unit NOT_FINISHED_ddTableConvParamDlg;

// Модуль: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_ddTableConvParamDlg.pas"
// Стереотип: "UtilityPack"

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , D_Base
;

type
 TTableConvParamDialog = class(TBaseDlg)
 end;//TTableConvParamDialog

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TTableConvParamDialogWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

end.
