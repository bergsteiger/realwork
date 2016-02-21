unit NOT_FINISHED_ExprEditForm;

// Модуль: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_ExprEditForm.pas"
// Стереотип: "UtilityPack"

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
;

type
 TExprEditor = class
 end;//TExprEditor

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TExprEditorWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

end.
