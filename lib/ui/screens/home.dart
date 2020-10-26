import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/models/models.dart';

class Home extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Esto es Peppex'),
            bottomOpacity: 0.0,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Text(
                  "Categorías",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                child: StreamBuilder<List<CategoryModel>>(
                  stream: categoriesController.listCategories(),
                  builder:
                      (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data
                          .map((category) => _categoryList(context, category))
                          .toList(),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              authController.signOut();
            },
            backgroundColor: Theme.of(context).buttonColor,
          ),
        ),
      );

  Widget _categoryList(BuildContext context, CategoryModel category) {
    return Obx(
      () => InkWell(
        onTap: () {
          categoriesController.setCurrentCategory(category);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(100, 240, 240, 240),
          ),
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
              color: Theme.of(context).textTheme.headline6.color,
              fontWeight:
                  categoriesController.currentCategory.uid == category.uid
                      ? FontWeight.bold
                      : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  final Function onPressed;
  final ProductModel product;
  const ProductListItem(
      {Key key, @required this.onPressed, @required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        elevation: 0.5,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: onPressed,
        child: Text(product.name),
      ),
    );
  }
}
