unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, gtPDFUtils, Password, gtExProPDFDoc, ExtCtrls, Buttons;

type
  TfrmMain = class(TForm)
    btnAction: TButton;
    edInputFile: TEdit;
    lbInputFile: TLabel;
    btnLoadFile: TButton;
    edOutPutFile: TEdit;
    lbOutPutFile: TLabel;
    btnLoadOutputFile: TButton;
    cbOpenAfterSave: TCheckBox;
    gtPDFDocument1: TgtPDFDocument;
    gbSigProps: TGroupBox;
    gbFieldProps: TGroupBox;
    edFieldName: TEdit;
    lbFieldname: TLabel;
    cbPageNo: TComboBox;
    lbPageNo: TLabel;
    cbSetPos: TCheckBox;
    edRectLeft: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edRectTop: TEdit;
    Label3: TLabel;
    edRectRight: TEdit;
    Label4: TLabel;
    edRectBotton: TEdit;
    gbFieldFill: TGroupBox;
    cbFieldName: TComboBox;
    lbField: TLabel;
    rgOptions: TRadioGroup;
    lbReason: TLabel;
    lbLocation: TLabel;
    Label5: TLabel;
    lbPFXFileName: TLabel;
    lbPassword: TLabel;
    edPFXFileName: TEdit;
    btnLoadPFXFile: TButton;
    edPassword: TEdit;
    edReason: TEdit;
    edLocation: TEdit;
    edContactInfo: TEdit;
    cbTime: TCheckBox;
    lbAppearanceText: TLabel;
    cbName: TCheckBox;
    cbReason: TCheckBox;
    cbLocation: TCheckBox;
    cbDate: TCheckBox;
    FontDialog1: TFontDialog;
    lbSelectFont: TLabel;
    Label7: TLabel;
    btnFont: TButton;
    cbLabels: TCheckBox;
    ColorBox1: TColorBox;
    procedure btnLoadFileClick(Sender: TObject);
    procedure btnLoadOutputFileClick(Sender: TObject);
    procedure btnLoadPFXFileClick(Sender: TObject);
    procedure btnActionClick(Sender: TObject);
    procedure cbSetPosClick(Sender: TObject);
    procedure gtPDFDocument1Password(Sender: TObject; var Password: string;
      var Continue: Boolean; const Tries: Integer);
    procedure FormCreate(Sender: TObject);
    procedure rgOptionsClick(Sender: TObject);
    procedure edInputFileExit(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
  private
    { Private declarations }
    FFont: TFont;
    procedure FillPageNumber;
    procedure FillFieldName;
    procedure LoadPDFFile;
    procedure EnableGroupBox(AGroupBox: TGroupBox);
    procedure DisableGroupBox(AGroupBox: TGroupBox);
  public
    { Public declarations }
  end;
  
	THackWinControl = class(TWinControl);

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnFontClick(Sender: TObject);
begin
  FontDialog1.Execute();
  FFont := FontDialog1.Font;
end;

procedure TfrmMain.btnLoadFileClick(Sender: TObject);
var
  LOpenDialog: TOpenDialog;
begin
  LOpenDialog := TOpenDialog.Create(Self);
  LOpenDialog.Filter := 'PDF Files|*.pdf';
  if not LOpenDialog.Execute then Exit;
  edInputFile.Text := LOpenDialog.FileName;
  LoadPDFFile;
  LOpenDialog.Free;
end;

procedure TfrmMain.btnLoadOutputFileClick(Sender: TObject);
var
  LOpenDialog: TOpenDialog;
begin
  LOpenDialog := TOpenDialog.Create(Self);
  LOpenDialog.Filter := 'PDF Files|*.pdf';
  if not LOpenDialog.Execute then Exit;
  edOutPutFile.Text := LOpenDialog.FileName;
end;

procedure TfrmMain.btnLoadPFXFileClick(Sender: TObject);
var
  LOpenDialog: TOpenDialog;
begin
  LOpenDialog := TOpenDialog.Create(Self);
  LOpenDialog.Filter := 'PFX Files|*.pfx';
  if not LOpenDialog.Execute then Exit;
  edPFXFileName.Text := LOpenDialog.FileName;
  LOpenDialog.Free;
end;

procedure TfrmMain.btnActionClick(Sender: TObject);
var
  LRect: TgtRect;
  LField: TgtFormField;
  LSigTextOptions: TgtDisplayTextOptions;
begin
  if edInputFile.Text = '' then
  begin
    ShowMessage('Input File does not exist');
    Exit;
  end;
  if edOutPutFile.Text = '' then
  begin
    ShowMessage('Output File does not exist');
    Exit;
  end;
  LSigTextOptions := [];
  if cbName.Checked then
    LSigTextOptions := LSigTextOptions + [dtoName];
  if cbReason.Checked then
    LSigTextOptions := LSigTextOptions + [dtoReason];
  if cbLocation.Checked then
    LSigTextOptions := LSigTextOptions + [dtoLocation];
  if cbDate.Checked then
    LSigTextOptions := LSigTextOptions + [dtoDate];
  if cbLabels.Checked then
    LSigTextOptions := LSigTextOptions + [dtoLabels];

  if (gbSigProps.Enabled) or (gbFieldProps.Enabled)then
  begin
    if cbSetPos.Checked then
      LRect := gtRect(StrToFloat(edRectLeft.Text), StrToFloat(edRectTop.Text),
      StrToFloat(edRectRight.Text), StrToFloat(edRectBotton.Text))
    else
      LRect := gtRect(0, 0, 0, 0);
    if (rgOptions.ItemIndex = 0) or (rgOptions.ItemIndex = 2) then
    begin
      if edPFXFileName.Text = '' then
      begin
        ShowMessage('PFX File does not exist');
        Exit;
      end;
      if edPassword.Text = '' then
      begin
        ShowMessage('PFX password empty');
      end;
    end;

    with gtPDFDocument1 do
    begin
      OpenAfterSave := cbOpenAfterSave.Checked;
      if IsLoaded then
      begin
        if rgOptions.ItemIndex <> 2 then
        begin
          if (cbTime.Checked) then
            AddSignature(edPFXFileName.Text, edPassword.Text, Now, edReason.Text,
              edLocation.Text, edContactInfo.Text, cbPageNo.ItemIndex + 1,
              edFieldName.Text, LRect, LSigTextOptions, ColorBox1.Selected, FFont)
          else
            AddSignature(edPFXFileName.Text, edPassword.Text, edReason.Text,
            edLocation.Text, '', cbPageNo.ItemIndex + 1, edFieldName.Text, LRect,
            LSigTextOptions, ColorBox1.Selected, FFont);
        end
        else
        begin
          if cbFieldName.ItemIndex = -1 then
          begin
            ShowMessage('No blank field to fill');
            Exit;
          end;

          LField := GetFormField(cbFieldName.Items[cbFieldName.ItemIndex]);
          if Assigned(LField) then
          begin
            if (cbTime.Checked) then
              LField.Fill(edPFXFileName.Text, edPassword.Text, Now, edReason.Text,
                edLocation.Text, edContactInfo.Text)
            else
              LField.Fill(edPFXFileName.Text, edPassword.Text, edReason.Text,
                edLocation.Text, edContactInfo.Text);
          end;
        end;
        SaveToFile(edOutPutFile.Text);
      end;
    end;
  end;
  edInputFile.Text := '';
end;

procedure TfrmMain.cbSetPosClick(Sender: TObject);
var
  LEnable: Boolean;
begin
  LEnable := TCheckBox(Sender).Checked;
  edRectLeft.Enabled := LEnable;
  edRectTop.Enabled := LEnable;
  edRectRight.Enabled := LEnable;
  edRectBotton.Enabled := LEnable;
end;

procedure TfrmMain.DisableGroupBox(AGroupBox: TGroupBox);
var
	I: Integer;
begin
	with AGroupBox do
	begin
		Enabled := False;
		for I := 0 to ControlCount - 1 do
			if (Controls[I] is TWinControl) and
					(THackWinControl(Controls[I]).Color = clWindow) then
				THackWinControl(Controls[I]).Color := clInactiveBorder;
	end;
end;

procedure TfrmMain.edInputFileExit(Sender: TObject);
begin
  LoadPDFFile;
end;

procedure TfrmMain.EnableGroupBox(AGroupBox: TGroupBox);
var
	I: Integer;
begin
	with AGroupBox do
	begin
		Enabled := True;
		for I := 0 to ControlCount - 1 do
			if (Controls[I] is TWinControl) and
					(THackWinControl(Controls[I]).Color = clInactiveBorder) then
				THackWinControl(Controls[I]).Color := clWindow;
	end;
end;

procedure TfrmMain.FillFieldName;
var
  I: Integer;
  LField: TgtFormField;
begin
  if gbFieldFill.Enabled then
  begin
    if not gtPDFDocument1.IsLoaded then Exit;
    cbFieldName.Items.Clear;
    for I := 1 to gtPDFDocument1.GetFormFieldCount do
    begin
      LField := gtPDFDocument1.GetFormField(I);
      if LField.FieldType = ftSignature then
        cbFieldName.Items.Add(LField.FieldName);
    end;
  end;
end;

procedure TfrmMain.FillPageNumber;
var
  I: Integer;
begin
  if gbFieldProps.Enabled then
  begin
    if not gtPDFDocument1.IsLoaded then Exit;
    cbPageNo.Items.Clear;
    for I := 1 to gtPDFDocument1.PageCount do
      cbPageNo.Items.Add(IntToStr(I));
    cbPageNo.ItemIndex := 0;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  edPFXFileName.Text := '';
  rgOptions.ItemIndex := 0;
  gbSigProps.Enabled := True;
  gbFieldProps.Enabled := True;
  gbFieldFill.Enabled := False;
  ColorBox1.Selected := clWhite;
end;

procedure TfrmMain.gtPDFDocument1Password(Sender: TObject; var Password: string;
  var Continue: Boolean; const Tries: Integer);
begin

  try
    if Continue then
      begin
      if (Tries <> 0) and (Tries < 3) then
        ShowMessage('Wrong Password!' + #13#10 + 'Enter the password again.');

      if Tries < 3 then
      begin
        frmPassword.ShowModal;
        frmPassword.edtpassword.Text := '';
        Password := frmPassword.FPwd;
        if frmPassword.IsCancel then
        begin
          Continue := false;
        end
        else
          Continue := True;
      end
      else
      begin
        Continue := False;
        ShowMessage('Wrong Password!' + #13#10 + 'Please open the document again.')
      end;
    end;
  except
  //
  end;
end;

procedure TfrmMain.LoadPDFFile;
begin
  if gtPDFDocument1.IsLoaded then
  begin
    gtPDFDocument1.Reset;
  end;
  gtPDFDocument1.LoadFromFile(edInputFile.Text);
  FillPageNumber;
  FillFieldName;
end;

procedure TfrmMain.rgOptionsClick(Sender: TObject);
var
  LSelect: Integer;
begin
  LSelect := rgOptions.ItemIndex;
  case LSelect of
    0:
    begin
      EnableGroupBox(gbSigProps);
      EnableGroupBox(gbFieldProps);
      DisableGroupBox(gbFieldFill);
      btnAction.Caption := 'Sign';
    end;
    1:
    begin
      edPFXFileName.Text := '';
      edPassword.Text := '';
      EnableGroupBox(gbFieldProps);
      DisableGroupBox(gbSigProps);
      DisableGroupBox(gbFieldFill);
      btnAction.Caption := 'Insert Field';
    end;
    2:
    begin
      EnableGroupBox(gbSigProps);
      EnableGroupBox(gbFieldFill);
      DisableGroupBox(gbFieldProps);
      btnAction.Caption := 'Fill Field';
    end;
  end;
  FillPageNumber;
  FillFieldName;
end;

end.

