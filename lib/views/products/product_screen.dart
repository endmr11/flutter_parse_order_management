import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterlivequery/core/models/orders_model.dart';
import 'package:flutterlivequery/core/models/products_model.dart';
import 'package:flutterlivequery/views/products/bloc/product_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductBloc bloc;
  List<ProductsModel>? products;
  bool isLoading = true;
  TextEditingController cstmrName = TextEditingController();
  TextEditingController cstmrAddress = TextEditingController();
  @override
  void initState() {
    super.initState();
    bloc = ProductBloc();
    bloc.add(ProductStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: BlocProvider(
          create: (context) => ProductBloc(),
          child: BlocListener<ProductBloc, ProductState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is ProductLoadingState) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is ProductLoadedState) {
                setState(() {
                  isLoading = false;
                  products = state.products;
                });
              } else if (state is ProductLoadingErrorState) {
                openErrorDialog("Loading Error");
              }
            },
            child: isLoading
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Column(
                    children: [
                      const Text(
                        "Products",
                        style: TextStyle(fontSize: 34),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: products != null ? products?.length : 0,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                color: Colors.blueGrey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    color: Colors.blueGrey,
                                    child: ListTile(
                                      title: Text(
                                        products![index].name!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      ),
                                      leading: Text(
                                        products![index].price.toString() +
                                            " \$",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          CupertinoIcons.cart,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        onPressed: () => openOrderDialog(
                                            products![index].id!,
                                            products![index].name!),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void openOrderDialog(int productId, String name) => showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('Order: $name'),
          content: Column(
            children: [
              const Text(
                "Please enter the information completely.",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 15,
              ),
              CupertinoTextField(
                placeholder: "Customer Name",
                placeholderStyle: const TextStyle(color: Colors.black),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                decoration: const BoxDecoration(color: Colors.white,),
                controller: cstmrName,
                style:const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 15,
              ),
              CupertinoTextField(
                placeholder: "Customer Address",
                placeholderStyle: const TextStyle(color: Colors.black),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                decoration: const BoxDecoration(color: Colors.white),
                controller: cstmrAddress,
                style:const TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('Order'),
              onPressed: () {
                bloc.add(ProductOrderEvent({"prod_id": productId,"customer": cstmrName.text,"content": cstmrAddress.text}));
                Navigator.pop(context);
              },
            )
          ],
        ),
      );

  void openErrorDialog(String err) => showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Alert'),
          content: Text(err),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('OK'),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
}
