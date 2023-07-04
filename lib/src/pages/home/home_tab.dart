import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hortifrute/src/services/utils_services.dart';
import '../../config/app_data.dart' as appData;
import '../../config/custom_colors.dart';
import 'componentes/category_tile.dart';
import 'componentes/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {


  String selectedCategory = 'Frutas';
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 30,
              ),
              children: [
                TextSpan(text: 'Green',
                  style: TextStyle(
                    color: CustomColors.customSwatchColor,
                  ),
                ),
                TextSpan(text: 'grocer',
                  style: TextStyle(
                    color: CustomColors.customContrastColor,
                  ),
                ),
              ],
            ),
          ),
          actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 15,
            ),
            child: GestureDetector(
                onTap: () {},
                child: AddToCartIcon(
                    badgeOptions: const BadgeOptions(active: false),
                    key: globalKeyCartItems,
                    icon: Badge(
                      backgroundColor: CustomColors.customContrastColor,
                      label: const Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      child: Icon(
                          Icons.shopping_cart,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                    ),
                ),
            ),
        ],
      ),
      // Campo de pesquisa
      body: AddToCartAnimation(
        cartKey: globalKeyCartItems,
        createAddToCartAnimation: (addCartAnimationMethod) {
          runAddToCardAnimation = addCartAnimationMethod;
        },
        jumpAnimation: const JumpAnimationOptions(
          curve: Curves.ease,
          duration: Duration(
            milliseconds: 100,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Pesquise aqui...',
                  helperStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColors.customContrastColor,
                    size: 21,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
            // Categorias
            Container(
              padding: const EdgeInsets.only(left: 10),
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return CategoryTile(
                    onPressed: () {
                      setState((){
                        selectedCategory = appData.categories[index];
                      });
                    },
                    category: appData.categories[index],
                    isSelected: appData.categories[index] == selectedCategory,
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(width: 10),
                itemCount: appData.categories.length,
              ),
            ),

            // Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 9 / 11.5,
                ),
                itemCount: appData.items.length,
                itemBuilder: (_, index) {
                  return ItemTile(
                    item: appData.items[index],
                    cartAnimationMethod: itemSelectedCartAnimations
                  );
                },
              ),
            ),
          ],
        ),
      ),



    );
  }
}
