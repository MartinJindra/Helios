package eu.mjindra.utils.dices;

/**
 * A D100 die.
 *
 * @author Martin Jindra
 * @version 31.05.2023
 */
public class D100 extends Dice {

    public D100(byte amount) {
        this(amount, (byte) 0);
    }

    public D100(byte amount, byte modifier) {
        super(amount, (byte) 100, modifier);
    }

}