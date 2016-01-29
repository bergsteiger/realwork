unit PDFormCheckBox;

interface

uses
  Classes, gtObject, PDElement, PDBaseObject, PDFormField;

type
  TgtPDFormCheckBox = class(TgtPDFormField)
  private
    FSymbol: TgtSelectionSymbol;
    //True if the Check box is checked
    FIsChecked: Boolean;

    //Stores the On and OFF option of a Check box
    FOption: TStringList;

    function GetIsChecked: Boolean;
    function GetOption(Index: Integer): AnsiString;
    function GetOptionCount: Integer;

    procedure SetIsChecked(AValue: Boolean);
    function GetSymbol: TgtSelectionSymbol;
    procedure SetSymbol(Value: TgtSelectionSymbol);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    function Clone: TgtPDFormField; override;

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
    property Font;
    property BorderWidth;
    property IsReadOnly;
    property IsChecked: Boolean read GetIsChecked write SetIsChecked;
    property Option[Index: Integer]: AnsiString read GetOption;
    property OptionCount: Integer read GetOptionCount;
    property Symbol: TgtSelectionSymbol read GetSymbol write SetSymbol;
  end;

implementation

uses
  PDDictionary, gtConstants, gtMethods, PDString, PDArray, PDName;

{ TgtPDFormCheckBox }

constructor TgtPDFormCheckBox.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FIsChecked := False;
end;

function TgtPDFormCheckBox.Clone: TgtPDFormField;
begin
  Result := TgtPDFormCheckBox.Create;
end;

constructor TgtPDFormCheckBox.Create;
begin
  inherited;
  FIsChecked := False;
  FormFieldType := ftCheckBox;
  FOption := TStringList.Create;
end;

destructor TgtPDFormCheckBox.Destroy;
begin
  if Assigned(FOption) then
    FreeObject(FOption);
  inherited;
end;

function TgtPDFormCheckBox.GetIsChecked: Boolean;
var
  LASDict: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if Value <> '' then
       FIsChecked := (Value <> PDF_OFF)
    else
    begin
      LASDict := TgtPDDictionary(FBaseObject).LookUp(PDF_AS);
      if Assigned(LASDict) then
        FIsChecked := (TgtPDName(LASDict).Value <> PDF_OFF);
    end;
  end;
  Result := FIsChecked;
end;

function TgtPDFormCheckBox.GetOption(Index: Integer): AnsiString;
var
  LMKObj, LNObj: TgtPDBaseObject;
  LValue: AnsiString;
  LI: Integer;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FOption) then
    begin
      FOption := TStringList.Create;
      LMKObj := TgtPDDictionary(FBaseObject).LookUp(PDF_AP);
      if Assigned(LMKObj) then
      begin
        LNObj := TgtPDDictionary(LMKObj).LookUp(PDF_N);
        if Assigned(LNObj) then
        begin
          for LI := 0 to TgtPDDictionary(LNObj).GetLength - 1 do
          begin
            LValue := TgtPDDictionary(LNObj).GetKey(LI);
            FOption.Add(LValue);
          end;
        end;
      end;
    end;
  end;

  if (Assigned(FOption) and (Index < FOption.Count)) then
    Result := FOption[Index];
end;

function TgtPDFormCheckBox.GetOptionCount: Integer;
begin
  Result := 0;
  GetOption(0);
  if Assigned(FOption) then
    Result := FOption.Count;
end;

function TgtPDFormCheckBox.GetSymbol: TgtSelectionSymbol;
var
  LKids, LKid, LMKObj, LCAObj: TgtPDBaseObject;
  LCAValue: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LKids := TgtPDDictionary(FBaseObject).LookUp(PDF_KIDS);
    if Assigned(LKids) then
    begin
      LKid := TgtPDArray(LKids).Get(0);
      if Assigned(LKid) then
      begin
        LMKObj := TgtPDDictionary(LKid).LookUp(PDF_MK);
        if Assigned(LMKObj) then
        begin // CA is the Charecter used for displaying which kind of symbol
              //to be used in the Radio button when it is selected
          LCAObj := TgtPDDictionary(LMKObj).LookUp(PDF_CA);
          if Assigned(LCAObj) then
          begin
            LCAValue := TgtPDString(LCAObj).Value;
            if LCAValue = '4' then FSymbol := csCheck
            else if LCAValue = 'l' then FSymbol := csCircle
            else if LCAValue = '6' then FSymbol := csCross
            else if LCAValue = 'n' then FSymbol := csSquare
            else if LCAValue = 'H' then FSymbol := csStar
            else if LCAValue = 'u' then FSymbol := csDiamond;
          end;
        end;
      end;
    end;
  end;
  Result := FSymbol;
end;

procedure TgtPDFormCheckBox.SetIsChecked(AValue: Boolean);
var
  LI: Integer;
begin
  FIsChecked := AValue;
  if Assigned(FBaseObject) then
  begin
    for LI := 0 to OptionCount - 1 do
    begin
      if ((AValue = True) and (Option[LI] <> PDF_OFF)) then
      begin
        TgtPDDictionary(FBaseObject).SetKeyValue(PDF_AS,
          TgtPDName.Create(Option[LI]));
        Value := Option[LI];
        Break;
      end;
    end;
    if (AValue = False) then
    begin
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_AS,
        TgtPDName.Create(PDF_OFF));
      Value := PDF_OFF;
    end;
  end;
end;

procedure TgtPDFormCheckBox.SetSymbol(Value: TgtSelectionSymbol);
var
  LMKObj, LObj: TgtPDBaseObject;
begin
  FSymbol := Value;
  LObj := nil;
  if Assigned(FBaseObject) then
  begin
    LMKObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LMKObj) then
    begin
      LObj := TgtPDDictionary(LMKObj).LookUp(PDF_CA);
    end
    else
    begin
      LMKObj := TgtPDDictionary.Create(Self);
      TgtPDDictionary(FBaseObject).Add(PDF_MK, LMKObj);
    end;
    case FSymbol of
      csCheck:
        begin
          if Assigned(LObj) then
            TgtPDString(LObj).Value := '4'
          else
            TgtPDDictionary(LMKObj).Add(PDF_CA, TgtPDString.Create('4', False));
        end;
      csCircle:
        begin
          if Assigned(LObj) then
            TgtPDString(LObj).Value := 'l'
          else
            TgtPDDictionary(LMKObj).Add(PDF_CA, TgtPDString.Create('l', False));
        end;
      csCross:
        begin
          if Assigned(LObj) then
            TgtPDString(LObj).Value := '6'
          else
            TgtPDDictionary(LMKObj).Add(PDF_CA, TgtPDString.Create('6', False));
        end;
      csDiamond:
        begin
          if Assigned(LObj) then
            TgtPDString(LObj).Value := 'u'
          else
            TgtPDDictionary(LMKObj).Add(PDF_CA, TgtPDString.Create('u', False));
        end;
      csSquare:
        begin
          if Assigned(LObj) then
            TgtPDString(LObj).Value := 'n'
          else
            TgtPDDictionary(LMKObj).Add(PDF_CA, TgtPDString.Create('n', False));
        end;
      csStar:
        begin
          if Assigned(LObj) then
            TgtPDString(LObj).Value := 'H'
          else
            TgtPDDictionary(LMKObj).Add(PDF_CA, TgtPDString.Create('H', False));
        end;
    end;
  end;
end;

end.
