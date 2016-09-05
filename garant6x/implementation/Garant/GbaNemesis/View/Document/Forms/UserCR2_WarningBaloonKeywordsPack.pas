unit UserCR2_WarningBaloonKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы UserCR2_WarningBaloon }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\UserCR2_WarningBaloonKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "UserCR2_WarningBaloonKeywordsPack" MUID: (4EF47F5A02F7_Pack)

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
 , UserCR2_WarningBaloon_Form
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
 //#UC START# *4EF47F5A02F7_Packimpl_uses*
 //#UC END# *4EF47F5A02F7_Packimpl_uses*
;

type
 TkwUserCR2WarningBaloonFormViewer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TUserCR2_WarningBaloonForm.Viewer }
  private
   function Viewer(const aCtx: TtfwContext;
    aUserCR2_WarningBaloonForm: TUserCR2_WarningBaloonForm): TnscEditor;
    {* Реализация слова скрипта .TUserCR2_WarningBaloonForm.Viewer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwUserCR2WarningBaloonFormViewer

 Tkw_Form_UserCR2_WarningBaloon = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы UserCR2_WarningBaloon
----
*Пример использования*:
[code]форма::UserCR2_WarningBaloon TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_UserCR2_WarningBaloon

 Tkw_UserCR2_WarningBaloon_Control_Viewer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Viewer
----
*Пример использования*:
[code]контрол::Viewer TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserCR2_WarningBaloon_Control_Viewer

 Tkw_UserCR2_WarningBaloon_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Viewer
----
*Пример использования*:
[code]контрол::Viewer:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserCR2_WarningBaloon_Control_Viewer_Push

function TkwUserCR2WarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
 aUserCR2_WarningBaloonForm: TUserCR2_WarningBaloonForm): TnscEditor;
 {* Реализация слова скрипта .TUserCR2_WarningBaloonForm.Viewer }
begin
 Result := aUserCR2_WarningBaloonForm.Viewer;
end;//TkwUserCR2WarningBaloonFormViewer.Viewer

class function TkwUserCR2WarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TUserCR2_WarningBaloonForm.Viewer';
end;//TkwUserCR2WarningBaloonFormViewer.GetWordNameForRegister

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

procedure TkwUserCR2WarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Viewer', aCtx);
end;//TkwUserCR2WarningBaloonFormViewer.SetValuePrim

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

function Tkw_Form_UserCR2_WarningBaloon.GetString: AnsiString;
begin
 Result := 'UserCR2_WarningBaloonForm';
end;//Tkw_Form_UserCR2_WarningBaloon.GetString

class procedure Tkw_Form_UserCR2_WarningBaloon.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TUserCR2_WarningBaloonForm);
end;//Tkw_Form_UserCR2_WarningBaloon.RegisterInEngine

class function Tkw_Form_UserCR2_WarningBaloon.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::UserCR2_WarningBaloon';
end;//Tkw_Form_UserCR2_WarningBaloon.GetWordNameForRegister

function Tkw_UserCR2_WarningBaloon_Control_Viewer.GetString: AnsiString;
begin
 Result := 'Viewer';
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_UserCR2_WarningBaloon_Control_Viewer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer.RegisterInEngine

class function Tkw_UserCR2_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer';
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer.GetWordNameForRegister

procedure Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Viewer');
 inherited;
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer:push';
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

initialization
 TkwUserCR2WarningBaloonFormViewer.RegisterInEngine;
 {* Регистрация UserCR2_WarningBaloonForm_Viewer }
 Tkw_Form_UserCR2_WarningBaloon.RegisterInEngine;
 {* Регистрация Tkw_Form_UserCR2_WarningBaloon }
 Tkw_UserCR2_WarningBaloon_Control_Viewer.RegisterInEngine;
 {* Регистрация Tkw_UserCR2_WarningBaloon_Control_Viewer }
 Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
 {* Регистрация Tkw_UserCR2_WarningBaloon_Control_Viewer_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TUserCR2_WarningBaloonForm));
 {* Регистрация типа TUserCR2_WarningBaloonForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
