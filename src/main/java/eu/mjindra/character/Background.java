package eu.mjindra.character;

/**
 * The backstory of a DnD character.
 *
 * @author Martin Jindra
 * @version 01.06.2023
 */
public class Background {

    private String roll, story, trinket, traits, ideals, bonds, flaws;

    private Feature feature;

    public Background(String roll) {
        this.roll = roll;
    }

    public String getRoll() {
        return roll;
    }

    public void setRoll(String roll) {
        this.roll = roll;
    }

    public String getStory() {
        return story;
    }

    public void setStory(String story) {
        this.story = story;
    }

    public String getTrinket() {
        return trinket;
    }

    public void setTrinket(String trinket) {
        this.trinket = trinket;
    }

    public String getTraits() {
        return traits;
    }

    public void setTraits(String traits) {
        this.traits = traits;
    }

    public String getIdeals() {
        return ideals;
    }

    public void setIdeals(String ideals) {
        this.ideals = ideals;
    }

    public String getBonds() {
        return bonds;
    }

    public void setBonds(String bonds) {
        this.bonds = bonds;
    }

    public String getFlaws() {
        return flaws;
    }

    public void setFlaws(String flaws) {
        this.flaws = flaws;
    }

    public Feature getFeature() {
        return feature;
    }

    public void setFeature(Feature feature) {
        this.feature = feature;
    }

    public String toString() {
        StringBuilder str = new StringBuilder(String.format("## %s Background\n", this.roll));
        str.append(String.format("Trinket: %s\n", this.trinket));
        str.append(String.format("Traits: %s\n", this.traits));
        str.append(String.format("Ideals: %s\n", this.ideals));
        str.append(String.format("Bonds: %s\n", this.bonds));
        str.append(String.format("Flaws: %s\n", this.flaws));
        str.append(String.format("\n%s\n", this.feature));
        return str.toString();
    }

    /**
     * A background feature of a character.
     *
     * @author Martin Jindra
     * @version 01.06.2023
     */
    static class Feature {

        private String name, description;

        public Feature(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String toString() {
            StringBuilder str = new StringBuilder(String.format("### %s\n", this.name));
            str.append(this.description);
            return str.toString();
        }
    }
}
