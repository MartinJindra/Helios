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

    private final short sum;


    public Dice(byte amount, byte sides) {
        this.amount = amount;
        this.sides = sides;
        this.sum = Roll.create(this.amount, this.sides).getTotal();
    }

    /**
     * Roll a die.
     *
     * @return the roll
     */
    public Roll roll() {
        return Roll.create(this.amount, this.sides);
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
        return String.format("%dd%d", this.amount, this.sides);
    }
}