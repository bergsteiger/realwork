unit ContentsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Contents }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\ContentsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 , vtPanel
 , vtLister
 , nscTreeViewWithAdapterDragDrop
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTasksPanelView
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
 Tkw_Form_Contents = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Contents
----
*������ �������������*:
[code]
'aControl' �����::Contents TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Contents

 Tkw_Contents_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_BackgroundPanel

 Tkw_Contents_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_lstBookmarks

 Tkw_Contents_Control_lstBookmarks_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_lstComments

 Tkw_Contents_Control_lstComments_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_lstExternalObjects

 Tkw_Contents_Control_lstExternalObjects_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_ContentsTree

 Tkw_Contents_Control_ContentsTree_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_ContextFilter

 Tkw_Contents_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_Tasks

 Tkw_Contents_Control_Tasks_Push = {final} class(TkwBynameControlPush)
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
  {* ����� ������� .TContentsForm.BackgroundPanel
[panel]������� BackgroundPanel ����� TContentsForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aContentsForm .TContentsForm.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtPanel;
    {* ���������� ����� ������� .TContentsForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormBackgroundPanel

 TkwContentsFormLstBookmarks = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.lstBookmarks
[panel]������� lstBookmarks ����� TContentsForm[panel]
*��� ����������:* TvtLister
*������:*
[code]
OBJECT VAR l_TvtLister
 aContentsForm .TContentsForm.lstBookmarks >>> l_TvtLister
[code]  }
  private
   function lstBookmarks(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtLister;
    {* ���������� ����� ������� .TContentsForm.lstBookmarks }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormLstBookmarks

 TkwContentsFormLstComments = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.lstComments
[panel]������� lstComments ����� TContentsForm[panel]
*��� ����������:* TvtLister
*������:*
[code]
OBJECT VAR l_TvtLister
 aContentsForm .TContentsForm.lstComments >>> l_TvtLister
[code]  }
  private
   function lstComments(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtLister;
    {* ���������� ����� ������� .TContentsForm.lstComments }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormLstComments

 TkwContentsFormLstExternalObjects = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.lstExternalObjects
[panel]������� lstExternalObjects ����� TContentsForm[panel]
*��� ����������:* TvtLister
*������:*
[code]
OBJECT VAR l_TvtLister
 aContentsForm .TContentsForm.lstExternalObjects >>> l_TvtLister
[code]  }
  private
   function lstExternalObjects(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtLister;
    {* ���������� ����� ������� .TContentsForm.lstExternalObjects }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormLstExternalObjects

 TkwContentsFormContentsTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.ContentsTree
[panel]������� ContentsTree ����� TContentsForm[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aContentsForm .TContentsForm.ContentsTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function ContentsTree(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TContentsForm.ContentsTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormContentsTree

 TkwContentsFormContextFilter = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.ContextFilter
[panel]������� ContextFilter ����� TContentsForm[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aContentsForm .TContentsForm.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TnscContextFilter;
    {* ���������� ����� ������� .TContentsForm.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormContextFilter

 TkwContentsFormTasks = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContentsForm.Tasks
[panel]������� Tasks ����� TContentsForm[panel]
*��� ����������:* TnscTasksPanelView
*������:*
[code]
OBJECT VAR l_TnscTasksPanelView
 aContentsForm .TContentsForm.Tasks >>> l_TnscTasksPanelView
[code]  }
  private
   function Tasks(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TnscTasksPanelView;
    {* ���������� ����� ������� .TContentsForm.Tasks }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormTasks

class function Tkw_Form_Contents.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Contents';
end;//Tkw_Form_Contents.GetWordNameForRegister

function Tkw_Form_Contents.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7B6EE98B5EAB_var*
//#UC END# *4DDFD2EA0116_7B6EE98B5EAB_var*
begin
//#UC START# *4DDFD2EA0116_7B6EE98B5EAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7B6EE98B5EAB_impl*
end;//Tkw_Form_Contents.GetString

class function Tkw_Contents_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_Contents_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Contents_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_94B6B22BBEAB_var*
//#UC END# *4DDFD2EA0116_94B6B22BBEAB_var*
begin
//#UC START# *4DDFD2EA0116_94B6B22BBEAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_94B6B22BBEAB_impl*
end;//Tkw_Contents_Control_BackgroundPanel.GetString

class procedure Tkw_Contents_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_94B6B22BBEAB_var*
//#UC END# *52A086150180_94B6B22BBEAB_var*
begin
//#UC START# *52A086150180_94B6B22BBEAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_94B6B22BBEAB_impl*
end;//Tkw_Contents_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_Contents_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A6DCC692D7A7_var*
//#UC END# *4DAEEDE10285_A6DCC692D7A7_var*
begin
//#UC START# *4DAEEDE10285_A6DCC692D7A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A6DCC692D7A7_impl*
end;//Tkw_Contents_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Contents_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_Contents_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_Contents_Control_lstBookmarks.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstBookmarks';
end;//Tkw_Contents_Control_lstBookmarks.GetWordNameForRegister

function Tkw_Contents_Control_lstBookmarks.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_FDC19690CA0B_var*
//#UC END# *4DDFD2EA0116_FDC19690CA0B_var*
begin
//#UC START# *4DDFD2EA0116_FDC19690CA0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_FDC19690CA0B_impl*
end;//Tkw_Contents_Control_lstBookmarks.GetString

class procedure Tkw_Contents_Control_lstBookmarks.RegisterInEngine;
//#UC START# *52A086150180_FDC19690CA0B_var*
//#UC END# *52A086150180_FDC19690CA0B_var*
begin
//#UC START# *52A086150180_FDC19690CA0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_FDC19690CA0B_impl*
end;//Tkw_Contents_Control_lstBookmarks.RegisterInEngine

procedure Tkw_Contents_Control_lstBookmarks_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DC2C371B5EC2_var*
//#UC END# *4DAEEDE10285_DC2C371B5EC2_var*
begin
//#UC START# *4DAEEDE10285_DC2C371B5EC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DC2C371B5EC2_impl*
end;//Tkw_Contents_Control_lstBookmarks_Push.DoDoIt

class function Tkw_Contents_Control_lstBookmarks_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstBookmarks:push';
end;//Tkw_Contents_Control_lstBookmarks_Push.GetWordNameForRegister

class function Tkw_Contents_Control_lstComments.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstComments';
end;//Tkw_Contents_Control_lstComments.GetWordNameForRegister

function Tkw_Contents_Control_lstComments.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B125D6142B36_var*
//#UC END# *4DDFD2EA0116_B125D6142B36_var*
begin
//#UC START# *4DDFD2EA0116_B125D6142B36_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B125D6142B36_impl*
end;//Tkw_Contents_Control_lstComments.GetString

class procedure Tkw_Contents_Control_lstComments.RegisterInEngine;
//#UC START# *52A086150180_B125D6142B36_var*
//#UC END# *52A086150180_B125D6142B36_var*
begin
//#UC START# *52A086150180_B125D6142B36_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B125D6142B36_impl*
end;//Tkw_Contents_Control_lstComments.RegisterInEngine

procedure Tkw_Contents_Control_lstComments_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4B60A82AAB7C_var*
//#UC END# *4DAEEDE10285_4B60A82AAB7C_var*
begin
//#UC START# *4DAEEDE10285_4B60A82AAB7C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4B60A82AAB7C_impl*
end;//Tkw_Contents_Control_lstComments_Push.DoDoIt

class function Tkw_Contents_Control_lstComments_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstComments:push';
end;//Tkw_Contents_Control_lstComments_Push.GetWordNameForRegister

class function Tkw_Contents_Control_lstExternalObjects.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstExternalObjects';
end;//Tkw_Contents_Control_lstExternalObjects.GetWordNameForRegister

function Tkw_Contents_Control_lstExternalObjects.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_473A1360A833_var*
//#UC END# *4DDFD2EA0116_473A1360A833_var*
begin
//#UC START# *4DDFD2EA0116_473A1360A833_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_473A1360A833_impl*
end;//Tkw_Contents_Control_lstExternalObjects.GetString

class procedure Tkw_Contents_Control_lstExternalObjects.RegisterInEngine;
//#UC START# *52A086150180_473A1360A833_var*
//#UC END# *52A086150180_473A1360A833_var*
begin
//#UC START# *52A086150180_473A1360A833_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_473A1360A833_impl*
end;//Tkw_Contents_Control_lstExternalObjects.RegisterInEngine

procedure Tkw_Contents_Control_lstExternalObjects_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BCDC18D563E6_var*
//#UC END# *4DAEEDE10285_BCDC18D563E6_var*
begin
//#UC START# *4DAEEDE10285_BCDC18D563E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BCDC18D563E6_impl*
end;//Tkw_Contents_Control_lstExternalObjects_Push.DoDoIt

class function Tkw_Contents_Control_lstExternalObjects_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lstExternalObjects:push';
end;//Tkw_Contents_Control_lstExternalObjects_Push.GetWordNameForRegister

class function Tkw_Contents_Control_ContentsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContentsTree';
end;//Tkw_Contents_Control_ContentsTree.GetWordNameForRegister

function Tkw_Contents_Control_ContentsTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_90DB87D5A17A_var*
//#UC END# *4DDFD2EA0116_90DB87D5A17A_var*
begin
//#UC START# *4DDFD2EA0116_90DB87D5A17A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_90DB87D5A17A_impl*
end;//Tkw_Contents_Control_ContentsTree.GetString

class procedure Tkw_Contents_Control_ContentsTree.RegisterInEngine;
//#UC START# *52A086150180_90DB87D5A17A_var*
//#UC END# *52A086150180_90DB87D5A17A_var*
begin
//#UC START# *52A086150180_90DB87D5A17A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_90DB87D5A17A_impl*
end;//Tkw_Contents_Control_ContentsTree.RegisterInEngine

procedure Tkw_Contents_Control_ContentsTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CEF92672CF37_var*
//#UC END# *4DAEEDE10285_CEF92672CF37_var*
begin
//#UC START# *4DAEEDE10285_CEF92672CF37_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CEF92672CF37_impl*
end;//Tkw_Contents_Control_ContentsTree_Push.DoDoIt

class function Tkw_Contents_Control_ContentsTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContentsTree:push';
end;//Tkw_Contents_Control_ContentsTree_Push.GetWordNameForRegister

class function Tkw_Contents_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter';
end;//Tkw_Contents_Control_ContextFilter.GetWordNameForRegister

function Tkw_Contents_Control_ContextFilter.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_98C51C23607E_var*
//#UC END# *4DDFD2EA0116_98C51C23607E_var*
begin
//#UC START# *4DDFD2EA0116_98C51C23607E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_98C51C23607E_impl*
end;//Tkw_Contents_Control_ContextFilter.GetString

class procedure Tkw_Contents_Control_ContextFilter.RegisterInEngine;
//#UC START# *52A086150180_98C51C23607E_var*
//#UC END# *52A086150180_98C51C23607E_var*
begin
//#UC START# *52A086150180_98C51C23607E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_98C51C23607E_impl*
end;//Tkw_Contents_Control_ContextFilter.RegisterInEngine

procedure Tkw_Contents_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9C078DD36879_var*
//#UC END# *4DAEEDE10285_9C078DD36879_var*
begin
//#UC START# *4DAEEDE10285_9C078DD36879_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9C078DD36879_impl*
end;//Tkw_Contents_Control_ContextFilter_Push.DoDoIt

class function Tkw_Contents_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_Contents_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_Contents_Control_Tasks.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Tasks';
end;//Tkw_Contents_Control_Tasks.GetWordNameForRegister

function Tkw_Contents_Control_Tasks.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5D1F447C6980_var*
//#UC END# *4DDFD2EA0116_5D1F447C6980_var*
begin
//#UC START# *4DDFD2EA0116_5D1F447C6980_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5D1F447C6980_impl*
end;//Tkw_Contents_Control_Tasks.GetString

class procedure Tkw_Contents_Control_Tasks.RegisterInEngine;
//#UC START# *52A086150180_5D1F447C6980_var*
//#UC END# *52A086150180_5D1F447C6980_var*
begin
//#UC START# *52A086150180_5D1F447C6980_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5D1F447C6980_impl*
end;//Tkw_Contents_Control_Tasks.RegisterInEngine

procedure Tkw_Contents_Control_Tasks_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B74BD809B3F5_var*
//#UC END# *4DAEEDE10285_B74BD809B3F5_var*
begin
//#UC START# *4DAEEDE10285_B74BD809B3F5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B74BD809B3F5_impl*
end;//Tkw_Contents_Control_Tasks_Push.DoDoIt

class function Tkw_Contents_Control_Tasks_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Tasks:push';
end;//Tkw_Contents_Control_Tasks_Push.GetWordNameForRegister

function TkwContentsFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtPanel;
 {* ���������� ����� ������� .TContentsForm.BackgroundPanel }
//#UC START# *DFF755D04550_4C8C363B5514_var*
//#UC END# *DFF755D04550_4C8C363B5514_var*
begin
//#UC START# *DFF755D04550_4C8C363B5514_impl*
 !!! Needs to be implemented !!!
//#UC END# *DFF755D04550_4C8C363B5514_impl*
end;//TkwContentsFormBackgroundPanel.BackgroundPanel

procedure TkwContentsFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4C8C363B5514_var*
//#UC END# *4DAEEDE10285_4C8C363B5514_var*
begin
//#UC START# *4DAEEDE10285_4C8C363B5514_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4C8C363B5514_impl*
end;//TkwContentsFormBackgroundPanel.DoDoIt

class function TkwContentsFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.BackgroundPanel';
end;//TkwContentsFormBackgroundPanel.GetWordNameForRegister

procedure TkwContentsFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4C8C363B5514_var*
//#UC END# *52D00B00031A_4C8C363B5514_var*
begin
//#UC START# *52D00B00031A_4C8C363B5514_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4C8C363B5514_impl*
end;//TkwContentsFormBackgroundPanel.SetValuePrim

function TkwContentsFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4C8C363B5514_var*
//#UC END# *551544E2001A_4C8C363B5514_var*
begin
//#UC START# *551544E2001A_4C8C363B5514_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4C8C363B5514_impl*
end;//TkwContentsFormBackgroundPanel.GetResultTypeInfo

function TkwContentsFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_4C8C363B5514_var*
//#UC END# *559687E6025A_4C8C363B5514_var*
begin
//#UC START# *559687E6025A_4C8C363B5514_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_4C8C363B5514_impl*
end;//TkwContentsFormBackgroundPanel.GetAllParamsCount

function TkwContentsFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4C8C363B5514_var*
//#UC END# *5617F4D00243_4C8C363B5514_var*
begin
//#UC START# *5617F4D00243_4C8C363B5514_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4C8C363B5514_impl*
end;//TkwContentsFormBackgroundPanel.ParamsTypes

function TkwContentsFormLstBookmarks.lstBookmarks(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtLister;
 {* ���������� ����� ������� .TContentsForm.lstBookmarks }
//#UC START# *F19C40784EE7_4490BAA2CF4F_var*
//#UC END# *F19C40784EE7_4490BAA2CF4F_var*
begin
//#UC START# *F19C40784EE7_4490BAA2CF4F_impl*
 !!! Needs to be implemented !!!
//#UC END# *F19C40784EE7_4490BAA2CF4F_impl*
end;//TkwContentsFormLstBookmarks.lstBookmarks

procedure TkwContentsFormLstBookmarks.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4490BAA2CF4F_var*
//#UC END# *4DAEEDE10285_4490BAA2CF4F_var*
begin
//#UC START# *4DAEEDE10285_4490BAA2CF4F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4490BAA2CF4F_impl*
end;//TkwContentsFormLstBookmarks.DoDoIt

class function TkwContentsFormLstBookmarks.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.lstBookmarks';
end;//TkwContentsFormLstBookmarks.GetWordNameForRegister

procedure TkwContentsFormLstBookmarks.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4490BAA2CF4F_var*
//#UC END# *52D00B00031A_4490BAA2CF4F_var*
begin
//#UC START# *52D00B00031A_4490BAA2CF4F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4490BAA2CF4F_impl*
end;//TkwContentsFormLstBookmarks.SetValuePrim

function TkwContentsFormLstBookmarks.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4490BAA2CF4F_var*
//#UC END# *551544E2001A_4490BAA2CF4F_var*
begin
//#UC START# *551544E2001A_4490BAA2CF4F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4490BAA2CF4F_impl*
end;//TkwContentsFormLstBookmarks.GetResultTypeInfo

function TkwContentsFormLstBookmarks.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_4490BAA2CF4F_var*
//#UC END# *559687E6025A_4490BAA2CF4F_var*
begin
//#UC START# *559687E6025A_4490BAA2CF4F_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_4490BAA2CF4F_impl*
end;//TkwContentsFormLstBookmarks.GetAllParamsCount

function TkwContentsFormLstBookmarks.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4490BAA2CF4F_var*
//#UC END# *5617F4D00243_4490BAA2CF4F_var*
begin
//#UC START# *5617F4D00243_4490BAA2CF4F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4490BAA2CF4F_impl*
end;//TkwContentsFormLstBookmarks.ParamsTypes

function TkwContentsFormLstComments.lstComments(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtLister;
 {* ���������� ����� ������� .TContentsForm.lstComments }
//#UC START# *5D2D9D6FB682_BB45F71CEF15_var*
//#UC END# *5D2D9D6FB682_BB45F71CEF15_var*
begin
//#UC START# *5D2D9D6FB682_BB45F71CEF15_impl*
 !!! Needs to be implemented !!!
//#UC END# *5D2D9D6FB682_BB45F71CEF15_impl*
end;//TkwContentsFormLstComments.lstComments

procedure TkwContentsFormLstComments.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BB45F71CEF15_var*
//#UC END# *4DAEEDE10285_BB45F71CEF15_var*
begin
//#UC START# *4DAEEDE10285_BB45F71CEF15_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BB45F71CEF15_impl*
end;//TkwContentsFormLstComments.DoDoIt

class function TkwContentsFormLstComments.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.lstComments';
end;//TkwContentsFormLstComments.GetWordNameForRegister

procedure TkwContentsFormLstComments.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BB45F71CEF15_var*
//#UC END# *52D00B00031A_BB45F71CEF15_var*
begin
//#UC START# *52D00B00031A_BB45F71CEF15_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BB45F71CEF15_impl*
end;//TkwContentsFormLstComments.SetValuePrim

function TkwContentsFormLstComments.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BB45F71CEF15_var*
//#UC END# *551544E2001A_BB45F71CEF15_var*
begin
//#UC START# *551544E2001A_BB45F71CEF15_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BB45F71CEF15_impl*
end;//TkwContentsFormLstComments.GetResultTypeInfo

function TkwContentsFormLstComments.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_BB45F71CEF15_var*
//#UC END# *559687E6025A_BB45F71CEF15_var*
begin
//#UC START# *559687E6025A_BB45F71CEF15_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_BB45F71CEF15_impl*
end;//TkwContentsFormLstComments.GetAllParamsCount

function TkwContentsFormLstComments.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BB45F71CEF15_var*
//#UC END# *5617F4D00243_BB45F71CEF15_var*
begin
//#UC START# *5617F4D00243_BB45F71CEF15_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BB45F71CEF15_impl*
end;//TkwContentsFormLstComments.ParamsTypes

function TkwContentsFormLstExternalObjects.lstExternalObjects(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtLister;
 {* ���������� ����� ������� .TContentsForm.lstExternalObjects }
//#UC START# *8C038B13B576_BC07363209CB_var*
//#UC END# *8C038B13B576_BC07363209CB_var*
begin
//#UC START# *8C038B13B576_BC07363209CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *8C038B13B576_BC07363209CB_impl*
end;//TkwContentsFormLstExternalObjects.lstExternalObjects

procedure TkwContentsFormLstExternalObjects.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BC07363209CB_var*
//#UC END# *4DAEEDE10285_BC07363209CB_var*
begin
//#UC START# *4DAEEDE10285_BC07363209CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BC07363209CB_impl*
end;//TkwContentsFormLstExternalObjects.DoDoIt

class function TkwContentsFormLstExternalObjects.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.lstExternalObjects';
end;//TkwContentsFormLstExternalObjects.GetWordNameForRegister

procedure TkwContentsFormLstExternalObjects.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BC07363209CB_var*
//#UC END# *52D00B00031A_BC07363209CB_var*
begin
//#UC START# *52D00B00031A_BC07363209CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BC07363209CB_impl*
end;//TkwContentsFormLstExternalObjects.SetValuePrim

function TkwContentsFormLstExternalObjects.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BC07363209CB_var*
//#UC END# *551544E2001A_BC07363209CB_var*
begin
//#UC START# *551544E2001A_BC07363209CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BC07363209CB_impl*
end;//TkwContentsFormLstExternalObjects.GetResultTypeInfo

function TkwContentsFormLstExternalObjects.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_BC07363209CB_var*
//#UC END# *559687E6025A_BC07363209CB_var*
begin
//#UC START# *559687E6025A_BC07363209CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_BC07363209CB_impl*
end;//TkwContentsFormLstExternalObjects.GetAllParamsCount

function TkwContentsFormLstExternalObjects.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BC07363209CB_var*
//#UC END# *5617F4D00243_BC07363209CB_var*
begin
//#UC START# *5617F4D00243_BC07363209CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BC07363209CB_impl*
end;//TkwContentsFormLstExternalObjects.ParamsTypes

function TkwContentsFormContentsTree.ContentsTree(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TContentsForm.ContentsTree }
//#UC START# *493082DA0AA9_73822264D1F3_var*
//#UC END# *493082DA0AA9_73822264D1F3_var*
begin
//#UC START# *493082DA0AA9_73822264D1F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *493082DA0AA9_73822264D1F3_impl*
end;//TkwContentsFormContentsTree.ContentsTree

procedure TkwContentsFormContentsTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_73822264D1F3_var*
//#UC END# *4DAEEDE10285_73822264D1F3_var*
begin
//#UC START# *4DAEEDE10285_73822264D1F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_73822264D1F3_impl*
end;//TkwContentsFormContentsTree.DoDoIt

class function TkwContentsFormContentsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.ContentsTree';
end;//TkwContentsFormContentsTree.GetWordNameForRegister

procedure TkwContentsFormContentsTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_73822264D1F3_var*
//#UC END# *52D00B00031A_73822264D1F3_var*
begin
//#UC START# *52D00B00031A_73822264D1F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_73822264D1F3_impl*
end;//TkwContentsFormContentsTree.SetValuePrim

function TkwContentsFormContentsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_73822264D1F3_var*
//#UC END# *551544E2001A_73822264D1F3_var*
begin
//#UC START# *551544E2001A_73822264D1F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_73822264D1F3_impl*
end;//TkwContentsFormContentsTree.GetResultTypeInfo

function TkwContentsFormContentsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_73822264D1F3_var*
//#UC END# *559687E6025A_73822264D1F3_var*
begin
//#UC START# *559687E6025A_73822264D1F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_73822264D1F3_impl*
end;//TkwContentsFormContentsTree.GetAllParamsCount

function TkwContentsFormContentsTree.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_73822264D1F3_var*
//#UC END# *5617F4D00243_73822264D1F3_var*
begin
//#UC START# *5617F4D00243_73822264D1F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_73822264D1F3_impl*
end;//TkwContentsFormContentsTree.ParamsTypes

function TkwContentsFormContextFilter.ContextFilter(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TnscContextFilter;
 {* ���������� ����� ������� .TContentsForm.ContextFilter }
//#UC START# *95E7CE26282E_1F49FC7EEC5A_var*
//#UC END# *95E7CE26282E_1F49FC7EEC5A_var*
begin
//#UC START# *95E7CE26282E_1F49FC7EEC5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *95E7CE26282E_1F49FC7EEC5A_impl*
end;//TkwContentsFormContextFilter.ContextFilter

procedure TkwContentsFormContextFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1F49FC7EEC5A_var*
//#UC END# *4DAEEDE10285_1F49FC7EEC5A_var*
begin
//#UC START# *4DAEEDE10285_1F49FC7EEC5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1F49FC7EEC5A_impl*
end;//TkwContentsFormContextFilter.DoDoIt

class function TkwContentsFormContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.ContextFilter';
end;//TkwContentsFormContextFilter.GetWordNameForRegister

procedure TkwContentsFormContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1F49FC7EEC5A_var*
//#UC END# *52D00B00031A_1F49FC7EEC5A_var*
begin
//#UC START# *52D00B00031A_1F49FC7EEC5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1F49FC7EEC5A_impl*
end;//TkwContentsFormContextFilter.SetValuePrim

function TkwContentsFormContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1F49FC7EEC5A_var*
//#UC END# *551544E2001A_1F49FC7EEC5A_var*
begin
//#UC START# *551544E2001A_1F49FC7EEC5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1F49FC7EEC5A_impl*
end;//TkwContentsFormContextFilter.GetResultTypeInfo

function TkwContentsFormContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1F49FC7EEC5A_var*
//#UC END# *559687E6025A_1F49FC7EEC5A_var*
begin
//#UC START# *559687E6025A_1F49FC7EEC5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1F49FC7EEC5A_impl*
end;//TkwContentsFormContextFilter.GetAllParamsCount

function TkwContentsFormContextFilter.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1F49FC7EEC5A_var*
//#UC END# *5617F4D00243_1F49FC7EEC5A_var*
begin
//#UC START# *5617F4D00243_1F49FC7EEC5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1F49FC7EEC5A_impl*
end;//TkwContentsFormContextFilter.ParamsTypes

function TkwContentsFormTasks.Tasks(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TnscTasksPanelView;
 {* ���������� ����� ������� .TContentsForm.Tasks }
//#UC START# *8B0302DABFA2_7D17DDA72BEE_var*
//#UC END# *8B0302DABFA2_7D17DDA72BEE_var*
begin
//#UC START# *8B0302DABFA2_7D17DDA72BEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *8B0302DABFA2_7D17DDA72BEE_impl*
end;//TkwContentsFormTasks.Tasks

procedure TkwContentsFormTasks.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7D17DDA72BEE_var*
//#UC END# *4DAEEDE10285_7D17DDA72BEE_var*
begin
//#UC START# *4DAEEDE10285_7D17DDA72BEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7D17DDA72BEE_impl*
end;//TkwContentsFormTasks.DoDoIt

class function TkwContentsFormTasks.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.Tasks';
end;//TkwContentsFormTasks.GetWordNameForRegister

procedure TkwContentsFormTasks.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7D17DDA72BEE_var*
//#UC END# *52D00B00031A_7D17DDA72BEE_var*
begin
//#UC START# *52D00B00031A_7D17DDA72BEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7D17DDA72BEE_impl*
end;//TkwContentsFormTasks.SetValuePrim

function TkwContentsFormTasks.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7D17DDA72BEE_var*
//#UC END# *551544E2001A_7D17DDA72BEE_var*
begin
//#UC START# *551544E2001A_7D17DDA72BEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7D17DDA72BEE_impl*
end;//TkwContentsFormTasks.GetResultTypeInfo

function TkwContentsFormTasks.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_7D17DDA72BEE_var*
//#UC END# *559687E6025A_7D17DDA72BEE_var*
begin
//#UC START# *559687E6025A_7D17DDA72BEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_7D17DDA72BEE_impl*
end;//TkwContentsFormTasks.GetAllParamsCount

function TkwContentsFormTasks.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7D17DDA72BEE_var*
//#UC END# *5617F4D00243_7D17DDA72BEE_var*
begin
//#UC START# *5617F4D00243_7D17DDA72BEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7D17DDA72BEE_impl*
end;//TkwContentsFormTasks.ParamsTypes

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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContentsForm));
 {* ����������� ���� Contents }
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
