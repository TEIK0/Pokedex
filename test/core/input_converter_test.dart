import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/core/util/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('String to UnsignedInt', () {
    test(
        'should return a integer when the string representes a unsigned integer',
        () async {
      const str = '123';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, const Right(123));
    });
    test('should return a failure when the string is not an integer', () async {
      const str = 'abc';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return a failure when the string is a negative integer',
        () async {
      const str = '-123';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
