unit alcuRegionEditDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  alcuMsgDlg, StdCtrls;

type
  TRegionEditDlg = class(TForm)
    Label1: TLabel;
    editDescription: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    editFTPServer: TEdit;
    Label3: TLabel;
    editFTPLogin: TEdit;
    Label4: TLabel;
    editFTPPassword: TEdit;
    Label5: TLabel;
    editFTPFolder: TEdit;
    Label6: TLabel;
    editFileNameMask: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label7: TLabel;
    editNotifyAddress: TEdit;
    procedure editDescriptionChange(Sender: TObject);
  private
    function Execute: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TRegionEditDlg;

implementation

{$R *.dfm}

function TRegionEditDlg.Execute: Boolean;
begin
 Result := ShowModal = mrOk;
end;

procedure TRegionEditDlg.editDescriptionChange(Sender: TObject);
begin
 Caption := editDescription.Text;
end;

end.
