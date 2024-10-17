import 'package:ecommerce/core/routes/routes.dart';
import 'package:flutter/material.dart';
import '../../feature/auth/presentation/screens/login_screen.dart';
import '../../feature/auth/presentation/screens/register_screen.dart';
import '../../feature/cart/presentation/screens/cart_screen.dart';
import '../../feature/home/presentation/screens/home_screen.dart';
import '../../feature/products/presentation/screens/product_details.dart';
import '../../feature/products/presentation/screens/products_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.products:
        return MaterialPageRoute(builder: (_) => const ProductsScreen());
      case Routes.productDetails:
        return MaterialPageRoute(builder: (_) => const ProductDetails());
      case Routes.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}