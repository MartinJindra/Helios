package eu.mjindra.utils.units;

/**
 * An enum representing mass in DND.
 *
 * @author Martin Jindra
 * @version 27.05.2023
 */
public enum Mass implements Base {
    POUND(1),
    KILOGRAM(2.2046F);
    public final float val;

    Mass(float val) {
        this.val = val;
    }
}
