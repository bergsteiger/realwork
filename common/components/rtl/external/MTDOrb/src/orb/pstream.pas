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
unit pstream;

interface

uses
  Classes;

type

  TPrintStream = class(TStream)
  public
    procedure writeln(str: AnsiString);
    procedure writestr(str: AnsiString);
    procedure writecrlf();
    procedure writeeol();
  end;

implementation

procedure TPrintStream.writeeol();
const
  eol: byte = 0;
begin
  write(eol,1);
end;

procedure TPrintStream.writecrlf();
const
  cr: byte = 13;
  lf: byte = 10;
begin
  write(cr,1);
  write(lf,1);
end;

procedure TPrintStream.writeln(str: AnsiString);
begin
  writestr(str);
  writecrlf;
end;

procedure TPrintStream.writestr(str: AnsiString);
begin
  write(PAnsiChar(str)^,length(str));
end;

end.
