/**
 A Keyframe is a simple data object that encapsulates all information needed to perform a motion tween between two lat/long pairs.
 */
class Keyframe {
  public long frame_start;
  public long frame_end;
  
  public float start_x;
  public float start_y;

  public float end_x;
  public float end_y;

  public Keyframe(String type, long frame_start, long frame_end, PVector source, PVector destination) {
    this.start_x  = source.x;
    this.start_y  = source.y;

    this.end_x = destination.x;
    this.end_y = destination.y;
    
    this.frame_start = frame_start;
    this.frame_end = frame_end;
  }
  
  public long durationInFrames() {
    return frame_end - frame_start;
  }

  String toString() {
    return "fs: " + frame_start + " fe: " + frame_end + " -> " + "(" + start_x + ", " + start_y + ")";
  }
}

