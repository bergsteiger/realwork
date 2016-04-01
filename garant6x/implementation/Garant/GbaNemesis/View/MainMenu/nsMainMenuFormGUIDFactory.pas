unit nsMainMenuFormGUIDFactory;
 {* ������� GUID'�� ��� ��
http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698414#comment-330698414 }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\nsMainMenuFormGUIDFactory.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsMainMenuFormGUIDFactory" MUID: (4F2012220355)

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
 TnsMainMenuFormGUIDFactory = class(TvcmFormGUIDFromMainFormList)
  {* ������� GUID'�� ��� ��
http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698414#comment-330698414 }
  public
   class function Instance: TnsMainMenuFormGUIDFactory;
    {* ����� ��������� ���������� ���������� TnsMainMenuFormGUIDFactory }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsMainMenuFormGUIDFactory
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_TnsMainMenuFormGUIDFactory: TnsMainMenuFormGUIDFactory = nil;
 {* ��������� ���������� TnsMainMenuFormGUIDFactory }

procedure TnsMainMenuFormGUIDFactoryFree;
 {* ����� ������������ ���������� ���������� TnsMainMenuFormGUIDFactory }
begin
 l3Free(g_TnsMainMenuFormGUIDFactory);
end;//TnsMainMenuFormGUIDFactoryFree

class function TnsMainMenuFormGUIDFactory.Instance: TnsMainMenuFormGUIDFactory;
 {* ����� ��������� ���������� ���������� TnsMainMenuFormGUIDFactory }
begin
 if (g_TnsMainMenuFormGUIDFactory = nil) then
 begin
  l3System.AddExitProc(TnsMainMenuFormGUIDFactoryFree);
  g_TnsMainMenuFormGUIDFactory := Create;
 end;
 Result := g_TnsMainMenuFormGUIDFactory;
end;//TnsMainMenuFormGUIDFactory.Instance

class function TnsMainMenuFormGUIDFactory.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsMainMenuFormGUIDFactory <> nil;
end;//TnsMainMenuFormGUIDFactory.Exists
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
