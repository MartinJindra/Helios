package eu.mjindra.utils.dices.mixer;

import eu.mjindra.utils.dices.Dice;

import java.util.ArrayList;
import java.util.List;

/**
 * A mixer used for adding up multiple and different dice rolls.
 *
 * @author Martin Jindra
 * @version 30.05.2023
 */
public class DiceMixer {

    private final List<Dice> dice;

    public DiceMixer() {
        this.dice = new ArrayList<>();
    }

    public void add(Dice die) {
        this.dice.add(die);
    }

    public short sum() {
        short sum = 0;
        for ( Dice d : this.dice ) {
            sum += d.sum();
        }
        return sum;
    }

    @Override
    public String toString() {
        StringBuilder str = new StringBuilder();
        for (Dice d : this.dice) {
            str.append(d);
            str.append('+');
        }
        str.deleteCharAt(str.lastIndexOf("+"));
        str.append('=');
        str.append(this.sum());
        return str.toString();
    }
}