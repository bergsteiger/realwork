unit nsListExceptions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsListExceptions.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Common::Business::Document::nsListExceptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  l3MessageID
  ;

type
 EListIsTooLong = class(Exception)
 end;//EListIsTooLong

var
  { Локализуемые строки EListIsTooLong local }
 str_ListIsTooLong : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ListIsTooLong'; rValue : 'Список содержит большое количество документов, он не может быть отфильтрован. Пожалуйста, уточните запрос.');
  { 'Список содержит большое количество документов, он не может быть отфильтрован. Пожалуйста, уточните запрос.' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3StringIDEx
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  ;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ListIsTooLong
 str_ListIsTooLong.Init;
 str_ListIsTooLong.SetDlgType(mtWarning);
{$IfEnd} //not Admin AND not Monitorings

end.