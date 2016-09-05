Unit Dt_IndexSupport;

{ $Id: Dt_IndexSupport.pas,v 1.15 2016/06/16 05:40:06 lukyanets Exp $ }
// $Log: Dt_IndexSupport.pas,v $
// Revision 1.15  2016/06/16 05:40:06  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.14  2014/11/17 10:57:30  fireton
// - удаляем и проверяем наличие файлов хранилища правильно
//
// Revision 1.13  2014/09/10 16:02:07  lulin
// - где возможно, там используем эксклюзивный доступ.
//
// Revision 1.12  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.11  2011/06/10 12:49:03  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TdaFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.10  2010/08/04 08:29:39  voba
// - k: 229672814
//
// Revision 1.9  2010/03/10 14:09:47  narry
// - не собиралось
//
// Revision 1.8  2009/01/29 10:54:55  narry
// - DocumentServerу не устанавливалось семейство
//
// Revision 1.7  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.6.8.2  2009/01/23 14:06:29  fireton
// - перенос Парня на Query
//
// Revision 1.6.8.1  2008/12/26 15:22:05  fireton
// - полностью избавляемся от ссылок на DT_Srch
//
// Revision 1.6  2007/12/06 11:40:59  lulin
// - cleanup.
//
// Revision 1.5  2004/08/03 08:52:51  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.4  2004/05/18 09:11:00  step
// change: GlobalFamPaths[] --> GlobalHtServer.FamilyTbl.FamilyPath()
//
// Revision 1.3  2004/05/12 14:01:29  narry
// - new: индексация заголовков словарных статей
//
// Revision 1.2  2004/04/22 07:02:05  voba
// no message
//
// Revision 1.1  2003/11/25 12:17:37  step
// Перенесен из Archi
//

{$I DtDefine.inc}

interface
 uses 
  daTypes,
  l3Types;

 type
  TIndexType = (itHeading, itText, itDictEntry);

  function GetTextIndexPath(aFamily :  TdaFamilyID; aIndexType : TIndexType) : String;

  procedure BuildTextIndexbyHeader(aFamily :  TdaFamilyID; aProgressProc: Tl3ProgressProc);
  { Создает текстовый индекс заголовков документов }

  procedure BuildTextIndexbyDictEntry(aFamily :  TdaFamilyID);
  { Создает текстовый индекс заголовков словарных статей }

implementation
 uses SysUtils,
      l3Base, l3String,
      m3ParaIndexBuilder, m3StgMgr,
      dt_Types, Dt_Serv, dtIntf, DT_Sab, DT_Doc, dt_Const, DT_Query;

function GetTextIndexPath(aFamily :  TdaFamilyID; aIndexType : TIndexType) : String;
begin
 Case aIndexType of
  itHeading  : Result := GlobalHtServer.FamilyTbl.FamilyPath(aFamily)+'Heading'+IntToHex(aFamily,3)+'.idx';
  itText     : Result := GlobalHtServer.FamilyTbl.FamilyPath(aFamily)+'bserv'+IntToHex(aFamily,3)+'.idx';
  itDictEntry: Result := GlobalHtServer.FamilyTbl.FamilyPath(aFamily)+'DictEntry'+IntToHex(aFamily,3)+'.idx';
 end;
end;

procedure BuildTextIndexbyHeader(aFamily :  TdaFamilyID; aProgressProc: Tl3ProgressProc);
var
 l_ParaIndexBuilder : Tm3ParaIndexBuilder;
 l_Sab              : ISab;
 lIdxFileName       : String;
 l_IteratorStub     : TdtRecAccessProc;
 l_Count            : Integer;

 function l_Iterator(aRec: PIDFNameRec): Boolean;
 begin
  Result := True; // обрабатываем все записи
  l_ParaIndexBuilder.AddPara(aRec^.rDocID, l3RTrim(l3PCharLen(PChar(@aRec^.rName), SizeOf(TFullNameStr))));
  Inc(l_Count);
  if Assigned(aProgressProc) then
     aProgressProc(1, l_Count, '');
 end;

begin
 //lIdxFileName := ChangeFileExt(GetTextIndexPath(aFamily,itHeading),'.new');
 //If DeleteFile(GetTextIndexPath(aFamily,itHeading)) then
 lIdxFileName := GetTextIndexPath(aFamily,itHeading);
 Tm3FullModeExclusiveStorageManager.DeleteStorageFile(lIdxFileName);
 if not Tm3FullModeExclusiveStorageManager.StorageFileExists(lIdxFileName) then
 begin
  l_ParaIndexBuilder := Tm3ParaIndexBuilder.Create(Tm3FullModeExclusiveStorageManager.MakeInterface(lIdxFileName));
  try
   l_Sab := MakeSab(DocumentServer(aFamily).FileTbl);
   try
    l_Sab.SelectAll;
    l_IteratorStub := L2RecAccessProc(@l_Iterator);
    if Assigned(aProgressProc) then
     aProgressProc(0, l_Sab.Count, 'Построение индеска названий документов');
    l_Count:= 0;
    try
     l_Sab.IterateRecords(l_IteratorStub, [fId_Fld, fFName_Fld]);
    finally
     FreeRecAccessProc(l_IteratorStub);
    end;
   finally
    if Assigned(aProgressProc) then
     aProgressProc(2, l_Sab.Count, '');
    l_Sab := nil;
   end;
  finally
   l3Free(l_ParaIndexBuilder);
  end;//try..finally
 end;
end;

procedure BuildTextIndexbyDictEntry(aFamily :  TdaFamilyID);
var
 l_ParaIndexBuilder : Tm3ParaIndexBuilder;
 l_Query            : TdtDocTypeFilterQuery;
 lIdxFileName       : String;
 l_IteratorStub     : TdtRecAccessProc;

 function l_Iterator(aRec: PIDFNameRec): Boolean;
 begin
  Result := True; // обрабатываем все записи
  l_ParaIndexBuilder.AddPara(aRec^.rDocID, l3RTrim(l3PCharLen(PChar(@aRec^.rName), SizeOf(TFullNameStr))));
 end;

begin
 lIdxFileName := GetTextIndexPath(aFamily,itDictEntry);
 Tm3FullModeExclusiveStorageManager.DeleteStorageFile(lIdxFileName);
 If not Tm3FullModeExclusiveStorageManager.StorageFileExists(lIdxFileName) then
 begin
  l_ParaIndexBuilder := Tm3ParaIndexBuilder.Create(Tm3FullModeExclusiveStorageManager.MakeInterface(lIdxFileName));
  try
   l_Query := TdtDocTypeFilterQuery.Create;
   try
    l_Query.DocTypeFilter := [dtDictEntry];
    if not l_Query.IsEmpty then
    begin
     l_IteratorStub := L2RecAccessProc(@l_Iterator);
     try
      l_Query.FoundList.IterateRecords(l_IteratorStub, [fId_Fld, fFName_Fld]);
     finally
      FreeRecAccessProc(l_IteratorStub);
     end;
    end;
   finally
    l3Free(l_Query);
   end;
  finally
   l3Free(l_ParaIndexBuilder);
  end;//try..finally
 end;
end;

end.
