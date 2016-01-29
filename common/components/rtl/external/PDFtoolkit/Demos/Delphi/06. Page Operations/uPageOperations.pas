unit uPageOperations;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc, gtPDFDoc,
  StdCtrls, ComCtrls, PDFtoolkitUsage;

type
  TForm1 = class(TForm)
    pgeCntrlMergeSplit: TPageControl;
    tbshMerge: TTabSheet;
    GroupBox8: TGroupBox;
    Label23: TLabel;
    Label10: TLabel;
    btnMergeOpen1: TButton;
    btnMerge: TButton;
    edMerge1: TEdit;
    edMergeoutfile: TEdit;
    btnMergeSave: TButton;
    tbshSplit: TTabSheet;
    GroupBox9: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    Label9: TLabel;
    edExtractPages: TEdit;
    edExtractPageRange: TEdit;
    btnExtract: TButton;
    btnSplitSave: TButton;
    tbshReorganize: TTabSheet;
    GroupBox6: TGroupBox;
    Label19: TLabel;
    Label6: TLabel;
    edDeletePageRange: TEdit;
    btnDelete: TButton;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label15: TLabel;
    edAppendFromFile: TEdit;
    edAppendPageRange: TEdit;
    btnAppendOpen: TButton;
    btnAppendPage: TButton;
    GroupBox7: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edInsertFrom: TEdit;
    edInsertPageRange: TEdit;
    edInsertAfterPage: TEdit;
    btnInsertOpen: TButton;
    btnInSertPage: TButton;
    tbshOther: TTabSheet;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edStitchPage: TEdit;
    edSticthToPage: TEdit;
    btnStitchPage: TButton;
    btnStitchPageSideBySide: TButton;
    Label13: TLabel;
    Label75: TLabel;
    edPDFfilename: TEdit;
    btnLoadPDF: TButton;
    gtPDFDocument1: TgtPDFDocument;
    OpenDialog1: TOpenDialog;
    Label14: TLabel;
    edSavePDFTo: TEdit;
    btnSaveFileName: TButton;
    btnSave: TButton;
    cbOpenAfterCreate: TCheckBox;
    btnReset: TButton;
    SaveDialog1: TSaveDialog;
    procedure btnLoadPDFClick(Sender: TObject);
    procedure btnSaveFileNameClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnMergeOpen1Click(Sender: TObject);
    procedure btnMergeSaveClick(Sender: TObject);
    procedure btnMergeClick(Sender: TObject);
    procedure btnSplitSaveClick(Sender: TObject);
    procedure btnExtractClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnAppendOpenClick(Sender: TObject);
    procedure btnAppendPageClick(Sender: TObject);
    procedure btnInsertOpenClick(Sender: TObject);
    procedure btnInSertPageClick(Sender: TObject);
    procedure btnStitchPageClick(Sender: TObject);
    procedure btnStitchPageSideBySideClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure ResetControls(Sender: TObject);
    procedure tbshMergeShow(Sender: TObject);
    procedure tbshSplitShow(Sender: TObject);
    procedure tbshReorganizeShow(Sender: TObject);
    procedure tbshOtherShow(Sender: TObject);
    
  private
     LFiles: TStringList;//Used in merge
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnLoadPDFClick(Sender: TObject);
begin
   if OpenDialog1.Execute then
  begin
    gtPDFDocument1.LoadFromFile(OpenDialog1.FileName);
    edPDFfilename.Text := OpenDialog1.FileName;
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

procedure TForm1.btnMergeOpen1Click(Sender: TObject);
var
  LOpnDlg: TOpenDialog;
  Li: Integer;
begin
  try
    LOpnDlg := TOpenDialog.Create(nil);
    LOpnDlg.Filter := '*.pdf';
    LOpnDlg.Options := [ofAllowMultiSelect];
    if LOpnDlg.Execute then
    begin
      LFiles := TStringList.Create;
      edMerge1.Text := LOpnDlg.Files.CommaText;
      for Li := 0 to LOpnDlg.Files.Count - 1 do
      begin
        LFiles.Add(LOpnDlg.Files[Li]);
      end;
    end;
  finally
    LOpnDlg.Free;
  end;
end;

procedure TForm1.btnMergeSaveClick(Sender: TObject);
var
  LSaveDlg: TSaveDialog;
begin
  try
    LSaveDlg := TSaveDialog.Create(nil);
    LSaveDlg.Execute;
    LSaveDlg.Filter := '*.pdf';
    edMergeoutfile.Text := LSaveDlg.FileName;
  finally
    LSaveDlg.Free;
  end;
end;

procedure TForm1.btnMergeClick(Sender: TObject);
begin
  try
    if gtPDFDocument1.IsLoaded then
    begin
      {Merges 'n' different PDF Document}
      try
        Mergedoc(gtPDFDocument1,LFiles,edMergeoutfile.Text);
        ShowMessage('Merged output saved to ' + edMergeoutfile.Text);
      finally
        LFiles.Free;
      end;
    end;
  except
    //
  end;
end;

procedure TForm1.btnSplitSaveClick(Sender: TObject);
var
  LSaveDlg: TSaveDialog;
begin
  try
    LSaveDlg := TSaveDialog.Create(nil);
    LSaveDlg.Execute;
    LSaveDlg.Filter := '*.pdf';
    edExtractPages.Text := LSaveDlg.FileName;
  finally
    LSaveDlg.Free;
  end;
end;

procedure TForm1.btnExtractClick(Sender: TObject);
begin
  try
    if gtPDFDocument1.IsLoaded then
    begin
      {Extract pages to the specified file}
      Extractpages(gtPDFDocument1,Trim(edExtractPages.Text),Trim(edExtractPageRange.Text));

    end;
  except
    //
  end;
end;

procedure TForm1.btnDeleteClick(Sender: TObject);
begin
  try
    if gtPDFDocument1.IsLoaded then
    begin
      {Delete pages from the current Document}
      DeletePages(gtPDFDocument1,Trim(edDeletePageRange.Text));

    end;
  except
    //
  end;
end;

procedure TForm1.btnAppendOpenClick(Sender: TObject);
begin
  OpenDialog1.Filter := '.pdf';
  OpenDialog1.DefaultExt := 'pdf';
  OpenDialog1.Execute;
  edAppendFromFile.Text := OpenDialog1.FileName;
end;

procedure TForm1.btnAppendPageClick(Sender: TObject);
begin
  {Appends pages from an other document to the current document}
  AppendPages(gtPDFDocument1,Trim(edAppendFromFile.Text),Trim(edAppendPageRange.Text));

end;

procedure TForm1.btnInsertOpenClick(Sender: TObject);
begin
  OpenDialog1.DefaultExt := 'pdf';
  OpenDialog1.Execute;
  edInsertFrom.Text := OpenDialog1.FileName;
end;

procedure TForm1.btnInSertPageClick(Sender: TObject);
begin
  {Insert pages from other document to the specified position}
  InsertPages(gtPDFDocument1,edInsertPageRange.Text, edInsertFrom.Text,StrToInt(edInsertAfterPage.Text));
end;

procedure TForm1.btnStitchPageClick(Sender: TObject);
begin
  try
    if gtPDFDocument1.IsLoaded then
    begin
      {Stitches Pages on the other page}
      StitchPages(gtPDFDocument1,StrToInt(edStitchPage.Text),
                  StrToInt(edSticthToPage.Text));

    end;
  except
    //
  end;
end;

procedure TForm1.btnStitchPageSideBySideClick(Sender: TObject);
begin
  try
    if gtPDFDocument1.IsLoaded then
    begin
      {Stitches Pages on the other page side by side}
      StitchPagesSideBySide(gtPDFDocument1,StrToInt(edStitchPage.Text),
                  StrToInt(edSticthToPage.Text));

    end;
  except
    //
  end;
end;

procedure TForm1.btnSaveFileNameClick(Sender: TObject);
begin
   if SaveDialog1.Execute then
  begin
    edSavePDFTo.Text := SaveDialog1.FileName;
  end;
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.Reset;
  end;
  ResetControls(Form1);
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
        (TWinControl(Sender).Controls[cntrlCnt] As TComboBox).ItemIndex := 0;
    end;
  end;
  edSavePDFTo.Text := 'C:\Output.pdf';
  edPDFfilename.Text := '';
end;

procedure TForm1.tbshMergeShow(Sender: TObject);
begin
  btnSave.Enabled := False;
  cbOpenAfterCreate.Enabled := False;
  edSavePDFTo.Enabled := False;
  btnSaveFileName.Enabled := False;
end;

procedure TForm1.tbshSplitShow(Sender: TObject);
begin
  btnSave.Enabled := True;
  cbOpenAfterCreate.Enabled := True;
  edSavePDFTo.Enabled := True;
  btnSaveFileName.Enabled := True;
end;

procedure TForm1.tbshReorganizeShow(Sender: TObject);
begin
  btnSave.Enabled := True;
  cbOpenAfterCreate.Enabled := True;
  edSavePDFTo.Enabled := True;
  btnSaveFileName.Enabled := True;
end;

procedure TForm1.tbshOtherShow(Sender: TObject);
begin
  btnSave.Enabled := True;
  cbOpenAfterCreate.Enabled := True;
  edSavePDFTo.Enabled := True;
  btnSaveFileName.Enabled := True;
end;

end.
