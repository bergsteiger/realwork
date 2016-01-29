unit D_DSPrm;

{ $Id: D_DSPrm.pas,v 1.2 1999/12/28 12:27:42 law Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,
  HelpCnst,
  BottomBtnDlg;

type
  TDocSetParamDlg = class(TBottomBtnDlg)
    Label1: TLabel;
    NameEdit: TEdit;
    rgSaveMethod: TRadioGroup;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DocSetParamDlg: TDocSetParamDlg;

implementation

{$R *.DFM}

procedure TDocSetParamDlg.FormCreate(Sender: TObject);
begin
  inherited;
  HelpContext := hcSaveDocSample;
end;

end.
