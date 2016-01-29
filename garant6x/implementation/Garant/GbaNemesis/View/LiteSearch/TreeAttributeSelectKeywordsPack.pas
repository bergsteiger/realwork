unit TreeAttributeSelectKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/TreeAttributeSelectKeywordsPack.pas"
// �����: 04.09.2009 14:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::LiteSearch::TreeAttributeSelectKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� TreeAttributeSelect
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  TreeAttributeSelect_Form
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  ,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike,
  SearchLite_Strange_Controls
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
  Tkw_Form_TreeAttributeSelect = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� TreeAttributeSelect
----
*������ �������������*:
[code]
'aControl' �����::TreeAttributeSelect TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_TreeAttributeSelect

// start class Tkw_Form_TreeAttributeSelect

class function Tkw_Form_TreeAttributeSelect.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::TreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect.GetWordNameForRegister

function Tkw_Form_TreeAttributeSelect.GetString: AnsiString;
 {-}
begin
 Result := 'efTreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect.GetString

type
  Tkw_TreeAttributeSelect_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel

// start class Tkw_TreeAttributeSelect_Control_BackgroundPanel

class function Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetString

class procedure Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push

// start class Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push

procedure Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_TreeAttributeSelect_Control_ContextFilter = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_TreeAttributeSelect_Control_ContextFilter

// start class Tkw_TreeAttributeSelect_Control_ContextFilter

class function Tkw_TreeAttributeSelect_Control_ContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_ContextFilter.GetString: AnsiString;
 {-}
begin
 Result := 'ContextFilter';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.GetString

class procedure Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine

type
  Tkw_TreeAttributeSelect_Control_ContextFilter_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push

// start class Tkw_TreeAttributeSelect_Control_ContextFilter_Push

procedure Tkw_TreeAttributeSelect_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push.GetWordNameForRegister

type
  Tkw_TreeAttributeSelect_Control_AttributeTree = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� AttributeTree
----
*������ �������������*:
[code]
�������::AttributeTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TreeAttributeSelect_Control_AttributeTree

// start class Tkw_TreeAttributeSelect_Control_AttributeTree

class function Tkw_TreeAttributeSelect_Control_AttributeTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::AttributeTree';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_AttributeTree.GetString: AnsiString;
 {-}
begin
 Result := 'AttributeTree';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.GetString

class procedure Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine

type
  Tkw_TreeAttributeSelect_Control_AttributeTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� AttributeTree
----
*������ �������������*:
[code]
�������::AttributeTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push

// start class Tkw_TreeAttributeSelect_Control_AttributeTree_Push

procedure Tkw_TreeAttributeSelect_Control_AttributeTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('AttributeTree');
 inherited;
end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_AttributeTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::AttributeTree:push';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push.GetWordNameForRegister

type
  TkwEfTreeAttributeSelectBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefTreeAttributeSelect.BackgroundPanel
[panel]������� BackgroundPanel ����� TefTreeAttributeSelect[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefTreeAttributeSelect .TefTreeAttributeSelect.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aefTreeAttributeSelect: TefTreeAttributeSelect): TvtPanel;
     {* ���������� ����� ������� .TefTreeAttributeSelect.BackgroundPanel }
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
  end;//TkwEfTreeAttributeSelectBackgroundPanel

// start class TkwEfTreeAttributeSelectBackgroundPanel

function TkwEfTreeAttributeSelectBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aefTreeAttributeSelect: TefTreeAttributeSelect): TvtPanel;
 {-}
begin
 Result := aefTreeAttributeSelect.BackgroundPanel;
end;//TkwEfTreeAttributeSelectBackgroundPanel.BackgroundPanel

procedure TkwEfTreeAttributeSelectBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefTreeAttributeSelect : TefTreeAttributeSelect;
begin
 try
  l_aefTreeAttributeSelect := TefTreeAttributeSelect(aCtx.rEngine.PopObjAs(TefTreeAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefTreeAttributeSelect: TefTreeAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aefTreeAttributeSelect)));
end;//TkwEfTreeAttributeSelectBackgroundPanel.DoDoIt

class function TkwEfTreeAttributeSelectBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefTreeAttributeSelect.BackgroundPanel';
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetWordNameForRegister

procedure TkwEfTreeAttributeSelectBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwEfTreeAttributeSelectBackgroundPanel.SetValuePrim

function TkwEfTreeAttributeSelectBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetResultTypeInfo

function TkwEfTreeAttributeSelectBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetAllParamsCount

function TkwEfTreeAttributeSelectBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeSelect)]);
end;//TkwEfTreeAttributeSelectBackgroundPanel.ParamsTypes

type
  TkwEfTreeAttributeSelectContextFilter = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefTreeAttributeSelect.ContextFilter
[panel]������� ContextFilter ����� TefTreeAttributeSelect[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aefTreeAttributeSelect .TefTreeAttributeSelect.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function ContextFilter(const aCtx: TtfwContext;
     aefTreeAttributeSelect: TefTreeAttributeSelect): TnscContextFilter;
     {* ���������� ����� ������� .TefTreeAttributeSelect.ContextFilter }
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
  end;//TkwEfTreeAttributeSelectContextFilter

// start class TkwEfTreeAttributeSelectContextFilter

function TkwEfTreeAttributeSelectContextFilter.ContextFilter(const aCtx: TtfwContext;
  aefTreeAttributeSelect: TefTreeAttributeSelect): TnscContextFilter;
 {-}
begin
 Result := aefTreeAttributeSelect.ContextFilter;
end;//TkwEfTreeAttributeSelectContextFilter.ContextFilter

procedure TkwEfTreeAttributeSelectContextFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefTreeAttributeSelect : TefTreeAttributeSelect;
begin
 try
  l_aefTreeAttributeSelect := TefTreeAttributeSelect(aCtx.rEngine.PopObjAs(TefTreeAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefTreeAttributeSelect: TefTreeAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ContextFilter(aCtx, l_aefTreeAttributeSelect)));
end;//TkwEfTreeAttributeSelectContextFilter.DoDoIt

class function TkwEfTreeAttributeSelectContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefTreeAttributeSelect.ContextFilter';
end;//TkwEfTreeAttributeSelectContextFilter.GetWordNameForRegister

procedure TkwEfTreeAttributeSelectContextFilter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwEfTreeAttributeSelectContextFilter.SetValuePrim

function TkwEfTreeAttributeSelectContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEfTreeAttributeSelectContextFilter.GetResultTypeInfo

function TkwEfTreeAttributeSelectContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfTreeAttributeSelectContextFilter.GetAllParamsCount

function TkwEfTreeAttributeSelectContextFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeSelect)]);
end;//TkwEfTreeAttributeSelectContextFilter.ParamsTypes

type
  TkwEfTreeAttributeSelectAttributeTree = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefTreeAttributeSelect.AttributeTree
[panel]������� AttributeTree ����� TefTreeAttributeSelect[panel]
*��� ����������:* TnscTreeViewHotTruck
*������:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aefTreeAttributeSelect .TefTreeAttributeSelect.AttributeTree >>> l_TnscTreeViewHotTruck
[code]  }
  private
  // private methods
   function AttributeTree(const aCtx: TtfwContext;
     aefTreeAttributeSelect: TefTreeAttributeSelect): TnscTreeViewHotTruck;
     {* ���������� ����� ������� .TefTreeAttributeSelect.AttributeTree }
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
  end;//TkwEfTreeAttributeSelectAttributeTree

// start class TkwEfTreeAttributeSelectAttributeTree

function TkwEfTreeAttributeSelectAttributeTree.AttributeTree(const aCtx: TtfwContext;
  aefTreeAttributeSelect: TefTreeAttributeSelect): TnscTreeViewHotTruck;
 {-}
begin
 Result := aefTreeAttributeSelect.AttributeTree;
end;//TkwEfTreeAttributeSelectAttributeTree.AttributeTree

procedure TkwEfTreeAttributeSelectAttributeTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefTreeAttributeSelect : TefTreeAttributeSelect;
begin
 try
  l_aefTreeAttributeSelect := TefTreeAttributeSelect(aCtx.rEngine.PopObjAs(TefTreeAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefTreeAttributeSelect: TefTreeAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((AttributeTree(aCtx, l_aefTreeAttributeSelect)));
end;//TkwEfTreeAttributeSelectAttributeTree.DoDoIt

class function TkwEfTreeAttributeSelectAttributeTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefTreeAttributeSelect.AttributeTree';
end;//TkwEfTreeAttributeSelectAttributeTree.GetWordNameForRegister

procedure TkwEfTreeAttributeSelectAttributeTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� AttributeTree', aCtx);
end;//TkwEfTreeAttributeSelectAttributeTree.SetValuePrim

function TkwEfTreeAttributeSelectAttributeTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEfTreeAttributeSelectAttributeTree.GetResultTypeInfo

function TkwEfTreeAttributeSelectAttributeTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfTreeAttributeSelectAttributeTree.GetAllParamsCount

function TkwEfTreeAttributeSelectAttributeTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeSelect)]);
end;//TkwEfTreeAttributeSelectAttributeTree.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_Form_TreeAttributeSelect
 Tkw_Form_TreeAttributeSelect.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_TreeAttributeSelect_Control_BackgroundPanel
 Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push
 Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_TreeAttributeSelect_Control_ContextFilter
 Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_TreeAttributeSelect_Control_ContextFilter_Push
 Tkw_TreeAttributeSelect_Control_ContextFilter_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_TreeAttributeSelect_Control_AttributeTree
 Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_TreeAttributeSelect_Control_AttributeTree_Push
 Tkw_TreeAttributeSelect_Control_AttributeTree_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� efTreeAttributeSelect_BackgroundPanel
 TkwEfTreeAttributeSelectBackgroundPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� efTreeAttributeSelect_ContextFilter
 TkwEfTreeAttributeSelectContextFilter.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� efTreeAttributeSelect_AttributeTree
 TkwEfTreeAttributeSelectAttributeTree.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TreeAttributeSelect
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefTreeAttributeSelect));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TnscContextFilter
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TnscTreeViewHotTruck
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
{$IfEnd} //not NoScripts

end.