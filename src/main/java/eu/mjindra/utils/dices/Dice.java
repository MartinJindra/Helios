package eu.mjindra.utils.dices;

import eu.mjindra.utils.dices.roll.Roll;

/**
 * An interface for dice.
 *
 * @author Martin Jindra
 * @version 30.05.2023
 */
public class Dice {

    private static byte amount;

    private static byte sides;

    private final short sum;


    public Dice(byte amount, byte sides) {
        Dice.amount = amount;
        Dice.sides = sides;
        this.sum = Roll.create(Dice.amount, Dice.sides).getTotal();
    }

    /**
     * Roll a die.
     *
     * @return the roll
     */
    public Roll roll() {
        return Roll.create(Dice.amount, Dice.sides);
    }

    /**
     * Roll a die.
     *
     * @return the roll
     */
    public static Roll roll(byte amount) {
        return Roll.create(amount, Dice.sides);
    }

    /**
     * Get the total sum of multiple rolls.
     *
     * @return total sum
     */
    public short sum() {
        return this.sum;
    }

    @Override
    public String toString() {
        return String.format("%dd%d", Dice.amount, Dice.sides);
    }
}