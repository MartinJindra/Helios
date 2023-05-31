package eu.mjindra.utils.dices;

/**
 * A D20 die.
 *
 * @author Martin Jindra
 * @version 31.05.2023
 */
public class D20 extends Dice {

    public D20(byte amount) {
        this(amount, (byte) 20);
    }

    public D20(byte amount, byte modifier) {
        super(amount, (byte) 20, modifier);
    }

}