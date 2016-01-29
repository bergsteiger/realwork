unit D_NewClassNameEd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, D_NameEd, OvcBase,  evEditorWindow, evEditor, evMemo, StdCtrls,
  Buttons, ExtCtrls, l3Interfaces,
  l3Types, vtSpin, TB97Ctls, evMultiSelectEditorWindow, evCustomEditor,
  evEditorWithOperations, afwControl, afwControlPrim, afwBaseControl,
  nevControl, evCustomMemo;

type
  TNewClassNameEditDlg = class(TNameEditDlg)
    AddedDataPanel: TPanel;
    Label2: TLabel;
    mComment: TevMemo;
    pnlRelinkID: TPanel;
    Label1: TLabel;
    edtRelinkDictID: TvtSpinEdit;
    pnlJuristicChanges: TPanel;
    cbxJuristicChanges: TCheckBox;
    procedure mEditorTextSourceBruttoCharCountChangeRus(Sender: TObject);
    procedure mEditorTextSourceBruttoCharCountChangeEng(Sender: TObject);
  private
    procedure SetROnly(aValue : boolean); override;

    procedure SetCommentText(const aValue : Tl3PCharLen);
    function  GetCommentText : Tl3PCharLen;

  public
    property  CommentText : Tl3PCharLen Read GetCommentText Write SetCommentText;
  end;

implementation

{$R *.dfm}

uses
  //Dialogs,
  //SysUtils,
  StrShop;

procedure TNewClassNameEditDlg.SetROnly(aValue : boolean);
begin
  Inherited;
  mComment.ReadOnly := aValue;
  edtRelinkDictID.Enabled := Not aValue;
end;

procedure TNewClassNameEditDlg.SetCommentText(const aValue : Tl3PCharLen);
begin
 mComment.Buffer := aValue;
 {NameEditor.IsOpen := True;}
end;

function  TNewClassNameEditDlg.GetCommentText : Tl3PCharLen;
begin
 Tl3WString(Result) := mComment.Buffer;
end;

procedure TNewClassNameEditDlg.mEditorTextSourceBruttoCharCountChangeRus(Sender: TObject);
begin
 mNameTextSourceBruttoCharCountChange(Sender);
 If mNameRus.TextLen > 75 then
  mNameRus.Color := clAqua
 else
  mNameRus.Color := clWindow;
end;

procedure TNewClassNameEditDlg.mEditorTextSourceBruttoCharCountChangeEng(Sender: TObject);
begin
 mNameTextSourceBruttoCharCountChange(Sender);

 If mNameEng.TextLen > 75 then
  mNameEng.Color := clAqua
 else
  mNameEng.Color := clWindow;
end;

end.
