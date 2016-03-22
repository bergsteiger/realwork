unit NOT_FINISHED_D_PicSizeEdit;

// Модуль: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_D_PicSizeEdit.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "D_PicSizeEdit" MUID: (4F5760A80104)

{$Include w:\archi\source\projects\Common\arCommon.inc}

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
