unit atCycleOperation;
 {* Пустая операция. Нужна чтобы циклически исполнять вложенные операции. }

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atCycleOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatCycleOperation" MUID: (489B0B86039C)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatCycleOperation = class(TatOperationBase)
  {* Пустая операция. Нужна чтобы циклически исполнять вложенные операции. }
  protected
   procedure ExecuteSelf; override;
 end;//TatCycleOperation

implementation

uses
 l3ImplUses
;

procedure TatCycleOperation.ExecuteSelf;
//#UC START# *48089F460352_489B0B86039C_var*
//#UC END# *48089F460352_489B0B86039C_var*
begin
//#UC START# *48089F460352_489B0B86039C_impl*
  // ничего не делаем
//#UC END# *48089F460352_489B0B86039C_impl*
end;//TatCycleOperation.ExecuteSelf

end.
