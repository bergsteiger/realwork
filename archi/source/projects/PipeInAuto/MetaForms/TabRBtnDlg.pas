unit TabRBtnDlg;

{ $Id: TabRBtnDlg.pas,v 1.1 2003/07/30 10:08:30 narry Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, RBtnDlg, ComCtrls;

type
  TTabRBtnDlg = class(TRBtnDlg)
    PageCtrl: TPageControl;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
