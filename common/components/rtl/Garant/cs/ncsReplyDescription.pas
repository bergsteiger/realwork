unit ncsReplyDescription;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsReplyDescription.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsReplyDescription" MUID: (5461D6C30025)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessage
 , SyncObjs
 , Windows
;

type
 TncsReplyDescription = class(Tl3ProtoObject)
  private
   f_Event: TEvent;
   f_Message: TncsMessage;
   f_Reply: TncsMessage;
  protected
   procedure pm_SetReply(aValue: TncsMessage);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aMessage: TncsMessage); reintroduce;
   procedure RequestEvent;
   function WaitForReply(aTimeOut: LongWord = Windows.INFINITE): Boolean;
   procedure AbortWait;
  public
   property Message: TncsMessage
    read f_Message;
   property Reply: TncsMessage
    read f_Reply
    write pm_SetReply;
 end;//TncsReplyDescription
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Utils
 //#UC START# *5461D6C30025impl_uses*
 //#UC END# *5461D6C30025impl_uses*
;

procedure TncsReplyDescription.pm_SetReply(aValue: TncsMessage);
//#UC START# *5461D977016B_5461D6C30025set_var*
//#UC END# *5461D977016B_5461D6C30025set_var*
begin
//#UC START# *5461D977016B_5461D6C30025set_impl*
 Assert(f_Reply = nil);
 aValue.SetRefTo(f_Reply);
 if Assigned(f_Event) then
  f_Event.SetEvent;
//#UC END# *5461D977016B_5461D6C30025set_impl*
end;//TncsReplyDescription.pm_SetReply

constructor TncsReplyDescription.Create(aMessage: TncsMessage);
//#UC START# *5461D8CE0020_5461D6C30025_var*
//#UC END# *5461D8CE0020_5461D6C30025_var*
begin
//#UC START# *5461D8CE0020_5461D6C30025_impl*
 inherited Create;
 aMessage.SetRefTo(f_Message)
//#UC END# *5461D8CE0020_5461D6C30025_impl*
end;//TncsReplyDescription.Create

procedure TncsReplyDescription.RequestEvent;
//#UC START# *5463220800C9_5461D6C30025_var*
//#UC END# *5463220800C9_5461D6C30025_var*
begin
//#UC START# *5463220800C9_5461D6C30025_impl*
 if f_Event = nil then
  f_Event := TEvent.Create(nil, True, False, l3CreateStringGUID);
//#UC END# *5463220800C9_5461D6C30025_impl*
end;//TncsReplyDescription.RequestEvent

function TncsReplyDescription.WaitForReply(aTimeOut: LongWord = Windows.INFINITE): Boolean;
//#UC START# *546335030341_5461D6C30025_var*
//#UC END# *546335030341_5461D6C30025_var*
begin
//#UC START# *546335030341_5461D6C30025_impl*
 if Assigned(Reply) then
 begin
  Result := True;
 end
 else
 begin
  RequestEvent;
  Result := f_Event.WaitFor(aTimeout) = wrSignaled;
 end;
//#UC END# *546335030341_5461D6C30025_impl*
end;//TncsReplyDescription.WaitForReply

procedure TncsReplyDescription.AbortWait;
//#UC START# *5464AAB30031_5461D6C30025_var*
//#UC END# *5464AAB30031_5461D6C30025_var*
begin
//#UC START# *5464AAB30031_5461D6C30025_impl*
 FreeAndNil(f_Reply);
 if Assigned(f_Event) then
  f_Event.SetEvent;
//#UC END# *5464AAB30031_5461D6C30025_impl*
end;//TncsReplyDescription.AbortWait

procedure TncsReplyDescription.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5461D6C30025_var*
//#UC END# *479731C50290_5461D6C30025_var*
begin
//#UC START# *479731C50290_5461D6C30025_impl*
 AbortWait;
 FreeAndNil(f_Event);
 FreeAndNil(f_Reply);
 FreeAndNil(f_Message);
 inherited;
//#UC END# *479731C50290_5461D6C30025_impl*
end;//TncsReplyDescription.Cleanup
{$IfEnd} // NOT Defined(Nemesis)

end.
