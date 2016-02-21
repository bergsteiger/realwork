unit ncsCompatibilityClientTransporter;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsCompatibilityClientTransporter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsClientTransporter
 , CsQueryTypes
 , ncsMessageInterfaces
;

type
 TncsCompatibilityClientTransporter = class(TncsClientTransporter)
  private
   f_QueryID: TCsQueryId;
  protected
   procedure BeforeSendHandshake; override;
   procedure BeforeReceiveHandshake; override;
  public
   constructor Create(aQueryID: TCsQueryId); reintroduce;
   class function Make(aQueryID: TCsQueryId): IncsClientTransporter; reintroduce;
 end;//TncsCompatibilityClientTransporter
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CsConst
;

constructor TncsCompatibilityClientTransporter.Create(aQueryID: TCsQueryId);
//#UC START# *5481A0E30063_547708500384_var*
//#UC END# *5481A0E30063_547708500384_var*
begin
//#UC START# *5481A0E30063_547708500384_impl*
 inherited Create;
 f_QueryID := aQueryID;
//#UC END# *5481A0E30063_547708500384_impl*
end;//TncsCompatibilityClientTransporter.Create

class function TncsCompatibilityClientTransporter.Make(aQueryID: TCsQueryId): IncsClientTransporter;
var
 l_Inst : TncsCompatibilityClientTransporter;
begin
 l_Inst := Create(aQueryID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsCompatibilityClientTransporter.Make

procedure TncsCompatibilityClientTransporter.BeforeSendHandshake;
//#UC START# *549279980264_547708500384_var*
//#UC END# *549279980264_547708500384_var*
begin
//#UC START# *549279980264_547708500384_impl*
 IOHandlers[ncs_skSend].WriteInteger(c_CsVersion);
 IOHandlers[ncs_skSend].WriteInteger(Integer(Get_ClientID));
 IOHandlers[ncs_skSend].WriteInteger(Ord(f_QueryID));
 IOHandlers[ncs_skSend].WriteBufferFlush;
//#UC END# *549279980264_547708500384_impl*
end;//TncsCompatibilityClientTransporter.BeforeSendHandshake

procedure TncsCompatibilityClientTransporter.BeforeReceiveHandshake;
//#UC START# *549279B300D5_547708500384_var*
//#UC END# *549279B300D5_547708500384_var*
begin
//#UC START# *549279B300D5_547708500384_impl*
 IOHandlers[ncs_skReceive].WriteInteger(c_CsVersion);
 IOHandlers[ncs_skReceive].WriteInteger(Integer(Get_ClientID));
 IOHandlers[ncs_skReceive].WriteInteger(Ord(qtalcuHandShake));
 IOHandlers[ncs_skReceive].WriteBufferFlush;
//#UC END# *549279B300D5_547708500384_impl*
end;//TncsCompatibilityClientTransporter.BeforeReceiveHandshake
{$IfEnd} // NOT Defined(Nemesis)

end.
