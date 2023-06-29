import 'dart:collection';
import 'dart:io';

import 'package:helios/dnd/character/parser/parser.dart' as dndparser;
import 'package:helios/dnd/dices/d0.dart';
import 'package:helios/dnd/dices/d10.dart' show D10;
import 'package:helios/dnd/dices/d100.dart' show D100;
import 'package:helios/dnd/dices/d12.dart' show D12;
import 'package:helios/dnd/dices/d20.dart' show D20;
import 'package:helios/dnd/dices/d4.dart' show D4;
import 'package:helios/dnd/dices/d6.dart' show D6;
import 'package:helios/dnd/dices/d8.dart' show D8;
import 'package:helios/dnd/dices/die.dart' show Die;
import 'package:helios/dnd/dices/mixer.dart' show Mixer;
import 'package:helios/dnd/properties/range.dart' show Range;
import 'package:helios/dnd/properties/weight.dart' show Weight;
import 'package:helios/dnd/quantity/length.dart' show Length;
import 'package:helios/dnd/quantity/mass.dart' show Mass;
import 'package:helios/dnd/quantity/value.dart';
import 'package:helios/util/strings.dart' as util;
import 'package:flutter_test/flutter_test.dart' show expect, group, test;

void main() {
  testDNDParser();
  testMassConverter();
  testMassAddOperator();
  testMassSubtractOperator();
  testMassMultiplyOperator();
  testMassDivideOperator();
  testRangeConverter();
  testRangeAddOperator();
  testRangeSubtractOperator();
  testRangeMultiplyOperator();
  testRangeDivideOperator();
  testDices();
  testMixer();
  testUtil();
}

void testDNDParser() {
  dndparser.Parser parser;
  List<FileSystemEntity> examples = Directory('examples').listSync();
  for (FileSystemEntity example in examples) {
    if (example.path.contains('.dnd5e')) {
      parser = dndparser.Parser(example.path);
      parser.parse();
      stdout.writeln(parser.character);
    }
  }
}

void testMassConverter() {
  group('Test the mass unit converter', () {
    test('100kg to 220.46pound', () {
      expect(
          Value.convert(Weight(100, Mass.kilogram), Mass.pound).amount, 220.46);
    });
    test('0.5pound to 0.23kg', () {
      expect(Value.convert(Weight(.5, Mass.pound), Mass.kilogram).amount, .23);
    });
    test('165pound to 74.84kg', () {
      expect(
          Value.convert(Weight(165, Mass.pound), Mass.kilogram).amount, 74.84);
    });
    test('0.5kg to 1.1pound', () {
      expect(Value.convert(Weight(.5, Mass.kilogram), Mass.pound).amount, 1.1);
    });
  });
}

void testMassAddOperator() {
  group('Test the math add operation for weights.', () {
    test('1kg + 30pound = 14.61kg', () {
      Weight op1 = Weight(1, Mass.kilogram);
      Weight op2 = Weight(30, Mass.pound);
      expect(Value.add(op1, op2).amount, 14.61);
    });
    test('0.5pound + 5kg = 11.52pound', () {
      Weight op1 = Weight(.5, Mass.pound);
      Weight op2 = Weight(5, Mass.kilogram);
      expect(Value.add(op1, op2).amount, 11.52);
    });
  });
}

void testMassSubtractOperator() {
  group('Test the math subtract operation for weights.', () {
    test('50kg - 23kg = 17kg', () {
      Weight op1 = Weight(50, Mass.kilogram);
      Weight op2 = Weight(23, Mass.kilogram);
      expect(Value.subtract(op1, op2).amount, 27);
    });
    test('80kg - 120kg = -40kg', () {
      Weight op1 = Weight(80, Mass.kilogram);
      Weight op2 = Weight(120, Mass.kilogram);
      expect(Value.subtract(op1, op2).amount, -40);
    });
    test('500pound - 20kg = 455.91pound', () {
      Weight op1 = Weight(500, Mass.pound);
      Weight op2 = Weight(20, Mass.kilogram);
      expect(Value.subtract(op1, op2).amount, 455.91);
    });
  });
}

void testMassMultiplyOperator() {
  group('Test the math multiplication operation for weights.', () {
    test('300kg * 20kg = 6000kg', () {
      Weight op1 = Weight(300, Mass.kilogram);
      Weight op2 = Weight(20, Mass.kilogram);
      expect(Value.multiply(op1, op2).amount, 6000);
    });
    test('20pound * 170pound = 3400pound', () {
      Weight op1 = Weight(20, Mass.pound);
      Weight op2 = Weight(170, Mass.pound);
      expect(Value.multiply(op1, op2).amount, 3400);
    });
    test('1.5pound * 1kg = 3.3pound', () {
      Weight op1 = Weight(1.5, Mass.pound);
      Weight op2 = Weight(1, Mass.kilogram);
      expect(Value.multiply(op1, op2).amount, 3.3);
    });
    test('20kg * 78pound = 707.6kg', () {
      Weight op1 = Weight(20, Mass.kilogram);
      Weight op2 = Weight(78, Mass.pound);
      expect(Value.multiply(op1, op2).amount, 707.6);
    });
  });
}

void testMassDivideOperator() {
  group('Test the math divide operation for weights.', () {
    test('350kg / 2kg = 175kg', () {
      Weight op1 = Weight(350, Mass.kilogram);
      Weight op2 = Weight(2, Mass.kilogram);
      expect(Value.divide(op1, op2).amount, 175);
    });
    test('50pound / 500pound = 0.1pound', () {
      Weight op1 = Weight(50, Mass.pound);
      Weight op2 = Weight(500, Mass.pound);
      expect(Value.divide(op1, op2).amount, .1);
    });
    test('300pound / 120kg = 1.13pound', () {
      Weight op1 = Weight(300, Mass.pound);
      Weight op2 = Weight(120, Mass.kilogram);
      expect(Value.divide(op1, op2).amount, 1.13);
    });
    test('85kg / 200pound = 0.94kg', () {
      Weight op1 = Weight(85, Mass.kilogram);
      Weight op2 = Weight(200, Mass.pound);
      expect(Value.divide(op1, op2).amount, .94);
    });
  });
}

void testRangeConverter() {
  group('Test the range unit converter', () {
    test(
        '100cm to 1m',
        () => {
              expect(
                  Value.convert(Range(100, Length.centimeter), Length.meter)
                      .amount,
                  1)
            });
    test(
        '0.5m to 50cm',
        () => {
              expect(
                  Value.convert(Range(.5, Length.meter), Length.centimeter)
                      .amount,
                  50)
            });
    test(
        '8ft to 96.39inch',
        () => {
              expect(Value.convert(Range(8, Length.feet), Length.inch).amount,
                  96.39)
            });
    test(
        '78inch to 6.47feet',
        () => {
              expect(Value.convert(Range(78, Length.inch), Length.feet).amount,
                  6.47)
            });
    test(
        '12ft to 3.66m',
        () => {
              expect(Value.convert(Range(12, Length.feet), Length.meter).amount,
                  3.66)
            });
    test(
        '7inch to 17.71cm',
        () => {
              expect(
                  Value.convert(Range(7, Length.inch), Length.centimeter)
                      .amount,
                  17.71)
            });
    test(
        '178cm to 5.84feet',
        () => {
              expect(
                  Value.convert(Range(178, Length.centimeter), Length.feet)
                      .amount,
                  5.84)
            });
    test(
        '50inch to 1.26m',
        () => {
              expect(Value.convert(Range(50, Length.inch), Length.meter).amount,
                  1.26)
            });
  });
}

void testRangeAddOperator() {
  group('Test the add operation for a range.', () {
    test('1m + 30cm = 1.3m', () {
      Range op1 = Range(1, Length.meter);
      Range op2 = Range(30, Length.centimeter);
      expect(Value.add(op1, op2).amount, 1.3);
    });
    test('1m + 5ft = 2.52m', () {
      Range op1 = Range(1, Length.meter);
      Range op2 = Range(5, Length.feet);
      expect(Value.add(op1, op2).amount, 2.52);
    });
    test('5ft + 0.2inch = 5.02ft', () {
      Range op1 = Range(5, Length.feet);
      Range op2 = Range(.2, Length.inch);
      expect(Value.add(op1, op2).amount, 5.02);
    });
    test('23inch + 35cm = 36.83inch', () {
      Range op1 = Range(23, Length.inch);
      Range op2 = Range(35, Length.centimeter);
      expect(Value.add(op1, op2).amount, 36.83);
    });
  });
}

void testRangeSubtractOperator() {
  group('Test the subtract operation for a range.', () {
    test('300cm - 2.5m = 50cm', () {
      Range op1 = Range(300, Length.centimeter);
      Range op2 = Range(2.5, Length.meter);
      expect(Value.subtract(op1, op2).amount, 50);
    });
    test('10m - 40ft = -2.19m', () {
      Range op1 = Range(10, Length.meter);
      Range op2 = Range(40, Length.feet);
      expect(Value.subtract(op1, op2).amount, -2.19);
    });
    test('3ft - 4inch = 2.67ft', () {
      Range op1 = Range(3, Length.feet);
      Range op2 = Range(4, Length.inch);
      expect(Value.subtract(op1, op2).amount, 2.67);
    });
    test('50inch - 24cm = 40.51inch', () {
      Range op1 = Range(50, Length.inch);
      Range op2 = Range(24, Length.centimeter);
      expect(Value.subtract(op1, op2).amount, 40.51);
    });
  });
}

void testRangeMultiplyOperator() {
  group('Test the multiplication operation for a range.', () {
    test('300cm * 10m = 300000cm', () {
      Range op1 = Range(300, Length.centimeter);
      Range op2 = Range(10, Length.meter);
      expect(Value.multiply(op1, op2).amount, 300000);
    });
    test('24m * 48ft = 351.12m', () {
      Range op1 = Range(24, Length.meter);
      Range op2 = Range(48, Length.feet);
      expect(Value.multiply(op1, op2).amount, 351.12);
    });
    test('1.5ft * 3.5inch = 0.43ft', () {
      Range op1 = Range(1.5, Length.feet);
      Range op2 = Range(3.5, Length.inch);
      expect(Value.multiply(op1, op2).amount, .43);
    });
    test('78inch * 96cm = 2960.1inch', () {
      Range op1 = Range(78, Length.inch);
      Range op2 = Range(96, Length.centimeter);
      expect(Value.multiply(op1, op2).amount, 2960.1);
    });
  });
}

void testRangeDivideOperator() {
  group('Test the divide operation for a range.', () {
    test('400cm / 2m = 2cm', () {
      Range op1 = Range(400, Length.centimeter);
      Range op2 = Range(2, Length.meter);
      expect(Value.divide(op1, op2).amount, 2);
    });
    test('35m / 54ft = 2.13m', () {
      Range op1 = Range(35, Length.meter);
      Range op2 = Range(54, Length.feet);
      expect(Value.divide(op1, op2).amount, 2.13);
    });
    test('25ft / 300inch = 1ft', () {
      Range op1 = Range(25, Length.feet);
      Range op2 = Range(300, Length.inch);
      expect(Value.divide(op1, op2).amount, 1);
    });
    test('128inch / 40cm = 8.1inch', () {
      Range op1 = Range(128, Length.inch);
      Range op2 = Range(40, Length.centimeter);
      expect(Value.divide(op1, op2).amount, 8.1);
    });
  });
}

void testDices() {
  group('Test the dices and rolls', () {
    test('D4', () {
      int total, len = 4;
      HashSet<int> res = HashSet();
      Die d = D4();
      do {
        d.newRoll();
        total = d.roll;
        res.add(total);
        expect(total >= 1 && total <= len, true);
      } while (res.length < len);
      expect(res, {1, 2, 3, 4});
    });
    test('D6', () {
      int total, len = 6;
      HashSet<int> res = HashSet();
      Die d = D6();
      do {
        d.newRoll();
        total = d.roll;
        res.add(total);
        expect(total >= 1 && total <= len, true);
      } while (res.length < len);
      expect(res, {1, 2, 3, 4, 5, 6});
    });
    test('D8', () {
      int total, len = 8;
      HashSet<int> res = HashSet();
      Die d = D8();
      do {
        d.newRoll();
        total = d.roll;
        res.add(total);
        expect(total >= 1 && total <= len, true);
      } while (res.length < len);
      expect(res, {1, 2, 3, 4, 5, 6, 7, 8});
    });
    test('D10', () {
      int total, len = 10;
      HashSet<int> res = HashSet();
      Die d = D10();
      do {
        d.newRoll();
        total = d.roll;
        res.add(total);
        expect(total >= 1 && total <= len, true);
      } while (res.length < len);
      expect(res, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10});
    });
    test('D12', () {
      int total, len = 12;
      HashSet<int> res = HashSet();
      Die d = D12();
      do {
        d.newRoll();
        total = d.roll;
        res.add(total);
        expect(total >= 1 && total <= len, true);
      } while (res.length < len);
      expect(res, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12});
    });
    test('D20', () {
      int total, len = 20;
      HashSet<int> res = HashSet();
      Die d = D20();
      do {
        d.newRoll();
        total = d.roll;
        res.add(total);
        expect(total >= 1 && total <= len, true);
      } while (res.length < len);
      expect(res, {
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20
      });
    });
    test('D100', () {
      int total, len = 100;
      HashSet<int> res = HashSet();
      Die d = D100();
      do {
        d.newRoll();
        total = d.roll;
        res.add(total);
        expect(total >= 1 && total <= len, true);
      } while (res.length < len);
      expect(res, {
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36,
        37,
        38,
        39,
        40,
        41,
        42,
        43,
        44,
        45,
        46,
        47,
        48,
        49,
        50,
        51,
        52,
        53,
        54,
        55,
        56,
        57,
        58,
        59,
        60,
        61,
        62,
        63,
        64,
        65,
        66,
        67,
        68,
        69,
        70,
        71,
        72,
        73,
        74,
        75,
        76,
        77,
        78,
        79,
        80,
        81,
        82,
        83,
        84,
        85,
        86,
        87,
        88,
        89,
        90,
        91,
        92,
        93,
        94,
        95,
        96,
        97,
        98,
        99,
        100
      });
    });
  });
}

void testMixer() {
  group('Test the Dice mixer.', () {
    test('Mix 1', () {
      Mixer mix = Mixer();
      mix.add(D4());
      mix.add(D4());
      mix.add(D6());
      mix.add(D12());
      mix.add(D100());
      mix.add(D6());
      mix.add(D20());
      expect(mix.toString(), '2d4+2d6+1d12+1d100+1d20');
    });
    test('Mix 2', () {
      Mixer mix = Mixer();
      mix.add(D0());
      mix.add(D20());
      for (int i = 0; i < 100; i++) {
        mix.add(D6());
      }
      mix.add(D20());
      expect(mix.toString(), '1d0+2d20+100d6');
    });
    test('Mix 1', () {
      Mixer mix = Mixer();
      for (int i = 0; i < 10; i++) {
        mix.add(D12());
      }
      for (int i = 0; i < 34; i++) {
        mix.add(D4());
      }
      for (int i = 0; i < 2; i++) {
        mix.add(D6());
      }
      for (int i = 0; i < 47; i++) {
        mix.add(D20());
      }
      for (int i = 0; i < 98; i++) {
        mix.add(D100());
      }
      expect(mix.toString(), '10d12+34d4+2d6+47d20+98d100');
    });
  });
}

void testUtil() {
  group('Test util methods', () {
    test('removeLast()', () {
      String expr = '1d20+20';
      expect(util.removeLast('$expr+', '+'), expr);
    });
  });
}
