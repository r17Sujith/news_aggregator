

class ScreenUtility {
  static const wsize1 = 0.00256;
  static const hsize1 = 0.00128;

  static calculateWidth(var width) {
    return wsize1 * width;
  }

  static calculateHeight(var height) {
    return hsize1 * height;
  }
}
