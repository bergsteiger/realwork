unit messagepopupfrm;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_listbox, vg_controls, vg_scene, vg_objects, vg_layouts;

type
  TfrmMessagePopup = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    ToolBar1: TvgToolBar;
    Label1: TvgLabel;
    msgType: TvgStringListBox;
    Label2: TvgLabel;
    ResultList: TvgStringListBox;
    CheckBox1: TvgCheckBox;
    CheckBox2: TvgCheckBox;
    CheckBox3: TvgCheckBox;
    CheckBox4: TvgCheckBox;
    CheckBox5: TvgCheckBox;
    Label3: TvgLabel;
    StyleBox: TvgPopupBox;
    ModernStyle: TvgResources;
    VistaStyle: TvgResources;
    AirStyle: TvgResources;
    ToolButton1: TvgToolButton;
    ToolButton2: TvgToolButton;
    MessagePopup1: TvgMessagePopup;
    Label4: TvgLabel;
    Rectangle1: TvgRectangle;
    Button1: TvgButton;
    Panel1: TvgPanel;
    Label5: TvgLabel;
    procedure ToolButton1Click(Sender: TObject);
    procedure StyleBoxChange(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMessagePopup: TfrmMessagePopup;

implementation

{$R *.dfm}

procedure TfrmMessagePopup.ToolButton1Click(Sender: TObject);
var
  Res: TModalResult;
  Btns: TvgMessageButtons;
  Typ: TvgMessageType;
begin
  Btns := [];
  if CheckBox1.IsChecked then Btns := Btns + [vgButtonYes];
  if CheckBox2.IsChecked then Btns := Btns + [vgButtonNo];
  if CheckBox3.IsChecked then Btns := Btns + [vgButtonOk];
  if CheckBox4.IsChecked then Btns := Btns + [vgButtonCancel];
  if CheckBox5.IsChecked then Btns := Btns + [vgButtonAbort];
  Typ := TvgMessageType(msgType.ItemIndex);

  Res := MessagePopup('This is a message popup caption',
    'Graphical editor integrated in IDE, graphical objects, simplify animation, advanced windows and controls, maximum performance, skinning engine, bitmap effects.',
    Typ,
    Btns,
    vgScene1,        
    Toolbar1,
    true);

  ResultList.ItemIndex := Integer(Res);
end;

procedure TfrmMessagePopup.StyleBoxChange(Sender: TObject);
begin
  case StyleBox.ItemIndex of
    0: vgScene1.Style := nil;
    1: vgScene1.Style := ModernStyle;
    2: vgScene1.Style := VistaStyle;
    3: vgScene1.Style := AirStyle;
  end;
end;

procedure TfrmMessagePopup.ToolButton2Click(Sender: TObject);
begin
  MessagePopup1.PopupModal;
end;

end.
