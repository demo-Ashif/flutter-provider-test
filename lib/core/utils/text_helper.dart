class TextHelper {
  static String newLineLongText(String text) {
    text = text.trim();

    StringBuffer sb = StringBuffer();

    // Split the word on spaces
    var words = text.split(" ");
    if (words.length == 2) {
      if (words[1].length < 5) {
        sb.write(words[0]);
        sb.write(" ");
        sb.write(words[1]);
      } else {
        // There are two words
        // Add new line after first word
        sb.write(words[0]);
        sb.write("\n");
        sb.write(words[1]);
      }

      return sb.toString();
    }

    if (words.length > 2) {
      // There are more that 2 words
      // Add new line after second word
      sb.write(words[0]);
      sb.write(" ");
      sb.write(words[1]);

      sb.write("\n");
      for (var i = 2; i < words.length; ++i) {
        sb.write(words[i]);
        if (i != words.length) {
          sb.write(" ");
        }
      }

      return sb.toString();
    }

    return text;
  }
}
