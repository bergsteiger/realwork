unit D_RepAsk;

{ $Id: d_RepAsk.PAS,v 1.2 1999/12/28 12:27:45 law Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls;

type
  TSaveTroubleDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label1: TLabel;
    RetryBtn: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
