unit eaMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolEdit, Mask, ZipForge, l3Types, Contnrs,
  ExtCtrls;

type
  TForm1 = class(TForm)
    feInputFile: TFilenameEdit;
    deSource: TDirectoryEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    deDest: TDirectoryEdit;
    ProgressBar: TProgressBar;
    lblDisp: TLabel;
    btnStart: TButton;
    Panel1: TPanel;
    rbLookForEVD: TRadioButton;
    rbLookForGZ: TRadioButton;
    rgInputFormat: TRadioGroup;
    procedure btnStartClick(Sender: TObject);
    procedure rgInputFormatClick(Sender: TObject);
  private
    { Private declarations }
    f_Count: Integer;
    f_Zips: TStringList;
    procedure ExtractOne(const aZipFN, aEvdFN: string);
    procedure Execute;
    procedure DoOnProgress(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
    procedure FillZips;
    function AddOneZipToList(const aFileName: String): Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
 l3Base,
 l3Interfaces,
 l3FileUtils,
 l3String,
 l3RegEx,
 l3Filer,
 vtDialogs,

 ddFileIterator;

const
 c_ifNSRC    = 0;
 c_ifLogFile = 1;


function TForm1.AddOneZipToList(const aFileName: String): Boolean;
var
 l_Zip : TZipForge;
begin
 Result := True;
 l_Zip := TZipForge.Create(nil);
 l_Zip.BaseDir := deDest.Text;
 l_Zip.FileName := aFileName;
 l_Zip.OpenArchive;
 f_Zips.AddObject(ExtractFileName(aFileName), l_Zip);
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
 Execute;
end;

procedure TForm1.DoOnProgress(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
begin
 case aState of
  piStart:
   begin
    ProgressBar.Max := aValue;
    ProgressBar.Position := 0;
   end;
  piCurrent : ProgressBar.Position := aValue;
  piEnd     : ProgressBar.Position := ProgressBar.Max;
 end;
 Application.ProcessMessages;
end;

procedure TForm1.Execute;
var
 l_InputFN: string;
 l_Filer: Tl3DosFiler;
 l_RegEx: Tl3RegularSearch;
 l_ZipName, l_EvdName: string;
 l_Line: Tl3WString;
 l_RP: Tl3MatchPosition;
 I : Integer;
begin
 btnStart.Enabled := False;
 try
  l_InputFN := feInputFile.FileName;
  if FileExists(l_InputFN) then
  begin
   l_Filer := Tl3DOSFiler.Make(l_InputFN);
   try
    l_Filer.Indicator.NeedProgressProc := True;
    l_Filer.Indicator.OnProgressProc := DoOnProgress;
    l_Filer.Open;
    f_Count := 0;
    f_Zips := TStringList.Create;
    try
     f_Zips.CaseSensitive := False;
     FillZips;
     lblDisp.Caption := 'Найдено: 0';
     ForceDirectories(deDest.Text);
     l_RegEx := Tl3RegularSearch.Create;
     try
      Assert(rgInputFormat.ItemIndex <= c_ifLogFile);
      case rgInputFormat.ItemIndex of
       c_ifNSRC    : l_RegEx.SearchPattern := '^\;{.+\.zip}\\{.+\.evd}$';
       c_ifLogFile : l_RegEx.SearchPattern := '^\d+\={.+\.evd}$';
      end;
      while not l_Filer.EOF do
      begin
       l_Line := l_Filer.ReadLn;
       if l_RegEx.SearchInString(l_Line, l_RP) then
       begin
        case rgInputFormat.ItemIndex of
         c_ifNSRC:
          begin
           l_ZipName := l3Str(l_RegEx.TagParts.ItemW[0]);
           l_EvdName := l3Str(l_RegEx.TagParts.ItemW[1]);
          end;
         c_ifLogFile:
          begin
           l_ZipName := '';
           l_EvdName := l3Str(l_RegEx.TagParts.ItemW[0]);
          end;
        end;
        ExtractOne(l_ZipName, l_EvdName);
       end;
      end;
     finally
      FreeAndNil(l_RegEx);
     end;
    finally
     for I := 0 to Pred(f_Zips.Count) do
      f_Zips.Objects[I].Free;
     FreeAndNil(f_Zips);
    end;
   finally
    FreeAndNil(l_Filer);
   end;
  end
  else
   vtMessageDlg(l3CStr('Не найден NSR файл!'));
 finally
  btnStart.Enabled := True;
 end;
end;

procedure TForm1.ExtractOne(const aZipFN, aEvdFN: string);
var
 l_Idx : Integer;
 l_Zip: TZipForge;
 l_FileName: string;
 l_AI: TZFArchiveItem;
begin
 try
  if rbLookForEVD.Checked and (aZipFN <> '') then
  begin
   // Для EVD передаётся имя zip-файла, беда только, что не всегда оно подходит.
   // Но всё равно, для скорости сначала поищем в указанном zip'е
   l_Idx := f_Zips.IndexOf(aZipFN);
   if l_Idx >= 0 then
   begin
    l_Zip := TZipForge(f_Zips.Objects[l_Idx]);
    if l_Zip.FindFirst(aEvdFN, l_AI) then
    begin
     l_Zip.ExtractFile(l_AI);
     Inc(f_Count);
     Exit;
    end;
   end;
  end;

  if rbLookForEVD.Checked then
   l_FileName := aEvdFN
  else
   l_FileName := ChangeFileExt(aEvdFN, '.gz');

  for l_Idx := 0 to Pred(f_Zips.Count) do
  begin
   l_Zip := TZipForge(f_Zips.Objects[l_Idx]);
   if l_Zip.FindFirst(l_FileName, l_AI) then
   begin
    l_Zip.ExtractFile(l_AI);
    Inc(f_Count);
    Break;
   end;
  end;
 finally
  lblDisp.Caption := Format('Найдено: %d', [f_Count]);
 end;
end;

procedure TForm1.FillZips;
var
 l_FI: TddFileIterator;
begin
 lblDisp.Caption := 'Зачитываем каталог zip-файлов...';
 Application.ProcessMessages;
 l_FI := TddFileIterator.Make(deSource.Text, '*.zip');
 try
  l_FI.IterateFiles(AddOneZipToList);
 finally
  FreeAndNil(l_FI);
 end;
end;

procedure TForm1.rgInputFormatClick(Sender: TObject);
begin
 case rgInputFormat.ItemIndex of
  c_ifNSRC    : feInputFile.Filter := 'NSRC (*.nsr)|*.nsr';
  c_ifLogFile : feInputFile.Filter := 'Лог-файлы (*.log)|*.log';
 end; 
end;

end.
