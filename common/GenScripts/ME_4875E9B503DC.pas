unit atOpenDocumentsFromListOperation;
 {* ��������� ��������� �� ������ ���������� }

// ������: "w:\quality\test\garant6x\AdapterTest\Operations\atOpenDocumentsFromListOperation.pas"
// ���������: "SimpleClass"
// ������� ������: "TatOpenDocumentsFromListOperation" MUID: (4875E9B503DC)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatOpenDocumentsFromListOperation = class(TatOperationBase)
  {* ��������� ��������� �� ������ ���������� }
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
    // ��������� � �������
    ExecutionContext.UserWorkContext.AddDocToHistory(l_Document);
    // �������� �����
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
    // �������� ������ �������� ������� ��������� � ������
    l_ListElement.GetFirstChild(l_TempNode);
    l_ListElement := l_TempNode;
    l_TempNode := nil;

    // ���������� ��������� ���������, ������� �� ��� � ���������
    l_EntriesOpened := 0;
    repeat
      if l_ListElement <> nil then
      begin // � ������ ��� ���-�� ����
        if TListNodeType(l_ListElement.GetType) = LNT_EDITIONS_GROUP then
        begin // � ��� ���-�� - ������ ��������, ������ �������� �� ����������
          Assert(l_ListElement.HasChildren, 'l_ListElement.HasChildren');
          Logger.Info('� ��������� ���� %d ��������, �������� ��������� �� ���������', [l_ListElement.GetChildCount]);
          l_ListElement.GetFirstChild(l_CurrEdition);
          Assert(l_CurrEdition <> nil, 'l_CurrEdition <> nil');
          l_ListElement := nil;
        end;
      end
      else if l_CurrEdition <> nil then
      begin // ���� ����� ����, ������ ��������� ���������� ��������� ������� ��������
        // �������� ��������� ��������
        l_CurrEdition.GetNext(l_TempNode);
        l_CurrEdition := l_TempNode;
        l_TempNode := nil;
      end;
      // ���� ���������� ������� �������� ���� �������� ������ ���������
      if (l_ListElement = nil) AND (l_CurrEdition <> nil) then
      begin
        l_CurrEdition.GetCaption(l_String);
        Logger.Info('��������� ��������� �������� "%s"', [l_String.GetData]);
        l_CurrEdition.GetFirstChild(l_ListElement);
      end;

      // � ����� ������� ���� ��������� ��� ��� ���� �� l_ListElement ��������� �� ���������
      if l_ListElement = nil then Exit; // ��� ���������

      // ��������� ������� ���������
      GetDocFromCurrListElement;
      //
      case l_ListEntryInfo.GetType of
        PT_PARA : l_EntryTypeName := '���������';
        PT_SUB  : l_EntryTypeName := '����';
      else
        Logger.Error('��������� �� �������� ���������� ��� �����, ����� ��������� �� �����');
        Exit;
      end;
      //
      l_ListElement.GetCaption(l_String);
      Logger.Info('��������� ��������� � %d � ������ "%s" ��������� %d �� %s %d',
        [l_EntriesOpened+1, l_String.GetData(), l_Document.GetInternalId, l_EntryTypeName, l_ListEntryInfo.GetPosition]);
      //
      OpenDocumentOrEntry;
      Inc(l_EntriesOpened);

      // ��������� � ���������� ��������
      l_ListElement.GetNext(l_TempNode);
      l_ListElement := l_TempNode;
      l_TempNode := nil;
    until (l_EntriesOpened = l_EntriesToOpen);
  end;
//#UC END# *48089F460352_4875E9B503DC_var*
begin
//#UC START# *48089F460352_4875E9B503DC_impl*
  // ��������� ��� ������ ���������� � �������� ������
  with  ExecutionContext.UserWorkContext do
  begin
    Assert(CurrList <> nil, 'CurrList <> nil');
    CurrList.GetRoot(l_ListRoot);
  end;
  Assert(l_ListRoot <> nil, 'l_ListRoot <> nil');
  // �������� ���������
  l_NumberOfDocs := Parameters['number_of_docs'].AsInt;
  l_IsRandomOpen := Parameters['is_random_open'].AsBool;
  l_IsEmulateOpening := Parameters['is_emulate_opening'].AsBool;
  l_IsFullLoad := Parameters['is_full_load'].AsBool;
  l_StartFrom := Parameters['start_from'].AsInt;
  l_EntriesToOpen := Parameters['entries_to_open'].AsInt;
  // ������ ������� ���������� � ������ � �������� ����� ������ ������� ������
  l_DocsCount := l_ListRoot.GetChildCount;
  l_ListRoot.GetFirstChild(l_FirstListElement);
  Assert(l_FirstListElement <> nil, 'l_FirstListElement <> nil');
  // ��������� ������� ���������� ������� ������� ��� ������� ������� ������
  for i := l_StartFrom-1 to Min(l_DocsCount, l_NumberOfDocs + l_StartFrom - 1)-1 do
  begin
    if l_IsRandomOpen then
      l_FirstListElement.GetBySibblingIndex( RandomRange(0, l_DocsCount-1), l_ListElement )
    else
      l_FirstListElement.GetBySibblingIndex( i, l_ListElement );
    Assert(l_ListElement <> nil, 'l_ListElement <> nil');

    l_ListElement.GetCaption(l_String);
    Logger.Info('������������ %d-� �������� � ������ "%s"', [i, l_String.GetData]);

    if (l_EntriesToOpen > 0) AND l_ListElement.HasChildren then
      OpenDocumentWithEntries
    else
    begin
      GetDocFromCurrListElement;
      Logger.Info('��������� ��������. ����� ��������� %d.', [l_Document.GetInternalId]);
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
    Add( ParamType.Create('number_of_docs', '���������� ����������� ����������', '1') );
    Add( ParamType.Create('is_emulate_opening', '����������� �� �������� ���������', 'true') );
    Add( ParamType.Create('is_random_open', '��������� ��������� �� �� �������, � � ��������� �������', 'false') );
    Add( ParamType.Create('is_full_load', '���������� ���������', 'false') );
    Add( ParamType.Create('start_from', '��������� � ��������� (�� �������)', '1') );
    Add( ParamType.Create('entries_to_open', '������� ��������� ���������', '0') );
  end;
//#UC END# *48089F3701B4_4875E9B503DC_impl*
end;//TatOpenDocumentsFromListOperation.InitParamList

procedure TatOpenDocumentsFromListOperation.ExecuteChilds;
//#UC START# *48089F660238_4875E9B503DC_var*
//#UC END# *48089F660238_4875E9B503DC_var*
begin
//#UC START# *48089F660238_4875E9B503DC_impl*
  // ���� ����������� ���� � ExecuteSelf
//#UC END# *48089F660238_4875E9B503DC_impl*
end;//TatOpenDocumentsFromListOperation.ExecuteChilds

end.
