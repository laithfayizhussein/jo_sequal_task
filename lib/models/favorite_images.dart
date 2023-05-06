class FavoriteImages {
  int? id;
  String? imageUrl;
  FavoriteImages(this.id, this.imageUrl);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
    };
    return map;
  }

  FavoriteImages.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    imageUrl = map['imageUrl'];
  }

  @override
  String toString() {
    return "('id'$id , 'url'$imageUrl)";
  }
} 
