import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hortifrute/src/pages/common_widgets/app_name_widget.dart';
import '../../config/custom_colors.dart';
import '../../pages_routes/app_pages.dart';
import '../common_widgets/custom_text_field.dart';
import 'controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  //Comtrolador de campos
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Nome do app
                    const AppNameWidget(
                      greenTitleColor: Colors.white,
                      textSize: 40,
                    ),
                    // Categorias
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Frutas'),
                            FadeAnimatedText('Verduras'),
                            FadeAnimatedText('Legumes'),
                            FadeAnimatedText('Carnes'),
                            FadeAnimatedText('Cereais'),
                            FadeAnimatedText('Laticíneos'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Formulário
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // E-mail
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'E-Mail',
                        validator: (email){
                          if(email == null || email.isEmpty) return 'Digite seu email!';
                          if(!email.isEmail) return 'Digite um email válido';
                          return null;
                        },
                      ),
                
                      //Senha
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: (password){
                          if(password == null || password.isEmpty) {
                            return 'Digite sua senha!';
                          }
                          if(password.length < 7) {
                            return 'Digite uma senha com pelo menos 7 caracteres.';
                          }
                          return null;
                        },
                      ),
                
                      // Botão de entrar
                      SizedBox(
                        height: 50,
                        child: GetX<AuthController>(
                          builder: (authcontroller) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                          onPressed:
                            authcontroller.isLoading.value 
                            ? null 
                            : () {
                              FocusScope.of(context).unfocus();
                              if(_formKey.currentState!.validate()){
                               String email = emailController.text;
                                String password = passwordController.text;

                                authcontroller.signIn(email: email, password: password);
                              }else{
                                print('Campos não válidos!');
                              }
                            //Get.offNamed(PagesRoutes.baseRoute);
                            },
                          child: authcontroller.isLoading.value 
                            ? const CircularProgressIndicator() 
                            : const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }
                        ),
                      ),
                
                      // Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){},
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          ),
                        ),
                      ),
                
                      // Divisor
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                
                      //Botão de novo usuário
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            side: const BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                          onPressed: (){
                            Get.toNamed(PagesRoutes.signUpRoute);
                          },
                          child: const Text('Criar conta',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
