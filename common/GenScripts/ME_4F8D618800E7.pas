unit NOT_FINISHED_D_TxSrch;

// Модуль: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_D_TxSrch.pas"
// Стереотип: "UtilityPack"

{$Include arCommon.inc}

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
