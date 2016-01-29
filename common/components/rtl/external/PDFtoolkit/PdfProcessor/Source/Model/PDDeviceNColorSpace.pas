{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDDeviceNColorSpace;

interface

uses
  PDColorSpace, gtObject, PDElement, PDBaseObject, PDTypes, PDFunction;

type
  TgtPDDeviceNColorSpace = class(TgtPDColorSpace)
  private
    // number of components
    FNoOfComps: Integer;

    // colorant names
    FNames: array[0..ColorMapMaxComps] of AnsiString;

    // alternate color space
    FAlt: TgtPDColorSpace;
    FFunc: TgtPDFunction;
    FIsNonMarking: Boolean;
  public
    constructor Create(ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    function GetMode: TgtColorSpaceMode; override;
    function GetNoOfComps: Integer; override;
    function IsNonMarking: Boolean;
    function GetColorantName(AIndex: Integer): AnsiString;
    function GetAlt: TgtPDColorSpace;
    function GetTintTransformFunc: TgtPDFunction;

    procedure GetDefaultColor(var Color: TgtColor); override;
    procedure GetGray(Color: TgtColor; var GrayColor: TgtGray); override;
    procedure GetRGB(Color: TgtColor; var RGBColor: TgtRGB); override;
    procedure GetCMYK(Color: TgtColor; var CMYKColor: TgtCMYK); override;
    function Copy: TgtPDColorSpace; override;
    procedure Update; override;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  PDArray, gtMethods, PDName;

{ TgtPDDeviceNColorSpace }

function TgtPDDeviceNColorSpace.Copy: TgtPDColorSpace;
var
  LColorSpace: TgtPDDeviceNColorSpace;
  LI: Integer;
begin
  LColorSpace := TgtPDDeviceNColorSpace.Create(FBaseObject);
  LColorSpace.FIsNonMarking := FIsNonMarking;
  for LI := 0 to FNoOfComps - 1 do
  begin
    LColorSpace.FNames[LI] := FNames[LI];
  end;

  Result := LColorSpace;
end;

constructor TgtPDDeviceNColorSpace.Create(ABaseObject: TgtPDBaseObject);
var
  LObj, LObj2: TgtPDBaseObject;
  LI: Integer;
begin
  FBaseObject := ABaseObject;

  if not ((TgtPDArray(FBaseObject).GetLength <> 4) or
    (TgtPDArray(FBaseObject).GetLength <> 5)) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad DeviceN color space');
    {$ENDIF}
    Exit;
  end;

  LObj := TgtPDArray(FBaseObject).Get(1);
  if not LObj.IsArray then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad DeviceN color space (names)');
    {$ENDIF}
    Exit;
  end;

  //Setting NO: of components
  if Assigned(LObj) then
  begin
    FNoOfComps := TgtPDArray(LObj).GetLength;
    if (FNoOfComps > ColorMapMaxComps) then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('DeviceN color space with too many (%d > %d) components',
        [FNoOfComps, ColorMapMaxComps]);
      {$ENDIF}
      FNoOfComps := ColorMapMaxComps;
    end;
  end;

  //Getting all the colorspaces from the Array
  for LI := 0 to FNoOfComps - 1 do
  begin
    LObj2 := TgtPDArray(LObj).Get(LI);
    if (not LObj2.IsName) then
    begin
      {$IFDEF DEBUG}
      Logger.LogError(('Bad DeviceN color space (names)'));
      {$ENDIF}
      Exit;
    end;
    FNames[LI] := TgtPDName(LObj2).Value;
  end;

  //Assigning the Alternate ColorSpace if any
  LObj := TgtPDArray(FBaseObject).Get(2);
  FAlt := TgtPDColorSpace.MakeColorSpace(LObj);
  if not Assigned(FAlt) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad DeviceN color space (alternate color space)');
    {$ENDIF}
    Exit;
  end;

  FIsNonMarking := True;
  for LI := 0 to FNoOfComps - 1 do
    FIsNonMarking := not (FNames[LI] = 'None');

  LObj := TgtPDArray(FBaseObject).Get(3);
  FFunc := TgtPDFunction.MakeFunction(LObj);
  if (not assigned(FFunc)) then
  begin
    FreeObject(FAlt);
    Exit;
  end;
end;

destructor TgtPDDeviceNColorSpace.Destroy;
begin
  if Assigned(FAlt) then FAlt.Free;
  if Assigned(FFunc) then FFunc.Free;
  
  inherited;
end;

function TgtPDDeviceNColorSpace.GetAlt: TgtPDColorSpace;
begin
  Result := FAlt;
end;

procedure TgtPDDeviceNColorSpace.GetCMYK(Color: TgtColor;
  var CMYKColor: TgtCMYK);
var
  LX, LC: TgtDoubleArray;
  LColor: TgtColor;
  LI: Integer;
begin
  for LI := 0 to FNoOfComps - 1 do
    LX[LI] := ColToDbl(Color.Comps[LI]);

  if Assigned(FFunc) then
    FFunc.Transform(LX, LC);

  for LI := 0 to FAlt.GetNoOfComps - 1 do
    LColor.Comps[LI] := DblToCol(LC[LI]);

  FAlt.GetCMYK(LColor, CMYKColor);

end;

function TgtPDDeviceNColorSpace.GetColorantName(AIndex: Integer): AnsiString;
begin
  Result := FNames[AIndex];
end;

procedure TgtPDDeviceNColorSpace.GetDefaultColor(var Color: TgtColor);
var
  LI: Integer;
begin
  for LI := 0 to FNoOfComps - 1 do
    Color.Comps[LI] := $10000;
end;

procedure TgtPDDeviceNColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
var
  LX, LC: TgtDoubleArray;
  LColor: TgtColor;
  LI: Integer;
begin
  for LI := 0 to FNoOfComps - 1 do
    LX[LI] := ColToDbl(Color.Comps[LI]);

  FFunc.Transform(LX, LC);

  for LI := 0 to FAlt.GetNoOfComps - 1 do
    LColor.Comps[LI] := DblToCol(LC[LI]);

  FAlt.GetGray(LColor, GrayColor);
end;

function TgtPDDeviceNColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csDeviceN;
end;

function TgtPDDeviceNColorSpace.GetNoOfComps: Integer;
begin
  Result := FNoOfComps;
end;

procedure TgtPDDeviceNColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
var
  LX, LC: TgtDoubleArray;
  LColor: TgtColor;
  LI: Integer;
begin
  for LI := 0 to FNoOfComps - 1 do
    LX[LI] := ColToDbl(Color.Comps[LI]);

  if Assigned(FFunc) then
    FFunc.Transform(LX, LC);

  if Assigned(FAlt) then
  begin
    for LI := 0 to FAlt.GetNoOfComps - 1 do
      LColor.Comps[LI] := DblToCol(LC[LI]);

    FAlt.GetRGB(LColor, RGBColor);
  end;

end;

function TgtPDDeviceNColorSpace.GetTintTransformFunc: TgtPDFunction;
begin
  Result := nil;
end;

function TgtPDDeviceNColorSpace.IsNonMarking: Boolean;
begin
  Result := FIsNonMarking;
end;

procedure TgtPDDeviceNColorSpace.Update;
begin
  inherited;

end;

end.
