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
unit throw;

interface

uses
  req_int,except_int,orbtypes,code_int;


  procedure dorb_static_throw(req: IStaticRequest); overload;
  procedure dorb_static_throw(req: IStaticRequest; const args: array of const); overload;
  procedure dorb_throw(ex: IORBException); overload;
  procedure dorb_throw(str: string); overload;
  procedure dorb_throw(systype: SYSEXC_TYPES; const minor: _ulong = 0; const status: TCompletionStatus = COMPLETED_NO); overload;
  procedure dorb_throw(const reason: string; systype: SYSEXC_TYPES; const minor: _ulong = 0; const status: TCompletionStatus = COMPLETED_NO); overload;

implementation

uses
  exceptions,SysUtils;

procedure dorb_static_throw(req: IStaticRequest);
begin
  dorb_static_throw(req,[]);
end;


procedure dorb_static_throw(req: IStaticRequest; const args: array of const);
var
  ex : IORBException;
  uuex: IUnknownUserException;
  i,len: integer;
  si : IStaticTypeInfo;
  repoid : RepositoryId;
  a : IStaticAny;
begin
  if req.get_exception <> nil then
    begin
      ex := req.get_exception;
      uuex := UnknownUserException.EXCEPTION_DOWNCAST(ex);
      if uuex <> nil then
        begin
          len := Length(args);
          i := 0;
          while i < len-1 do
            begin
              si := IStaticTypeInfo(args[i].VInterface);
              repoid := args[i+1].VPChar;
              inc(i,2);
              if uuex.except_repoid = repoid then
                begin
                  a := uuex.exception(si);
                  dorb_throw(IORBException(a.value^));
                end;
            end;
          dorb_throw(UNKNOWN.Create(0, COMPLETED_NO));
        end
      else
        dorb_throw(ex);
    end;
end;

procedure dorb_throw(ex: IORBException);
begin
  ex.throw;
end;

procedure dorb_throw(str: string);
begin
  raise Exception.Create(str);
end;

procedure dorb_throw(systype: SYSEXC_TYPES; const minor: _ulong; const status: TCompletionStatus);
begin
  dorb_throw(SystemException.create_sysex(systype, minor, status) as IORBException);
end;

procedure dorb_throw(const reason: string; systype: SYSEXC_TYPES; const minor: _ulong; const status: TCompletionStatus);
begin
  dorb_throw(SystemException.create_sysex(reason, systype, minor, status) as IORBException);
end;

end.
