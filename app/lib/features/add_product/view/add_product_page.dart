import 'dart:io';

import 'package:app/features/add_product/cubit/add_product_cubit.dart';
import 'package:common_ui/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddProductView();
  }
}

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    // We use read because state is used only to show immutable field like,
    // name, brand, ecc.
    final state = context.read<AddProductCubit>().state;
    return Scaffold(
      appBar: AppBar(
        // FIXME: l10n
        title: const Text('Aggiungi prodotto'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  state.imageFrontSmallUrl!,
                  width: 100,
                  height: 100,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.name),
                      Text(state.brand ?? '---'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const _ExpiryDateTextField(),
            const _QuantityTextField(),
            const _LocationTextField(),
            const SizedBox(height: 20),
            const _SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _ExpiryDateTextField extends StatefulWidget {
  const _ExpiryDateTextField();

  @override
  State<_ExpiryDateTextField> createState() => __ExpiryDateTextFieldState();
}

class __ExpiryDateTextFieldState extends State<_ExpiryDateTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final initialDate = context.read<AddProductCubit>().state.expiryDate;
    _controller = TextEditingController(
      text: initialDate?.toString(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductCubit, AddProductState>(
      listenWhen: (prev, current) => prev.expiryDate != current.expiryDate,
      listener: (context, state) {
        if (state.expiryDate != null) {
          _controller.text = DateTimeFormatter.it()
              .prettyDateWithDay
              .format(state.expiryDate!);
        }
      },
      child: TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.calendar_month_rounded),
          hintText: 'Inserisci la data di scadenza',
        ),
        onTap: () async {
          DateTime? date;
          final cubit = context.read<AddProductCubit>();
          if (Platform.isIOS) {
            date = await DateTimePicker.iOSPickDateTime(
              context: context,
              initialDate: DateTime.now(),
              minDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
            );
          } else {
            date = await DateTimePicker.androidPickDate(
              context: context,
              initialDate: DateTime.now(),
              minDateTime: DateTime.now(),
            );
          }
          if (date != null) {
            cubit.onDateTimeChanged(date);
          }
        },
      ),
    );
  }
}

class _QuantityTextField extends StatelessWidget {
  const _QuantityTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.numbers_rounded),
        hintText: 'Numero di prodotti',
      ),
      onTap: () {
        // show cupertino selections
      },
    );
  }
}

class _LocationTextField extends StatelessWidget {
  const _LocationTextField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddProductCubit, AddProductState, String?>(
      selector: (state) {
        return state.location;
      },
      builder: (context, location) {
        return TextFormField(
          initialValue: location,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.home_rounded),
            hintText: 'Dove lo riponi?',
          ),
          onChanged: (value) {
            context.read<AddProductCubit>().onLocationChanged(value);
          },
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AddProductCubit>().add();
      },
      child: const Text('Aggiungi'),
    );
  }
}
