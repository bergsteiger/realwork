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
unit req_int;

interface

uses
  code_int,Classes,orbtypes,except_int,env_int;

type

  IStaticInterfaceDispatcher = interface;
  IStaticServerRequest = interface;

  IORBRequest = interface
  ['{61252F6A-4D23-11d4-9D27-204C4F4F5020}']
    function context(): PServiceContextList;
    procedure set_context(const ctx: PServiceContextList);
    procedure add_in_arg(const any: IStaticAny);
    procedure add_inout_arg(const any: IStaticAny);
    procedure add_out_arg(const any: IStaticAny);
    function copy_out_args(const req: IORBRequest): Boolean;
    function get_in_args(const enc: IEncoder): Boolean; overload;
    function get_in_args(const list : INVList; out ctx: IContext): Boolean; overload;
    function get_in_args(const list : IStaticAnyList; out ctx: IContext): Boolean; overload;
    function get_out_args(const enc: IEncoder;out is_except: Boolean): Boolean; overload;
    function get_out_args(const res: IStaticAny; const list: IStaticAnyList; out ex: IORBException): Boolean; overload;
    function get_out_args(const res: IAny; const list: INVList; out ex: IORBException): Boolean; overload;
    procedure invoke();
    function op_name(): AnsiString;
    function req_type(): AnsiString;
    function set_out_args(const dec: IDecoder; const exception : Boolean): Boolean; overload;
    function set_out_args(const ex: IORBException): Boolean; overload;
    function set_out_args(const res: IStaticAny; const list: IStaticAnyList): Boolean; overload;
    function set_out_args(const res: IAny; const list: INVList): Boolean; overload;
  end;

  IStaticRequest = interface(IORBRequest)
  ['{61252F6B-4D23-11d4-9D27-204C4F4F5020}']
    function get_exception(): IORBException;
    procedure oneway();
    procedure set_exception(const ex: IORBException);
    procedure set_result(const any: IStaticAny);
    procedure set_exceptions_tc(exTC: array of ITypeCode);
  end;

  IServerRequestBase = interface
  ['{61252F6C-4D23-11d4-9D27-204C4F4F5020}']
    function environment: IEnvironment;
  end;

  IServerRequest = interface(IServerRequestBase)
  ['{61252F6D-4D23-11d4-9D27-204C4F4F5020}']
    procedure set_exception(const exc: IORBException);
    function operation: AnsiString;
    function arguments(const lst: INVList): Boolean;
    procedure set_result(const any: IAny);
    function ctx: IContext;
  end;

  IStaticServerRequest = interface(IServerRequestBase)
  ['{61252F6E-4D23-11d4-9D27-204C4F4F5020}']
    procedure add_in_arg(const any: IStaticAny);
    procedure add_out_arg(const any: IStaticAny);
    procedure add_inout_arg(const any: IStaticAny);
    function read_args(): Boolean;
    procedure set_exception(const ex: IORBException);
    procedure set_result(const any: IStaticAny);
    function op_name: AnsiString;
    procedure write_results();
    procedure set_exceptions_tc(exTC: array of ITypeCode);
  end;


  IStaticInterfaceDispatcher = interface
  ['{61252F6F-4D23-11d4-9D27-204C4F4F5020}']
    function _dispatch(const req: IStaticServerRequest; const env: IEnvironment): Boolean;
  end;

  IGIOPREquest = interface(IORBRequest)
  ['{ED6FA101-779A-11d4-9D50-204C4F4F5020}']
    function input_byteorder: TByteOrder;
    function output_byteorder: TByteOrder;
  end;


implementation

end.
