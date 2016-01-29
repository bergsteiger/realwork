unit D_SchRes;

{ $Id: D_SCHRES.PAS,v 1.9 2014/07/11 11:26:13 dinishev Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, OvcBase, vtlister, afwControlPrim, afwBaseControl,
  afwControl, afwInputControl, vtForm;

type
  TSearchResultDlg = class(TvtForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Help: TBitBtn;
    OKBtn: TBitBtn;
    Cancel: TBitBtn;
    SrchWinList : TvtDStringlister;
    ResultLabel: TLabel;
    edtSrchWinName: TEdit;
    procedure SrchWinListActionElement(Sender: TObject; CurN: Pointer);
    procedure FormResize(Sender: TObject);
    procedure SrchWinListCurrentChanged(Sender: TObject; aNewCurrent, aOldCurrent: Integer);
  private
    { Private declarations }
  public
    DefaultNameForZeroItem : String;
  end;

implementation

{$R *.DFM}

procedure TSearchResultDlg.SrchWinListActionElement(Sender: TObject; CurN: Pointer);
begin
 ModalResult := mrOk;
end;

procedure TSearchResultDlg.SrchWinListCurrentChanged(Sender: TObject; aNewCurrent, aOldCurrent: Integer);
 begin
  If aNewCurrent = 0
   then edtSrchWinName.Text := DefaultNameForZeroItem
   else edtSrchWinName.Text := SrchWinList.Items.PasStr[aNewCurrent];
 end;

procedure TSearchResultDlg.FormResize(Sender: TObject);
 begin
  edtSrchWinName.Width := 409 + Width - 529;
 end;

end.
