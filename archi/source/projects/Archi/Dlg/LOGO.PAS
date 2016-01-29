unit Logo;

{ $Id: LOGO.PAS,v 1.14 2013/09/13 14:02:41 voba Exp $ }

interface

uses Classes,
     StdCtrls, Graphics, Forms, Controls,
     vtLabel, vtImageForm, Messages;

type
  TLOGODlg = class(TForm)
    ImageForm: TvtImageForm;
    VerInfo: TvtLabel;
    procedure FormCreate(Sender: TObject);
    procedure ImageFormClick(Sender: TObject);
  private
  end;

 {Procedure ShowLogo;}

implementation

{$R *.DFM}
uses SysUtils,
     BaseSupport
     ;

procedure TLOGODlg.FormCreate(Sender: TObject);
begin
 VerInfo.Caption := BaseSupport.GetProjectConfigStr;
end;

procedure TLOGODlg.ImageFormClick(Sender: TObject);
begin
 ModalResult := mrOk;
end;

end.
