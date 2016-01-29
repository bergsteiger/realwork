{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDPatternColorSpace;

interface

uses
  PDColorSpace, gtObject, PDElement, PDBaseObject, PDTypes;

type
  TgtPDPatternColorSpace = class(TgtPDColorSpace)
  private
    FUnder: TgtPDColorSpace;
  public
    constructor Create(ABaseObject: TgtPDBaseObject); overload;
//    constructor Create(ABaseObject: TgtPDBaseObject); overload;

    function GetMode: TgtColorSpaceMode; override;
    function GetNoOfComps: Integer; override;
     // Pattern-specific access.
    function GetUnder: TgtPDColorSpace;

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
  PDArray;

{ TgtPDPatternColorSpace }

function TgtPDPatternColorSpace.Copy: TgtPDColorSpace;
begin
  Result := TgtPDPatternColorSpace.Create(FBaseObject);
end;

constructor TgtPDPatternColorSpace.Create(ABaseObject: TgtPDBaseObject);
var
  LObj: TgtPDBaseObject;
begin
  FBaseObject := ABaseObject;

  if Assigned(FBaseObject) then
  begin
    if (TgtPDArray(FBaseObject).GetLength <> 1) then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Bad Pattern color space');
      {$ENDIF}
      Exit;
    end;

    FUnder := nil;
    if TgtPDArray(FBaseObject).GetLength = 2 then
    begin
      LObj := TgtPDArray(FBaseObject).Get(1);
      FUnder := TgtPDColorSpace.MakeColorSpace(LObj);
      if not Assigned(FUnder) then
      begin
      {$IFDEF DEBUG}
        Logger.LogError('Bad Pattern color space (underlying color space)');
      {$ENDIF}
        Exit;
      end;
    end;
  end;
end;

procedure TgtPDPatternColorSpace.GetCMYK(Color: TgtColor;
  var CMYKColor: TgtCMYK);
begin
  CMYKColor.C := 0;
  CMYKColor.M := 0;
  CMYKColor.Y := 0;
  CMYKColor.K := 1;
end;

procedure TgtPDPatternColorSpace.GetDefaultColor(var Color: TgtColor);
begin
  inherited;

end;

procedure TgtPDPatternColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
begin
  GrayColor := 0;
end;

function TgtPDPatternColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csPattern;
end;

function TgtPDPatternColorSpace.GetNoOfComps: Integer;
begin
  Result := 0;
end;

procedure TgtPDPatternColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
begin
  RGBColor.R := 0;
  RGBColor.G := 0;
  RGBColor.B := 0;
end;

function TgtPDPatternColorSpace.GetUnder: TgtPDColorSpace;
begin
  Result := FUnder;
end;

procedure TgtPDPatternColorSpace.Update;
begin
  inherited;

end;

end.
