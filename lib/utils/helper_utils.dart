

import 'dart:ui';

import '../data/models/category_model.dart';
import '../data/models/product_model.dart';

const List<Color> colors = [
  Color(0xff2E2E2E),
  Color(0xff29695D),
  Color(0xff5B8EA3),
  Color(0xff746A36),
];

List images = [
  "https://shamo-backend.buildwithangga.id/storage/gallery/sW4VtliQPYnwvlbpxL5x6ZhKvbgBWT84OoiDyRsE.png",
  "https://shamo-backend.buildwithangga.id/storage/gallery/sW4VtliQPYnwvlbpxL5x6ZhKvbgBWT84OoiDyRsE.png",
  "https://shamo-backend.buildwithangga.id/storage/gallery/sW4VtliQPYnwvlbpxL5x6ZhKvbgBWT84OoiDyRsE.png",
];

final List<String> listCategory = [
  "All Shoes",
  "Sport",
  "Hiking",
  "Basketball",
  "Trainning",
  "Running"
];

List<ProductModel> productList = [
  ProductModel(
      id: 1,
      name: "Nike Air Max 90",
      price: 239,
      description: "A pillar of sneaker culture, the Nike Air Max 90 remains one of the most significant designs since the brand’s founding. And while its OG colorways are some of the most significant.",
      tags: "popular",
      categoriesId: 1,
      category: CategoryModel(id: 1, name: 'Sneakers'),
      galleries: []
  ),
  ProductModel(
    id: 1,
    name: "Nike Air Max 90",
    price: 239,
    description: "A pillar of sneaker culture, the Nike Air Max 90 remains one of the most significant designs since the brand’s founding. And while its OG colorways are some of the most significant.",
    tags: "popular",
    categoriesId: 1,
    category: CategoryModel(id: 1, name: ''),
    galleries: []
  ),
  ProductModel(
    id: 1,
    name: "Nike Air Max 90",
    price: 239,
    description: "A pillar of sneaker culture, the Nike Air Max 90 remains one of the most significant designs since the brand’s founding. And while its OG colorways are some of the most significant.",
    tags: "popular",
    categoriesId: 1,
    category: CategoryModel(id: 1, name: ''),
    galleries: []
  ),
  ProductModel(
    id: 1,
    name: "Nike Air Max 90",
    price: 239,
    description: "A pillar of sneaker culture, the Nike Air Max 90 remains one of the most significant designs since the brand’s founding. And while its OG colorways are some of the most significant.",
    tags: "popular",
    categoriesId: 1,
    category: CategoryModel(id: 1, name: ''),
    galleries: []
  ),
  ProductModel(
    id: 1,
    name: "Nike Air Max 90",
    price: 239,
    description: "A pillar of sneaker culture, the Nike Air Max 90 remains one of the most significant designs since the brand’s founding. And while its OG colorways are some of the most significant.",
    tags: "popular",
    categoriesId: 1,
    category: CategoryModel(id: 1, name: ''),
    galleries: []
),
];