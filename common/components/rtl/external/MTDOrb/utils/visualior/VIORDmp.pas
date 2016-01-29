unit VIORDmp;

interface

uses
  SysUtils, Types, Classes, Variants,
{$IFDEF LINUX}
  QGraphics, QControls, QForms, QDialogs,  QStdCtrls,
{$ELSE}
  Graphics, Controls, Forms, Dialogs,  StdCtrls,
{$ENDIF}
  orb_int,
  orb,
  poa_int,
  poa_impl,
  exceptions,
  except_int,
  orbtypes,
  iior_int,
  ior;


type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button3: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    IORFileName : String;
    strBaseCaption : String;
    IORFile : Text;
    Function FormatIOR(strIOR : string) : String;
    Function FileName(strFile : String) : String;
    Procedure ProduceInfo;
    Procedure LoadAndProduceInfo;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$IFDEF LINUX}
{$R *.xfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

function TForm1.FileName(strFile : String) : String;
var
  strTemp : String;
  nPos : integer;
begin
  strTemp := strFile;
{$IFDEF LINUX}
  nPos := Pos('/',strTemp);
{$ELSE}
  nPos := Pos('\',strTemp);
{$ENDIF}
  while (nPos > 0) do
    begin
      if ((nPos + 1) < length(strTemp) ) then
        strTemp := copy(strTemp,nPos+1,length(strTemp)-(nPos));
{$IFDEF LINUX}
        nPos := Pos('/',strTemp);
{$ELSE}
        nPos := Pos('\',strTemp);
{$ENDIF}
    end;
  result := strTemp;
end;

function TForm1.FormatIOR(strIOR :String) : String;
var
  strTemp : String;
  strTemp2 : String;
begin
  //Combined w/ Word Wrap on Memo1 this formats nicely
  strTemp := '';
  strTemp2 := strIOR;
  while (length(strTemp2) > 0) do
    begin
      strTemp := strTemp + copy(strTemp2,0,40);
{$IFDEF LINUX}
      strTemp := strTemp + #13;
{$ELSE}
      strTemp := strTemp + ' ';
{$ENDIF}
      strTemp2 := copy(strTemp2,41,length(strTemp2));
    end;
  Result := StrTemp;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  StrTemp : String;
begin
  if OpenDialog1.Execute then
    begin
      if FileExists(OpenDialog1.FileName) then
        begin
          IORFileName := OpenDialog1.FileName;
          StrTemp := FileName(IORFileName);
          Form1.Caption := strBaseCaption + ' : '+strTemp;
          LoadAndProduceInfo();
        end
      else
        ShowMessage('File : '+OpenDialog1.FileName+' doesn''t exist,');
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  IORFileName := '';
  strBaseCaption := Form1.Caption;
end;

procedure TForm1.ProduceInfo;
var
  dOrb : IORB;
  Obj : IORBObject;
  Props : TStrings;
  ObjectIOR : IIOR;
  strOut : String;
  streamTemp : TStringStream;
begin
    Props := TStringList.Create;
    streamTemp := TStringStream.Create('');
    if (Pos('IOR',Memo1.Text) > 0) then
    begin
        try
            dOrb := ORB_Init(Props);
            assert((dOrb <> nil),'Invalid ORB Reference Returned');
            obj := dOrb.string_to_object(AnsiString(Memo1.Text));
            if (obj <> nil) then
              begin
                strOut := '';
                ObjectIOR := obj._ior;
                streamTemp.Seek(0,soFromBeginning);
                ObjectIOR.print(streamTemp);
                strOut := streamTemp.DataString;
                if (strOut <> '') then
                  begin
                    Memo2.Lines.Clear;
                    Memo2.Lines.Add(strOut);
                  end;

              end;
            dOrb.do_shutdown;
        except
            ShowMessage('Fatal Error During Translation Process.');
        end;
    end
    else
        ShowMessage('This Does not Appear to be a valid IOR.');


end;

procedure TForm1.LoadAndProduceInfo;
var
  strTemp : String;
begin
  strTemp :='';
  if (IORFileName <> '') then
    begin
      AssignFile(IORFile,IORFileName);
      Reset(IORFile);
      Readln(IORFile,strTemp);
      CloseFile(IORFile);
      if (Pos('IOR',strTemp) > 0) then
        begin
          //Could use Memo1.Lines.LoadFromFile() here
          //But I chose to format the loaded IOR from a
          //String
          //---Anyway, 6 of one half dozen of the other :)
          Memo1.Lines.Clear;
          //Memo1.Lines.Add( FormatIOR(strTemp));
          Memo1.Lines.Add(strTemp);
          ProduceInfo();
        end
      else
        ShowMessage('This Does not Appear to be a valid IOR.');
    end
  else
    ShowMessage('Please Select A File.');
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
    ProduceInfo();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if (SaveDialog1.Execute) then
    begin
        Memo2.Lines.SaveToFile(SaveDialog1.FileName);
    end;
end;

end.
