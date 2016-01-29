unit mceMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ddAppConfigTypes, StdCtrls, ComCtrls, l3Types;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    pnlSettings: TPanel;
    ProgressBar: TProgressBar;
    btnGo: TButton;
    procedure btnGoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    f_Config: TddAppConfigNode;
    { Private declarations }
    procedure DoProgress(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 l3Filer,
 l3FileUtils,
 l3Const,
 l3Interfaces,
 l3Base,
 l3InterfacedComponent,

 k2TagGen,
 k2FileGenerator,
 k2Reader,

 evSimpleTextPainter,
 evdNativeWriter,
 evdNativeReader,

 ddNSRC_w,
 ddNSRC_r,
 ddFileIterator,
 ddAppConfigUtils,
 ddMisspellCorrect;

const
 ifNSRC = 0;
 ifEVD  = 1;

procedure TMainForm.btnGoClick(Sender: TObject);
var
 l_DictFN: string;
 l_Ext: AnsiString;
 l_InDir: string;
 l_InFiler: Tl3DosFiler;
 l_OutDir: string;
 l_OutFiler: Tl3DosFiler;
 l_FI: TddFileIterator;
 l_Stub: TddIterateProc;
 l_G     : Tk2TagGenerator;

 procedure Error(const aMsg: string);
 begin
  MessageDlg(aMsg, mtError, [mbOk], 0);
 end;

 function DoOneFile(const aFilename: AnsiString): Boolean;
 var
  l_JustFilename: AnsiString;
 begin
  Result := True;
  l_JustFilename := ExtractFileName(aFilename);
  l3System.Msg2Log(l_JustFilename);
  l_InFiler.FileName := aFilename;
  l_OutFiler.FileName := ConcatDirName(l_OutDir, l_JustFilename);
  l_InFiler.Open;
  try
   l_OutFiler.Open;
   try
    Tk2CustomFileParser(l_G).Execute;
   finally
    l_OutFiler.Close;
   end;
  finally
   l_InFiler.Close;
  end;
 end;


begin
 f_Config.Save(MakedefaultStorage);
 btnGo.Enabled := False;
 f_Config.Enabled := False;
 try
  (f_Config as IddConfigNode).GetControlValues;
  l_DictFN := f_Config.AsString['MisspellDict'];
  if FileExists(l_DictFN) then
  begin
   l_InDir := f_Config.AsString['SrcFolder'];
   if DirectoryExists(l_InDir) then
   begin
    l_OutDir := f_Config.AsString['DestFolder'];
    if ForceDirectories(l_OutDir) then
    begin
     case f_Config.AsInteger['InFormat'] of
      ifNSRC: l_Ext := '*.nsr';
      ifEVD : l_Ext := '*.evd';
     else
      Assert(False, 'Not supported!');
     end;
     l_FI := TddFileIterator.Make(l_InDir, l_Ext, DoProgress);
     try
      if l_FI.Count > 0 then
      begin
       l_InFiler := Tl3DOSFiler.Create;
       try
        l_InFiler.Mode := l3_fmRead;
        l_OutFiler := Tl3DOSFiler.Create;
        try
         l_OutFiler.Mode := l3_fmWrite;
         l_G := nil;
         try
          case f_Config.AsInteger['InFormat'] of
           ifNSRC: TddNSRCGenerator.SetTo(l_G);
           ifEVD : TevdNativeWriter.SetTo(l_G);
          end; //case
          Tk2CustomFileGenerator(l_G).Filer := l_OutFiler;

          if f_Config.AsInteger['InFormat'] = ifNSRC then
           TevSimpleTextPainter.SetTo(l_G);

          TddMisspellCorrectFilterEx.SetTo(l_G, l_DictFN);

          case f_Config.AsInteger['InFormat'] of
           ifNSRC: TCustomNSRCReader.SetTo(l_G);
           ifEVD : TevdNativeReader.SetTo(l_G);
          end; //case
          Tk2CustomFileParser(l_G).Filer := l_InFiler;

          l3System.Str2Log('');
          l3System.Msg2Log('Обработка файлов в папке %s', [l_InDir]);
          l_Stub := L2IterateFilesProc(@DoOneFile);
          try
           l_FI.IterateFiles(l_Stub);
          finally
           FreeIterateFilesProc(l_Stub);
          end;
         finally
          FreeAndNil(l_G);
         end;
        finally
         FreeAndNil(l_OutFiler);
        end;
       finally
        FreeAndNil(l_InFiler);
       end;
      end
      else
       Error('Не найдены файлы NSRC!');
     finally
      FreeAndNil(l_FI);
     end;
    end
    else
     Error('Неверный путь к папке с результатами!');
   end
   else
    Error('Папка с исходными данными не найдена!');
  end
  else
   Error('Файл словаря опечаток не найден!');
 finally
  btnGo.Enabled := True;
  f_Config.Enabled := True;
 end;
end;

procedure TMainForm.DoProgress(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
begin
 case aState of
  piStart:
   begin
    ProgressBar.Position := 0;
    ProgressBar.Max := aValue;
   end;
  piCurrent: ProgressBar.Position := aValue;
  piEnd    : ProgressBar.Position := ProgressBar.Max;
 end;
 Application.ProcessMessages;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 f_Config.Save(MakedefaultStorage);
 FreeAndNil(f_Config);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 l_CI: TddRadioGroupConfigItem;
begin
 l_CI := TddRadioGroupConfigItem.CreateItem('InFormat', 'Формат файлов', 0);
 l_CI.Add('NSRC');
 l_CI.Add('EVD');
 f_Config := MakeNode('Config', 'Настройки', False,
   MakeCustomItem(l_CI, 
   MakeFolderName('SrcFolder', 'Папка с исходными документами', '',
   MakeFolderName('DestFolder', 'Папка для результатов', '',
   MakeFileName('MisspellDict', 'Словарь опечаток', '*.csv', 'lcMisspell.csv'
   ))))
  );
 f_Config.LabelTop := True;//False;
 (f_Config as IddConfigNode).CreateFrame(pnlSettings, 0);
 f_Config.Load(MakedefaultStorage);
 (f_Config as IddConfigNode).SetControlValues(False);
end;

end.
