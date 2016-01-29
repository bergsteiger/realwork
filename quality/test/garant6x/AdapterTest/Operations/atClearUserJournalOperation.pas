unit atClearUserJournalOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atClearUserJournalOperation.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatClearUserJournalOperation
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
 TatClearUserJournalOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 end;//TatClearUserJournalOperation

implementation

uses
  atUserJournalHelper,
  atLogger
  ;

// start class TatClearUserJournalOperation

procedure TatClearUserJournalOperation.ExecuteSelf;
//#UC START# *48089F460352_4FCCF88E0303_var*
//#UC END# *48089F460352_4FCCF88E0303_var*
begin
//#UC START# *48089F460352_4FCCF88E0303_impl*
  TatUserJournalHelper.Clear;
  Logger.Info('������ ������ ������');
//#UC END# *48089F460352_4FCCF88E0303_impl*
end;//TatClearUserJournalOperation.ExecuteSelf

end.