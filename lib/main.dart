import 'package:fiisplan2/telas/tela_abertura.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Para chamar Firebase.initializeApp()
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Força português independente o idioma do smartphone
      // Deixei essa linha apenas para mostrar, num aplicativo a ser
      // disponibilizado no AppStore, ela deve ser retirada
      locale: Locale('pt', 'BR'),  // Current locale
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('pt', 'BR'), // Brasil
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Definindo padrão para a AppBar
        appBarTheme: AppBarTheme(
          // Cor de fundo da AppBar
          backgroundColor: Colors.green,
          // Cor do texto e ícones da AppBar
          foregroundColor: Colors.white
        ),
        // Definindo padrão para o Drawer
        drawerTheme: DrawerThemeData(
          // Cor de fundo do Drawer
          backgroundColor: Colors.white,
        ),
        // Definindo padrao para FloatingActionButton
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          // Cor do texto do floatingActionButton
          foregroundColor: Colors.white,
          // Cor de fundo do floatingActionButton
          backgroundColor: Colors.green,
          // Botão circular
          shape: CircleBorder(),
        ),
        // Definindo padrão para ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
          )
        ),
        // Definindo padrào para TabBar
        tabBarTheme: TabBarTheme(
          // Cor da Tab selecionada
          labelColor: Colors.white,
          // Cor de Tab não selecionada
          unselectedLabelColor: Colors.white
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green,
        ),
        // Define o tema para claro ou escuro
        brightness: Brightness.light,
        // Define a cor de fundo padrão para Containers
        scaffoldBackgroundColor: Colors.white,
      ),
      home: TelaAbertura(),
    );
  }
}
