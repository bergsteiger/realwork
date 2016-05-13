unit ContentsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Contents }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\ContentsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ContentsKeywordsPack" MUID: (39D904AB57B9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
 , vtLister
 , nscTreeViewWithAdapterDragDrop
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTasksPanelView
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Contents_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_Contents = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Contents
----
*������ �������������*:
[code]
'aControl' �����::Contents TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Contents

 Tkw_Contents_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_BackgroundPanel

 Tkw_Contents_Control_BackgroundPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_BackgroundPanel_Push

 Tkw_Contents_Control_lstBookmarks = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lstBookmarks
----
*������ �������������*:
[code]
�������::lstBookmarks TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_lstBookmarks

 Tkw_Contents_Control_lstBookmarks_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� lstBookmarks
----
*������ �������������*:
[code]
�������::lstBookmarks:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_lstBookmarks_Push

 Tkw_Contents_Control_lstComments = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lstComments
----
*������ �������������*:
[code]
�������::lstComments TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_lstComments

 Tkw_Contents_Control_lstComments_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� lstComments
----
*������ �������������*:
[code]
�������::lstComments:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_lstComments_Push

 Tkw_Contents_Control_lstExternalObjects = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lstExternalObjects
----
*������ �������������*:
[code]
�������::lstExternalObjects TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_lstExternalObjects

 Tkw_Contents_Control_lstExternalObjects_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� lstExternalObjects
----
*������ �������������*:
[code]
�������::lstExternalObjects:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_lstExternalObjects_Push

 Tkw_Contents_Control_ContentsTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContentsTree
----
*������ �������������*:
[code]
�������::ContentsTree TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_ContentsTree

 Tkw_Contents_Control_ContentsTree_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� ContentsTree
----
*������ �������������*:
[code]
�������::ContentsTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_ContentsTree_Push

 Tkw_Contents_Control_ContextFilter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_ContextFilter

 Tkw_Contents_Control_ContextFilter_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_ContextFilter_Push

 Tkw_Contents_Control_Tasks = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Tasks
----
*������ �������������*:
[code]
�������::Tasks TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_Tasks

 Tkw_Contents_Control_Tasks_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� Tasks
----
*������ �������������*:
[code]
�������::Tasks:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_Tasks_Push

 TkwContentsFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtPanel;
    {* ���������� ����� ������� .TContentsForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContentsFormBackgroundPanel

 TkwContentsFormLstBookmarks = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.lstBookmarks }
  private
   function lstBookmarks(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtLister;
    {* ���������� ����� ������� .TContentsForm.lstBookmarks }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContentsFormLstBookmarks

 TkwContentsFormLstComments = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.lstComments }
  private
   function lstComments(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtLister;
    {* ���������� ����� ������� .TContentsForm.lstComments }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContentsFormLstComments

 TkwContentsFormLstExternalObjects = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.lstExternalObjects }
  private
   function lstExternalObjects(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtLister;
    {* ���������� ����� ������� .TContentsForm.lstExternalObjects }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContentsFormLstExternalObjects

 TkwContentsFormContentsTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.ContentsTree }
  private
   function ContentsTree(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TContentsForm.ContentsTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContentsFormContentsTree

 TkwContentsFormContextFilter = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TnscContextFilter;
    {* ���������� ����� ������� .TContentsForm.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContentsFormContextFilter

 TkwContentsFormTasks = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.Tasks }
  private
   function Tasks(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TnscTasksPanelView;
    {* ���������� ����� ������� .TContentsForm.Tasks }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContentsFormTasks

function Tkw_Form_Contents.GetString: AnsiString;
begin
 Result := 'ContentsForm';
end;//Tkw_Form_Contents.GetString

class function Tkw_Form_Contents.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Contents';
end;//Tkw_Form_Contents.GetWordNameForRegister

function Tkw_Contents_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_Contents_Control_BackgroundPanel.GetString

class procedure Tkw_Contents_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Contents_Control_BackgroundPanel.RegisterInEngine

class function Tkw_Contents_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_Contents_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_Contents_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_Contents_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Contents_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_Contents_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_Contents_Control_lstBookmarks.GetString: AnsiString;
begin
 Result := 'lstBookmarks';
end;//Tkw_Contents_Control_lstBookmarks.GetString

class procedure Tkw_Contents_Control_lstBookmarks.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLister);
end;//Tkw_Contents_Control_lstBookmarks.RegisterInEngine

class function Tkw_Contents_Control_lstBookmarks.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstBookmarks';
end;//Tkw_Contents_Control_lstBookmarks.GetWordNameForRegister

procedure Tkw_Contents_Control_lstBookmarks_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lstBookmarks');
 inherited;
end;//Tkw_Contents_Control_lstBookmarks_Push.DoDoIt

class function Tkw_Contents_Control_lstBookmarks_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstBookmarks:push';
end;//Tkw_Contents_Control_lstBookmarks_Push.GetWordNameForRegister

function Tkw_Contents_Control_lstComments.GetString: AnsiString;
begin
 Result := 'lstComments';
end;//Tkw_Contents_Control_lstComments.GetString

class procedure Tkw_Contents_Control_lstComments.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLister);
end;//Tkw_Contents_Control_lstComments.RegisterInEngine

class function Tkw_Contents_Control_lstComments.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstComments';
end;//Tkw_Contents_Control_lstComments.GetWordNameForRegister

procedure Tkw_Contents_Control_lstComments_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lstComments');
 inherited;
end;//Tkw_Contents_Control_lstComments_Push.DoDoIt

class function Tkw_Contents_Control_lstComments_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstComments:push';
end;//Tkw_Contents_Control_lstComments_Push.GetWordNameForRegister

function Tkw_Contents_Control_lstExternalObjects.GetString: AnsiString;
begin
 Result := 'lstExternalObjects';
end;//Tkw_Contents_Control_lstExternalObjects.GetString

class procedure Tkw_Contents_Control_lstExternalObjects.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLister);
end;//Tkw_Contents_Control_lstExternalObjects.RegisterInEngine

class function Tkw_Contents_Control_lstExternalObjects.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstExternalObjects';
end;//Tkw_Contents_Control_lstExternalObjects.GetWordNameForRegister

procedure Tkw_Contents_Control_lstExternalObjects_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lstExternalObjects');
 inherited;
end;//Tkw_Contents_Control_lstExternalObjects_Push.DoDoIt

class function Tkw_Contents_Control_lstExternalObjects_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstExternalObjects:push';
end;//Tkw_Contents_Control_lstExternalObjects_Push.GetWordNameForRegister

function Tkw_Contents_Control_ContentsTree.GetString: AnsiString;
begin
 Result := 'ContentsTree';
end;//Tkw_Contents_Control_ContentsTree.GetString

class procedure Tkw_Contents_Control_ContentsTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Contents_Control_ContentsTree.RegisterInEngine

class function Tkw_Contents_Control_ContentsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContentsTree';
end;//Tkw_Contents_Control_ContentsTree.GetWordNameForRegister

procedure Tkw_Contents_Control_ContentsTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContentsTree');
 inherited;
end;//Tkw_Contents_Control_ContentsTree_Push.DoDoIt

class function Tkw_Contents_Control_ContentsTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContentsTree:push';
end;//Tkw_Contents_Control_ContentsTree_Push.GetWordNameForRegister

function Tkw_Contents_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_Contents_Control_ContextFilter.GetString

class procedure Tkw_Contents_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_Contents_Control_ContextFilter.RegisterInEngine

class function Tkw_Contents_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter';
end;//Tkw_Contents_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_Contents_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_Contents_Control_ContextFilter_Push.DoDoIt

class function Tkw_Contents_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_Contents_Control_ContextFilter_Push.GetWordNameForRegister

function Tkw_Contents_Control_Tasks.GetString: AnsiString;
begin
 Result := 'Tasks';
end;//Tkw_Contents_Control_Tasks.GetString

class procedure Tkw_Contents_Control_Tasks.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTasksPanelView);
end;//Tkw_Contents_Control_Tasks.RegisterInEngine

class function Tkw_Contents_Control_Tasks.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Tasks';
end;//Tkw_Contents_Control_Tasks.GetWordNameForRegister

procedure Tkw_Contents_Control_Tasks_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Tasks');
 inherited;
end;//Tkw_Contents_Control_Tasks_Push.DoDoIt

class function Tkw_Contents_Control_Tasks_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Tasks:push';
end;//Tkw_Contents_Control_Tasks_Push.GetWordNameForRegister

function TkwContentsFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtPanel;
 {* ���������� ����� ������� .TContentsForm.BackgroundPanel }
begin
 Result := aContentsForm.BackgroundPanel;
end;//TkwContentsFormBackgroundPanel.BackgroundPanel

procedure TkwContentsFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
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
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aContentsForm));
end;//TkwContentsFormBackgroundPanel.DoDoIt

class function TkwContentsFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.BackgroundPanel';
end;//TkwContentsFormBackgroundPanel.GetWordNameForRegister

function TkwContentsFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwContentsFormBackgroundPanel.GetResultTypeInfo

function TkwContentsFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormBackgroundPanel.GetAllParamsCount

function TkwContentsFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormBackgroundPanel.ParamsTypes

procedure TkwContentsFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwContentsFormBackgroundPanel.SetValuePrim

function TkwContentsFormLstBookmarks.lstBookmarks(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtLister;
 {* ���������� ����� ������� .TContentsForm.lstBookmarks }
begin
 Result := aContentsForm.lstBookmarks;
end;//TkwContentsFormLstBookmarks.lstBookmarks

procedure TkwContentsFormLstBookmarks.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
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
 aCtx.rEngine.PushObj(lstBookmarks(aCtx, l_aContentsForm));
end;//TkwContentsFormLstBookmarks.DoDoIt

class function TkwContentsFormLstBookmarks.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.lstBookmarks';
end;//TkwContentsFormLstBookmarks.GetWordNameForRegister

function TkwContentsFormLstBookmarks.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLister);
end;//TkwContentsFormLstBookmarks.GetResultTypeInfo

function TkwContentsFormLstBookmarks.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormLstBookmarks.GetAllParamsCount

function TkwContentsFormLstBookmarks.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormLstBookmarks.ParamsTypes

procedure TkwContentsFormLstBookmarks.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lstBookmarks', aCtx);
end;//TkwContentsFormLstBookmarks.SetValuePrim

function TkwContentsFormLstComments.lstComments(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtLister;
 {* ���������� ����� ������� .TContentsForm.lstComments }
begin
 Result := aContentsForm.lstComments;
end;//TkwContentsFormLstComments.lstComments

procedure TkwContentsFormLstComments.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
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
 aCtx.rEngine.PushObj(lstComments(aCtx, l_aContentsForm));
end;//TkwContentsFormLstComments.DoDoIt

class function TkwContentsFormLstComments.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.lstComments';
end;//TkwContentsFormLstComments.GetWordNameForRegister

function TkwContentsFormLstComments.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLister);
end;//TkwContentsFormLstComments.GetResultTypeInfo

function TkwContentsFormLstComments.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormLstComments.GetAllParamsCount

function TkwContentsFormLstComments.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormLstComments.ParamsTypes

procedure TkwContentsFormLstComments.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lstComments', aCtx);
end;//TkwContentsFormLstComments.SetValuePrim

function TkwContentsFormLstExternalObjects.lstExternalObjects(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtLister;
 {* ���������� ����� ������� .TContentsForm.lstExternalObjects }
begin
 Result := aContentsForm.lstExternalObjects;
end;//TkwContentsFormLstExternalObjects.lstExternalObjects

procedure TkwContentsFormLstExternalObjects.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
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
 aCtx.rEngine.PushObj(lstExternalObjects(aCtx, l_aContentsForm));
end;//TkwContentsFormLstExternalObjects.DoDoIt

class function TkwContentsFormLstExternalObjects.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.lstExternalObjects';
end;//TkwContentsFormLstExternalObjects.GetWordNameForRegister

function TkwContentsFormLstExternalObjects.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLister);
end;//TkwContentsFormLstExternalObjects.GetResultTypeInfo

function TkwContentsFormLstExternalObjects.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormLstExternalObjects.GetAllParamsCount

function TkwContentsFormLstExternalObjects.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormLstExternalObjects.ParamsTypes

procedure TkwContentsFormLstExternalObjects.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lstExternalObjects', aCtx);
end;//TkwContentsFormLstExternalObjects.SetValuePrim

function TkwContentsFormContentsTree.ContentsTree(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TContentsForm.ContentsTree }
begin
 Result := aContentsForm.ContentsTree;
end;//TkwContentsFormContentsTree.ContentsTree

procedure TkwContentsFormContentsTree.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
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
 aCtx.rEngine.PushObj(ContentsTree(aCtx, l_aContentsForm));
end;//TkwContentsFormContentsTree.DoDoIt

class function TkwContentsFormContentsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.ContentsTree';
end;//TkwContentsFormContentsTree.GetWordNameForRegister

function TkwContentsFormContentsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwContentsFormContentsTree.GetResultTypeInfo

function TkwContentsFormContentsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormContentsTree.GetAllParamsCount

function TkwContentsFormContentsTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormContentsTree.ParamsTypes

procedure TkwContentsFormContentsTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ContentsTree', aCtx);
end;//TkwContentsFormContentsTree.SetValuePrim

function TkwContentsFormContextFilter.ContextFilter(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TnscContextFilter;
 {* ���������� ����� ������� .TContentsForm.ContextFilter }
begin
 Result := aContentsForm.ContextFilter;
end;//TkwContentsFormContextFilter.ContextFilter

procedure TkwContentsFormContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
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
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aContentsForm));
end;//TkwContentsFormContextFilter.DoDoIt

class function TkwContentsFormContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.ContextFilter';
end;//TkwContentsFormContextFilter.GetWordNameForRegister

function TkwContentsFormContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwContentsFormContextFilter.GetResultTypeInfo

function TkwContentsFormContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormContextFilter.GetAllParamsCount

function TkwContentsFormContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormContextFilter.ParamsTypes

procedure TkwContentsFormContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwContentsFormContextFilter.SetValuePrim

function TkwContentsFormTasks.Tasks(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TnscTasksPanelView;
 {* ���������� ����� ������� .TContentsForm.Tasks }
begin
 Result := aContentsForm.Tasks;
end;//TkwContentsFormTasks.Tasks

procedure TkwContentsFormTasks.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
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
 aCtx.rEngine.PushObj(Tasks(aCtx, l_aContentsForm));
end;//TkwContentsFormTasks.DoDoIt

class function TkwContentsFormTasks.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.Tasks';
end;//TkwContentsFormTasks.GetWordNameForRegister

function TkwContentsFormTasks.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTasksPanelView);
end;//TkwContentsFormTasks.GetResultTypeInfo

function TkwContentsFormTasks.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormTasks.GetAllParamsCount

function TkwContentsFormTasks.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormTasks.ParamsTypes

procedure TkwContentsFormTasks.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Tasks', aCtx);
end;//TkwContentsFormTasks.SetValuePrim

initialization
 Tkw_Form_Contents.RegisterInEngine;
 {* ����������� Tkw_Form_Contents }
 Tkw_Contents_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_BackgroundPanel }
 Tkw_Contents_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_BackgroundPanel_Push }
 Tkw_Contents_Control_lstBookmarks.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_lstBookmarks }
 Tkw_Contents_Control_lstBookmarks_Push.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_lstBookmarks_Push }
 Tkw_Contents_Control_lstComments.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_lstComments }
 Tkw_Contents_Control_lstComments_Push.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_lstComments_Push }
 Tkw_Contents_Control_lstExternalObjects.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_lstExternalObjects }
 Tkw_Contents_Control_lstExternalObjects_Push.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_lstExternalObjects_Push }
 Tkw_Contents_Control_ContentsTree.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_ContentsTree }
 Tkw_Contents_Control_ContentsTree_Push.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_ContentsTree_Push }
 Tkw_Contents_Control_ContextFilter.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_ContextFilter }
 Tkw_Contents_Control_ContextFilter_Push.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_ContextFilter_Push }
 Tkw_Contents_Control_Tasks.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_Tasks }
 Tkw_Contents_Control_Tasks_Push.RegisterInEngine;
 {* ����������� Tkw_Contents_Control_Tasks_Push }
 TkwContentsFormBackgroundPanel.RegisterInEngine;
 {* ����������� ContentsForm_BackgroundPanel }
 TkwContentsFormLstBookmarks.RegisterInEngine;
 {* ����������� ContentsForm_lstBookmarks }
 TkwContentsFormLstComments.RegisterInEngine;
 {* ����������� ContentsForm_lstComments }
 TkwContentsFormLstExternalObjects.RegisterInEngine;
 {* ����������� ContentsForm_lstExternalObjects }
 TkwContentsFormContentsTree.RegisterInEngine;
 {* ����������� ContentsForm_ContentsTree }
 TkwContentsFormContextFilter.RegisterInEngine;
 {* ����������� ContentsForm_ContextFilter }
 TkwContentsFormTasks.RegisterInEngine;
 {* ����������� ContentsForm_Tasks }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContentsForm));
 {* ����������� ���� TContentsForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLister));
 {* ����������� ���� TvtLister }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* ����������� ���� TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTasksPanelView));
 {* ����������� ���� TnscTasksPanelView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
