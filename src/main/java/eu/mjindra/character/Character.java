package eu.mjindra.character;

import eu.mjindra.combat.Attack;
import eu.mjindra.utils.properties.Money;
import eu.mjindra.utils.units.Coin;
import org.jetbrains.annotations.Nullable;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

/**
 * Class to represent a DND character.
 *
 * @author Martin Jindra
 * @version 02.06.2023
 */
public class Character {
    String[] classesArray;
    private byte[] characterPortrait, companionPortrait;
    private byte level;
    private int experience;
    private String group, name, race, classesString, gender, playerName, equipment, treasure, quests;
    private boolean isFavorite;
    private final List<Attack> attacks;
    private Background background;
    private Organization organization;
    private Map<Coin, Money> currencies;
    private Map<String, String> notes;

    /**
     * Create an empty character.
     */
    public Character() {
        this.classesArray = new String[0];
        this.characterPortrait = new byte[0];
        this.companionPortrait = new byte[0];
        this.level = 0;
        this.experience = 0;
        this.group = "";
        this.name = "";
        this.race = "";
        this.classesString = "";
        this.background = new Background("");
        this.gender = "";
        this.playerName = "";
        this.isFavorite = false;
        this.attacks = new ArrayList<>();
        this.organization = new Organization();
        this.currencies = new HashMap<>();
        this.equipment = "";
        this.treasure = "";
        this.notes = new HashMap<>();
        this.quests = "";
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPlayerName() {
        return playerName;
    }

    public void setPlayerName(String playerName) {
        this.playerName = playerName;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }

    public byte @Nullable [] getCharacterPortrait() {
        return this.characterPortrait;
    }

    public void setCharacterPortrait(String portraitBase64) {
        this.characterPortrait = Base64.getDecoder().decode(portraitBase64);
    }

    public void setCharacterPortrait(Path portraitPath) {
        if (Files.exists(portraitPath)) {
            try {
                this.characterPortrait = Files.readAllBytes(portraitPath);
            } catch (IOException e) {
                System.err.format("Character portrait \'%s\' does not exists.\n", portraitPath);
            }
        }
    }

    public byte @Nullable [] getCompanionPortrait() {
        return this.companionPortrait;
    }

    public void setCompanionPortrait(String portraitBase64) {
        this.companionPortrait = Base64.getDecoder().decode(portraitBase64);
    }

    public void setCompanionPortrait(Path portraitPath) {
        if (Files.exists(portraitPath)) {
            try {
                this.companionPortrait = Files.readAllBytes(portraitPath);
            } catch (IOException e) {
                System.err.format("Companion portrait \'%s\' does not exists.", portraitPath);
            }
        }
    }

    public boolean isFavorite() {
        return isFavorite;
    }

    public void setFavorite(boolean favorite) {
        isFavorite = favorite;
    }

    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRace() {
        return race;
    }

    public void setRace(String race) {
        this.race = race;
    }

    public String[] getClassName() {
        return this.classesArray;
    }

    public void setClasses(String classes) {
        this.classesString = classes;
        this.classesArray = classes.split("/");
        for (int i = 0; i < this.classesArray.length; i++) {
            this.classesArray[i] = this.classesArray[i].trim();
        }
    }

    public Background getBackground() {
        return background;
    }

    public void setBackground(Background background) {
        this.background = background;
    }

    public byte getLevel() {
        return level;
    }

    public void setLevel(byte level) {
        this.level = level;
    }

    public void addAttack(Attack attack) {
        this.attacks.add(attack);
    }

    public List<Attack> getAttacks() {
        return this.attacks;
    }

    public void removeAttack(byte i) {
        this.attacks.remove(i);
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    public Map<Coin, Money> getCurrencies() {
        return currencies;
    }

    public void setCurrencies(HashMap<Coin, Money> currencies) {
        this.currencies = currencies;
    }

    public String getEquipment() {
        return equipment;
    }

    public void setEquipment(String equipment) {
        this.equipment = equipment;
    }

    public String getTreasure() {
        return treasure;
    }

    public void setTreasure(String treasure) {
        this.treasure = treasure;
    }

    public void addNotes(String side, String content) {
        this.notes.put(side, content);
    }

    public Map getNotes() {
        return this.notes;
    }

    public String getQuests() {
        return quests;
    }

    public void setQuests(String quests) {
        this.quests = quests;
    }

    /**
     * Sums up all information into a printable format.
     *
     * @return all information
     */
    public String summarizeInformation() {
        StringBuilder str = new StringBuilder();

        // TODO implement printable format for a character
        String header = String.format("# %s (%s):", this.name, this.playerName);
        str.append(String.format("%s\n", header));
        str.append(String.format("%s\n\n", "-".repeat(header.length())));
        str.append(String.format("Class: %s\n", this.classesString));
        str.append(String.format("Race: %s\n", this.race));
        str.append(String.format("Gender: %s\n", this.gender));
        str.append(String.format("Level: %d\n", this.level));
        str.append(String.format("Experience: %d\n", this.experience));
        str.append("\n## Attacks:\n");
        str.append(String.format("%s\n", "-".repeat("## Attacks:".length())));
        for (Attack attack : this.attacks)
            str.append(String.format("\n%s", attack));
        str.append(String.format("\n%s\n", this.background));
        str.append(String.format("%s\n", this.organization));
        str.append("\n## Currencies:\n");
        for (Money m : this.currencies.values())
            str.append(String.format("%s\n", m));
        str.append("\n## Equipment:\n");
        str.append(String.format("%s\n", this.equipment));
        str.append("\n## Treasure:\n");
        str.append(String.format("%s", this.treasure));
        str.append("\n## Notes:\n");
        for (String content : this.notes.values())
            str.append(String.format("%s\n", content));
        str.append("\n## Quests:\n");
        str.append(this.quests);
        return str.toString();
    }

    @Override
    public String toString() {
        return this.summarizeInformation();
    }


}
