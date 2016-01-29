unit D_DocInf;

{ $Id: D_DocInf.pas,v 1.1 2009/05/14 08:45:08 dinishev Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TShowDocInfoDlg = class(TForm)
    pnlButtons: TPanel;
    pnlButtonsRight: TPanel;
    OKBtn: TBitBtn;
    lblDocSize: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
