package eu.mjindra.utils.dices;

/**
 * A D12 die.
 *
 * @author Martin Jindra
 * @version 31.05.2023
 */
public class D12 extends Dice {

    public D12(byte amount) {
        this(amount, (byte) 0);
    }

    public D12(byte amount, byte modifier) {
        super(amount, (byte) 12, modifier);
    }

}