unit msmGenerateElement;

// Модуль: "w:\common\components\gui\Garant\msm\msmGenerateElement.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmGenerateElement" MUID: (57DFE4880208)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeOperation
;

type
 TmsmGenerateElement = class(TmsmListLikeOperation)
  protected
   procedure DoDoIt; override;
 end;//TmsmGenerateElement

implementation

uses
 l3ImplUses
 , msmModelElementMethodCaller
 //#UC START# *57DFE4880208impl_uses*
 , msmBaseModelElement
 //#UC END# *57DFE4880208impl_uses*
;

procedure TmsmGenerateElement.DoDoIt;
//#UC START# *57CEB1F602D1_57DFE4880208_var*
//#UC END# *57CEB1F602D1_57DFE4880208_var*
begin
//#UC START# *57CEB1F602D1_57DFE4880208_impl*
 Assert(Model.CurrentElement <> nil);
 TmsmModelElementMethodCaller.RawCall((Model.CurrentElement As ITmsmBaseModelElementWrap).GetSelf.MainWord, 'GenerateElement');
//#UC END# *57CEB1F602D1_57DFE4880208_impl*
end;//TmsmGenerateElement.DoDoIt

end.
