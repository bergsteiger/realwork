{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Json;

/// <summary>
/// REST.Json implements a TJson class that offers several convenience methods:
/// - converting Objects to Json and vice versa
/// - formating Json
/// </summary>

interface

uses
  System.JSON,
  REST.JsonReflect;

type
  TJsonOption = (joIgnoreEmptyStrings, joIgnoreEmptyArrays, joDateIsUTC, joDateFormatUnix, joDateFormatISO8601, joDateFormatMongo, joDateFormatParse);
  TJsonOptions = set of TJsonOption;

  TJson = class(TObject)
  private
    class procedure ProcessOptions(AJsonObject: TJSOnObject; AOptions: TJsonOptions); static;
  public
    /// <summary>
    /// Converts any TObject descendant into its Json representation.
    /// </summary>
    class function ObjectToJsonObject(AObject: TObject; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601]): TJSOnObject;
    /// <summary>
    ///   Converts any TObject decendant into its Json string representation. The resulting string has proper Json
    ///   encoding applied.
    /// </summary>
    class function ObjectToJsonString(AObject: TObject; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601]): string;
    class function JsonToObject<T: class, constructor>(AJsonObject: TJSOnObject; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601]): T; overload;
    class function JsonToObject<T: class, constructor>(AJson: string; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601]): T; overload;
    class procedure JsonToObject(AObject:TObject; AJsonObject: TJSOnObject; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601]); overload;
    class function Format(AJsonValue: TJsonValue): string;

    /// <summary>
    ///   Encodes the string representation of a TJSONValue descendant so that line breaks, tabulators etc are escaped
    ///   using backslashes.
    /// </summary>
    /// <example>
    ///   {"name":"something\else"} will be encoded as {"name":"something\\else"}
    /// </example>
    class function JsonEncode(AJsonValue: TJsonValue): string; overload;
    class function JsonEncode(AJsonString: String): string; overload;
  end;



implementation

uses
  System.DateUtils, System.SysUtils, System.Rtti, System.Character, System.JSONConsts,
  REST.Json.Types;


class function TJson.Format(AJsonValue: TJsonValue): string;
var
  s: string;
  c: char;
  EOL: string;
  INDENT: string;
  LIndent: string;
  isEOL: boolean;
  isInString: boolean;
  isEscape: boolean;
begin
  EOL := #13#10;
  INDENT := '  ';
  isEOL := true;
  isInString := false;
  isEscape := false;
  s := AJsonValue.ToString; //This will basically display all strings as Delphi strings. Technically we should show "Json encoded" strings here.
  for c in s do
  begin
    if not isInString and ((c = '{') or (c = '[')) then
    begin
      if not isEOL then
        Result := Result + EOL;
      Result := Result + LIndent + c + EOL;
      LIndent := LIndent + INDENT;
      Result := Result + LIndent;
      isEOL := true;
    end
    else if not isInString and (c = ',') then
    begin
      isEOL := false;
      Result := Result + c + EOL + LIndent;
    end
    else if not isInString and ((c = '}') or (c = ']')) then
    begin
      Delete(LIndent, 1, Length(INDENT));
      if not isEOL then
        Result := Result + EOL;
      Result := Result + LIndent + c + EOL;
      isEOL := true;
    end
    else
    begin
      isEOL := false;
      Result := Result + c;
    end;
    isEscape := (c = '\') and not isEscape;
    if not isEscape and (c = '"') then
      isInString := not isInString;
  end;
end;

class function TJson.JsonToObject<T>(AJson: string; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601]): T;
var
  LJSONValue: TJsonValue;
  LJSONObject: TJSOnObject;
begin
  LJSONValue := TJSOnObject.ParseJSONValue(AJson);
  try
    if assigned(LJSONValue) and (LJSONValue is TJSOnObject) then
      LJSONObject := LJSONValue as TJSOnObject
    else
      raise EConversionError.Create(SCannotCreateObject);
    Result := JsonToObject<T>(LJSONObject, AOptions);
  finally
    FreeAndNil(LJSONObject);
  end;
end;

class function TJson.JsonEncode(AJsonValue: TJsonValue): string;
var
  LBytes: TBytes;
begin
  SetLength(LBytes,AJsonValue.ToString.Length*6); //Length can not be predicted. Worst case: every single char gets escaped
  SetLength(LBytes, AJsonValue.ToBytes(LBytes, 0)); //adjust Array to actual length
  Result := TEncoding.UTF8.GetString(LBytes);
end;


class function TJson.JsonEncode(AJsonString: string): string;
var
  LJsonValue: TJSONValue;
begin
  LJsonValue := TJsonObject.ParseJSONValue(AJsonString);
  try
    Result := JsonEncode(LJsonValue);
  finally
    LJsonValue.Free;
  end;
end;


class procedure TJson.JsonToObject(AObject:TObject; AJsonObject: TJSOnObject; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601]);
var
  LUnMarshaler: TJSONUnMarshal;
begin
  LUnMarshaler := TJSONUnMarshal.Create;
  try
    LUnMarshaler.DateTimeIsUTC  := joDateIsUTC in AOptions;
    if joDateFormatUnix in AOptions then
      LUnMarshaler.DateFormat :=jdfUnix
    else if joDateFormatISO8601 in AOptions then
     LUnMarshaler.DateFormat := jdfISO8601
    else if joDateFormatMongo in AOptions then
      LUnMarshaler.DateFormat := jdfMongo
    else if joDateFormatParse in AOptions then
      LUnMarshaler.DateFormat := jdfParse;

    ProcessOptions(AJsonObject, AOptions);

    LUnMarshaler.CreateObject(AObject.ClassType, AJsonObject, AObject);
  finally
    FreeAndNil(LUnMarshaler);
  end;
end;

class function TJson.JsonToObject<T>(AJsonObject: TJSOnObject; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601]): T;
var
  LUnMarshaler: TJSONUnMarshal;
begin
  LUnMarshaler := TJSONUnMarshal.Create;
  try
    LUnMarshaler.DateTimeIsUTC  := joDateIsUTC in AOptions;
    if joDateFormatUnix in AOptions then
      LUnMarshaler.DateFormat :=jdfUnix
    else if joDateFormatISO8601 in AOptions then
      LUnMarshaler.DateFormat := jdfISO8601
    else if joDateFormatMongo in AOptions then
      LUnMarshaler.DateFormat := jdfMongo
    else if joDateFormatParse in AOptions then
      LUnMarshaler.DateFormat := jdfParse;

    ProcessOptions(AJSONObject, AOptions);

    Result := LUnMarshaler.CreateObject(T, AJsonObject) as T;
  finally
    FreeAndNil(LUnMarshaler);
  end;
end;

class function TJson.ObjectToJsonObject(AObject: TObject; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601]): TJSOnObject;
var
  LMarshaler: TJSONMarshal;
  LJSONObject: TJSOnObject;
begin
  LMarshaler := TJSONMarshal.Create(TJSONConverter.Create);
  try
    LMarshaler.DateTimeIsUTC  := joDateIsUTC in AOptions;
    if joDateFormatUnix in AOptions then
      LMarshaler.DateFormat :=jdfUnix
    else if joDateFormatISO8601 in AOptions then
      LMarshaler.DateFormat := jdfISO8601
    else if joDateFormatMongo in AOptions then
      LMarshaler.DateFormat := jdfMongo
    else if joDateFormatParse in AOptions then
      LMarshaler.DateFormat := jdfParse;


    LJSONObject := LMarshaler.Marshal(AObject) as TJSOnObject;
    ProcessOptions(LJSONObject, AOptions);

    Result := LJSONObject;
  finally
    FreeAndNil(LMarshaler);
  end;
end;

class function TJson.ObjectToJsonString(AObject: TObject; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601]): string;
var
  LJSONObject: TJSOnObject;
begin
  LJSONObject := ObjectToJsonObject(AObject, AOptions);
  try
    Result := TJson.JsonEncode(LJSONObject);
  finally
    FreeAndNil(LJSONObject);
  end;
end;

class procedure TJson.ProcessOptions(AJsonObject: TJSOnObject; AOptions: TJsonOptions);
var
  LPair: TJSONPair;
  LItem: TObject;
  i: Integer;

  function IsEmpty(ASet: TJsonOptions):boolean;
  var
    LElement: TJsonOption;
  begin
    Result := true;
    for LElement in ASet do
    begin
      Result := false;
      break;
    end;
  end;

begin
  if assigned(AJsonObject) and not isEmpty(AOptions) then

   for i := AJsonObject.Count -1 downto 0  do
    begin
      LPair := TJSONPair(AJsonObject.Pairs[i]);
      if LPair.JsonValue is TJSOnObject then
        TJson.ProcessOptions(TJSOnObject(LPair.JsonValue), AOptions)
      else if LPair.JsonValue is TJSONArray then
      begin
        if (joIgnoreEmptyArrays in AOptions) and (TJSONArray(LPair.JsonValue).Count = 0) then
        begin
          AJsonObject.RemovePair(LPair.JsonString.Value).DisposeOf;
        end
        else
          for LItem in TJSONArray(LPair.JsonValue) do
          begin
            if LItem is TJSOnObject then
              TJson.ProcessOptions(TJSOnObject(LItem), AOptions)
          end;
      end
      else
      begin
        if (joIgnoreEmptyStrings in AOptions) and (LPair.JsonValue.value = '') then
        begin
          AJsonObject.RemovePair(LPair.JsonString.Value).DisposeOf;
        end;
      end;
    end;
end;

end.
