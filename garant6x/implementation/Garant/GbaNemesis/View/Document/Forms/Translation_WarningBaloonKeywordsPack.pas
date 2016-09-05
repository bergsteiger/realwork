unit Translation_WarningBaloonKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Translation_WarningBaloon }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\Translation_WarningBaloonKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "Translation_WarningBaloonKeywordsPack" MUID: (4EE22F340060_Pack)

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
 , Translation_WarningBaloon_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4EE22F340060_Packimpl_uses*
 //#UC END# *4EE22F340060_Packimpl_uses*
;

type
 TkwTranslationWarningBaloonFormViewer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTranslation_WarningBaloonForm.Viewer }
  private
   function Viewer(const aCtx: TtfwContext;
    aTranslation_WarningBaloonForm: TTranslation_WarningBaloonForm): TnscEditor;
    {* Реализация слова скрипта .TTranslation_WarningBaloonForm.Viewer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwTranslationWarningBaloonFormViewer

 Tkw_Form_Translation_WarningBaloon = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Translation_WarningBaloon
----
*Пример использования*:
[code]форма::Translation_WarningBaloon TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Translation_WarningBaloon

 Tkw_Translation_WarningBaloon_Control_Viewer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Viewer
----
*Пример использования*:
[code]контрол::Viewer TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Translation_WarningBaloon_Control_Viewer

 Tkw_Translation_WarningBaloon_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Viewer
----
*Пример использования*:
[code]контрол::Viewer:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Translation_WarningBaloon_Control_Viewer_Push

function TkwTranslationWarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
 aTranslation_WarningBaloonForm: TTranslation_WarningBaloonForm): TnscEditor;
 {* Реализация слова скрипта .TTranslation_WarningBaloonForm.Viewer }
begin
 Result := aTranslation_WarningBaloonForm.Viewer;
end;//TkwTranslationWarningBaloonFormViewer.Viewer

class function TkwTranslationWarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTranslation_WarningBaloonForm.Viewer';
end;//TkwTranslationWarningBaloonFormViewer.GetWordNameForRegister

function TkwTranslationWarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwTranslationWarningBaloonFormViewer.GetResultTypeInfo

function TkwTranslationWarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTranslationWarningBaloonFormViewer.GetAllParamsCount

function TkwTranslationWarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTranslation_WarningBaloonForm)]);
end;//TkwTranslationWarningBaloonFormViewer.ParamsTypes

procedure TkwTranslationWarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Viewer', aCtx);
end;//TkwTranslationWarningBaloonFormViewer.SetValuePrim

procedure TkwTranslationWarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
var l_aTranslation_WarningBaloonForm: TTranslation_WarningBaloonForm;
begin
 try
  l_aTranslation_WarningBaloonForm := TTranslation_WarningBaloonForm(aCtx.rEngine.PopObjAs(TTranslation_WarningBaloonForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTranslation_WarningBaloonForm: TTranslation_WarningBaloonForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Viewer(aCtx, l_aTranslation_WarningBaloonForm));
end;//TkwTranslationWarningBaloonFormViewer.DoDoIt

function Tkw_Form_Translation_WarningBaloon.GetString: AnsiString;
begin
 Result := 'Translation_WarningBaloonForm';
end;//Tkw_Form_Translation_WarningBaloon.GetString

class procedure Tkw_Form_Translation_WarningBaloon.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TTranslation_WarningBaloonForm);
end;//Tkw_Form_Translation_WarningBaloon.RegisterInEngine

class function Tkw_Form_Translation_WarningBaloon.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Translation_WarningBaloon';
end;//Tkw_Form_Translation_WarningBaloon.GetWordNameForRegister

function Tkw_Translation_WarningBaloon_Control_Viewer.GetString: AnsiString;
begin
 Result := 'Viewer';
end;//Tkw_Translation_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_Translation_WarningBaloon_Control_Viewer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_Translation_WarningBaloon_Control_Viewer.RegisterInEngine

class function Tkw_Translation_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer';
end;//Tkw_Translation_WarningBaloon_Control_Viewer.GetWordNameForRegister

procedure Tkw_Translation_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_Translation_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_Translation_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer:push';
end;//Tkw_Translation_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

initialization
 TkwTranslationWarningBaloonFormViewer.RegisterInEngine;
 {* Регистрация Translation_WarningBaloonForm_Viewer }
 Tkw_Form_Translation_WarningBaloon.RegisterInEngine;
 {* Регистрация Tkw_Form_Translation_WarningBaloon }
 Tkw_Translation_WarningBaloon_Control_Viewer.RegisterInEngine;
 {* Регистрация Tkw_Translation_WarningBaloon_Control_Viewer }
 Tkw_Translation_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
 {* Регистрация Tkw_Translation_WarningBaloon_Control_Viewer_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTranslation_WarningBaloonForm));
 {* Регистрация типа TTranslation_WarningBaloonForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
