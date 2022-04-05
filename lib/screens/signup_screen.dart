import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ride_guia/helpers/validators.dart';
import 'package:ride_guia/model/guia.dart';
import 'package:ride_guia/model/guia_manager.dart';
import 'package:ride_guia/screens/home_page.dart';
import 'package:ride_guia/utils/colors.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Guia guia = Guia();

  final cName = TextEditingController();
  final cCategoria = TextEditingController();
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();
  final cConfirmPassword = TextEditingController();
  final cCpf = TextEditingController();
  final cTelefone = TextEditingController();
  final cCep = TextEditingController();
  final cRua = TextEditingController();
  final cBairro = TextEditingController();
  final cCidade = TextEditingController();
  final cEstado = TextEditingController();

  createGuia() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Obrigado por se cadastrar! "),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
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
                    TextFormField(
                      controller: cName,
                      validator: (name) {
                        if (name!.isEmpty) {
                          return "Nome está em branco";
                        } else if (name.trim().split(' ').length <= 1) {
                          return "Prencha seu nome completo";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Nome Completo",
                        hintText: "Digite seu nome completo",
                      ),
                      enabled: !guiaManager.loading,
                    ),
                    TextFormField(
                      controller: cCategoria,
                      validator: (categoria) {
                        if (categoria!.isEmpty) {
                          return "Nome está em branco";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Serviço prestado",
                        hintText: "Digite o tipo de passeio",
                      ),
                      enabled: !guiaManager.loading,
                    ),
                    //
                    TextFormField(
                      controller: cEmail,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Campo obrigatório";
                        } else if (!emailValid(email)) {
                          return "Email inválido";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        hintText: "Digite seu email",
                      ),
                      enabled: !guiaManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      keyboardAppearance: Brightness.light,
                    ),
                    TextFormField(
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '###.###.###-##')
                      ],
                      decoration: const InputDecoration(
                        labelText: "CPF",
                        hintText: "000.000.000-00",
                      ),
                      controller: cCpf,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "CPF está em branco";
                        }
                        return null;
                      },
                      enabled: !guiaManager.loading,
                    ),
                    TextFormField(
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '(##) # ####-####')
                      ],
                      decoration: const InputDecoration(
                        labelText: "Telefone",
                        hintText: "(00) 0 0000-0000",
                      ),
                      controller: cTelefone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Telefone está em branco";
                        }
                        return null;
                      },
                      enabled: !guiaManager.loading,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Cep",
                        hintText: "Digite seu CEP",
                      ),
                      controller: cCep,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "CEP está em branco";
                        }
                        return null;
                      },
                      enabled: !guiaManager.loading,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Rua",
                        hintText: "Digite o nome da sua rua",
                      ),
                      controller: cRua,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Rua está em branco";
                        }
                        return null;
                      },
                      enabled: !guiaManager.loading,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Bairro",
                        hintText: "Digite o nome do seu bairro",
                      ),
                      controller: cBairro,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Bairro está em branco";
                        }
                        return null;
                      },
                      enabled: !guiaManager.loading,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Cidade",
                      ),
                      controller: cCidade,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Cidade está em branco";
                        }
                        return null;
                      },
                      enabled: !guiaManager.loading,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Estado",
                      ),
                      controller: cEstado,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Estado está em branco";
                        }
                        return null;
                      },
                      enabled: !guiaManager.loading,
                    ),
                    TextFormField(
                      controller: cPassword,
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return "Senha está em branco";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Senha",
                        hintText: "Digite sua senha",
                      ),
                      enabled: !guiaManager.loading,
                      obscureText: true,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Confirmar senha",
                          hintText: "Digite sua senha novamente"),
                      controller: cConfirmPassword,
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return "Campo obrigatório de confirmação";
                        }
                        return null;
                      },
                      obscureText: true,
                      enabled: !guiaManager.loading,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: guiaManager.loading
                            ? darkColor.withAlpha(100)
                            : darkColor,
                        fixedSize: const Size(250, 50),
                      ),
                      onPressed: guiaManager.loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                if (cPassword.text != cConfirmPassword.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Senhas não coincidem'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                guiaManager.signUP(
                                    client: Guia(
                                        name: cName.text,
                                        categoria: cCategoria.text,
                                        email: cEmail.text,
                                        password: cPassword.text),
                                    onFail: (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Falha ao cadastrar: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                    onSuccess: () {
                                      createGuia();
                                    });
                              }
                            },
                      child: guiaManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text(
                              "CADASTRAR",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
