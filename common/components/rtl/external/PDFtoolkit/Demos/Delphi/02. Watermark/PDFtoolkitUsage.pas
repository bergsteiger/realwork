unit PDFtoolkitUsage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, gtPDFUtils, PDTypes, gtCrypt;


procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
{********* Watermark *********}
procedure InsertTextWatermark(APDFDoc: TgtPDFDocument; AText, APageno: string; AFont: TFont;
  AStrokeColor: TColor; AOverlay: Boolean; AX, AY: Extended; AHPos, AVPos, AWritingmode, AOpacity, AAngle: Integer);
procedure InsertRectangleWatermark(APDFDoc: TgtPDFDocument; AInitialPoint, AEndPoint: TgtPoint;
  ApenWidth, AOpacityFill, AOpacityStroke: Integer; AStorkeColor, AFillColor: TColor; APageno: string);
procedure InsertImageWatermark(APDFDoc: TgtPDFDocument; Aimage: TGraphic; Ax, Ay, AWidth, AHeight: Extended;
  AOverlay: Boolean; AOpacity, AHPos, AVPos, AAngle: Integer; APageno: string);
procedure InsertCircleWatermark(APDFDoc: TgtPDFDocument; ACenterPoint: TgtPoint; ARadius: Extended;
  AFillColor, AStrokeColor: TColor; Apen, AOpacity: Integer; APageno: string);
procedure InsertPolygonWatermark(APDFDoc: TgtPDFDocument; ACenterpoint: TgtPoint; ANumofsides, Asidelength,
  APen: Integer; AStrokeColor, AFillColor: TColor; APageno: string);
procedure InsertCurveWatermark(APDFDoc: TgtPDFDocument; AInitialPoint, AFirstCntrlPoint, ASecondCntrlPoint,
  AendPoint: TgtPoint; AStrokeColor: TColor; APen: Integer; APageno: string);
procedure InsertLineWatermark(APDFDoc: TgtPDFDocument; AInitialPoint, AEndPoint: TgtPoint;
  AStrokeColor: TColor; APen, AOpacityStroke: Integer; APageno: string);
procedure InsertEllipseWatermark(APDFDoc: TgtPDFDocument; ACenterPoint: TgtPoint; AMajorRadius, AMinorRadius:
  extended; APen: Integer; AStrokeColor, AFillColor: TColor; APageno: string);



implementation

uses
  PDImage;

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.MeasurementUnit := TgtMeasurementUnit(AMUnit);
  end;
end;

procedure InsertTextWatermark(APDFDoc: TgtPDFDocument; AText, APageno: string; AFont: TFont;
  AStrokeColor: TColor; AOverlay: Boolean; AX, AY: Extended; AHPos, AVPos, AWritingmode, AOpacity, AAngle: Integer);
var
  LTxtWatermark: TgtTextWatermarkTemplate;

  function CreateTextWatermark: TgtTextWatermarkTemplate;
  begin
    Result := TgtTextWatermarkTemplate.Create;
    with Result do
    begin
      Text := AText;
      if Assigned(AFont) then
        Font := AFont;
      StrokeColor := AStrokeColor;
      Overlay := AOverlay;
      OpacityStroke := AOpacity;
      X := AX;
      Y := AY;
      RenderMode := rmFillStroke;
      WritingMode := TgtWrtMode(AWritingmode);
      HorizPos := TgtHorizontalPosition(AHPos);
      VertPos := TgtVerticalPosition(AVPos);
      Angle := AAngle;
    end;
  end;

begin
  LTxtWatermark := CreateTextWatermark;
  try
    APDFDoc.InsertWatermark(LTxtWatermark,APageno);
  finally
    LTxtWatermark.Free;
  end;
end;

procedure InsertRectangleWatermark(APDFDoc: TgtPDFDocument; AInitialPoint, AEndPoint: TgtPoint;
  ApenWidth, AOpacityFill, AOpacityStroke: Integer; AStorkeColor, AFillColor: TColor; APageno: string);
var
  LRectWatermark: TgtRectangleWatermarkTemplate;

  function CreateRectangleWatermark: TgtRectangleWatermarkTemplate;
  begin
    Result := TgtRectangleWatermarkTemplate.Create;
    with Result do
    begin
      InitialPoint.X := AInitialPoint.X;
      InitialPoint.Y := AInitialPoint.Y;
      EndPoint.X := AEndPoint.X;
      EndPoint.Y := AEndPoint.Y;
      PenWidth := ApenWidth;
      OpacityFill := AOpacityFill;
      OpacityStroke := AOpacityStroke;
      StrokeColor := AStorkeColor;
      Fillcolor := AFillColor;
    end;
  end;
begin
  LRectWatermark := CreateRectangleWatermark;
  try
    APDFDoc.InsertWatermark(LRectWatermark,APageno);
  finally
    LRectWatermark.Free;
  end;
end;

procedure InsertImageWatermark(APDFDoc: TgtPDFDocument; Aimage: TGraphic; Ax, Ay, AWidth, AHeight: Extended;
  AOverlay: Boolean; AOpacity, AHPos, AVPos, AAngle: Integer; APageno: string);
var
  LImageWatermark: TgtImageWatermarkTemplate;

  function CreateImageWatermark: TgtImageWatermarkTemplate;
  begin
    Result := TgtImageWatermarkTemplate.Create;
    with Result do
    begin
      Image := Aimage;
      X := Ax;
      Y := Ay;
      Width := AWidth;
      Height := AHeight;
      Overlay := AOverlay;
      OpacityFill := AOpacity;
      ImageFormat := ofBMP;
      HorizPos := TgtHorizontalPosition(AHPos);
      VertPos := TgtVerticalPosition(AVPos);
      Angle := AAngle;
    end;
  end;
begin
  LImageWatermark := CreateImageWatermark;
  try
    APDFDoc.InsertWatermark(LImageWatermark,APageno);
  finally
    LImageWatermark.Free;
  end;
end;

procedure InsertCircleWatermark(APDFDoc: TgtPDFDocument; ACenterPoint: TgtPoint; ARadius: Extended;
  AFillColor, AStrokeColor: TColor; Apen, AOpacity: Integer; APageno: string);
var
  LCircleWatermark: TgtCircleWaterMarkTemplate;

  function CreateCircleWatermark: TgtCircleWaterMarkTemplate;
  begin
    Result := TgtCircleWaterMarkTemplate.Create;
    with Result do
    begin
      Center.X := ACenterPoint.X;
      Center.Y := ACenterPoint.Y;
      Radius := ARadius;
      Fillcolor := AFillColor;
      StrokeColor := AStrokeColor;
      PenWidth := Apen;
      OpacityFill := AOpacity;
    end;
  end;

begin
  LCircleWatermark := CreateCircleWatermark;
  try
    APDFDoc.InsertWatermark(LCircleWatermark,APageno);
  finally
    LCircleWatermark.Free;
  end;
end;

procedure InsertPolygonWatermark(APDFDoc: TgtPDFDocument; ACenterpoint: TgtPoint; ANumofsides, Asidelength,
  APen: Integer; AStrokeColor, AFillColor: TColor; APageno: string);
var
  LPolygonWatermark: TgtPolygonWatermark;

  function CreatePolygonWatermark: TgtPolygonWatermark;
  begin
    Result := TgtPolygonWatermark.Create;
    with Result do
    begin
      Center.X := ACenterPoint.X;
      Center.Y := ACenterPoint.Y;
      NoOfSides := ANumofsides;
      Fillcolor := AFillColor;
      StrokeColor := AStrokeColor;
      PenWidth := Apen;
      SideLength := Asidelength;
    end;
  end;

begin
  LPolygonWatermark := CreatePolygonWatermark;
  try
    APDFDoc.InsertWatermark(LPolygonWatermark,APageno);
  finally
    LPolygonWatermark.Free;
  end;
end;

procedure InsertCurveWatermark(APDFDoc: TgtPDFDocument; AInitialPoint, AFirstCntrlPoint, ASecondCntrlPoint,
  AendPoint: TgtPoint; AStrokeColor: TColor; APen: Integer; APageno: string);
var
  LCurveWatermark: TgtCurveWaterMarkTemplate;

  function CreateCurveWatermark: TgtCurveWaterMarkTemplate;
  begin
    Result := TgtCurveWaterMarkTemplate.Create;
    with Result do
    begin
      InitialPoint.X := AInitialPoint.X;
      InitialPoint.Y := AInitialPoint.Y;
      FirstControlPoint.X := AFirstCntrlPoint.X;
      FirstControlPoint.Y := AFirstCntrlPoint.Y;
      SecondControlPoint.X := ASecondCntrlPoint.X;
      SecondControlPoint.Y := ASecondCntrlPoint.Y;
      EndPoint.X := AendPoint.X;
      EndPoint.Y := AendPoint.Y;
      StrokeColor := AStrokeColor;
      PenWidth := Apen;
    end;
  end;
begin
  LCurveWatermark := CreateCurveWatermark;
  try
    APDFDoc.InsertWatermark(LCurveWatermark,APageno);
  finally
    LCurveWatermark.Free;
  end;
end;

procedure InsertLineWatermark(APDFDoc: TgtPDFDocument; AInitialPoint, AEndPoint: TgtPoint;
  AStrokeColor: TColor; APen, AOpacityStroke: Integer; APageno: string);
var
  LLineWatermark: TgtLineWatermarkTemplate;

  function CreateLineWatermark: TgtLineWatermarkTemplate;
  begin
    Result := TgtLineWatermarkTemplate.Create;
    with Result do
    begin
      InitialPoint.X := AInitialPoint.X;
      InitialPoint.Y := AInitialPoint.Y;
      EndPoint.X := AendPoint.X;
      EndPoint.Y := AendPoint.Y;
      StrokeColor := AStrokeColor;
      PenWidth := Apen;
      OpacityStroke := AOpacityStroke;
    end;
  end;

begin
  LLineWatermark := CreateLineWatermark;
  try
    APDFDoc.InsertWatermark(LLineWatermark,APageno);
  finally
    LLineWatermark.Free;
  end;
end;

procedure InsertEllipseWatermark(APDFDoc: TgtPDFDocument; ACenterPoint: TgtPoint; AMajorRadius, AMinorRadius:
  extended; APen: Integer; AStrokeColor, AFillColor: TColor; APageno: string);
var
  LEllipseWatermark: TgtEllipseWaterMarkTemplate;

  function CreateEllipseWatermark: TgtEllipseWaterMarkTemplate;
  begin
    Result := TgtEllipseWaterMarkTemplate.Create;
    with Result do
    begin
      Center.X := ACenterPoint.X;
      Center.Y := ACenterPoint.Y;
      MajorRadius := AMajorRadius;
      MinorRadius := AMinorRadius;
      StrokeColor := AStrokeColor;
      Fillcolor := AFillColor;
    end;
  end;
begin
  LEllipseWatermark := CreateEllipseWatermark;
  try
    APDFDoc.InsertWatermark(LEllipseWatermark,APageno);
  finally
    LEllipseWatermark.Free;
  end;
end;



end.






