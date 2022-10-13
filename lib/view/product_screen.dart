import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_bloc/bloc/product_bloc/product_bloc.dart';
import 'package:sqflite_bloc/bloc/product_bloc/product_event.dart';
import 'package:sqflite_bloc/bloc/product_bloc/product_state.dart';
import 'package:sqflite_bloc/utils/ui_utils.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.indigoAccent,
      title: const Text(
        'Shopping Page',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is GetProductInitialState) {
            UiUtils.showSnackbar(context, 'Get product initial state');
          } else if (state is GetProductLoadingState) {
            UiUtils.showSnackbar(context, 'Get product loading state');
          } else if (state is GetProductSuccessState) {
            UiUtils.showSnackbar(context, 'Get product success state');
          } else if (state is GetProductFailureState) {
            UiUtils.showSnackbar(context, state.error ?? "");
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is GetProductFailureState) {
              return Center(
                child: Text(state.error ?? ""),
              );
            } else if (state is GetProductLoadingState ||
                state is GetProductInitialState) {
              return Center(child: CircularProgressIndicator());
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.7 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: state.product!.products!.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            child: Container(
                                height: 100,
                                width: double.infinity,
                                color: Colors.blue,
                                child: state.product?.products?[index].images !=
                                        null
                                    ? Image.network(
                                        state.product!.products![index]
                                            .images![0],
                                        fit: BoxFit.fill,
                                      )
                                    : SizedBox.shrink()),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 15, left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    state.product?.products?[index].title ?? "",
                                    style: TextStyle(fontSize: 16),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
