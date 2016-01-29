unit m3RootStreamNew;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3RootStreamNew.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3RootStreamNew
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3RootStream,
  ActiveX
  ;

type
 Tm3RootStreamNew = class(Tm3RootStream)
 protected
 // overridden protected methods
   class function NeedHeaderAlignment: Boolean; override;
 public
 // overridden public methods
   class function HeaderID: TCLSID; override;
 end;//Tm3RootStreamNew

implementation

// start class Tm3RootStreamNew

class function Tm3RootStreamNew.HeaderID: TCLSID;
//#UC START# *53FDFAF900ED_54086C1B011D_var*
const
 cHeaderID : TCLSID = '{30E5059C-8A5A-493D-827C-BF8E0BCFE940}';
//#UC END# *53FDFAF900ED_54086C1B011D_var*
begin
//#UC START# *53FDFAF900ED_54086C1B011D_impl*
 Result := cHeaderID;
//#UC END# *53FDFAF900ED_54086C1B011D_impl*
end;//Tm3RootStreamNew.HeaderID

class function Tm3RootStreamNew.NeedHeaderAlignment: Boolean;
//#UC START# *5408826C0072_54086C1B011D_var*
//#UC END# *5408826C0072_54086C1B011D_var*
begin
//#UC START# *5408826C0072_54086C1B011D_impl*
 Result := false;
//#UC END# *5408826C0072_54086C1B011D_impl*
end;//Tm3RootStreamNew.NeedHeaderAlignment

end.