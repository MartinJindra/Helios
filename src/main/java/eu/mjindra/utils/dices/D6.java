package eu.mjindra.utils.dices;

/**
 * A D6 die.
 *
 * @author Martin Jindra
 * @version 31.05.2023
 */
public class D6 extends Dice {

    public D6(byte amount) {
        this(amount, (byte) 0);
    }

    public D6(byte amount, byte modifier) {
        super(amount, (byte) 6, modifier);
    }

}