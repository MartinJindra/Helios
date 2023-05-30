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

    public Dice(byte amount, byte sides) {
        this.amount = amount;
        this.sides = sides;
        this.roll = Roll.create(this.amount, this.sides);
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
        return this.roll.getTotal();
    }

    @Override
    public String toString() {
        StringBuilder str = new StringBuilder();
        for ( byte res : this.roll.getOrder() ) {
            str.append(String.format("%d(d%d)+", res, this.sides));
        }
        str.deleteCharAt(str.lastIndexOf("+"));
        return str.toString();
    }
}