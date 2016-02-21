unit ncsMessageQueue;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsMessageQueue.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsPriorityMessageList
 , SyncObjs
 , ncsMessage
 , Windows
;

type
 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 TncsMessageQueue = class(_l3CriticalSectionHolder_)
  private
   f_Data: TncsPriorityMessageList;
   f_DataReadyEvent: TEvent;
   f_Processing: Boolean;
    {* Поле для свойства Processing }
  protected
   procedure pm_SetProcessing(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure SignalMessageReady;
   procedure Push(aMessage: TncsMessage);
   function WaitForMessage(aTimeOut: LongWord = INFINITE): Boolean;
   function ExtractMessage(out theMessage: TncsMessage): Boolean;
    {* Увеличивает счетчик theMessage! Требуется theMessage.Free }
  public
   property Processing: Boolean
    read f_Processing
    write pm_SetProcessing;
 end;//TncsMessageQueue
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3Utils
;

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

procedure TncsMessageQueue.pm_SetProcessing(aValue: Boolean);
//#UC START# *545A157B02C2_544E3C54031Dset_var*
//#UC END# *545A157B02C2_544E3C54031Dset_var*
begin
//#UC START# *545A157B02C2_544E3C54031Dset_impl*
 Lock;
 try
  f_Processing := aValue;
  if not f_Processing then
  begin
   SignalMessageReady;
   f_Data.Clear;
  end
  else
   if f_Data.Count > 0 then
    SignalMessageReady
   else
    f_DataReadyEvent.ResetEvent;
 finally
  Unlock;
 end;
//#UC END# *545A157B02C2_544E3C54031Dset_impl*
end;//TncsMessageQueue.pm_SetProcessing

procedure TncsMessageQueue.SignalMessageReady;
//#UC START# *5451F97902B8_544E3C54031D_var*
//#UC END# *5451F97902B8_544E3C54031D_var*
begin
//#UC START# *5451F97902B8_544E3C54031D_impl*
 f_DataReadyEvent.SetEvent;
//#UC END# *5451F97902B8_544E3C54031D_impl*
end;//TncsMessageQueue.SignalMessageReady

procedure TncsMessageQueue.Push(aMessage: TncsMessage);
//#UC START# *544E3DE3032D_544E3C54031D_var*
//#UC END# *544E3DE3032D_544E3C54031D_var*
begin
//#UC START# *544E3DE3032D_544E3C54031D_impl*
 Lock;
 try
  f_Data.Add(aMessage);
  SignalMessageReady;
 finally
  Unlock;
 end;
//#UC END# *544E3DE3032D_544E3C54031D_impl*
end;//TncsMessageQueue.Push

function TncsMessageQueue.WaitForMessage(aTimeOut: LongWord = INFINITE): Boolean;
//#UC START# *5452022F026A_544E3C54031D_var*
//#UC END# *5452022F026A_544E3C54031D_var*
begin
//#UC START# *5452022F026A_544E3C54031D_impl*
 if not Processing then
  Result := False
 else
  Result := (f_DataReadyEvent.WaitFor(aTimeOut) = wrSignaled) and Processing;
//#UC END# *5452022F026A_544E3C54031D_impl*
end;//TncsMessageQueue.WaitForMessage

function TncsMessageQueue.ExtractMessage(out theMessage: TncsMessage): Boolean;
 {* Увеличивает счетчик theMessage! Требуется theMessage.Free }
//#UC START# *545202810200_544E3C54031D_var*
//#UC END# *545202810200_544E3C54031D_var*
begin
//#UC START# *545202810200_544E3C54031D_impl*
 Result := False;
 FreeAndNil(theMessage);
 if Processing then
 begin
  Lock;
  try
   if (f_Data.Count > 0) then
   begin
    f_Data[0].SetRefTo(theMessage);
    f_Data.Delete(0);
    Result := True;
   end;
   if (f_Data.Count = 0) then
    f_DataReadyEvent.ResetEvent;
  finally
   Unlock;
  end;
 end;
//#UC END# *545202810200_544E3C54031D_impl*
end;//TncsMessageQueue.ExtractMessage

procedure TncsMessageQueue.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_544E3C54031D_var*
//#UC END# *479731C50290_544E3C54031D_var*
begin
//#UC START# *479731C50290_544E3C54031D_impl*
 FreeAndNil(f_Data);
 FreeAndNil(f_DataReadyEvent);
 inherited Cleanup;
//#UC END# *479731C50290_544E3C54031D_impl*
end;//TncsMessageQueue.Cleanup

procedure TncsMessageQueue.InitFields;
//#UC START# *47A042E100E2_544E3C54031D_var*
//#UC END# *47A042E100E2_544E3C54031D_var*
begin
//#UC START# *47A042E100E2_544E3C54031D_impl*
 inherited InitFields;
 f_Data := TncsPriorityMessageList.Make;
// f_Data := TncsPriorityMessageList.MakeSorted(l3_dupError);
 f_DataReadyEvent := TEvent.Create(nil, True, False, l3CreateStringGUID);
//#UC END# *47A042E100E2_544E3C54031D_impl*
end;//TncsMessageQueue.InitFields
{$IfEnd} // NOT Defined(Nemesis)

end.
