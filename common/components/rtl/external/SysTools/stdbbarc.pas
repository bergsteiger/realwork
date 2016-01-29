{*********************************************************}
{*                  STDBBARC.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StDbBarC;
  {-data aware bar code components}


interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, ClipBrd, Controls, Graphics, Messages, SysUtils,
  StConst, StBarc, Db, DbCtrls, DbTables;

type
  TStDbBarCode = class(TStBarCode)
  protected {private}
    {.Z+}
    FDataLink : TFieldDataLink;

    procedure DataChange(Sender : TObject);
    function GetDataField : string;
    function GetDataSource : TDataSource;
    procedure SetDataField(const Value : string);
    procedure SetDataSource(Value : TDataSource);

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
    {.Z+}
  published
    property Code
      stored False;

    property DataField : string
      read GetDataField
      write SetDataField;

    property DataSource : TDataSource
      read GetDataSource
      write SetDataSource;
  end;


implementation


{*** TStDbBarCode ***}

constructor TStDbBarCode.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
end;

procedure TStDbBarCode.DataChange(Sender : TObject);
begin
  if FDataLink.Field = nil then
    Code := '12345678922'
  else
    Code := FDataLink.Field.DisplayText;
end;

destructor TStDbBarCode.Destroy;
begin
  FDataLink.OnDataChange := nil;
  FDataLink.Free;
  FDataLink := nil;

  inherited Destroy;
end;

function TStDbBarCode.GetDataField : string;
begin
  Result := FDataLink.FieldName;
end;

function TStDbBarCode.GetDataSource : TDataSource;
begin
  Result := FDataLink.DataSource
end;

procedure TStDbBarCode.SetDataField(const Value : string);
begin
  FDataLink.FieldName := Value;
end;

procedure TStDbBarCode.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;
end;


end.