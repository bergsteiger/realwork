unit SaveKeyMacro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSaveKeyMacroDlg = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SaveKeyMacroDlg: TSaveKeyMacroDlg;

implementation

{$R *.dfm}

procedure TSaveKeyMacroDlg.Button1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Edit1.Text := SaveDialog1.FileName;
end;

end.
