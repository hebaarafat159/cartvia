import 'package:cartvia_project/data/api_service.dart';
import 'package:cartvia_project/data/repositories/shopping_list_repository.dart';
import 'package:cartvia_project/l10n/app_localizations.dart';
import 'package:cartvia_project/theme/tokens/app_colors.dart';
import 'package:cartvia_project/viewmodels/products_view_model.dart';
import 'package:cartvia_project/viewmodels/shopping_list_view_model.dart';
import 'package:cartvia_project/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static MyAppState of(BuildContext context) {
    final state = context.findAncestorStateOfType<MyAppState>();
    assert(state != null, 'MyApp state not found in context.');
    return state!;
  }

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale? _locale;

  Locale? get locale => _locale;

  void toggleLocale() {
    setState(() {
      if (_locale?.languageCode == 'ar') {
        _locale = const Locale('en');
      } else {
        _locale = const Locale('ar');
      }
    });
  }

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
        ChangeNotifierProxyProvider<ShoppingListViewModel, ProductsViewModel>(
          create: (_) => ProductsViewModel(),
          update: (_, shoppingListViewModel, productsViewModel) =>
              (productsViewModel ?? ProductsViewModel())
                ..updateShoppingLists(shoppingListViewModel.shoppingList),
        ),
      ],
      child: MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
          useMaterial3: true,
        ),
        home: const MyHome(),
      ),
    );
  }
}
