unit vtHintWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\vtHintWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "vtHintWordsPack" MUID: (54EC8A6F01D7)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , TypInfo
 , tfwScriptingInterfaces
 , l3Interfaces
 , vtHintManager
 , Windows
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwApplicationCancelHint = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:CancelHint }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwApplicationCancelHint

 TkwApplicationIsHintVisible = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:IsHintVisible }
  private
   function application_IsHintVisible(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта application:IsHintVisible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwApplicationIsHintVisible

 TkwApplicationGetLastHint = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:GetLastHint }
  private
   function application_GetLastHint(const aCtx: TtfwContext): Il3CString;
    {* Реализация слова скрипта application:GetLastHint }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwApplicationGetLastHint

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

function TkwApplicationCancelHint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwApplicationCancelHint.ParamsTypes

procedure TkwApplicationCancelHint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_552FAFAA0226_Word_var*
//#UC END# *4DAEEDE10285_552FAFAA0226_Word_var*
begin
//#UC START# *4DAEEDE10285_552FAFAA0226_Word_impl*
 with TvtHintManager.Instance do
  if Count > 0 then
   ShowWindow(Item[Count - 1].Handle, SW_HIDE);
//#UC END# *4DAEEDE10285_552FAFAA0226_Word_impl*
end;//TkwApplicationCancelHint.DoDoIt

function TkwApplicationIsHintVisible.application_IsHintVisible(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта application:IsHintVisible }
//#UC START# *552FAFB6009F_552FAFB6009F_Word_var*
//#UC END# *552FAFB6009F_552FAFB6009F_Word_var*
begin
//#UC START# *552FAFB6009F_552FAFB6009F_Word_impl*
 with TvtHintManager.Instance do
  Result := ((Count > 0) and IsWindowVisible(Item[Count - 1].Handle));
//#UC END# *552FAFB6009F_552FAFB6009F_Word_impl*
end;//TkwApplicationIsHintVisible.application_IsHintVisible

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
begin
 Result := OpenTypesToTypes([]);
end;//TkwApplicationIsHintVisible.ParamsTypes

procedure TkwApplicationIsHintVisible.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(application_IsHintVisible(aCtx));
end;//TkwApplicationIsHintVisible.DoDoIt

function TkwApplicationGetLastHint.application_GetLastHint(const aCtx: TtfwContext): Il3CString;
 {* Реализация слова скрипта application:GetLastHint }
//#UC START# *552FAFDC0324_552FAFDC0324_Word_var*
//#UC END# *552FAFDC0324_552FAFDC0324_Word_var*
begin
//#UC START# *552FAFDC0324_552FAFDC0324_Word_impl*
 with TvtHintManager.Instance do
  if Count > 0 then
   Result := Item[Count - 1].LastHint
  else
   Result := TtfwCStringFactory.C('');
//#UC END# *552FAFDC0324_552FAFDC0324_Word_impl*
end;//TkwApplicationGetLastHint.application_GetLastHint

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
begin
 Result := OpenTypesToTypes([]);
end;//TkwApplicationGetLastHint.ParamsTypes

procedure TkwApplicationGetLastHint.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(application_GetLastHint(aCtx));
end;//TkwApplicationGetLastHint.DoDoIt

initialization
 TkwApplicationCancelHint.RegisterInEngine;
 {* Регистрация application_CancelHint }
 TkwApplicationIsHintVisible.RegisterInEngine;
 {* Регистрация application_IsHintVisible }
 TkwApplicationGetLastHint.RegisterInEngine;
 {* Регистрация application_GetLastHint }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
