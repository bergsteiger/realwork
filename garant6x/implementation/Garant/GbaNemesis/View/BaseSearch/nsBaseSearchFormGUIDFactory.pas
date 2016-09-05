unit nsBaseSearchFormGUIDFactory;
 {* ������� GUID'�� ��� ���� �� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\nsBaseSearchFormGUIDFactory.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsBaseSearchFormGUIDFactory" MUID: (4F1EDE130096)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormGUIDFromMainFormList
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsBaseSearchFormGUIDFactory = class({$If NOT Defined(NoVCM)}
 TvcmFormGUIDFromMainFormList
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ������� GUID'�� ��� ���� �� }
  public
   class function Instance: TnsBaseSearchFormGUIDFactory;
    {* ����� ��������� ���������� ���������� TnsBaseSearchFormGUIDFactory }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsBaseSearchFormGUIDFactory
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *4F1EDE130096impl_uses*
 //#UC END# *4F1EDE130096impl_uses*
;

{$If NOT Defined(NoVCM)}
var g_TnsBaseSearchFormGUIDFactory: TnsBaseSearchFormGUIDFactory = nil;
 {* ��������� ���������� TnsBaseSearchFormGUIDFactory }

procedure TnsBaseSearchFormGUIDFactoryFree;
 {* ����� ������������ ���������� ���������� TnsBaseSearchFormGUIDFactory }
begin
 l3Free(g_TnsBaseSearchFormGUIDFactory);
end;//TnsBaseSearchFormGUIDFactoryFree

class function TnsBaseSearchFormGUIDFactory.Instance: TnsBaseSearchFormGUIDFactory;
 {* ����� ��������� ���������� ���������� TnsBaseSearchFormGUIDFactory }
begin
 if (g_TnsBaseSearchFormGUIDFactory = nil) then
 begin
  l3System.AddExitProc(TnsBaseSearchFormGUIDFactoryFree);
  g_TnsBaseSearchFormGUIDFactory := Create;
 end;
 Result := g_TnsBaseSearchFormGUIDFactory;
end;//TnsBaseSearchFormGUIDFactory.Instance

class function TnsBaseSearchFormGUIDFactory.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsBaseSearchFormGUIDFactory <> nil;
end;//TnsBaseSearchFormGUIDFactory.Exists
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
