unit a2RangeEditDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TRangeEditDlg = class(TForm)
    Label1: TLabel;
    edFrom: TEdit;
    Label2: TLabel;
    edTo: TEdit;
    Label3: TLabel;
    btnOK: TButton;
    Button2: TButton;
    procedure edFromChange(Sender: TObject);
  private
    function pm_GetValueFrom: LongInt;
    function pm_GetValueTo: LongInt;
    { Private declarations }
  public
    property ValueFrom: LongInt read pm_GetValueFrom;
    property ValueTo: LongInt read pm_GetValueTo;
    { Public declarations }
  end;

var
  RangeEditDlg: TRangeEditDlg;

implementation

{$R *.dfm}

function TRangeEditDlg.pm_GetValueFrom: LongInt;
begin
 Result := StrToIntDef(edFrom.Text, -1);
end;

function TRangeEditDlg.pm_GetValueTo: LongInt;
begin
 Result := StrToIntDef(edTo.Text, -1);;
end;

procedure TRangeEditDlg.edFromChange(Sender: TObject);
begin
 btnOK.Enabled := (ValueFrom > 0) and (ValueTo > 0) and (ValueFrom <= ValueTo);
end;

end.
