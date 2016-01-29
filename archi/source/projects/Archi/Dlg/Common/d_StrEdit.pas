unit d_StrEdit;

{ $Id: d_StrEdit.pas,v 1.4 2013/04/19 13:05:16 lulin Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, StdCtrls, Buttons, ExtCtrls;

type
  TStringEditDlg = class(TBottomBtnDlg)
    lblText: TLabel;
    edtValue: TEdit;
   private
    function  GetValue : AnsiString;
    procedure SetValue(aValue : AnsiString);
    procedure SetLabelText(aValue : AnsiString);

   public
    property Value : AnsiString read GetValue write SetValue;
    property LabelText : AnsiString write SetLabelText;
  end;

function RequestStringValue(var aValue : AnsiString; AOwner: TComponent;
                                 aCaption : AnsiString = ''; aLabel : AnsiString = '') : Boolean;

implementation

{$R *.DFM}

 function RequestStringValue(var aValue : AnsiString; AOwner: TComponent;
                                 aCaption : AnsiString = ''; aLabel : AnsiString = '') : Boolean;
  begin
   With TStringEditDlg.Create(AOwner) do
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

 function  TStringEditDlg.GetValue : AnsiString;
  begin
   Result := edtValue.Text;
  end;

 procedure TStringEditDlg.SetValue(aValue : AnsiString);
  begin
   edtValue.Text := aValue;
  end;

 procedure TStringEditDlg.SetLabelText(aValue : AnsiString);
  begin
   lblText.Caption := aValue;
  end;

end.
