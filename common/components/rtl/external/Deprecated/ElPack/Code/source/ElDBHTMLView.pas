{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

unit ElDBHTMLView;

interface

uses
     DB,
     DBCtrls,

     ElHTMLView,

     Forms,
     Windows,
     Controls,
     StdCtrls,
     Messages,
{$ifdef VCL_6_USED}
Types,
{$endif}
     ElStrUtils,
     ElDBConst,
     Classes,
     SysUtils;

type

    TElDBHTMLView = class(TElHTMLView)
    private
      FDataLink: TFieldDataLink;
      procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
      procedure DataChange(Sender: TObject);
      function GetDataField: string;
      function GetDataSource: TDataSource;
      function GetField: TField;
      procedure SetDataField(const Value: string);
      procedure SetDataSource(Value: TDataSource);
    protected
      FUnicodeMode: TElDBUnicodeMode;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      {$ifdef VCL_4_USED}
      function ExecuteAction(Action: TBasicAction): Boolean; override;
      function UpdateAction(Action: TBasicAction): Boolean; override;
      function UseRightToLeftAlignment: Boolean; override;
      {$endif}
      property Field: TField read GetField;
    published
      property DataField: string read GetDataField write SetDataField;
      property DataSource: TDataSource read GetDataSource write SetDataSource;
      property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
          default umFieldType;
    end;

implementation

constructor TElDBHTMLView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
end;

destructor TElDBHTMLView.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBHTMLView.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TElDBHTMLView.DataChange(Sender: TObject);
{$ifdef ELPACK_UNICODE}
var S : WideString;
{$endif}
begin
  if not FDataLink.Active then
  begin
    if csDesigning in ComponentState then
      Caption := Name
    else
      Caption := ''
  end
  else
  if FDataLink.Field <> nil then
  {$ifdef ELPACK_UNICODE}
    if FDataLink.Field.isNull then
      S := ''
    else
    if (UnicodeMode = umForceUTF8) and
       (ConvertUTF8toUTF16(FDataLink.Field.DisplayText, S, strictConversion, false) <> sourceIllegal)
    then
    else
    begin
      if (FDataLink.Field.DataType = ftWideString) then
        S := FDataLink.Field.Value
      else
        S := FDataLink.Field.AsString;
    end;
    Caption := S;
  {$else}
    Caption := FDataLink.Field.AsString;
  {$endif}
end;

{$ifdef VCL_4_USED}
function TElDBHTMLView.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;
{$endif}

function TElDBHTMLView.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBHTMLView.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBHTMLView.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TElDBHTMLView.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBHTMLView.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBHTMLView.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

{$ifdef VCL_4_USED}
function TElDBHTMLView.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

function TElDBHTMLView.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;
{$endif}

end.
