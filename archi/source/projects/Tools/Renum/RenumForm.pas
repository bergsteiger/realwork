unit RenumForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    EditSource: TEdit;
    ButtonLookSrc: TButton;
    EditDestination: TEdit;
    ButtonLookdest: TButton;
    RadioGroup1: TRadioGroup;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure ButtonLookSrcClick(Sender: TObject);
    procedure ButtonLookdestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Uses
 dt_LinkServ,
 ddHTInit,
 ddClientBaseEngine,
 daSchemeConsts,
 l3Interfaces,
 l3String,
 l3Chars,
 l3Base,
 l3Types,
 l3Filer,
 DT_Renum,
 DT_Const,
 Dialogs;

procedure TForm1.Button1Click(Sender: TObject);
var
 l_Renum: TReNumTbl;
 l_InFile,
 l_OutFile: Tl3DOSFiler;
 l_Number: Integer;
 l_OutStr: Il3CString;
 l_Pos: Integer;
 l_S, l_SNum: Tl3WString;
begin
 if InitBaseEngine then
 try
  Button1.Enabled:= False;
  ProgressBar1.Visible:= True;
  l_Renum:= LinkServer(CurrentFamily).Renum;
  l_InFile:= Tl3DOSFiler.Make(editSource.Text);
  try
   l_InFile.Open;
   ProgressBar1.Max:= l_InFile.Size;
   ProgressBar1.Position:= 0;
   l_OutFile:= Tl3DOSFiler.Make(editDestination.Text, l3_fmWrite);
   try
    l_OutFile.Open;
    while not l_InFile.EOF do
    begin
     l_S := l3Trim(l_InFile.Readln);
     l_Pos := l3GetPosCharSet(l_S.S, [cc_HardSpace, cc_Tab]);
     if l_Pos > 0 then
      l_SNum := l3Copy(l_S, 0, l_Pos)
     else
      l_SNum := l_S;
     l_Number := l3StrToIntDef(l_SNum, -1);
     if l_Number > 0 then
     begin
      if RadioGroup1.ItemIndex = 0 then
       l_Number := l_Renum.ConvertExternalDocNumberToInternal(l_Number)
      else
       l_Number := l_Renum.GetExtDocID(l_Number);
      l_OutStr := l3Cat(l3CStr(IntToStr(l_Number)), l3Copy(l_S, l_SNum.SLen));
      l_OutFile.WriteLn(l_OutStr.AsWStr);
     end;
     ProgressBar1.Position:= l_InFile.Stream.Position;
    end; // while not l_InFile.IsEO
   finally
    l3Free(l_OutFile);
   end; // try.. finally
  finally
   l3Free(l_InFile);
  end; // try.. finally
  MessageDlg('Преобразование закончено', mtInformation, [mbOk], 0);
 finally
  DoneClientBaseEngine;
  Button1.Enabled:= True;
  ProgressBar1.Visible:= False;
 end;
end;

procedure TForm1.ButtonLookSrcClick(Sender: TObject);
var
 l_FileName: String;
begin
 l_FileName:= EditSource.Text;
 if PromptForFileName(l_FileName) then
  EditSource.Text:= l_FileName;
end;

procedure TForm1.ButtonLookdestClick(Sender: TObject);
var
 l_FileName: String;
begin
 l_FileName:= EditDestination.Text;
 if PromptForFileName(l_FileName) then
  EditDestination.Text:= l_FileName;
end;

end.
