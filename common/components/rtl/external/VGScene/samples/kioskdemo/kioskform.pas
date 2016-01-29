unit kioskform;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_layouts, vg_controls, vg_objects, vg_effects,
  vg_listbox, vg_textbox;

type
  TfrmKiosk = class(TForm)
    kioskScene: TvgScene;
    kioskRoot: TvgScaledLayout;
    Layout1: TvgLayout;
    vgResources1: TvgResources;
    Rectangle1: TvgRectangle;
    Ellipse1: TvgEllipse;
    Ellipse2: TvgEllipse;
    Button2: TvgButton;
    Button3: TvgButton;
    Button4: TvgButton;
    Button5: TvgButton;
    Button6: TvgButton;
    Button7: TvgButton;
    Button8: TvgButton;
    Button9: TvgButton;
    Button10: TvgButton;
    Button11: TvgButton;
    Rectangle2: TvgRectangle;
    numberOut: TvgText;
    ShadowEffect1: TvgShadowEffect;
    Button12: TvgButton;
    Popup1: TvgPopup;
    Rectangle3: TvgRectangle;
    Text1: TvgText;
    Button1: TvgButton;
    Button13: TvgButton;
    ScrollBar1: TvgScrollBar;
    ScrollBar2: TvgScrollBar;
    TextBox1: TvgTextBox;
    CheckBox1: TvgCheckBox;
    RadioButton1: TvgRadioButton;
    StringListBox1: TvgStringListBox;
    CheckBox2: TvgCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FSaveBounds: TRect;
  end;

var
  frmKiosk: TfrmKiosk;

implementation

{$R *.dfm}

procedure TfrmKiosk.Button2Click(Sender: TObject);
begin
  numberOut.Text := numberOut.Text + TvgButton(Sender).Text;
end;

procedure TfrmKiosk.Button1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmKiosk.Button12Click(Sender: TObject);
begin
  Popup1.Popup;
end;

procedure TfrmKiosk.Button13Click(Sender: TObject);
begin
  MessagePopup('This is message', 'Some information', vgMessageInformation, [vgButtonOK], kioskScene, Rectangle2);
end;

procedure TfrmKiosk.CheckBox2Change(Sender: TObject);
begin
  if CheckBox2.IsChecked then
  begin
    FSaveBounds := frmKiosk.BoundsRect;
    frmKiosk.WindowState := wsMaximized;
    frmKiosk.BorderStyle := bsNone;
  end
  else
  begin
    frmKiosk.WindowState := wsNormal;
    frmKiosk.BorderStyle := bsSizeable;
    frmKiosk.BoundsRect := FSaveBounds;
  end
end;

end.
