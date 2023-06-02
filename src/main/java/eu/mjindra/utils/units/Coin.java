package eu.mjindra.utils.units;

/**
 * All coins for DnD.
 *
 * @author Martin Jindra
 * @version 02.06.2023
 */
public enum Coin implements Base {
    COPPER(10F),
    SILVER(1),
    ELECTRUM(0.2F),
    GOLD(0.1F),
    PLATINUM(0.01F);

    public final float val;

    Coin(float val) {
        this.val = val;
    }
}