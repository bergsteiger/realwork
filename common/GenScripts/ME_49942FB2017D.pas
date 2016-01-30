unit vcmLocalInterfaces;
 {* ��������� ���������� VCM }

// ������: "w:\common\components\gui\Garant\VCM\implementation\vcmLocalInterfaces.pas"
// ���������: "Interfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3Interfaces
 , vcmUserControls
;

type
 IvcmFormSetDataSourceListener = interface(Il3Notify)
  {* ��������� ������� ������ ������� ������ }
  ['{5F7A6BE6-C326-4A36-8B7C-F3F8140E0CE6}']
  procedure DataChanged;
   {* ������ ���������� }
 end;//IvcmFormSetDataSourceListener

 IvcmDock = interface
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
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
