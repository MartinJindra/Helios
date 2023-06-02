package eu.mjindra.character;

import eu.mjindra.combat.Attack;
import eu.mjindra.combat.Damage;
import eu.mjindra.utils.properties.Ability;
import eu.mjindra.utils.properties.Money;
import eu.mjindra.utils.properties.Range;
import eu.mjindra.utils.units.Coin;
import eu.mjindra.utils.units.Length;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

/**
 * Parser for .dnd5e character file.
 *
 * @author Martin Jindra
 * @version 02.06.2023
 */
public class DND5eParser {

    private final Character character;
    private Path file;
    private Element rootElement;

    public DND5eParser(String file) throws FileNotFoundException {
        this.character = new Character();
        this.setFile(file);
    }

    public Character getCharacter() {
        return this.character;
    }

    public void setFile(String file) throws FileNotFoundException {
        if (!file.isBlank()) {
            this.file = Path.of(file);
            if (!Files.exists(this.file))
                throw new FileNotFoundException(String.format("%s does not exists.", file));
        }
    }

    /**
     * Parse the entire XML.
     */
    public void parseXML() {

        try {
            Document document = new SAXBuilder().build(this.file.toFile());
            this.rootElement = document.getRootElement();

            this.parseInformation();
            this.parseBuild();

        } catch (JDOMException | IOException e) {
            System.err.println(e.getMessage());
        }
    }

    /**
     * Parse the information and display-information elements.
     */
    private void parseInformation() {
        Element informationElement = this.rootElement.getChild("information");
        Element displayElement = this.rootElement.getChild("display-properties");

        this.character.setGroup(Objects.requireNonNullElse(informationElement.getChildText("group"), "").trim());
        this.character.setName(Objects.requireNonNullElse(displayElement.getChildText("name"), "").trim());
        this.character.setRace(Objects.requireNonNullElse(displayElement.getChildText("race"), "").trim());
        this.character.setClasses(Objects.requireNonNullElse(displayElement.getChildText("class"), "").trim());

        Background br = new Background(Objects.requireNonNullElse(displayElement.getChildText("background"), "").trim());
        this.character.setBackground(br);

        this.character.setLevel(Byte.parseByte(Objects.requireNonNullElse(displayElement.getChildText("level"), "0").trim()));

        Element portraitElement = displayElement.getChild("portrait");
        String portrait;
        if ((portrait = portraitElement.getChildText("base64")) != null)
            this.character.setCharacterPortrait(portrait);
        if ((portrait = portraitElement.getChildText("local")) != null && Files.exists(Path.of(portrait)))
            this.character.setCharacterPortrait(Path.of(portrait));
        String companion = Objects.requireNonNullElse(portraitElement.getChildText("companion").trim(), "");
        if (!companion.isBlank())
            this.character.setCompanionPortrait(Path.of(companion));
    }

    /**
     * Parse the build element.
     */
    private void parseBuild() {
        Element buildElement = this.rootElement.getChild("build");
        this.parseInput(buildElement);
        this.parseAppearance(buildElement);
    }

    /**
     * Parse the child element "input" of parent "build".
     *
     * @param buildElement
     */
    private void parseInput(Element buildElement) {
        Element inputElement = buildElement.getChild("input");

        this.character.setGender(Objects.requireNonNullElse(inputElement.getChildText("gender"), "").trim());
        this.character.setPlayerName(Objects.requireNonNullElse(inputElement.getChildText("player-name"), "").trim());
        this.character.setExperience(Integer.parseInt(Objects.requireNonNullElse(inputElement.getChildText("experience"), "0")));

        // Attacks
        Element attackElement = inputElement.getChild("attacks");
        List<Element> attacks = attackElement.getChildren("attack");
        Attack attack;
        String rangeString, damageString, abilityString;
        String[] stringArray;
        for (Element att : attacks) {
            attack = new Attack();
            // UUID
            attack.setUuid(Objects.requireNonNullElse(att.getAttributeValue("identifier"), ""));
            // Name
            attack.setName(Objects.requireNonNullElse(att.getAttributeValue("name"), ""));

            // Range
            rangeString = Objects.requireNonNullElse(att.getAttributeValue("range"), "");
            // If range has long and short ranges
            if (rangeString.contains("/")) {
                stringArray = rangeString.split("/");
                attack.setShortRange(new Range(Float.parseFloat(stringArray[0]), Length.FEET));
                attack.setLongRange(new Range(Float.parseFloat(stringArray[1]), Length.FEET));
            } else {
                // If only one range exists
                if (rangeString.endsWith("ft")) {
                    stringArray = rangeString.split(" ");
                    attack.setShortRange(new Range(Float.parseFloat(stringArray[0]), Length.FEET));
                }
            }

            // Attack vs AC
            attack.setAttack(Byte.parseByte(Objects.requireNonNullElse(att.getAttributeValue("attack").split(" ")[0], "")));

            // Damage
            damageString = Objects.requireNonNullElse(att.getAttributeValue("damage"), "");
            attack.setDamage(Damage.parse(damageString));

            // Is the weapon displayed
            attack.setDisplayed(Boolean.parseBoolean(att.getAttributeValue("displayed")));

            // Ability
            abilityString = Objects.requireNonNullElse(att.getAttributeValue("ability").toUpperCase(), "");
            attack.setAbility(Ability.valueOf(abilityString));

            this.character.addAttack(attack);


        }

        // Backstory
        Background br = this.character.getBackground();
        br.setStory(Objects.requireNonNullElse(inputElement.getChildText("background"), ""));
        br.setTrinket(Objects.requireNonNullElse(inputElement.getChildText("background-trinket"), ""));
        br.setTraits(Objects.requireNonNullElse(inputElement.getChildText("background-traits"), ""));
        br.setIdeals(Objects.requireNonNullElse(inputElement.getChildText("background-ideals"), ""));
        br.setBonds(Objects.requireNonNullElse(inputElement.getChildText("background-bonds"), ""));
        br.setFlaws(Objects.requireNonNullElse(inputElement.getChildText("background-flaws"), ""));

        Element brackgroundElement = inputElement.getChild("background");
        String backgroundName = Objects.requireNonNullElse(brackgroundElement.getChild("feature").getAttributeValue("name"), "");
        String backgroundDesc = Objects.requireNonNullElse(brackgroundElement.getChild("feature").getChildText("description"), "");
        Background.Feature backgroundFeature = new Background.Feature(backgroundName);
        backgroundFeature.setDescription(backgroundDesc);
        br.setFeature(backgroundFeature);

        // Organization
        Element originationElement = inputElement.getChild("organization");
        Organization org = new Organization();
        org.setName(Objects.requireNonNullElse(originationElement.getChildText("name"), ""));
        org.setSymbol(Objects.requireNonNullElse(originationElement.getChildText("symbol"), ""));
        org.setAllies(Objects.requireNonNullElse(originationElement.getChildText("allies"), ""));
        this.character.setOrganization(org);

        // Currency
        Element currencyElement = inputElement.getChild("currency");
        this.character.setEquipment(Objects.requireNonNullElse(currencyElement.getChildText("equipment"), ""));
        this.character.setTreasure(Objects.requireNonNullElse(currencyElement.getChildText("treasure"), ""));
        HashMap<Coin, Money> currencies = new HashMap<>();
        for (Coin c : Coin.values()) {
            Money money = new Money(Objects.requireNonNullElse(Float.parseFloat(currencyElement.getChildText(c.name().toLowerCase())), 0F), c);
            currencies.put(c, money);
        }
        this.character.setCurrencies(currencies);

        // Notes and Quest
        Element notesElement = inputElement.getChild("notes");
        for (Element el : notesElement.getChildren("note"))
            this.character.addNotes(el.getAttributeValue("column"), el.getText());
        this.character.setQuests(Objects.requireNonNullElse(notesElement.getChildText("quest"), ""));
    }

    private void parseAppearance(Element buildElement) {
        // Appearance
        Element appearanceElement = buildElement.getChild("appearance");
        Appearance appearance = new Appearance();
        appearance.setAge(Short.parseShort(Objects.requireNonNullElse(appearanceElement.getChildText("age"), "0")));
        appearance.setHeight(Objects.requireNonNullElse(appearanceElement.getChildText("height"), "0"));
        appearance.setWeight(Objects.requireNonNullElse(appearanceElement.getChildText("weight"), "0"));
        appearance.setEyes(Objects.requireNonNullElse(appearanceElement.getChildText("eyes"), "0"));
        appearance.setSkin(Objects.requireNonNullElse(appearanceElement.getChildText("skin"), "0"));
        appearance.setHair(Objects.requireNonNullElse(appearanceElement.getChildText("hair"), "0"));
        this.character.setAppearance(appearance);
    }
}