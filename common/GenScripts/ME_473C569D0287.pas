unit afwTypes;
 {* ������� ���� ���������� AFW. }

// ������: "w:\common\components\gui\Garant\AFW\afwTypes.pas"
// ���������: "Interfaces"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

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

 TafwScrollBarType = (
  afw_sbHorz
  , afw_sbVert
 );//TafwScrollBarType

 TafwScrollBars = set of TafwScrollBarType;

const
 afw_sbBoth = [Low(TafwScrollBarType) .. High(TafwScrollBarType)];

implementation

uses
 l3ImplUses
;

end.
