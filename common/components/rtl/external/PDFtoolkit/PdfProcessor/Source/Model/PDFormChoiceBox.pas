unit PDFormChoiceBox;

interface

uses
  Classes, gtObject, PDElement, PDBaseObject, PDFormField;

type
  TgtPDFormChoiceBox = class(TgtPDFormField)
  private
    FIsSortedList: Boolean;
    FIsMultiSelect: Boolean;
    FIsDoNotSpellCheck: Boolean;

    {Display values --- in the case of List box or Combo were there is "Display name"
    as well as a "value" Whenever the "Display value" is selected,
    Corresponding "value" is set as the value}
    FOptions: TStringList; // Display Name

    function GetIsSortedList: Boolean;
    function GetIsMultiSelect: Boolean;
    function GetIsDoNotSpellCheck: Boolean;
    function GetOptions(Index: Integer): AnsiString;
    function GetOptionCount: Integer;

    procedure SetOptions(AIndex: Integer; AValue: AnsiString);
    procedure SetIsSortedList(Value: Boolean);
    procedure SetIsMultiSelect(Value: Boolean);
    procedure SetIsDoNotSpellCheck(Value: Boolean);
  protected
    FValueList: TStringList; //Value List

    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;

    property RotationAngle;
    property BorderColor;
    property BackGroundColor;
    property HighlightMode;
    property DefaultValue;
    property Value;
    property FieldName;
    property Preferences;
    property Justification;
    property AltFieldName;
    property Transparent;
    property FormFieldType;
    property BorderStyle;
    property Action;
    property Rect;
    property Page;
    property BorderWidth;
    property IsReadOnly;
    property Font;
    property Options[Index: Integer]: AnsiString read GetOptions write SetOptions;
    property OptionCount: Integer read GetOptionCount;
    property IsSortedList: Boolean read GetIsSortedList write SetIsSortedList;
    property IsMultiSelect: Boolean read GetIsMultiSelect write SetIsMultiSelect;
    property IsDoNotSpellCheck: Boolean read GetIsDoNotSpellCheck write SetIsDoNotSpellCheck;

  public
    function AddItem(Item: AnsiString): Integer; overload;
    function AddItem(DisplayValue: AnsiString; Value: AnsiString): Integer; overload;
    destructor Destroy; override;
  end;

implementation

uses
  gtConstants, gtMethods, PDDictionary, PDArray, PDString;

constructor TgtPDFormChoiceBox.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  FIsSortedList := False;
  FIsMultiSelect := False;
  FIsDoNotSpellCheck := False;
end;

function TgtPDFormChoiceBox.AddItem(Item: AnsiString): Integer;
var
  LOpt, LValueObj: TgtPDArray;
begin
  GetOptions(1);
  if Assigned(FBaseObject) then
  begin
    LOpt := TgtPDDictionary(FBaseObject).LookUp(PDF_OPT) as TgtPDArray;
    if Assigned(LOpt) then
    begin
      if Assigned(FValueList) then
      begin
        LValueObj := TgtPDArray.Create(Self);
        LValueObj.Add(TgtPDString.Create(Item, False));
        LValueObj.Add(TgtPDString.Create(Item, False));
        LOpt.Add(LValueObj);
      end
      else
      begin
        LOpt.Add(TgtPDString.Create(Item, False));
      end;
    end;
  end;

  if not Assigned(FOptions) then
    FOptions := TStringList.Create;
  if Assigned(FValueList) then
    FValueList.Add(Item);
  Result := FOptions.Add(Item) + 1;
end;

function TgtPDFormChoiceBox.AddItem(DisplayValue, Value: AnsiString): Integer;
var
  LOpt, LValueObj: TgtPDArray;
begin
  if Assigned(FBaseObject) then
  begin
    LOpt := TgtPDDictionary(FBaseObject).LookUp(PDF_OPT) as TgtPDArray;
    if Assigned(LOpt) then
    begin
      if Assigned(FValueList) then
      begin
        LValueObj := TgtPDArray.Create(Self);
        LValueObj.Add(TgtPDString.Create(Value, False));
        LValueObj.Add(TgtPDString.Create(DisplayValue, False));
        LOpt.Add(LValueObj);
      end
      else
      begin
        LOpt.Add(TgtPDString.Create(DisplayValue, False));
      end;
    end;
  end;

  if not Assigned(FOptions) then
    FOptions := TStringList.Create;
  if Assigned(FValueList) then
    FValueList.Add(Value);
  Result := FOptions.Add(DisplayValue) + 1;
end;

constructor TgtPDFormChoiceBox.Create;
begin
  inherited;
  FValueList := TStringList.Create;
  FIsSortedList := False;
  FIsMultiSelect := False;
  FIsDoNotSpellCheck := False;
  FOptions := TStringList.Create;
end;

destructor TgtPDFormChoiceBox.Destroy;
begin
  if Assigned(FOptions) then
    FreeObject(FOptions);
  if Assigned(FValueList) then
    FreeObject(FValueList);
  inherited;
end;

function TgtPDFormChoiceBox.GetIsDoNotSpellCheck: Boolean;
begin
  if Assigned(FBaseObject) then
    FIsDoNotSpellCheck := (((FFlag shr 22) and 1) = 1);
  Result := FIsDoNotSpellCheck;
end;

function TgtPDFormChoiceBox.GetIsMultiSelect: Boolean;
begin
  if Assigned(FBaseObject) then
    FIsMultiSelect := (((FFlag shr 21) and 1) = 1);
  Result := FIsMultiSelect;
end;

function TgtPDFormChoiceBox.GetIsSortedList: Boolean;
begin
  if Assigned(FBaseObject) then
    FIsSortedList := (((FFlag shr 19) and 1) = 1);
  Result := FIsSortedList;
end;

function TgtPDFormChoiceBox.GetOptionCount: Integer;
begin
  GetOptions(0);
  Result := FValueList.Count;
end;

function TgtPDFormChoiceBox.GetOptions(Index: Integer): AnsiString;
var
  LOpt, LItem, LObj: TgtPDBaseObject;
  LI: Integer;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FValueList) then
    begin
      FValueList := TStringList.Create;
      LOpt := TgtPDDictionary(FBaseObject).LookUp(PDF_OPT);
      if LOpt.IsArray then
      begin
        for LI := 0 to TgtPDArray(LOpt).GetLength - 1 do
        begin
          LItem := TgtPDArray(LOpt).Get(LI);
          if LItem.IsArray then
          begin
            if not Assigned(FOptions) then
              FOptions := TStringList.Create;

            LObj := TgtPDArray(LItem).Get(0);
            FValueList.Add(TgtPDString(LObj).Value);
            LObj := TgtPDArray(LItem).Get(1);
            FOptions.Add(TgtPDString(LObj).Value);
          end
          else if LItem.IsString then
          begin
            FValueList.Add(TgtPDString(LItem).Value);
          end;
        end;
      end;
    end;
  end;
  if (Assigned(FValueList) and (Index < FValueList.Count)) then
    Result := FValueList[Index];
end;

procedure TgtPDFormChoiceBox.SetIsDoNotSpellCheck(Value: Boolean);
begin
  FIsDoNotSpellCheck := Value;

  if Assigned(FBaseObject) then
  begin
    if FIsDoNotSpellCheck then
      FFlag := FFlag or (1 shl 22);
  end;
end;

procedure TgtPDFormChoiceBox.SetIsMultiSelect(Value: Boolean);
begin
  FIsMultiSelect := Value;

  if Assigned(FBaseObject) then
  begin
    if FIsMultiSelect then
      FFlag := FFlag or (1 shl 21);
  end;
end;

procedure TgtPDFormChoiceBox.SetIsSortedList(Value: Boolean);
begin
  FIsSortedList := Value;

  if Assigned(FBaseObject) then
  begin
    if FIsSortedList then
      FFlag := FFlag or (1 shl 19);
  end;
end;
procedure TgtPDFormChoiceBox.SetOptions(AIndex: Integer; AValue: AnsiString);
var
  LOpt, LItem, LObj: TgtPDBaseObject;
  LI: Integer;
begin
  GetOptions(0);
  if Assigned(FBaseObject) then
  begin
    LOpt := TgtPDDictionary(FBaseObject).LookUp(PDF_OPT);
    if Assigned(LOpt) then
    begin
      if LOpt.IsArray then
      begin
        for LI := 0 to TgtPDArray(LOpt).GetLength - 1 do
        begin
          if (LI = AIndex) then
          begin
            LItem := TgtPDArray(LOpt).Get(LI);
            if LItem.IsArray then//if it is a name value pair...
            begin
              LObj := TgtPDArray(LItem).Get(0);//Fetch only the value
              TgtPDString(LObj).Value := AValue;//update with new value
              FValueList.Delete(AIndex);//delete the old value
              FValueList.Insert(AIndex, TgtPDString(LObj).Value);//insert the new value
              Break;
            end
            else if LItem.IsString then//if it is just a value...
            begin
              TgtPDString(LItem).Value := AValue;//update with new value
              FValueList.Delete(AIndex);//delete the old value
              FValueList.Insert(AIndex, TgtPDString(LItem).Value);//insert the new value
              Break;
            end;
          end;
        end;
        if (AIndex = TgtPDArray(LOpt).GetLength) then
        begin
          TgtPDArray(LOpt).Insert(TgtPDString.Create(AValue, False), AIndex);
          FValueList.Add(AValue);//insert the new value
        end;
      end;
    end;
  end;
end;

end.
