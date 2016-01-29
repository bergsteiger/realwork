unit mop_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdActns, Menus;

type
  TForm1 = class(TForm)
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    FileExit1: TFileExit;
    File1: TMenuItem;
    Exit1: TMenuItem;
    actExportLinkWithPages: TAction;
    N1: TMenuItem;
    page1: TMenuItem;
    OpenDialog: TOpenDialog;
    actImportLinkWithPages: TAction;
    pages1: TMenuItem;
    acRemovePubBySubscribtion: TAction;
    N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actExportLinkWithPagesExecute(Sender: TObject);
    procedure actImportLinkWithPagesExecute(Sender: TObject);
    procedure acRemovePubBySubscribtionExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
 l3Base,
 l3Types,
 l3Stream,
 l3Parser,
 l3Memory,
 l3String,

 daTypes,

 HT_Const,
 HT_DLL,
 DT_aTbl,
 DT_Dict,
 DT_Sab,
 Dt_Types,
 DT_Const,
 DT_Link,
 DT_Doc,
 DT_Err,
 DT_Serv,
 ddHTInit, dt_Table, Dt_Free;

{$R *.dfm}

type
 PJoinedRec = ^TJoinedRec;
 TJoinedRec = record
  Doc_ID   : DWORD;
  Dict_ID  : DWORD;
  Pages    : array [1..128] of Char;
  FullName : array [1..1000] of Char;
 end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 InitBaseEngine(akClient, '127.0.0.1');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 DoneClientBaseEngine;
end;

procedure TForm1.actExportLinkWithPagesExecute(Sender: TObject);
var
 l_Parser: Tl3Parser;
 l_FS: Tl3FileStream;
 l_MS: Tl3MemoryStream;
 l_DIdSab: SAB;
 l_DocID : TDocID;
 l_Count : Integer;
 l_LinkSAB: SAB;
 l_JoinedSAB: SAB;
 l_VI: TValuesIteratorForJoinedRecs;
 l_Rec : TJoinedRec;
 l_OutS: Tl3TextStream;
 l_Str: string;
begin
 if OpenDialog.Execute then
 begin
  LinkServer.Family := 1;
  DocumentServer.Family := 1;
  LinkServer.Links[da_dlPublisheds].RefreshSrchList;
  htCreateEmptySAB(@(LinkServer.Links[da_dlPublisheds].fSrchList), l_DIdSab,
    LinkServer.Links[da_dlPublisheds].TblH, lnkDocIDFld, RES_VALUE);
  Ht(htOpenResults(l_DIdSab,ROPEN_READ,nil,0));
  l_MS := Tl3MemoryStream.Create(nil);
  try
   l_FS := Tl3FileStream.Create(OpenDialog.FileName, l3_fmRead);
   try
    l_Parser := Tl3Parser.Create(nil);
    try
     l_Parser.CheckFiler.Stream := l_FS;
     l_Parser.NextTokenSp;
     l_Count := 0;
     while l_Parser.TokenType <> l3_ttEOF do
     begin
      if l_Parser.TokenType = l3_ttInteger then
      begin
       l_DocID := l_Parser.TokenInt;
       l_DocID := DocumentServer.RenumTbl.ConvertToRealNumber(l_DocID);
       l_MS.Write(l_DocID, SizeOf(TDocID));
       Inc(l_Count);
      end;
      l_Parser.NextTokenSp;
     end;
    finally
     l3Free(l_Parser);
    end;
   finally
    l3Free(l_FS);
   end;
   if l_Count > 0 then
   begin
    Ht(htIncludeResultsBlock(l_DIdSab, 0, l_MS.MemoryPool.AsPointer, l_Count*SizeOf(TDocID)));
    htRecordsByKey(l_LinkSAB, l_DIdSab);
    DocumentServer.FileTbl.RefreshSrchList;
    if htTablesJoin(l_JoinedSAB,
       l_LinkSAB,
       lnkDocIDFld,
       EQUAL,
       DocumentServer.FileTbl.fSrchList,
       fId_Fld,
       nil,
       False,
       DRAFT_ZERO) = nil then
     Ht(l_JoinedSAB.nRetCode)
    else
    begin
     if l_JoinedSAB.gFoundCnt > 0 then
     begin
      l_VI := TValuesIteratorForJoinedRecs.Create(
          l_JoinedSAB,
          LinkServer.Links[da_dlPublisheds], [1,2,3],
          DocumentServer.FileTbl, [3]);
      try
       l_OutS := Tl3TextStream.Create(ChangeFileExt(OpenDialog.FileName, '.csv'), l3_fmCreateReadWrite);
       try
        while not l_VI.EOF do
        begin
         l_VI.ReadFullRec(l_Rec);
         l_Str := IntToStr(l_Rec.Doc_ID)+';'+IntToStr(l_Rec.Dict_ID)+';'+l3ArrayToString(l_Rec.Pages, 128)+
            ';'+l3ArrayToString(l_Rec.FullName, 1000);
         l_OutS.WriteLn([l_Str]);
         l_VI.Next;
        end;
       finally
        l3Free(l_OutS);
       end;
      finally
       l3Free(l_VI);
      end;
     end;
    end;
   end;
  finally
   l3Free(l_MS);
  end;
 end;
end;

procedure TForm1.actImportLinkWithPagesExecute(Sender: TObject);
var
 l_Parser: Tl3Parser;
 l_FS: Tl3FileStream;
 l_DocID, l_DictID: DWORD;
 l_Pages: array [1..128] of Char;
 l_PPages, l_POldPages: PChar;
 l_Pos : Integer;
 l_RecNum: Integer;
 l_LinksAdded: Integer;
 l_LinksChanged: Integer;
 l_RecCount: Integer;
begin
 if OpenDialog.Execute then
 begin
  l_LinksAdded := 0;
  l_LinksChanged := 0;
  l_RecCount := 0;
  l3System.Msg2Log(#13#10'ИМПОРТ ЛИНКОВ К PUBLISHEDS (ФАЙЛ "%s")', [OpenDialog.Filename]);
  LinkServer.Family := 1;
  l_Parser := Tl3Parser.Make(Tl3FileStream.Create(OpenDialog.FileName, l3_fmRead),
       [], [' '..#255]-[';'], l3_DefaultParserWhiteSpace-[#10,#13,' ','-',',']+[';']);
  try
   l_Pos := 1;
   l_Parser.NextTokenSp;
   repeat
    case l_Parser.TokenType of
     l3_ttSymbol:
      if l_Pos < 4 then
      begin
       case l_Pos of
        1: l_DocID := StrToInt(Trim(l_Parser.TokenString));
        2: l_DictID := StrToInt(Trim(l_Parser.TokenString));
        3: l3StringToArray(l_Pages, 128, l_Parser.TokenString, #0);
       end;
       Inc(l_Pos);
      end;
     l3_ttEOL:
      begin
       if l_Pos > 3 then
       begin
        Inc(l_RecCount);
        with LinkServer.Links[da_dlPublisheds] do
        begin

         l_RecNum := LoadFRecByKey(l_DocID, l_DictID);

         if l_RecNum = 0 then
         begin
          PutToFullRec(lnkDocIDFld, l_DocID);
          PutToFullRec(lnkDictIDFld, l_DictID);
         end;

         l_PPages := @l_Pages;

         if l_RecNum > 0 then
         begin
          GetFromFullRec(lnkPublihedsPages, l_POldPages);
          try
           if AnsiStrComp(l_PPages, l_POldPages) <> 0 then
           begin
            PutToFullRec(lnkPublihedsPages, l_PPages);
            HoldRec(l_RecNum);
            try
             UpdFRec(l_RecNum);
             l3System.Msg2Log('- данные изменены (документ %d)', [l_DocID]);
             Inc(l_LinksChanged)
            finally
             FreeRec(l_RecNum);
            end;
           end;
          finally
           l3StrDispose(l_POldPages); // приходится подчищать за GetFromFullRec :(
          end;
         end
         else
         begin
          PutToFullRec(lnkPublihedsPages, l_PPages);
          l3System.Msg2Log('- добавлен линк к документу %d', [l_DocID]);
          Inc(l_LinksAdded);
          AddFRec;
         end;
        end;
       end;
       l_Pos := 1;
      end;
    end;
    l_Parser.NextTokenSp;
   until l_Parser.TokenType = l3_ttEOF;
  finally
   l_Parser.Filer.Stream.Free;
   l3Free(l_Parser);
  end;
  l3System.Msg2Log('------------------'#13#10'Обработано записей: %d   Изменено: %d    Добавлено: %d', [l_RecCount, l_LinksChanged, l_LinksAdded]);
 end;
end;

procedure TForm1.acRemovePubBySubscribtionExecute(Sender: TObject);
var
 l_CSTbl: TDictionaryTbl;
 l_RecNo: Longint;
 l_CSID    : DWORD;
 l_CSID_NEW: DWORD;
 l_Sab: ISab;
begin
 DictServer.Family := CurrentFamily;
 l_CSTbl := DictServer.DictTbl[da_dlCorSources];
 l_CSID := 0;
 l_RecNo := l_CSTbl.GetRecordIDByUniq(dtIDfld, l_CSID);
 if l_RecNo > 0 then
 begin
  // получаем новый ID
  l_CSID_NEW := GlobalHtServer.FreeTbl[CurrentFamily].GetFree(FamTblNames[ftDtA]);
  // Модифицируем запись в DT#A
  l_CSTbl.GetFullRec(l_RecNo, True);
  l_CSTbl.PutToFullRec(dtIDFld, l_CSID_NEW);
  l_CSTbl.UpdFRec(l_RecNo);
  l_CSTbl.FreeRec(l_RecNo);
  // Модифицируем записи в DT#B
  l_Sab := MakeSab(DictServer.DictTbl[da_dlPublisheds]);
  l_Sab.Select(piSourFld, l_CSID);
  l_Sab.ModifyRecs(piSourFld, l_CSID_NEW);
  l_Sab := nil;
  MessageDlg('Операция завершена успешно', mtInformation, [mbOk], 0);
 end
 else
  MessageDlg('В базе отсутствует источник "по рассылке" (ID = 0)', mtInformation, [mbOk], 0);
end;

end.
