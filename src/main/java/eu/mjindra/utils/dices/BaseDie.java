package eu.mjindra.utils.dices;

import eu.mjindra.utils.dices.roll.Roll;

/**
 * An interface for Dices.
 * @author Martin Jindra
 * @version 30.05.2023
 */
public interface BaseDie {

    /**
     * Roll a die.
     * @param amount how often should the die be rolled.
     * @return the result
     */
    static Roll roll(byte amount, byte dice) {
        return Roll.create(amount, dice);
    }
}
