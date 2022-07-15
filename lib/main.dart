import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

void main() {
  runApp(MaterialApp(
    home: task(),
  ));
}

class task extends StatefulWidget {
  const task({Key? key}) : super(key: key);

  @override
  State<task> createState() => _taskState();
}

class _taskState extends State<task> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productss();
  }

  bool sts = false;
  Prodts? pd;
  @override
  Widget build(BuildContext context) {
    return sts
        ? Scaffold(
            body: ListView.builder(
              itemCount: pd!.products!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network("${pd!.products![index].thumbnail}"),
                  subtitle:
                      Text(maxLines: 1, "${pd!.products![index].description}"),
                  title: Text("${pd!.products![index].brand}"),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.canPop(context);
                      },
                      icon: Icon(Icons.threed_rotation)),
                  // shape: ShapeBorder,
                );
              },
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  productss() async {
    var url = Uri.parse('https://dummyjson.com/products');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    developer.log(response.body);
    var ress = jsonDecode(response.body);
    pd = Prodts.fromJson(ress);
    print("id===${pd!.products![0].category}==");

    setState(() {
      sts = true;
    });
  }
}

class Prodts {
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;

  Prodts({this.products, this.total, this.skip, this.limit});

  Prodts.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Products(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discountPercentage'] = this.discountPercentage;
    data['rating'] = this.rating;
    data['stock'] = this.stock;
    data['brand'] = this.brand;
    data['category'] = this.category;
    data['thumbnail'] = this.thumbnail;
    data['images'] = this.images;
    return data;
  }
}
