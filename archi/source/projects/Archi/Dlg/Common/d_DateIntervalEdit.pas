unit d_DateIntervalEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Mask, vtCombo, vtDateEdit, Buttons,
  ExtCtrls,
  l3Date;

type
  TDateIntervalDlg = class(TBottomBtnDlg)
    edtDateLow: TvtDateEdit;
    edtDateHigh: TvtDateEdit;
    Label1: TStaticText;
    Label2: TStaticText;
  end;

  function GetDateInterval(var aDateLow, aDateHigh: TStDate;
                           aCaption : string = '') : boolean;

implementation

{$R *.dfm}

 function GetDateInterval(var aDateLow, aDateHigh: TStDate; aCaption : string = '') : boolean;
  begin
   with TDateIntervalDlg.Create(nil) do
   try
    edtDateLow.StDate  := aDateLow;
    edtDateHigh.StDate := aDateHigh;
    If aCaption <> '' then Caption := aCaption;

    Result := Execute;
   finally
    Free;
   end;
  end;


end.
