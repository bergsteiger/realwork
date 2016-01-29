{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.CustomScope;

interface

uses
  System.Rtti,

  System.Bindings.EvalProtocol, System.Bindings.EvalSys;

type
  TScopeClass = class of TCustomScope;

  TCustomScope = class abstract(TInterfacedObject, IScope, ICustomScope)
  type
    TWrapperFoundCallback = reference to procedure (Scope: TCustomScope; const Wrapper: ICustomWrapper);
  private
    FCache: TDictionaryScope;
    FMappedObject: TObject;
    FMetaClass: TClass;
    FWrapperFoundCallback: TWrapperFoundCallback;
  protected
    { ICustomScope }
    function GetMappedObject: TObject;
    function GetMetaClass: TClass;
    procedure SetMappedObject(const Value: TObject);

    // the user has to provide the returning of a custom wrapper that will
    // be used by the engine to parse the expression and evaluate it;
    // this method is called only once for each different symbol that is
    // not found on the internal cache
    function DoLookup(const Name: String): IInterface; virtual; abstract;
  public
    constructor Create(const MappedObject: TObject; MetaClass: TClass); virtual;
    destructor Destroy; override;

    { ICustomScope }
    // called by the engine whenever it needs a custom wrapper for the given symbol;
    // if the wrapper is found on the internal cache, it returns the reference
    // from there; if it's not on the cache, it calls DoLookup() provided by the user;
    function Lookup(const Name: string): IInterface;

    property MappedObject: TObject read GetMappedObject write SetMappedObject;
    property MetaClass: TClass read GetMetaClass;

                                                                            
// named DoWrapperUpdate() that the user must override to synchronize the
// custom wrappers information with the information on the scope (i.e. the object
// on which the custom scope is created may be nil after it hasn't been nil
// at some point and this must be reflected also in the contents of the custom wrapper).
// In fact, the step of updating the ParentObject in the custom wrapper can be
                                                       
// The event could still remain along this DoWrapperUpdate().

    // triggered when the wrapper is found either in the internal scope cache
    // or after it is given by the user from DoLookup; it represents the step
    // of adjustments for the settings in the custom wrapper before returning
    // to the engine processings
    property OnWrapperFound: TWrapperFoundCallback read FWrapperFoundCallback write FWrapperFoundCallback;
  end;

implementation

{ TCustomScope }

constructor TCustomScope.Create(const MappedObject: TObject; MetaClass: TClass);
begin
  inherited Create;

  FCache := TDictionaryScope.Create;
  FMappedObject := MappedObject;
  FMetaClass := MetaClass;
end;

destructor TCustomScope.Destroy;
begin
  FCache.Free;

  inherited;
end;

function TCustomScope.GetMappedObject: TObject;
begin
  Result := FMappedObject;
end;

function TCustomScope.GetMetaClass: TClass;
begin
  Result := FMetaClass;
end;

function TCustomScope.Lookup(const Name: string): IInterface;
begin
  // search the internal structure for the cached custom wrapper
  Result := FCache.Lookup(Name);

  // request the custom wrapper from the user routine
  if not Assigned(Result) then
  begin
    Result := DoLookup(Name);                                                                                         

    // a custom wrapper has been created for the symbol; add it to the cache
    if Assigned(Result) then
      FCache.Map.Add(Name, Result);
  end;

  if Assigned(Result) and Assigned(OnWrapperFound) then
    OnWrapperFound(Self, ICustomWrapper(Result));
end;

procedure TCustomScope.SetMappedObject(const Value: TObject);
begin
  FMappedObject := Value;
end;

end.
