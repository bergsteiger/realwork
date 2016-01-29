unit ddProgressDlg;
{ $Id: ddProgressDlg.pas,v 1.6 2013/04/11 16:46:28 lulin Exp $ }

// $Log: ddProgressDlg.pas,v $
// Revision 1.6  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.5  2005/02/16 17:11:54  narry
// - update: альтернативный расчет времени окончания процесса
//
// Revision 1.4  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.3  2003/02/05 11:48:43  narry
// - update & bug fix
//
// Revision 1.2  2002/10/18 15:00:34  narry
// - update
//

{$I ddDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,
  ddProgressTypes;

type
  TddProgressDialog = class(TForm)
    rbLocal: TGroupBox;
    lblMessage: TLabel;
    pbLocal: TProgressBar;
    lblLocalDone: TLabel;
    lblLocalSpeed: TLabel;
    lblLocalElapsed: TLabel;
    lblLocalRemaining: TLabel;
    gbTotal: TGroupBox;
    pbTotal: TProgressBar;
    lblTotalDone: TLabel;
    lblTotalSpeed: TLabel;
    lblTotalElapsed: TLabel;
    lblTotalRemaining: TLabel;
    lbLogProcess: TListBox;
    Button1: TButton;
    cbShowDetails: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure cbShowDetailsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
   f_Mode      : TddProgressMode; // Режим обсчета
   f_OnAbort : TNotifyEvent;
   f_ShowDetails: Boolean;
  protected
   procedure SetMode(Value: TddProgressMode);
  public
    { Public declarations }
   procedure AddToDetails(const S: AnsiString);
   property Mode: TddProgressMode
      read f_Mode write SetMode;
   property OnAbort: TNotifyEvent
    read f_OnAbort
    write f_OnAbort;
   property ShowDetails: Boolean
    read f_ShowDetails;
  end;

var
  ddProgressDialog: TddProgressDialog;

implementation

{$R *.dfm}


{ Окошко }

procedure TddProgressDialog.SetMode(Value: TddProgressMode);
begin
 if Mode <> Value then
 begin
  f_Mode:= Value;
  gbTotal.Enabled:= Mode = dd_pmDual;
  pbTotal.Enabled:= Mode = dd_pmDual;
  lblTotalDone.Enabled:= Mode = dd_pmDual;
  lblTotalSpeed.Enabled:= Mode = dd_pmDual;
  lblTotalElapsed.Enabled:= Mode = dd_pmDual;
  lblTotalRemaining.Enabled:= Mode = dd_pmDual;
 end; // Mode <> Value
end;

procedure TddProgressDialog.AddToDetails(const S: AnsiString);
begin
 if ShowDetails then
 begin
  if lbLogProcess.Items.Count = High(Integer) then
   lbLogProcess.Items.Clear;
  try
   lbLogProcess.Items.Add(S);
  except
   lbLogProcess.Items.Clear;
   lbLogProcess.Items.Add(S);
  end;
  lbLogProcess.ItemIndex:= Pred(lbLogProcess.Items.Count);
 end;
end;

procedure TddProgressDialog.BitBtn1Click(Sender: TObject);
begin
 if Assigned(f_OnAbort) then
 begin
  if MessageDlg('Вы действительно хотите прервать процесс?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
   f_OnAbort(Self);
   Button1.Enabled:= False;
   AddToDetails('Прерывание процесса...');
  end;
 end;
end;

procedure TddProgressDialog.cbShowDetailsClick(Sender: TObject);
begin
 if not cbShowDetails.Checked then
  lbLogProcess.Items.Clear;
 f_ShowDetails:= cbShowDetails.Checked;
end;

procedure TddProgressDialog.FormCreate(Sender: TObject);
begin
 f_ShowDetails:= True;
end;

end.
