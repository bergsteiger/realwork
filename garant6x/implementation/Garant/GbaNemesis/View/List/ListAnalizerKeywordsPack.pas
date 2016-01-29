unit ListAnalizerKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/ListAnalizerKeywordsPack.pas"
// �����: 31.08.2009 20:51
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::WorkWithList::View::List::List$FP::ListAnalizerKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� ListAnalizer
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
  eeTreeView,
  vtPanel,
  ListAnalizer_Form,
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
  Tkw_Form_ListAnalizer = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� ListAnalizer
----
*������ �������������*:
[code]
'aControl' �����::ListAnalizer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ListAnalizer

// start class Tkw_Form_ListAnalizer

class function Tkw_Form_ListAnalizer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::ListAnalizer';
end;//Tkw_Form_ListAnalizer.GetWordNameForRegister

function Tkw_Form_ListAnalizer.GetString: AnsiString;
 {-}
begin
 Result := 'ListAnalizerForm';
end;//Tkw_Form_ListAnalizer.GetString

type
  Tkw_ListAnalizer_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_ListAnalizer_Control_BackgroundPanel

// start class Tkw_ListAnalizer_Control_BackgroundPanel

class function Tkw_ListAnalizer_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_ListAnalizer_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_ListAnalizer_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_ListAnalizer_Control_BackgroundPanel.GetString

class procedure Tkw_ListAnalizer_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ListAnalizer_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_ListAnalizer_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_ListAnalizer_Control_BackgroundPanel_Push

// start class Tkw_ListAnalizer_Control_BackgroundPanel_Push

procedure Tkw_ListAnalizer_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_ListAnalizer_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_ListAnalizer_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_ListAnalizer_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_ListAnalizer_Control_ListTree = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ListTree
----
*������ �������������*:
[code]
�������::ListTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ListAnalizer_Control_ListTree

// start class Tkw_ListAnalizer_Control_ListTree

class function Tkw_ListAnalizer_Control_ListTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ListTree';
end;//Tkw_ListAnalizer_Control_ListTree.GetWordNameForRegister

function Tkw_ListAnalizer_Control_ListTree.GetString: AnsiString;
 {-}
begin
 Result := 'ListTree';
end;//Tkw_ListAnalizer_Control_ListTree.GetString

class procedure Tkw_ListAnalizer_Control_ListTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_ListAnalizer_Control_ListTree.RegisterInEngine

type
  Tkw_ListAnalizer_Control_ListTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ListTree
----
*������ �������������*:
[code]
�������::ListTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ListAnalizer_Control_ListTree_Push

// start class Tkw_ListAnalizer_Control_ListTree_Push

procedure Tkw_ListAnalizer_Control_ListTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ListTree');
 inherited;
end;//Tkw_ListAnalizer_Control_ListTree_Push.DoDoIt

class function Tkw_ListAnalizer_Control_ListTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ListTree:push';
end;//Tkw_ListAnalizer_Control_ListTree_Push.GetWordNameForRegister

type
  TkwListAnalizerFormBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TListAnalizerForm.BackgroundPanel
[panel]������� BackgroundPanel ����� TListAnalizerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aListAnalizerForm .TListAnalizerForm.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aListAnalizerForm: TListAnalizerForm): TvtPanel;
     {* ���������� ����� ������� .TListAnalizerForm.BackgroundPanel }
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
  end;//TkwListAnalizerFormBackgroundPanel

// start class TkwListAnalizerFormBackgroundPanel

function TkwListAnalizerFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aListAnalizerForm: TListAnalizerForm): TvtPanel;
 {-}
begin
 Result := aListAnalizerForm.BackgroundPanel;
end;//TkwListAnalizerFormBackgroundPanel.BackgroundPanel

procedure TkwListAnalizerFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aListAnalizerForm : TListAnalizerForm;
begin
 try
  l_aListAnalizerForm := TListAnalizerForm(aCtx.rEngine.PopObjAs(TListAnalizerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aListAnalizerForm: TListAnalizerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aListAnalizerForm)));
end;//TkwListAnalizerFormBackgroundPanel.DoDoIt

class function TkwListAnalizerFormBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TListAnalizerForm.BackgroundPanel';
end;//TkwListAnalizerFormBackgroundPanel.GetWordNameForRegister

procedure TkwListAnalizerFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwListAnalizerFormBackgroundPanel.SetValuePrim

function TkwListAnalizerFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwListAnalizerFormBackgroundPanel.GetResultTypeInfo

function TkwListAnalizerFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwListAnalizerFormBackgroundPanel.GetAllParamsCount

function TkwListAnalizerFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TListAnalizerForm)]);
end;//TkwListAnalizerFormBackgroundPanel.ParamsTypes

type
  TkwListAnalizerFormListTree = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TListAnalizerForm.ListTree
[panel]������� ListTree ����� TListAnalizerForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aListAnalizerForm .TListAnalizerForm.ListTree >>> l_TeeTreeView
[code]  }
  private
  // private methods
   function ListTree(const aCtx: TtfwContext;
     aListAnalizerForm: TListAnalizerForm): TeeTreeView;
     {* ���������� ����� ������� .TListAnalizerForm.ListTree }
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
  end;//TkwListAnalizerFormListTree

// start class TkwListAnalizerFormListTree

function TkwListAnalizerFormListTree.ListTree(const aCtx: TtfwContext;
  aListAnalizerForm: TListAnalizerForm): TeeTreeView;
 {-}
begin
 Result := aListAnalizerForm.ListTree;
end;//TkwListAnalizerFormListTree.ListTree

procedure TkwListAnalizerFormListTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aListAnalizerForm : TListAnalizerForm;
begin
 try
  l_aListAnalizerForm := TListAnalizerForm(aCtx.rEngine.PopObjAs(TListAnalizerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aListAnalizerForm: TListAnalizerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ListTree(aCtx, l_aListAnalizerForm)));
end;//TkwListAnalizerFormListTree.DoDoIt

class function TkwListAnalizerFormListTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TListAnalizerForm.ListTree';
end;//TkwListAnalizerFormListTree.GetWordNameForRegister

procedure TkwListAnalizerFormListTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ListTree', aCtx);
end;//TkwListAnalizerFormListTree.SetValuePrim

function TkwListAnalizerFormListTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwListAnalizerFormListTree.GetResultTypeInfo

function TkwListAnalizerFormListTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwListAnalizerFormListTree.GetAllParamsCount

function TkwListAnalizerFormListTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TListAnalizerForm)]);
end;//TkwListAnalizerFormListTree.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_ListAnalizer
 Tkw_Form_ListAnalizer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ListAnalizer_Control_BackgroundPanel
 Tkw_ListAnalizer_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ListAnalizer_Control_BackgroundPanel_Push
 Tkw_ListAnalizer_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ListAnalizer_Control_ListTree
 Tkw_ListAnalizer_Control_ListTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ListAnalizer_Control_ListTree_Push
 Tkw_ListAnalizer_Control_ListTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ListAnalizerForm_BackgroundPanel
 TkwListAnalizerFormBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ListAnalizerForm_ListTree
 TkwListAnalizerFormListTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� ListAnalizer
 TtfwTypeRegistrator.RegisterType(TypeInfo(TListAnalizerForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TeeTreeView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.