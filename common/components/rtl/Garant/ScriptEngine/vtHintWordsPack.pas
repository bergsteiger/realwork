unit vtHintWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$VT"
// Модуль: "vtHintWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VT::vtHintWords::vtHintWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwScriptingInterfaces,
  tfwGlobalKeyWord
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  vtHintManager,
  Windows,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwApplicationCancelHint = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:CancelHint
*Пример:*
[code]
 application:CancelHint
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
 end;//TkwApplicationCancelHint

// start class TkwApplicationCancelHint

procedure TkwApplicationCancelHint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_602888D14BF8_var*
//#UC END# *4DAEEDE10285_602888D14BF8_var*
begin
//#UC START# *4DAEEDE10285_602888D14BF8_impl*
// Application.CancelHint;
 with TvtHintManager.Instance do
  if Count > 0 then
   ShowWindow(Item[Count - 1].Handle, SW_HIDE);
//#UC END# *4DAEEDE10285_602888D14BF8_impl*
end;//TkwApplicationCancelHint.DoDoIt

class function TkwApplicationCancelHint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'application:CancelHint';
end;//TkwApplicationCancelHint.GetWordNameForRegister

function TkwApplicationCancelHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwApplicationCancelHint.GetResultTypeInfo

function TkwApplicationCancelHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwApplicationCancelHint.GetAllParamsCount

type
 TkwApplicationIsHintVisible = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:IsHintVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 application:IsHintVisible >>> l_Boolean
[code]  }
 private
 // private methods
   function ApplicationIsHintVisible(const aCtx: TtfwContext): Boolean;
     {* Реализация слова скрипта application:IsHintVisible }
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
 end;//TkwApplicationIsHintVisible

// start class TkwApplicationIsHintVisible

function TkwApplicationIsHintVisible.ApplicationIsHintVisible(const aCtx: TtfwContext): Boolean;
//#UC START# *84B99BA2B7CE_0EF7A152CBB4_var*
//#UC END# *84B99BA2B7CE_0EF7A152CBB4_var*
begin
//#UC START# *84B99BA2B7CE_0EF7A152CBB4_impl*
 with TvtHintManager.Instance do
  Result := ((Count > 0) and IsWindowVisible(Item[Count - 1].Handle));
//#UC END# *84B99BA2B7CE_0EF7A152CBB4_impl*
end;//TkwApplicationIsHintVisible.ApplicationIsHintVisible

procedure TkwApplicationIsHintVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushBool((ApplicationIsHintVisible(aCtx)));
end;//TkwApplicationIsHintVisible.DoDoIt

class function TkwApplicationIsHintVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'application:IsHintVisible';
end;//TkwApplicationIsHintVisible.GetWordNameForRegister

function TkwApplicationIsHintVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwApplicationIsHintVisible.GetResultTypeInfo

function TkwApplicationIsHintVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwApplicationIsHintVisible.GetAllParamsCount

function TkwApplicationIsHintVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwApplicationIsHintVisible.ParamsTypes

type
 TkwApplicationGetLastHint = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:GetLastHint
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 application:GetLastHint >>> l_Il3CString
[code]  }
 private
 // private methods
   function ApplicationGetLastHint(const aCtx: TtfwContext): Il3CString;
     {* Реализация слова скрипта application:GetLastHint }
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
 end;//TkwApplicationGetLastHint

// start class TkwApplicationGetLastHint

function TkwApplicationGetLastHint.ApplicationGetLastHint(const aCtx: TtfwContext): Il3CString;
//#UC START# *BEF87F4CB387_64C2DF1C9241_var*
//#UC END# *BEF87F4CB387_64C2DF1C9241_var*
begin
//#UC START# *BEF87F4CB387_64C2DF1C9241_impl*
 with TvtHintManager.Instance do
  if Count > 0 then
   Result := Item[Count - 1].LastHint
  else
   Result := TtfwCStringFactory.C('');
//#UC END# *BEF87F4CB387_64C2DF1C9241_impl*
end;//TkwApplicationGetLastHint.ApplicationGetLastHint

procedure TkwApplicationGetLastHint.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString((ApplicationGetLastHint(aCtx)));
end;//TkwApplicationGetLastHint.DoDoIt

class function TkwApplicationGetLastHint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'application:GetLastHint';
end;//TkwApplicationGetLastHint.GetWordNameForRegister

function TkwApplicationGetLastHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwApplicationGetLastHint.GetResultTypeInfo

function TkwApplicationGetLastHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwApplicationGetLastHint.GetAllParamsCount

function TkwApplicationGetLastHint.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwApplicationGetLastHint.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация application_CancelHint
 TkwApplicationCancelHint.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация application_IsHintVisible
 TkwApplicationIsHintVisible.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация application_GetLastHint
 TkwApplicationGetLastHint.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts

end.