unit m3LZODeflateStreamNew;

// Модуль: "w:\common\components\rtl\Garant\m3\m3LZODeflateStreamNew.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3ArcCla
 , ActiveX
;

type
 Tm3LZODeflateStreamNew = class(Tm3LZODeflateStream)
  protected
   class function NeedHeaderAlignment: Boolean; override;
  public
   class function HeaderID: TCLSID; override;
 end;//Tm3LZODeflateStreamNew

implementation

uses
 l3ImplUses
;

class function Tm3LZODeflateStreamNew.HeaderID: TCLSID;
//#UC START# *53FDFAF900ED_542AA47B0241_var*
const
 cID : TGUID = '{93A7EBCE-9A80-4727-B8FD-8CABA46FE5B6}';
//#UC END# *53FDFAF900ED_542AA47B0241_var*
begin
//#UC START# *53FDFAF900ED_542AA47B0241_impl*
 Result := cID;
//#UC END# *53FDFAF900ED_542AA47B0241_impl*
end;//Tm3LZODeflateStreamNew.HeaderID

class function Tm3LZODeflateStreamNew.NeedHeaderAlignment: Boolean;
//#UC START# *5408826C0072_542AA47B0241_var*
//#UC END# *5408826C0072_542AA47B0241_var*
begin
//#UC START# *5408826C0072_542AA47B0241_impl*
 Result := false;
//#UC END# *5408826C0072_542AA47B0241_impl*
end;//Tm3LZODeflateStreamNew.NeedHeaderAlignment

end.
