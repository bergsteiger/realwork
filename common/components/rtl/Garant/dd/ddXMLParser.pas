unit ddXMLParser;

{ $Id: ddXMLParser.pas,v 1.3 2013/04/25 10:18:09 fireton Exp $ }

interface

uses
  Classes,

  l3InterfacedStringList,
  l3Interfaces,
  l3ProtoObject,
  l3StringList,
  l3Except,

  XpBase,
  XpParser;

type
 TddXMLParserOnData = procedure(const aStr: Il3CString) of object;

 TddXMLParser = class(Tl3ProtoObject)
 private
  f_AttrList: Tl3InterfacedStringList;
  f_NeedAttributes: Boolean;
  f_OnData: TddXMLParserOnData;
  f_OnEndTag: TddXMLParserOnData;
  f_OnStartTag: TddXMLParserOnData;
  f_XpParser: TXpParser;
  f_TagList : Tl3StringList;
  procedure DoStartElement(aOwner : TObject; const aValue : DOMString);
  procedure DoEndElement(aOwner : TObject; const aValue : DOMString);
  procedure DoCharData(aOwner : TObject; const aValue : DOMString);
  procedure DoOnData(const aStr: Il3CString);
  procedure DoOnAttribute(aOwner: TObject; const aName, aValue: DOMString; aSpecified : Boolean);
  function pm_GetAttributes(anAttrName: AnsiString): Il3CString;
  function pm_GetCurrentTag: Il3CString;
  function pm_GetTags(aIndex: Integer): Il3CString;
  procedure pm_SetNeedAttributes(const Value: Boolean);
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  function IsInTag(const aString: AnsiString): Boolean;
  procedure ParseStream(const aStream: TStream);
  function TagPathIs(aPath: array of string): Boolean;
  property CurrentTag: Il3CString read pm_GetCurrentTag;
  property OnData: TddXMLParserOnData read f_OnData write f_OnData;
  property OnEndTag: TddXMLParserOnData read f_OnEndTag write f_OnEndTag;
  property OnStartTag: TddXMLParserOnData read f_OnStartTag write f_OnStartTag;
  property Attributes[anAttrName: AnsiString]: Il3CString read pm_GetAttributes;
  property NeedAttributes: Boolean read f_NeedAttributes write pm_SetNeedAttributes;
  property Tags[aIndex: Integer]: Il3CString read pm_GetTags;
 end;

 EddXMLReadError = class(El3ReadError);

implementation
uses
 SysUtils,
 
 l3Base,
 l3String;

const
 cs_StructureError = 'Нарушена структура XML'; 

constructor TddXMLParser.Create;
begin
 inherited;
 f_XpParser := TXpParser.Create(nil);
 f_XpParser.OnStartElement := DoStartElement;
 f_XpParser.OnEndElement   := DoEndElement;
 f_XpParser.OnCharData     := DoCharData;
 f_XpParser.OnAttribute    := DoOnAttribute;
 f_TagList := Tl3StringList.Make;
 f_AttrList := Tl3InterfacedStringList.MakeSorted;
end;

procedure TddXMLParser.Cleanup;
begin
 FreeAndNil(f_XpParser);
 FreeAndNil(f_TagList);
 FreeAndNil(f_AttrList);
 inherited;
end;

procedure TddXMLParser.DoCharData(aOwner : TObject; const aValue : DOMString);
begin
 DoOnData(l3CStr(aValue));
end;

procedure TddXMLParser.DoEndElement(aOwner : TObject; const aValue : DOMString);
begin
 if l3Same(CurrentTag.AsWStr, l3PCharLen(aValue)) then
 begin
  if Assigned(f_OnEndTag) then
   f_OnEndTag(CurrentTag);
  f_TagList.DeleteLast
 end
 else
  raise EddXMLReadError.Create(cs_StructureError);
end;

procedure TddXMLParser.DoOnAttribute(aOwner: TObject; const aName, aValue: DOMString; aSpecified : Boolean);
begin
 if f_NeedAttributes and aSpecified then
  f_AttrList.Add(l3CStr(aName), l3CStr(aValue));
end;

procedure TddXMLParser.DoOnData(const aStr: Il3CString);
begin
 if Assigned(f_OnData) then
  f_OnData(aStr);
end;

procedure TddXMLParser.DoStartElement(aOwner : TObject; const aValue : DOMString);
var
 l_Str : Il3CString;
begin
 l_Str := l3CStr(aValue);
 f_TagList.Add(l_Str);
 if Assigned(f_OnStartTag) then
  f_OnStartTag(l_Str);
 if f_NeedAttributes then
  f_AttrList.Clear;
end;

function TddXMLParser.IsInTag(const aString: AnsiString): Boolean;
begin
 Result := f_TagList.IndexOf(l3PCharLen(aString)) >= 0;
end;

procedure TddXMLParser.ParseStream(const aStream: TStream);
begin
 f_AttrList.Clear;
 f_XpParser.ParseStream(aStream);
end;

function TddXMLParser.pm_GetAttributes(anAttrName: AnsiString): Il3CString;
var
 l_Intf: IUnknown;
begin
 l_Intf := f_AttrList.FindInterface(l3PCharLen(anAttrName));
 if l_Intf <> nil then
  Result := Il3CString(l_Intf);
end;

function TddXMLParser.pm_GetCurrentTag: Il3CString;
begin
 Result := Tags[0];
end;

function TddXMLParser.pm_GetTags(aIndex: Integer): Il3CString;
begin
 if aIndex > f_TagList.Count - 1 then
  Result := nil
 else
  Result := f_TagList.ItemC[f_TagList.Count - 1 - aIndex];
end;

procedure TddXMLParser.pm_SetNeedAttributes(const Value: Boolean);
begin
 f_NeedAttributes := Value;
 if f_NeedAttributes then
  f_AttrList.Clear;
end;

function TddXMLParser.TagPathIs(aPath: array of string): Boolean;
var
 I: Integer;
 l_Idx: Integer;
begin
 Result := False;
 l_Idx := 0;
 for I := Low(aPath) to High(aPath) do
 begin
  if not l3Same(Tags[l_Idx], aPath[I]) then
   Exit;
  Inc(l_Idx);
 end;
 Result := True;
end;

end.
