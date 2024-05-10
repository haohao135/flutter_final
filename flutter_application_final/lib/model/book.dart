
class Book{
  String id;
  String image;
  String name;
  int price;

  Book({required this.id, required this.image, required this.name, required this.price});
  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "image": image,
      "name": name,
      "price": price,
    };
  }
}