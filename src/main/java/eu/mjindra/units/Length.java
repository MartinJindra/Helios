package eu.mjindra.units;

/**
 * An enum representing length in DND.
 * @author Martin Jindra
 * @version 27.05.2023
 */
public enum Length implements Base {
    FEET(1),
    INCH(12),
    METER(0.3048F),
    CENTIMETER(30.48F);

    public final float val;

    Length(float val) {
        this.val = val;
    }
}
