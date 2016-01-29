unit D_DictItemEdit;

{ $Id: D_DictItemEdit.pas,v 1.5 2015/07/02 07:34:41 lukyanets Exp $ }

interface

uses 
  WinTypes, 
  WinProcs, 
  Classes, 
  Graphics, 

  Forms, 
  Controls, 
  Buttons,
  StdCtrls, 
  ExtCtrls, 
  OvcBase, 

  l3Types, 
  l3Interfaces, 

  evEditorWindow, 
  evEditor, 
  evMemo,

  BottomBtnDlg, 

  TB97Ctls, 

  evMultiSelectEditorWindow, 
  evCustomEditor,
  evEditorWithOperations, 
  evTextSource,

  daTypes,

  Dt_Types, dt_AttrSchema,
  afwControl, F_DictItemEdit;

type
  TDictItemEditDlg = class(TBottomBtnDlg)
    Frame1: TDictItemEditFrame;

    procedure OKClick(Sender: TObject);
  private
    fROnly     : Boolean;
//    fBiLingual : Boolean;
  protected
    procedure SetROnly(aValue : Boolean); virtual;

  public
    function Execute(aDictID : TdaDictionaryType) : Boolean;
    property ROnly : Boolean read fROnly write SetROnly;
  end;

implementation

{$R *.DFM}

uses
  Dialogs,
  vtDialogs,
  SysUtils,
  StrShop,
  evTypes,
  ddSpell, Main,
  l3Base,
  l3String
  ;

function TDictItemEditDlg.Execute(aDictID : TdaDictionaryType) : Boolean;
begin
 Frame1.Init(aDictID);
 Result := ShowModal = mrOk;
end;

procedure TDictItemEditDlg.OKClick(Sender: TObject);
begin
 if not Frame1.Validate then
  ModalResult := mrNone;
end;

procedure TDictItemEditDlg.SetROnly(aValue : Boolean);
begin
 Frame1.SetROnly(aValue);
 OK.Enabled := not aValue;
end;

(*
procedure TDictItemEditDlg.SetBiLingual(aValue : Boolean);
begin
 fBiLingual := aValue;
 If fBiLingual then
 begin
  mNameRus.Height := (pnlName.ClientHeight - TControl(mNameRus).Left) div 2 - TControl(mNameRus).Top;

  lblNameEng.Top := (pnlName.ClientHeight - TControl(mNameRus).Left) div 2 + lblNameRus.Top;
  lblNameEng.Visible := True;

  TControl(mNameEng).Top := (pnlName.ClientHeight - TControl(mNameRus).Left) div 2 + TControl(mNameRus).Top;
  mNameEng.Height := pnlName.ClientHeight - TControl(mNameEng).Top - TControl(mNameRus).Left;
  //mNameRus.Height;

  lblNameRus.Caption := sidNameRus;
  mNameEng.Visible := True;
 end
 else
 begin
  mNameRus.Height := pnlName.ClientHeight - TControl(mNameRus).Top - TControl(mNameRus).Left;

  lblNameEng.Visible := False;
  lblNameRus.Caption := sidName;
  mNameEng.Visible := False;
 end;
end;
*)

(*procedure TDictItemEditDlg.pnlNameResize(Sender: TObject);
begin
  inherited;
  SetBiLingual(fBiLingual);
end;
*)

end.


