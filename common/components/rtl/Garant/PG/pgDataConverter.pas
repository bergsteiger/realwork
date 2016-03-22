unit pgDataConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgDataConverter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgDataConverter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  l3ProtoObject,
  pgInterfaces,
  daInterfaces,
  daTypes,
  l3Date
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgDataConverter = class(Tl3ProtoObject, IpgDataConverter)
 protected
 // realized methods
   function AllocateParamBuffer(const aDescription: IdaParamDescription): Pointer;
   procedure ParamToDataBase(const aDescription: IdaParamDescription;
    ClientBufferFormat: TdaDataType;
    aClientBuffer: Pointer;
    var aServerBuffer: Pointer);
   procedure ParamFromDataBase(const aDescription: IdaParamDescription;
    ClientBufferFormat: TdaDataType;
    aServerBuffer: Pointer;
    aClientBuffer: Pointer);
   procedure FreeParamBuffer(const aDescription: IdaParamDescription;
    aBuffer: Pointer);
   function ToInteger(aData: Pointer): Integer;
   function ToLargeInt(aData: Pointer): LargeInt;
   function ToStDate(aData: Pointer): TStDate;
   function ToStTime(aData: Pointer): TStTime;
   function ToString(aData: Pointer): AnsiString;
   function ToByte(aData: Pointer): Byte;
 public
 // public methods
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
   class function Make: IpgDataConverter; reintroduce;
     {* Сигнатура фабрики TpgDataConverter.Make }
 end;//TpgDataConverter
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  l3Base,
  SysUtils
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

// start class TpgDataConverter

constructor TpgDataConverter.Create;
//#UC START# *55E42F4600AD_55E42F2D027B_var*
//#UC END# *55E42F4600AD_55E42F2D027B_var*
begin
//#UC START# *55E42F4600AD_55E42F2D027B_impl*
 inherited Create;
//#UC END# *55E42F4600AD_55E42F2D027B_impl*
end;//TpgDataConverter.Create

class function TpgDataConverter.Make: IpgDataConverter;
var
 l_Inst : TpgDataConverter;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TpgDataConverter.AllocateParamBuffer(const aDescription: IdaParamDescription): Pointer;
//#UC START# *555995210007_55E42F2D027B_var*
//#UC END# *555995210007_55E42F2D027B_var*
begin
//#UC START# *555995210007_55E42F2D027B_impl*
 case aDescription.DataType of
  da_dtChar:
   l3System.GetLocalMem(Result, aDescription.Size + 1);
  da_dtDWord:
   l3System.GetLocalMem(Result, SizeOf(LongInt));
  da_dtQWord:
   l3System.GetLocalMem(Result, SizeOf(LargeInt));
  da_dtDate:                                           
   l3System.GetLocalMem(Result, SizeOf(TStDate));
  da_dtTime:
   l3System.GetLocalMem(Result, SizeOf(TStTime));
  da_dtWord:
   l3System.GetLocalMem(Result, SizeOf(Word));
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)

 else
  Assert(False);
 end;
//!! !!! Needs to be implemented !!!
//#UC END# *555995210007_55E42F2D027B_impl*
end;//TpgDataConverter.AllocateParamBuffer

procedure TpgDataConverter.ParamToDataBase(const aDescription: IdaParamDescription;
  ClientBufferFormat: TdaDataType;
  aClientBuffer: Pointer;
  var aServerBuffer: Pointer);
//#UC START# *5559955500DF_55E42F2D027B_var*
var
 l_Str: AnsiString;
 l_Size: Integer;
//#UC END# *5559955500DF_55E42F2D027B_var*
begin
//#UC START# *5559955500DF_55E42F2D027B_impl*
 case aDescription.DataType of
  da_dtChar:
   begin
    case ClientBufferFormat of
     da_dtDWord:
      l_Str := IntToStr(PLongInt(aClientBuffer)^);
     da_dtQWord:
      l_Str := IntToStr(PLargeInt(aClientBuffer)^);
     da_dtChar:
      l_Str := PAnsiString(aClientBuffer)^;
     da_dtDate:
      l_Str := IntToStr(PStDate(aClientBuffer)^);
     da_dtTime:
      l_Str := IntToStr(PStTime(aClientBuffer)^);
     da_dtWord:
      l_Str := IntToStr(PWord(aClientBuffer)^);
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
    end; // Client case da_dtDWord
    if aDescription.Size = 0 then
    begin
     l_Size := Length(l_Str);
     l3System.FreeLocalMem(aServerBuffer);
     l3System.GetLocalMem(aServerBuffer, l_Size + 1);
    end
    else
     l_Size := aDescription.Size;
    StrPLCopy(PAnsiChar(aServerBuffer), PAnsiChar(l_Str), l_Size);
   end;
  da_dtDWord:
   case ClientBufferFormat of
    da_dtDWord:
     PLongInt(aServerBuffer)^ := PLongInt(aClientBuffer)^;
    da_dtQWord:
     PLongInt(aServerBuffer)^ := PLargeInt(aClientBuffer)^;
    da_dtChar:
     PLongInt(aServerBuffer)^ := StrToInt(PAnsiString(aClientBuffer)^);
    da_dtDate:
     PLongInt(aServerBuffer)^ := PStDate(aClientBuffer)^;
    da_dtTime:
     PLongInt(aServerBuffer)^ := PStTime(aClientBuffer)^;
    da_dtWord:
     PLongInt(aServerBuffer)^ := PWord(aClientBuffer)^;
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtDWord
  da_dtQWord:
   case ClientBufferFormat of
    da_dtDWord:
     PLargeInt(aServerBuffer)^ := PLongInt(aClientBuffer)^;
    da_dtQWord:
     PLargeInt(aServerBuffer)^ := PLargeInt(aClientBuffer)^;
    da_dtChar:
     PLargeInt(aServerBuffer)^ := StrToInt64(PAnsiString(aClientBuffer)^);
    da_dtDate:
     PLargeInt(aServerBuffer)^ := PStDate(aClientBuffer)^;
    da_dtTime:
     PLargeInt(aServerBuffer)^ := PStTime(aClientBuffer)^;
    da_dtWord:
     PLargeInt(aServerBuffer)^ := PWord(aClientBuffer)^;
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtQWord

  da_dtDate:
   case ClientBufferFormat of
    da_dtDWord:
     PStDate(aServerBuffer)^ := PLongInt(aClientBuffer)^;
    da_dtQWord:
     PStDate(aServerBuffer)^ := PLargeInt(aClientBuffer)^;
    da_dtChar:
     PStDate(aServerBuffer)^ := StrToInt(PAnsiString(aClientBuffer)^);
    da_dtDate:
     PStDate(aServerBuffer)^ := PStDate(aClientBuffer)^;
    da_dtTime:
     PStDate(aServerBuffer)^ := PStTime(aClientBuffer)^;
    da_dtWord:
     PStDate(aServerBuffer)^ := PWord(aClientBuffer)^;
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtQWord

  da_dtTime:
   case ClientBufferFormat of
    da_dtDWord:
     PStTime(aServerBuffer)^ := PLongInt(aClientBuffer)^;
    da_dtQWord:
     PStTime(aServerBuffer)^ := PLargeInt(aClientBuffer)^;
    da_dtChar:
     PStTime(aServerBuffer)^ := StrToInt(PAnsiString(aClientBuffer)^);
    da_dtDate:
     PStTime(aServerBuffer)^ := PStDate(aClientBuffer)^;
    da_dtTime:
     PStTime(aServerBuffer)^ := PStTime(aClientBuffer)^;
    da_dtWord:
     PStTime(aServerBuffer)^ := PWord(aClientBuffer)^;
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end;

  da_dtWord:
   case ClientBufferFormat of
    da_dtDWord:
     PWord(aServerBuffer)^ := PLongInt(aClientBuffer)^;
    da_dtQWord:
     PWord(aServerBuffer)^ := PLargeInt(aClientBuffer)^;
    da_dtChar:
     PWord(aServerBuffer)^ := StrToInt(PAnsiString(aClientBuffer)^);
    da_dtDate:
     PWord(aServerBuffer)^ := PStDate(aClientBuffer)^;
    da_dtTime:
     PWord(aServerBuffer)^ := PStTime(aClientBuffer)^;
    da_dtWord:
     PWord(aServerBuffer)^ := PWord(aClientBuffer)^;
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtQWord
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)

 else
  Assert(False);
 end;
//!! !!! Needs to be implemented !!!
//#UC END# *5559955500DF_55E42F2D027B_impl*
end;//TpgDataConverter.ParamToDataBase

procedure TpgDataConverter.ParamFromDataBase(const aDescription: IdaParamDescription;
  ClientBufferFormat: TdaDataType;
  aServerBuffer: Pointer;
  aClientBuffer: Pointer);
//#UC START# *55599596005B_55E42F2D027B_var*
//#UC END# *55599596005B_55E42F2D027B_var*
begin
//#UC START# *55599596005B_55E42F2D027B_impl*
 case ClientBufferFormat of
  da_dtChar:
   case aDescription.DataType of
    da_dtChar:
     PAnsiString(aClientBuffer)^ := StrPas(PAnsiChar(aServerBuffer));
    da_dtDWord:
     PAnsiString(aClientBuffer)^ := IntToStr(PLongInt(aServerBuffer)^);
    da_dtQWord:
     PAnsiString(aClientBuffer)^ := IntToStr(PLargeInt(aServerBuffer)^);
    da_dtDate:
     PAnsiString(aClientBuffer)^ := IntToStr(PStDate(aServerBuffer)^);
    da_dtTime:
     PAnsiString(aClientBuffer)^ := IntToStr(PStTime(aServerBuffer)^);
    da_dtWord:
     PAnsiString(aClientBuffer)^ := IntToStr(PWord(aServerBuffer)^);
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtDWord

  da_dtDWord:
   case aDescription.DataType of
    da_dtChar:
     PLongInt(aClientBuffer)^ := StrToInt(PAnsiChar(aServerBuffer)^);
    da_dtDWord:
     PLongInt(aClientBuffer)^ := PLongInt(aServerBuffer)^;
    da_dtQWord:
     PLongInt(aClientBuffer)^ := PLargeInt(aServerBuffer)^;
    da_dtDate:
     PLongInt(aClientBuffer)^ := PStDate(aServerBuffer)^;
    da_dtTime:
     PLongInt(aClientBuffer)^ := PStTime(aServerBuffer)^;
    da_dtWord:
     PLongInt(aClientBuffer)^ := PWord(aServerBuffer)^;
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtDWord
  da_dtQWord:
   case ClientBufferFormat of
    da_dtChar:
     PLargeInt(aClientBuffer)^ := StrToInt64(PAnsiChar(aServerBuffer)^);
    da_dtDWord:
     PLargeInt(aClientBuffer)^ := PLongInt(aServerBuffer)^;
    da_dtQWord:
     PLargeInt(aClientBuffer)^ := PLargeInt(aServerBuffer)^;
    da_dtDate:
     PLargeInt(aClientBuffer)^ := PStDate(aServerBuffer)^;
    da_dtTime:
     PLargeInt(aClientBuffer)^ := PStTime(aServerBuffer)^;
    da_dtWord:
     PLargeInt(aClientBuffer)^ := PWord(aServerBuffer)^;
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtQWord

  da_dtDate:
   case ClientBufferFormat of
    da_dtChar:
     PStDate(aClientBuffer)^ := StrToInt(PAnsiChar(aServerBuffer)^);
    da_dtDWord:
     PStDate(aClientBuffer)^ := PLongInt(aServerBuffer)^;
    da_dtQWord:
     PStDate(aClientBuffer)^ := PLargeInt(aServerBuffer)^;
    da_dtDate:
     PStDate(aClientBuffer)^ := PStDate(aServerBuffer)^;
    da_dtTime:
     PStDate(aClientBuffer)^ := PStTime(aServerBuffer)^;
    da_dtWord:
     PStDate(aClientBuffer)^ := PWord(aServerBuffer)^;
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtQWord

  da_dtTime:
   case ClientBufferFormat of
    da_dtChar:
     PStTime(aClientBuffer)^ := StrToInt(PAnsiChar(aServerBuffer)^);
    da_dtDWord:
     PStTime(aClientBuffer)^ := PLongInt(aServerBuffer)^;
    da_dtQWord:
     PStTime(aClientBuffer)^ := PLargeInt(aServerBuffer)^;
    da_dtDate:
     PStTime(aClientBuffer)^ := PStDate(aServerBuffer)^;
    da_dtTime:
     PStTime(aClientBuffer)^ := PStTime(aServerBuffer)^;
    da_dtWord:
     PStTime(aClientBuffer)^ := PWord(aServerBuffer)^;
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end;

  da_dtWord:
   case ClientBufferFormat of
    da_dtChar:
     PWord(aClientBuffer)^ := StrToInt(PAnsiChar(aServerBuffer)^);
    da_dtDWord:
     PWord(aClientBuffer)^ := PLongInt(aServerBuffer)^;
    da_dtQWord:
     PWord(aClientBuffer)^ := PLargeInt(aServerBuffer)^;
    da_dtDate:
     PWord(aClientBuffer)^ := PStDate(aServerBuffer)^;
    da_dtTime:
     PWord(aClientBuffer)^ := PStTime(aServerBuffer)^;
    da_dtWord:
     PWord(aClientBuffer)^ := PWord(aServerBuffer)^;
(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtQWord

(*
++   da_dtChar
 , da_dtByte
++ , da_dtDate
++ , da_dtTime
++ , da_dtDWord
++ , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
 else
  Assert(False);
 end;
//!! !!! Needs to be implemented !!!
//#UC END# *55599596005B_55E42F2D027B_impl*
end;//TpgDataConverter.ParamFromDataBase

procedure TpgDataConverter.FreeParamBuffer(const aDescription: IdaParamDescription;
  aBuffer: Pointer);
//#UC START# *5559D14D02D1_55E42F2D027B_var*
//#UC END# *5559D14D02D1_55E42F2D027B_var*
begin
//#UC START# *5559D14D02D1_55E42F2D027B_impl*
 l3System.FreeLocalMem(aBuffer);
//#UC END# *5559D14D02D1_55E42F2D027B_impl*
end;//TpgDataConverter.FreeParamBuffer

function TpgDataConverter.ToInteger(aData: Pointer): Integer;
//#UC START# *5627650001E5_55E42F2D027B_var*
//#UC END# *5627650001E5_55E42F2D027B_var*
begin
//#UC START# *5627650001E5_55E42F2D027B_impl*
 Result := StrToInt(PAnsiChar(aData));
//#UC END# *5627650001E5_55E42F2D027B_impl*
end;//TpgDataConverter.ToInteger

function TpgDataConverter.ToLargeInt(aData: Pointer): LargeInt;
//#UC START# *56276513038B_55E42F2D027B_var*
//#UC END# *56276513038B_55E42F2D027B_var*
begin
//#UC START# *56276513038B_55E42F2D027B_impl*
 Result := StrToInt64(PAnsiChar(aData));
//#UC END# *56276513038B_55E42F2D027B_impl*
end;//TpgDataConverter.ToLargeInt

function TpgDataConverter.ToStDate(aData: Pointer): TStDate;
//#UC START# *56276521027B_55E42F2D027B_var*
//#UC END# *56276521027B_55E42F2D027B_var*
begin
//#UC START# *56276521027B_55E42F2D027B_impl*
 Result := StrToInt(PAnsiChar(aData));
//#UC END# *56276521027B_55E42F2D027B_impl*
end;//TpgDataConverter.ToStDate

function TpgDataConverter.ToStTime(aData: Pointer): TStTime;
//#UC START# *562765320349_55E42F2D027B_var*
//#UC END# *562765320349_55E42F2D027B_var*
begin
//#UC START# *562765320349_55E42F2D027B_impl*
 Result := StrToInt(PAnsiChar(aData));
//#UC END# *562765320349_55E42F2D027B_impl*
end;//TpgDataConverter.ToStTime

function TpgDataConverter.ToString(aData: Pointer): AnsiString;
//#UC START# *5627654202D2_55E42F2D027B_var*
//#UC END# *5627654202D2_55E42F2D027B_var*
begin
//#UC START# *5627654202D2_55E42F2D027B_impl*
 Result := PAnsiChar(aData);
//#UC END# *5627654202D2_55E42F2D027B_impl*
end;//TpgDataConverter.ToString

function TpgDataConverter.ToByte(aData: Pointer): Byte;
//#UC START# *562E129A00BB_55E42F2D027B_var*
//#UC END# *562E129A00BB_55E42F2D027B_var*
begin
//#UC START# *562E129A00BB_55E42F2D027B_impl*
 Result := StrToInt(PAnsiChar(aData));
//#UC END# *562E129A00BB_55E42F2D027B_impl*
end;//TpgDataConverter.ToByte

{$IfEnd} //UsePostgres

end.