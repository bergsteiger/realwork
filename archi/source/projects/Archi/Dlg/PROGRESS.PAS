unit Progress;

{ $Id: PROGRESS.PAS,v 1.5 2005/05/27 15:23:28 lulin Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, W95Meter, VConst, OvcBase;

type
  TProgressDlg = class(TForm)
    CancelBtn    : TBitBtn;
    PercentMeter : TW95Meter;
    MsgLabel     : TLabel;
  private
    { Private declarations }
  public
    constructor CreateParam(AOwner : TComponent; aCaption : String);
    procedure ProgressProc (aState: Byte; aPercent: Integer;
                            aValue: Longint; const aMsg: string);

  end;

implementation
 {$R *.DFM}

 constructor TProgressDlg.CreateParam(AOwner : TComponent; aCaption : String);
  Begin
   Inherited Create(AOwner);
   Caption:=aCaption;

  end;

 procedure TProgressDlg.ProgressProc (aState: Byte; aPercent: Integer;
                            aValue: Longint; const aMsg: string);
  Begin
   Case aState of
    piStart   :  Try
                  Show;
                 except
                 end;

    piCurrent : Begin
                 PercentMeter.Percent:=aPercent;
                 MsgLabel.Caption:=aMsg;
                end;
    piEnd     : Close;
   end;
  end;
end.
