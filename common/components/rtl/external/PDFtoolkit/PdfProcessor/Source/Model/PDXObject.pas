{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDXObject;

interface

uses
  PDElement, gtObject, PDBaseObject, gtMethods;

type
  TgtXObjectType = (xtImage, xtForm, xtPostScript);

  TgtPDXObject = class(TgtPDElement)
  private
    FSubType: TgtXObjectType;
    FTagName: AnsiString;

    procedure SetSubType(const Value: TgtXObjectType);
  public
    class function MakeXObject(AParentDoc: TgtObject;
      AResourceElement: TgtPDElement; AXObjectDict: TgtPDBaseObject;
      ATagName: AnsiString): TgtPDXObject; overload;

    destructor Destroy; override;

    function IsName(const TagName: AnsiString): Boolean;
    function IsImage: Boolean; virtual;
    function IsForm: Boolean; virtual;
    function IsPostScript: Boolean; virtual;
    procedure Update; override;

    property SubType: TgtXObjectType read FSubType write SetSubType;
    property TagName: AnsiString read FTagName;
  end;

  TgtPDEnumXObjectEvent = procedure(Font: TgtPDXObject; var Name: AnsiString;
    var Cancel: Boolean) of object;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  PDDictionary, gtConstants, PDName, PDImage, PDForm, PDPostScript,
  PDStream, PDAppearanceStream;

{ TgtPDXObject }

destructor TgtPDXObject.Destroy;
begin

  inherited;
end;

function TgtPDXObject.IsForm: Boolean;
begin
  Result := False;
end;

function TgtPDXObject.IsImage: Boolean;
begin
  Result := False;
end;

function TgtPDXObject.IsName(const TagName: AnsiString): Boolean;
begin
  Result := (FTagName = TagName);
end;

function TgtPDXObject.IsPostScript: Boolean;
begin
  Result := False;
end;

class function TgtPDXObject.MakeXObject(AParentDoc: TgtObject;
  AResourceElement: TgtPDElement; AXObjectDict: TgtPDBaseObject;
  ATagName: AnsiString): TgtPDXObject;
var
  LObj: TgtPDBaseObject;
begin
  Result := nil;
//  if not (AXObjectDict.IsStream and
//    TgtPDStream(AXObjectDict).Isof(PDF_XOBJECT)) then
//  begin
//    if not AXObjectDict.IsDict(PDF_XObject) then
//    begin
//      Result := nil;
//      Logger.LogError('Invalid XObject');
//      Exit;
//    end;
//  end;

  if AXObjectDict.IsStream then
    LObj := TgtPDDictionary(TgtPDStream(AXObjectDict).GetDict).
      LookUp(PDF_SUBTYPE)
  else
    LObj := TgtPDDictionary(AXObjectDict).LookUp(PDF_SUBTYPE);

  //if subtype entry not found in Form XObject, when parentelt is Appearancestream
  if ((not Assigned(LObj)) and (AResourceElement is TgtPDAppearanceStream)) then
  begin
    Result := TgtPDForm.Create(AParentDoc, AResourceElement, AXObjectDict);
    Result.SubType := xtForm;
    Exit;
  end;

  if not Assigned(LObj) then
  begin
    Result := nil;
    {$IFDEF DEBUG}
    Logger.LogError('Cannot find Subtype entry in %s XObject', [ATagName]);
    {$ENDIF}
    Exit;
  end;

  if not LObj.IsName then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Subtype entry in %s XObject is not a Name object',
      [ATagName]);
    {$ENDIF}
    Exit;
  end;

  if LObj.IsName(PDF_IMAGE) then
  begin
    Result := TgtPDImage.Create(AParentDoc, AResourceElement, AXObjectDict);
    Result.SubType := xtImage;
  end
  else if LObj.IsName(PDF_FORM) then
  begin
    Result := TgtPDForm.Create(AParentDoc, AResourceElement, AXObjectDict);
    Result.SubType := xtForm;
  end
  else if LObj.IsName(PDF_PS) then
  begin
    Result := TgtPDPostScript.Create(AParentDoc, AResourceElement, AXObjectDict);
    Result.SubType := xtPostScript;
  end
  else
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Invalid subtype entry in %s XObject', [ATagName]);
    {$ENDIF}
    Exit;
  end;

  Result.FTagName := ATagName;
end;

procedure TgtPDXObject.SetSubType(const Value: TgtXObjectType);
begin
  FSubType := Value;
end;

procedure TgtPDXObject.Update;
begin
  inherited;
  if FParentElement.BaseObject.IsChanged = True then
  begin

  end;
end;

end.
