unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, dximctrl;

type
  TForm1 = class(TForm)
    ImageListBox: TdxImageListBox;
    ImageComboBox: TdxImageComboBox;
    SpinImage: TdxSpinImage;
    imgLarge: TImageList;
    imgSmall: TImageList;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    Label1: TLabel;
    ComboBox1: TComboBox;
    RadioGroup4: TRadioGroup;
    RadioGroup5: TRadioGroup;
    Label2: TLabel;
    Edit1: TEdit;
    procedure RadioGroup1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure RadioGroup4Click(Sender: TObject);
    procedure RadioGroup5Click(Sender: TObject);
    procedure SpinImageChange(Sender: TObject; ItemIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
    ImageListBox.ImageAlign := dxliLeft
  else ImageListBox.ImageAlign := dxliRight;
  ImageComboBox.ImageAlign := ImageListBox.ImageAlign;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
const
  StConst = ' Multiline test, Multiline test, Multiline test';
var
  i : Integer;
begin
  ImageListBox.MultiLines := CheckBox1.Checked;
  ImageComboBox.MultiLines := CheckBox1.Checked;
  if CheckBox1.Checked then
  begin
    ImageListBox.ItemHeight := 32;
    for i := 0 to ImageListBox.Items.Count - 1 do
    begin
      ImageListBox.Items[i] := ImageListBox.Items[i] + StConst;
      ImageListBox.ImageIndexes[i] := i;
    end;
    ImageComboBox.ItemHeight := 32;
    for i := 0 to ImageComboBox.Items.Count - 1 do
    begin
      ImageComboBox.Items[i] := ImageComboBox.Items[i] + StConst;
      ImageComboBox.ImageIndexes[i] := i;
    end;
  end else begin
    ImageListBox.ItemHeight := 22;
    for i := 0 to ImageListBox.Items.Count - 1 do
    begin
      ImageListBox.Items[i] := Copy(ImageListBox.Items[i], 1, Pos(' ', ImageListBox.Items[i]));
      ImageListBox.ImageIndexes[i] := i;
    end;
    ImageComboBox.ItemHeight := 22;
    for i := 0 to ImageComboBox.Items.Count - 1 do
    begin
      ImageComboBox.Items[i] := Copy(ImageComboBox.Items[i], 1, Pos(' ', ImageComboBox.Items[i]));
      ImageComboBox.ImageIndexes[i] := i;
    end;
  end;
end;

procedure TForm1.RadioGroup2Click(Sender: TObject);
begin
  ImageListBox.VertAlignment := TVertAlignment(RadioGroup2.ItemIndex);
  ImageComboBox.VertAlignment := ImageListBox.VertAlignment;
end;

procedure TForm1.RadioGroup3Click(Sender: TObject);
begin
  ImageListBox.Alignment := TAlignment(RadioGroup3.ItemIndex);
  ImageComboBox.Alignment := ImageListBox.Alignment;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  for i := 8 to 32 do
    ComboBox1.Items.Add(IntToStr(i));
  ComboBox1.ItemIndex := 8;
end;

procedure TForm1.ComboBox1Click(Sender: TObject);
begin
  SpinImage.UpDownWidth := StrToInt(ComboBox1.Items[ComboBox1.ItemIndex]);
end;

procedure TForm1.RadioGroup4Click(Sender: TObject);
begin
  SpinImage.UpDownOrientation := TdxsiOrientation(RadioGroup4.ItemIndex);
end;

procedure TForm1.RadioGroup5Click(Sender: TObject);
begin
  SpinImage.UpDownAlign := TdxUpDownAlign(RadioGroup5.ItemIndex);
end;

procedure TForm1.SpinImageChange(Sender: TObject; ItemIndex: Integer);
begin
  if ItemIndex > -1 then
    Edit1.Text := SpinImage.Items[ItemIndex].Value
  else Edit1.Text := '';
end;

end.
