{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDResource;

interface

uses
  Contnrs, PDElement, gtObject, PDBaseObject, PDFont, PDXObject, PDColorSpace,
  PDGState, PDPattern, PDIndirectRef, PDName;

type
  TgtPDResourceType = (resExtGState, resColorSpace, resPattern, resShading,
    resXObject, resFont, resProcSet, resProperties);

  TgtPDEnumProcSetEvent = procedure(var Name: AnsiString;
    var Cancel: Boolean) of object;

  TgtPDResource = class(TgtPDElement)
  private
    FFontCount: Integer;
    // List which store all the Font objects in the current Resource
    FFontList: TObjectList;
    // List which store all the XOjects in the current Resource
    FXObjectList: TObjectList;
    // List which store all the ColorSpace objects in the current Resource
    FColorSpaceList: TObjectList;
    // List which store all the GState objects in the current Resource
    FGStateList: TObjectList;

    FCanFreeFont: Boolean;

    function GetFontCount: Integer;
    function GetFontList: TObjectList;
    function GetXObjectCount: Integer;
    function GetGStateCount: Integer;
    function GetColorSpaceCount: Integer;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;
    procedure Update; override;
    //Given the post-script name of the font,
    //returns the corresponding existing font tag...
    function GetFontByName(APostScriptName: AnsiString): TgtPDFont;
    function LookUpFont(const Name: AnsiString): TgtPDFont;
    function LookUpXObject(const Name: AnsiString): TgtPDXObject;
    function LookUpColorSpace(const Name: AnsiString): TgtPDColorSpace;
    function LookUpGState(const Name: AnsiString): TgtPDGState;
    function LookUpPattern(const Name: AnsiString): TgtPDPattern;
    function GetFont(Index: Integer): TgtPDFont;
    function GetXObject(Index: Integer): TgtPDXObject;
    function GetGState(Index: Integer): TgtPDGState;
    function GetColorSpace(Index: Integer): TgtPDColorSpace;
    function GetResourceName(ResourceType: TgtPDResourceType): AnsiString;

    procedure SetFontResource(AFontList: TObjectList);

    function AddXObject(AXObject: TgtPDXObject): Integer;
    function AddFont(AFont: TgtPDFont): Integer;
    function AddColorSpace(AColorSpace: TgtPDColorSpace): Integer;
    function AddPattern(APattern: TgtPDPattern): Integer;
    function AddExtGState(AExtGState: TgtPDGState): Integer;
    property FontList: TObjectList read GetFontList;
    property FontCount: Integer read GetFontCount;
    property XObjectCount: Integer read GetXObjectCount;
    property GStateCount: Integer read GetGStateCount;
    property ColorSpaceCount: Integer read GetColorSpaceCount;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtConstants, PDDictionary, gtMethods, PDDocument;

{ TgtPDResource }

(**
 *  Constructor
 *  @param AParentDoc is the Document for this object
 *  @param AParentElement is the parent Dictionary for this object
 *  @param ABaseObject is the Object defining this object(Resource Dict in this case)
 *  @algorithm
 *         1.	Start
 *         2.	FParentDoc := AParentDoc
 *         3.	FParentElement := AParentElement
 *         4.	FBaseObject := ABaseObject
 *         5.	End
 *
 *)

function TgtPDResource.AddColorSpace(AColorSpace: TgtPDColorSpace): Integer;
begin
  if not Assigned(FColorSpaceList) then
    FColorSpaceList := TObjectList.Create;

  Result := FColorSpaceList.Add(AColorSpace);
end;

function TgtPDResource.AddExtGState(AExtGState: TgtPDGState): Integer;
begin
  if not Assigned(FGStateList) then
    FGStateList := TObjectList.Create(True);
  Result := FGStateList.Add(AExtGState);
end;

function TgtPDResource.AddFont(AFont: TgtPDFont): Integer;
begin
  if not Assigned(FFontList) then
    FFontList := TObjectList.Create;

  Result := FFontList.Add(AFont);
end;

function TgtPDResource.AddPattern(APattern: TgtPDPattern): Integer;
begin
  Result := 0;
end;

function TgtPDResource.AddXObject(AXObject: TgtPDXObject): Integer;
begin
  if not Assigned(FXObjectList) then
    FXObjectList := TObjectList.Create;

  Result := FXObjectList.Add(AXObject);
end;

constructor TgtPDResource.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  FFontCount := 0;
  FCanFreeFont := True;
end;

destructor TgtPDResource.Destroy;
begin
  if FCanFreeFont then
    if Assigned(FFontList) then FreeObject(FFontList);
  if Assigned(FColorSpaceList) then FreeObject(FColorSpaceList);
  if Assigned(FXObjectList) then FreeObject(FXObjectList);
  if Assigned(FGStateList) then FreeObject(FGStateList);
  inherited;
end;

function TgtPDResource.GetColorSpace(Index: Integer): TgtPDColorSpace;
begin
  Result := nil;
  if not Assigned(FColorSpaceList) then
    LookUpColorSpace('');

  if Assigned(FColorSpaceList) and (Index < FColorSpaceList.Count) then
    Result := TgtPDColorSpace(FColorSpaceList.Items[Index]);
end;

function TgtPDResource.GetColorSpaceCount: Integer;
begin
  Result := 0;
  if not Assigned(FColorSpaceList) then
    LookUpColorSpace('');
    
  if Assigned(FColorSpaceList) then
    Result := FColorSpaceList.Count;
end;

function TgtPDResource.GetFont(Index: Integer): TgtPDFont;
begin
  Result := nil;
  if not Assigned(FFontList) then
    LookUpFont('');

  if Assigned(FFontList) and (Index < FFontList.Count) then
    Result := TgtPDFont(FFontList.Items[Index]);
end;

function TgtPDResource.GetFontCount: Integer;
begin
  if not Assigned(FFontList) then
    LookUpFont('');
  if Assigned(FFontList) then
    FFontCount := FFontList.Count;
  Result := FFontCount;
end;

function TgtPDResource.GetFontList: TObjectList;
begin
  Result := nil;
  if FontCount <> 0 then
    Result := FFontList;
end;

function TgtPDResource.GetGState(Index: Integer): TgtPDGState;
begin
  Result := nil;
  if not Assigned(FGStateList) then
    LookUpGState('');

  if Assigned(FGStateList) and (Index < FGStateList.Count) then
    Result := FGStateList.Items[Index] as TgtPDGState;
end;

function TgtPDResource.GetGStateCount: Integer;
begin
  Result := 0;
  if not Assigned(FGStateList) then
    LookUpGState('');

  if Assigned(FGStateList) then
    Result := FGStateList.Count;
end;

function TgtPDResource.GetFontByName(APostScriptName: AnsiString): TgtPDFont;
var
  LI: Integer;
begin
  Result := nil;
  if Assigned(BaseObject) then
  begin
    //Traverse through all the font objects in the current resource
    for LI := 0 to FontCount - 1 do
    begin
      if GetFont(LI).Name = APostScriptName then
      begin
        //if found return the font tag
        Result := GetFont(LI);
        Exit;
      end;
    end;
  end;
end;

function TgtPDResource.GetResourceName(ResourceType: TgtPDResourceType): AnsiString;
var
  LRandomNum: AnsiString;
begin
  LRandomNum := IntegerToString(Random(MaxInt));
  case ResourceType of
    resExtGState: Result := 'PPGS' + LRandomNum;
    resColorSpace: Result := 'PPCS' + LRandomNum;
    resPattern: Result := 'PPPtrn' + LRandomNum;
    resShading: Result := 'PPShd' + LRandomNum;
    resXObject: Result := 'PPXbj' + LRandomNum;
    resFont: Result := 'PPFnt' + LRandomNum;
    resProcSet: Result := 'PPProS' + LRandomNum;
    resProperties: Result := 'PPProp' + LRandomNum;
  end;
end;

function TgtPDResource.GetXObject(Index: Integer): TgtPDXObject;
begin
  Result := nil;
  if not Assigned(FXObjectList) then
    LookUpXObject('');

  if Assigned(FXObjectList) and (Index < FXObjectList.Count) then
    Result := FXObjectList.Items[Index] as TgtPDXObject;
end;

function TgtPDResource.GetXObjectCount: Integer;
begin
  Result := 0;
  if not Assigned(FXObjectList) then
    LookUpXObject('');

  if Assigned(FXObjectList) then
    Result := FXObjectList.Count;
end;

function TgtPDResource.LookUpColorSpace(const Name: AnsiString): TgtPDColorSpace;
var
  LColorSpaceDict: TgtPDDictionary;
  I: Integer;
  LTag: AnsiString;
  LObj: TgtPDBaseObject;
begin
  Result := nil;
  if not Assigned(FColorSpaceList) then
  begin
    FColorSpaceList := TObjectList.Create;

    LColorSpaceDict := TgtPDDictionary(FBaseObject).LookUp(PDF_COLORSPACE) as TgtPDDictionary;
    if Assigned(LColorSpaceDict) and LColorSpaceDict.IsDict then
    begin
      for I := 0 to LColorSpaceDict.GetLength - 1 do
      begin
        LTag := LColorSpaceDict.GetKey(I);
        LObj := LColorSpaceDict.GetValue(I);
        FColorSpaceList.Add(TgtPDColorSpace.MakeColorSpace(LObj, LTag));
      end;
    end
    else
    begin
    {$IFDEF DEBUG}
      Logger.LogError('Cannot find ColorSpace entry in resource dict');
    {$ENDIF}
      Exit;
    end;
  end;

  if FColorSpaceList.Count < 1 then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('No ColorSpaces found for page');
    {$ENDIF}
    Exit;
  end;

  for I := 0 to FColorSpaceList.Count - 1 do
  begin
    if Assigned(TgtPDColorSpace(FColorSpaceList.Items[I])) and
      TgtPDColorSpace(FColorSpaceList.Items[I]).IsName(Name) then
    begin
      Result := TgtPDColorSpace(FColorSpaceList.Items[I]);
      Break;
    end;
  end;
  if Result = nil then
  begin
  {$IFDEF DEBUG}
    Logger.LogError('Cannot find ColorSpace of name %s', [Name]);
  {$ENDIF}
  end;
end;

(**
 *  This function Lookup for a Font Dictionary in the Resource and returns
 *    currusponding PDFont object
 *  @param Name is the Font name in the Font Dictionary
 *  @return PDFont object
 *  @algorithm
 *         1.	Start
 *         2.	Return Nil
 *         3.	IF NOT Assigned FFontList Then
 *         4.	begin
 *           a.	LFontDict := LookUp for Font in FBaseObject
 *           b.	IF Assigned LFontDict Then
 *           c.	Begin
 *             i.	Create TObjectList with FFontList
 *             ii.	Loop LI from 0 To LFontDict.GetLength - 1
 *             iii.	Begin
 *               1.	LFontObj := LFontDict.get(LI)
 *               2.	FFontList.Add(Call TgtPDFont.MakeFont(FParentDoc, Self,
 *                  LFontObj, Name) )
 *             iv.	End
 *           d.	End
 *         5.	End
 *         6.	IF Assigned FFontList Then
 *         7.	Loop LI From 0 To FFontList.Count - 1
 *           a.	IF TgtPDFont(FFontList.Items[LI]).IsName(Name) Then
 *           b.	begin
 *             i.	Return TgtPDFont(FFontList.Items[LI])
 *             ii.	Exit
 *           c.	End
 *         8.	End
 *         9.	End
 *
 *)

function TgtPDResource.LookUpFont(const Name: AnsiString): TgtPDFont;
var
  LFontList: TgtPDBaseObject;
  I: Integer;
  LFont: TgtPDFont;
  LTag: AnsiString;
begin
  Result := nil;
  if not Assigned(FFontList) then
  begin
    LFontList := TgtPDDictionary(FBaseObject).LookUp(PDF_FONT);
    if Assigned(LFontList) then
    begin
      FFontList := TObjectList.Create(True);
      for I := 0 to TgtPDDictionary(LFontList).GetLength - 1 do
      begin
        LTag := TgtPDDictionary(LFontList).GetKey(I);
        LFont := TgtPDFont.MakeFont(ParentDoc, Self, LTag,
          TgtPDDictionary(LFontList).GetValue(I));
        if Assigned(LFont) then
          FFontList.Add(LFont);
        if Name = LTag then
          Result := LFont;
      end;
    end;
  end;

  if ((Result = nil) and (FFontList <> nil)) then
  begin
    for I := 0 to FFontList.Count - 1 do
    begin
      if Name = TgtPDFont(FFontList.Items[I]).Tag then
      begin
        Result := TgtPDFont(FFontList.Items[I]);
        Break;
      end;
    end;
  end;
end;

function TgtPDResource.LookUpGState(const Name: AnsiString): TgtPDGState;
var
  LGSList: TgtPDBaseObject;
  I: Integer;
  LTag: AnsiString;
  LGState: TgtPDGState;
begin
  Result := nil;
  if not Assigned(FGStateList) then
  begin
    LGSList := TgtPDDictionary(FBaseObject).LookUp(PDF_EXTGSTATE);
    if Assigned(LGSList) then
    begin
      FGStateList := TObjectList.Create(True);
      for I := 0 to TgtPDDictionary(LGSList).GetLength - 1 do
      begin
        LTag := TgtPDDictionary(LGSList).GetKey(I);
        LGState := TgtPDGState.Create(ParentDoc, Self,
          TgtPDDictionary(LGSList).GetValue(I), LTag);
        FGStateList.Add(LGState);
        if Name = LTag then
          Result := LGState;
      end;
    end;
  end;

  if ((Result = nil) and (FGStateList <> nil)) then
  begin
    for I := 0 to FGStateList.Count - 1 do
    begin
      if Name = TgtPDGState(FGStateList.Items[I]).Tag then
      begin
        Result := TgtPDGState(FGStateList.Items[I]);
        Break;
      end;
    end;
  end;

end;

function TgtPDResource.LookUpPattern(const Name: AnsiString): TgtPDPattern;
begin
  Result := nil;
end;

function TgtPDResource.LookUpXObject(const Name: AnsiString): TgtPDXObject;
var
  LXObjDict: TgtPDBaseObject;
  LObj: TgtPDBaseObject;
  LTag: AnsiString;
  I: Integer;
begin
  Result := nil;
  if not Assigned(FXObjectList) then
  begin
    FXObjectList := TObjectList.Create;

    LXObjDict := TgtPDDictionary(FBaseObject).LookUp(PDF_XOBJECT);
    if Assigned(LXObjDict) and LXObjDict.IsDict then
    begin
      for I := 0 to TgtPDDictionary(LXObjDict).GetLength - 1 do
      begin
        LTag := TgtPDDictionary(LXObjDict).GetKey(I);
        LObj := TgtPDDictionary(LXObjDict).GetValue(I);
        FXObjectList.Add(TgtPDXObject.MakeXObject(FParentDoc, Self, LObj, LTag));
      end;
    end
    else
    begin
    {$IFDEF DEBUG}
      Logger.LogError('Cannot find XObject entry in resource dict');
    {$ENDIF}
      Exit;
    end;
  end;

  if FXObjectList.Count < 1 then
  begin
  {$IFDEF DEBUG}
    Logger.LogError('No XObject''s found for page');
  {$ENDIF}
    Exit;
  end;

  for I := 0 to FXObjectList.Count - 1 do
  begin
    if Assigned(FXObjectList.Items[I]) and
      TgtPDXObject(FXObjectList.Items[I]).IsName(Name) then
    begin
      Result := TgtPDXObject(FXObjectList.Items[I]);
      Break;
    end;
  end;
  if Result = nil then
  begin
  {$IFDEF DEBUG}
    Logger.LogError('Cannot find XObject of name %s', [Name]);
  {$ENDIF}
  end;
end;

procedure TgtPDResource.SetFontResource(AFontList: TObjectList);
begin
  FCanFreeFont := False;
  FFontList := AFontList;
end;

procedure TgtPDResource.Update;
var
  LI: Integer;
//  LIndRef, LObj: TgtPDBaseObject;
begin
//  inherited;
  if Assigned(FFontList) then
  begin
    for LI := 0 to GetFontCount - 1 do
    begin
      TgtPDFont(FFontList.Items[LI]).Update;
    end;
    FreeObject(FFontList);
  end;

  if Assigned(FColorSpaceList) then
  begin
    for LI := 0 to FColorSpaceList.Count - 1 do
      TgtPDColorSpace(FColorSpaceList.Items[LI]).Update;
    FreeObject(FColorSpaceList);
  end;

//  if Assigned(FXObjectList) then
//  begin
//    for LI := 0 to FXObjectList.Count - 1 do
//      TgtPDXObject(FXObjectList.Items[LI]).Update;
//    FreeObject(FXObjectList);
//  end;
end;

end.
