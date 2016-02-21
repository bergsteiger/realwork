unit m3LZOInflateStreamNew;

// Модуль: "w:\common\components\rtl\Garant\m3\m3LZOInflateStreamNew.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3ArcCla
 , ActiveX
;

type
 Tm3LZOInflateStreamNew = class(Tm3LZOInflateStream)
  protected
   class function NeedHeaderAlignment: Boolean; override;
  public
   class function HeaderID: TCLSID; override;
 end;//Tm3LZOInflateStreamNew

implementation

uses
 l3ImplUses
 , m3LZODeflateStreamNew
;

class function Tm3LZOInflateStreamNew.HeaderID: TCLSID;
//#UC START# *53FDFAF900ED_542AA48C0354_var*
//#UC END# *53FDFAF900ED_542AA48C0354_var*
begin
//#UC START# *53FDFAF900ED_542AA48C0354_impl*
 Result := Tm3LZODeflateStreamNew.HeaderID;
//#UC END# *53FDFAF900ED_542AA48C0354_impl*
end;//Tm3LZOInflateStreamNew.HeaderID

class function Tm3LZOInflateStreamNew.NeedHeaderAlignment: Boolean;
//#UC START# *5408826C0072_542AA48C0354_var*
//#UC END# *5408826C0072_542AA48C0354_var*
begin
//#UC START# *5408826C0072_542AA48C0354_impl*
 Result := false;
//#UC END# *5408826C0072_542AA48C0354_impl*
end;//Tm3LZOInflateStreamNew.NeedHeaderAlignment

end.
