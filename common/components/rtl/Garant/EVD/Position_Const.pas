unit Position_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Position_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::Position
//
// Позиция в тексте
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Position - "Позиция в тексте".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_typPosition: PositionAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Position : PositionAtom = nil;

// start class PositionAtom

function k2_typPosition: PositionAtom;
begin
 if (g_Position = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Position := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Position;
 end;//g_Position = nil
 Result := g_Position;
end;

end.