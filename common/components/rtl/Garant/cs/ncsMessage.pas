unit ncsMessage;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsMessage.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ncsMessage" MUID: (5453986402AC)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3Variant
 , evdNcsTypes
 , k2Base
 , Classes
;

type
 TncsMessageClass = class of TncsMessage;

 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TncsMessage = class(_evdTagHolder_)
  protected
   function pm_GetKind: TncsMessageKind;
   procedure pm_SetKind(aValue: TncsMessageKind);
   function pm_GetMessageID: AnsiString;
   procedure pm_SetMessageID(const aValue: AnsiString);
   function pm_GetTimeStamp: TDateTime;
   procedure pm_SetTimeStamp(aValue: TDateTime);
   procedure InitFields; override;
   function NeedSendRawDataAsBinary: Boolean; override;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
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

 TncsInvalidMessage = class(TncsMessage)
 end;//TncsInvalidMessage

 TncsReply = class(TncsMessage)
  public
   constructor Create(aMessage: TncsMessage); reintroduce;
 end;//TncsReply

 TncsDIsconnect = class(TncsMessage)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TncsDIsconnect

 TncsDIsconnectReply = class(TncsReply)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TncsDIsconnectReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Utils
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
 , csMessage_Const
 , csDIsconnect_Const
 , csDIsconnectReply_Const
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TncsMessage.pm_GetKind: TncsMessageKind;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TncsMessageKind(TaggedData.IntA[k2_attrKind]);
end;//TncsMessage.pm_GetKind

procedure TncsMessage.pm_SetKind(aValue: TncsMessageKind);
begin
 TaggedData.IntW[k2_attrKind, nil] := Ord(aValue);
end;//TncsMessage.pm_SetKind

function TncsMessage.pm_GetMessageID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMessageID]);
end;//TncsMessage.pm_GetMessageID

procedure TncsMessage.pm_SetMessageID(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrMessageID, nil] := (aValue);
end;//TncsMessage.pm_SetMessageID

function TncsMessage.pm_GetTimeStamp: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrTimeStamp]);
end;//TncsMessage.pm_GetTimeStamp

procedure TncsMessage.pm_SetTimeStamp(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrTimeStamp, nil] := (aValue);
end;//TncsMessage.pm_SetTimeStamp

class function TncsMessage.GetTaggedDataType: Tk2Type;
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

class function TncsDIsconnect.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsDIsconnect;
end;//TncsDIsconnect.GetTaggedDataType

class function TncsDIsconnectReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsDIsconnectReply;
end;//TncsDIsconnectReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
