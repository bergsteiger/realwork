unit AdminMainKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы AdminMain }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AdminMainKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , AdminMain_Form
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
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_AdminMain = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы AdminMain
----
*Пример использования*:
[code]
'aControl' форма::AdminMain TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AdminMain

 Tkw_AdminMain_Control_StatusBar = {final} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_StatusBar

 Tkw_AdminMain_Control_StatusBar_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_StatusBar_Push

 Tkw_AdminMain_Control_ClientZone = {final} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_ClientZone

 Tkw_AdminMain_Control_ClientZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_ClientZone_Push

 Tkw_AdminMain_Control_MainZone = {final} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_MainZone

 Tkw_AdminMain_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_MainZone_Push

 Tkw_AdminMain_Control_ParentZonePanel = {final} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_ParentZonePanel

 Tkw_AdminMain_Control_ParentZonePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_ParentZonePanel_Push

 Tkw_AdminMain_Control_ChildZonePanel = {final} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_ChildZonePanel

 Tkw_AdminMain_Control_ChildZonePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_ChildZonePanel_Push

 Tkw_AdminMain_Control_BaseSearchPanel = {final} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_BaseSearchPanel

 Tkw_AdminMain_Control_BaseSearchPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_BaseSearchPanel_Push

 Tkw_AdminMain_Control_LeftNavigator = {final} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_LeftNavigator

 Tkw_AdminMain_Control_LeftNavigator_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_LeftNavigator_Push

 {$If Defined(HasRightNavigator)}
 Tkw_AdminMain_Control_RightNavigator = {final} class(TtfwControlString)
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
 end;//Tkw_AdminMain_Control_RightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

 {$If Defined(HasRightNavigator)}
 Tkw_AdminMain_Control_RightNavigator_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminMain_Control_RightNavigator_Push
 {$IfEnd} // Defined(HasRightNavigator)

 TkwAdminMainFormStatusBar = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.StatusBar
[panel]Контрол StatusBar формы TAdminMainForm[panel]
*Тип результата:* TnscStatusBar
*Пример:*
[code]
OBJECT VAR l_TnscStatusBar
 aAdminMainForm .TAdminMainForm.StatusBar >>> l_TnscStatusBar
[code]  }
  private
   function StatusBar(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TnscStatusBar;
    {* Реализация слова скрипта .TAdminMainForm.StatusBar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormStatusBar

 TkwAdminMainFormClientZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.ClientZone
[panel]Контрол ClientZone формы TAdminMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAdminMainForm .TAdminMainForm.ClientZone >>> l_TvtPanel
[code]  }
  private
   function ClientZone(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtPanel;
    {* Реализация слова скрипта .TAdminMainForm.ClientZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormClientZone

 TkwAdminMainFormMainZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.MainZone
[panel]Контрол MainZone формы TAdminMainForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aAdminMainForm .TAdminMainForm.MainZone >>> l_TvtProportionalPanel
[code]  }
  private
   function MainZone(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TAdminMainForm.MainZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormMainZone

 TkwAdminMainFormParentZonePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.ParentZonePanel
[panel]Контрол ParentZonePanel формы TAdminMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAdminMainForm .TAdminMainForm.ParentZonePanel >>> l_TvtPanel
[code]  }
  private
   function ParentZonePanel(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtPanel;
    {* Реализация слова скрипта .TAdminMainForm.ParentZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormParentZonePanel

 TkwAdminMainFormChildZonePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.ChildZonePanel
[panel]Контрол ChildZonePanel формы TAdminMainForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aAdminMainForm .TAdminMainForm.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
  private
   function ChildZonePanel(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TAdminMainForm.ChildZonePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormChildZonePanel

 TkwAdminMainFormBaseSearchPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.BaseSearchPanel
[panel]Контрол BaseSearchPanel формы TAdminMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAdminMainForm .TAdminMainForm.BaseSearchPanel >>> l_TvtPanel
[code]  }
  private
   function BaseSearchPanel(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TvtPanel;
    {* Реализация слова скрипта .TAdminMainForm.BaseSearchPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormBaseSearchPanel

 TkwAdminMainFormLeftNavigator = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.LeftNavigator
[panel]Контрол LeftNavigator формы TAdminMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aAdminMainForm .TAdminMainForm.LeftNavigator >>> l_TnscNavigator
[code]  }
  private
   function LeftNavigator(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TnscNavigator;
    {* Реализация слова скрипта .TAdminMainForm.LeftNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormLeftNavigator

 {$If Defined(HasRightNavigator)}
 TkwAdminMainFormRightNavigator = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAdminMainForm.RightNavigator
[panel]Контрол RightNavigator формы TAdminMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aAdminMainForm .TAdminMainForm.RightNavigator >>> l_TnscNavigator
[code]  }
  private
   function RightNavigator(const aCtx: TtfwContext;
    aAdminMainForm: TAdminMainForm): TnscNavigator;
    {* Реализация слова скрипта .TAdminMainForm.RightNavigator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdminMainFormRightNavigator
 {$IfEnd} // Defined(HasRightNavigator)

class function Tkw_Form_AdminMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::AdminMain';
end;//Tkw_Form_AdminMain.GetWordNameForRegister

function Tkw_Form_AdminMain.GetString: AnsiString;
begin
 Result := 'AdminMainForm';
end;//Tkw_Form_AdminMain.GetString

class function Tkw_AdminMain_Control_StatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StatusBar';
end;//Tkw_AdminMain_Control_StatusBar.GetWordNameForRegister

function Tkw_AdminMain_Control_StatusBar.GetString: AnsiString;
begin
 Result := 'StatusBar';
end;//Tkw_AdminMain_Control_StatusBar.GetString

class procedure Tkw_AdminMain_Control_StatusBar.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscStatusBar);
end;//Tkw_AdminMain_Control_StatusBar.RegisterInEngine

procedure Tkw_AdminMain_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('StatusBar');
 inherited;
end;//Tkw_AdminMain_Control_StatusBar_Push.DoDoIt

class function Tkw_AdminMain_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StatusBar:push';
end;//Tkw_AdminMain_Control_StatusBar_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_ClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientZone';
end;//Tkw_AdminMain_Control_ClientZone.GetWordNameForRegister

function Tkw_AdminMain_Control_ClientZone.GetString: AnsiString;
begin
 Result := 'ClientZone';
end;//Tkw_AdminMain_Control_ClientZone.GetString

class procedure Tkw_AdminMain_Control_ClientZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AdminMain_Control_ClientZone.RegisterInEngine

procedure Tkw_AdminMain_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ClientZone');
 inherited;
end;//Tkw_AdminMain_Control_ClientZone_Push.DoDoIt

class function Tkw_AdminMain_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientZone:push';
end;//Tkw_AdminMain_Control_ClientZone_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone';
end;//Tkw_AdminMain_Control_MainZone.GetWordNameForRegister

function Tkw_AdminMain_Control_MainZone.GetString: AnsiString;
begin
 Result := 'MainZone';
end;//Tkw_AdminMain_Control_MainZone.GetString

class procedure Tkw_AdminMain_Control_MainZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AdminMain_Control_MainZone.RegisterInEngine

procedure Tkw_AdminMain_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_AdminMain_Control_MainZone_Push.DoDoIt

class function Tkw_AdminMain_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_AdminMain_Control_MainZone_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZonePanel';
end;//Tkw_AdminMain_Control_ParentZonePanel.GetWordNameForRegister

function Tkw_AdminMain_Control_ParentZonePanel.GetString: AnsiString;
begin
 Result := 'ParentZonePanel';
end;//Tkw_AdminMain_Control_ParentZonePanel.GetString

class procedure Tkw_AdminMain_Control_ParentZonePanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AdminMain_Control_ParentZonePanel.RegisterInEngine

procedure Tkw_AdminMain_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZonePanel');
 inherited;
end;//Tkw_AdminMain_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_AdminMain_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZonePanel:push';
end;//Tkw_AdminMain_Control_ParentZonePanel_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZonePanel';
end;//Tkw_AdminMain_Control_ChildZonePanel.GetWordNameForRegister

function Tkw_AdminMain_Control_ChildZonePanel.GetString: AnsiString;
begin
 Result := 'ChildZonePanel';
end;//Tkw_AdminMain_Control_ChildZonePanel.GetString

class procedure Tkw_AdminMain_Control_ChildZonePanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AdminMain_Control_ChildZonePanel.RegisterInEngine

procedure Tkw_AdminMain_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZonePanel');
 inherited;
end;//Tkw_AdminMain_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_AdminMain_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZonePanel:push';
end;//Tkw_AdminMain_Control_ChildZonePanel_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BaseSearchPanel';
end;//Tkw_AdminMain_Control_BaseSearchPanel.GetWordNameForRegister

function Tkw_AdminMain_Control_BaseSearchPanel.GetString: AnsiString;
begin
 Result := 'BaseSearchPanel';
end;//Tkw_AdminMain_Control_BaseSearchPanel.GetString

class procedure Tkw_AdminMain_Control_BaseSearchPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AdminMain_Control_BaseSearchPanel.RegisterInEngine

procedure Tkw_AdminMain_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BaseSearchPanel');
 inherited;
end;//Tkw_AdminMain_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_AdminMain_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BaseSearchPanel:push';
end;//Tkw_AdminMain_Control_BaseSearchPanel_Push.GetWordNameForRegister

class function Tkw_AdminMain_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftNavigator';
end;//Tkw_AdminMain_Control_LeftNavigator.GetWordNameForRegister

function Tkw_AdminMain_Control_LeftNavigator.GetString: AnsiString;
begin
 Result := 'LeftNavigator';
end;//Tkw_AdminMain_Control_LeftNavigator.GetString

class procedure Tkw_AdminMain_Control_LeftNavigator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_AdminMain_Control_LeftNavigator.RegisterInEngine

procedure Tkw_AdminMain_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftNavigator');
 inherited;
end;//Tkw_AdminMain_Control_LeftNavigator_Push.DoDoIt

class function Tkw_AdminMain_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftNavigator:push';
end;//Tkw_AdminMain_Control_LeftNavigator_Push.GetWordNameForRegister

{$If Defined(HasRightNavigator)}
class function Tkw_AdminMain_Control_RightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightNavigator';
end;//Tkw_AdminMain_Control_RightNavigator.GetWordNameForRegister

function Tkw_AdminMain_Control_RightNavigator.GetString: AnsiString;
begin
 Result := 'RightNavigator';
end;//Tkw_AdminMain_Control_RightNavigator.GetString

class procedure Tkw_AdminMain_Control_RightNavigator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_AdminMain_Control_RightNavigator.RegisterInEngine
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
procedure Tkw_AdminMain_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightNavigator');
 inherited;
end;//Tkw_AdminMain_Control_RightNavigator_Push.DoDoIt

class function Tkw_AdminMain_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightNavigator:push';
end;//Tkw_AdminMain_Control_RightNavigator_Push.GetWordNameForRegister
{$IfEnd} // Defined(HasRightNavigator)

function TkwAdminMainFormStatusBar.StatusBar(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TnscStatusBar;
 {* Реализация слова скрипта .TAdminMainForm.StatusBar }
begin
 Result := aAdminMainForm.StatusBar;
end;//TkwAdminMainFormStatusBar.StatusBar

procedure TkwAdminMainFormStatusBar.DoDoIt(const aCtx: TtfwContext);
var l_aAdminMainForm: TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StatusBar(aCtx, l_aAdminMainForm));
end;//TkwAdminMainFormStatusBar.DoDoIt

class function TkwAdminMainFormStatusBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.StatusBar';
end;//TkwAdminMainFormStatusBar.GetWordNameForRegister

procedure TkwAdminMainFormStatusBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству StatusBar', aCtx);
end;//TkwAdminMainFormStatusBar.SetValuePrim

function TkwAdminMainFormStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwAdminMainFormStatusBar.GetResultTypeInfo

function TkwAdminMainFormStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormStatusBar.GetAllParamsCount

function TkwAdminMainFormStatusBar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormStatusBar.ParamsTypes

function TkwAdminMainFormClientZone.ClientZone(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TvtPanel;
 {* Реализация слова скрипта .TAdminMainForm.ClientZone }
begin
 Result := aAdminMainForm.ClientZone;
end;//TkwAdminMainFormClientZone.ClientZone

procedure TkwAdminMainFormClientZone.DoDoIt(const aCtx: TtfwContext);
var l_aAdminMainForm: TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ClientZone(aCtx, l_aAdminMainForm));
end;//TkwAdminMainFormClientZone.DoDoIt

class function TkwAdminMainFormClientZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.ClientZone';
end;//TkwAdminMainFormClientZone.GetWordNameForRegister

procedure TkwAdminMainFormClientZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ClientZone', aCtx);
end;//TkwAdminMainFormClientZone.SetValuePrim

function TkwAdminMainFormClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAdminMainFormClientZone.GetResultTypeInfo

function TkwAdminMainFormClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormClientZone.GetAllParamsCount

function TkwAdminMainFormClientZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormClientZone.ParamsTypes

function TkwAdminMainFormMainZone.MainZone(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TAdminMainForm.MainZone }
begin
 Result := aAdminMainForm.MainZone;
end;//TkwAdminMainFormMainZone.MainZone

procedure TkwAdminMainFormMainZone.DoDoIt(const aCtx: TtfwContext);
var l_aAdminMainForm: TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MainZone(aCtx, l_aAdminMainForm));
end;//TkwAdminMainFormMainZone.DoDoIt

class function TkwAdminMainFormMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.MainZone';
end;//TkwAdminMainFormMainZone.GetWordNameForRegister

procedure TkwAdminMainFormMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству MainZone', aCtx);
end;//TkwAdminMainFormMainZone.SetValuePrim

function TkwAdminMainFormMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwAdminMainFormMainZone.GetResultTypeInfo

function TkwAdminMainFormMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormMainZone.GetAllParamsCount

function TkwAdminMainFormMainZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormMainZone.ParamsTypes

function TkwAdminMainFormParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TvtPanel;
 {* Реализация слова скрипта .TAdminMainForm.ParentZonePanel }
begin
 Result := aAdminMainForm.ParentZonePanel;
end;//TkwAdminMainFormParentZonePanel.ParentZonePanel

procedure TkwAdminMainFormParentZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aAdminMainForm: TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZonePanel(aCtx, l_aAdminMainForm));
end;//TkwAdminMainFormParentZonePanel.DoDoIt

class function TkwAdminMainFormParentZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.ParentZonePanel';
end;//TkwAdminMainFormParentZonePanel.GetWordNameForRegister

procedure TkwAdminMainFormParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZonePanel', aCtx);
end;//TkwAdminMainFormParentZonePanel.SetValuePrim

function TkwAdminMainFormParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAdminMainFormParentZonePanel.GetResultTypeInfo

function TkwAdminMainFormParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormParentZonePanel.GetAllParamsCount

function TkwAdminMainFormParentZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormParentZonePanel.ParamsTypes

function TkwAdminMainFormChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TAdminMainForm.ChildZonePanel }
begin
 Result := aAdminMainForm.ChildZonePanel;
end;//TkwAdminMainFormChildZonePanel.ChildZonePanel

procedure TkwAdminMainFormChildZonePanel.DoDoIt(const aCtx: TtfwContext);
var l_aAdminMainForm: TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZonePanel(aCtx, l_aAdminMainForm));
end;//TkwAdminMainFormChildZonePanel.DoDoIt

class function TkwAdminMainFormChildZonePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.ChildZonePanel';
end;//TkwAdminMainFormChildZonePanel.GetWordNameForRegister

procedure TkwAdminMainFormChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZonePanel', aCtx);
end;//TkwAdminMainFormChildZonePanel.SetValuePrim

function TkwAdminMainFormChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwAdminMainFormChildZonePanel.GetResultTypeInfo

function TkwAdminMainFormChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormChildZonePanel.GetAllParamsCount

function TkwAdminMainFormChildZonePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormChildZonePanel.ParamsTypes

function TkwAdminMainFormBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TvtPanel;
 {* Реализация слова скрипта .TAdminMainForm.BaseSearchPanel }
begin
 Result := aAdminMainForm.BaseSearchPanel;
end;//TkwAdminMainFormBaseSearchPanel.BaseSearchPanel

procedure TkwAdminMainFormBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
var l_aAdminMainForm: TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BaseSearchPanel(aCtx, l_aAdminMainForm));
end;//TkwAdminMainFormBaseSearchPanel.DoDoIt

class function TkwAdminMainFormBaseSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.BaseSearchPanel';
end;//TkwAdminMainFormBaseSearchPanel.GetWordNameForRegister

procedure TkwAdminMainFormBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BaseSearchPanel', aCtx);
end;//TkwAdminMainFormBaseSearchPanel.SetValuePrim

function TkwAdminMainFormBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAdminMainFormBaseSearchPanel.GetResultTypeInfo

function TkwAdminMainFormBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormBaseSearchPanel.GetAllParamsCount

function TkwAdminMainFormBaseSearchPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormBaseSearchPanel.ParamsTypes

function TkwAdminMainFormLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TnscNavigator;
 {* Реализация слова скрипта .TAdminMainForm.LeftNavigator }
begin
 Result := aAdminMainForm.LeftNavigator;
end;//TkwAdminMainFormLeftNavigator.LeftNavigator

procedure TkwAdminMainFormLeftNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aAdminMainForm: TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftNavigator(aCtx, l_aAdminMainForm));
end;//TkwAdminMainFormLeftNavigator.DoDoIt

class function TkwAdminMainFormLeftNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.LeftNavigator';
end;//TkwAdminMainFormLeftNavigator.GetWordNameForRegister

procedure TkwAdminMainFormLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftNavigator', aCtx);
end;//TkwAdminMainFormLeftNavigator.SetValuePrim

function TkwAdminMainFormLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwAdminMainFormLeftNavigator.GetResultTypeInfo

function TkwAdminMainFormLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormLeftNavigator.GetAllParamsCount

function TkwAdminMainFormLeftNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormLeftNavigator.ParamsTypes

{$If Defined(HasRightNavigator)}
function TkwAdminMainFormRightNavigator.RightNavigator(const aCtx: TtfwContext;
 aAdminMainForm: TAdminMainForm): TnscNavigator;
 {* Реализация слова скрипта .TAdminMainForm.RightNavigator }
begin
 Result := aAdminMainForm.RightNavigator;
end;//TkwAdminMainFormRightNavigator.RightNavigator

procedure TkwAdminMainFormRightNavigator.DoDoIt(const aCtx: TtfwContext);
var l_aAdminMainForm: TAdminMainForm;
begin
 try
  l_aAdminMainForm := TAdminMainForm(aCtx.rEngine.PopObjAs(TAdminMainForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAdminMainForm: TAdminMainForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightNavigator(aCtx, l_aAdminMainForm));
end;//TkwAdminMainFormRightNavigator.DoDoIt

class function TkwAdminMainFormRightNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAdminMainForm.RightNavigator';
end;//TkwAdminMainFormRightNavigator.GetWordNameForRegister

procedure TkwAdminMainFormRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightNavigator', aCtx);
end;//TkwAdminMainFormRightNavigator.SetValuePrim

function TkwAdminMainFormRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwAdminMainFormRightNavigator.GetResultTypeInfo

function TkwAdminMainFormRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdminMainFormRightNavigator.GetAllParamsCount

function TkwAdminMainFormRightNavigator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAdminMainForm)]);
end;//TkwAdminMainFormRightNavigator.ParamsTypes
{$IfEnd} // Defined(HasRightNavigator)

initialization
 Tkw_Form_AdminMain.RegisterInEngine;
 {* Регистрация Tkw_Form_AdminMain }
 Tkw_AdminMain_Control_StatusBar.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_StatusBar }
 Tkw_AdminMain_Control_StatusBar_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_StatusBar_Push }
 Tkw_AdminMain_Control_ClientZone.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_ClientZone }
 Tkw_AdminMain_Control_ClientZone_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_ClientZone_Push }
 Tkw_AdminMain_Control_MainZone.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_MainZone }
 Tkw_AdminMain_Control_MainZone_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_MainZone_Push }
 Tkw_AdminMain_Control_ParentZonePanel.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_ParentZonePanel }
 Tkw_AdminMain_Control_ParentZonePanel_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_ParentZonePanel_Push }
 Tkw_AdminMain_Control_ChildZonePanel.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_ChildZonePanel }
 Tkw_AdminMain_Control_ChildZonePanel_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_ChildZonePanel_Push }
 Tkw_AdminMain_Control_BaseSearchPanel.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_BaseSearchPanel }
 Tkw_AdminMain_Control_BaseSearchPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_BaseSearchPanel_Push }
 Tkw_AdminMain_Control_LeftNavigator.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_LeftNavigator }
 Tkw_AdminMain_Control_LeftNavigator_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_LeftNavigator_Push }
{$If Defined(HasRightNavigator)}
 Tkw_AdminMain_Control_RightNavigator.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
{$If Defined(HasRightNavigator)}
 Tkw_AdminMain_Control_RightNavigator_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminMain_Control_RightNavigator_Push }
{$IfEnd} // Defined(HasRightNavigator)
 TkwAdminMainFormStatusBar.RegisterInEngine;
 {* Регистрация AdminMainForm_StatusBar }
 TkwAdminMainFormClientZone.RegisterInEngine;
 {* Регистрация AdminMainForm_ClientZone }
 TkwAdminMainFormMainZone.RegisterInEngine;
 {* Регистрация AdminMainForm_MainZone }
 TkwAdminMainFormParentZonePanel.RegisterInEngine;
 {* Регистрация AdminMainForm_ParentZonePanel }
 TkwAdminMainFormChildZonePanel.RegisterInEngine;
 {* Регистрация AdminMainForm_ChildZonePanel }
 TkwAdminMainFormBaseSearchPanel.RegisterInEngine;
 {* Регистрация AdminMainForm_BaseSearchPanel }
 TkwAdminMainFormLeftNavigator.RegisterInEngine;
 {* Регистрация AdminMainForm_LeftNavigator }
{$If Defined(HasRightNavigator)}
 TkwAdminMainFormRightNavigator.RegisterInEngine;
 {* Регистрация AdminMainForm_RightNavigator }
{$IfEnd} // Defined(HasRightNavigator)
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAdminMainForm));
 {* Регистрация типа AdminMain }
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
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
