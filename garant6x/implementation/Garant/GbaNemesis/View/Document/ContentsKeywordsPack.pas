unit ContentsKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/ContentsKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::ContentsKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� Contents
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
  Contents_Form,
  vtLister
  {$If defined(Nemesis)}
  ,
  nscTasksPanelView
  {$IfEnd} //Nemesis
  ,
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
  Tkw_Form_Contents = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� Contents
----
*������ �������������*:
[code]
'aControl' �����::Contents TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Contents

// start class Tkw_Form_Contents

class function Tkw_Form_Contents.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Contents';
end;//Tkw_Form_Contents.GetWordNameForRegister

function Tkw_Form_Contents.GetString: AnsiString;
 {-}
begin
 Result := 'ContentsForm';
end;//Tkw_Form_Contents.GetString

type
  Tkw_Contents_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Contents_Control_BackgroundPanel

// start class Tkw_Contents_Control_BackgroundPanel

class function Tkw_Contents_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_Contents_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Contents_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_Contents_Control_BackgroundPanel.GetString

class procedure Tkw_Contents_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Contents_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_Contents_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Contents_Control_BackgroundPanel_Push

// start class Tkw_Contents_Control_BackgroundPanel_Push

procedure Tkw_Contents_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_Contents_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Contents_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_Contents_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_Contents_Control_lstBookmarks = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� lstBookmarks
----
*������ �������������*:
[code]
�������::lstBookmarks TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Contents_Control_lstBookmarks

// start class Tkw_Contents_Control_lstBookmarks

class function Tkw_Contents_Control_lstBookmarks.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lstBookmarks';
end;//Tkw_Contents_Control_lstBookmarks.GetWordNameForRegister

function Tkw_Contents_Control_lstBookmarks.GetString: AnsiString;
 {-}
begin
 Result := 'lstBookmarks';
end;//Tkw_Contents_Control_lstBookmarks.GetString

class procedure Tkw_Contents_Control_lstBookmarks.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLister);
end;//Tkw_Contents_Control_lstBookmarks.RegisterInEngine

type
  Tkw_Contents_Control_lstBookmarks_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� lstBookmarks
----
*������ �������������*:
[code]
�������::lstBookmarks:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Contents_Control_lstBookmarks_Push

// start class Tkw_Contents_Control_lstBookmarks_Push

procedure Tkw_Contents_Control_lstBookmarks_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lstBookmarks');
 inherited;
end;//Tkw_Contents_Control_lstBookmarks_Push.DoDoIt

class function Tkw_Contents_Control_lstBookmarks_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lstBookmarks:push';
end;//Tkw_Contents_Control_lstBookmarks_Push.GetWordNameForRegister

type
  Tkw_Contents_Control_lstComments = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� lstComments
----
*������ �������������*:
[code]
�������::lstComments TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Contents_Control_lstComments

// start class Tkw_Contents_Control_lstComments

class function Tkw_Contents_Control_lstComments.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lstComments';
end;//Tkw_Contents_Control_lstComments.GetWordNameForRegister

function Tkw_Contents_Control_lstComments.GetString: AnsiString;
 {-}
begin
 Result := 'lstComments';
end;//Tkw_Contents_Control_lstComments.GetString

class procedure Tkw_Contents_Control_lstComments.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLister);
end;//Tkw_Contents_Control_lstComments.RegisterInEngine

type
  Tkw_Contents_Control_lstComments_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� lstComments
----
*������ �������������*:
[code]
�������::lstComments:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Contents_Control_lstComments_Push

// start class Tkw_Contents_Control_lstComments_Push

procedure Tkw_Contents_Control_lstComments_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lstComments');
 inherited;
end;//Tkw_Contents_Control_lstComments_Push.DoDoIt

class function Tkw_Contents_Control_lstComments_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lstComments:push';
end;//Tkw_Contents_Control_lstComments_Push.GetWordNameForRegister

type
  Tkw_Contents_Control_lstExternalObjects = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� lstExternalObjects
----
*������ �������������*:
[code]
�������::lstExternalObjects TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Contents_Control_lstExternalObjects

// start class Tkw_Contents_Control_lstExternalObjects

class function Tkw_Contents_Control_lstExternalObjects.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lstExternalObjects';
end;//Tkw_Contents_Control_lstExternalObjects.GetWordNameForRegister

function Tkw_Contents_Control_lstExternalObjects.GetString: AnsiString;
 {-}
begin
 Result := 'lstExternalObjects';
end;//Tkw_Contents_Control_lstExternalObjects.GetString

class procedure Tkw_Contents_Control_lstExternalObjects.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLister);
end;//Tkw_Contents_Control_lstExternalObjects.RegisterInEngine

type
  Tkw_Contents_Control_lstExternalObjects_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� lstExternalObjects
----
*������ �������������*:
[code]
�������::lstExternalObjects:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Contents_Control_lstExternalObjects_Push

// start class Tkw_Contents_Control_lstExternalObjects_Push

procedure Tkw_Contents_Control_lstExternalObjects_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lstExternalObjects');
 inherited;
end;//Tkw_Contents_Control_lstExternalObjects_Push.DoDoIt

class function Tkw_Contents_Control_lstExternalObjects_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::lstExternalObjects:push';
end;//Tkw_Contents_Control_lstExternalObjects_Push.GetWordNameForRegister

type
  Tkw_Contents_Control_ContentsTree = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ContentsTree
----
*������ �������������*:
[code]
�������::ContentsTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Contents_Control_ContentsTree

// start class Tkw_Contents_Control_ContentsTree

class function Tkw_Contents_Control_ContentsTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContentsTree';
end;//Tkw_Contents_Control_ContentsTree.GetWordNameForRegister

function Tkw_Contents_Control_ContentsTree.GetString: AnsiString;
 {-}
begin
 Result := 'ContentsTree';
end;//Tkw_Contents_Control_ContentsTree.GetString

class procedure Tkw_Contents_Control_ContentsTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Contents_Control_ContentsTree.RegisterInEngine

type
  Tkw_Contents_Control_ContentsTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ContentsTree
----
*������ �������������*:
[code]
�������::ContentsTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Contents_Control_ContentsTree_Push

// start class Tkw_Contents_Control_ContentsTree_Push

procedure Tkw_Contents_Control_ContentsTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContentsTree');
 inherited;
end;//Tkw_Contents_Control_ContentsTree_Push.DoDoIt

class function Tkw_Contents_Control_ContentsTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContentsTree:push';
end;//Tkw_Contents_Control_ContentsTree_Push.GetWordNameForRegister

type
  Tkw_Contents_Control_ContextFilter = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Contents_Control_ContextFilter

// start class Tkw_Contents_Control_ContextFilter

class function Tkw_Contents_Control_ContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter';
end;//Tkw_Contents_Control_ContextFilter.GetWordNameForRegister

function Tkw_Contents_Control_ContextFilter.GetString: AnsiString;
 {-}
begin
 Result := 'ContextFilter';
end;//Tkw_Contents_Control_ContextFilter.GetString

class procedure Tkw_Contents_Control_ContextFilter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_Contents_Control_ContextFilter.RegisterInEngine

type
  Tkw_Contents_Control_ContextFilter_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Contents_Control_ContextFilter_Push

// start class Tkw_Contents_Control_ContextFilter_Push

procedure Tkw_Contents_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_Contents_Control_ContextFilter_Push.DoDoIt

class function Tkw_Contents_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_Contents_Control_ContextFilter_Push.GetWordNameForRegister

type
  Tkw_Contents_Control_Tasks = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� Tasks
----
*������ �������������*:
[code]
�������::Tasks TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Contents_Control_Tasks

// start class Tkw_Contents_Control_Tasks

class function Tkw_Contents_Control_Tasks.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Tasks';
end;//Tkw_Contents_Control_Tasks.GetWordNameForRegister

function Tkw_Contents_Control_Tasks.GetString: AnsiString;
 {-}
begin
 Result := 'Tasks';
end;//Tkw_Contents_Control_Tasks.GetString

class procedure Tkw_Contents_Control_Tasks.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTasksPanelView);
end;//Tkw_Contents_Control_Tasks.RegisterInEngine

type
  Tkw_Contents_Control_Tasks_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� Tasks
----
*������ �������������*:
[code]
�������::Tasks:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Contents_Control_Tasks_Push

// start class Tkw_Contents_Control_Tasks_Push

procedure Tkw_Contents_Control_Tasks_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Tasks');
 inherited;
end;//Tkw_Contents_Control_Tasks_Push.DoDoIt

class function Tkw_Contents_Control_Tasks_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Tasks:push';
end;//Tkw_Contents_Control_Tasks_Push.GetWordNameForRegister

type
  TkwContentsFormBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TContentsForm.BackgroundPanel
[panel]������� BackgroundPanel ����� TContentsForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aContentsForm .TContentsForm.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aContentsForm: TContentsForm): TvtPanel;
     {* ���������� ����� ������� .TContentsForm.BackgroundPanel }
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
  end;//TkwContentsFormBackgroundPanel

// start class TkwContentsFormBackgroundPanel

function TkwContentsFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aContentsForm: TContentsForm): TvtPanel;
 {-}
begin
 Result := aContentsForm.BackgroundPanel;
end;//TkwContentsFormBackgroundPanel.BackgroundPanel

procedure TkwContentsFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aContentsForm : TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aContentsForm)));
end;//TkwContentsFormBackgroundPanel.DoDoIt

class function TkwContentsFormBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TContentsForm.BackgroundPanel';
end;//TkwContentsFormBackgroundPanel.GetWordNameForRegister

procedure TkwContentsFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwContentsFormBackgroundPanel.SetValuePrim

function TkwContentsFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwContentsFormBackgroundPanel.GetResultTypeInfo

function TkwContentsFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwContentsFormBackgroundPanel.GetAllParamsCount

function TkwContentsFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormBackgroundPanel.ParamsTypes

type
  TkwContentsFormLstBookmarks = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TContentsForm.lstBookmarks
[panel]������� lstBookmarks ����� TContentsForm[panel]
*��� ����������:* TvtLister
*������:*
[code]
OBJECT VAR l_TvtLister
 aContentsForm .TContentsForm.lstBookmarks >>> l_TvtLister
[code]  }
  private
  // private methods
   function LstBookmarks(const aCtx: TtfwContext;
     aContentsForm: TContentsForm): TvtLister;
     {* ���������� ����� ������� .TContentsForm.lstBookmarks }
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
  end;//TkwContentsFormLstBookmarks

// start class TkwContentsFormLstBookmarks

function TkwContentsFormLstBookmarks.LstBookmarks(const aCtx: TtfwContext;
  aContentsForm: TContentsForm): TvtLister;
 {-}
begin
 Result := aContentsForm.lstBookmarks;
end;//TkwContentsFormLstBookmarks.LstBookmarks

procedure TkwContentsFormLstBookmarks.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aContentsForm : TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LstBookmarks(aCtx, l_aContentsForm)));
end;//TkwContentsFormLstBookmarks.DoDoIt

class function TkwContentsFormLstBookmarks.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TContentsForm.lstBookmarks';
end;//TkwContentsFormLstBookmarks.GetWordNameForRegister

procedure TkwContentsFormLstBookmarks.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� lstBookmarks', aCtx);
end;//TkwContentsFormLstBookmarks.SetValuePrim

function TkwContentsFormLstBookmarks.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLister);
end;//TkwContentsFormLstBookmarks.GetResultTypeInfo

function TkwContentsFormLstBookmarks.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwContentsFormLstBookmarks.GetAllParamsCount

function TkwContentsFormLstBookmarks.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormLstBookmarks.ParamsTypes

type
  TkwContentsFormLstComments = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TContentsForm.lstComments
[panel]������� lstComments ����� TContentsForm[panel]
*��� ����������:* TvtLister
*������:*
[code]
OBJECT VAR l_TvtLister
 aContentsForm .TContentsForm.lstComments >>> l_TvtLister
[code]  }
  private
  // private methods
   function LstComments(const aCtx: TtfwContext;
     aContentsForm: TContentsForm): TvtLister;
     {* ���������� ����� ������� .TContentsForm.lstComments }
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
  end;//TkwContentsFormLstComments

// start class TkwContentsFormLstComments

function TkwContentsFormLstComments.LstComments(const aCtx: TtfwContext;
  aContentsForm: TContentsForm): TvtLister;
 {-}
begin
 Result := aContentsForm.lstComments;
end;//TkwContentsFormLstComments.LstComments

procedure TkwContentsFormLstComments.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aContentsForm : TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LstComments(aCtx, l_aContentsForm)));
end;//TkwContentsFormLstComments.DoDoIt

class function TkwContentsFormLstComments.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TContentsForm.lstComments';
end;//TkwContentsFormLstComments.GetWordNameForRegister

procedure TkwContentsFormLstComments.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� lstComments', aCtx);
end;//TkwContentsFormLstComments.SetValuePrim

function TkwContentsFormLstComments.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLister);
end;//TkwContentsFormLstComments.GetResultTypeInfo

function TkwContentsFormLstComments.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwContentsFormLstComments.GetAllParamsCount

function TkwContentsFormLstComments.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormLstComments.ParamsTypes

type
  TkwContentsFormLstExternalObjects = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TContentsForm.lstExternalObjects
[panel]������� lstExternalObjects ����� TContentsForm[panel]
*��� ����������:* TvtLister
*������:*
[code]
OBJECT VAR l_TvtLister
 aContentsForm .TContentsForm.lstExternalObjects >>> l_TvtLister
[code]  }
  private
  // private methods
   function LstExternalObjects(const aCtx: TtfwContext;
     aContentsForm: TContentsForm): TvtLister;
     {* ���������� ����� ������� .TContentsForm.lstExternalObjects }
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
  end;//TkwContentsFormLstExternalObjects

// start class TkwContentsFormLstExternalObjects

function TkwContentsFormLstExternalObjects.LstExternalObjects(const aCtx: TtfwContext;
  aContentsForm: TContentsForm): TvtLister;
 {-}
begin
 Result := aContentsForm.lstExternalObjects;
end;//TkwContentsFormLstExternalObjects.LstExternalObjects

procedure TkwContentsFormLstExternalObjects.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aContentsForm : TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LstExternalObjects(aCtx, l_aContentsForm)));
end;//TkwContentsFormLstExternalObjects.DoDoIt

class function TkwContentsFormLstExternalObjects.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TContentsForm.lstExternalObjects';
end;//TkwContentsFormLstExternalObjects.GetWordNameForRegister

procedure TkwContentsFormLstExternalObjects.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� lstExternalObjects', aCtx);
end;//TkwContentsFormLstExternalObjects.SetValuePrim

function TkwContentsFormLstExternalObjects.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLister);
end;//TkwContentsFormLstExternalObjects.GetResultTypeInfo

function TkwContentsFormLstExternalObjects.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwContentsFormLstExternalObjects.GetAllParamsCount

function TkwContentsFormLstExternalObjects.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormLstExternalObjects.ParamsTypes

type
  TkwContentsFormContentsTree = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TContentsForm.ContentsTree
[panel]������� ContentsTree ����� TContentsForm[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aContentsForm .TContentsForm.ContentsTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function ContentsTree(const aCtx: TtfwContext;
     aContentsForm: TContentsForm): TnscTreeViewWithAdapterDragDrop;
     {* ���������� ����� ������� .TContentsForm.ContentsTree }
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
  end;//TkwContentsFormContentsTree

// start class TkwContentsFormContentsTree

function TkwContentsFormContentsTree.ContentsTree(const aCtx: TtfwContext;
  aContentsForm: TContentsForm): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aContentsForm.ContentsTree;
end;//TkwContentsFormContentsTree.ContentsTree

procedure TkwContentsFormContentsTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aContentsForm : TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ContentsTree(aCtx, l_aContentsForm)));
end;//TkwContentsFormContentsTree.DoDoIt

class function TkwContentsFormContentsTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TContentsForm.ContentsTree';
end;//TkwContentsFormContentsTree.GetWordNameForRegister

procedure TkwContentsFormContentsTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ContentsTree', aCtx);
end;//TkwContentsFormContentsTree.SetValuePrim

function TkwContentsFormContentsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwContentsFormContentsTree.GetResultTypeInfo

function TkwContentsFormContentsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwContentsFormContentsTree.GetAllParamsCount

function TkwContentsFormContentsTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormContentsTree.ParamsTypes

type
  TkwContentsFormContextFilter = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TContentsForm.ContextFilter
[panel]������� ContextFilter ����� TContentsForm[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aContentsForm .TContentsForm.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function ContextFilter(const aCtx: TtfwContext;
     aContentsForm: TContentsForm): TnscContextFilter;
     {* ���������� ����� ������� .TContentsForm.ContextFilter }
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
  end;//TkwContentsFormContextFilter

// start class TkwContentsFormContextFilter

function TkwContentsFormContextFilter.ContextFilter(const aCtx: TtfwContext;
  aContentsForm: TContentsForm): TnscContextFilter;
 {-}
begin
 Result := aContentsForm.ContextFilter;
end;//TkwContentsFormContextFilter.ContextFilter

procedure TkwContentsFormContextFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aContentsForm : TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ContextFilter(aCtx, l_aContentsForm)));
end;//TkwContentsFormContextFilter.DoDoIt

class function TkwContentsFormContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TContentsForm.ContextFilter';
end;//TkwContentsFormContextFilter.GetWordNameForRegister

procedure TkwContentsFormContextFilter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwContentsFormContextFilter.SetValuePrim

function TkwContentsFormContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwContentsFormContextFilter.GetResultTypeInfo

function TkwContentsFormContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwContentsFormContextFilter.GetAllParamsCount

function TkwContentsFormContextFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormContextFilter.ParamsTypes

type
  TkwContentsFormTasks = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TContentsForm.Tasks
[panel]������� Tasks ����� TContentsForm[panel]
*��� ����������:* TnscTasksPanelView
*������:*
[code]
OBJECT VAR l_TnscTasksPanelView
 aContentsForm .TContentsForm.Tasks >>> l_TnscTasksPanelView
[code]  }
  private
  // private methods
   function Tasks(const aCtx: TtfwContext;
     aContentsForm: TContentsForm): TnscTasksPanelView;
     {* ���������� ����� ������� .TContentsForm.Tasks }
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
  end;//TkwContentsFormTasks

// start class TkwContentsFormTasks

function TkwContentsFormTasks.Tasks(const aCtx: TtfwContext;
  aContentsForm: TContentsForm): TnscTasksPanelView;
 {-}
begin
 Result := aContentsForm.Tasks;
end;//TkwContentsFormTasks.Tasks

procedure TkwContentsFormTasks.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aContentsForm : TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Tasks(aCtx, l_aContentsForm)));
end;//TkwContentsFormTasks.DoDoIt

class function TkwContentsFormTasks.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TContentsForm.Tasks';
end;//TkwContentsFormTasks.GetWordNameForRegister

procedure TkwContentsFormTasks.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Tasks', aCtx);
end;//TkwContentsFormTasks.SetValuePrim

function TkwContentsFormTasks.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTasksPanelView);
end;//TkwContentsFormTasks.GetResultTypeInfo

function TkwContentsFormTasks.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwContentsFormTasks.GetAllParamsCount

function TkwContentsFormTasks.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormTasks.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_Contents
 Tkw_Form_Contents.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_BackgroundPanel
 Tkw_Contents_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_BackgroundPanel_Push
 Tkw_Contents_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_lstBookmarks
 Tkw_Contents_Control_lstBookmarks.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_lstBookmarks_Push
 Tkw_Contents_Control_lstBookmarks_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_lstComments
 Tkw_Contents_Control_lstComments.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_lstComments_Push
 Tkw_Contents_Control_lstComments_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_lstExternalObjects
 Tkw_Contents_Control_lstExternalObjects.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_lstExternalObjects_Push
 Tkw_Contents_Control_lstExternalObjects_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_ContentsTree
 Tkw_Contents_Control_ContentsTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_ContentsTree_Push
 Tkw_Contents_Control_ContentsTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_ContextFilter
 Tkw_Contents_Control_ContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_ContextFilter_Push
 Tkw_Contents_Control_ContextFilter_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_Tasks
 Tkw_Contents_Control_Tasks.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Contents_Control_Tasks_Push
 Tkw_Contents_Control_Tasks_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ContentsForm_BackgroundPanel
 TkwContentsFormBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ContentsForm_lstBookmarks
 TkwContentsFormLstBookmarks.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ContentsForm_lstComments
 TkwContentsFormLstComments.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ContentsForm_lstExternalObjects
 TkwContentsFormLstExternalObjects.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ContentsForm_ContentsTree
 TkwContentsFormContentsTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ContentsForm_ContextFilter
 TkwContentsFormContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ContentsForm_Tasks
 TkwContentsFormTasks.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� Contents
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContentsForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtLister
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLister));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscContextFilter
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscTasksPanelView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTasksPanelView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.