{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2011 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }

unit gtXportIntf;

interface

uses
  Classes, gtclasses3, gtCstDocEng, Dialogs;

type

  TgtExportInterface = class(TgtBaseComponent)
  private
    FVisible: Boolean;
    FEngine: TgtCustomDocumentEngine;
    FAlreadyPrepared: Boolean;
    FDoBeginDoc: Boolean;
    FDoEndDoc: Boolean;
    FDocStarted: Boolean;
    FAfterEndDoc: TgtNotifyEvent;

    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetVisible(const Value: Boolean);
    procedure SetAlreadyPrepared(const Value: Boolean);
    procedure SetDoBeginDoc(const Value: Boolean);
    procedure SetDoEndDoc(const Value: Boolean);
    procedure SetDocStarted(const Value: Boolean);
    procedure OnEngineEndDoc(Sender: TgtCustomDocumentEngine);

  protected
    property AlreadyPrepared: Boolean read FAlreadyPrepared write
      SetAlreadyPrepared default True;
    property DocStarted
      : Boolean read FDocStarted write SetDocStarted default False;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;

    procedure StartDocument;
    procedure EndDocument;
    procedure InsertPage;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Engine: TgtCustomDocumentEngine read FEngine write SetEngine;
    property Visible: Boolean read FVisible write SetVisible default True;
    property DoBeginDoc: Boolean read FDoBeginDoc write SetDoBeginDoc;
    property DoEndDoc: Boolean read FDoEndDoc write SetDoEndDoc;
  end;

implementation

{ TgtExportInterface }

constructor TgtExportInterface.Create(AOwner: TComponent);
begin
  inherited;
  FAlreadyPrepared := True;
  FVisible := True;
  FEngine := nil;
  FDoBeginDoc := True;
  FDoEndDoc := True;
end;

destructor TgtExportInterface.Destroy;
begin

  inherited;
end;

procedure TgtExportInterface.EndDocument;
begin
  if DoEndDoc then
  begin
    IgtDocumentEngine(FEngine).EndDoc;
  end;
  DocStarted := False;
end;

procedure TgtExportInterface.InsertPage;
begin
  IgtDocumentEngine(FEngine).NewPage;
end;

procedure TgtExportInterface.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FEngine) then
    FEngine := nil;
end;

procedure TgtExportInterface.OnEngineEndDoc(Sender: TgtCustomDocumentEngine);
begin
  if Assigned(FAfterEndDoc) then
    FAfterEndDoc(Sender);
  DocStarted := False;
  FEngine.OnAfterEndDoc := FAfterEndDoc;
  FAfterEndDoc := nil;
end;

procedure TgtExportInterface.SetAlreadyPrepared(const Value: Boolean);
begin
  FAlreadyPrepared := Value;
end;

procedure TgtExportInterface.SetDoBeginDoc(const Value: Boolean);
begin
  FDoBeginDoc := Value;
end;

procedure TgtExportInterface.SetDocStarted(const Value: Boolean);
begin
  FDocStarted := Value;
end;

procedure TgtExportInterface.SetDoEndDoc(const Value: Boolean);
begin
  FDoEndDoc := Value;
  if ((not Value) and (FEngine <> nil)) then
  begin
    FAfterEndDoc := FEngine.OnAfterEndDoc;
    FEngine.OnAfterEndDoc := OnEngineEndDoc;
  end;
end;

procedure TgtExportInterface.SetEngine(const Value: TgtCustomDocumentEngine);
begin
  FEngine := Value;
end;

procedure TgtExportInterface.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

procedure TgtExportInterface.StartDocument;
begin
  if DoBeginDoc and (not DocStarted) then
    IgtDocumentEngine(FEngine).BeginDoc
  else if DocStarted then
    IgtDocumentEngine(FEngine).NewPage;
  DocStarted := True;
end;

end.
