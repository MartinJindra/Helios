package eu.mjindra.attacks;

import eu.mjindra.utils.dices.D0;
import eu.mjindra.utils.dices.Dice;

/**
 * Class representing damage.
 *
 * @author Martin Jindra
 * @version 30.05.2023
 */
public class Damage {

    public Dice dice;

    private DamageType type;

    public Damage(Dice dice, DamageType type) {
        this.dice = dice;
        this.type = type;
    }

    public Damage(byte modifier, DamageType type) {
        this.dice = new D0((byte) 1, modifier);
        this.type = type;
    }

    public Dice getDice() {
        return dice;
    }

    public void setDice(Dice dice) {
        this.dice = dice;
    }

    public DamageType getType() {
        return type;
    }

    public void setType(DamageType type) {
        this.type = type;
    }

    /**
     * Parses an expression for a Damage object.
     * A die (and optional damage type) is required.
     * @param expression expression
     * @return processed Damage object
     */
    public static Damage parse(String expression) {
        String[] stringSplit = expression.split(" ");

        if (stringSplit.length == 1) {
            stringSplit[0] = stringSplit[0].replace("+", "");
            return new Damage(Byte.parseByte(stringSplit[0]), DamageType.NONE);
        }
        DamageType type = DamageType.valueOf(stringSplit[1].toUpperCase());
        Dice damage = Dice.parse(stringSplit[0]);

        return new Damage(damage, type);
    }

    public String toString() {
        return String.format("%s %s", this.dice, this.type.desc());
    }
}