unit ChangesBetweenEditonsKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ChangesBetweenEditons }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\ChangesBetweenEditonsKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ChangesBetweenEditions_Module
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , SysUtils
;

type
 Tkw_Form_ChangesBetweenEditons = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ChangesBetweenEditons
----
*Пример использования*:
[code]
'aControl' форма::ChangesBetweenEditons TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ChangesBetweenEditons

 Tkw_ChangesBetweenEditons_Control_Text = {final} class(TtfwControlString)
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
 end;//Tkw_ChangesBetweenEditons_Control_Text

 Tkw_ChangesBetweenEditons_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChangesBetweenEditons_Control_Text_Push

 Tkw_ChangesBetweenEditons_Component_TextSource = {final} class(TtfwControlString)
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
 end;//Tkw_ChangesBetweenEditons_Component_TextSource

 TkwChangesBetweenEditonsFormText = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChangesBetweenEditonsForm.Text
[panel]Контрол Text формы TChangesBetweenEditonsForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aChangesBetweenEditonsForm .TChangesBetweenEditonsForm.Text >>> l_TnscEditor
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aChangesBetweenEditonsForm: TChangesBetweenEditonsForm): TnscEditor;
    {* Реализация слова скрипта .TChangesBetweenEditonsForm.Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChangesBetweenEditonsFormText

class function Tkw_Form_ChangesBetweenEditons.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ChangesBetweenEditons';
end;//Tkw_Form_ChangesBetweenEditons.GetWordNameForRegister

function Tkw_Form_ChangesBetweenEditons.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_67948A4EBDB0_var*
//#UC END# *4DDFD2EA0116_67948A4EBDB0_var*
begin
//#UC START# *4DDFD2EA0116_67948A4EBDB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_67948A4EBDB0_impl*
end;//Tkw_Form_ChangesBetweenEditons.GetString

class function Tkw_ChangesBetweenEditons_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text';
end;//Tkw_ChangesBetweenEditons_Control_Text.GetWordNameForRegister

function Tkw_ChangesBetweenEditons_Control_Text.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1BA38271BDB3_var*
//#UC END# *4DDFD2EA0116_1BA38271BDB3_var*
begin
//#UC START# *4DDFD2EA0116_1BA38271BDB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1BA38271BDB3_impl*
end;//Tkw_ChangesBetweenEditons_Control_Text.GetString

class procedure Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine;
//#UC START# *52A086150180_1BA38271BDB3_var*
//#UC END# *52A086150180_1BA38271BDB3_var*
begin
//#UC START# *52A086150180_1BA38271BDB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1BA38271BDB3_impl*
end;//Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine

procedure Tkw_ChangesBetweenEditons_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_94A27C77E601_var*
//#UC END# *4DAEEDE10285_94A27C77E601_var*
begin
//#UC START# *4DAEEDE10285_94A27C77E601_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_94A27C77E601_impl*
end;//Tkw_ChangesBetweenEditons_Control_Text_Push.DoDoIt

class function Tkw_ChangesBetweenEditons_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text:push';
end;//Tkw_ChangesBetweenEditons_Control_Text_Push.GetWordNameForRegister

class function Tkw_ChangesBetweenEditons_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_ChangesBetweenEditons_Component_TextSource.GetWordNameForRegister

function Tkw_ChangesBetweenEditons_Component_TextSource.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_213CB8D54D9D_var*
//#UC END# *4DDFD2EA0116_213CB8D54D9D_var*
begin
//#UC START# *4DDFD2EA0116_213CB8D54D9D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_213CB8D54D9D_impl*
end;//Tkw_ChangesBetweenEditons_Component_TextSource.GetString

class procedure Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine;
//#UC START# *52A086150180_213CB8D54D9D_var*
//#UC END# *52A086150180_213CB8D54D9D_var*
begin
//#UC START# *52A086150180_213CB8D54D9D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_213CB8D54D9D_impl*
end;//Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine

function TkwChangesBetweenEditonsFormText.Text(const aCtx: TtfwContext;
 aChangesBetweenEditonsForm: TChangesBetweenEditonsForm): TnscEditor;
 {* Реализация слова скрипта .TChangesBetweenEditonsForm.Text }
//#UC START# *5B130D443290_1945ED3EEC31_var*
//#UC END# *5B130D443290_1945ED3EEC31_var*
begin
//#UC START# *5B130D443290_1945ED3EEC31_impl*
 !!! Needs to be implemented !!!
//#UC END# *5B130D443290_1945ED3EEC31_impl*
end;//TkwChangesBetweenEditonsFormText.Text

procedure TkwChangesBetweenEditonsFormText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1945ED3EEC31_var*
//#UC END# *4DAEEDE10285_1945ED3EEC31_var*
begin
//#UC START# *4DAEEDE10285_1945ED3EEC31_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1945ED3EEC31_impl*
end;//TkwChangesBetweenEditonsFormText.DoDoIt

class function TkwChangesBetweenEditonsFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChangesBetweenEditonsForm.Text';
end;//TkwChangesBetweenEditonsFormText.GetWordNameForRegister

procedure TkwChangesBetweenEditonsFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1945ED3EEC31_var*
//#UC END# *52D00B00031A_1945ED3EEC31_var*
begin
//#UC START# *52D00B00031A_1945ED3EEC31_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1945ED3EEC31_impl*
end;//TkwChangesBetweenEditonsFormText.SetValuePrim

function TkwChangesBetweenEditonsFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwChangesBetweenEditonsFormText.GetResultTypeInfo

function TkwChangesBetweenEditonsFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChangesBetweenEditonsFormText.GetAllParamsCount

function TkwChangesBetweenEditonsFormText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwChangesBetweenEditonsFormText.ParamsTypes

initialization
 Tkw_Form_ChangesBetweenEditons.RegisterInEngine;
 {* Регистрация Tkw_Form_ChangesBetweenEditons }
 Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine;
 {* Регистрация Tkw_ChangesBetweenEditons_Control_Text }
 Tkw_ChangesBetweenEditons_Control_Text_Push.RegisterInEngine;
 {* Регистрация Tkw_ChangesBetweenEditons_Control_Text_Push }
 Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_ChangesBetweenEditons_Component_TextSource }
 TkwChangesBetweenEditonsFormText.RegisterInEngine;
 {* Регистрация ChangesBetweenEditonsForm_Text }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChangesBetweenEditonsForm));
 {* Регистрация типа ChangesBetweenEditons }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
