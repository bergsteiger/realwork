unit Main;

{ $Id: Main.pas,v 1.7 2015/04/07 07:35:56 lukyanets Exp $ }
// $Log: Main.pas,v $
// Revision 1.7  2015/04/07 07:35:56  lukyanets
// Изолируем HT
//
// Revision 1.6  2015/04/01 11:54:37  lukyanets
// Изолируем утилиты
//
// Revision 1.5  2014/10/16 10:41:39  lukyanets
// Более контролируемо создаем конфиги
//
// Revision 1.4  2005/05/27 14:44:36  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.3  2004/12/23 11:47:15  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.2  2004/08/31 11:13:55  step
// мелкие исправления
//
// Revision 1.1  2004/08/30 17:09:35  step
// занесено в CVS
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  l3Base,
  Dt_Const, StdCtrls, Contnrs,
  m3DB, m3DBInterfaces, OvcBase,  W95Meter, ActnList, afwControlPrim,
  afwBaseControl, afwControl;

type
  TDocNumVerifier = class;

  TMainForm = class(TForm)
    FileMeter: TW95Meter;
    FilesMeter: TW95Meter;
    lbFile: TLabel;
    lbFiles: TLabel;
    bStart: TButton;
    bStop: TButton;
    bSave: TButton;
    procedure FileMeterSetStr(const aStr: String);
    procedure FilesMeterSetStr(const aStr: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bStartClick(Sender: TObject);
    procedure bStopClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
  private
    f_DocNumVerifier: TDocNumVerifier;
    procedure Yield(aSender: TObject);
  public

  end;

  TDocNums = class(Tl3Base) // все номера из FILE.ABSNUM и из FILE.RELATED
  private
   f_List: TBucketList;
   procedure Init;
  protected
   procedure Release; override;
  public
   constructor Create; reintroduce;
   function Exists(aDocId: LongWord): Boolean;
  end;

  TDocNumVerifier = class(Tl3Base)
  private
   f_DocNums: TDocNums;
   f_DocBase: Im3DB;
   f_BadDocs: TList;
   procedure Connect;
   procedure Disconnect;
  protected
   procedure Release; override;
  public
   constructor Create(aForm: TMainForm); reintroduce;
   procedure Execute;
   function BadDocsAmount: Integer;
   procedure SaveBadDocs;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 daDataProvider,
 l3IniFile, Dt_Doc, Dt_Query, l3FileUtils, m3StorageInterfaces, Dt_Types,
 ncsDefaultProviderHolder;

procedure TMainForm.Yield(aSender: TObject);
begin
 Application.ProcessMessages;
end;

procedure TMainForm.FileMeterSetStr(const aStr: String);
begin
 lbFile.Caption := aStr;
end;

procedure TMainForm.FilesMeterSetStr(const aStr: String);
begin
 lbFiles.Caption := aStr;
end;

{ TDocNums }

constructor TDocNums.Create;
begin
 inherited Create;

 f_List := TBucketList.Create(bl256);

 Init;
end;

function TDocNums.Exists(aDocId: LongWord): Boolean;
begin
 Result := f_List.Exists(Pointer(aDocId));
end;

procedure TDocNums.Init;
var
 l_Query: TSelectionQuery;
 l_Value: LongWord;
begin
 f_List.Clear;

 DocumentServer.Family := CurrentFamily;
 l_Query := TSelectionQuery.Create(DocumentServer.FileTbl);
 try
  l_Query.Open([fId_Fld, fRelated_fld]);
  while not l_Query.Eof do
  begin

   // AbsNum
   l_Value := l_Query.FieldAsLongWord[fId_Fld];
   if (l_Value > 0) and not f_List.Exists(Pointer(l_Value)) then
    f_List.Add(Pointer(l_Value), nil);

   // Related
   l_Value := l_Query.FieldAsLongWord[fRelated_fld];
   if (l_Value > 0) and not f_List.Exists(Pointer(l_Value)) then
    f_List.Add(Pointer(l_Value), nil);

   l_Query.Next;
  end;
  l_Query.Close;
 finally
  FreeAndNil(l_Query);
 end;
end;

procedure TDocNums.Release;
begin
 l3Free(f_List);

 inherited;
end;

{ TDocNumVerifier }

function TDocNumVerifier.BadDocsAmount: Integer;
begin
 if f_BadDocs = nil then
  Result := 0
 else
  Result := f_BadDocs.Count;
end;

procedure TDocNumVerifier.Connect;
begin
 InitStationAndServerConfig(ConcatDirName(ExtractDirName(Application.ExeName), 'Archi.Ini'));
 TncsDefaultProviderHolder.CreateProvider;
end;

constructor TDocNumVerifier.Create(aForm: TMainForm);
begin
 Connect;

 f_DocNums := TDocNums.Create;
 f_DocBase := Tm3DB.Make(GlobalDataProvider.TextBase[CurrentFamily],
                         False,
                         aForm.Yield,
                         aForm.FileMeter.ProgressProc_ev,
                         aForm.FilesMeter.ProgressProc_ev);
 f_BadDocs := TList.Create;
end;

procedure TDocNumVerifier.Disconnect;
begin
 TncsDefaultProviderHolder.DestroyProvider;
 DoneConfigs;
end;

procedure TDocNumVerifier.Execute;
 function DoDoc(const aDoc: Im3DBDocumentPart): Bool;
 begin
  if not f_DocNums.Exists(aDoc.Document.ID) then
   f_BadDocs.Add(Pointer(aDoc.Document.ID));
  Result := True;
 end;
begin
 f_BadDocs.Clear;
 f_DocBase.Start(m3_saReadWrite);
 try
  f_DocBase.AllFiles.IterateF(m3L2DocumentAction(@DoDoc));
 finally
  f_DocBase.Finish;
 end;

 ShowMessage(Format('Поиск завершен.'#13#10'Найдено: %d', [f_BadDocs.Count]));
end;

procedure TDocNumVerifier.Release;
begin
 l3Free(f_DocNums);
 f_DocBase := nil;
 l3Free(f_BadDocs);

 Disconnect;
 
 inherited;
end;

function fn_DocNumCompare(aItem1, aItem2: Pointer): Integer;
begin
 Result := Integer(LongWord(aItem1)) - Integer(LongWord(aItem2));
end;

procedure TDocNumVerifier.SaveBadDocs;
var
 l_SaveDialog: TSaveDialog;
 l_FileStream: TFileStream;
 l_Doc: string;
 I: Integer;
begin
 l_SaveDialog := TSaveDialog.Create(nil);
 try
  l_SaveDialog.Title := 'Сохранение номеров документов';
  if l_SaveDialog.Execute then
  begin
   f_BadDocs.Sort(fn_DocNumCompare);
   l_FileStream := TFileStream.Create(l_SaveDialog.FileName, fmCreate);
   try
    for I := 0 to f_BadDocs.Count - 1 do
    begin
     l_Doc := IntToStr(LongWord(f_BadDocs[I])) + #13#10;
     l_FileStream.Write(l_Doc[1], Length(l_Doc));
    end;
   finally
    l_FileStream.Free;
   end;
  end;
 finally
  l_SaveDialog.Free;
 end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 l3Free(f_DocNumVerifier);
end;

procedure TMainForm.bStartClick(Sender: TObject);
begin
 bStart.Enabled := False;
 bStop.Enabled := True;
 bSave.Enabled := False;
 try
  if f_DocNumVerifier = nil then
  begin
   Screen.Cursor := crHourGlass;
   try
    f_DocNumVerifier := TDocNumVerifier.Create(Self);
   finally
    Screen.Cursor := crDefault;
   end;
  end;
  f_DocNumVerifier.Execute;
 finally
  bSave.Enabled := True;
  bStop.Enabled := False;
  bStart.Enabled := True;
 end;
end;

procedure TMainForm.bStopClick(Sender: TObject);
begin
 if (f_DocNumVerifier <> nil) then
  f_DocNumVerifier.f_DocBase.Stop;

 bStart.Enabled := True;
 bStop.Enabled := False;
 bSave.Enabled := True;
end;

procedure TMainForm.bSaveClick(Sender: TObject);
begin
 if f_DocNumVerifier <> nil then
  f_DocNumVerifier.SaveBadDocs;
end;

end.


