unit NOT_FINISHED_evResultFont;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evResultFont.pas"
// Начат: 17.05.2005 12:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::evResultFont::evResultFont
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Tags
  ;

type
 TevFontArray = array [Tk2FontParam] of Integer;

 TevResultFont = {$IfDef XE4}record{$Else}object{$EndIf}
 end;//TevResultFont

 PevResultFontEx = ^TevResultFontEx;

implementation

end.