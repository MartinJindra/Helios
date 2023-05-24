package eu.mjindra.characterfile;

/**
 * Class to represent a DND character.
 * @author Martin Jindra
 * @version 24.03.2023
 */
public class Character {

    private String group, name, race, className, background;

    private byte level;

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

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
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

        info.append(String.format("Name:\t\t%s\n", this.name));
        info.append(String.format("Race:\t\t%s\n", this.race));
        info.append(String.format("Class:\t\t%s\n", this.className));
        info.append(String.format("Level:\t\t%d\n", this.level));
        info.append(String.format("Background:\t%s\n", this.background));
        return info.toString();
    }

    @Override
    public String toString() {
        return this.summerizeInformation();
    }

}
