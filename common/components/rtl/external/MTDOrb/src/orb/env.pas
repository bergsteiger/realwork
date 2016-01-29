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
unit env;

interface

{$IFNDEF USELIB}

uses
  env_int,except_int,Classes,code_int,orbtypes;

type

  {** Implements org.omg.CORBA.Environment. This class is used to hold
    exception information for DII requests.  }
  TEnvironment = class(TInterfacedObject,IEnvironment)
  private
    FException : IORBException;
    FPrincipal : IPrincipal;
  protected
    function get_exception(): IORBException;
    procedure set_exception(const ex: IORBException);
    function principal(): IPrincipal;
    procedure clear();
  public
    constructor Create(pr: IPrincipal = nil);
  end;

  {** Implements org.omg.CORBA.NVList }
  TNVList = class(TInterfacedObject,INVList)
  private
    FArray: NVList;
    FLast : integer;
  protected
    function add(flags: _ulong): TNamedValue;
    function add_item(name: Identifier;flags: _ulong): TNamedValue;
    function add_value(name: Identifier; any: IAny; flags: _ulong): TNamedValue;
    function count: integer;
    procedure delete(index: integer);
    function item(index: integer): TNamedValue;
    function copy(const src: INVList;flags: _ulong): Boolean;
  public
    constructor Create(length: integer=0);
  end;

  TStaticAnyList = class(TInterfaceList,IStaticAnyList)
  protected
    function _Get(Index: Integer): IStaticAny;
    procedure _Put(Index: Integer; Item: IStaticAny);
  public
    property Items[Index: Integer]: IStaticAny read _Get write _Put; default;
  end;


implementation

uses
  any;

//*********************************************************************
// TEnvironment
//*********************************************************************
procedure TEnvironment.clear;
begin
  FPrincipal := nil;
  FException := nil;
end;

constructor TEnvironment.Create(pr: IPrincipal);
begin
  FPrincipal := pr;
end;

function TEnvironment.get_exception: IORBException;
begin
  result := FException;
end;

function TEnvironment.principal: IPrincipal;
begin
  result := FPrincipal;
end;

procedure TEnvironment.set_exception(const ex: IORBException);
begin
  FException := ex;
end;

//*********************************************************************
//  TStaticAnyList
//*********************************************************************
function TStaticAnyList._Get(Index: Integer): IStaticAny;
begin
  result := IStaticAny(Get(Index));
end;

procedure TStaticAnyList._Put(Index: Integer; Item: IStaticAny);
begin

end;

//*********************************************************************
//  TNVList
//*********************************************************************
constructor TNVList.Create(length: integer);
begin
  inherited Create();
  FLast := 0;
  setLength(FArray,length);
end;

function TNVList.add(flags: _ulong): TNamedValue;
begin
  result := add_value('',nil,flags);
end;

function TNVList.add_item(name: Identifier; flags: _ulong): TNamedValue;
begin
  result := add_value(name,nil,flags);
end;

function TNVList.add_value(name: Identifier; any: IAny;
  flags: _ulong): TNamedValue;
begin
  if FLast >= Length(FArray) then
    setLength(FArray,FLast+1);
  FArray[FLast].name := name;
  if any = nil then
    FArray[FLast].argument := TAny.Create()
  else
    FArray[FLast].argument := any;
  FArray[FLast].flags := flags;
  result := FArray[FLast];
  inc(FLast);
end;

function TNVList.count: integer;
begin
  result := FLast;
end;

procedure TNVList.delete(index: integer);
begin
  if index < FLast then
    begin
      dec(FLast);
      if index < FLast then
        move(FArray[index+1],FArray[index],SizeOf(TNamedValue)*FLast-index)
    end;
end;

function TNVList.item(index: integer): TNamedValue;
begin
  if index < FLast then
    result := FArray[index]
  else
    FillChar(result,sizeof(result),0);
end;

function TNVList.copy(const src: INVList; flags: _ulong): Boolean;
const
  emptynv : TNamedValue = (name:'';argument:nil;len:0;flags:0);
var
  dst: INVList;
  dstcount,srccount: integer;
  dstnv,srcnv: TNamedValue;
  d,s : integer;
begin
  result := false;
  dst := self;
  dstcount := dst.count;
  srccount := src.count;
  d := 0;
  s := 0;
  while true do
    begin
      srcnv := emptynv;
      while s < srccount do
        begin
          srcnv := src.item(s);
          if (srcnv.flags and flags) <> 0 then break;
          inc(s);
        end;
      dstnv := emptynv;
      while d < dstcount do
        begin
          dstnv := dst.item(d);
          if (dstnv.flags and flags) <> 0 then break;
          inc(d);
        end;
      if (s >= srccount) or (d >= dstcount) then
        begin
          if (s < srccount) or (d < dstcount) then
            exit;
          break;
        end;
      if (srcnv.flags and flags) <> (dstnv.flags and flags) then
        exit;
      dstnv.argument.copy(srcnv.argument);
      inc(s); inc(d);
    end;
  result := true;
end;

{$ELSE}
implementation
{$ENDIF}
end.
