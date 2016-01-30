unit afwTypes;
 {* ������� ���� ���������� AFW. }

// ������: "w:\common\components\gui\Garant\AFW\afwTypes.pas"
// ���������: "Interfaces"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
;

type
 TafwPrintPage = record
  {* ���� ��� ������ �������� ��������� }
  rNumber: Integer;
   {* ����� �������� ������� � 0 }
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
