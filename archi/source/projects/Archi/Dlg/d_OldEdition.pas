unit d_OldEdition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, ExtCtrls, vtSpin, Buttons;

type
  TOldEditionDlg = class(TBottomBtnDlg)
    edtDocID: TvtSpinEdit;
    Label1: TLabel;
    rgEditionKind: TRadioGroup;
    procedure OKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 function GetOldEditionData(out aEditionID : Integer; out aOldEdition : Boolean) : Boolean;

implementation

{$R *.dfm}
uses
 l3String,
 daSchemeConsts,
 Dt_Const, DT_Serv, DT_Doc,
 dt_LinkServ,
 vtDialogs;

 function GetOldEditionData(out aEditionID : Integer; out aOldEdition : Boolean) : Boolean;
 begin
  with TOldEditionDlg.Create(nil) do
  try
   Result := Execute;
   If Result then
   begin
    aEditionID := edtDocID.AsInteger;
    aOldEdition := rgEditionKind.ItemIndex = 0;
   end;
  finally
   Free;
  end;
 end;

procedure TOldEditionDlg.OKClick(Sender: TObject);
var
 lRelFlag   : Boolean;
 lDocID     : Longint;
 lDocPresent : Boolean;
begin
 lDocPresent := False;
 lDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(edtDocID.AsInteger);
 If lDocID <> -1 then
 begin
  If DocumentServer(CurrentFamily).CheckDoc(lDocID, True, lRelFlag) then
   lDocPresent := True;
 end;

 If lDocPresent then
 begin
  vtMessageDlg(l3Fmt('Документ #%d существует. Выберите другой номер.',
       [edtDocID.AsInteger]), mtWarning);
  ActiveControl := edtDocID;
  ModalResult := mrNone;
 end;

end;

end.
