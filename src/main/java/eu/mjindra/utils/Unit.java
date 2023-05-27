package eu.mjindra.utils;

import eu.mjindra.units.Base;
import org.apache.commons.math3.util.Precision;

/**
 * A super class for units.
 * @author Martin Jindra
 * @version 27.05.2023
 */
public abstract class Unit {

    private float amount;

    private Base unit;

    public Unit(float amount, Base unit) {
        this.set(amount, unit);
    }

    public void set(float amount, Base unit) {
        this.amount = amount;
        this.unit = unit;
    }

    public float getAmount() {
        return this.amount;
    }

    public Base getUnit() {
        return this.unit;
    }

    /**
     * Add up another unit.
     * The sum will be in the unit
     * of the object instance.
     * @param second another range
     */
    public void add(Unit second) {
        float sum = Precision.round(
                this.getAmount() + second.convert(this.getUnit()).getAmount(),
                4
        );
        this.set(sum, this.getUnit());
    }

    /**
     * Subtract another unit.
     * The subtraction will be in the unit
     * of the object instance.
     * @param second another range
     */
    public void subtract(Unit second) {
        float subtraction = Precision.round(
                this.getAmount() - second.convert(this.getUnit()).getAmount(),
                4
        );
        this.set(subtraction, this.getUnit());
    }

    /**
     * Multiply another unit.
     * The multiplication will be in the unit
     * of the object instance.
     * @param second another range
     */
    public void multiply(Unit second) {
        float multiplication = Precision.round(
                this.getAmount() * second.convert(this.getUnit()).getAmount(),
                4
        );
        this.set(multiplication, this.getUnit());
    }

    /**
     * Divide another unit.
     * The division will be in the unit
     * of the object instance.
     * @param second another range
     */
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
    public abstract Unit convert(Base to);
}
