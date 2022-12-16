import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yabalash_mobile_app/core/constants/app_layouts.dart';
import 'package:yabalash_mobile_app/features/addresses/presentation/widgets/update_address_body.dart';

import '../../../../core/widgets/ya_balash_custom_button.dart';
import '../../domain/entities/address.dart';
import '../blocs/cubit/update_address_cubit.dart';

final _formKey = GlobalKey<FormBuilderState>();

class UpdateAddress extends StatelessWidget {
  final bool isfromEdit;
  final Address? address;
  const UpdateAddress({super.key, required this.isfromEdit, this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpdateAddressBody(
        isFromEdit: isfromEdit,
        formkey: _formKey,
        address: address,
      ),
      bottomNavigationBar: Container(
        padding: kDefaultPadding,
        height: 70.h,
        child: BlocBuilder<UpdateAddressCubit, UpdateAddressState>(
          builder: (context, state) {
            return YaBalashCustomButton(
              isDisabled: isfromEdit ? false : state.isButtonDisabled,
              onTap: () {
                if (!state.isButtonDisabled!) {
                  if (_formKey.currentState!.validate()) {}
                }
              },
              child: const Text('حفظ العنوان'),
            );
          },
        ),
      ),
    );
  }
}
