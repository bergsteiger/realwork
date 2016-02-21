unit ncsMessage;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsMessage.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3Variant
 , csMessage_Const
 , evdNcsTypes
 , k2Base
 , Classes
 , csDIsconnect_Const
 , csDIsconnectReply_Const
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
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TncsMessage.pm_GetKind: TncsMessageKind;
//#UC START# *1D5377CCDA1F_544E079E0253get_var*
//#UC END# *1D5377CCDA1F_544E079E0253get_var*
begin
//#UC START# *1D5377CCDA1F_544E079E0253get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1D5377CCDA1F_544E079E0253get_impl*
end;//TncsMessage.pm_GetKind

procedure TncsMessage.pm_SetKind(aValue: TncsMessageKind);
//#UC START# *1D5377CCDA1F_544E079E0253set_var*
//#UC END# *1D5377CCDA1F_544E079E0253set_var*
begin
//#UC START# *1D5377CCDA1F_544E079E0253set_impl*
 !!! Needs to be implemented !!!
//#UC END# *1D5377CCDA1F_544E079E0253set_impl*
end;//TncsMessage.pm_SetKind

function TncsMessage.pm_GetMessageID: AnsiString;
//#UC START# *304530FC54C4_544E079E0253get_var*
//#UC END# *304530FC54C4_544E079E0253get_var*
begin
//#UC START# *304530FC54C4_544E079E0253get_impl*
 !!! Needs to be implemented !!!
//#UC END# *304530FC54C4_544E079E0253get_impl*
end;//TncsMessage.pm_GetMessageID

procedure TncsMessage.pm_SetMessageID(const aValue: AnsiString);
//#UC START# *304530FC54C4_544E079E0253set_var*
//#UC END# *304530FC54C4_544E079E0253set_var*
begin
//#UC START# *304530FC54C4_544E079E0253set_impl*
 !!! Needs to be implemented !!!
//#UC END# *304530FC54C4_544E079E0253set_impl*
end;//TncsMessage.pm_SetMessageID

function TncsMessage.pm_GetTimeStamp: TDateTime;
//#UC START# *0872C343F429_544E079E0253get_var*
//#UC END# *0872C343F429_544E079E0253get_var*
begin
//#UC START# *0872C343F429_544E079E0253get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0872C343F429_544E079E0253get_impl*
end;//TncsMessage.pm_GetTimeStamp

procedure TncsMessage.pm_SetTimeStamp(aValue: TDateTime);
//#UC START# *0872C343F429_544E079E0253set_var*
//#UC END# *0872C343F429_544E079E0253set_var*
begin
//#UC START# *0872C343F429_544E079E0253set_impl*
 !!! Needs to be implemented !!!
//#UC END# *0872C343F429_544E079E0253set_impl*
end;//TncsMessage.pm_SetTimeStamp

class function TncsMessage.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_544E079E0253_var*
//#UC END# *53AC03EE01FD_544E079E0253_var*
begin
//#UC START# *53AC03EE01FD_544E079E0253_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_544E079E0253_impl*
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
//#UC START# *53AC03EE01FD_547C1F31030C_var*
//#UC END# *53AC03EE01FD_547C1F31030C_var*
begin
//#UC START# *53AC03EE01FD_547C1F31030C_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_547C1F31030C_impl*
end;//TncsDIsconnect.GetTaggedDataType

class function TncsDIsconnectReply.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_547C1F3F025A_var*
//#UC END# *53AC03EE01FD_547C1F3F025A_var*
begin
//#UC START# *53AC03EE01FD_547C1F3F025A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_547C1F3F025A_impl*
end;//TncsDIsconnectReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
