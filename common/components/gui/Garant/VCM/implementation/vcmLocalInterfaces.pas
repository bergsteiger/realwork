unit vcmLocalInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmLocalInterfaces.pas"
// �����: 12.02.2009 17:19
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmLocalInterfaces
//
// ��������� ���������� VCM
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  vcmUserControls
  ;

type
 IvcmFormSetDataSourceListener = interface(Il3Notify)
  {* ��������� ������� ������ ������� ������ }
   ['{5F7A6BE6-C326-4A36-8B7C-F3F8140E0CE6}']
   procedure DataChanged;
     {* ������ ���������� }
 end;//IvcmFormSetDataSourceListener

 IvcmDock = interface(IUnknown)
  {* ��������� �������������� dock-�� toolbar-�� }
   ['{D8BE3620-B1A8-4165-8332-BBD4DA958592}']
   function pm_GetFullWidth: Integer;
   function pm_GetFullHeight: Integer;
   function pm_GetPos: TvcmEffectiveToolBarPos;
   property FullWidth: Integer
     read pm_GetFullWidth;
     {* ������ ������ dock-� toolbar-�� � ������ ����, ��� dock ����� ����
           �������� ��� � �����-������ ��������� }
   property FullHeight: Integer
     read pm_GetFullHeight;
     {* ������ ������ dock-� toolbar-�� � ������ ����, ��� dock ����� ����
           �������� ��� � �����-������ ��������� }
   property Pos: TvcmEffectiveToolBarPos
     read pm_GetPos;
     {* ������� dock-� �� ����� }
 end;//IvcmDock
{$IfEnd} //not NoVCM

implementation

end.