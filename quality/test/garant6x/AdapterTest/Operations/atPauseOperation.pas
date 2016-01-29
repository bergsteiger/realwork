unit atPauseOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atPauseOperation.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatPauseOperation
//
// ���������������� ���������� �� ������� ������������� Enter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  atOperationBase
  ;

type
 TatPauseOperation = class(TatOperationBase)
  {* ���������������� ���������� �� ������� ������������� Enter }
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
  Logger.Info('���������� �������������� �� ������� Enter �������������');
  ReadLn;
  Logger.Info('���������� ������');
//#UC END# *48089F460352_4A5222F60224_impl*
end;//TatPauseOperation.ExecuteSelf

end.