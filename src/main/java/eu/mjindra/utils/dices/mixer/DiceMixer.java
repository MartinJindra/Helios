package eu.mjindra.utils.dices.mixer;

import eu.mjindra.utils.dices.roll.Roll;

import java.util.ArrayList;
import java.util.List;

/**
 * A mixer used for adding up multiple dice rolls.
 *
 * @author Martin Jindra
 * @version 30.05.2023
 */
public class DiceMixer {

    private final List<Roll> rolls;

    public DiceMixer() {
        this.rolls = new ArrayList<>();
    }

    public void add(Roll roll) {
        this.rolls.add(roll);
    }

    /**
     * Get the total sum of multiple rolls.
     * @return total sum
     */
    public short sum() {
        short sum = 0;
        for (Roll roll : this.rolls) {
            sum += roll.getTotal();
        }
        return sum;
    }
}