import 'dart:io';

import 'package:helios/dnd/character/parser.dart' as dndparser;
import 'package:helios/dnd/properties/weight.dart' show Weight;
import 'package:helios/dnd/quantity/mass.dart' show Mass;
import 'package:test/test.dart';

void main() {
  testDNDParser();
  testMassConverter();
  testMassAddOperator();
  testMassSubtractOperator();
  testMassMultiplyOperator();
  testMassDivideOperator();
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
  group('Test the unit converter', () {
    test(
        '100kg to 220.4622pound',
        () => {
              expect(
                  Weight(100, Mass.kilogram).convert(Mass.pound).amount, 220.46)
            });
    test(
        '0.5pound to 0.2268kg',
        () => {
              expect(Weight(.5, Mass.pound).convert(Mass.kilogram).amount,
                  .22679851220175995)
            });
    test(
        '165pound to 74.8427kg',
        () => {
              expect(Weight(165, Mass.pound).convert(Mass.kilogram).amount,
                  74.84350902658078)
            });
    test(
        '0.5kg to 1.1023pound',
        () => {
              expect(
                  Weight(.5, Mass.kilogram).convert(Mass.pound).amount, 1.1023)
            });
  });
}

void testMassAddOperator() {
  group('Test the math add operation for weights.', () {
    test('1kg + 30pound = 14.6077kg', () {
      Weight op1 = Weight(1, Mass.kilogram);
      Weight op2 = Weight(30, Mass.pound);
      op1.add(op2);
      expect(op1.amount, 14.607910732105596);
    });
    test('0.5pound + 5kg = 11.5231pound', () {
      Weight op1 = Weight(.5, Mass.pound);
      Weight op2 = Weight(5, Mass.kilogram);
      op1.add(op2);
      expect(op1.amount, 11.523);
    });
  });
}

void testMassSubtractOperator() {
  group('Test the math subtract operation for weights.', () {
    test('50kg - 23kg = 17kg', () {
      Weight op1 = Weight(50, Mass.kilogram);
      Weight op2 = Weight(23, Mass.kilogram);
      op1.subtract(op2);
      expect(op1.amount, 27);
    });
    test('80kg - 120kg = -40kg', () {
      Weight op1 = Weight(80, Mass.kilogram);
      Weight op2 = Weight(120, Mass.kilogram);
      op1.subtract(op2);
      expect(op1.amount, -40);
    });
    test('500pound - 20kg = 455.908pound', () {
      Weight op1 = Weight(500, Mass.pound);
      Weight op2 = Weight(20, Mass.kilogram);
      op1.subtract(op2);
      expect(op1.amount, 455.908);
    });
  });
}

void testMassMultiplyOperator() {
  group('Test the math multiplication operation for weights.', () {
    test('300kg * 20kg = 6000kg', () {
      Weight op1 = Weight(300, Mass.kilogram);
      Weight op2 = Weight(20, Mass.kilogram);
      op1.multiply(op2);
      expect(op1.amount, 6000);
    });
    test('20pound * 170pound = 3400pound', () {
      Weight op1 = Weight(20, Mass.pound);
      Weight op2 = Weight(170, Mass.pound);
      op1.multiply(op2);
      expect(op1.amount, 3400);
    });
    test('1.5pound * 1kg = 3.3069pound', () {
      Weight op1 = Weight(1.5, Mass.pound);
      Weight op2 = Weight(1, Mass.kilogram);
      op1.multiply(op2);
      expect(op1.amount, 3.3069);
    });
    test('20kg * 78pound = 707.612kg', () {
      Weight op1 = Weight(20, Mass.kilogram);
      Weight op2 = Weight(78, Mass.pound);
      op1.multiply(op2);
      expect(op1.amount, 707.611358069491);
    });
  });
}

void testMassDivideOperator() {
  group('Test the math divide operation for weights.', () {
    test('350kg / 2kg = 175kg', () {
      Weight op1 = Weight(350, Mass.kilogram);
      Weight op2 = Weight(2, Mass.kilogram);
      op1.divide(op2);
      expect(op1.amount, 175);
    });
    test('50pound / 500pound = 0.1pound', () {
      Weight op1 = Weight(50, Mass.pound);
      Weight op2 = Weight(500, Mass.pound);
      op1.divide(op2);
      expect(op1.amount, .1);
    });
    test('300pound / 120kg = 1.1340pound', () {
      Weight op1 = Weight(300, Mass.pound);
      Weight op2 = Weight(120, Mass.kilogram);
      op1.divide(op2);
      expect(op1.amount, 1.1339925610087997);
    });
    test('85kg / 200pound = 0.9370kg', () {
      Weight op1 = Weight(85, Mass.kilogram);
      Weight op2 = Weight(200, Mass.pound);
      op1.divide(op2);
      expect(op1.amount, .9369550000000001);
    });
  });
}
