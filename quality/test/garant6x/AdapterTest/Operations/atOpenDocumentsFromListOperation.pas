unit atOpenDocumentsFromListOperation;
 {* Открывает документы из списка документов }

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atOpenDocumentsFromListOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatOpenDocumentsFromListOperation" MUID: (4875E9B503DC)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatOpenDocumentsFromListOperation = class(TatOperationBase)
  {* Открывает документы из списка документов }
  protected
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
   procedure ExecuteChilds; override;
 end;//TatOpenDocumentsFromListOperation

implementation

uses
 l3ImplUses
 , atDocumentHelper
 , DocumentUnit
 , DynamicTreeUnit
 , atLogger
 , Math
 , BaseTypesUnit
 , DynamicDocListUnit
 , IOUnit
;

procedure TatOpenDocumentsFromListOperation.ExecuteSelf;
//#UC START# *48089F460352_4875E9B503DC_var*
  var
    l_Document : IDocument;
    l_ListElement, l_FirstListElement, l_ListRoot : INodeBase;
    l_ListEntryInfo : IListEntryInfo;
    l_Entity : IEntityBase;
    i, l_NumberOfDocs, l_DocsCount, l_StartFrom, l_EntriesToOpen : Integer;
    l_IsRandomOpen, l_IsEmulateOpening, l_IsFullLoad : Boolean;
    l_String : IString;

  procedure OpenDocumentOrEntry;
  begin
    if l_IsEmulateOpening then
      with TatDocReader.Create(l_Document) do
      try
        IsFullLoad := l_IsFullLoad;
        case l_ListEntryInfo.GetType of
          PT_SUB : ReadFromSub(l_ListEntryInfo.GetPosition);
          PT_PARA: ReadFromPara(l_ListEntryInfo.GetPosition);
        end;
      finally
        Free;
      end;
    // добавляем в историю
    ExecutionContext.UserWorkContext.AddDocToHistory(l_Document);
    // вызываем детей
    inherited ExecuteChilds;
  end;

  procedure GetDocFromCurrListElement;
  begin
    l_ListElement.GetEntity(l_Entity);
    Assert(l_Entity <> nil, 'l_Entity <> nil');
    l_ListEntryInfo := l_Entity as IListEntryInfo;
    l_ListEntryInfo.GetDoc(l_Document);
    Assert(l_Document <> nil, 'l_Document <> nil');
  end;

  procedure OpenDocumentWithEntries;
    var
      l_TempNode, l_CurrEdition : INodeBase;
      l_EntriesOpened : Integer;
      l_EntryTypeName : String;
  begin
    // получаем первый дочерний элемент документа в списке
    l_ListElement.GetFirstChild(l_TempNode);
    l_ListElement := l_TempNode;
    l_TempNode := nil;

    // перебираем вхождения документа, включая те что в редакциях
    l_EntriesOpened := 0;
    repeat
      if l_ListElement <> nil then
      begin // в списке еще что-то есть
        if TListNodeType(l_ListElement.GetType) = LNT_EDITIONS_GROUP then
        begin // и это что-то - группа редакций, значит начинаем их перебирать
          Assert(l_ListElement.HasChildren, 'l_ListElement.HasChildren');
          Logger.Info('У документа есть %d редакций, начинаем открывать их вхождения', [l_ListElement.GetChildCount]);
          l_ListElement.GetFirstChild(l_CurrEdition);
          Assert(l_CurrEdition <> nil, 'l_CurrEdition <> nil');
          l_ListElement := nil;
        end;
      end
      else if l_CurrEdition <> nil then
      begin // если вошли сюда, значит закончили перебирать вхождения текущей редакции
        // получаем следующую редакцию
        l_CurrEdition.GetNext(l_TempNode);
        l_CurrEdition := l_TempNode;
        l_TempNode := nil;
      end;
      // если изменилась текущая редакция надо получить первое вхождение
      if (l_ListElement = nil) AND (l_CurrEdition <> nil) then
      begin
        l_CurrEdition.GetCaption(l_String);
        Logger.Info('Открываем вхождения редакции "%s"', [l_String.GetData]);
        l_CurrEdition.GetFirstChild(l_ListElement);
      end;

      // к этому моменту если вхождения все еще есть то l_ListElement указывает на вхождение
      if l_ListElement = nil then Exit; // все перебрали

      // открываем текущее вхождение
      GetDocFromCurrListElement;
      //
      case l_ListEntryInfo.GetType of
        PT_PARA : l_EntryTypeName := 'параграфе';
        PT_SUB  : l_EntryTypeName := 'сабе';
      else
        Logger.Error('Вхождение не является параграфом или сабом, такое открывать не умеем');
        Exit;
      end;
      //
      l_ListElement.GetCaption(l_String);
      Logger.Info('Открываем вхождение № %d с именем "%s" документа %d на %s %d',
        [l_EntriesOpened+1, l_String.GetData(), l_Document.GetInternalId, l_EntryTypeName, l_ListEntryInfo.GetPosition]);
      //
      OpenDocumentOrEntry;
      Inc(l_EntriesOpened);

      // переходим к следующему элементу
      l_ListElement.GetNext(l_TempNode);
      l_ListElement := l_TempNode;
      l_TempNode := nil;
    until (l_EntriesOpened = l_EntriesToOpen);
  end;
//#UC END# *48089F460352_4875E9B503DC_var*
begin
//#UC START# *48089F460352_4875E9B503DC_impl*
  // проверяем что список нормальный и получаем корень
  with  ExecutionContext.UserWorkContext do
  begin
    Assert(CurrList <> nil, 'CurrList <> nil');
    CurrList.GetRoot(l_ListRoot);
  end;
  Assert(l_ListRoot <> nil, 'l_ListRoot <> nil');
  // получаем параметры
  l_NumberOfDocs := Parameters['number_of_docs'].AsInt;
  l_IsRandomOpen := Parameters['is_random_open'].AsBool;
  l_IsEmulateOpening := Parameters['is_emulate_opening'].AsBool;
  l_IsFullLoad := Parameters['is_full_load'].AsBool;
  l_StartFrom := Parameters['start_from'].AsInt;
  l_EntriesToOpen := Parameters['entries_to_open'].AsInt;
  // узнаем сколько документов в списке и получаем самый превый элемент списка
  l_DocsCount := l_ListRoot.GetChildCount;
  l_ListRoot.GetFirstChild(l_FirstListElement);
  Assert(l_FirstListElement <> nil, 'l_FirstListElement <> nil');
  // открываем столько документов сколько сказано или столько сколько сможем
  for i := l_StartFrom-1 to Min(l_DocsCount, l_NumberOfDocs + l_StartFrom - 1)-1 do
  begin
    if l_IsRandomOpen then
      l_FirstListElement.GetBySibblingIndex( RandomRange(0, l_DocsCount-1), l_ListElement )
    else
      l_FirstListElement.GetBySibblingIndex( i, l_ListElement );
    Assert(l_ListElement <> nil, 'l_ListElement <> nil');

    l_ListElement.GetCaption(l_String);
    Logger.Info('Обрабатываем %d-й документ с именем "%s"', [i, l_String.GetData]);

    if (l_EntriesToOpen > 0) AND l_ListElement.HasChildren then
      OpenDocumentWithEntries
    else
    begin
      GetDocFromCurrListElement;
      Logger.Info('Открываем документ. Номер документа %d.', [l_Document.GetInternalId]);
      OpenDocumentOrEntry;
    end;

  end;
//#UC END# *48089F460352_4875E9B503DC_impl*
end;//TatOpenDocumentsFromListOperation.ExecuteSelf

procedure TatOpenDocumentsFromListOperation.InitParamList;
//#UC START# *48089F3701B4_4875E9B503DC_var*
//#UC END# *48089F3701B4_4875E9B503DC_var*
begin
//#UC START# *48089F3701B4_4875E9B503DC_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('number_of_docs', 'Количество открываемых документов', '1') );
    Add( ParamType.Create('is_emulate_opening', 'Эмулировать ли открытие документа', 'true') );
    Add( ParamType.Create('is_random_open', 'Открывать документы не по порядку, а в случайном порядке', 'false') );
    Add( ParamType.Create('is_full_load', 'Прогружать полностью', 'false') );
    Add( ParamType.Create('start_from', 'Открывать с документа (по порядку)', '1') );
    Add( ParamType.Create('entries_to_open', 'Сколько вхождений открывать', '0') );
  end;
//#UC END# *48089F3701B4_4875E9B503DC_impl*
end;//TatOpenDocumentsFromListOperation.InitParamList

procedure TatOpenDocumentsFromListOperation.ExecuteChilds;
//#UC START# *48089F660238_4875E9B503DC_var*
//#UC END# *48089F660238_4875E9B503DC_var*
begin
//#UC START# *48089F660238_4875E9B503DC_impl*
  // дети выполняются явно в ExecuteSelf
//#UC END# *48089F660238_4875E9B503DC_impl*
end;//TatOpenDocumentsFromListOperation.ExecuteChilds

end.
