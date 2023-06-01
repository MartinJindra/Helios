package eu.mjindra.utils.dices;

import eu.mjindra.utils.dices.roll.Roll;

/**
 * An interface for dice.
 *
 * @author Martin Jindra
 * @version 30.05.2023
 */
public class Dice {

    private final byte amount;

    private final byte sides;

    private final Roll roll;

    private final byte modifier;

    public Dice(byte amount, byte sides) {
        this(amount, sides, (byte) 0);
    }

    public Dice(byte amount, byte sides, byte modifier) {
        this.amount = amount;
        this.sides = sides;
        this.modifier = modifier;
        this.roll = Roll.create(this.amount, this.sides, this.modifier);
    }

    public byte getAmount() {
        return amount;
    }

    public byte getSides() {
        return sides;
    }

    public byte getModifier() {
        return modifier;
    }

    /**
     * Roll a die.
     *
     * @return the roll
     */
    public Roll roll() {
        return Roll.create(this.amount, this.sides, this.modifier);
    }

    /**
     * Get the total sum of multiple rolls.
     *
     * @return total sum
     */
    public short sum() {
        return this.roll.getTotal();
    }

    @Override
    public String toString() {

        // if empty die only modifier
        if (this.sides == 0)
            return String.format("%d", this.modifier);

        String operator = " ";
        if (this.modifier >= 0)
            operator = "+";

        StringBuilder str = new StringBuilder();
        if (this.roll.getOrder().length == 1) {
            if (this.modifier != 0)
                str.append(String.format("(%dd%d%s%d)", this.amount, this.sides, operator, modifier));
            else str.append(String.format("%dd%d", this.amount, this.sides));
        } else {
            for (byte res : this.roll.getOrder()) {
                if (this.modifier != 0)
                    str.append(String.format("(%dd%d%c%d)+", this.amount, this.sides, operator, modifier));
                else str.append(String.format("%dd%d+", this.amount, this.sides));
            }
            str.deleteCharAt(str.lastIndexOf("+"));
        }
        return str.toString();
    }

    /**
     * Parse a string into a dice.
     * Examples:
     *     `3d3 + 2`
     *     `1d4`
     *     `1    d    2`
     * @param dice dice as a string.
     * @return processed dice
     */
    public static Dice parse(String dice) {
        dice = dice.replace(" ", "");
        String[] splits;
        byte amount = 0, sides = 0, modifier = 0;
        // if modifier is present
        if (dice.contains("+")) {
            splits = dice.split("\\+");
            dice = splits[0];
            modifier = Byte.parseByte(splits[1]);
        } else if (dice.contains("-")) {
            splits = dice.split("-");
            dice = splits[0];
            modifier = Byte.parseByte(splits[1]);
            modifier *= -1;
        } 
        // if only the dice is present
        if (dice.contains("d")) {
            splits = dice.split("d");
            amount = Byte.parseByte(splits[0]);
            sides = Byte.parseByte(splits[1]);
        }
        return new Dice(amount, sides, modifier);
    }

    // TODO add an optional modifier for dices
}