class Note {

  dynamic id; // Can be int or String, depending on the use case

  String title;

  String content;

  DateTime createdAt;

  String? imagePath; // Optional image path


  String? pdfPath; // Optional PDF path



  Note({

    this.id,

    required this.title,

    required this.content,

    required this.createdAt,

    this.imagePath,

    this.pdfPath,

  });



  // Convert Note object to a Map (for database storage)

  Map<String, dynamic> toMap() {

    return {

      'id': id,

      'title': title,

      'content': content,

      'createdAt': createdAt.toIso8601String(), // Convert DateTime to ISO 8601 string

      'imagePath': imagePath,

      'pdfPath': pdfPath,

    };

  }



  // Create a Note object from a Map (for fetching from the database)

  factory Note.fromMap(Map<String, dynamic> map) {

    return Note(

      id: map['id'],

      title: map['title'],

      content: map['content'],

      createdAt: DateTime.parse(map['createdAt']), // Parse ISO 8601 string to DateTime

      imagePath: map['imagePath'],

      pdfPath: map['pdfPath'],

    );

  }



  // Optional: Override toString() for easier debugging

  @override

  String toString() {

    return 'Note(id: $id, title: $title, content: $content, createdAt: $createdAt, imagePath: $imagePath,  pdfPath: $pdfPath)';

  }

}