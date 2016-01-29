unit afwTypes;

{$IfDef DesignTimeLibrary}
{.$WEAKPACKAGEUNIT ON}
{$EndIf DesignTimeLibrary}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/AFW/afwTypes.pas"
// �����: 30.12.2004 13:38
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::AFW::afwTypes
//
// ������� ���� ���������� AFW.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\AFW\afwDefine.inc}

interface

type
 TafwPrintPage = record
  {* ���� ��� ������ �������� ��������� }
   rNumber : Integer; // ����� �������� ������� � 0
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

end.