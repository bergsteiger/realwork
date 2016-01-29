unit D_NameSrcEd;

{$Include l3Define.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, D_NameEd, OvcBase,  evEditorWindow, evEditor, evMemo, Buttons,
  StdCtrls, ExtCtrls, evMultiSelectEditorWindow, evCustomEditor,
  evEditorWithOperations, afwControl, evCustomMemo, afwControlPrim,
  afwBaseControl, nevControl;

type
  TNameEditSrcDlg = class(TNameEditDlg)
    AddedDataPanel: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    edShortName: TEdit;
    edSynon: TevMemo;
    procedure FormShow(Sender: TObject);
  private        
    procedure SetROnly(aValue : Boolean); override;
  public
    { Public declarations }
  end;

implementation

uses
  evFacadTextSource
  ;

{$INCLUDE ProjectDefine.inc}

{$R *.dfm}
procedure TNameEditSrcDlg.SetROnly(aValue : boolean);
begin
 inherited;
 edShortName.Enabled := not aValue;
 edSynon.Enabled := not aValue;
end;

procedure TNameEditSrcDlg.FormShow(Sender: TObject);
begin
  inherited;
  evSetTextParaLimit(edSynon.TextSource, 1);
end;

end.
