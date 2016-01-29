unit D_DelRpl;

{ $Id: D_DELRPL.PAS,v 1.5 2001/02/02 07:43:21 voba Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, vtSpin;

type
  TDelWithReplaceDlg = class(TForm)
    pnlButtons: TPanel;
    pnlButtonsRight: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    edtReplID: TvtSpinEdit;
  private
   DictID : Longint;
  public
    Constructor CreateParam(AOwner : TComponent; aID : Longint; aIDName : String);
    Function Execute : Boolean;
  end;

implementation

{$R *.DFM}
 Uses SysUtils, StrShop;

Constructor TDelWithReplaceDlg.CreateParam(AOwner : TComponent; aID : Longint; aIDName : String);
 //var
 // Str : String;
 begin
  Inherited Create(AOwner);
  DictID := aID;
  //Str := aIDName;
  //If (Length(Str) > 0) and (Str[Length(Str)] = ^C)
  // then Label1.Caption := Copy(Str, 1, Length(Str)-1)
  // else Label1.Caption := Str;
  Label1.Caption := aIDName;
 end;

Function TDelWithReplaceDlg.Execute : Boolean;
 Begin
  Result := ShowModal = mrOk;

  {
  Visible := True;
  repeat
   Application.HandleMessage;
   if Application.Terminated
    then ModalResult := mrCancel;
  until ModalResult <> 0;}
 end;
end.
