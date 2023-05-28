package eu.mjindra.utils.dices;

/**
 * A parent for Dices.
 */
public interface Dice {

    /**
     * Roll a die.
     * @param amount how often should the die be rolled.
     * @return the result
     */
    static Roll roll(byte amount, byte dice) {
        return Roll.create(amount, dice);
    }
}
