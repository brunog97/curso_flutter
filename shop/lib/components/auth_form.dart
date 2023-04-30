import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { signUpMode, loginMode }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.loginMode;

  bool get _isLogin => _authMode == AuthMode.loginMode;
  bool get _isSignUp => _authMode == AuthMode.signUpMode;
  bool _obscureText = true;
  bool _isLoading = false;

  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AnimationController? _animationController;
  Animation<Size>? _heightAnimation;

  @override
  void initState() {
    super.initState();
    //_animationController = AnimationController(vsync: 1);
  }

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _toggleObscureText() {
    setState(() => _obscureText = !_obscureText);
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin) {
        _authMode = AuthMode.signUpMode;
      } else {
        _authMode = AuthMode.loginMode;
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Entendi'),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    final isValid =
        _formKey.currentState?.validate() ?? false; //validando o form

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);
    _formKey.currentState?.save();

    //Como to em uma area que não possui conext, eu chamo o listen como false
    //O listen pode ser falso quando eu não quero notificar as mudanças
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin) {
        //Login
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        //Cadastro
        await auth.signUp(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        height: _isLogin ? 320 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (emailField) {
                  final email = emailField ?? '';

                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Informe um e-mail valido';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: InkWell(
                    onTap: _toggleObscureText,
                    child: Icon(
                      _obscureText ? Icons.remove_red_eye : Icons.hide_source,
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                obscureText: _obscureText,
                onSaved: (password) => _authData['password'] = password ?? '',
                controller: _passwordController,
                validator: (passwordField) {
                  final password = passwordField ?? '';

                  if (password.isEmpty || password.length <= 5) {
                    return 'Informe uma senha valida';
                  }

                  return null;
                },
              ),
              if (_isSignUp)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirmar Senha'),
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  validator: _isLogin
                      ? null
                      : (passwordField) {
                          final password = passwordField ?? '';

                          if (_passwordController.text != password) {
                            return 'Senhas informadas não conferem';
                          }

                          return null;
                        },
                ),
              SizedBox(
                height: 20,
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    _authMode == AuthMode.loginMode ? 'ENTRAR' : 'CADASTRE-SE',
                  ),
                ),
              Spacer(),
              TextButton(
                onPressed: _isLoading ? null : _switchAuthMode,
                child: Text(_isLogin ? 'REGISTRE-SE!' : 'JÁ POSSUI UMA CONTA?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
