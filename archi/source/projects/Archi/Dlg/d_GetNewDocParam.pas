unit d_GetNewDocParam;

{$Include l3Define.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, OvcBase,  evEditorWindow,
  evEditor, evMemo, vtSpin, ComCtrls, Mask, ToolEdit,
  evMultiSelectEditorWindow,
  BottomBtnDlg, evCustomEditor, evEditorWithOperations, afwControl,
  evCustomMemo, afwControlPrim, afwBaseControl, nevControl,
  evCustomEditorWindowPrim, evCustomEditorWindow,
  evCustomEditorWindowModelPart, evCustomEditorModelPart;

const
 dkText      = 0;
 dkObject    = 1;
 dkDictEntry = 2;
 dkFlash     = 3;

type
  TNewDocParam = class(TBottomBtnDlg)
    edtDocID: TvtSpinEdit;
    edtDocName: TevMemo;
    cbDocKind: TComboBox;
    gbImportFromFile: TGroupBox;
    FileEdit: TFilenameEdit;
    AnalizeChkBox: TCheckBox;
    Label4: TLabel;
    lblDocID: TLabel;
    lblDocName: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FileEditChange(Sender: TObject);
    procedure cbDocKindChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    function Execute : Boolean;
  end;

implementation

{$R *.DFM}

{$INCLUDE ProjectDefine.inc}

uses
 HelpCnst,
 IniShop,
 DT_Serv,

 evFacadTextSource
 ;

procedure TNewDocParam.FormCreate(Sender: TObject);
var
 l_OldNameTop: Integer;
begin
 inherited;
 HelpContext := hcNewDoc;

 if GlobalHtServer.ExtDocIDsFromRange then
 begin
  lblDocID.Visible := False;
  edtDocID.Visible := False;
  lblDocName.Top := cbDocKind.Top + cbDocKind.Height + 10;
  l_OldNameTop := edtDocName.Top;
  edtDocName.Top := lblDocName.Top + lblDocName.Height + 3;
  edtDocName.Height := edtDocName.Height + (l_OldNameTop - edtDocName.Top);
 end;

 //if IniRec.DebugInfo then
 // cbDocKind.Enabled := True;
end;

function TNewDocParam.Execute : Boolean;
begin
 if GlobalHtServer.ExtDocIDsFromRange then
  ActiveControl := edtDocName
 else
  ActiveControl := edtDocID;
 cbDocKind.ItemIndex := Pred(IniRec.CreateDocKind);
 cbDocKindChange(Self);
 Result := ShowModal = mrOk;
 if Result then
  IniRec.CreateDocKind := Succ(cbDocKind.ItemIndex);
end;

procedure TNewDocParam.FileEditChange(Sender: TObject);
var
 lFName : string;
 lPos   : integer;
begin
 Exit;
 if (Length(FileEdit.FileName) > 0) and
    (edtDocID.AsInteger = 0) then
 begin
  lFName := ExtractFileName(FileEdit.FileName);
  lPos := Pos('.', lFName);
  if lPos > 0 then
   lFName := System.Copy(lFName, 1, Pred(lPos));
  try
   edtDocID.AsInteger := StrToInt(lFName);
  except
  end;
 end;
end;

procedure TNewDocParam.cbDocKindChange(Sender: TObject);
begin
 if not GlobalHtServer.ExtDocIDsFromRange then
 begin
  if cbDocKind.ItemIndex = 2 {Словарная статья} then
  begin
   //edtDocID.Empty;
   edtDocID.Enabled := False;
  end
  else
   edtDocID.Enabled := True;
 end;
end;

procedure TNewDocParam.FormShow(Sender: TObject);
begin
 inherited;
 evSetTextParaLimit(edtDocName.TextSource, 1);
end;

end.
