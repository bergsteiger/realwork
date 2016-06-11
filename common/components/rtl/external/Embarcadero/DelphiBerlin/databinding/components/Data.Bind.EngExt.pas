{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
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

function GetSelectedDateTime(AObject: TObject): TValue;
var
  LEditor: IBindDateTimeEditEditor;
begin
  Result := TValue.Empty;
  if Supports(GetBindEditor(AObject, IBindDateTimeEditEditor), IBindDateTimeEditEditor, LEditor) then
    if not LEditor.IsEmpty then
      Result := TValue.From<TDateTime>(LEditor.SelectedDateTime);
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

function TryGetIndex(AValue: TValue; out AIndex: Integer): Boolean;
var
  LExtended: Extended;
begin
  Result := AValue.TryAsType<Integer>(AIndex);
  if not Result then
  begin
    Result := AValue.TryAsType<Extended>(LExtended);  // Value is extended if the result of expression engine calculation
    if Result then
      AIndex := Round(LExtended);

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

function GetSynchIndex(AObject: TObject): TValue;
var
  LEditor: IBindListSynchEditor;
begin
  Result := 0;
  if Supports(GetBindEditor(AObject, IBindListEditorCommon), IBindListSynchEditor, LEditor) then
  begin
    Result := LEditor.SynchIndex;
  end;
end;

procedure SetSynchIndex(AObject: TObject; AIndex: TValue);
var
  LEditor: IBindListSynchEditor;
  LIndex: Integer;
begin
  if TryGetIndex(AIndex, LIndex) then
    if Supports(GetBindEditor(AObject, IBindListEditorCommon), IBindListSynchEditor, LEditor) then
    begin
      LEditor.SynchIndex := LIndex;
    end;
end;

function GetListItemIndex(AObject: TObject): TValue;
var
  LEditor: IBindListItemIndexEditor;
begin
  Result := 0;
  if Supports(GetBindEditor(AObject, IBindListEditorCommon), IBindListItemIndexEditor, LEditor) then
  begin
    Result := LEditor.ItemIndex;
  end;
end;

procedure SetListItemIndex(AObject: TObject; AIndex: TValue);
var
  LEditor: IBindListItemIndexEditor;
  LIndex: Integer;
begin
  LIndex := -1;
  if TryGetIndex(AIndex, LIndex) then
    if Supports(GetBindEditor(AObject, IBindListEditorCommon), IBindListItemIndexEditor, LEditor) then
    begin
      LEditor.ItemIndex := LIndex;
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

procedure SetSelectedDateTime(AObject: TObject; const AValue: TValue);
var
  LEditor: IBindDateTimeEditEditor;
  LDateTime: TDateTime;
begin
  if AObject <> nil then
    if Supports(GetBindEditor(AObject, IBindDateTimeEditEditor), IBindDateTimeEditEditor, LEditor) then
      if (AValue.ToString = '') or (AValue.IsEmpty) then
        LEditor.IsEmpty := True
      else if TryStrToDateTime(AValue.ToString, LDateTime) then
      begin
          LEditor.SelectedDateTime := LDateTime;
          LEditor.IsEmpty := False;
      end
        else
          raise Exception.Create(AValue.ToString + ' Invalid Date');
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

function MakeSynchIndex: IInvokable;
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
          Result := GetSynchIndex(v.GetValue.AsObject);
      end,
      procedure(x: TValue)
      begin
        SetSynchIndex(v.GetValue.AsObject, x);
      end);
  end);
end;

function MakeListItemIndex: IInvokable;
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
          Result := GetListItemIndex(v.GetValue.AsObject);
      end,
      procedure(x: TValue)
      begin
        SetListItemIndex(v.GetValue.AsObject, x);
      end);
  end);
end;

function MakeSelectedDateTime: IInvokable;
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
          Result := GetSelectedDateTime(v.GetValue.AsObject);
      end,
      procedure(x: TValue)
      begin
        SetSelectedDateTime(v.GetValue.AsObject, x);
      end);
  end);
end;

const
  sIDCheckedState = 'CheckedState';
  sIDSelectedText = 'SelectedText';
  sIDSynchIndex = 'SynchIndex';
  sIDListItemIndex = 'ListItemIndex';
  sIDSelectedItem = 'SelectedItem';
  sIDSelectedLookupValue = 'SelectedLookupValue';
  sIDSelectedValue = 'SelectedValue';
  sIDLookup = 'Lookup';
  sIDSelectedDateTime = 'SelectedDateTime';
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

    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeSynchIndex,
        sIDSynchIndex,
        sIDSynchIndex,
        sThisUnit,
        True,
        '', nil)
    );
    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeSelectedDateTime,
        sIDSelectedDateTime,
        sSelectedDateTime,
        sThisUnit,
        True,
        sSelectedDateTimeDesc, nil)
    );
    TBindingMethodsFactory.RegisterMethod(
      TMethodDescription.Create(
        MakeListItemIndex,
        sIDListItemIndex,
        sIDListItemIndex,
        sThisUnit,
        True,
        '', nil)
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
  TBindingMethodsFactory.UnRegisterMethod(sIDSynchIndex);
  TBindingMethodsFactory.UnRegisterMethod(sIDSelectedDateTime);
end;


initialization
  RegisterMethods;
finalization
  UnregisterMethods;

end.
