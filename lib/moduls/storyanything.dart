class StoryModuel {
  int id;
  String email, firstname, lastname;

  StoryModuel(this.email, this.firstname, this.id, this.lastname);

  factory StoryModuel.fromJson(Map<String, dynamic> map) {
    return StoryModuel(
        map['emile'], map['first_name'], map['user_id'], map['last_name']);
  }
}
