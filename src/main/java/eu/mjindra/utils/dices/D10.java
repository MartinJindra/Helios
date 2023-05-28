package eu.mjindra.utils.dices;

/**
 * A D10 die.
 * @author Martin Jindra
 * @version 28.05.2023
 */
public class D10 implements Dice {
    public static Roll roll(byte amount) {
        return Dice.roll(amount, (byte) 10);
    }
}