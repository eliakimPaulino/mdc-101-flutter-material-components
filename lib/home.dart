// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/products_repository.dart';
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, this.category = Category.all}) : super(key: key);
  final Category category;

  List<Card> _buildGridCards(context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 13 / 11,
              child: Image.asset(
                product.assetName,
                fit: BoxFit.fitWidth,
                package: product.assetPackage,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: theme.textTheme.button,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AsymmetricView(
      products: ProductsRepository.loadProducts(category),
    );
    // Scaffold(
    //   appBar: AppBar(
    //     elevation: 0,
    //     title: const Text('SHRINE'),
    //     actions: <Widget>[
    //       IconButton(
    //         icon: const Icon(
    //           Icons.search,
    //           semanticLabel: 'search',
    //         ),
    //         onPressed: () {
    //           debugPrint('Search button');
    //         },
    //       ),
    //       IconButton(
    //         icon: const Icon(
    //           Icons.add_shopping_cart_rounded,
    //           semanticLabel: 'filter',
    //         ),
    //         onPressed: () {
    //           debugPrint('Filter button');
    //         },
    //       ),
    //     ],
    //     leading: IconButton(
    //       icon: const Icon(
    //         Icons.menu,
    //         semanticLabel: 'menu',
    //       ),
    //       onPressed: () {
    //         debugPrint('Menu button');
    //       },
    //     ),
    //   ),
    //   body:
    //   // AsymmetricView(
    //   //   products: ProductsRepository.loadProducts(Category.all),
    //   // ),
    //   GridView.count(
    //     crossAxisCount: 2,
    //     padding: const EdgeInsets.all(16.0),
    //     childAspectRatio: 8.0 / 9.0,
    //     children: _buildGridCards(context),
    //   ),
    //   resizeToAvoidBottomInset: false,
    // );
  }
}
