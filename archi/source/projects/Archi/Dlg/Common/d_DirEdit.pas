unit D_DirEdit;

{ $Id: d_DirEdit.pas,v 1.1 2002/04/15 10:35:41 voba Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, StdCtrls, vtSpin, Buttons, ExtCtrls, Mask, ToolEdit;

type
  TDirEditDlg = class(TBottomBtnDlg)
    lblText: TLabel;
    edtFilename: TDirectoryEdit;
   private
    function  GetValue : TFileName;
    procedure SetValue(aValue : TFileName);
    procedure SetLabelText(aValue : String);

   public
    property Value : TFileName read GetValue write SetValue;
    property LabelText : string write SetLabelText;
  end;

function RequestDirName(var aValue   : TFileName;
                            aOwner   : TComponent;
                            aCaption : String = '';
                            aLabel   : String = '') : Boolean;

implementation

{$R *.DFM}

 function RequestDirName(var aValue   : TFileName;
                             aOwner   : TComponent;
                             aCaption : String = '';
                             aLabel   : String = '') : Boolean;

  begin
   With TDirEditDlg.Create(AOwner) do
    try
     Caption := aCaption;
     LabelText := aLabel;
     Value := aValue;
     //If aFilters <> '' then edtFilename.Filter := aFilters;
     Result := Execute;
     If Result then Result := Length(Value) > 0;
     If Result then aValue := Value;
    finally
     Free;
    end;
  end;

 function  TDirEditDlg.GetValue : TFileName;
  begin
   Result := edtFileName.Text;
  end;

 procedure TDirEditDlg.SetValue(aValue : TFileName);
  begin
   edtFileName.Text := aValue;
  end;

 procedure TDirEditDlg.SetLabelText(aValue : String);
  begin
   lblText.Caption := aValue;
  end;

end.
