{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.Bind.EngExt"'}    {Do not Localize}
unit Data.Bind.EngExt;

// Register binding engine extensions

interface

implementation

uses Data.Bind.Components, System.Bindings.EvalProtocol, System.SysUtils, System.Classes,
  Data.Bind.Consts, System.Rtti, System.Bindings.Methods;


function GetCheckedState(AObject: TObject): string;
var
  LEditor: IBindCheckBoxEditor;
begin
  Result := '';
  if Supports(GetBindEditor(AObject, IBindCheckBoxEditor), IBindCheckBoxEditor, LEditor) then
  begin
    case LEditor.State of
      cbChecked: Result := BoolToStr(True, True);
      cbUnchecked:  Result := BoolToStr(False, True);
      cbGrayed: Result := '';
    end;
  end;
end;

function GetSelectedText(AObject: TObject): string;
var
  LEditor: IBindListEditorCommon;
begin
  Result := '';
  if Supports(GetBindEditor(AObject, IBindListEditorCommon), IBindListEditorCommon, LEditor) then
  begin
    Result := LEditor.SelectedText;
  end;
end;

function GetSelectedLookupValue(AObject: TObject): TValue;
var
  LEditor: IBindListLookupEditor;
begin
  Result := TValue.Empty;
  if Supports(GetBindEditor(AObject, IBindListEditorCommon), IBindListLookupEditor, LEditor) then
  begin
    Result := LEditor.SelectedLookupValue
  end;
end;

function GetSelectedItem(AObject: TObject): TObject;
var
  LEditor: IBindListEditorCommon;
begin
  Result := nil;
  if Supports(GetBindEditor(AObject, IBindListEditorCommon), IBindListEditorCommon, LEditor) then
  begin
    Result := LEditor.SelectedItem;
  end;
end;


function GetSelectedValue(AObject: TObject): TValue;
var
  LEditor: IBindListEditor;
begin
  Result := nil;
  if Supports(GetBindEditor(AObject, IBindListEditorCommon), IBindListEditor, LEditor) then
  begin
    Result := LEditor.SelectedValue;
  end;
end;

procedure SetCheckedState(AObject: TObject; const AValue: string);
var
  LEditor: IBindCheckBoxEditor;
  BoolVal: Boolean;
begin
  if Assigned(AObject) then
    if Supports(GetBindEditor(AObject, IBindCheckBoxEditor), IBindCheckBoxEditor, LEditor) then
    begin
      if TryStrToBool(AValue, BoolVal) then
      begin
        if BoolVal then
          LEditor.State := cbChecked
        else
          LEditor.State := cbUnchecked;
      end
      else if LEditor.AllowGrayed then
        LEditor.State := cbGrayed
      else
        LEditor.State := cbUnchecked;
    end;
end;

procedure SetSelectedText(AObject: TObject; const AValue: string);
var
  LEditor: IBindListEditor;
begin
  if AObject <> nil then

  if Supports(GetBindEditor(AObject, IBindListEditor), IBindListEditor, LEditor) then
  begin
    LEditor.SelectedText := AValue;
  end;
end;

procedure SetSelectedLookupValue(AObject: TObject; const AValue: TValue);
var
  LEditor: IBindListLookupEditor;
begin
  if AObject <> nil then

  if Supports(GetBindEditor(AObject, IBindListEditor), IBindListLookupEditor, LEditor) then
  begin
    LEditor.SelectedLookupValue := AValue;
  end;
end;

procedure SetSelectedValue(AObject: TObject; const AValue: TValue);
var
  LEditor: IBindListEditor;
begin
  if Supports(GetBindEditor(AObject, IBindListEditor), IBindListEditor, LEditor) then
  begin
    LEditor.SelectedValue := AValue;
  end;
end;

function MakeCheckedState: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(sArgCount);
    v := Args[0];
    Result := MakeLocation(TypeInfo(string),
      function: TValue
      begin
        if v.GetValue.IsEmpty then
          Result := TValue.Empty
        else
          Result := GetCheckedState(v.GetValue.AsObject);
      end,
      procedure(x: TValue)
      begin
        SetCheckedState(v.GetValue.AsObject, x.AsString);
      end);
  end);
end;

function MakeSelectedText: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
//    loc: ILocation;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(sArgCount);
    v := Args[0];
    Result := MakeLocation(TypeInfo(string),
      function: TValue
      begin
        if v.GetValue.IsEmpty then
          Result := TValue.Empty
        else
          Result := GetSelectedText(v.GetValue.AsObject);
      end,
      procedure(x: TValue)
      begin
        SetSelectedText(v.GetValue.AsObject, x.AsString);
      end);
  end);
end;

function MakeSelectedLookupValue: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(sArgCount);
    v := Args[0];
    Result := MakeLocation(TypeInfo(TValue),
      function: TValue
      begin
        if v.GetValue.IsEmpty then
          Result := TValue.Empty
        else
          Result := GetSelectedLookupValue(v.GetValue.AsObject);
      end,
      procedure(x: TValue)
      begin
        SetSelectedLookupValue(v.GetValue.AsObject, x);
      end);
  end);
end;

function MakeSelectedValue: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(sArgCount);
    v := Args[0];
    Result := MakeLocation(TypeInfo(TValue),
      function: TValue
      begin
        if v.GetValue.IsEmpty then
          Result := TValue.Empty
        else
          Result := GetSelectedValue(v.GetValue.AsObject);
      end,
      procedure(x: TValue)
      begin
        SetSelectedValue(v.GetValue.AsObject, x);
      end);
  end);
end;

function MakeSelectedItem: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v: IValue;
//    loc: ILocation;
  begin
    if Length(Args) <> 1 then
      raise EEvaluatorError.Create(sArgCount);
    v := Args[0];
    if v.GetValue.IsEmpty then
      Result := TValueWrapper.Create(nil)
    else
      Result := TValueWrapper.Create(GetSelectedItem(v.GetValue.AsObject));
  end);
end;

function MakeLookup: IInvokable;
begin
  Result := MakeInvokable(function(Args: TArray<IValue>): IValue
  var
    v1: IValue;
    v2: IValue;
    v3: IValue;
    v4: IValue;
    LResult: TValue;
    LScopeLookup: IScopeLookup;
    LKeyField: string;
    LKeyValue: TValue;
    LValueField: string;
//    loc: ILocation;
  begin
    if Length(Args) <> 4 then
      raise EEvaluatorError.Create(sArgCount);
    v1 := Args[0];
    v2 := Args[1];
    v3 := Args[2];
    v4 := Args[3];
    LResult := nil;
    if v1.GetValue.IsObject then
    begin
      if System.SysUtils.Supports(v1.GetValue.AsObject, IScopeLookup, LScopeLookup) then
      begin
        if v2.GetValue.TryAsType<string>(LKeyField) then
        begin
          LKeyValue := v3.GetValue;
          if v4.GetValue.TryAsType<string>(LValueField) then
          begin
            LResult := LScopeLookup.Lookup(LKeyField, LKeyValue, LValueField);
          end;
        end;
      end
      else
        raise TBindCompException.CreateFmt(sScopeLookupNotImplemented, [v1.GetValue.AsObject.ClassName]);
    end;
    Result := TValueWrapper.Create(LResult);
  end);
end;

const
  sIDCheckedState = 'CheckedState';
  sIDSelectedText = 'SelectedText';
  sIDSelectedItem = 'SelectedItem';
  sIDSelectedLookupValue = 'SelectedLookupValue';
  sIDSelectedValue = 'SelectedValue';
  sIDLookup = 'Lookup';
  sThisUnit = 'Data.Bind.EngExt';

procedure RegisterMethods;
begin
    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeCheckedState,
        sIDCheckedState,
        sCheckedState,
        sThisUnit,
        True,
        sCheckedStateDesc, nil)
    );
    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeSelectedText,
        sIDSelectedText,
        sSelectedText,
        sThisUnit,
        True,
        sSelectedTextDesc, nil)
    );

    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeSelectedItem,
        sIDSelectedItem,
        sSelectedItem,
        sThisUnit,
        True,
        sSelectedItemDesc, nil)
    );

    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeSelectedLookupValue,
        sIDSelectedLookupValue,
        sSelectedLookupValue,
        sThisUnit,
        True,
        sSelectedLookupValueDesc, nil)
    );

    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeSelectedValue,
        sIDSelectedValue,
        sSelectedValue,
        sThisUnit,
        True,
        sSelectedValueDesc, nil)
    );

    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeLookup,
        sIDLookup,
        sLookup,
        sThisUnit,
        True,
        sLookupDesc, nil)
    );

end;

procedure UnregisterMethods;
begin
  TBindingMethodsFactory.UnRegisterMethod(sIDSelectedText);
  TBindingMethodsFactory.UnRegisterMethod(sIDSelectedItem);
  TBindingMethodsFactory.UnRegisterMethod(sIDCheckedState);
  TBindingMethodsFactory.UnRegisterMethod(sIDSelectedLookupValue);
  TBindingMethodsFactory.UnRegisterMethod(sIDLookup);
  TBindingMethodsFactory.UnRegisterMethod(sIDSelectedValue);
end;


initialization
  RegisterMethods;
finalization
  UnregisterMethods;

end.
