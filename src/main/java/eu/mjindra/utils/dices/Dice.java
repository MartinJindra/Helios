package eu.mjindra.utils.dices;

import eu.mjindra.utils.dices.roll.Roll;

/**
 * A parent for dice.
 * @author Martin Jindra
 * @version 30.05.2023
 */
public class Dice implements BaseDie {

    private static byte sides;

    public Dice(byte sides) {
        Dice.sides = sides;
    }

    public static Roll roll(byte amount) {
        return BaseDie.roll(amount, Dice.sides);
    }
}
