unit atAbortOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atAbortOperation.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatAbortOperation
//
// ����������� ���������� ������ �����
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
 TatAbortOperation = class(TatOperationBase)
  {* ����������� ���������� ������ ����� }
 protected
 // realized methods
   procedure ExecuteSelf; override;
 end;//TatAbortOperation

implementation

uses
  Windows
  ;

// start class TatAbortOperation

procedure TatAbortOperation.ExecuteSelf;
//#UC START# *48089F460352_48A2A3F10001_var*
//#UC END# *48089F460352_48A2A3F10001_var*
begin
//#UC START# *48089F460352_48A2A3F10001_impl*
  TerminateProcess( GetCurrentProcess, 1 );
//#UC END# *48089F460352_48A2A3F10001_impl*
end;//TatAbortOperation.ExecuteSelf

end.