package eu.mjindra.utils.dices;

/**
 * A D0 die.
 *
 * @author Martin Jindra
 * @version 31.05.2023
 */
public class D0 extends Dice {

    public D0(byte amount) {
        this(amount, (byte) 0);
    }

    public D0(byte amount, byte modifier) {
        super(amount, (byte) 0, modifier);
    }

}