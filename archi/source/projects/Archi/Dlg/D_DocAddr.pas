unit D_DocAddr;

{ $Id: D_DocAddr.pas,v 1.6 2007/04/23 08:36:03 voba Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg,
  StdCtrls, vtSpin, Buttons, ExtCtrls,
  DT_Types, ActnList, tb97GraphicControl, TB97Ctls, vtSpeedButton;

type
  TDocAddrDlg = class(TBottomBtnDlg)
    lblDocID: TLabel;
    lblSubID: TLabel;
    edtDocID: TvtSpinEdit;
    edtSubID: TvtSpinEdit;
    ActionList1: TActionList;
    acPaste: TAction;
    btnPasteAddr: TSpeedButton;
    procedure OKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure acPasteExecute(Sender: TObject);
   private
    function IsNemesisAddrInClipboard: Boolean;
    function PasteNemesisAddr : boolean;
   protected
    procedure WMActivateApp(var Message: TMessage); message WM_ACTIVATEAPP;
   public
    function Execute(Var aAddrRec : TGlobalCoordinateRec) : boolean; reintroduce;
    //property DocID : Integer read GetDocID write SetDocID;
    //property SubID : Integer read GetDocID write SetDocID;
  end;

//function RequestDocAddr(var aValue : Integer; AOwner: TComponent;
//                                 aCaption : String = ''; aLabel : String = '') : Boolean;

implementation
uses
 Clipbrd,
 Main;

{$R *.DFM}

var
 gSaveDocID : integer;

function TDocAddrDlg.Execute(Var aAddrRec : TGlobalCoordinateRec) : boolean;
 begin
  with aAddrRec do
  begin
   //if not PasteNemesisAddr then
   //begin
    edtDocID.AsInteger := Doc;
    edtSubID.AsInteger := Sub;
    If edtDocID.AsInteger = 0 then
     edtDocID.AsInteger := gSaveDocID;
   //end;
   Result := ShowModal = mrOK;
   If Result then
   begin
    Doc := edtDocID.AsInteger;
    Sub := edtSubID.AsInteger;

    gSaveDocID := Doc;
   end;
  end;
 end;

function TDocAddrDlg.IsNemesisAddrInClipboard: Boolean;
var
 l_Clip: string;
 I: Integer;
 l_DotCount: Integer;
begin
 Result := False;
 l_Clip := Clipboard.AsText;
 if l_Clip <> '' then
 begin
  l_DotCount := 0;
  for I := 1 to Length(l_Clip) do
   case l_Clip[I] of
    '0'..'9': ;
    '.'     : Inc(l_DotCount);
   else
    Exit;
   end;
  Result := (l_DotCount = 1);
 end;
end;

(* function RequestIntegerValue(var aValue : Integer; AOwner: TComponent;
                                  aCaption : String = ''; aLabel : String = '') : Boolean;
  begin
   With TIntegerEditDlg.Create(AOwner) do
    try
     Caption := aCaption;
     LabelText := aLabel;
     Value := aValue;
     Result := Execute;
     If Result then aValue := Value;
    finally
     Free;
    end;
  end;
*)
procedure TDocAddrDlg.OKClick(Sender: TObject);
begin
 If edtDocID.AsInteger <= 0 then
 begin
  ModalResult := mrNone;
  ActiveControl := edtDocID;
 end;
end;

function TDocAddrDlg.PasteNemesisAddr : boolean;
var
 l_Clip: string;
 l_DotPos: Integer;
begin
 Result := IsNemesisAddrInClipboard;
 if Result then
 begin
  l_Clip := Clipboard.AsText;
  l_DotPos := Pos('.', l_Clip);
  edtDocID.Text := System.Copy(l_Clip, 1, l_DotPos-1);
  edtSubID.Text := System.Copy(l_Clip, l_DotPos+1, MaxInt);
 end;
end;

procedure TDocAddrDlg.FormActivate(Sender: TObject);
begin
 //btnPasteAddr.Enabled := IsNemesisAddrInClipboard;
end;

procedure TDocAddrDlg.WMActivateApp(var Message: TMessage);
begin
 inherited;
 //btnPasteAddr.Enabled := IsNemesisAddrInClipboard;
end;

procedure TDocAddrDlg.acPasteExecute(Sender: TObject);
begin
 // если не можем вставить как адрес, вставим как есть
 if not PasteNemesisAddr then
  Paste;
end;

end.
