unit alcuCloseQueryDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, vtLabel, vtFocusLabel, OvcBase, afwControlPrim,
  afwBaseControl, afwControl, afwTextControlPrim, afwTextControl;

type
  TalcuCloseQueryDlgForm = class(TForm)
    vtLabel1: TvtLabel;
    vtFocusLabel1: TvtFocusLabel;
    vtFocusLabel2: TvtFocusLabel;
    vtFocusLabel3: TvtFocusLabel;
    procedure vtFocusLabel1Click(Sender: TObject);
    procedure vtFocusLabel2Click(Sender: TObject);
    procedure vtFocusLabel3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  alcuCloseQueryDlgForm: TalcuCloseQueryDlgForm;

implementation

{$R *.dfm}

procedure TalcuCloseQueryDlgForm.vtFocusLabel1Click(Sender: TObject);
begin
  ModalResult := mrYes;
end;

procedure TalcuCloseQueryDlgForm.vtFocusLabel2Click(Sender: TObject);
begin
  ModalResult := mrNo;
end;

procedure TalcuCloseQueryDlgForm.vtFocusLabel3Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
