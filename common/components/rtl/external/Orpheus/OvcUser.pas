{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                   OVCUSER.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcUser;
  {-User data class}

interface

uses
  SysUtils,
  OvcData;

type
  {class for implementing user-defined mask and substitution characters}
  TOvcUserData = class(TObject)
  {.Z+}
  protected {private}
    FUserCharSets : TUserCharSets;
    FForceCase    : TForceCase;
    FSubstChars   : TSubstChars;

    {property methods}
    function GetForceCase(Index : TForceCaseRange) : TCaseChange;
      {-get the case changing behavior of the specified user mask character}
    function GetSubstChar(Index : TSubstCharRange) : AnsiChar;
      {-get the meaning of the specified substitution character}
    function GetUserCharSet(Index : TUserSetRange) : TCharSet;
      {-get the specified user-defined character set}
    procedure SetForceCase(Index : TForceCaseRange; CC : TCaseChange);
      {-set the case changing behavior of the specified user mask character}
    procedure SetSubstChar(Index : TSubstCharRange; SC : AnsiChar);
      {-set the meaning of the specified substitution character}
    procedure SetUserCharSet(Index : TUserSetRange; const US : TCharSet);
      {-set the specified user-defined character set}
  {.Z+}

  public
    constructor Create;
      {-initialize using default field data}

    property ForceCase[Index : TForceCaseRange] : TCaseChange
      read GetForceCase
      write SetForceCase;

    property SubstChars[Index : TSubstCharRange] : AnsiChar
      read GetSubstChar
      write SetSubstChar;

    property UserCharSet[Index : TUserSetRange] : TCharSet
      read GetUserCharSet
      write SetUserCharSet;
  end;

var
  {global default user data object}
  OvcUserData : TOvcUserData;


implementation


{*** TOvcUserData ***}

const
  DefUserCharSets : TUserCharSets = (
      {User1} [#1..#255], {User2} [#1..#255], {User3} [#1..#255],
      {User4} [#1..#255], {User5} [#1..#255], {User6} [#1..#255],
      {User7} [#1..#255], {User8} [#1..#255] );

  DefForceCase : TForceCase = (
      mcNoChange, mcNoChange, mcNoChange, mcNoChange,
      mcNoChange, mcNoChange, mcNoChange, mcNoChange);

  DefSubstChars : TSubstChars = (
      Subst1, Subst2, Subst3, Subst4, Subst5, Subst6, Subst7, Subst8);

constructor TOvcUserData.Create;
begin
  inherited Create;

  FUserCharSets := DefUserCharSets;
  FForceCase    := DefForceCase;
  FSubstChars   := DefSubstChars;
end;

function TOvcUserData.GetForceCase(Index : TForceCaseRange) : TCaseChange;
  {-get the case changing behavior of the specified user mask character}
begin
  case Index of
    pmUser1..pmUser8 : Result := FForceCase[Index];
  else
    Result := mcNoChange;
  end;
end;

function TOvcUserData.GetSubstChar(Index : TSubstCharRange) : AnsiChar;
  {-get the meaning of the specified substitution character}
begin
  case Index of
    Subst1..Subst8 : Result := FSubstChars[Index];
  else
    Result := #0;
  end;
end;

function TOvcUserData.GetUserCharSet(Index : TUserSetRange) : TCharSet;
  {-get the specified user-defined character set}
begin
  case Index of
    pmUser1..pmUser8 : Result := FUserCharSets[Index];
  end;
end;

procedure TOvcUserData.SetForceCase(Index : TForceCaseRange; CC : TCaseChange);
  {-set the case changing behavior of the specified user mask character}
begin
  case Index of
    pmUser1..pmUser8 : FForceCase[Index] := CC;
  end;
end;

procedure TOvcUserData.SetSubstChar(Index : TSubstCharRange; SC : AnsiChar);
  {-set the meaning of the specified substitution character}
begin
  case Index of
    Subst1..Subst8 : FSubstChars[Index] := SC;
  end;
end;

procedure TOvcUserData.SetUserCharSet(Index : TUserSetRange; const US : TCharSet);
  {-set the specified user-defined character set}
begin
  case Index of
    pmUser1..pmUser8 : FUserCharSets[Index] := US-[#0];
  end;
end;


{*** exit procedure ***}

procedure DestroyGlobalUserData; far;
begin
  OvcUserData.Free
end;


initialization
  {create instance of default user data class}
  OvcUserData := TOvcUserData.Create;

{$IFDEF Win32}
finalization
  DestroyGlobalUserData;
{$ELSE}
  AddExitProc(DestroyGlobalUserData);
{$ENDIF}
end.
