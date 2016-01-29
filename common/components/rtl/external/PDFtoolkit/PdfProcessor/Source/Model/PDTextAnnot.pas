{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDTextAnnot;

interface

uses
  PDBaseObject, PDDictionary, gtObject, PDElement, PDAnnot;

type
  TgtPDTextAnnot = class(TgtPDAnnot)
  private
    FOpen: Boolean;
    FState: AnsiString;
    FStateModel: AnsiString;

    function GetOpen: Boolean;
    function GetState: AnsiString;
    function GetStateModel: AnsiString;
    procedure setOpen(const Value: Boolean);
    procedure SetState(const Value: AnsiString);
    procedure SetStateModel(const Value: AnsiString);

  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    property Open: Boolean read GetOpen write setOpen;
    property State: AnsiString read GetState write SetState;
    property StateModel: AnsiString read GetStateModel write SetStateModel;

  end;

implementation

uses
  gtConstants, PDBoolean, PDModelException, PDString, gtLogger;

{ TgtPDTextAnnot }

constructor TgtPDTextAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotText;
end;

constructor TgtPDTextAnnot.Create;
begin
  inherited;
  AnnotType := annotText;
  FOpen := False;
end;

destructor TgtPDTextAnnot.Destroy;
begin

  inherited;
end;

function TgtPDTextAnnot.GetOpen: Boolean;
var
  LObject: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObject := TgtPDDictionary(FBaseObject).LookUp(PDF_OPEN);
    if Assigned(LObject) then
      if (LObject.IsBoolean) then
        FOpen := TgtPDBoolean(LObject).Value
      else
      begin
        raise ExBadAnnotation.Create(ErrBadAnnotation);
{$IFDEF DEBUG}
        Logger.LogError('Boolean Object expected');
{$ENDIF}
      end;
  end;
  Result := FOpen;
end;

function TgtPDTextAnnot.GetState: AnsiString;
var
  LObject: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObject := TgtPDDictionary(FBaseObject).LookUp(PDF_STATE);
    if Assigned(LObject) then
      if (LObject.IsString) then
        FState := TgtPDString(LObject).Value
      else
      begin
        raise ExBadAnnotation.Create(ErrBadAnnotation);
{$IFDEF DEBUG}
        Logger.LogError('AnsiString Object expected');
{$ENDIF}
      end;
  end;
  Result := FState;
end;

function TgtPDTextAnnot.GetStateModel: AnsiString;
var
  LObject: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObject := TgtPDDictionary(FBaseObject).LookUp(PDF_STATEMODEL);
    if Assigned(LObject) then
      if (LObject.IsString) then
        FStateModel := TgtPDString(LObject).Value
      else
      begin
        raise ExBadAnnotation.Create(ErrBadAnnotation);
{$IFDEF DEBUG}
        Logger.LogError('AnsiString Object expected');
{$ENDIF}
      end;
  end;
  Result := FStateModel;
end;

procedure TgtPDTextAnnot.setOpen(const Value: Boolean);
var
  LObject: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObject := TgtPDDictionary(FBaseObject).LookUp(PDF_OPEN);
    if Assigned(LObject) and LObject.IsBoolean then
    begin
      TgtPDBoolean(LObject).Value := Value;
    end
    else
    begin
      LObject := TgtPDBoolean.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_OPEN, LObject);
    end;
  end;
  FOpen := Value;
end;

procedure TgtPDTextAnnot.SetState(const Value: AnsiString);
var
  LObject: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObject := TgtPDDictionary(FBaseObject).LookUp(PDF_STATE);
    if Assigned(LObject) and LObject.IsString then
    begin
      TgtPDString(LObject).Value := Value;
    end
    else
    begin
      LObject := TgtPDString.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_STATE, LObject);
    end;
  end;
  FState := Value;
end;

procedure TgtPDTextAnnot.SetStateModel(const Value: AnsiString);
var
  LObject: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObject := TgtPDDictionary(FBaseObject).LookUp(PDF_STATEMODEL);
    if Assigned(LObject) and LObject.IsString then
    begin
      TgtPDString(LObject).Value := Value;
    end
    else
    begin
      LObject := TgtPDString.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_STATEMODEL, LObject);
    end;
  end;
  FStateModel := Value;
end;

end.
