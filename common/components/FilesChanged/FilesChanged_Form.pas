unit FilesChanged_Form;

interface

uses
 Forms

 , l3Interfaces
 , l3_String
 , l3StringList
 , l3Base

 , vtLister
 , vtPanel
 , vtButton
 , vtSizeablePanel

 , evMemo
;

type
 TFilesListString = class(Tl3_String)
  private
   Changed : Boolean;
  protected
   procedure Cleanup; override;
  public
   procedure AssignString(aStr: Tl3PrimString); override;  
 end;//TFilesListString
 
 TFilesList = class(Tl3StringList)
  protected
   function StringItemClass: Rl3String; override;
 end;//TFilesList

 TFilesChangedForm = class(TForm)
  public
   class procedure Run;
   destructor Destroy; override;
  private
   f_Lister : TvtLister;
   f_BottomPanel : TvtPanel;
   f_Ok : TvtButton;
   f_Diff : TvtButton;
   f_Restore : TvtButton;
   f_Revert : TvtButton;
   f_Files : TFilesList;
   f_LogPanel : TvtSizeablePanel;
   f_Log : TevMemo;
  private
   procedure Init;
   function  GetItem(anIndex: Integer): Il3CString;
   procedure DoGetItem(Sender: TObject;
             Index: LongInt;
             var ItemString: Il3CString);
   procedure DoGetItemFont(Sender: TObject;
             Index: LongInt;
             const aFont: Il3Font);
   procedure OkClick(Sender: TObject);
   procedure DiffClick(Sender: TObject);
   procedure Restore(anIndex: Integer);
   procedure RestoreClick(Sender: TObject);
   procedure Revert(anIndex: Integer);
   procedure RevertClick(Sender: TObject);
   procedure Load;
   procedure LoadLog;
   procedure DoActionElement(Sender: TObject;
             Index: LongInt);
 end;//TFilesChangedForm

{$R *.dfm}

implementation

uses
 Windows
 , ActiveX
 
 , SysUtils
 , StrUtils

 , Graphics
 , Controls
 , StdCtrls
 , Dialogs

 , l3Types
 , l3String
 , l3Stream
 , l3Filer
 , l3FileUtils

 , evdStyles

 , nevTools
;

class procedure TFilesChangedForm.Run;
var
 l_F : TFilesChangedForm;
begin
 Application.CreateForm(TFilesChangedForm, l_F);
 l_F.Init;
 l_F.Show;
end;

destructor TFilesChangedForm.Destroy;
begin
 l3System.CheckClipboard;
 FreeAndNil(f_Files);
 inherited;
end;

procedure TFilesChangedForm.Init;
const
 cGap = 20;
begin
 Width := 900;
 Height := 600;

 f_LogPanel := TvtSizeablePanel.Create(Self);
 f_LogPanel.Parent := Self;
 f_LogPanel.Align := alBottom;
 f_LogPanel.Height := 250;
 f_LogPanel.ResizeStyle := rsUpdate;
 f_LogPanel.SizeableSides := [szTop];

 f_BottomPanel := TvtPanel.Create(Self);
 f_BottomPanel.Parent := f_LogPanel;
 f_BottomPanel.Align := alBottom;
 f_BottomPanel.Height := 50;

 f_Log := TevMemo.Create(Self);
 f_Log.Parent := f_LogPanel;
 f_Log.Wrap := false;
 f_Log.ScrollStyle := ssBoth;
 f_Log.Processor.DefaultStyle := ev_saTxtNormalOEM;
 f_Log.AutoSelect := false;
 f_Log.Align := alClient;

 f_Ok := TvtButton.Create(Self);
 f_Ok.Parent := f_BottomPanel;
 f_Ok.Caption := '&Ok';
 f_Ok.Left := f_BottomPanel.Width - cGap - f_Ok.Width;
 f_Ok.Anchors := [akRight];
 f_Ok.Top := f_BottomPanel.Height div 2 - f_Ok.Height div 2;
 f_Ok.OnClick := OkClick;

 f_Diff := TvtButton.Create(Self);
 f_Diff.Parent := f_BottomPanel;
 f_Diff.Caption := '&Diff';
 f_Diff.Left := cGap;
 f_Diff.Top := f_Ok.Top;
 f_Diff.OnClick := DiffClick;

 f_Restore := TvtButton.Create(Self);
 f_Restore.Parent := f_BottomPanel;
 f_Restore.Caption := '&Undo';
 f_Restore.Left := f_Diff.Left + f_Diff.Width + cGap div 2;
 f_Restore.Top := f_Ok.Top;
 f_Restore.OnClick := RestoreClick;

 f_Revert := TvtButton.Create(Self);
 f_Revert.Parent := f_BottomPanel;
 f_Revert.Caption := '&Redo';
 f_Revert.Left := f_Restore.Left + f_Restore.Width + cGap div 2;
 f_Revert.Top := f_Ok.Top;
 f_Revert.OnClick := RevertClick;

 f_Lister := TvtLister.Create(Self);
 f_Lister.Parent := Self;
 f_Lister.Align := alClient;
 f_Lister.OnGetStrItem := DoGetItem;
 f_Lister.OnGetItemFont := DoGetItemFont;
 f_Lister.OnActionElement := DoActionElement;
 f_Lister.ScrollStyle := ssBoth;
 f_Lister.MultiSelect := true;
 Self.Load;
 Self.LoadLog;
 Self.ActiveControl := f_Lister;
 Position := poScreenCenter;
end;

function  TFilesChangedForm.GetItem(anIndex: Integer): Il3CString;
begin
 if (anIndex >= 0) AND (anIndex < f_Files.Count) then
  Result := f_Files.ItemC[anIndex]
 else
  Result := nil; 
end;

procedure TFilesChangedForm.DoGetItem(Sender: TObject;
          Index: LongInt;
          var ItemString: Il3CString);
var
 l_S : TFilesListString;          
begin
 try
  if (Index >= 0) AND (Index < f_Files.Count) then
  begin
   l_S := f_Files.Items[Index] As TFilesListString; 
   ItemString := l3CStr(l_S);
   if l_S.Changed then
    ItemString := l3Cat(ItemString, ' *');
  end//(Index >= 0) AND (Index < f_Files.Count)
  else
   ItemString := nil;
 except
  ItemString := l3CStr(IntToStr(Index));
 end;//try..except
end;

const
 cBackupPrefix = 'C:\Temp\GenBackup';
 cSourcePrefix = 'W:';

function BackupPrefix: String;
begin
 Result := ParamStr(2);
 if (Result = '') then
  Result := cBackupPrefix;
end;

function RevertPrefix: String;
begin
 Result := BackupPrefix + 'Revert';
end;

function SourcePrefix: String;
begin
 Result := ParamStr(3);
 if (Result = '') then
  Result := cSourcePrefix;
end;

function ToSource(const aStr: Il3CString): String;
begin
 Result := l3Str(aStr);
 Result := AnsiReplaceText(Result, BackupPrefix + '\', SourcePrefix + '\');
end;

function ToBackup(const aStr: Il3CString): String;
begin
 Result := l3Str(aStr);
 Result := AnsiReplaceText(Result, SourcePrefix + '\', BackupPrefix + '\');
end;

function ToRevert(const aStr: String): String;
begin
 Result := AnsiReplaceText(aStr, SourcePrefix + '\', RevertPrefix + '\')
end;

procedure TFilesChangedForm.DoGetItemFont(Sender: TObject;
          Index: LongInt;
          const aFont: Il3Font);
var
 l_S : TFilesListString;
 l_F : String;
begin
 l_S := f_Files.Items[Index] As TFilesListString;
 if l_S.Changed then
  aFont.ForeColor := clRed
 else
 if (Index mod 2 = 0) then
  aFont.ForeColor := clBlack
 else
  aFont.ForeColor := clBlue;

 l_F := l_S.AsString;
 if not FileExists(l_F) OR (GetFileSize(l_F) <= 0) then
  aFont.StrikeOut := true
 else
  aFont.StrikeOut := false;

 if l_S.Changed then
  l_F := ToRevert(l_S.AsString)
 else
  l_F := ToBackup(l3CStr(l_S));
 if not FileExists(l_F) OR (GetFileSize(l_F) <= 0) then
 begin
  aFont.Bold := true;
  aFont.Italic := true;
 end
 else
 begin
  aFont.Bold := false;
  aFont.Italic := false;
 end;
end;

function FilesName: String;
const
 cFiles = 'W:\common\components\FilesChanged\changed.lst';
begin
 Result := ParamStr(1);
 if (Result = '') then
  Result := cFiles;
end;

procedure LoadFiles(aFiles: TFilesList; aCheckSame: Boolean);
var
 l_Filer : Tl3DOSFiler;
 l_S : Il3CString;
 l_Files : String;
 l_Backup : String;
 l_Source : String;
begin
 aFiles.Sorted := true; 

 l_Files := FilesName;

 if FileExists(l_Files) then
 begin
  l_Filer := Tl3DOSFiler.Make(l_Files, l3_fmFullShareRead{l3_fmRead}, false);
  try
   l_Filer.Open;
   try
    while not l_Filer.EOF do
    begin
     l_S := l3CStr(l_Filer.ReadLn);
     l_Backup := l3Str(l_S);
     if (l_Backup <> '~') then
      if (l_Backup <> '') then
      begin
       l_Source := ToSource(l_S);
       if aCheckSame then
        if FileExists(l_Source) then
         if FileExists(l_Backup) then
          if l3CompareFiles(l_Backup, l_Source) then
           continue;
       aFiles.Add(l_Source);
      end;//l3Str(l_S) <> ''
    end;//while not l_Filer.EOF
   finally
    l_Filer.Close;
   end;//try..finally
  finally
   FreeAndNil(l_Filer);
  end;//try..finally
 end;//FileExists(l_Files)
end;

procedure TFilesChangedForm.OkClick(Sender: TObject);
var
 l_C : String;
 l_S : String;
var
 l_Index : Integer;
 l_Files : TFilesList;
 l_SIndex : Integer;
 l_Filer : Tl3DosFiler;
begin
 l_Files := TFilesList.Create;
 try
  LoadFiles(l_Files, false);
  for l_Index := 0 to Pred(f_Files.Count) do
  begin
   l_S := f_Files.Items[l_Index].AsString;
   l_C := ToBackup(f_Files.ItemC[l_Index]);
   try
    DeleteFile(l_C);
    l_SIndex := l_Files.IndexOf(l_S);
    if (l_SIndex >= 0) then
     l_Files.Delete(l_SIndex);
   except
    l3System.Msg2Log('Ошибка удаления файла: ' + l_C);
   end;//try..except
  end;//for l_Index
  l_Filer := Tl3DOSFiler.Make(FilesName, l3_fmWrite, false);
  try
   try
    l_Filer.Open;
   except
    Exit;
   end;//try..except
   try
    for l_Index := 0 to Pred(l_Files.Count) do
     l_Filer.WriteLn(ToBackup(l_Files.ItemC[l_Index]));
   finally
    l_Filer.Close;
   end;//try..finally
  finally
   FreeAndNil(l_Filer);
  end;//try..finally
 finally
  FreeAndNil(l_Files);
 end;//try..finally
 (*l_C := 'W:\shared\models\NewSchool\Scripts\clearbackupprim.cmd ' + BackupPrefix + '\';
 Windows.WinExec(PAnsiChar(l_C), SW_SHOWNORMAL);*)
 Self.Close;
end;

procedure TFilesChangedForm.DiffClick(Sender: TObject);
begin
 DoActionElement(f_Lister, f_Lister.Current);
end;

procedure TFilesChangedForm.Revert(anIndex: Integer);
var
 l_S : TFilesListString;
 l_Source : String;
 l_ForRevert : String;
begin
 l_S := f_Files.Items[anIndex] As TFilesListString;
 if not l_S.Changed then
  Exit;
 l_S.Changed := false;
 l_Source := l_S.AsString;

 l_ForRevert := ToRevert(l_Source);

 if FileExists(l_ForRevert) AND (GetFileSize(l_ForRevert) > 0) then
  CopyFile(l_ForRevert, l_Source, cmNoBakCopy)
 else
  DeleteFile(l_Source);
 f_Lister.Invalidate;
end;

procedure TFilesChangedForm.RevertClick(Sender: TObject);
var
 l_SC : Integer;
 l_Index : Integer;
begin
 l_SC := f_Lister.SelectedCount;
 if (l_SC <= 1) then
 begin
  Revert(f_Lister.Current);
 end//l_SC <= 1
 else
 begin
  l_Index := 0;
  while (l_SC > 0) do
  begin
   Inc(l_Index);
   if not f_Lister.Selected[Pred(l_Index)] then
    continue;
   Revert(Pred(l_Index));
   Dec(l_SC);
  end;//  while (l_SC > 0)
 end;//l_SC <= 1
end;

procedure TFilesChangedForm.Restore(anIndex: Integer);
var
 l_S : TFilesListString;
 l_Backup : String;
 l_Source : String;
 l_ForRevert : String;
begin
 l_S := f_Files.Items[anIndex] As TFilesListString;
 if l_S.Changed then
  Exit;
 l_S.Changed := true;
 l_Backup := ToBackup(l3CStr(l_S));
 l_Source := l_S.AsString;

 l_ForRevert := ToRevert(l_Source);
 if FileExists(l_Source) then
  CopyFile(l_Source, l_ForRevert, cmNoBakCopy)
 else
  DeleteFile(l_ForRevert);

 if FileExists(l_Backup) AND (GetFileSize(l_Backup) > 0) then
  CopyFile(l_Backup, l_Source, cmNoBakCopy)
 else
  DeleteFile(l_Source);
 f_Lister.Invalidate;
end;

procedure TFilesChangedForm.RestoreClick(Sender: TObject);
var
 l_SC : Integer;
 l_Index : Integer;
begin
 l_SC := f_Lister.SelectedCount;
 if (l_SC <= 1) then
 begin
  Restore(f_Lister.Current);
 end//l_SC <= 1
 else
 begin
  l_Index := 0;
  while (l_SC > 0) do
  begin
   Inc(l_Index);
   if not f_Lister.Selected[Pred(l_Index)] then
    continue;
   Restore(Pred(l_Index));
   Dec(l_SC);
  end;//  while (l_SC > 0)
 end;//l_SC <= 1
end;

procedure TFilesChangedForm.Load;
begin
 if (f_Files = nil) then
  f_Files := TFilesList.Create
 else
  f_Files.Clear;

 try
  LoadFiles(f_Files, true);
 except
  f_Files.Add('Ошибка загрузки файла: ' + FilesName);
 end;//try..except

 f_Lister.Total := f_Files.Count;
end;

function LogName: String;
begin
 Result := ParamStr(4);
 if (Result = '') then
  Result := 'W:\shared\models\NewSchool\Scripts\callMSS.log'
end;

procedure TFilesChangedForm.LoadLog;
var
 l_N : String;
 l_S : IStream;
begin
 l_N := LogName;
 if not FileExists(l_N) then
  f_Log.TextSource.New
 else
 begin
  try
   l_S := Tl3FileStream.Make(l_N, l3_fmFullShareRead{Write}, 10000);
  except
   f_Log.Text := 'Не удалось загрузить лог генерации. Файл ' + l_N + ' видимо был занят';
   Exit;
  end;//try..except
  try
   f_Log.TextSource.DocumentContainer.TagWriter.WriteTag(nil, CF_TEXT, l_S);
   InevSelection(f_Log.Selection).Unselect;
  finally
   l_S := nil;
  end;//try..finally
 end;//not FileExists(l_N)
 f_Log.ReadOnly := true;
end;

function CompareCmd: String;
begin
 Result := ParamStr(5);
 if (Result = '') then
  Result := 'W:\common\env\QuickLaunch\afc.cmd'
end;

procedure Compare(const aBackup, aSource: String);
var
 l_C : String;
begin
 l_C := CompareCmd + ' "' + aBackup + '" "' + aSource + '"';
 Windows.WinExec(PAnsiChar(l_C), SW_SHOWNORMAL);
end;

procedure TFilesChangedForm.DoActionElement(Sender: TObject;
          Index: LongInt);
var
 l_SC : Integer;
 l_S : Il3CString;
 l_Index : Integer;
begin
 l_SC := f_Lister.SelectedCount;
 if (l_SC <= 1) then
 begin
  l_S := GetItem(Index);
  Compare(ToBackup(l_S), l3Str(l_S));
 end//l_SC <= 1
 else
 begin
  l_Index := 0;
  while (l_SC > 0) do
  begin
   Inc(l_Index);
   if not f_Lister.Selected[Pred(l_Index)] then
    continue;
   l_S := GetItem(Pred(l_Index));
   Compare(ToBackup(l_S), l3Str(l_S));
   Dec(l_SC);
  end;//  while (l_SC > 0)
 end;//l_SC <= 1
end;

// TFilesList

function TFilesList.StringItemClass: Rl3String;
begin
 Result := TFilesListString;
end;

// TFilesListString

procedure TFilesListString.Cleanup;
begin
 Changed := false;
 inherited;
end;

procedure TFilesListString.AssignString(aStr: Tl3PrimString);
begin
 inherited;
 if (aStr Is TFilesListString) then
  Self.Changed := TFilesListString(aStr).Changed;
end;

end.