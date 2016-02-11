unit CustomizeTasksPanelKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� CustomizeTasksPanel }

// ������: "w:\common\components\gui\Garant\VCM\View\TasksPanel\CustomizeTasksPanelKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include sdoDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimTasksPanelMenu_Module
 , vtCtrls
 , vtPanel
 , vtLabel
 , vtButton
 , vtGroupBox
 , eeTreeView
 , eeButton
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Buttons
 {$IfEnd} // NOT Defined(NoVCL)
 , eeCheckBox
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_CustomizeTasksPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� CustomizeTasksPanel
----
*������ �������������*:
[code]
'aControl' �����::CustomizeTasksPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Form_CustomizeTasksPanel

 Tkw_CustomizeTasksPanel_Control_spRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� spRight
----
*������ �������������*:
[code]
�������::spRight TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_spRight

 Tkw_CustomizeTasksPanel_Control_spRight_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� spRight
----
*������ �������������*:
[code]
�������::spRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_spRight_Push

 Tkw_CustomizeTasksPanel_Control_pnlBottom = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlBottom
----
*������ �������������*:
[code]
�������::pnlBottom TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlBottom

 Tkw_CustomizeTasksPanel_Control_pnlBottom_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlBottom
----
*������ �������������*:
[code]
�������::pnlBottom:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push

 Tkw_CustomizeTasksPanel_Control_lblConfirmSave = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblConfirmSave
----
*������ �������������*:
[code]
�������::lblConfirmSave TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave

 Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblConfirmSave
----
*������ �������������*:
[code]
�������::lblConfirmSave:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push

 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblAvailableOpsCaption
----
*������ �������������*:
[code]
�������::lblAvailableOpsCaption TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption

 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblAvailableOpsCaption
----
*������ �������������*:
[code]
�������::lblAvailableOpsCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push

 Tkw_CustomizeTasksPanel_Control_btOk = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btOk
----
*������ �������������*:
[code]
�������::btOk TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btOk

 Tkw_CustomizeTasksPanel_Control_btOk_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btOk
----
*������ �������������*:
[code]
�������::btOk:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btOk_Push

 Tkw_CustomizeTasksPanel_Control_btCancel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btCancel
----
*������ �������������*:
[code]
�������::btCancel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btCancel

 Tkw_CustomizeTasksPanel_Control_btCancel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btCancel
----
*������ �������������*:
[code]
�������::btCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push

 Tkw_CustomizeTasksPanel_Control_btApply = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btApply
----
*������ �������������*:
[code]
�������::btApply TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btApply

 Tkw_CustomizeTasksPanel_Control_btApply_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btApply
----
*������ �������������*:
[code]
�������::btApply:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btApply_Push

 Tkw_CustomizeTasksPanel_Control_pnlRep = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlRep
----
*������ �������������*:
[code]
�������::pnlRep TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlRep

 Tkw_CustomizeTasksPanel_Control_pnlRep_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlRep
----
*������ �������������*:
[code]
�������::pnlRep:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push

 Tkw_CustomizeTasksPanel_Control_splRep = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� splRep
----
*������ �������������*:
[code]
�������::splRep TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_splRep

 Tkw_CustomizeTasksPanel_Control_splRep_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� splRep
----
*������ �������������*:
[code]
�������::splRep:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_splRep_Push

 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� gbAvailableGroups
----
*������ �������������*:
[code]
�������::gbAvailableGroups TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups

 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� gbAvailableGroups
----
*������ �������������*:
[code]
�������::gbAvailableGroups:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push

 Tkw_CustomizeTasksPanel_Control_tvRepGroups = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvRepGroups
----
*������ �������������*:
[code]
�������::tvRepGroups TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups

 Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvRepGroups
----
*������ �������������*:
[code]
�������::tvRepGroups:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push

 Tkw_CustomizeTasksPanel_Control_vtPanel1 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� vtPanel1
----
*������ �������������*:
[code]
�������::vtPanel1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_vtPanel1

 Tkw_CustomizeTasksPanel_Control_vtPanel1_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� vtPanel1
----
*������ �������������*:
[code]
�������::vtPanel1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push

 Tkw_CustomizeTasksPanel_Control_cbGroupName = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbGroupName
----
*������ �������������*:
[code]
�������::cbGroupName TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbGroupName

 Tkw_CustomizeTasksPanel_Control_cbGroupName_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbGroupName
----
*������ �������������*:
[code]
�������::cbGroupName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push

 Tkw_CustomizeTasksPanel_Control_btnAddGroup = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnAddGroup
----
*������ �������������*:
[code]
�������::btnAddGroup TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup

 Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnAddGroup
----
*������ �������������*:
[code]
�������::btnAddGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push

 Tkw_CustomizeTasksPanel_Control_btnChangeGroup = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnChangeGroup
----
*������ �������������*:
[code]
�������::btnChangeGroup TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup

 Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnChangeGroup
----
*������ �������������*:
[code]
�������::btnChangeGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push

 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnDeleteGroup
----
*������ �������������*:
[code]
�������::btnDeleteGroup TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup

 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnDeleteGroup
----
*������ �������������*:
[code]
�������::btnDeleteGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push

 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� gbAvailableOperations
----
*������ �������������*:
[code]
�������::gbAvailableOperations TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations

 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� gbAvailableOperations
----
*������ �������������*:
[code]
�������::gbAvailableOperations:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push

 Tkw_CustomizeTasksPanel_Control_tvRepOps = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvRepOps
----
*������ �������������*:
[code]
�������::tvRepOps TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvRepOps

 Tkw_CustomizeTasksPanel_Control_tvRepOps_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvRepOps
----
*������ �������������*:
[code]
�������::tvRepOps:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push

 Tkw_CustomizeTasksPanel_Control_pnlForms = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlForms
----
*������ �������������*:
[code]
�������::pnlForms TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlForms

 Tkw_CustomizeTasksPanel_Control_pnlForms_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlForms
----
*������ �������������*:
[code]
�������::pnlForms:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push

 Tkw_CustomizeTasksPanel_Control_lblForms = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblForms
----
*������ �������������*:
[code]
�������::lblForms TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblForms

 Tkw_CustomizeTasksPanel_Control_lblForms_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblForms
----
*������ �������������*:
[code]
�������::lblForms:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push

 Tkw_CustomizeTasksPanel_Control_cbForms = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbForms
----
*������ �������������*:
[code]
�������::cbForms TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbForms

 Tkw_CustomizeTasksPanel_Control_cbForms_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbForms
----
*������ �������������*:
[code]
�������::cbForms:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push

 Tkw_CustomizeTasksPanel_Control_pnlMain = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlMain

 Tkw_CustomizeTasksPanel_Control_pnlMain_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push

 Tkw_CustomizeTasksPanel_Control_pnlLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlLeft
----
*������ �������������*:
[code]
�������::pnlLeft TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlLeft

 Tkw_CustomizeTasksPanel_Control_pnlLeft_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlLeft
----
*������ �������������*:
[code]
�������::pnlLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push

 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnMoveOpToPanel
----
*������ �������������*:
[code]
�������::btnMoveOpToPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel

 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnMoveOpToPanel
----
*������ �������������*:
[code]
�������::btnMoveOpToPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push

 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnMoveOpToRep
----
*������ �������������*:
[code]
�������::btnMoveOpToRep TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep

 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnMoveOpToRep
----
*������ �������������*:
[code]
�������::btnMoveOpToRep:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push

 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnMoveGroupToPanel
----
*������ �������������*:
[code]
�������::btnMoveGroupToPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel

 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnMoveGroupToPanel
----
*������ �������������*:
[code]
�������::btnMoveGroupToPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push

 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnMoveGroupToRep
----
*������ �������������*:
[code]
�������::btnMoveGroupToRep TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep

 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnMoveGroupToRep
----
*������ �������������*:
[code]
�������::btnMoveGroupToRep:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push

 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlTasksPanel
----
*������ �������������*:
[code]
�������::pnlTasksPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel

 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlTasksPanel
----
*������ �������������*:
[code]
�������::pnlTasksPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push

 Tkw_CustomizeTasksPanel_Control_gbTasksPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� gbTasksPanel
----
*������ �������������*:
[code]
�������::gbTasksPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel

 Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� gbTasksPanel
----
*������ �������������*:
[code]
�������::gbTasksPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push

 Tkw_CustomizeTasksPanel_Control_tvTasksPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvTasksPanel
----
*������ �������������*:
[code]
�������::tvTasksPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel

 Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvTasksPanel
----
*������ �������������*:
[code]
�������::tvTasksPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push

 Tkw_CustomizeTasksPanel_Control_vtGroupBox3 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� vtGroupBox3
----
*������ �������������*:
[code]
�������::vtGroupBox3 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3

 Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� vtGroupBox3
----
*������ �������������*:
[code]
�������::vtGroupBox3:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push

 Tkw_CustomizeTasksPanel_Control_lblCaption = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblCaption
----
*������ �������������*:
[code]
�������::lblCaption TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblCaption

 Tkw_CustomizeTasksPanel_Control_lblCaption_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblCaption
----
*������ �������������*:
[code]
�������::lblCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push

 Tkw_CustomizeTasksPanel_Control_edChange = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edChange
----
*������ �������������*:
[code]
�������::edChange TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_edChange

 Tkw_CustomizeTasksPanel_Control_edChange_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edChange
----
*������ �������������*:
[code]
�������::edChange:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_edChange_Push

 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbForAllUseCases
----
*������ �������������*:
[code]
�������::cbForAllUseCases TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases

 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbForAllUseCases
----
*������ �������������*:
[code]
�������::cbForAllUseCases:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push

 Tkw_CustomizeTasksPanel_Control_btnChangeItem = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnChangeItem
----
*������ �������������*:
[code]
�������::btnChangeItem TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem

 Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnChangeItem
----
*������ �������������*:
[code]
�������::btnChangeItem:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push

 Tkw_CustomizeTasksPanel_Control_pnlOperationPos = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlOperationPos
----
*������ �������������*:
[code]
�������::pnlOperationPos TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos

 Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlOperationPos
----
*������ �������������*:
[code]
�������::pnlOperationPos:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push

 Tkw_CustomizeTasksPanel_Control_UpBitBtn = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� UpBitBtn
----
*������ �������������*:
[code]
�������::UpBitBtn TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn

 Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� UpBitBtn
----
*������ �������������*:
[code]
�������::UpBitBtn:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push

 Tkw_CustomizeTasksPanel_Control_DownBitBtn = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� DownBitBtn
----
*������ �������������*:
[code]
�������::DownBitBtn TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn

 Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� DownBitBtn
----
*������ �������������*:
[code]
�������::DownBitBtn:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push

 TkwCustomizeTasksPanelFormSpRight = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.spRight
[panel]������� spRight ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtSplitter
*������:*
[code]
OBJECT VAR l_TvtSplitter
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.spRight >>> l_TvtSplitter
[code]  }
  private
   function spRight(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.spRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormSpRight

 TkwCustomizeTasksPanelFormPnlBottom = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlBottom
[panel]������� pnlBottom ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlBottom >>> l_TvtPanel
[code]  }
  private
   function pnlBottom(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlBottom }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormPnlBottom

 TkwCustomizeTasksPanelFormLblConfirmSave = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblConfirmSave
[panel]������� lblConfirmSave ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblConfirmSave >>> l_TvtLabel
[code]  }
  private
   function lblConfirmSave(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblConfirmSave }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormLblConfirmSave

 TkwCustomizeTasksPanelFormLblAvailableOpsCaption = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblAvailableOpsCaption
[panel]������� lblAvailableOpsCaption ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblAvailableOpsCaption >>> l_TvtLabel
[code]  }
  private
   function lblAvailableOpsCaption(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption

 TkwCustomizeTasksPanelFormBtOk = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btOk
[panel]������� btOk ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btOk >>> l_TvtButton
[code]  }
  private
   function btOk(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btOk }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtOk

 TkwCustomizeTasksPanelFormBtCancel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btCancel
[panel]������� btCancel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btCancel >>> l_TvtButton
[code]  }
  private
   function btCancel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btCancel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtCancel

 TkwCustomizeTasksPanelFormBtApply = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btApply
[panel]������� btApply ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btApply >>> l_TvtButton
[code]  }
  private
   function btApply(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btApply }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtApply

 TkwCustomizeTasksPanelFormPnlRep = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlRep
[panel]������� pnlRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlRep >>> l_TvtPanel
[code]  }
  private
   function pnlRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlRep }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormPnlRep

 TkwCustomizeTasksPanelFormSplRep = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.splRep
[panel]������� splRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtSplitter
*������:*
[code]
OBJECT VAR l_TvtSplitter
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.splRep >>> l_TvtSplitter
[code]  }
  private
   function splRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.splRep }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormSplRep

 TkwCustomizeTasksPanelFormGbAvailableGroups = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.gbAvailableGroups
[panel]������� gbAvailableGroups ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbAvailableGroups >>> l_TvtGroupBox
[code]  }
  private
   function gbAvailableGroups(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableGroups }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormGbAvailableGroups

 TkwCustomizeTasksPanelFormTvRepGroups = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.tvRepGroups
[panel]������� tvRepGroups ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvRepGroups >>> l_TeeTreeView
[code]  }
  private
   function tvRepGroups(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepGroups }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormTvRepGroups

 TkwCustomizeTasksPanelFormVtPanel1 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.vtPanel1
[panel]������� vtPanel1 ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.vtPanel1 >>> l_TvtPanel
[code]  }
  private
   function vtPanel1(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtPanel1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormVtPanel1

 TkwCustomizeTasksPanelFormCbGroupName = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.cbGroupName
[panel]������� cbGroupName ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtComboBox
*������:*
[code]
OBJECT VAR l_TvtComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbGroupName >>> l_TvtComboBox
[code]  }
  private
   function cbGroupName(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbGroupName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormCbGroupName

 TkwCustomizeTasksPanelFormBtnAddGroup = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnAddGroup
[panel]������� btnAddGroup ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnAddGroup >>> l_TeeButton
[code]  }
  private
   function btnAddGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnAddGroup }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtnAddGroup

 TkwCustomizeTasksPanelFormBtnChangeGroup = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnChangeGroup
[panel]������� btnChangeGroup ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnChangeGroup >>> l_TeeButton
[code]  }
  private
   function btnChangeGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeGroup }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtnChangeGroup

 TkwCustomizeTasksPanelFormBtnDeleteGroup = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnDeleteGroup
[panel]������� btnDeleteGroup ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnDeleteGroup >>> l_TeeButton
[code]  }
  private
   function btnDeleteGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnDeleteGroup }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtnDeleteGroup

 TkwCustomizeTasksPanelFormGbAvailableOperations = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.gbAvailableOperations
[panel]������� gbAvailableOperations ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbAvailableOperations >>> l_TvtGroupBox
[code]  }
  private
   function gbAvailableOperations(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableOperations }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormGbAvailableOperations

 TkwCustomizeTasksPanelFormTvRepOps = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.tvRepOps
[panel]������� tvRepOps ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvRepOps >>> l_TeeTreeView
[code]  }
  private
   function tvRepOps(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepOps }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormTvRepOps

 TkwCustomizeTasksPanelFormPnlForms = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlForms
[panel]������� pnlForms ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlForms >>> l_TvtPanel
[code]  }
  private
   function pnlForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlForms }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormPnlForms

 TkwCustomizeTasksPanelFormLblForms = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblForms
[panel]������� lblForms ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblForms >>> l_TvtLabel
[code]  }
  private
   function lblForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblForms }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormLblForms

 TkwCustomizeTasksPanelFormCbForms = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.cbForms
[panel]������� cbForms ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TComboBox
*������:*
[code]
OBJECT VAR l_TComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbForms >>> l_TComboBox
[code]  }
  private
   function cbForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForms }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormCbForms

 TkwCustomizeTasksPanelFormPnlMain = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlMain
[panel]������� pnlMain ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlMain >>> l_TvtPanel
[code]  }
  private
   function pnlMain(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlMain }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormPnlMain

 TkwCustomizeTasksPanelFormPnlLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlLeft
[panel]������� pnlLeft ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlLeft >>> l_TvtPanel
[code]  }
  private
   function pnlLeft(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormPnlLeft

 TkwCustomizeTasksPanelFormBtnMoveOpToPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToPanel
[panel]������� btnMoveOpToPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveOpToPanel >>> l_TBitBtn
[code]  }
  private
   function btnMoveOpToPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel

 TkwCustomizeTasksPanelFormBtnMoveOpToRep = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToRep
[panel]������� btnMoveOpToRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveOpToRep >>> l_TBitBtn
[code]  }
  private
   function btnMoveOpToRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToRep }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep

 TkwCustomizeTasksPanelFormBtnMoveGroupToPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToPanel
[panel]������� btnMoveGroupToPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveGroupToPanel >>> l_TBitBtn
[code]  }
  private
   function btnMoveGroupToPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel

 TkwCustomizeTasksPanelFormBtnMoveGroupToRep = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToRep
[panel]������� btnMoveGroupToRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveGroupToRep >>> l_TBitBtn
[code]  }
  private
   function btnMoveGroupToRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToRep }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep

 TkwCustomizeTasksPanelFormPnlTasksPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlTasksPanel
[panel]������� pnlTasksPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlTasksPanel >>> l_TvtPanel
[code]  }
  private
   function pnlTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlTasksPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormPnlTasksPanel

 TkwCustomizeTasksPanelFormGbTasksPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.gbTasksPanel
[panel]������� gbTasksPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbTasksPanel >>> l_TvtGroupBox
[code]  }
  private
   function gbTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbTasksPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormGbTasksPanel

 TkwCustomizeTasksPanelFormTvTasksPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.tvTasksPanel
[panel]������� tvTasksPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvTasksPanel >>> l_TeeTreeView
[code]  }
  private
   function tvTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvTasksPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormTvTasksPanel

 TkwCustomizeTasksPanelFormVtGroupBox3 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.vtGroupBox3
[panel]������� vtGroupBox3 ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.vtGroupBox3 >>> l_TvtGroupBox
[code]  }
  private
   function vtGroupBox3(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtGroupBox3 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormVtGroupBox3

 TkwCustomizeTasksPanelFormLblCaption = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblCaption
[panel]������� lblCaption ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblCaption >>> l_TvtLabel
[code]  }
  private
   function lblCaption(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormLblCaption

 TkwCustomizeTasksPanelFormEdChange = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.edChange
[panel]������� edChange ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtComboBox
*������:*
[code]
OBJECT VAR l_TvtComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.edChange >>> l_TvtComboBox
[code]  }
  private
   function edChange(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.edChange }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormEdChange

 TkwCustomizeTasksPanelFormCbForAllUseCases = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.cbForAllUseCases
[panel]������� cbForAllUseCases ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeCheckBox
*������:*
[code]
OBJECT VAR l_TeeCheckBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbForAllUseCases >>> l_TeeCheckBox
[code]  }
  private
   function cbForAllUseCases(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForAllUseCases }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormCbForAllUseCases

 TkwCustomizeTasksPanelFormBtnChangeItem = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnChangeItem
[panel]������� btnChangeItem ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnChangeItem >>> l_TeeButton
[code]  }
  private
   function btnChangeItem(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeItem }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormBtnChangeItem

 TkwCustomizeTasksPanelFormPnlOperationPos = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlOperationPos
[panel]������� pnlOperationPos ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlOperationPos >>> l_TvtPanel
[code]  }
  private
   function pnlOperationPos(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlOperationPos }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormPnlOperationPos

 TkwCustomizeTasksPanelFormUpBitBtn = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.UpBitBtn
[panel]������� UpBitBtn ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.UpBitBtn >>> l_TBitBtn
[code]  }
  private
   function UpBitBtn(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.UpBitBtn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormUpBitBtn

 TkwCustomizeTasksPanelFormDownBitBtn = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.DownBitBtn
[panel]������� DownBitBtn ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.DownBitBtn >>> l_TBitBtn
[code]  }
  private
   function DownBitBtn(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.DownBitBtn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCustomizeTasksPanelFormDownBitBtn

class function Tkw_Form_CustomizeTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::CustomizeTasksPanel';
end;//Tkw_Form_CustomizeTasksPanel.GetWordNameForRegister

function Tkw_Form_CustomizeTasksPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_51039407562C_var*
//#UC END# *4DDFD2EA0116_51039407562C_var*
begin
//#UC START# *4DDFD2EA0116_51039407562C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_51039407562C_impl*
end;//Tkw_Form_CustomizeTasksPanel.GetString

class procedure Tkw_Form_CustomizeTasksPanel.RegisterInEngine;
//#UC START# *52A086150180_51039407562C_var*
//#UC END# *52A086150180_51039407562C_var*
begin
//#UC START# *52A086150180_51039407562C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_51039407562C_impl*
end;//Tkw_Form_CustomizeTasksPanel.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_spRight.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::spRight';
end;//Tkw_CustomizeTasksPanel_Control_spRight.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_spRight.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_42A694BF7C5D_var*
//#UC END# *4DDFD2EA0116_42A694BF7C5D_var*
begin
//#UC START# *4DDFD2EA0116_42A694BF7C5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_42A694BF7C5D_impl*
end;//Tkw_CustomizeTasksPanel_Control_spRight.GetString

class procedure Tkw_CustomizeTasksPanel_Control_spRight.RegisterInEngine;
//#UC START# *52A086150180_42A694BF7C5D_var*
//#UC END# *52A086150180_42A694BF7C5D_var*
begin
//#UC START# *52A086150180_42A694BF7C5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_42A694BF7C5D_impl*
end;//Tkw_CustomizeTasksPanel_Control_spRight.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_spRight_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EB29C7EA3DE5_var*
//#UC END# *4DAEEDE10285_EB29C7EA3DE5_var*
begin
//#UC START# *4DAEEDE10285_EB29C7EA3DE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EB29C7EA3DE5_impl*
end;//Tkw_CustomizeTasksPanel_Control_spRight_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_spRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::spRight:push';
end;//Tkw_CustomizeTasksPanel_Control_spRight_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_pnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlBottom';
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlBottom.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CC47AB4A0196_var*
//#UC END# *4DDFD2EA0116_CC47AB4A0196_var*
begin
//#UC START# *4DDFD2EA0116_CC47AB4A0196_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CC47AB4A0196_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlBottom.RegisterInEngine;
//#UC START# *52A086150180_CC47AB4A0196_var*
//#UC END# *52A086150180_CC47AB4A0196_var*
begin
//#UC START# *52A086150180_CC47AB4A0196_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CC47AB4A0196_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_434F7D0E25A1_var*
//#UC END# *4DAEEDE10285_434F7D0E25A1_var*
begin
//#UC START# *4DAEEDE10285_434F7D0E25A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_434F7D0E25A1_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlBottom:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblConfirmSave';
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4C9E1169E5C1_var*
//#UC END# *4DDFD2EA0116_4C9E1169E5C1_var*
begin
//#UC START# *4DDFD2EA0116_4C9E1169E5C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4C9E1169E5C1_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblConfirmSave.RegisterInEngine;
//#UC START# *52A086150180_4C9E1169E5C1_var*
//#UC END# *52A086150180_4C9E1169E5C1_var*
begin
//#UC START# *52A086150180_4C9E1169E5C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4C9E1169E5C1_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_02E2B4659307_var*
//#UC END# *4DAEEDE10285_02E2B4659307_var*
begin
//#UC START# *4DAEEDE10285_02E2B4659307_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_02E2B4659307_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblConfirmSave:push';
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblAvailableOpsCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_075383E9CC33_var*
//#UC END# *4DDFD2EA0116_075383E9CC33_var*
begin
//#UC START# *4DDFD2EA0116_075383E9CC33_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_075383E9CC33_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.RegisterInEngine;
//#UC START# *52A086150180_075383E9CC33_var*
//#UC END# *52A086150180_075383E9CC33_var*
begin
//#UC START# *52A086150180_075383E9CC33_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_075383E9CC33_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F5061FEDAF43_var*
//#UC END# *4DAEEDE10285_F5061FEDAF43_var*
begin
//#UC START# *4DAEEDE10285_F5061FEDAF43_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F5061FEDAF43_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblAvailableOpsCaption:push';
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btOk.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btOk';
end;//Tkw_CustomizeTasksPanel_Control_btOk.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btOk.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DFA6EB875E3C_var*
//#UC END# *4DDFD2EA0116_DFA6EB875E3C_var*
begin
//#UC START# *4DDFD2EA0116_DFA6EB875E3C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DFA6EB875E3C_impl*
end;//Tkw_CustomizeTasksPanel_Control_btOk.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btOk.RegisterInEngine;
//#UC START# *52A086150180_DFA6EB875E3C_var*
//#UC END# *52A086150180_DFA6EB875E3C_var*
begin
//#UC START# *52A086150180_DFA6EB875E3C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DFA6EB875E3C_impl*
end;//Tkw_CustomizeTasksPanel_Control_btOk.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btOk_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DAF9298D8BB9_var*
//#UC END# *4DAEEDE10285_DAF9298D8BB9_var*
begin
//#UC START# *4DAEEDE10285_DAF9298D8BB9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DAF9298D8BB9_impl*
end;//Tkw_CustomizeTasksPanel_Control_btOk_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btOk:push';
end;//Tkw_CustomizeTasksPanel_Control_btOk_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btCancel';
end;//Tkw_CustomizeTasksPanel_Control_btCancel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btCancel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CEA9FD1DE042_var*
//#UC END# *4DDFD2EA0116_CEA9FD1DE042_var*
begin
//#UC START# *4DDFD2EA0116_CEA9FD1DE042_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CEA9FD1DE042_impl*
end;//Tkw_CustomizeTasksPanel_Control_btCancel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btCancel.RegisterInEngine;
//#UC START# *52A086150180_CEA9FD1DE042_var*
//#UC END# *52A086150180_CEA9FD1DE042_var*
begin
//#UC START# *52A086150180_CEA9FD1DE042_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CEA9FD1DE042_impl*
end;//Tkw_CustomizeTasksPanel_Control_btCancel.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btCancel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FB733C0BDD97_var*
//#UC END# *4DAEEDE10285_FB733C0BDD97_var*
begin
//#UC START# *4DAEEDE10285_FB733C0BDD97_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FB733C0BDD97_impl*
end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btCancel:push';
end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btApply.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btApply';
end;//Tkw_CustomizeTasksPanel_Control_btApply.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btApply.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E65A74CAF532_var*
//#UC END# *4DDFD2EA0116_E65A74CAF532_var*
begin
//#UC START# *4DDFD2EA0116_E65A74CAF532_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E65A74CAF532_impl*
end;//Tkw_CustomizeTasksPanel_Control_btApply.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btApply.RegisterInEngine;
//#UC START# *52A086150180_E65A74CAF532_var*
//#UC END# *52A086150180_E65A74CAF532_var*
begin
//#UC START# *52A086150180_E65A74CAF532_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E65A74CAF532_impl*
end;//Tkw_CustomizeTasksPanel_Control_btApply.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btApply_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_324C1AF2E387_var*
//#UC END# *4DAEEDE10285_324C1AF2E387_var*
begin
//#UC START# *4DAEEDE10285_324C1AF2E387_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_324C1AF2E387_impl*
end;//Tkw_CustomizeTasksPanel_Control_btApply_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btApply_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btApply:push';
end;//Tkw_CustomizeTasksPanel_Control_btApply_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_pnlRep.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlRep';
end;//Tkw_CustomizeTasksPanel_Control_pnlRep.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlRep.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_68D2A80BA3AC_var*
//#UC END# *4DDFD2EA0116_68D2A80BA3AC_var*
begin
//#UC START# *4DDFD2EA0116_68D2A80BA3AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_68D2A80BA3AC_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlRep.RegisterInEngine;
//#UC START# *52A086150180_68D2A80BA3AC_var*
//#UC END# *52A086150180_68D2A80BA3AC_var*
begin
//#UC START# *52A086150180_68D2A80BA3AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_68D2A80BA3AC_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlRep.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_pnlRep_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D4F2CAF6DCF1_var*
//#UC END# *4DAEEDE10285_D4F2CAF6DCF1_var*
begin
//#UC START# *4DAEEDE10285_D4F2CAF6DCF1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D4F2CAF6DCF1_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlRep:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_splRep.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::splRep';
end;//Tkw_CustomizeTasksPanel_Control_splRep.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_splRep.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A2A984BF53A1_var*
//#UC END# *4DDFD2EA0116_A2A984BF53A1_var*
begin
//#UC START# *4DDFD2EA0116_A2A984BF53A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A2A984BF53A1_impl*
end;//Tkw_CustomizeTasksPanel_Control_splRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_splRep.RegisterInEngine;
//#UC START# *52A086150180_A2A984BF53A1_var*
//#UC END# *52A086150180_A2A984BF53A1_var*
begin
//#UC START# *52A086150180_A2A984BF53A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A2A984BF53A1_impl*
end;//Tkw_CustomizeTasksPanel_Control_splRep.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_splRep_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B9FC60DAC749_var*
//#UC END# *4DAEEDE10285_B9FC60DAC749_var*
begin
//#UC START# *4DAEEDE10285_B9FC60DAC749_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B9FC60DAC749_impl*
end;//Tkw_CustomizeTasksPanel_Control_splRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_splRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::splRep:push';
end;//Tkw_CustomizeTasksPanel_Control_splRep_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbAvailableGroups';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_749FC3FE2FFA_var*
//#UC END# *4DDFD2EA0116_749FC3FE2FFA_var*
begin
//#UC START# *4DDFD2EA0116_749FC3FE2FFA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_749FC3FE2FFA_impl*
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetString

class procedure Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.RegisterInEngine;
//#UC START# *52A086150180_749FC3FE2FFA_var*
//#UC END# *52A086150180_749FC3FE2FFA_var*
begin
//#UC START# *52A086150180_749FC3FE2FFA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_749FC3FE2FFA_impl*
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_145A433A21E8_var*
//#UC END# *4DAEEDE10285_145A433A21E8_var*
begin
//#UC START# *4DAEEDE10285_145A433A21E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_145A433A21E8_impl*
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbAvailableGroups:push';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvRepGroups';
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_02962B97FD74_var*
//#UC END# *4DDFD2EA0116_02962B97FD74_var*
begin
//#UC START# *4DDFD2EA0116_02962B97FD74_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_02962B97FD74_impl*
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetString

class procedure Tkw_CustomizeTasksPanel_Control_tvRepGroups.RegisterInEngine;
//#UC START# *52A086150180_02962B97FD74_var*
//#UC END# *52A086150180_02962B97FD74_var*
begin
//#UC START# *52A086150180_02962B97FD74_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_02962B97FD74_impl*
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_779F75A12583_var*
//#UC END# *4DAEEDE10285_779F75A12583_var*
begin
//#UC START# *4DAEEDE10285_779F75A12583_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_779F75A12583_impl*
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvRepGroups:push';
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_vtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtPanel1';
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_vtPanel1.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C93CB6AAB680_var*
//#UC END# *4DDFD2EA0116_C93CB6AAB680_var*
begin
//#UC START# *4DDFD2EA0116_C93CB6AAB680_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C93CB6AAB680_impl*
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1.GetString

class procedure Tkw_CustomizeTasksPanel_Control_vtPanel1.RegisterInEngine;
//#UC START# *52A086150180_C93CB6AAB680_var*
//#UC END# *52A086150180_C93CB6AAB680_var*
begin
//#UC START# *52A086150180_C93CB6AAB680_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C93CB6AAB680_impl*
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_054F5CE71A55_var*
//#UC END# *4DAEEDE10285_054F5CE71A55_var*
begin
//#UC START# *4DAEEDE10285_054F5CE71A55_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_054F5CE71A55_impl*
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtPanel1:push';
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_cbGroupName.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbGroupName';
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_cbGroupName.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C9BA5280EC51_var*
//#UC END# *4DDFD2EA0116_C9BA5280EC51_var*
begin
//#UC START# *4DDFD2EA0116_C9BA5280EC51_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C9BA5280EC51_impl*
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName.GetString

class procedure Tkw_CustomizeTasksPanel_Control_cbGroupName.RegisterInEngine;
//#UC START# *52A086150180_C9BA5280EC51_var*
//#UC END# *52A086150180_C9BA5280EC51_var*
begin
//#UC START# *52A086150180_C9BA5280EC51_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C9BA5280EC51_impl*
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_42F13BB32A28_var*
//#UC END# *4DAEEDE10285_42F13BB32A28_var*
begin
//#UC START# *4DAEEDE10285_42F13BB32A28_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_42F13BB32A28_impl*
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbGroupName:push';
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnAddGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CE93F6A98E6B_var*
//#UC END# *4DDFD2EA0116_CE93F6A98E6B_var*
begin
//#UC START# *4DDFD2EA0116_CE93F6A98E6B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CE93F6A98E6B_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnAddGroup.RegisterInEngine;
//#UC START# *52A086150180_CE93F6A98E6B_var*
//#UC END# *52A086150180_CE93F6A98E6B_var*
begin
//#UC START# *52A086150180_CE93F6A98E6B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CE93F6A98E6B_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_95FBA27EB55C_var*
//#UC END# *4DAEEDE10285_95FBA27EB55C_var*
begin
//#UC START# *4DAEEDE10285_95FBA27EB55C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_95FBA27EB55C_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnAddGroup:push';
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnChangeGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8017513A28D0_var*
//#UC END# *4DDFD2EA0116_8017513A28D0_var*
begin
//#UC START# *4DDFD2EA0116_8017513A28D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8017513A28D0_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnChangeGroup.RegisterInEngine;
//#UC START# *52A086150180_8017513A28D0_var*
//#UC END# *52A086150180_8017513A28D0_var*
begin
//#UC START# *52A086150180_8017513A28D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8017513A28D0_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6DF61535F5AB_var*
//#UC END# *4DAEEDE10285_6DF61535F5AB_var*
begin
//#UC START# *4DAEEDE10285_6DF61535F5AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6DF61535F5AB_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnChangeGroup:push';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnDeleteGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1B6273506EC7_var*
//#UC END# *4DDFD2EA0116_1B6273506EC7_var*
begin
//#UC START# *4DDFD2EA0116_1B6273506EC7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1B6273506EC7_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.RegisterInEngine;
//#UC START# *52A086150180_1B6273506EC7_var*
//#UC END# *52A086150180_1B6273506EC7_var*
begin
//#UC START# *52A086150180_1B6273506EC7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1B6273506EC7_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_22AC03E5AF2D_var*
//#UC END# *4DAEEDE10285_22AC03E5AF2D_var*
begin
//#UC START# *4DAEEDE10285_22AC03E5AF2D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_22AC03E5AF2D_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnDeleteGroup:push';
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbAvailableOperations';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F31FD5E355B5_var*
//#UC END# *4DDFD2EA0116_F31FD5E355B5_var*
begin
//#UC START# *4DDFD2EA0116_F31FD5E355B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F31FD5E355B5_impl*
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetString

class procedure Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.RegisterInEngine;
//#UC START# *52A086150180_F31FD5E355B5_var*
//#UC END# *52A086150180_F31FD5E355B5_var*
begin
//#UC START# *52A086150180_F31FD5E355B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F31FD5E355B5_impl*
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9C3E29B0CCC6_var*
//#UC END# *4DAEEDE10285_9C3E29B0CCC6_var*
begin
//#UC START# *4DAEEDE10285_9C3E29B0CCC6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9C3E29B0CCC6_impl*
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbAvailableOperations:push';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_tvRepOps.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvRepOps';
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_tvRepOps.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E5528F851767_var*
//#UC END# *4DDFD2EA0116_E5528F851767_var*
begin
//#UC START# *4DDFD2EA0116_E5528F851767_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E5528F851767_impl*
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps.GetString

class procedure Tkw_CustomizeTasksPanel_Control_tvRepOps.RegisterInEngine;
//#UC START# *52A086150180_E5528F851767_var*
//#UC END# *52A086150180_E5528F851767_var*
begin
//#UC START# *52A086150180_E5528F851767_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E5528F851767_impl*
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_951B1F0CABF6_var*
//#UC END# *4DAEEDE10285_951B1F0CABF6_var*
begin
//#UC START# *4DAEEDE10285_951B1F0CABF6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_951B1F0CABF6_impl*
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvRepOps:push';
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_pnlForms.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlForms';
end;//Tkw_CustomizeTasksPanel_Control_pnlForms.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlForms.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8EF7889B3EBE_var*
//#UC END# *4DDFD2EA0116_8EF7889B3EBE_var*
begin
//#UC START# *4DDFD2EA0116_8EF7889B3EBE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8EF7889B3EBE_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlForms.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlForms.RegisterInEngine;
//#UC START# *52A086150180_8EF7889B3EBE_var*
//#UC END# *52A086150180_8EF7889B3EBE_var*
begin
//#UC START# *52A086150180_8EF7889B3EBE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8EF7889B3EBE_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlForms.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_pnlForms_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9796678C7184_var*
//#UC END# *4DAEEDE10285_9796678C7184_var*
begin
//#UC START# *4DAEEDE10285_9796678C7184_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9796678C7184_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlForms_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlForms:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_lblForms.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblForms';
end;//Tkw_CustomizeTasksPanel_Control_lblForms.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblForms.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B31EE69A8980_var*
//#UC END# *4DDFD2EA0116_B31EE69A8980_var*
begin
//#UC START# *4DDFD2EA0116_B31EE69A8980_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B31EE69A8980_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblForms.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblForms.RegisterInEngine;
//#UC START# *52A086150180_B31EE69A8980_var*
//#UC END# *52A086150180_B31EE69A8980_var*
begin
//#UC START# *52A086150180_B31EE69A8980_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B31EE69A8980_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblForms.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_lblForms_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BE7E44BBD571_var*
//#UC END# *4DAEEDE10285_BE7E44BBD571_var*
begin
//#UC START# *4DAEEDE10285_BE7E44BBD571_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BE7E44BBD571_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblForms_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblForms:push';
end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_cbForms.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbForms';
end;//Tkw_CustomizeTasksPanel_Control_cbForms.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_cbForms.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EAE945BF346F_var*
//#UC END# *4DDFD2EA0116_EAE945BF346F_var*
begin
//#UC START# *4DDFD2EA0116_EAE945BF346F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EAE945BF346F_impl*
end;//Tkw_CustomizeTasksPanel_Control_cbForms.GetString

class procedure Tkw_CustomizeTasksPanel_Control_cbForms.RegisterInEngine;
//#UC START# *52A086150180_EAE945BF346F_var*
//#UC END# *52A086150180_EAE945BF346F_var*
begin
//#UC START# *52A086150180_EAE945BF346F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EAE945BF346F_impl*
end;//Tkw_CustomizeTasksPanel_Control_cbForms.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_cbForms_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9BEC4D6F77EB_var*
//#UC END# *4DAEEDE10285_9BEC4D6F77EB_var*
begin
//#UC START# *4DAEEDE10285_9BEC4D6F77EB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9BEC4D6F77EB_impl*
end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbForms_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbForms:push';
end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain';
end;//Tkw_CustomizeTasksPanel_Control_pnlMain.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlMain.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9D284F6D879D_var*
//#UC END# *4DDFD2EA0116_9D284F6D879D_var*
begin
//#UC START# *4DDFD2EA0116_9D284F6D879D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9D284F6D879D_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlMain.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlMain.RegisterInEngine;
//#UC START# *52A086150180_9D284F6D879D_var*
//#UC END# *52A086150180_9D284F6D879D_var*
begin
//#UC START# *52A086150180_9D284F6D879D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9D284F6D879D_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlMain.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2DC2AB688E9A_var*
//#UC END# *4DAEEDE10285_2DC2AB688E9A_var*
begin
//#UC START# *4DAEEDE10285_2DC2AB688E9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2DC2AB688E9A_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_pnlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeft';
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlLeft.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AFBE56929E66_var*
//#UC END# *4DDFD2EA0116_AFBE56929E66_var*
begin
//#UC START# *4DDFD2EA0116_AFBE56929E66_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AFBE56929E66_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlLeft.RegisterInEngine;
//#UC START# *52A086150180_AFBE56929E66_var*
//#UC END# *52A086150180_AFBE56929E66_var*
begin
//#UC START# *52A086150180_AFBE56929E66_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AFBE56929E66_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DFE657D62DD8_var*
//#UC END# *4DAEEDE10285_DFE657D62DD8_var*
begin
//#UC START# *4DAEEDE10285_DFE657D62DD8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DFE657D62DD8_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeft:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveOpToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_33984D5162DC_var*
//#UC END# *4DDFD2EA0116_33984D5162DC_var*
begin
//#UC START# *4DDFD2EA0116_33984D5162DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_33984D5162DC_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.RegisterInEngine;
//#UC START# *52A086150180_33984D5162DC_var*
//#UC END# *52A086150180_33984D5162DC_var*
begin
//#UC START# *52A086150180_33984D5162DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_33984D5162DC_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_44C5D250782F_var*
//#UC END# *4DAEEDE10285_44C5D250782F_var*
begin
//#UC START# *4DAEEDE10285_44C5D250782F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_44C5D250782F_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveOpToPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveOpToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CACF6E1CA9C4_var*
//#UC END# *4DDFD2EA0116_CACF6E1CA9C4_var*
begin
//#UC START# *4DDFD2EA0116_CACF6E1CA9C4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CACF6E1CA9C4_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.RegisterInEngine;
//#UC START# *52A086150180_CACF6E1CA9C4_var*
//#UC END# *52A086150180_CACF6E1CA9C4_var*
begin
//#UC START# *52A086150180_CACF6E1CA9C4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CACF6E1CA9C4_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_833340E8F50A_var*
//#UC END# *4DAEEDE10285_833340E8F50A_var*
begin
//#UC START# *4DAEEDE10285_833340E8F50A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_833340E8F50A_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveOpToRep:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveGroupToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9C2D4929DE60_var*
//#UC END# *4DDFD2EA0116_9C2D4929DE60_var*
begin
//#UC START# *4DDFD2EA0116_9C2D4929DE60_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9C2D4929DE60_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.RegisterInEngine;
//#UC START# *52A086150180_9C2D4929DE60_var*
//#UC END# *52A086150180_9C2D4929DE60_var*
begin
//#UC START# *52A086150180_9C2D4929DE60_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9C2D4929DE60_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0541B32DD50F_var*
//#UC END# *4DAEEDE10285_0541B32DD50F_var*
begin
//#UC START# *4DAEEDE10285_0541B32DD50F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0541B32DD50F_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveGroupToPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveGroupToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_211D6BBD9BD4_var*
//#UC END# *4DDFD2EA0116_211D6BBD9BD4_var*
begin
//#UC START# *4DDFD2EA0116_211D6BBD9BD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_211D6BBD9BD4_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.RegisterInEngine;
//#UC START# *52A086150180_211D6BBD9BD4_var*
//#UC END# *52A086150180_211D6BBD9BD4_var*
begin
//#UC START# *52A086150180_211D6BBD9BD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_211D6BBD9BD4_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9DCBB6C956C7_var*
//#UC END# *4DAEEDE10285_9DCBB6C956C7_var*
begin
//#UC START# *4DAEEDE10285_9DCBB6C956C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9DCBB6C956C7_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveGroupToRep:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DCBB264906B4_var*
//#UC END# *4DDFD2EA0116_DCBB264906B4_var*
begin
//#UC START# *4DDFD2EA0116_DCBB264906B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DCBB264906B4_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.RegisterInEngine;
//#UC START# *52A086150180_DCBB264906B4_var*
//#UC END# *52A086150180_DCBB264906B4_var*
begin
//#UC START# *52A086150180_DCBB264906B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DCBB264906B4_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_98669D2F119F_var*
//#UC END# *4DAEEDE10285_98669D2F119F_var*
begin
//#UC START# *4DAEEDE10285_98669D2F119F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_98669D2F119F_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlTasksPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F3FA0E074423_var*
//#UC END# *4DDFD2EA0116_F3FA0E074423_var*
begin
//#UC START# *4DDFD2EA0116_F3FA0E074423_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F3FA0E074423_impl*
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_gbTasksPanel.RegisterInEngine;
//#UC START# *52A086150180_F3FA0E074423_var*
//#UC END# *52A086150180_F3FA0E074423_var*
begin
//#UC START# *52A086150180_F3FA0E074423_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F3FA0E074423_impl*
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FD7C1F723427_var*
//#UC END# *4DAEEDE10285_FD7C1F723427_var*
begin
//#UC START# *4DAEEDE10285_FD7C1F723427_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FD7C1F723427_impl*
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbTasksPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A17975321C44_var*
//#UC END# *4DDFD2EA0116_A17975321C44_var*
begin
//#UC START# *4DDFD2EA0116_A17975321C44_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A17975321C44_impl*
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_tvTasksPanel.RegisterInEngine;
//#UC START# *52A086150180_A17975321C44_var*
//#UC END# *52A086150180_A17975321C44_var*
begin
//#UC START# *52A086150180_A17975321C44_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A17975321C44_impl*
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3DFD722F9F33_var*
//#UC END# *4DAEEDE10285_3DFD722F9F33_var*
begin
//#UC START# *4DAEEDE10285_3DFD722F9F33_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3DFD722F9F33_impl*
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvTasksPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtGroupBox3';
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9C435F1CDCF4_var*
//#UC END# *4DDFD2EA0116_9C435F1CDCF4_var*
begin
//#UC START# *4DDFD2EA0116_9C435F1CDCF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9C435F1CDCF4_impl*
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetString

class procedure Tkw_CustomizeTasksPanel_Control_vtGroupBox3.RegisterInEngine;
//#UC START# *52A086150180_9C435F1CDCF4_var*
//#UC END# *52A086150180_9C435F1CDCF4_var*
begin
//#UC START# *52A086150180_9C435F1CDCF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9C435F1CDCF4_impl*
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DE29A49DDE57_var*
//#UC END# *4DAEEDE10285_DE29A49DDE57_var*
begin
//#UC START# *4DAEEDE10285_DE29A49DDE57_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DE29A49DDE57_impl*
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtGroupBox3:push';
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_lblCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblCaption.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblCaption.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_17FB0D58ADDE_var*
//#UC END# *4DDFD2EA0116_17FB0D58ADDE_var*
begin
//#UC START# *4DDFD2EA0116_17FB0D58ADDE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_17FB0D58ADDE_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblCaption.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblCaption.RegisterInEngine;
//#UC START# *52A086150180_17FB0D58ADDE_var*
//#UC END# *52A086150180_17FB0D58ADDE_var*
begin
//#UC START# *52A086150180_17FB0D58ADDE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_17FB0D58ADDE_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblCaption.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_lblCaption_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CEE6A63FB624_var*
//#UC END# *4DAEEDE10285_CEE6A63FB624_var*
begin
//#UC START# *4DAEEDE10285_CEE6A63FB624_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CEE6A63FB624_impl*
end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblCaption:push';
end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_edChange.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edChange';
end;//Tkw_CustomizeTasksPanel_Control_edChange.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_edChange.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DE135337B772_var*
//#UC END# *4DDFD2EA0116_DE135337B772_var*
begin
//#UC START# *4DDFD2EA0116_DE135337B772_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DE135337B772_impl*
end;//Tkw_CustomizeTasksPanel_Control_edChange.GetString

class procedure Tkw_CustomizeTasksPanel_Control_edChange.RegisterInEngine;
//#UC START# *52A086150180_DE135337B772_var*
//#UC END# *52A086150180_DE135337B772_var*
begin
//#UC START# *52A086150180_DE135337B772_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DE135337B772_impl*
end;//Tkw_CustomizeTasksPanel_Control_edChange.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_edChange_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52CF08BE1976_var*
//#UC END# *4DAEEDE10285_52CF08BE1976_var*
begin
//#UC START# *4DAEEDE10285_52CF08BE1976_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_52CF08BE1976_impl*
end;//Tkw_CustomizeTasksPanel_Control_edChange_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_edChange_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edChange:push';
end;//Tkw_CustomizeTasksPanel_Control_edChange_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbForAllUseCases';
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A7CD199CCE34_var*
//#UC END# *4DDFD2EA0116_A7CD199CCE34_var*
begin
//#UC START# *4DDFD2EA0116_A7CD199CCE34_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A7CD199CCE34_impl*
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetString

class procedure Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.RegisterInEngine;
//#UC START# *52A086150180_A7CD199CCE34_var*
//#UC END# *52A086150180_A7CD199CCE34_var*
begin
//#UC START# *52A086150180_A7CD199CCE34_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A7CD199CCE34_impl*
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D744CBBE2A67_var*
//#UC END# *4DAEEDE10285_D744CBBE2A67_var*
begin
//#UC START# *4DAEEDE10285_D744CBBE2A67_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D744CBBE2A67_impl*
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbForAllUseCases:push';
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnChangeItem';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_925C508BD888_var*
//#UC END# *4DDFD2EA0116_925C508BD888_var*
begin
//#UC START# *4DDFD2EA0116_925C508BD888_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_925C508BD888_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnChangeItem.RegisterInEngine;
//#UC START# *52A086150180_925C508BD888_var*
//#UC END# *52A086150180_925C508BD888_var*
begin
//#UC START# *52A086150180_925C508BD888_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_925C508BD888_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BC90F088843C_var*
//#UC END# *4DAEEDE10285_BC90F088843C_var*
begin
//#UC START# *4DAEEDE10285_BC90F088843C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BC90F088843C_impl*
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnChangeItem:push';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlOperationPos';
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AECD9C42F36C_var*
//#UC END# *4DDFD2EA0116_AECD9C42F36C_var*
begin
//#UC START# *4DDFD2EA0116_AECD9C42F36C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AECD9C42F36C_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlOperationPos.RegisterInEngine;
//#UC START# *52A086150180_AECD9C42F36C_var*
//#UC END# *52A086150180_AECD9C42F36C_var*
begin
//#UC START# *52A086150180_AECD9C42F36C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AECD9C42F36C_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_921C11567D29_var*
//#UC END# *4DAEEDE10285_921C11567D29_var*
begin
//#UC START# *4DAEEDE10285_921C11567D29_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_921C11567D29_impl*
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlOperationPos:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UpBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D6CAC6CBB1C8_var*
//#UC END# *4DDFD2EA0116_D6CAC6CBB1C8_var*
begin
//#UC START# *4DDFD2EA0116_D6CAC6CBB1C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D6CAC6CBB1C8_impl*
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetString

class procedure Tkw_CustomizeTasksPanel_Control_UpBitBtn.RegisterInEngine;
//#UC START# *52A086150180_D6CAC6CBB1C8_var*
//#UC END# *52A086150180_D6CAC6CBB1C8_var*
begin
//#UC START# *52A086150180_D6CAC6CBB1C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D6CAC6CBB1C8_impl*
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EE8408A13DD_var*
//#UC END# *4DAEEDE10285_4EE8408A13DD_var*
begin
//#UC START# *4DAEEDE10285_4EE8408A13DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4EE8408A13DD_impl*
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UpBitBtn:push';
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.GetWordNameForRegister

class function Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DownBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C6865294790C_var*
//#UC END# *4DDFD2EA0116_C6865294790C_var*
begin
//#UC START# *4DDFD2EA0116_C6865294790C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C6865294790C_impl*
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetString

class procedure Tkw_CustomizeTasksPanel_Control_DownBitBtn.RegisterInEngine;
//#UC START# *52A086150180_C6865294790C_var*
//#UC END# *52A086150180_C6865294790C_var*
begin
//#UC START# *52A086150180_C6865294790C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C6865294790C_impl*
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn.RegisterInEngine

procedure Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DEFE16F7CEDF_var*
//#UC END# *4DAEEDE10285_DEFE16F7CEDF_var*
begin
//#UC START# *4DAEEDE10285_DEFE16F7CEDF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DEFE16F7CEDF_impl*
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DownBitBtn:push';
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.GetWordNameForRegister

function TkwCustomizeTasksPanelFormSpRight.spRight(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.spRight }
//#UC START# *F8EF1D8C47E1_F7EFDD0A0622_var*
//#UC END# *F8EF1D8C47E1_F7EFDD0A0622_var*
begin
//#UC START# *F8EF1D8C47E1_F7EFDD0A0622_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8EF1D8C47E1_F7EFDD0A0622_impl*
end;//TkwCustomizeTasksPanelFormSpRight.spRight

procedure TkwCustomizeTasksPanelFormSpRight.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(spRight(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormSpRight.DoDoIt

class function TkwCustomizeTasksPanelFormSpRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.spRight';
end;//TkwCustomizeTasksPanelFormSpRight.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormSpRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtSplitter(aValue.AsObject(TvtSplitter));
end;//TkwCustomizeTasksPanelFormSpRight.SetValuePrim

function TkwCustomizeTasksPanelFormSpRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSplitter);
end;//TkwCustomizeTasksPanelFormSpRight.GetResultTypeInfo

function TkwCustomizeTasksPanelFormSpRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormSpRight.GetAllParamsCount

function TkwCustomizeTasksPanelFormSpRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormSpRight.ParamsTypes

function TkwCustomizeTasksPanelFormPnlBottom.pnlBottom(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlBottom }
//#UC START# *B525B64C372C_30A77B945B54_var*
//#UC END# *B525B64C372C_30A77B945B54_var*
begin
//#UC START# *B525B64C372C_30A77B945B54_impl*
 !!! Needs to be implemented !!!
//#UC END# *B525B64C372C_30A77B945B54_impl*
end;//TkwCustomizeTasksPanelFormPnlBottom.pnlBottom

procedure TkwCustomizeTasksPanelFormPnlBottom.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBottom(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlBottom.DoDoIt

class function TkwCustomizeTasksPanelFormPnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlBottom';
end;//TkwCustomizeTasksPanelFormPnlBottom.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlBottom.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwCustomizeTasksPanelFormPnlBottom.SetValuePrim

function TkwCustomizeTasksPanelFormPnlBottom.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlBottom.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlBottom.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormPnlBottom.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlBottom.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlBottom.ParamsTypes

function TkwCustomizeTasksPanelFormLblConfirmSave.lblConfirmSave(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblConfirmSave }
//#UC START# *101BB4FFB581_830FC77EF285_var*
//#UC END# *101BB4FFB581_830FC77EF285_var*
begin
//#UC START# *101BB4FFB581_830FC77EF285_impl*
 !!! Needs to be implemented !!!
//#UC END# *101BB4FFB581_830FC77EF285_impl*
end;//TkwCustomizeTasksPanelFormLblConfirmSave.lblConfirmSave

procedure TkwCustomizeTasksPanelFormLblConfirmSave.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblConfirmSave(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormLblConfirmSave.DoDoIt

class function TkwCustomizeTasksPanelFormLblConfirmSave.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblConfirmSave';
end;//TkwCustomizeTasksPanelFormLblConfirmSave.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormLblConfirmSave.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtLabel(aValue.AsObject(TvtLabel));
end;//TkwCustomizeTasksPanelFormLblConfirmSave.SetValuePrim

function TkwCustomizeTasksPanelFormLblConfirmSave.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCustomizeTasksPanelFormLblConfirmSave.GetResultTypeInfo

function TkwCustomizeTasksPanelFormLblConfirmSave.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormLblConfirmSave.GetAllParamsCount

function TkwCustomizeTasksPanelFormLblConfirmSave.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormLblConfirmSave.ParamsTypes

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.lblAvailableOpsCaption(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
//#UC START# *56BBC284669F_C6FF95C2A3CB_var*
//#UC END# *56BBC284669F_C6FF95C2A3CB_var*
begin
//#UC START# *56BBC284669F_C6FF95C2A3CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *56BBC284669F_C6FF95C2A3CB_impl*
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.lblAvailableOpsCaption

procedure TkwCustomizeTasksPanelFormLblAvailableOpsCaption.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblAvailableOpsCaption(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.DoDoIt

class function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblAvailableOpsCaption';
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormLblAvailableOpsCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtLabel(aValue.AsObject(TvtLabel));
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.SetValuePrim

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetResultTypeInfo

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetAllParamsCount

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.ParamsTypes

function TkwCustomizeTasksPanelFormBtOk.btOk(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btOk }
//#UC START# *963469F9ED47_F707F1CC5E90_var*
//#UC END# *963469F9ED47_F707F1CC5E90_var*
begin
//#UC START# *963469F9ED47_F707F1CC5E90_impl*
 !!! Needs to be implemented !!!
//#UC END# *963469F9ED47_F707F1CC5E90_impl*
end;//TkwCustomizeTasksPanelFormBtOk.btOk

procedure TkwCustomizeTasksPanelFormBtOk.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btOk(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtOk.DoDoIt

class function TkwCustomizeTasksPanelFormBtOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btOk';
end;//TkwCustomizeTasksPanelFormBtOk.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtButton(aValue.AsObject(TvtButton));
end;//TkwCustomizeTasksPanelFormBtOk.SetValuePrim

function TkwCustomizeTasksPanelFormBtOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwCustomizeTasksPanelFormBtOk.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtOk.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtOk.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtOk.ParamsTypes

function TkwCustomizeTasksPanelFormBtCancel.btCancel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btCancel }
//#UC START# *F82ED2A12D75_8EDCD0E495D1_var*
//#UC END# *F82ED2A12D75_8EDCD0E495D1_var*
begin
//#UC START# *F82ED2A12D75_8EDCD0E495D1_impl*
 !!! Needs to be implemented !!!
//#UC END# *F82ED2A12D75_8EDCD0E495D1_impl*
end;//TkwCustomizeTasksPanelFormBtCancel.btCancel

procedure TkwCustomizeTasksPanelFormBtCancel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btCancel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtCancel.DoDoIt

class function TkwCustomizeTasksPanelFormBtCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btCancel';
end;//TkwCustomizeTasksPanelFormBtCancel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtCancel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtButton(aValue.AsObject(TvtButton));
end;//TkwCustomizeTasksPanelFormBtCancel.SetValuePrim

function TkwCustomizeTasksPanelFormBtCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwCustomizeTasksPanelFormBtCancel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtCancel.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtCancel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtCancel.ParamsTypes

function TkwCustomizeTasksPanelFormBtApply.btApply(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btApply }
//#UC START# *0FAEB495CD10_BDD28480233F_var*
//#UC END# *0FAEB495CD10_BDD28480233F_var*
begin
//#UC START# *0FAEB495CD10_BDD28480233F_impl*
 !!! Needs to be implemented !!!
//#UC END# *0FAEB495CD10_BDD28480233F_impl*
end;//TkwCustomizeTasksPanelFormBtApply.btApply

procedure TkwCustomizeTasksPanelFormBtApply.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btApply(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtApply.DoDoIt

class function TkwCustomizeTasksPanelFormBtApply.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btApply';
end;//TkwCustomizeTasksPanelFormBtApply.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtApply.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtButton(aValue.AsObject(TvtButton));
end;//TkwCustomizeTasksPanelFormBtApply.SetValuePrim

function TkwCustomizeTasksPanelFormBtApply.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwCustomizeTasksPanelFormBtApply.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtApply.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtApply.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtApply.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtApply.ParamsTypes

function TkwCustomizeTasksPanelFormPnlRep.pnlRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlRep }
//#UC START# *2B9C9A020B52_3A63DD696AA2_var*
//#UC END# *2B9C9A020B52_3A63DD696AA2_var*
begin
//#UC START# *2B9C9A020B52_3A63DD696AA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *2B9C9A020B52_3A63DD696AA2_impl*
end;//TkwCustomizeTasksPanelFormPnlRep.pnlRep

procedure TkwCustomizeTasksPanelFormPnlRep.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlRep(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlRep.DoDoIt

class function TkwCustomizeTasksPanelFormPnlRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlRep';
end;//TkwCustomizeTasksPanelFormPnlRep.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwCustomizeTasksPanelFormPnlRep.SetValuePrim

function TkwCustomizeTasksPanelFormPnlRep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlRep.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlRep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormPnlRep.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlRep.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlRep.ParamsTypes

function TkwCustomizeTasksPanelFormSplRep.splRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.splRep }
//#UC START# *0778C7EBD61D_32B42EEEDDA8_var*
//#UC END# *0778C7EBD61D_32B42EEEDDA8_var*
begin
//#UC START# *0778C7EBD61D_32B42EEEDDA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *0778C7EBD61D_32B42EEEDDA8_impl*
end;//TkwCustomizeTasksPanelFormSplRep.splRep

procedure TkwCustomizeTasksPanelFormSplRep.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(splRep(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormSplRep.DoDoIt

class function TkwCustomizeTasksPanelFormSplRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.splRep';
end;//TkwCustomizeTasksPanelFormSplRep.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormSplRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtSplitter(aValue.AsObject(TvtSplitter));
end;//TkwCustomizeTasksPanelFormSplRep.SetValuePrim

function TkwCustomizeTasksPanelFormSplRep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSplitter);
end;//TkwCustomizeTasksPanelFormSplRep.GetResultTypeInfo

function TkwCustomizeTasksPanelFormSplRep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormSplRep.GetAllParamsCount

function TkwCustomizeTasksPanelFormSplRep.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormSplRep.ParamsTypes

function TkwCustomizeTasksPanelFormGbAvailableGroups.gbAvailableGroups(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableGroups }
//#UC START# *7849EC9857DE_69860393305E_var*
//#UC END# *7849EC9857DE_69860393305E_var*
begin
//#UC START# *7849EC9857DE_69860393305E_impl*
 !!! Needs to be implemented !!!
//#UC END# *7849EC9857DE_69860393305E_impl*
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.gbAvailableGroups

procedure TkwCustomizeTasksPanelFormGbAvailableGroups.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(gbAvailableGroups(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.DoDoIt

class function TkwCustomizeTasksPanelFormGbAvailableGroups.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.gbAvailableGroups';
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormGbAvailableGroups.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtGroupBox(aValue.AsObject(TvtGroupBox));
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.SetValuePrim

function TkwCustomizeTasksPanelFormGbAvailableGroups.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.GetResultTypeInfo

function TkwCustomizeTasksPanelFormGbAvailableGroups.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.GetAllParamsCount

function TkwCustomizeTasksPanelFormGbAvailableGroups.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.ParamsTypes

function TkwCustomizeTasksPanelFormTvRepGroups.tvRepGroups(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepGroups }
//#UC START# *049D2B14E7DB_986ABA2A8C16_var*
//#UC END# *049D2B14E7DB_986ABA2A8C16_var*
begin
//#UC START# *049D2B14E7DB_986ABA2A8C16_impl*
 !!! Needs to be implemented !!!
//#UC END# *049D2B14E7DB_986ABA2A8C16_impl*
end;//TkwCustomizeTasksPanelFormTvRepGroups.tvRepGroups

procedure TkwCustomizeTasksPanelFormTvRepGroups.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvRepGroups(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormTvRepGroups.DoDoIt

class function TkwCustomizeTasksPanelFormTvRepGroups.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.tvRepGroups';
end;//TkwCustomizeTasksPanelFormTvRepGroups.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormTvRepGroups.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TeeTreeView(aValue.AsObject(TeeTreeView));
end;//TkwCustomizeTasksPanelFormTvRepGroups.SetValuePrim

function TkwCustomizeTasksPanelFormTvRepGroups.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwCustomizeTasksPanelFormTvRepGroups.GetResultTypeInfo

function TkwCustomizeTasksPanelFormTvRepGroups.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormTvRepGroups.GetAllParamsCount

function TkwCustomizeTasksPanelFormTvRepGroups.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormTvRepGroups.ParamsTypes

function TkwCustomizeTasksPanelFormVtPanel1.vtPanel1(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtPanel1 }
//#UC START# *05A2E42CBD88_30C7717A0A01_var*
//#UC END# *05A2E42CBD88_30C7717A0A01_var*
begin
//#UC START# *05A2E42CBD88_30C7717A0A01_impl*
 !!! Needs to be implemented !!!
//#UC END# *05A2E42CBD88_30C7717A0A01_impl*
end;//TkwCustomizeTasksPanelFormVtPanel1.vtPanel1

procedure TkwCustomizeTasksPanelFormVtPanel1.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtPanel1(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormVtPanel1.DoDoIt

class function TkwCustomizeTasksPanelFormVtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.vtPanel1';
end;//TkwCustomizeTasksPanelFormVtPanel1.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormVtPanel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwCustomizeTasksPanelFormVtPanel1.SetValuePrim

function TkwCustomizeTasksPanelFormVtPanel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormVtPanel1.GetResultTypeInfo

function TkwCustomizeTasksPanelFormVtPanel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormVtPanel1.GetAllParamsCount

function TkwCustomizeTasksPanelFormVtPanel1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormVtPanel1.ParamsTypes

function TkwCustomizeTasksPanelFormCbGroupName.cbGroupName(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbGroupName }
//#UC START# *2944F6A3A9E8_9949328605B2_var*
//#UC END# *2944F6A3A9E8_9949328605B2_var*
begin
//#UC START# *2944F6A3A9E8_9949328605B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *2944F6A3A9E8_9949328605B2_impl*
end;//TkwCustomizeTasksPanelFormCbGroupName.cbGroupName

procedure TkwCustomizeTasksPanelFormCbGroupName.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbGroupName(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormCbGroupName.DoDoIt

class function TkwCustomizeTasksPanelFormCbGroupName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.cbGroupName';
end;//TkwCustomizeTasksPanelFormCbGroupName.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormCbGroupName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtComboBox(aValue.AsObject(TvtComboBox));
end;//TkwCustomizeTasksPanelFormCbGroupName.SetValuePrim

function TkwCustomizeTasksPanelFormCbGroupName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBox);
end;//TkwCustomizeTasksPanelFormCbGroupName.GetResultTypeInfo

function TkwCustomizeTasksPanelFormCbGroupName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormCbGroupName.GetAllParamsCount

function TkwCustomizeTasksPanelFormCbGroupName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormCbGroupName.ParamsTypes

function TkwCustomizeTasksPanelFormBtnAddGroup.btnAddGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnAddGroup }
//#UC START# *4187D02CC0AF_C2C53273FCEF_var*
//#UC END# *4187D02CC0AF_C2C53273FCEF_var*
begin
//#UC START# *4187D02CC0AF_C2C53273FCEF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4187D02CC0AF_C2C53273FCEF_impl*
end;//TkwCustomizeTasksPanelFormBtnAddGroup.btnAddGroup

procedure TkwCustomizeTasksPanelFormBtnAddGroup.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnAddGroup(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnAddGroup.DoDoIt

class function TkwCustomizeTasksPanelFormBtnAddGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnAddGroup';
end;//TkwCustomizeTasksPanelFormBtnAddGroup.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnAddGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TeeButton(aValue.AsObject(TeeButton));
end;//TkwCustomizeTasksPanelFormBtnAddGroup.SetValuePrim

function TkwCustomizeTasksPanelFormBtnAddGroup.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeButton);
end;//TkwCustomizeTasksPanelFormBtnAddGroup.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnAddGroup.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtnAddGroup.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnAddGroup.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnAddGroup.ParamsTypes

function TkwCustomizeTasksPanelFormBtnChangeGroup.btnChangeGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeGroup }
//#UC START# *61A3DF6A81BB_10B158D87985_var*
//#UC END# *61A3DF6A81BB_10B158D87985_var*
begin
//#UC START# *61A3DF6A81BB_10B158D87985_impl*
 !!! Needs to be implemented !!!
//#UC END# *61A3DF6A81BB_10B158D87985_impl*
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.btnChangeGroup

procedure TkwCustomizeTasksPanelFormBtnChangeGroup.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnChangeGroup(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.DoDoIt

class function TkwCustomizeTasksPanelFormBtnChangeGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnChangeGroup';
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnChangeGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TeeButton(aValue.AsObject(TeeButton));
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.SetValuePrim

function TkwCustomizeTasksPanelFormBtnChangeGroup.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeButton);
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnChangeGroup.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnChangeGroup.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.ParamsTypes

function TkwCustomizeTasksPanelFormBtnDeleteGroup.btnDeleteGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnDeleteGroup }
//#UC START# *2348EB229156_96E949C9C123_var*
//#UC END# *2348EB229156_96E949C9C123_var*
begin
//#UC START# *2348EB229156_96E949C9C123_impl*
 !!! Needs to be implemented !!!
//#UC END# *2348EB229156_96E949C9C123_impl*
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.btnDeleteGroup

procedure TkwCustomizeTasksPanelFormBtnDeleteGroup.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnDeleteGroup(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.DoDoIt

class function TkwCustomizeTasksPanelFormBtnDeleteGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnDeleteGroup';
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnDeleteGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TeeButton(aValue.AsObject(TeeButton));
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.SetValuePrim

function TkwCustomizeTasksPanelFormBtnDeleteGroup.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeButton);
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnDeleteGroup.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnDeleteGroup.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.ParamsTypes

function TkwCustomizeTasksPanelFormGbAvailableOperations.gbAvailableOperations(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableOperations }
//#UC START# *BA118C4BFD3F_6FC654DB8656_var*
//#UC END# *BA118C4BFD3F_6FC654DB8656_var*
begin
//#UC START# *BA118C4BFD3F_6FC654DB8656_impl*
 !!! Needs to be implemented !!!
//#UC END# *BA118C4BFD3F_6FC654DB8656_impl*
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.gbAvailableOperations

procedure TkwCustomizeTasksPanelFormGbAvailableOperations.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(gbAvailableOperations(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.DoDoIt

class function TkwCustomizeTasksPanelFormGbAvailableOperations.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.gbAvailableOperations';
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormGbAvailableOperations.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtGroupBox(aValue.AsObject(TvtGroupBox));
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.SetValuePrim

function TkwCustomizeTasksPanelFormGbAvailableOperations.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.GetResultTypeInfo

function TkwCustomizeTasksPanelFormGbAvailableOperations.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.GetAllParamsCount

function TkwCustomizeTasksPanelFormGbAvailableOperations.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.ParamsTypes

function TkwCustomizeTasksPanelFormTvRepOps.tvRepOps(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepOps }
//#UC START# *C4553536591D_A38BA9C74BE4_var*
//#UC END# *C4553536591D_A38BA9C74BE4_var*
begin
//#UC START# *C4553536591D_A38BA9C74BE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *C4553536591D_A38BA9C74BE4_impl*
end;//TkwCustomizeTasksPanelFormTvRepOps.tvRepOps

procedure TkwCustomizeTasksPanelFormTvRepOps.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvRepOps(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormTvRepOps.DoDoIt

class function TkwCustomizeTasksPanelFormTvRepOps.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.tvRepOps';
end;//TkwCustomizeTasksPanelFormTvRepOps.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormTvRepOps.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TeeTreeView(aValue.AsObject(TeeTreeView));
end;//TkwCustomizeTasksPanelFormTvRepOps.SetValuePrim

function TkwCustomizeTasksPanelFormTvRepOps.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwCustomizeTasksPanelFormTvRepOps.GetResultTypeInfo

function TkwCustomizeTasksPanelFormTvRepOps.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormTvRepOps.GetAllParamsCount

function TkwCustomizeTasksPanelFormTvRepOps.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormTvRepOps.ParamsTypes

function TkwCustomizeTasksPanelFormPnlForms.pnlForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlForms }
//#UC START# *573334FE0B26_98A522EB9B72_var*
//#UC END# *573334FE0B26_98A522EB9B72_var*
begin
//#UC START# *573334FE0B26_98A522EB9B72_impl*
 !!! Needs to be implemented !!!
//#UC END# *573334FE0B26_98A522EB9B72_impl*
end;//TkwCustomizeTasksPanelFormPnlForms.pnlForms

procedure TkwCustomizeTasksPanelFormPnlForms.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlForms(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlForms.DoDoIt

class function TkwCustomizeTasksPanelFormPnlForms.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlForms';
end;//TkwCustomizeTasksPanelFormPnlForms.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlForms.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwCustomizeTasksPanelFormPnlForms.SetValuePrim

function TkwCustomizeTasksPanelFormPnlForms.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlForms.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlForms.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormPnlForms.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlForms.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlForms.ParamsTypes

function TkwCustomizeTasksPanelFormLblForms.lblForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblForms }
//#UC START# *EFAA2299FADA_7897D9940B95_var*
//#UC END# *EFAA2299FADA_7897D9940B95_var*
begin
//#UC START# *EFAA2299FADA_7897D9940B95_impl*
 !!! Needs to be implemented !!!
//#UC END# *EFAA2299FADA_7897D9940B95_impl*
end;//TkwCustomizeTasksPanelFormLblForms.lblForms

procedure TkwCustomizeTasksPanelFormLblForms.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblForms(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormLblForms.DoDoIt

class function TkwCustomizeTasksPanelFormLblForms.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblForms';
end;//TkwCustomizeTasksPanelFormLblForms.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormLblForms.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtLabel(aValue.AsObject(TvtLabel));
end;//TkwCustomizeTasksPanelFormLblForms.SetValuePrim

function TkwCustomizeTasksPanelFormLblForms.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCustomizeTasksPanelFormLblForms.GetResultTypeInfo

function TkwCustomizeTasksPanelFormLblForms.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormLblForms.GetAllParamsCount

function TkwCustomizeTasksPanelFormLblForms.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormLblForms.ParamsTypes

function TkwCustomizeTasksPanelFormCbForms.cbForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForms }
//#UC START# *54E784B5E79A_1A3E1FD39C35_var*
//#UC END# *54E784B5E79A_1A3E1FD39C35_var*
begin
//#UC START# *54E784B5E79A_1A3E1FD39C35_impl*
 !!! Needs to be implemented !!!
//#UC END# *54E784B5E79A_1A3E1FD39C35_impl*
end;//TkwCustomizeTasksPanelFormCbForms.cbForms

procedure TkwCustomizeTasksPanelFormCbForms.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbForms(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormCbForms.DoDoIt

class function TkwCustomizeTasksPanelFormCbForms.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.cbForms';
end;//TkwCustomizeTasksPanelFormCbForms.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormCbForms.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TComboBox(aValue.AsObject(TComboBox));
end;//TkwCustomizeTasksPanelFormCbForms.SetValuePrim

function TkwCustomizeTasksPanelFormCbForms.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TComboBox);
end;//TkwCustomizeTasksPanelFormCbForms.GetResultTypeInfo

function TkwCustomizeTasksPanelFormCbForms.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormCbForms.GetAllParamsCount

function TkwCustomizeTasksPanelFormCbForms.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormCbForms.ParamsTypes

function TkwCustomizeTasksPanelFormPnlMain.pnlMain(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlMain }
//#UC START# *E19E77C670D0_0C210ABBA2B3_var*
//#UC END# *E19E77C670D0_0C210ABBA2B3_var*
begin
//#UC START# *E19E77C670D0_0C210ABBA2B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *E19E77C670D0_0C210ABBA2B3_impl*
end;//TkwCustomizeTasksPanelFormPnlMain.pnlMain

procedure TkwCustomizeTasksPanelFormPnlMain.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlMain(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlMain.DoDoIt

class function TkwCustomizeTasksPanelFormPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlMain';
end;//TkwCustomizeTasksPanelFormPnlMain.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwCustomizeTasksPanelFormPnlMain.SetValuePrim

function TkwCustomizeTasksPanelFormPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlMain.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormPnlMain.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlMain.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlMain.ParamsTypes

function TkwCustomizeTasksPanelFormPnlLeft.pnlLeft(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlLeft }
//#UC START# *E6D46C32FCBF_7437A67D8F04_var*
//#UC END# *E6D46C32FCBF_7437A67D8F04_var*
begin
//#UC START# *E6D46C32FCBF_7437A67D8F04_impl*
 !!! Needs to be implemented !!!
//#UC END# *E6D46C32FCBF_7437A67D8F04_impl*
end;//TkwCustomizeTasksPanelFormPnlLeft.pnlLeft

procedure TkwCustomizeTasksPanelFormPnlLeft.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLeft(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlLeft.DoDoIt

class function TkwCustomizeTasksPanelFormPnlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlLeft';
end;//TkwCustomizeTasksPanelFormPnlLeft.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwCustomizeTasksPanelFormPnlLeft.SetValuePrim

function TkwCustomizeTasksPanelFormPnlLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlLeft.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormPnlLeft.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlLeft.ParamsTypes

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.btnMoveOpToPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToPanel }
//#UC START# *403FFE17BE81_18FC0FBEC908_var*
//#UC END# *403FFE17BE81_18FC0FBEC908_var*
begin
//#UC START# *403FFE17BE81_18FC0FBEC908_impl*
 !!! Needs to be implemented !!!
//#UC END# *403FFE17BE81_18FC0FBEC908_impl*
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.btnMoveOpToPanel

procedure TkwCustomizeTasksPanelFormBtnMoveOpToPanel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnMoveOpToPanel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.DoDoIt

class function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveOpToPanel';
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnMoveOpToPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TBitBtn(aValue.AsObject(TBitBtn));
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.SetValuePrim

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.ParamsTypes

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.btnMoveOpToRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToRep }
//#UC START# *845AB7670E2D_43465A2C4EA5_var*
//#UC END# *845AB7670E2D_43465A2C4EA5_var*
begin
//#UC START# *845AB7670E2D_43465A2C4EA5_impl*
 !!! Needs to be implemented !!!
//#UC END# *845AB7670E2D_43465A2C4EA5_impl*
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.btnMoveOpToRep

procedure TkwCustomizeTasksPanelFormBtnMoveOpToRep.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnMoveOpToRep(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.DoDoIt

class function TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveOpToRep';
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnMoveOpToRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TBitBtn(aValue.AsObject(TBitBtn));
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.SetValuePrim

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.ParamsTypes

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.btnMoveGroupToPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
//#UC START# *8271FA8C8558_AFBC0E97D4D0_var*
//#UC END# *8271FA8C8558_AFBC0E97D4D0_var*
begin
//#UC START# *8271FA8C8558_AFBC0E97D4D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *8271FA8C8558_AFBC0E97D4D0_impl*
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.btnMoveGroupToPanel

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnMoveGroupToPanel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.DoDoIt

class function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveGroupToPanel';
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TBitBtn(aValue.AsObject(TBitBtn));
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.SetValuePrim

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.ParamsTypes

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.btnMoveGroupToRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToRep }
//#UC START# *70259125B502_EF74613C5669_var*
//#UC END# *70259125B502_EF74613C5669_var*
begin
//#UC START# *70259125B502_EF74613C5669_impl*
 !!! Needs to be implemented !!!
//#UC END# *70259125B502_EF74613C5669_impl*
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.btnMoveGroupToRep

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToRep.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnMoveGroupToRep(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.DoDoIt

class function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveGroupToRep';
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TBitBtn(aValue.AsObject(TBitBtn));
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.SetValuePrim

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.ParamsTypes

function TkwCustomizeTasksPanelFormPnlTasksPanel.pnlTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlTasksPanel }
//#UC START# *B316BD720299_D7EB4AB84AE4_var*
//#UC END# *B316BD720299_D7EB4AB84AE4_var*
begin
//#UC START# *B316BD720299_D7EB4AB84AE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *B316BD720299_D7EB4AB84AE4_impl*
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.pnlTasksPanel

procedure TkwCustomizeTasksPanelFormPnlTasksPanel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlTasksPanel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.DoDoIt

class function TkwCustomizeTasksPanelFormPnlTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlTasksPanel';
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.SetValuePrim

function TkwCustomizeTasksPanelFormPnlTasksPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlTasksPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlTasksPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.ParamsTypes

function TkwCustomizeTasksPanelFormGbTasksPanel.gbTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbTasksPanel }
//#UC START# *81AAED10AC89_8CF041C165C6_var*
//#UC END# *81AAED10AC89_8CF041C165C6_var*
begin
//#UC START# *81AAED10AC89_8CF041C165C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *81AAED10AC89_8CF041C165C6_impl*
end;//TkwCustomizeTasksPanelFormGbTasksPanel.gbTasksPanel

procedure TkwCustomizeTasksPanelFormGbTasksPanel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(gbTasksPanel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormGbTasksPanel.DoDoIt

class function TkwCustomizeTasksPanelFormGbTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.gbTasksPanel';
end;//TkwCustomizeTasksPanelFormGbTasksPanel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormGbTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtGroupBox(aValue.AsObject(TvtGroupBox));
end;//TkwCustomizeTasksPanelFormGbTasksPanel.SetValuePrim

function TkwCustomizeTasksPanelFormGbTasksPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwCustomizeTasksPanelFormGbTasksPanel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormGbTasksPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormGbTasksPanel.GetAllParamsCount

function TkwCustomizeTasksPanelFormGbTasksPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormGbTasksPanel.ParamsTypes

function TkwCustomizeTasksPanelFormTvTasksPanel.tvTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvTasksPanel }
//#UC START# *05D5F8C2935F_8B03628B7726_var*
//#UC END# *05D5F8C2935F_8B03628B7726_var*
begin
//#UC START# *05D5F8C2935F_8B03628B7726_impl*
 !!! Needs to be implemented !!!
//#UC END# *05D5F8C2935F_8B03628B7726_impl*
end;//TkwCustomizeTasksPanelFormTvTasksPanel.tvTasksPanel

procedure TkwCustomizeTasksPanelFormTvTasksPanel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvTasksPanel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormTvTasksPanel.DoDoIt

class function TkwCustomizeTasksPanelFormTvTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.tvTasksPanel';
end;//TkwCustomizeTasksPanelFormTvTasksPanel.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormTvTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TeeTreeView(aValue.AsObject(TeeTreeView));
end;//TkwCustomizeTasksPanelFormTvTasksPanel.SetValuePrim

function TkwCustomizeTasksPanelFormTvTasksPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwCustomizeTasksPanelFormTvTasksPanel.GetResultTypeInfo

function TkwCustomizeTasksPanelFormTvTasksPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormTvTasksPanel.GetAllParamsCount

function TkwCustomizeTasksPanelFormTvTasksPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormTvTasksPanel.ParamsTypes

function TkwCustomizeTasksPanelFormVtGroupBox3.vtGroupBox3(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtGroupBox3 }
//#UC START# *EEB96B111A6E_6980CE14D559_var*
//#UC END# *EEB96B111A6E_6980CE14D559_var*
begin
//#UC START# *EEB96B111A6E_6980CE14D559_impl*
 !!! Needs to be implemented !!!
//#UC END# *EEB96B111A6E_6980CE14D559_impl*
end;//TkwCustomizeTasksPanelFormVtGroupBox3.vtGroupBox3

procedure TkwCustomizeTasksPanelFormVtGroupBox3.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtGroupBox3(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormVtGroupBox3.DoDoIt

class function TkwCustomizeTasksPanelFormVtGroupBox3.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.vtGroupBox3';
end;//TkwCustomizeTasksPanelFormVtGroupBox3.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormVtGroupBox3.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtGroupBox(aValue.AsObject(TvtGroupBox));
end;//TkwCustomizeTasksPanelFormVtGroupBox3.SetValuePrim

function TkwCustomizeTasksPanelFormVtGroupBox3.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwCustomizeTasksPanelFormVtGroupBox3.GetResultTypeInfo

function TkwCustomizeTasksPanelFormVtGroupBox3.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormVtGroupBox3.GetAllParamsCount

function TkwCustomizeTasksPanelFormVtGroupBox3.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormVtGroupBox3.ParamsTypes

function TkwCustomizeTasksPanelFormLblCaption.lblCaption(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblCaption }
//#UC START# *E00A094D4D36_602A6F187FAB_var*
//#UC END# *E00A094D4D36_602A6F187FAB_var*
begin
//#UC START# *E00A094D4D36_602A6F187FAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *E00A094D4D36_602A6F187FAB_impl*
end;//TkwCustomizeTasksPanelFormLblCaption.lblCaption

procedure TkwCustomizeTasksPanelFormLblCaption.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblCaption(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormLblCaption.DoDoIt

class function TkwCustomizeTasksPanelFormLblCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblCaption';
end;//TkwCustomizeTasksPanelFormLblCaption.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormLblCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtLabel(aValue.AsObject(TvtLabel));
end;//TkwCustomizeTasksPanelFormLblCaption.SetValuePrim

function TkwCustomizeTasksPanelFormLblCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCustomizeTasksPanelFormLblCaption.GetResultTypeInfo

function TkwCustomizeTasksPanelFormLblCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormLblCaption.GetAllParamsCount

function TkwCustomizeTasksPanelFormLblCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormLblCaption.ParamsTypes

function TkwCustomizeTasksPanelFormEdChange.edChange(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.edChange }
//#UC START# *7D441EBBAFA3_1C9E311E45DD_var*
//#UC END# *7D441EBBAFA3_1C9E311E45DD_var*
begin
//#UC START# *7D441EBBAFA3_1C9E311E45DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *7D441EBBAFA3_1C9E311E45DD_impl*
end;//TkwCustomizeTasksPanelFormEdChange.edChange

procedure TkwCustomizeTasksPanelFormEdChange.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edChange(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormEdChange.DoDoIt

class function TkwCustomizeTasksPanelFormEdChange.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.edChange';
end;//TkwCustomizeTasksPanelFormEdChange.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormEdChange.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtComboBox(aValue.AsObject(TvtComboBox));
end;//TkwCustomizeTasksPanelFormEdChange.SetValuePrim

function TkwCustomizeTasksPanelFormEdChange.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBox);
end;//TkwCustomizeTasksPanelFormEdChange.GetResultTypeInfo

function TkwCustomizeTasksPanelFormEdChange.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormEdChange.GetAllParamsCount

function TkwCustomizeTasksPanelFormEdChange.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormEdChange.ParamsTypes

function TkwCustomizeTasksPanelFormCbForAllUseCases.cbForAllUseCases(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForAllUseCases }
//#UC START# *3C15A5A81A25_D09D41A6B747_var*
//#UC END# *3C15A5A81A25_D09D41A6B747_var*
begin
//#UC START# *3C15A5A81A25_D09D41A6B747_impl*
 !!! Needs to be implemented !!!
//#UC END# *3C15A5A81A25_D09D41A6B747_impl*
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.cbForAllUseCases

procedure TkwCustomizeTasksPanelFormCbForAllUseCases.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbForAllUseCases(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.DoDoIt

class function TkwCustomizeTasksPanelFormCbForAllUseCases.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.cbForAllUseCases';
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormCbForAllUseCases.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TeeCheckBox(aValue.AsObject(TeeCheckBox));
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.SetValuePrim

function TkwCustomizeTasksPanelFormCbForAllUseCases.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeCheckBox);
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.GetResultTypeInfo

function TkwCustomizeTasksPanelFormCbForAllUseCases.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.GetAllParamsCount

function TkwCustomizeTasksPanelFormCbForAllUseCases.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.ParamsTypes

function TkwCustomizeTasksPanelFormBtnChangeItem.btnChangeItem(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeItem }
//#UC START# *E2ACF687299F_EC814F34DB5A_var*
//#UC END# *E2ACF687299F_EC814F34DB5A_var*
begin
//#UC START# *E2ACF687299F_EC814F34DB5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *E2ACF687299F_EC814F34DB5A_impl*
end;//TkwCustomizeTasksPanelFormBtnChangeItem.btnChangeItem

procedure TkwCustomizeTasksPanelFormBtnChangeItem.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnChangeItem(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnChangeItem.DoDoIt

class function TkwCustomizeTasksPanelFormBtnChangeItem.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnChangeItem';
end;//TkwCustomizeTasksPanelFormBtnChangeItem.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormBtnChangeItem.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TeeButton(aValue.AsObject(TeeButton));
end;//TkwCustomizeTasksPanelFormBtnChangeItem.SetValuePrim

function TkwCustomizeTasksPanelFormBtnChangeItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeButton);
end;//TkwCustomizeTasksPanelFormBtnChangeItem.GetResultTypeInfo

function TkwCustomizeTasksPanelFormBtnChangeItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormBtnChangeItem.GetAllParamsCount

function TkwCustomizeTasksPanelFormBtnChangeItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormBtnChangeItem.ParamsTypes

function TkwCustomizeTasksPanelFormPnlOperationPos.pnlOperationPos(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlOperationPos }
//#UC START# *CFAF11C0D5A2_D2DE7F6F9FC5_var*
//#UC END# *CFAF11C0D5A2_D2DE7F6F9FC5_var*
begin
//#UC START# *CFAF11C0D5A2_D2DE7F6F9FC5_impl*
 !!! Needs to be implemented !!!
//#UC END# *CFAF11C0D5A2_D2DE7F6F9FC5_impl*
end;//TkwCustomizeTasksPanelFormPnlOperationPos.pnlOperationPos

procedure TkwCustomizeTasksPanelFormPnlOperationPos.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlOperationPos(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlOperationPos.DoDoIt

class function TkwCustomizeTasksPanelFormPnlOperationPos.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlOperationPos';
end;//TkwCustomizeTasksPanelFormPnlOperationPos.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormPnlOperationPos.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TvtPanel(aValue.AsObject(TvtPanel));
end;//TkwCustomizeTasksPanelFormPnlOperationPos.SetValuePrim

function TkwCustomizeTasksPanelFormPnlOperationPos.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCustomizeTasksPanelFormPnlOperationPos.GetResultTypeInfo

function TkwCustomizeTasksPanelFormPnlOperationPos.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormPnlOperationPos.GetAllParamsCount

function TkwCustomizeTasksPanelFormPnlOperationPos.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormPnlOperationPos.ParamsTypes

function TkwCustomizeTasksPanelFormUpBitBtn.UpBitBtn(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.UpBitBtn }
//#UC START# *4FAE5140B75E_E1CA9B7A6AB2_var*
//#UC END# *4FAE5140B75E_E1CA9B7A6AB2_var*
begin
//#UC START# *4FAE5140B75E_E1CA9B7A6AB2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FAE5140B75E_E1CA9B7A6AB2_impl*
end;//TkwCustomizeTasksPanelFormUpBitBtn.UpBitBtn

procedure TkwCustomizeTasksPanelFormUpBitBtn.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UpBitBtn(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormUpBitBtn.DoDoIt

class function TkwCustomizeTasksPanelFormUpBitBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.UpBitBtn';
end;//TkwCustomizeTasksPanelFormUpBitBtn.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormUpBitBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TBitBtn(aValue.AsObject(TBitBtn));
end;//TkwCustomizeTasksPanelFormUpBitBtn.SetValuePrim

function TkwCustomizeTasksPanelFormUpBitBtn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormUpBitBtn.GetResultTypeInfo

function TkwCustomizeTasksPanelFormUpBitBtn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormUpBitBtn.GetAllParamsCount

function TkwCustomizeTasksPanelFormUpBitBtn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormUpBitBtn.ParamsTypes

function TkwCustomizeTasksPanelFormDownBitBtn.DownBitBtn(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.DownBitBtn }
//#UC START# *D32924A2F222_0A40E3797513_var*
//#UC END# *D32924A2F222_0A40E3797513_var*
begin
//#UC START# *D32924A2F222_0A40E3797513_impl*
 !!! Needs to be implemented !!!
//#UC END# *D32924A2F222_0A40E3797513_impl*
end;//TkwCustomizeTasksPanelFormDownBitBtn.DownBitBtn

procedure TkwCustomizeTasksPanelFormDownBitBtn.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DownBitBtn(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormDownBitBtn.DoDoIt

class function TkwCustomizeTasksPanelFormDownBitBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.DownBitBtn';
end;//TkwCustomizeTasksPanelFormDownBitBtn.GetWordNameForRegister

procedure TkwCustomizeTasksPanelFormDownBitBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_CustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_CustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� CustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CustomizeTasksPanelForm. := TBitBtn(aValue.AsObject(TBitBtn));
end;//TkwCustomizeTasksPanelFormDownBitBtn.SetValuePrim

function TkwCustomizeTasksPanelFormDownBitBtn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TBitBtn);
end;//TkwCustomizeTasksPanelFormDownBitBtn.GetResultTypeInfo

function TkwCustomizeTasksPanelFormDownBitBtn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCustomizeTasksPanelFormDownBitBtn.GetAllParamsCount

function TkwCustomizeTasksPanelFormDownBitBtn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomizeTasksPanelForm)]);
end;//TkwCustomizeTasksPanelFormDownBitBtn.ParamsTypes

initialization
 Tkw_Form_CustomizeTasksPanel.RegisterInEngine;
 {* ����������� Tkw_Form_CustomizeTasksPanel }
 Tkw_CustomizeTasksPanel_Control_spRight.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_spRight }
 Tkw_CustomizeTasksPanel_Control_spRight_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_spRight_Push }
 Tkw_CustomizeTasksPanel_Control_pnlBottom.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlBottom }
 Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlBottom_Push }
 Tkw_CustomizeTasksPanel_Control_lblConfirmSave.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_lblConfirmSave }
 Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push }
 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption }
 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push }
 Tkw_CustomizeTasksPanel_Control_btOk.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btOk }
 Tkw_CustomizeTasksPanel_Control_btOk_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btOk_Push }
 Tkw_CustomizeTasksPanel_Control_btCancel.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btCancel }
 Tkw_CustomizeTasksPanel_Control_btCancel_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btCancel_Push }
 Tkw_CustomizeTasksPanel_Control_btApply.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btApply }
 Tkw_CustomizeTasksPanel_Control_btApply_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btApply_Push }
 Tkw_CustomizeTasksPanel_Control_pnlRep.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlRep }
 Tkw_CustomizeTasksPanel_Control_pnlRep_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlRep_Push }
 Tkw_CustomizeTasksPanel_Control_splRep.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_splRep }
 Tkw_CustomizeTasksPanel_Control_splRep_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_splRep_Push }
 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_gbAvailableGroups }
 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push }
 Tkw_CustomizeTasksPanel_Control_tvRepGroups.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_tvRepGroups }
 Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push }
 Tkw_CustomizeTasksPanel_Control_vtPanel1.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_vtPanel1 }
 Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_vtPanel1_Push }
 Tkw_CustomizeTasksPanel_Control_cbGroupName.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_cbGroupName }
 Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_cbGroupName_Push }
 Tkw_CustomizeTasksPanel_Control_btnAddGroup.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnAddGroup }
 Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push }
 Tkw_CustomizeTasksPanel_Control_btnChangeGroup.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnChangeGroup }
 Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push }
 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnDeleteGroup }
 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push }
 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_gbAvailableOperations }
 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push }
 Tkw_CustomizeTasksPanel_Control_tvRepOps.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_tvRepOps }
 Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_tvRepOps_Push }
 Tkw_CustomizeTasksPanel_Control_pnlForms.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlForms }
 Tkw_CustomizeTasksPanel_Control_pnlForms_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlForms_Push }
 Tkw_CustomizeTasksPanel_Control_lblForms.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_lblForms }
 Tkw_CustomizeTasksPanel_Control_lblForms_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_lblForms_Push }
 Tkw_CustomizeTasksPanel_Control_cbForms.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_cbForms }
 Tkw_CustomizeTasksPanel_Control_cbForms_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_cbForms_Push }
 Tkw_CustomizeTasksPanel_Control_pnlMain.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlMain }
 Tkw_CustomizeTasksPanel_Control_pnlMain_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlMain_Push }
 Tkw_CustomizeTasksPanel_Control_pnlLeft.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlLeft }
 Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlLeft_Push }
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel }
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push }
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep }
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push }
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel }
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push }
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep }
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push }
 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlTasksPanel }
 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push }
 Tkw_CustomizeTasksPanel_Control_gbTasksPanel.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_gbTasksPanel }
 Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push }
 Tkw_CustomizeTasksPanel_Control_tvTasksPanel.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_tvTasksPanel }
 Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push }
 Tkw_CustomizeTasksPanel_Control_vtGroupBox3.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_vtGroupBox3 }
 Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push }
 Tkw_CustomizeTasksPanel_Control_lblCaption.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_lblCaption }
 Tkw_CustomizeTasksPanel_Control_lblCaption_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_lblCaption_Push }
 Tkw_CustomizeTasksPanel_Control_edChange.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_edChange }
 Tkw_CustomizeTasksPanel_Control_edChange_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_edChange_Push }
 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_cbForAllUseCases }
 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push }
 Tkw_CustomizeTasksPanel_Control_btnChangeItem.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnChangeItem }
 Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push }
 Tkw_CustomizeTasksPanel_Control_pnlOperationPos.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlOperationPos }
 Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push }
 Tkw_CustomizeTasksPanel_Control_UpBitBtn.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_UpBitBtn }
 Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push }
 Tkw_CustomizeTasksPanel_Control_DownBitBtn.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_DownBitBtn }
 Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.RegisterInEngine;
 {* ����������� Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push }
 TkwCustomizeTasksPanelFormSpRight.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_spRight }
 TkwCustomizeTasksPanelFormPnlBottom.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_pnlBottom }
 TkwCustomizeTasksPanelFormLblConfirmSave.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_lblConfirmSave }
 TkwCustomizeTasksPanelFormLblAvailableOpsCaption.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_lblAvailableOpsCaption }
 TkwCustomizeTasksPanelFormBtOk.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btOk }
 TkwCustomizeTasksPanelFormBtCancel.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btCancel }
 TkwCustomizeTasksPanelFormBtApply.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btApply }
 TkwCustomizeTasksPanelFormPnlRep.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_pnlRep }
 TkwCustomizeTasksPanelFormSplRep.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_splRep }
 TkwCustomizeTasksPanelFormGbAvailableGroups.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_gbAvailableGroups }
 TkwCustomizeTasksPanelFormTvRepGroups.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_tvRepGroups }
 TkwCustomizeTasksPanelFormVtPanel1.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_vtPanel1 }
 TkwCustomizeTasksPanelFormCbGroupName.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_cbGroupName }
 TkwCustomizeTasksPanelFormBtnAddGroup.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btnAddGroup }
 TkwCustomizeTasksPanelFormBtnChangeGroup.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btnChangeGroup }
 TkwCustomizeTasksPanelFormBtnDeleteGroup.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btnDeleteGroup }
 TkwCustomizeTasksPanelFormGbAvailableOperations.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_gbAvailableOperations }
 TkwCustomizeTasksPanelFormTvRepOps.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_tvRepOps }
 TkwCustomizeTasksPanelFormPnlForms.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_pnlForms }
 TkwCustomizeTasksPanelFormLblForms.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_lblForms }
 TkwCustomizeTasksPanelFormCbForms.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_cbForms }
 TkwCustomizeTasksPanelFormPnlMain.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_pnlMain }
 TkwCustomizeTasksPanelFormPnlLeft.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_pnlLeft }
 TkwCustomizeTasksPanelFormBtnMoveOpToPanel.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btnMoveOpToPanel }
 TkwCustomizeTasksPanelFormBtnMoveOpToRep.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btnMoveOpToRep }
 TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btnMoveGroupToPanel }
 TkwCustomizeTasksPanelFormBtnMoveGroupToRep.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btnMoveGroupToRep }
 TkwCustomizeTasksPanelFormPnlTasksPanel.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_pnlTasksPanel }
 TkwCustomizeTasksPanelFormGbTasksPanel.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_gbTasksPanel }
 TkwCustomizeTasksPanelFormTvTasksPanel.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_tvTasksPanel }
 TkwCustomizeTasksPanelFormVtGroupBox3.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_vtGroupBox3 }
 TkwCustomizeTasksPanelFormLblCaption.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_lblCaption }
 TkwCustomizeTasksPanelFormEdChange.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_edChange }
 TkwCustomizeTasksPanelFormCbForAllUseCases.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_cbForAllUseCases }
 TkwCustomizeTasksPanelFormBtnChangeItem.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_btnChangeItem }
 TkwCustomizeTasksPanelFormPnlOperationPos.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_pnlOperationPos }
 TkwCustomizeTasksPanelFormUpBitBtn.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_UpBitBtn }
 TkwCustomizeTasksPanelFormDownBitBtn.RegisterInEngine;
 {* ����������� CustomizeTasksPanelForm_DownBitBtn }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomizeTasksPanelForm));
 {* ����������� ���� CustomizeTasksPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSplitter));
 {* ����������� ���� TvtSplitter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* ����������� ���� TvtButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* ����������� ���� TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* ����������� ���� TeeTreeView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBox));
 {* ����������� ���� TvtComboBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeButton));
 {* ����������� ���� TeeButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TComboBox));
 {* ����������� ���� TComboBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TBitBtn));
 {* ����������� ���� TBitBtn }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeCheckBox));
 {* ����������� ���� TeeCheckBox }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
