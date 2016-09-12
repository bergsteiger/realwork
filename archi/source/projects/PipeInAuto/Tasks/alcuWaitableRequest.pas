unit alcuWaitableRequest;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuWaitableRequest.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuWaitableRequest" MUID: (57D29F210256)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , SyncObjs
 , daTypes
 , Classes
;

type
 TalcuWaitableRequest = class({$If NOT Defined(Nemesis)}
 TddProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 )
  private
   f_ReadyEvent: TEvent;
  protected
   procedure SignalReady;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(Nemesis)}
   procedure DoLoadFrom(aStream: TStream;
    aIsPipe: Boolean); override;
   {$IfEnd} // NOT Defined(Nemesis)
  public
   procedure WaitForReady;
   {$If NOT Defined(Nemesis)}
   constructor Create(aUserID: TdaUserID); override;
   {$IfEnd} // NOT Defined(Nemesis)
   {$If NOT Defined(Nemesis)}
   procedure DoSaveTo(aStream: TStream;
    aIsPipe: Boolean); override;
   {$IfEnd} // NOT Defined(Nemesis)
 end;//TalcuWaitableRequest
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , SysUtils
 , l3Utils
 , Windows
 //#UC START# *57D29F210256impl_uses*
 //#UC END# *57D29F210256impl_uses*
;

{$If NOT Defined(Nemesis)}
procedure TalcuWaitableRequest.SignalReady;
//#UC START# *57D2A8F90129_57D29F210256_var*
//#UC END# *57D2A8F90129_57D29F210256_var*
begin
//#UC START# *57D2A8F90129_57D29F210256_impl*
 f_ReadyEvent.SetEvent;
//#UC END# *57D2A8F90129_57D29F210256_impl*
end;//TalcuWaitableRequest.SignalReady

procedure TalcuWaitableRequest.WaitForReady;
//#UC START# *57C3FD1D0063_57D29F210256_var*
//#UC END# *57C3FD1D0063_57D29F210256_var*
begin
//#UC START# *57C3FD1D0063_57D29F210256_impl*
 f_ReadyEvent.WaitFor(INFINITE);
//#UC END# *57C3FD1D0063_57D29F210256_impl*
end;//TalcuWaitableRequest.WaitForReady

procedure TalcuWaitableRequest.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57D29F210256_var*
//#UC END# *479731C50290_57D29F210256_var*
begin
//#UC START# *479731C50290_57D29F210256_impl*
 FreeAndNil(f_ReadyEvent);
 inherited Cleanup;
//#UC END# *479731C50290_57D29F210256_impl*
end;//TalcuWaitableRequest.Cleanup

constructor TalcuWaitableRequest.Create(aUserID: TdaUserID);
//#UC START# *53B3D8A8011F_57D29F210256_var*
//#UC END# *53B3D8A8011F_57D29F210256_var*
begin
//#UC START# *53B3D8A8011F_57D29F210256_impl*
 inherited Create(aUserID);
 f_ReadyEvent := TEvent.Create(nil, True, False, l3CreateStringGUID);
//#UC END# *53B3D8A8011F_57D29F210256_impl*
end;//TalcuWaitableRequest.Create

procedure TalcuWaitableRequest.DoSaveTo(aStream: TStream;
 aIsPipe: Boolean);
//#UC START# *53E481990243_57D29F210256_var*
//#UC END# *53E481990243_57D29F210256_var*
begin
//#UC START# *53E481990243_57D29F210256_impl*
 Assert(False);
//#UC END# *53E481990243_57D29F210256_impl*
end;//TalcuWaitableRequest.DoSaveTo

procedure TalcuWaitableRequest.DoLoadFrom(aStream: TStream;
 aIsPipe: Boolean);
//#UC START# *53E481DF03D1_57D29F210256_var*
//#UC END# *53E481DF03D1_57D29F210256_var*
begin
//#UC START# *53E481DF03D1_57D29F210256_impl*
 Assert(False);
//#UC END# *53E481DF03D1_57D29F210256_impl*
end;//TalcuWaitableRequest.DoLoadFrom
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
