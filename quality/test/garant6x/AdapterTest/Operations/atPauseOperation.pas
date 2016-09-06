unit atPauseOperation;
 {* ѕриостанавливает выполнение до нажати€ пользователем Enter }

// ћодуль: "w:\quality\test\garant6x\AdapterTest\Operations\atPauseOperation.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TatPauseOperation" MUID: (4A5222F60224)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatPauseOperation = class(TatOperationBase)
  {* ѕриостанавливает выполнение до нажати€ пользователем Enter }
  protected
   procedure ExecuteSelf; override;
 end;//TatPauseOperation

implementation

uses
 l3ImplUses
 , atLogger
 //#UC START# *4A5222F60224impl_uses*
 //#UC END# *4A5222F60224impl_uses*
;

procedure TatPauseOperation.ExecuteSelf;
//#UC START# *48089F460352_4A5222F60224_var*
//#UC END# *48089F460352_4A5222F60224_var*
begin
//#UC START# *48089F460352_4A5222F60224_impl*
  WriteLn('Press Enter to continue...');
  Flush(Output);
  Logger.Info('¬ыполнение приостановлено до нажати€ Enter пользователем');
  ReadLn;
  Logger.Info('ѕродолжаем работу');
//#UC END# *48089F460352_4A5222F60224_impl*
end;//TatPauseOperation.ExecuteSelf

end.
