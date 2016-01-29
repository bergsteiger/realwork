unit DSubView;

{ $Id: DSUBVIEW.PAS,v 1.9 2010/07/21 10:38:44 voba Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, OvcBase, vtlister,  ComCtrls, vtStatusBar, afwControlPrim,
  afwBaseControl, afwControl, afwInputControl;

type
  TViewSubDlg = class(TForm)
    lstSub: TvtDStringlister;
    FooterPanel: TvtStatusBar;
    procedure lstSubCurrentChanged(Sender: TObject; NewCurrent, OldCurrent: Longint);
    function  lstSubGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
    procedure lstSubActionElement(Sender: TObject; Index: Longint);
  private
    { Private declarations }
  public
    Function Execute(Var aSub : Longint) : Boolean;
  end;

implementation

{$R *.DFM}
 Uses SysUtils, ResShop,
      Main;

Function TViewSubDlg.Execute(Var aSub : Longint) : Boolean;
 begin
  Result := ShowModal = mrOK;
  If Result then
   ASub := lstSub.Items.DataInt[lstSub.Current];
 end;

procedure TViewSubDlg.lstSubCurrentChanged(Sender: TObject; NewCurrent, OldCurrent: Longint);
 begin
  If (lstSub.Total > 0)
   then FooterPanel.Panels[0].Text := Format('%d из %d', [NewCurrent+1, lstSub.Total])
   else FooterPanel.Panels[0].Text := '';
 end;

function TViewSubDlg.lstSubGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
 begin
  Result := picAnchor;
 end;

procedure TViewSubDlg.lstSubActionElement(Sender: TObject; Index: Longint);
 begin
  ModalResult := mrOK;
 end;

end.
