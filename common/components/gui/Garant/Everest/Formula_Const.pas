unit Formula_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Formula_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Formula
//
// Формула
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Formula - "Формула".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idFormula = 110;

function k2_typFormula: FormulaTag;

//#UC START# *4857926501CBconst_intf*
//#UC END# *4857926501CBconst_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Formula : FormulaTag = nil;

// start class FormulaTag

function k2_typFormula: FormulaTag;
begin
 if (g_Formula = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Formula := TevNativeSchema(Tk2TypeTable.GetInstance).t_Formula;
 end;//g_Formula = nil
 Result := g_Formula;
end;

end.