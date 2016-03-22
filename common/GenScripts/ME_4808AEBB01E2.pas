unit atLogoutOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atLogoutOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatLogoutOperation" MUID: (4808AEBB01E2)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatLogoutOperation = class(TatOperationBase)
  protected
   procedure ExecuteSelf; override;
 end;//TatLogoutOperation

implementation

uses
 l3ImplUses
;

procedure TatLogoutOperation.ExecuteSelf;
//#UC START# *48089F460352_4808AEBB01E2_var*
//#UC END# *48089F460352_4808AEBB01E2_var*
begin
//#UC START# *48089F460352_4808AEBB01E2_impl*
    inherited;
    ExecutionContext.UserWorkContext.Clear;
    ExecutionContext.GblAdapterWorker.Logout;
//#UC END# *48089F460352_4808AEBB01E2_impl*
end;//TatLogoutOperation.ExecuteSelf

end.
