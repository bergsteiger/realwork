unit atExecuteUserJournalOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atExecuteUserJournalOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatExecuteUserJournalOperation" MUID: (4FC8B0A8002E)

interface

uses
 l3IntfUses
 , atIterateUserJournalOperation
 , atQuery
 , atUserJournalHelper
 , SearchUnit
;

type
 _atExecutesQueryAddOn_Parent_ = TatIterateUserJournalOperation;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atExecutesQueryAddOn.imp.pas}
 TatExecuteUserJournalOperation = class(_atExecutesQueryAddOn_)
  protected
   function OnQuery(const anQuery: TatQuery): Boolean; override;
   function OnBookmark(const aBookmark: TatJournalBookmark): Boolean; override;
   procedure InitParamList; override;
 end;//TatExecuteUserJournalOperation

implementation

uses
 l3ImplUses
 , atLogger
 , atDocumentHelper
 , atSearchHelper
 , BaseTypesUnit
 , SysUtils
 //#UC START# *4FC8B0A8002Eimpl_uses*
 //#UC END# *4FC8B0A8002Eimpl_uses*
;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atExecutesQueryAddOn.imp.pas}

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

  Logger.Info('Открываем закладку с именем "%s" - она показывает на параграф № %d документа № %d',
    [aBookmark.Name, aBookmark.Para, aBookmark.Document.GetInternalId]);

  try
    l_DocReader := TatDocReader.Create(aBookmark.Document);
  except
    on ECanNotFindData do
    begin
      Logger.Info('Не удается открыть документ %d, видимо, он отсутвует в базе', [aBookmark.Document.GetInternalId]);
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
    Add( ParamType.Create('is_bookmarks', 'Открывать закладки', 'true') );
    Add( ParamType.Create('is_queries', 'Выполнять запросы', 'true') );
  end;
//#UC END# *48089F3701B4_4FC8B0A8002E_impl*
end;//TatExecuteUserJournalOperation.InitParamList

end.
