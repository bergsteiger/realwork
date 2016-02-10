unit Translation_WarningBaloonKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Translation_WarningBaloon }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Translation_WarningBaloonKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
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
 , SysUtils
;

type
 Tkw_Form_Translation_WarningBaloon = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Translation_WarningBaloon
----
*Пример использования*:
[code]
'aControl' форма::Translation_WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Translation_WarningBaloon

 Tkw_Translation_WarningBaloon_Control_Viewer = {final} class(TtfwControlString)
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
 end;//Tkw_Translation_WarningBaloon_Control_Viewer

 Tkw_Translation_WarningBaloon_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Viewer
----
*Пример использования*:
[code]
контрол::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Translation_WarningBaloon_Control_Viewer_Push

 TkwTranslationWarningBaloonFormViewer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TTranslation_WarningBaloonForm.Viewer
[panel]Контрол Viewer формы TTranslation_WarningBaloonForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aTranslation_WarningBaloonForm .TTranslation_WarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
   function Viewer(const aCtx: TtfwContext;
    aTranslation_WarningBaloonForm: TTranslation_WarningBaloonForm): TnscEditor;
    {* Реализация слова скрипта .TTranslation_WarningBaloonForm.Viewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTranslationWarningBaloonFormViewer

class function Tkw_Form_Translation_WarningBaloon.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Translation_WarningBaloon';
end;//Tkw_Form_Translation_WarningBaloon.GetWordNameForRegister

function Tkw_Form_Translation_WarningBaloon.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_00A08488AB00_var*
//#UC END# *4DDFD2EA0116_00A08488AB00_var*
begin
//#UC START# *4DDFD2EA0116_00A08488AB00_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_00A08488AB00_impl*
end;//Tkw_Form_Translation_WarningBaloon.GetString

class function Tkw_Translation_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer';
end;//Tkw_Translation_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_Translation_WarningBaloon_Control_Viewer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7834354B8302_var*
//#UC END# *4DDFD2EA0116_7834354B8302_var*
begin
//#UC START# *4DDFD2EA0116_7834354B8302_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7834354B8302_impl*
end;//Tkw_Translation_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_Translation_WarningBaloon_Control_Viewer.RegisterInEngine;
//#UC START# *52A086150180_7834354B8302_var*
//#UC END# *52A086150180_7834354B8302_var*
begin
//#UC START# *52A086150180_7834354B8302_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7834354B8302_impl*
end;//Tkw_Translation_WarningBaloon_Control_Viewer.RegisterInEngine

procedure Tkw_Translation_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_83EED00573B4_var*
//#UC END# *4DAEEDE10285_83EED00573B4_var*
begin
//#UC START# *4DAEEDE10285_83EED00573B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_83EED00573B4_impl*
end;//Tkw_Translation_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_Translation_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer:push';
end;//Tkw_Translation_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

function TkwTranslationWarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
 aTranslation_WarningBaloonForm: TTranslation_WarningBaloonForm): TnscEditor;
 {* Реализация слова скрипта .TTranslation_WarningBaloonForm.Viewer }
//#UC START# *AA0A0365CCEE_83A9A6BA36A3_var*
//#UC END# *AA0A0365CCEE_83A9A6BA36A3_var*
begin
//#UC START# *AA0A0365CCEE_83A9A6BA36A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *AA0A0365CCEE_83A9A6BA36A3_impl*
end;//TkwTranslationWarningBaloonFormViewer.Viewer

procedure TkwTranslationWarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_83A9A6BA36A3_var*
//#UC END# *4DAEEDE10285_83A9A6BA36A3_var*
begin
//#UC START# *4DAEEDE10285_83A9A6BA36A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_83A9A6BA36A3_impl*
end;//TkwTranslationWarningBaloonFormViewer.DoDoIt

class function TkwTranslationWarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TTranslation_WarningBaloonForm.Viewer';
end;//TkwTranslationWarningBaloonFormViewer.GetWordNameForRegister

procedure TkwTranslationWarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
end;//TkwTranslationWarningBaloonFormViewer.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwTranslationWarningBaloonFormViewer.ParamsTypes

initialization
 Tkw_Form_Translation_WarningBaloon.RegisterInEngine;
 {* Регистрация Tkw_Form_Translation_WarningBaloon }
 Tkw_Translation_WarningBaloon_Control_Viewer.RegisterInEngine;
 {* Регистрация Tkw_Translation_WarningBaloon_Control_Viewer }
 Tkw_Translation_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
 {* Регистрация Tkw_Translation_WarningBaloon_Control_Viewer_Push }
 TkwTranslationWarningBaloonFormViewer.RegisterInEngine;
 {* Регистрация Translation_WarningBaloonForm_Viewer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTranslation_WarningBaloonForm));
 {* Регистрация типа Translation_WarningBaloon }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
