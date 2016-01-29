unit atCycleOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atCycleOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatCycleOperation
//
// Пустая операция. Нужна чтобы циклически исполнять вложенные операции.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atOperationBase
  ;

type
 TatCycleOperation = class(TatOperationBase)
  {* Пустая операция. Нужна чтобы циклически исполнять вложенные операции. }
 protected
 // realized methods
   procedure ExecuteSelf; override;
 end;//TatCycleOperation

implementation

// start class TatCycleOperation

procedure TatCycleOperation.ExecuteSelf;
//#UC START# *48089F460352_489B0B86039C_var*
//#UC END# *48089F460352_489B0B86039C_var*
begin
//#UC START# *48089F460352_489B0B86039C_impl*
  // ничего не делаем
//#UC END# *48089F460352_489B0B86039C_impl*
end;//TatCycleOperation.ExecuteSelf

end.