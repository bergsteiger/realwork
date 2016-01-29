{*********************************************************}
{*                  STNETPFM.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}
{$H+} {Huge strings}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{$IFNDEF VERSION2}
  !! Error: This unit cannot be compiled with Delphi 1 or CBuilder 1
{$ENDIF}

unit StNetPfm;

interface

uses
  Windows, Classes, StBase;

type
  TStCPFlags = (cpfForNetCard, cpfNotRouted, cpfSlowLink, cpfDynamic);
  TStCPFlagsSet = set of TStCPFlags;

  TStNetPerformance = class(TStComponent)
   private   { Private Methods/Properties   }
    FGotData     : Boolean;

    { Input }
    FLocalName   : string;
    FRemoteName  : string;
    FProviderName: string;

    { Output }
    FFlags       : TStCPFlagsSet;
    FSpeed       : DWord;
    FDelay       : DWord;
    FOptDataSize : DWord;
   protected { Protected Methods/Properties }
    function GetFlags: TStCPFlagsSet;
    function GetSpeed: DWord;
    function GetDelay: DWord;
    function GetOptDataSize : DWord;

    procedure SetLocalName(Value: string);
    procedure SetRemoteName(Value: string);
    procedure SetProviderName(Value: string);
   public    { Public Methods/Properties    }
    procedure QueryPerformance;

    property Flags: TStCPFlagsSet read GetFlags;
    property Speed: DWord read GetSpeed;
    property Delay: DWord read GetDelay;
    property OptDataSize: DWord read GetOptDataSize;

   published { Published Methods/Properties }
    property LocalName: string
      read FLocalName write SetLocalName;
    property RemoteName: string
      read FRemoteName write SetRemoteName;
    property ProviderName: string
      read FProviderName write SetProviderName;
  end;


implementation

uses SysUtils
{$IFDEF TRIALRUN}
  , Registry,
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
{$ELSE}
  ;
{$ENDIF}

procedure TStNetPerformance.QueryPerformance;
var
  Err : DWord;
  NR  : TNetResource;
  CI  : TNetConnectInfoStruct;
begin
  FillChar(NR, SizeOf(NR), 0);
  FillChar(CI, SizeOf(CI), 0);

  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  if FLocalName <> '' then
    NR.lpLocalName := PAnsiChar(FLocalName)
  else
    NR.lpRemoteName := PAnsiChar(FRemoteName);

  if Length(FProviderName) > 0 then
    NR.lpProvider := PAnsiChar(FProviderName);

  CI.cbStructure := SizeOf(CI);

  Err := MultinetGetConnectionPerformance(@NR, @CI);
  if Err = NO_ERROR then begin
    FFlags := [];
    if (CI.dwFlags and WNCON_FORNETCARD) = WNCON_FORNETCARD then
      Include(FFlags, cpfForNetCard);
    if (CI.dwFlags and WNCON_NOTROUTED) = WNCON_NOTROUTED then
      Include(FFlags, cpfNotRouted);
    if (CI.dwFlags and WNCON_SLOWLINK) = WNCON_SLOWLINK then
      Include(FFlags, cpfSlowLink);
    if (CI.dwFlags and WNCON_DYNAMIC) = WNCON_DYNAMIC then
      Include(FFlags, cpfDynamic);

    FSpeed       := CI.dwSpeed;
    FDelay       := CI.dwDelay;
    FOptDataSize := CI.dwOptDataSize;

    FGotData := True;
  end else
    RaiseStWin32Error(EStNetException, Err);
end;

function TStNetPerformance.GetFlags: TStCPFlagsSet;
begin
  if not FGotData then
    QueryPerformance;
  Result := FFlags;
end;

function TStNetPerformance.GetSpeed: DWord;
begin
  if not FGotData then
    QueryPerformance;
  Result := FSpeed;
end;

function TStNetPerformance.GetDelay: DWord;
begin
  if not FGotData then
    QueryPerformance;
  Result := FDelay;
end;

function TStNetPerformance.GetOptDataSize : DWord;
begin
  if not FGotData then
    QueryPerformance;
  Result := FOptDataSize;
end;

procedure TStNetPerformance.SetLocalName(Value: string);
begin
  if Value <> FLocalName then begin
    FLocalName := Value;
    FGotData := False;
  end;
end;

procedure TStNetPerformance.SetRemoteName(Value: string);
begin
  if Value <> FRemoteName then begin
    FRemoteName := Value;
    FGotData := False;
  end;
end;

procedure TStNetPerformance.SetProviderName(Value: string);
begin
  if Value <> FProviderName then begin
    FProviderName := Value;
    FGotData := False;
  end;
end;


end.
