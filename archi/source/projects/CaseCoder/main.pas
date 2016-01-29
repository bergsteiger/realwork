unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ddFileIterator, ExtCtrls, ddAppConfigTypes, l3Filer, k2TagGen,
  l3Types, l3LongintList;

type
  TMainForm = class(TForm)
    ProgressBar1: TProgressBar;
    WorkSpace: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    f_Config: TddAppConfigNode;
    f_Files: TddFileIterator;
    f_Gen: Tk2TagGenerator;
    f_InFiler: Tl3DOSFiler;
    f_OutFiler: Tl3DOSFiler;
    procedure Progress(aState : Byte; aValue : Long; const aMsg : String = '');
    function Str2List(const aStr: String): Tl3LongintList;
    { Private declarations }
  public
    procedure DestroyPipe;
    procedure FreeFileList;
    procedure LoadFileList;
    procedure MakePipe;
    function workUpFile(const aFileName: String): Boolean;
    procedure WorkupFiles;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

Uses
 ddHTInit, ddAppConfigUtils, l3Base, evdReader, evdWriter, dd_lcCaseCodeGenerator,
 ddAutoLinkFilter, l3FileUtils, rxStrUtils;

procedure TMainForm.Button1Click(Sender: TObject);
begin
 Button1.Enabled:= False;
 try
  f_Config.GetControlValues;
  if InitBaseEngine(f_Config.Items[0].StringValue, f_Config.Items[1].StringValue, f_Config.Items[2].StringValue) then
  begin
   MakePipe;
   try
    ForceDirectories(f_Config.Items[4].StringValue);
    LoadFileList;
    WorkupFiles;
    ShowMessage('Номера дел и ссылки успешно расставлены');
   finally
    FreeFileList;
    destroyPipe;
    DoneClientBaseEngine;
   end;
  end
  else
   ShowMessage('не удалось подключиться к базе данных');
 finally
  Button1.Enabled:= True;
 end;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.DestroyPipe;
begin
 l3Free(f_Gen);
 l3Free(f_OutFiler);
 l3Free(f_InFiler);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 //AfwHackControlFont(Self);
 f_Config:= MakeNode('Config', 'Настройки',
             {0}MakeFolderName('Путь к базе', '',
             {1}MakeString('Пользователь', '',
             {2}MakeString('Пароль', '', '*',
             // дальше просто параметры
             {3}MakeFolderName('Папка с исходными данными', '',
             {4}MakeFolderName('Папка с обработанными данными', '',
//             {5}MakeFileName('Список кодексов', '*.csv', '',
//             {6}MakeFileName('Список ФЗ', '*.csv', '',
             {5}makeString('Список Исходящих органов', '211;214;215;216;217;218;219;220;221;222;223;224',
             nil))))))){))};
 f_Config.LabelTop:= False;
 f_Config.CreateFrame(WorkSpace, 0);
 f_Config.Load(MakedefaultStorage);
 f_Config.SetControlValues(False);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 f_Config.GetControlValues;
 f_Config.Save(MakedefaultStorage);
 l3Free(f_Config);
end;

procedure TMainForm.FreeFileList;
begin
 l3Free(f_Files);
end;

procedure TMainForm.LoadFileList;
begin
 f_Files:= TddFileIterator.Make(f_Config.Items[3].StringValue, '*.evd');
 f_Files.OnProgress:= Progress;
end;

procedure TMainForm.MakePipe;
var
 l_List: Tl3LongintList;
begin
 // TODO -cMM: TMainForm.MakePipe необходимо написать реализацию
 { Читалка_евд-Расстановщик_номеров-Расстановщик_ссылок_Писалка_евд }
 f_Gen:= nil;
 f_OutFiler:= Tl3DOSFiler.Create(nil);
 TevdNativeWriter.setTo(f_Gen);
 TevdNativeWriter(f_Gen).Filer:= f_OutFiler;
 TevdNativeWriter(f_Gen).Binary := True;
 with f_Config do
 begin
  l_List:= Str2List(Items[5].StringValue);
  try
   TddAutoLinkFilter.SetTo(f_Gen, l_List{Items[5].StringValue, Items[6].StringValue});
  finally
   l3Free(l_List);
  end;
 end;
 f_InFiler:= Tl3DOSFiler.Create(nil);
 TlcBufferedCaseCodeGenerator.SetTo(f_Gen);
 TevdNativeReader.SetTo(f_Gen);
 TevdNativeReader(f_Gen).Filer:= f_InFiler;
end;

procedure TMainForm.Progress(aState : Byte; aValue : Long; const aMsg : String = '');
begin
 case aState of
  0:
   begin
    ProgressBar1.Max:= aValue;
    ProgressBar1.Position:= 0;
   end;
  1,2: ProgressBar1.Position:= aValue;
 end;
 Application.ProcessMessages;
end;

function TMainForm.Str2List(const aStr: String): Tl3LongintList;
var
 i: Integer;
 l_ID: Integer;
begin
 Result:= Tl3LongintList.Make;
 for i:= 1 to WordCount(aStr, [';',',']) do
 begin
  l_ID:= StrToIntDef(ExtractWord(i, aStr, [';',',']), 0);
  if l_ID > 0 then
   Result.Add(l_ID);
 end;

end;

function TMainForm.workUpFile(const aFileName: String): Boolean;
begin
 Result := True;
 f_outFiler.FileName:= ConcatDirName(f_Config.Items[4].StringValue, ExtractFileName(aFileName));
 f_InFiler.FileName:= aFileName;
 f_Gen.Start;
 try
  (f_Gen as TevdNativeReader).Read;
 finally
  f_Gen.Finish;
 end;
end;

procedure TMainForm.WorkupFiles;
begin
 f_Files.IterateFiles(workUpFile);
end;

end.
