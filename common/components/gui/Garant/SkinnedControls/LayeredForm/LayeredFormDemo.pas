unit LayeredFormDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, LayeredForm , vcmEntityForm, vtPanel,
  l3InterfacedComponent, vcmComponent, vcmBaseEntities, vcmBaseMenuManager,
  vcmMenuManager, vcmMainForm, DataModule;

type
  TMainForm = class(TvcmMainForm)
   Button1: TButton;
   vcmMenuManager1: TvcmMenuManager;
   procedure Button1Click(Sender: TObject);
  protected
   procedure RegisterModules; override;
  private
    { Private declarations }
  end;

var
  MainForm: TMainForm;

implementation
Uses MyEntity;
{$R *.dfm}

procedure TMainForm.RegisterModules;
begin
// в этом примере что-то регистрируется неверно ... выскакивает ошибка
// inherited;
// RegisterModule(TmoDocument);
end;

procedure TMainForm.Button1Click(Sender: TObject);
var
 l_LayeredForm: TLayeredForm;
 l_Panel: TvtPanel;
 l_BitBtn: TBitBtn;
 l_Shape: TShape;
 l_Form: TMyEntityForm;
 l_Memo: TMemo;
const
 cWarningMessageColor = $F6E1D2;
begin
 l_LayeredForm := TLayeredForm.CreateNew(Self);
 l_LayeredForm.Color := cTransparentColor;
 l_LayeredForm.SetBounds(100, 300, 600, 100);
 l_LayeredForm.Font.Size := 11;

 l_Shape := TShape.Create(l_LayeredForm);
 l_Shape.Parent := l_LayeredForm;
 l_Shape.Shape  := stRoundRect;
 l_Shape.Align := alClient;
 l_Shape.Brush.Color := cWarningMessageColor;

 l_BitBtn := TBitBtn.Create(l_LayeredForm);
 l_BitBtn.Parent := l_LayeredForm;
 l_BitBtn.SetBounds(480, 60, 100, 30);
 l_BitBtn.Kind := bkClose;

 l_Panel := TvtPanel.Create(l_LayeredForm);
 l_Panel.Parent := l_LayeredForm;
 l_Panel.ParentColor := True;
 l_Panel.Color := cWarningMessageColor;
 l_Panel.SetBounds(10, 10, 460, 80);
 l_Panel.BevelOuter := bvLowered;
 l_Panel.DockSite := True;

 l_LayeredForm.Show;

 l_Form := TMyEntityForm.CreateNew(Self);

 l_Memo := TMemo.Create(l_Form);
 l_Memo.Parent := l_Form;
 l_Memo.Align  := alClient;
 l_Memo.Lines.Add('Hello World');

 l_Form.Show;
 l_Form.ManualDock(l_Panel, nil, alClient);
end;

end.
