unit dt_Utils;

interface
uses
 l3LongintList,

 HT_Const,

 dt_Types,
 dt_doc,

 evdTasksHelpers
 ;



procedure ConvertList2Storage(aTopicList: DocumentIDListHelper; aDocStorage: TDocumentSabList; aRenum: Boolean = True; ConvertRelsToDoc: Boolean = False); overload;
procedure ConvertList2Storage(aTopicList: Tl3LongintList; aDocStorage: TDocumentSabList; aRenum: Boolean = True; ConvertRelsToDoc: Boolean = False); overload;

procedure ConvertList2Text(aDocNumList: DocumentIDListHelper; var aText: String; aRenum: Boolean = True); overload;
procedure ConvertList2Text(aDocNumList: Tl3LongintList; var aText: String; aRenum: Boolean = True); overload;

function CheckTableStruct(const aTableName: string; const aStruct: array of ThtElementInfo): Boolean; overload;
function CheckTableStruct(const aTableHandle: ThtTblHandle; const aStruct: array of ThtElementInfo): Boolean; overload;

implementation
uses
 HT_DLL,
 dt_LinkServ,
 dt_Const,
 dtIntf, DT_Sab,
 SysUtils, l3String,
 Classes, Dt_ReNum, m2MemLib;

procedure ConvertSub2Storage(const aSab: ISab; aDocStorage: TDocumentSabList; aRenum: Boolean; ConvertRelsToDoc: Boolean);
var
 lSabRel : ISab;
begin
 if aRenum then
 begin
  aSab.RecordsByKey;
  aSab.ValuesOfKey(rnRealID_fld);
 end;

 if ConvertRelsToDoc then
 begin
  lSabRel := MakeSabCopy(aSab);
  aSab.TransferToPhoto(fID_Fld, DocumentServer.FileTbl);
  aSab.RecordsByKey;
  lSabRel.TransferToPhoto(fRelated_fld, DocumentServer.FileTbl);
  lSabRel.RecordsByKey;
  aSab.OrSab(lSabRel);
 end
 else
 begin
  aSab.TransferToPhoto(fID_Fld, DocumentServer.FileTbl);
  aSab.RecordsByKey;
 end;

 aSab.ValuesOfKey(fID_Fld);
 aDocStorage.CurSab := aSab;
end;

procedure ConvertList2Storage(aTopicList: Tl3LongintList; aDocStorage: TDocumentSabList; aRenum: Boolean = True; ConvertRelsToDoc: Boolean = False);
begin
 ConvertSub2Storage(MakeValueSet(LinkServer(CurrentFamily).ReNum, rnImportID_fld, aTopicList), aDocStorage, aRenum, ConvertRelsToDoc);
end;

procedure ConvertList2Storage(aTopicList: DocumentIDListHelper; aDocStorage: TDocumentSabList; aRenum: Boolean = True; ConvertRelsToDoc: Boolean = False);
begin
 ConvertSub2Storage(MakeValueSet(LinkServer(CurrentFamily).ReNum, rnImportID_fld, aTopicList), aDocStorage, aRenum, ConvertRelsToDoc);
end;

procedure ConvertList2Text(aDocNumList: DocumentIDListHelper; var aText: String; aRenum: Boolean = True);
var
 l_Sab          : ISab;
 l_Filler       : IValueSetFiller;
 l_RelText      : String;
 l_DocID        : TDocID;
 l_IteratorStub : TdtRecAccessProc;
 i              : Integer;

 function l_Iterator(aRec: PIDFNameRec): Boolean;
 begin
  Result := True; // обрабатываем все записи
  if ARec^.rDocID <> 0 then
    aText := SysUtils.Format('%s'#13#10'%d'#9'%s', [aText,
          LinkServer(CurrentFamily).ReNum.GetExtDocID(aRec^.rDocID),
          l3ArrayToString(aRec^.rName, cFullNameSize)]);
 end;

begin
 DocumentServer.Family := CurrentFamily;
 l_Sab := MakeSab(DocumentServer.FileTbl);
 try
  l_RelText:= '';

  l_Filler := l_Sab.MakeValueSetFiller(fId_Fld);
  try
   for i:= 0 to Pred(aDocNumList.Count) do
   try
    if aRenum then // Список содержит внутренние номера
     l_DocID := LinkServer(CurrentFamily).ReNum.ConvertToRealNumber(aDocNumList.Items[i])
    else
     l_DocID := aDocNumList.Items[i];
    l_Filler.AddValue(l_DocID);
   except
    // Это справки
    if aDocNumList.Items[i] <> 0 then
     l_RelText := SysUtils.Format('%s'#13#10'%d', [l_RelText, l_DocID]);
   end;
  finally
   l_Filler := nil;
  end;
  l_Sab.RecordsByKey;

  aText := SysUtils.Format('Список содержит: документов - %d, справок - %d.'#13#10, [l_Sab.Count, aDocNumList.Count-l_Sab.Count]);

  l_IteratorStub := L2RecAccessProc(@l_Iterator);
  try
   l_Sab.IterateRecords(l_IteratorStub, [fId_Fld, fFName_Fld]);
  finally
   FreeRecAccessProc(l_IteratorStub);
  end;

  aText:= aText + #13#10 + l_RelText;
 finally
  l_Sab := nil;
 end;
end;

procedure ConvertList2Text(aDocNumList: Tl3LongintList; var aText: String; aRenum: Boolean = True);
var
 l_Sab          : ISab;
 l_Filler       : IValueSetFiller;
 l_RelText      : String;
 l_DocID        : TDocID;
 l_IteratorStub : TdtRecAccessProc;
 i              : Integer;

 function l_Iterator(aRec: PIDFNameRec): Boolean;
 begin
  Result := True; // обрабатываем все записи
  if ARec^.rDocID <> 0 then
    aText := SysUtils.Format('%s'#13#10'%d'#9'%s', [aText,
          LinkServer(CurrentFamily).ReNum.GetExtDocID(aRec^.rDocID),
          l3ArrayToString(aRec^.rName, cFullNameSize)]);
 end;

begin
 DocumentServer.Family := CurrentFamily;
 l_Sab := MakeSab(DocumentServer.FileTbl);
 try
  l_RelText:= '';

  l_Filler := l_Sab.MakeValueSetFiller(fId_Fld);
  try
   for i:= 0 to aDocNumList.Hi do
   try
    if aRenum then // Список содержит внутренние номера
     l_DocID := LinkServer(CurrentFamily).ReNum.ConvertToRealNumber(aDocNumList.Items[i])
    else
     l_DocID := aDocNumList.Items[i];
    l_Filler.AddValue(l_DocID);
   except
    // Это справки
    if aDocNumList.Items[i] <> 0 then
     l_RelText := SysUtils.Format('%s'#13#10'%d', [l_RelText, l_DocID]);
   end;
  finally
   l_Filler := nil;
  end;
  l_Sab.RecordsByKey;

  aText := SysUtils.Format('Список содержит: документов - %d, справок - %d.'#13#10, [l_Sab.Count, aDocNumList.Count-l_Sab.Count]);

  l_IteratorStub := L2RecAccessProc(@l_Iterator);
  try
   l_Sab.IterateRecords(l_IteratorStub, [fId_Fld, fFName_Fld]);
  finally
   FreeRecAccessProc(l_IteratorStub);
  end;

  aText:= aText + #13#10 + l_RelText;
 finally
  l_Sab := nil;
 end;
end;

function CheckTableStruct(const aTableHandle: ThtTblHandle; const aStruct: array of ThtElementInfo): Boolean;
var
 l_BufLen: Integer;
 l_ElemBuf: Pointer;
 l_ElemNo: Integer;
 l_Info : ThtTableInfoRec;
begin
 Result := False;
 if htTableInfo(aTableHandle, l_Info) = 0 then
 begin
  l_ElemNo := l_Info.nFieldCnt + l_Info.nGroupCnt + l_Info.nSubstrCnt;
  if l_ElemNo = Length(aStruct) then
  begin
   l_BufLen := l_ElemNo * SizeOf(ThtElementInfo);
   GetMem(l_ElemBuf, l_BufLen);
   try
    htTableElementList(aTableHandle, l_ElemBuf);
    Result := m2MemCompare(@aStruct[0], l_ElemBuf, l_BufLen) = 0;
   finally
    FreeMem(l_ElemBuf);
   end;
  end;
 end;
end;

function CheckTableStruct(const aTableName: string; const aStruct: array of ThtElementInfo): Boolean;
var
 l_BufLen: Integer;
 l_ElemBuf: Pointer;
 l_ElemNo: Integer;
 l_Handle: ThtTblHandle;
 l_Info : ThtTableInfoRec;
begin
 Result := False;
 if htTableOpen(PAnsiChar(aTableName), '', '', TAB_SHARE, l_Handle) = 0 then
  Result := CheckTableStruct(l_Handle, aStruct);
end;

end.

