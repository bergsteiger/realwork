unit D_IntEdit;

{ $Id: d_IntEdit.pas,v 1.1 2008/03/12 14:32:17 dinishev Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, StdCtrls, vtSpin, Buttons, ExtCtrls;

type
  TIntegerEditDlg = class(TBottomBtnDlg)
    edtValue: TvtSpinEdit;
    lblText: TLabel;
   private
    function  GetValue : Integer;
    procedure SetValue(aValue : Integer);
    procedure SetLabelText(aValue : String);

   public
    property Value : Integer read GetValue write SetValue;
    property LabelText : string write SetLabelText;
  end;

function RequestIntegerValue(var aValue : Integer; AOwner: TComponent;
                                 aCaption : String = ''; aLabel : String = '') : Boolean;

implementation

{$R *.DFM}

 function RequestIntegerValue(var aValue : Integer; AOwner: TComponent;
                                  aCaption : String = ''; aLabel : String = '') : Boolean;
  begin
   With TIntegerEditDlg.Create(AOwner) do
    try
     Caption := aCaption;
     LabelText := aLabel;
     Value := aValue;
     Result := Execute;
     If Result then aValue := Value;
    finally
     Free;
    end;
  end;

 function  TIntegerEditDlg.GetValue : Integer;
  begin
   Result := edtValue.AsInteger;
  end;

 procedure TIntegerEditDlg.SetValue(aValue : Integer);
  begin
   edtValue.Value := aValue;
  end;

 procedure TIntegerEditDlg.SetLabelText(aValue : String);
  begin
   lblText.Caption := aValue;
  end;

end.
