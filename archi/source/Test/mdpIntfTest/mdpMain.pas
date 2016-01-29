unit mdpMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, vtCombo, vtDateEdit, ddTypes, ddMDPIntegration;

type
  TMainForm = class(TForm)
    Button1: TButton;
    memLog: TMemo;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure DoOnError(const aDescription: String; aCategory: Integer = 0);
    procedure DoOnResult(const aResult: TddMDPImportResultObj);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 DateUtils,
 l3Types,
 l3Filer,
 evdWriter,

 //SewerPipe,

 k2TagGen;

{$R *.dfm}

{$IFDEF ARCHIFREE}
procedure TMainForm.Button1Click(Sender: TObject);
var
 l_Reader: TddMDPReader;
 l_Writer: TevdNativeWriter;
 l_Filer : Tl3DOSFiler;
begin
 l_Filer := Tl3DOSFiler.Make('result.evd', l3_fmWrite);
 try
  l_Filer.Open;
  l_Reader := TddMDPReader.Create;
  try
   l_Reader.Since := deSince.Date;
   l_Writer := TevdNativeWriter.Create;
   try
    l_Writer.Binary := False;
    l_Reader.Generator := l_Writer;
    l_Writer.Filer := l_Filer;
    l_Reader.Execute;
   finally
    FreeAndNil(l_Writer);
   end;
  finally
   FreeAndNil(l_Reader);
  end;
 finally
  FreeAndNil(l_Filer);
 end;
end;

{$ELSE}
procedure TMainForm.Button1Click(Sender: TObject);
begin
 ddImportFromMDP(DoOnError, DoOnResult, nil);
end;

procedure TMainForm.DoOnError(const aDescription: String; aCategory: Integer = 0);
begin
 memLog.Lines.Add(aDescription);
end;

procedure TMainForm.DoOnResult(const aResult: TddMDPImportResultObj);
begin
 memLog.Lines.Add('----8<-----');
 with memLog.Lines, aResult do
 begin
  Add(Format('DocID: %d', [rDocID]));
  Add(Format('Name: %s', [rName]));
  Add(Format('Comment: %s', [rComment]));
  if rIsNew then
   Add('+ новый документ')
  else
   Add('- существующий документ');
  {
  if rSuccess then
   Add('+ успешно обработан')
  else
   Add('- не обработан');
  } 
 end;
end;

{$ENDIF}

procedure TMainForm.FormShow(Sender: TObject);
begin
// deSince.Date := IncDay(Now, -3);
end;

end.
