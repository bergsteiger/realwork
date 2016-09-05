unit msmRunner;

// Модуль: "w:\common\components\msm\msmRunner.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmRunner" MUID: (57A9BC090082)

{$Include w:\common\components\msm\msm.inc}

interface

uses
 l3IntfUses
 //#UC START# *57A9BC090082intf_uses*
 //#UC END# *57A9BC090082intf_uses*
;

type
 //#UC START# *57A9BC090082ci*
 //#UC END# *57A9BC090082ci*
 //#UC START# *57A9BC090082cit*
 //#UC END# *57A9BC090082cit*
 TmsmRunner = class
  public
   class procedure Run;
 //#UC START# *57A9BC090082publ*
 //#UC END# *57A9BC090082publ*
 end;//TmsmRunner

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , msmMainForm
 //#UC START# *57A9BC090082impl_uses*
 //#UC END# *57A9BC090082impl_uses*
;

class procedure TmsmRunner.Run;
//#UC START# *57A9BCA20257_57A9BC090082_var*
//#UC END# *57A9BCA20257_57A9BC090082_var*
begin
//#UC START# *57A9BCA20257_57A9BC090082_impl*
 TmsmMainForm.Run;
 Application.Run;
//#UC END# *57A9BCA20257_57A9BC090082_impl*
end;//TmsmRunner.Run

//#UC START# *57A9BC090082impl*
//#UC END# *57A9BC090082impl*

end.
