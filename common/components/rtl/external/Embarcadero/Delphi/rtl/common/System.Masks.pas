{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Masks;

{$WARN WIDECHAR_REDUCED OFF}

interface

uses System.SysUtils;

type
  EMaskException = class(Exception);

  TMask = class
  private type
    // WideChar Reduced to ByteChar in set expressions.
    TMaskSet = set of Char;
    PMaskSet = ^TMaskSet;
    TMaskStates = (msLiteral, msAny, msSet, msMBCSLiteral);
    TMaskState = record
      SkipTo: Boolean;
      case State: TMaskStates of
        msLiteral: (Literal: Char);
        msAny: ();
        msSet: (
          Negate: Boolean;
          CharSet: PMaskSet);
        msMBCSLiteral: (LeadByte, TrailByte: Char);
    end;

  private
    FMaskStates: array of TMaskState;

  protected
    function InitMaskStates(const Mask: string): Integer;
    procedure DoneMaskStates;
    function MatchesMaskStates(const Filename: string): Boolean;

  public
    constructor Create(const MaskValue: string);
    destructor Destroy; override;
    function Matches(const Filename: string): Boolean;
  end;


function MatchesMask(const Filename, Mask: string): Boolean;

implementation

uses System.RTLConsts;

const
  MaxCards = 30;

function TMask.InitMaskStates(const Mask: string): Integer;
var
  I: Integer;
  SkipTo: Boolean;
  Literal: Char;
  LeadByte, TrailByte: Char;
  P: PChar;
  Negate: Boolean;
  CharSet: TMaskSet;
  Cards: Integer;

  procedure InvalidMask;
  begin
    raise EMaskException.CreateResFmt(@SInvalidMask, [Mask,
      P - PChar(Mask) + 1]);
  end;

  procedure Reset;
  begin
    SkipTo := False;
    Negate := False;
    CharSet := [];
  end;

  procedure WriteScan(MaskState: TMaskStates);
  begin
    if I <= High(FMaskStates) then
    begin
      if SkipTo then
      begin
        Inc(Cards);
        if Cards > MaxCards then InvalidMask;
      end;
      FMaskStates[I].SkipTo := SkipTo;
      FMaskStates[I].State := MaskState;
      case MaskState of
        msLiteral: FMaskStates[I].Literal := UpCase(Literal);
        msSet:
          begin
            FMaskStates[I].Negate := Negate;
            New(FMaskStates[I].CharSet);
            FMaskStates[I].CharSet^ := CharSet;
          end;
        msMBCSLiteral:
          begin
            FMaskStates[I].LeadByte := LeadByte;
            FMaskStates[I].TrailByte := TrailByte;
          end;
      end;
    end;
    Inc(I);
    Reset;
  end;

  procedure ScanSet;
  var
    LastChar: Char;
    C: Char;
  begin
    Inc(P);
    if P^ = '!' then
    begin
      Negate := True;
      Inc(P);
    end;
    LastChar := #0;
    while not (P^ in [#0, ']']) do
    begin
      // MBCS characters not supported in msSet!
      if IsLeadChar(P^) then
         Inc(P)
      else
      case P^ of
        '-':
          if LastChar = #0 then InvalidMask
          else
          begin
            Inc(P);
            for C := LastChar to UpCase(P^) do
              CharSet := CharSet + [C];
          end;
      else
        LastChar := UpCase(P^);
        CharSet := CharSet + [LastChar];
      end;
      Inc(P);
    end;
    if (P^ <> ']') or (CharSet = []) then InvalidMask;
    WriteScan(msSet);
  end;

begin
  P := PChar(Mask);
  I := 0;
  Cards := 0;
  Reset;
  while P^ <> #0 do
  begin
    case P^ of
      '*': SkipTo := True;
      '?': if not SkipTo then WriteScan(msAny);
      '[':  ScanSet;
    else
      if IsLeadChar(P^) then
      begin
        LeadByte := P^;
        Inc(P);
        TrailByte := P^;
        WriteScan(msMBCSLiteral);
      end
      else
      begin
        Literal := P^;
        WriteScan(msLiteral);
      end;
    end;
    Inc(P);
  end;
  Literal := #0;
  WriteScan(msLiteral);
  Result := I;
end;

function TMask.MatchesMaskStates(const Filename: string): Boolean;
type
  TStackRec = record
    sP: PChar;
    sI: Integer;
  end;
var
  T: Integer;
  S: array of TStackRec;
  I: Integer;
  P: PChar;

  procedure Push(P: PChar; I: Integer);
  begin
    S[T].sP := P;
    S[T].sI := I;
    Inc(T);
  end;

  function Pop(var P: PChar; var I: Integer): Boolean;
  begin
    if T = 0 then
      Result := False
    else
    begin
      Dec(T);
      P := S[T].sP;
      I := S[T].sI;
      Result := True;
    end;
  end;

  function Matches(P: PChar; Start: Integer): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := Start to High(FMaskStates) do
    begin
      if FMaskStates[I].SkipTo then
      begin
        case FMaskStates[I].State of
          msLiteral:
            while (P^ <> #0) and (UpCase(P^) <> FMaskStates[I].Literal) do Inc(P);
          msSet:
            while (P^ <> #0) and not (FMaskStates[I].Negate xor (UpCase(P^) in FMaskStates[I].CharSet^)) do Inc(P);
          msMBCSLiteral:
            while (P^ <> #0) do
            begin
              if (P^ <> FMaskStates[I].LeadByte) then Inc(P, 2)
              else
              begin
                Inc(P);
                if (P^ = FMaskStates[I].TrailByte) then Break;
                Inc(P);
              end;
            end;
        end;
        if P^ <> #0 then
          Push(@P[1], I);
      end;
      case FMaskStates[I].State of
        msLiteral: if UpCase(P^) <> FMaskStates[I].Literal then Exit;
        msSet: if not (FMaskStates[I].Negate xor (UpCase(P^) in FMaskStates[I].CharSet^)) then Exit;
        msMBCSLiteral:
          begin
            if P^ <> FMaskStates[I].LeadByte then Exit;
            Inc(P);
            if P^ <> FMaskStates[I].TrailByte then Exit;
          end;
        msAny:
          if P^ = #0 then
          begin
            Result := False;
            Exit;
          end;
      end;
      Inc(P);
    end;
    Result := True;
  end;

begin
  SetLength(S, MaxCards);
  Result := True;
  T := 0;
  P := PChar(Filename);
  I := Low(FMaskStates);
  repeat
    if Matches(P, I) then Exit;
  until not Pop(P, I);
  Result := False;
end;

procedure TMask.DoneMaskStates;
var
  I: Integer;
begin
  for I := Low(FMaskStates) to High(FMaskStates) do
    if FMaskStates[I].State = msSet then Dispose(FMaskStates[I].CharSet);
end;

{ TMask }

constructor TMask.Create(const MaskValue: string);
var
  Size: Integer;
begin
  SetLength(FMaskStates, 1);
  Size := InitMaskStates(MaskValue);
  DoneMaskStates;

  SetLength(FMaskStates, Size);
  InitMaskStates(MaskValue);
end;

destructor TMask.Destroy;
begin
  DoneMaskStates;
  SetLength(FMaskStates, 0)
end;

function TMask.Matches(const Filename: string): Boolean;
begin
  Result := MatchesMaskStates(Filename);
end;

function MatchesMask(const Filename, Mask: string): Boolean;
var
  CMask: TMask;
begin
  CMask := TMask.Create(Mask);
  try
    Result := CMask.Matches(Filename);
  finally
    CMask.Free;
  end;
end;

end.
