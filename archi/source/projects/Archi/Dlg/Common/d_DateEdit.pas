unit d_DateEdit;

{ $Id: d_DateEdit.pas,v 1.2 2005/03/28 14:02:16 voba Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, StdCtrls, Buttons, ExtCtrls,
  stDate, Mask, vtCombo, vtDateEdit, vtBndLabel;

type
  TDateEditDlg = class(TBottomBtnDlg)
    edtDate: TvtDateEdit;
    lblText: TvtBoundedLabel;
   private
    function  GetValue : TstDate;
    procedure SetValue(aValue : TstDate);
    procedure SetLabelText(aValue : string);

   public
    property Date : TstDate read GetValue write SetValue;
    property LabelText : string write SetLabelText;
  end;

function RequestDate(var aValue : TstDate; AOwner: TComponent;
                     aCaption : String = ''; aLabel : String = '') : Boolean;

implementation

{$R *.DFM}

function RequestDate(var aValue : TstDate; AOwner: TComponent;
                     aCaption : String = ''; aLabel : String = '') : Boolean;
begin
 With TDateEditDlg.Create(AOwner) do
  try
   Caption := aCaption;
   LabelText := aLabel;
   if Length(aLabel) > 10 then
   begin
    edtDate.Top := 34;
    edtDate.Left := 16;
    lblText.Position := lpAbove;
   end;
   Date := aValue;
   Result := Execute;
   if Result then
    aValue := Date;
  finally
   Free;
  end;
end;

function  TDateEditDlg.GetValue : TstDate;
begin
 Result := edtDate.StDate;
end;

procedure TDateEditDlg.SetValue(aValue : TstDate);
begin
 edtDate.StDate := aValue;
end;

procedure TDateEditDlg.SetLabelText(aValue : String);
begin
 lblText.Caption := aValue;
end;

end.
