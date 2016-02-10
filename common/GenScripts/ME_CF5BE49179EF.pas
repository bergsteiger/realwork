unit F1LikeFormWithBSKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы F1LikeFormWithBS }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBSKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , F1LikeFormWithBS_Form
 {$If Defined(Nemesis)}
 , nscTreeComboWithHistoryAndOperations
 {$IfEnd} // Defined(Nemesis)
 , eeEditorExport
 {$If Defined(Nemesis)}
 , eeTextSourceExport
 {$IfEnd} // Defined(Nemesis)
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
 Tkw_Form_F1LikeFormWithBS = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы F1LikeFormWithBS
----
*Пример использования*:
[code]
'aControl' форма::F1LikeFormWithBS TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_F1LikeFormWithBS

 Tkw_F1LikeFormWithBS_Control_BaseSearchControl = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BaseSearchControl
----
*Пример использования*:
[code]
контрол::BaseSearchControl TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl

 Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BaseSearchControl
----
*Пример использования*:
[code]
контрол::BaseSearchControl:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push

 Tkw_F1LikeFormWithBS_Control_Text = {final} class(TtfwControlString)
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
 end;//Tkw_F1LikeFormWithBS_Control_Text

 Tkw_F1LikeFormWithBS_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_F1LikeFormWithBS_Control_Text_Push

 Tkw_F1LikeFormWithBS_Component_TextSource = {final} class(TtfwControlString)
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
 end;//Tkw_F1LikeFormWithBS_Component_TextSource

 Tkw_F1LikeFormWithBS_Component_LoadManager = {final} class(TtfwControlString)
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
 end;//Tkw_F1LikeFormWithBS_Component_LoadManager

 TkwF1LikeFormWithBSFormBaseSearchControl = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeFormWithBSForm.BaseSearchControl
[panel]Контрол BaseSearchControl формы TF1LikeFormWithBSForm[panel]
*Тип результата:* TnscTreeComboWithHistoryAndOperations
*Пример:*
[code]
OBJECT VAR l_TnscTreeComboWithHistoryAndOperations
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.BaseSearchControl >>> l_TnscTreeComboWithHistoryAndOperations
[code]  }
  private
   function BaseSearchControl(const aCtx: TtfwContext;
    aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TnscTreeComboWithHistoryAndOperations;
    {* Реализация слова скрипта .TF1LikeFormWithBSForm.BaseSearchControl }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1LikeFormWithBSFormBaseSearchControl

 TkwF1LikeFormWithBSFormText = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeFormWithBSForm.Text
[panel]Контрол Text формы TF1LikeFormWithBSForm[panel]
*Тип результата:* TeeEditorExport
*Пример:*
[code]
OBJECT VAR l_TeeEditorExport
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.Text >>> l_TeeEditorExport
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeEditorExport;
    {* Реализация слова скрипта .TF1LikeFormWithBSForm.Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1LikeFormWithBSFormText

 TkwF1LikeFormWithBSFormTextSource = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeFormWithBSForm.TextSource
[panel]Контрол TextSource формы TF1LikeFormWithBSForm[panel]
*Тип результата:* TeeTextSourceExport
*Пример:*
[code]
OBJECT VAR l_TeeTextSourceExport
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.TextSource >>> l_TeeTextSourceExport
[code]  }
  private
   function TextSource(const aCtx: TtfwContext;
    aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeTextSourceExport;
    {* Реализация слова скрипта .TF1LikeFormWithBSForm.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1LikeFormWithBSFormTextSource

 TkwF1LikeFormWithBSFormLoadManager = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeFormWithBSForm.LoadManager
[panel]Контрол LoadManager формы TF1LikeFormWithBSForm[panel]
*Тип результата:* TevLoadDocumentManager
*Пример:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  private
   function LoadManager(const aCtx: TtfwContext;
    aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TevLoadDocumentManager;
    {* Реализация слова скрипта .TF1LikeFormWithBSForm.LoadManager }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1LikeFormWithBSFormLoadManager

class function Tkw_Form_F1LikeFormWithBS.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::F1LikeFormWithBS';
end;//Tkw_Form_F1LikeFormWithBS.GetWordNameForRegister

function Tkw_Form_F1LikeFormWithBS.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7372C331829E_var*
//#UC END# *4DDFD2EA0116_7372C331829E_var*
begin
//#UC START# *4DDFD2EA0116_7372C331829E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7372C331829E_impl*
end;//Tkw_Form_F1LikeFormWithBS.GetString

class function Tkw_F1LikeFormWithBS_Control_BaseSearchControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BaseSearchControl';
end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl.GetWordNameForRegister

function Tkw_F1LikeFormWithBS_Control_BaseSearchControl.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9A1294D3ACEE_var*
//#UC END# *4DDFD2EA0116_9A1294D3ACEE_var*
begin
//#UC START# *4DDFD2EA0116_9A1294D3ACEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9A1294D3ACEE_impl*
end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl.GetString

class procedure Tkw_F1LikeFormWithBS_Control_BaseSearchControl.RegisterInEngine;
//#UC START# *52A086150180_9A1294D3ACEE_var*
//#UC END# *52A086150180_9A1294D3ACEE_var*
begin
//#UC START# *52A086150180_9A1294D3ACEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9A1294D3ACEE_impl*
end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl.RegisterInEngine

procedure Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A2A08F87EBF9_var*
//#UC END# *4DAEEDE10285_A2A08F87EBF9_var*
begin
//#UC START# *4DAEEDE10285_A2A08F87EBF9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A2A08F87EBF9_impl*
end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push.DoDoIt

class function Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BaseSearchControl:push';
end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push.GetWordNameForRegister

class function Tkw_F1LikeFormWithBS_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text';
end;//Tkw_F1LikeFormWithBS_Control_Text.GetWordNameForRegister

function Tkw_F1LikeFormWithBS_Control_Text.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CA93D80FB47F_var*
//#UC END# *4DDFD2EA0116_CA93D80FB47F_var*
begin
//#UC START# *4DDFD2EA0116_CA93D80FB47F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CA93D80FB47F_impl*
end;//Tkw_F1LikeFormWithBS_Control_Text.GetString

class procedure Tkw_F1LikeFormWithBS_Control_Text.RegisterInEngine;
//#UC START# *52A086150180_CA93D80FB47F_var*
//#UC END# *52A086150180_CA93D80FB47F_var*
begin
//#UC START# *52A086150180_CA93D80FB47F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CA93D80FB47F_impl*
end;//Tkw_F1LikeFormWithBS_Control_Text.RegisterInEngine

procedure Tkw_F1LikeFormWithBS_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_63B6777B2481_var*
//#UC END# *4DAEEDE10285_63B6777B2481_var*
begin
//#UC START# *4DAEEDE10285_63B6777B2481_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_63B6777B2481_impl*
end;//Tkw_F1LikeFormWithBS_Control_Text_Push.DoDoIt

class function Tkw_F1LikeFormWithBS_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text:push';
end;//Tkw_F1LikeFormWithBS_Control_Text_Push.GetWordNameForRegister

class function Tkw_F1LikeFormWithBS_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_F1LikeFormWithBS_Component_TextSource.GetWordNameForRegister

function Tkw_F1LikeFormWithBS_Component_TextSource.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_34D2256ABB71_var*
//#UC END# *4DDFD2EA0116_34D2256ABB71_var*
begin
//#UC START# *4DDFD2EA0116_34D2256ABB71_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_34D2256ABB71_impl*
end;//Tkw_F1LikeFormWithBS_Component_TextSource.GetString

class procedure Tkw_F1LikeFormWithBS_Component_TextSource.RegisterInEngine;
//#UC START# *52A086150180_34D2256ABB71_var*
//#UC END# *52A086150180_34D2256ABB71_var*
begin
//#UC START# *52A086150180_34D2256ABB71_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_34D2256ABB71_impl*
end;//Tkw_F1LikeFormWithBS_Component_TextSource.RegisterInEngine

class function Tkw_F1LikeFormWithBS_Component_LoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::LoadManager';
end;//Tkw_F1LikeFormWithBS_Component_LoadManager.GetWordNameForRegister

function Tkw_F1LikeFormWithBS_Component_LoadManager.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EF79220AA985_var*
//#UC END# *4DDFD2EA0116_EF79220AA985_var*
begin
//#UC START# *4DDFD2EA0116_EF79220AA985_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EF79220AA985_impl*
end;//Tkw_F1LikeFormWithBS_Component_LoadManager.GetString

class procedure Tkw_F1LikeFormWithBS_Component_LoadManager.RegisterInEngine;
//#UC START# *52A086150180_EF79220AA985_var*
//#UC END# *52A086150180_EF79220AA985_var*
begin
//#UC START# *52A086150180_EF79220AA985_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EF79220AA985_impl*
end;//Tkw_F1LikeFormWithBS_Component_LoadManager.RegisterInEngine

function TkwF1LikeFormWithBSFormBaseSearchControl.BaseSearchControl(const aCtx: TtfwContext;
 aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TnscTreeComboWithHistoryAndOperations;
 {* Реализация слова скрипта .TF1LikeFormWithBSForm.BaseSearchControl }
//#UC START# *0893F9F458C8_136DA0DCC3CD_var*
//#UC END# *0893F9F458C8_136DA0DCC3CD_var*
begin
//#UC START# *0893F9F458C8_136DA0DCC3CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *0893F9F458C8_136DA0DCC3CD_impl*
end;//TkwF1LikeFormWithBSFormBaseSearchControl.BaseSearchControl

procedure TkwF1LikeFormWithBSFormBaseSearchControl.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_136DA0DCC3CD_var*
//#UC END# *4DAEEDE10285_136DA0DCC3CD_var*
begin
//#UC START# *4DAEEDE10285_136DA0DCC3CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_136DA0DCC3CD_impl*
end;//TkwF1LikeFormWithBSFormBaseSearchControl.DoDoIt

class function TkwF1LikeFormWithBSFormBaseSearchControl.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeFormWithBSForm.BaseSearchControl';
end;//TkwF1LikeFormWithBSFormBaseSearchControl.GetWordNameForRegister

procedure TkwF1LikeFormWithBSFormBaseSearchControl.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_136DA0DCC3CD_var*
//#UC END# *52D00B00031A_136DA0DCC3CD_var*
begin
//#UC START# *52D00B00031A_136DA0DCC3CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_136DA0DCC3CD_impl*
end;//TkwF1LikeFormWithBSFormBaseSearchControl.SetValuePrim

function TkwF1LikeFormWithBSFormBaseSearchControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeComboWithHistoryAndOperations);
end;//TkwF1LikeFormWithBSFormBaseSearchControl.GetResultTypeInfo

function TkwF1LikeFormWithBSFormBaseSearchControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeFormWithBSFormBaseSearchControl.GetAllParamsCount

function TkwF1LikeFormWithBSFormBaseSearchControl.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_136DA0DCC3CD_var*
//#UC END# *5617F4D00243_136DA0DCC3CD_var*
begin
//#UC START# *5617F4D00243_136DA0DCC3CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_136DA0DCC3CD_impl*
end;//TkwF1LikeFormWithBSFormBaseSearchControl.ParamsTypes

function TkwF1LikeFormWithBSFormText.Text(const aCtx: TtfwContext;
 aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeEditorExport;
 {* Реализация слова скрипта .TF1LikeFormWithBSForm.Text }
//#UC START# *3A2B72861D87_0261BE97F6D3_var*
//#UC END# *3A2B72861D87_0261BE97F6D3_var*
begin
//#UC START# *3A2B72861D87_0261BE97F6D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A2B72861D87_0261BE97F6D3_impl*
end;//TkwF1LikeFormWithBSFormText.Text

procedure TkwF1LikeFormWithBSFormText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0261BE97F6D3_var*
//#UC END# *4DAEEDE10285_0261BE97F6D3_var*
begin
//#UC START# *4DAEEDE10285_0261BE97F6D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0261BE97F6D3_impl*
end;//TkwF1LikeFormWithBSFormText.DoDoIt

class function TkwF1LikeFormWithBSFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeFormWithBSForm.Text';
end;//TkwF1LikeFormWithBSFormText.GetWordNameForRegister

procedure TkwF1LikeFormWithBSFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0261BE97F6D3_var*
//#UC END# *52D00B00031A_0261BE97F6D3_var*
begin
//#UC START# *52D00B00031A_0261BE97F6D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0261BE97F6D3_impl*
end;//TkwF1LikeFormWithBSFormText.SetValuePrim

function TkwF1LikeFormWithBSFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeEditorExport);
end;//TkwF1LikeFormWithBSFormText.GetResultTypeInfo

function TkwF1LikeFormWithBSFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeFormWithBSFormText.GetAllParamsCount

function TkwF1LikeFormWithBSFormText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0261BE97F6D3_var*
//#UC END# *5617F4D00243_0261BE97F6D3_var*
begin
//#UC START# *5617F4D00243_0261BE97F6D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0261BE97F6D3_impl*
end;//TkwF1LikeFormWithBSFormText.ParamsTypes

function TkwF1LikeFormWithBSFormTextSource.TextSource(const aCtx: TtfwContext;
 aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeTextSourceExport;
 {* Реализация слова скрипта .TF1LikeFormWithBSForm.TextSource }
//#UC START# *C5216B007203_F2D78F0C5EE9_var*
//#UC END# *C5216B007203_F2D78F0C5EE9_var*
begin
//#UC START# *C5216B007203_F2D78F0C5EE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *C5216B007203_F2D78F0C5EE9_impl*
end;//TkwF1LikeFormWithBSFormTextSource.TextSource

procedure TkwF1LikeFormWithBSFormTextSource.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F2D78F0C5EE9_var*
//#UC END# *4DAEEDE10285_F2D78F0C5EE9_var*
begin
//#UC START# *4DAEEDE10285_F2D78F0C5EE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F2D78F0C5EE9_impl*
end;//TkwF1LikeFormWithBSFormTextSource.DoDoIt

class function TkwF1LikeFormWithBSFormTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeFormWithBSForm.TextSource';
end;//TkwF1LikeFormWithBSFormTextSource.GetWordNameForRegister

procedure TkwF1LikeFormWithBSFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F2D78F0C5EE9_var*
//#UC END# *52D00B00031A_F2D78F0C5EE9_var*
begin
//#UC START# *52D00B00031A_F2D78F0C5EE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F2D78F0C5EE9_impl*
end;//TkwF1LikeFormWithBSFormTextSource.SetValuePrim

function TkwF1LikeFormWithBSFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTextSourceExport);
end;//TkwF1LikeFormWithBSFormTextSource.GetResultTypeInfo

function TkwF1LikeFormWithBSFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeFormWithBSFormTextSource.GetAllParamsCount

function TkwF1LikeFormWithBSFormTextSource.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F2D78F0C5EE9_var*
//#UC END# *5617F4D00243_F2D78F0C5EE9_var*
begin
//#UC START# *5617F4D00243_F2D78F0C5EE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F2D78F0C5EE9_impl*
end;//TkwF1LikeFormWithBSFormTextSource.ParamsTypes

function TkwF1LikeFormWithBSFormLoadManager.LoadManager(const aCtx: TtfwContext;
 aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TevLoadDocumentManager;
 {* Реализация слова скрипта .TF1LikeFormWithBSForm.LoadManager }
//#UC START# *FEAC64D6A9AB_0296E955C9A5_var*
//#UC END# *FEAC64D6A9AB_0296E955C9A5_var*
begin
//#UC START# *FEAC64D6A9AB_0296E955C9A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *FEAC64D6A9AB_0296E955C9A5_impl*
end;//TkwF1LikeFormWithBSFormLoadManager.LoadManager

procedure TkwF1LikeFormWithBSFormLoadManager.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0296E955C9A5_var*
//#UC END# *4DAEEDE10285_0296E955C9A5_var*
begin
//#UC START# *4DAEEDE10285_0296E955C9A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0296E955C9A5_impl*
end;//TkwF1LikeFormWithBSFormLoadManager.DoDoIt

class function TkwF1LikeFormWithBSFormLoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeFormWithBSForm.LoadManager';
end;//TkwF1LikeFormWithBSFormLoadManager.GetWordNameForRegister

procedure TkwF1LikeFormWithBSFormLoadManager.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0296E955C9A5_var*
//#UC END# *52D00B00031A_0296E955C9A5_var*
begin
//#UC START# *52D00B00031A_0296E955C9A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0296E955C9A5_impl*
end;//TkwF1LikeFormWithBSFormLoadManager.SetValuePrim

function TkwF1LikeFormWithBSFormLoadManager.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevLoadDocumentManager);
end;//TkwF1LikeFormWithBSFormLoadManager.GetResultTypeInfo

function TkwF1LikeFormWithBSFormLoadManager.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeFormWithBSFormLoadManager.GetAllParamsCount

function TkwF1LikeFormWithBSFormLoadManager.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0296E955C9A5_var*
//#UC END# *5617F4D00243_0296E955C9A5_var*
begin
//#UC START# *5617F4D00243_0296E955C9A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0296E955C9A5_impl*
end;//TkwF1LikeFormWithBSFormLoadManager.ParamsTypes

initialization
 Tkw_Form_F1LikeFormWithBS.RegisterInEngine;
 {* Регистрация Tkw_Form_F1LikeFormWithBS }
 Tkw_F1LikeFormWithBS_Control_BaseSearchControl.RegisterInEngine;
 {* Регистрация Tkw_F1LikeFormWithBS_Control_BaseSearchControl }
 Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push.RegisterInEngine;
 {* Регистрация Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push }
 Tkw_F1LikeFormWithBS_Control_Text.RegisterInEngine;
 {* Регистрация Tkw_F1LikeFormWithBS_Control_Text }
 Tkw_F1LikeFormWithBS_Control_Text_Push.RegisterInEngine;
 {* Регистрация Tkw_F1LikeFormWithBS_Control_Text_Push }
 Tkw_F1LikeFormWithBS_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_F1LikeFormWithBS_Component_TextSource }
 Tkw_F1LikeFormWithBS_Component_LoadManager.RegisterInEngine;
 {* Регистрация Tkw_F1LikeFormWithBS_Component_LoadManager }
 TkwF1LikeFormWithBSFormBaseSearchControl.RegisterInEngine;
 {* Регистрация F1LikeFormWithBSForm_BaseSearchControl }
 TkwF1LikeFormWithBSFormText.RegisterInEngine;
 {* Регистрация F1LikeFormWithBSForm_Text }
 TkwF1LikeFormWithBSFormTextSource.RegisterInEngine;
 {* Регистрация F1LikeFormWithBSForm_TextSource }
 TkwF1LikeFormWithBSFormLoadManager.RegisterInEngine;
 {* Регистрация F1LikeFormWithBSForm_LoadManager }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TF1LikeFormWithBSForm));
 {* Регистрация типа F1LikeFormWithBS }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeComboWithHistoryAndOperations));
 {* Регистрация типа TnscTreeComboWithHistoryAndOperations }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeEditorExport));
 {* Регистрация типа TeeEditorExport }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTextSourceExport));
 {* Регистрация типа TeeTextSourceExport }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevLoadDocumentManager));
 {* Регистрация типа TevLoadDocumentManager }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
