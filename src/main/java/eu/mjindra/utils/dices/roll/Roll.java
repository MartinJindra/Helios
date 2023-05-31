package eu.mjindra.utils.dices.roll;

import eu.mjindra.utils.dices.Dice;

/**
 * Class representing a die roll.
 *
 * @author Martin Jindra
 * @version 31.05.2023
 */
public class Roll {

    private final byte[] order;

    private final short total;

    /**
     * Generate a roll.
     * Runs loops over amount and generates
     * a random number from 0 (exclusive) and dice (inclusive).
     * Plus modifier.
     * @param amount how often a die is rolled
     * @param dice which die it is
     * @param modifier a positive or negative modifier
     */
    private Roll(byte amount, byte dice, byte modifier) {
        this.order = new byte[amount];
        short total = modifier;
        for (short i = 0; i < amount; i++) {
            this.order[i] = (byte) (Math.random() * dice + 1);
            total += this.order[i];
        }
        this.total = total;
    }

    public static Roll create(byte amount, byte dice, byte modifier) {
        return new Roll(amount, dice, modifier);
    }

    public static Roll create(Dice die) { return new Roll(die.getAmount(), die.getSides(), die.getModifier()); }

    /**
     * Get the total sum of the roll.
     *
     * @return total sum
     */
    public short getTotal() {
        return this.total;
    }

    /**
     * Get the order of the dice rolls.
     *
     * @return order
     */
    public byte[] getOrder() {
        return this.order;
    }

    @Override
    public String toString() {
        return String.format("%d", this.total);
    }
}