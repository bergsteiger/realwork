{*********************************************************}
{*                  STDBBARC.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit stdbpnbc;
  {-data aware bar code components}


interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, ClipBrd, Controls, Graphics, Messages, SysUtils,
  StConst, StBarPN, Db, DbCtrls, DbTables;

type
  TStDbPNBarCode = class(TStPNBarCode)
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
    property PostalCode
      stored False;

    property DataField : string
      read GetDataField
      write SetDataField;

    property DataSource : TDataSource
      read GetDataSource
      write SetDataSource;
  end;


implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  Forms,
  IniFiles,
  ShellAPI,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

{*** TStDbPNBarCode ***}

constructor TStDbPNBarCode.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);

  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
end;

procedure TStDbPNBarCode.DataChange(Sender : TObject);
begin
  if FDataLink.Field = nil then
    PostalCode := '12345'
  else
    PostalCode := FDataLink.Field.DisplayText;
end;

destructor TStDbPNBarCode.Destroy;
begin
  FDataLink.OnDataChange := nil;
  FDataLink.Free;
  FDataLink := nil;

  inherited Destroy;
end;

function TStDbPNBarCode.GetDataField : string;
begin
  Result := FDataLink.FieldName;
end;

function TStDbPNBarCode.GetDataSource : TDataSource;
begin
  Result := FDataLink.DataSource
end;

procedure TStDbPNBarCode.SetDataField(const Value : string);
begin
  FDataLink.FieldName := Value;
end;

procedure TStDbPNBarCode.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;
end;


end.