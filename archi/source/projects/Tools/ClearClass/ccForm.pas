unit ccForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ddProgressObj,
  Dialogs, ddAppConfigTypes, ExtCtrls, StdCtrls, ComCtrls, k2Types, l3FieldSortRecList, l3LongintList,
  dtIntf, dt_Sab, Mask, ToolEdit;

type
  TClearClassForm = class(TForm)
    Panel2: TPanel;
    GoButton: TButton;
    CancelButton: TButton;
    Panel1: TPanel;
    ProgressBar: TProgressBar;
    ProgressLabel: TLabel;
    feTopicList: TFilenameEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    f_Aborted: Boolean;
   procedure ClearDocuments;
    function LoadDocNumbers: ISab;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClearClassForm: TClearClassForm;

implementation

Uses
 l3Base, l3Types, l3String, l3Filer, l3LingLib, l3Date,
 ddAppConfigUtils, ddHTInit,
 dt_Types, dt_Serv, dt_Const,
 afwVCL,
 StrUtils, ddClientBaseEngine,
 Math, DT_Link, DT_LinkServ, DT_DictConst, DT_Dict, rxStrUtils,
 dt_AttrSchema, l3LongintListPrim, DT_Doc, ddHeaderFilter, k2Interfaces,
  Dt_ReNum, l3FileUtils, stFileOp, ddUtils, DT_Stage, l3Stream, l3Memory,
  l3Parser;

{$R *.dfm}

procedure TClearClassForm.ClearDocuments;
var
 lSab, lSab2: ISab;
 lStage : TStageType;
begin
 f_Aborted:= False;
 lSab:= LoadDocNumbers;
 if lSab <> nil then
 begin
   lSab.ValuesOfKey(rnRealID_fld);
   lSab2 := MakeSabCopy(lSab);

   lSab.TransferToPhoto(stDocID_Key, LinkServer(CurrentFamily).Attribute[atStages]);
   lSab.RecordsByKey;
   lStage := stClass;
   lSab.SubSelect(stType_Key, lStage);
   lSab.DeleteFromTable;

   lSab2.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atClasses]);
   lSab2.RecordsByKey;
   lSab2.DeleteFromTable;
   ShowMessage('Этап и классы успешно обнулены');
 end;
end;

procedure TClearClassForm.FormCreate(Sender: TObject);
begin
 AfwHackControlFont(Self);
end;

procedure TClearClassForm.GoButtonClick(Sender: TObject);
begin
 GoButton.Enabled:= False;
 try
  CancelButton.Caption:= 'Отмена';
  ClearDocuments;
 finally
  CancelButton.Caption:= 'Выход';
  GoButton.Enabled:= True;
 end;
end;

procedure TClearClassForm.CancelButtonClick(Sender: TObject);
begin
 if GoButton.Enabled then
  Close
 else
  f_Aborted:= True;
end;

function TClearClassForm.LoadDocNumbers: ISab;
var
 lStream : Tl3FileStream  ;
 lTmpStream : Tl3MemoryStream;
 lParser : Tl3Parser;
 lHasAdded : Boolean;
 lCurNum : Integer;
 l_Filename: string;
 l_Renum : Boolean;
begin
 lHasAdded := False;
 l_Filename := feTopicList.FileName;
 if FileExists(l_Filename) then
 begin
  lStream := Tl3FileStream.Create(l_Filename, l3_fmRead);
  try
   lTmpStream := Tl3MemoryStream.Create;
   lTmpStream.Size := 0;
   try
    lParser := Tl3Parser.Create;
    try
     lParser.CheckFloat := false;
     lParser.CheckFiler.Stream := lStream;
     lParser.NextTokenSp;
     if (lParser.TokenType = l3_ttSingleChar) and (lParser.TokenChar = '#') then
     begin
      lParser.Filer.ReadLn;
      lParser.NextTokenSp;
      l_Renum := False;
     end
     else
      l_Renum := True;
 
     While lParser.TokenType <> l3_ttEOF do
     begin
      If lParser.TokenType = l3_ttInteger then
      begin
          try
           lCurNum := lParser.TokenInt; {- 100000};
           lTmpStream.Write(lCurNum, SizeOf(Integer));
           lHasAdded:=True;
          except
          end;
      end;
      lParser.Filer.ReadLn;
      lParser.NextTokenSp;
     end;
 
 
     If lHasAdded then
     begin
      lTmpStream.Seek(0,0);
      Result:= MakeValueSet(LinkServer(CurrentFamily).Attribute[atRenum],
                            IfThen(l_Renum, rnImportID_fld, rnRealID_fld), lTmpStream);
     end
     else
      Result:= nil;
    finally
     l3Free(lParser);
    end;
   finally
    l3Free(lTmpStream);
 
   end;
  finally
   l3Free(lStream);
  end;
 end
 else
  MessageDlg(Format('Файл %s не найден!', [l_Filename]), mtError, [mbOk], 0);
end;

end.
