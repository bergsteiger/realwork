unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  vg_scene, vg_controls, vg_treeview, vg_objects, vgTypes,
  vg_effects, vg_layouts, vgCustomResources, vgComponent, vgCustomObject,
  vgCustomControl, vtVGSceneRes ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Popup1: TvgPopup;
    bMakeRTPopup: TButton;
    Label1: TvgLabel;
    Resources1: TvgResources;
    CalloutPanel1: TvgCalloutPanel;
    NonVGLayout1: TvgNonVGLayout;
    Label2: TvgLabel;
    Panel1: TPanel;
    NonVGLayout2: TvgNonVGLayout;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure bMakeRTPopupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  l_BackGround: TvgBackGround;
  l_Scene: TvgScene;
  l_Popup: TvgPopup;
  l_Path: TvgCalloutPanel;
  l_TvgText: TvgText;
begin
  l_BackGround := TvgBackGround.Create(Self);
  with l_BackGround do
  begin
    Fill.Style := vgBrushSolid;
  end;

  l_Scene := TvgScene.Create(Self);
  with l_Scene do
  begin
   Parent := Self;
   AddObject(l_BackGround);
   Style := vtVGSceneResources.vgResources;
  end;

  l_Popup := TvgPopup.Create(l_Scene);
  with l_Popup do
  begin
   Parent := TvgObject(l_Scene.Root);
   SetBounds(50, 70, 300, 100);
   PlacementTarget := l_BackGround;
   StaysOpen := True;
   DragWithParent := False;
  end;

  l_Path := TvgCalloutPanel.Create(l_Popup);
  with l_Path do
  begin
   Parent := TvgObject(l_Popup);
   Resource := cCalloutPanelStyleLayoutName;
   Align := vaClient;
   CalloutPosition := vgCalloutLeft;
   CalloutWidth := 15;
   CalloutLength := 15;
  end;

  l_TvgText := TvgText.Create(l_Path);
  with l_TvgText do
  begin
    Parent := l_Path;
    Align := vaCenter;
    Position.X := 7;
    Position.Y := 40;
    Width := 146;
    Height := 83;
    Fill.Color := '#FFEAEAEA';
    Text := 'Hello Word!'
  end;

  l_Popup.IsOpen  := True;
end;

procedure TForm1.bMakeRTPopupClick(Sender: TObject);
var
  l_BackGround: TvgBackGround;
  l_Scene: TvgScene;
  l_Popup: TvgPopup;
  l_Path: TvgCalloutPanel;
  l_NonVGLayout: TvgNonVGLayout;
  l_MainPanel: TPanel;
  l_Label: TvgLabel;
begin
  l_MainPanel := TPanel.Create(Self);
  l_MainPanel.Parent := Self;
  l_MainPanel.Align := alClient;

  l_BackGround := TvgBackGround.Create(Self);
  with l_BackGround do
  begin
    Width := 589;
    Height := 237;
  end;

  l_Scene := TvgScene.Create(Self);
  with l_Scene do
  begin
   Parent := l_MainPanel;
   Left := 28;
   Top := 12;
   Width := 589;
   Height := 237;
   Style := Resources1;
   AddObject(l_BackGround);
  end;

  l_Popup := TvgPopup.Create(Self);
  with l_Popup do
  begin
   Parent := l_BackGround;
   Position.X := 52;
   Position.Y := 41;
   Width := 276;
   Height := 162;
   TabOrder := 1;
   IsOpen := False;
   PlacementTarget := l_BackGround;
  end;

  l_Path := TvgCalloutPanel.Create(Self);
  with l_Path do
  begin
   Parent := l_Popup;
   Position.X := 16;
   Position.Y := 25;
   Width := 249;
   Height := 128;
   TabOrder := 0;
   CalloutWidth := 23;
   CalloutLength := 11;
  end;

  l_NonVGLayout := TvgNonVGLayout.Create(Self);
  with l_NonVGLayout do
  begin
   Parent := l_Path;
   Position.X := 135;
   Position.Y := 30;
   Width := 100;
   Height := 86;
   NonVGControl := Panel1;
  end;

  l_Label := TvgLabel.Create(Self);
  with l_Label do
  begin
   Parent := l_Path;
   Position.X := 43;
   Position.Y := 43;
   Width := 120;
   Height := 56;
   TabOrder := 2;
   TextAlign := vgTextAlignCenter;
   VertTextAlign := vgTextAlignCenter;
   Text := 'Label12345678901234567890';
  end;

  l_Popup.IsOpen  := True;
end;

end.
