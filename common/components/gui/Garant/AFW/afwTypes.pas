unit afwTypes;

{$IfDef DesignTimeLibrary}
{.$WEAKPACKAGEUNIT ON}
{$EndIf DesignTimeLibrary}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AFW"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/AFW/afwTypes.pas"
// Начат: 30.12.2004 13:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::AFW::afwTypes
//
// Базовые типы библиотеки AFW.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\AFW\afwDefine.inc}

interface

type
 TafwPrintPage = record
  {* инфо для печати страницы документа }
   rNumber : Integer; // номер страницы начиная с 0
 end;//TafwPrintPage

 TafwPrintPagesArray = array of TafwPrintPage;
  {* Массив страниц preview. }

 TafwPagesInterval = (
  {* Интервал печати. }
   afw_piAll
 , afw_piOdd
 , afw_piEven
 );//TafwPagesInterval

 TafwCommands = array of AnsiString;

implementation

end.