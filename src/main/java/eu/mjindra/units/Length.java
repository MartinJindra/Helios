package eu.mjindra.units;

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
