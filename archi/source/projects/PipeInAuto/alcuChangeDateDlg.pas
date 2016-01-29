unit alcuChangeDateDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  alcuMsgDlg, StdCtrls, ComCtrls;

type
  TalcuChangeDateDialog = class(TForm)
    Button1: TButton;
    Button2: TButton;
    dtFrom: TDateTimePicker;
    dtTo: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    lblTaskCaption: TLabel;
  public
    function Execute(const aCaption: String; const aFromDate: TDateTime; out
            aToDate: TDateTime): Boolean;
  end;
  
var
  alcuChangeDateDialog: TalcuChangeDateDialog;

implementation

{$R *.dfm}

{ TForm1 }

{
**************************** TalcuChangeDateDialog *****************************
}
function TalcuChangeDateDialog.Execute(const aCaption: String; const aFromDate:
        TDateTime; out aToDate: TDateTime): Boolean;
begin
  lblTaskCaption.Caption:= aCaption;
  dtFrom.Date:= aFromDate;
  dtTo.Date:= aFromDate;
  if ShowModal = mrOk then
  begin
   Result:= true;
   aToDate:= dtTo.date;
  end
  else
  begin
   Result:= False;
   aToDate:= aFromDate;
  end
end;

end.
