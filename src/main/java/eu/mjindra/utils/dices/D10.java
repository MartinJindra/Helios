package eu.mjindra.utils.dices;

/**
 * A D10 die.
 *
 * @author Martin Jindra
 * @version 31.05.2023
 */
public class D10 extends Dice {

    public D10(byte amount) {
        this(amount, (byte) 10);
    }

    public D10(byte amount, byte modifier) {
        super(amount, (byte) 10, modifier);
    }

}