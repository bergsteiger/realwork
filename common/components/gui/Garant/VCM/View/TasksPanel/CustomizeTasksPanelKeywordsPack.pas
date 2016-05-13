unit CustomizeTasksPanelKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы CustomizeTasksPanel }

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\CustomizeTasksPanelKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "CustomizeTasksPanelKeywordsPack" MUID: (4D0A6F43B618)

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
  {* Слово словаря для идентификатора формы CustomizeTasksPanel
----
*Пример использования*:
[code]
'aControl' форма::CustomizeTasksPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_CustomizeTasksPanel

 Tkw_CustomizeTasksPanel_Control_spRight = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола spRight
----
*Пример использования*:
[code]
контрол::spRight TryFocus ASSERT
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
  {* Слово словаря для контрола spRight
----
*Пример использования*:
[code]
контрол::spRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_spRight_Push

 Tkw_CustomizeTasksPanel_Control_pnlBottom = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlBottom
----
*Пример использования*:
[code]
контрол::pnlBottom TryFocus ASSERT
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
  {* Слово словаря для контрола pnlBottom
----
*Пример использования*:
[code]
контрол::pnlBottom:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push

 Tkw_CustomizeTasksPanel_Control_lblConfirmSave = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblConfirmSave
----
*Пример использования*:
[code]
контрол::lblConfirmSave TryFocus ASSERT
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
  {* Слово словаря для контрола lblConfirmSave
----
*Пример использования*:
[code]
контрол::lblConfirmSave:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push

 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblAvailableOpsCaption
----
*Пример использования*:
[code]
контрол::lblAvailableOpsCaption TryFocus ASSERT
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
  {* Слово словаря для контрола lblAvailableOpsCaption
----
*Пример использования*:
[code]
контрол::lblAvailableOpsCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push

 Tkw_CustomizeTasksPanel_Control_btOk = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btOk
----
*Пример использования*:
[code]
контрол::btOk TryFocus ASSERT
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
  {* Слово словаря для контрола btOk
----
*Пример использования*:
[code]
контрол::btOk:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btOk_Push

 Tkw_CustomizeTasksPanel_Control_btCancel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btCancel
----
*Пример использования*:
[code]
контрол::btCancel TryFocus ASSERT
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
  {* Слово словаря для контрола btCancel
----
*Пример использования*:
[code]
контрол::btCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push

 Tkw_CustomizeTasksPanel_Control_btApply = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btApply
----
*Пример использования*:
[code]
контрол::btApply TryFocus ASSERT
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
  {* Слово словаря для контрола btApply
----
*Пример использования*:
[code]
контрол::btApply:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btApply_Push

 Tkw_CustomizeTasksPanel_Control_pnlRep = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlRep
----
*Пример использования*:
[code]
контрол::pnlRep TryFocus ASSERT
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
  {* Слово словаря для контрола pnlRep
----
*Пример использования*:
[code]
контрол::pnlRep:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push

 Tkw_CustomizeTasksPanel_Control_splRep = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола splRep
----
*Пример использования*:
[code]
контрол::splRep TryFocus ASSERT
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
  {* Слово словаря для контрола splRep
----
*Пример использования*:
[code]
контрол::splRep:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_splRep_Push

 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола gbAvailableGroups
----
*Пример использования*:
[code]
контрол::gbAvailableGroups TryFocus ASSERT
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
  {* Слово словаря для контрола gbAvailableGroups
----
*Пример использования*:
[code]
контрол::gbAvailableGroups:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push

 Tkw_CustomizeTasksPanel_Control_tvRepGroups = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvRepGroups
----
*Пример использования*:
[code]
контрол::tvRepGroups TryFocus ASSERT
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
  {* Слово словаря для контрола tvRepGroups
----
*Пример использования*:
[code]
контрол::tvRepGroups:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push

 Tkw_CustomizeTasksPanel_Control_vtPanel1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vtPanel1
----
*Пример использования*:
[code]
контрол::vtPanel1 TryFocus ASSERT
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
  {* Слово словаря для контрола vtPanel1
----
*Пример использования*:
[code]
контрол::vtPanel1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push

 Tkw_CustomizeTasksPanel_Control_cbGroupName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbGroupName
----
*Пример использования*:
[code]
контрол::cbGroupName TryFocus ASSERT
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
  {* Слово словаря для контрола cbGroupName
----
*Пример использования*:
[code]
контрол::cbGroupName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push

 Tkw_CustomizeTasksPanel_Control_btnAddGroup = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnAddGroup
----
*Пример использования*:
[code]
контрол::btnAddGroup TryFocus ASSERT
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
  {* Слово словаря для контрола btnAddGroup
----
*Пример использования*:
[code]
контрол::btnAddGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push

 Tkw_CustomizeTasksPanel_Control_btnChangeGroup = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnChangeGroup
----
*Пример использования*:
[code]
контрол::btnChangeGroup TryFocus ASSERT
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
  {* Слово словаря для контрола btnChangeGroup
----
*Пример использования*:
[code]
контрол::btnChangeGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push

 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnDeleteGroup
----
*Пример использования*:
[code]
контрол::btnDeleteGroup TryFocus ASSERT
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
  {* Слово словаря для контрола btnDeleteGroup
----
*Пример использования*:
[code]
контрол::btnDeleteGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push

 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола gbAvailableOperations
----
*Пример использования*:
[code]
контрол::gbAvailableOperations TryFocus ASSERT
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
  {* Слово словаря для контрола gbAvailableOperations
----
*Пример использования*:
[code]
контрол::gbAvailableOperations:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push

 Tkw_CustomizeTasksPanel_Control_tvRepOps = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvRepOps
----
*Пример использования*:
[code]
контрол::tvRepOps TryFocus ASSERT
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
  {* Слово словаря для контрола tvRepOps
----
*Пример использования*:
[code]
контрол::tvRepOps:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push

 Tkw_CustomizeTasksPanel_Control_pnlForms = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlForms
----
*Пример использования*:
[code]
контрол::pnlForms TryFocus ASSERT
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
  {* Слово словаря для контрола pnlForms
----
*Пример использования*:
[code]
контрол::pnlForms:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push

 Tkw_CustomizeTasksPanel_Control_lblForms = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblForms
----
*Пример использования*:
[code]
контрол::lblForms TryFocus ASSERT
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
  {* Слово словаря для контрола lblForms
----
*Пример использования*:
[code]
контрол::lblForms:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push

 Tkw_CustomizeTasksPanel_Control_cbForms = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbForms
----
*Пример использования*:
[code]
контрол::cbForms TryFocus ASSERT
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
  {* Слово словаря для контрола cbForms
----
*Пример использования*:
[code]
контрол::cbForms:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push

 Tkw_CustomizeTasksPanel_Control_pnlMain = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlMain
----
*Пример использования*:
[code]
контрол::pnlMain TryFocus ASSERT
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
  {* Слово словаря для контрола pnlMain
----
*Пример использования*:
[code]
контрол::pnlMain:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push

 Tkw_CustomizeTasksPanel_Control_pnlLeft = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlLeft
----
*Пример использования*:
[code]
контрол::pnlLeft TryFocus ASSERT
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
  {* Слово словаря для контрола pnlLeft
----
*Пример использования*:
[code]
контрол::pnlLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push

 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnMoveOpToPanel
----
*Пример использования*:
[code]
контрол::btnMoveOpToPanel TryFocus ASSERT
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
  {* Слово словаря для контрола btnMoveOpToPanel
----
*Пример использования*:
[code]
контрол::btnMoveOpToPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push

 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnMoveOpToRep
----
*Пример использования*:
[code]
контрол::btnMoveOpToRep TryFocus ASSERT
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
  {* Слово словаря для контрола btnMoveOpToRep
----
*Пример использования*:
[code]
контрол::btnMoveOpToRep:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push

 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnMoveGroupToPanel
----
*Пример использования*:
[code]
контрол::btnMoveGroupToPanel TryFocus ASSERT
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
  {* Слово словаря для контрола btnMoveGroupToPanel
----
*Пример использования*:
[code]
контрол::btnMoveGroupToPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push

 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnMoveGroupToRep
----
*Пример использования*:
[code]
контрол::btnMoveGroupToRep TryFocus ASSERT
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
  {* Слово словаря для контрола btnMoveGroupToRep
----
*Пример использования*:
[code]
контрол::btnMoveGroupToRep:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push

 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlTasksPanel
----
*Пример использования*:
[code]
контрол::pnlTasksPanel TryFocus ASSERT
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
  {* Слово словаря для контрола pnlTasksPanel
----
*Пример использования*:
[code]
контрол::pnlTasksPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push

 Tkw_CustomizeTasksPanel_Control_gbTasksPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола gbTasksPanel
----
*Пример использования*:
[code]
контрол::gbTasksPanel TryFocus ASSERT
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
  {* Слово словаря для контрола gbTasksPanel
----
*Пример использования*:
[code]
контрол::gbTasksPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push

 Tkw_CustomizeTasksPanel_Control_tvTasksPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvTasksPanel
----
*Пример использования*:
[code]
контрол::tvTasksPanel TryFocus ASSERT
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
  {* Слово словаря для контрола tvTasksPanel
----
*Пример использования*:
[code]
контрол::tvTasksPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push

 Tkw_CustomizeTasksPanel_Control_vtGroupBox3 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vtGroupBox3
----
*Пример использования*:
[code]
контрол::vtGroupBox3 TryFocus ASSERT
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
  {* Слово словаря для контрола vtGroupBox3
----
*Пример использования*:
[code]
контрол::vtGroupBox3:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push

 Tkw_CustomizeTasksPanel_Control_lblCaption = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblCaption
----
*Пример использования*:
[code]
контрол::lblCaption TryFocus ASSERT
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
  {* Слово словаря для контрола lblCaption
----
*Пример использования*:
[code]
контрол::lblCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push

 Tkw_CustomizeTasksPanel_Control_edChange = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edChange
----
*Пример использования*:
[code]
контрол::edChange TryFocus ASSERT
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
  {* Слово словаря для контрола edChange
----
*Пример использования*:
[code]
контрол::edChange:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_edChange_Push

 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbForAllUseCases
----
*Пример использования*:
[code]
контрол::cbForAllUseCases TryFocus ASSERT
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
  {* Слово словаря для контрола cbForAllUseCases
----
*Пример использования*:
[code]
контрол::cbForAllUseCases:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push

 Tkw_CustomizeTasksPanel_Control_btnChangeItem = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnChangeItem
----
*Пример использования*:
[code]
контрол::btnChangeItem TryFocus ASSERT
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
  {* Слово словаря для контрола btnChangeItem
----
*Пример использования*:
[code]
контрол::btnChangeItem:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push

 Tkw_CustomizeTasksPanel_Control_pnlOperationPos = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlOperationPos
----
*Пример использования*:
[code]
контрол::pnlOperationPos TryFocus ASSERT
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
  {* Слово словаря для контрола pnlOperationPos
----
*Пример использования*:
[code]
контрол::pnlOperationPos:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push

 Tkw_CustomizeTasksPanel_Control_UpBitBtn = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола UpBitBtn
----
*Пример использования*:
[code]
контрол::UpBitBtn TryFocus ASSERT
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
  {* Слово словаря для контрола UpBitBtn
----
*Пример использования*:
[code]
контрол::UpBitBtn:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push

 Tkw_CustomizeTasksPanel_Control_DownBitBtn = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола DownBitBtn
----
*Пример использования*:
[code]
контрол::DownBitBtn TryFocus ASSERT
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
  {* Слово словаря для контрола DownBitBtn
----
*Пример использования*:
[code]
контрол::DownBitBtn:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push

 TkwCustomizeTasksPanelFormSpRight = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TCustomizeTasksPanelForm.spRight }
  private
   function spRight(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.spRight }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlBottom }
  private
   function pnlBottom(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlBottom }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.lblConfirmSave }
  private
   function lblConfirmSave(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblConfirmSave }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
  private
   function lblAvailableOpsCaption(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btOk }
  private
   function btOk(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btOk }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btCancel }
  private
   function btCancel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btCancel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btApply }
  private
   function btApply(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btApply }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlRep }
  private
   function pnlRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlRep }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.splRep }
  private
   function splRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.splRep }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.gbAvailableGroups }
  private
   function gbAvailableGroups(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbAvailableGroups }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.tvRepGroups }
  private
   function tvRepGroups(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvRepGroups }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.vtPanel1 }
  private
   function vtPanel1(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.vtPanel1 }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.cbGroupName }
  private
   function cbGroupName(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbGroupName }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnAddGroup }
  private
   function btnAddGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnAddGroup }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnChangeGroup }
  private
   function btnChangeGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnChangeGroup }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnDeleteGroup }
  private
   function btnDeleteGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnDeleteGroup }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.gbAvailableOperations }
  private
   function gbAvailableOperations(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbAvailableOperations }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.tvRepOps }
  private
   function tvRepOps(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvRepOps }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlForms }
  private
   function pnlForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlForms }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.lblForms }
  private
   function lblForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblForms }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.cbForms }
  private
   function cbForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbForms }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlMain }
  private
   function pnlMain(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlMain }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlLeft }
  private
   function pnlLeft(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlLeft }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveOpToPanel }
  private
   function btnMoveOpToPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveOpToPanel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveOpToRep }
  private
   function btnMoveOpToRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveOpToRep }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
  private
   function btnMoveGroupToPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveGroupToRep }
  private
   function btnMoveGroupToRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveGroupToRep }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlTasksPanel }
  private
   function pnlTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlTasksPanel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.gbTasksPanel }
  private
   function gbTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbTasksPanel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.tvTasksPanel }
  private
   function tvTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvTasksPanel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.vtGroupBox3 }
  private
   function vtGroupBox3(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.vtGroupBox3 }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.lblCaption }
  private
   function lblCaption(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblCaption }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.edChange }
  private
   function edChange(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.edChange }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.cbForAllUseCases }
  private
   function cbForAllUseCases(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbForAllUseCases }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnChangeItem }
  private
   function btnChangeItem(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnChangeItem }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlOperationPos }
  private
   function pnlOperationPos(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlOperationPos }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.UpBitBtn }
  private
   function UpBitBtn(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.UpBitBtn }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.DownBitBtn }
  private
   function DownBitBtn(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.DownBitBtn }
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
 Result := 'форма::CustomizeTasksPanel';
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
 Result := 'контрол::spRight';
end;//Tkw_CustomizeTasksPanel_Control_spRight.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_spRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('spRight');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_spRight_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_spRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::spRight:push';
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
 Result := 'контрол::pnlBottom';
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBottom');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBottom:push';
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
 Result := 'контрол::lblConfirmSave';
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblConfirmSave');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblConfirmSave:push';
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
 Result := 'контрол::lblAvailableOpsCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblAvailableOpsCaption');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblAvailableOpsCaption:push';
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
 Result := 'контрол::btOk';
end;//Tkw_CustomizeTasksPanel_Control_btOk.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btOk_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btOk');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btOk_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btOk:push';
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
 Result := 'контрол::btCancel';
end;//Tkw_CustomizeTasksPanel_Control_btCancel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btCancel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btCancel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btCancel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btCancel:push';
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
 Result := 'контрол::btApply';
end;//Tkw_CustomizeTasksPanel_Control_btApply.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btApply_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btApply');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btApply_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btApply_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btApply:push';
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
 Result := 'контрол::pnlRep';
end;//Tkw_CustomizeTasksPanel_Control_pnlRep.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlRep_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlRep:push';
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
 Result := 'контрол::splRep';
end;//Tkw_CustomizeTasksPanel_Control_splRep.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_splRep_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('splRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_splRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_splRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::splRep:push';
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
 Result := 'контрол::gbAvailableGroups';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('gbAvailableGroups');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::gbAvailableGroups:push';
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
 Result := 'контрол::tvRepGroups';
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvRepGroups');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvRepGroups:push';
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
 Result := 'контрол::vtPanel1';
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vtPanel1');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtPanel1:push';
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
 Result := 'контрол::cbGroupName';
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbGroupName');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbGroupName:push';
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
 Result := 'контрол::btnAddGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnAddGroup');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnAddGroup:push';
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
 Result := 'контрол::btnChangeGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnChangeGroup');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnChangeGroup:push';
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
 Result := 'контрол::btnDeleteGroup';
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnDeleteGroup');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnDeleteGroup:push';
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
 Result := 'контрол::gbAvailableOperations';
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('gbAvailableOperations');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::gbAvailableOperations:push';
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
 Result := 'контрол::tvRepOps';
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvRepOps');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvRepOps:push';
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
 Result := 'контрол::pnlForms';
end;//Tkw_CustomizeTasksPanel_Control_pnlForms.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlForms_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlForms');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlForms_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlForms:push';
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
 Result := 'контрол::lblForms';
end;//Tkw_CustomizeTasksPanel_Control_lblForms.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_lblForms_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblForms');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblForms_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblForms:push';
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
 Result := 'контрол::cbForms';
end;//Tkw_CustomizeTasksPanel_Control_cbForms.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_cbForms_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbForms');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_cbForms_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbForms_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbForms:push';
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
 Result := 'контрол::pnlMain';
end;//Tkw_CustomizeTasksPanel_Control_pnlMain.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlMain_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain:push';
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
 Result := 'контрол::pnlLeft';
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLeft');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLeft:push';
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
 Result := 'контрол::btnMoveOpToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnMoveOpToPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnMoveOpToPanel:push';
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
 Result := 'контрол::btnMoveOpToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnMoveOpToRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnMoveOpToRep:push';
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
 Result := 'контрол::btnMoveGroupToPanel';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnMoveGroupToPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnMoveGroupToPanel:push';
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
 Result := 'контрол::btnMoveGroupToRep';
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnMoveGroupToRep');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnMoveGroupToRep:push';
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
 Result := 'контрол::pnlTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlTasksPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlTasksPanel:push';
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
 Result := 'контрол::gbTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('gbTasksPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::gbTasksPanel:push';
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
 Result := 'контрол::tvTasksPanel';
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvTasksPanel');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvTasksPanel:push';
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
 Result := 'контрол::vtGroupBox3';
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vtGroupBox3');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtGroupBox3:push';
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
 Result := 'контрол::lblCaption';
end;//Tkw_CustomizeTasksPanel_Control_lblCaption.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_lblCaption_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblCaption');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_lblCaption_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_lblCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblCaption:push';
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
 Result := 'контрол::edChange';
end;//Tkw_CustomizeTasksPanel_Control_edChange.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_edChange_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edChange');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_edChange_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_edChange_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edChange:push';
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
 Result := 'контрол::cbForAllUseCases';
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbForAllUseCases');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbForAllUseCases:push';
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
 Result := 'контрол::btnChangeItem';
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnChangeItem');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnChangeItem:push';
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
 Result := 'контрол::pnlOperationPos';
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlOperationPos');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlOperationPos:push';
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
 Result := 'контрол::UpBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UpBitBtn');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::UpBitBtn:push';
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
 Result := 'контрол::DownBitBtn';
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn.GetWordNameForRegister

procedure Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('DownBitBtn');
 inherited;
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.DoDoIt

class function Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DownBitBtn:push';
end;//Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.GetWordNameForRegister

function TkwCustomizeTasksPanelFormSpRight.spRight(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.spRight }
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
 RunnerError('Нельзя присваивать значение readonly свойству spRight', aCtx);
end;//TkwCustomizeTasksPanelFormSpRight.SetValuePrim

procedure TkwCustomizeTasksPanelFormSpRight.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(spRight(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormSpRight.DoDoIt

function TkwCustomizeTasksPanelFormPnlBottom.pnlBottom(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlBottom }
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
 RunnerError('Нельзя присваивать значение readonly свойству pnlBottom', aCtx);
end;//TkwCustomizeTasksPanelFormPnlBottom.SetValuePrim

procedure TkwCustomizeTasksPanelFormPnlBottom.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBottom(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlBottom.DoDoIt

function TkwCustomizeTasksPanelFormLblConfirmSave.lblConfirmSave(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblConfirmSave }
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
 RunnerError('Нельзя присваивать значение readonly свойству lblConfirmSave', aCtx);
end;//TkwCustomizeTasksPanelFormLblConfirmSave.SetValuePrim

procedure TkwCustomizeTasksPanelFormLblConfirmSave.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblConfirmSave(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormLblConfirmSave.DoDoIt

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.lblAvailableOpsCaption(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
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
 RunnerError('Нельзя присваивать значение readonly свойству lblAvailableOpsCaption', aCtx);
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.SetValuePrim

procedure TkwCustomizeTasksPanelFormLblAvailableOpsCaption.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblAvailableOpsCaption(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.DoDoIt

function TkwCustomizeTasksPanelFormBtOk.btOk(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btOk }
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
 RunnerError('Нельзя присваивать значение readonly свойству btOk', aCtx);
end;//TkwCustomizeTasksPanelFormBtOk.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtOk.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btOk(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtOk.DoDoIt

function TkwCustomizeTasksPanelFormBtCancel.btCancel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btCancel }
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
 RunnerError('Нельзя присваивать значение readonly свойству btCancel', aCtx);
end;//TkwCustomizeTasksPanelFormBtCancel.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtCancel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btCancel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtCancel.DoDoIt

function TkwCustomizeTasksPanelFormBtApply.btApply(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btApply }
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
 RunnerError('Нельзя присваивать значение readonly свойству btApply', aCtx);
end;//TkwCustomizeTasksPanelFormBtApply.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtApply.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btApply(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtApply.DoDoIt

function TkwCustomizeTasksPanelFormPnlRep.pnlRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlRep }
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
 RunnerError('Нельзя присваивать значение readonly свойству pnlRep', aCtx);
end;//TkwCustomizeTasksPanelFormPnlRep.SetValuePrim

procedure TkwCustomizeTasksPanelFormPnlRep.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlRep(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlRep.DoDoIt

function TkwCustomizeTasksPanelFormSplRep.splRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.splRep }
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
 RunnerError('Нельзя присваивать значение readonly свойству splRep', aCtx);
end;//TkwCustomizeTasksPanelFormSplRep.SetValuePrim

procedure TkwCustomizeTasksPanelFormSplRep.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(splRep(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormSplRep.DoDoIt

function TkwCustomizeTasksPanelFormGbAvailableGroups.gbAvailableGroups(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbAvailableGroups }
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
 RunnerError('Нельзя присваивать значение readonly свойству gbAvailableGroups', aCtx);
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.SetValuePrim

procedure TkwCustomizeTasksPanelFormGbAvailableGroups.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(gbAvailableGroups(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.DoDoIt

function TkwCustomizeTasksPanelFormTvRepGroups.tvRepGroups(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvRepGroups }
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
 RunnerError('Нельзя присваивать значение readonly свойству tvRepGroups', aCtx);
end;//TkwCustomizeTasksPanelFormTvRepGroups.SetValuePrim

procedure TkwCustomizeTasksPanelFormTvRepGroups.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvRepGroups(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormTvRepGroups.DoDoIt

function TkwCustomizeTasksPanelFormVtPanel1.vtPanel1(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.vtPanel1 }
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
 RunnerError('Нельзя присваивать значение readonly свойству vtPanel1', aCtx);
end;//TkwCustomizeTasksPanelFormVtPanel1.SetValuePrim

procedure TkwCustomizeTasksPanelFormVtPanel1.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtPanel1(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormVtPanel1.DoDoIt

function TkwCustomizeTasksPanelFormCbGroupName.cbGroupName(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbGroupName }
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
 RunnerError('Нельзя присваивать значение readonly свойству cbGroupName', aCtx);
end;//TkwCustomizeTasksPanelFormCbGroupName.SetValuePrim

procedure TkwCustomizeTasksPanelFormCbGroupName.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbGroupName(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormCbGroupName.DoDoIt

function TkwCustomizeTasksPanelFormBtnAddGroup.btnAddGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnAddGroup }
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
 RunnerError('Нельзя присваивать значение readonly свойству btnAddGroup', aCtx);
end;//TkwCustomizeTasksPanelFormBtnAddGroup.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtnAddGroup.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnAddGroup(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnAddGroup.DoDoIt

function TkwCustomizeTasksPanelFormBtnChangeGroup.btnChangeGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnChangeGroup }
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
 RunnerError('Нельзя присваивать значение readonly свойству btnChangeGroup', aCtx);
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtnChangeGroup.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnChangeGroup(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.DoDoIt

function TkwCustomizeTasksPanelFormBtnDeleteGroup.btnDeleteGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnDeleteGroup }
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
 RunnerError('Нельзя присваивать значение readonly свойству btnDeleteGroup', aCtx);
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtnDeleteGroup.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnDeleteGroup(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.DoDoIt

function TkwCustomizeTasksPanelFormGbAvailableOperations.gbAvailableOperations(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbAvailableOperations }
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
 RunnerError('Нельзя присваивать значение readonly свойству gbAvailableOperations', aCtx);
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.SetValuePrim

procedure TkwCustomizeTasksPanelFormGbAvailableOperations.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(gbAvailableOperations(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.DoDoIt

function TkwCustomizeTasksPanelFormTvRepOps.tvRepOps(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvRepOps }
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
 RunnerError('Нельзя присваивать значение readonly свойству tvRepOps', aCtx);
end;//TkwCustomizeTasksPanelFormTvRepOps.SetValuePrim

procedure TkwCustomizeTasksPanelFormTvRepOps.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvRepOps(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormTvRepOps.DoDoIt

function TkwCustomizeTasksPanelFormPnlForms.pnlForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlForms }
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
 RunnerError('Нельзя присваивать значение readonly свойству pnlForms', aCtx);
end;//TkwCustomizeTasksPanelFormPnlForms.SetValuePrim

procedure TkwCustomizeTasksPanelFormPnlForms.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlForms(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlForms.DoDoIt

function TkwCustomizeTasksPanelFormLblForms.lblForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblForms }
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
 RunnerError('Нельзя присваивать значение readonly свойству lblForms', aCtx);
end;//TkwCustomizeTasksPanelFormLblForms.SetValuePrim

procedure TkwCustomizeTasksPanelFormLblForms.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblForms(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormLblForms.DoDoIt

function TkwCustomizeTasksPanelFormCbForms.cbForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbForms }
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
 RunnerError('Нельзя присваивать значение readonly свойству cbForms', aCtx);
end;//TkwCustomizeTasksPanelFormCbForms.SetValuePrim

procedure TkwCustomizeTasksPanelFormCbForms.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbForms(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormCbForms.DoDoIt

function TkwCustomizeTasksPanelFormPnlMain.pnlMain(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlMain }
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
 RunnerError('Нельзя присваивать значение readonly свойству pnlMain', aCtx);
end;//TkwCustomizeTasksPanelFormPnlMain.SetValuePrim

procedure TkwCustomizeTasksPanelFormPnlMain.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlMain(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlMain.DoDoIt

function TkwCustomizeTasksPanelFormPnlLeft.pnlLeft(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlLeft }
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
 RunnerError('Нельзя присваивать значение readonly свойству pnlLeft', aCtx);
end;//TkwCustomizeTasksPanelFormPnlLeft.SetValuePrim

procedure TkwCustomizeTasksPanelFormPnlLeft.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLeft(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlLeft.DoDoIt

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.btnMoveOpToPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveOpToPanel }
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
 RunnerError('Нельзя присваивать значение readonly свойству btnMoveOpToPanel', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtnMoveOpToPanel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnMoveOpToPanel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.DoDoIt

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.btnMoveOpToRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveOpToRep }
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
 RunnerError('Нельзя присваивать значение readonly свойству btnMoveOpToRep', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtnMoveOpToRep.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnMoveOpToRep(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.DoDoIt

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.btnMoveGroupToPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
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
 RunnerError('Нельзя присваивать значение readonly свойству btnMoveGroupToPanel', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnMoveGroupToPanel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.DoDoIt

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.btnMoveGroupToRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveGroupToRep }
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
 RunnerError('Нельзя присваивать значение readonly свойству btnMoveGroupToRep', aCtx);
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToRep.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnMoveGroupToRep(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.DoDoIt

function TkwCustomizeTasksPanelFormPnlTasksPanel.pnlTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlTasksPanel }
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
 RunnerError('Нельзя присваивать значение readonly свойству pnlTasksPanel', aCtx);
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.SetValuePrim

procedure TkwCustomizeTasksPanelFormPnlTasksPanel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlTasksPanel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.DoDoIt

function TkwCustomizeTasksPanelFormGbTasksPanel.gbTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbTasksPanel }
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
 RunnerError('Нельзя присваивать значение readonly свойству gbTasksPanel', aCtx);
end;//TkwCustomizeTasksPanelFormGbTasksPanel.SetValuePrim

procedure TkwCustomizeTasksPanelFormGbTasksPanel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(gbTasksPanel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormGbTasksPanel.DoDoIt

function TkwCustomizeTasksPanelFormTvTasksPanel.tvTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvTasksPanel }
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
 RunnerError('Нельзя присваивать значение readonly свойству tvTasksPanel', aCtx);
end;//TkwCustomizeTasksPanelFormTvTasksPanel.SetValuePrim

procedure TkwCustomizeTasksPanelFormTvTasksPanel.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvTasksPanel(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormTvTasksPanel.DoDoIt

function TkwCustomizeTasksPanelFormVtGroupBox3.vtGroupBox3(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.vtGroupBox3 }
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
 RunnerError('Нельзя присваивать значение readonly свойству vtGroupBox3', aCtx);
end;//TkwCustomizeTasksPanelFormVtGroupBox3.SetValuePrim

procedure TkwCustomizeTasksPanelFormVtGroupBox3.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtGroupBox3(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormVtGroupBox3.DoDoIt

function TkwCustomizeTasksPanelFormLblCaption.lblCaption(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblCaption }
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
 RunnerError('Нельзя присваивать значение readonly свойству lblCaption', aCtx);
end;//TkwCustomizeTasksPanelFormLblCaption.SetValuePrim

procedure TkwCustomizeTasksPanelFormLblCaption.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblCaption(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormLblCaption.DoDoIt

function TkwCustomizeTasksPanelFormEdChange.edChange(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.edChange }
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
 RunnerError('Нельзя присваивать значение readonly свойству edChange', aCtx);
end;//TkwCustomizeTasksPanelFormEdChange.SetValuePrim

procedure TkwCustomizeTasksPanelFormEdChange.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edChange(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormEdChange.DoDoIt

function TkwCustomizeTasksPanelFormCbForAllUseCases.cbForAllUseCases(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbForAllUseCases }
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
 RunnerError('Нельзя присваивать значение readonly свойству cbForAllUseCases', aCtx);
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.SetValuePrim

procedure TkwCustomizeTasksPanelFormCbForAllUseCases.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbForAllUseCases(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.DoDoIt

function TkwCustomizeTasksPanelFormBtnChangeItem.btnChangeItem(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnChangeItem }
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
 RunnerError('Нельзя присваивать значение readonly свойству btnChangeItem', aCtx);
end;//TkwCustomizeTasksPanelFormBtnChangeItem.SetValuePrim

procedure TkwCustomizeTasksPanelFormBtnChangeItem.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnChangeItem(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormBtnChangeItem.DoDoIt

function TkwCustomizeTasksPanelFormPnlOperationPos.pnlOperationPos(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlOperationPos }
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
 RunnerError('Нельзя присваивать значение readonly свойству pnlOperationPos', aCtx);
end;//TkwCustomizeTasksPanelFormPnlOperationPos.SetValuePrim

procedure TkwCustomizeTasksPanelFormPnlOperationPos.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlOperationPos(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormPnlOperationPos.DoDoIt

function TkwCustomizeTasksPanelFormUpBitBtn.UpBitBtn(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.UpBitBtn }
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
 RunnerError('Нельзя присваивать значение readonly свойству UpBitBtn', aCtx);
end;//TkwCustomizeTasksPanelFormUpBitBtn.SetValuePrim

procedure TkwCustomizeTasksPanelFormUpBitBtn.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UpBitBtn(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormUpBitBtn.DoDoIt

function TkwCustomizeTasksPanelFormDownBitBtn.DownBitBtn(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.DownBitBtn }
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
 RunnerError('Нельзя присваивать значение readonly свойству DownBitBtn', aCtx);
end;//TkwCustomizeTasksPanelFormDownBitBtn.SetValuePrim

procedure TkwCustomizeTasksPanelFormDownBitBtn.DoDoIt(const aCtx: TtfwContext);
var l_aCustomizeTasksPanelForm: TCustomizeTasksPanelForm;
begin
 try
  l_aCustomizeTasksPanelForm := TCustomizeTasksPanelForm(aCtx.rEngine.PopObjAs(TCustomizeTasksPanelForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCustomizeTasksPanelForm: TCustomizeTasksPanelForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DownBitBtn(aCtx, l_aCustomizeTasksPanelForm));
end;//TkwCustomizeTasksPanelFormDownBitBtn.DoDoIt

initialization
 Tkw_Form_CustomizeTasksPanel.RegisterInEngine;
 {* Регистрация Tkw_Form_CustomizeTasksPanel }
 Tkw_CustomizeTasksPanel_Control_spRight.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_spRight }
 Tkw_CustomizeTasksPanel_Control_spRight_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_spRight_Push }
 Tkw_CustomizeTasksPanel_Control_pnlBottom.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlBottom }
 Tkw_CustomizeTasksPanel_Control_pnlBottom_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlBottom_Push }
 Tkw_CustomizeTasksPanel_Control_lblConfirmSave.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_lblConfirmSave }
 Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_lblConfirmSave_Push }
 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption }
 Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_lblAvailableOpsCaption_Push }
 Tkw_CustomizeTasksPanel_Control_btOk.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btOk }
 Tkw_CustomizeTasksPanel_Control_btOk_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btOk_Push }
 Tkw_CustomizeTasksPanel_Control_btCancel.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btCancel }
 Tkw_CustomizeTasksPanel_Control_btCancel_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btCancel_Push }
 Tkw_CustomizeTasksPanel_Control_btApply.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btApply }
 Tkw_CustomizeTasksPanel_Control_btApply_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btApply_Push }
 Tkw_CustomizeTasksPanel_Control_pnlRep.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlRep }
 Tkw_CustomizeTasksPanel_Control_pnlRep_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlRep_Push }
 Tkw_CustomizeTasksPanel_Control_splRep.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_splRep }
 Tkw_CustomizeTasksPanel_Control_splRep_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_splRep_Push }
 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_gbAvailableGroups }
 Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_gbAvailableGroups_Push }
 Tkw_CustomizeTasksPanel_Control_tvRepGroups.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_tvRepGroups }
 Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_tvRepGroups_Push }
 Tkw_CustomizeTasksPanel_Control_vtPanel1.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_vtPanel1 }
 Tkw_CustomizeTasksPanel_Control_vtPanel1_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_vtPanel1_Push }
 Tkw_CustomizeTasksPanel_Control_cbGroupName.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_cbGroupName }
 Tkw_CustomizeTasksPanel_Control_cbGroupName_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_cbGroupName_Push }
 Tkw_CustomizeTasksPanel_Control_btnAddGroup.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnAddGroup }
 Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnAddGroup_Push }
 Tkw_CustomizeTasksPanel_Control_btnChangeGroup.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnChangeGroup }
 Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnChangeGroup_Push }
 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnDeleteGroup }
 Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnDeleteGroup_Push }
 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_gbAvailableOperations }
 Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_gbAvailableOperations_Push }
 Tkw_CustomizeTasksPanel_Control_tvRepOps.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_tvRepOps }
 Tkw_CustomizeTasksPanel_Control_tvRepOps_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_tvRepOps_Push }
 Tkw_CustomizeTasksPanel_Control_pnlForms.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlForms }
 Tkw_CustomizeTasksPanel_Control_pnlForms_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlForms_Push }
 Tkw_CustomizeTasksPanel_Control_lblForms.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_lblForms }
 Tkw_CustomizeTasksPanel_Control_lblForms_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_lblForms_Push }
 Tkw_CustomizeTasksPanel_Control_cbForms.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_cbForms }
 Tkw_CustomizeTasksPanel_Control_cbForms_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_cbForms_Push }
 Tkw_CustomizeTasksPanel_Control_pnlMain.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlMain }
 Tkw_CustomizeTasksPanel_Control_pnlMain_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlMain_Push }
 Tkw_CustomizeTasksPanel_Control_pnlLeft.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlLeft }
 Tkw_CustomizeTasksPanel_Control_pnlLeft_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlLeft_Push }
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel }
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnMoveOpToPanel_Push }
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep }
 Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnMoveOpToRep_Push }
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel }
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnMoveGroupToPanel_Push }
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep }
 Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnMoveGroupToRep_Push }
 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlTasksPanel }
 Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlTasksPanel_Push }
 Tkw_CustomizeTasksPanel_Control_gbTasksPanel.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_gbTasksPanel }
 Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_gbTasksPanel_Push }
 Tkw_CustomizeTasksPanel_Control_tvTasksPanel.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_tvTasksPanel }
 Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_tvTasksPanel_Push }
 Tkw_CustomizeTasksPanel_Control_vtGroupBox3.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_vtGroupBox3 }
 Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_vtGroupBox3_Push }
 Tkw_CustomizeTasksPanel_Control_lblCaption.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_lblCaption }
 Tkw_CustomizeTasksPanel_Control_lblCaption_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_lblCaption_Push }
 Tkw_CustomizeTasksPanel_Control_edChange.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_edChange }
 Tkw_CustomizeTasksPanel_Control_edChange_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_edChange_Push }
 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_cbForAllUseCases }
 Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_cbForAllUseCases_Push }
 Tkw_CustomizeTasksPanel_Control_btnChangeItem.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnChangeItem }
 Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_btnChangeItem_Push }
 Tkw_CustomizeTasksPanel_Control_pnlOperationPos.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlOperationPos }
 Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_pnlOperationPos_Push }
 Tkw_CustomizeTasksPanel_Control_UpBitBtn.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_UpBitBtn }
 Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_UpBitBtn_Push }
 Tkw_CustomizeTasksPanel_Control_DownBitBtn.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_DownBitBtn }
 Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push.RegisterInEngine;
 {* Регистрация Tkw_CustomizeTasksPanel_Control_DownBitBtn_Push }
 TkwCustomizeTasksPanelFormSpRight.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_spRight }
 TkwCustomizeTasksPanelFormPnlBottom.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_pnlBottom }
 TkwCustomizeTasksPanelFormLblConfirmSave.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_lblConfirmSave }
 TkwCustomizeTasksPanelFormLblAvailableOpsCaption.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_lblAvailableOpsCaption }
 TkwCustomizeTasksPanelFormBtOk.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btOk }
 TkwCustomizeTasksPanelFormBtCancel.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btCancel }
 TkwCustomizeTasksPanelFormBtApply.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btApply }
 TkwCustomizeTasksPanelFormPnlRep.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_pnlRep }
 TkwCustomizeTasksPanelFormSplRep.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_splRep }
 TkwCustomizeTasksPanelFormGbAvailableGroups.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_gbAvailableGroups }
 TkwCustomizeTasksPanelFormTvRepGroups.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_tvRepGroups }
 TkwCustomizeTasksPanelFormVtPanel1.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_vtPanel1 }
 TkwCustomizeTasksPanelFormCbGroupName.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_cbGroupName }
 TkwCustomizeTasksPanelFormBtnAddGroup.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btnAddGroup }
 TkwCustomizeTasksPanelFormBtnChangeGroup.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btnChangeGroup }
 TkwCustomizeTasksPanelFormBtnDeleteGroup.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btnDeleteGroup }
 TkwCustomizeTasksPanelFormGbAvailableOperations.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_gbAvailableOperations }
 TkwCustomizeTasksPanelFormTvRepOps.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_tvRepOps }
 TkwCustomizeTasksPanelFormPnlForms.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_pnlForms }
 TkwCustomizeTasksPanelFormLblForms.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_lblForms }
 TkwCustomizeTasksPanelFormCbForms.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_cbForms }
 TkwCustomizeTasksPanelFormPnlMain.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_pnlMain }
 TkwCustomizeTasksPanelFormPnlLeft.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_pnlLeft }
 TkwCustomizeTasksPanelFormBtnMoveOpToPanel.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btnMoveOpToPanel }
 TkwCustomizeTasksPanelFormBtnMoveOpToRep.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btnMoveOpToRep }
 TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btnMoveGroupToPanel }
 TkwCustomizeTasksPanelFormBtnMoveGroupToRep.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btnMoveGroupToRep }
 TkwCustomizeTasksPanelFormPnlTasksPanel.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_pnlTasksPanel }
 TkwCustomizeTasksPanelFormGbTasksPanel.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_gbTasksPanel }
 TkwCustomizeTasksPanelFormTvTasksPanel.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_tvTasksPanel }
 TkwCustomizeTasksPanelFormVtGroupBox3.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_vtGroupBox3 }
 TkwCustomizeTasksPanelFormLblCaption.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_lblCaption }
 TkwCustomizeTasksPanelFormEdChange.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_edChange }
 TkwCustomizeTasksPanelFormCbForAllUseCases.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_cbForAllUseCases }
 TkwCustomizeTasksPanelFormBtnChangeItem.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_btnChangeItem }
 TkwCustomizeTasksPanelFormPnlOperationPos.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_pnlOperationPos }
 TkwCustomizeTasksPanelFormUpBitBtn.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_UpBitBtn }
 TkwCustomizeTasksPanelFormDownBitBtn.RegisterInEngine;
 {* Регистрация CustomizeTasksPanelForm_DownBitBtn }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomizeTasksPanelForm));
 {* Регистрация типа TCustomizeTasksPanelForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSplitter));
 {* Регистрация типа TvtSplitter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* Регистрация типа TvtButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* Регистрация типа TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* Регистрация типа TeeTreeView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBox));
 {* Регистрация типа TvtComboBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeButton));
 {* Регистрация типа TeeButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TComboBox));
 {* Регистрация типа TComboBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TBitBtn));
 {* Регистрация типа TBitBtn }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeCheckBox));
 {* Регистрация типа TeeCheckBox }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
