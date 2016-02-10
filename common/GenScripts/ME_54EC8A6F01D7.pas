unit vtHintWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\vtHintWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , vtHintManager
 , Windows
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwApplicationCancelHint = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:CancelHint
*Пример:*
[code]
 application:CancelHint
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwApplicationCancelHint

 TkwApplicationIsHintVisible = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:IsHintVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 application:IsHintVisible >>> l_Boolean
[code]  }
  private
   function application_IsHintVisible(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта application:IsHintVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwApplicationIsHintVisible

 TkwApplicationGetLastHint = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:GetLastHint
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 application:GetLastHint >>> l_Il3CString
[code]  }
  private
   function application_GetLastHint(const aCtx: TtfwContext): Il3CString;
    {* Реализация слова скрипта application:GetLastHint }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwApplicationGetLastHint

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
begin
 Result := 'application:CancelHint';
end;//TkwApplicationCancelHint.GetWordNameForRegister

function TkwApplicationCancelHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwApplicationCancelHint.GetResultTypeInfo

function TkwApplicationCancelHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwApplicationCancelHint.GetAllParamsCount

function TkwApplicationIsHintVisible.application_IsHintVisible(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта application:IsHintVisible }
//#UC START# *84B99BA2B7CE_0EF7A152CBB4_var*
//#UC END# *84B99BA2B7CE_0EF7A152CBB4_var*
begin
//#UC START# *84B99BA2B7CE_0EF7A152CBB4_impl*
 with TvtHintManager.Instance do
  Result := ((Count > 0) and IsWindowVisible(Item[Count - 1].Handle));
//#UC END# *84B99BA2B7CE_0EF7A152CBB4_impl*
end;//TkwApplicationIsHintVisible.application_IsHintVisible

procedure TkwApplicationIsHintVisible.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0EF7A152CBB4_var*
//#UC END# *4DAEEDE10285_0EF7A152CBB4_var*
begin
//#UC START# *4DAEEDE10285_0EF7A152CBB4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0EF7A152CBB4_impl*
end;//TkwApplicationIsHintVisible.DoDoIt

class function TkwApplicationIsHintVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'application:IsHintVisible';
end;//TkwApplicationIsHintVisible.GetWordNameForRegister

function TkwApplicationIsHintVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwApplicationIsHintVisible.GetResultTypeInfo

function TkwApplicationIsHintVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwApplicationIsHintVisible.GetAllParamsCount

function TkwApplicationIsHintVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0EF7A152CBB4_var*
//#UC END# *5617F4D00243_0EF7A152CBB4_var*
begin
//#UC START# *5617F4D00243_0EF7A152CBB4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0EF7A152CBB4_impl*
end;//TkwApplicationIsHintVisible.ParamsTypes

function TkwApplicationGetLastHint.application_GetLastHint(const aCtx: TtfwContext): Il3CString;
 {* Реализация слова скрипта application:GetLastHint }
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
end;//TkwApplicationGetLastHint.application_GetLastHint

procedure TkwApplicationGetLastHint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_64C2DF1C9241_var*
//#UC END# *4DAEEDE10285_64C2DF1C9241_var*
begin
//#UC START# *4DAEEDE10285_64C2DF1C9241_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_64C2DF1C9241_impl*
end;//TkwApplicationGetLastHint.DoDoIt

class function TkwApplicationGetLastHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'application:GetLastHint';
end;//TkwApplicationGetLastHint.GetWordNameForRegister

function TkwApplicationGetLastHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwApplicationGetLastHint.GetResultTypeInfo

function TkwApplicationGetLastHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwApplicationGetLastHint.GetAllParamsCount

function TkwApplicationGetLastHint.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_64C2DF1C9241_var*
//#UC END# *5617F4D00243_64C2DF1C9241_var*
begin
//#UC START# *5617F4D00243_64C2DF1C9241_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_64C2DF1C9241_impl*
end;//TkwApplicationGetLastHint.ParamsTypes

initialization
 TkwApplicationCancelHint.RegisterInEngine;
 {* Регистрация application_CancelHint }
 TkwApplicationIsHintVisible.RegisterInEngine;
 {* Регистрация application_IsHintVisible }
 TkwApplicationGetLastHint.RegisterInEngine;
 {* Регистрация application_GetLastHint }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts)

end.
