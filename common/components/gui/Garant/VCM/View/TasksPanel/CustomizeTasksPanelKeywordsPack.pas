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
 , tfwTypeInfo
 , TypInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , tfwTypeRegistrator
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
  {* Слово скрипта .TCustomizeTasksPanelForm.spRight
[panel]Контрол spRight формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtSplitter
*Пример:*
[code]
OBJECT VAR l_TvtSplitter
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.spRight >>> l_TvtSplitter
[code]  }
  private
   function spRight(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.spRight }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlBottom
[panel]Контрол pnlBottom формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlBottom >>> l_TvtPanel
[code]  }
  private
   function pnlBottom(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlBottom }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.lblConfirmSave
[panel]Контрол lblConfirmSave формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblConfirmSave >>> l_TvtLabel
[code]  }
  private
   function lblConfirmSave(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblConfirmSave }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.lblAvailableOpsCaption
[panel]Контрол lblAvailableOpsCaption формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblAvailableOpsCaption >>> l_TvtLabel
[code]  }
  private
   function lblAvailableOpsCaption(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btOk
[panel]Контрол btOk формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btOk >>> l_TvtButton
[code]  }
  private
   function btOk(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btOk }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btCancel
[panel]Контрол btCancel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btCancel >>> l_TvtButton
[code]  }
  private
   function btCancel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btCancel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btApply
[panel]Контрол btApply формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btApply >>> l_TvtButton
[code]  }
  private
   function btApply(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btApply }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlRep
[panel]Контрол pnlRep формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlRep >>> l_TvtPanel
[code]  }
  private
   function pnlRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlRep }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.splRep
[panel]Контрол splRep формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtSplitter
*Пример:*
[code]
OBJECT VAR l_TvtSplitter
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.splRep >>> l_TvtSplitter
[code]  }
  private
   function splRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.splRep }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.gbAvailableGroups
[panel]Контрол gbAvailableGroups формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbAvailableGroups >>> l_TvtGroupBox
[code]  }
  private
   function gbAvailableGroups(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbAvailableGroups }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.tvRepGroups
[panel]Контрол tvRepGroups формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvRepGroups >>> l_TeeTreeView
[code]  }
  private
   function tvRepGroups(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvRepGroups }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.vtPanel1
[panel]Контрол vtPanel1 формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.vtPanel1 >>> l_TvtPanel
[code]  }
  private
   function vtPanel1(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.vtPanel1 }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.cbGroupName
[panel]Контрол cbGroupName формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtComboBox
*Пример:*
[code]
OBJECT VAR l_TvtComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbGroupName >>> l_TvtComboBox
[code]  }
  private
   function cbGroupName(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbGroupName }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnAddGroup
[panel]Контрол btnAddGroup формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeButton
*Пример:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnAddGroup >>> l_TeeButton
[code]  }
  private
   function btnAddGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnAddGroup }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnChangeGroup
[panel]Контрол btnChangeGroup формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeButton
*Пример:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnChangeGroup >>> l_TeeButton
[code]  }
  private
   function btnChangeGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnChangeGroup }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnDeleteGroup
[panel]Контрол btnDeleteGroup формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeButton
*Пример:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnDeleteGroup >>> l_TeeButton
[code]  }
  private
   function btnDeleteGroup(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnDeleteGroup }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.gbAvailableOperations
[panel]Контрол gbAvailableOperations формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbAvailableOperations >>> l_TvtGroupBox
[code]  }
  private
   function gbAvailableOperations(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbAvailableOperations }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.tvRepOps
[panel]Контрол tvRepOps формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvRepOps >>> l_TeeTreeView
[code]  }
  private
   function tvRepOps(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvRepOps }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlForms
[panel]Контрол pnlForms формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlForms >>> l_TvtPanel
[code]  }
  private
   function pnlForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlForms }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.lblForms
[panel]Контрол lblForms формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblForms >>> l_TvtLabel
[code]  }
  private
   function lblForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblForms }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.cbForms
[panel]Контрол cbForms формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TComboBox
*Пример:*
[code]
OBJECT VAR l_TComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbForms >>> l_TComboBox
[code]  }
  private
   function cbForms(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbForms }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlMain
[panel]Контрол pnlMain формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlMain >>> l_TvtPanel
[code]  }
  private
   function pnlMain(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlMain }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlLeft
[panel]Контрол pnlLeft формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlLeft >>> l_TvtPanel
[code]  }
  private
   function pnlLeft(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlLeft }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveOpToPanel
[panel]Контрол btnMoveOpToPanel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveOpToPanel >>> l_TBitBtn
[code]  }
  private
   function btnMoveOpToPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveOpToPanel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveOpToRep
[panel]Контрол btnMoveOpToRep формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveOpToRep >>> l_TBitBtn
[code]  }
  private
   function btnMoveOpToRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveOpToRep }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveGroupToPanel
[panel]Контрол btnMoveGroupToPanel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveGroupToPanel >>> l_TBitBtn
[code]  }
  private
   function btnMoveGroupToPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnMoveGroupToRep
[panel]Контрол btnMoveGroupToRep формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnMoveGroupToRep >>> l_TBitBtn
[code]  }
  private
   function btnMoveGroupToRep(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveGroupToRep }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlTasksPanel
[panel]Контрол pnlTasksPanel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlTasksPanel >>> l_TvtPanel
[code]  }
  private
   function pnlTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlTasksPanel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.gbTasksPanel
[panel]Контрол gbTasksPanel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.gbTasksPanel >>> l_TvtGroupBox
[code]  }
  private
   function gbTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbTasksPanel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.tvTasksPanel
[panel]Контрол tvTasksPanel формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.tvTasksPanel >>> l_TeeTreeView
[code]  }
  private
   function tvTasksPanel(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvTasksPanel }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.vtGroupBox3
[panel]Контрол vtGroupBox3 формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.vtGroupBox3 >>> l_TvtGroupBox
[code]  }
  private
   function vtGroupBox3(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.vtGroupBox3 }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.lblCaption
[panel]Контрол lblCaption формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.lblCaption >>> l_TvtLabel
[code]  }
  private
   function lblCaption(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblCaption }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.edChange
[panel]Контрол edChange формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtComboBox
*Пример:*
[code]
OBJECT VAR l_TvtComboBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.edChange >>> l_TvtComboBox
[code]  }
  private
   function edChange(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.edChange }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.cbForAllUseCases
[panel]Контрол cbForAllUseCases формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeCheckBox
*Пример:*
[code]
OBJECT VAR l_TeeCheckBox
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.cbForAllUseCases >>> l_TeeCheckBox
[code]  }
  private
   function cbForAllUseCases(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbForAllUseCases }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.btnChangeItem
[panel]Контрол btnChangeItem формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TeeButton
*Пример:*
[code]
OBJECT VAR l_TeeButton
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.btnChangeItem >>> l_TeeButton
[code]  }
  private
   function btnChangeItem(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnChangeItem }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.pnlOperationPos
[panel]Контрол pnlOperationPos формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.pnlOperationPos >>> l_TvtPanel
[code]  }
  private
   function pnlOperationPos(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlOperationPos }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.UpBitBtn
[panel]Контрол UpBitBtn формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.UpBitBtn >>> l_TBitBtn
[code]  }
  private
   function UpBitBtn(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.UpBitBtn }
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
  {* Слово скрипта .TCustomizeTasksPanelForm.DownBitBtn
[panel]Контрол DownBitBtn формы TCustomizeTasksPanelForm[panel]
*Тип результата:* TBitBtn
*Пример:*
[code]
OBJECT VAR l_TBitBtn
 aCustomizeTasksPanelForm .TCustomizeTasksPanelForm.DownBitBtn >>> l_TBitBtn
[code]  }
  private
   function DownBitBtn(const aCtx: TtfwContext;
    aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
    {* Реализация слова скрипта .TCustomizeTasksPanelForm.DownBitBtn }
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

procedure TkwCustomizeTasksPanelFormSpRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству spRight', aCtx);
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

class function TkwCustomizeTasksPanelFormSpRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.spRight';
end;//TkwCustomizeTasksPanelFormSpRight.GetWordNameForRegister

function TkwCustomizeTasksPanelFormPnlBottom.pnlBottom(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlBottom }
begin
 Result := aCustomizeTasksPanelForm.pnlBottom;
end;//TkwCustomizeTasksPanelFormPnlBottom.pnlBottom

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

procedure TkwCustomizeTasksPanelFormPnlBottom.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlBottom', aCtx);
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

class function TkwCustomizeTasksPanelFormPnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlBottom';
end;//TkwCustomizeTasksPanelFormPnlBottom.GetWordNameForRegister

function TkwCustomizeTasksPanelFormLblConfirmSave.lblConfirmSave(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblConfirmSave }
begin
 Result := aCustomizeTasksPanelForm.lblConfirmSave;
end;//TkwCustomizeTasksPanelFormLblConfirmSave.lblConfirmSave

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

procedure TkwCustomizeTasksPanelFormLblConfirmSave.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblConfirmSave', aCtx);
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

class function TkwCustomizeTasksPanelFormLblConfirmSave.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblConfirmSave';
end;//TkwCustomizeTasksPanelFormLblConfirmSave.GetWordNameForRegister

function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.lblAvailableOpsCaption(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblAvailableOpsCaption }
begin
 Result := aCustomizeTasksPanelForm.lblAvailableOpsCaption;
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.lblAvailableOpsCaption

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

procedure TkwCustomizeTasksPanelFormLblAvailableOpsCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblAvailableOpsCaption', aCtx);
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

class function TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblAvailableOpsCaption';
end;//TkwCustomizeTasksPanelFormLblAvailableOpsCaption.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtOk.btOk(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btOk }
begin
 Result := aCustomizeTasksPanelForm.btOk;
end;//TkwCustomizeTasksPanelFormBtOk.btOk

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

procedure TkwCustomizeTasksPanelFormBtOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btOk', aCtx);
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

class function TkwCustomizeTasksPanelFormBtOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btOk';
end;//TkwCustomizeTasksPanelFormBtOk.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtCancel.btCancel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btCancel }
begin
 Result := aCustomizeTasksPanelForm.btCancel;
end;//TkwCustomizeTasksPanelFormBtCancel.btCancel

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

procedure TkwCustomizeTasksPanelFormBtCancel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btCancel', aCtx);
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

class function TkwCustomizeTasksPanelFormBtCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btCancel';
end;//TkwCustomizeTasksPanelFormBtCancel.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtApply.btApply(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btApply }
begin
 Result := aCustomizeTasksPanelForm.btApply;
end;//TkwCustomizeTasksPanelFormBtApply.btApply

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

procedure TkwCustomizeTasksPanelFormBtApply.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btApply', aCtx);
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

class function TkwCustomizeTasksPanelFormBtApply.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btApply';
end;//TkwCustomizeTasksPanelFormBtApply.GetWordNameForRegister

function TkwCustomizeTasksPanelFormPnlRep.pnlRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlRep }
begin
 Result := aCustomizeTasksPanelForm.pnlRep;
end;//TkwCustomizeTasksPanelFormPnlRep.pnlRep

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

procedure TkwCustomizeTasksPanelFormPnlRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlRep', aCtx);
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

class function TkwCustomizeTasksPanelFormPnlRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlRep';
end;//TkwCustomizeTasksPanelFormPnlRep.GetWordNameForRegister

function TkwCustomizeTasksPanelFormSplRep.splRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtSplitter;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.splRep }
begin
 Result := aCustomizeTasksPanelForm.splRep;
end;//TkwCustomizeTasksPanelFormSplRep.splRep

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

procedure TkwCustomizeTasksPanelFormSplRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству splRep', aCtx);
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

class function TkwCustomizeTasksPanelFormSplRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.splRep';
end;//TkwCustomizeTasksPanelFormSplRep.GetWordNameForRegister

function TkwCustomizeTasksPanelFormGbAvailableGroups.gbAvailableGroups(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbAvailableGroups }
begin
 Result := aCustomizeTasksPanelForm.gbAvailableGroups;
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.gbAvailableGroups

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

procedure TkwCustomizeTasksPanelFormGbAvailableGroups.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству gbAvailableGroups', aCtx);
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

class function TkwCustomizeTasksPanelFormGbAvailableGroups.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.gbAvailableGroups';
end;//TkwCustomizeTasksPanelFormGbAvailableGroups.GetWordNameForRegister

function TkwCustomizeTasksPanelFormTvRepGroups.tvRepGroups(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvRepGroups }
begin
 Result := aCustomizeTasksPanelForm.tvRepGroups;
end;//TkwCustomizeTasksPanelFormTvRepGroups.tvRepGroups

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

procedure TkwCustomizeTasksPanelFormTvRepGroups.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvRepGroups', aCtx);
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

class function TkwCustomizeTasksPanelFormTvRepGroups.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.tvRepGroups';
end;//TkwCustomizeTasksPanelFormTvRepGroups.GetWordNameForRegister

function TkwCustomizeTasksPanelFormVtPanel1.vtPanel1(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.vtPanel1 }
begin
 Result := aCustomizeTasksPanelForm.vtPanel1;
end;//TkwCustomizeTasksPanelFormVtPanel1.vtPanel1

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

procedure TkwCustomizeTasksPanelFormVtPanel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству vtPanel1', aCtx);
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

class function TkwCustomizeTasksPanelFormVtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.vtPanel1';
end;//TkwCustomizeTasksPanelFormVtPanel1.GetWordNameForRegister

function TkwCustomizeTasksPanelFormCbGroupName.cbGroupName(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbGroupName }
begin
 Result := aCustomizeTasksPanelForm.cbGroupName;
end;//TkwCustomizeTasksPanelFormCbGroupName.cbGroupName

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

procedure TkwCustomizeTasksPanelFormCbGroupName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbGroupName', aCtx);
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

class function TkwCustomizeTasksPanelFormCbGroupName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.cbGroupName';
end;//TkwCustomizeTasksPanelFormCbGroupName.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtnAddGroup.btnAddGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnAddGroup }
begin
 Result := aCustomizeTasksPanelForm.btnAddGroup;
end;//TkwCustomizeTasksPanelFormBtnAddGroup.btnAddGroup

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

procedure TkwCustomizeTasksPanelFormBtnAddGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnAddGroup', aCtx);
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

class function TkwCustomizeTasksPanelFormBtnAddGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnAddGroup';
end;//TkwCustomizeTasksPanelFormBtnAddGroup.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtnChangeGroup.btnChangeGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnChangeGroup }
begin
 Result := aCustomizeTasksPanelForm.btnChangeGroup;
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.btnChangeGroup

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

procedure TkwCustomizeTasksPanelFormBtnChangeGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnChangeGroup', aCtx);
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

class function TkwCustomizeTasksPanelFormBtnChangeGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnChangeGroup';
end;//TkwCustomizeTasksPanelFormBtnChangeGroup.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtnDeleteGroup.btnDeleteGroup(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnDeleteGroup }
begin
 Result := aCustomizeTasksPanelForm.btnDeleteGroup;
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.btnDeleteGroup

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

procedure TkwCustomizeTasksPanelFormBtnDeleteGroup.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnDeleteGroup', aCtx);
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

class function TkwCustomizeTasksPanelFormBtnDeleteGroup.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnDeleteGroup';
end;//TkwCustomizeTasksPanelFormBtnDeleteGroup.GetWordNameForRegister

function TkwCustomizeTasksPanelFormGbAvailableOperations.gbAvailableOperations(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbAvailableOperations }
begin
 Result := aCustomizeTasksPanelForm.gbAvailableOperations;
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.gbAvailableOperations

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

procedure TkwCustomizeTasksPanelFormGbAvailableOperations.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству gbAvailableOperations', aCtx);
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

class function TkwCustomizeTasksPanelFormGbAvailableOperations.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.gbAvailableOperations';
end;//TkwCustomizeTasksPanelFormGbAvailableOperations.GetWordNameForRegister

function TkwCustomizeTasksPanelFormTvRepOps.tvRepOps(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvRepOps }
begin
 Result := aCustomizeTasksPanelForm.tvRepOps;
end;//TkwCustomizeTasksPanelFormTvRepOps.tvRepOps

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

procedure TkwCustomizeTasksPanelFormTvRepOps.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvRepOps', aCtx);
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

class function TkwCustomizeTasksPanelFormTvRepOps.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.tvRepOps';
end;//TkwCustomizeTasksPanelFormTvRepOps.GetWordNameForRegister

function TkwCustomizeTasksPanelFormPnlForms.pnlForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlForms }
begin
 Result := aCustomizeTasksPanelForm.pnlForms;
end;//TkwCustomizeTasksPanelFormPnlForms.pnlForms

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

procedure TkwCustomizeTasksPanelFormPnlForms.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlForms', aCtx);
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

class function TkwCustomizeTasksPanelFormPnlForms.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlForms';
end;//TkwCustomizeTasksPanelFormPnlForms.GetWordNameForRegister

function TkwCustomizeTasksPanelFormLblForms.lblForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblForms }
begin
 Result := aCustomizeTasksPanelForm.lblForms;
end;//TkwCustomizeTasksPanelFormLblForms.lblForms

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

procedure TkwCustomizeTasksPanelFormLblForms.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblForms', aCtx);
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

class function TkwCustomizeTasksPanelFormLblForms.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblForms';
end;//TkwCustomizeTasksPanelFormLblForms.GetWordNameForRegister

function TkwCustomizeTasksPanelFormCbForms.cbForms(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TComboBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbForms }
begin
 Result := aCustomizeTasksPanelForm.cbForms;
end;//TkwCustomizeTasksPanelFormCbForms.cbForms

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

procedure TkwCustomizeTasksPanelFormCbForms.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbForms', aCtx);
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

class function TkwCustomizeTasksPanelFormCbForms.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.cbForms';
end;//TkwCustomizeTasksPanelFormCbForms.GetWordNameForRegister

function TkwCustomizeTasksPanelFormPnlMain.pnlMain(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlMain }
begin
 Result := aCustomizeTasksPanelForm.pnlMain;
end;//TkwCustomizeTasksPanelFormPnlMain.pnlMain

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

procedure TkwCustomizeTasksPanelFormPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlMain', aCtx);
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

class function TkwCustomizeTasksPanelFormPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlMain';
end;//TkwCustomizeTasksPanelFormPnlMain.GetWordNameForRegister

function TkwCustomizeTasksPanelFormPnlLeft.pnlLeft(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlLeft }
begin
 Result := aCustomizeTasksPanelForm.pnlLeft;
end;//TkwCustomizeTasksPanelFormPnlLeft.pnlLeft

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

procedure TkwCustomizeTasksPanelFormPnlLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlLeft', aCtx);
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

class function TkwCustomizeTasksPanelFormPnlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlLeft';
end;//TkwCustomizeTasksPanelFormPnlLeft.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.btnMoveOpToPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveOpToPanel }
begin
 Result := aCustomizeTasksPanelForm.btnMoveOpToPanel;
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.btnMoveOpToPanel

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

procedure TkwCustomizeTasksPanelFormBtnMoveOpToPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnMoveOpToPanel', aCtx);
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

class function TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveOpToPanel';
end;//TkwCustomizeTasksPanelFormBtnMoveOpToPanel.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtnMoveOpToRep.btnMoveOpToRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveOpToRep }
begin
 Result := aCustomizeTasksPanelForm.btnMoveOpToRep;
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.btnMoveOpToRep

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

procedure TkwCustomizeTasksPanelFormBtnMoveOpToRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnMoveOpToRep', aCtx);
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

class function TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveOpToRep';
end;//TkwCustomizeTasksPanelFormBtnMoveOpToRep.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.btnMoveGroupToPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveGroupToPanel }
begin
 Result := aCustomizeTasksPanelForm.btnMoveGroupToPanel;
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.btnMoveGroupToPanel

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

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnMoveGroupToPanel', aCtx);
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

class function TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveGroupToPanel';
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToPanel.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.btnMoveGroupToRep(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnMoveGroupToRep }
begin
 Result := aCustomizeTasksPanelForm.btnMoveGroupToRep;
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.btnMoveGroupToRep

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

procedure TkwCustomizeTasksPanelFormBtnMoveGroupToRep.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnMoveGroupToRep', aCtx);
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

class function TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnMoveGroupToRep';
end;//TkwCustomizeTasksPanelFormBtnMoveGroupToRep.GetWordNameForRegister

function TkwCustomizeTasksPanelFormPnlTasksPanel.pnlTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlTasksPanel }
begin
 Result := aCustomizeTasksPanelForm.pnlTasksPanel;
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.pnlTasksPanel

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

procedure TkwCustomizeTasksPanelFormPnlTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlTasksPanel', aCtx);
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

class function TkwCustomizeTasksPanelFormPnlTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlTasksPanel';
end;//TkwCustomizeTasksPanelFormPnlTasksPanel.GetWordNameForRegister

function TkwCustomizeTasksPanelFormGbTasksPanel.gbTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.gbTasksPanel }
begin
 Result := aCustomizeTasksPanelForm.gbTasksPanel;
end;//TkwCustomizeTasksPanelFormGbTasksPanel.gbTasksPanel

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

procedure TkwCustomizeTasksPanelFormGbTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству gbTasksPanel', aCtx);
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

class function TkwCustomizeTasksPanelFormGbTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.gbTasksPanel';
end;//TkwCustomizeTasksPanelFormGbTasksPanel.GetWordNameForRegister

function TkwCustomizeTasksPanelFormTvTasksPanel.tvTasksPanel(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeTreeView;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.tvTasksPanel }
begin
 Result := aCustomizeTasksPanelForm.tvTasksPanel;
end;//TkwCustomizeTasksPanelFormTvTasksPanel.tvTasksPanel

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

procedure TkwCustomizeTasksPanelFormTvTasksPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvTasksPanel', aCtx);
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

class function TkwCustomizeTasksPanelFormTvTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.tvTasksPanel';
end;//TkwCustomizeTasksPanelFormTvTasksPanel.GetWordNameForRegister

function TkwCustomizeTasksPanelFormVtGroupBox3.vtGroupBox3(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtGroupBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.vtGroupBox3 }
begin
 Result := aCustomizeTasksPanelForm.vtGroupBox3;
end;//TkwCustomizeTasksPanelFormVtGroupBox3.vtGroupBox3

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

procedure TkwCustomizeTasksPanelFormVtGroupBox3.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству vtGroupBox3', aCtx);
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

class function TkwCustomizeTasksPanelFormVtGroupBox3.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.vtGroupBox3';
end;//TkwCustomizeTasksPanelFormVtGroupBox3.GetWordNameForRegister

function TkwCustomizeTasksPanelFormLblCaption.lblCaption(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtLabel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.lblCaption }
begin
 Result := aCustomizeTasksPanelForm.lblCaption;
end;//TkwCustomizeTasksPanelFormLblCaption.lblCaption

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

procedure TkwCustomizeTasksPanelFormLblCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblCaption', aCtx);
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

class function TkwCustomizeTasksPanelFormLblCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.lblCaption';
end;//TkwCustomizeTasksPanelFormLblCaption.GetWordNameForRegister

function TkwCustomizeTasksPanelFormEdChange.edChange(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtComboBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.edChange }
begin
 Result := aCustomizeTasksPanelForm.edChange;
end;//TkwCustomizeTasksPanelFormEdChange.edChange

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

procedure TkwCustomizeTasksPanelFormEdChange.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edChange', aCtx);
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

class function TkwCustomizeTasksPanelFormEdChange.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.edChange';
end;//TkwCustomizeTasksPanelFormEdChange.GetWordNameForRegister

function TkwCustomizeTasksPanelFormCbForAllUseCases.cbForAllUseCases(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeCheckBox;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.cbForAllUseCases }
begin
 Result := aCustomizeTasksPanelForm.cbForAllUseCases;
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.cbForAllUseCases

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

procedure TkwCustomizeTasksPanelFormCbForAllUseCases.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbForAllUseCases', aCtx);
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

class function TkwCustomizeTasksPanelFormCbForAllUseCases.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.cbForAllUseCases';
end;//TkwCustomizeTasksPanelFormCbForAllUseCases.GetWordNameForRegister

function TkwCustomizeTasksPanelFormBtnChangeItem.btnChangeItem(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TeeButton;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.btnChangeItem }
begin
 Result := aCustomizeTasksPanelForm.btnChangeItem;
end;//TkwCustomizeTasksPanelFormBtnChangeItem.btnChangeItem

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

procedure TkwCustomizeTasksPanelFormBtnChangeItem.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnChangeItem', aCtx);
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

class function TkwCustomizeTasksPanelFormBtnChangeItem.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.btnChangeItem';
end;//TkwCustomizeTasksPanelFormBtnChangeItem.GetWordNameForRegister

function TkwCustomizeTasksPanelFormPnlOperationPos.pnlOperationPos(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TvtPanel;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.pnlOperationPos }
begin
 Result := aCustomizeTasksPanelForm.pnlOperationPos;
end;//TkwCustomizeTasksPanelFormPnlOperationPos.pnlOperationPos

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

procedure TkwCustomizeTasksPanelFormPnlOperationPos.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlOperationPos', aCtx);
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

class function TkwCustomizeTasksPanelFormPnlOperationPos.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.pnlOperationPos';
end;//TkwCustomizeTasksPanelFormPnlOperationPos.GetWordNameForRegister

function TkwCustomizeTasksPanelFormUpBitBtn.UpBitBtn(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.UpBitBtn }
begin
 Result := aCustomizeTasksPanelForm.UpBitBtn;
end;//TkwCustomizeTasksPanelFormUpBitBtn.UpBitBtn

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

procedure TkwCustomizeTasksPanelFormUpBitBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству UpBitBtn', aCtx);
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

class function TkwCustomizeTasksPanelFormUpBitBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.UpBitBtn';
end;//TkwCustomizeTasksPanelFormUpBitBtn.GetWordNameForRegister

function TkwCustomizeTasksPanelFormDownBitBtn.DownBitBtn(const aCtx: TtfwContext;
 aCustomizeTasksPanelForm: TCustomizeTasksPanelForm): TBitBtn;
 {* Реализация слова скрипта .TCustomizeTasksPanelForm.DownBitBtn }
begin
 Result := aCustomizeTasksPanelForm.DownBitBtn;
end;//TkwCustomizeTasksPanelFormDownBitBtn.DownBitBtn

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

procedure TkwCustomizeTasksPanelFormDownBitBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству DownBitBtn', aCtx);
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

class function TkwCustomizeTasksPanelFormDownBitBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCustomizeTasksPanelForm.DownBitBtn';
end;//TkwCustomizeTasksPanelFormDownBitBtn.GetWordNameForRegister

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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomizeTasksPanelForm));
 {* Регистрация типа CustomizeTasksPanel }
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
