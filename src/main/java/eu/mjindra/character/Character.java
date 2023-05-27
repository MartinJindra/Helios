package eu.mjindra.character;

import org.jetbrains.annotations.Nullable;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Base64;

/**
 * Class to represent a DND character.
 * @author Martin Jindra
 * @version 24.03.2023
 */
public class Character {
    private byte[] characterPortrait, companionPortrait;

    private byte level;

    private int experience;

    private String group, name, race, classesString, background, gender, playerName;

    String[] classesArray;


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

    public void setCharacterPortrait(String portraitBase64) {
        this.characterPortrait = Base64.getDecoder().decode(portraitBase64);
    }

    public void setCharacterPortrait(Path portraitPath) {
        if (Files.exists(portraitPath)) {
            try {
                this.characterPortrait = Files.readAllBytes(portraitPath);
            } catch (IOException e) {
                System.err.format("Portrait %s does not exists.\n", portraitPath);
            }
        }
    }

    public byte @Nullable [] getCharacterPortrait() {
        return this.characterPortrait;
    }

    public void setCompanionPortrait(String portraitBase64) {
        this.companionPortrait = Base64.getDecoder().decode(portraitBase64);
    }

    public void setCompanionPortrait(Path portraitPath) {
        if (Files.exists(portraitPath)) {
            try {
                this.companionPortrait = Files.readAllBytes(portraitPath);
            } catch (IOException e) {
                System.err.format("Portrait %s does not exists.", portraitPath);
            }
        }
    }

    public byte @Nullable [] getCompanionPortrait() {
        return this.companionPortrait;
    }

    public boolean isFavorite() {
        return isFavorite;
    }

    public void setFavorite(boolean favorite) {
        isFavorite = favorite;
    }

    private boolean isFavorite;

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

    public String getBackground() {
        return background;
    }

    public void setBackground(String background) {
        this.background = background;
    }

    public byte getLevel() {
        return level;
    }

    public void setLevel(byte level) {
        this.level = level;
    }

    /**
     * Sums up all information into a printable format.
     * @return all information
     */
    public String summerizeInformation() {
        StringBuilder info = new StringBuilder();

        // TODO implement printable format for a character
        String header = String.format("%s (%s):", this.name, this.playerName);
        info.append(String.format("%s\n", header));
        info.append(String.format("%s\n", "-".repeat(header.length())));
        info.append(String.format("Class:\t\t%s\n", this.classesString));
        info.append(String.format("Race:\t\t%s\n", this.race));
        info.append(String.format("Gender:\t\t%s\n", this.gender));
        info.append(String.format("Level:\t\t%d\n", this.level));
        info.append(String.format("Experience:\t%d\n", this.experience));
        info.append(String.format("Background:\t%s\n", this.background));
        return info.toString();
    }

    @Override
    public String toString() {
        return this.summerizeInformation();
    }

}
