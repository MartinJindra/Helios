package eu.mjindra.utils.dices.roll;

/**
 * Class representing a die roll.
 *
 * @author Martin Jindra
 * @version 28.05.2023
 */
public class Roll {

    private final byte[] order;

    private final short total;

    private Roll(byte amount, byte dice) {
        this.order = new byte[amount];
        short total = 0;
        for (short i = 0; i < amount; i++) {
            this.order[i] = (byte) (Math.random() * dice + 1);
            total += this.order[i];
        }
        this.total = total;
    }

    public static Roll create(byte amount, byte dice) {
        return new Roll(amount, dice);
    }

    /**
     * Get the total sum of the roll.
     *
     * @return total sum
     */
    public short getTotal() {
        return this.total;
    }

    /**
     * Get the order of the dice rolls.
     *
     * @return order
     */
    public byte[] getOrder() {
        return this.order;
    }

    @Override
    public String toString() {
        StringBuilder str = new StringBuilder(String.format("%d ", this.total));
        for (byte b : this.order) {
            str.append('[');
            str.append(b);
            str.append(']');
            str.append('+');
        }
        str.deleteCharAt(str.lastIndexOf("+"));
        return str.toString();
    }
}