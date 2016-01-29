unit VirtMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ElXPThemedControl, ElTree, ExtCtrls, ElStrUtils, StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Tree: TElTree;
    AmountEdit: TEdit;
    AddItemsBtn: TButton;
    ClearBtn: TButton;
    procedure TreeVirtualHintNeeded(Sender: TObject; Item: TElTreeItem;
      var Hint: TElFString);
    procedure TreeVirtualTextNeeded(Sender: TObject; Item: TElTreeItem;
      SectionIndex: Integer; var Text: TElFString);
    procedure TreeVirtualPropsNeeded(Sender: TObject; Item: TElTreeItem;
      PropTypes: TElVirtPropTypes; Value: TElTreeItemStaticDataEx);
    procedure AddItemsBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.TreeVirtualHintNeeded(Sender: TObject;
  Item: TElTreeItem; var Hint: TElFString);
begin
  Hint := 'This is the hint for item ' + IntToStr(Item.Tag);
end;

procedure TForm1.TreeVirtualTextNeeded(Sender: TObject;
  Item: TElTreeItem; SectionIndex: Integer; var Text: TElFString);
begin
  Text := 'Item ' + IntToStr(Item.Tag);
end;

procedure TForm1.TreeVirtualPropsNeeded(Sender: TObject;
  Item: TElTreeItem; PropTypes: TElVirtPropTypes;
  Value: TElTreeItemStaticDataEx);
begin
  // The values being set below are shown as an example of what parameters
  // should be set when some flag is present in PropTypes
  if vptStyles in PropTypes then
    Value.UseStyles  := false;
  if vptFontStyle in PropTypes then
  begin
    Value.ParentFontStyle := true;
    // the following settings are not necessary as ParentFontStyle = true.
    // they are just an example of what should be set in response to each flag
    Value.Cut := false;
    Value.Bold := false;
    Value.Italic := false;
    Value.Underlined := false;
    Value.Strikeout := false;
  end;
  if vptVisual in PropTypes then
  begin
    Value.SuppressLines := false;
    Value.DrawHLine := false;
  end;
  if vptIndent in PropTypes then
    Value.IndentAdjust := 0;
  if vptEdit in PropTypes then
    Value.AllowEdit := true;
  if vptHTML in PropTypes then
    Value.HintIsHTML := false;

  if vptCheck in PropTypes then
  begin
    Value.ShowCheckBox := true;
    Value.CheckBoxState := cbChecked;
  end;
  if vptButtons in PropTypes then
  begin
    Value.ForceButtons := false;
    Value.SuppressButtons := false;
  end;
  if vptImages in PropTypes then
  begin
    Value.ImageIndex := -1;
    Value.ImageIndex2 := -1;
    Value.StImageIndex := -1;
    Value.StImageIndex2 := -1;
    Value.OverlayIndex := -1;
    Value.OverlayIndex2 := -1;
  end;
  if vptColors in PropTypes then
  begin
    Value.ParentColors := true;
  end;
end;

type THackItem = class(TElTreeItem);

procedure TForm1.AddItemsBtnClick(Sender: TObject);
var i,
    j, k : integer;
    tick : Cardinal;
begin
  i := StrToIntDef(AmountEdit.Text, -1);
  if i > -1 then
  begin
    tick := GetTickCount;
    Tree.IsUpdating := true;
    k := Tree.Items.Count;
    Tree.Items.AllocateStorage(i + k);
    Tree.Items.AllocateStorageInRoot(i + k);
    for j := 0 to i - 1 do
    begin
      with Tree.Items.AddLastItem(nil) do
        Tag := j + k;
    end;
    Tree.IsUpdating := false;
    tick := GetTickCount - tick;
    MessageBox(0, PChar('Items added in ' + IntToStr(tick) + ' msec'), nil, 0);

  end
  else
  begin
    MessageBox(0, 'Please enter positive number of items to add', nil, 0);
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Tree.VirtualityLevel := vlAllProps;
end;

procedure TForm1.ClearBtnClick(Sender: TObject);
var tick: Cardinal;
begin
  tick := GetTickCount;
  Tree.Items.Clear;
  tick := GetTickCount - tick;
  MessageBox(0, PChar('Tree cleared in ' + IntToStr(tick) + ' msec'), nil, 0);
end;

end.

