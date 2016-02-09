unit TextLoadKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы TextLoad }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\TextLoadKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextLoad_Form
 , evEditor
 , evTextSource
 , evLoadDocumentManager
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_TextLoad = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы TextLoad
----
*Пример использования*:
[code]
'aControl' форма::TextLoad TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TextLoad

 Tkw_TextLoad_Control_Text = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Text
----
*Пример использования*:
[code]
контрол::Text TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TextLoad_Control_Text

 Tkw_TextLoad_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TextLoad_Control_Text_Push

 Tkw_TextLoad_Component_TextSource = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TextLoad_Component_TextSource

 Tkw_TextLoad_Component_LoadManager = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LoadManager
----
*Пример использования*:
[code]
компонент::LoadManager TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TextLoad_Component_LoadManager

 TkwTextLoadFormText = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextLoadForm.Text
[panel]Контрол Text формы TTextLoadForm[panel]
*Тип результата:* TevEditor
*Пример:*
[code]
OBJECT VAR l_TevEditor
 aTextLoadForm .TTextLoadForm.Text >>> l_TevEditor
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aTextLoadForm: TTextLoadForm): TevEditor;
    {* Реализация слова скрипта .TTextLoadForm.Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextLoadFormText

 TkwTextLoadFormTextSource = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextLoadForm.TextSource
[panel]Контрол TextSource формы TTextLoadForm[panel]
*Тип результата:* TevTextSource
*Пример:*
[code]
OBJECT VAR l_TevTextSource
 aTextLoadForm .TTextLoadForm.TextSource >>> l_TevTextSource
[code]  }
  private
   function TextSource(const aCtx: TtfwContext;
    aTextLoadForm: TTextLoadForm): TevTextSource;
    {* Реализация слова скрипта .TTextLoadForm.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextLoadFormTextSource

 TkwTextLoadFormLoadManager = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTextLoadForm.LoadManager
[panel]Контрол LoadManager формы TTextLoadForm[panel]
*Тип результата:* TevLoadDocumentManager
*Пример:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aTextLoadForm .TTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  private
   function LoadManager(const aCtx: TtfwContext;
    aTextLoadForm: TTextLoadForm): TevLoadDocumentManager;
    {* Реализация слова скрипта .TTextLoadForm.LoadManager }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextLoadFormLoadManager

class function Tkw_Form_TextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::TextLoad';
end;//Tkw_Form_TextLoad.GetWordNameForRegister

function Tkw_Form_TextLoad.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B837DA74DBC9_var*
//#UC END# *4DDFD2EA0116_B837DA74DBC9_var*
begin
//#UC START# *4DDFD2EA0116_B837DA74DBC9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B837DA74DBC9_impl*
end;//Tkw_Form_TextLoad.GetString

class function Tkw_TextLoad_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text';
end;//Tkw_TextLoad_Control_Text.GetWordNameForRegister

function Tkw_TextLoad_Control_Text.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F65C91769460_var*
//#UC END# *4DDFD2EA0116_F65C91769460_var*
begin
//#UC START# *4DDFD2EA0116_F65C91769460_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F65C91769460_impl*
end;//Tkw_TextLoad_Control_Text.GetString

class procedure Tkw_TextLoad_Control_Text.RegisterInEngine;
//#UC START# *52A086150180_F65C91769460_var*
//#UC END# *52A086150180_F65C91769460_var*
begin
//#UC START# *52A086150180_F65C91769460_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F65C91769460_impl*
end;//Tkw_TextLoad_Control_Text.RegisterInEngine

procedure Tkw_TextLoad_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_59B3098A6C26_var*
//#UC END# *4DAEEDE10285_59B3098A6C26_var*
begin
//#UC START# *4DAEEDE10285_59B3098A6C26_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_59B3098A6C26_impl*
end;//Tkw_TextLoad_Control_Text_Push.DoDoIt

class function Tkw_TextLoad_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text:push';
end;//Tkw_TextLoad_Control_Text_Push.GetWordNameForRegister

class function Tkw_TextLoad_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_TextLoad_Component_TextSource.GetWordNameForRegister

function Tkw_TextLoad_Component_TextSource.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B67F088B1D29_var*
//#UC END# *4DDFD2EA0116_B67F088B1D29_var*
begin
//#UC START# *4DDFD2EA0116_B67F088B1D29_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B67F088B1D29_impl*
end;//Tkw_TextLoad_Component_TextSource.GetString

class procedure Tkw_TextLoad_Component_TextSource.RegisterInEngine;
//#UC START# *52A086150180_B67F088B1D29_var*
//#UC END# *52A086150180_B67F088B1D29_var*
begin
//#UC START# *52A086150180_B67F088B1D29_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B67F088B1D29_impl*
end;//Tkw_TextLoad_Component_TextSource.RegisterInEngine

class function Tkw_TextLoad_Component_LoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::LoadManager';
end;//Tkw_TextLoad_Component_LoadManager.GetWordNameForRegister

function Tkw_TextLoad_Component_LoadManager.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4B79DA077628_var*
//#UC END# *4DDFD2EA0116_4B79DA077628_var*
begin
//#UC START# *4DDFD2EA0116_4B79DA077628_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4B79DA077628_impl*
end;//Tkw_TextLoad_Component_LoadManager.GetString

class procedure Tkw_TextLoad_Component_LoadManager.RegisterInEngine;
//#UC START# *52A086150180_4B79DA077628_var*
//#UC END# *52A086150180_4B79DA077628_var*
begin
//#UC START# *52A086150180_4B79DA077628_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4B79DA077628_impl*
end;//Tkw_TextLoad_Component_LoadManager.RegisterInEngine

function TkwTextLoadFormText.Text(const aCtx: TtfwContext;
 aTextLoadForm: TTextLoadForm): TevEditor;
 {* Реализация слова скрипта .TTextLoadForm.Text }
//#UC START# *A1D2F81F7E32_3A01E87E6153_var*
//#UC END# *A1D2F81F7E32_3A01E87E6153_var*
begin
//#UC START# *A1D2F81F7E32_3A01E87E6153_impl*
 !!! Needs to be implemented !!!
//#UC END# *A1D2F81F7E32_3A01E87E6153_impl*
end;//TkwTextLoadFormText.Text

procedure TkwTextLoadFormText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3A01E87E6153_var*
//#UC END# *4DAEEDE10285_3A01E87E6153_var*
begin
//#UC START# *4DAEEDE10285_3A01E87E6153_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3A01E87E6153_impl*
end;//TkwTextLoadFormText.DoDoIt

class function TkwTextLoadFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextLoadForm.Text';
end;//TkwTextLoadFormText.GetWordNameForRegister

procedure TkwTextLoadFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3A01E87E6153_var*
//#UC END# *52D00B00031A_3A01E87E6153_var*
begin
//#UC START# *52D00B00031A_3A01E87E6153_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3A01E87E6153_impl*
end;//TkwTextLoadFormText.SetValuePrim

function TkwTextLoadFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3A01E87E6153_var*
//#UC END# *551544E2001A_3A01E87E6153_var*
begin
//#UC START# *551544E2001A_3A01E87E6153_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3A01E87E6153_impl*
end;//TkwTextLoadFormText.GetResultTypeInfo

function TkwTextLoadFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextLoadFormText.GetAllParamsCount

function TkwTextLoadFormText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3A01E87E6153_var*
//#UC END# *5617F4D00243_3A01E87E6153_var*
begin
//#UC START# *5617F4D00243_3A01E87E6153_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3A01E87E6153_impl*
end;//TkwTextLoadFormText.ParamsTypes

function TkwTextLoadFormTextSource.TextSource(const aCtx: TtfwContext;
 aTextLoadForm: TTextLoadForm): TevTextSource;
 {* Реализация слова скрипта .TTextLoadForm.TextSource }
//#UC START# *4795B0E3B6F9_D6313D19545C_var*
//#UC END# *4795B0E3B6F9_D6313D19545C_var*
begin
//#UC START# *4795B0E3B6F9_D6313D19545C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4795B0E3B6F9_D6313D19545C_impl*
end;//TkwTextLoadFormTextSource.TextSource

procedure TkwTextLoadFormTextSource.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D6313D19545C_var*
//#UC END# *4DAEEDE10285_D6313D19545C_var*
begin
//#UC START# *4DAEEDE10285_D6313D19545C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D6313D19545C_impl*
end;//TkwTextLoadFormTextSource.DoDoIt

class function TkwTextLoadFormTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextLoadForm.TextSource';
end;//TkwTextLoadFormTextSource.GetWordNameForRegister

procedure TkwTextLoadFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D6313D19545C_var*
//#UC END# *52D00B00031A_D6313D19545C_var*
begin
//#UC START# *52D00B00031A_D6313D19545C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D6313D19545C_impl*
end;//TkwTextLoadFormTextSource.SetValuePrim

function TkwTextLoadFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D6313D19545C_var*
//#UC END# *551544E2001A_D6313D19545C_var*
begin
//#UC START# *551544E2001A_D6313D19545C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D6313D19545C_impl*
end;//TkwTextLoadFormTextSource.GetResultTypeInfo

function TkwTextLoadFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextLoadFormTextSource.GetAllParamsCount

function TkwTextLoadFormTextSource.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D6313D19545C_var*
//#UC END# *5617F4D00243_D6313D19545C_var*
begin
//#UC START# *5617F4D00243_D6313D19545C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D6313D19545C_impl*
end;//TkwTextLoadFormTextSource.ParamsTypes

function TkwTextLoadFormLoadManager.LoadManager(const aCtx: TtfwContext;
 aTextLoadForm: TTextLoadForm): TevLoadDocumentManager;
 {* Реализация слова скрипта .TTextLoadForm.LoadManager }
//#UC START# *9D8356A1CD46_C123391CA040_var*
//#UC END# *9D8356A1CD46_C123391CA040_var*
begin
//#UC START# *9D8356A1CD46_C123391CA040_impl*
 !!! Needs to be implemented !!!
//#UC END# *9D8356A1CD46_C123391CA040_impl*
end;//TkwTextLoadFormLoadManager.LoadManager

procedure TkwTextLoadFormLoadManager.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C123391CA040_var*
//#UC END# *4DAEEDE10285_C123391CA040_var*
begin
//#UC START# *4DAEEDE10285_C123391CA040_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C123391CA040_impl*
end;//TkwTextLoadFormLoadManager.DoDoIt

class function TkwTextLoadFormLoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTextLoadForm.LoadManager';
end;//TkwTextLoadFormLoadManager.GetWordNameForRegister

procedure TkwTextLoadFormLoadManager.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C123391CA040_var*
//#UC END# *52D00B00031A_C123391CA040_var*
begin
//#UC START# *52D00B00031A_C123391CA040_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C123391CA040_impl*
end;//TkwTextLoadFormLoadManager.SetValuePrim

function TkwTextLoadFormLoadManager.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C123391CA040_var*
//#UC END# *551544E2001A_C123391CA040_var*
begin
//#UC START# *551544E2001A_C123391CA040_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C123391CA040_impl*
end;//TkwTextLoadFormLoadManager.GetResultTypeInfo

function TkwTextLoadFormLoadManager.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTextLoadFormLoadManager.GetAllParamsCount

function TkwTextLoadFormLoadManager.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C123391CA040_var*
//#UC END# *5617F4D00243_C123391CA040_var*
begin
//#UC START# *5617F4D00243_C123391CA040_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C123391CA040_impl*
end;//TkwTextLoadFormLoadManager.ParamsTypes

initialization
 Tkw_Form_TextLoad.RegisterInEngine;
 {* Регистрация Tkw_Form_TextLoad }
 Tkw_TextLoad_Control_Text.RegisterInEngine;
 {* Регистрация Tkw_TextLoad_Control_Text }
 Tkw_TextLoad_Control_Text_Push.RegisterInEngine;
 {* Регистрация Tkw_TextLoad_Control_Text_Push }
 Tkw_TextLoad_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_TextLoad_Component_TextSource }
 Tkw_TextLoad_Component_LoadManager.RegisterInEngine;
 {* Регистрация Tkw_TextLoad_Component_LoadManager }
 TkwTextLoadFormText.RegisterInEngine;
 {* Регистрация TextLoadForm_Text }
 TkwTextLoadFormTextSource.RegisterInEngine;
 {* Регистрация TextLoadForm_TextSource }
 TkwTextLoadFormLoadManager.RegisterInEngine;
 {* Регистрация TextLoadForm_LoadManager }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTextLoadForm));
 {* Регистрация типа TextLoad }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevEditor));
 {* Регистрация типа TevEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevTextSource));
 {* Регистрация типа TevTextSource }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevLoadDocumentManager));
 {* Регистрация типа TevLoadDocumentManager }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
