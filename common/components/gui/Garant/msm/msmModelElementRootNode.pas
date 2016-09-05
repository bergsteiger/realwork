unit msmModelElementRootNode;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementRootNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementRootNode" MUID: (57C9A4830362)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmModelElementNode
 , msmElementViews
 //#UC START# *57C9A4830362intf_uses*
 //#UC END# *57C9A4830362intf_uses*
;

type
 //#UC START# *57C9A4830362ci*
 //#UC END# *57C9A4830362ci*
 //#UC START# *57C9A4830362cit*
 //#UC END# *57C9A4830362cit*
 TmsmModelElementRootNode = class(TmsmModelElementNode)
  public
   constructor Create(const anElement: TmsmModelElementView); reintroduce;
 //#UC START# *57C9A4830362publ*
 //#UC END# *57C9A4830362publ*
 end;//TmsmModelElementRootNode

implementation

uses
 l3ImplUses
 //#UC START# *57C9A4830362impl_uses*
 //#UC END# *57C9A4830362impl_uses*
;

constructor TmsmModelElementRootNode.Create(const anElement: TmsmModelElementView);
//#UC START# *57C9A6470169_57C9A4830362_var*
//#UC END# *57C9A6470169_57C9A4830362_var*
begin
//#UC START# *57C9A6470169_57C9A4830362_impl*
 inherited Create(anElement, -1);
//#UC END# *57C9A6470169_57C9A4830362_impl*
end;//TmsmModelElementRootNode.Create

//#UC START# *57C9A4830362impl*
//#UC END# *57C9A4830362impl*

end.
