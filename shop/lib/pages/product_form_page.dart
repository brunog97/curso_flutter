import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save(); // chama os onSaved

    setState(() => _isLoading = true);
    try {
      final navigator = Navigator.of(context);
      await Provider.of<ProductList>(context, listen: false)
          .saveProduct(_formData);

      navigator.pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Ops. Ocorreu um erro!'),
          content: Text(
              'Não foi possível salvar o produto, tente novamente mais tarde!\n\nPersistindo contate o suporte.'),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.purple),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Entendi',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
            tooltip: 'Salvar produto',
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                      strokeWidth: 12,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Cadastrando o produto...')
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']
                          ?.toString(), //só chama o toString() caso possua valor
                      validator: (nameForm) {
                        final name = nameForm ?? '';
                        if (name.trim().isEmpty) {
                          return 'O nome não pode ficar em branco.';
                        } else if (name.trim().length <= 3) {
                          return 'O nome é muito pequeno.';
                        }

                        return null;
                      },
                      onSaved: (name) => _formData['name'] = name ?? '',
                      decoration: InputDecoration(labelText: 'Nome'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_priceFocus),
                    ),
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      validator: (priceForm) {
                        final priceValue = priceForm ?? '';
                        final price = double.tryParse(priceValue) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço válido';
                        }

                        return null;
                      },
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                      decoration: InputDecoration(labelText: 'Preço'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_descriptionFocus),
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      validator: (descriptionForm) {
                        final description = descriptionForm ?? '';
                        if (description.trim().isEmpty) {
                          return 'A descrição não pode ficar em branco.';
                        } else if (description.trim().length <= 3) {
                          return 'A descrição é muito pequeno.';
                        }

                        return null;
                      },
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      decoration: InputDecoration(labelText: 'Descrição'),
                      //textInputAction: TextInputAction.next,
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_imageUrlFocus),
                      maxLines: 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (imageUrlForm) {
                              final imageUrl = imageUrlForm ?? '';
                              if (!isValidImageUrl(imageUrl)) {
                                return 'A URL informada não é valida';
                              }

                              return null;
                            },
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = imageUrl ?? '',
                            decoration:
                                InputDecoration(labelText: 'Url da Imagem'),
                            //textInputAction: TextInputAction.next,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            keyboardType: TextInputType.url,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => _submitForm(),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? Text(
                                  'Informe a url',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              : !isValidImageUrl(_imageUrlController.text)
                                  ? Text(
                                      'URL INVALIDA',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    )
                                  : Image.network(
                                      _imageUrlController.text,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
