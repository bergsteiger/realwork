unit ncsReplyDescription;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsReplyDescription.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsReplyDescription
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
  SyncObjs,
  Windows,
  l3ProtoObject,
  ncsMessage
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsReplyDescription = class(Tl3ProtoObject)
 private
 // private fields
   f_Event : TEvent;
   f_Message : TncsMessage;
    {* Поле для свойства Message}
   f_Reply : TncsMessage;
    {* Поле для свойства Reply}
 protected
 // property methods
   procedure pm_SetReply(aValue: TncsMessage);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aMessage: TncsMessage); reintroduce;
   procedure RequestEvent;
     {* Сигнатура метода RequestEvent }
   function WaitForReply(aTimeOut: LongWord = INFINITE): Boolean;
   procedure AbortWait;
     {* Сигнатура метода AbortWait }
 public
 // public properties
   property Message: TncsMessage
     read f_Message;
   property Reply: TncsMessage
     read f_Reply
     write pm_SetReply;
 end;//TncsReplyDescription
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Utils,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsReplyDescription

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

function TncsReplyDescription.WaitForReply(aTimeOut: LongWord = INFINITE): Boolean;
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

procedure TncsReplyDescription.Cleanup;
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

{$IfEnd} //not Nemesis

end.