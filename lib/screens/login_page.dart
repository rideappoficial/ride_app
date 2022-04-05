import 'package:flutter/material.dart';
import 'package:ride_guia/helpers/validators.dart';
import 'package:ride_guia/model/guia.dart';
import 'package:ride_guia/model/guia_manager.dart';
import 'package:ride_guia/screens/home_page.dart';
import 'package:ride_guia/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cEmail = TextEditingController();
  final cSenha = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  loginGuia() {
    if (cEmail.text.isNotEmpty && cSenha.text.isNotEmpty) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Seja bem vindo " + cEmail.text),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    child: const Text("Entrar"),
                  ),
                ],
              ));
    } else {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Senha incorreta ou em branco"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Voltar",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Consumer<GuiaManager>(
                builder: (_, guiaManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("images/logoGuia.png"),
                        )),
                      ),
                      TextFormField(
                        controller: cEmail,
                        enabled: !guiaManager.loading,
                        decoration: const InputDecoration(
                          hintText: "Digite seu email",
                          labelText: "E-mail:",
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (value) {
                          if (!emailValid(value!)) {
                            return "Email inválido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: cSenha,
                        enabled: !guiaManager.loading,
                        decoration: const InputDecoration(
                          labelText: "Senha",
                          hintText: "Digite sua senha",
                          prefixIcon: Icon(
                            Icons.password,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        autocorrect: false,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 8) {
                            return "Senha inválida";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: guiaManager.loading
                                ? darkColor.withAlpha(100)
                                : darkColor),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            guiaManager.signIn(
                                client: Guia(
                                    email: cEmail.text, password: cSenha.text),
                                onFail: (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Falha ao entrar: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                                onSuccess: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
                                });
                          }
                        },
                        child: guiaManager.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Ainda não tem conta?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()),
                              );
                            },
                            child: const Text(
                              "CADASTRE-SE",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
