unit CheckLst;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\CheckLst.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "CheckLst" MUID: (51F24E760273)

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
;

type
 TCheckListBox = class
 end;//TCheckListBox
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , CheckListBoxWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *51F24E760273impl_uses*
 //#UC END# *51F24E760273impl_uses*
;
{$IfEnd} // NOT Defined(NoVCL)

end.
