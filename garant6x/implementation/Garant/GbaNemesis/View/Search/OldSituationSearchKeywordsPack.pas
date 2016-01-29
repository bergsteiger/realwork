unit OldSituationSearchKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/OldSituationSearchKeywordsPack.pas"
// �����: 08.09.2009 15:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 �������� ����������::Search::View::Search::Search::OldSituationSearchKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� OldSituationSearch
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  OldSituationSearch_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_OldSituationSearch = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� OldSituationSearch
----
*������ �������������*:
[code]
'aControl' �����::OldSituationSearch TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_OldSituationSearch

// start class Tkw_Form_OldSituationSearch

class function Tkw_Form_OldSituationSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::OldSituationSearch';
end;//Tkw_Form_OldSituationSearch.GetWordNameForRegister

function Tkw_Form_OldSituationSearch.GetString: AnsiString;
 {-}
begin
 Result := 'cfOldSituationSearch';
end;//Tkw_Form_OldSituationSearch.GetString

type
  Tkw_OldSituationSearch_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_OldSituationSearch_Control_BackgroundPanel

// start class Tkw_OldSituationSearch_Control_BackgroundPanel

class function Tkw_OldSituationSearch_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_OldSituationSearch_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_OldSituationSearch_Control_BackgroundPanel.GetString

class procedure Tkw_OldSituationSearch_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_OldSituationSearch_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_OldSituationSearch_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_OldSituationSearch_Control_BackgroundPanel_Push

// start class Tkw_OldSituationSearch_Control_BackgroundPanel_Push

procedure Tkw_OldSituationSearch_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_OldSituationSearch_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_OldSituationSearch_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_OldSituationSearch_Control_ContextFilter = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_OldSituationSearch_Control_ContextFilter

// start class Tkw_OldSituationSearch_Control_ContextFilter

class function Tkw_OldSituationSearch_Control_ContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter';
end;//Tkw_OldSituationSearch_Control_ContextFilter.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_ContextFilter.GetString: AnsiString;
 {-}
begin
 Result := 'ContextFilter';
end;//Tkw_OldSituationSearch_Control_ContextFilter.GetString

class procedure Tkw_OldSituationSearch_Control_ContextFilter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_OldSituationSearch_Control_ContextFilter.RegisterInEngine

type
  Tkw_OldSituationSearch_Control_ContextFilter_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_OldSituationSearch_Control_ContextFilter_Push

// start class Tkw_OldSituationSearch_Control_ContextFilter_Push

procedure Tkw_OldSituationSearch_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_OldSituationSearch_Control_ContextFilter_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_OldSituationSearch_Control_ContextFilter_Push.GetWordNameForRegister

type
  Tkw_OldSituationSearch_Control_InnerBackgroundPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� InnerBackgroundPanel
----
*������ �������������*:
[code]
�������::InnerBackgroundPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel

// start class Tkw_OldSituationSearch_Control_InnerBackgroundPanel

class function Tkw_OldSituationSearch_Control_InnerBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::InnerBackgroundPanel';
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_InnerBackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'InnerBackgroundPanel';
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel.GetString

class procedure Tkw_OldSituationSearch_Control_InnerBackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel.RegisterInEngine

type
  Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� InnerBackgroundPanel
----
*������ �������������*:
[code]
�������::InnerBackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push

// start class Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push

procedure Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('InnerBackgroundPanel');
 inherited;
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::InnerBackgroundPanel:push';
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_OldSituationSearch_Control_BotomPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� BotomPanel
----
*������ �������������*:
[code]
�������::BotomPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_OldSituationSearch_Control_BotomPanel

// start class Tkw_OldSituationSearch_Control_BotomPanel

class function Tkw_OldSituationSearch_Control_BotomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BotomPanel';
end;//Tkw_OldSituationSearch_Control_BotomPanel.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_BotomPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BotomPanel';
end;//Tkw_OldSituationSearch_Control_BotomPanel.GetString

class procedure Tkw_OldSituationSearch_Control_BotomPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_OldSituationSearch_Control_BotomPanel.RegisterInEngine

type
  Tkw_OldSituationSearch_Control_BotomPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� BotomPanel
----
*������ �������������*:
[code]
�������::BotomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_OldSituationSearch_Control_BotomPanel_Push

// start class Tkw_OldSituationSearch_Control_BotomPanel_Push

procedure Tkw_OldSituationSearch_Control_BotomPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BotomPanel');
 inherited;
end;//Tkw_OldSituationSearch_Control_BotomPanel_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_BotomPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BotomPanel:push';
end;//Tkw_OldSituationSearch_Control_BotomPanel_Push.GetWordNameForRegister

type
  Tkw_OldSituationSearch_Control_ParentZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_OldSituationSearch_Control_ParentZone

// start class Tkw_OldSituationSearch_Control_ParentZone

class function Tkw_OldSituationSearch_Control_ParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ParentZone';
end;//Tkw_OldSituationSearch_Control_ParentZone.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_ParentZone.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZone';
end;//Tkw_OldSituationSearch_Control_ParentZone.GetString

class procedure Tkw_OldSituationSearch_Control_ParentZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_OldSituationSearch_Control_ParentZone.RegisterInEngine

type
  Tkw_OldSituationSearch_Control_ParentZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_OldSituationSearch_Control_ParentZone_Push

// start class Tkw_OldSituationSearch_Control_ParentZone_Push

procedure Tkw_OldSituationSearch_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_OldSituationSearch_Control_ParentZone_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ParentZone:push';
end;//Tkw_OldSituationSearch_Control_ParentZone_Push.GetWordNameForRegister

type
  Tkw_OldSituationSearch_Control_ZoneContainer = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ZoneContainer
----
*������ �������������*:
[code]
�������::ZoneContainer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_OldSituationSearch_Control_ZoneContainer

// start class Tkw_OldSituationSearch_Control_ZoneContainer

class function Tkw_OldSituationSearch_Control_ZoneContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ZoneContainer';
end;//Tkw_OldSituationSearch_Control_ZoneContainer.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_ZoneContainer.GetString: AnsiString;
 {-}
begin
 Result := 'ZoneContainer';
end;//Tkw_OldSituationSearch_Control_ZoneContainer.GetString

class procedure Tkw_OldSituationSearch_Control_ZoneContainer.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_OldSituationSearch_Control_ZoneContainer.RegisterInEngine

type
  Tkw_OldSituationSearch_Control_ZoneContainer_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ZoneContainer
----
*������ �������������*:
[code]
�������::ZoneContainer:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_OldSituationSearch_Control_ZoneContainer_Push

// start class Tkw_OldSituationSearch_Control_ZoneContainer_Push

procedure Tkw_OldSituationSearch_Control_ZoneContainer_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ZoneContainer');
 inherited;
end;//Tkw_OldSituationSearch_Control_ZoneContainer_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_ZoneContainer_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ZoneContainer:push';
end;//Tkw_OldSituationSearch_Control_ZoneContainer_Push.GetWordNameForRegister

type
  Tkw_OldSituationSearch_Control_ChildZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_OldSituationSearch_Control_ChildZone

// start class Tkw_OldSituationSearch_Control_ChildZone

class function Tkw_OldSituationSearch_Control_ChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ChildZone';
end;//Tkw_OldSituationSearch_Control_ChildZone.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_ChildZone.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZone';
end;//Tkw_OldSituationSearch_Control_ChildZone.GetString

class procedure Tkw_OldSituationSearch_Control_ChildZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_OldSituationSearch_Control_ChildZone.RegisterInEngine

type
  Tkw_OldSituationSearch_Control_ChildZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_OldSituationSearch_Control_ChildZone_Push

// start class Tkw_OldSituationSearch_Control_ChildZone_Push

procedure Tkw_OldSituationSearch_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_OldSituationSearch_Control_ChildZone_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ChildZone:push';
end;//Tkw_OldSituationSearch_Control_ChildZone_Push.GetWordNameForRegister

type
  Tkw_OldSituationSearch_Control_MainZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� MainZone
----
*������ �������������*:
[code]
�������::MainZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_OldSituationSearch_Control_MainZone

// start class Tkw_OldSituationSearch_Control_MainZone

class function Tkw_OldSituationSearch_Control_MainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::MainZone';
end;//Tkw_OldSituationSearch_Control_MainZone.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_MainZone.GetString: AnsiString;
 {-}
begin
 Result := 'MainZone';
end;//Tkw_OldSituationSearch_Control_MainZone.GetString

class procedure Tkw_OldSituationSearch_Control_MainZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_OldSituationSearch_Control_MainZone.RegisterInEngine

type
  Tkw_OldSituationSearch_Control_MainZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� MainZone
----
*������ �������������*:
[code]
�������::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_OldSituationSearch_Control_MainZone_Push

// start class Tkw_OldSituationSearch_Control_MainZone_Push

procedure Tkw_OldSituationSearch_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_OldSituationSearch_Control_MainZone_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::MainZone:push';
end;//Tkw_OldSituationSearch_Control_MainZone_Push.GetWordNameForRegister

type
  TkwCfOldSituationSearchBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfOldSituationSearch.BackgroundPanel
[panel]������� BackgroundPanel ����� TcfOldSituationSearch[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 acfOldSituationSearch .TcfOldSituationSearch.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
     {* ���������� ����� ������� .TcfOldSituationSearch.BackgroundPanel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfOldSituationSearchBackgroundPanel

// start class TkwCfOldSituationSearchBackgroundPanel

function TkwCfOldSituationSearchBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
 {-}
begin
 Result := acfOldSituationSearch.BackgroundPanel;
end;//TkwCfOldSituationSearchBackgroundPanel.BackgroundPanel

procedure TkwCfOldSituationSearchBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfOldSituationSearch : TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_acfOldSituationSearch)));
end;//TkwCfOldSituationSearchBackgroundPanel.DoDoIt

class function TkwCfOldSituationSearchBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfOldSituationSearch.BackgroundPanel';
end;//TkwCfOldSituationSearchBackgroundPanel.GetWordNameForRegister

procedure TkwCfOldSituationSearchBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwCfOldSituationSearchBackgroundPanel.SetValuePrim

function TkwCfOldSituationSearchBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfOldSituationSearchBackgroundPanel.GetResultTypeInfo

function TkwCfOldSituationSearchBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfOldSituationSearchBackgroundPanel.GetAllParamsCount

function TkwCfOldSituationSearchBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchBackgroundPanel.ParamsTypes

type
  TkwCfOldSituationSearchContextFilter = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfOldSituationSearch.ContextFilter
[panel]������� ContextFilter ����� TcfOldSituationSearch[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 acfOldSituationSearch .TcfOldSituationSearch.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function ContextFilter(const aCtx: TtfwContext;
     acfOldSituationSearch: TcfOldSituationSearch): TnscContextFilter;
     {* ���������� ����� ������� .TcfOldSituationSearch.ContextFilter }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfOldSituationSearchContextFilter

// start class TkwCfOldSituationSearchContextFilter

function TkwCfOldSituationSearchContextFilter.ContextFilter(const aCtx: TtfwContext;
  acfOldSituationSearch: TcfOldSituationSearch): TnscContextFilter;
 {-}
begin
 Result := acfOldSituationSearch.ContextFilter;
end;//TkwCfOldSituationSearchContextFilter.ContextFilter

procedure TkwCfOldSituationSearchContextFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfOldSituationSearch : TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ContextFilter(aCtx, l_acfOldSituationSearch)));
end;//TkwCfOldSituationSearchContextFilter.DoDoIt

class function TkwCfOldSituationSearchContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfOldSituationSearch.ContextFilter';
end;//TkwCfOldSituationSearchContextFilter.GetWordNameForRegister

procedure TkwCfOldSituationSearchContextFilter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwCfOldSituationSearchContextFilter.SetValuePrim

function TkwCfOldSituationSearchContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwCfOldSituationSearchContextFilter.GetResultTypeInfo

function TkwCfOldSituationSearchContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfOldSituationSearchContextFilter.GetAllParamsCount

function TkwCfOldSituationSearchContextFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchContextFilter.ParamsTypes

type
  TkwCfOldSituationSearchInnerBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfOldSituationSearch.InnerBackgroundPanel
[panel]������� InnerBackgroundPanel ����� TcfOldSituationSearch[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfOldSituationSearch .TcfOldSituationSearch.InnerBackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function InnerBackgroundPanel(const aCtx: TtfwContext;
     acfOldSituationSearch: TcfOldSituationSearch): TvtProportionalPanel;
     {* ���������� ����� ������� .TcfOldSituationSearch.InnerBackgroundPanel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfOldSituationSearchInnerBackgroundPanel

// start class TkwCfOldSituationSearchInnerBackgroundPanel

function TkwCfOldSituationSearchInnerBackgroundPanel.InnerBackgroundPanel(const aCtx: TtfwContext;
  acfOldSituationSearch: TcfOldSituationSearch): TvtProportionalPanel;
 {-}
begin
 Result := acfOldSituationSearch.InnerBackgroundPanel;
end;//TkwCfOldSituationSearchInnerBackgroundPanel.InnerBackgroundPanel

procedure TkwCfOldSituationSearchInnerBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfOldSituationSearch : TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((InnerBackgroundPanel(aCtx, l_acfOldSituationSearch)));
end;//TkwCfOldSituationSearchInnerBackgroundPanel.DoDoIt

class function TkwCfOldSituationSearchInnerBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfOldSituationSearch.InnerBackgroundPanel';
end;//TkwCfOldSituationSearchInnerBackgroundPanel.GetWordNameForRegister

procedure TkwCfOldSituationSearchInnerBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� InnerBackgroundPanel', aCtx);
end;//TkwCfOldSituationSearchInnerBackgroundPanel.SetValuePrim

function TkwCfOldSituationSearchInnerBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfOldSituationSearchInnerBackgroundPanel.GetResultTypeInfo

function TkwCfOldSituationSearchInnerBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfOldSituationSearchInnerBackgroundPanel.GetAllParamsCount

function TkwCfOldSituationSearchInnerBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchInnerBackgroundPanel.ParamsTypes

type
  TkwCfOldSituationSearchBotomPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfOldSituationSearch.BotomPanel
[panel]������� BotomPanel ����� TcfOldSituationSearch[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfOldSituationSearch .TcfOldSituationSearch.BotomPanel >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function BotomPanel(const aCtx: TtfwContext;
     acfOldSituationSearch: TcfOldSituationSearch): TvtSizeablePanel;
     {* ���������� ����� ������� .TcfOldSituationSearch.BotomPanel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfOldSituationSearchBotomPanel

// start class TkwCfOldSituationSearchBotomPanel

function TkwCfOldSituationSearchBotomPanel.BotomPanel(const aCtx: TtfwContext;
  acfOldSituationSearch: TcfOldSituationSearch): TvtSizeablePanel;
 {-}
begin
 Result := acfOldSituationSearch.BotomPanel;
end;//TkwCfOldSituationSearchBotomPanel.BotomPanel

procedure TkwCfOldSituationSearchBotomPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfOldSituationSearch : TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BotomPanel(aCtx, l_acfOldSituationSearch)));
end;//TkwCfOldSituationSearchBotomPanel.DoDoIt

class function TkwCfOldSituationSearchBotomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfOldSituationSearch.BotomPanel';
end;//TkwCfOldSituationSearchBotomPanel.GetWordNameForRegister

procedure TkwCfOldSituationSearchBotomPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BotomPanel', aCtx);
end;//TkwCfOldSituationSearchBotomPanel.SetValuePrim

function TkwCfOldSituationSearchBotomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfOldSituationSearchBotomPanel.GetResultTypeInfo

function TkwCfOldSituationSearchBotomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfOldSituationSearchBotomPanel.GetAllParamsCount

function TkwCfOldSituationSearchBotomPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchBotomPanel.ParamsTypes

type
  TkwCfOldSituationSearchParentZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfOldSituationSearch.ParentZone
[panel]������� ParentZone ����� TcfOldSituationSearch[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 acfOldSituationSearch .TcfOldSituationSearch.ParentZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ParentZone(const aCtx: TtfwContext;
     acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
     {* ���������� ����� ������� .TcfOldSituationSearch.ParentZone }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfOldSituationSearchParentZone

// start class TkwCfOldSituationSearchParentZone

function TkwCfOldSituationSearchParentZone.ParentZone(const aCtx: TtfwContext;
  acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
 {-}
begin
 Result := acfOldSituationSearch.ParentZone;
end;//TkwCfOldSituationSearchParentZone.ParentZone

procedure TkwCfOldSituationSearchParentZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfOldSituationSearch : TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentZone(aCtx, l_acfOldSituationSearch)));
end;//TkwCfOldSituationSearchParentZone.DoDoIt

class function TkwCfOldSituationSearchParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfOldSituationSearch.ParentZone';
end;//TkwCfOldSituationSearchParentZone.GetWordNameForRegister

procedure TkwCfOldSituationSearchParentZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ParentZone', aCtx);
end;//TkwCfOldSituationSearchParentZone.SetValuePrim

function TkwCfOldSituationSearchParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfOldSituationSearchParentZone.GetResultTypeInfo

function TkwCfOldSituationSearchParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfOldSituationSearchParentZone.GetAllParamsCount

function TkwCfOldSituationSearchParentZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchParentZone.ParamsTypes

type
  TkwCfOldSituationSearchZoneContainer = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfOldSituationSearch.ZoneContainer
[panel]������� ZoneContainer ����� TcfOldSituationSearch[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfOldSituationSearch .TcfOldSituationSearch.ZoneContainer >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function ZoneContainer(const aCtx: TtfwContext;
     acfOldSituationSearch: TcfOldSituationSearch): TvtProportionalPanel;
     {* ���������� ����� ������� .TcfOldSituationSearch.ZoneContainer }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfOldSituationSearchZoneContainer

// start class TkwCfOldSituationSearchZoneContainer

function TkwCfOldSituationSearchZoneContainer.ZoneContainer(const aCtx: TtfwContext;
  acfOldSituationSearch: TcfOldSituationSearch): TvtProportionalPanel;
 {-}
begin
 Result := acfOldSituationSearch.ZoneContainer;
end;//TkwCfOldSituationSearchZoneContainer.ZoneContainer

procedure TkwCfOldSituationSearchZoneContainer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfOldSituationSearch : TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ZoneContainer(aCtx, l_acfOldSituationSearch)));
end;//TkwCfOldSituationSearchZoneContainer.DoDoIt

class function TkwCfOldSituationSearchZoneContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfOldSituationSearch.ZoneContainer';
end;//TkwCfOldSituationSearchZoneContainer.GetWordNameForRegister

procedure TkwCfOldSituationSearchZoneContainer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ZoneContainer', aCtx);
end;//TkwCfOldSituationSearchZoneContainer.SetValuePrim

function TkwCfOldSituationSearchZoneContainer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfOldSituationSearchZoneContainer.GetResultTypeInfo

function TkwCfOldSituationSearchZoneContainer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfOldSituationSearchZoneContainer.GetAllParamsCount

function TkwCfOldSituationSearchZoneContainer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchZoneContainer.ParamsTypes

type
  TkwCfOldSituationSearchChildZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfOldSituationSearch.ChildZone
[panel]������� ChildZone ����� TcfOldSituationSearch[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 acfOldSituationSearch .TcfOldSituationSearch.ChildZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ChildZone(const aCtx: TtfwContext;
     acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
     {* ���������� ����� ������� .TcfOldSituationSearch.ChildZone }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfOldSituationSearchChildZone

// start class TkwCfOldSituationSearchChildZone

function TkwCfOldSituationSearchChildZone.ChildZone(const aCtx: TtfwContext;
  acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
 {-}
begin
 Result := acfOldSituationSearch.ChildZone;
end;//TkwCfOldSituationSearchChildZone.ChildZone

procedure TkwCfOldSituationSearchChildZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfOldSituationSearch : TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ChildZone(aCtx, l_acfOldSituationSearch)));
end;//TkwCfOldSituationSearchChildZone.DoDoIt

class function TkwCfOldSituationSearchChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfOldSituationSearch.ChildZone';
end;//TkwCfOldSituationSearchChildZone.GetWordNameForRegister

procedure TkwCfOldSituationSearchChildZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZone', aCtx);
end;//TkwCfOldSituationSearchChildZone.SetValuePrim

function TkwCfOldSituationSearchChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfOldSituationSearchChildZone.GetResultTypeInfo

function TkwCfOldSituationSearchChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfOldSituationSearchChildZone.GetAllParamsCount

function TkwCfOldSituationSearchChildZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchChildZone.ParamsTypes

type
  TkwCfOldSituationSearchMainZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfOldSituationSearch.MainZone
[panel]������� MainZone ����� TcfOldSituationSearch[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfOldSituationSearch .TcfOldSituationSearch.MainZone >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function MainZone(const aCtx: TtfwContext;
     acfOldSituationSearch: TcfOldSituationSearch): TvtSizeablePanel;
     {* ���������� ����� ������� .TcfOldSituationSearch.MainZone }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfOldSituationSearchMainZone

// start class TkwCfOldSituationSearchMainZone

function TkwCfOldSituationSearchMainZone.MainZone(const aCtx: TtfwContext;
  acfOldSituationSearch: TcfOldSituationSearch): TvtSizeablePanel;
 {-}
begin
 Result := acfOldSituationSearch.MainZone;
end;//TkwCfOldSituationSearchMainZone.MainZone

procedure TkwCfOldSituationSearchMainZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfOldSituationSearch : TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((MainZone(aCtx, l_acfOldSituationSearch)));
end;//TkwCfOldSituationSearchMainZone.DoDoIt

class function TkwCfOldSituationSearchMainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfOldSituationSearch.MainZone';
end;//TkwCfOldSituationSearchMainZone.GetWordNameForRegister

procedure TkwCfOldSituationSearchMainZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� MainZone', aCtx);
end;//TkwCfOldSituationSearchMainZone.SetValuePrim

function TkwCfOldSituationSearchMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfOldSituationSearchMainZone.GetResultTypeInfo

function TkwCfOldSituationSearchMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfOldSituationSearchMainZone.GetAllParamsCount

function TkwCfOldSituationSearchMainZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchMainZone.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_OldSituationSearch
 Tkw_Form_OldSituationSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_BackgroundPanel
 Tkw_OldSituationSearch_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_BackgroundPanel_Push
 Tkw_OldSituationSearch_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_ContextFilter
 Tkw_OldSituationSearch_Control_ContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_ContextFilter_Push
 Tkw_OldSituationSearch_Control_ContextFilter_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_InnerBackgroundPanel
 Tkw_OldSituationSearch_Control_InnerBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push
 Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_BotomPanel
 Tkw_OldSituationSearch_Control_BotomPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_BotomPanel_Push
 Tkw_OldSituationSearch_Control_BotomPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_ParentZone
 Tkw_OldSituationSearch_Control_ParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_ParentZone_Push
 Tkw_OldSituationSearch_Control_ParentZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_ZoneContainer
 Tkw_OldSituationSearch_Control_ZoneContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_ZoneContainer_Push
 Tkw_OldSituationSearch_Control_ZoneContainer_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_ChildZone
 Tkw_OldSituationSearch_Control_ChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_ChildZone_Push
 Tkw_OldSituationSearch_Control_ChildZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_MainZone
 Tkw_OldSituationSearch_Control_MainZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_OldSituationSearch_Control_MainZone_Push
 Tkw_OldSituationSearch_Control_MainZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� cfOldSituationSearch_BackgroundPanel
 TkwCfOldSituationSearchBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� cfOldSituationSearch_ContextFilter
 TkwCfOldSituationSearchContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� cfOldSituationSearch_InnerBackgroundPanel
 TkwCfOldSituationSearchInnerBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� cfOldSituationSearch_BotomPanel
 TkwCfOldSituationSearchBotomPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� cfOldSituationSearch_ParentZone
 TkwCfOldSituationSearchParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� cfOldSituationSearch_ZoneContainer
 TkwCfOldSituationSearchZoneContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� cfOldSituationSearch_ChildZone
 TkwCfOldSituationSearchChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� cfOldSituationSearch_MainZone
 TkwCfOldSituationSearchMainZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� OldSituationSearch
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfOldSituationSearch));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscContextFilter
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.