unit atLogoutOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atLogoutOperation.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatLogoutOperation
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
 TatLogoutOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 end;//TatLogoutOperation

implementation

// start class TatLogoutOperation

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