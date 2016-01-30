unit NOT_FINISHED_d_edMSub;

// Модуль: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_d_edMSub.pas"
// Стереотип: "UtilityPack"

{$Include arCommon.inc}

interface

uses
 l3IntfUses
;

type
 TNewSubDlg = class
  {* Диалог редакторования саба. }
 end;//TNewSubDlg

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TNewSubDlgWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

end.
