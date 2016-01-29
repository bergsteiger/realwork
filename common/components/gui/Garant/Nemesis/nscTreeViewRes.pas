unit nscTreeViewRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscTreeViewRes.pas"
// Начат: 10.03.2010 20:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::Tree::nscTreeViewRes
//
// Ресурсы для TnscTreeView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  l3StringIDEx
  ;

var
  { Локализуемые строки nscMultiStroke }
 str_nsc_WrapHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_WrapHint'; rValue : 'Включить перенос по словам');
  { 'Включить перенос по словам' }
 str_nsc_UnwrapHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_UnwrapHint'; rValue : 'Выключить перенос по словам');
  { 'Выключить перенос по словам' }

const
  { Карта преобразования локализованных строк nscMultiStroke }
 nscMultiStrokeMap : array [Boolean] of Pl3StringIDEx = (
  @str_nsc_WrapHint
  , @str_nsc_UnwrapHint
 );//nscMultiStrokeMap
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3MessageID
  ;

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis)}
// Инициализация str_nsc_WrapHint
 str_nsc_WrapHint.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// Инициализация str_nsc_UnwrapHint
 str_nsc_UnwrapHint.Init;
{$IfEnd} //Nemesis

end.