unit souConverterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, k2TagGen, l3Interfaces, l3Filer, StdCtrls, ComCtrls, ddCmdLineUtils,
  AppEvnts;

type
 TsouCmdLine = class(TddBaseCmdLine)
 private
  f_DestFolder: string;
  f_SrcFolder: string;
  f_SubDir: Boolean;
 protected
  procedure Init; override;
  procedure SetDefault; override;
 end;

  TsouMainForm = class(TForm)
    LabelFile: TLabel;
    LabelFOlder: TLabel;
    ProgressBar: TProgressBar;
    ProgressLabel: TLabel;
    ApplicationEvents1: TApplicationEvents;
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    f_Abort: Boolean;
    f_CmdLine: TsouCmdLine;
   f_InFiler: Tl3DOSFiler;
   f_OutFiler: Tl3DOSFiler;
   f_Reader: Tk2TagGenerator;
   procedure ConvertFiles;
    procedure Dowork;
    function GetAutolinkFileName: string;
   function GetKTFileName: string;
   function GetMisspelsFileName: string;
    function pm_GetgDestinationFolder: String;
    function pm_GetgSourceFolder: string;
    function pm_GetgWithSubDirs: Boolean;
    procedure UpdateProgress(Sender: TObject; aTotalPercent: Integer);
   procedure WrongWordFound(aTopicID: Integer; aWrongWord: Il3CString);
    { Private declarations }
  public
    property gDestinationFolder: String read pm_GetgDestinationFolder;
    property gSourceFolder: string read pm_GetgSourceFolder;
    property gWithSubDirs: Boolean read pm_GetgWithSubDirs;
    { Public declarations }
  end;

procedure SetDefault;

var
  SouMainForm: TsouMainForm;

implementation

uses
  ddNsrc_r, ddNsrc_w,
  ddSpellCheckFilter, ddKTExtractor, ddAutoLinkFilter, dd_lcMisspellFilter,
  ddFileIterator, ddProgressObj, l3Base, l3FileUtils, l3Types, ddUtils,
  dt_Serv, dt_Const, ddHTInit, ddCmdLineDlg, EvSimpleTextPainter;

{$R *.dfm}

procedure SetDefault;
begin
 // TODO -cMM: TddCmdLine.SetDefault default body inserted
end;

procedure TsouMainForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_CmdLine)
end;

procedure TsouMainForm.ApplicationEvents1Idle(Sender: TObject; var Done:
    Boolean);
begin
 Application.OnIdle:= nil;
 if f_CmdLine.NeedHelp then
 begin
  ShowCmdHelpMessage(Application.Title, f_CmdLine.HelpText);
  Application.Terminate;
 end
 else
  DoWork;
end;

procedure TsouMainForm.FormCreate(Sender: TObject);
begin
 f_CmdLine:= TsouCmdLine.Create(true);
end;

procedure TsouMainForm.ConvertFiles;
var
 l_Filer : TevDOSFiler;
 l_Filer2: TevDOSFiler;
 l_Files: TddFileIterator;
 i: Integer;
 l_Start: TDateTime;
 l_Prg: TddProgressObject;
 l_Gen: Tk2TagGenerator;
 l_ExMasks: TStrings;

 procedure BuildPipe;
 begin
  l_Gen:= nil;
  TddNSRCGenerator.SetTo(l_Gen);
  TddNSRCGenerator(l_Gen).Filer:= l_Filer2;
  TevSimpleTextPainter.SetTo(l_Gen);
  TddKTExtractorFilter.SetTo(l_Gen, GetKTFileName);
  TddAutoLinkFilter.SetTo(l_Gen, nil, GetAutolinkFileName);
  TddSpellCheckFilter.SetTo(l_Gen{, WrongWordFound});
  Tdd_lcMisspellFilter.SetTo(l_Gen, GetMisspelsFileName);
  TCustomNSRCReader.SetTo(l_Gen);
  TCustomNSRCReader(l_Gen).Filer:= l_Filer;
 end;


 function lp_WorkFile(const FileName: String): Boolean;
 var
  l_FileName: String;
  l_GZFilename: string;
 begin
  l3System.Msg2Log(FileName);
  l_GZFilename := ExtractFileName(FileName);
  labelFile.Caption:= l_GZFilename;

  l_Filer.Filename := Filename;
  l_FileName:= ConcatDirName(gDestinationFolder, ChangeFileExt(l_GZFilename, '.nsr'));
  l_Filer2.FileName:= l_FileName;
  try
   try
    TCustomNSRCReader(l_Gen).Execute;
   except
    on E: Exception do
    begin
     l3System.Msg2Log('ОШИБКА ПРИ ЧТЕНИИ!');
     l_Filer.Close;
     l_Filer2.Close;
     FreeAndNil(l_Gen);
     BuildPipe;
    end;
   end;
  except
   on E: Exception do
   begin
    l3System.Exception2Log(E);
   end;
  end;
  labelFile.Caption:= '';
  Result:= not f_Abort;
 end; // lp_WorkFile

begin
 ForceDirectories(gDestinationFolder);
 l_Files:= TddFileIterator.Make(gSourceFolder, '*.nsr', nil, gWithSubDirs);
 try
  l_Files.LoadFiles;
  if not l_Files.Empty then
  begin
   l_Filer:= TevDOSFiler.Create;
   try
    l_Filer.Mode:= l3_fmRead;
     l_Filer2:= TevDOSFiler.Create;
     try
       l_Filer2.Mode:= l3_fmFullShareCreateReadWrite;
       l_Start:= Now;
       try
        BuildPipe;
        LabelFolder.Caption:= gSourceFolder;
        l_Prg:= TddProgressObject.Create(nil);
        try
         l_Prg.OnUpdate:= UpdateProgress;
         l_Prg.Start(l_Files.FileList.Count);
         l3System.Msg2Log('Начато преобразование %d файлов', [l_Files.FileList.Count]);
         f_Abort:= False;
         l_Filer.NeedProcessMessages:= True;
         l_Filer.Indicator.NeedProgressProc:= True;
         l_Filer.Indicator.OnProgressProc:= l_Prg.ProcessUpdate;
         for i:= 0 to l_Files.FileList.Count-1 do
         begin
          if f_Abort then
           break;
          lp_WorkFile(l_Files.FileList[i]);
          l_Prg.ProcessUpdate(i);
         end; // for i
        finally
         l_Prg.Stop;
         l3System.Msg2Log('Преобразование закончено за '+ CalcElapsedTime(l_Start, Now));
         l3Free(l_Prg);
        end;
        LabelFolder.Caption:= '';
       finally
        FreeAndNil(l_Gen);
       end;

     finally
      l3Free(l_Filer2);
     end;
   finally
    l3Free(l_Filer);
   end;
  end;
 finally
  l3Free(l_Files);
 end;
end;

procedure TsouMainForm.Dowork;
var
 l_Ok: Boolean;
begin
 with f_CmdLine do
 begin
  if BaseRoot <> '' then
   l_Ok:= InitBaseEngine(BaseRoot, User, Password)
  else
   l_ok:= InitBaseEngine(serverIP, ServerPort, User, Password);
  if l_Ok then
  try
   ConvertFiles;
  finally
   DoneClientBaseEngine;
  end;
  Close;
 end;
end;

procedure TsouMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 f_Abort:= True;
end;

function TsouMainForm.GetAutolinkFileName: string;
begin
 if GlobalHtServer <> nil then
  Result := ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily), 'autolink.dat')
 else
  Result:= '';
end;

function TsouMainForm.GetKTFileName: string;
begin
 if GlobalHtServer <> nil then
  Result := ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily), 'kthemes.zip')
 else
  Result:= '';
end;

function TsouMainForm.GetMisspelsFileName: string;
begin
 Result := GetAppFolderFileName('TypicalErrors.txt');
end;

function TsouMainForm.pm_GetgDestinationFolder: String;
begin
 Result := f_CmdLine.f_DestFolder;
 if Result = '' then
  Result:= ConcatDirname(gSourceFolder, 'result');
end;

function TsouMainForm.pm_GetgSourceFolder: string;
begin
 Result := f_CmdLine.f_SrcFolder;
end;

function TsouMainForm.pm_GetgWithSubDirs: Boolean;
begin
 Result := f_CmdLine.f_SubDir;
end;

procedure TsouMainForm.UpdateProgress(Sender: TObject; aTotalPercent: Integer);
begin
 ProgressBar.Position:= aTotalPercent;
 ProgressLabel.Caption:= 'До окончания осталось: '+ TddProgressObject(Sender).TotalRemainingTimeAsString;
 Application.ProcessMessages;
end;

procedure TsouMainForm.WrongWordFound(aTopicID: Integer; aWrongWord:
    Il3CString);
begin
end;

procedure TsouCmdLine.Init;
begin
 inherited Init;
 AddFolder('src', 'Папка с исходными файлами', '', f_SrcFolder);
 AddString('dest', 'Папка для обработанных файлов', '', f_DestFolder);
 AddBool('r', 'Обрабатывать подпапки', '', f_SubDir);
end;

procedure TsouCmdLine.SetDefault;
begin
 inherited SetDefault;
 f_SubDir:= False;
 f_DestFolder:= '';
 f_SrcFolder:= '';
end;

end.
