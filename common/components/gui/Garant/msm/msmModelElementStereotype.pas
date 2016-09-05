unit msmModelElementStereotype;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementStereotype.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementStereotype" MUID: (57AB18FF00B2)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmBaseModelElement
 , msmModelElements
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TmsmModelElementStereotype = class(TmsmBaseModelElement, ImsmModelElementStereotype)
  public
   class function Make(aMainWord: TtfwWord): ImsmModelElementStereotype; reintroduce;
 end;//TmsmModelElementStereotype

implementation

uses
 l3ImplUses
 //#UC START# *57AB18FF00B2impl_uses*
 //#UC END# *57AB18FF00B2impl_uses*
;

class function TmsmModelElementStereotype.Make(aMainWord: TtfwWord): ImsmModelElementStereotype;
var
 l_Inst : TmsmModelElementStereotype;
begin
 l_Inst := Create(aMainWord);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmModelElementStereotype.Make

end.
