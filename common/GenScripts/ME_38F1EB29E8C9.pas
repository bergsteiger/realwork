unit StyleEditorContainerKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы StyleEditorContainer }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\StyleEditorContainerKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Settings_Module
 , vtProportionalPanel
 , vtPanel
 , vtSizeablePanel
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
 Tkw_Form_StyleEditorContainer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы StyleEditorContainer
----
*Пример использования*:
[code]
'aControl' форма::StyleEditorContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_StyleEditorContainer

 Tkw_StyleEditorContainer_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorContainer_Control_BackgroundPanel

 Tkw_StyleEditorContainer_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_BackgroundPanel_Push

 Tkw_StyleEditorContainer_Control_MainZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorContainer_Control_MainZone

 Tkw_StyleEditorContainer_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_MainZone_Push

 Tkw_StyleEditorContainer_Control_ParentZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorContainer_Control_ParentZone

 Tkw_StyleEditorContainer_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_ParentZone_Push

 Tkw_StyleEditorContainer_Control_ChildZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorContainer_Control_ChildZone

 Tkw_StyleEditorContainer_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_ChildZone_Push

 Tkw_StyleEditorContainer_Control_NavigatorZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NavigatorZone
----
*Пример использования*:
[code]
контрол::NavigatorZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorContainer_Control_NavigatorZone

 Tkw_StyleEditorContainer_Control_NavigatorZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NavigatorZone
----
*Пример использования*:
[code]
контрол::NavigatorZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorContainer_Control_NavigatorZone_Push

 TkwStyleEditorContainerFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorContainerForm.BackgroundPanel
[panel]Контрол BackgroundPanel формы TStyleEditorContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aStyleEditorContainerForm .TStyleEditorContainerForm.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aStyleEditorContainerForm: TStyleEditorContainerForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TStyleEditorContainerForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorContainerFormBackgroundPanel

 TkwStyleEditorContainerFormMainZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorContainerForm.MainZone
[panel]Контрол MainZone формы TStyleEditorContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aStyleEditorContainerForm .TStyleEditorContainerForm.MainZone >>> l_TvtPanel
[code]  }
  private
   function MainZone(const aCtx: TtfwContext;
    aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
    {* Реализация слова скрипта .TStyleEditorContainerForm.MainZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorContainerFormMainZone

 TkwStyleEditorContainerFormParentZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorContainerForm.ParentZone
[panel]Контрол ParentZone формы TStyleEditorContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aStyleEditorContainerForm .TStyleEditorContainerForm.ParentZone >>> l_TvtSizeablePanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TStyleEditorContainerForm.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorContainerFormParentZone

 TkwStyleEditorContainerFormChildZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorContainerForm.ChildZone
[panel]Контрол ChildZone формы TStyleEditorContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aStyleEditorContainerForm .TStyleEditorContainerForm.ChildZone >>> l_TvtPanel
[code]  }
  private
   function ChildZone(const aCtx: TtfwContext;
    aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
    {* Реализация слова скрипта .TStyleEditorContainerForm.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorContainerFormChildZone

 TkwStyleEditorContainerFormNavigatorZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorContainerForm.NavigatorZone
[panel]Контрол NavigatorZone формы TStyleEditorContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aStyleEditorContainerForm .TStyleEditorContainerForm.NavigatorZone >>> l_TvtSizeablePanel
[code]  }
  private
   function NavigatorZone(const aCtx: TtfwContext;
    aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TStyleEditorContainerForm.NavigatorZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorContainerFormNavigatorZone

class function Tkw_Form_StyleEditorContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::StyleEditorContainer';
end;//Tkw_Form_StyleEditorContainer.GetWordNameForRegister

function Tkw_Form_StyleEditorContainer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D6AEB6164592_var*
//#UC END# *4DDFD2EA0116_D6AEB6164592_var*
begin
//#UC START# *4DDFD2EA0116_D6AEB6164592_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D6AEB6164592_impl*
end;//Tkw_Form_StyleEditorContainer.GetString

class function Tkw_StyleEditorContainer_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AC437F22A7AC_var*
//#UC END# *4DDFD2EA0116_AC437F22A7AC_var*
begin
//#UC START# *4DDFD2EA0116_AC437F22A7AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AC437F22A7AC_impl*
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel.GetString

class procedure Tkw_StyleEditorContainer_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_AC437F22A7AC_var*
//#UC END# *52A086150180_AC437F22A7AC_var*
begin
//#UC START# *52A086150180_AC437F22A7AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AC437F22A7AC_impl*
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A9487958C12C_var*
//#UC END# *4DAEEDE10285_A9487958C12C_var*
begin
//#UC START# *4DAEEDE10285_A9487958C12C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A9487958C12C_impl*
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_StyleEditorContainer_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone';
end;//Tkw_StyleEditorContainer_Control_MainZone.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_MainZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F8174439ED60_var*
//#UC END# *4DDFD2EA0116_F8174439ED60_var*
begin
//#UC START# *4DDFD2EA0116_F8174439ED60_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F8174439ED60_impl*
end;//Tkw_StyleEditorContainer_Control_MainZone.GetString

class procedure Tkw_StyleEditorContainer_Control_MainZone.RegisterInEngine;
//#UC START# *52A086150180_F8174439ED60_var*
//#UC END# *52A086150180_F8174439ED60_var*
begin
//#UC START# *52A086150180_F8174439ED60_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F8174439ED60_impl*
end;//Tkw_StyleEditorContainer_Control_MainZone.RegisterInEngine

procedure Tkw_StyleEditorContainer_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_15A257ADED1A_var*
//#UC END# *4DAEEDE10285_15A257ADED1A_var*
begin
//#UC START# *4DAEEDE10285_15A257ADED1A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_15A257ADED1A_impl*
end;//Tkw_StyleEditorContainer_Control_MainZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_StyleEditorContainer_Control_MainZone_Push.GetWordNameForRegister

class function Tkw_StyleEditorContainer_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone';
end;//Tkw_StyleEditorContainer_Control_ParentZone.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_ParentZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F596DE2AED86_var*
//#UC END# *4DDFD2EA0116_F596DE2AED86_var*
begin
//#UC START# *4DDFD2EA0116_F596DE2AED86_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F596DE2AED86_impl*
end;//Tkw_StyleEditorContainer_Control_ParentZone.GetString

class procedure Tkw_StyleEditorContainer_Control_ParentZone.RegisterInEngine;
//#UC START# *52A086150180_F596DE2AED86_var*
//#UC END# *52A086150180_F596DE2AED86_var*
begin
//#UC START# *52A086150180_F596DE2AED86_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F596DE2AED86_impl*
end;//Tkw_StyleEditorContainer_Control_ParentZone.RegisterInEngine

procedure Tkw_StyleEditorContainer_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_026D2678402C_var*
//#UC END# *4DAEEDE10285_026D2678402C_var*
begin
//#UC START# *4DAEEDE10285_026D2678402C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_026D2678402C_impl*
end;//Tkw_StyleEditorContainer_Control_ParentZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_StyleEditorContainer_Control_ParentZone_Push.GetWordNameForRegister

class function Tkw_StyleEditorContainer_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone';
end;//Tkw_StyleEditorContainer_Control_ChildZone.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_ChildZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CFE578562B89_var*
//#UC END# *4DDFD2EA0116_CFE578562B89_var*
begin
//#UC START# *4DDFD2EA0116_CFE578562B89_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CFE578562B89_impl*
end;//Tkw_StyleEditorContainer_Control_ChildZone.GetString

class procedure Tkw_StyleEditorContainer_Control_ChildZone.RegisterInEngine;
//#UC START# *52A086150180_CFE578562B89_var*
//#UC END# *52A086150180_CFE578562B89_var*
begin
//#UC START# *52A086150180_CFE578562B89_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CFE578562B89_impl*
end;//Tkw_StyleEditorContainer_Control_ChildZone.RegisterInEngine

procedure Tkw_StyleEditorContainer_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C9AD090A5305_var*
//#UC END# *4DAEEDE10285_C9AD090A5305_var*
begin
//#UC START# *4DAEEDE10285_C9AD090A5305_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C9AD090A5305_impl*
end;//Tkw_StyleEditorContainer_Control_ChildZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_StyleEditorContainer_Control_ChildZone_Push.GetWordNameForRegister

class function Tkw_StyleEditorContainer_Control_NavigatorZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NavigatorZone';
end;//Tkw_StyleEditorContainer_Control_NavigatorZone.GetWordNameForRegister

function Tkw_StyleEditorContainer_Control_NavigatorZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_660A29871516_var*
//#UC END# *4DDFD2EA0116_660A29871516_var*
begin
//#UC START# *4DDFD2EA0116_660A29871516_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_660A29871516_impl*
end;//Tkw_StyleEditorContainer_Control_NavigatorZone.GetString

class procedure Tkw_StyleEditorContainer_Control_NavigatorZone.RegisterInEngine;
//#UC START# *52A086150180_660A29871516_var*
//#UC END# *52A086150180_660A29871516_var*
begin
//#UC START# *52A086150180_660A29871516_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_660A29871516_impl*
end;//Tkw_StyleEditorContainer_Control_NavigatorZone.RegisterInEngine

procedure Tkw_StyleEditorContainer_Control_NavigatorZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_37F21FB3BC72_var*
//#UC END# *4DAEEDE10285_37F21FB3BC72_var*
begin
//#UC START# *4DAEEDE10285_37F21FB3BC72_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_37F21FB3BC72_impl*
end;//Tkw_StyleEditorContainer_Control_NavigatorZone_Push.DoDoIt

class function Tkw_StyleEditorContainer_Control_NavigatorZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NavigatorZone:push';
end;//Tkw_StyleEditorContainer_Control_NavigatorZone_Push.GetWordNameForRegister

function TkwStyleEditorContainerFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aStyleEditorContainerForm: TStyleEditorContainerForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TStyleEditorContainerForm.BackgroundPanel }
//#UC START# *0DF1BCF16B90_EBEA0AF6DB49_var*
//#UC END# *0DF1BCF16B90_EBEA0AF6DB49_var*
begin
//#UC START# *0DF1BCF16B90_EBEA0AF6DB49_impl*
 !!! Needs to be implemented !!!
//#UC END# *0DF1BCF16B90_EBEA0AF6DB49_impl*
end;//TkwStyleEditorContainerFormBackgroundPanel.BackgroundPanel

procedure TkwStyleEditorContainerFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EBEA0AF6DB49_var*
//#UC END# *4DAEEDE10285_EBEA0AF6DB49_var*
begin
//#UC START# *4DAEEDE10285_EBEA0AF6DB49_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EBEA0AF6DB49_impl*
end;//TkwStyleEditorContainerFormBackgroundPanel.DoDoIt

class function TkwStyleEditorContainerFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorContainerForm.BackgroundPanel';
end;//TkwStyleEditorContainerFormBackgroundPanel.GetWordNameForRegister

procedure TkwStyleEditorContainerFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_EBEA0AF6DB49_var*
//#UC END# *52D00B00031A_EBEA0AF6DB49_var*
begin
//#UC START# *52D00B00031A_EBEA0AF6DB49_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_EBEA0AF6DB49_impl*
end;//TkwStyleEditorContainerFormBackgroundPanel.SetValuePrim

function TkwStyleEditorContainerFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_EBEA0AF6DB49_var*
//#UC END# *551544E2001A_EBEA0AF6DB49_var*
begin
//#UC START# *551544E2001A_EBEA0AF6DB49_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_EBEA0AF6DB49_impl*
end;//TkwStyleEditorContainerFormBackgroundPanel.GetResultTypeInfo

function TkwStyleEditorContainerFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_EBEA0AF6DB49_var*
//#UC END# *559687E6025A_EBEA0AF6DB49_var*
begin
//#UC START# *559687E6025A_EBEA0AF6DB49_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_EBEA0AF6DB49_impl*
end;//TkwStyleEditorContainerFormBackgroundPanel.GetAllParamsCount

function TkwStyleEditorContainerFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_EBEA0AF6DB49_var*
//#UC END# *5617F4D00243_EBEA0AF6DB49_var*
begin
//#UC START# *5617F4D00243_EBEA0AF6DB49_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_EBEA0AF6DB49_impl*
end;//TkwStyleEditorContainerFormBackgroundPanel.ParamsTypes

function TkwStyleEditorContainerFormMainZone.MainZone(const aCtx: TtfwContext;
 aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
 {* Реализация слова скрипта .TStyleEditorContainerForm.MainZone }
//#UC START# *A3BD65DC9166_FAE31F4C0B42_var*
//#UC END# *A3BD65DC9166_FAE31F4C0B42_var*
begin
//#UC START# *A3BD65DC9166_FAE31F4C0B42_impl*
 !!! Needs to be implemented !!!
//#UC END# *A3BD65DC9166_FAE31F4C0B42_impl*
end;//TkwStyleEditorContainerFormMainZone.MainZone

procedure TkwStyleEditorContainerFormMainZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FAE31F4C0B42_var*
//#UC END# *4DAEEDE10285_FAE31F4C0B42_var*
begin
//#UC START# *4DAEEDE10285_FAE31F4C0B42_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FAE31F4C0B42_impl*
end;//TkwStyleEditorContainerFormMainZone.DoDoIt

class function TkwStyleEditorContainerFormMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorContainerForm.MainZone';
end;//TkwStyleEditorContainerFormMainZone.GetWordNameForRegister

procedure TkwStyleEditorContainerFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FAE31F4C0B42_var*
//#UC END# *52D00B00031A_FAE31F4C0B42_var*
begin
//#UC START# *52D00B00031A_FAE31F4C0B42_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FAE31F4C0B42_impl*
end;//TkwStyleEditorContainerFormMainZone.SetValuePrim

function TkwStyleEditorContainerFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FAE31F4C0B42_var*
//#UC END# *551544E2001A_FAE31F4C0B42_var*
begin
//#UC START# *551544E2001A_FAE31F4C0B42_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FAE31F4C0B42_impl*
end;//TkwStyleEditorContainerFormMainZone.GetResultTypeInfo

function TkwStyleEditorContainerFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_FAE31F4C0B42_var*
//#UC END# *559687E6025A_FAE31F4C0B42_var*
begin
//#UC START# *559687E6025A_FAE31F4C0B42_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_FAE31F4C0B42_impl*
end;//TkwStyleEditorContainerFormMainZone.GetAllParamsCount

function TkwStyleEditorContainerFormMainZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FAE31F4C0B42_var*
//#UC END# *5617F4D00243_FAE31F4C0B42_var*
begin
//#UC START# *5617F4D00243_FAE31F4C0B42_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FAE31F4C0B42_impl*
end;//TkwStyleEditorContainerFormMainZone.ParamsTypes

function TkwStyleEditorContainerFormParentZone.ParentZone(const aCtx: TtfwContext;
 aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TStyleEditorContainerForm.ParentZone }
//#UC START# *91BA0AEC555C_489405F97345_var*
//#UC END# *91BA0AEC555C_489405F97345_var*
begin
//#UC START# *91BA0AEC555C_489405F97345_impl*
 !!! Needs to be implemented !!!
//#UC END# *91BA0AEC555C_489405F97345_impl*
end;//TkwStyleEditorContainerFormParentZone.ParentZone

procedure TkwStyleEditorContainerFormParentZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_489405F97345_var*
//#UC END# *4DAEEDE10285_489405F97345_var*
begin
//#UC START# *4DAEEDE10285_489405F97345_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_489405F97345_impl*
end;//TkwStyleEditorContainerFormParentZone.DoDoIt

class function TkwStyleEditorContainerFormParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorContainerForm.ParentZone';
end;//TkwStyleEditorContainerFormParentZone.GetWordNameForRegister

procedure TkwStyleEditorContainerFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_489405F97345_var*
//#UC END# *52D00B00031A_489405F97345_var*
begin
//#UC START# *52D00B00031A_489405F97345_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_489405F97345_impl*
end;//TkwStyleEditorContainerFormParentZone.SetValuePrim

function TkwStyleEditorContainerFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_489405F97345_var*
//#UC END# *551544E2001A_489405F97345_var*
begin
//#UC START# *551544E2001A_489405F97345_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_489405F97345_impl*
end;//TkwStyleEditorContainerFormParentZone.GetResultTypeInfo

function TkwStyleEditorContainerFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_489405F97345_var*
//#UC END# *559687E6025A_489405F97345_var*
begin
//#UC START# *559687E6025A_489405F97345_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_489405F97345_impl*
end;//TkwStyleEditorContainerFormParentZone.GetAllParamsCount

function TkwStyleEditorContainerFormParentZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_489405F97345_var*
//#UC END# *5617F4D00243_489405F97345_var*
begin
//#UC START# *5617F4D00243_489405F97345_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_489405F97345_impl*
end;//TkwStyleEditorContainerFormParentZone.ParamsTypes

function TkwStyleEditorContainerFormChildZone.ChildZone(const aCtx: TtfwContext;
 aStyleEditorContainerForm: TStyleEditorContainerForm): TvtPanel;
 {* Реализация слова скрипта .TStyleEditorContainerForm.ChildZone }
//#UC START# *29B40E5B1C55_940A5D9F84B6_var*
//#UC END# *29B40E5B1C55_940A5D9F84B6_var*
begin
//#UC START# *29B40E5B1C55_940A5D9F84B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *29B40E5B1C55_940A5D9F84B6_impl*
end;//TkwStyleEditorContainerFormChildZone.ChildZone

procedure TkwStyleEditorContainerFormChildZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_940A5D9F84B6_var*
//#UC END# *4DAEEDE10285_940A5D9F84B6_var*
begin
//#UC START# *4DAEEDE10285_940A5D9F84B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_940A5D9F84B6_impl*
end;//TkwStyleEditorContainerFormChildZone.DoDoIt

class function TkwStyleEditorContainerFormChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorContainerForm.ChildZone';
end;//TkwStyleEditorContainerFormChildZone.GetWordNameForRegister

procedure TkwStyleEditorContainerFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_940A5D9F84B6_var*
//#UC END# *52D00B00031A_940A5D9F84B6_var*
begin
//#UC START# *52D00B00031A_940A5D9F84B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_940A5D9F84B6_impl*
end;//TkwStyleEditorContainerFormChildZone.SetValuePrim

function TkwStyleEditorContainerFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_940A5D9F84B6_var*
//#UC END# *551544E2001A_940A5D9F84B6_var*
begin
//#UC START# *551544E2001A_940A5D9F84B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_940A5D9F84B6_impl*
end;//TkwStyleEditorContainerFormChildZone.GetResultTypeInfo

function TkwStyleEditorContainerFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_940A5D9F84B6_var*
//#UC END# *559687E6025A_940A5D9F84B6_var*
begin
//#UC START# *559687E6025A_940A5D9F84B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_940A5D9F84B6_impl*
end;//TkwStyleEditorContainerFormChildZone.GetAllParamsCount

function TkwStyleEditorContainerFormChildZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_940A5D9F84B6_var*
//#UC END# *5617F4D00243_940A5D9F84B6_var*
begin
//#UC START# *5617F4D00243_940A5D9F84B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_940A5D9F84B6_impl*
end;//TkwStyleEditorContainerFormChildZone.ParamsTypes

function TkwStyleEditorContainerFormNavigatorZone.NavigatorZone(const aCtx: TtfwContext;
 aStyleEditorContainerForm: TStyleEditorContainerForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TStyleEditorContainerForm.NavigatorZone }
//#UC START# *2D2CF57B5DED_7EBE25C04E3C_var*
//#UC END# *2D2CF57B5DED_7EBE25C04E3C_var*
begin
//#UC START# *2D2CF57B5DED_7EBE25C04E3C_impl*
 !!! Needs to be implemented !!!
//#UC END# *2D2CF57B5DED_7EBE25C04E3C_impl*
end;//TkwStyleEditorContainerFormNavigatorZone.NavigatorZone

procedure TkwStyleEditorContainerFormNavigatorZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7EBE25C04E3C_var*
//#UC END# *4DAEEDE10285_7EBE25C04E3C_var*
begin
//#UC START# *4DAEEDE10285_7EBE25C04E3C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7EBE25C04E3C_impl*
end;//TkwStyleEditorContainerFormNavigatorZone.DoDoIt

class function TkwStyleEditorContainerFormNavigatorZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorContainerForm.NavigatorZone';
end;//TkwStyleEditorContainerFormNavigatorZone.GetWordNameForRegister

procedure TkwStyleEditorContainerFormNavigatorZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7EBE25C04E3C_var*
//#UC END# *52D00B00031A_7EBE25C04E3C_var*
begin
//#UC START# *52D00B00031A_7EBE25C04E3C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7EBE25C04E3C_impl*
end;//TkwStyleEditorContainerFormNavigatorZone.SetValuePrim

function TkwStyleEditorContainerFormNavigatorZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7EBE25C04E3C_var*
//#UC END# *551544E2001A_7EBE25C04E3C_var*
begin
//#UC START# *551544E2001A_7EBE25C04E3C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7EBE25C04E3C_impl*
end;//TkwStyleEditorContainerFormNavigatorZone.GetResultTypeInfo

function TkwStyleEditorContainerFormNavigatorZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_7EBE25C04E3C_var*
//#UC END# *559687E6025A_7EBE25C04E3C_var*
begin
//#UC START# *559687E6025A_7EBE25C04E3C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_7EBE25C04E3C_impl*
end;//TkwStyleEditorContainerFormNavigatorZone.GetAllParamsCount

function TkwStyleEditorContainerFormNavigatorZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7EBE25C04E3C_var*
//#UC END# *5617F4D00243_7EBE25C04E3C_var*
begin
//#UC START# *5617F4D00243_7EBE25C04E3C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7EBE25C04E3C_impl*
end;//TkwStyleEditorContainerFormNavigatorZone.ParamsTypes

initialization
 Tkw_Form_StyleEditorContainer.RegisterInEngine;
 {* Регистрация Tkw_Form_StyleEditorContainer }
 Tkw_StyleEditorContainer_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorContainer_Control_BackgroundPanel }
 Tkw_StyleEditorContainer_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorContainer_Control_BackgroundPanel_Push }
 Tkw_StyleEditorContainer_Control_MainZone.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorContainer_Control_MainZone }
 Tkw_StyleEditorContainer_Control_MainZone_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorContainer_Control_MainZone_Push }
 Tkw_StyleEditorContainer_Control_ParentZone.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorContainer_Control_ParentZone }
 Tkw_StyleEditorContainer_Control_ParentZone_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorContainer_Control_ParentZone_Push }
 Tkw_StyleEditorContainer_Control_ChildZone.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorContainer_Control_ChildZone }
 Tkw_StyleEditorContainer_Control_ChildZone_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorContainer_Control_ChildZone_Push }
 Tkw_StyleEditorContainer_Control_NavigatorZone.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorContainer_Control_NavigatorZone }
 Tkw_StyleEditorContainer_Control_NavigatorZone_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorContainer_Control_NavigatorZone_Push }
 TkwStyleEditorContainerFormBackgroundPanel.RegisterInEngine;
 {* Регистрация StyleEditorContainerForm_BackgroundPanel }
 TkwStyleEditorContainerFormMainZone.RegisterInEngine;
 {* Регистрация StyleEditorContainerForm_MainZone }
 TkwStyleEditorContainerFormParentZone.RegisterInEngine;
 {* Регистрация StyleEditorContainerForm_ParentZone }
 TkwStyleEditorContainerFormChildZone.RegisterInEngine;
 {* Регистрация StyleEditorContainerForm_ChildZone }
 TkwStyleEditorContainerFormNavigatorZone.RegisterInEngine;
 {* Регистрация StyleEditorContainerForm_NavigatorZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorContainerForm));
 {* Регистрация типа StyleEditorContainer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
