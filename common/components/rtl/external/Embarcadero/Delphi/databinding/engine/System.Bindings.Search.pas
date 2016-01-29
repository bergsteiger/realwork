{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.Search;

interface

uses
  System.SysUtils, System.Rtti, System.TypInfo, System.Generics.Collections,
  System.Bindings.EvalProtocol;

type
  /// <summary>Provides extensive support for locating objects and object
  /// properties within wrapper scopes.</summary>
  TBindingSearch = class(TObject)
  private
    class var
      FRttiCtx: TRttiContext;

    class procedure DoDepthGetWrappers(const ScopeEnum: IScopeEnumerable;
      Dict: TWrapperDictionary);
    class function DoDepthSearchObject(Obj: TObject; const Group: IGroup): IInterface;
  public
    /// <summary>Initializes internal data structures shared by all the routines.</summary>
    class constructor Create;

    class function IsWrapper(const Wrapper: IInterface): Boolean; inline;
    /// <summary>Determines if a given wrapper wraps around an object instance.</summary>
    /// <param name="Wrapper">The wrapper to be checked.</param>
    /// <returns>True if the wrapper wraps around an object.</returns>
    class function IsObjectWrapper(const Wrapper: IInterface): Boolean; overload;
    /// <summary>Determines if a given wrapper wraps around a given object.</summary>
    /// <param name="Wrapper">The wrapper to be checked.</param>
    /// <param name="Obj">The object on which the wrapper is tested.</param>
    /// <returns>True if the wrapper wraps around the given object</returns>
    class function IsObjectWrapper(const Wrapper: IInterface; Obj: TObject): Boolean; overload;
    /// <summary>Determines if a given wrapper wraps around a particular object member.</summary>
    /// <param name="Wrapper">The wrapper to be tested for wrapping around the
    /// the given object member.</param>
    /// <param name="Obj">The object whose member is tested of being wrapped by
    /// the given wrapper.</param>
    /// <param name="MemberName">The name of the member that is tested of being wrapped
    /// by the given wrapper.</param>
    /// <returns>True if the wrapper wraps aroudn the given object member.</returns>
    class function IsMemberWrapper(const Wrapper: IInterface; Obj: TObject;
      const MemberName: String): Boolean;

    /// <summary>Determines if a given object property can be wrapped by an
    /// object wrapper.</summary>
    /// <param name="Obj">The object whose property is tested of supporting an
    /// object wrapper.</param>
    /// <param name="PropertyName">The name of the property that is tested for
    /// supporting an object wrapper around it.</param>
    /// <returns>True if the specified object property permits an object
    /// wrapper around it.</returns>
    /// <remarks>An object property doesn't support being wrapped by an object
    /// wrapper if the type of that property is not a class type.</remarks>
    class function PermitsObjectWrapper(Obj: TObject; const PropertyName: String): Boolean; overload;
    /// <summary>Determines if an object member can be wrapped by an object
    /// wrapper based on the member RTTI information.</summary>
    /// <param name="Member">RTTI information for the member.</param>
    /// <returns>True if the given object member is of an object type.</returns>
    class function PermitsObjectWrapper(const Member: TRttiMember): Boolean; overload;

    /// <summary>Searches in a depth-first manner for the first wrapper that
    /// wraps around the given object, starting within the given scope.</summary>
    /// <param name="Obj">The searched object.</param>
    /// <param name="Scope">The scope within the search starts.</param>
    /// <returns>The wrapper that wraps the specified object.</returns>
    /// <remarks>Within a scope there may be wrappers that are scopes themselves.
    /// The routine passes through all the wrappers that have scope support and
    /// search for the given object.</remarks>
    class function DepthSearchObject(Obj: TObject; const Scope: IScopeEx): IInterface; overload;
    class function DepthSearchObject(Obj: TObject; Wrappers: TWrapperDictionary): IInterface; overload;
    /// <summary>Searches in a depth-first manner for the first wrapper that
    /// wraps around the given object property, starting within the given scope.</summary>
    /// <param name="Obj">The object whose property is searched for.</param>
    /// <param name="PropertyName">The name of the searched property.</param>
    /// <param name="Scope">The scope within the search starts.</param>
    /// <returns>The wrapper that wraps the given object property.</returns>
    /// <remarks>Within a scope there may be wrappers that are scopes themselves.
    /// The routine passes through all the wrappers that have scope support and
    /// search for the given object property. The found property wrapper is a
    /// wrapper with IGroup support. You can enumerate it to access individual
    /// object member wrapper instances of the property represented by the group.</remarks>
    class function DepthSearchProperty(Obj: TObject; const PropertyName: String;
      const Scope: IScopeEx): IInterface; overload;
    class function DepthSearchProperty(Obj: TObject; const PropertyName: String;
      const Wrappers: TWrapperDictionary): IInterface; overload;
    /// <summary>Generates a list containing all the wrappers within the hierarchy
    /// of scopes that starts with the given scope.</summary>
    /// <param name="Scope">The scope where the wrapper gathering starts.</param>
    /// <returns>All the wrappers in the given scope and the wrappers in its
    /// subscopes and so on.</returns>
    /// <remarks>If a wrapper in the given scope has scope support, it puts in
    /// the same list the wrappers of that scope and the process continues until
    /// there are no more wrappers that have scope support. The user must free
    /// the list when it becomes of no further use.</remarks>
    class function DepthGetWrappers(const Scope: IScope): TWrapperDictionary;

    /// <summary>Clears the arguments of the wrappers that support IArguments in a
    /// depth-first manner.</summary>
    /// <param name="StartScopeEnumerable">The scope whose wrappers are going to have
    /// their arguments reset.</param>
    class procedure ResetWrappersArguments(const StartScopeEnumerable: IScopeEnumerable);
    /// <summary>Reattaches all the wrappers within the given scope to their parents.</summary>
    /// <param name="StartScopeEnumerable">The scope whose wrappers are going to
    /// be reattached.</param>
    class procedure ReattachWrappers(const StartScopeEnumerable: IScopeEnumerable);
    /// <summary>Prepares the wrappers for evaluation. It clears the arguments of the wrappers
    /// that support IArguments and then reattaches the wrappers to the new parents.</summary>
    /// <param name="StartScopeEnumerable">The scope whose wrappers are going to
    /// be prepared for evaluation.</param>
    class procedure PrepareWrappersForEvaluation(const StartScopeEnumerable: IScopeEnumerable);

    /// <summary>Puts the wrapper instances of the group in the given dictionary.</summary>
    /// <param name="Group">The group from which the wrapper instances are collected.</param>
    /// <param name="WrprDict">The wrapper dictionary to which the instances are added.</param>
    class procedure CollectGroupInstWrprs(Group: IGroup; WrprDict: TWrapperDictionary);
    /// <summary>Copies the wrappers from a wrapper dictionary to the other one.</summary>
    /// <param name="AFrom">The dictionary from which it copies the wrappers.</param>
    /// <param name="ATo">The dictionary to which it copies the wrappers.</param>
    class procedure CopyWrprs(AFrom, ATo: TWrapperDictionary);
  end;

implementation

{ TBindingSearch }

class procedure TBindingSearch.CollectGroupInstWrprs(Group: IGroup;
  WrprDict: TWrapperDictionary);
var
  i: Integer;
begin
  if Assigned(Group) and Assigned(WrprDict) then
    for i := 0 to Group.WrapperCount - 1 do
      WrprDict.AddOrSetValue(Group.Wrappers[i], nil);
end;

class procedure TBindingSearch.CopyWrprs(AFrom, ATo: TWrapperDictionary);
var
  Wrpr: IInterface;
begin
  for Wrpr in AFrom.Keys do
    ATo.AddOrSetValue(Wrpr, nil);
end;

class constructor TBindingSearch.Create;
begin
  inherited;

  FRttiCtx := TRttiContext.Create;
end;

class function TBindingSearch.DepthGetWrappers(
  const Scope: IScope): TWrapperDictionary;
var
  LScopeEnum: IScopeEnumerable;
begin
  Result := nil;
  if Supports(Scope, IScopeEnumerable, LScopeEnum) then
  begin
    Result := TWrapperDictionary.Create;

    DoDepthGetWrappers(LScopeEnum, Result);
  end;
end;

class function TBindingSearch.DepthSearchObject(Obj: TObject;
  const Scope: IScopeEx): IInterface;
var
  LScopeEnum: IScopeEnumerable;
  LScopeEx: IScopeEx;
  LWrapper: IInterface;
  LGroup: IGroup;
begin
  Result := nil;
  if Assigned(Obj) and Assigned(Scope) then
  begin
    // search the scope for immediate wrappers in it that may wrap around Obj
    Result := Scope.Lookup(Obj);

    // no wrapper for Obj has been found in Scope;
    // take each item in Scope and go inside its scope if it supports that
    if not Assigned(Result) and Supports(Scope, IScopeEnumerable, LScopeEnum) then
      for LWrapper in LScopeEnum do
      begin
        // the wrapper is an object wrapper, so go in-depth in its scope
        if IsObjectWrapper(LWrapper) and Supports(LWrapper, IScopeEx, LScopeEx) then
          Result := DepthSearchObject(Obj, LScopeEx)
        else // it's a group and go in-depth to search the group
          if Supports(LWrapper, IGroup, LGroup) then
            Result := DoDepthSearchObject(Obj, LGroup);

        if Assigned(Result) then
          Break;
      end;
  end;
end;

class function TBindingSearch.DepthSearchObject(Obj: TObject;
  Wrappers: TWrapperDictionary): IInterface;
var
  Wrpr: IInterface;
begin
  Result := nil;
  if Assigned(Obj) and Assigned(Wrappers) then
    for Wrpr in Wrappers.Keys do
      if IsObjectWrapper(Wrpr, Obj) then
      begin
        Result := Wrpr;
        Break;
      end;
end;

class function TBindingSearch.DepthSearchProperty(Obj: TObject;
  const PropertyName: String; const Wrappers: TWrapperDictionary): IInterface;
var
  Wrpr: IInterface;
begin
  Result := nil;
  if Assigned(Obj) and Assigned(Wrappers) then
    for Wrpr in Wrappers.Keys do
      if IsMemberWrapper(Wrpr, Obj, PropertyName) then
      begin
        Result := Wrpr;
        Break;
      end;
end;

class function TBindingSearch.DepthSearchProperty(Obj: TObject;
  const PropertyName: String; const Scope: IScopeEx): IInterface;
var
  ObjScope: IScope;
begin
  // search a wrapper that wraps around Obj
  Result := DepthSearchObject(Obj, Scope);

  // now search the wrapper for the property in the scope of the wrapper for Obj
  if Assigned(Result) and Supports(Result, IScope, ObjScope) then
    Result := ObjScope.Lookup(PropertyName);
end;

class procedure TBindingSearch.DoDepthGetWrappers(const ScopeEnum: IScopeEnumerable;
  Dict: TWrapperDictionary);
var
  LWrapper: IInterface;
  LScopeEnum: IScopeEnumerable;
begin
  // enumerate all the contained wrappers in the scope and consider only those
  // wrappers that implement IWrapper; this will avoid adding duplicates because
  // of the nested scopes that enumerate as contained wrappers both the inner
  // and the outer scopes
  for LWrapper in ScopeEnum do
  begin
    // add only the wrappers and not references to dictionaries or neste scopes
    if IsWrapper(LWrapper) then
      Dict.Add(LWrapper, nil);

    // if the LWrapper can be enumerated, it means that it also contains sub-wrappers
    if Supports(LWrapper, IScopeEnumerable, LScopeEnum) then
      DoDepthGetWrappers(LScopeEnum, Dict);
  end;
end;

class function TBindingSearch.DoDepthSearchObject(Obj: TObject;
  const Group: IGroup): IInterface;
var
  LGroupEnum: IScopeEnumerable;
  LWrapper: IInterface;
  LWrprScopeEx: IScopeEx;
begin
  Result := nil;
  if Assigned(Obj) and Supports(Group, IScopeEnumerable, LGroupEnum) then
    for LWrapper in LGroupEnum do
      if IsObjectWrapper(LWrapper) and Supports(LWrapper, IScopeEx, LWrprScopeEx) then
      begin
        Result := DepthSearchObject(Obj, LWrprScopeEx);

        if Assigned(Result) then
          Break;
      end;
end;

class function TBindingSearch.IsObjectWrapper(const Wrapper: IInterface): Boolean;
var
  LValue: IValue;
begin
  Result := Assigned(Wrapper) and
            Supports(Wrapper, IValue, LValue) and
            Assigned(LValue) and
            Assigned(LValue.GetType) and
           (LValue.GetType^.Kind = tkClass);
end;

class function TBindingSearch.IsMemberWrapper(const Wrapper: IInterface;
  Obj: TObject; const MemberName: String): Boolean;
var
  LWChild: IChild;
begin
  Result := Supports(Wrapper, IChild, LWChild) and
           (LWChild.Parent = Obj) and (LWChild.MemberName = MemberName);
end;

class function TBindingSearch.IsObjectWrapper(const Wrapper: IInterface;
  Obj: TObject): Boolean;
var
  LValue: IValue;
begin
  Result := Supports(Wrapper, IValue, LValue);
  Result := Result and TBindingSearch.IsObjectWrapper(Wrapper);
  Result := Result and (Obj = LValue.GetValue.AsObject);
end;

class function TBindingSearch.IsWrapper(const Wrapper: IInterface): Boolean;
begin
  Result := Supports(Wrapper, IWrapper);
end;

class function TBindingSearch.PermitsObjectWrapper(
  const Member: TRttiMember): Boolean;
var
  LTypeKind: TTypeKind;
begin
  Result := False;
  if Assigned(Member) then
  begin
    LTypeKind := tkUnknown;
    if Member is TRttiProperty then
      LTypeKind := TRttiProperty(Member).PropertyType.TypeKind
    else
    if Member is TRttiMethod then
      LTypeKind := TRttiMethod(Member).ReturnType.TypeKind
    else
    if Member is TRttiIndexedProperty then
      LTypeKind := TRttiIndexedProperty(Member).PropertyType.TypeKind
    else
    if Member is TRttiField then
      LTypeKind := TRttiField(Member).FieldType.TypeKind;

    Result := LTypeKind in [tkClass, tkRecord];
  end;
end;

class function TBindingSearch.PermitsObjectWrapper(Obj: TObject;
  const PropertyName: String): Boolean;
var
  LRttiType: TRttiType;
  LRttiProp: TRttiProperty;
  LRttiIdxProp: TRttiIndexedProperty;
begin
  Result := False;
  if Assigned(Obj) then
  begin
    // when the property is missing, it's obvious that Obj permits to be
    // wrapped by an object
    Result := PropertyName = '';

    // the property name is specified; check if its type permits to be
    // wrapped by an object
    if not Result then
    begin
      LRttiType := FRttiCtx.GetType(Obj.ClassInfo);
      if Assigned(LRttiType) then
      begin
        LRttiProp := LRttiType.GetProperty(PropertyName);
        if Assigned(LRttiProp) then
          Result := LRttiProp.PropertyType.TypeKind = tkClass
        else
        begin
          LRttiIdxProp := LRttiType.GetIndexedProperty(PropertyName);
          if Assigned(LRttiIdxProp) then
            Result := LRttiIdxProp.PropertyType.TypeKind = tkClass;
        end;
      end;
    end;
  end;
end;

class procedure TBindingSearch.PrepareWrappersForEvaluation(
  const StartScopeEnumerable: IScopeEnumerable);
begin
  if Assigned(StartScopeEnumerable) then
  begin
    // reset the arguments of the wrappers that wrap on object members which
    // support arguments; it's like the wrappers were after compilation, when
    // they have no arguments; this is important because the last arguments
    // may request invalid information from the object members they wrap because
    // the parents object may have changed up until this evaluation
    ResetWrappersArguments(StartScopeEnumerable);

    // reattach all the wrappers to the available parents; the wrappers that
    // wrap around object members that need arguments will return default (nil, 0)
    // values, which is actually a detach operation for their sub-wrappers
    ReattachWrappers(StartScopeEnumerable);
  end;
end;

class procedure TBindingSearch.ReattachWrappers(
  const StartScopeEnumerable: IScopeEnumerable);
var
  WrprScopeEnumerable: IScopeEnumerable;
  WrprPlacehld: IPlaceholder;
  WrprRecPlacehld: IRecordPlaceholder;
  Wrpr: IInterface;
begin
  if Assigned(StartScopeEnumerable) then
    for Wrpr in StartScopeEnumerable do
    begin
      if Supports(Wrpr, IPlaceholder, WrprPlacehld) then
        WrprPlacehld.Attach(WrprPlacehld.Attachment)
      else
      if Supports(Wrpr, IRecordPlaceholder, WrprRecPlacehld) then
        WrprRecPlacehld.Attach(WrprRecPlacehld.Attachment);

      // go in-depth only for storage scopes, such as nested scopes or
      // dictionary scopes, but not wrappers; because reattaching a top-level
      // wrapper, will reattach all its sub-wrappers in a depth-first manner
      if not Supports(Wrpr, IWrapper) and
         Supports(Wrpr, IScopeEnumerable, WrprScopeEnumerable) then
        ReattachWrappers(WrprScopeEnumerable);
    end;
end;

class procedure TBindingSearch.ResetWrappersArguments(
  const StartScopeEnumerable: IScopeEnumerable);
var
  Wrpr: IInterface;
  WrprArguments: IArguments;
  WrprScopeEnumerable: IScopeEnumerable;
begin
  if Assigned(StartScopeEnumerable) then
    for Wrpr in StartScopeEnumerable do
    begin
      // reset the arguments of the wrapper
      if Supports(Wrpr, IArguments, WrprArguments) then
        WrprArguments.SetArgs(nil);

      // go in-depth in its subwrappers
      if Supports(Wrpr, IScopeEnumerable, WrprScopeEnumerable) then
        ResetWrappersArguments(WrprScopeEnumerable);
    end;
end;

end.
