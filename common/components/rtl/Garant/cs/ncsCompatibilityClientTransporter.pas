unit ncsCompatibilityClientTransporter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsCompatibilityClientTransporter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsCompatibilityClientTransporter
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
  CsQueryTypes,
  ncsClientTransporter,
  ncsMessageInterfaces,
  ncsMessage,
  Windows,
  CsCommon
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsCompatibilityClientTransporter = class(TncsClientTransporter)
 private
 // private fields
   f_QueryID : TCsQueryId;
 protected
 // overridden protected methods
   procedure BeforeSendHandshake; override;
     {* Сигнатура метода BeforeSendHandshake }
   procedure BeforeReceiveHandshake; override;
     {* Сигнатура метода BeforeReceiveHandshake }
 public
 // public methods
   constructor Create(aQueryID: TCsQueryId); reintroduce;
   class function Make(aQueryID: TCsQueryId): IncsClientTransporter; reintroduce;
     {* Сигнатура фабрики TncsCompatibilityClientTransporter.Make }
 end;//TncsCompatibilityClientTransporter
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  CsConst
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsCompatibilityClientTransporter

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
end;

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

{$IfEnd} //not Nemesis

end.