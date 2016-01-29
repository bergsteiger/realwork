{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDSeparationColorSpace;

interface

uses
  PDColorSpace, PDElement, gtObject, PDTypes, PDBaseObject, PDFunction;

type
  TgtPDSeparationColorSpace = class(TgtPDColorSpace)
  private
    // colorant name
    FName: AnsiString;

    // alternate color space
    FAlt: TgtPDColorSpace;

    // tint transform (into alternate color space)
    FFunc: TgtPDFunction;

    FIsNonMarking: Boolean;
  public
    constructor Create(ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    function GetMode: TgtColorSpaceMode; override;
    function GetNoOfComps: Integer; override;
    function IsNonMarking: Boolean;
    function GetColorantName: AnsiString;
    function GetAlt: TgtPDColorSpace;
    function GetFunction: TgtPDFunction;

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
  PDArray, PDName, gtMethods, gtConstants;

{ TgtPDSeparationColorSpace }

function TgtPDSeparationColorSpace.Copy: TgtPDColorSpace;
begin
  Result := TgtPDSeparationColorSpace.Create(FBaseObject);
end;

constructor TgtPDSeparationColorSpace.Create(ABaseObject: TgtPDBaseObject);
var
  LObj: TgtPDBaseObject;
begin
  FBaseObject := ABaseObject;

//  LObj := nil;
  FAlt := nil;

  if (TgtPDArray(FBaseObject).GetLength <> 4) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad Separation color space');
    {$ENDIF}
    Exit;
  end;

  LObj := TgtPDArray(FBaseObject).Get(1);
  if not LObj.IsName then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad Separation color space (name)');
    {$ENDIF}
    Exit;
  end;

  FName := TgtPDName(LObj).Value;

  LObj := TgtPDArray(FBaseObject).Get(2);
  FAlt := TgtPDColorSpace.MakeColorSpace(LObj);
  if not Assigned(FAlt) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad Separation color space (alternate color space)');
    {$ENDIF}
    Exit;
  end;

  FIsNonMarking := (FName = 'None');

  LObj := TgtPDArray(FBaseObject).Get(3);
  FFunc := TgtPDFunction.MakeFunction(LObj);
  if (not assigned(FFunc)) then
  begin
//    FreeObject(FAlt);
//    Exit;
  end;
end;

destructor TgtPDSeparationColorSpace.Destroy;
begin
  if Assigned(FAlt) then FAlt.Free;
  if Assigned(FFunc) then FFunc.Free;

  inherited;
end;

function TgtPDSeparationColorSpace.GetAlt: TgtPDColorSpace;
begin
  Result := FAlt;
end;

procedure TgtPDSeparationColorSpace.GetCMYK(Color: TgtColor;
  var CMYKColor: TgtCMYK);
var
  LC: TgtDoubleArray;
  LX: TgtDoubleArray;
  LColor: TgtColor;
  LI: Integer;
begin
  if assigned(FAlt) then
  begin
    LX[0] := ColToDbl(Color.Comps[0]);
    if assigned(FFunc) then FFunc.Transform(LX, LC)
    else
    begin
      for LI := 1 to FunctionMaxInputs - 1 do
        LC[LI] := 0;
    end;
    
    for LI := 0 to FAlt.GetNoOfComps - 1 do
      LColor.Comps[LI] := DblToCol(LC[LI]);

    FAlt.GetCMYK(LColor, CMYKColor);
  end;
end;

procedure TgtPDSeparationColorSpace.GetDefaultColor(var Color: TgtColor);
begin
  if ( not Assigned(FFunc) and (
    ((FName = PDF_BLACK) or (FName = PDF_CYAN) or (FName = PDF_MAGENTA) or (FName = PDF_YELLOW))
    and (FAlt.GetMode =  csDeviceCMYK))) then
    FAlt.GetDefaultColor(Color)
  else
    Color.Comps[0] := $10000;
end;

function TgtPDSeparationColorSpace.GetFunction: TgtPDFunction;
begin
  Result := FFunc;
end;

procedure TgtPDSeparationColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
var
  LC: TgtDoubleArray;
  LX: TgtDoubleArray;
  LColor: TgtColor;
  LI: Integer;
begin
  if Assigned(FAlt) then
  begin
    LX[0] := ColToDbl(Color.Comps[0]);
    if assigned(FFunc) then FFunc.Transform(LX, LC)
    else
    begin
      for LI := 1 to FunctionMaxInputs - 1 do
        LC[LI] := 0;
    end;

    for LI := 0 to FAlt.GetNoOfComps - 1 do
      LColor.Comps[LI] := DblToCol(LC[LI]);

    FAlt.GetGray(LColor, GrayColor);
  end;
end;

function TgtPDSeparationColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csSeparation;
end;

function TgtPDSeparationColorSpace.GetColorantName: AnsiString;
begin
  Result := FName;
end;

function TgtPDSeparationColorSpace.GetNoOfComps: Integer;
begin
  Result := 1;
end;

procedure TgtPDSeparationColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
var
  LC: TgtDoubleArray;
  LX: TgtDoubleArray;
  LColor: TgtColor;
  LI: Integer;
begin
  if not Assigned(FFunc) then
  begin
    FAlt.GetDefaultColor(LColor);
    if FName = PDF_BLACK then
      LColor.Comps[3] := Color.Comps[0];
    FAlt.GetRGB(LColor, RGBColor);
  end
  else if Assigned(FAlt) then
  begin

//  {uncomment it after implimenting functions}
    LX[0] := ColToDbl(Color.Comps[0]);
    if Assigned(FFunc) then FFunc.Transform(LX, LC)
    else
    begin
      for LI := 0 to FunctionMaxInputs - 1 do
        LC[LI] := 0;
    end;

    for LI := 0 to FAlt.GetNoOfComps - 1 do
      LColor.Comps[LI] := DblToCol(LC[LI]);
//
    FAlt.GetRGB(LColor, RGBColor);
//    FAlt.GetRGB(Color, RGBColor);
  end
  else
  begin
    RGBColor.R := 0;
    RGBColor.G := 0;
    RGBColor.B := 0;
  end;

end;

function TgtPDSeparationColorSpace.IsNonMarking: Boolean;
begin
  Result := FIsNonMarking;
end;

procedure TgtPDSeparationColorSpace.Update;
begin
  inherited;

end;

end.
