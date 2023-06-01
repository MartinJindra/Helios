package eu.mjindra.utils.properties;

import eu.mjindra.utils.units.Base;
import eu.mjindra.utils.units.Mass;
import org.apache.commons.math3.util.Precision;

/**
 * A class representing weight in DND.
 *
 * @author Martin Jindra
 * @version 27.05.2023
 */
public class Weight extends Unit {
    public Weight(float amount, Mass unit) {
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
        Mass m = (Mass) to;
        float f = super.getAmount() * ((Mass) super.getUnit()).val;
        return new Weight(Precision.round(f / ((Mass) to).val, 4), m);
    }
}
