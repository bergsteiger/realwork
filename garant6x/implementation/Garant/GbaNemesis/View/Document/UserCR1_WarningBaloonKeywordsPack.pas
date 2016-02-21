unit UserCR1_WarningBaloonKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы UserCR1_WarningBaloon }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\UserCR1_WarningBaloonKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , UserCR1_WarningBaloon_Form
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
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_UserCR1_WarningBaloon = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы UserCR1_WarningBaloon
----
*Пример использования*:
[code]
'aControl' форма::UserCR1_WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserCR1_WarningBaloon

 Tkw_UserCR1_WarningBaloon_Control_Viewer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Viewer
----
*Пример использования*:
[code]
контрол::Viewer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserCR1_WarningBaloon_Control_Viewer

 Tkw_UserCR1_WarningBaloon_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Viewer
----
*Пример использования*:
[code]
контрол::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserCR1_WarningBaloon_Control_Viewer_Push

 TkwUserCR1WarningBaloonFormViewer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TUserCR1_WarningBaloonForm.Viewer
[panel]Контрол Viewer формы TUserCR1_WarningBaloonForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aUserCR1_WarningBaloonForm .TUserCR1_WarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
   function Viewer(const aCtx: TtfwContext;
    aUserCR1_WarningBaloonForm: TUserCR1_WarningBaloonForm): TnscEditor;
    {* Реализация слова скрипта .TUserCR1_WarningBaloonForm.Viewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwUserCR1WarningBaloonFormViewer

class function Tkw_Form_UserCR1_WarningBaloon.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::UserCR1_WarningBaloon';
end;//Tkw_Form_UserCR1_WarningBaloon.GetWordNameForRegister

function Tkw_Form_UserCR1_WarningBaloon.GetString: AnsiString;
begin
 Result := 'UserCR1_WarningBaloonForm';
end;//Tkw_Form_UserCR1_WarningBaloon.GetString

class function Tkw_UserCR1_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer';
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_UserCR1_WarningBaloon_Control_Viewer.GetString: AnsiString;
begin
 Result := 'Viewer';
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_UserCR1_WarningBaloon_Control_Viewer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer.RegisterInEngine

procedure Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer:push';
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

function TkwUserCR1WarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
 aUserCR1_WarningBaloonForm: TUserCR1_WarningBaloonForm): TnscEditor;
 {* Реализация слова скрипта .TUserCR1_WarningBaloonForm.Viewer }
begin
 Result := aUserCR1_WarningBaloonForm.Viewer;
end;//TkwUserCR1WarningBaloonFormViewer.Viewer

procedure TkwUserCR1WarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
var l_aUserCR1_WarningBaloonForm: TUserCR1_WarningBaloonForm;
begin
 try
  l_aUserCR1_WarningBaloonForm := TUserCR1_WarningBaloonForm(aCtx.rEngine.PopObjAs(TUserCR1_WarningBaloonForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aUserCR1_WarningBaloonForm: TUserCR1_WarningBaloonForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Viewer(aCtx, l_aUserCR1_WarningBaloonForm));
end;//TkwUserCR1WarningBaloonFormViewer.DoDoIt

class function TkwUserCR1WarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TUserCR1_WarningBaloonForm.Viewer';
end;//TkwUserCR1WarningBaloonFormViewer.GetWordNameForRegister

procedure TkwUserCR1WarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Viewer', aCtx);
end;//TkwUserCR1WarningBaloonFormViewer.SetValuePrim

function TkwUserCR1WarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwUserCR1WarningBaloonFormViewer.GetResultTypeInfo

function TkwUserCR1WarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwUserCR1WarningBaloonFormViewer.GetAllParamsCount

function TkwUserCR1WarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TUserCR1_WarningBaloonForm)]);
end;//TkwUserCR1WarningBaloonFormViewer.ParamsTypes

initialization
 Tkw_Form_UserCR1_WarningBaloon.RegisterInEngine;
 {* Регистрация Tkw_Form_UserCR1_WarningBaloon }
 Tkw_UserCR1_WarningBaloon_Control_Viewer.RegisterInEngine;
 {* Регистрация Tkw_UserCR1_WarningBaloon_Control_Viewer }
 Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
 {* Регистрация Tkw_UserCR1_WarningBaloon_Control_Viewer_Push }
 TkwUserCR1WarningBaloonFormViewer.RegisterInEngine;
 {* Регистрация UserCR1_WarningBaloonForm_Viewer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TUserCR1_WarningBaloonForm));
 {* Регистрация типа UserCR1_WarningBaloon }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
