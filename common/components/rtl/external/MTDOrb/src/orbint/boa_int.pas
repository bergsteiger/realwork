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
unit boa_int;

interface

uses
  orb_int,orbtypes,SysUtils,ir_int,env_int,code_int,req_int;

type

  IObjectRecord = interface;
  IImplementationDef = interface;

  IObjectInfo = interface
  ['{AF662CB9-4D2E-11d4-9D27-204C4F4F5020}']
    function repoid(): string; overload;
    function tag(): string; overload;
    procedure repoid(val: string); overload;
    procedure tag(val: string); overload;
  end;

  IImplementationBase = interface(IORBObject)
  ['{AF662CBA-4D2E-11d4-9D27-204C4F4F5020}']
    //procedure create_ref(const id: string;const ImplBase: IUnknown;const repoid: string);
    procedure create_ref(const id: Identifier;const idef: IInterfaceDef; const implDef : IImplementationDef;const repoid: RepositoryId);
    function find_impl(const repid: RepositoryId; const name: Identifier): IImplementationDef;
    function impl_name(const name: Identifier): Identifier;
    function make_request(const req: IORBRequest;const obj: IORBObject; id: ORBMessageID;
       const oa: IObjectAdaptor; pr: IPrincipal):IServerRequestBase;
    procedure doinvoke(const req: IServerRequestBase; const env: IEnvironment);
  end;

  IStaticImplementation = interface(IImplementationBase)
  ['{AF662CBB-4D2E-11d4-9D27-204C4F4F5020}']
    procedure doinvoke(const req: IServerRequestBase; const env: IEnvironment);
    procedure invoke(const req: IStaticServerRequest; const env: IEnvironment);
  end;

  IStaticMethodDispatcher = interface(IStaticImplementation)
  ['{AF662CBC-4D2E-11d4-9D27-204C4F4F5020}']
    procedure register_dispatcher(const disp: IStaticInterfaceDispatcher);
  end;

  IImplementationDef = interface(IImplementationBase)
  ['{AF662CBD-4D2E-11d4-9D27-204C4F4F5020}']
    function name(): string;
  end;

  IBOA = interface(IObjectAdaptor)
  ['{AF662CA0-4D2E-11d4-9D27-204C4F4F5020}']
    function createrec(const id: Identifier; const intdef: IInterfaceDef;
      const imrdef: IImplementationDef; const skel: IImplementationBase;
      const repoid: RepositoryId): IORBObject;
    function get_record(const obj: IORBObject): IObjectRecord;
    function impl_name: Identifier;
    function unique_id(out buffer: AnsiString): _ulong;
    function get_pricipal(const obj: IORBObject; const env: IEnvironment): IPrincipal;
  end;

  IObjectRecord = interface
  ['{AF662CA1-4D2E-11d4-9D27-204C4F4F5020}']
    function local_obj: IORBObject;
    function remote_obj: IORBObject;
    function skel(): IORBObject;
    function id(): Identifier;
  end;

implementation

end.
