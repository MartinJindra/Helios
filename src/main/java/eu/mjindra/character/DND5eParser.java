package eu.mjindra.character;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Objects;

/**
 * Parser for .dnd5e character file.
 * @author Martin Jindra
 * @version 23.05.2023
 */
public class DND5eParser {

    private Path file;
    private Element rootElement;

    private final Character character;

    public DND5eParser(String file) throws FileNotFoundException {
        this();
        this.setFile(file);
    }

    public DND5eParser() {
        this.character = new Character();
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
            throw new RuntimeException(e);
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
        this.character.setBackground(Objects.requireNonNullElse(displayElement.getChildText("background"), "").trim());
        this.character.setLevel(Byte.parseByte(Objects.requireNonNullElse(displayElement.getChildText( "level"), "0").trim()));

        Element portraitElement = displayElement.getChild("portrait");
        String portrait;
        if ((portrait = portraitElement.getChildText("base64")) != null)
            this.character.setCharacterPortrait(portrait);
        if ((portrait = portraitElement.getChildText("local")) != null)
            this.character.setCharacterPortrait(Path.of(portrait));
        this.character.setCompanionPortrait(Path.of(Objects.requireNonNullElse(portraitElement.getChildText("companion"), "")));
    }

    /**
     * Parse the build element.
     */
    private void parseBuild() {
        Element buildElement = this.rootElement.getChild("build");
        Element inputElement = buildElement.getChild("input");

        this.character.setGender(Objects.requireNonNullElse(inputElement.getChildText("gender"), "").trim());
        this.character.setPlayerName(Objects.requireNonNullElse(inputElement.getChildText("player-name"), "").trim());
        this.character.setExperience(Integer.parseInt(Objects.requireNonNullElse(inputElement.getChildText( "experience"), "0")));
    }
}
