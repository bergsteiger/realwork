unit xmlform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ddAppConfigTypes, ComCtrls;

type
  TConverterForm = class(TForm)
    WorkPanel: TPanel;
    ButtonsPanel: TPanel;
    OkButton: TButton;
    Button2: TButton;
    ProgressBar: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
    f_Aborted: Boolean;
    f_Node: TddCustomConfigNode;
    procedure ConfigChanged(Sender: TObject);
    procedure ConvertFiles;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConverterForm: TConverterForm;

const
 cFileName = 'c:\2_109_793524712.gz';

implementation

Uses
 evdWriter,
 afwVCL,
 ddArbitralCourtReader, ddAppConfig, ddFileIterator,
 l3Base, l3Filer, l3FileUtils,
 k2TagGen, ddUtils;

{$R *.dfm}

procedure TConverterForm.ConvertFiles;
var
 l_Filer, l_Filer2: TevDOSFiler;
 l_Reader: TArbitralCourtReader;
 l_Writer: TevdNativeWriter;
 l_Files: TddFileIterator;
 i: Integer;
 l_Start: TDateTime;

 function lp_WorkFile(const FileName: String): Boolean;
 begin
  l_Filer.FileName:= FileName;
  l_Filer2.FileName:= ConcatDirName(ddAppConfiguration.AsString['DestinationFolder'], ChangeFileExt(ExtractFileName(FileName), '.evd'));
  l_Reader.Execute;
  Result:= True;
 end;
begin
 ForceDirectories(ddAppConfiguration.AsString['DestinationFolder']);
 l_Files:= TddFileIterator.Make(ddAppConfiguration.AsString['SourceFolder'], '*.gz');
 try
  l_Files.LoadFiles;
  ProgressBar.Max:= l_Files.FileList.Count;
  ProgressBar.Position:= 0;
  l_Filer:= TevDOSFiler.Create;
  try
   l_Reader:= TArbitralCourtReader.Create;
   try
    l_Reader.SourceFileName:= ddAppConfiguration.AsString['Source.csv'];
    l_Reader.Filer:= l_Filer;
    l_Filer2:= TevDOSFiler.Create;
    try
     l_Writer:= TevdNativeWriter.Create;
     try
      l_Writer.Binary:= True;
      l_Writer.Filer:= l_Filer2;
      l_Reader.Generator:= l_Writer;
      l_Start:= Now; f_Aborted:= False;
      for i:= 0 to l_Files.FileList.Count-1 do
      begin
       if f_Aborted then
        break;
       lp_WorkFile(l_Files.FileList.Strings[i]);
       ProgressBar.Position:= Succ(i);
       Application.ProcessMessages;
      end; // for i
      ShowMessage('Преобразование закончено за '+ CalcElapsedTime(l_Start, Now));
     finally
      l3Free(l_Writer);
     end;
    finally
     l3Free(l_Filer2);
    end;
   finally
    l3Free(l_Reader);
   end;
  finally
   l3Free(l_Filer);
  end;
 finally
  l3Free(l_Files);
 end;
end;

procedure TConverterForm.FormCreate(Sender: TObject);
var
 l_H, l_W: Integer;
begin
 AfwHackControlFont(Self);
 ddAppConfiguration:= TddAppConfiguration.Create();
 with ddAppConfiguration do
 begin
  f_Node:= AddNode('General', 'Настройки');
  //f_Node.OnChange:= ConfigChanged;
  AddFolderNameItem('SourceFolder', 'Папка с исходными файлами');
   //Required:= True;
  AddFolderNameItem('DestinationFolder', 'Папка для обработанных файлов');
   //Required:= True;
  AddFileNameItem('Source.csv', 'Расшифровка исходящих органов');
   Filter:= 'Значения, разделенные запятыми (*.csv)|*.csv';
  Load;
  (*
  f_Node.FrameSize(WorkPanel, l_H, l_W);
  ClientHeight:= l_H + ButtonsPanel.Height;
  ClientWidth:= l_W;
  *)
  f_node.CreateFrame(WorkPanel, 0);
  f_Node.SetControlValues(False);
 end;
end;

procedure TConverterForm.FormDestroy(Sender: TObject);
begin
 l3Free(ddAppConfiguration);
end;

procedure TConverterForm.Button2Click(Sender: TObject);
begin
 if OkButton.Enabled then
  Close
 else
  f_Aborted:= True;
end;

procedure TConverterForm.OkButtonClick(Sender: TObject);
begin
 f_Node.GetControlValues;
 ddAppConfiguration.Save;
 OkButton.Enabled:= False;
 ConvertFiles;
 OkButton.Enabled:= True;
end;

procedure TConverterForm.ConfigChanged(Sender: TObject);
begin
 //OkButton.Enabled:= ddAppConfiguration.IsValid;
end;

end.
