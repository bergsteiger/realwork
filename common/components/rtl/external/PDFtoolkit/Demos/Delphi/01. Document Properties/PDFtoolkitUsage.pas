unit PDFtoolkitUsage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, gtPDFUtils, gtCrypt;

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
{********* Content Properties *********}
procedure SetViewerPreference(APDFDoc:TgtPDFDocument; AHideToolbar,AHideMenubar,
  AHideWindowUI,AFitWindow,ACenterWindow,ADisplayDocTitle: Boolean);
procedure SetDocInfo(APDFDoc:TgtPDFDocument; AAuthor, ACreator, ACreationDate,
  AModDate, ATitle, AKeywords, ASubject: string);
procedure SetPageLayout(APDFDoc:TgtPDFDocument; APageLayout: Integer);
procedure SetPagemode(APDFDoc:TgtPDFDocument; APagemodet: Integer);
procedure SetPageRotation(APDFDoc:TgtPDFDocument; AAngle: Integer; APageRange: string);
function GetPDFPagesize(APDFDoc:TgtPDFDocument; APageNo, AMeasurement: Integer):TgtPageSize;
function GetPDFPageMediabox(APDFDoc:TgtPDFDocument; APageNo: Integer):TgtRect;
function GetPDFPageCropBox(APDFDoc:TgtPDFDocument; APageNo: Integer):TgtRect;
function GetPageXMLMetadata(APDFDoc:TgtPDFDocument):string;
function GetPageCount(APDFDoc:TgtPDFDocument):Integer;
function GetPDFVersion(APDFDoc:TgtPDFDocument):string;
procedure SetPDFPageTransitionEffect(APDFDoc:TgtPDFDocument; APageRange: string;
  ADur:Integer; ATransEffect: TgtTransitionEffect);
procedure AddCustomPDFInfo(APDFDoc:TgtPDFDocument; AName, AValue: string; ASchema: Integer);
procedure SetPageMedia(APDFDoc: TgtPDFDocument; ARect:TgtRect; APageno: string);
procedure SetPageCrop(APDFDoc: TgtPDFDocument; ARect:TgtRect; APageno: string);
function GetPageRotation(APDFDoc:TgtPDFDocument;APageNo: Integer):Integer;
//const

implementation

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.MeasurementUnit := TgtMeasurementUnit(AMUnit);
  end;
end;

procedure SetViewerPreference(APDFDoc:TgtPDFDocument; AHideToolbar,AHideMenubar,
  AHideWindowUI,AFitWindow,ACenterWindow,ADisplayDocTitle: Boolean);
begin
  if APDFDoc.IsLoaded then
  begin
    with APDFDoc.ViewerPreferences do
    begin
      HideToolbar := AHideToolbar;
      HideMenubar := AHideMenubar;
      HideWindowUI := AHideWindowUI;
      FitWindow := AFitWindow;
      CenterWindow := ACenterWindow;
      DisplayDocTitle := ADisplayDocTitle;
    end;
  end;
end;

procedure SetDocInfo(APDFDoc:TgtPDFDocument; AAuthor, ACreator, ACreationDate,
  AModDate, ATitle, AKeywords, ASubject: string);
begin
  if APDFDoc.IsLoaded then
  begin
    with APDFDoc.DocInfo do
    begin
       Author := AAuthor;
       Creator := ACreator;
       CreationDate := ACreationDate;
       ModDate := AModDate;
       Title := ATitle;
       Keywords := AKeywords;
       Subject := ASubject;
    end;
  end;
end;

procedure SetPageLayout(APDFDoc:TgtPDFDocument; APageLayout: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.PageLayout := TgtPageLayout(APageLayout);
  end;
end;

procedure SetPagemode(APDFDoc:TgtPDFDocument; APagemodet: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
  APDFDoc.PageMode:= TgtPageMode(APagemodet);
  end;
end;

procedure SetPageRotation(APDFDoc:TgtPDFDocument; AAngle: Integer; APageRange: string);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.RotatePages(APageRange,TgtRotationAngle(AAngle));
  end;
end;

function GetPDFPagesize(APDFDoc:TgtPDFDocument; APageNo, AMeasurement: Integer):TgtPageSize;
begin
  if APDFDoc.IsLoaded then
  begin
    Result := APDFDoc.GetPageSize(APageNo, TgtMeasurementUnit(AMeasurement));
  end;
end;

function GetPDFPageMediabox(APDFDoc:TgtPDFDocument; APageNo: Integer):TgtRect;
begin
  if APDFDoc.IsLoaded then
  begin
    Result := APDFDoc.GetPageMediaBox(APageNo);
  end;
end;

function GetPDFPageCropBox(APDFDoc:TgtPDFDocument; APageNo: Integer):TgtRect;
begin
  if APDFDoc.IsLoaded then
  begin
    Result := APDFDoc.GetPageCropBox(APageNo,muPixels);
  end;
end;

function GetPageXMLMetadata(APDFDoc:TgtPDFDocument):string;
begin
  if APDFDoc.IsLoaded then
  begin
    Result := APDFDoc.GetXMLMetadata;
  end;
end;

function GetPageCount(APDFDoc:TgtPDFDocument):Integer;
begin
  Result := 0;
  if APDFDoc.IsLoaded then
  begin
    Result := APDFDoc.PageCount;
  end;
end;

function GetPDFVersion(APDFDoc:TgtPDFDocument):string;
begin
  if APDFDoc.IsLoaded then
  begin
    case APDFDoc.PDFVersion of
      pvPDF10: Result := '1.0';
      pvPDF11: Result := '1.1';
      pvPDF12: Result := '1.2';
      pvPDF13: Result := '1.3';
      pvPDF14: Result := '1.4';
      pvPDF15: Result := '1.5';
      pvPDF16: Result := '1.6';
      pvPDF17: Result := '1.7';
    end;
  end;
end;

procedure SetPDFPageTransitionEffect(APDFDoc:TgtPDFDocument; APageRange: string;
  ADur:Integer; ATransEffect: TgtTransitionEffect);
begin
  if APDFDoc.IsLoaded then
  begin
   APDFDoc.SetPageTransitionEffect(APageRange,ADur,ATransEffect);
  end;
end;

procedure AddCustomPDFInfo(APDFDoc:TgtPDFDocument; AName, AValue: string; ASchema: Integer);
var
  LCstInfo: TgtCustomPDFInfo;
begin
  if APDFDoc.IsLoaded then
  begin
    LCstInfo := TgtCustomPDFInfo.Create;
    LCstInfo.Name := AName;
    LCstInfo.Value := AValue;
    LCstInfo.Schema := TgtCustomInfoSchema(ASchema);
    APDFDoc.AddCustomPDFInfo(LCstInfo);
  end;
end;

procedure SetPageMedia(APDFDoc: TgtPDFDocument; ARect:TgtRect; APageno: string);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.SetPageMediaBox(APageno,ARect);
  end;
end;

procedure SetPageCrop(APDFDoc: TgtPDFDocument; ARect:TgtRect; APageno: string);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.SetPageCropBox(APageno,ARect);
  end;
end;

function GetPageRotation(APDFDoc:TgtPDFDocument;APageNo: Integer):Integer;
begin
  Result := 0;
  if APDFDoc.IsLoaded then
  begin
    Result := APDFDoc.GetPageRotate(APageNo);
  end;
end;


end.


