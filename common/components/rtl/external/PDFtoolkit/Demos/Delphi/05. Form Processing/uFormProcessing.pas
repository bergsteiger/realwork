unit uFormProcessing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PDFtoolkitUsage, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc, 
  gtPDFDoc, StdCtrls, Grids, ComCtrls, Spin, ExtCtrls, gtPDFUtils, gtExProPDFDoc;

type
  TFormfieldSelection = (frmTextBox, frmComboBox, frmListbox, frmButton,
    frmcheckbox, frmRadio);
    
  TForm1 = class(TForm)
    gtPDFDocument1: TgtPDFDocument;
    edPDFfilename: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    edSavePDFTo: TEdit;
    btnSaveFileName: TButton;
    btnLoadPDF: TButton;
    OpenDialog1: TOpenDialog;
    btnSave: TButton;
    pgcntrlFormProcessing: TPageControl;
    tbshReadEditform: TTabSheet;
    sgFields: TStringGrid;
    btnGetFormFields: TButton;
    btnSetformfields: TButton;
    tbshAddform: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    rgrpAddform: TRadioGroup;
    pctrlAddformsettings: TPageControl;
    tbshPushButton: TTabSheet;
    Label183: TLabel;
    Label184: TLabel;
    Label188: TLabel;
    Label187: TLabel;
    Label190: TLabel;
    Label191: TLabel;
    Label186: TLabel;
    Label185: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    edFormPushLeft: TEdit;
    edFormPushTop: TEdit;
    edFormPushRight: TEdit;
    edFormPushBottom: TEdit;
    edFormPushFieldname: TEdit;
    spedPushBorderWidth: TSpinEdit;
    cbFormPushPageno: TComboBox;
    edFormPushNormal: TEdit;
    edFormPushDown: TEdit;
    edFormPushRollover: TEdit;
    cbPushBtnAction: TComboBox;
    btnPushbtnfont: TButton;
    GroupBox4: TGroupBox;
    Label58: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    cbFormsubmitformat: TComboBox;
    edFormPushSubmitURL: TEdit;
    edFormPushJavascript: TEdit;
    tbshCheckbox: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    edFormCheckLeft: TEdit;
    edFormCheckTop: TEdit;
    edFormCheckBottom: TEdit;
    edFormCheckRight: TEdit;
    edFormCheckFieldname: TEdit;
    cbFormCheckPageno: TComboBox;
    spedFormCheckBwidth: TSpinEdit;
    chkFormCheckValue: TCheckBox;
    cbformcheckboxsymbol: TComboBox;
    cbCheckboxBorderstyle: TComboBox;
    tbshRadiobutton: TTabSheet;
    Label38: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Selected: TLabel;
    edformRadioLeft: TEdit;
    edformRadioTop: TEdit;
    edformRadioRight: TEdit;
    edformRadioBottom: TEdit;
    edformRadioFieldname: TEdit;
    edformRadioFielddvalue: TEdit;
    cbFormRadioPageno: TComboBox;
    cbFormRadioSymbol: TComboBox;
    spedRadioBorderWidth: TSpinEdit;
    cbRadioBorderStyle: TComboBox;
    btnRadioFont: TButton;
    chkRadioAtleastone: TCheckBox;
    edRadioItemindex: TEdit;
    tbshTextbox: TTabSheet;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    edFormTextLeft: TEdit;
    edFormTextTop: TEdit;
    edFormTextBottom: TEdit;
    edFormTextRight: TEdit;
    edFormTextfieldname: TEdit;
    edFormTextValue: TEdit;
    cbformTextpageno: TComboBox;
    chkformTextTran: TCheckBox;
    chkformTextIsMulti: TCheckBox;
    chkformTextIsPass: TCheckBox;
    chkformTextIsfile: TCheckBox;
    cbformTextJust: TComboBox;
    btnTextFont: TButton;
    cbtextboxBorderStyle: TComboBox;
    spedTextboxBorderwidth: TSpinEdit;
    chkTextboxIsDonotScroll: TCheckBox;
    chkTextboxSpellcheck: TCheckBox;
    tbshcombobox: TTabSheet;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    edformComboLeft: TEdit;
    edformComboTop: TEdit;
    edformComboRight: TEdit;
    edformComboBottom: TEdit;
    edformComboFieldname: TEdit;
    chkFormComboIsSorted: TCheckBox;
    chkFormComboIsEdit: TCheckBox;
    cbFormComboPageno: TComboBox;
    spedComboBorderwidth: TSpinEdit;
    cbComboBorderStyle: TComboBox;
    btnCombofont: TButton;
    lstbxComboAddItem: TListBox;
    edComboSelecteditemindex: TEdit;
    tbshListbox: TTabSheet;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    edFormListLeft: TEdit;
    edFormListtop: TEdit;
    chkFormlistIsSorted: TCheckBox;
    chkFormListMultiSelect: TCheckBox;
    edFormListBottom: TEdit;
    edFormListRight: TEdit;
    edFormListFieldname: TEdit;
    cbFormListPageno: TComboBox;
    spedListBoxBorderWidth: TSpinEdit;
    cbListBoxBorderStyle: TComboBox;
    btnListboxfont: TButton;
    btnAddFormField: TButton;
    cbAddFormMeasure: TComboBox;
    tbshFlatten: TTabSheet;
    GroupBox1: TGroupBox;
    Label55: TLabel;
    edFlattenIndex: TEdit;
    btnFlattenindex: TButton;
    GroupBox2: TGroupBox;
    Label73: TLabel;
    edFlattenName: TEdit;
    btnflattenName: TButton;
    GroupBox3: TGroupBox;
    Label74: TLabel;
    edFlattenPage: TEdit;
    btnflattenPage: TButton;
    tbshOthers: TTabSheet;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    ColorDialog2: TColorDialog;
    btnBackColor: TButton;
    btnBorderColor: TButton;
    btnCBBackClr: TButton;
    btnCBBrdrClr: TButton;
    btnRBBackClr: TButton;
    btnRBBrdrClr: TButton;
    btnTBBackClr: TButton;
    btnTBBrdrClr: TButton;
    btnComBBrdrClr: TButton;
    btnComBBackClr: TButton;
    btnLBBackClr: TButton;
    btnLBBrdrClr: TButton;
    Label75: TLabel;
    btnReset: TButton;
    cbOpenAfterCreate: TCheckBox;
    edFormComboAddItem: TEdit;
    btnComboBoxAddItem: TButton;
    Label69: TLabel;
    edFormListAddItem: TEdit;
    lstbxListBoxItems: TListBox;
    btnListAddItem: TButton;
    SaveDialog1: TSaveDialog;
    procedure btnGetFormFieldsClick(Sender: TObject);
    procedure btnLoadPDFClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveFileNameClick(Sender: TObject);
    procedure btnRadioFontClick(Sender: TObject);
    procedure btnAddFormFieldClick(Sender: TObject);
    procedure btnBackColorClick(Sender: TObject);
    procedure btnBorderColorClick(Sender: TObject);
    procedure rgrpAddformClick(Sender: TObject);
    procedure btnListboxfontClick(Sender: TObject);
    procedure btnPushbtnfontClick(Sender: TObject);
    procedure btnTextFontClick(Sender: TObject);
    procedure btnCombofontClick(Sender: TObject);
    procedure btnSetformfieldsClick(Sender: TObject);
    procedure btnFlattenindexClick(Sender: TObject);
    procedure btnflattenNameClick(Sender: TObject);
    procedure btnflattenPageClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure ResetControls(Sender: TObject);
    procedure btnComboBoxAddItemClick(Sender: TObject);
    procedure btnListAddItemClick(Sender: TObject);
  private
    { Private declarations }
    FFont: TFont;
  public
    { Public declarations }
    procedure PopulatePageno(Sender: TObject);
  end;

var
  Form1: TForm1;
  SelectedField: TFormfieldSelection;


implementation

{$R *.DFM}

procedure TForm1.btnGetFormFieldsClick(Sender: TObject);
var
  LI,LFieldCount: Integer;
  LFormField: TgtFormField;
begin
  if gtPDFDocument1.IsLoaded then
  begin
    LFieldCount := gtPDFDocument1.GetFormFieldCount;
    with sgFields do
    begin
      RowCount := LFieldCount + 1;
      for LI := 1 to LFieldCount do
      begin
        {Get formfield fro mthe index specified}
        LFormField := gtPDFDocument1.GetFormField(LI);
        Cells[0, LI] := IntToStr(LI);
        Cells[1, LI] := LFormField.FieldName;
        Cells[2, LI] := LFormField.QualifiedName;
        Cells[3, LI] := FieldTypes[LFormField.FieldType];
        Cells[4, LI] := LFormField.FieldValue;
        //Cells[5, LI] := IfThen(LFormField.ReadOnly, 'True', 'False');
        If(LFormField.ReadOnly) then
        Cells[5, Li] :=  'True'
        else
        Cells[5, Li] := 'False';
        If(LFormField.Transparent) then
        Cells[6, Li] :=  'True'
        else
        Cells[6, Li] := 'False';

        Cells[7, Li] := LFormField.DefaultValue;
        FreeAndNil(LFormField);
      end;
    end;
  end;
end;

procedure TForm1.btnLoadPDFClick(Sender: TObject);
begin
   if OpenDialog1.Execute then
  begin
    gtPDFDocument1.LoadFromFile(OpenDialog1.FileName);
    edPDFfilename.Text := OpenDialog1.FileName;
    PopulatePageno(cbFormPushPageno);
    cbFormPushPageno.ItemIndex := 0;
    PopulatePageno(cbFormCheckPageno);
    cbFormCheckPageno.ItemIndex := 0;
    PopulatePageno(cbFormRadioPageno);
    cbFormRadioPageno.ItemIndex := 0;
    PopulatePageno(cbformTextpageno);
    cbformTextpageno.ItemIndex := 0;
    PopulatePageno(cbFormComboPageno);
    cbFormComboPageno.ItemIndex := 0;
    PopulatePageno(cbFormListPageno);
    cbFormListPageno.ItemIndex := 0;

  end;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  if (cbOpenAfterCreate.Checked) then
    gtPDFDocument1.OpenAfterSave := True
  else
    gtPDFDocument1.OpenAfterSave := False;
  gtPDFDocument1.SaveToFile(edSavePDFTo.Text);
  btnResetClick(Self);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  with sgFields do
  begin
    Cells[0, 0] := 'Sl.No';
    Cells[1, 0] := 'Field Name';
    Cells[2, 0] := 'Qualified Name';
    Cells[3, 0] := 'Field Type';
    Cells[4, 0] := 'Field Value';
    Cells[5, 0] := 'ReadOnly';
    Cells[6, 0] :=  'Transparent';
    Cells[7, 0] := 'Default Value';
  end;
  SelectedField := TFormfieldSelection(rgrpAddform.ItemIndex);
end;

procedure TForm1.btnSaveFileNameClick(Sender: TObject);
begin
   if SaveDialog1.Execute then
  begin
    edSavePDFTo.Text := SaveDialog1.FileName;
  end;
end;

procedure TForm1.btnRadioFontClick(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    FFont := FontDialog1.Font;
  end;
end;

procedure TForm1.btnAddFormFieldClick(Sender: TObject);
var
  LRect: TgtRect;
  LItems: TStringList;
begin
  try
    SetMeasurementUnit(gtPDFDocument1,cbAddFormMeasure.ItemIndex);
    if Assigned(gtPDFDocument1) then
    begin
      case SelectedField of
        frmButton:
          begin
            LRect.Left := StrToFloat(edFormPushLeft.Text);
            LRect.Top := StrToFloat(edFormPushTop.Text);
            LRect.Right := StrToFloat(edFormPushRight.Text);
            LRect.Bottom := StrToFloat(edFormPushBottom.Text);
            AddPushButton(gtPDFDocument1, LRect, edFormPushNormal.Text,edFormPushDown.Text,
              edFormPushRollover.Text, edFormPushSubmitURL.Text, edFormPushJavascript.Text,
              edFormPushFieldname.Text, spedPushBorderWidth.Value, cbFormPushPageno.ItemIndex + 1,
              cbPushBtnAction.ItemIndex,cbFormsubmitformat.ItemIndex,ColorDialog1.Color,
              ColorDialog2.Color,FFont);
          end;
        frmcheckbox:
          begin
            LRect.Left := StrToFloat(edFormCheckLeft.Text);
            LRect.Top := StrToFloat(edFormCheckTop.Text);
            LRect.Right := StrToFloat(edFormCheckRight.Text);
            LRect.Bottom := StrToFloat(edFormCheckBottom.Text);
            AddCheckBox(gtPDFDocument1, LRect,edFormCheckFieldname.Text, spedFormCheckBwidth.Value,
              cbFormCheckPageno.ItemIndex + 1, cbformcheckboxsymbol.ItemIndex,cbCheckboxBorderstyle.ItemIndex,
              ColorDialog1.Color, ColorDialog2.Color,chkFormCheckValue.Checked);
          end;
        frmRadio:
          begin
            LRect.Left := StrToFloat(edformRadioLeft.Text);
            LRect.Top := StrToFloat(edformRadioTop.Text);
            LRect.Right := StrToFloat(edformRadioRight.Text);
            LRect.Bottom := StrToFloat(edformRadioBottom.Text);
            AddRadioButton(gtPDFDocument1,LRect,edformRadioFieldname.Text, edformRadioFielddvalue.Text,
              cbFormRadioPageno.ItemIndex + 1, cbFormRadioSymbol.ItemIndex,spedRadioBorderWidth.Value,
              cbRadioBorderStyle.ItemIndex,StrToInt(edRadioItemindex.Text),ColorDialog1.Color,
              ColorDialog2.Color,FFont,chkRadioAtleastone.Checked);

              edformRadioLeft.Text := '';
              edformRadioTop.Text := '';
              edformRadioRight.Text := '';
              edformRadioBottom.Text := '';
              edformRadioFieldname.Text := '';
              edformRadioFielddvalue.Text := '';
          end;
        frmTextBox:
          begin
            LRect.Left := StrToFloat(edFormTextLeft.Text);
            LRect.Top := StrToFloat(edFormTextTop.Text);
            LRect.Right := StrToFloat(edFormTextRight.Text);
            LRect.Bottom := StrToFloat(edFormTextBottom.Text);
            AddTextBox(gtPDFDocument1,LRect,edFormTextfieldname.Text, edFormTextValue.Text, cbformTextpageno.ItemIndex + 1,
              cbformTextJust.ItemIndex,spedTextboxBorderwidth.Value, cbtextboxBorderStyle.ItemIndex,
              ColorDialog1.Color, ColorDialog2.Color,chkformTextTran.Checked,
              chkformTextIsMulti.Checked,chkformTextIsPass.Checked, chkformTextIsfile.Checked,
              chkTextboxIsDonotScroll.Checked, chkTextboxSpellcheck.Checked, FFont);
          end;
        frmComboBox:
          begin
            LItems := TStringList.Create;
            LItems.AddStrings(lstbxComboAddItem.Items);
            LRect.Left := StrToFloat(edformComboLeft.Text);
            LRect.Top := StrToFloat(edformComboTop.Text);
            LRect.Right := StrToFloat(edformComboRight.Text);
            LRect.Bottom := StrToFloat(edformComboBottom.Text);
            AddComboBox(gtPDFDocument1, LRect, edformComboFieldname.Text,cbFormComboPageno.ItemIndex + 1,
              spedComboBorderwidth.Value,cbComboBorderStyle.ItemIndex,StrToInt(edComboSelecteditemindex.Text),
              ColorDialog1.Color,ColorDialog2.Color,chkFormComboIsEdit.Checked,chkFormComboIsSorted.Checked,
              LItems, FFont);

            LItems.Free;
          end;
        frmListbox:
          begin
            LItems := TStringList.Create;
            LItems.AddStrings(lstbxListBoxItems.Items);
            LRect.Left := StrToFloat(edFormListLeft.Text);
            LRect.Top := StrToFloat(edFormListtop.Text);
            LRect.Right := StrToFloat(edFormListRight.Text);
            LRect.Bottom := StrToFloat(edFormListBottom.Text);
            AddListBox(gtPDFDocument1,LRect,edFormListFieldname.Text,cbFormListPageno.ItemIndex + 1,
              spedComboBorderwidth.Value,cbListBoxBorderStyle.ItemIndex,ColorDialog1.Color,
              ColorDialog2.Color,chkFormListMultiSelect.Checked,chkFormlistIsSorted.Checked,
              LItems, FFont);

           LItems.Free
          end;
      end;
    end;
  except
    
  end;
end;

procedure TForm1.btnBackColorClick(Sender: TObject);
begin
  ColorDialog2.Execute;
end;

procedure TForm1.btnBorderColorClick(Sender: TObject);
begin
  ColorDialog1.Execute;
end;

procedure TForm1.rgrpAddformClick(Sender: TObject);
begin
 case rgrpAddform.ItemIndex of
    0:
    begin
      pctrlAddformsettings.ActivePageIndex := 3;
      SelectedField := frmTextBox;
    end;
    1:
    begin
      pctrlAddformsettings.ActivePageIndex := 4;
      SelectedField := frmComboBox;
    end;
    2:
    begin
      pctrlAddformsettings.ActivePageIndex := 5;
      SelectedField := frmListbox;
    end;
    3:
    begin
      pctrlAddformsettings.ActivePageIndex := 0;
      SelectedField := frmButton;
    end;
    4:
    begin
      pctrlAddformsettings.ActivePageIndex := 1;
      SelectedField := frmcheckbox;
    end;
    5:
    begin
      pctrlAddformsettings.ActivePageIndex := 2;
      SelectedField := frmRadio;
      Label1.Caption := 'Radio item settings'
    end;
  else
      pctrlAddformsettings.ActivePageIndex := 3;
      SelectedField := frmTextBox;
  end;
end;

procedure TForm1.btnListAddItemClick(Sender: TObject);
begin
  if edFormListAddItem.Text = '' then
    ShowMessage('Enter an item name')
  else
  begin
    lstbxListBoxItems.Items.Add(edFormListAddItem.Text);
    edFormListAddItem.Text := '';
  end;
end;

procedure TForm1.btnListboxfontClick(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    FFont := FontDialog1.Font;
  end;
end;

procedure TForm1.btnPushbtnfontClick(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    FFont := FontDialog1.Font;
  end;
end;

procedure TForm1.btnTextFontClick(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    FFont := FontDialog1.Font;
  end;
end;

procedure TForm1.btnComboBoxAddItemClick(Sender: TObject);
begin
  if edFormComboAddItem.Text = '' then
    ShowMessage('Enter an item name')
  else
  begin
    lstbxComboAddItem.Items.Add(edFormComboAddItem.Text);
    edFormComboAddItem.Text := '';
  end;

end;

procedure TForm1.btnCombofontClick(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    FFont := FontDialog1.Font;
  end;
end;

procedure TForm1.PopulatePageno(Sender: TObject);
var
  Li: Integer;
begin
  if (Sender is TComboBox) then
  begin
    (Sender as TComboBox).Clear;
    for Li := 0 to gtPDFDocument1.PageCount - 1 do
    begin
      (Sender as TComboBox).Items.Add(IntToStr(Li + 1));
    end;
  end;
end;

procedure TForm1.btnSetformfieldsClick(Sender: TObject);
var
  LI: Integer;
  LreadOnly, LTransparent: Boolean;
begin
  try
    if Assigned(gtPDFDocument1) then
    begin
      with gtPDFDocument1, sgFields do
      begin
        for LI := 1 to GetFormFieldCount do
        begin
           if (AnsiCompareText(Cells[5, LI], 'true') = 0) then
            LreadOnly := True
            else
            LreadOnly := False;

            if (AnsiCompareText(Cells[6, LI], 'true') = 0) then
              LTransparent := True
            else
              LTransparent := False;
            //TgtPDFDocuemt, FieldIndex, Fieldname, Fieldvalue, Defaultvalue, Transparent
          SetPDFFormfields(gtPDFDocument1, LI, Cells[1, LI], Cells[4, LI],
            LreadOnly, LTransparent, Cells[7, LI]);
        end;
      end;
    end;
  except
    //
  end;
end;

procedure TForm1.btnFlattenindexClick(Sender: TObject);
begin
  try
    FlattenFormFieldByIndex(gtPDFDocument1,StrToInt(edFlattenIndex.Text));
  except
    //
  end;
end;

procedure TForm1.btnflattenNameClick(Sender: TObject);
begin
  try
    FlattenFormFieldByName(gtPDFDocument1,edFlattenName.Text);
  except
    //
  end;
end;

procedure TForm1.btnflattenPageClick(Sender: TObject);
begin
  try
    FlattenFormFieldOnPage(gtPDFDocument1,edFlattenPage.Text);
  except
    //
  end;
end;

procedure TForm1.btnResetClick(Sender: TObject);
var
  nCol:integer;
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.Reset;
  end;
  cbFormPushPageno.Clear;
  cbFormCheckPageno.Clear;
  cbFormRadioPageno.Clear;
  cbformTextpageno.Clear;
  cbFormComboPageno.Clear;
  cbFormListPageno.Clear;
  ResetControls(Form1);
  for nCol := 0 to sgFields.ColCount - 1 do
    sgFields.Cols[nCol].Clear;
  with sgFields do
  begin
    Cells[0, 0] := 'Sl.No';
    Cells[1, 0] := 'Field Name';
    Cells[2, 0] := 'Qualified Name';
    Cells[3, 0] := 'Field Type';
    Cells[4, 0] := 'Field Value';
    Cells[5, 0] := 'ReadOnly';
    Cells[6, 0] :=  'Transparent';
    Cells[7, 0] := 'Default Value';
  end;
end;

procedure TForm1.ResetControls(Sender: TObject);
var
  cntrlCnt: Integer;
begin
  if (Sender is TWinControl) then
  begin
    for cntrlCnt := 0 to TWinControl(Sender).ControlCount - 1 do
    begin
      if TWinControl(Sender).ContainsControl(TWinControl(Sender).Controls[cntrlCnt]) then
      begin
        ResetControls(TWinControl(Sender).Controls[cntrlCnt]);
      end;
      if (TWinControl(Sender).Controls[cntrlCnt] is TEdit) then
        (TWinControl(Sender).Controls[cntrlCnt] As TEdit).Text := ''
      else if (TWinControl(Sender).Controls[cntrlCnt] is TCheckBox) then
        (TWinControl(Sender).Controls[cntrlCnt] As TCheckBox).Checked := False
      else if (TWinControl(Sender).Controls[cntrlCnt] is TComboBox) then
        (TWinControl(Sender).Controls[cntrlCnt] As TComboBox).ItemIndex := 0
      else if (TWinControl(Sender).Controls[cntrlCnt] is TListBox) then
        (TWinControl(Sender).Controls[cntrlCnt] As TListBox).Items.Clear;
    end;
  end;
  edSavePDFTo.Text := 'C:\Output.pdf';
  edPDFfilename.Text := '';
end;


end.
