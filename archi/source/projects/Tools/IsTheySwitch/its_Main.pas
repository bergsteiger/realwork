unit its_Main;

interface

uses
  Windows, Messages, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, ToolEdit, ComCtrls, XPMan;

type
  TMainForm = class(TForm)
    feLog: TFilenameEdit;
    Label1: TLabel;
    pnlResult: TPanel;
    PB: TProgressBar;
    btnStart: TButton;
    XPManifest1: TXPManifest;
    edMinVersion: TEdit;
    Label2: TLabel;
    procedure btnStartClick(Sender: TObject);
    procedure edMinVersionChange(Sender: TObject);
    procedure feLogChange(Sender: TObject);
  private
    f_MinVersion: Integer;
    procedure CheckInput;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 SysUtils,
 
 l3Types,
 l3Interfaces,
 l3Stream,
 l3Filer,
 l3String,
 l3RegEx,
 l3StringList, l3StringListPrim;

procedure TMainForm.btnStartClick(Sender: TObject);
var
 l_FN: string;
 l_Filer: Tl3DOSFiler;
 l_Src: Tl3WString;
 l_RE: Tl3RegularSearch;
 l_MP: Tl3MatchPosition;
 l_Name: Tl3WString;
 l_Build: Integer;
 l_NameList: Tl3StringList;
begin
 l_FN := feLog.FileName;
 if Trim(l_FN) = '' then
 begin
  MessageDlg('Необходимо задать имя файла лога!', mtError, [mbOK], 0);
  Exit;
 end;
 if FileExists(l_FN) then
 begin
  l_Filer := Tl3DOSFiler.Make(l_FN, l3_fmRead);
  btnStart.Enabled := False;
  try
   l_Filer.Open;
   PB.Max := l_Filer.Size;
   PB.Position := 0;
   pnlResult.Caption := '';
   Application.ProcessMessages;
   l_RE := Tl3RegularSearch.Create;
   try
    l_RE.IgnoreCase := True;
    l_RE.SearchPattern := 'i\.{[^\s\t]+}.+Run Archi client.+build {\d+}';
    l_NameList := Tl3StringList.MakeSorted;
    try
     while not l_Filer.EOF do
     begin
      l_Src := l_Filer.ReadLn;
      if l_RE.SearchInString(l_Src, l_MP) then
      begin
       l_Name := l_RE.TagParts[0].AsWStr;
       try
        l_Build := l3StrToInt(l_RE.TagParts[1].AsWStr);
       except
        l_Build := 0;
       end;
       if l_Build >= f_MinVersion then
        l_NameList.Add(l_Name);
      end;
      PB.StepBy(l_Src.SLen+2);
      Application.ProcessMessages;
     end;
     if l_NameList.Count = 0 then
     begin
      pnlResult.Font.Color := clRed;
      pnlResult.Caption := 'Свидетельств перехода на новую версию не найдено';
     end
     else
     begin
      pnlResult.Font.Color := clGreen;
      pnlResult.Caption := Format('Обнаружен переход на новую версию. Количество пользователей: %d', [l_NameList.Count]);
     end;
    finally
     FreeAndNil(l_NameList);
    end;
   finally
     FreeAndNil(l_RE);
   end;
  finally
   btnStart.Enabled := True;
   FreeAndNil(l_Filer);
  end;
 end
 else
  MessageDlg('Файл лога не найден!', mtError, [mbOK], 0);
end;

procedure TMainForm.CheckInput;
begin
 f_MinVersion := StrToIntDef(edMinVersion.Text, -1);
 btnStart.Enabled := (f_MinVersion > 0) and FileExists(feLog.FileName);
end;

procedure TMainForm.edMinVersionChange(Sender: TObject);
begin
 CheckInput;
end;

procedure TMainForm.feLogChange(Sender: TObject);
begin
 CheckInput;
end;

end.
