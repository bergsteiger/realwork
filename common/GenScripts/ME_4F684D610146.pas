unit NOT_FINISHED_ddTableConvParamDlg;

// ������: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_ddTableConvParamDlg.pas"
// ���������: "UtilityPack"
// ������� ������: "ddTableConvParamDlg" MUID: (4F684D610146)

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
