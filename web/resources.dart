part of ld34;

class Resources {

  static Map<String, ImageElement> images;
  static Map<String, AudioElement> sounds;
  static int imagesLoaded, soundsLoaded;

  static void init() {
    images = new Map<String, ImageElement>();
    sounds = new Map<String, AudioElement>();
    imagesLoaded = soundsLoaded = 0;
  }

  static void load() {
    sounds['test'] = new AudioElement('res/test.wav')..onLoadedData.first.then((e) => soundsLoaded++);
    images['cage'] = new ImageElement(src: 'res/cage.png')..onLoad.first.then((e) => imagesLoaded++);
    images['trump'] = new ImageElement(src: 'res/trump.png')..onLoad.first.then((e) => imagesLoaded++);
    images['labeouf'] = new ImageElement(src: 'res/labeouf.png')..onLoad.first.then((e) => imagesLoaded++);
  }

}