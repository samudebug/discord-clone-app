class Profile {
  String id;
  String uid;
  String username;
  String displayName;
  String? photoUrl;
  bool completedOnboarding;

  Profile(
      {required this.id,
      required this.uid,
      required this.username,
      required this.displayName,
      this.photoUrl,
      this.completedOnboarding = false});
  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        uid = json['uid'],
        username = json['username'],
        displayName = json['displayName'],
        photoUrl = json['photoUrl'],
        completedOnboarding = json['completedOnboarding'];
}
