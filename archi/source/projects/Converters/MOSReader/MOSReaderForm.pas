unit MOSReaderForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, k2TagGen, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
  private
    f_Folder: string;
    f_Gen: Tk2TagGenerator;
    procedure GetFileName(const aFileName: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

Uses
 ddMOSReader, ddProgressObj,
 evEvdWriter,
 l3FileUtils, l3Filer, l3InterfacedComponent;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 l_Prg: TddProgressObject;
begin
 f_Gen:= nil;
 f_Folder:= ExtractFileDir('C:\aac\Mosoblsud\mosoblsud_d.csv');
 l_Prg:= TddProgressObject.Create;
 try
  l_Prg.ProgressBar:= ProgressBar1;
  TevEvdStorageWriter.SetTo(f_Gen, 'C:\aac\Mosoblsud\mosoblsud_d.evd');
  try
   with TddMOSReader.Create do
   try
    Progressor:= l_Prg;
    OnFileNameEvent:= GetFileName;
    Generator:= f_Gen;
    Execute('C:\aac\Mosoblsud\mosoblsud_d.csv', 'C:\aac\Mosoblsud\mosoblsud_t.csv')
   finally
    Free;
   end;
  finally
   FreeAndNil(f_gen);
  end;
 finally
  FreeAndNil(l_Prg);
 end;
end;

procedure TForm1.GetFileName(const aFileName: String);
begin
 Tl3DOSFiler(TevEvdStorageWriter(f_Gen).Filer).FileName:= ConcatDirName(f_Folder, aFileName+'.evd');
end;

end.
