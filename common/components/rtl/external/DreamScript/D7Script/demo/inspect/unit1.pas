{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ComCtrls, ExtCtrls, oinspect, Grids, dcstdctl,
  dcgen, Menus,dcreg;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    ListBox1: TListBox;
    ComboBox1: TComboBox;
    ScrollBar1: TScrollBar;
    GroupBox1: TGroupBox;
    RadioButton2: TRadioButton;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TDCSplitter;
    SelBox: TListBox;
    Button3: TButton;
    PageControl2: TPageControl;
    Properties: TTabSheet;
    Events: TTabSheet;
    Panel3: TPanel;
    RadioVB: TRadioButton;
    RadioDelphi: TRadioButton;
    CheckAliases: TCheckBox;
    CheckGroups: TCheckBox;
    HeaderControl1: THeaderControl;
    PropertyList: TObjectInspector;
    EventList: TObjectInspector;
    PopupMenu1: TPopupMenu;
    procedure ButtonSetClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckAliasesClick(Sender: TObject);
    procedure CheckGroupsClick(Sender: TObject);
    procedure HeaderControl1SectionResize(HeaderControl: THeaderControl;
      Section: THeaderSection);
    procedure HeaderControl1SectionTrack(HeaderControl: THeaderControl;
      Section: THeaderSection; Width: Integer; State: TSectionTrackState);
    procedure EventListSplitterMoving(Sender: TObject; X: Integer);
    procedure PropertyListComponentChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PropertyListGetCellParams(Sender: TObject;
      PropEdit: TDCDsgnProperty; Column: Integer; Font: TFont);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
const
  RegistrationURL = 'http://www.nstarsolutions.com/987.htm';

{$R *.DFM}

procedure TForm1.ButtonSetClick(Sender: TObject);
var i : integer;
    clist : TList;
begin
  clist := TList.Create;
  try
    with SelBox do
      for i := 0 to SelBox.Items.Count - 1 do
        if Selected[i] then
          clist.Add(TControl(Items.Objects[I]));

    PropertyList.SetControls(clist);
    EventList.SetControls(clist);
  finally
    clist.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var i : integer;
begin
  for i := 0 to Selbox.Items.Count - 1 do
    Selbox.Selected[i] := false;
  PropertyList.CurrentControl := nil;
  EventList.CurrentControl := nil;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  if RadioDelphi.Checked then
    begin
      PropertyList.Style := isDelphi;
      EventList.Style := isDelphi;
    end
  else
    begin
      PropertyList.Style := isVB;
      EventList.Style := isVB;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i : integer;
begin
  EventList.FixedColWidth:=PropertyList.FixedColWidth;
  for i := 0 to ComponentCount - 1 do
   SelBox.Items.AddObject(Components[i].ClassName, Components[i]);
  PageControl1.ActivePage := TabSheet1;
  EventList.Style := isDelphi;
  PropertyList.Style := isDelphi;
  EventList.Options := EventList.Options + [oiUseGroups];
  PropertyList.Options := PropertyList.Options + [oiUseGroups];
  HeaderControl1.Sections[0].Width := EventList.FixedColWidth + 2;
  if SelBox.Items.Count > 0 then
  begin
    SelBox.Selected[0] := true;
    ButtonSetClick(Self);
  end;
  PageControl1.ActivePage := TabSheet1;

  RecreateWnd;
end;

procedure TForm1.CheckAliasesClick(Sender: TObject);
begin
  if CheckAliases.Checked then
    PropertyList.Options := PropertyList.Options + [oiUseAliases]
  else
    PropertyList.Options := PropertyList.Options - [oiUseAliases]
end;

procedure TForm1.CheckGroupsClick(Sender: TObject);
begin
  if CheckGroups.Checked then
  Begin
    PropertyList.Options := PropertyList.Options + [oiUseGroups];
    EventList.Options := EventList.Options + [oiUseGroups];
  End
  else
  Begin
    PropertyList.Options := PropertyList.Options - [oiUseGroups];
    EventList.Options := EventList.Options - [oiUseGroups];
  End
end;

procedure TForm1.HeaderControl1SectionResize(
  HeaderControl: THeaderControl; Section: THeaderSection);
begin
  EventList.FixedColWidth := HeaderControl1.Sections[0].Width - 2;
end;

procedure TForm1.HeaderControl1SectionTrack(
  HeaderControl: THeaderControl; Section: THeaderSection; Width: Integer;
  State: TSectionTrackState);
begin
  EventList.FixedColWidth := Width - 2;
end;

procedure TForm1.EventListSplitterMoving(Sender: TObject; X: Integer);
begin
  HeaderControl1.Sections[0].Width := X + 2;
  If Sender=PropertyList then
    EventList.FixedColWidth:=X
  else
    PropertyList.FixedColWidth:=X;
end;

procedure TForm1.PropertyListComponentChanged(Sender: TObject);
var
  index : integer;
  i     : integer;
begin
  index := -1;
  for i := 0 to SelBox.Items.Count - 1 do
    if SelBox.Items.Objects[i] = PropertyList.CurrentControl then
      begin
        index := i;
        break;
      end;

  if index <> -1 then
    if not SelBox.Selected[index] then
      with SelBox do
        for i := 0 to SelBox.Items.Count - 1 do
          Selected[i] := i = index;

  SelBox.ItemIndex := index;
end;

{------------------------------------------------------------------}

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Designer := nil;
end;

{------------------------------------------------------------------}

procedure TForm1.PropertyListGetCellParams(Sender: TObject;
  PropEdit: TDCDsgnProperty; Column: Integer; Font: TFont);
begin
  if Assigned(propedit) and (propedit.GetName = 'Caption') then
    Font.Color := clGreen;
end;

{------------------------------------------------------------------}

end.
