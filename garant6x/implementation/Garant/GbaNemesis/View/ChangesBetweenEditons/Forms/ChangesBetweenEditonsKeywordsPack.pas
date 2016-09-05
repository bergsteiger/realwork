unit ChangesBetweenEditonsKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ChangesBetweenEditons }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\ChangesBetweenEditonsKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ChangesBetweenEditonsKeywordsPack" MUID: (4DDCD6800267_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , ChangesBetweenEditons_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4DDCD6800267_Packimpl_uses*
 //#UC END# *4DDCD6800267_Packimpl_uses*
;

type
 TkwChangesBetweenEditonsFormText = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChangesBetweenEditonsForm.Text }
  private
   function Text(const aCtx: TtfwContext;
    aChangesBetweenEditonsForm: TChangesBetweenEditonsForm): TnscEditor;
    {* Реализация слова скрипта .TChangesBetweenEditonsForm.Text }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwChangesBetweenEditonsFormText

 Tkw_Form_ChangesBetweenEditons = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ChangesBetweenEditons
----
*Пример использования*:
[code]форма::ChangesBetweenEditons TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ChangesBetweenEditons

 Tkw_ChangesBetweenEditons_Control_Text = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Text
----
*Пример использования*:
[code]контрол::Text TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChangesBetweenEditons_Control_Text

 Tkw_ChangesBetweenEditons_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]контрол::Text:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChangesBetweenEditons_Control_Text_Push

 Tkw_ChangesBetweenEditons_Component_TextSource = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]компонент::TextSource TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChangesBetweenEditons_Component_TextSource

function TkwChangesBetweenEditonsFormText.Text(const aCtx: TtfwContext;
 aChangesBetweenEditonsForm: TChangesBetweenEditonsForm): TnscEditor;
 {* Реализация слова скрипта .TChangesBetweenEditonsForm.Text }
begin
 Result := aChangesBetweenEditonsForm.Text;
end;//TkwChangesBetweenEditonsFormText.Text

class function TkwChangesBetweenEditonsFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChangesBetweenEditonsForm.Text';
end;//TkwChangesBetweenEditonsFormText.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TChangesBetweenEditonsForm)]);
end;//TkwChangesBetweenEditonsFormText.ParamsTypes

procedure TkwChangesBetweenEditonsFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Text', aCtx);
end;//TkwChangesBetweenEditonsFormText.SetValuePrim

procedure TkwChangesBetweenEditonsFormText.DoDoIt(const aCtx: TtfwContext);
var l_aChangesBetweenEditonsForm: TChangesBetweenEditonsForm;
begin
 try
  l_aChangesBetweenEditonsForm := TChangesBetweenEditonsForm(aCtx.rEngine.PopObjAs(TChangesBetweenEditonsForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aChangesBetweenEditonsForm: TChangesBetweenEditonsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Text(aCtx, l_aChangesBetweenEditonsForm));
end;//TkwChangesBetweenEditonsFormText.DoDoIt

function Tkw_Form_ChangesBetweenEditons.GetString: AnsiString;
begin
 Result := 'ChangesBetweenEditonsForm';
end;//Tkw_Form_ChangesBetweenEditons.GetString

class procedure Tkw_Form_ChangesBetweenEditons.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TChangesBetweenEditonsForm);
end;//Tkw_Form_ChangesBetweenEditons.RegisterInEngine

class function Tkw_Form_ChangesBetweenEditons.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ChangesBetweenEditons';
end;//Tkw_Form_ChangesBetweenEditons.GetWordNameForRegister

function Tkw_ChangesBetweenEditons_Control_Text.GetString: AnsiString;
begin
 Result := 'Text';
end;//Tkw_ChangesBetweenEditons_Control_Text.GetString

class procedure Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine

class function Tkw_ChangesBetweenEditons_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text';
end;//Tkw_ChangesBetweenEditons_Control_Text.GetWordNameForRegister

procedure Tkw_ChangesBetweenEditons_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_ChangesBetweenEditons_Control_Text_Push.DoDoIt

class function Tkw_ChangesBetweenEditons_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text:push';
end;//Tkw_ChangesBetweenEditons_Control_Text_Push.GetWordNameForRegister

function Tkw_ChangesBetweenEditons_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_ChangesBetweenEditons_Component_TextSource.GetString

class procedure Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine

class function Tkw_ChangesBetweenEditons_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_ChangesBetweenEditons_Component_TextSource.GetWordNameForRegister

initialization
 TkwChangesBetweenEditonsFormText.RegisterInEngine;
 {* Регистрация ChangesBetweenEditonsForm_Text }
 Tkw_Form_ChangesBetweenEditons.RegisterInEngine;
 {* Регистрация Tkw_Form_ChangesBetweenEditons }
 Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine;
 {* Регистрация Tkw_ChangesBetweenEditons_Control_Text }
 Tkw_ChangesBetweenEditons_Control_Text_Push.RegisterInEngine;
 {* Регистрация Tkw_ChangesBetweenEditons_Control_Text_Push }
 Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_ChangesBetweenEditons_Component_TextSource }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChangesBetweenEditonsForm));
 {* Регистрация типа TChangesBetweenEditonsForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
