unit d_AutoCompleteCfg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls, vtBndLabel, OvcBase,
   vtLister, evAutoComplete, afwControl, afwInputControl, l3Interfaces;

type
  TAutoCompleteCfgDlg = class(TBottomBtnDlg)
    lstMacros: TvtLister;
    btnAdd: TButton;
    btnDelete: TButton;
    btnEdit: TButton;
    procedure lstMacrosGetStrItem(Sender: TObject; Index: Integer;
      var ItemString: Il3CString);
    procedure btnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lstMacrosCountChanged(Sender: TObject; NewCount: Integer);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(aOwner: TComponent); override;
    { Public declarations }
  end;

var
  AutoCompleteCfgDlg: TAutoCompleteCfgDlg;

implementation

uses l3Base, d_AutoCompleteCfgEdit;

{$R *.dfm}

constructor TAutoCompleteCfgDlg.Create(aOwner: TComponent);
begin
 inherited Create(aOwner);
 lstMacros.Total := AutoComplete.MacroList.Count;
end;

procedure TAutoCompleteCfgDlg.lstMacrosGetStrItem(Sender: TObject;
  Index: Integer; var ItemString: Il3CString);
var
 AC: TevACMacro;
 lStr: string;
begin
 AC := TevACMacro(AutoComplete.MacroList[Index]);
 if AC.RegExp then
  lStr := '+'
 else
  lStr := '';
 ItemString := l3CStr(lStr +#9 + AC.Macro +#9 + AC.Replacement);
end;

procedure TAutoCompleteCfgDlg.btnAddClick(Sender: TObject);
var
 lDlg: TACEditDlg;
 N: Integer;
begin
 lDlg := TACEditDlg.Create(Self);
 try
  if lDlg.ShowModal = mrOK then
  begin
   N := AutoComplete.AddMacro(lDlg.edMacro.Text, lDlg.edReplacement.Text, lDlg.cbRegexp.Checked);
   lstMacros.Total := AutoComplete.MacroList.Count;
   lstMacros.Current := N;
   lstMacros.Refresh;
  end;
 finally
  lDlg.Free;
 end;
end;

procedure TAutoCompleteCfgDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
 if ModalResult = mrOK then
 begin
  AutoComplete.SaveToFile;
 end
 else
  AutoComplete.LoadFromFile;
end;

procedure TAutoCompleteCfgDlg.lstMacrosCountChanged(Sender: TObject;
  NewCount: Integer);
begin
 btnDelete.Enabled := lstMacros.Total > 0;
 btnEdit.Enabled := btnDelete.Enabled;
end;

procedure TAutoCompleteCfgDlg.btnDeleteClick(Sender: TObject);
begin
 if MessageDlg('Вы действительно хотите удалить этот элемент?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
 begin
  AutoComplete.MacroList.Delete(lstMacros.Current);
  lstMacros.Total := AutoComplete.MacroList.Count;
 end; {if..}
end;

procedure TAutoCompleteCfgDlg.btnEditClick(Sender: TObject);
var
 AC: TevACMacro;
 lDlg: TACEditDlg;
 N: Integer;
begin
 AC := TevACMacro(AutoComplete.MacroList[lstMacros.Current]);
 lDlg := TACEditDlg.Create(Self);
 try
  lDlg.edMacro.Text := AC.Macro;
  lDlg.edReplacement.Text := AC.Replacement;
  lDlg.cbRegexp.Checked := AC.RegExp;
  if lDlg.ShowModal = mrOK then
  begin
   AC.Macro := lDlg.edMacro.Text;
   AC.Replacement := lDlg.edReplacement.Text;
   AC.RegExp := lDlg.cbRegexp.Checked;
   lstMacros.Refresh;
  end;
 finally
  lDlg.Free;
 end;
end;

end.
