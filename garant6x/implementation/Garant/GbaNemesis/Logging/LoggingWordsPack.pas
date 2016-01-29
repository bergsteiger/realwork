unit LoggingWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Logging"
// Автор: Костицын
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/LoggingWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Базовые определения предметной области::LegalDomain::Logging::LoggingWords::LoggingWordsPack
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  tfwGlobalKeyWord
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  nsLoggingTestService,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwLoggingStartListening = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта logging:StartListening
*Пример:*
[code]
 logging:StartListening
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwLoggingStartListening

// start class TkwLoggingStartListening

procedure TkwLoggingStartListening.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_66D69322DA0D_var*
//#UC END# *4DAEEDE10285_66D69322DA0D_var*
begin
//#UC START# *4DAEEDE10285_66D69322DA0D_impl*
 TnsLoggingTestService.Instance.StartListening;
//#UC END# *4DAEEDE10285_66D69322DA0D_impl*
end;//TkwLoggingStartListening.DoDoIt

class function TkwLoggingStartListening.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'logging:StartListening';
end;//TkwLoggingStartListening.GetWordNameForRegister

function TkwLoggingStartListening.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwLoggingStartListening.GetResultTypeInfo

function TkwLoggingStartListening.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwLoggingStartListening.GetAllParamsCount

type
 TkwLoggingFinishListening = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта logging:FinishListening
*Пример:*
[code]
 logging:FinishListening
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwLoggingFinishListening

// start class TkwLoggingFinishListening

procedure TkwLoggingFinishListening.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_961A18770456_var*
//#UC END# *4DAEEDE10285_961A18770456_var*
begin
//#UC START# *4DAEEDE10285_961A18770456_impl*
 TnsLoggingTestService.Instance.StopListening;
//#UC END# *4DAEEDE10285_961A18770456_impl*
end;//TkwLoggingFinishListening.DoDoIt

class function TkwLoggingFinishListening.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'logging:FinishListening';
end;//TkwLoggingFinishListening.GetWordNameForRegister

function TkwLoggingFinishListening.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwLoggingFinishListening.GetResultTypeInfo

function TkwLoggingFinishListening.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwLoggingFinishListening.GetAllParamsCount

type
 TkwLoggingGetLogRecords = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта logging:GetLogRecords
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 logging:GetLogRecords >>> l_String
[code]  }
 private
 // private methods
   function LoggingGetLogRecords(const aCtx: TtfwContext): AnsiString;
     {* Реализация слова скрипта logging:GetLogRecords }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoggingGetLogRecords

// start class TkwLoggingGetLogRecords

function TkwLoggingGetLogRecords.LoggingGetLogRecords(const aCtx: TtfwContext): AnsiString;
//#UC START# *E7318C288828_4FDD3D4A4771_var*
//#UC END# *E7318C288828_4FDD3D4A4771_var*
begin
//#UC START# *E7318C288828_4FDD3D4A4771_impl*
 Result := TnsLoggingTestService.Instance.GetLogStrings;
//#UC END# *E7318C288828_4FDD3D4A4771_impl*
end;//TkwLoggingGetLogRecords.LoggingGetLogRecords

procedure TkwLoggingGetLogRecords.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString((LoggingGetLogRecords(aCtx)));
end;//TkwLoggingGetLogRecords.DoDoIt

class function TkwLoggingGetLogRecords.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'logging:GetLogRecords';
end;//TkwLoggingGetLogRecords.GetWordNameForRegister

function TkwLoggingGetLogRecords.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwLoggingGetLogRecords.GetResultTypeInfo

function TkwLoggingGetLogRecords.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwLoggingGetLogRecords.GetAllParamsCount

function TkwLoggingGetLogRecords.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoggingGetLogRecords.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация logging_StartListening
 TkwLoggingStartListening.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация logging_FinishListening
 TkwLoggingFinishListening.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация logging_GetLogRecords
 TkwLoggingGetLogRecords.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts

end.