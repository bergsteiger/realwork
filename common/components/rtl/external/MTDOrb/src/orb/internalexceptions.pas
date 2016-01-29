// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit internalexceptions;

interface

uses SysUtils;

type
  //base exception
  EBaseInternalException = class(Exception);

  //
  ESystemCallException = class(EBaseInternalException)
  private
    FError: integer;
  public
    constructor Create(const Msg: string; const AError: integer);
    function GetError(): integer;
  end;

  EIllegalArgumentException = class(EBaseInternalException);

  EInterruptedException = class(EBaseInternalException)
  public
    constructor Create;
  end;

procedure RaiseSystemCallException(const Msg: string);

implementation

procedure RaiseSystemCallException(const Msg: string);
begin
end;

{ ESystemCallException }

constructor ESystemCallException.Create(const Msg: string;
  const AError: integer);
begin
  inherited Create(Msg);
  FError := AError;
end;

function ESystemCallException.GetError: integer;
begin
  result := FError;
end;

{ EInterruptedException }
constructor EInterruptedException.Create;
begin
  inherited Create('EInterruptedException');
end;


end.
