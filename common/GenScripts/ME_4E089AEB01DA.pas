unit vcmMessageQueue;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessageQueue.pas"
// Стереотип: "SimpleClass"

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
    {* Метод получения экземпляра синглетона TvcmMessageQueue }
 end;//TvcmMessageQueue
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TvcmMessageQueue: TvcmMessageQueue = nil;
 {* Экземпляр синглетона TvcmMessageQueue }

procedure TvcmMessageQueueFree;
 {* Метод освобождения экземпляра синглетона TvcmMessageQueue }
begin
 l3Free(g_TvcmMessageQueue);
end;//TvcmMessageQueueFree

class function TvcmMessageQueue.Exists: Boolean;
//#UC START# *4E089B4302D8_4E089AEB01DA_var*
//#UC END# *4E089B4302D8_4E089AEB01DA_var*
begin
//#UC START# *4E089B4302D8_4E089AEB01DA_impl*
 Result := (g_TvcmMessageQueue <> nil);
//#UC END# *4E089B4302D8_4E089AEB01DA_impl*
end;//TvcmMessageQueue.Exists

class function TvcmMessageQueue.Instance: TvcmMessageQueue;
 {* Метод получения экземпляра синглетона TvcmMessageQueue }
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
