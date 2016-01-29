{ *********************************************************************** }
{                                                                         }
{ Delphi Runtime Library                                                  }
{                                                                         }
{ Copyright (c) 1999-2001 Borland Software Corporation                    }
{                                                                         }
{ *********************************************************************** }

unit CorbaVCL;

{$T-,H+,X+}

interface

uses Classes, CorbaObj;

type
  TCorbaVclComponentFactory = class(TCorbaFactory)
  private
    FComponentClass: TComponentClass;
  protected
    function CreateInterface(const InstanceName: string): IObject; override;
  public
    constructor Create(const InterfaceName, InstanceName, RepositoryId: string;
      const ImplGUID: TGUID; AComponentClass: TComponentClass;
      Instancing: TCorbaInstancing = iMultiInstance;
      ThreadModel: TCorbaThreadModel = tmSingleThread);
    property ComponentClass: TComponentClass read FComponentClass;
  end;

implementation

type
  TCorbaVclComponentAdapter = class(TCorbaImplementation, IVCLComObject)
  private
    FComponent: TComponent;
  protected
    function ObjQueryInterface(const IID: TGUID; out Obj): HResult; override;
    procedure FreeOnRelease;
  public
    //constructor Create(AComponentClass: TComponentClass); reintroduce;
    constructor CreateFromFactory(AFactory: TCorbaVclComponentFactory);
    destructor Destroy; override;
  end;

{ TCorbaVclComponentAdapter }

constructor TCorbaVclComponentAdapter.CreateFromFactory(AFactory: TCorbaVclComponentFactory);
begin
  inherited Create(nil, AFactory);
  FComponent := AFactory.ComponentClass.Create(nil);
  FComponent.VCLComObject := Pointer(IVCLComObject(Self));
end;

destructor TCorbaVclComponentAdapter.Destroy;
begin
  if FComponent <> nil then
  begin
    FComponent.VCLComObject := nil;
    FComponent.Free;
  end;
  inherited Destroy;
end;

procedure TCorbaVclComponentAdapter.FreeOnRelease;
begin
  // Always frees on release
end;

function TCorbaVclComponentAdapter.ObjQueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  Result := inherited ObjQueryInterface(IID, Obj);
  if Result <> 0 then
    if FComponent.GetInterface(IID, Obj) then Result := 0;
end;

{ TCorbaVclComponentFactory }

constructor TCorbaVclComponentFactory.Create(const InterfaceName,
  InstanceName, RepositoryId: string; const ImplGUID: TGUID;
  AComponentClass: TComponentClass; Instancing: TCorbaInstancing;
  ThreadModel: TCorbaThreadModel);
begin
  inherited Create(InterfaceName, InstanceName, RepositoryID, ImplGUID,
    Instancing, ThreadModel);
  FComponentClass := AComponentClass;
end;

function TCorbaVclComponentFactory.CreateInterface(const InstanceName: string): IObject;
begin
  Result := TCorbaVclComponentAdapter.CreateFromFactory(Self);
end;

end.
