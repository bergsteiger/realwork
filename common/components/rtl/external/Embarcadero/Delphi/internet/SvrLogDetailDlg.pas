{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SvrLogDetailDlg;

interface

uses
{$IFDEF MSWINDOWS}
  System.Win.Registry,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ActnList, SvrLogFrame, SvrLogDetailFrame, System.IniFiles;

type
  TLogDetail = class(TForm)            
    ActionList1: TActionList;
    PrevAction: TAction;
    NextAction: TAction;
    CloseAction: TAction;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    LogDetailFrame: TLogDetailFrame;
    procedure PrevActionExecute(Sender: TObject);
    procedure PrevActionUpdate(Sender: TObject);
    procedure NextActionExecute(Sender: TObject);
    procedure NextActionUpdate(Sender: TObject);
    procedure CloseActionExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FLogFrame: TLogFrame;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Load(Reg: TRegIniFile; const Section: string);
    procedure Save(Reg: TRegIniFile; const Section: string);
    property LogFrame: TLogFrame read FLogFrame write FLogFrame;
  end;

var
  FLogDetail: TLogDetail;

implementation

{$R *.dfm}

procedure TLogDetail.PrevActionExecute(Sender: TObject);
begin
  FLogFrame.Previous;
  FLogFrame.ShowDetail(LogDetailFrame);
end;

procedure TLogDetail.PrevActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := FLogFrame.Index > 0;
  if not ((Sender as TAction).Enabled) and (ActiveControl = Button1) then
    Button3.SetFocus;
end;

procedure TLogDetail.NextActionExecute(Sender: TObject);
begin
  FLogFrame.Next;
  FLogFrame.ShowDetail(LogDetailFrame);
end;

procedure TLogDetail.NextActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (FLogFrame.Count > 0)
    and (FLogFrame.Index < FLogFrame.Count - 1);
  if (not (Sender as TAction).Enabled) and (ActiveControl = Button2) then
    Button3.SetFocus;
end;

constructor TLogDetail.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TLogDetail.CloseActionExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

const
  sLeft = 'Left';
  sTop = 'Top';
  sWidth = 'Width';
  sHeight = 'Height';

procedure TLogDetail.Load(Reg: TRegIniFile; const Section: string);
begin
  if Reg.ReadInteger(Section, sLeft, 0) <> 0 then
  begin
    Position := poDesigned;
    Self.Left := Reg.ReadInteger(Section, sLeft, Self.Left);
    Self.Top := Reg.ReadInteger(Section, sTop, Self.Top);
    Self.Width := Reg.ReadInteger(Section, sWidth, Self.Width);
    Self.Height := Reg.ReadInteger(Section, sHeight, Self.Height);
  end;
  LogDetailFrame.Load(Reg, Section);
end;

procedure TLogDetail.Save(Reg: TRegIniFile; const Section: string);
begin
  LogDetailFrame.Save(Reg, Section);
  Reg.WriteInteger(Section, sLeft, Self.Left);
  Reg.WriteInteger(Section, sTop, Self.Top);
  Reg.WriteInteger(Section, sWidth, Self.Width);
  Reg.WriteInteger(Section, sHeight, Self.Height);
end;

procedure TLogDetail.FormShow(Sender: TObject);
begin
  FLogFrame.ShowDetail(LogDetailFrame);
  LogDetailFrame.Memo1.SetFocus;
end;

end.
