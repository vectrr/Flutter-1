class Student {
  final int id;
  final String name;
  final int age;
  final String bio;
  final String occupation;
  final String email;
  final String createdAt;
  final String updatedAt;

  Student({this.id, this.name, this.age, this.bio, this.occupation,
    this.email, this.createdAt, this.updatedAt});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      bio: json['bio'],
      occupation: json['occupation'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'bio': bio,
  };
}
