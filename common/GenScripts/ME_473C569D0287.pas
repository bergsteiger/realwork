unit afwTypes;
 {* Базовые типы библиотеки AFW. }

// Модуль: "w:\common\components\gui\Garant\AFW\afwTypes.pas"
// Стереотип: "Interfaces"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
;

type
 TafwPrintPage = record
  {* инфо для печати страницы документа }
  rNumber: Integer;
   {* номер страницы начиная с 0 }
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

uses
 l3ImplUses
;

end.
