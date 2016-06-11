{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Json.Interceptors;

interface

uses
  System.Json, REST.JsonReflect;

type
  TISODateTimeInterceptor = class(TJSONInterceptor)
  private
    FDateTimeIsUTC: Boolean;
  public
    constructor Create(ADateTimeIsUTC: Boolean); reintroduce;
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
    property DateTimeIsUTC: Boolean read FDateTimeIsUTC write FDateTimeIsUTC;
  end;

  TArrayInterceptor = class(TJSONInterceptor)
  public
    function ObjectsConverter(Data: TObject; Field: string): TListOfObjects; override;
    procedure ObjectsReverter(Data: TObject; Field: string; Arg: TListOfObjects); override;
  end;

  TBytesInterceptor = class(TJSONInterceptor)
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
  end;

  TUnixDateTimeInterceptor = class(TJSONInterceptor)
  private
    FDateTimeIsUTC: Boolean;
  public
    constructor Create(ADateTimeIsUTC: Boolean); reintroduce;
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
    property DateTimeIsUTC: Boolean read FDateTimeIsUTC write FDateTimeIsUTC;
  end;

  TMongoDateTimeInterceptor = class(TJSONInterceptor)
  private
    FDateTimeIsUTC: Boolean;
  public
    constructor Create(ADateTimeIsUTC: Boolean); reintroduce;
    function ObjectConverter(Data: TObject; Field: string): TObject; override;
    procedure ObjectReverter(Data: TObject; Field: string; Arg: TObject); override;
    property DateTimeIsUTC: Boolean read FDateTimeIsUTC write FDateTimeIsUTC;
  end;


  /// <summary>Parse DateTime Intercepter for conversions between TObject and TDateTime</summary>
  TParseDateTimeInterceptor = class(TJSONInterceptor)
  private
    FDateTimeIsUTC: Boolean;
  public
    constructor Create(ADateTimeIsUTC: Boolean); reintroduce;
    function ObjectConverter(Data: TObject; Field: string): TObject; override;
    procedure ObjectReverter(Data: TObject; Field: string; Arg: TObject); override;
    property DateTimeIsUTC: Boolean read FDateTimeIsUTC write FDateTimeIsUTC;
  end;

implementation

uses
  System.Rtti, System.SysUtils, System.DateUtils, System.NetEncoding, REST.Json.Types;

var
  ArrayConverter: TObjectsConverter;
  ArrayReverter: TObjectsReverter;

  BytesConverter: TStringConverter;
  BytesReverter: TStringReverter;

  { TISODateTimeInterceptor }

constructor TISODateTimeInterceptor.Create(ADateTimeIsUTC: Boolean);
begin
  ConverterType := ctString;
  ReverterType := rtString;
  FDateTimeIsUTC := true;
end;

function TISODateTimeInterceptor.StringConverter(Data: TObject; Field: string): string;
var
  ctx: TRTTIContext;
  date: TDateTime;
begin
  date := ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
  result := DateToISO8601(date, DateTimeIsUTC);
end;

procedure TISODateTimeInterceptor.StringReverter(Data: TObject; Field: string; Arg: string);
var
  ctx: TRTTIContext;
  datetime: TDateTime;
begin
  datetime := ISO8601ToDate(Arg, DateTimeIsUTC);
  ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, datetime);
end;

{ TArrayInterceptor }

function TArrayInterceptor.ObjectsConverter(Data: TObject; Field: string): TListOfObjects;
begin
  result := ArrayConverter(Data, Field);
end;

procedure TArrayInterceptor.ObjectsReverter(Data: TObject; Field: string; Arg: TListOfObjects);
begin
  ArrayReverter(Data, Field, Arg);
end;

{ TBytesInterceptor }

function TBytesInterceptor.StringConverter(Data: TObject; Field: string): string;
begin
  result := BytesConverter(Data, Field);
end;

procedure TBytesInterceptor.StringReverter(Data: TObject; Field: string; Arg: string);
begin
  inherited;
  BytesReverter(Data, Field, Arg);
end;

procedure InitializeConverters(ADateTimeIsUTC: Boolean);
begin
  ArrayConverter := function(Data: TObject; Field: string): TListOfObjects
    // var
    // date: TDateTime;
    begin
      // date := ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
      // result := FormatDateTime('yyyy-mm-dd hh:nn:ss', date);
    end;

  ArrayReverter := procedure(Data: TObject; Field: string; Arg: TListOfObjects)
    var
      ctx: TRTTIContext;
      datetime: TDateTime;
    begin
      datetime := 0;
      ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, datetime);
    end;

  BytesConverter := function(Data: TObject; Field: string): string
    // var
    // ctx: TRTTIContext;
    begin
      // date := ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
      // result := FormatDateTime('yyyy-mm-dd hh:nn:ss', date);
    end;

  BytesReverter := procedure(Data: TObject; Field: string; Arg: string)
    var
      ctx: TRTTIContext;
      LBytes: TBytes;
      LValue: TValue;

      LByteValues: TArray<TValue>;
      i: Integer;
      LArrayType: TRttiType;
    begin
      ctx := TRTTIContext.Create;
                                   
      LBytes := TNetEncoding.Base64.DecodeStringToBytes(Arg);

      SetLength(LByteValues, Length(LBytes));
      for i := 0 to Length(LBytes) - 1 do
      begin
        LByteValues[i] := LBytes[i];
      end;

      LArrayType := ctx.GetType(Data.ClassType).GetField(Field).FieldType;

      LValue := TValue.FromArray(LArrayType.Handle, LByteValues);

      ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, LValue);

    end;
end;

{ TUnixDateTimeInterceptor }

constructor TUnixDateTimeInterceptor.Create(ADateTimeIsUTC: Boolean);
begin
  ConverterType := ctString;
  ReverterType := rtString;
  FDateTimeIsUTC := true;
end;

function TUnixDateTimeInterceptor.StringConverter(Data: TObject; Field: string): string;
var
  ctx: TRTTIContext;
  date: TDateTime;
begin
  date := ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
  result := IntToStr(DateTimeToUnix(date, DateTimeIsUTC));
end;

procedure TUnixDateTimeInterceptor.StringReverter(Data: TObject; Field: string; Arg: string);

var
  ctx: TRTTIContext;
  datetime: TDateTime;
begin
  datetime := UnixToDateTime(StrToIntDef(Arg, 0), DateTimeIsUTC);
  ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, datetime);
end;

{ TMongoDateTimeInterceptor }

constructor TMongoDateTimeInterceptor.Create(ADateTimeIsUTC: Boolean);
begin
  ConverterType := ctObject;
  ReverterType := rtObject;
  FDateTimeIsUTC := ADateTimeIsUTC;
  ObjectType := TMongoDate;
end;

function TMongoDateTimeInterceptor.ObjectConverter(Data: TObject; Field: string): TObject;
var
  ctx: TRTTIContext;
  date: TDateTime;
begin
  // http://docs.mongodb.org/manual/reference/mongodb-extended-json/
  // Strict mode: {"$date" : 1382128582}
  date := ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
  result := TMongoDate.Create(DateTimeToUnix(date, DateTimeIsUTC));  // '{"$date" : ' + IntToStr(DateToUnix(date, DateTimeIsUTC)) + '}';
end;

      /// <summary>Reverter that sets an object field to a value based on
    /// an intermediate object</summary>
    /// <param name="Data">Current object instance being populated</param>
    /// <param name="Field">Field name</param>
    /// <param name="Arg"> intermediate object </param>

procedure TMongoDateTimeInterceptor.ObjectReverter(Data: TObject; Field: string; Arg: TObject);
var
  ctx: TRTTIContext;
  LDatetime: TDateTime;
begin
 if assigned(Arg) then begin
    LDatetime := (Arg as TMongoDate).GetDatetime(DateTimeIsUTC);
    ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, LDatetime);
  end;
end;

{ TParseDateTimeInterceptor }

constructor TParseDateTimeInterceptor.Create(ADateTimeIsUTC: Boolean);
begin
  ConverterType := ctObject;
  ReverterType := rtObject;
  FDateTimeIsUTC := ADateTimeIsUTC;
  ObjectType := TParseDate;
end;

function TParseDateTimeInterceptor.ObjectConverter(Data: TObject; Field: string): TObject;
var
  ctx: TRTTIContext;
  date: TDateTime;
begin
  date := ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
  result := TParseDate.Create(date, DateTimeIsUTC);
end;

procedure TParseDateTimeInterceptor.ObjectReverter(Data: TObject; Field: string; Arg: TObject);
var
  ctx: TRTTIContext;
  LDatetime: TDateTime;
begin
 if assigned(Arg) then begin
    LDatetime := (Arg as TParseDate).GetDatetime(DateTimeIsUTC);
    ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, LDatetime);
  end;
end;

initialization

finalization

end.
