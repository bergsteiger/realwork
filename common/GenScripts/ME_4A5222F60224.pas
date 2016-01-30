unit atPauseOperation;
 {* ���������������� ���������� �� ������� ������������� Enter }

// ������: "w:\quality\test\garant6x\AdapterTest\Operations\atPauseOperation.pas"
// ���������: "SimpleClass"

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatPauseOperation = class(TatOperationBase)
  {* ���������������� ���������� �� ������� ������������� Enter }
  protected
   procedure ExecuteSelf; override;
 end;//TatPauseOperation

implementation

uses
 l3ImplUses
 , atLogger
;

procedure TatPauseOperation.ExecuteSelf;
//#UC START# *48089F460352_4A5222F60224_var*
//#UC END# *48089F460352_4A5222F60224_var*
begin
//#UC START# *48089F460352_4A5222F60224_impl*
  WriteLn('Press Enter to continue...');
  Flush(Output);
  Logger.Info('���������� �������������� �� ������� Enter �������������');
  ReadLn;
  Logger.Info('���������� ������');
//#UC END# *48089F460352_4A5222F60224_impl*
end;//TatPauseOperation.ExecuteSelf

end.
