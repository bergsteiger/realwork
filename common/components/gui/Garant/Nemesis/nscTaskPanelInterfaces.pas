unit nscTaskPanelInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscTaskPanelInterfaces.pas"
// �����: 18.02.2009 17:24
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi For F1::Nemesis::nscTaskPanelInterfaces
//
// ���������� ��� ������ �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmTaskPanelInterfaces
  {$IfEnd} //not NoVCM
  
  ;

type
 InscOperationNode = interface(IUnknown)
  {* ���� �������� ������ ����� }
   ['{6B165312-3701-4BB0-A2B2-9E73321E893C}']
   function pm_GetOp: IvcmCustOpsGroupOperation;
   procedure CaptionChanged;
     {* ���������� �������� �������� }
   property Op: IvcmCustOpsGroupOperation
     read pm_GetOp;
 end;//InscOperationNode
{$IfEnd} //Nemesis

implementation

end.