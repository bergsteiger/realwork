unit ddSimpleProgressDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls;

type
  TddSimpleProgressDialog = class(TForm)
    ProgressBar: TProgressBar;
  private
    { Private declarations }
  public
   { Public declarations }
   procedure UpdateProc(Sender: TObject; aTotalPercent: Integer);
  end;

var
  ddSimpleProgressDialog: TddSimpleProgressDialog;

implementation

{$R *.dfm}

procedure TddSimpleProgressDialog.UpdateProc(Sender: TObject; aTotalPercent: Integer);
begin
 ProgressBar.Position := aTotalPercent;
 Update;
end;

end.
