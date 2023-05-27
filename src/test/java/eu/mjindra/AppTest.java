package eu.mjindra;

import eu.mjindra.character.DND5eParser;
import eu.mjindra.units.Length;
import eu.mjindra.utils.Range;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Unit test for simple App.
 */
public class AppTest {

    /**
     * Test the unit converter
     */
    @Test
    @DisplayName("testRangeConverter")
    public void testRangeConverter() {
        // 100cm to 1m
        Range r = new Range(100, Length.CENTIMETER);
        assertEquals(1, r.convert(Length.METER).getAmount());
        // 0.5m to 50cm
        r.set(0.5F, Length.METER);
        assertEquals(50, r.convert(Length.CENTIMETER).getAmount(), 0);
        // 8ft to 96inch
        r.set(8, Length.FEET);
        assertEquals(96, r.convert(Length.INCH).getAmount(), 0);
        // 78inch to 6.5ft
        r.set(78, Length.INCH);
        assertEquals(6.5, r.convert(Length.FEET).getAmount(), 0);
        // 12 ft to 3.6576m
        r.set(12, Length.FEET);
        assertEquals(3.6576F, r.convert(Length.METER).getAmount(), 0);
        // 7inch to 17.78cm
        r.set(7, Length.INCH);
        assertEquals(17.78F, r.convert(Length.CENTIMETER).getAmount(), 0);
        // 178cm to 5.8399ft
        r.set(178, Length.CENTIMETER);
        assertEquals(5.8399F, r.convert(Length.FEET).getAmount(), 0);
        // 50inch to 1.27m
        r.set(50, Length.INCH);
        assertEquals(1.27F, r.convert(Length.METER).getAmount(), 0);
    }

    /**
     * Test the math operation for a range.
     */
    @Test
    @DisplayName("testAddOperator")
    public void testAddOperator() {
        // 1m + 30cm = 1.3m
        Range op1 = new Range(1, Length.METER);
        Range op2 = new Range(30, Length.CENTIMETER);
        op1.add(op2);
        assertEquals(1.3F, op1.getAmount(), 0);

        // 1m + 5ft = 2.524m
        op1.set(1, Length.METER);
        op2.set(5, Length.FEET);
        op1.add(op2);
        assertEquals(2.524F, op1.getAmount(), 0);

        // 5ft + 0.2inch = 5.0167ft
        op1.set(5, Length.FEET);
        op2.set(0.2F, Length.INCH);
        op1.add(op2);
        assertEquals(5.0167F, op1.getAmount(), 0);

        // 23inch + 35cm = 36.7795inch
        op1.set(23, Length.INCH);
        op2.set(35, Length.CENTIMETER);
        op1.add(op2);
        assertEquals(36.7795F, op1.getAmount(), 0);
    }

    @Test
    @DisplayName("testSubtractOperator")
    public void testSubtractOperator() {
        // 300cm - 2.5m = 50cm
        Range op1 = new Range(300, Length.CENTIMETER);
        Range op2 = new Range(2.5F, Length.METER);
        op1.subtract(op2);
        assertEquals(50, op1.getAmount(), 0);

        // 10m - 40ft = -2.192m
        op1.set(10, Length.METER);
        op2.set(40, Length.FEET);
        op1.subtract(op2);
        assertEquals(-2.192F, op1.getAmount(), 0);

        // 3ft - 4inch = 2.6667ft
        op1.set(3, Length.FEET);
        op2.set(4, Length.INCH);
        op1.subtract(op2);
        assertEquals(2.6667F, op1.getAmount(), 0);

        // 50inch - 24cm = 40,5512inch
        op1.set(50, Length.INCH);
        op2.set(24, Length.CENTIMETER);
        op1.subtract(op2);
        assertEquals(40.5512F, op1.getAmount(), 0);
    }

    @Test
    @DisplayName("testMultiplyOperator")
    public void testMultiplyOperator() {
        // 300cm * 10m = 300000cm
        Range op1 = new Range(300, Length.CENTIMETER);
        Range op2 = new Range(10, Length.METER);
        op1.multiply(op2);
        assertEquals(300000, op1.getAmount(), 0);

        // 24m * 48ft = 351.1296m
        op1.set(24, Length.METER);
        op2.set(48, Length.FEET);
        op1.multiply(op2);
        assertEquals(351.1296F, op1.getAmount(), 0);

        // 1.5ft * 3.5inch = 0.4376ft
        op1.set(1.5F, Length.FEET);
        op2.set(3.5F, Length.INCH);
        op1.multiply(op2);
        assertEquals(0.4376F, op1.getAmount(), 0);

        // 78inch * 96cm = 2948.0334inch
        op1.set(78, Length.INCH);
        op2.set(96, Length.CENTIMETER);
        op1.multiply(op2);
        assertEquals(2948.0334F, op1.getAmount(), 0);
    }

    @Test
    @DisplayName("testDivideOperator")
    public void testDivideOperator() {
        // 400cm / 2m = 2cm
        Range op1 = new Range(400, Length.CENTIMETER);
        Range op2 = new Range(2, Length.METER);
        op1.divide(op2);
        assertEquals(2, op1.getAmount(), 0);

        // 35m / 54ft = 2.1265m
        op1.set(35, Length.METER);
        op2.set(54, Length.FEET);
        op1.divide(op2);
        assertEquals(2.1265F, op1.getAmount(), 0);

        // 25ft / 300inch = 1ft
        op1.set(25, Length.FEET);
        op2.set(300, Length.INCH);
        op1.divide(op2);
        assertEquals(1, op1.getAmount(), 0);

        // 128inch / 40cm = 8.1280inch
        op1.set(128, Length.INCH);
        op2.set(40, Length.CENTIMETER);
        op1.divide(op2);
        assertEquals(8.1280F, op1.getAmount(), 0);
    }

    @Test
    @DisplayName("testDNDParser")
    public void testDNDParser() {
        try(Stream<Path> examples = Files.list(Path.of("examples"))) {

            DND5eParser parser = new eu.mjindra.character.DND5eParser();
            eu.mjindra.character.Character character;

            for (Path example: examples.toList()) {
                parser.setFile(example.toString());
                parser.parseXML();
                character = parser.getCharacter();
                System.out.println(character.summerizeInformation());
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
