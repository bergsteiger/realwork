unit CustomizeTasksPanelKeywordsPack;

interface

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
 , StdCtrls
 , Buttons
 , eeCheckBox
 , tfwControlString
 , kwBynameControlPush
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_CustomizeTasksPanel = class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� CustomizeTasksPanel
----
*������ �������������*:
[code]
'aControl' �����::CustomizeTasksPanel TryFocus ASSERT
[code] }
 end;//Tkw_Form_CustomizeTasksPanel
 
 Tkw_CustomizeTasksPanel_Control_spRight = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� spRight
----
*������ �������������*:
[code]
�������::spRight TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_spRight
 
 Tkw_CustomizeTasksPanel_Control_spRight_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� spRight
----
*������ �������������*:
[code]
�������::spRight:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_spRight_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlBottom = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlBottom
----
*������ �������������*:
[code]
�������::pnlBottom TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlBottom
 
 Tkw_CustomizeTasksPanel_Control_pnlBottom_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlBottom
----
*������ �������������*:
[code]
�������::pnlBottom:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push
 
 Tkw_CustomizeTasksPanel_Control_lblConfirmSave = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblConfirmSave
----
*������ �������������*:
[code]
�������::lblConfirmSave TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave
 
 Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblConfirmSave
----
*������ �������������*:
[code]
�������::lblConfirmSave:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push
 
 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblAvailableOpsCaption
----
*������ �������������*:
[code]
�������::lblAvailableOpsCaption TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption
 
 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblAvailableOpsCaption
----
*������ �������������*:
[code]
�������::lblAvailableOpsCaption:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push
 
 Tkw_CustomizeTasksPanel_Control_btOk = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btOk
----
*������ �������������*:
[code]
�������::btOk TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btOk
 
 Tkw_CustomizeTasksPanel_Control_btOk_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btOk
----
*������ �������������*:
[code]
�������::btOk:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btOk_Push
 
 Tkw_CustomizeTasksPanel_Control_btCancel = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btCancel
----
*������ �������������*:
[code]
�������::btCancel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btCancel
 
 Tkw_CustomizeTasksPanel_Control_btCancel_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btCancel
----
*������ �������������*:
[code]
�������::btCancel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push
 
 Tkw_CustomizeTasksPanel_Control_btApply = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btApply
----
*������ �������������*:
[code]
�������::btApply TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btApply
 
 Tkw_CustomizeTasksPanel_Control_btApply_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btApply
----
*������ �������������*:
[code]
�������::btApply:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btApply_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlRep = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlRep
----
*������ �������������*:
[code]
�������::pnlRep TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlRep
 
 Tkw_CustomizeTasksPanel_Control_pnlRep_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlRep
----
*������ �������������*:
[code]
�������::pnlRep:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push
 
 Tkw_CustomizeTasksPanel_Control_splRep = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� splRep
----
*������ �������������*:
[code]
�������::splRep TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_splRep
 
 Tkw_CustomizeTasksPanel_Control_splRep_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� splRep
----
*������ �������������*:
[code]
�������::splRep:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_splRep_Push
 
 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� gbAvailableGroups
----
*������ �������������*:
[code]
�������::gbAvailableGroups TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups
 
 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� gbAvailableGroups
----
*������ �������������*:
[code]
�������::gbAvailableGroups:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push
 
 Tkw_CustomizeTasksPanel_Control_tvRepGroups = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvRepGroups
----
*������ �������������*:
[code]
�������::tvRepGroups TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups
 
 Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvRepGroups
----
*������ �������������*:
[code]
�������::tvRepGroups:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push
 
 Tkw_CustomizeTasksPanel_Control_vtPanel1 = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� vtPanel1
----
*������ �������������*:
[code]
�������::vtPanel1 TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_vtPanel1
 
 Tkw_CustomizeTasksPanel_Control_vtPanel1_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� vtPanel1
----
*������ �������������*:
[code]
�������::vtPanel1:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push
 
 Tkw_CustomizeTasksPanel_Control_cbGroupName = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbGroupName
----
*������ �������������*:
[code]
�������::cbGroupName TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbGroupName
 
 Tkw_CustomizeTasksPanel_Control_cbGroupName_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbGroupName
----
*������ �������������*:
[code]
�������::cbGroupName:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push
 
 Tkw_CustomizeTasksPanel_Control_btnAddGroup = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnAddGroup
----
*������ �������������*:
[code]
�������::btnAddGroup TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup
 
 Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnAddGroup
----
*������ �������������*:
[code]
�������::btnAddGroup:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push
 
 Tkw_CustomizeTasksPanel_Control_btnChangeGroup = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnChangeGroup
----
*������ �������������*:
[code]
�������::btnChangeGroup TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup
 
 Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnChangeGroup
----
*������ �������������*:
[code]
�������::btnChangeGroup:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push
 
 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnDeleteGroup
----
*������ �������������*:
[code]
�������::btnDeleteGroup TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup
 
 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnDeleteGroup
----
*������ �������������*:
[code]
�������::btnDeleteGroup:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push
 
 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� gbAvailableOperations
----
*������ �������������*:
[code]
�������::gbAvailableOperations TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations
 
 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� gbAvailableOperations
----
*������ �������������*:
[code]
�������::gbAvailableOperations:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push
 
 Tkw_CustomizeTasksPanel_Control_tvRepOps = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvRepOps
----
*������ �������������*:
[code]
�������::tvRepOps TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvRepOps
 
 Tkw_CustomizeTasksPanel_Control_tvRepOps_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvRepOps
----
*������ �������������*:
[code]
�������::tvRepOps:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlForms = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlForms
----
*������ �������������*:
[code]
�������::pnlForms TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlForms
 
 Tkw_CustomizeTasksPanel_Control_pnlForms_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlForms
----
*������ �������������*:
[code]
�������::pnlForms:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push
 
 Tkw_CustomizeTasksPanel_Control_lblForms = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblForms
----
*������ �������������*:
[code]
�������::lblForms TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblForms
 
 Tkw_CustomizeTasksPanel_Control_lblForms_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblForms
----
*������ �������������*:
[code]
�������::lblForms:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push
 
 Tkw_CustomizeTasksPanel_Control_cbForms = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbForms
----
*������ �������������*:
[code]
�������::cbForms TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbForms
 
 Tkw_CustomizeTasksPanel_Control_cbForms_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbForms
----
*������ �������������*:
[code]
�������::cbForms:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlMain = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlMain
 
 Tkw_CustomizeTasksPanel_Control_pnlMain_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlLeft = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlLeft
----
*������ �������������*:
[code]
�������::pnlLeft TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlLeft
 
 Tkw_CustomizeTasksPanel_Control_pnlLeft_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlLeft
----
*������ �������������*:
[code]
�������::pnlLeft:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push
 
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnMoveOpToPanel
----
*������ �������������*:
[code]
�������::btnMoveOpToPanel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel
 
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnMoveOpToPanel
----
*������ �������������*:
[code]
�������::btnMoveOpToPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push
 
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnMoveOpToRep
----
*������ �������������*:
[code]
�������::btnMoveOpToRep TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep
 
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnMoveOpToRep
----
*������ �������������*:
[code]
�������::btnMoveOpToRep:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push
 
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnMoveGroupToPanel
----
*������ �������������*:
[code]
�������::btnMoveGroupToPanel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel
 
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnMoveGroupToPanel
----
*������ �������������*:
[code]
�������::btnMoveGroupToPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push
 
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnMoveGroupToRep
----
*������ �������������*:
[code]
�������::btnMoveGroupToRep TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep
 
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnMoveGroupToRep
----
*������ �������������*:
[code]
�������::btnMoveGroupToRep:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlTasksPanel
----
*������ �������������*:
[code]
�������::pnlTasksPanel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel
 
 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlTasksPanel
----
*������ �������������*:
[code]
�������::pnlTasksPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push
 
 Tkw_CustomizeTasksPanel_Control_gbTasksPanel = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� gbTasksPanel
----
*������ �������������*:
[code]
�������::gbTasksPanel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel
 
 Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� gbTasksPanel
----
*������ �������������*:
[code]
�������::gbTasksPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push
 
 Tkw_CustomizeTasksPanel_Control_tvTasksPanel = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvTasksPanel
----
*������ �������������*:
[code]
�������::tvTasksPanel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel
 
 Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvTasksPanel
----
*������ �������������*:
[code]
�������::tvTasksPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push
 
 Tkw_CustomizeTasksPanel_Control_vtGroupBox3 = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� vtGroupBox3
----
*������ �������������*:
[code]
�������::vtGroupBox3 TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3
 
 Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� vtGroupBox3
----
*������ �������������*:
[code]
�������::vtGroupBox3:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push
 
 Tkw_CustomizeTasksPanel_Control_lblCaption = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblCaption
----
*������ �������������*:
[code]
�������::lblCaption TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblCaption
 
 Tkw_CustomizeTasksPanel_Control_lblCaption_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblCaption
----
*������ �������������*:
[code]
�������::lblCaption:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push
 
 Tkw_CustomizeTasksPanel_Control_edChange = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edChange
----
*������ �������������*:
[code]
�������::edChange TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_edChange
 
 Tkw_CustomizeTasksPanel_Control_edChange_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edChange
----
*������ �������������*:
[code]
�������::edChange:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_edChange_Push
 
 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbForAllUseCases
----
*������ �������������*:
[code]
�������::cbForAllUseCases TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases
 
 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbForAllUseCases
----
*������ �������������*:
[code]
�������::cbForAllUseCases:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push
 
 Tkw_CustomizeTasksPanel_Control_btnChangeItem = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnChangeItem
----
*������ �������������*:
[code]
�������::btnChangeItem TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem
 
 Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnChangeItem
----
*������ �������������*:
[code]
�������::btnChangeItem:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlOperationPos = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlOperationPos
----
*������ �������������*:
[code]
�������::pnlOperationPos TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos
 
 Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlOperationPos
----
*������ �������������*:
[code]
�������::pnlOperationPos:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push
 
 Tkw_CustomizeTasksPanel_Control_UpBitBtn = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� UpBitBtn
----
*������ �������������*:
[code]
�������::UpBitBtn TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn
 
 Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� UpBitBtn
----
*������ �������������*:
[code]
�������::UpBitBtn:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push
 
 Tkw_CustomizeTasksPanel_Control_DownBitBtn = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� DownBitBtn
----
*������ �������������*:
[code]
�������::DownBitBtn TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn
 
 Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� DownBitBtn
----
*������ �������������*:
[code]
�������::DownBitBtn:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push
 
 TkwCustomizeTasksPanelFormSpRight = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.spRight
[panel]������� spRight ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtSplitter
*������:*
[code]
OBJECT VAR l_TvtSplitter
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.spRight >>> l_TvtSplitter
[code]  }
  function spRight(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.spRight }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormSpRight
 
 TkwCustomizeTasksPanelFormPnlBottom = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlBottom
[panel]������� pnlBottom ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlBottom >>> l_TvtPanel
[code]  }
  function pnlBottom(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlBottom }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlBottom
 
 TkwCustomizeTasksPanelFormLblConfirmSave = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblConfirmSave
[panel]������� lblConfirmSave ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblConfirmSave >>> l_TvtLabel
[code]  }
  function lblConfirmSave(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblConfirmSave }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormLblConfirmSave
 
 TkwCustomizeTasksPanelFormLblAvailableOpsCaption = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblAvailableOpsCaption
[panel]������� lblAvailableOpsCaption ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblAvailableOpsCaption >>> l_TvtLabel
[code]  }
  function lblAvailableOpsCaption(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption
 
 TkwCustomizeTasksPanelFormBtOk = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btOk
[panel]������� btOk ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btOk >>> l_TvtButton
[code]  }
  function btOk(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btOk }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtOk
 
 TkwCustomizeTasksPanelFormBtCancel = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btCancel
[panel]������� btCancel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btCancel >>> l_TvtButton
[code]  }
  function btCancel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btCancel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtCancel
 
 TkwCustomizeTasksPanelFormBtApply = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btApply
[panel]������� btApply ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btApply >>> l_TvtButton
[code]  }
  function btApply(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btApply }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtApply
 
 TkwCustomizeTasksPanelFormPnlRep = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlRep
[panel]������� pnlRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlRep >>> l_TvtPanel
[code]  }
  function pnlRep(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlRep }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlRep
 
 TkwCustomizeTasksPanelFormSplRep = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.splRep
[panel]������� splRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtSplitter
*������:*
[code]
OBJECT VAR l_TvtSplitter
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.splRep >>> l_TvtSplitter
[code]  }
  function splRep(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.splRep }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormSplRep
 
 TkwCustomizeTasksPanelFormGbAvailableGroups = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.gbAvailableGroups
[panel]������� gbAvailableGroups ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbAvailableGroups >>> l_TvtGroupBox
[code]  }
  function gbAvailableGroups(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableGroups }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormGbAvailableGroups
 
 TkwCustomizeTasksPanelFormTvRepGroups = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.tvRepGroups
[panel]������� tvRepGroups ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvRepGroups >>> l_TeeTreeView
[code]  }
  function tvRepGroups(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepGroups }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormTvRepGroups
 
 TkwCustomizeTasksPanelFormVtPanel1 = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.vtPanel1
[panel]������� vtPanel1 ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.vtPanel1 >>> l_TvtPanel
[code]  }
  function vtPanel1(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtPanel1 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormVtPanel1
 
 TkwCustomizeTasksPanelFormCbGroupName = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.cbGroupName
[panel]������� cbGroupName ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtComboBox
*������:*
[code]
OBJECT VAR l_TvtComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbGroupName >>> l_TvtComboBox
[code]  }
  function cbGroupName(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbGroupName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormCbGroupName
 
 TkwCustomizeTasksPanelFormBtnAddGroup = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnAddGroup
[panel]������� btnAddGroup ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnAddGroup >>> l_TeeButton
[code]  }
  function btnAddGroup(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnAddGroup }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnAddGroup
 
 TkwCustomizeTasksPanelFormBtnChangeGroup = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnChangeGroup
[panel]������� btnChangeGroup ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnChangeGroup >>> l_TeeButton
[code]  }
  function btnChangeGroup(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeGroup }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnChangeGroup
 
 TkwCustomizeTasksPanelFormBtnDeleteGroup = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnDeleteGroup
[panel]������� btnDeleteGroup ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnDeleteGroup >>> l_TeeButton
[code]  }
  function btnDeleteGroup(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnDeleteGroup }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnDeleteGroup
 
 TkwCustomizeTasksPanelFormGbAvailableOperations = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.gbAvailableOperations
[panel]������� gbAvailableOperations ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbAvailableOperations >>> l_TvtGroupBox
[code]  }
  function gbAvailableOperations(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbAvailableOperations }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormGbAvailableOperations
 
 TkwCustomizeTasksPanelFormTvRepOps = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.tvRepOps
[panel]������� tvRepOps ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvRepOps >>> l_TeeTreeView
[code]  }
  function tvRepOps(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvRepOps }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormTvRepOps
 
 TkwCustomizeTasksPanelFormPnlForms = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlForms
[panel]������� pnlForms ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlForms >>> l_TvtPanel
[code]  }
  function pnlForms(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlForms }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlForms
 
 TkwCustomizeTasksPanelFormLblForms = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblForms
[panel]������� lblForms ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblForms >>> l_TvtLabel
[code]  }
  function lblForms(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblForms }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormLblForms
 
 TkwCustomizeTasksPanelFormCbForms = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.cbForms
[panel]������� cbForms ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TComboBox
*������:*
[code]
OBJECT VAR l_TComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbForms >>> l_TComboBox
[code]  }
  function cbForms(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForms }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormCbForms
 
 TkwCustomizeTasksPanelFormPnlMain = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlMain
[panel]������� pnlMain ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlMain >>> l_TvtPanel
[code]  }
  function pnlMain(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlMain }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlMain
 
 TkwCustomizeTasksPanelFormPnlLeft = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlLeft
[panel]������� pnlLeft ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlLeft >>> l_TvtPanel
[code]  }
  function pnlLeft(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlLeft }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlLeft
 
 TkwCustomizeTasksPanelFormBtnMoveOpToPanel = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToPanel
[panel]������� btnMoveOpToPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveOpToPanel >>> l_TBitBtn
[code]  }
  function btnMoveOpToPanel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel
 
 TkwCustomizeTasksPanelFormBtnMoveOpToRep = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToRep
[panel]������� btnMoveOpToRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveOpToRep >>> l_TBitBtn
[code]  }
  function btnMoveOpToRep(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveOpToRep }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep
 
 TkwCustomizeTasksPanelFormBtnMoveGroupToPanel = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToPanel
[panel]������� btnMoveGroupToPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveGroupToPanel >>> l_TBitBtn
[code]  }
  function btnMoveGroupToPanel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel
 
 TkwCustomizeTasksPanelFormBtnMoveGroupToRep = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToRep
[panel]������� btnMoveGroupToRep ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveGroupToRep >>> l_TBitBtn
[code]  }
  function btnMoveGroupToRep(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnMoveGroupToRep }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep
 
 TkwCustomizeTasksPanelFormPnlTasksPanel = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlTasksPanel
[panel]������� pnlTasksPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlTasksPanel >>> l_TvtPanel
[code]  }
  function pnlTasksPanel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlTasksPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlTasksPanel
 
 TkwCustomizeTasksPanelFormGbTasksPanel = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.gbTasksPanel
[panel]������� gbTasksPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbTasksPanel >>> l_TvtGroupBox
[code]  }
  function gbTasksPanel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.gbTasksPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormGbTasksPanel
 
 TkwCustomizeTasksPanelFormTvTasksPanel = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.tvTasksPanel
[panel]������� tvTasksPanel ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvTasksPanel >>> l_TeeTreeView
[code]  }
  function tvTasksPanel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.tvTasksPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormTvTasksPanel
 
 TkwCustomizeTasksPanelFormVtGroupBox3 = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.vtGroupBox3
[panel]������� vtGroupBox3 ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.vtGroupBox3 >>> l_TvtGroupBox
[code]  }
  function vtGroupBox3(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.vtGroupBox3 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormVtGroupBox3
 
 TkwCustomizeTasksPanelFormLblCaption = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.lblCaption
[panel]������� lblCaption ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblCaption >>> l_TvtLabel
[code]  }
  function lblCaption(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.lblCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormLblCaption
 
 TkwCustomizeTasksPanelFormEdChange = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.edChange
[panel]������� edChange ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtComboBox
*������:*
[code]
OBJECT VAR l_TvtComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.edChange >>> l_TvtComboBox
[code]  }
  function edChange(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.edChange }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormEdChange
 
 TkwCustomizeTasksPanelFormCbForAllUseCases = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.cbForAllUseCases
[panel]������� cbForAllUseCases ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeCheckBox
*������:*
[code]
OBJECT VAR l_TeeCheckBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbForAllUseCases >>> l_TeeCheckBox
[code]  }
  function cbForAllUseCases(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.cbForAllUseCases }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormCbForAllUseCases
 
 TkwCustomizeTasksPanelFormBtnChangeItem = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.btnChangeItem
[panel]������� btnChangeItem ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TeeButton
*������:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnChangeItem >>> l_TeeButton
[code]  }
  function btnChangeItem(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.btnChangeItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnChangeItem
 
 TkwCustomizeTasksPanelFormPnlOperationPos = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.pnlOperationPos
[panel]������� pnlOperationPos ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlOperationPos >>> l_TvtPanel
[code]  }
  function pnlOperationPos(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.pnlOperationPos }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlOperationPos
 
 TkwCustomizeTasksPanelFormUpBitBtn = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.UpBitBtn
[panel]������� UpBitBtn ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.UpBitBtn >>> l_TBitBtn
[code]  }
  function UpBitBtn(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.UpBitBtn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormUpBitBtn
 
 TkwCustomizeTasksPanelFormDownBitBtn = class(TtfwPropertyLike)
  {* ����� ������� .TCustomizeTasksPanelForm.DownBitBtn
[panel]������� DownBitBtn ����� TCustomizeTasksPanelForm[panel]
*��� ����������:* TBitBtn
*������:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.DownBitBtn >>> l_TBitBtn
[code]  }
  function DownBitBtn(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* ���������� ����� ������� .TCustomizeTasksPanelForm.DownBitBtn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormDownBitBtn
 
end.
