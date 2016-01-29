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
unit intercept_int;

interface

uses
  Classes, orb_int, env_int, code_int, req_int, orbtypes;

const
  LowestPriority = 0;
  HighestPriority = $7fffffff;

type
  TStatus = (INVOKE_CONTINUE, INVOKE_ABORT, INVOKE_RETRY, INVOKE_BREAK);
  TPriority = _ulong;

  IRoot = interface(IORBObject)
  ['{021B76E0-361D-423C-988A-E77D4DF71A17}']
    function prio(): TPriority;
    procedure activate(const p: TPriority);
    procedure deactivate();
    function is_active(): boolean;
  end;

  IInterceptContext = interface(IORBObject)
  ['{72D73FCD-6DEC-475B-8A8E-8893BF4B2B52}']
    procedure _destroy();
  end;

  ILWRootRequest = interface(IORBObject)
  ['{53B9B404-E996-4297-8394-5FAB04130F11}']
    function get_target(): IORBObject;
    procedure set_target(obj: IORBObject);
    function get_operation(): Identifier;
    procedure set_operation(const ident: Identifier);
    procedure set_service_context(const id: ServiceID; const flags: long; const d: ContextData);
    function get_service_context (const id: ServiceID; const flags: long): ContextData;
    procedure remove_service_context (const id: ServiceID);
    function has_service_context(const id: ServiceID): boolean;
    procedure set_context(const interceptor: IRoot; const ctx: Intercept_int.IInterceptContext);
    function get_context(const interceptor: IRoot): Intercept_int.IInterceptContext;
    property target: IORBObject read get_target write set_target;
    property operation: Identifier read get_operation write set_operation;
  end;

  ILWRequest = interface(ILWRootRequest)
  ['{A1AFF39B-37E7-4D4D-84E6-71B57BB8517C}']
    function request(): IRequest;
  end;

  ILWServerRequest = interface(ILWRootRequest)
  ['{F70D86B0-2E7B-4F69-AFCE-BCA66D73D9E2}']
    function request(): IServerRequest;
  end;

  IClientInterceptor = interface(IRoot)
  ['{4123953F-2158-4C98-A1E1-365C333979F3}']
    function initialize_request(const req: ILWRequest; const env: IEnvironment): TStatus;
    function after_marshal(const req: ILWRequest; const env: IEnvironment): TStatus;
    function output_message(const buf: IBuffer; const env: IEnvironment): TStatus;
    function input_message(const buf: IBuffer; const env: IEnvironment): TStatus;
    function before_unmarshal(const req: ILWRequest; const env: IEnvironment): TStatus;
    function finish_request(const req: ILWRequest; const env: IEnvironment): TStatus;
  end;

  IServerInterceptor = interface(IRoot)
  ['{690DB2B4-BB09-4332-BADF-37B6FCCCB2DB}']
    function input_message(const buf: IBuffer; const env: IEnvironment): TStatus;
    function initialize_request(const req: ILWServerRequest; const env: IEnvironment): TStatus;
    function after_unmarshal(const req: ILWServerRequest; const env: IEnvironment): TStatus;
    function before_marshal(const req: ILWServerRequest; const env: IEnvironment): TStatus;
    function finish_request(const req: ILWServerRequest; const env: IEnvironment): TStatus;
    function output_message(const buf: IBuffer; const env: IEnvironment): TStatus;
  end;

  ORBId = string;

  IInitInterceptor = interface(IRoot)
  ['{D7435D3B-7858-48D8-B909-91D751CC1B2B}']
    function initialize(const orb: IORB; const id: ORBId; argv: TStrings): TStatus;
  end;

  IBOAInterceptor = interface(IRoot)
  ['{75AD0642-18C1-452D-BFD1-8B2BF880F5CE}']
    function bind(const repoid: RepositoryId; const tag: IObjectTag): TStatus;
    function restore(const obj: IORBObject): TStatus;
    function _create(const obj: IORBObject): TStatus;
  end;

  IConnInterceptor = interface(IRoot)
  ['{4E6EF774-63C6-4224-BE29-62A567466C38}']
    function client_connect(const addr: AnsiString): TStatus;
    function client_disconnect(const addr: AnsiString): TStatus;
  end;

implementation

end.
