unit nsBaseSearchFormGUIDFactory;
 {* ������� GUID'�� ��� ���� �� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\nsBaseSearchFormGUIDFactory.pas"
// ���������: "SimpleClass"

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
 TnsBaseSearchFormGUIDFactory = class(TvcmFormGUIDFromMainFormList)
  {* ������� GUID'�� ��� ���� �� }
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsBaseSearchFormGUIDFactory;
    {* ����� ��������� ���������� ���������� TnsBaseSearchFormGUIDFactory }
 end;//TnsBaseSearchFormGUIDFactory
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsBaseSearchFormGUIDFactory: TnsBaseSearchFormGUIDFactory = nil;
 {* ��������� ���������� TnsBaseSearchFormGUIDFactory }

procedure TnsBaseSearchFormGUIDFactoryFree;
 {* ����� ������������ ���������� ���������� TnsBaseSearchFormGUIDFactory }
begin
 l3Free(g_TnsBaseSearchFormGUIDFactory);
end;//TnsBaseSearchFormGUIDFactoryFree

class function TnsBaseSearchFormGUIDFactory.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsBaseSearchFormGUIDFactory <> nil;
end;//TnsBaseSearchFormGUIDFactory.Exists

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
