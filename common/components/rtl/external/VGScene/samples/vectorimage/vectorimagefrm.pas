unit vectorimagefrm;

interface

uses
  {$IFDEF FPC}
  LResources,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, StdCtrls, vg_ani, vg_effects,
  vg_controls, vg_layouts, vg_textbox;

type
  TfrmVectorImage = class(TForm)
    vgScene1: TvgScene;
    VectorImageRoot: TvgBackground;
    LionRoot: TvgPanel;
    Flowroot: TvgPanel;
    Text1: TvgLabel;
    Text2: TvgLabel;
    Text3: TvgLabel;
    TextBox1: TvgTextBox;
    Flow: TvgPath;
    Text4: TvgLabel;
    Text5: TvgLabel;
    Button1: TvgButton;
    vgResources1: TvgResources;
    Lion: TvgScaledLayout;
    procedure FlowrootMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TvgPoint; var Handled: Boolean);
    procedure LionRootMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TvgPoint; var Handled: Boolean);
    procedure TextBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVectorImage: TfrmVectorImage;
  
implementation

uses vg_dsgn;

{$R *.dfm}

procedure TfrmVectorImage.FlowrootMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TvgPoint;
  var Handled: Boolean);
begin
  if (WheelDelta < 0) and (Lion.Width < 4) then Exit;

  Flow.Width := Flow.Width + (WheelDelta * 0.001 * Flow.Width);
  Flow.Height := Flow.Height + (WheelDelta * 0.001 * Flow.Height);
  FlowRoot.Realign;
end;

procedure TfrmVectorImage.LionRootMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TvgPoint;
  var Handled: Boolean);
begin
  if (WheelDelta < 0) and (Lion.Width < 4) then Exit;

  Lion.Width := Lion.Width + (WheelDelta * 0.001 * Lion.Width);
  Lion.Height := Lion.Height + (WheelDelta * 0.001 * Lion.Height);
  LionRoot.Realign;
end;

procedure TfrmVectorImage.TextBox1Change(Sender: TObject);
begin
  Flow.Data.Data := TextBox1.Text;
end;

procedure TfrmVectorImage.Button1Click(Sender: TObject);
begin
  SelectInDesign(Flow.Fill, Flow);
end;

end.
