package eu.mjindra.utils;

import eu.mjindra.units.Length;
import org.apache.commons.math3.util.Precision;

public class Range {

    private float amount;

    private Length unit;

    public Range(float amount, Length unit) {
        set(amount, unit);
    }

    public void set(float amount, Length unit) {
        this.amount = amount;
        this.unit = unit;
    }

    public float getAmount() {
        return this.amount;
    }

    public Length getUnit() {
        return this.unit;
    }

    /**
     * Add up another range.
     * The sum will be in the unit
     * of the object instance.
     * @param second another range
     */
    public void add(Range second) {
        float sum = Precision.round(
                this.amount +Range.convert(second, this.unit).getAmount(),
                4
        );
        this.set(sum, this.unit);
    }

    /**
     * Subtract another range.
     * The subtraction will be in the unit
     * of the object instance.
     * @param second another range
     */
    public void subtract(Range second) {
        float subtraction = Precision.round(
                this.amount - Range.convert(second, this.unit).getAmount(),
                4
        );
        this.set(subtraction, this.unit);
    }

    /**
     * Multiply another range.
     * The multiplication will be in the unit
     * of the object instance.
     * @param second another range
     */
    public void multiply(Range second) {
        float multiplication = Precision.round(
                this.amount * Range.convert(second, this.unit).getAmount(),
                4
        );
        this.set(multiplication, this.unit);
    }
    /**
     * Divide another range.
     * The division will be in the unit
     * of the object instance.
     * @param second another range
     */
    public void divide(Range second) {
        float division = Precision.round(
                this.amount / Range.convert(second, this.unit).getAmount(),
                4
        );
        this.set(division, this.unit);
    }
    public static Range convert(Range from, Length to) {
        float f;
        switch (from.unit) {
            case FEET -> f = from.amount / Length.FEET.val;
            case INCH -> f = from.amount / Length.INCH.val;
            case METER -> f = from.amount / Length.METER.val;
            case CENTIMETER -> f = from.amount / Length.CENTIMETER.val;
            default -> f = from.amount;
        }
        return new Range(Precision.round(f  * to.val, 4), to);
    }
}
