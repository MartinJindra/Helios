package eu.mjindra.utils.properties;

/**
 * Enum for DND abilities.
 *
 * @author Martin Jindra
 * @version 27.05.2023
 */
public enum Ability {

    STRENGTH("Strength"),
    DEXTERITY("Dexterity"),
    CONSTITUTION("Constitution"),
    INTELLIGENCE("Intelligence"),
    WISDOM("Wisdom"),
    CHARISMA("Charisma");

    private final String desc;

    Ability(String desc) {
        this.desc = desc;
    }

    public String desc() {
        return this.desc;
    }
}
