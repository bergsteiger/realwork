unit DecorTextPara_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/DecorTextPara_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::DecorTextPara
//
// Текстовый параграф - оформление, не редактируется, не участвует в поиске
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DecorTextPara - "Текстовый параграф - оформление, не редактируется, не участвует в поиске".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idDecorTextPara = 72;

function k2_typDecorTextPara: DecorTextParaTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DecorTextPara : DecorTextParaTag = nil;

// start class DecorTextParaTag

function k2_typDecorTextPara: DecorTextParaTag;
begin
 if (g_DecorTextPara = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_DecorTextPara := TevNativeSchema(Tk2TypeTable.GetInstance).t_DecorTextPara;
 end;//g_DecorTextPara = nil
 Result := g_DecorTextPara;
end;

end.