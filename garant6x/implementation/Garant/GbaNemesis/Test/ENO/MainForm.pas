unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
 Registry
 ;

procedure TForm1.FormCreate(Sender: TObject);
var
 l_IDX: Integer;
begin
 Label1.Caption := 'Переданная строка - ';
 for l_IDX := 1 to ParamCount do
 begin
  if l_IDX <> 1 then
   Label1.Caption := Label1.Caption + ' ';
  Label1.Caption := Label1.Caption + ParamStr(l_IDX);
 end;
end;

procedure TForm1.Button1Click(Sender: TObject);
  {-}
var
 R         : TRegistry;
 l_AppName : String;
begin
 l_AppName := ChangeFileExt(ExtractFileName(Application.ExeName), '');
 R := TRegistry.Create;
 try
  with R do begin
   RootKey := HKEY_CLASSES_ROOT;
   if OpenKey(Edit1.Text, true) then begin
    WriteString('', 'gerfile');
    CloseKey;
   end;
   if OpenKey('gerfile', true) then begin
    WriteString('', 'ENO tester');
    WriteInteger('EditFlags', $0);
    CloseKey;
   end;
   if OpenKey('gerfile\Shell', true) then begin
    WriteString('', '');
    CloseKey;
   end;
   if OpenKey('gerfile\Shell\Open', true) then begin
    WriteInteger('EditFlags', $1);
    CloseKey;
   end;
   if OpenKey('gerfile\Shell\Open\command', true) then begin
    WriteString('', Application.ExeName + ' %1');
    CloseKey;
   end;
  end;{with R}
 finally
  FreeAndNil(R);
 end;{try..finally}
end;

end.
