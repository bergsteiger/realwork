{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCProcessDlg;

{$I DC.inc}

interface

uses
  StdCtrls, Buttons, Controls, ExtCtrls, Classes, ComCtrls, Forms,

  DCConsts,
  DCButtonPanel;

type
  TDCPosType = ( psPassStep, psStartStep, psCommitStep, psShowMessage );

  TDCProcessForm = class;
  TDCTerminateEvent = Procedure( ASender : TDCProcessForm ) of object;
  TDCTerminateEventEx = Procedure( ASender : TDCProcessForm );

  TDCProcessForm = class(TForm)
    ProgressBar: TProgressBar;
    StatusLabel: TLabel;
    StatusMemo: TMemo;
    ButtonPanel: TDCButtonPanel;
    CloseButton: TBitBtn;
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StatusMemoKeyPress(Sender: TObject; var Key: Char);
    procedure CloseButtonClick(Sender: TObject);
  private
    Processes : TList;
    FCanClose : Boolean;

    FCancelBtnEnabled   : Boolean;
    FOnTerminateEvent   : TDCTerminateEvent;
    FOnTerminateEventEx : TDCTerminateEventEx;
    
    FSimpleBar          : Boolean;

    Procedure SetOnTerminateEvent( AValue : TDCTerminateEvent );
    Procedure SetOnTerminateEventEx( AValue : TDCTerminateEventEx );
    procedure SetSimpleBar( AValue : Boolean );
  protected
    Procedure DoTerminateEvent; virtual;
    Procedure InitCloseBtn;

    Property CanClose : Boolean Read FCanClose Write FCanClose;

    Procedure StartNewProcess( ANumber : Integer );
    Procedure PassStep;
    Procedure CommitProcess;
  public
    Constructor Create( AOwner : TComponent ); override;
    Destructor Destroy; Override;

    Property SimpleBar : Boolean Read FSimpleBar Write SetSimpleBar;

    Procedure ShowProgressDialog( AMaxCount : Integer; Const AWindowHeader : String );
    Procedure SetStatus( APos: Integer; APosType: TDCPosType; Const ABottomLabel : String );
    Procedure FinishProcess( Const AWindowHeader : String ); 

    Property OnTerminateEvent   : TDCTerminateEvent   Read FOnTerminateEvent   Write SetOnTerminateEvent;
    Property OnTerminateEventEx : TDCTerminateEventEx Read FOnTerminateEventEx Write SetOnTerminateEventEx;
  end;

var
  DCProcessForm: TDCProcessForm;

implementation

{$R *.DFM}

{------------------------------------------------------------------}

Const
  MinStepLength = 2;
  
{------------------------------------------------------------------}

Type
  TProcessInfo = class
    MaxStep       : Integer;
    Step          : Integer;
    Jump          : Integer;
    OldPos        : Integer;
    Length        : Integer;
  public
    Constructor Create( ProgressBar : TProgressBar; AOldPos, ALength, AMaxStep : Integer ); Virtual;
  End;

{------------------------------------------------------------------}

{ TDCProcessForm }

Procedure TDCProcessForm.FinishProcess( Const AWindowHeader : String );
begin
  Caption := AWindowHeader;
  CommitProcess;
  FCanClose := True;
  Hide;

  If SimpleBar Then
    Exit;
    
  ProgressBar.Position := ProgressBar.Max;
  CloseButton.Caption := SVerbClose;
  CloseButton.Enabled := True;
  FCancelBtnEnabled := False;
  ShowModal;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.SetStatus( APos : Integer; APosType : TDCPosType;
  Const ABottomLabel : String );
begin
  If ( APosType = psShowMessage ) Or ( ABottomLabel <> '' ) Then
    StatusMemo.Lines.Add( ABottomLabel );

  Case APosType Of
    psPassStep    : PassStep;
    psStartStep   : StartNewProcess( APos );
    psCommitStep  : CommitProcess;
    psShowMessage : ;
{    psAbsolute : ProgressBar.Position := APos;
    psShift    : ProgressBar.Position := ProgressBar.Position + APos;}
  End;
  Application.ProcessMessages;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.ShowProgressDialog( AMaxCount : Integer; Const AWindowHeader : String );
begin
  StatusMemo.Lines.Clear;
  InitCloseBtn;

  FCanClose := False;
  ProgressBar.Position := 0;
  Caption := AWindowHeader;
  Show;
  StartNewProcess( AMaxCount );
  Update;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.StatusMemoKeyPress( Sender : TObject; Var Key : Char );
begin
  If Key In [#13, #27] Then
    Close;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.CloseButtonClick( Sender : TObject );
begin
  CanClose := True;
  If FCancelBtnEnabled Then
    DoTerminateEvent
  Else
    Close;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.SetOnTerminateEvent( AValue : TDCTerminateEvent );
begin
  FOnTerminateEvent := AValue;
  InitCloseBtn;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.SetOnTerminateEventEx( AValue : TDCTerminateEventEx );
begin
  FOnTerminateEventEx := AValue;
  InitCloseBtn;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.DoTerminateEvent;
begin
  If Assigned( FOnTerminateEvent ) Then
    FOnTerminateEvent( Self );
  If Assigned( FOnTerminateEventEx ) Then
    FOnTerminateEventEx( Self );
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.InitCloseBtn;
begin
  CloseButton.Enabled := Assigned( FOnTerminateEvent ) Or Assigned( FOnTerminateEventEx );
  FCancelBtnEnabled := CloseButton.Enabled;
  If FCancelBtnEnabled Then
    CloseButton.Caption := SCancelButton
  Else
    CloseButton.Caption := SVerbClose;
end;

{------------------------------------------------------------------}

Constructor TDCProcessForm.Create( AOwner : TComponent );
begin
  Inherited;
  Processes := TList.Create;
  ProgressBar.Step := ProgressBar.Max;
  
  StatusLabel.Caption := sDCProcessStatusLabelCaption;
end;

{------------------------------------------------------------------}

procedure TDCProcessForm.FormDeactivate(Sender: TObject);
begin
  If Visible Then
    SetFocus;
end;

{------------------------------------------------------------------}

procedure TDCProcessForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Not FCanClose Then
    Action := caNone;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.CommitProcess;
begin
  If Processes.Count = 0 Then
    Exit;
  With TProcessInfo( Processes[ Processes.Count - 1 ] ) Do
  begin
    ProgressBar.Position := OldPos + Length;
    ProgressBar.Step := Length;
    Free;
  end;
  Processes.Count := Processes.Count - 1;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.PassStep;
begin
  If Processes.Count = 0 Then
    Exit;
  With TProcessInfo( Processes[ Processes.Count - 1 ] ) Do
  begin
    If MaxStep = 0 Then
      Exit;
    Inc( Step );
    If Step >= MaxStep Then
      Exit;
    If Step Mod Jump = 0 Then
      ProgressBar.Position := OldPos + ( Step * Length ) Div MaxStep; 
  end;
end;

{------------------------------------------------------------------}

Destructor TDCProcessForm.Destroy;
Var
  I : Integer;
begin
  For I := 0 To Processes.Count - 1 Do
    TObject( Processes[ I ] ).Free;
  Processes.Free;
  inherited;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.StartNewProcess( ANumber : Integer );
begin
  Processes.Add( TProcessInfo.Create( ProgressBar, ProgressBar.Position, ProgressBar.Step, ANumber ) );
  With TProcessInfo( Processes[ Processes.Count - 1 ] ) Do
    ProgressBar.Step := Length Div MaxStep;
end;

{------------------------------------------------------------------}

Procedure TDCProcessForm.SetSimpleBar( AValue : Boolean );
begin
  If FSimpleBar = AValue Then
    Exit;
  FSimpleBar := AValue;
  StatusLabel.Visible := Not AValue;
  StatusMemo.Visible := Not AValue;
  ButtonPanel.Visible := Not AValue;
  If AValue Then
    Height := 68
  Else
    Height := 242;
end;

{------------------------------------------------------------------}

{ TProcessInfo }

Constructor TProcessInfo.Create( ProgressBar : TProgressBar; AOldPos, ALength, AMaxStep : Integer );
begin
  Inherited Create;
  MaxStep := AMaxStep;
  Step    := 0;
  OldPos := AOldPos;
  Length := ALength;

  If MaxStep = 0 Then
    Exit;
  If ALength <= MinStepLength Then
    Jump := AMaxStep
  Else
    If ( ALength Div MinStepLength ) Div AMaxStep > MinStepLength Then
      Jump := 1
    Else
      Jump := AMaxStep Div ( ALength Div MinStepLength ) + 1;
end;

{------------------------------------------------------------------}

end.
