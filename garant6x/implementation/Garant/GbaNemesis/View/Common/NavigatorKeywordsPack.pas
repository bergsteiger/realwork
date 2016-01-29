unit NavigatorKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/NavigatorKeywordsPack.pas"
// �����: 24.08.2009 20:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Core::Common::View::Common::PrimF1Common::NavigatorKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� Navigator
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
  vtPanel,
  Navigator_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscTreeViewWithAdapterDragDrop,
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
  Tkw_Form_Navigator = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� Navigator
----
*������ �������������*:
[code]
'aControl' �����::Navigator TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Navigator

// start class Tkw_Form_Navigator

class function Tkw_Form_Navigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Navigator';
end;//Tkw_Form_Navigator.GetWordNameForRegister

function Tkw_Form_Navigator.GetString: AnsiString;
 {-}
begin
 Result := 'en_Navigator';
end;//Tkw_Form_Navigator.GetString

type
  Tkw_Navigator_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Navigator_Control_BackgroundPanel

// start class Tkw_Navigator_Control_BackgroundPanel

class function Tkw_Navigator_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_Navigator_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Navigator_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_Navigator_Control_BackgroundPanel.GetString

class procedure Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_Navigator_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Navigator_Control_BackgroundPanel_Push

// start class Tkw_Navigator_Control_BackgroundPanel_Push

procedure Tkw_Navigator_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_Navigator_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Navigator_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_Navigator_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_Navigator_Control_ContextFilter = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Navigator_Control_ContextFilter

// start class Tkw_Navigator_Control_ContextFilter

class function Tkw_Navigator_Control_ContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter';
end;//Tkw_Navigator_Control_ContextFilter.GetWordNameForRegister

function Tkw_Navigator_Control_ContextFilter.GetString: AnsiString;
 {-}
begin
 Result := 'ContextFilter';
end;//Tkw_Navigator_Control_ContextFilter.GetString

class procedure Tkw_Navigator_Control_ContextFilter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_Navigator_Control_ContextFilter.RegisterInEngine

type
  Tkw_Navigator_Control_ContextFilter_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Navigator_Control_ContextFilter_Push

// start class Tkw_Navigator_Control_ContextFilter_Push

procedure Tkw_Navigator_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_Navigator_Control_ContextFilter_Push.DoDoIt

class function Tkw_Navigator_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_Navigator_Control_ContextFilter_Push.GetWordNameForRegister

type
  Tkw_Navigator_Control_NavigatorTree = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� NavigatorTree
----
*������ �������������*:
[code]
�������::NavigatorTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Navigator_Control_NavigatorTree

// start class Tkw_Navigator_Control_NavigatorTree

class function Tkw_Navigator_Control_NavigatorTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::NavigatorTree';
end;//Tkw_Navigator_Control_NavigatorTree.GetWordNameForRegister

function Tkw_Navigator_Control_NavigatorTree.GetString: AnsiString;
 {-}
begin
 Result := 'NavigatorTree';
end;//Tkw_Navigator_Control_NavigatorTree.GetString

class procedure Tkw_Navigator_Control_NavigatorTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Navigator_Control_NavigatorTree.RegisterInEngine

type
  Tkw_Navigator_Control_NavigatorTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� NavigatorTree
----
*������ �������������*:
[code]
�������::NavigatorTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Navigator_Control_NavigatorTree_Push

// start class Tkw_Navigator_Control_NavigatorTree_Push

procedure Tkw_Navigator_Control_NavigatorTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NavigatorTree');
 inherited;
end;//Tkw_Navigator_Control_NavigatorTree_Push.DoDoIt

class function Tkw_Navigator_Control_NavigatorTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::NavigatorTree:push';
end;//Tkw_Navigator_Control_NavigatorTree_Push.GetWordNameForRegister

type
  TkwEnNavigatorBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_Navigator.BackgroundPanel
[panel]������� BackgroundPanel ����� Ten_Navigator[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_Navigator .Ten_Navigator.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aen_Navigator: Ten_Navigator): TvtPanel;
     {* ���������� ����� ������� .Ten_Navigator.BackgroundPanel }
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
  end;//TkwEnNavigatorBackgroundPanel

// start class TkwEnNavigatorBackgroundPanel

function TkwEnNavigatorBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aen_Navigator: Ten_Navigator): TvtPanel;
 {-}
begin
 Result := aen_Navigator.BackgroundPanel;
end;//TkwEnNavigatorBackgroundPanel.BackgroundPanel

procedure TkwEnNavigatorBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_Navigator : Ten_Navigator;
begin
 try
  l_aen_Navigator := Ten_Navigator(aCtx.rEngine.PopObjAs(Ten_Navigator));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_Navigator: Ten_Navigator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aen_Navigator)));
end;//TkwEnNavigatorBackgroundPanel.DoDoIt

class function TkwEnNavigatorBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_Navigator.BackgroundPanel';
end;//TkwEnNavigatorBackgroundPanel.GetWordNameForRegister

procedure TkwEnNavigatorBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwEnNavigatorBackgroundPanel.SetValuePrim

function TkwEnNavigatorBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnNavigatorBackgroundPanel.GetResultTypeInfo

function TkwEnNavigatorBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnNavigatorBackgroundPanel.GetAllParamsCount

function TkwEnNavigatorBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_Navigator)]);
end;//TkwEnNavigatorBackgroundPanel.ParamsTypes

type
  TkwEnNavigatorContextFilter = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_Navigator.ContextFilter
[panel]������� ContextFilter ����� Ten_Navigator[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aen_Navigator .Ten_Navigator.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function ContextFilter(const aCtx: TtfwContext;
     aen_Navigator: Ten_Navigator): TnscContextFilter;
     {* ���������� ����� ������� .Ten_Navigator.ContextFilter }
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
  end;//TkwEnNavigatorContextFilter

// start class TkwEnNavigatorContextFilter

function TkwEnNavigatorContextFilter.ContextFilter(const aCtx: TtfwContext;
  aen_Navigator: Ten_Navigator): TnscContextFilter;
 {-}
begin
 Result := aen_Navigator.ContextFilter;
end;//TkwEnNavigatorContextFilter.ContextFilter

procedure TkwEnNavigatorContextFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_Navigator : Ten_Navigator;
begin
 try
  l_aen_Navigator := Ten_Navigator(aCtx.rEngine.PopObjAs(Ten_Navigator));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_Navigator: Ten_Navigator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ContextFilter(aCtx, l_aen_Navigator)));
end;//TkwEnNavigatorContextFilter.DoDoIt

class function TkwEnNavigatorContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_Navigator.ContextFilter';
end;//TkwEnNavigatorContextFilter.GetWordNameForRegister

procedure TkwEnNavigatorContextFilter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwEnNavigatorContextFilter.SetValuePrim

function TkwEnNavigatorContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnNavigatorContextFilter.GetResultTypeInfo

function TkwEnNavigatorContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnNavigatorContextFilter.GetAllParamsCount

function TkwEnNavigatorContextFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_Navigator)]);
end;//TkwEnNavigatorContextFilter.ParamsTypes

type
  TkwEnNavigatorNavigatorTree = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_Navigator.NavigatorTree
[panel]������� NavigatorTree ����� Ten_Navigator[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_Navigator .Ten_Navigator.NavigatorTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function NavigatorTree(const aCtx: TtfwContext;
     aen_Navigator: Ten_Navigator): TnscTreeViewWithAdapterDragDrop;
     {* ���������� ����� ������� .Ten_Navigator.NavigatorTree }
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
  end;//TkwEnNavigatorNavigatorTree

// start class TkwEnNavigatorNavigatorTree

function TkwEnNavigatorNavigatorTree.NavigatorTree(const aCtx: TtfwContext;
  aen_Navigator: Ten_Navigator): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aen_Navigator.NavigatorTree;
end;//TkwEnNavigatorNavigatorTree.NavigatorTree

procedure TkwEnNavigatorNavigatorTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_Navigator : Ten_Navigator;
begin
 try
  l_aen_Navigator := Ten_Navigator(aCtx.rEngine.PopObjAs(Ten_Navigator));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_Navigator: Ten_Navigator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NavigatorTree(aCtx, l_aen_Navigator)));
end;//TkwEnNavigatorNavigatorTree.DoDoIt

class function TkwEnNavigatorNavigatorTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_Navigator.NavigatorTree';
end;//TkwEnNavigatorNavigatorTree.GetWordNameForRegister

procedure TkwEnNavigatorNavigatorTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� NavigatorTree', aCtx);
end;//TkwEnNavigatorNavigatorTree.SetValuePrim

function TkwEnNavigatorNavigatorTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnNavigatorNavigatorTree.GetResultTypeInfo

function TkwEnNavigatorNavigatorTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnNavigatorNavigatorTree.GetAllParamsCount

function TkwEnNavigatorNavigatorTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_Navigator)]);
end;//TkwEnNavigatorNavigatorTree.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_Navigator
 Tkw_Form_Navigator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Navigator_Control_BackgroundPanel
 Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Navigator_Control_BackgroundPanel_Push
 Tkw_Navigator_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Navigator_Control_ContextFilter
 Tkw_Navigator_Control_ContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Navigator_Control_ContextFilter_Push
 Tkw_Navigator_Control_ContextFilter_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Navigator_Control_NavigatorTree
 Tkw_Navigator_Control_NavigatorTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Navigator_Control_NavigatorTree_Push
 Tkw_Navigator_Control_NavigatorTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_Navigator_BackgroundPanel
 TkwEnNavigatorBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_Navigator_ContextFilter
 TkwEnNavigatorContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_Navigator_NavigatorTree
 TkwEnNavigatorNavigatorTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� Navigator
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_Navigator));
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
// ����������� ���� TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.