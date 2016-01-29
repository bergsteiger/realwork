unit nd1_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, vg_controls, vg_listbox, vg_layouts,
  OvcBase, afwControlPrim, afwBaseControl, afwControl, nevControl,
  evCustomEditorWindowPrim, evEditorWindow, evCustomEditorWindowModelPart,
  evMultiSelectEditorWindow, evCustomEditorModelPart, evCustomEditor,
  evEditorWithOperations, evCustomMemo, evCustomEdit, elCustomEdit,
  elCustomButtonEdit, ctButtonEdit, ctAbstractEdit, AbstractDropDown, DropDownTree,
  nscTreeComboWithHistory, nscTreeComboWithHistoryAndOperations;

type
  TForm1 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Rectangle1: TvgRectangle;
    Rectangle2: TvgRectangle;
    vgResources1: TvgResources;
    CloseButton1: TvgCloseButton;
    RadioButton1: TvgRadioButton;
    RadioButton2: TvgRadioButton;
    RadioButton3: TvgRadioButton;
    RadioButton4: TvgRadioButton;
    RadioButton5: TvgRadioButton;
    Layout1: TvgLayout;
    Layout2: TvgLayout;
    NonVGLayout1: TvgNonVGLayout;
    nscTreeComboWithHistoryAndOperations1: TnscTreeComboWithHistoryAndOperations;
    Button2: TvgButton;
    Path1: TvgPath;
    Layout3: TvgLayout;
    Text1: TvgText;
    Text2: TvgText;
    PathButton1: TvgPathButton;
    PathButton2: TvgPathButton;
    docSetCombo: TvgComboBox;
    procedure FormShow(Sender: TObject);
    procedure PathButton1Click(Sender: TObject);
  private
   { Private declarations }
   procedure AddListItem(const aCaption: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.AddListItem(const aCaption: string);
var
 l_Item: TvgListBoxItem;
begin
 l_Item := TvgListBoxItem.Create(nil);
 l_Item.Parent := docSetCombo.ListBox;
 l_Item.Resource := 'docSetElementStyle';
 l_Item.Binding['text'] := aCaption;
 l_Item.Font.Size := 12;
 l_Item.Font.Family := 'Arial';
 //l_Item.Font.Style := vgFontBold;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 docSetCombo.ListBox.Resource := 'docSetComboListStyle';
 AddListItem('Везде');
 AddListItem('Список: в документах');
 AddListItem('Список: в названиях');
 docSetCombo.ItemIndex := 0;
 FocusControl(vgScene1);
end;

procedure TForm1.PathButton1Click(Sender: TObject);
begin
 docSetCombo.Clear;
 AddListItem('Раз!');
 AddListItem('Два!');
 AddListItem('Три!');
 docSetCombo.ItemIndex := 0;
end;

end.