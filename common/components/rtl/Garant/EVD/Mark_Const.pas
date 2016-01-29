unit Mark_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Mark_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::Mark
//
// Вспомогательный значок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Mark - "Вспомогательный значок".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idMark = 116;

function k2_typMark: MarkTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Mark : MarkTag = nil;

// start class MarkTag

function k2_typMark: MarkTag;
begin
 if (g_Mark = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Mark := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Mark;
 end;//g_Mark = nil
 Result := g_Mark;
end;

end.