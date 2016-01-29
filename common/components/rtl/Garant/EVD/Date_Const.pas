unit Date_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Date_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::EVD::Standard::evdNative::Date
//
// Дата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Date - "Дата".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_typDate: DateAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Date : DateAtom = nil;

// start class DateAtom

function k2_typDate: DateAtom;
begin
 if (g_Date = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Date := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Date;
 end;//g_Date = nil
 Result := g_Date;
end;

end.