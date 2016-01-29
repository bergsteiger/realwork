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
unit env_int;

interface

uses
  except_int,code_int,Classes,orbtypes;

type
  IContextList = interface;

  PNamedValue = ^TNamedValue;
  TNamedValue = record
    name : Identifier;
    argument : IAny;
    len : long;
    flags : _ulong;
  end;

  NVList = array of TNamedValue;

  IContext = interface
  ['{61252F70-4D23-11d4-9D27-204C4F4F5020}']
    procedure set_one_value(const prop_name: Identifier; const value: AnsiString);
    procedure set_values(const values : NVList);
    procedure get_values(const start_scope: Identifier; const op_flags: Flags; const prop_name: Identifier; out values: NVList); overload;
    procedure get_values(const start_scope: Identifier; const op_flags: Flags; const ctx_list: IContextList; out values: NVList); overload;
    procedure delete_values(const prop_name: Identifier);
    procedure create_child(const ctx_name: Identifier; out child_ctx: IContext);
    procedure delete(const del_flags: Flags);
    // DORB extension
    procedure encode(const enc: IEncoder; const ctxlist: IContextList);
    function decode(const dec: IDecoder): Boolean;
    function context_name(): Identifier;
    function parent(): IContext;
  end;

  {**  Helper for NVList }
  INVList = interface
  ['{61252F72-4D23-11d4-9D27-204C4F4F5020}']
    function add(flags: _ulong): TNamedValue;
    function add_item(name: Identifier;flags: _ulong): TNamedValue;
    function add_value(name: Identifier; any: IAny; flags: _ulong): TNamedValue;
    function count: integer;
    procedure delete(index: integer);
    function item(index: integer): TNamedValue;
    function copy(const src: INVList;flags: _ulong): Boolean;
  end;

  IStaticAnyList = interface(IInterfaceList)
  ['{61252F73-4D23-11d4-9D27-204C4F4F5020}']
    function _Get(Index: Integer): IStaticAny;
    procedure _Put(Index: Integer; Item: IStaticAny);
    property Items[Index: Integer]: IStaticAny read _Get write _Put; default;
  end;

  IEnvironment = interface
  ['{61252F75-4D23-11d4-9D27-204C4F4F5020}']
    function get_exception(): IORBException;
    procedure set_exception(const ex: IORBException);
    function principal(): IPrincipal;
    procedure clear();
  end;

  IExceptionList = interface
  ['{59BA8B90-DE7A-43F9-AA95-18449315DD52}']
    function count: _ulong;
    procedure add(tc: ITypeCode);
    procedure add_consume(tc: ITypeCode);
    function item(idx: _ulong): ITypeCode;
    procedure remove(idx: _ulong);
  end;

  IContextList = interface
  ['{25A72F6D-1448-4C39-9066-E54DE2285153}']
    function count: _ulong;
    function item(idx: _ulong): string;
  end;

implementation

end.
