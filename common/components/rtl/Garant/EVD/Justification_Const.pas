unit Justification_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Justification_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::Justification
//
// Выравнивание текста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Justification - "Выравнивание текста".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_typJustification: JustificationAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Justification : JustificationAtom = nil;

// start class JustificationAtom

function k2_typJustification: JustificationAtom;
begin
 if (g_Justification = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Justification := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Justification;
 end;//g_Justification = nil
 Result := g_Justification;
end;

end.