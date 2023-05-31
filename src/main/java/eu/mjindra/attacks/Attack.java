package eu.mjindra.attacks;

import eu.mjindra.utils.properties.Ability;
import eu.mjindra.utils.properties.Range;

/**
 * A class representing an attack in DND.
 *
 * @author Martin Jindra
 * @version 27.05.2023
 */
public class Attack {

    private String uuid;

    private String name;

    private Range shortRange, longRange;

    private byte attack;

    private Damage damage;

    private boolean displayed;

    private Ability ability;

    public Attack() {
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Range getShortRange() {
        return shortRange;
    }

    public void setShortRange(Range shortRange) {
        this.shortRange = shortRange;
    }

    public Range getLongRange() {
        return longRange;
    }

    public void setLongRange(Range longRange) {
        this.longRange = longRange;
    }

    public byte getAttack() {
        return attack;
    }

    public void setAttack(byte attack) {
        this.attack = attack;
    }

    public Damage getDamage() {
        return damage;
    }

    public void setDamage(Damage damage) {
        this.damage = damage;
    }

    public boolean isDisplayed() {
        return displayed;
    }

    public void setDisplayed(boolean displayed) {
        this.displayed = displayed;
    }

    public Ability getAbility() {
        return ability;
    }

    public void setAbility(Ability ability) {
        this.ability = ability;
    }

    public String toString() {
        StringBuilder str = new StringBuilder();

        str.append(String.format("### %s:\n", this.name));
        str.append(String.format("Short range: %s\n", this.shortRange));
        if (this.longRange != null)
            str.append(String.format("Long range: %s\n", this.longRange));
        str.append(String.format("Attack: %d + AC\n", this.attack));
        str.append(String.format("Damage: %s\n", this.damage));
        str.append(String.format("Ability: %s\n", this.ability.desc()));

        return str.toString();
    }
}
