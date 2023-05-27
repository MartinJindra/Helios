package eu.mjindra.utils;

import eu.mjindra.units.Base;
import eu.mjindra.units.Length;
import org.apache.commons.math3.util.Precision;

public class Range extends Unit {

    public Range(float amount, Length unit) {
        super(amount, unit);
    }

    public void set(float amount, Length unit) {
        super.set(amount, unit);
    }

    public float getAmount() {
        return super.getAmount();
    }

    public Length getUnit() {
        return (Length) super.getUnit();
    }

    /**
     * Add up another range.
     * The sum will be in the unit
     * of the object instance.
     * @param second another range
     */
    @Override
    public void add(Unit second) {
        float sum = Precision.round(
                this.getAmount() + second.convert(this.getUnit()).getAmount(),
                4
        );
        this.set(sum, this.getUnit());
    }

    /**
     * Subtract another range.
     * The subtraction will be in the unit
     * of the object instance.
     * @param second another range
     */
    @Override
    public void subtract(Unit second) {
        float subtraction = Precision.round(
                this.getAmount() - second.convert(this.getUnit()).getAmount(),
                4
        );
        this.set(subtraction, this.getUnit());
    }

    /**
     * Multiply another range.
     * The multiplication will be in the unit
     * of the object instance.
     * @param second another range
     */
    @Override
    public void multiply(Unit second) {
        float multiplication = Precision.round(
                this.getAmount() * second.convert(this.getUnit()).getAmount(),
                4
        );
        this.set(multiplication, this.getUnit());
    }
    /**
     * Divide another range.
     * The division will be in the unit
     * of the object instance.
     * @param second another range
     */
    @Override
    public void divide(Unit second) {
        float division = Precision.round(
                this.getAmount() / second.convert(this.getUnit()).getAmount(),
                4
        );
        this.set(division, this.getUnit());
    }

    /**
     * Convert the value of one unit to another unit.
     * @param to different unit
     * @return converted value
     */
    @Override
    public Unit convert(Base to) {
        Length l = (Length) to;
        float f = this.getAmount() / this.getUnit().val;
        return new Range(Precision.round(f * l.val, 4), l);
    }
}
