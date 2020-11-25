import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/models/models.dart';
import 'package:peppex_delivery/ui/components/product.dart';
import 'package:peppex_delivery/ui/components/top_app_bar.dart';
import 'package:peppex_delivery/ui/screens/checkout.dart';

class Home extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: TopAppBar(appBarText: 'Menú'),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
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
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height -
                    50 -
                    TopAppBar().preferredSize.height,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Center(
                  child: Obx(
                    () => StreamBuilder<List<ProductModel>>(
                      stream: categoriesController.listProducts(
                        categoriesController.currentCategory?.uid,
                      ),
                      builder: (context,
                          AsyncSnapshot<List<ProductModel>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data == null ||
                            snapshot.data.length == 0) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                              child: Text(
                                'Aún no hay productos registrados en esta categoría',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          );
                        }
                        return GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(
                                snapshot.data.length,
                                (index) => _listProducts(
                                    context, snapshot.data[index])));
                      },
                    ),
                  ),
                ),
              )
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
            borderRadius: BorderRadius.circular(8),
            color: categoriesController.currentCategory.uid == category.uid
                ? Theme.of(context).primaryColor
                : Color.fromARGB(100, 240, 240, 240),
          ),
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 115,
          height: 24,
          child: Text(
            category.name,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
              color: Theme.of(context).textTheme.headline6.color,
              fontWeight:
                  categoriesController.currentCategory.uid == category.uid
                      ? FontWeight.bold
                      : FontWeight.w200,
            ),
          ),
        ),
      ),
    );
  }

  Widget _listProducts(BuildContext context, ProductModel product) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ProductThumb(product: product));
  }
}
