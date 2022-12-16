import 'dart:developer' as devs show log;

extension Common on Object {
  void log() => devs.log('Logger :: ${toString()}');

  num parseNum() {
    num result = 0;
    try {
      if (toString().indexOf('rating') > -1) {
        if (toString().length > 9) {
          result = num.parse(toString().replaceAll('\$', '').replaceAll('rating', '').substring(0, 2));
        } else {
          result = num.parse(toString().replaceAll('\$', '').replaceAll('rating', ''));
        }
      } else {
        result = num.parse(toString().replaceAll('\$', ''));
      }
    } catch (e) {
      'parseNum invalid value :: ${toString()}'.log();
    }
    return result;
  }
}

int getCategory(String value) {
  int result = 1;
  switch (value) {
    case 'Shoes':
      result = 1;
      break;
    case 'Clothes':
      result = 2;
      break;
    case 'Foods':
      result = 3;
      break;
    case 'Sport':
      result = 4;
      break;
    case 'Computer':
      result = 5;
      break;
    default:
      result = 1;
      break;
  }
  return result;
}

