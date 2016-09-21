unit msmCopySelection;

// Модуль: "w:\common\components\gui\Garant\msm\msmCopySelection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmCopySelection" MUID: (57E2607203E3)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeOperation
;

type
 TmsmCopySelection = class(TmsmListLikeOperation)
  protected
   procedure DoDoIt; override;
 end;//TmsmCopySelection

implementation

uses
 l3ImplUses
 , msmElementSelectionDataObject
 //#UC START# *57E2607203E3impl_uses*
 , l3Base
 //#UC END# *57E2607203E3impl_uses*
;

procedure TmsmCopySelection.DoDoIt;
//#UC START# *57CEB1F602D1_57E2607203E3_var*
//#UC END# *57CEB1F602D1_57E2607203E3_var*
begin
//#UC START# *57CEB1F602D1_57E2607203E3_impl*
 l3System.SetClipboardData(TmsmElementSelectionDataObject.Make(Model.Selection));
//#UC END# *57CEB1F602D1_57E2607203E3_impl*
end;//TmsmCopySelection.DoDoIt

end.
