unit ncsReplyWaiter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsReplyWaiter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsReplyWaiter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  Windows,
  l3ProtoObject,
  ncsMessage,
  ncsReplyDescription,
  ncsReplyDecsriptionList,
  SyncObjs
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 TncsReplyWaiter = class(_l3CriticalSectionHolder_)
 private
 // private fields
   f_List : TncsReplyDecsriptionList;
 private
 // private methods
   function FindDesc(aMessage: TncsMessage): TncsReplyDescription;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   procedure SubmitReply(aMessage: TncsMessage);
   procedure SubmitMessage(aMessage: TncsMessage);
   procedure Clear;
   function WaitForReply(aMessage: TncsMessage;
    var theReply: TncsMessage;
    aTimeOut: LongWord = INFINITE): Boolean;
 end;//TncsReplyWaiter
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

// start class TncsReplyWaiter

function TncsReplyWaiter.FindDesc(aMessage: TncsMessage): TncsReplyDescription;
//#UC START# *54633EAE039A_5461D9EE0244_var*
var
 l_IDX: Integer;
//#UC END# *54633EAE039A_5461D9EE0244_var*
begin
//#UC START# *54633EAE039A_5461D9EE0244_impl*
 Result := nil;
 for l_IDX := 0 to f_List.Count - 1 do
  if f_List[l_IDX].Message.MessageID = aMessage.MessageID then
  begin
   Result := f_List[l_IDX];
   Break;
  end;
//#UC END# *54633EAE039A_5461D9EE0244_impl*
end;//TncsReplyWaiter.FindDesc

procedure TncsReplyWaiter.SubmitReply(aMessage: TncsMessage);
//#UC START# *54630A1F0046_5461D9EE0244_var*
var
 l_Desc: TncsReplyDescription;
//#UC END# *54630A1F0046_5461D9EE0244_var*
begin
//#UC START# *54630A1F0046_5461D9EE0244_impl*
 l_Desc := nil;
 Lock;
 try
  FindDesc(aMessage).SetRefTo(l_Desc);
  try
   if Assigned(l_Desc) then
    l_Desc.Reply := aMessage
   else
    l3System.Msg2Log('Не найдено сообщение для ответа!!');
  finally
   FreeAndNil(l_Desc);
  end;
 finally
  Unlock;
 end;
//#UC END# *54630A1F0046_5461D9EE0244_impl*
end;//TncsReplyWaiter.SubmitReply

procedure TncsReplyWaiter.SubmitMessage(aMessage: TncsMessage);
//#UC START# *54630A3E001D_5461D9EE0244_var*
var
 l_Desc: TncsReplyDescription;
//#UC END# *54630A3E001D_5461D9EE0244_var*
begin
//#UC START# *54630A3E001D_5461D9EE0244_impl*
 l_Desc := TncsReplyDescription.Create(aMessage);
 try
  Lock;
  try
   f_List.Add(l_Desc);
  finally
   Unlock;
  end;
 finally
  FreeAndNil(l_Desc);
 end;
//#UC END# *54630A3E001D_5461D9EE0244_impl*
end;//TncsReplyWaiter.SubmitMessage

procedure TncsReplyWaiter.Clear;
//#UC START# *54630A7102CD_5461D9EE0244_var*
var
 l_IDX: Integer;
//#UC END# *54630A7102CD_5461D9EE0244_var*
begin
//#UC START# *54630A7102CD_5461D9EE0244_impl*
 Lock;
 try
  for l_IDX := 0 to f_List.Count - 1 do
   f_List[l_IDX].AbortWait;
  f_List.Clear;
 finally
  Unlock;
 end;
//#UC END# *54630A7102CD_5461D9EE0244_impl*
end;//TncsReplyWaiter.Clear

function TncsReplyWaiter.WaitForReply(aMessage: TncsMessage;
  var theReply: TncsMessage;
  aTimeOut: LongWord = INFINITE): Boolean;
//#UC START# *54630A80027D_5461D9EE0244_var*
var
 l_Desc: TncsReplyDescription;
//#UC END# *54630A80027D_5461D9EE0244_var*
begin
//#UC START# *54630A80027D_5461D9EE0244_impl*
 Result := False;
 FreeAndNil(theReply);
 l_Desc := nil;
 Lock;
 try
  FindDesc(aMessage).SetRefTo(l_Desc);
 finally
  Unlock;
 end;
 if Assigned(l_Desc) then
  try
   Result := l_Desc.WaitForReply(aTimeOut);
   if Result then
   begin
    if Assigned(l_Desc.Reply) and not (l_Desc.Reply is TncsInvalidMessage) then
     l_Desc.Reply.SetRefTo(theReply)
    else
    begin
     Result := False;
     if l_Desc.Reply = nil then
      l3System.Msg2Log('Неопознанный отклик на сообщение %s (%s)!! = nil', [aMessage.TaggedData.TagType.AsString, aMessage.MessageID])
     else
      l3System.Msg2Log('Неопознанный отклик на сообщение %s (%s)!! = Invalid', [aMessage.TaggedData.TagType.AsString, aMessage.MessageID]);
     l_Desc.AbortWait;
    end;
    Lock;
    try
     f_List.Remove(l_Desc);
    finally
     Unlock;
    end;
   end;
  finally
   FreeAndNil(l_Desc)
  end;
//#UC END# *54630A80027D_5461D9EE0244_impl*
end;//TncsReplyWaiter.WaitForReply

procedure TncsReplyWaiter.Cleanup;
//#UC START# *479731C50290_5461D9EE0244_var*
//#UC END# *479731C50290_5461D9EE0244_var*
begin
//#UC START# *479731C50290_5461D9EE0244_impl*
 Clear;
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_5461D9EE0244_impl*
end;//TncsReplyWaiter.Cleanup

procedure TncsReplyWaiter.InitFields;
//#UC START# *47A042E100E2_5461D9EE0244_var*
//#UC END# *47A042E100E2_5461D9EE0244_var*
begin
//#UC START# *47A042E100E2_5461D9EE0244_impl*
 inherited;
 f_List := TncsReplyDecsriptionList.Create;
//#UC END# *47A042E100E2_5461D9EE0244_impl*
end;//TncsReplyWaiter.InitFields

{$IfEnd} //not Nemesis

end.