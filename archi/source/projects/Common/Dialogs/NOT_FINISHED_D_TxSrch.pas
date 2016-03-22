unit NOT_FINISHED_D_TxSrch;

// Модуль: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_D_TxSrch.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "D_TxSrch" MUID: (4F8D618800E7)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
;

type
 TTextSearchDlg = class
 end;//TTextSearchDlg

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TTextSearchDlgWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

end.
