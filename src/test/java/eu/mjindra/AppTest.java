package eu.mjindra;

import eu.mjindra.character.DND5eParser;
import eu.mjindra.units.Length;
import eu.mjindra.units.Mass;
import eu.mjindra.utils.dices.*;
import eu.mjindra.utils.dices.mixer.DiceMixer;
import eu.mjindra.utils.properties.Range;
import eu.mjindra.utils.properties.Weight;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashSet;
import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Unit test for simple App.
 */
public class AppTest {

    @Test
    @DisplayName("testDNDParser")
    public void testDNDParser() {
        try (Stream<Path> examples = Files.list(Path.of("examples"))) {

            DND5eParser parser = new eu.mjindra.character.DND5eParser();
            eu.mjindra.character.Character character;

            for (Path example : examples.toList()) {
                parser.setFile(example.toString());
                parser.parseXML();
                character = parser.getCharacter();
                System.out.println(character.summarizeInformation());
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Test the unit converter
     */
    @Test
    @DisplayName("testMassConverter")
    public void testMassConverter() {
        // 100kg to 220.4622pound
        Weight w = new Weight(100, Mass.KILOGRAM);
        assertEquals(220.46F, w.convert(Mass.POUND).getAmount());
        // 0.5pound to 0.2268kg
        w.set(0.5F, Mass.POUND);
        assertEquals(0.2268F, w.convert(Mass.KILOGRAM).getAmount(), 0);
        // 165pound to 74.8427kg
        w.set(165, Mass.POUND);
        assertEquals(74.8435F, w.convert(Mass.KILOGRAM).getAmount(), 0);
        // 0.5kg to 1.1023pound
        w.set(0.5F, Mass.KILOGRAM);
        assertEquals(1.1023F, w.convert(Mass.POUND).getAmount(), 0);
    }

    /**
     * Test the math operation for a range.
     */
    @Test
    @DisplayName("testMassAddOperator")
    public void testMassAddOperator() {
        // 1kg + 30pound = 14.6077kg
        Weight op1 = new Weight(1, Mass.KILOGRAM);
        Weight op2 = new Weight(30, Mass.POUND);
        op1.add(op2);
        assertEquals(14.6079F, op1.getAmount(), 0);

        // 0.5pound + 5kg = 11.5231pound
        op1.set(.5F, Mass.POUND);
        op2.set(5, Mass.KILOGRAM);
        op1.add(op2);
        assertEquals(11.523F, op1.getAmount(), 0);
    }

    @Test
    @DisplayName("testMassSubtractOperator")
    public void testMassSubtractOperator() {
        // 50kg - 23kg = 17kg
        Weight op1 = new Weight(50, Mass.KILOGRAM);
        Weight op2 = new Weight(23, Mass.KILOGRAM);
        op1.subtract(op2);
        assertEquals(27, op1.getAmount(), 0);

        // 80kg - 120kg = -40kg
        op1.set(80, Mass.KILOGRAM);
        op2.set(120, Mass.KILOGRAM);
        op1.subtract(op2);
        assertEquals(-40, op1.getAmount(), 0);

        // 500pound - 20kg = 455.9075pound
        op1.set(500, Mass.POUND);
        op2.set(20, Mass.KILOGRAM);
        op1.subtract(op2);
        assertEquals(455.908F, op1.getAmount(), 0);
    }

    @Test
    @DisplayName("testMassMultiplyOperator")
    public void testMassMultiplyOperator() {
        // 300kg * 20kg = 6000kg
        Weight op1 = new Weight(300, Mass.KILOGRAM);
        Weight op2 = new Weight(20, Mass.KILOGRAM);
        op1.multiply(op2);
        assertEquals(6000, op1.getAmount(), 0);

        // 20pound * 170 pound = 340pound
        op1.set(20, Mass.POUND);
        op2.set(170, Mass.POUND);
        op1.multiply(op2);
        assertEquals(3400, op1.getAmount(), 0);

        // 1.5pound * 1kg = 3.3069pound
        op1.set(1.5F, Mass.POUND);
        op2.set(1, Mass.KILOGRAM);
        op1.multiply(op2);
        assertEquals(3.3069F, op1.getAmount(), 0);

        // 20kg * 78pound = 707.604kg
        op1.set(20, Mass.KILOGRAM);
        op2.set(78, Mass.POUND);
        op1.multiply(op2);
        assertEquals(707.612F, op1.getAmount(), 0);
    }

    @Test
    @DisplayName("testMassDivideOperator")
    public void testMassDivideOperator() {
        // 350kg / 2kg = 175kg
        Weight op1 = new Weight(350, Mass.KILOGRAM);
        Weight op2 = new Weight(2, Mass.KILOGRAM);
        op1.divide(op2);
        assertEquals(175, op1.getAmount(), 0);

        // 50pound / 500pound = 0.1pound
        op1.set(50, Mass.POUND);
        op2.set(500, Mass.POUND);
        op1.divide(op2);
        assertEquals(0.1F, op1.getAmount(), 0);

        // 300pound / 120kg = 1.1340
        op1.set(300, Mass.POUND);
        op2.set(120, Mass.KILOGRAM);
        op1.divide(op2);
        assertEquals(1.1340F, op1.getAmount(), 0);

        // 85kg / 200pound = 0.9370kg
        op1.set(85, Mass.KILOGRAM);
        op2.set(200, Mass.POUND);
        op1.divide(op2);
        assertEquals(0.9370F, op1.getAmount(), 0);
    }

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
    @DisplayName("testRangeAddOperator")
    public void testRangeAddOperator() {
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
    @DisplayName("testRangeSubtractOperator")
    public void testRangeSubtractOperator() {
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
    public void testRangeMultiplyOperator() {
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
    public void testRangeDivideOperator() {
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
    @DisplayName("testDices")
    public void testDices() {
        // D4
        short total;
        short len = 4;
        HashSet<Short> res = new HashSet<>(len);
        Dice d = new D4((byte) 1);
        do {
            total = d.roll().getTotal();
            res.add(total);
            assertTrue(total >= 1 && total <= len);
        } while (res.size() != len);
        System.out.println(res);
        // D6
        len = 6;
        res = new HashSet<>(len);
        d = new D6((byte) 1);
        do {
            total = d.roll().getTotal();
            res.add(total);
            assertTrue(total >= 1 && total <= len);
        } while (res.size() != len);
        System.out.println(res);
        // D8
        len = 8;
        res = new HashSet<>(len);
        d = new D8((byte) 1);
        do {
            total = d.roll().getTotal();
            res.add(total);
            assertTrue(total >= 1 && total <= len);
        } while (res.size() != len);
        System.out.println(res);
        // D10
        len = 10;
        res = new HashSet<>(len);
        d = new D10((byte) 1);
        do {
            total = d.roll().getTotal();
            res.add(total);
            assertTrue(total >= 1 && total <= len);
        } while (res.size() != len);
        System.out.println(res);
        // D12
        len = 12;
        res = new HashSet<>(len);
        d = new D12((byte) 1);
        do {
            total = d.roll().getTotal();
            res.add(total);
            assertTrue(total >= 1 && total <= len);
        } while (res.size() != len);
        System.out.println(res);
        // D20
        len = 20;
        res = new HashSet<>(len);
        d = new D20((byte) 1);
        do {
            total = d.roll().getTotal();
            res.add(total);
            assertTrue(total >= 1 && total <= len);
        } while (res.size() != len);
        System.out.println(res);
        // D100
        len = 100;
        res = new HashSet<>(len);
        d = new D100((byte) 1);
        do {
            total = d.roll().getTotal();
            res.add(total);
            assertTrue(total >= 1 && total <= len);
        } while (res.size() != len);
        System.out.println(res);
    }

    @Test
    @DisplayName("testDicesToString")
    public void testDicesToString() {

        DiceMixer mixer = new DiceMixer();
        mixer.add(new D8((byte) 1));
        mixer.add(new D8((byte) 1));
        mixer.add(new D20((byte) 1));
        mixer.add(new D12((byte) 2));
        System.out.println(mixer);

        mixer = new DiceMixer();
        mixer.add(new D100((byte) 1));
        mixer.add(new D6((byte) 2));
        mixer.add(new D4((byte) 2));
        mixer.add(new D8((byte) 4));
        mixer.add(new D4((byte) 2));
        System.out.println(mixer);

        byte len = 6;
        Dice d = new D4(len);
        System.out.println(d.roll());
        d = new D6(len);
        System.out.println(d.roll());
        d = new D8(len);
        System.out.println(d.roll());
        d = new D10(len);
        System.out.println(d.roll());
        d = new D12(len);
        System.out.println(d.roll());
        d = new D20(len);
        System.out.println(d.roll());
        d = new D100(len);
        System.out.println(d.roll());
    }
}
