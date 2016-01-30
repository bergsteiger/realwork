unit NOT_FINISHED_D_PicSizeEdit;

// Модуль: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_D_PicSizeEdit.pas"
// Стереотип: "UtilityPack"

{$Include arCommon.inc}

interface

uses
 l3IntfUses
;

type
 TPicSizeEditDlg = class
 end;//TPicSizeEditDlg

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TPicSizeEditDlgWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

end.
