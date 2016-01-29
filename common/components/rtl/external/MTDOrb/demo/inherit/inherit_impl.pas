unit inherit_impl;

interface

uses
  orb,orb_int;

type

  IBase = interface(IORBObject)
    procedure BaseOp();
  end;

  IDerived = interface(IBase)
    procedure DerivedOp();
  end;

  TBase = class(TORBObject,IBase)
  public
    procedure BaseOp();
    class function narrow(obj: IORBObject): IBase;
  end;

  TDerived = class(TBase,IDerived)
  public
    procedure DerivedOp();
    class function narrow(obj: IORBObject): IDerived;
  end;

implementation

uses
  static,code_int,req_int;

procedure TBase.BaseOp();
var
  req: IStaticRequest;
begin
  req := TStaticRequest.Create(self,'BaseOp');
  req.Invoke;
end;

class function TBase.narrow(obj: IORBObject): IBase;
begin
  result := TBase.Create;
  result.Assign(obj);
end;

procedure TDerived.DerivedOp();
var
  req: IStaticRequest;
begin
  req := TStaticRequest.Create(self,'DerivedOp');
  req.Invoke;
end;

class function TDerived.narrow(obj: IORBObject): IDerived;
begin
  result := TDerived.Create;
  result.Assign(obj);
end;

end.
