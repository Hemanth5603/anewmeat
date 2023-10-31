/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myBannerModelNode = BannerModel.fromJson(map);
*/ 



class BannerModel {
    List<Banner?>? banners;
    

    BannerModel({this.banners}); 

    BannerModel.fromJson(Map<String, dynamic> json) {
        if (json['banners'] != null) {
         banners = <Banner>[];
         json['banners'].forEach((v) {
         banners!.add(Banner.fromJson(v));
        });
      }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['banners'] =banners != null ? banners!.map((v) => v?.toJson()).toList() : null;
        return data;
    }
}

class Banner {
  Banner({
    this.id, 
    required this.imageURL,
    this.v
  }); 

    String? id;
    String imageURL;
    int? v;

    

    factory Banner.fromJson(Map<String, dynamic> json) {
      return Banner(
        id: json["_id"],
        imageURL: json["imageURL"],
        v: json['__v'],
        
      );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['_id'] = id;
        data['imageURL'] = imageURL;
        data['__v'] = v;
        return data;
    }
}


