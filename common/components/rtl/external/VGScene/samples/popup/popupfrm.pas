unit popupfrm;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_objects, vg_controls, vg_scene, vg_effects, vg_ani,
  vg_listbox, vg_layouts;

type
  TfrmPopup = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Popup1: TvgPopup;
    Path1: TvgCalloutPanel;
    Text1: TvgText;
    Text2: TvgText;
    RoundRect1: TvgRoundRect;
    RoundRect2: TvgRoundRect;
    HudStringListBox1: TvgHudStringListBox;
    ShadowEffect1: TvgShadowEffect;
    ShadowEffect2: TvgShadowEffect;
    Text4: TvgText;
    Text3: TvgText;
    Text5: TvgText;
    Popup3: TvgPopup;
    CalloutRect1: TvgCalloutPanel;
    ShadowEffect4: TvgShadowEffect;
    Text6: TvgText;
    ContextPopup: TvgPopup;
    CalloutRect2: TvgCalloutPanel;
    ShadowEffect6: TvgShadowEffect;
    procedure RoundRect1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure RoundRect2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPopup: TfrmPopup;

implementation

{$R *.dfm}

procedure TfrmPopup.RoundRect1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Popup1.IsOpen := not Popup1.IsOpen;
end;

procedure TfrmPopup.RoundRect2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Popup3.IsOpen := true;
end;

end.
