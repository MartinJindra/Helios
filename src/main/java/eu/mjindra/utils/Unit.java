package eu.mjindra.utils;

import eu.mjindra.units.Base;

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
    public abstract void add(Unit second);

    /**
     * Subtract another unit.
     * The subtraction will be in the unit
     * of the object instance.
     * @param second another range
     */
    public abstract void subtract(Unit second);

    /**
     * Multiply another unit.
     * The multiplication will be in the unit
     * of the object instance.
     * @param second another range
     */
    public abstract void multiply(Unit second);

    /**
     * Divide another unit.
     * The division will be in the unit
     * of the object instance.
     * @param second another range
     */
    public abstract void divide(Unit second);

    /**
     * Convert the value of one unit to another unit.
     * @param to different unit
     * @return converted value
     */
    public abstract Unit convert(Base to);
}
