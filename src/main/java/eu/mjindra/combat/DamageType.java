package eu.mjindra.combat;

/**
 * Different damage types an attack or spell can do.
 *
 * @author Martin Jindra
 * @version 30.05.2023
 */
public enum DamageType {
    ACID("Acid"),
    BLUDGEONING("Bludgeoning"),
    COLD("Cold"),
    FIRE("Fire"),
    FORCE("Force"),
    LIGHTNING("Lightning"),
    NECROTIC("Necrotic"),
    PIERCING("Piercing"),
    POISON("Poison"),
    PSYCHIC("Psychic"),
    RADIANT("Radiant"),
    SLASHING("Slashing"),
    THUNDER("Thunder"),
    NONE("");

    private final String desc;

    DamageType(String desc) {
        this.desc = desc;
    }

    public String desc() {
        return this.desc;
    }
}
