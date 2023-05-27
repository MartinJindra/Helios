package eu.mjindra.units;

public enum Mass implements Base {
    POUND(1),
    KILOGRAM(2.2046F);
    public final float val;

    Mass(float val) {
        this.val = val;
    }
}
