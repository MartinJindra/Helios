package eu.mjindra.utils.dices.roll;

/**
 * Class representing a die roll.
 * @author Martin Jindra
 * @version 28.05.2023
 */
public class Roll {

    private final byte dice;

    private final byte[] roll;

    private final short total;

    private Roll(byte amount, byte dice) {
        this.dice = dice;
        byte total = 0, tmp;
        this.roll = new byte[amount];
        for (short i = 0; i < this.roll.length; i++) {
            tmp = (byte) (Math.random() * dice + 1);
            this.roll[i] = tmp;
            total += tmp;
        }
        this.total = total;
    }

    public static Roll create(byte amount, byte dice) {
        return new Roll(amount, dice);
    }

    /**
     * Sums up all information into a printable format.
     * @return all information
     */
    public String summarizeInformation() {
        return String.format("(%dd%d) %d", this.roll.length, this.dice, this.total);
    }

    /**
     * Sums up all information into a printable format.
     * @return all information
     */
    public String toString() {
        return this.summarizeInformation();
    }

    public byte[] getRoll() {
        return roll;
    }

    public short getTotal() {
        return total;
    }
}