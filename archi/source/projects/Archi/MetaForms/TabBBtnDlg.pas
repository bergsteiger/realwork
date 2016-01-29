unit TabBBtnDlg;

{ $Id: TabBBtnDlg.pas,v 1.2 1999/12/28 12:27:46 law Exp $ }

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
 
