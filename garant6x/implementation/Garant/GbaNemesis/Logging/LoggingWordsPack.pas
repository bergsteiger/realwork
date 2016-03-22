unit LoggingWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\LoggingWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "LoggingWordsPack" MUID: (55B75D980276)

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
 , tfwScriptingInterfaces
 , TypInfo
 , nsLoggingTestService
 , nsCachedEventsProcessor
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwLoggingStartListening = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта logging:StartListening
*Пример:*
[code]
 logging:StartListening
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwLoggingStartListening

 TkwLoggingFinishListening = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта logging:FinishListening
*Пример:*
[code]
 logging:FinishListening
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwLoggingFinishListening

 TkwLoggingGetLogRecords = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта logging:GetLogRecords
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 logging:GetLogRecords >>> l_String
[code]  }
  private
   function logging_GetLogRecords(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта logging:GetLogRecords }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoggingGetLogRecords

 TkwLoggingWriteCachedEvents = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта logging:WriteCachedEvents
*Пример:*
[code]
 logging:WriteCachedEvents
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwLoggingWriteCachedEvents

procedure TkwLoggingStartListening.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_66D69322DA0D_var*
//#UC END# *4DAEEDE10285_66D69322DA0D_var*
begin
//#UC START# *4DAEEDE10285_66D69322DA0D_impl*
 TnsLoggingTestService.Instance.StartListening;
//#UC END# *4DAEEDE10285_66D69322DA0D_impl*
end;//TkwLoggingStartListening.DoDoIt

function TkwLoggingStartListening.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwLoggingStartListening.GetResultTypeInfo

function TkwLoggingStartListening.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwLoggingStartListening.GetAllParamsCount

class function TkwLoggingStartListening.GetWordNameForRegister: AnsiString;
begin
 Result := 'logging:StartListening';
end;//TkwLoggingStartListening.GetWordNameForRegister

procedure TkwLoggingFinishListening.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_961A18770456_var*
//#UC END# *4DAEEDE10285_961A18770456_var*
begin
//#UC START# *4DAEEDE10285_961A18770456_impl*
 TnsLoggingTestService.Instance.StopListening;
//#UC END# *4DAEEDE10285_961A18770456_impl*
end;//TkwLoggingFinishListening.DoDoIt

function TkwLoggingFinishListening.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwLoggingFinishListening.GetResultTypeInfo

function TkwLoggingFinishListening.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwLoggingFinishListening.GetAllParamsCount

class function TkwLoggingFinishListening.GetWordNameForRegister: AnsiString;
begin
 Result := 'logging:FinishListening';
end;//TkwLoggingFinishListening.GetWordNameForRegister

function TkwLoggingGetLogRecords.logging_GetLogRecords(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта logging:GetLogRecords }
//#UC START# *E7318C288828_4FDD3D4A4771_var*
//#UC END# *E7318C288828_4FDD3D4A4771_var*
begin
//#UC START# *E7318C288828_4FDD3D4A4771_impl*
 Result := TnsLoggingTestService.Instance.GetLogStrings;
//#UC END# *E7318C288828_4FDD3D4A4771_impl*
end;//TkwLoggingGetLogRecords.logging_GetLogRecords

procedure TkwLoggingGetLogRecords.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(logging_GetLogRecords(aCtx));
end;//TkwLoggingGetLogRecords.DoDoIt

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

class function TkwLoggingGetLogRecords.GetWordNameForRegister: AnsiString;
begin
 Result := 'logging:GetLogRecords';
end;//TkwLoggingGetLogRecords.GetWordNameForRegister

procedure TkwLoggingWriteCachedEvents.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_03C2482A3269_var*
//#UC END# *4DAEEDE10285_03C2482A3269_var*
begin
//#UC START# *4DAEEDE10285_03C2482A3269_impl*
 if TnsCachedEventsProcessor.Exists then
  TnsCachedEventsProcessor.Make.ForceWriteCache;
//#UC END# *4DAEEDE10285_03C2482A3269_impl*
end;//TkwLoggingWriteCachedEvents.DoDoIt

function TkwLoggingWriteCachedEvents.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwLoggingWriteCachedEvents.GetResultTypeInfo

function TkwLoggingWriteCachedEvents.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwLoggingWriteCachedEvents.GetAllParamsCount

class function TkwLoggingWriteCachedEvents.GetWordNameForRegister: AnsiString;
begin
 Result := 'logging:WriteCachedEvents';
end;//TkwLoggingWriteCachedEvents.GetWordNameForRegister

initialization
 TkwLoggingStartListening.RegisterInEngine;
 {* Регистрация logging_StartListening }
 TkwLoggingFinishListening.RegisterInEngine;
 {* Регистрация logging_FinishListening }
 TkwLoggingGetLogRecords.RegisterInEngine;
 {* Регистрация logging_GetLogRecords }
 TkwLoggingWriteCachedEvents.RegisterInEngine;
 {* Регистрация logging_WriteCachedEvents }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
{$IfEnd} // NOT Defined(NoScripts)

end.
