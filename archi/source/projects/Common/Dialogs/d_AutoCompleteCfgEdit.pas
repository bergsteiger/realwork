unit d_AutoCompleteCfgEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, vtBndLabel, vtLabel, vtForm;

type
  TACEditDlg = class(TvtForm)
    edMacro: TEdit;
    vtBoundedLabel1: TvtBoundedLabel;
    edReplacement: TEdit;
    vtBoundedLabel2: TvtBoundedLabel;
    cbRegexp: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    procedure edMacroChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ACEditDlg: TACEditDlg;

implementation

{$R *.dfm}

procedure TACEditDlg.edMacroChange(Sender: TObject);
begin
 btnOK.Enabled := (edMacro.Text <> '') and (Pos(' ', edMacro.Text)=0) and (edReplacement.Text <> '');
end;

procedure TACEditDlg.FormShow(Sender: TObject);
begin
 edMacroChange(nil);
end;

end.
