unit NewBaseSearch_Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, vg_controls, vg_listbox, vg_layouts,
  OvcBase, afwControlPrim, afwBaseControl, afwControl, nevControl,
  evCustomEditorWindowPrim, evEditorWindow, evCustomEditorWindowModelPart,
  evMultiSelectEditorWindow, evCustomEditorModelPart, evCustomEditor,
  evEditorWithOperations, evCustomMemo, evCustomEdit, elCustomEdit,
  elCustomButtonEdit, ctButtonEdit, ctAbstractEdit, AbstractDropDown, DropDownTree,
  nscTreeComboWithHistory, nscTreeComboWithHistoryAndOperations, nscCustomTreeComboWithHistory,

  NewBaseSearchForDFM_Form, l3InterfacedComponent, vcmComponent,
  vcmBaseEntities, vcmEntities, vgComponent, vgCustomResources,
  vgCustomObject, vgCustomControl, vg_effects, vgEffect, vgObject,
  vgVisualObject, vgScenePrim, vcmExternalInterfaces, evCustomEditorWindow
  ;

type
  TNewBaseSearchForm = class(TvcmEntityFormRef)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Rectangle1: TvgRectangle;
    BottomMargin: TvgRectangle;
    MostOuterRectangle: TvgRectangle;
    vgResources1: TvgResources;
    CloseBtn: TvgCloseButton;
    AreaCombo: TvgComboBox;
    Layout1: TvgLayout;
    Layout2: TvgLayout;
    ContextEditPanel: TvgNonVGLayout;
    ContextEdit: TnscTreeComboWithHistoryAndOperations;
    DropButton: TvgButton;
    Path1: TvgPath;
    ExampleLabel: TvgText;
    QueryExampleLabel: TvgText;
    FoundCountLabel: TvgText;
    FindBtn: TvgPathButton;
    FindBackBtn: TvgPathButton;
    Entities: TvcmEntities;
    Layout3: TvgLayout;
    Line1: TvgLine;
    MoreTab: TvgComboBox;
    GlowEffect1: TvgGlowEffect;
    GlowEffect2: TvgGlowEffect;
    Border: TvgRectangle;
    InnerBorder: TvgRectangle;
    procedure CloseBtnClick(Sender: TObject);
    procedure FindBtnClick(Sender: TObject);
    procedure AreaComboChange(Sender: TObject);
    procedure FindBackBtnClick(Sender: TObject);
    procedure DropButtonClick(Sender: TObject);
    procedure QueryExampleLabelClick(Sender: TObject);
    procedure QueryExampleLabelKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure vcmEntityFormRefCreate(Sender: TObject);
    { При создании формы БП восстанавливаем ширину выпадающего списка }
  private
    procedure OnContextEditCloseUp(Sender: TObject);
    { При закрытии нужно запоминать ширину выпадающего списка }
  protected
    procedure InitControls; override;
  public
    { Public declarations }
  end;//TNewBaseSearchForm

implementation

{$R *.dfm}

uses
  BaseSearchInterfaces,
  l3Defaults
  ;

procedure TNewBaseSearchForm.CloseBtnClick(Sender: TObject);
begin
 DoCloseBtnClick;
end;

procedure TNewBaseSearchForm.FindBtnClick(Sender: TObject);
begin
 DoFindBtnClick;
end;

procedure TNewBaseSearchForm.AreaComboChange(Sender: TObject);
begin
 if (AreaCombo.ItemIndex >= Ord(Low(TnsSearchArea))) AND
    (AreaCombo.ItemIndex <= Ord(High(TnsSearchArea))) then
  UpdateSearcherArea(TnsSearchArea(AreaCombo.ItemIndex),
                     f_BaseSearcher.WindowData.ContextKind);
end;

procedure TNewBaseSearchForm.FindBackBtnClick(Sender: TObject);
begin
 DoFindBackBtnClick;
end;

procedure TNewBaseSearchForm.DropButtonClick(Sender: TObject);
var
 l_ContextEditPos : TPoint;
 l_DropButtonPos : TPoint;
 l_P : TvgPoint;
 l_MinDropDownWidth : Integer;
begin
 // ширина выпадающего списка имеет ограничения как сверху, так и снизу
 // http://mdp.garant.ru/pages/viewpage.action?pageId=273598933
 l_ContextEditPos := ContextEdit.ClientToScreen(Point(0, 0));
 l_P := DropButton.LocalToAbsolute(vgPoint(0, 0));
 l_DropButtonPos := vgScene1.ClientToScreen(Point(Trunc(l_P.X), Trunc(l_P.Y)));
 l_MinDropDownWidth := l_DropButtonPos.X + Trunc(DropButton.Width) - l_ContextEditPos.X;
 if ContextEdit.Tree is TnscSubTree then
  with TnscSubTree(ContextEdit.Tree) do
  begin
   CustomMinSizeX := l_MinDropDownWidth;
  end;
 if (ContextEdit.DropWidth < l_MinDropDownWidth) then
  ContextEdit.DropWidth := l_MinDropDownWidth;
 if ContextEdit.CanFocus then
  ContextEdit.SetFocus;
 ContextEdit.Button.Click;
 DropButton.IsPressed := ContextEdit.Dropped;
end;

procedure TNewBaseSearchForm.QueryExampleLabelClick(Sender: TObject);
begin
 ApplyCurrentExample;
end;

procedure TNewBaseSearchForm.QueryExampleLabelKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
begin
 if (KeyChar = #32) then
 begin
  ApplyCurrentExample;
  KeyChar := #0;
 end;//KeyChar = #32
end;

var
  // ширину выпадающего списка для ContextEdit храним в глобальной переменной
  // для синхронизации размеров у разных объектов БП
  g_ContextEditDropWidth: Integer = 0;

procedure TNewBaseSearchForm.vcmEntityFormRefCreate(Sender: TObject);
begin
 ContextEdit.DropWidth := g_ContextEditDropWidth;
 ContextEdit.KeepLastDropWidth := True;
 ContextEdit.OnCloseUp := OnContextEditCloseUp;
end;

procedure TNewBaseSearchForm.OnContextEditCloseUp(Sender: TObject);
begin
 g_ContextEditDropWidth := ContextEdit.DropWidth;
end;

procedure TNewBaseSearchForm.InitControls;
begin
 inherited;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=361399733 
 if ContextEdit.Tree is TnscSubTree then
  with TnscSubTree(ContextEdit.Tree) do
  begin
   HotTrackColor := cGarant2011GradientEndColor;
   YandexLikeBehaviour := True;
  end;
end;

end.