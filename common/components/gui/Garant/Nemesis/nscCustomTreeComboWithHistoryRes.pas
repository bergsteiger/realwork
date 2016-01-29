unit nscCustomTreeComboWithHistoryRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscCustomTreeComboWithHistoryRes.pas"
// Начат: 10.03.2010 22:09
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::Editor::nscCustomTreeComboWithHistoryRes
//
// Ресурсы для TnscCustomTreeComboWithHistory
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
  { Локализуемые строки MiscMessages }
 str_nsc_CloseHyperlinkText : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_CloseHyperlinkText'; rValue : 'Закрыть');
  { 'Закрыть' }
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3MessageID
  ;

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis)}
// Инициализация str_nsc_CloseHyperlinkText
 str_nsc_CloseHyperlinkText.Init;
{$IfEnd} //Nemesis

end.