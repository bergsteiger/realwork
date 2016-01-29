unit ncsMessage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsMessage.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Messages::ncsMessage
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
  l3Variant,
  evdNcsTypes,
  Classes,
  k2Base
  ;

type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TncsMessage = class(_evdTagHolder_)
 protected
 // property methods
   function pm_GetKind: TncsMessageKind;
   procedure pm_SetKind(aValue: TncsMessageKind);
   function pm_GetMessageID: AnsiString;
   procedure pm_SetMessageID(const aValue: AnsiString);
   function pm_GetTimeStamp: TDateTime;
   procedure pm_SetTimeStamp(aValue: TDateTime);
 public
 // realized methods
   class function GetTaggedDataType: Tk2Type; override;
 protected
 // overridden protected methods
   procedure InitFields; override;
   function NeedSendRawDataAsBinary: Boolean; override;
 public
 // public properties
   property Kind: TncsMessageKind
     read pm_GetKind
     write pm_SetKind;
     {* На сообщение должен быть послан ответ }
   property MessageID: AnsiString
     read pm_GetMessageID
     write pm_SetMessageID;
     {* Уникальный ключ по котороу ищется сообщение во всяких списках }
   property TimeStamp: TDateTime
     read pm_GetTimeStamp
     write pm_SetTimeStamp;
 end;//TncsMessage

 TncsMessageClass = class of TncsMessage;

 TncsInvalidMessage = class(TncsMessage)
 end;//TncsInvalidMessage

 TncsReply = class(TncsMessage)
 public
 // public methods
   constructor Create(aMessage: TncsMessage); reintroduce;
 end;//TncsReply

 TncsDIsconnect = class(TncsMessage)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TncsDIsconnect

 TncsDIsconnectReply = class(TncsReply)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TncsDIsconnectReply
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Utils,
  csMessage_Const,
  evdNativeWriter,
  l3Filer,
  l3Types,
  k2TagGen,
  evdNativeReader,
  k2DocumentBuffer,
  SysUtils,
  csDIsconnect_Const,
  csDIsconnectReply_Const
  ;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

// start class TncsMessage

function TncsMessage.pm_GetKind: TncsMessageKind;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TncsMessageKind(TaggedData.IntA[k2_attrKind]);
end;//TncsMessage.pm_GetKind

procedure TncsMessage.pm_SetKind(aValue: TncsMessageKind);
 {-}
begin
 TaggedData.IntW[k2_attrKind, nil] := Ord(aValue);
end;//TncsMessage.pm_SetKind

function TncsMessage.pm_GetMessageID: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMessageID]);
end;//TncsMessage.pm_GetMessageID

procedure TncsMessage.pm_SetMessageID(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrMessageID, nil] := (aValue);
end;//TncsMessage.pm_SetMessageID

function TncsMessage.pm_GetTimeStamp: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrTimeStamp]);
end;//TncsMessage.pm_GetTimeStamp

procedure TncsMessage.pm_SetTimeStamp(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrTimeStamp, nil] := (aValue);
end;//TncsMessage.pm_SetTimeStamp

class function TncsMessage.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsMessage;
end;//TncsMessage.GetTaggedDataType

procedure TncsMessage.InitFields;
//#UC START# *47A042E100E2_544E079E0253_var*
//#UC END# *47A042E100E2_544E079E0253_var*
begin
//#UC START# *47A042E100E2_544E079E0253_impl*
 inherited;
 if Kind <> ncs_mkReply then
  MessageID := l3CreateStringGUID;
 TimeStamp := Now;
//#UC END# *47A042E100E2_544E079E0253_impl*
end;//TncsMessage.InitFields

function TncsMessage.NeedSendRawDataAsBinary: Boolean;
//#UC START# *549413590379_544E079E0253_var*
//#UC END# *549413590379_544E079E0253_var*
begin
//#UC START# *549413590379_544E079E0253_impl*
 Result := True;
//#UC END# *549413590379_544E079E0253_impl*
end;//TncsMessage.NeedSendRawDataAsBinary
// start class TncsReply

constructor TncsReply.Create(aMessage: TncsMessage);
//#UC START# *547831D300BE_547831BD02E5_var*
//#UC END# *547831D300BE_547831BD02E5_var*
begin
//#UC START# *547831D300BE_547831BD02E5_impl*
 Assert(Assigned(aMessage) and (aMessage.Kind = ncs_mkMessage));
 inherited Create;
 Kind := ncs_mkReply;
 MessageID := aMessage.MessageID
//#UC END# *547831D300BE_547831BD02E5_impl*
end;//TncsReply.Create
// start class TncsDIsconnect

class function TncsDIsconnect.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsDIsconnect;
end;//TncsDIsconnect.GetTaggedDataType
// start class TncsDIsconnectReply

class function TncsDIsconnectReply.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsDIsconnectReply;
end;//TncsDIsconnectReply.GetTaggedDataType
{$IfEnd} //not Nemesis

end.