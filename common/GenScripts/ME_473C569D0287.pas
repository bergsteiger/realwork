unit afwTypes;

interface

uses
 l3IntfUses
;

type
 TafwPrintPage = record
  {* ���� ��� ������ �������� ��������� }
 end;//TafwPrintPage
 
 TafwPrintPagesArray = array of TafwPrintPage;
  {* ������ ������� preview. }
 
 TafwPagesInterval = (
  {* �������� ������. }
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
