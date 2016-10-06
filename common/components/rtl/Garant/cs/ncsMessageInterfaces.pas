unit ncsMessageInterfaces;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsMessageInterfaces.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ncsMessageInterfaces" MUID: (5460A4DB018A)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsCommon
 , ncsMessage
 , Windows
 , csIdIOHandlerAbstractAdapter
;

type
 PIncsMessageExecutorFactory = ^IncsMessageExecutorFactory;

 IncsTransporter = interface
  ['{CE5512DA-5FA9-423C-A266-65F24CF2501C}']
  function Get_Connected: Boolean;
  function Get_ClientID: TCsClientId;
  procedure Set_ClientID(aValue: TCsClientId);
  function Get_Processing: Boolean;
  function Get_SessionID: AnsiString;
  procedure Send(aMessage: TncsMessage);
  function WaitForReply(aMessage: TncsMessage;
   var theReply: TncsMessage;
   aTimeOut: LongWord = Windows.INFINITE): Boolean;
  procedure RegisterHelper(const aHelper: IUnknown);
  procedure UnregisterHelper(const aHelper: IUnknown);
  property Connected: Boolean
   read Get_Connected;
   {* Есть физический коннект }
  property ClientID: TCsClientId
   read Get_ClientID
   write Set_ClientID;
  property Processing: Boolean
   read Get_Processing;
   {* Есть полноценная обработка сообщений }
  property SessionID: AnsiString
   read Get_SessionID;
 end;//IncsTransporter

 TncsExecuteContext = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rMessage: TncsMessage;
   rTransporter: IncsTransporter;
 end;//TncsExecuteContext

 IncsExecutor = interface
  ['{A6EB1A21-7939-4C8E-B5BC-65A97C27D138}']
  procedure Execute(const aContext: TncsExecuteContext);
 end;//IncsExecutor

 IncsMessageExecutorFactory = interface
  ['{EB847F25-81CC-421B-ADFF-D135A33AC78B}']
  function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
 end;//IncsMessageExecutorFactory

 IncsClientTransporter = interface(IncsTransporter)
  ['{CD83C556-C3C5-40FA-91B1-6C1CA7CF87D7}']
  procedure Connect(const aServerHost: AnsiString;
   aServerPort: Integer;
   const aSessionID: AnsiString);
  procedure Disconnect(Immidiate: Boolean = False);
   {* Immidiate = True - отрубить сразу
Immidiate = False - дождаться завершения обмена послав ncsDisconnect и дождавшись ответа }
 end;//IncsClientTransporter

 IncsServerTransporter = interface(IncsTransporter)
  ['{2DF810B8-EB59-4A34-8945-D6D35E58B03C}']
  function Get_Terminated: Boolean;
  procedure ProcessMessages(IsMainSocket: Boolean);
  procedure Terminate(WaitForTermination: Boolean = True);
  procedure RegisterSendBackHandler(aHandler: TcsIdIOHandlerAbstractAdapter);
  property Terminated: Boolean
   read Get_Terminated;
 end;//IncsServerTransporter

 TncsSocketKind = (
  ncs_skSend
  , ncs_skReceive
 );//TncsSocketKind

function TncsExecuteContext_C(aMessage: TncsMessage;
 const aTransporter: IncsTransporter): TncsExecuteContext;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *5460A4DB018Aimpl_uses*
 //#UC END# *5460A4DB018Aimpl_uses*
;

function TncsExecuteContext_C(aMessage: TncsMessage;
 const aTransporter: IncsTransporter): TncsExecuteContext;
//#UC START# *5464B3AA0087_5464B37E01ED_var*
//#UC END# *5464B3AA0087_5464B37E01ED_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5464B3AA0087_5464B37E01ED_impl*
 Result.rMessage := aMessage;
 Result.rTransporter := aTransporter;
//#UC END# *5464B3AA0087_5464B37E01ED_impl*
end;//TncsExecuteContext_C
{$IfEnd} // NOT Defined(Nemesis)

end.
