package eu.mjindra.utils.dices;

/**
 * A D20 die.
 *
 * @author Martin Jindra
 * @version 30.05.2023
 */
public class D20 extends Dice {

    public D20(byte amount) {
        super(amount, (byte) 20);
    }

}