unit TabBBtnDlg;

{ $Id: TabBBtnDlg.pas,v 1.1 2003/07/30 10:08:31 narry Exp $ }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, BtnDlg, ComCtrls;

type
  TTabBBtnDlg = class(TBtnDlg)
    PageCtrl: TPageControl;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
 
