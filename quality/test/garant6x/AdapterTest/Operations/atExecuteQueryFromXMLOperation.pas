unit atExecuteQueryFromXMLOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atExecuteQueryFromXMLOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatExecuteQueryFromXMLOperation" MUID: (50085F6E0099)

interface

uses
 l3IntfUses
 , atOperationBase
 , Classes
 , atStringFileReader
 , atQuery
 , SearchUnit
;

type
 _atIterateThroughFilesAddOn_Parent_ = TatOperationBase;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atIterateThroughFilesAddOn.imp.pas}
 _atExecutesQueryAddOn_Parent_ = _atIterateThroughFilesAddOn_;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atExecutesQueryAddOn.imp.pas}
 TatExecuteQueryFromXMLOperation = class(_atExecutesQueryAddOn_)
  private
   f_IsIgnoreImportErrors: Boolean;
   f_IsCallChildsOnEmptyResult: Boolean;
   f_ImportErrors: TStringList;
  protected
   function OnFile(const aFileName: AnsiString): Boolean; override;
   procedure InitParamList; override;
   procedure ExecuteSelf; override;
   procedure ExecuteChilds; override;
 end;//TatExecuteQueryFromXMLOperation

implementation

uses
 l3ImplUses
 , atLogger
 , XMLDoc
 , XMLIntf
 , SysUtils
 , atFileInitializer
 , atFileIterator
 , atSyncedStringFileReader
 , atOperationEnv
 , atSearchHelper
 //#UC START# *50085F6E0099impl_uses*
 //#UC END# *50085F6E0099impl_uses*
;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atIterateThroughFilesAddOn.imp.pas}

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atExecutesQueryAddOn.imp.pas}

function TatExecuteQueryFromXMLOperation.OnFile(const aFileName: AnsiString): Boolean;
//#UC START# *502A649F0204_50085F6E0099_var*
  var
    l_Query : TatQuery;
    l_XML : IXMLDocument;
    l_ErrMsg : String;
    l_IsSuccessSearch : Boolean;
//#UC END# *502A649F0204_50085F6E0099_var*
begin
//#UC START# *502A649F0204_50085F6E0099_impl*
  Result := true;

  // парсим входящий файл
  try
    l_XML := TXMLDocument.Create(aFileName);
    l_XML.Active := true;
  except
    on ex : Exception do
    begin
      Logger.Exception(ex, 'Ошибка парсинга файла: ');
      Raise;
    end;
  end;

  f_ImportErrors.Clear;
  l_Query := TatQuery.CreateFromXML(l_XML, f_ImportErrors);
  try
    if f_ImportErrors.Count > 0 then
    begin
      l_ErrMsg := 'При импорте запроса некоторые атрибуты не найдены в базе: ' + f_ImportErrors.DelimitedText;
      if NOT f_IsIgnoreImportErrors then
      begin
        Logger.Error(l_ErrMsg);
        Result := false; // прерываем обход файлов
        Exit;
      end
      else
        Logger.Warning(l_ErrMsg);
    end;
    //
    l_IsSuccessSearch := ExecuteQuery(l_Query);
    if l_IsSuccessSearch OR f_IsCallChildsOnEmptyResult then
    begin
      if (NOT l_IsSuccessSearch) AND (ExecutionContext.UserWorkContext.CurrList <> nil) then
        ExecutionContext.UserWorkContext.AddListToHistory(nil);

      inherited ExecuteChilds;
    end;  
  finally
    FreeAndNil(l_Query);
  end;
//#UC END# *502A649F0204_50085F6E0099_impl*
end;//TatExecuteQueryFromXMLOperation.OnFile

procedure TatExecuteQueryFromXMLOperation.InitParamList;
//#UC START# *48089F3701B4_50085F6E0099_var*
//#UC END# *48089F3701B4_50085F6E0099_var*
begin
//#UC START# *48089F3701B4_50085F6E0099_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('is_ignore_import_errors', 'Игнорировать ошибки импорта запроса', 'true') );
    Add( ParamType.Create('is_call_childs_on_empty_result', 'Вызывать дочерние операции на пустом результате', 'false') );
  end;
//#UC END# *48089F3701B4_50085F6E0099_impl*
end;//TatExecuteQueryFromXMLOperation.InitParamList

procedure TatExecuteQueryFromXMLOperation.ExecuteSelf;
//#UC START# *48089F460352_50085F6E0099_var*
//#UC END# *48089F460352_50085F6E0099_var*
begin
//#UC START# *48089F460352_50085F6E0099_impl*
  f_IsIgnoreImportErrors := Parameters['is_ignore_import_errors'].AsBool;
  f_IsCallChildsOnEmptyResult := Parameters['is_call_childs_on_empty_result'].AsBool;
  f_ImportErrors := TStringList.Create;
  f_ImportErrors.Delimiter := ';';
  try
    inherited;
  finally
    FreeAndNil(f_ImportErrors);
  end;
//#UC END# *48089F460352_50085F6E0099_impl*
end;//TatExecuteQueryFromXMLOperation.ExecuteSelf

procedure TatExecuteQueryFromXMLOperation.ExecuteChilds;
//#UC START# *48089F660238_50085F6E0099_var*
//#UC END# *48089F660238_50085F6E0099_var*
begin
//#UC START# *48089F660238_50085F6E0099_impl*
  //
//#UC END# *48089F660238_50085F6E0099_impl*
end;//TatExecuteQueryFromXMLOperation.ExecuteChilds

end.
