
import 'package:fiisplan2/controle/patrimonio_control.dart';
import 'package:fiisplan2/controle/usuario_control.dart';
import 'package:fiisplan2/controle/venda_control.dart';

import 'compra_control.dart';
import 'dividendo_control.dart';
import 'fundo_imobiliario_control.dart';
import 'imposto_control.dart';

class FabricaControladora {
  static final UsuarioControl _usuarioControl = UsuarioControl();
  static final PatrimonioControl _patrimonioControl = PatrimonioControl();
  static final FundoImobiliarioControl _fundoImobiliarioControl = FundoImobiliarioControl();
  static final CompraControl _compraControl = CompraControl();
  static final VendaControl _vendaControl = VendaControl();
  static final ImpostoControl _impostoControl = ImpostoControl();
  static final DividendoControl _dividendoControl = DividendoControl();


  static UsuarioControl obterUsuarioControl(){
    return _usuarioControl;
  }

  static PatrimonioControl obterPatrimonioControl(){
    return _patrimonioControl;
  }

  static FundoImobiliarioControl obterFundoImobiliarioControl(){
    return _fundoImobiliarioControl;
  }

  static CompraControl obterCompraControl(){
    return _compraControl;
  }

  static VendaControl obterVendaControl(){
    return _vendaControl;
  }

  static DividendoControl obterDividendoControl(){
    return _dividendoControl;
  }

  static ImpostoControl obterImpostoControl(){
    return _impostoControl;
  }
}