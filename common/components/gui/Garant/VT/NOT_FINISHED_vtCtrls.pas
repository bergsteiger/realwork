unit NOT_FINISHED_vtCtrls;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtCtrls.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vtCtrls" MUID: (4AC0B2A102BE)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvtSplitter = class
 end;//TvtSplitter

 TvtComboBox = class({$If NOT Defined(NoVCL)}
 TComboBox
 {$IfEnd} // NOT Defined(NoVCL)
 )
 end;//TvtComboBox

procedure AdjustCtrl;

implementation

uses
 l3ImplUses
 //#UC START# *4AC0B2A102BEimpl_uses*
 //#UC END# *4AC0B2A102BEimpl_uses*
;

procedure AdjustCtrl;
//#UC START# *4AC0B2B302FE_4AC0B2A102BE_var*
//#UC END# *4AC0B2B302FE_4AC0B2A102BE_var*
begin
//#UC START# *4AC0B2B302FE_4AC0B2A102BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC0B2B302FE_4AC0B2A102BE_impl*
end;//AdjustCtrl

end.
