class StoryoneModuel {
  int id, clintphone;
  String clintname;
  num chistwhdth,
      cholder,
      handwhdth,
      hight,
      handlength,
      lowerpart,
      mfsl,
      nick,
      muscle,
      bttn;

  StoryoneModuel(
      this.clintname,
      this.clintphone,
      this.id,
      this.chistwhdth,
      this.cholder,
      this.handwhdth,
      this.hight,
      this.handlength,
      this.lowerpart,
      this.mfsl,
      this.muscle,
      this.nick,
      this.bttn);

  factory StoryoneModuel.fromJson(Map<String, dynamic> map) {
    return StoryoneModuel(
        map['clint_name'],
        map['clint_phone'],
        map['clint_id'],
        map['chist_whdth'],
        map['cholder'],
        map['hand_whdth'],
        map['hight'],
        map['hand_length'],
        map['lower_part'],
        map['mfsl'],
        map['muscle'],
        map['nick'],
        map['bttn']);
  }
}
