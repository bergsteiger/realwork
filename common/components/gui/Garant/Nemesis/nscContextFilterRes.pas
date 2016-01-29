unit nscContextFilterRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscContextFilterRes.pas"
// Начат: 10.03.2010 21:16
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Nemesis::ContextFilter::nscContextFilterRes
//
// Ресурсы для TnscContextFilter
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
  { Локализуемые строки ContextFilterMessages }
 str_nsc_LabelCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_LabelCaption'; rValue : 'Контекстный фильтр');
  { 'Контекстный фильтр' }
 str_nsc_ContextEmptyMessage : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ContextEmptyMessage'; rValue : 'Введите слова для поиска и фильтрации');
  { 'Введите слова для поиска и фильтрации' }
 str_nsc_ButtonActiveHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ButtonActiveHint'; rValue : 'Выключить контекстный фильтр');
  { 'Выключить контекстный фильтр' }
 str_nsc_ButtonInActiveHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_ButtonInActiveHint'; rValue : 'Включить контекстный фильтр');
  { 'Включить контекстный фильтр' }
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3MessageID
  ;

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis)}
// Инициализация str_nsc_LabelCaption
 str_nsc_LabelCaption.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// Инициализация str_nsc_ContextEmptyMessage
 str_nsc_ContextEmptyMessage.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// Инициализация str_nsc_ButtonActiveHint
 str_nsc_ButtonActiveHint.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// Инициализация str_nsc_ButtonInActiveHint
 str_nsc_ButtonInActiveHint.Init;
{$IfEnd} //Nemesis

end.