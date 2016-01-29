unit drMain;

{ $Id: drMain.pas,v 1.6 2010/09/28 13:08:32 fireton Exp $ }

// $Log: drMain.pas,v $
// Revision 1.6  2010/09/28 13:08:32  fireton
// - Распределяем память для PChar своими средствами
//
// Revision 1.5  2008/03/04 08:27:30  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.4  2008/02/15 08:50:29  fireton
// - исправление ошибки
//
// Revision 1.3  2008/01/14 15:05:07  fireton
// - мелкая отладка
//
// Revision 1.2  2007/12/29 12:42:16  fireton
// - сначала ищем записи для изменения, потом изменяем
//   (иначе на некоторых машинах появлялась ошибка)
//
// Revision 1.1  2007/12/03 09:11:21  fireton
// - первый коммит
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, ComCtrls;

type
  TMainForm = class(TForm)
    Button1: TButton;
    XPManifest1: TXPManifest;
    ProgressBar: TProgressBar;
    lblDisp: TLabel;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 HT_Const,
 l3Base,
 l3RegEx,
 l3String,
 DT_Types,
 DT_Const,
 DT_Serv,
 DT_ATbl,
 DT_Sab,
 DT_Doc,
 DT_Misc, Math;

const
 cFindString    = '\(с изм\. и доп\.[^\(]*\)';
 cReplaceString = '(с изменениями и дополнениями)';

{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
var
 l_Passw    : TPassStr;
 l_Name     : TTblNameStr;
 l_Table    : TPrometTbl;
 l_Sab      : ISab;
 l_FoundSab : ISab;
 l_FoundCur : ISabCursor;
 l_HStub    : Pointer;
 l_RegExp   : Tl3RegularSearch;
 l_RCount   : Integer;
 l_FCount   : Integer;
 l_Tmp      : Integer;
 l_SrchProc : TdtRecAccessProc;

 procedure DispRCount;
 begin
  lblDisp.Caption := Format('Замен: %d', [l_RCount]);
  Update;
 end;

 procedure DispFoundCount;
 begin
  lblDisp.Caption := Format('Поиск документов для переименования: %d', [l_FCount]);
  Update;
 end;

 function ReplaceNameInRec(gRecNo : LongInt; fpRecord : Pointer) : MFUNC_RET;
 var
  l_NamePC : PChar;
  l_NewName: string;
  l_RP     : TvtMatchPosition;
  //l_DocID  : TDocID;
 begin
  l_Table.GetFieldFromRecord(fpRecord, fFName_Fld, l_NamePC);
  if l_RegExp.SearchInString(l_NamePC, 0, StrLen(l_NamePC), l_RP) then
  begin
   //l_Table.GetFieldFromRecord(fpRecord, fId_Fld, l_DocID);
   l_NewName := Copy(l_NamePC, 1, l_RP.StartPos) + cReplaceString + Copy(l_NamePC, l_RP.EndPos+1, MaxInt);
   l_Table.PutFieldToRecord(fpRecord, fFName_Fld, l_NewName);
   Inc(l_RCount);
   DispRCount;
  end;
  l3StrDispose(l_NamePC);
  ProgressBar.Position := ProgressBar.Position + 1;
  Result := MFUNC_SUCCESS;
 end;

 function IsNeededName(aData: Pointer): Boolean;
 var
  l_RP: TvtMatchPosition;
 begin
  Result := True; // перебираем все...
  if l_RegExp.SearchInString(PChar(aData)+4, 0, FullNameSize, l_RP) then
  begin
   l_FoundCur.AddItem(PDword(aData)^);
   Inc(l_FCount);
   DispFoundCount;
  end;
  ProgressBar.Position := ProgressBar.Position + 1;
 end;

 function IsNeededName2(aData: Pointer): Boolean;
 var
  l_RP: TvtMatchPosition;
 begin
  Result := True; // перебираем все...
  if l_RegExp.SearchInString(PChar(aData)+4, 0, FullNameSize, l_RP) then
  begin
   Random;
  end;
 end;

begin
 ProgressBar.Position := 0;
 l_RCount := 0;
 l_Name   := FamTblNames[ftFile] + IntToHex(CurrentFamily, 3);
 l_Passw  := TblPassW[FamPassIndex[ftFile]];
 l_Table := TPrometTbl.Create(CurrentFamily, l_Passw, l_Name, True);
 try
  l_Sab := MakeSab(l_Table);
  try
   l_Sab.SelectAll;
   l_FoundSab := MakeEmptySab(l_Sab);
   l_RegExp := Tl3RegularSearch.Create;
   try
    l_RegExp.SearchPattern := cFindString;

    l_SrchProc := L2RecAccessProc(@IsNeededName);
    try
     l_FCount := 0;
     DispFoundCount;
     l_FoundCur := l_FoundSab.MakeSabCursor([0, fFName_Fld], cmForward);
     try
      ProgressBar.Position := 0;
      ProgressBar.Max := l_Sab.Count;
      ProgressBar.Step := Max(1, l_Sab.Count div 400);
      l_Sab.IterateRecords(l_SrchProc, [0, fFName_Fld]);
     finally
      l_FoundCur := nil;
     end;
    finally
     FreeRecAccessProc(l_SrchProc);
    end;

    ProgressBar.Position := 0;
    l_RCount := 0;
    DispRCount;
    ProgressBar.Max := l_FoundSab.Count;
    ProgressBar.Step := Max(1, l_FoundSab.Count div 400);
    l_HStub := HTStub3(@ReplaceNameInRec);
    try
     l_Table.ModifyRecs(l_FoundSab.HTSab, l_HStub);
    finally
     HTStubFree(l_HStub);
    end;
   finally
    l3Free(l_RegExp);
   end;
  finally
   l_Sab := nil;
   l_FoundSab := nil;
  end;
 finally
  l3Free(l_Table);
 end;
 MessageDlg('Переименование завершено', mtInformation, [mbOk], 0);
end;

end.
