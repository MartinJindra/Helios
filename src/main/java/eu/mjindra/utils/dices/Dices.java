package eu.mjindra.utils.dices;

/**
 * Enums for easy die creation.
 *
 * @author Martin Jindra
 * @version 30.05.2023
 */
public enum Dices {

    D0(new D0((byte) 0)),

    D10(new D10((byte) 1)),

    D100(new D100((byte) 1)),

    D12(new D12((byte) 1)),

    D20(new D20((byte) 1)),

    D4(new D4((byte) 1)),

    D6(new D6((byte) 1)),

    D8(new D8((byte) 1));

    private final Dice die;

    Dices(Dice die) {
        this.die = die;
    }

}
