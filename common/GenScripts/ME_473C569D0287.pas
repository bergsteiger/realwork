unit afwTypes;

interface

uses
 l3IntfUses
;

type
 TafwPrintPage = record
  {* инфо для печати страницы документа }
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
