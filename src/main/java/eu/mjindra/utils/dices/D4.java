package eu.mjindra.utils.dices;

/**
 * A D4 die.
 *
 * @author Martin Jindra
 * @version 31.05.2023
 */
public class D4 extends Dice {

    public D4(byte amount) {
        this(amount, (byte) 0);
    }

    public D4(byte amount, byte modifier) {
        super(amount, (byte) 4, modifier);
    }

}