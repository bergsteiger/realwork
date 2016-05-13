unit CustomizeTasksPanelKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� CustomizeTasksPanel }

// ������: "w:\common\components\gui\Garant\VCM\View\TasksPanel\CustomizeTasksPanelKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "CustomizeTasksPanelKeywordsPack" MUID: (4D0A6F43B618)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
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
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , CustomizeTasksPanel_Form
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
 Tkw_Form_CustomizeTasksPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� CustomizeTasksPanel
----
*������ �������������*:
[code]
'aControl' �����::CustomizeTasksPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_CustomizeTasksPanel

 Tkw_CustomizeTasksPanel_Control_spRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� spRight
----
*������ �������������*:
[code]
�������::spRight TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_spRight

 Tkw_CustomizeTasksPanel_Control_spRight_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlBottom

 Tkw_CustomizeTasksPanel_Control_pnlBottom_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave

 Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption

 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btOk

 Tkw_CustomizeTasksPanel_Control_btOk_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btCancel

 Tkw_CustomizeTasksPanel_Control_btCancel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btApply

 Tkw_CustomizeTasksPanel_Control_btApply_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlRep

 Tkw_CustomizeTasksPanel_Control_pnlRep_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_splRep

 Tkw_CustomizeTasksPanel_Control_splRep_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups

 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups

 Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_vtPanel1

 Tkw_CustomizeTasksPanel_Control_vtPanel1_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbGroupName

 Tkw_CustomizeTasksPanel_Control_cbGroupName_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup

 Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup

 Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup

 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations

 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvRepOps

 Tkw_CustomizeTasksPanel_Control_tvRepOps_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlForms

 Tkw_CustomizeTasksPanel_Control_pnlForms_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblForms

 Tkw_CustomizeTasksPanel_Control_lblForms_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbForms

 Tkw_CustomizeTasksPanel_Control_cbForms_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlMain

 Tkw_CustomizeTasksPanel_Control_pnlMain_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlLeft

 Tkw_CustomizeTasksPanel_Control_pnlLeft_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel

 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep

 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel

 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep

 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel

 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel

 Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel

 Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3

 Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblCaption

 Tkw_CustomizeTasksPanel_Control_lblCaption_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_edChange

 Tkw_CustomizeTasksPanel_Control_edChange_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases

 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem

 Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos

 Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn

 Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn

 Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
  {* ����� ������� .TCustomizeTasksPanelForm.spRight }
  private
   function spRight(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.spRight }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormSpRight

 TkwCustomizeTasksPanelFormPnlBottom = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlBottom }
  private
   function pnlBottom(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlBottom }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormPnlBottom

 TkwCustomizeTasksPanelFormLblConfirmSave = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblConfirmSave }
  private
   function lblConfirmSave(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblConfirmSave }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormLblConfirmSave

 TkwCustomizeTasksPanelFormLblAvailableOpsCaption = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
  private
   function lblAvailableOpsCaption(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption

 TkwCustomizeTasksPanelFormBtOk = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btOk }
  private
   function btOk(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btOk }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtOk

 TkwCustomizeTasksPanelFormBtCancel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btCancel }
  private
   function btCancel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btCancel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtCancel

 TkwCustomizeTasksPanelFormBtApply = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btApply }
  private
   function btApply(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btApply }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtApply

 TkwCustomizeTasksPanelFormPnlRep = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlRep }
  private
   function pnlRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlRep }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormPnlRep

 TkwCustomizeTasksPanelFormSplRep = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.splRep }
  private
   function splRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.splRep }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormSplRep

 TkwCustomizeTasksPanelFormGbAvailableGroups = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.gbAvailableGroups }
  private
   function gbAvailableGroups(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableGroups }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormGbAvailableGroups

 TkwCustomizeTasksPanelFormTvRepGroups = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.tvRepGroups }
  private
   function tvRepGroups(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepGroups }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormTvRepGroups

 TkwCustomizeTasksPanelFormVtPanel1 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.vtPanel1 }
  private
   function vtPanel1(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtPanel1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormVtPanel1

 TkwCustomizeTasksPanelFormCbGroupName = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.cbGroupName }
  private
   function cbGroupName(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbGroupName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormCbGroupName

 TkwCustomizeTasksPanelFormBtnAddGroup = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnAddGroup }
  private
   function btnAddGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnAddGroup }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtnAddGroup

 TkwCustomizeTasksPanelFormBtnChangeGroup = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnChangeGroup }
  private
   function btnChangeGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeGroup }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtnChangeGroup

 TkwCustomizeTasksPanelFormBtnDeleteGroup = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnDeleteGroup }
  private
   function btnDeleteGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnDeleteGroup }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtnDeleteGroup

 TkwCustomizeTasksPanelFormGbAvailableOperations = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.gbAvailableOperations }
  private
   function gbAvailableOperations(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableOperations }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormGbAvailableOperations

 TkwCustomizeTasksPanelFormTvRepOps = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.tvRepOps }
  private
   function tvRepOps(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepOps }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormTvRepOps

 TkwCustomizeTasksPanelFormPnlForms = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlForms }
  private
   function pnlForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlForms }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormPnlForms

 TkwCustomizeTasksPanelFormLblForms = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblForms }
  private
   function lblForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblForms }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormLblForms

 TkwCustomizeTasksPanelFormCbForms = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.cbForms }
  private
   function cbForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForms }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormCbForms

 TkwCustomizeTasksPanelFormPnlMain = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlMain }
  private
   function pnlMain(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormPnlMain

 TkwCustomizeTasksPanelFormPnlLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlLeft }
  private
   function pnlLeft(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlLeft }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormPnlLeft

 TkwCustomizeTasksPanelFormBtnMoveOpToPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToPanel }
  private
   function btnMoveOpToPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel

 TkwCustomizeTasksPanelFormBtnMoveOpToRep = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToRep }
  private
   function btnMoveOpToRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToRep }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep

 TkwCustomizeTasksPanelFormBtnMoveGroupToPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
  private
   function btnMoveGroupToPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel

 TkwCustomizeTasksPanelFormBtnMoveGroupToRep = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToRep }
  private
   function btnMoveGroupToRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToRep }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep

 TkwCustomizeTasksPanelFormPnlTasksPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlTasksPanel }
  private
   function pnlTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlTasksPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormPnlTasksPanel

 TkwCustomizeTasksPanelFormGbTasksPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.gbTasksPanel }
  private
   function gbTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbTasksPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormGbTasksPanel

 TkwCustomizeTasksPanelFormTvTasksPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.tvTasksPanel }
  private
   function tvTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvTasksPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormTvTasksPanel

 TkwCustomizeTasksPanelFormVtGroupBox3 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.vtGroupBox3 }
  private
   function vtGroupBox3(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtGroupBox3 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormVtGroupBox3

 TkwCustomizeTasksPanelFormLblCaption = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblCaption }
  private
   function lblCaption(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblCaption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormLblCaption

 TkwCustomizeTasksPanelFormEdChange = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.edChange }
  private
   function edChange(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.edChange }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormEdChange

 TkwCustomizeTasksPanelFormCbForAllUseCases = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.cbForAllUseCases }
  private
   function cbForAllUseCases(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForAllUseCases }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormCbForAllUseCases

 TkwCustomizeTasksPanelFormBtnChangeItem = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnChangeItem }
  private
   function btnChangeItem(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeItem }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormBtnChangeItem

 TkwCustomizeTasksPanelFormPnlOperationPos = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlOperationPos }
  private
   function pnlOperationPos(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlOperationPos }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormPnlOperationPos

 TkwCustomizeTasksPanelFormUpBitBtn = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.UpBitBtn }
  private
   function UpBitBtn(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.UpBitBtn }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormUpBitBtn

 TkwCustomizeTasksPanelFormDownBitBtn = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.DownBitBtn }
  private
   function DownBitBtn(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* ���������� ����� ������� .TCustomizeTasksPanelForm.DownBitBtn }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCustomizeTasksPanelFormDownBitBtn

function Tkw_Form_CustomizeTasksPanel.GetString: AnsiString;
begin
 Result := 'CustomizeTasksPanelForm';
end;//Tkw_Form_CustomizeTasksPanel.GetString

class procedure Tkw_Form_CustomizeTasksPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TCustomizeTasksPanelForm);
end;//Tkw_Form_CustomizeTasksPanel.RegisterInEngine

class function Tkw_Form_CustomizeTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::CustomizeTasksPanel';
end;//Tkw_Form_CustomizeTasksPanel.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_spRight.GetString: AnsiString;
begin
 Result := 'spRight';
end;//Tkw_CustomizeTasksPanel_Control_spRight.GetString

class procedure Tkw_CustomizeTasksPanel_Control_spRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSplitter);
end;//Tkw_CustomizeTasksPanel_Control_spRight.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_spRight.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::spRight';
end;//Tkw_CustomizeTasksPanel_Control_spRight.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_spRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('spRight');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_spRight_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_spRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::spRight:push';
end;//Tkw_CustomizeTasksPanel_Control_spRight_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlBottom.GetString: AnsiString;
begin
 Result := 'pnlBottom';
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlBottom.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_pnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlBottom';
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBottom');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlBottom:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetString: AnsiString;
begin
 Result := 'lblConfirmSave';
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblConfirmSave.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblConfirmSave';
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblConfirmSave');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblConfirmSave:push';
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetString: AnsiString;
begin
 Result := 'lblAvailableOpsCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblAvailableOpsCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblAvailableOpsCaption');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblAvailableOpsCaption:push';
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btOk.GetString: AnsiString;
begin
 Result := 'btOk';
end;//Tkw_CustomizeTasksPanel_Control_btOk.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btOk.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_CustomizeTasksPanel_Control_btOk.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btOk.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btOk';
end;//Tkw_CustomizeTasksPanel_Control_btOk.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btOk_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btOk');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btOk_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btOk:push';
end;//Tkw_CustomizeTasksPanel_Control_btOk_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btCancel.GetString: AnsiString;
begin
 Result := 'btCancel';
end;//Tkw_CustomizeTasksPanel_Control_btCancel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btCancel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_CustomizeTasksPanel_Control_btCancel.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btCancel';
end;//Tkw_CustomizeTasksPanel_Control_btCancel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btCancel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btCancel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btCancel:push';
end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btApply.GetString: AnsiString;
begin
 Result := 'btApply';
end;//Tkw_CustomizeTasksPanel_Control_btApply.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btApply.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_CustomizeTasksPanel_Control_btApply.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btApply.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btApply';
end;//Tkw_CustomizeTasksPanel_Control_btApply.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btApply_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btApply');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btApply_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btApply_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btApply:push';
end;//Tkw_CustomizeTasksPanel_Control_btApply_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlRep.GetString: AnsiString;
begin
 Result := 'pnlRep';
end;//Tkw_CustomizeTasksPanel_Control_pnlRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlRep.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlRep.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_pnlRep.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlRep';
end;//Tkw_CustomizeTasksPanel_Control_pnlRep.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlRep_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlRep:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_splRep.GetString: AnsiString;
begin
 Result := 'splRep';
end;//Tkw_CustomizeTasksPanel_Control_splRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_splRep.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSplitter);
end;//Tkw_CustomizeTasksPanel_Control_splRep.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_splRep.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::splRep';
end;//Tkw_CustomizeTasksPanel_Control_splRep.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_splRep_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('splRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_splRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_splRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::splRep:push';
end;//Tkw_CustomizeTasksPanel_Control_splRep_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetString: AnsiString;
begin
 Result := 'gbAvailableGroups';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetString

class procedure Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbAvailableGroups';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('gbAvailableGroups');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbAvailableGroups:push';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetString: AnsiString;
begin
 Result := 'tvRepGroups';
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetString

class procedure Tkw_CustomizeTasksPanel_Control_tvRepGroups.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvRepGroups';
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvRepGroups');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvRepGroups:push';
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_vtPanel1.GetString: AnsiString;
begin
 Result := 'vtPanel1';
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1.GetString

class procedure Tkw_CustomizeTasksPanel_Control_vtPanel1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_vtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtPanel1';
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vtPanel1');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtPanel1:push';
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_cbGroupName.GetString: AnsiString;
begin
 Result := 'cbGroupName';
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName.GetString

class procedure Tkw_CustomizeTasksPanel_Control_cbGroupName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBox);
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_cbGroupName.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbGroupName';
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbGroupName');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbGroupName:push';
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetString: AnsiString;
begin
 Result := 'btnAddGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnAddGroup.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeButton);
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnAddGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnAddGroup');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnAddGroup:push';
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetString: AnsiString;
begin
 Result := 'btnChangeGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnChangeGroup.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeButton);
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnChangeGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnChangeGroup');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnChangeGroup:push';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetString: AnsiString;
begin
 Result := 'btnDeleteGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeButton);
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnDeleteGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnDeleteGroup');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnDeleteGroup:push';
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetString: AnsiString;
begin
 Result := 'gbAvailableOperations';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetString

class procedure Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbAvailableOperations';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('gbAvailableOperations');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbAvailableOperations:push';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_tvRepOps.GetString: AnsiString;
begin
 Result := 'tvRepOps';
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps.GetString

class procedure Tkw_CustomizeTasksPanel_Control_tvRepOps.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_tvRepOps.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvRepOps';
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvRepOps');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvRepOps:push';
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlForms.GetString: AnsiString;
begin
 Result := 'pnlForms';
end;//Tkw_CustomizeTasksPanel_Control_pnlForms.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlForms.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlForms.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_pnlForms.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlForms';
end;//Tkw_CustomizeTasksPanel_Control_pnlForms.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlForms_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlForms');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlForms_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlForms:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblForms.GetString: AnsiString;
begin
 Result := 'lblForms';
end;//Tkw_CustomizeTasksPanel_Control_lblForms.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblForms.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CustomizeTasksPanel_Control_lblForms.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_lblForms.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblForms';
end;//Tkw_CustomizeTasksPanel_Control_lblForms.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_lblForms_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblForms');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblForms_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblForms:push';
end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_cbForms.GetString: AnsiString;
begin
 Result := 'cbForms';
end;//Tkw_CustomizeTasksPanel_Control_cbForms.GetString

class procedure Tkw_CustomizeTasksPanel_Control_cbForms.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TComboBox);
end;//Tkw_CustomizeTasksPanel_Control_cbForms.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_cbForms.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbForms';
end;//Tkw_CustomizeTasksPanel_Control_cbForms.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_cbForms_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbForms');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbForms_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbForms:push';
end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlMain.GetString: AnsiString;
begin
 Result := 'pnlMain';
end;//Tkw_CustomizeTasksPanel_Control_pnlMain.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlMain.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain';
end;//Tkw_CustomizeTasksPanel_Control_pnlMain.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlLeft.GetString: AnsiString;
begin
 Result := 'pnlLeft';
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_pnlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeft';
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLeft');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeft:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetString: AnsiString;
begin
 Result := 'btnMoveOpToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveOpToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnMoveOpToPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveOpToPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetString: AnsiString;
begin
 Result := 'btnMoveOpToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveOpToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnMoveOpToRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveOpToRep:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetString: AnsiString;
begin
 Result := 'btnMoveGroupToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveGroupToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnMoveGroupToPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveGroupToPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetString: AnsiString;
begin
 Result := 'btnMoveGroupToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveGroupToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnMoveGroupToRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnMoveGroupToRep:push';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetString: AnsiString;
begin
 Result := 'pnlTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlTasksPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlTasksPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetString: AnsiString;
begin
 Result := 'gbTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_gbTasksPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('gbTasksPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbTasksPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetString: AnsiString;
begin
 Result := 'tvTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetString

class procedure Tkw_CustomizeTasksPanel_Control_tvTasksPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvTasksPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvTasksPanel:push';
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetString: AnsiString;
begin
 Result := 'vtGroupBox3';
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetString

class procedure Tkw_CustomizeTasksPanel_Control_vtGroupBox3.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtGroupBox3';
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vtGroupBox3');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtGroupBox3:push';
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_lblCaption.GetString: AnsiString;
begin
 Result := 'lblCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblCaption.GetString

class procedure Tkw_CustomizeTasksPanel_Control_lblCaption.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CustomizeTasksPanel_Control_lblCaption.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_lblCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblCaption.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_lblCaption_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblCaption');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblCaption:push';
end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_edChange.GetString: AnsiString;
begin
 Result := 'edChange';
end;//Tkw_CustomizeTasksPanel_Control_edChange.GetString

class procedure Tkw_CustomizeTasksPanel_Control_edChange.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBox);
end;//Tkw_CustomizeTasksPanel_Control_edChange.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_edChange.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edChange';
end;//Tkw_CustomizeTasksPanel_Control_edChange.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_edChange_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edChange');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_edChange_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_edChange_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edChange:push';
end;//Tkw_CustomizeTasksPanel_Control_edChange_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetString: AnsiString;
begin
 Result := 'cbForAllUseCases';
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetString

class procedure Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeCheckBox);
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbForAllUseCases';
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbForAllUseCases');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbForAllUseCases:push';
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetString: AnsiString;
begin
 Result := 'btnChangeItem';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetString

class procedure Tkw_CustomizeTasksPanel_Control_btnChangeItem.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeButton);
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnChangeItem';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnChangeItem');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnChangeItem:push';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetString: AnsiString;
begin
 Result := 'pnlOperationPos';
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetString

class procedure Tkw_CustomizeTasksPanel_Control_pnlOperationPos.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlOperationPos';
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlOperationPos');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlOperationPos:push';
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetString: AnsiString;
begin
 Result := 'UpBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetString

class procedure Tkw_CustomizeTasksPanel_Control_UpBitBtn.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UpBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UpBitBtn');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UpBitBtn:push';
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.GetWordNameForRegister

function Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetString: AnsiString;
begin
 Result := 'DownBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetString

class procedure Tkw_CustomizeTasksPanel_Control_DownBitBtn.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TBitBtn);
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn.RegisterInEngine

class function Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DownBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('DownBitBtn');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DownBitBtn:push';
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.GetWordNameForRegister

function TkwCustomizeTasksPanelFormSpRight.spRight(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.spRight }
begin
 Result := aCustomizeTasksPanelForm.spRight;
end;//TkwCustomizeTasksPanelFormSpRight.spRight

class function TkwCustomizeTasksPanelFormSpRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.spRight';
end;//TkwCustomizeTasksPanelFormSpRight.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormSpRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� spRight', aCtx);
end;//TkwCustomizeTasksPanelFormSpRight.SetValuePrim

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

function TkwCustomizeTasksPanelFormPnlBottom.pnlBottom(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlBottom }
begin
 Result := aCustomizeTasksPanelForm.pnlBottom;
end;//TkwCustomizeTasksPanelFormPnlBottom.pnlBottom

class function TkwCustomizeTasksPanelFormPnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlBottom';
end;//TkwCustomizeTasksPanelFormPnlBottom.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormPnlBottom.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlBottom', aCtx);
end;//TkwCustomizeTasksPanelFormPnlBottom.SetValuePrim

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

function TkwCustomizeTasksPanelFormLblConfirmSave.lblConfirmSave(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblConfirmSave }
begin
 Result := aCustomizeTasksPanelForm.lblConfirmSave;
end;//TkwCustomizeTasksPanelFormLblConfirmSave.lblConfirmSave

class function TkwCustomizeTasksPanelFormLblConfirmSave.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblConfirmSave';
end;//TkwCustomizeTasksPanelFormLblConfirmSave.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormLblConfirmSave.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblConfirmSave', aCtx);
end;//TkwCustomizeTasksPanelFormLblConfirmSave.SetValuePrim

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

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.lblAvailableOpsCaption(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
begin
 Result := aCustomizeTasksPanelForm.lblAvailableOpsCaption;
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.lblAvailableOpsCaption

class function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblAvailableOpsCaption';
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormLblAvailableOpsCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblAvailableOpsCaption', aCtx);
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtOk.btOk(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btOk }
begin
 Result := aCustomizeTasksPanelForm.btOk;
end;//TkwCustomizeTasksPanelFormBtOk.btOk

class function TkwCustomizeTasksPanelFormBtOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btOk';
end;//TkwCustomizeTasksPanelFormBtOk.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btOk', aCtx);
end;//TkwCustomizeTasksPanelFormBtOk.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtCancel.btCancel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btCancel }
begin
 Result := aCustomizeTasksPanelForm.btCancel;
end;//TkwCustomizeTasksPanelFormBtCancel.btCancel

class function TkwCustomizeTasksPanelFormBtCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btCancel';
end;//TkwCustomizeTasksPanelFormBtCancel.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtCancel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btCancel', aCtx);
end;//TkwCustomizeTasksPanelFormBtCancel.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtApply.btApply(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btApply }
begin
 Result := aCustomizeTasksPanelForm.btApply;
end;//TkwCustomizeTasksPanelFormBtApply.btApply

class function TkwCustomizeTasksPanelFormBtApply.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btApply';
end;//TkwCustomizeTasksPanelFormBtApply.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtApply.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btApply', aCtx);
end;//TkwCustomizeTasksPanelFormBtApply.SetValuePrim

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

function TkwCustomizeTasksPanelFormPnlRep.pnlRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlRep }
begin
 Result := aCustomizeTasksPanelForm.pnlRep;
end;//TkwCustomizeTasksPanelFormPnlRep.pnlRep

class function TkwCustomizeTasksPanelFormPnlRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlRep';
end;//TkwCustomizeTasksPanelFormPnlRep.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormPnlRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlRep', aCtx);
end;//TkwCustomizeTasksPanelFormPnlRep.SetValuePrim

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

function TkwCustomizeTasksPanelFormSplRep.splRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.splRep }
begin
 Result := aCustomizeTasksPanelForm.splRep;
end;//TkwCustomizeTasksPanelFormSplRep.splRep

class function TkwCustomizeTasksPanelFormSplRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.splRep';
end;//TkwCustomizeTasksPanelFormSplRep.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormSplRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� splRep', aCtx);
end;//TkwCustomizeTasksPanelFormSplRep.SetValuePrim

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

function TkwCustomizeTasksPanelFormGbAvailableGroups.gbAvailableGroups(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableGroups }
begin
 Result := aCustomizeTasksPanelForm.gbAvailableGroups;
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.gbAvailableGroups

class function TkwCustomizeTasksPanelFormGbAvailableGroups.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.gbAvailableGroups';
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormGbAvailableGroups.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� gbAvailableGroups', aCtx);
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.SetValuePrim

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

function TkwCustomizeTasksPanelFormTvRepGroups.tvRepGroups(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepGroups }
begin
 Result := aCustomizeTasksPanelForm.tvRepGroups;
end;//TkwCustomizeTasksPanelFormTvRepGroups.tvRepGroups

class function TkwCustomizeTasksPanelFormTvRepGroups.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.tvRepGroups';
end;//TkwCustomizeTasksPanelFormTvRepGroups.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormTvRepGroups.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvRepGroups', aCtx);
end;//TkwCustomizeTasksPanelFormTvRepGroups.SetValuePrim

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

function TkwCustomizeTasksPanelFormVtPanel1.vtPanel1(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtPanel1 }
begin
 Result := aCustomizeTasksPanelForm.vtPanel1;
end;//TkwCustomizeTasksPanelFormVtPanel1.vtPanel1

class function TkwCustomizeTasksPanelFormVtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.vtPanel1';
end;//TkwCustomizeTasksPanelFormVtPanel1.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormVtPanel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� vtPanel1', aCtx);
end;//TkwCustomizeTasksPanelFormVtPanel1.SetValuePrim

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

function TkwCustomizeTasksPanelFormCbGroupName.cbGroupName(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbGroupName }
begin
 Result := aCustomizeTasksPanelForm.cbGroupName;
end;//TkwCustomizeTasksPanelFormCbGroupName.cbGroupName

class function TkwCustomizeTasksPanelFormCbGroupName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.cbGroupName';
end;//TkwCustomizeTasksPanelFormCbGroupName.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormCbGroupName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� cbGroupName', aCtx);
end;//TkwCustomizeTasksPanelFormCbGroupName.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtnAddGroup.btnAddGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnAddGroup }
begin
 Result := aCustomizeTasksPanelForm.btnAddGroup;
end;//TkwCustomizeTasksPanelFormBtnAddGroup.btnAddGroup

class function TkwCustomizeTasksPanelFormBtnAddGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnAddGroup';
end;//TkwCustomizeTasksPanelFormBtnAddGroup.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtnAddGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnAddGroup', aCtx);
end;//TkwCustomizeTasksPanelFormBtnAddGroup.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtnChangeGroup.btnChangeGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeGroup }
begin
 Result := aCustomizeTasksPanelForm.btnChangeGroup;
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.btnChangeGroup

class function TkwCustomizeTasksPanelFormBtnChangeGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnChangeGroup';
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtnChangeGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnChangeGroup', aCtx);
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtnDeleteGroup.btnDeleteGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnDeleteGroup }
begin
 Result := aCustomizeTasksPanelForm.btnDeleteGroup;
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.btnDeleteGroup

class function TkwCustomizeTasksPanelFormBtnDeleteGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnDeleteGroup';
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtnDeleteGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnDeleteGroup', aCtx);
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.SetValuePrim

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

function TkwCustomizeTasksPanelFormGbAvailableOperations.gbAvailableOperations(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableOperations }
begin
 Result := aCustomizeTasksPanelForm.gbAvailableOperations;
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.gbAvailableOperations

class function TkwCustomizeTasksPanelFormGbAvailableOperations.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.gbAvailableOperations';
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormGbAvailableOperations.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� gbAvailableOperations', aCtx);
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.SetValuePrim

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

function TkwCustomizeTasksPanelFormTvRepOps.tvRepOps(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepOps }
begin
 Result := aCustomizeTasksPanelForm.tvRepOps;
end;//TkwCustomizeTasksPanelFormTvRepOps.tvRepOps

class function TkwCustomizeTasksPanelFormTvRepOps.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.tvRepOps';
end;//TkwCustomizeTasksPanelFormTvRepOps.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormTvRepOps.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvRepOps', aCtx);
end;//TkwCustomizeTasksPanelFormTvRepOps.SetValuePrim

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

function TkwCustomizeTasksPanelFormPnlForms.pnlForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlForms }
begin
 Result := aCustomizeTasksPanelForm.pnlForms;
end;//TkwCustomizeTasksPanelFormPnlForms.pnlForms

class function TkwCustomizeTasksPanelFormPnlForms.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlForms';
end;//TkwCustomizeTasksPanelFormPnlForms.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormPnlForms.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlForms', aCtx);
end;//TkwCustomizeTasksPanelFormPnlForms.SetValuePrim

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

function TkwCustomizeTasksPanelFormLblForms.lblForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblForms }
begin
 Result := aCustomizeTasksPanelForm.lblForms;
end;//TkwCustomizeTasksPanelFormLblForms.lblForms

class function TkwCustomizeTasksPanelFormLblForms.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblForms';
end;//TkwCustomizeTasksPanelFormLblForms.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormLblForms.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblForms', aCtx);
end;//TkwCustomizeTasksPanelFormLblForms.SetValuePrim

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

function TkwCustomizeTasksPanelFormCbForms.cbForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForms }
begin
 Result := aCustomizeTasksPanelForm.cbForms;
end;//TkwCustomizeTasksPanelFormCbForms.cbForms

class function TkwCustomizeTasksPanelFormCbForms.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.cbForms';
end;//TkwCustomizeTasksPanelFormCbForms.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormCbForms.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� cbForms', aCtx);
end;//TkwCustomizeTasksPanelFormCbForms.SetValuePrim

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

function TkwCustomizeTasksPanelFormPnlMain.pnlMain(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlMain }
begin
 Result := aCustomizeTasksPanelForm.pnlMain;
end;//TkwCustomizeTasksPanelFormPnlMain.pnlMain

class function TkwCustomizeTasksPanelFormPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlMain';
end;//TkwCustomizeTasksPanelFormPnlMain.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlMain', aCtx);
end;//TkwCustomizeTasksPanelFormPnlMain.SetValuePrim

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

function TkwCustomizeTasksPanelFormPnlLeft.pnlLeft(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlLeft }
begin
 Result := aCustomizeTasksPanelForm.pnlLeft;
end;//TkwCustomizeTasksPanelFormPnlLeft.pnlLeft

class function TkwCustomizeTasksPanelFormPnlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlLeft';
end;//TkwCustomizeTasksPanelFormPnlLeft.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormPnlLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlLeft', aCtx);
end;//TkwCustomizeTasksPanelFormPnlLeft.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.btnMoveOpToPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToPanel }
begin
 Result := aCustomizeTasksPanelForm.btnMoveOpToPanel;
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.btnMoveOpToPanel

class function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveOpToPanel';
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtnMoveOpToPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnMoveOpToPanel', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.btnMoveOpToRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToRep }
begin
 Result := aCustomizeTasksPanelForm.btnMoveOpToRep;
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.btnMoveOpToRep

class function TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveOpToRep';
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtnMoveOpToRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnMoveOpToRep', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.btnMoveGroupToPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
begin
 Result := aCustomizeTasksPanelForm.btnMoveGroupToPanel;
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.btnMoveGroupToPanel

class function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveGroupToPanel';
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnMoveGroupToPanel', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.btnMoveGroupToRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToRep }
begin
 Result := aCustomizeTasksPanelForm.btnMoveGroupToRep;
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.btnMoveGroupToRep

class function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveGroupToRep';
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnMoveGroupToRep', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.SetValuePrim

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

function TkwCustomizeTasksPanelFormPnlTasksPanel.pnlTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlTasksPanel }
begin
 Result := aCustomizeTasksPanelForm.pnlTasksPanel;
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.pnlTasksPanel

class function TkwCustomizeTasksPanelFormPnlTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlTasksPanel';
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormPnlTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlTasksPanel', aCtx);
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.SetValuePrim

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

function TkwCustomizeTasksPanelFormGbTasksPanel.gbTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbTasksPanel }
begin
 Result := aCustomizeTasksPanelForm.gbTasksPanel;
end;//TkwCustomizeTasksPanelFormGbTasksPanel.gbTasksPanel

class function TkwCustomizeTasksPanelFormGbTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.gbTasksPanel';
end;//TkwCustomizeTasksPanelFormGbTasksPanel.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormGbTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� gbTasksPanel', aCtx);
end;//TkwCustomizeTasksPanelFormGbTasksPanel.SetValuePrim

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

function TkwCustomizeTasksPanelFormTvTasksPanel.tvTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvTasksPanel }
begin
 Result := aCustomizeTasksPanelForm.tvTasksPanel;
end;//TkwCustomizeTasksPanelFormTvTasksPanel.tvTasksPanel

class function TkwCustomizeTasksPanelFormTvTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.tvTasksPanel';
end;//TkwCustomizeTasksPanelFormTvTasksPanel.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormTvTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvTasksPanel', aCtx);
end;//TkwCustomizeTasksPanelFormTvTasksPanel.SetValuePrim

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

function TkwCustomizeTasksPanelFormVtGroupBox3.vtGroupBox3(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtGroupBox3 }
begin
 Result := aCustomizeTasksPanelForm.vtGroupBox3;
end;//TkwCustomizeTasksPanelFormVtGroupBox3.vtGroupBox3

class function TkwCustomizeTasksPanelFormVtGroupBox3.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.vtGroupBox3';
end;//TkwCustomizeTasksPanelFormVtGroupBox3.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormVtGroupBox3.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� vtGroupBox3', aCtx);
end;//TkwCustomizeTasksPanelFormVtGroupBox3.SetValuePrim

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

function TkwCustomizeTasksPanelFormLblCaption.lblCaption(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblCaption }
begin
 Result := aCustomizeTasksPanelForm.lblCaption;
end;//TkwCustomizeTasksPanelFormLblCaption.lblCaption

class function TkwCustomizeTasksPanelFormLblCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblCaption';
end;//TkwCustomizeTasksPanelFormLblCaption.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormLblCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblCaption', aCtx);
end;//TkwCustomizeTasksPanelFormLblCaption.SetValuePrim

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

function TkwCustomizeTasksPanelFormEdChange.edChange(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.edChange }
begin
 Result := aCustomizeTasksPanelForm.edChange;
end;//TkwCustomizeTasksPanelFormEdChange.edChange

class function TkwCustomizeTasksPanelFormEdChange.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.edChange';
end;//TkwCustomizeTasksPanelFormEdChange.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormEdChange.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edChange', aCtx);
end;//TkwCustomizeTasksPanelFormEdChange.SetValuePrim

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

function TkwCustomizeTasksPanelFormCbForAllUseCases.cbForAllUseCases(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForAllUseCases }
begin
 Result := aCustomizeTasksPanelForm.cbForAllUseCases;
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.cbForAllUseCases

class function TkwCustomizeTasksPanelFormCbForAllUseCases.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.cbForAllUseCases';
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormCbForAllUseCases.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� cbForAllUseCases', aCtx);
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.SetValuePrim

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

function TkwCustomizeTasksPanelFormBtnChangeItem.btnChangeItem(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeItem }
begin
 Result := aCustomizeTasksPanelForm.btnChangeItem;
end;//TkwCustomizeTasksPanelFormBtnChangeItem.btnChangeItem

class function TkwCustomizeTasksPanelFormBtnChangeItem.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnChangeItem';
end;//TkwCustomizeTasksPanelFormBtnChangeItem.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormBtnChangeItem.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnChangeItem', aCtx);
end;//TkwCustomizeTasksPanelFormBtnChangeItem.SetValuePrim

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

function TkwCustomizeTasksPanelFormPnlOperationPos.pnlOperationPos(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlOperationPos }
begin
 Result := aCustomizeTasksPanelForm.pnlOperationPos;
end;//TkwCustomizeTasksPanelFormPnlOperationPos.pnlOperationPos

class function TkwCustomizeTasksPanelFormPnlOperationPos.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlOperationPos';
end;//TkwCustomizeTasksPanelFormPnlOperationPos.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormPnlOperationPos.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlOperationPos', aCtx);
end;//TkwCustomizeTasksPanelFormPnlOperationPos.SetValuePrim

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

function TkwCustomizeTasksPanelFormUpBitBtn.UpBitBtn(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.UpBitBtn }
begin
 Result := aCustomizeTasksPanelForm.UpBitBtn;
end;//TkwCustomizeTasksPanelFormUpBitBtn.UpBitBtn

class function TkwCustomizeTasksPanelFormUpBitBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.UpBitBtn';
end;//TkwCustomizeTasksPanelFormUpBitBtn.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormUpBitBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� UpBitBtn', aCtx);
end;//TkwCustomizeTasksPanelFormUpBitBtn.SetValuePrim

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

function TkwCustomizeTasksPanelFormDownBitBtn.DownBitBtn(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* ���������� ����� ������� .TCustomizeTasksPanelForm.DownBitBtn }
begin
 Result := aCustomizeTasksPanelForm.DownBitBtn;
end;//TkwCustomizeTasksPanelFormDownBitBtn.DownBitBtn

class function TkwCustomizeTasksPanelFormDownBitBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.DownBitBtn';
end;//TkwCustomizeTasksPanelFormDownBitBtn.GetWordNameForRegister

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

procedure TkwCustomizeTasksPanelFormDownBitBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� DownBitBtn', aCtx);
end;//TkwCustomizeTasksPanelFormDownBitBtn.SetValuePrim

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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomizeTasksPanelForm));
 {* ����������� ���� TCustomizeTasksPanelForm }
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
