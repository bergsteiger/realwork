unit vcmMessageQueue;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessageQueue.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmMessageQueue" MUID: (4E089AEB01DA)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmMessageQueuePrim
;

type
 TvcmMessageQueue = class(TvcmMessageQueuePrim)
  public
   class function Exists: Boolean;
   class function Instance: TvcmMessageQueue;
    {* ����� ��������� ���������� ���������� TvcmMessageQueue }
 end;//TvcmMessageQueue
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *4E089AEB01DAimpl_uses*
 //#UC END# *4E089AEB01DAimpl_uses*
;

var g_TvcmMessageQueue: TvcmMessageQueue = nil;
 {* ��������� ���������� TvcmMessageQueue }

procedure TvcmMessageQueueFree;
 {* ����� ������������ ���������� ���������� TvcmMessageQueue }
begin
 l3Free(g_TvcmMessageQueue);
end;//TvcmMessageQueueFree

class function TvcmMessageQueue.Exists: Boolean;
begin
 Result := g_TvcmMessageQueue <> nil;
end;//TvcmMessageQueue.Exists

class function TvcmMessageQueue.Instance: TvcmMessageQueue;
 {* ����� ��������� ���������� ���������� TvcmMessageQueue }
begin
 if (g_TvcmMessageQueue = nil) then
 begin
  l3System.AddExitProc(TvcmMessageQueueFree);
  g_TvcmMessageQueue := Create;
 end;
 Result := g_TvcmMessageQueue;
end;//TvcmMessageQueue.Instance
{$IfEnd} // NOT Defined(NoVCM)

end.
