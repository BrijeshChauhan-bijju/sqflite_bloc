import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_bloc/bloc/locale_bloc/locale_bloc.dart';
import 'package:sqflite_bloc/bloc/locale_bloc/locale_event.dart';
import 'package:sqflite_bloc/bloc/product_bloc/product_bloc.dart';
import 'package:sqflite_bloc/bloc/product_bloc/product_event.dart';
import 'package:sqflite_bloc/bloc/product_bloc/product_state.dart';
import 'package:sqflite_bloc/bloc/remote_database_bloc/remote_database_bloc.dart';
import 'package:sqflite_bloc/bloc/remote_database_bloc/remote_database_event.dart';
import 'package:sqflite_bloc/bloc/remote_database_bloc/remote_database_state.dart';
import 'package:sqflite_bloc/constants/app_constants.dart';
import 'package:sqflite_bloc/generated/l10n.dart';
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
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.indigoAccent,
      title: Text(
        S.of(context).shoppingPage,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        AppConstants.LANGUAGE_KEY == AppConstants.LOCALE_EN
            ? InkWell(
                onTap: () {
                  throw Exception();
                  /*    AppConstants.LANGUAGE_KEY = AppConstants.LOCALE_HI;
                  context.read<LocaleBloc>().add(ChangeLocaleEvent(
                        locale: Locale(AppConstants.LOCALE_HI),
                      ));*/
                },
                child: Center(
                  child: Text(
                    S.of(context).hindi,
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  AppConstants.LANGUAGE_KEY = AppConstants.LOCALE_EN;
                  context.read<LocaleBloc>().add(ChangeLocaleEvent(
                        locale: Locale(AppConstants.LOCALE_EN),
                      ));
                },
                child: Center(
                    child: Text(
                  S.of(context).english,
                ))),
        Padding(
          padding: EdgeInsetsDirectional.only(end: 10),
        )
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      child: BlocListener<RemoteDatabaseBloc, RemoteDatabaseState>(
          listener: (context, state) {
           if (state is AddProductToRemoteLoadingCart) {
            } else if (state is AddProductToRemoteSuccessCart) {
              UiUtils.showSnackbar(
                  context, state.message);
            } else if (state is AddProductToFailueCart) {
              UiUtils.showSnackbar(context, state.error ?? "");
            }
          },
          child: BlocListener<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is GetProductInitialState) {
                UiUtils.showSnackbar(
                  context,
                  S.of(context).getProductInitialState,
                );
              } else if (state is GetProductLoadingState) {
                UiUtils.showSnackbar(
                    context, S.of(context).getProductLoadingState);
              } else if (state is GetProductSuccessState) {
                UiUtils.showSnackbar(
                    context, S.of(context).getProductSuccessState);
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
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.7 / 1.7,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
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
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    color: Colors.blue,
                                    child: state.product?.products?[index]
                                                .images !=
                                            null
                                        ? Image.network(
                                            state.product!.products![index]
                                                .images![0],
                                            fit: BoxFit.fill,
                                          )
                                        : const SizedBox.shrink()),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.product?.products?[index].title ??
                                            "",
                                        style: const TextStyle(fontSize: 16),
                                        maxLines: 2,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<RemoteDatabaseBloc>()
                                              .add(AddProductToRemoteCartEvent(
                                                  state.product!
                                                      .products![index]));
                                        },
                                        icon: const Icon(
                                          Icons.add_shopping_cart_outlined,
                                        ))
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
          )),
    );
  }
}
