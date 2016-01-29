{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcstrled;
{.$I dc.inc}
{$I dcprod.inc}
interface


uses
  dcsystem,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  ExtCtrls, dcdreamlib, dcedit, Buttons, dccommon, dcgen, dcconsts, consts, comctrls
  {$IFDEF D3} ,checklst {$ENDIF};

type
  TStringsEditForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    CodeButton: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel3: TPanel;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    Panel4: TPanel;
    OpenButton: TSpeedButton;
    SaveButton: TSpeedButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    procedure Memo1Change(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CodeButtonClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    FEditObject:TComponent;
    FNeedCodeEditor:boolean;
    procedure SetEditObject(Value:TComponent);
    procedure LoadFontStyles;
    procedure SaveFontStyles;
  public
    EditName : string;
    EditProp:string;
    procedure EditInCodeEditor;
    procedure ShowNumberOfLines;
    property EditObject:TComponent Read FEditObject Write SetEditObject;
    property NeedCodeEditor:boolean Read FNeedCodeEditor;
  end;

var
  StringsEditForm: TStringsEditForm;

type
  TStringListEdit = class(TPropertyEditor)
  public
    function  GetAttributes : TPropertyAttributes; override;
    function  GetValue : string; override;
    procedure Edit; override;
  end;

  THintPropertyEdit = class(TStringProperty)
  public
    function  GetAttributes : TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TCaptionPropertyEdit = class(TCaptionProperty)
  public
    function  GetAttributes : TPropertyAttributes; override;
    procedure Edit; override;
  end;

function  EditStrings(Strings: TStrings; const ACaption: String): boolean;

const
  SStringsEditForm = 'StringsEditForm'; //don't resource
  SFontName = 'FontName'; //don't resource
  SFontSize = 'FontSize'; //don't resource

implementation

{------------------------------------------------------------------}

procedure TStringsEditForm.EditInCodeEditor;
begin
  BroadcastToNotifiers(self,CM_EDITTEXTPROP,Integer(EditObject),Integer(EditProp));
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.SetEditObject(Value:TComponent);
begin
  FEditObject:=Value;

  CodeButton.Enabled:=
  {$IFDEF DREAMMEMO}
    (FEditObject<>nil) and (not UnderDelphiIDE);
  {$ELSE}
    False;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.LoadFontStyles;
var
  KeyStr: string;
  Idx: integer;
begin
  KeyStr := SFormRegPrefix + SStringsEditForm + '\';
  with ComboBox1 do
  begin
    Idx := Items.IndexOf(ReadFromRegistry(KeyStr + SFontName, 'Arial'));
    if Idx >= 0 then
    begin
      ItemIndex := Idx;
      Memo1.Font.Name := Text;
    end;
  end;
  with ComboBox2 do
  begin
    Idx := Items.IndexOf(ReadFromRegistry(KeyStr + SFontSize, 10));
    if Idx >= 0 then
    begin
      ItemIndex := Idx;
      Memo1.Font.Size := StrToInt(Text);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.SaveFontStyles;
var
  KeyStr: string;
begin
  KeyStr := SFormRegPrefix + SStringsEditForm + '\';
  WriteToRegistry(KeyStr + SFontName, Memo1.Font.Name);
  WriteToRegistry(KeyStr + SFontSize, Memo1.Font.Size);
end;

{------------------------------------------------------------------}

function TStringListEdit.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly, paMultiSelect];
end;

{------------------------------------------------------------------}

function TStringListEdit.GetValue: string;
begin
  result := '(' + GetPropType^.Name + ')';
end;

{------------------------------------------------------------------}

procedure TStringListEdit.Edit;
var
  Comp: TPersistent;
  i: integer;
begin
  with TStringsEditForm.Create(Application) do
    try
      LoadFontStyles;
      Comp := GetComponent(0);
      if Comp is TComponent then
        EditName := TComponent(Comp).Name + '.' + GetName
      else
        EditName := GetName;
      memo1.lines.Assign(TStrings(GetOrdValue));
      ShowNumberOfLines;
      if Comp is TComponent then
      begin
        Editobject:=TComponent(Comp);
        EditProp:=GetName;
      end;
      if ShowModal = idOk then
      begin
        for i := 0 to PropCount - 1 do
          TStrings(GetOrdValueAt(i)).Assign(memo1.lines);
        if memo1.Modified then
          DesignerModified(Comp);
        If NeedCodeEditor then
          EditInCodeEditor;
      end;
      SaveFontStyles;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

function  EditStrings(Strings:TStrings; const ACaption:String) : boolean;
begin
  with TStringsEditForm.Create(Application) do
    try
      CodeButton.Enabled := false;
      memo1.lines.Assign(Strings);
      EditName := ACaption;
      ShowNumberOfLines;
      result := (ShowModal = idOk);
      if result  then
        Strings.Assign(memo1.lines);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

function  THintPropertyEdit.GetAttributes : TPropertyAttributes;
begin
  Result:=Inherited GetAttributes;
  Result:=Result+[padialog];
end;

{------------------------------------------------------------------}

function  TCaptionPropertyEdit.GetAttributes : TPropertyAttributes;
begin
  Result:=Inherited GetAttributes;
  Result:=Result+[padialog];
end;

{------------------------------------------------------------------}

type
  THack=class(TPropertyEditor);

procedure CommonEditMethod(PropEdit:TPropertyEditor);
var
  s    : string;
  Comp : TPersistent;
  Form : TStringsEditForm;
begin
  Form:=TStringsEditForm.Create(Application);
  with Form,THack(Propedit) do
    try
      LoadFontStyles;
      Comp := GetComponent(0);
      if Comp is TComponent then
        EditName := TComponent(Comp).Name + '.' + GetName
      else
        EditName := GetName;

      memo1.text := GetStrValue;
      ShowNumberOfLines;
      If Comp is TComponent then
      begin
        Editobject:=TComponent(Comp);
        EditProp:=GetName;
      end;
      if ShowModal = idOk then
        begin
          s := Memo1.Text;
          if (s <> '') and (s[length(s)] = #10) then
            Delete(s, length(s) - 1, 2);

          SetStrValue(s);
          if memo1.Modified then
            DesignerModified(Comp);

          If NeedCodeEditor then
            EditInCodeEditor;
        end;
      SaveFontStyles;
    finally
      Form.Free;
    end;
end;

{------------------------------------------------------------------}

procedure THintPropertyEdit.Edit;
begin
  CommonEditMethod(Self);
end;
{------------------------------------------------------------------}

procedure TCaptionPropertyEdit.Edit;
begin
  CommonEditMethod(Self);
end;

{******************************************************************}

{$R *.DFM}

{------------------------------------------------------------------}

procedure TStringsEditForm.ShowNumberOfLines;
begin
  Caption := SCapEditing + EditName + ' (' + IntToStr(Memo1.Lines.Count) + SCapLines;
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.Memo1Change(Sender: TObject);
begin
  ShowNumberOfLines;
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.ButtonLoadClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.ButtonSaveClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key=VK_ESCAPE then
    ModalResult:=mrCancel;
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.FormShow(Sender: TObject);
begin
  ShowNumberOfLines;
  Memo1.Perform(EM_SETSEL, -1, 0); // Scroll the caret into view.
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  SetFormFont(self);
  SetFlatProp([SaveButton,OpenButton],True);

  Caption := SStrlEdit;
  OpenButton.Hint := SOpen;
  SaveButton.Hint := RemoveCharSet(['&'],SVerbSave);
  CodeButton.Caption := SCodeEdit;

  UpdateStandardButtons(OkBut, CancelBut, HelpBut);

  for i := 0 to Screen.Fonts.Count - 1 do
    ComboBox1.Items.Add(Screen.Fonts[i]);
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(Memo1.Font.Name);
  with ComboBox2.Items do
    for i := 0 to 15 do
      Add(IntToStr(StdFontSizes[i]));
  ComboBox2.ItemIndex := ComboBox2.Items.IndexOf(IntToStr(Memo1.Font.Size));
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.CodeButtonClick(Sender: TObject);
begin
  ModalResult:=mrOk;
  FNeedCodeEditor:=True;
end;

{------------------------------------------------------------------}

//BeginSkipConst
procedure _InstantRegister;
begin
  RegisterPropertyEditor(TypeInfo(TStrings), nil, '', TStringListEdit);
  RegisterVisualProperty(SVerbLinesEditor,TMemo,'Lines');
  RegisterVisualProperty(SVerbItemsEditor,TListBox,'Items');
  RegisterVisualProperty(SVerbItemsEditor,TComboBox,'Items');
  RegisterVisualProperty(SVerbItemsEditor,TRadioGroup,'Items');
  RegisterVisualProperty(SVerbTabsEditor,TTabControl,'Tabs');
//  RegisterVisualProperty(SVerbLinesEditor,TRichEdit,'Lines');
  {$IFDEF D3}
  RegisterVisualProperty(SVerbItemsEditor,TCheckListBox,'Items');
  {$ENDIF}
end;
//EndSkipConst

{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForInstant(_InstantRegister);
end;

{------------------------------------------------------------------}

procedure TStringsEditForm.ComboBox1Change(Sender: TObject);
begin
  Memo1.Font.Name := ComboBox1.Text;
end;

procedure TStringsEditForm.ComboBox2Change(Sender: TObject);
begin
  Memo1.Font.Size := StrToInt(ComboBox2.Text);
end;

initialization
  RunRegister;
end.
