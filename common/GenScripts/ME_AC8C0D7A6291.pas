unit WarningKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Warning }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\WarningKeywordsPack.pas"
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
 Tkw_Form_Warning = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Warning
----
*Пример использования*:
[code]
'aControl' форма::Warning TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Warning

 Tkw_Warning_Control_Viewer = {final} class(TtfwControlString)
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
 end;//Tkw_Warning_Control_Viewer

 Tkw_Warning_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Viewer
----
*Пример использования*:
[code]
контрол::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Warning_Control_Viewer_Push

 TkwWarningFormViewer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TWarningForm.Viewer
[panel]Контрол Viewer формы TWarningForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aWarningForm .TWarningForm.Viewer >>> l_TnscEditor
[code]  }
  private
   function Viewer(const aCtx: TtfwContext;
    aWarningForm: TWarningForm): TnscEditor;
    {* Реализация слова скрипта .TWarningForm.Viewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWarningFormViewer

class function Tkw_Form_Warning.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Warning';
end;//Tkw_Form_Warning.GetWordNameForRegister

function Tkw_Form_Warning.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F04941204495_var*
//#UC END# *4DDFD2EA0116_F04941204495_var*
begin
//#UC START# *4DDFD2EA0116_F04941204495_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F04941204495_impl*
end;//Tkw_Form_Warning.GetString

class function Tkw_Warning_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer';
end;//Tkw_Warning_Control_Viewer.GetWordNameForRegister

function Tkw_Warning_Control_Viewer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_20B03195C5DC_var*
//#UC END# *4DDFD2EA0116_20B03195C5DC_var*
begin
//#UC START# *4DDFD2EA0116_20B03195C5DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_20B03195C5DC_impl*
end;//Tkw_Warning_Control_Viewer.GetString

class procedure Tkw_Warning_Control_Viewer.RegisterInEngine;
//#UC START# *52A086150180_20B03195C5DC_var*
//#UC END# *52A086150180_20B03195C5DC_var*
begin
//#UC START# *52A086150180_20B03195C5DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_20B03195C5DC_impl*
end;//Tkw_Warning_Control_Viewer.RegisterInEngine

procedure Tkw_Warning_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_32D945597E5A_var*
//#UC END# *4DAEEDE10285_32D945597E5A_var*
begin
//#UC START# *4DAEEDE10285_32D945597E5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_32D945597E5A_impl*
end;//Tkw_Warning_Control_Viewer_Push.DoDoIt

class function Tkw_Warning_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer:push';
end;//Tkw_Warning_Control_Viewer_Push.GetWordNameForRegister

function TkwWarningFormViewer.Viewer(const aCtx: TtfwContext;
 aWarningForm: TWarningForm): TnscEditor;
 {* Реализация слова скрипта .TWarningForm.Viewer }
//#UC START# *D9E97791A411_FF936140AA96_var*
//#UC END# *D9E97791A411_FF936140AA96_var*
begin
//#UC START# *D9E97791A411_FF936140AA96_impl*
 !!! Needs to be implemented !!!
//#UC END# *D9E97791A411_FF936140AA96_impl*
end;//TkwWarningFormViewer.Viewer

procedure TkwWarningFormViewer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FF936140AA96_var*
//#UC END# *4DAEEDE10285_FF936140AA96_var*
begin
//#UC START# *4DAEEDE10285_FF936140AA96_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FF936140AA96_impl*
end;//TkwWarningFormViewer.DoDoIt

class function TkwWarningFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TWarningForm.Viewer';
end;//TkwWarningFormViewer.GetWordNameForRegister

procedure TkwWarningFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
DoSetValue(, aValue);
end;//TkwWarningFormViewer.SetValuePrim

function TkwWarningFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwWarningFormViewer.GetResultTypeInfo

function TkwWarningFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWarningFormViewer.GetAllParamsCount

function TkwWarningFormViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwWarningFormViewer.ParamsTypes

initialization
 Tkw_Form_Warning.RegisterInEngine;
 {* Регистрация Tkw_Form_Warning }
 Tkw_Warning_Control_Viewer.RegisterInEngine;
 {* Регистрация Tkw_Warning_Control_Viewer }
 Tkw_Warning_Control_Viewer_Push.RegisterInEngine;
 {* Регистрация Tkw_Warning_Control_Viewer_Push }
 TkwWarningFormViewer.RegisterInEngine;
 {* Регистрация WarningForm_Viewer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWarningForm));
 {* Регистрация типа Warning }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
