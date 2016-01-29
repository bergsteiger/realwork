unit tcMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit;

type
  TForm1 = class(TForm)
    feCHM: TFilenameEdit;
    Label1: TLabel;
    edContext: TEdit;
    Label2: TLabel;
    btnOpen: TButton;
    procedure btnOpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
 SPHTMLHelp;

{$R *.dfm}

procedure TForm1.btnOpenClick(Sender: TObject);
begin
 Application.HelpFile := feCHM.FileName;
 Application.HelpContext(StrToIntDef(edContext.Text, 0));
end;

end.
