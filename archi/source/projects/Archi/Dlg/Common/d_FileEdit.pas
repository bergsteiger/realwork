unit D_FileEdit;

{ $Id: d_FileEdit.pas,v 1.2 2002/03/01 13:24:04 voba Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, StdCtrls, vtSpin, Buttons, ExtCtrls, Mask, ToolEdit;

type
  TFileEditDlg = class(TBottomBtnDlg)
    lblText: TLabel;
    edtFilename: TFilenameEdit;
   private
    function  GetValue : TFileName;
    procedure SetValue(aValue : TFileName);
    procedure SetLabelText(aValue : String);

   public
    property Value : TFileName read GetValue write SetValue;
    property LabelText : string write SetLabelText;
  end;

function RequestFileName(var aValue : TFileName;
                             aOwner: TComponent;
                             aCaption : String = '';
                             aLabel : String = '';
                             aFilters : String = '') : Boolean;

implementation

{$R *.DFM}

 function RequestFileName(var aValue : TFileName;
                              aOwner: TComponent;
                              aCaption : String = '';
                              aLabel : String = '';
                              aFilters : String = '') : Boolean;

  begin
   With TFileEditDlg.Create(AOwner) do
    try
     Caption := aCaption;
     LabelText := aLabel;
     Value := aValue;
     If aFilters <> '' then edtFilename.Filter := aFilters;
     Result := Execute;
     If Result then Result := Length(Value) > 0;
     If Result then aValue := Value;
    finally
     Free;
    end;
  end;

 function  TFileEditDlg.GetValue : TFileName;
  begin
   Result := edtFileName.Text;
  end;

 procedure TFileEditDlg.SetValue(aValue : TFileName);
  begin
   edtFileName.Text := aValue;
  end;

 procedure TFileEditDlg.SetLabelText(aValue : String);
  begin
   lblText.Caption := aValue;
  end;

end.
