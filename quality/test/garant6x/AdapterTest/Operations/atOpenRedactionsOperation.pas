unit atOpenRedactionsOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atOpenRedactionsOperation.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatOpenRedactionsOperation
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  atOperationBase,
  atLoadDocumentsByIDFromListOperation
  ;

type
 TatOpenRedactionsOperation = class(TatOperationBase)
 private
 // private fields
   f_LoadDocumentByIDFromListOperation : TatLoadDocumentsByIDFromListOperation;
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure InitFields; override;
   procedure ExecuteChilds; override;
 end;//TatOpenRedactionsOperation

implementation

uses
  DocumentUnit,
  atLogger,
  atStringHelper,
  SysUtils
  ;

// start class TatOpenRedactionsOperation

procedure TatOpenRedactionsOperation.ExecuteSelf;
//#UC START# *48089F460352_48B560B601B8_var*
  var
    l_RedactionsList : IRedactionInfoList;
    l_Redaction : TRedactionInfo;
    i : integer;
//#UC END# *48089F460352_48B560B601B8_var*
begin
//#UC START# *48089F460352_48B560B601B8_impl*
  inherited;
  // �������� ������ ��������
  with ExecutionContext.UserWorkContext do
  begin
    Assert(CurrDoc <> nil, 'CurrDoc <> nil');
    Logger.Info('�������� ����� ��������...');
    CurrDoc.GetRedactionsList(l_RedactionsList);
  end;
  Assert(l_RedactionsList <> nil, 'l_RedactionsList <> nil');
  if (l_RedactionsList.Count = 0) then
  begin
    Logger.Info('������ �������� ����.');
    Exit;
  end;
  // ���������� ��������
  for i := 0 to l_RedactionsList.Count-1 do
  begin
    l_RedactionsList.pm_GetItem(i, l_Redaction);
    // ��������� ��������
    Logger.Info('�������� ��������: "%s". �����: %d.', [TatStringHelper.AStr2DStr(l_Redaction.rName), l_Redaction.rId]);
    with f_LoadDocumentByIDFromListOperation do
    begin
      Logger.Info('������ ������������� ��������� %s ��� �������� ���������', [ClassName]);
      Parameters['documents_list'].AsStr := IntToStr(l_Redaction.rId);
      Execute(ExecutionContext);
    end;
    // ��������� �����
    inherited ExecuteChilds;
  end;
//#UC END# *48089F460352_48B560B601B8_impl*
end;//TatOpenRedactionsOperation.ExecuteSelf

procedure TatOpenRedactionsOperation.Cleanup;
//#UC START# *479731C50290_48B560B601B8_var*
//#UC END# *479731C50290_48B560B601B8_var*
begin
//#UC START# *479731C50290_48B560B601B8_impl*
  FreeAndNil(f_LoadDocumentByIDFromListOperation);
  inherited;
//#UC END# *479731C50290_48B560B601B8_impl*
end;//TatOpenRedactionsOperation.Cleanup

procedure TatOpenRedactionsOperation.InitFields;
//#UC START# *47A042E100E2_48B560B601B8_var*
//#UC END# *47A042E100E2_48B560B601B8_var*
begin
//#UC START# *47A042E100E2_48B560B601B8_impl*
  inherited;
  f_LoadDocumentByIDFromListOperation := TatLoadDocumentsByIDFromListOperation.Create;
//#UC END# *47A042E100E2_48B560B601B8_impl*
end;//TatOpenRedactionsOperation.InitFields

procedure TatOpenRedactionsOperation.ExecuteChilds;
//#UC START# *48089F660238_48B560B601B8_var*
//#UC END# *48089F660238_48B560B601B8_var*
begin
//#UC START# *48089F660238_48B560B601B8_impl*
  // ���� ����������� ���� � ExecuteSelf
//#UC END# *48089F660238_48B560B601B8_impl*
end;//TatOpenRedactionsOperation.ExecuteChilds

end.