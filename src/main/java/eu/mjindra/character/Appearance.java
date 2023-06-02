package eu.mjindra.character;

/**
 * The appearance of a DnD character.
 *
 * @author Martin Jindra
 * @version 02.06.2023
 */
public class Appearance {

    private short age;

    private String height, weight, eyes, skin, hair;

    public short getAge() {
        return age;
    }

    public void setAge(short age) {
        this.age = age;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getEyes() {
        return eyes;
    }

    public void setEyes(String eyes) {
        this.eyes = eyes;
    }

    public String getSkin() {
        return skin;
    }

    public void setSkin(String skin) {
        this.skin = skin;
    }

    public String getHair() {
        return hair;
    }

    public void setHair(String hair) {
        this.hair = hair;
    }

    public String toString() {
        StringBuilder str = new StringBuilder();
        str.append(String.format("Age: %s\n", this.age));
        str.append(String.format("Height: %s\n", this.height));
        str.append(String.format("Weight: %s\n", this.weight));
        str.append(String.format("Eyes: %s\n", this.eyes));
        str.append(String.format("Skin: %s\n", this.skin));
        str.append(String.format("Hair: %s\n", this.hair));
        return str.toString();
    }
}
