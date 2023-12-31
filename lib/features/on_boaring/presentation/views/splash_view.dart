import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yabalash_mobile_app/features/on_boaring/presentation/blocs/cubit/splash_cubit.dart';

import '../../../cart/presentation/blocs/cubit/cart_cubit.dart';
import '../widgets/spalsh_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return const SplashBody();
            },
          );
        },
      ),
    );
  }
}
