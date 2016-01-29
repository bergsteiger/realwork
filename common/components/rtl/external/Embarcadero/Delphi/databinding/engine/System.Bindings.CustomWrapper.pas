{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.CustomWrapper;

interface

uses
  System.SysUtils, System.Rtti, System.TypInfo, System.RTLConsts,

  System.Bindings.EvalProtocol;

type
  ECustomWrapperError = class(Exception);

                                                                                                                             

                                                                
  TCustomWrapper = class(TInterfacedObject, IInterface,
    ICustomWrapper,
    IValue, IInvokable, IArguments,
    IChild, IPlaceholder)
  private
    FWrapperType: TCustomWrapperType;
    FGetterCallback: TCustomWrapperGetterCallback;
    FParent: TObject;
    FMetaClass: TClass;
    FMemberName: String;
    FArgs: TArray<TValue>;
    FValue: TValue;
  public
    // creates a wrapper of the given WrapperType and uses the given getter callback
    // to determine the actual value of the wrapped object member; the metaclass
    // can be used for custom operations when the parent object is nil;
    // the metaclass usually depicts the class type of the parent or from which it
    // can be derived
    constructor Create(Parent: TObject; MetaClass: TClass; const MemberName: String;
      WrapperType: TCustomWrapperType; const GetterCallback: TCustomWrapperGetterCallback);

    // depending on MemberType, decides which interfaces are accessible:
    // IValue - property, indexed property, method
    // IInvokable - method
    // IArguments - indexed property, method
    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;

    { ICustomWrapper }
    function GetWrapperType: TCustomWrapperType; inline;
    function GetGetterCallback: TCustomWrapperGetterCallback; inline;
    procedure SetGetterCallback(const Callback: TCustomWrapperGetterCallback); inline;

    property WrapperType: TCustomWrapperType read GetWrapperType;
    property GetterCallback: TCustomWrapperGetterCallback read GetGetterCallback write SetGetterCallback;

    { IValue }
    // the type information of the current value can be established only if
    // ensured that the stored value is updated to the latest one
    function GetType: PTypeInfo; inline;
    // the last result value of the getter is stored internally;
    // to update the last stored value for properties, just call this routine;
    // for method wrappers, it returns the last result of the method invokation,
    // but cannot update the value; it can be updated only by calling Invoke
    function GetValue: TValue;

    { IInvokable }
    // calls the getter with the given arguments and updates the internal result
    // value of the method; the arguments are also stored internally
    function Invoke(const Args: TArray<IValue>): IValue;

    { IArguments }
    function GetArgs: TArray<TValue>; inline;
    procedure SetArgs(const Args: TArray<TValue>); inline;

    property Args: TArray<TValue> read GetArgs write SetArgs;

    { IChild }
    function GetParent: TObject; inline;
    function GetMemberName: String; inline;

    property Parent: TObject read GetParent;
    property MemberName: String read GetMemberName;

    { IPlaceholder }
    function GetAttachment: TObject; inline;
    function GetMetaClass: TClass; inline;
    function GetAttached: Boolean; inline;
    function GetEvalTimeOnly: Boolean; inline;

    procedure Attach(Obj: TObject); inline;
    procedure Detach; inline;

    property Attachment: TObject read GetAttachment;
    property MetaClass: TClass read GetMetaClass;
    property Attached: Boolean read GetAttached;
    property EvalTimeOnly: Boolean read GetEvalTimeOnly;
  end;

implementation

{ TCustomWrapper }

procedure TCustomWrapper.Attach(Obj: TObject);
begin
  FParent := Obj;
end;

constructor TCustomWrapper.Create(Parent: TObject; MetaClass: TClass;
  const MemberName: String; WrapperType: TCustomWrapperType;
  const GetterCallback: TCustomWrapperGetterCallback);
begin
  inherited Create;

  if not Assigned(MetaClass) then
    raise ECustomWrapperError.CreateFmt(SParamIsNil, ['MetaClass']);
  if MemberName = '' then
    raise ECustomWrapperError.Create(SInvalidString);
  if not Assigned(GetterCallback) then
    raise ECustomWrapperError.CreateFmt(SParamIsNil, ['GetterCallback']);

  FParent := Parent;
  FMetaClass := MetaClass;
  FMemberName := MemberName;
  FWrapperType := WrapperType;
  FGetterCallback := GetterCallback;
end;

procedure TCustomWrapper.Detach;
begin
  FParent := nil;
end;

function TCustomWrapper.GetArgs: TArray<TValue>;
begin
  Result := FArgs;
end;

function TCustomWrapper.GetAttached: Boolean;
begin
  Result := Assigned(FParent);
end;

function TCustomWrapper.GetAttachment: TObject;
begin
  Result := FParent;
end;

function TCustomWrapper.GetEvalTimeOnly: Boolean;
begin
  Result := True;
end;

function TCustomWrapper.GetGetterCallback: TCustomWrapperGetterCallback;
begin
  Result := FGetterCallback;
end;

function TCustomWrapper.GetMemberName: String;
begin
  Result := FMemberName;
end;

function TCustomWrapper.GetMetaClass: TClass;
begin
  Result := FMetaClass;
end;

function TCustomWrapper.GetParent: TObject;
begin
  Result := FParent;
end;

function TCustomWrapper.GetType: PTypeInfo;
begin
  Result := FValue.TypeInfo;
end;

function TCustomWrapper.GetValue: TValue;
begin
  Result := TValue.Empty;
  case WrapperType of
    cwtProperty:
      begin
        FValue := FGetterCallback(FParent, FMemberName, nil);
        Result := FValue;
      end;
    cwtIndexedProperty:
      if Length(Args) > 0 then
      begin
        // calculate the value and store it internally
        FValue := FGetterCallback(FParent, FMemberName, Args);
        Result := FValue;
      end;
    cwtMethod:
      Result := FValue;
  end;
end;

function TCustomWrapper.GetWrapperType: TCustomWrapperType;
begin
  Result := FWrapperType;
end;

function TCustomWrapper.Invoke(const Args: TArray<IValue>): IValue;
begin
  // call the getter to determine the result
  FArgs := AdaptArguments(Args);

  // wrap the value is a simple value wrapper to transport the actual value
  // to the core of the engine; there it will be analyzed whether it's an
  // object or not and wrapped accordingly
  FValue := FGetterCallback(FParent, FMemberName, FArgs);
  Result := TValueWrapper.Create(FValue);
end;

function TCustomWrapper.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := S_OK;
  case FWrapperType of
    cwtProperty:
      if (IID = IInvokable) or
         (IID = IArguments) then
        Result := E_NOINTERFACE;
    cwtIndexedProperty:
      if IID = IInvokable then
        Result := E_NOINTERFACE;
    else ;
  end;

  if Result = S_OK then
    Result := inherited QueryInterface(IID, Obj);
end;

procedure TCustomWrapper.SetArgs(const Args: TArray<TValue>);
begin
  FArgs := Args;
end;

procedure TCustomWrapper.SetGetterCallback(
  const Callback: TCustomWrapperGetterCallback);
begin
                                                                                 
  if not Assigned(Callback) then
    raise ECustomWrapperError.CreateFmt(SParamIsNil, ['Callback']);

  FGetterCallback := Callback;
end;

end.
