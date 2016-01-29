unit f2main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, Placemnt;

type
  TfrmMain = class(TForm)
    edWorkDir: TDirectoryEdit;
    GroupBox1: TGroupBox;
    edRange: TEdit;
    Label1: TLabel;
    edStartNum: TEdit;
    Label2: TLabel;
    edPrefix: TEdit;
    Label3: TLabel;
    edNumWidth: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    FormStorage1: TFormStorage;
    edFileMask: TEdit;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Proceed;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses l3Base, l3RangeManager, l3Chars, l3String;

{$R *.dfm}

{ TForm1 }

procedure TfrmMain.Proceed;
var
 NumWidth: Integer;
 NewName: string;
 I: Integer;
 PrefixStr: string;
 Files: TStringList;
 CurIndex: Integer;
 StartNumber: Integer;
 RangeStr: string;
 X: Integer;
 FCount: Integer;
 MaskStr: string;
 WorkPath: string;
 WorkMask: string;
 ExePath: string;
 RM: Tl3RangeManager;

 procedure LoadList(const AMask: string);
 var
  FS : TSearchRec;
  X  : Integer;
  ExeS: string;
 begin
  Files.Clear;
  ExeS := UpperCase(ExtractFileName(Application.ExeName));
  X := FindFirst(AMask, faArchive, FS);
  while X = 0 do
  begin
   if UpperCase(FS.Name) <> ExeS then
    Files.Add(FS.Name);
   X := FindNext(FS);
  end;
 end;

begin
 try
  RangeStr := edRange.Text;
  if Trim(RangeStr) = '' then
  begin
   FocusControl(edRange);
   raise Exception.Create('не определен диапазон значений');
  end;

  ExePath := ExtractFilePath(Application.ExeName);
  WorkPath := edWorkDir.Text;
  MaskStr := edFileMask.Text;

  if WorkPath = '' then
  begin
   WorkPath := GetCurrentDir;
   edWorkDir.Text := WorkPath;
  end;

  WorkPath := IncludeTrailingPathDelimiter(WorkPath);

  if MaskStr = '' then
  begin
   MaskStr := '*.*';
   edFileMask.Text := MaskStr;
  end;

  if edStartNum.Text = '' then
   StartNumber := 0
  else
   try
    StartNumber := StrToInt(edStartNum.Text);
   except
    FocusControl(edStartNum);
    raise Exception.Create('ошибка в стартовом номере');
   end;

  if edNumWidth.Text = '' then
  begin
   NumWidth := 0;
   edNumWidth.Text := '0';
  end
  else
   try
    NumWidth := StrToInt(edNumWidth.Text);
   except
    FocusControl(edNumWidth);
    raise Exception.Create('ошибка в ширине');
   end;

  PrefixStr := edPrefix.Text;

  if DirectoryExists(WorkPath) then
  begin
   FCount := 0;
   RM := Tl3RangeManager.Create;
   try
    X := RM.CheckSource(RangeStr);
    if X = 0 then
    begin
     edRange.Color := clWindow;
     RM.SrcString := RangeStr;

     if StartNumber >= RM[RM.Count] then
      raise Exception.Create('диапазон номеров исчерпан!');

     if StartNumber <> 0 then
     begin
      CurIndex := RM.IndexOfPage[StartNumber];
      if CurIndex = -1 then
      begin
       MessageDlg('Внимание! Диапазон номеров был изменен!', mtInformation, [mbOK], 0);
       CurIndex := 1;
      end;
     end
     else
      CurIndex := 1;

     Files := TStringList.Create;
     try
      LoadList(WorkPath+MaskStr);
      for I := 0 to Files.Count-1 do
      begin
       try
        StartNumber := RM[CurIndex];
        NewName := WorkPath + PrefixStr + Format('%.'+IntToStr(NumWidth)+'d',[StartNumber]) + ExtractFileExt(Files[I]);
        if FileExists(NewName) then
         raise Exception.Create('файл '+NewName+' уже существует!');
        RenameFile(WorkPath+Files[I], NewName);
        Inc(FCount);
       except
        raise Exception.Create('невозможно переименовать файл '+ExtractFileName(Files[I])+' в ' + ExtractFileName(NewName));
       end;
       Inc(CurIndex);
       if CurIndex > RM.Count then
       begin
        edStartNum.Text := '-';
        raise Exception.Create('диапазон номеров исчерпан!');
       end;
      end;
     finally
      Files.Free;
     end;
     MessageDlg(IntToStr(FCount)+' файлов переименовано.', mtInformation, [mbOK], 0);
     if CurIndex > RM.Count then
     begin
      edRange.Text := '-';
      raise Exception.Create('диапазон номеров исчерпан!');
     end
     else
     begin
      StartNumber := RM[CurIndex];
      edStartNum.Text := IntToStr(StartNumber);
     end;
    end
    else
    begin
     edRange.Color := $DEDEFF;
     FocusControl(edRange);
     edRange.SelStart := X-1;
     edRange.SelLength := 1;
     //MessageDlg('Ошибка в определении диапазона!', mtError, [mbOK], 0);
    end;
   finally
    l3Free(RM);
   end;
  end
  else
   raise Exception.Create('директория ' + WorkPath + ' не существует.');
 except
  on E: Exception do MessageDlg('Ошибка: '+E.Message, mtError, [mbOK], 0);
 end;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
 Proceed;
end;

end.
