{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit MaskProp;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls, ExtCtrls, Buttons,
  DesignIntf, DesignEditors, Mask, MaskUtils, SysUtils, Dialogs;

type
{ TMaskProperty
  Property editor the Masked Edit Mask property   }

  TMaskProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;


type
  TMaskForm = class(TForm)
    InputMask: TEdit;
    Label1: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    TestEdit: TMaskEdit;
    Label4: TLabel;
    Blanks: TEdit;
    Bevel1: TBevel;
    SaveMaskCheck: TCheckBox;
    Masks: TButton;
    OpenDialog1: TOpenDialog;
    OKButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    procedure BlanksChange(Sender: TObject);
    procedure InputMaskChange(Sender: TObject);
    procedure ListDrawItem(Control: TWinControl;
          Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure ListBoxSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MasksClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
    FInEditChange: Boolean;
    function AddBlanks(Value: String): String;
    procedure LoadMaskList(const FileName: string);
  protected
    function GetListMaskValue(Index: Integer): string;
    function GetMaskValue(const Value: string): string;
    procedure Loaded; override;
  public
  end;

var
  MaskForm: TMaskForm;

function EditInputMask(var InputMask: string; const InitialDir: string): Boolean;

implementation

uses Registry, LibHelp, DsnConst, ToolsAPI;

{$R *.dfm}

function EditInputMask(var InputMask: string; const InitialDir: string): Boolean;
var
  Frm : TMaskForm;
begin
  Frm := TMaskForm.Create (Application);
  try
    Frm.InputMask.Text := InputMask;
    Frm.TestEdit.EditMask := Frm.InputMask.Text;
    if InitialDir <> '' then Frm.OpenDialog1.InitialDir := InitialDir;
    Result := Frm.ShowModal = mrOK;
    if Result then
    begin
      InputMask := Frm.InputMask.Text;
      if (Length(InputMask) <> 0) and (MaskGetFldSeparator(InputMask) < 0) then
      begin
        Frm.BlanksChange(Frm);
        InputMask := Frm.InputMask.Text;
      end;
    end;
  finally
    Frm.Free;
  end;
end;

{ TMaskProperty }

function TMaskProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;


procedure TMaskProperty.Edit;
var
  Str : String;
begin
  Str := GetValue;
  if EditInputMask(Str, GetLocaleDirectory((BorlandIDEServices as IOTAServices).GetTemplateDirectory)) and (GetValue <> Str) then
  begin
    SetValue(Str);
    Modified;
  end;
end;

{-----------}

procedure TMaskForm.BlanksChange(Sender: TObject);
Var
  Str : String;
begin
  Str := InputMask.Text;
  if (Length(Str) <> 0) and not FInEditChange then
    InputMask.Text := AddBlanks(Str);
end;

function TMaskForm.AddBlanks(Value: string): string;
Var
  Pos : Integer;
  BlankChar : Char;
  SaveChar : Char;
begin
  Result := Value;
  if Length (Result) <> 0 then
  begin
    BlankChar := MaskGetMaskBlank (Value);
    SaveChar  := '1';
    if Length (Blanks.Text) > 0 then
      BlankChar := Blanks.Text[1];
    if not SaveMaskCheck.Checked then
      SaveChar := MaskNoSave;

    Pos := MaskGetFldSeparator (Result);
    if Pos > 0 then SetLength(Result, Pos - 1);
    Result := Result + MaskFieldSeparator + SaveChar
               + MaskFieldSeparator + BlankChar;
  end;
end;

procedure TMaskForm.InputMaskChange(Sender: TObject);
var
  BlankChar: string;
begin
  TestEdit.Text := EmptyStr;
  TestEdit.EditMask := InputMask.Text;
  if TestEdit.EditMask <> GetListMaskValue(ListBox1.ItemIndex) then
    ListBox1.ItemIndex := -1;
  FInEditChange := True;
  SaveMaskCheck.Checked := MaskGetMaskSave(TestEdit.EditMask);
  BlankChar := MaskGetMaskBlank (TestEdit.EditMask);
  Blanks.Text := Format ('%s', [BlankChar]);
  FInEditChange := False;
end;

procedure TMaskForm.ListDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  R: TRect;
  CString: array[0..80] of char;
  Str, EditMask : String;
  X, Temp, StrPos : Integer;
begin
  if (Index >= ListBox1.Items.Count) then Exit;
  with ListBox1.Canvas do
  begin
    Str := ListBox1.Items[Index];
    StrPos := AnsiPos ('|', Str);
    if StrPos = 0 then Exit;

    R := Rect;
    X := R.Right;
    R.Right := R.Right div 2;
    ExtTextOut(Handle, R.Left + 1, R.Top + 1, ETO_CLIPPED or ETO_OPAQUE, @R,
      PChar(Copy(Str, 1, StrPos)), StrPos - 1, nil);
    MoveTo(R.Right, R.Top);
    LineTo(R.Right, R.Bottom);

    Str := Copy(Str, StrPos + 2, Length (Str) - StrPos - 2);
    StrPos := AnsiPos ('|', Str);
    if StrPos = 0 then Exit;
    Temp := Length(Str);
    SetLength(Str, StrPos - 2);
    EditMask := GetListMaskValue(Index);
    EditMask[Length(EditMask) - 2] := '0';
    EditMask := FormatMaskText(EditMask, Str);
    StrPLCopy(CString, EditMask, SizeOf(CString) - 1);
    SetLength(Str, Temp);
    R.Left := R.Right + 1;
    R.Right := X;
    ExtTextOut(Handle, R.Left + 1, R.Top + 1, ETO_CLIPPED or ETO_OPAQUE, @R,
      CString, Length(EditMask), nil);
  end;
end;

procedure TMaskForm.ListBoxSelect(Sender: TObject);
begin
  if ListBox1.ItemIndex >= 0 then
    InputMask.Text := GetListMaskValue(ListBox1.ItemIndex);
end;

function TMaskForm.GetListMaskValue(Index: Integer): string;
begin
  if Index >= 0 then Result := GetMaskValue(ListBox1.Items[Index])
  else Result := '';
end;

function TMaskForm.GetMaskValue(const Value: string): string;
var
  StrPos: Integer;
begin
  Result := '';
  StrPos := AnsiPos ('|', Value);
  if StrPos = 0 then Exit;
  Result := Value;
  Result := Copy(Result, StrPos + 1, Length (Result) - StrPos);
  StrPos := AnsiPos ('|', Result);
  if StrPos = 0 then
  begin
    Result := '';
    Exit;
  end;
  if Result[StrPos+1] = ' ' then
    Inc (StrPos);
  Result := Copy(Result, StrPos + 1, Length (Result) - StrPos);
end;

procedure TMaskForm.FormCreate(Sender: TObject);
begin
  HelpContext := hcDInputMaskEditor;
end;

procedure TMaskForm.MasksClick(Sender: TObject);
var
  AppIniFile: TRegIniFile;
begin
  OpenDialog1.HelpContext := hcDOpenMaskFile;
  if OpenDialog1.Execute then
  begin
    LoadMaskList(OpenDialog1.FileName);
    AppIniFile := TRegIniFile.Create((BorlandIDEServices as IOTAServices).GetBaseRegistryKey);
    try
      AppIniFile.WriteString (SIniEditorsName, SINIEditMaskName,
        OpenDialog1.FileName);
    finally
      AppIniFile.Free;
    end;
  end;
end;

procedure TMaskForm.Loaded;
var
  AppIniFile: TRegIniFile;
  Value: String;
begin
  inherited Loaded;
  AppIniFile := TRegIniFile.Create((BorlandIDEServices as IOTAServices).GetBaseRegistryKey);
  try
    Value := AppIniFile.ReadString (SIniEditorsName, SIniEditMaskName, '');
    LoadMaskList(Value);
  finally
    AppIniFile.Free;
  end;
end;

procedure TMaskForm.LoadMaskList(const FileName: string);
const
  UTF8BOM = $BFBBEF;   // reverse order
  UTF8BOMSize = 3;
var
  I, Size: Integer;
  Items: TStringList;
  UTF8Str: UTF8String;
  Stream: TStream;
  BOM: Cardinal;
begin
  if (Length(FileName) > 0) and FileExists(FileName) then
  begin
    Items := TStringList.Create;
    try
      // Since D8 .DEM files are UTF8 encoded. Test for the
      // UTF8 BOM and convert contents if present
      Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
      try
        if Stream.Size >= UTF8BOMSize then
        begin
          BOM := 0;
          Stream.Read(BOM, UTF8BOMSize);
          if BOM = UTF8BOM then
          begin
            Size := Stream.Size - Stream.Position;
            SetString(UTF8Str, nil, Size);
            Stream.Read(Pointer(UTF8Str)^, Size);
            Items.Text := UTF8ToAnsi(UTF8Str);
          end
          else
          begin
            Stream.Position := 0;
            Items.LoadFromStream(Stream);
          end;
        end
        else
          Items.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;

      I := 0;
      while I < (Items.Count - 1) do
      begin
        if (Length(Items[I]) = 0) then Items.Delete(I)
        else if (GetMaskValue(Items[I]) = '') then
          raise EInvalidOperation.Create(SInvalidSampleMask)
        else Inc(I);
        if I >= Items.Count then break;
      end;
      ListBox1.Items := Items;
    finally
      Items.Free;
    end;
  end;
end;

procedure TMaskForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.




