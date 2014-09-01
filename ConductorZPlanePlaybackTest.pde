import ddf.minim.*;

AudioPlayer player;
Renderer renderer;
Minim minim;

final int FPS = 30;


void processBeatEvent(JSONObject jsonObj) {
  int index = jsonObj.getInt("index");
  float bpm = jsonObj.getFloat("bpm");
  float probability = jsonObj.getFloat("probability");
  float time = jsonObj.getFloat("time");
  Boolean downbeat = jsonObj.getBoolean("downbeat");
  
  renderer.addBeat(time, downbeat);
}

void processMelodyEvent(JSONObject jsonObj) {
  float pitch = jsonObj.getFloat("midi_pitch");
  float onset_time = jsonObj.getFloat("onset_time");
  float volume = jsonObj.getFloat("volume");
  float duration = jsonObj.getFloat("duration");
  
  renderer.addMelody(onset_time, duration, pitch);
}

void processBeats(JSONArray beat_events) {
  for (int i = 0; i < beat_events.size(); i++) {    
    JSONObject beat_event = beat_events.getJSONObject(i); 
    processBeatEvent(beat_event);
  }
}

void processMelody(JSONArray melody_events) {
  for (int i = 0; i < melody_events.size(); i++) {    
    JSONObject melody_event = melody_events.getJSONObject(i); 
    processMelodyEvent(melody_event);
  }
}

void parseJSON(JSONArray booking_events) {
   for (int i = 0; i < booking_events.size(); i++) {    
    JSONObject bookingEvent = booking_events.getJSONObject(i); 
    processBeatEvent(bookingEvent);
  }
}

String mp3_path(String song_name) {
  return "assets/" + song_name + ".mp3_processed/" + song_name + ".mp3";
}

String melody_path(String song_name) {
  return "assets/" + song_name + ".mp3_processed/" + song_name + ".mp3_melody.json";
}

String tempo_path(String song_name) {
  return "assets/" + song_name + ".mp3_processed/" + song_name + ".mp3_tempo.json";
}



void setup()
{
  smooth();
  noStroke();
  frameRate(FPS);
  
  int WIDTH = 500;
  int HEIGHT = 800;
  
  size(WIDTH, HEIGHT);
  textSize(14);
  
  renderer = new Renderer(FPS);
  
  String song_title = "Time";
  
  println(tempo_path(song_title));
  println(melody_path(song_title));
  
  // Beat Events
  JSONArray beat_events = loadJSONArray(tempo_path(song_title));
  JSONArray melody_events = loadJSONArray(melody_path(song_title));
  
  processBeats(beat_events);
  processMelody(melody_events);
  
  minim = new Minim(this);

  player = minim.loadFile(mp3_path(song_title), 2048);
  player.play();
}

void draw()
{
//  println(random(255));
  renderer.render();
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}

