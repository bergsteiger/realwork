unit atLoadDocumentsByIDFromListOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atLoadDocumentsByIDFromListOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatLoadDocumentsByIDFromListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atOperationBase
  ;

type
 TatLoadDocumentsByIDFromListOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
   procedure ExecuteChilds; override;
 end;//TatLoadDocumentsByIDFromListOperation

implementation

uses
  atLogger,
  DocumentUnit,
  Classes,
  SysUtils,
  atDocumentHelper,
  IOUnit
  ;

// start class TatLoadDocumentsByIDFromListOperation

procedure TatLoadDocumentsByIDFromListOperation.ExecuteSelf;
//#UC START# *48089F460352_4811D5DD0028_var*
  var
    docNumbers : array of Integer;
    docNumber : integer;
    document : IDocument;
    missingInfo : IMissingInfo;
    objName, blocksInfo : IString;
    i : integer;
    isDocFounded, isInternalNumbers, isFullLoad : boolean;
    l_DocReader : TatDocReader;


//#UC END# *48089F460352_4811D5DD0028_var*
begin
//#UC START# *48089F460352_4811D5DD0028_impl*
  inherited;
  isFullLoad := Parameters['is_full_load'].AsBool;
  isInternalNumbers := Parameters['is_internal_numbers'].AsBool;
  // разбиваем список номеров документов в массив
  with TStringList.Create do
  try
    Delimiter := ';';
    DelimitedText := Parameters['documents_list'].AsStr;
    for i := 0 to Count-1 do
    begin
      SetLength(docNumbers, i+1);
      docNumbers[i] := StrToInt(Strings[i]);
      // конвертируем номера из привычных внутренних в нужные
      if isInternalNumbers then
        Inc(docNumbers[i], 100000);
    end;
  finally
    Free;
  end;
  //
  if ( High(docNumbers) = -1) then
    Raise( EInvalidOpParams.Create('Массив номеров документов пуст!') );
  //
  for i := Low(docNumbers) to High(docNumbers) do
  begin
    docNumber := docNumbers[i];

    Logger.Info('Получаем документ с номером ' + IntToStr(docNumber) + '.');
    isDocFounded := ExecutionContext.GblAdapterWorker.Common.GetDocumentOnNumber(docNumber, document, missingInfo);

    //
    if isDocFounded then
    begin // если документ найден
      Logger.Info('Успешно получили документ.');
      // то добавляем его в историю
      ExecutionContext.UserWorkContext.AddDocToHistory(document);
      // прогружаем данные документа
      l_DocReader := TatDocReader.Create(document);
      try
        l_DocReader.IsFullLoad := isFullLoad;
        l_DocReader.Read();
      finally
        FreeAndNil(l_DocReader);
      end;
      // и выполняем дочерние операции
      inherited ExecuteChilds;
    end
    else if Assigned(missingInfo) then
    begin // мы знаем почему не найден документ
      missingInfo.GetObjName(objName);
      missingInfo.GetBlocksInfo(blocksInfo);
      Logger.Error('Документ "%s" не найден потому что он содержится в отсутствующем блоке(ах) "%s"', [objName.GetData, blocksInfo.GetData]);
    end
    else // неизвестно почему документ не может быть открыт
      Logger.Error('Документ с номером %d не может быть открыт по неизвестной причине!', [docNumber]);
  end;
//#UC END# *48089F460352_4811D5DD0028_impl*
end;//TatLoadDocumentsByIDFromListOperation.ExecuteSelf

procedure TatLoadDocumentsByIDFromListOperation.InitParamList;
//#UC START# *48089F3701B4_4811D5DD0028_var*
//#UC END# *48089F3701B4_4811D5DD0028_var*
begin
//#UC START# *48089F3701B4_4811D5DD0028_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('documents_list') );
    Add( ParamType.Create('is_internal_numbers', 'Указаны внутренние номера', 'false') );
    Add( ParamType.Create('is_full_load', 'Прогружать полностью', 'false') );
  end;
//#UC END# *48089F3701B4_4811D5DD0028_impl*
end;//TatLoadDocumentsByIDFromListOperation.InitParamList

procedure TatLoadDocumentsByIDFromListOperation.ExecuteChilds;
//#UC START# *48089F660238_4811D5DD0028_var*
//#UC END# *48089F660238_4811D5DD0028_var*
begin
//#UC START# *48089F660238_4811D5DD0028_impl*
 // ничего не делаем, т.к. запускать детей будет ExecuteSelf
//#UC END# *48089F660238_4811D5DD0028_impl*
end;//TatLoadDocumentsByIDFromListOperation.ExecuteChilds

end.