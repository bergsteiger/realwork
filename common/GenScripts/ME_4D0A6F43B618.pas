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
  {* Слово словаря для идентификатора формы CustomizeTasksPanel
----
*Пример использования*:
[code]
'aControl' форма::CustomizeTasksPanel TryFocus ASSERT
[code] }
 end;//Tkw_Form_CustomizeTasksPanel
 
 Tkw_CustomizeTasksPanel_Control_spRight = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола spRight
----
*Пример использования*:
[code]
контрол::spRight TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_spRight
 
 Tkw_CustomizeTasksPanel_Control_spRight_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола spRight
----
*Пример использования*:
[code]
контрол::spRight:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_spRight_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlBottom = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlBottom
----
*Пример использования*:
[code]
контрол::pnlBottom TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlBottom
 
 Tkw_CustomizeTasksPanel_Control_pnlBottom_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlBottom
----
*Пример использования*:
[code]
контрол::pnlBottom:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push
 
 Tkw_CustomizeTasksPanel_Control_lblConfirmSave = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblConfirmSave
----
*Пример использования*:
[code]
контрол::lblConfirmSave TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave
 
 Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола lblConfirmSave
----
*Пример использования*:
[code]
контрол::lblConfirmSave:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push
 
 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblAvailableOpsCaption
----
*Пример использования*:
[code]
контрол::lblAvailableOpsCaption TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption
 
 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола lblAvailableOpsCaption
----
*Пример использования*:
[code]
контрол::lblAvailableOpsCaption:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push
 
 Tkw_CustomizeTasksPanel_Control_btOk = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btOk
----
*Пример использования*:
[code]
контрол::btOk TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btOk
 
 Tkw_CustomizeTasksPanel_Control_btOk_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btOk
----
*Пример использования*:
[code]
контрол::btOk:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btOk_Push
 
 Tkw_CustomizeTasksPanel_Control_btCancel = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btCancel
----
*Пример использования*:
[code]
контрол::btCancel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btCancel
 
 Tkw_CustomizeTasksPanel_Control_btCancel_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btCancel
----
*Пример использования*:
[code]
контрол::btCancel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push
 
 Tkw_CustomizeTasksPanel_Control_btApply = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btApply
----
*Пример использования*:
[code]
контрол::btApply TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btApply
 
 Tkw_CustomizeTasksPanel_Control_btApply_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btApply
----
*Пример использования*:
[code]
контрол::btApply:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btApply_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlRep = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlRep
----
*Пример использования*:
[code]
контрол::pnlRep TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlRep
 
 Tkw_CustomizeTasksPanel_Control_pnlRep_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlRep
----
*Пример использования*:
[code]
контрол::pnlRep:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push
 
 Tkw_CustomizeTasksPanel_Control_splRep = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола splRep
----
*Пример использования*:
[code]
контрол::splRep TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_splRep
 
 Tkw_CustomizeTasksPanel_Control_splRep_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола splRep
----
*Пример использования*:
[code]
контрол::splRep:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_splRep_Push
 
 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола gbAvailableGroups
----
*Пример использования*:
[code]
контрол::gbAvailableGroups TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups
 
 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола gbAvailableGroups
----
*Пример использования*:
[code]
контрол::gbAvailableGroups:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push
 
 Tkw_CustomizeTasksPanel_Control_tvRepGroups = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvRepGroups
----
*Пример использования*:
[code]
контрол::tvRepGroups TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups
 
 Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола tvRepGroups
----
*Пример использования*:
[code]
контрол::tvRepGroups:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push
 
 Tkw_CustomizeTasksPanel_Control_vtPanel1 = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vtPanel1
----
*Пример использования*:
[code]
контрол::vtPanel1 TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_vtPanel1
 
 Tkw_CustomizeTasksPanel_Control_vtPanel1_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола vtPanel1
----
*Пример использования*:
[code]
контрол::vtPanel1:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push
 
 Tkw_CustomizeTasksPanel_Control_cbGroupName = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbGroupName
----
*Пример использования*:
[code]
контрол::cbGroupName TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbGroupName
 
 Tkw_CustomizeTasksPanel_Control_cbGroupName_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола cbGroupName
----
*Пример использования*:
[code]
контрол::cbGroupName:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push
 
 Tkw_CustomizeTasksPanel_Control_btnAddGroup = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnAddGroup
----
*Пример использования*:
[code]
контрол::btnAddGroup TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup
 
 Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btnAddGroup
----
*Пример использования*:
[code]
контрол::btnAddGroup:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push
 
 Tkw_CustomizeTasksPanel_Control_btnChangeGroup = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnChangeGroup
----
*Пример использования*:
[code]
контрол::btnChangeGroup TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup
 
 Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btnChangeGroup
----
*Пример использования*:
[code]
контрол::btnChangeGroup:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push
 
 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnDeleteGroup
----
*Пример использования*:
[code]
контрол::btnDeleteGroup TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup
 
 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btnDeleteGroup
----
*Пример использования*:
[code]
контрол::btnDeleteGroup:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push
 
 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола gbAvailableOperations
----
*Пример использования*:
[code]
контрол::gbAvailableOperations TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations
 
 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола gbAvailableOperations
----
*Пример использования*:
[code]
контрол::gbAvailableOperations:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push
 
 Tkw_CustomizeTasksPanel_Control_tvRepOps = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvRepOps
----
*Пример использования*:
[code]
контрол::tvRepOps TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvRepOps
 
 Tkw_CustomizeTasksPanel_Control_tvRepOps_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола tvRepOps
----
*Пример использования*:
[code]
контрол::tvRepOps:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlForms = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlForms
----
*Пример использования*:
[code]
контрол::pnlForms TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlForms
 
 Tkw_CustomizeTasksPanel_Control_pnlForms_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlForms
----
*Пример использования*:
[code]
контрол::pnlForms:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push
 
 Tkw_CustomizeTasksPanel_Control_lblForms = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblForms
----
*Пример использования*:
[code]
контрол::lblForms TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblForms
 
 Tkw_CustomizeTasksPanel_Control_lblForms_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола lblForms
----
*Пример использования*:
[code]
контрол::lblForms:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push
 
 Tkw_CustomizeTasksPanel_Control_cbForms = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbForms
----
*Пример использования*:
[code]
контрол::cbForms TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbForms
 
 Tkw_CustomizeTasksPanel_Control_cbForms_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола cbForms
----
*Пример использования*:
[code]
контрол::cbForms:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlMain = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlMain
----
*Пример использования*:
[code]
контрол::pnlMain TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlMain
 
 Tkw_CustomizeTasksPanel_Control_pnlMain_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlMain
----
*Пример использования*:
[code]
контрол::pnlMain:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlLeft = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlLeft
----
*Пример использования*:
[code]
контрол::pnlLeft TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlLeft
 
 Tkw_CustomizeTasksPanel_Control_pnlLeft_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlLeft
----
*Пример использования*:
[code]
контрол::pnlLeft:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push
 
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnMoveOpToPanel
----
*Пример использования*:
[code]
контрол::btnMoveOpToPanel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel
 
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btnMoveOpToPanel
----
*Пример использования*:
[code]
контрол::btnMoveOpToPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push
 
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnMoveOpToRep
----
*Пример использования*:
[code]
контрол::btnMoveOpToRep TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep
 
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btnMoveOpToRep
----
*Пример использования*:
[code]
контрол::btnMoveOpToRep:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push
 
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnMoveGroupToPanel
----
*Пример использования*:
[code]
контрол::btnMoveGroupToPanel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel
 
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btnMoveGroupToPanel
----
*Пример использования*:
[code]
контрол::btnMoveGroupToPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push
 
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnMoveGroupToRep
----
*Пример использования*:
[code]
контрол::btnMoveGroupToRep TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep
 
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btnMoveGroupToRep
----
*Пример использования*:
[code]
контрол::btnMoveGroupToRep:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlTasksPanel
----
*Пример использования*:
[code]
контрол::pnlTasksPanel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel
 
 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlTasksPanel
----
*Пример использования*:
[code]
контрол::pnlTasksPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push
 
 Tkw_CustomizeTasksPanel_Control_gbTasksPanel = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола gbTasksPanel
----
*Пример использования*:
[code]
контрол::gbTasksPanel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel
 
 Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола gbTasksPanel
----
*Пример использования*:
[code]
контрол::gbTasksPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push
 
 Tkw_CustomizeTasksPanel_Control_tvTasksPanel = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvTasksPanel
----
*Пример использования*:
[code]
контрол::tvTasksPanel TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel
 
 Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола tvTasksPanel
----
*Пример использования*:
[code]
контрол::tvTasksPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push
 
 Tkw_CustomizeTasksPanel_Control_vtGroupBox3 = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vtGroupBox3
----
*Пример использования*:
[code]
контрол::vtGroupBox3 TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3
 
 Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола vtGroupBox3
----
*Пример использования*:
[code]
контрол::vtGroupBox3:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push
 
 Tkw_CustomizeTasksPanel_Control_lblCaption = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblCaption
----
*Пример использования*:
[code]
контрол::lblCaption TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblCaption
 
 Tkw_CustomizeTasksPanel_Control_lblCaption_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола lblCaption
----
*Пример использования*:
[code]
контрол::lblCaption:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push
 
 Tkw_CustomizeTasksPanel_Control_edChange = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edChange
----
*Пример использования*:
[code]
контрол::edChange TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_edChange
 
 Tkw_CustomizeTasksPanel_Control_edChange_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола edChange
----
*Пример использования*:
[code]
контрол::edChange:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_edChange_Push
 
 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbForAllUseCases
----
*Пример использования*:
[code]
контрол::cbForAllUseCases TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases
 
 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола cbForAllUseCases
----
*Пример использования*:
[code]
контрол::cbForAllUseCases:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push
 
 Tkw_CustomizeTasksPanel_Control_btnChangeItem = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnChangeItem
----
*Пример использования*:
[code]
контрол::btnChangeItem TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem
 
 Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола btnChangeItem
----
*Пример использования*:
[code]
контрол::btnChangeItem:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push
 
 Tkw_CustomizeTasksPanel_Control_pnlOperationPos = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlOperationPos
----
*Пример использования*:
[code]
контрол::pnlOperationPos TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos
 
 Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlOperationPos
----
*Пример использования*:
[code]
контрол::pnlOperationPos:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push
 
 Tkw_CustomizeTasksPanel_Control_UpBitBtn = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола UpBitBtn
----
*Пример использования*:
[code]
контрол::UpBitBtn TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn
 
 Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола UpBitBtn
----
*Пример использования*:
[code]
контрол::UpBitBtn:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push
 
 Tkw_CustomizeTasksPanel_Control_DownBitBtn = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола DownBitBtn
----
*Пример использования*:
[code]
контрол::DownBitBtn TryFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn
 
 Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола DownBitBtn
----
*Пример использования*:
[code]
контрол::DownBitBtn:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push
 
 TkwCustomizeTasksPanelFormSpRight = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.spRight
[panel]Контрол spRight формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtSplitter
*Пример:*
[code]
OBJECT VAR l_TvtSplitter
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.spRight >>> l_TvtSplitter
[code]  }
  function spRight(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.spRight }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormSpRight
 
 TkwCustomizeTasksPanelFormPnlBottom = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlBottom
[panel]Контрол pnlBottom формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlBottom >>> l_TvtPanel
[code]  }
  function pnlBottom(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlBottom }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlBottom
 
 TkwCustomizeTasksPanelFormLblConfirmSave = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.lblConfirmSave
[panel]Контрол lblConfirmSave формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblConfirmSave >>> l_TvtLabel
[code]  }
  function lblConfirmSave(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblConfirmSave }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormLblConfirmSave
 
 TkwCustomizeTasksPanelFormLblAvailableOpsCaption = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.lblAvailableOpsCaption
[panel]Контрол lblAvailableOpsCaption формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblAvailableOpsCaption >>> l_TvtLabel
[code]  }
  function lblAvailableOpsCaption(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption
 
 TkwCustomizeTasksPanelFormBtOk = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btOk
[panel]Контрол btOk формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btOk >>> l_TvtButton
[code]  }
  function btOk(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btOk }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtOk
 
 TkwCustomizeTasksPanelFormBtCancel = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btCancel
[panel]Контрол btCancel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btCancel >>> l_TvtButton
[code]  }
  function btCancel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btCancel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtCancel
 
 TkwCustomizeTasksPanelFormBtApply = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btApply
[panel]Контрол btApply формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btApply >>> l_TvtButton
[code]  }
  function btApply(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btApply }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtApply
 
 TkwCustomizeTasksPanelFormPnlRep = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlRep
[panel]Контрол pnlRep формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlRep >>> l_TvtPanel
[code]  }
  function pnlRep(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlRep }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlRep
 
 TkwCustomizeTasksPanelFormSplRep = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.splRep
[panel]Контрол splRep формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtSplitter
*Пример:*
[code]
OBJECT VAR l_TvtSplitter
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.splRep >>> l_TvtSplitter
[code]  }
  function splRep(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.splRep }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormSplRep
 
 TkwCustomizeTasksPanelFormGbAvailableGroups = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.gbAvailableGroups
[panel]Контрол gbAvailableGroups формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbAvailableGroups >>> l_TvtGroupBox
[code]  }
  function gbAvailableGroups(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbAvailableGroups }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormGbAvailableGroups
 
 TkwCustomizeTasksPanelFormTvRepGroups = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.tvRepGroups
[panel]Контрол tvRepGroups формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvRepGroups >>> l_TeeTreeView
[code]  }
  function tvRepGroups(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvRepGroups }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormTvRepGroups
 
 TkwCustomizeTasksPanelFormVtPanel1 = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.vtPanel1
[panel]Контрол vtPanel1 формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.vtPanel1 >>> l_TvtPanel
[code]  }
  function vtPanel1(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.vtPanel1 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormVtPanel1
 
 TkwCustomizeTasksPanelFormCbGroupName = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.cbGroupName
[panel]Контрол cbGroupName формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtComboBox
*Пример:*
[code]
OBJECT VAR l_TvtComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbGroupName >>> l_TvtComboBox
[code]  }
  function cbGroupName(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbGroupName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormCbGroupName
 
 TkwCustomizeTasksPanelFormBtnAddGroup = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btnAddGroup
[panel]Контрол btnAddGroup формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeButton
*Пример:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnAddGroup >>> l_TeeButton
[code]  }
  function btnAddGroup(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnAddGroup }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnAddGroup
 
 TkwCustomizeTasksPanelFormBtnChangeGroup = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btnChangeGroup
[panel]Контрол btnChangeGroup формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeButton
*Пример:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnChangeGroup >>> l_TeeButton
[code]  }
  function btnChangeGroup(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnChangeGroup }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnChangeGroup
 
 TkwCustomizeTasksPanelFormBtnDeleteGroup = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btnDeleteGroup
[panel]Контрол btnDeleteGroup формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeButton
*Пример:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnDeleteGroup >>> l_TeeButton
[code]  }
  function btnDeleteGroup(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnDeleteGroup }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnDeleteGroup
 
 TkwCustomizeTasksPanelFormGbAvailableOperations = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.gbAvailableOperations
[panel]Контрол gbAvailableOperations формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbAvailableOperations >>> l_TvtGroupBox
[code]  }
  function gbAvailableOperations(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbAvailableOperations }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormGbAvailableOperations
 
 TkwCustomizeTasksPanelFormTvRepOps = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.tvRepOps
[panel]Контрол tvRepOps формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvRepOps >>> l_TeeTreeView
[code]  }
  function tvRepOps(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvRepOps }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormTvRepOps
 
 TkwCustomizeTasksPanelFormPnlForms = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlForms
[panel]Контрол pnlForms формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlForms >>> l_TvtPanel
[code]  }
  function pnlForms(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlForms }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlForms
 
 TkwCustomizeTasksPanelFormLblForms = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.lblForms
[panel]Контрол lblForms формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblForms >>> l_TvtLabel
[code]  }
  function lblForms(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblForms }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormLblForms
 
 TkwCustomizeTasksPanelFormCbForms = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.cbForms
[panel]Контрол cbForms формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TComboBox
*Пример:*
[code]
OBJECT VAR l_TComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbForms >>> l_TComboBox
[code]  }
  function cbForms(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbForms }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormCbForms
 
 TkwCustomizeTasksPanelFormPnlMain = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlMain
[panel]Контрол pnlMain формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlMain >>> l_TvtPanel
[code]  }
  function pnlMain(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlMain }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlMain
 
 TkwCustomizeTasksPanelFormPnlLeft = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlLeft
[panel]Контрол pnlLeft формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlLeft >>> l_TvtPanel
[code]  }
  function pnlLeft(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlLeft }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlLeft
 
 TkwCustomizeTasksPanelFormBtnMoveOpToPanel = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveOpToPanel
[panel]Контрол btnMoveOpToPanel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveOpToPanel >>> l_TBitBtn
[code]  }
  function btnMoveOpToPanel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveOpToPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel
 
 TkwCustomizeTasksPanelFormBtnMoveOpToRep = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveOpToRep
[panel]Контрол btnMoveOpToRep формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveOpToRep >>> l_TBitBtn
[code]  }
  function btnMoveOpToRep(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveOpToRep }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep
 
 TkwCustomizeTasksPanelFormBtnMoveGroupToPanel = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveGroupToPanel
[panel]Контрол btnMoveGroupToPanel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveGroupToPanel >>> l_TBitBtn
[code]  }
  function btnMoveGroupToPanel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel
 
 TkwCustomizeTasksPanelFormBtnMoveGroupToRep = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveGroupToRep
[panel]Контрол btnMoveGroupToRep формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveGroupToRep >>> l_TBitBtn
[code]  }
  function btnMoveGroupToRep(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveGroupToRep }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep
 
 TkwCustomizeTasksPanelFormPnlTasksPanel = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlTasksPanel
[panel]Контрол pnlTasksPanel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlTasksPanel >>> l_TvtPanel
[code]  }
  function pnlTasksPanel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlTasksPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlTasksPanel
 
 TkwCustomizeTasksPanelFormGbTasksPanel = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.gbTasksPanel
[panel]Контрол gbTasksPanel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbTasksPanel >>> l_TvtGroupBox
[code]  }
  function gbTasksPanel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbTasksPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormGbTasksPanel
 
 TkwCustomizeTasksPanelFormTvTasksPanel = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.tvTasksPanel
[panel]Контрол tvTasksPanel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvTasksPanel >>> l_TeeTreeView
[code]  }
  function tvTasksPanel(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvTasksPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormTvTasksPanel
 
 TkwCustomizeTasksPanelFormVtGroupBox3 = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.vtGroupBox3
[panel]Контрол vtGroupBox3 формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.vtGroupBox3 >>> l_TvtGroupBox
[code]  }
  function vtGroupBox3(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.vtGroupBox3 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormVtGroupBox3
 
 TkwCustomizeTasksPanelFormLblCaption = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.lblCaption
[panel]Контрол lblCaption формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblCaption >>> l_TvtLabel
[code]  }
  function lblCaption(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormLblCaption
 
 TkwCustomizeTasksPanelFormEdChange = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.edChange
[panel]Контрол edChange формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtComboBox
*Пример:*
[code]
OBJECT VAR l_TvtComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.edChange >>> l_TvtComboBox
[code]  }
  function edChange(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.edChange }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormEdChange
 
 TkwCustomizeTasksPanelFormCbForAllUseCases = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.cbForAllUseCases
[panel]Контрол cbForAllUseCases формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeCheckBox
*Пример:*
[code]
OBJECT VAR l_TeeCheckBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbForAllUseCases >>> l_TeeCheckBox
[code]  }
  function cbForAllUseCases(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbForAllUseCases }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormCbForAllUseCases
 
 TkwCustomizeTasksPanelFormBtnChangeItem = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.btnChangeItem
[panel]Контрол btnChangeItem формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeButton
*Пример:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnChangeItem >>> l_TeeButton
[code]  }
  function btnChangeItem(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnChangeItem }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormBtnChangeItem
 
 TkwCustomizeTasksPanelFormPnlOperationPos = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlOperationPos
[panel]Контрол pnlOperationPos формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlOperationPos >>> l_TvtPanel
[code]  }
  function pnlOperationPos(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlOperationPos }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormPnlOperationPos
 
 TkwCustomizeTasksPanelFormUpBitBtn = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.UpBitBtn
[panel]Контрол UpBitBtn формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.UpBitBtn >>> l_TBitBtn
[code]  }
  function UpBitBtn(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.UpBitBtn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormUpBitBtn
 
 TkwCustomizeTasksPanelFormDownBitBtn = class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.DownBitBtn
[panel]Контрол DownBitBtn формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.DownBitBtn >>> l_TBitBtn
[code]  }
  function DownBitBtn(const aCtx: TtfwContext;
   aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
   {* Реализация слова скрипта .TCustomizeTasksPanelForm.DownBitBtn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCustomizeTasksPanelFormDownBitBtn
 
end.
