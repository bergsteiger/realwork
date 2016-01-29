unit k2DictRec_Wrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2DictRec_Wrap.pas"
// Начат: 07.09.1998 12:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Wrapper::Class>> Shared Delphi::K2::Standard::Wk2DictRec
//
// Обёртка для словарных записей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  Persistent_Wrap,
  l3Variant
  ;

type
 Wk2DictRec = class(WPersistent)
  {* Обёртка для словарных записей }
 protected
 // overridden protected methods
   function StrToTag(const aValue: AnsiString): Tl3Tag; override;
 end;//Wk2DictRec

implementation

uses
  k2DictRec,
  k2Tags,
  l3CustomString,
  k2Dictionary,
  k2Base
  ;

// start class Wk2DictRec

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