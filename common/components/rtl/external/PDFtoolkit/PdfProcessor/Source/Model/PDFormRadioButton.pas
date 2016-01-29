unit PDFormRadioButton;

interface

uses
  Classes, PDTypes, gtObject, PDElement, PDBaseObject, PDFormField, PDRadioItem,
  Contnrs;

type
  TgtPDFormRadioButton = class(TgtPDFormField)
  private
    FOptions: TStringList;
    FSelectedItemIndex: Integer;
    FAtleastOneSelectedItem: Boolean;
    FSymbol: TgtSelectionSymbol;

    function GetOptions(Index: Integer): AnsiString;
    function GetSelectedItemIndex: Integer;
    function GetAtleastOneSelectedItem: Boolean;
    function GetSymbol: TgtSelectionSymbol;
    function GetOptionCount: Integer;

    procedure SetOptions(AIndex: Integer; AValue: AnsiString);
    procedure SetSelectedItemIndex(Value: Integer);
    procedure SetAtleastOneSelectedItem(Value: Boolean);
    procedure SetSymbol(Value: TgtSelectionSymbol);
  protected
    //List of all Radio items
    FRadioItemList: TObjectList;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    function Clone: TgtPDFormField; override;

    function GetRadioItem(AIndex: Integer): TgtPDRadioItem; overload;
    function GetItemCount: Integer;

    function AddRadioItem(ARadioItem: TgtPDRadioItem): Integer;

    property RotationAngle;
    property HighlightMode;
    property DefaultValue;
    property Value;
    property FieldName;
    property Preferences;
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
    property Options[Index: Integer]: AnsiString read GetOptions write SetOptions;
    property OptionCount: Integer read GetOptionCount;
    property Symbol: TgtSelectionSymbol read GetSymbol write SetSymbol;
    property AtleastOneSelectedItem: Boolean read GetAtleastOneSelectedItem
      write SetAtleastOneSelectedItem;
    property SelectedItemIndex: Integer read GetSelectedItemIndex
      write SetSelectedItemIndex;
  end;

implementation

uses
  gtMethods, gtConstants, PDDictionary, PDArray, PDString, PDInteger, SysUtils,
  PDName;

{ TgtPDFormRadioButton }

function TgtPDFormRadioButton.AddRadioItem(ARadioItem: TgtPDRadioItem): Integer;
begin
  //Update the Option list
  FOptions.Add(ARadioItem.Value);

  //Update the RadioItem list object
  Result := FRadioItemList.Add(ARadioItem);
end;

constructor TgtPDFormRadioButton.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FOptions := TStringList.Create;
end;

function TgtPDFormRadioButton.Clone: TgtPDFormField;
begin
  Result := TgtPDFormRadioButton.Create;
end;

constructor TgtPDFormRadioButton.Create;
begin
  inherited;
  FormFieldType := ftRadio;
  FOptions := TStringList.Create;
  FSymbol := csCheck;
  FRadioItemList := TObjectList.Create(True);
end;

destructor TgtPDFormRadioButton.Destroy;
begin
  if Assigned(FOptions) then
    FreeObject(FOptions);
  if Assigned(FRadioItemList) then
    FreeObject(FRadioItemList);
  inherited;
end;

function TgtPDFormRadioButton.GetAtleastOneSelectedItem: Boolean;
begin
  if Assigned(FBaseObject) then
  begin
    FAtleastOneSelectedItem := (((FFlag shr 14) and 1) = 1);
  end;
  Result := FAtleastOneSelectedItem;
end;

function TgtPDFormRadioButton.GetItemCount: Integer;
begin
  Result := 0;
  GetOptions(0);
  if Assigned(FRadioItemList) then
    Result := FRadioItemList.Count;
end;

function TgtPDFormRadioButton.GetOptionCount: Integer;
begin
  if (FOptions.Count = 0) then
    GetOptions(0);
  Result := FOptions.Count;
end;

function TgtPDFormRadioButton.GetOptions(Index: Integer): AnsiString;
var
  LKids, LKid, LAPObj, LNObj: TgtPDBaseObject;
  LI, LJ: Integer;
  LKey: AnsiString;
  LRadioItem: TgtPDRadioItem;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FRadioItemList) then
    begin
      FRadioItemList := TObjectList.Create(True);
      //Array of Radio Items
      LKids := TgtPDDictionary(FBaseObject).LookUp(PDF_KIDS);
      if Assigned(LKids) then
      begin
        for LI := 0 to TgtPDArray(LKids).GetLength - 1 do
        begin
          LKid := TgtPDArray(LKids).Get(LI);
          if Assigned(LKid) then
          begin
            //Create a Radio Item and Add to Item List
            LRadioItem := TgtPDRadioItem.Create(FParentDoc, Self, LKid);
            FRadioItemList.Add(LRadioItem);

            //Gets the AP Dict
            LAPObj := TgtPDDictionary(LKid).LookUp(PDF_AP);
            if Assigned(LAPObj) then
            begin
              //Gets the Normal Appearence Dict and Sreach through
              //it to get the Allowed values
              LNObj := TgtPDDictionary(LAPObj).LookUp(PDF_N);
              if Assigned(LNObj) then
              begin
                for LJ := 0 to TgtPDDictionary(LNObj).GetLength - 1 do
                begin
                  LKey := TgtPDDictionary(LNObj).GetKey(LJ);
                  // If NoToggleToOff flag is set, then do not add the Off state.
                  if (((FFlag shr 14) and 1) = 1) and (LKey = PDF_OFF) then
                    Continue;
                  //Add the Allowed value to the Option list
                  FOptions.Add(LKey);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  if (Assigned(FOptions) and (Index < FOptions.Count)) then
    Result := FOptions[Index];
end;

function TgtPDFormRadioButton.GetRadioItem(AIndex: Integer): TgtPDRadioItem;
var
  LI: Integer;
begin
  Result := nil;
  if ((AIndex >= 0) and (AIndex < OptionCount)) then
  begin
    for LI := 0 to FRadioItemList.Count - 1 do
    begin
      if LI = AIndex then
      begin
        Result := TgtPDRadioItem(FRadioItemList[LI]);
        Exit;
      end;
    end;
  end;
end;

//function TgtPDFormRadioButton.GetRadioItem(AName: AnsiString): TgtPDRadioItem;
//begin
//  Result := nil;
//  if (OptionCount <> 0) then
//  begin
//    Result := GetRadioItem(FOptions.IndexOf(AName));
//  end;
//end;

function TgtPDFormRadioButton.GetSelectedItemIndex: Integer;
var
  LI: Integer;
begin
  if (AtleastOneSelectedItem = True) then
  begin
    for LI := 0 to OptionCount - 1 do
    begin
      if Value = Options[LI] then
      begin
        FSelectedItemIndex := LI;
        Break;
      end;
    end;
  end;
  Result := FSelectedItemIndex;
end;

function TgtPDFormRadioButton.GetSymbol: TgtSelectionSymbol;
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

procedure TgtPDFormRadioButton.SetAtleastOneSelectedItem(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  FAtleastOneSelectedItem := Value;

  if Assigned(FBaseObject) then
  begin
    FFlag := FFlag or (1 shl 14);
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FF);
    if Assigned(LObj) then
      TgtPDInteger(LObj).Value := FFlag
    else
      TgtPDDictionary(FBaseObject).Add(PDF_FF, TgtPDInteger.Create(FFlag));
  end;
end;

procedure TgtPDFormRadioButton.SetOptions(AIndex: Integer; AValue: AnsiString);
var
  LKids, LKid, LAPObj, LNObj, LASObj: TgtPDBaseObject;
  LJ: Integer;
  LKey: AnsiString;
begin
  GetOptions(0);
  if Assigned(FBaseObject) then
  begin
    LKids := TgtPDDictionary(FBaseObject).LookUp(PDF_KIDS);
    if Assigned(LKids) then
    begin
      LKid := TgtPDArray(LKids).Get(AIndex);
      if Assigned(LKid) then
      begin
        //update AS value
        LASObj := TgtPDDictionary(LKid).LookUp(PDF_AS);
        if (Assigned(LASObj) and (TgtPDName(LASObj).Value <> PDF_OFF)) then
        begin
          TgtPDName(LASObj).Value := AValue;
          //change parent default value
          TgtPDDictionary(FBaseObject).SetKeyValue(PDF_V, TgtPDName.Create(AValue));
          TgtPDDictionary(FBaseObject).SetKeyValue(PDF_DV, TgtPDName.Create(AValue));
        end;

        LAPObj := TgtPDDictionary(LKid).LookUp(PDF_AP);
        if Assigned(LAPObj) then
        begin
          LNObj := TgtPDDictionary(LAPObj).LookUp(PDF_N);
          if Assigned(LNObj) then
          begin
            for LJ := 0 to TgtPDDictionary(LNObj).GetLength - 1 do
            begin
              LKey := TgtPDDictionary(LNObj).GetKey(LJ);
              if (LKey <> PDF_OFF) then
              begin
                TgtPDDictionary(LNObj).SetKey(LJ, AValue);
                FOptions.Delete(AIndex);
                FOptions.Insert(AIndex, AValue);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TgtPDFormRadioButton.SetSelectedItemIndex(Value: Integer);
begin
  FSelectedItemIndex := Value;
end;

procedure TgtPDFormRadioButton.SetSymbol(Value: TgtSelectionSymbol);
var
//  LSymbol: AnsiString;
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
