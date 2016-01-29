
//------------------------------------------------------------------------------
//Progress screen
//------------------------------------------------------------------------------

unit uProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Gauges;

type
  TfrmProgress = class(TForm)
    gOverall: TGauge;
    gFile: TGauge;
    lbFile: TLabel;
    btnCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    bCancel: Boolean;
    { Public declarations }
  end;

var
  frmProgress: TfrmProgress;

implementation

{$R *.dfm}

//------------------------------------------------------------------------------
// OnFormCreate
//------------------------------------------------------------------------------
procedure TfrmProgress.FormCreate(Sender: TObject);
begin
 bCancel := False;
end; // TfrmProgress.FormCreate

//------------------------------------------------------------------------------
// OnCancelClick
//------------------------------------------------------------------------------
procedure TfrmProgress.btnCancelClick(Sender: TObject);
begin
 bCancel := True;
 Close;
end; // TfrmProgress.btnCancelClick

procedure TfrmProgress.FormShow(Sender: TObject);
begin
 bCancel := False;
end;

end.
