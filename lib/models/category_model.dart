class CategoryModel {
    CategoryModel({
        required this.categories,
    });

    final List<CategoryModelElement> categories;

  get data => null;

    CategoryModel copyWith({
        List<CategoryModelElement>? categories,
    }) {
        return CategoryModel(
            categories: categories ?? this.categories,
        );
    }

    factory CategoryModel.fromJson(Map<String, dynamic> json){ 
        return CategoryModel(
            categories: json["categories"] == null ? [] : List<CategoryModelElement>.from(json["categories"]!.map((x) => CategoryModelElement.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "categories": categories.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$categories, ";
    }
}

class CategoryModelElement {
    CategoryModelElement({
        this.id,
        required this.imageUrl,
        this.name,
        this.tag,
        this.isNew,
        this.v,
    });

    String? id;
    String imageUrl;
    String? name;
    String? tag;
    String? isNew;
    int? v;

    CategoryModelElement copyWith({
        String? id,
        String? imageUrl,
        String? name,
        String? tag,
        String? isNew,
        int? v,
    }) {
        return CategoryModelElement(
            id: id ?? this.id,
            imageUrl: imageUrl ?? this.imageUrl,
            name: name ?? this.name,
            tag: tag ?? this.tag,
            isNew: isNew ?? this.isNew,
            v: v ?? this.v,
        );
    }

    factory CategoryModelElement.fromJson(Map<String, dynamic> json){ 
        return CategoryModelElement(
            id: json["_id"],
            imageUrl: json["imageURL"],
            name: json["name"],
            tag: json["tag"],
            isNew: json["isNew"],
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "imageURL": imageUrl,
        "name": name,
        "tag": tag,
        "isNew": isNew,
        "__v": v,
    };

    @override
    String toString(){
        return "$id, $imageUrl, $name, $tag, $isNew, $v, ";
    }
}
