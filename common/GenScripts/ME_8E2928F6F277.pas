unit MainKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Main }

// Модуль: "w:\MDProcess\NewGen\MainKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include ngDefine.inc}

interface

{$If Defined(NewGen) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NewGenRes
 {$If Defined(Nemesis)}
 , nscStatusBar
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , vtProportionalPanel
 , vtSizeablePanel
 {$If Defined(Nemesis)}
 , nscNavigator
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
{$IfEnd} // Defined(NewGen) AND NOT Defined(NoScripts)

implementation

{$If Defined(NewGen) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Main = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Main
----
*Пример использования*:
[code]
'aControl' форма::Main TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Main

 Tkw_Main_Control_StatusBar = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Main_Control_StatusBar

 Tkw_Main_Control_StatusBar_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_StatusBar_Push

 Tkw_Main_Control_ClientZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Main_Control_ClientZone

 Tkw_Main_Control_ClientZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ClientZone_Push

 Tkw_Main_Control_MainZone = {final} class(TtfwControlString)
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
 end;//Tkw_Main_Control_MainZone

 Tkw_Main_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_MainZone_Push

 Tkw_Main_Control_ParentZonePanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Main_Control_ParentZonePanel

 Tkw_Main_Control_ParentZonePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ParentZonePanel_Push

 Tkw_Main_Control_ChildZonePanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Main_Control_ChildZonePanel

 Tkw_Main_Control_ChildZonePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_ChildZonePanel_Push

 Tkw_Main_Control_BaseSearchPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Main_Control_BaseSearchPanel

 Tkw_Main_Control_BaseSearchPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_BaseSearchPanel_Push

 Tkw_Main_Control_LeftNavigator = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Main_Control_LeftNavigator

 Tkw_Main_Control_LeftNavigator_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_LeftNavigator_Push

 {$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Main_Control_RightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

 {$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Main_Control_RightNavigator_Push
 {$IfEnd} // Defined(HasRightNavigator)

 TkwMainFormStatusBar = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.StatusBar
[panel]Контрол StatusBar формы TMainForm[panel]
*Тип результата:* TnscStatusBar
*Пример:*
[code]
OBJECT VAR l_TnscStatusBar
 aMainForm .TMainForm.StatusBar >>> l_TnscStatusBar
[code]  }
  private
   function StatusBar(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscStatusBar;
    {* Реализация слова скрипта .TMainForm.StatusBar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormStatusBar

 TkwMainFormClientZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.ClientZone
[panel]Контрол ClientZone формы TMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.ClientZone >>> l_TvtPanel
[code]  }
  private
   function ClientZone(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
    {* Реализация слова скрипта .TMainForm.ClientZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormClientZone

 TkwMainFormMainZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.MainZone
[panel]Контрол MainZone формы TMainForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aMainForm .TMainForm.MainZone >>> l_TvtProportionalPanel
[code]  }
  private
   function MainZone(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TMainForm.MainZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormMainZone

 TkwMainFormParentZonePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.ParentZonePanel
[panel]Контрол ParentZonePanel формы TMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.ParentZonePanel >>> l_TvtPanel
[code]  }
  private
   function ParentZonePanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
    {* Реализация слова скрипта .TMainForm.ParentZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormParentZonePanel

 TkwMainFormChildZonePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.ChildZonePanel
[panel]Контрол ChildZonePanel формы TMainForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMainForm .TMainForm.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
  private
   function ChildZonePanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TMainForm.ChildZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormChildZonePanel

 TkwMainFormBaseSearchPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.BaseSearchPanel
[panel]Контрол BaseSearchPanel формы TMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.BaseSearchPanel >>> l_TvtPanel
[code]  }
  private
   function BaseSearchPanel(const aCtx: TtfwContext;
    aMainForm: TMainForm): TvtPanel;
    {* Реализация слова скрипта .TMainForm.BaseSearchPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormBaseSearchPanel

 TkwMainFormLeftNavigator = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.LeftNavigator
[panel]Контрол LeftNavigator формы TMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMainForm .TMainForm.LeftNavigator >>> l_TnscNavigator
[code]  }
  private
   function LeftNavigator(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscNavigator;
    {* Реализация слова скрипта .TMainForm.LeftNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormLeftNavigator

 {$If Defined(HasRightNavigator)}
 TkwMainFormRightNavigator = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.RightNavigator
[panel]Контрол RightNavigator формы TMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMainForm .TMainForm.RightNavigator >>> l_TnscNavigator
[code]  }
  private
   function RightNavigator(const aCtx: TtfwContext;
    aMainForm: TMainForm): TnscNavigator;
    {* Реализация слова скрипта .TMainForm.RightNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainFormRightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

class function Tkw_Form_Main.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Main';
end;//Tkw_Form_Main.GetWordNameForRegister

function Tkw_Form_Main.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0C1F2DC9AC8C_var*
//#UC END# *4DDFD2EA0116_0C1F2DC9AC8C_var*
begin
//#UC START# *4DDFD2EA0116_0C1F2DC9AC8C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0C1F2DC9AC8C_impl*
end;//Tkw_Form_Main.GetString

class function Tkw_Main_Control_StatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StatusBar';
end;//Tkw_Main_Control_StatusBar.GetWordNameForRegister

function Tkw_Main_Control_StatusBar.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4824670A5A2A_var*
//#UC END# *4DDFD2EA0116_4824670A5A2A_var*
begin
//#UC START# *4DDFD2EA0116_4824670A5A2A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4824670A5A2A_impl*
end;//Tkw_Main_Control_StatusBar.GetString

class procedure Tkw_Main_Control_StatusBar.RegisterInEngine;
//#UC START# *52A086150180_4824670A5A2A_var*
//#UC END# *52A086150180_4824670A5A2A_var*
begin
//#UC START# *52A086150180_4824670A5A2A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4824670A5A2A_impl*
end;//Tkw_Main_Control_StatusBar.RegisterInEngine

procedure Tkw_Main_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7BCD9306056A_var*
//#UC END# *4DAEEDE10285_7BCD9306056A_var*
begin
//#UC START# *4DAEEDE10285_7BCD9306056A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7BCD9306056A_impl*
end;//Tkw_Main_Control_StatusBar_Push.DoDoIt

class function Tkw_Main_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StatusBar:push';
end;//Tkw_Main_Control_StatusBar_Push.GetWordNameForRegister

class function Tkw_Main_Control_ClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientZone';
end;//Tkw_Main_Control_ClientZone.GetWordNameForRegister

function Tkw_Main_Control_ClientZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E6747A3933D3_var*
//#UC END# *4DDFD2EA0116_E6747A3933D3_var*
begin
//#UC START# *4DDFD2EA0116_E6747A3933D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E6747A3933D3_impl*
end;//Tkw_Main_Control_ClientZone.GetString

class procedure Tkw_Main_Control_ClientZone.RegisterInEngine;
//#UC START# *52A086150180_E6747A3933D3_var*
//#UC END# *52A086150180_E6747A3933D3_var*
begin
//#UC START# *52A086150180_E6747A3933D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E6747A3933D3_impl*
end;//Tkw_Main_Control_ClientZone.RegisterInEngine

procedure Tkw_Main_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C03853069052_var*
//#UC END# *4DAEEDE10285_C03853069052_var*
begin
//#UC START# *4DAEEDE10285_C03853069052_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C03853069052_impl*
end;//Tkw_Main_Control_ClientZone_Push.DoDoIt

class function Tkw_Main_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientZone:push';
end;//Tkw_Main_Control_ClientZone_Push.GetWordNameForRegister

class function Tkw_Main_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone';
end;//Tkw_Main_Control_MainZone.GetWordNameForRegister

function Tkw_Main_Control_MainZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2DDA8136A2CC_var*
//#UC END# *4DDFD2EA0116_2DDA8136A2CC_var*
begin
//#UC START# *4DDFD2EA0116_2DDA8136A2CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2DDA8136A2CC_impl*
end;//Tkw_Main_Control_MainZone.GetString

class procedure Tkw_Main_Control_MainZone.RegisterInEngine;
//#UC START# *52A086150180_2DDA8136A2CC_var*
//#UC END# *52A086150180_2DDA8136A2CC_var*
begin
//#UC START# *52A086150180_2DDA8136A2CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2DDA8136A2CC_impl*
end;//Tkw_Main_Control_MainZone.RegisterInEngine

procedure Tkw_Main_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C89B13837B6D_var*
//#UC END# *4DAEEDE10285_C89B13837B6D_var*
begin
//#UC START# *4DAEEDE10285_C89B13837B6D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C89B13837B6D_impl*
end;//Tkw_Main_Control_MainZone_Push.DoDoIt

class function Tkw_Main_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_Main_Control_MainZone_Push.GetWordNameForRegister

class function Tkw_Main_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZonePanel';
end;//Tkw_Main_Control_ParentZonePanel.GetWordNameForRegister

function Tkw_Main_Control_ParentZonePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4F1EA78CB03B_var*
//#UC END# *4DDFD2EA0116_4F1EA78CB03B_var*
begin
//#UC START# *4DDFD2EA0116_4F1EA78CB03B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4F1EA78CB03B_impl*
end;//Tkw_Main_Control_ParentZonePanel.GetString

class procedure Tkw_Main_Control_ParentZonePanel.RegisterInEngine;
//#UC START# *52A086150180_4F1EA78CB03B_var*
//#UC END# *52A086150180_4F1EA78CB03B_var*
begin
//#UC START# *52A086150180_4F1EA78CB03B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4F1EA78CB03B_impl*
end;//Tkw_Main_Control_ParentZonePanel.RegisterInEngine

procedure Tkw_Main_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_805E0D14D7DB_var*
//#UC END# *4DAEEDE10285_805E0D14D7DB_var*
begin
//#UC START# *4DAEEDE10285_805E0D14D7DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_805E0D14D7DB_impl*
end;//Tkw_Main_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_Main_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZonePanel:push';
end;//Tkw_Main_Control_ParentZonePanel_Push.GetWordNameForRegister

class function Tkw_Main_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZonePanel';
end;//Tkw_Main_Control_ChildZonePanel.GetWordNameForRegister

function Tkw_Main_Control_ChildZonePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B5EDBB79177E_var*
//#UC END# *4DDFD2EA0116_B5EDBB79177E_var*
begin
//#UC START# *4DDFD2EA0116_B5EDBB79177E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B5EDBB79177E_impl*
end;//Tkw_Main_Control_ChildZonePanel.GetString

class procedure Tkw_Main_Control_ChildZonePanel.RegisterInEngine;
//#UC START# *52A086150180_B5EDBB79177E_var*
//#UC END# *52A086150180_B5EDBB79177E_var*
begin
//#UC START# *52A086150180_B5EDBB79177E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B5EDBB79177E_impl*
end;//Tkw_Main_Control_ChildZonePanel.RegisterInEngine

procedure Tkw_Main_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F5A64ABB9DD7_var*
//#UC END# *4DAEEDE10285_F5A64ABB9DD7_var*
begin
//#UC START# *4DAEEDE10285_F5A64ABB9DD7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F5A64ABB9DD7_impl*
end;//Tkw_Main_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_Main_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZonePanel:push';
end;//Tkw_Main_Control_ChildZonePanel_Push.GetWordNameForRegister

class function Tkw_Main_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BaseSearchPanel';
end;//Tkw_Main_Control_BaseSearchPanel.GetWordNameForRegister

function Tkw_Main_Control_BaseSearchPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5F19A85E4E70_var*
//#UC END# *4DDFD2EA0116_5F19A85E4E70_var*
begin
//#UC START# *4DDFD2EA0116_5F19A85E4E70_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5F19A85E4E70_impl*
end;//Tkw_Main_Control_BaseSearchPanel.GetString

class procedure Tkw_Main_Control_BaseSearchPanel.RegisterInEngine;
//#UC START# *52A086150180_5F19A85E4E70_var*
//#UC END# *52A086150180_5F19A85E4E70_var*
begin
//#UC START# *52A086150180_5F19A85E4E70_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5F19A85E4E70_impl*
end;//Tkw_Main_Control_BaseSearchPanel.RegisterInEngine

procedure Tkw_Main_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_604B7AAA90AC_var*
//#UC END# *4DAEEDE10285_604B7AAA90AC_var*
begin
//#UC START# *4DAEEDE10285_604B7AAA90AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_604B7AAA90AC_impl*
end;//Tkw_Main_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_Main_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BaseSearchPanel:push';
end;//Tkw_Main_Control_BaseSearchPanel_Push.GetWordNameForRegister

class function Tkw_Main_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftNavigator';
end;//Tkw_Main_Control_LeftNavigator.GetWordNameForRegister

function Tkw_Main_Control_LeftNavigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F836C01A2B81_var*
//#UC END# *4DDFD2EA0116_F836C01A2B81_var*
begin
//#UC START# *4DDFD2EA0116_F836C01A2B81_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F836C01A2B81_impl*
end;//Tkw_Main_Control_LeftNavigator.GetString

class procedure Tkw_Main_Control_LeftNavigator.RegisterInEngine;
//#UC START# *52A086150180_F836C01A2B81_var*
//#UC END# *52A086150180_F836C01A2B81_var*
begin
//#UC START# *52A086150180_F836C01A2B81_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F836C01A2B81_impl*
end;//Tkw_Main_Control_LeftNavigator.RegisterInEngine

procedure Tkw_Main_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4A8475A64C5D_var*
//#UC END# *4DAEEDE10285_4A8475A64C5D_var*
begin
//#UC START# *4DAEEDE10285_4A8475A64C5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4A8475A64C5D_impl*
end;//Tkw_Main_Control_LeftNavigator_Push.DoDoIt

class function Tkw_Main_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftNavigator:push';
end;//Tkw_Main_Control_LeftNavigator_Push.GetWordNameForRegister

class function Tkw_Main_Control_RightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightNavigator';
end;//Tkw_Main_Control_RightNavigator.GetWordNameForRegister

function Tkw_Main_Control_RightNavigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5532C5E8A0E4_var*
//#UC END# *4DDFD2EA0116_5532C5E8A0E4_var*
begin
//#UC START# *4DDFD2EA0116_5532C5E8A0E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5532C5E8A0E4_impl*
end;//Tkw_Main_Control_RightNavigator.GetString

class procedure Tkw_Main_Control_RightNavigator.RegisterInEngine;
//#UC START# *52A086150180_5532C5E8A0E4_var*
//#UC END# *52A086150180_5532C5E8A0E4_var*
begin
//#UC START# *52A086150180_5532C5E8A0E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5532C5E8A0E4_impl*
end;//Tkw_Main_Control_RightNavigator.RegisterInEngine

procedure Tkw_Main_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_67B2DC3359FC_var*
//#UC END# *4DAEEDE10285_67B2DC3359FC_var*
begin
//#UC START# *4DAEEDE10285_67B2DC3359FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_67B2DC3359FC_impl*
end;//Tkw_Main_Control_RightNavigator_Push.DoDoIt

class function Tkw_Main_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightNavigator:push';
end;//Tkw_Main_Control_RightNavigator_Push.GetWordNameForRegister

function TkwMainFormStatusBar.StatusBar(const aCtx: TtfwContext;
 aMainForm: TMainForm): TnscStatusBar;
 {* Реализация слова скрипта .TMainForm.StatusBar }
//#UC START# *14CB668555BE_E7937E8D2012_var*
//#UC END# *14CB668555BE_E7937E8D2012_var*
begin
//#UC START# *14CB668555BE_E7937E8D2012_impl*
 !!! Needs to be implemented !!!
//#UC END# *14CB668555BE_E7937E8D2012_impl*
end;//TkwMainFormStatusBar.StatusBar

procedure TkwMainFormStatusBar.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StatusBar(aCtx, l_aMainForm));
end;//TkwMainFormStatusBar.DoDoIt

class function TkwMainFormStatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.StatusBar';
end;//TkwMainFormStatusBar.GetWordNameForRegister

procedure TkwMainFormStatusBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TnscStatusBar(aValue.AsObject(TnscStatusBar));
end;//TkwMainFormStatusBar.SetValuePrim

function TkwMainFormStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwMainFormStatusBar.GetResultTypeInfo

function TkwMainFormStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormStatusBar.GetAllParamsCount

function TkwMainFormStatusBar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormStatusBar.ParamsTypes

function TkwMainFormClientZone.ClientZone(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtPanel;
 {* Реализация слова скрипта .TMainForm.ClientZone }
//#UC START# *790D6FDB47ED_E8000876B931_var*
//#UC END# *790D6FDB47ED_E8000876B931_var*
begin
//#UC START# *790D6FDB47ED_E8000876B931_impl*
 !!! Needs to be implemented !!!
//#UC END# *790D6FDB47ED_E8000876B931_impl*
end;//TkwMainFormClientZone.ClientZone

procedure TkwMainFormClientZone.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ClientZone(aCtx, l_aMainForm));
end;//TkwMainFormClientZone.DoDoIt

class function TkwMainFormClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.ClientZone';
end;//TkwMainFormClientZone.GetWordNameForRegister

procedure TkwMainFormClientZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwMainFormClientZone.SetValuePrim

function TkwMainFormClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormClientZone.GetResultTypeInfo

function TkwMainFormClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormClientZone.GetAllParamsCount

function TkwMainFormClientZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormClientZone.ParamsTypes

function TkwMainFormMainZone.MainZone(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TMainForm.MainZone }
//#UC START# *341ECBE7AEED_0F505AC58780_var*
//#UC END# *341ECBE7AEED_0F505AC58780_var*
begin
//#UC START# *341ECBE7AEED_0F505AC58780_impl*
 !!! Needs to be implemented !!!
//#UC END# *341ECBE7AEED_0F505AC58780_impl*
end;//TkwMainFormMainZone.MainZone

procedure TkwMainFormMainZone.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MainZone(aCtx, l_aMainForm));
end;//TkwMainFormMainZone.DoDoIt

class function TkwMainFormMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.MainZone';
end;//TkwMainFormMainZone.GetWordNameForRegister

procedure TkwMainFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TvtProportionalPanel(aValue.AsObject(TvtProportionalPanel));
end;//TkwMainFormMainZone.SetValuePrim

function TkwMainFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwMainFormMainZone.GetResultTypeInfo

function TkwMainFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormMainZone.GetAllParamsCount

function TkwMainFormMainZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormMainZone.ParamsTypes

function TkwMainFormParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtPanel;
 {* Реализация слова скрипта .TMainForm.ParentZonePanel }
//#UC START# *F761950D5FAF_13CB2670C2C7_var*
//#UC END# *F761950D5FAF_13CB2670C2C7_var*
begin
//#UC START# *F761950D5FAF_13CB2670C2C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *F761950D5FAF_13CB2670C2C7_impl*
end;//TkwMainFormParentZonePanel.ParentZonePanel

procedure TkwMainFormParentZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZonePanel(aCtx, l_aMainForm));
end;//TkwMainFormParentZonePanel.DoDoIt

class function TkwMainFormParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.ParentZonePanel';
end;//TkwMainFormParentZonePanel.GetWordNameForRegister

procedure TkwMainFormParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwMainFormParentZonePanel.SetValuePrim

function TkwMainFormParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormParentZonePanel.GetResultTypeInfo

function TkwMainFormParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormParentZonePanel.GetAllParamsCount

function TkwMainFormParentZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormParentZonePanel.ParamsTypes

function TkwMainFormChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TMainForm.ChildZonePanel }
//#UC START# *727146AAB600_CA34AD1DFE87_var*
//#UC END# *727146AAB600_CA34AD1DFE87_var*
begin
//#UC START# *727146AAB600_CA34AD1DFE87_impl*
 !!! Needs to be implemented !!!
//#UC END# *727146AAB600_CA34AD1DFE87_impl*
end;//TkwMainFormChildZonePanel.ChildZonePanel

procedure TkwMainFormChildZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZonePanel(aCtx, l_aMainForm));
end;//TkwMainFormChildZonePanel.DoDoIt

class function TkwMainFormChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.ChildZonePanel';
end;//TkwMainFormChildZonePanel.GetWordNameForRegister

procedure TkwMainFormChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TvtSizeablePanel(aValue.AsObject(TvtSizeablePanel));
end;//TkwMainFormChildZonePanel.SetValuePrim

function TkwMainFormChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMainFormChildZonePanel.GetResultTypeInfo

function TkwMainFormChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormChildZonePanel.GetAllParamsCount

function TkwMainFormChildZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormChildZonePanel.ParamsTypes

function TkwMainFormBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
 aMainForm: TMainForm): TvtPanel;
 {* Реализация слова скрипта .TMainForm.BaseSearchPanel }
//#UC START# *AB391F4900BC_52B37CC440AC_var*
//#UC END# *AB391F4900BC_52B37CC440AC_var*
begin
//#UC START# *AB391F4900BC_52B37CC440AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *AB391F4900BC_52B37CC440AC_impl*
end;//TkwMainFormBaseSearchPanel.BaseSearchPanel

procedure TkwMainFormBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BaseSearchPanel(aCtx, l_aMainForm));
end;//TkwMainFormBaseSearchPanel.DoDoIt

class function TkwMainFormBaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.BaseSearchPanel';
end;//TkwMainFormBaseSearchPanel.GetWordNameForRegister

procedure TkwMainFormBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwMainFormBaseSearchPanel.SetValuePrim

function TkwMainFormBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainFormBaseSearchPanel.GetResultTypeInfo

function TkwMainFormBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormBaseSearchPanel.GetAllParamsCount

function TkwMainFormBaseSearchPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormBaseSearchPanel.ParamsTypes

function TkwMainFormLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
 aMainForm: TMainForm): TnscNavigator;
 {* Реализация слова скрипта .TMainForm.LeftNavigator }
//#UC START# *430B6E47C888_0C160E9D7D22_var*
//#UC END# *430B6E47C888_0C160E9D7D22_var*
begin
//#UC START# *430B6E47C888_0C160E9D7D22_impl*
 !!! Needs to be implemented !!!
//#UC END# *430B6E47C888_0C160E9D7D22_impl*
end;//TkwMainFormLeftNavigator.LeftNavigator

procedure TkwMainFormLeftNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftNavigator(aCtx, l_aMainForm));
end;//TkwMainFormLeftNavigator.DoDoIt

class function TkwMainFormLeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.LeftNavigator';
end;//TkwMainFormLeftNavigator.GetWordNameForRegister

procedure TkwMainFormLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TnscNavigator(aValue.AsObject(TnscNavigator));
end;//TkwMainFormLeftNavigator.SetValuePrim

function TkwMainFormLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainFormLeftNavigator.GetResultTypeInfo

function TkwMainFormLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormLeftNavigator.GetAllParamsCount

function TkwMainFormLeftNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormLeftNavigator.ParamsTypes

{$If Defined(HasRightNavigator)}
function TkwMainFormRightNavigator.RightNavigator(const aCtx: TtfwContext;
 aMainForm: TMainForm): TnscNavigator;
 {* Реализация слова скрипта .TMainForm.RightNavigator }
//#UC START# *8641DD667255_DAD6AC79A3FE_var*
//#UC END# *8641DD667255_DAD6AC79A3FE_var*
begin
//#UC START# *8641DD667255_DAD6AC79A3FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *8641DD667255_DAD6AC79A3FE_impl*
end;//TkwMainFormRightNavigator.RightNavigator
{$IfEnd} // Defined(HasRightNavigator)

procedure TkwMainFormRightNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aMainForm: TMainForm;
begin
 try
  l_aMainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightNavigator(aCtx, l_aMainForm));
end;//TkwMainFormRightNavigator.DoDoIt

class function TkwMainFormRightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TMainForm.RightNavigator';
end;//TkwMainFormRightNavigator.GetWordNameForRegister

procedure TkwMainFormRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_MainForm: TMainForm;
begin
 try
  l_MainForm := TMainForm(aCtx.rEngine.PopObjAs(TMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра MainForm: TMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MainForm. := TnscNavigator(aValue.AsObject(TnscNavigator));
end;//TkwMainFormRightNavigator.SetValuePrim

function TkwMainFormRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainFormRightNavigator.GetResultTypeInfo

function TkwMainFormRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMainFormRightNavigator.GetAllParamsCount

function TkwMainFormRightNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMainForm)]);
end;//TkwMainFormRightNavigator.ParamsTypes

initialization
 Tkw_Form_Main.RegisterInEngine;
 {* Регистрация Tkw_Form_Main }
 Tkw_Main_Control_StatusBar.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_StatusBar }
 Tkw_Main_Control_StatusBar_Push.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_StatusBar_Push }
 Tkw_Main_Control_ClientZone.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_ClientZone }
 Tkw_Main_Control_ClientZone_Push.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_ClientZone_Push }
 Tkw_Main_Control_MainZone.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_MainZone }
 Tkw_Main_Control_MainZone_Push.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_MainZone_Push }
 Tkw_Main_Control_ParentZonePanel.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_ParentZonePanel }
 Tkw_Main_Control_ParentZonePanel_Push.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_ParentZonePanel_Push }
 Tkw_Main_Control_ChildZonePanel.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_ChildZonePanel }
 Tkw_Main_Control_ChildZonePanel_Push.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_ChildZonePanel_Push }
 Tkw_Main_Control_BaseSearchPanel.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_BaseSearchPanel }
 Tkw_Main_Control_BaseSearchPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_BaseSearchPanel_Push }
 Tkw_Main_Control_LeftNavigator.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_LeftNavigator }
 Tkw_Main_Control_LeftNavigator_Push.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_LeftNavigator_Push }
{$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
{$If Defined(HasRightNavigator)}
 Tkw_Main_Control_RightNavigator_Push.RegisterInEngine;
 {* Регистрация Tkw_Main_Control_RightNavigator_Push }
{$IfEnd} // Defined(HasRightNavigator)
 TkwMainFormStatusBar.RegisterInEngine;
 {* Регистрация MainForm_StatusBar }
 TkwMainFormClientZone.RegisterInEngine;
 {* Регистрация MainForm_ClientZone }
 TkwMainFormMainZone.RegisterInEngine;
 {* Регистрация MainForm_MainZone }
 TkwMainFormParentZonePanel.RegisterInEngine;
 {* Регистрация MainForm_ParentZonePanel }
 TkwMainFormChildZonePanel.RegisterInEngine;
 {* Регистрация MainForm_ChildZonePanel }
 TkwMainFormBaseSearchPanel.RegisterInEngine;
 {* Регистрация MainForm_BaseSearchPanel }
 TkwMainFormLeftNavigator.RegisterInEngine;
 {* Регистрация MainForm_LeftNavigator }
{$If Defined(HasRightNavigator)}
 TkwMainFormRightNavigator.RegisterInEngine;
 {* Регистрация MainForm_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMainForm));
 {* Регистрация типа Main }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
 {* Регистрация типа TnscStatusBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscNavigator));
 {* Регистрация типа TnscNavigator }
{$IfEnd} // Defined(NewGen) AND NOT Defined(NoScripts)

end.
