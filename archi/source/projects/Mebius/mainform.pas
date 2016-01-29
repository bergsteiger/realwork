unit mainform;
{ $Id: mainform.pas,v 1.3 2014/10/08 13:07:42 lukyanets Exp $ }
// $Log: mainform.pas,v $
// Revision 1.3  2014/10/08 13:07:42  lukyanets
// ѕереносим процедуры в правильное место
//
// Revision 1.2  2006/01/05 15:06:02  narry
// - изменение: запись-чтение настроек
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, ddProgressObj, l3Base, ComCtrls, XPMan;

type
  TMebiusForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    dirSourceFolder: TDirectoryEdit;
    dirDestinationFolder: TDirectoryEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    cbImportType: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    cbInputFileType: TComboBox;
    Label5: TLabel;
    cbOutputFileType: TComboBox;
    ProgressBar: TProgressBar;
    Descript: TLabel;
    XPManifest1: TXPManifest;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    f_Progressor: TddProgressObject;
    f_TopicList: Tl3PVList;
    { Private declarations }
  public
    procedure ExportDocuments;
    function ImportDocuments: Boolean;
    procedure ProgressorUpdate(Sender: TObject; aState: Byte);
    procedure TopicStart(theTopicNo: Longint);
    { Public declarations }
  end;

var
  MebiusForm: TMebiusForm;

implementation

{$R *.dfm}

Uses
 ddImportPipe, ddHTInit, ExportPipe, ddUtils,
 dt_Types, dt_Const, dt_IFltr, dt_Srch,
 l3Memory, l3IniFile;

procedure TMebiusForm.Button1Click(Sender: TObject);
begin
 ProgressBar.Visible := True;
 f_TopicList := Tl3LongintList.MakeSorted;
 try
  f_Progressor := TddProgressObject.Create;
  try
   f_Progressor.OnUpdate := ProgressorUpdate;
   if ImportDocuments then
    ExportDocuments;
   ProgressBar.Position := 0;
  finally
   l3Free(f_Progressor);
  end;
 finally
  l3Free(f_TopicList);
 end;
 ProgressBar.Visible := False;
end;

procedure TMebiusForm.ExportDocuments;
var
 lTmpStream : Tl3MemoryStream;
 f_Srch : TSrchServer;
 i : Integer;
 lCurNum : Integer;
 f_Pipe: TExportPipe;
 Diapason: TDiapasonRec;
begin
 Descript.Caption := 'Ёкспорт';
 f_Srch := TSrchServer.Create;
 try
  lTmpStream := Tl3MemoryStream.Create;
  lTmpStream.Size := 0;
  try
   f_Srch.Family := CurrentFamily;
   f_Srch.Renum := True;
   for i:= 0 to  f_TopicList.Hi do
   begin
    lCurNum := Longint(f_TopicList.Items[i]);
    lTmpStream.Write(lCurNum, SizeOf(Integer));
   end; // for i
   lTmpStream.Seek(0,0);
   f_Srch.AddResDocs(lTmpStream);
   f_Pipe := TExportPipe.Create(nil);
   try
    f_Pipe.Progressor := f_Progressor;
    f_Pipe.OutFileType:= TepSupportFileType(cbOutputFileType.ItemIndex);
    f_Pipe.Family:= CurrentFamily;
    f_Pipe.DivideBy:= divTopic;
    f_Pipe.ExportDocument:= True;
    f_Pipe.UpdateFiles:= False;
    f_Pipe.DocumentFileNameMask:= 'document.nsr';
    f_Pipe.OutputFileSize:= 0;
    f_Pipe.ExportAnnotation := False;
    f_Pipe.ExternalExport:= False;
    f_Pipe.ExportDocImage := False;
    f_Pipe.OnlyStructure := False;
    Diapason.Typ := tdNumList;
    Diapason.List := f_Srch.FoundIDList;
    Diapason.ExternalFormat := False;
    f_Pipe.Diapason:= Diapason;

    f_Pipe.ExportEmpty:= True;
    f_Pipe.ExportKW:= False;
    f_Pipe.KWFileName:= 'garant.kw';
    f_Pipe.ExportDirectory:= dirDestinationFolder.Text;
    f_Pipe.Execute;
   finally
     l3Free(f_Pipe);
   end; {Pipe.Create}
  finally
   l3Free(lTmpStream);
  end;
 finally
  l3Free(f_Srch);
 end;
 Descript.Caption := '';
end;

function TMebiusForm.ImportDocuments: Boolean;
var
 l_Pipe: TPipeDream;
begin
 Descript.Caption := '»мпорт';
 l_Pipe := TPipeDream.Create(nil, CurrentFamily);
 try
  l_Pipe.WorkDir := dirSourceFolder.Text;
  case cbInputFileType.ItemIndex of
   0: l_Pipe.InputFileType := dd_itGarant;
   1: l_Pipe.InputFileType := dd_itEverest;
  else
   l_Pipe.InputFileType:= dd_itAutoDetect;
  end;
  case cbImportType.ItemIndex of
   0,
   1: l_Pipe.ImportType := ietMassive;
   2: l_Pipe.ImportType := ietPacked;
  end;

  l_Pipe.SameDocuments:= sdrDelete;
  l_Pipe.CheckDocuments:= True;

  l_Pipe.MoveFiles:= False;
  l_Pipe.DoneDir:= '';
  l_Pipe.TwoPassImport:= cbImportType.ItemIndex = 1;
  l_Pipe.NotUpdatableDicts:= ddAllDicts;
  l_Pipe.FinalUpdate:= False;
  l_Pipe.PictureDir:= '';
  l_Pipe.Progressor:= f_Progressor;
  l_Pipe.OnTopicStart := TopicStart;
  l_Pipe.IsEnglish:= False;
  Result := l_Pipe.Execute;
 finally
  l3Free(l_Pipe);
 end;
 Descript.Caption := '';
end;

procedure TMebiusForm.TopicStart(theTopicNo: Longint);
begin
 // «десь запоминиаютс€ номера импортированных документов
 f_TopicList.Add(theTopicNo);
end;

procedure TMebiusForm.FormCreate(Sender: TObject);
begin
 InitBaseEngine(akClient);
 LoadSettings(Self);
end;

procedure TMebiusForm.FormDestroy(Sender: TObject);
begin
 SaveSettings(Self);
 DoneClientBaseEngine;
end;

procedure TMebiusForm.ProgressorUpdate(Sender: TObject; aState: Byte);
begin
 with (Sender as TddProgressObject), ProgressBar do
 case aState of
  0: begin
      Max := TotalMax;
      Position := 0;
     end;
  1: Position := TotalCur;
  2: Position := Max;
 end;
end;

end.
