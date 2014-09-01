import ddf.minim.*;

AudioPlayer player;
Minim minim;//audio context

void processMelodyEvent(JSONObject jsonObj) {
}

void processBeatEvent(JSONObject jsonObj) {
//  long startTime = jsonObj.getInt("date_start_unix");
//  long endTime = jsonObj.getInt("date_end_unix");
//  
//  float bookingLatitude   = jsonObj.getFloat("booking_latitude");
//  float bookingLongitude  = jsonObj.getFloat("booking_longitude");
//
//  float providerLatitude  = jsonObj.getFloat("provider_latitude");
//  float providerLongitude = jsonObj.getFloat("provider_longitude");
//  //int providerID          = jsonObj.getInt("provider_id");
//  
//  PVector bookingLocation = new PVector(bookingLatitude, bookingLongitude);
//  PVector providerLocation = new PVector(providerLatitude, providerLongitude);
//  
//  String type = jsonObj.getString("type");
//  
//  PVector providerPos = normalizeCoordinates(geodeticToCartesian(providerLatitude, providerLongitude));
//  PVector bookingPos = normalizeCoordinates(geodeticToCartesian(bookingLatitude, bookingLongitude));
//  
//  renderer.addProvider(new PVector(providerPos.x, providerPos.y));
//  
//  if(type.equals("availability_log"))
//    renderer.addAvailabilityLog(startTime, bookingPos, providerPos);
//  else
//    renderer.addBooking(startTime, endTime, bookingPos, providerPos);
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
  frameRate(30);
  
  int WIDTH = 800;
  int HEIGHT = 400;
  
  size(WIDTH, HEIGHT);
  textSize(14);
  
  String song_title = "Time";
  
  println(tempo_path(song_title));
  println(melody_path(song_title));
  
  // Beat Events
  JSONArray beat_events = loadJSONArray(tempo_path(song_title));
  JSONArray melody_events = loadJSONArray(melody_path(song_title));
  
  minim = new Minim(this);

  player = minim.loadFile(mp3_path(song_title), 2048);
  player.play();
}

void draw()
{
}

void stop()
{
   
  player.close();
  minim.stop();
  super.stop();
  
  
}

