unit m3RootStreamNew;

// Модуль: "w:\common\components\rtl\Garant\m3\m3RootStreamNew.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3RootStreamNew" MUID: (54086C1B011D)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3RootStream
 , ActiveX
;

type
 Tm3RootStreamNew = class(Tm3RootStream)
  protected
   class function NeedHeaderAlignment: Boolean; override;
  public
   class function HeaderID: TCLSID; override;
 end;//Tm3RootStreamNew

implementation

uses
 l3ImplUses
 //#UC START# *54086C1B011Dimpl_uses*
 //#UC END# *54086C1B011Dimpl_uses*
;

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
