unit msmSaveChangedElements;

// Модуль: "w:\common\components\gui\Garant\msm\msmSaveChangedElements.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmSaveChangedElements" MUID: (57E10D840208)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmOperation
;

type
 TmsmSaveChangedElements = class(TmsmOperation)
  protected
   procedure DoDoIt; override;
 end;//TmsmSaveChangedElements

implementation

uses
 l3ImplUses
 , msmChangedElements
 //#UC START# *57E10D840208impl_uses*
 //#UC END# *57E10D840208impl_uses*
;

procedure TmsmSaveChangedElements.DoDoIt;
//#UC START# *57CEB1F602D1_57E10D840208_var*
//#UC END# *57CEB1F602D1_57E10D840208_var*
begin
//#UC START# *57CEB1F602D1_57E10D840208_impl*
 TmsmChangedElements.Instance.Save;
//#UC END# *57CEB1F602D1_57E10D840208_impl*
end;//TmsmSaveChangedElements.DoDoIt

end.
