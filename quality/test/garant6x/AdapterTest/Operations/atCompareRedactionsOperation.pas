unit atCompareRedactionsOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atCompareRedactionsOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatCompareRedactionsOperation
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
 TatCompareRedactionsOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
 end;//TatCompareRedactionsOperation

implementation

uses
  DocumentUnit,
  atLogger,
  atDocumentHelper
  ;

// start class TatCompareRedactionsOperation

procedure TatCompareRedactionsOperation.ExecuteSelf;
//#UC START# *48089F460352_4BAB7804006B_var*
  var
    l_Document : IDocument;
    l_DocState : IDocumentState;
    l_PrevRedactionsList : IRedactionInfoList;
    l_RedactionInfo : TRedactionInfo;
    i, l_DiffsCount,  l_ComparedRedaction, l_MaxDiffsCount : Integer;
    l_DiffData : TDiffData;
    l_ParaNum : TParaNum;
    l_EP : TEntryPoint;
//#UC END# *48089F460352_4BAB7804006B_var*
begin
//#UC START# *48089F460352_4BAB7804006B_impl*
  inherited;
  //
  l_ComparedRedaction := Parameters['compared_redaction'].AsInt;
  l_MaxDiffsCount := Parameters['max_diffs_count'].AsInt;
  //
  l_Document := ExecutionContext.UserWorkContext.CurrDoc;
  if (l_Document = nil) then
  begin
    Logger.Error('Нет открытого документа!');
    Exit;
  end;
  //
  l_Document.GetCurrentState(l_DocState);
  Assert(l_DocState <> nil);
  // получаем список редакций, с которыми будем сравнивать документ
  l_DocState.GetPrevRedactionsList(l_PrevRedactionsList);
  if (l_PrevRedactionsList = nil) OR (l_PrevRedactionsList.Count = 0) then
  begin
    Logger.Info('У документа нет предыдущих редакций!');
    Exit;
  end;

  // перебираем список редакций
  for i := 0 to l_PrevRedactionsList.Count-1 do
  begin
    l_PrevRedactionsList.pm_GetItem(i, l_RedactionInfo);

    if (l_ComparedRedaction <> -1) AND (l_RedactionInfo.rId <> l_ComparedRedaction) then
      continue;

    if (NOT l_RedactionInfo.rIsComparable) then
    begin
      Logger.Warning('Редакция %d не сравниваема', [l_RedactionInfo.rId]);
      continue;
    end;

    Logger.Info('Сравниваем документ %d с редакцией %d', [l_Document.GetInternalId, l_RedactionInfo.rId]);
    // сравниваем
    l_DocState.DiffWithRedactionById(l_RedactionInfo.rId, l_DiffData);

    // проходим по различиям
    l_DiffsCount := 0;
    while ((l_MaxDiffsCount = -1) OR (l_DiffsCount < l_MaxDiffsCount))
      AND l_DiffData.rDiffIterator.HasNext do
    begin
      l_ParaNum := l_DiffData.rDiffIterator.Next;
      //
      if TatDocumentHelper.FindPara(l_DiffData.rCur, l_ParaNum, l_EP) then
        TatDocumentHelper.ReadPara(l_DiffData.rCur, l_EP);
      if TatDocumentHelper.FindPara(l_DiffData.rPrev, l_ParaNum, l_EP) then
        TatDocumentHelper.ReadPara(l_DiffData.rPrev, l_EP);
      //
      Inc(l_DiffsCount);
    end;
  end;
//#UC END# *48089F460352_4BAB7804006B_impl*
end;//TatCompareRedactionsOperation.ExecuteSelf

procedure TatCompareRedactionsOperation.InitParamList;
//#UC START# *48089F3701B4_4BAB7804006B_var*
//#UC END# *48089F3701B4_4BAB7804006B_var*
begin
//#UC START# *48089F3701B4_4BAB7804006B_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('compared_redaction', 'Номер сравниваемой редакции', '-1') );
    Add( ParamType.Create('max_diffs_count', 'Просматривать не более стольки различий', '-1') );
  end;
//#UC END# *48089F3701B4_4BAB7804006B_impl*
end;//TatCompareRedactionsOperation.InitParamList

end.