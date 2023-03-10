import 'package:dt_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dt_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dt_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dt_delivery_app/app/pages/auth/register/register_controller.dart';
import 'package:dt_delivery_app/app/pages/auth/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/base_state/base_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            register: () => showLoader(),
            error: () {
              hideLoader();
              showError('Erro ao registrar usuario');
            },
            success: () {
              hideLoader();
              showSuccess('Cadastro realizado com sucesso');
              Navigator.pop(context);
            });
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    'Preencha os campos abaixopara criar o seu cadastro.',
                    style: context.textStyles.textMedium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameEC,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: Validatorless.required('Nome Obrigat??rio'),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailEC,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('E-mail Obrigat??rio'),
                        Validatorless.email('E-mail inv??lido'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordEC,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Senha Obrigat??ria'),
                        Validatorless.min(6, 'A senha deve conter no minimo 6 caracteres'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confirme sua senha'),
                    obscureText: true,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('?? obrigat??rio que confirme sua senha'),
                        Validatorless.min(6, 'A senha deve conter no minimo 6 caracteres'),
                        Validatorless.compare(_passwordEC, 'As senhas n??o est??o iguais'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: DeliveryButton(
                      onPressed: () {
                        final valid = _formKey.currentState?.validate() ?? false;
                        if (valid) {
                          controller.register(
                            _nameEC.text,
                            _emailEC.text,
                            _passwordEC.text,
                          );
                        }
                      },
                      label: 'Cadastrar',
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
