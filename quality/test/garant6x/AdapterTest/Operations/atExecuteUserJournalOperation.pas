unit atExecuteUserJournalOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atExecuteUserJournalOperation.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatExecuteUserJournalOperation
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  atIterateUserJournalOperation,
  SearchUnit,
  atQuery,
  atUserJournalHelper
  ;

type
 _atExecutesQueryAddOn_Parent_ = TatIterateUserJournalOperation;
 {$Include ..\Operations\atExecutesQueryAddOn.imp.pas}
 TatExecuteUserJournalOperation = class(_atExecutesQueryAddOn_)
 protected
 // realized methods
   function OnQuery(const anQuery: TatQuery): Boolean; override;
   function OnBookmark(const aBookmark: TatJournalBookmark): Boolean; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
 end;//TatExecuteUserJournalOperation

implementation

uses
  atLogger,
  atDocumentHelper,
  atSearchHelper,
  BaseTypesUnit,
  SysUtils
  ;

{$Include ..\Operations\atExecutesQueryAddOn.imp.pas}

// start class TatExecuteUserJournalOperation

function TatExecuteUserJournalOperation.OnQuery(const anQuery: TatQuery): Boolean;
//#UC START# *5006F37302DF_4FC8B0A8002E_var*
//#UC END# *5006F37302DF_4FC8B0A8002E_var*
begin
//#UC START# *5006F37302DF_4FC8B0A8002E_impl*
  Result := Parameters['is_queries'].AsBool AND ExecuteQuery(anQuery);
//#UC END# *5006F37302DF_4FC8B0A8002E_impl*
end;//TatExecuteUserJournalOperation.OnQuery

function TatExecuteUserJournalOperation.OnBookmark(const aBookmark: TatJournalBookmark): Boolean;
//#UC START# *5006F4130346_4FC8B0A8002E_var*
  var
    l_DocReader : TatDocReader;
//#UC END# *5006F4130346_4FC8B0A8002E_var*
begin
//#UC START# *5006F4130346_4FC8B0A8002E_impl*
  Result := false;
  if NOT Parameters['is_bookmarks'].AsBool then Exit;

  Logger.Info('��������� �������� � ������ "%s" - ��� ���������� �� �������� � %d ��������� � %d',
    [aBookmark.Name, aBookmark.Para, aBookmark.Document.GetInternalId]);

  try
    l_DocReader := TatDocReader.Create(aBookmark.Document);
  except
    on ECanNotFindData do
    begin
      Logger.Info('�� ������� ������� �������� %d, ������, �� ��������� � ����', [aBookmark.Document.GetInternalId]);
      Exit;
    end;
  end;

  try
    l_DocReader.ReadFromPara(aBookmark.Para);
    ExecutionContext.UserWorkContext.AddDocToHistory(aBookmark.Document);
    Result := true;
  finally
    FreeAndNil(l_DocReader);
  end;
//#UC END# *5006F4130346_4FC8B0A8002E_impl*
end;//TatExecuteUserJournalOperation.OnBookmark

procedure TatExecuteUserJournalOperation.InitParamList;
//#UC START# *48089F3701B4_4FC8B0A8002E_var*
//#UC END# *48089F3701B4_4FC8B0A8002E_var*
begin
//#UC START# *48089F3701B4_4FC8B0A8002E_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('is_bookmarks', '��������� ��������', 'true') );
    Add( ParamType.Create('is_queries', '��������� �������', 'true') );
  end;
//#UC END# *48089F3701B4_4FC8B0A8002E_impl*
end;//TatExecuteUserJournalOperation.InitParamList

end.