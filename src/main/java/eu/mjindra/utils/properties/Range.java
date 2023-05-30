package eu.mjindra.utils.properties;

import eu.mjindra.units.Base;
import eu.mjindra.units.Length;
import org.apache.commons.math3.util.Precision;

/**
 * A class representing range in DND.
 *
 * @author Martin Jindra
 * @version 27.05.2023
 */
public class Range extends Unit {

    public Range(float amount, Length unit) {
        super(amount, unit);
    }

    /**
     * Convert the value of one unit to another unit.
     *
     * @param to different unit
     * @return converted value
     */
    @Override
    public Unit convert(Base to) {
        Length l = (Length) to;
        float f = super.getAmount() / ((Length) super.getUnit()).val;
        return new Range(Precision.round(f * l.val, 4), l);
    }
}
