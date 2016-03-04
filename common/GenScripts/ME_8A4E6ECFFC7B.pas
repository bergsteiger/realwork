unit UserCR2_WarningBaloonKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы UserCR2_WarningBaloon }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\UserCR2_WarningBaloonKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , UserCR2_WarningBaloon_Form
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
 Tkw_Form_UserCR2_WarningBaloon = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы UserCR2_WarningBaloon
----
*Пример использования*:
[code]
'aControl' форма::UserCR2_WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserCR2_WarningBaloon

 Tkw_UserCR2_WarningBaloon_Control_Viewer = {final} class(TtfwControlString)
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
 end;//Tkw_UserCR2_WarningBaloon_Control_Viewer

 Tkw_UserCR2_WarningBaloon_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Viewer
----
*Пример использования*:
[code]
контрол::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserCR2_WarningBaloon_Control_Viewer_Push

 TkwUserCR2WarningBaloonFormViewer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TUserCR2_WarningBaloonForm.Viewer
[panel]Контрол Viewer формы TUserCR2_WarningBaloonForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aUserCR2_WarningBaloonForm .TUserCR2_WarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
   function Viewer(const aCtx: TtfwContext;
    aUserCR2_WarningBaloonForm: TUserCR2_WarningBaloonForm): TnscEditor;
    {* Реализация слова скрипта .TUserCR2_WarningBaloonForm.Viewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwUserCR2WarningBaloonFormViewer

class function Tkw_Form_UserCR2_WarningBaloon.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::UserCR2_WarningBaloon';
end;//Tkw_Form_UserCR2_WarningBaloon.GetWordNameForRegister

function Tkw_Form_UserCR2_WarningBaloon.GetString: AnsiString;
begin
 Result := 'UserCR2_WarningBaloonForm';
end;//Tkw_Form_UserCR2_WarningBaloon.GetString

class function Tkw_UserCR2_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer';
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_UserCR2_WarningBaloon_Control_Viewer.GetString: AnsiString;
begin
 Result := 'Viewer';
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_UserCR2_WarningBaloon_Control_Viewer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer.RegisterInEngine

procedure Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer:push';
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

function TkwUserCR2WarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
 aUserCR2_WarningBaloonForm: TUserCR2_WarningBaloonForm): TnscEditor;
 {* Реализация слова скрипта .TUserCR2_WarningBaloonForm.Viewer }
begin
 Result := aUserCR2_WarningBaloonForm.Viewer;
end;//TkwUserCR2WarningBaloonFormViewer.Viewer

procedure TkwUserCR2WarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
var l_aUserCR2_WarningBaloonForm: TUserCR2_WarningBaloonForm;
begin
 try
  l_aUserCR2_WarningBaloonForm := TUserCR2_WarningBaloonForm(aCtx.rEngine.PopObjAs(TUserCR2_WarningBaloonForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aUserCR2_WarningBaloonForm: TUserCR2_WarningBaloonForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Viewer(aCtx, l_aUserCR2_WarningBaloonForm));
end;//TkwUserCR2WarningBaloonFormViewer.DoDoIt

class function TkwUserCR2WarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TUserCR2_WarningBaloonForm.Viewer';
end;//TkwUserCR2WarningBaloonFormViewer.GetWordNameForRegister

procedure TkwUserCR2WarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Viewer', aCtx);
end;//TkwUserCR2WarningBaloonFormViewer.SetValuePrim

function TkwUserCR2WarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwUserCR2WarningBaloonFormViewer.GetResultTypeInfo

function TkwUserCR2WarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwUserCR2WarningBaloonFormViewer.GetAllParamsCount

function TkwUserCR2WarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TUserCR2_WarningBaloonForm)]);
end;//TkwUserCR2WarningBaloonFormViewer.ParamsTypes

initialization
 Tkw_Form_UserCR2_WarningBaloon.RegisterInEngine;
 {* Регистрация Tkw_Form_UserCR2_WarningBaloon }
 Tkw_UserCR2_WarningBaloon_Control_Viewer.RegisterInEngine;
 {* Регистрация Tkw_UserCR2_WarningBaloon_Control_Viewer }
 Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
 {* Регистрация Tkw_UserCR2_WarningBaloon_Control_Viewer_Push }
 TkwUserCR2WarningBaloonFormViewer.RegisterInEngine;
 {* Регистрация UserCR2_WarningBaloonForm_Viewer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TUserCR2_WarningBaloonForm));
 {* Регистрация типа UserCR2_WarningBaloon }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
