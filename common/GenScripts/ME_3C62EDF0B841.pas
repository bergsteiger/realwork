unit SynchroView_WarningBaloonKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы SynchroView_WarningBaloon }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\SynchroView_WarningBaloonKeywordsPack.pas"
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
 Tkw_Form_SynchroView_WarningBaloon = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы SynchroView_WarningBaloon
----
*Пример использования*:
[code]
'aControl' форма::SynchroView_WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SynchroView_WarningBaloon

 Tkw_SynchroView_WarningBaloon_Control_Viewer = {final} class(TtfwControlString)
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
 end;//Tkw_SynchroView_WarningBaloon_Control_Viewer

 Tkw_SynchroView_WarningBaloon_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Viewer
----
*Пример использования*:
[code]
контрол::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SynchroView_WarningBaloon_Control_Viewer_Push

 TkwSynchroViewWarningBaloonFormViewer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TSynchroView_WarningBaloonForm.Viewer
[panel]Контрол Viewer формы TSynchroView_WarningBaloonForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aSynchroView_WarningBaloonForm .TSynchroView_WarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
   function Viewer(const aCtx: TtfwContext;
    aSynchroView_WarningBaloonForm: TSynchroView_WarningBaloonForm): TnscEditor;
    {* Реализация слова скрипта .TSynchroView_WarningBaloonForm.Viewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSynchroViewWarningBaloonFormViewer

class function Tkw_Form_SynchroView_WarningBaloon.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::SynchroView_WarningBaloon';
end;//Tkw_Form_SynchroView_WarningBaloon.GetWordNameForRegister

function Tkw_Form_SynchroView_WarningBaloon.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_11405B0E96EC_var*
//#UC END# *4DDFD2EA0116_11405B0E96EC_var*
begin
//#UC START# *4DDFD2EA0116_11405B0E96EC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_11405B0E96EC_impl*
end;//Tkw_Form_SynchroView_WarningBaloon.GetString

class function Tkw_SynchroView_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer';
end;//Tkw_SynchroView_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_SynchroView_WarningBaloon_Control_Viewer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_55338649331E_var*
//#UC END# *4DDFD2EA0116_55338649331E_var*
begin
//#UC START# *4DDFD2EA0116_55338649331E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_55338649331E_impl*
end;//Tkw_SynchroView_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_SynchroView_WarningBaloon_Control_Viewer.RegisterInEngine;
//#UC START# *52A086150180_55338649331E_var*
//#UC END# *52A086150180_55338649331E_var*
begin
//#UC START# *52A086150180_55338649331E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_55338649331E_impl*
end;//Tkw_SynchroView_WarningBaloon_Control_Viewer.RegisterInEngine

procedure Tkw_SynchroView_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A1906895B120_var*
//#UC END# *4DAEEDE10285_A1906895B120_var*
begin
//#UC START# *4DAEEDE10285_A1906895B120_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A1906895B120_impl*
end;//Tkw_SynchroView_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_SynchroView_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Viewer:push';
end;//Tkw_SynchroView_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

function TkwSynchroViewWarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
 aSynchroView_WarningBaloonForm: TSynchroView_WarningBaloonForm): TnscEditor;
 {* Реализация слова скрипта .TSynchroView_WarningBaloonForm.Viewer }
//#UC START# *0E9150D43889_C36D33260EB8_var*
//#UC END# *0E9150D43889_C36D33260EB8_var*
begin
//#UC START# *0E9150D43889_C36D33260EB8_impl*
 !!! Needs to be implemented !!!
//#UC END# *0E9150D43889_C36D33260EB8_impl*
end;//TkwSynchroViewWarningBaloonFormViewer.Viewer

procedure TkwSynchroViewWarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C36D33260EB8_var*
//#UC END# *4DAEEDE10285_C36D33260EB8_var*
begin
//#UC START# *4DAEEDE10285_C36D33260EB8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C36D33260EB8_impl*
end;//TkwSynchroViewWarningBaloonFormViewer.DoDoIt

class function TkwSynchroViewWarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSynchroView_WarningBaloonForm.Viewer';
end;//TkwSynchroViewWarningBaloonFormViewer.GetWordNameForRegister

procedure TkwSynchroViewWarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C36D33260EB8_var*
//#UC END# *52D00B00031A_C36D33260EB8_var*
begin
//#UC START# *52D00B00031A_C36D33260EB8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C36D33260EB8_impl*
end;//TkwSynchroViewWarningBaloonFormViewer.SetValuePrim

function TkwSynchroViewWarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwSynchroViewWarningBaloonFormViewer.GetResultTypeInfo

function TkwSynchroViewWarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSynchroViewWarningBaloonFormViewer.GetAllParamsCount

function TkwSynchroViewWarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C36D33260EB8_var*
//#UC END# *5617F4D00243_C36D33260EB8_var*
begin
//#UC START# *5617F4D00243_C36D33260EB8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C36D33260EB8_impl*
end;//TkwSynchroViewWarningBaloonFormViewer.ParamsTypes

initialization
 Tkw_Form_SynchroView_WarningBaloon.RegisterInEngine;
 {* Регистрация Tkw_Form_SynchroView_WarningBaloon }
 Tkw_SynchroView_WarningBaloon_Control_Viewer.RegisterInEngine;
 {* Регистрация Tkw_SynchroView_WarningBaloon_Control_Viewer }
 Tkw_SynchroView_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
 {* Регистрация Tkw_SynchroView_WarningBaloon_Control_Viewer_Push }
 TkwSynchroViewWarningBaloonFormViewer.RegisterInEngine;
 {* Регистрация SynchroView_WarningBaloonForm_Viewer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TSynchroView_WarningBaloonForm));
 {* Регистрация типа SynchroView_WarningBaloon }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
