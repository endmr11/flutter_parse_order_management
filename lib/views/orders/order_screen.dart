import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterlivequery/core/locale/storage.dart';
import 'package:flutterlivequery/core/models/orders_model.dart';
import 'package:flutterlivequery/core/models/products_model.dart';
import 'package:flutterlivequery/views/orders/bloc/order_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderBloc bloc;
  List<OrdersModel>? orders;
  List<ProductsModel>? products;
  bool isLoading = true;
  late StreamSubscription orderSubscription;
  @override
  void initState() {
    super.initState();
    bloc = OrderBloc();
    bloc.add(OrderStartEvent());
    orderSubscription = LocalStorage.parseStream.listen((event) {
      setState(() {
        orders?.insert(
            0,
            OrdersModel(
                id: event['data'][0]['id'],
                prod_id: event['data'][0]['prod_id'],
                customer: event['data'][0]['customer'],
                content: event['data'][0]['content']));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    orderSubscription.cancel();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: BlocProvider(
          create: (context) => OrderBloc(),
          child: BlocListener<OrderBloc, OrderState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is OrderLoadingState) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is OrderLoadedState) {
                setState(() {
                  isLoading = false;
                  orders = state.orders;
                  products = state.products;
                });
              } else if (state is OrderLoadingErrorState) {
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
                        "Orders",
                        style: TextStyle(fontSize: 34),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: orders != null ? orders?.length : 0,
                          itemBuilder: (context, index) {
                            String? productName;
                            for (var p in products!) {
                              if (p.id == orders![index].prod_id) {
                                productName = p.name;
                              }
                            }
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
                                        "Product: $productName",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      ),
                                      subtitle: Text(
                                          "Customer Name: ${orders![index].customer!}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                      trailing: IconButton(
                                          icon: const Icon(
                                            CupertinoIcons.eye,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          onPressed: () {}),
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
