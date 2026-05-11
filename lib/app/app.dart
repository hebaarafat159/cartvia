import 'package:cartvia_project/data/api_service.dart';
import 'package:cartvia_project/data/repositories/shopping_list_repository.dart';
import 'package:cartvia_project/viewmodels/home_view_model.dart';
import 'package:cartvia_project/viewmodels/shopping_list_view_model.dart';
import 'package:cartvia_project/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        ProxyProvider<ApiService, ShoppingListRepository>(
          update: (_, apiService, __) =>
              ShoppingListRepository(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (context) => ShoppingListViewModel(
            repository: context.read<ShoppingListRepository>(),
          )..loadShoppingList(),
        ),
        Provider(create: (_) => const HomeViewModel()),
      ],
      child: MaterialApp(
        title: 'CartVia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 244, 122, 40)),
          useMaterial3: true,
        ),
        home: const MyHome(),
      ),
    );
  }
}
