part of ld34;

class Resources {

  static Map<String, ImageElement> images;
  static Map<String, AudioElement> sounds;

  static void init() {
    images = new Map<String, ImageElement>();
    sounds = new Map<String, AudioElement>();
  }

  static void load() {
    sounds['test'] = new AudioElement('res/test.wav');
    images['cage'] = new ImageElement(src: 'res/cage.png');
    images['trump'] = new ImageElement(src: 'res/trump.png');
    images['labeouf'] = new ImageElement(src: 'res/labeouf.png');
  }

}