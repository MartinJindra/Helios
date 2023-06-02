package eu.mjindra.utils.properties;

import eu.mjindra.utils.units.Base;
import eu.mjindra.utils.units.Coin;
import org.apache.commons.math3.util.Precision;

/**
 * Monnnneeeeeyyyy.
 *
 * @author Martin Jindra
 * @version 02.06.2023
 */
public class Money extends Unit {

    public Money(float amount, Coin coin) {
        super(amount, coin);
    }

    /**
     * Convert the value of one unit to another unit.
     *
     * @param to different unit
     * @return converted value
     */
    @Override
    public Money convert(Base to) {
        Coin c = (Coin) to;
        float f = super.getAmount() / ((Coin) super.getUnit()).val;
        return new Money(Precision.round(f * c.val, 4), c);
    }
}