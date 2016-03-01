unit k2DictRec_Wrap;
 {* Обёртка для словарных записей }

// Модуль: "w:\common\components\rtl\Garant\K2\k2DictRec_Wrap.pas"
// Стереотип: "Wrapper"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , Persistent_Wrap
 , l3Variant
;

type
 Wk2DictRec = class(WPersistent)
  {* Обёртка для словарных записей }
  protected
   function StrToTag(const aValue: AnsiString): Tl3Tag; override;
 end;//Wk2DictRec

implementation

uses
 l3ImplUses
 , k2DictRec
 , k2Tags
 , l3CustomString
 , k2Dictionary
 , k2Base
;

function Wk2DictRec.StrToTag(const aValue: AnsiString): Tl3Tag;
//#UC START# *484CCEBC00DC_484D10530133_var*
var
 VT : Tk2Dictionary;
 ST : Tl3Variant;
//#UC END# *484CCEBC00DC_484D10530133_var*
begin
//#UC START# *484CCEBC00DC_484D10530133_impl*
 VT := AtomType.ValueTable;
 if (VT <> nil) then begin
  ST := VT.DRByName[aValue];
  if (ST <> nil) then
  begin
   Result := St;
   Exit;
  end;//ST <> nil
 end;{VT <> nil}
 Result := inherited StrToTag(aValue);
//#UC END# *484CCEBC00DC_484D10530133_impl*
end;//Wk2DictRec.StrToTag

end.
