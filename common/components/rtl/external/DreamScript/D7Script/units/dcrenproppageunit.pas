{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCRenPropPageUnit;

interface

uses
  StdCtrls, Controls, ExtCtrls, Buttons, Classes, Forms, SysUtils, Dialogs,
  dcconsts, DCButtonPanel;

type
  TDCRenPropPageForm = class(TForm)
    DCButtonPanel1: TDCButtonPanel;
    HelpBtn: TBitBtn;
    CancelBtn: TBitBtn;
    OkBtn: TBitBtn;
    Bevel: TBevel;
    PageNameLabel: TLabel;
    PageNameEdit: TEdit;
    procedure PageNameEditChange(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
  private
    FReservedWords : TStrings;
  public
    Constructor Create( AOwner : TComponent ); override;

    Property ReservedWords : TStrings Read FReservedWords Write FReservedWords;
  end;

Function DCEditPalettePageName( AReservedWords : TStrings; Const APalettePageName : String ) : String;
Function DCAddPalettePageName( AReservedWords : TStrings ) : String;

implementation

{------------------------------------------------------------------}

Function DCEditPalettePageName( AReservedWords : TStrings; Const APalettePageName : String ) : String;
begin
  With TDCRenPropPageForm.Create( Nil ) Do
    try
      Caption := sDCRenPropPageFormCaption;

      ReservedWords := AReservedWords;
      PageNameEdit.Text := APalettePageName;
      Result := APalettePageName;
      If ShowModal = mrOk Then
        Result := Trim( PageNameEdit.Text );
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

Function DCAddPalettePageName( AReservedWords : TStrings ) : String;
begin
  With TDCRenPropPageForm.Create( Nil ) Do
    try
      Caption := sDCAddPropPageFormCaption;

      ReservedWords := AReservedWords;
      PageNameEdit.Text := '';
      Result := '';
      If ShowModal = mrOk Then
        Result := Trim( PageNameEdit.Text );
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

{$R *.DFM}

{------------------------------------------------------------------}

{ TDCRenPropPageForm }

Constructor TDCRenPropPageForm.Create( AOwner : TComponent );
begin
  Inherited;
  PageNameLabel.Caption := sDCPageNameCaption;
end;

{------------------------------------------------------------------}

procedure TDCRenPropPageForm.PageNameEditChange(Sender: TObject);
begin
  OkBtn.Enabled := Trim( PageNameEdit.Text ) <> '';
end;

{------------------------------------------------------------------}

procedure TDCRenPropPageForm.OkBtnClick(Sender: TObject);
Var
  Text : String;
begin
  Text := Trim( PageNameEdit.Text );
  If ReservedWords.IndexOf( Text ) < 0 Then
    Exit;
  MessageDlg( Format( sDCDublicatePageName, [Text] ), mtError, [mbOk], 0 );
  ModalResult := mrNone;
end;

{------------------------------------------------------------------}

end.
