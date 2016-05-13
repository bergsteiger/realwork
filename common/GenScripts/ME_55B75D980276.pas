unit LoggingWordsPack;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\LoggingWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "LoggingWordsPack" MUID: (55B75D980276)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , TypInfo
 , tfwScriptingInterfaces
 , nsLoggingTestService
 , nsCachedEventsProcessor
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwLoggingStartListening = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� logging:StartListening }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoggingStartListening

 TkwLoggingFinishListening = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� logging:FinishListening }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoggingFinishListening

 TkwLoggingGetLogRecords = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� logging:GetLogRecords }
  private
   function logging_GetLogRecords(const aCtx: TtfwContext): AnsiString;
    {* ���������� ����� ������� logging:GetLogRecords }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoggingGetLogRecords

 TkwLoggingWriteCachedEvents = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� logging:WriteCachedEvents }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoggingWriteCachedEvents

class function TkwLoggingStartListening.GetWordNameForRegister: AnsiString;
begin
 Result := 'logging:StartListening';
end;//TkwLoggingStartListening.GetWordNameForRegister

function TkwLoggingStartListening.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwLoggingStartListening.GetResultTypeInfo

function TkwLoggingStartListening.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwLoggingStartListening.GetAllParamsCount

function TkwLoggingStartListening.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoggingStartListening.ParamsTypes

procedure TkwLoggingStartListening.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55B75DC003BF_Word_var*
//#UC END# *4DAEEDE10285_55B75DC003BF_Word_var*
begin
//#UC START# *4DAEEDE10285_55B75DC003BF_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_55B75DC003BF_Word_impl*
end;//TkwLoggingStartListening.DoDoIt

class function TkwLoggingFinishListening.GetWordNameForRegister: AnsiString;
begin
 Result := 'logging:FinishListening';
end;//TkwLoggingFinishListening.GetWordNameForRegister

function TkwLoggingFinishListening.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwLoggingFinishListening.GetResultTypeInfo

function TkwLoggingFinishListening.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwLoggingFinishListening.GetAllParamsCount

function TkwLoggingFinishListening.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoggingFinishListening.ParamsTypes

procedure TkwLoggingFinishListening.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55B75DD7013D_Word_var*
//#UC END# *4DAEEDE10285_55B75DD7013D_Word_var*
begin
//#UC START# *4DAEEDE10285_55B75DD7013D_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_55B75DD7013D_Word_impl*
end;//TkwLoggingFinishListening.DoDoIt

function TkwLoggingGetLogRecords.logging_GetLogRecords(const aCtx: TtfwContext): AnsiString;
 {* ���������� ����� ������� logging:GetLogRecords }
//#UC START# *55B75E0E039F_55B75E0E039F_Word_var*
//#UC END# *55B75E0E039F_55B75E0E039F_Word_var*
begin
//#UC START# *55B75E0E039F_55B75E0E039F_Word_impl*
 Result := TnsLoggingTestService.Instance.GetLogStrings;
//#UC END# *55B75E0E039F_55B75E0E039F_Word_impl*
end;//TkwLoggingGetLogRecords.logging_GetLogRecords

class function TkwLoggingGetLogRecords.GetWordNameForRegister: AnsiString;
begin
 Result := 'logging:GetLogRecords';
end;//TkwLoggingGetLogRecords.GetWordNameForRegister

function TkwLoggingGetLogRecords.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwLoggingGetLogRecords.GetResultTypeInfo

function TkwLoggingGetLogRecords.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwLoggingGetLogRecords.GetAllParamsCount

function TkwLoggingGetLogRecords.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoggingGetLogRecords.ParamsTypes

procedure TkwLoggingGetLogRecords.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(logging_GetLogRecords(aCtx));
end;//TkwLoggingGetLogRecords.DoDoIt

class function TkwLoggingWriteCachedEvents.GetWordNameForRegister: AnsiString;
begin
 Result := 'logging:WriteCachedEvents';
end;//TkwLoggingWriteCachedEvents.GetWordNameForRegister

function TkwLoggingWriteCachedEvents.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwLoggingWriteCachedEvents.GetResultTypeInfo

function TkwLoggingWriteCachedEvents.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwLoggingWriteCachedEvents.GetAllParamsCount

function TkwLoggingWriteCachedEvents.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoggingWriteCachedEvents.ParamsTypes

procedure TkwLoggingWriteCachedEvents.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_56D4147C0385_Word_var*
//#UC END# *4DAEEDE10285_56D4147C0385_Word_var*
begin
//#UC START# *4DAEEDE10285_56D4147C0385_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_56D4147C0385_Word_impl*
end;//TkwLoggingWriteCachedEvents.DoDoIt

initialization
 TkwLoggingStartListening.RegisterInEngine;
 {* ����������� logging_StartListening }
 TkwLoggingFinishListening.RegisterInEngine;
 {* ����������� logging_FinishListening }
 TkwLoggingGetLogRecords.RegisterInEngine;
 {* ����������� logging_GetLogRecords }
 TkwLoggingWriteCachedEvents.RegisterInEngine;
 {* ����������� logging_WriteCachedEvents }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
