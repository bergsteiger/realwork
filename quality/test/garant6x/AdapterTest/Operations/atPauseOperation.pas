unit atPauseOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atPauseOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatPauseOperation
//
// Приостанавливает выполнение до нажатия пользователем Enter
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
 TatPauseOperation = class(TatOperationBase)
  {* Приостанавливает выполнение до нажатия пользователем Enter }
 protected
 // realized methods
   procedure ExecuteSelf; override;
 end;//TatPauseOperation

implementation

uses
  atLogger
  ;

// start class TatPauseOperation

procedure TatPauseOperation.ExecuteSelf;
//#UC START# *48089F460352_4A5222F60224_var*
//#UC END# *48089F460352_4A5222F60224_var*
begin
//#UC START# *48089F460352_4A5222F60224_impl*
  WriteLn('Press Enter to continue...');
  Flush(Output);
  Logger.Info('Выполнение приостановлено до нажатия Enter пользователем');
  ReadLn;
  Logger.Info('Продолжаем работу');
//#UC END# *48089F460352_4A5222F60224_impl*
end;//TatPauseOperation.ExecuteSelf

end.