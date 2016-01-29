unit dslMain;

{ $Id: dslMain.pas,v 1.1 2008/04/24 15:00:50 fireton Exp $ }

// $Log: dslMain.pas,v $
// Revision 1.1  2008/04/24 15:00:50  fireton
// - первый коммит
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, ComCtrls, Mask, ToolEdit;

type
  TMainForm = class(TForm)
    Button1: TButton;
    XPManifest1: TXPManifest;
    feResultFile: TFilenameEdit;
    Label1: TLabel;
    Progress: TProgressBar;
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
 l3Types,
 l3Base,
 l3String,
 l3Stream,
 DT_Types,
 DT_Const,
 DT_Serv,
 DT_Sab,
 DT_Doc,
 DT_Renum;

{$R *.dfm}

type
 PDocSprRec = ^TDocSprRec;
 TDocSprRec = packed record
  rDoc: TDocID;
  rSpr: TDocID;
 end;

procedure TMainForm.Button1Click(Sender: TObject);
var
 l_SabDocs  : ISab;
 l_ID: TDocID;
 l_Iter: TdtRecAccessProc;
 l_File: Tl3TextStream;
 l_Count: Longword;

 function Iterator(aRec : PDocSprRec) : Boolean; register;
 var
  l_Doc, l_Spr: TDocID;
 begin
  Result := True;
  l_Doc := DocumentServer.RenumTbl.ConvertToImportNumber(aRec.rDoc);
  l_Spr := DocumentServer.RenumTbl.ConvertToImportNumber(aRec.rSpr);
  l_File.PutLine(Format('%d %d', [l_Doc, l_Spr]));
  Inc(l_Count);
  if l_Count mod 100 = 0 then
  begin
   Progress.Position := l_Count;
   Update;
  end;
 end;

begin
 DocumentServer.Family := CurrentFamily;
 l_SabDocs  := MakeSab(DocumentServer.FileTbl);
 l_ID := 0;
 l_SabDocs.Select(fRelated_fld, l_ID, NOT_EQUAL);
 DocumentServer.RenumTbl.Buffered := True;
 Progress.Max := l_SabDocs.Count;
 l_Count := 0;
 Screen.Cursor := crHourGlass;
 try
  l_File := Tl3TextStream.Create(feResultFile.FileName, l3_fmCreateReadWrite);
  try
   l_Iter := L2RecAccessProc(@Iterator);
   try
    l_SabDocs.IterateRecords(l_Iter, [fId_Fld, fRelated_fld]);
   finally
    FreeRecAccessProc(l_Iter);
   end;
  finally
   l3Free(l_File);
  end;
  Progress.Position := Progress.Max;
 finally
  Screen.Cursor := crDefault;
 end;
end;

end.
