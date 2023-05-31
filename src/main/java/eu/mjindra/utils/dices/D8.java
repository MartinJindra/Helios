package eu.mjindra.utils.dices;

/**
 * A D8 die.
 *
 * @author Martin Jindra
 * @version 31.05.2023
 */
public class D8 extends Dice {

    public D8(byte amount) {
        this(amount, (byte) 8);
    }

    public D8(byte amount, byte modifier) {
        super(amount, (byte) 8, modifier);
    }

}