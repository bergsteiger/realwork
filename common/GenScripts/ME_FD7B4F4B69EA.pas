unit F1LikeTextLoadKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы F1LikeTextLoad }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoadKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , F1LikeTextLoad_Form
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
 Tkw_Form_F1LikeTextLoad = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы F1LikeTextLoad
----
*Пример использования*:
[code]
'aControl' форма::F1LikeTextLoad TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_F1LikeTextLoad

 Tkw_F1LikeTextLoad_Control_Text = {final} class(TtfwControlString)
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
 end;//Tkw_F1LikeTextLoad_Control_Text

 Tkw_F1LikeTextLoad_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_F1LikeTextLoad_Control_Text_Push

 Tkw_F1LikeTextLoad_Component_TextSource = {final} class(TtfwControlString)
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
 end;//Tkw_F1LikeTextLoad_Component_TextSource

 Tkw_F1LikeTextLoad_Component_LoadManager = {final} class(TtfwControlString)
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
 end;//Tkw_F1LikeTextLoad_Component_LoadManager

 TkwF1LikeTextLoadFormText = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeTextLoadForm.Text
[panel]Контрол Text формы TF1LikeTextLoadForm[panel]
*Тип результата:* TeeEditorExport
*Пример:*
[code]
OBJECT VAR l_TeeEditorExport
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.Text >>> l_TeeEditorExport
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeEditorExport;
    {* Реализация слова скрипта .TF1LikeTextLoadForm.Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1LikeTextLoadFormText

 TkwF1LikeTextLoadFormTextSource = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeTextLoadForm.TextSource
[panel]Контрол TextSource формы TF1LikeTextLoadForm[panel]
*Тип результата:* TeeTextSourceExport
*Пример:*
[code]
OBJECT VAR l_TeeTextSourceExport
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.TextSource >>> l_TeeTextSourceExport
[code]  }
  private
   function TextSource(const aCtx: TtfwContext;
    aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeTextSourceExport;
    {* Реализация слова скрипта .TF1LikeTextLoadForm.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1LikeTextLoadFormTextSource

 TkwF1LikeTextLoadFormLoadManager = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeTextLoadForm.LoadManager
[panel]Контрол LoadManager формы TF1LikeTextLoadForm[panel]
*Тип результата:* TevLoadDocumentManager
*Пример:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  private
   function LoadManager(const aCtx: TtfwContext;
    aF1LikeTextLoadForm: TF1LikeTextLoadForm): TevLoadDocumentManager;
    {* Реализация слова скрипта .TF1LikeTextLoadForm.LoadManager }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1LikeTextLoadFormLoadManager

class function Tkw_Form_F1LikeTextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::F1LikeTextLoad';
end;//Tkw_Form_F1LikeTextLoad.GetWordNameForRegister

function Tkw_Form_F1LikeTextLoad.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CC6531873D8E_var*
//#UC END# *4DDFD2EA0116_CC6531873D8E_var*
begin
//#UC START# *4DDFD2EA0116_CC6531873D8E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CC6531873D8E_impl*
end;//Tkw_Form_F1LikeTextLoad.GetString

class function Tkw_F1LikeTextLoad_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text';
end;//Tkw_F1LikeTextLoad_Control_Text.GetWordNameForRegister

function Tkw_F1LikeTextLoad_Control_Text.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_02540828BFD4_var*
//#UC END# *4DDFD2EA0116_02540828BFD4_var*
begin
//#UC START# *4DDFD2EA0116_02540828BFD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_02540828BFD4_impl*
end;//Tkw_F1LikeTextLoad_Control_Text.GetString

class procedure Tkw_F1LikeTextLoad_Control_Text.RegisterInEngine;
//#UC START# *52A086150180_02540828BFD4_var*
//#UC END# *52A086150180_02540828BFD4_var*
begin
//#UC START# *52A086150180_02540828BFD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_02540828BFD4_impl*
end;//Tkw_F1LikeTextLoad_Control_Text.RegisterInEngine

procedure Tkw_F1LikeTextLoad_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_244CB8ED63D3_var*
//#UC END# *4DAEEDE10285_244CB8ED63D3_var*
begin
//#UC START# *4DAEEDE10285_244CB8ED63D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_244CB8ED63D3_impl*
end;//Tkw_F1LikeTextLoad_Control_Text_Push.DoDoIt

class function Tkw_F1LikeTextLoad_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text:push';
end;//Tkw_F1LikeTextLoad_Control_Text_Push.GetWordNameForRegister

class function Tkw_F1LikeTextLoad_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_F1LikeTextLoad_Component_TextSource.GetWordNameForRegister

function Tkw_F1LikeTextLoad_Component_TextSource.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4540B5FFA739_var*
//#UC END# *4DDFD2EA0116_4540B5FFA739_var*
begin
//#UC START# *4DDFD2EA0116_4540B5FFA739_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4540B5FFA739_impl*
end;//Tkw_F1LikeTextLoad_Component_TextSource.GetString

class procedure Tkw_F1LikeTextLoad_Component_TextSource.RegisterInEngine;
//#UC START# *52A086150180_4540B5FFA739_var*
//#UC END# *52A086150180_4540B5FFA739_var*
begin
//#UC START# *52A086150180_4540B5FFA739_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4540B5FFA739_impl*
end;//Tkw_F1LikeTextLoad_Component_TextSource.RegisterInEngine

class function Tkw_F1LikeTextLoad_Component_LoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::LoadManager';
end;//Tkw_F1LikeTextLoad_Component_LoadManager.GetWordNameForRegister

function Tkw_F1LikeTextLoad_Component_LoadManager.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0A06CF3EFC75_var*
//#UC END# *4DDFD2EA0116_0A06CF3EFC75_var*
begin
//#UC START# *4DDFD2EA0116_0A06CF3EFC75_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0A06CF3EFC75_impl*
end;//Tkw_F1LikeTextLoad_Component_LoadManager.GetString

class procedure Tkw_F1LikeTextLoad_Component_LoadManager.RegisterInEngine;
//#UC START# *52A086150180_0A06CF3EFC75_var*
//#UC END# *52A086150180_0A06CF3EFC75_var*
begin
//#UC START# *52A086150180_0A06CF3EFC75_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0A06CF3EFC75_impl*
end;//Tkw_F1LikeTextLoad_Component_LoadManager.RegisterInEngine

function TkwF1LikeTextLoadFormText.Text(const aCtx: TtfwContext;
 aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeEditorExport;
 {* Реализация слова скрипта .TF1LikeTextLoadForm.Text }
//#UC START# *5223D9508B48_92E0CD11116C_var*
//#UC END# *5223D9508B48_92E0CD11116C_var*
begin
//#UC START# *5223D9508B48_92E0CD11116C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5223D9508B48_92E0CD11116C_impl*
end;//TkwF1LikeTextLoadFormText.Text

procedure TkwF1LikeTextLoadFormText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_92E0CD11116C_var*
//#UC END# *4DAEEDE10285_92E0CD11116C_var*
begin
//#UC START# *4DAEEDE10285_92E0CD11116C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_92E0CD11116C_impl*
end;//TkwF1LikeTextLoadFormText.DoDoIt

class function TkwF1LikeTextLoadFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeTextLoadForm.Text';
end;//TkwF1LikeTextLoadFormText.GetWordNameForRegister

procedure TkwF1LikeTextLoadFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_92E0CD11116C_var*
//#UC END# *52D00B00031A_92E0CD11116C_var*
begin
//#UC START# *52D00B00031A_92E0CD11116C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_92E0CD11116C_impl*
end;//TkwF1LikeTextLoadFormText.SetValuePrim

function TkwF1LikeTextLoadFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_92E0CD11116C_var*
//#UC END# *551544E2001A_92E0CD11116C_var*
begin
//#UC START# *551544E2001A_92E0CD11116C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_92E0CD11116C_impl*
end;//TkwF1LikeTextLoadFormText.GetResultTypeInfo

function TkwF1LikeTextLoadFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_92E0CD11116C_var*
//#UC END# *559687E6025A_92E0CD11116C_var*
begin
//#UC START# *559687E6025A_92E0CD11116C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_92E0CD11116C_impl*
end;//TkwF1LikeTextLoadFormText.GetAllParamsCount

function TkwF1LikeTextLoadFormText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_92E0CD11116C_var*
//#UC END# *5617F4D00243_92E0CD11116C_var*
begin
//#UC START# *5617F4D00243_92E0CD11116C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_92E0CD11116C_impl*
end;//TkwF1LikeTextLoadFormText.ParamsTypes

function TkwF1LikeTextLoadFormTextSource.TextSource(const aCtx: TtfwContext;
 aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeTextSourceExport;
 {* Реализация слова скрипта .TF1LikeTextLoadForm.TextSource }
//#UC START# *A6C169041D2E_A1D2254061BE_var*
//#UC END# *A6C169041D2E_A1D2254061BE_var*
begin
//#UC START# *A6C169041D2E_A1D2254061BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *A6C169041D2E_A1D2254061BE_impl*
end;//TkwF1LikeTextLoadFormTextSource.TextSource

procedure TkwF1LikeTextLoadFormTextSource.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A1D2254061BE_var*
//#UC END# *4DAEEDE10285_A1D2254061BE_var*
begin
//#UC START# *4DAEEDE10285_A1D2254061BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A1D2254061BE_impl*
end;//TkwF1LikeTextLoadFormTextSource.DoDoIt

class function TkwF1LikeTextLoadFormTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeTextLoadForm.TextSource';
end;//TkwF1LikeTextLoadFormTextSource.GetWordNameForRegister

procedure TkwF1LikeTextLoadFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A1D2254061BE_var*
//#UC END# *52D00B00031A_A1D2254061BE_var*
begin
//#UC START# *52D00B00031A_A1D2254061BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A1D2254061BE_impl*
end;//TkwF1LikeTextLoadFormTextSource.SetValuePrim

function TkwF1LikeTextLoadFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A1D2254061BE_var*
//#UC END# *551544E2001A_A1D2254061BE_var*
begin
//#UC START# *551544E2001A_A1D2254061BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A1D2254061BE_impl*
end;//TkwF1LikeTextLoadFormTextSource.GetResultTypeInfo

function TkwF1LikeTextLoadFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_A1D2254061BE_var*
//#UC END# *559687E6025A_A1D2254061BE_var*
begin
//#UC START# *559687E6025A_A1D2254061BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_A1D2254061BE_impl*
end;//TkwF1LikeTextLoadFormTextSource.GetAllParamsCount

function TkwF1LikeTextLoadFormTextSource.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A1D2254061BE_var*
//#UC END# *5617F4D00243_A1D2254061BE_var*
begin
//#UC START# *5617F4D00243_A1D2254061BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A1D2254061BE_impl*
end;//TkwF1LikeTextLoadFormTextSource.ParamsTypes

function TkwF1LikeTextLoadFormLoadManager.LoadManager(const aCtx: TtfwContext;
 aF1LikeTextLoadForm: TF1LikeTextLoadForm): TevLoadDocumentManager;
 {* Реализация слова скрипта .TF1LikeTextLoadForm.LoadManager }
//#UC START# *C0C210709146_8DECEC4A4E9A_var*
//#UC END# *C0C210709146_8DECEC4A4E9A_var*
begin
//#UC START# *C0C210709146_8DECEC4A4E9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *C0C210709146_8DECEC4A4E9A_impl*
end;//TkwF1LikeTextLoadFormLoadManager.LoadManager

procedure TkwF1LikeTextLoadFormLoadManager.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8DECEC4A4E9A_var*
//#UC END# *4DAEEDE10285_8DECEC4A4E9A_var*
begin
//#UC START# *4DAEEDE10285_8DECEC4A4E9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8DECEC4A4E9A_impl*
end;//TkwF1LikeTextLoadFormLoadManager.DoDoIt

class function TkwF1LikeTextLoadFormLoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeTextLoadForm.LoadManager';
end;//TkwF1LikeTextLoadFormLoadManager.GetWordNameForRegister

procedure TkwF1LikeTextLoadFormLoadManager.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8DECEC4A4E9A_var*
//#UC END# *52D00B00031A_8DECEC4A4E9A_var*
begin
//#UC START# *52D00B00031A_8DECEC4A4E9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8DECEC4A4E9A_impl*
end;//TkwF1LikeTextLoadFormLoadManager.SetValuePrim

function TkwF1LikeTextLoadFormLoadManager.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8DECEC4A4E9A_var*
//#UC END# *551544E2001A_8DECEC4A4E9A_var*
begin
//#UC START# *551544E2001A_8DECEC4A4E9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8DECEC4A4E9A_impl*
end;//TkwF1LikeTextLoadFormLoadManager.GetResultTypeInfo

function TkwF1LikeTextLoadFormLoadManager.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_8DECEC4A4E9A_var*
//#UC END# *559687E6025A_8DECEC4A4E9A_var*
begin
//#UC START# *559687E6025A_8DECEC4A4E9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_8DECEC4A4E9A_impl*
end;//TkwF1LikeTextLoadFormLoadManager.GetAllParamsCount

function TkwF1LikeTextLoadFormLoadManager.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8DECEC4A4E9A_var*
//#UC END# *5617F4D00243_8DECEC4A4E9A_var*
begin
//#UC START# *5617F4D00243_8DECEC4A4E9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8DECEC4A4E9A_impl*
end;//TkwF1LikeTextLoadFormLoadManager.ParamsTypes

initialization
 Tkw_Form_F1LikeTextLoad.RegisterInEngine;
 {* Регистрация Tkw_Form_F1LikeTextLoad }
 Tkw_F1LikeTextLoad_Control_Text.RegisterInEngine;
 {* Регистрация Tkw_F1LikeTextLoad_Control_Text }
 Tkw_F1LikeTextLoad_Control_Text_Push.RegisterInEngine;
 {* Регистрация Tkw_F1LikeTextLoad_Control_Text_Push }
 Tkw_F1LikeTextLoad_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_F1LikeTextLoad_Component_TextSource }
 Tkw_F1LikeTextLoad_Component_LoadManager.RegisterInEngine;
 {* Регистрация Tkw_F1LikeTextLoad_Component_LoadManager }
 TkwF1LikeTextLoadFormText.RegisterInEngine;
 {* Регистрация F1LikeTextLoadForm_Text }
 TkwF1LikeTextLoadFormTextSource.RegisterInEngine;
 {* Регистрация F1LikeTextLoadForm_TextSource }
 TkwF1LikeTextLoadFormLoadManager.RegisterInEngine;
 {* Регистрация F1LikeTextLoadForm_LoadManager }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TF1LikeTextLoadForm));
 {* Регистрация типа F1LikeTextLoad }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeEditorExport));
 {* Регистрация типа TeeEditorExport }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTextSourceExport));
 {* Регистрация типа TeeTextSourceExport }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevLoadDocumentManager));
 {* Регистрация типа TevLoadDocumentManager }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
