unit fcabout;

interface

{$i fcIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, fcLabel;

type
  TfcAbout1stForm = class(TForm)
    Bevel1: TBevel;
    Label4: TLabel;
    Button1: TButton;
    Registration: TLabel;
    Version: TLabel;
    fcLabel1: TfcLabel;
    fcLabel2: TfcLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    ARegistration, AVersion: string;
    { Public declarations }
  end;

var
  fcAbout1stForm: TfcAbout1stForm;

implementation

{$R *.DFM}

procedure TfcAbout1stForm.FormShow(Sender: TObject);
begin
   Version.Caption:= 'Version: ' + AVersion;
   Registration.Caption:= ARegistration;
end;

end.
