unit MainExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainLiteExpress, StdActns, ActnList, evAction, dxBar,
  l3InternalInterfaces, l3Base,
  l3ProgressComponent, l3Filer, k2Reader, evEvdRd, k2TagGen, k2DocumentGenerator,
  evdWriter, ImgList, OvcBase, evSubPn, l3InterfacedComponent,
  evSaveDocumentManager, evLoadDocumentManager, dxBarExtItems, StdCtrls,
  vtCtrls;

type
  TMainExpressForm = class(TMainLiteExpressForm)
    acBold: TevAction;
    acItalic: TevAction;
    acUnderline: TevAction;
    acStrikeout: TevAction;
    acSubscript: TevAction;
    acSuperscript: TevAction;
    btBold: TdxBarButton;
    btItalic: TdxBarButton;
    btUnderline: TdxBarButton;
    btStrikeout: TdxBarButton;
    btSubscript: TdxBarButton;
    btSuperscript: TdxBarButton;
    cbFontName: TdxBarFontNameCombo;
    ccFontSize: TdxBarControlContainerItem;
    cbFontSize: TFontSizeComboBox;
    procedure cbFontNameChange(Sender: TObject);
    procedure cbFontSizeChange(Sender: TObject);
  private
    { Private declarations }
    f_FreezeFont : Boolean;
  public
    { Public declarations }
    procedure EditorWindowFontChange(const Font: Il3Font);
      override;
      {-}
    procedure UpdateItems;
      override;
      {-}
    procedure CloseMDIChild(Form: TForm);
      override;
      {-}
  end;

implementation

uses
  l3Draw_TLB
  ;

{$R *.dfm}

procedure TMainExpressForm.EditorWindowFontChange(const Font: Il3Font);
var
 F : Il3FontInfo;
begin
 inherited;
 f_FreezeFont := true;
 try
  if l3IOk(Font.QueryInterface(Il3FontInfo, F)) then
   try
    cbFontName.Text := F.Name;
//    ColorComboBox.Selected := F.ForeColor;
//    BackColorComboBox.Selected := F.BackColor;
    cbFontSize.FontSize := F.Size;
   finally
    F := nil;
   end;{try..finally}
 finally
  f_FreezeFont := false;
 end;{try..finally}
end;

procedure TMainExpressForm.cbFontNameChange(Sender: TObject);
//var
// ActChild : TForm;
begin
 if not f_FreezeFont then begin
//  ActChild := ActiveMDIChild;
//  if (ActChild <> nil) then Windows.SetFocus(ActChild.Handle);
  if (ActiveEditor <> nil) then begin
   cbFontSize.FontName:= cbFontName.Text;
   ActiveEditor.Editor.TextPara.Font.Name := cbFontName.Text;
  end;{ActiveEditor <> nil}
 end;//not f_FreezeFont
end;

procedure TMainExpressForm.cbFontSizeChange(Sender: TObject);
var
 ActChild : TForm;
begin
 if not f_FreezeFont then begin
  ActChild := ActiveMDIChild;
  if ActChild <> nil then Windows.SetFocus(ActChild.Handle);
  if (ActiveEditor <> nil) then
   try
    ActiveEditor.Editor.TextPara.Font.Size := cbFontSize.FontSize;
   except
    EditorWindowFontChange(ActiveEditor.Editor.TextPara.Font);
   end;
 end;//not f_FreezeFont
end;

procedure TMainExpressForm.UpdateItems;
  //override;
  {-}
begin
 inherited;
 cbFontName.Enabled := true;
 ccFontSize.Enabled := true;
 cbFontSize.Enabled := true;
end;

procedure TMainExpressForm.CloseMDIChild(Form: TForm);
  //override;
  {-}
begin
 inherited;
 with liMDIChildren.Items do begin
  cbFontName.Enabled := (Count > 0);
  ccFontSize.Enabled := (Count > 0);
  cbFontSize.Enabled := (Count > 0);
 end;//with liMDIChildren.Items
end;

end.
