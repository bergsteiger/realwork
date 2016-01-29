unit htDataConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "HT"
// Модуль: "w:/common/components/rtl/Garant/HT/htDataConverter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::HT::Provider::ThtDataConverter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\HT\htDefineDA.inc}

interface

uses
  l3ProtoObject,
  htInterfaces
  {$If not defined(Nemesis)}
  ,
  HT_Const
  {$IfEnd} //not Nemesis
  ,
  daInterfaces,
  daTypes,
  l3Date
  ;

type
 ThtDataConverter = class(Tl3ProtoObject, IhtDataConverter)
 private
 // private methods
   function MakeString(aData: Pointer;
     const aDesc: OPEL): AnsiString;
 protected
 // realized methods
   function AllocateParamBuffer(const aDescription: IdaParamDescription): Pointer;
   procedure ParamToDataBase(const aDescription: IdaParamDescription;
    ClientBufferFormat: TdaDataType;
    aClientBuffer: Pointer;
    aServerBuffer: Pointer);
   procedure ParamFromDataBase(const aDescription: IdaParamDescription;
    ClientBufferFormat: TdaDataType;
    aServerBuffer: Pointer;
    aClientBuffer: Pointer);
   procedure FreeParamBuffer(const aDescription: IdaParamDescription;
    aBuffer: Pointer);
   function ToLargeInt(aData: Pointer;
    const aDesc: OPEL): LargeInt;
   function ToInteger(aData: Pointer;
    const aDesc: OPEL): Integer;
   function ToStDate(aData: Pointer;
    const aDesc: OPEL): TStDate;
   function ToStTime(aData: Pointer;
    const aDesc: OPEL): TStTime;
   function ToString(aData: Pointer;
    const aDesc: OPEL): AnsiString;
   function ToByte(aData: Pointer;
    const aDesc: OPEL): Byte;
 public
 // public methods
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
   class function Make: IhtDataConverter; reintroduce;
     {* Сигнатура фабрики ThtDataConverter.Make }
 end;//ThtDataConverter

implementation

uses
  l3Base,
  l3String,
  SysUtils
  ;

// start class ThtDataConverter

function ThtDataConverter.MakeString(aData: Pointer;
  const aDesc: OPEL): AnsiString;
//#UC START# *562E1BAB0090_55599B5C014A_var*
//#UC END# *562E1BAB0090_55599B5C014A_var*
begin
//#UC START# *562E1BAB0090_55599B5C014A_impl*
 if aDesc.nType = ET_CHAR then
  Result := l3ArrayToString(aData^, aDesc.wLen)
 else
  Result := '';
//#UC END# *562E1BAB0090_55599B5C014A_impl*
end;//ThtDataConverter.MakeString

constructor ThtDataConverter.Create;
//#UC START# *55599D240026_55599B5C014A_var*
//#UC END# *55599D240026_55599B5C014A_var*
begin
//#UC START# *55599D240026_55599B5C014A_impl*
 inherited Create;
//#UC END# *55599D240026_55599B5C014A_impl*
end;//ThtDataConverter.Create

class function ThtDataConverter.Make: IhtDataConverter;
var
 l_Inst : ThtDataConverter;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function ThtDataConverter.AllocateParamBuffer(const aDescription: IdaParamDescription): Pointer;
//#UC START# *555995210007_55599B5C014A_var*
//#UC END# *555995210007_55599B5C014A_var*
begin
//#UC START# *555995210007_55599B5C014A_impl*
 case aDescription.DataType of
  da_dtChar:
   l3System.GetLocalMem(Result, aDescription.Size + 1);
  da_dtDWord:
   l3System.GetLocalMem(Result, SizeOf(LongInt));
  da_dtQWord:
   l3System.GetLocalMem(Result, SizeOf(LargeInt));
(*
++   da_dtChar
 , da_dtByte
 , da_dtDate
 , da_dtTime
++ , da_dtDWord
 , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)

 else
  Assert(False);
 end;
// !!! Needs to be implemented !!!
//#UC END# *555995210007_55599B5C014A_impl*
end;//ThtDataConverter.AllocateParamBuffer

procedure ThtDataConverter.ParamToDataBase(const aDescription: IdaParamDescription;
  ClientBufferFormat: TdaDataType;
  aClientBuffer: Pointer;
  aServerBuffer: Pointer);
//#UC START# *5559955500DF_55599B5C014A_var*
//#UC END# *5559955500DF_55599B5C014A_var*
begin
//#UC START# *5559955500DF_55599B5C014A_impl*
 case aDescription.DataType of
  da_dtChar:
   case ClientBufferFormat of
    da_dtDWord:
     StrPLCopy(PAnsiChar(aServerBuffer), PAnsiChar(IntToStr(PLongInt(aClientBuffer)^)), aDescription.Size);
    da_dtQWord:
     StrPLCopy(PAnsiChar(aServerBuffer), PAnsiChar(IntToStr(PLargeInt(aClientBuffer)^)), aDescription.Size);
    da_dtChar:
     StrPLCopy(PAnsiChar(aServerBuffer), PAnsiChar(PAnsiString(aClientBuffer)^), aDescription.Size);
(*
++   da_dtChar
 , da_dtByte
 , da_dtDate
 , da_dtTime
++ , da_dtDWord
 , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtDWord
  da_dtDWord:
   case ClientBufferFormat of
    da_dtDWord:
     PLongInt(aServerBuffer)^ := PLongInt(aClientBuffer)^;
    da_dtQWord:
     PLongInt(aServerBuffer)^ := PLargeInt(aClientBuffer)^;
    da_dtChar:
     PLongInt(aServerBuffer)^ := StrToInt(PAnsiString(aClientBuffer)^);
(*
++   da_dtChar
 , da_dtByte
 , da_dtDate
 , da_dtTime
++ , da_dtDWord
 , da_dtWord
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
(*
++   da_dtChar
 , da_dtByte
 , da_dtDate
 , da_dtTime
++ , da_dtDWord
 , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtQWord

(*   da_dtChar
 , da_dtByte
 , da_dtDate
 , da_dtTime
++ , da_dtDWord
 , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)

 else
  Assert(False);
 end;
// !!! Needs to be implemented !!!
//#UC END# *5559955500DF_55599B5C014A_impl*
end;//ThtDataConverter.ParamToDataBase

procedure ThtDataConverter.ParamFromDataBase(const aDescription: IdaParamDescription;
  ClientBufferFormat: TdaDataType;
  aServerBuffer: Pointer;
  aClientBuffer: Pointer);
//#UC START# *55599596005B_55599B5C014A_var*
//#UC END# *55599596005B_55599B5C014A_var*
begin
//#UC START# *55599596005B_55599B5C014A_impl*
 case ClientBufferFormat of
  da_dtChar:
   case aDescription.DataType of
    da_dtChar:
     PString(aClientBuffer)^ := StrPas(PAnsiChar(aServerBuffer));
    da_dtDWord:
     PString(aClientBuffer)^ := IntToStr(PLongInt(aServerBuffer)^);
    da_dtQWord:
     PString(aClientBuffer)^ := IntToStr(PLargeInt(aServerBuffer)^);
(*
++   da_dtChar
 , da_dtByte
 , da_dtDate
 , da_dtTime
++ , da_dtDWord
 , da_dtWord
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
(*
++   da_dtChar
 , da_dtByte
 , da_dtDate
 , da_dtTime
++ , da_dtDWord
 , da_dtWord
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
(*
++   da_dtChar
 , da_dtByte
 , da_dtDate
 , da_dtTime
++ , da_dtDWord
 , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
   end; // Client case da_dtQWord

(*   da_dtChar
 , da_dtByte
 , da_dtDate
 , da_dtTime
++ , da_dtDWord
 , da_dtWord
 , da_dtInteger
 , da_dtBoolean
++ , da_dtQWord*)
 else
  Assert(False);
 end;
// !!! Needs to be implemented !!!
//#UC END# *55599596005B_55599B5C014A_impl*
end;//ThtDataConverter.ParamFromDataBase

procedure ThtDataConverter.FreeParamBuffer(const aDescription: IdaParamDescription;
  aBuffer: Pointer);
//#UC START# *5559D14D02D1_55599B5C014A_var*
//#UC END# *5559D14D02D1_55599B5C014A_var*
begin
//#UC START# *5559D14D02D1_55599B5C014A_impl*
 l3System.FreeLocalMem(aBuffer);
//#UC END# *5559D14D02D1_55599B5C014A_impl*
end;//ThtDataConverter.FreeParamBuffer

function ThtDataConverter.ToLargeInt(aData: Pointer;
  const aDesc: OPEL): LargeInt;
//#UC START# *55C89B830012_55599B5C014A_var*
//#UC END# *55C89B830012_55599B5C014A_var*
begin
//#UC START# *55C89B830012_55599B5C014A_impl*
 Result := 0;
 case aDesc.nType of
  ET_CHAR:
   Result := StrToInt64(MakeString(aData, aDesc));
//  ET_ARRA = 1;   (* Массив байтов заданной длины *)
  ET_BYTE:
   Result := PByte(aData)^;   (* Элемент - короткое целое (1 байт) без знака *)
  ET_INTR:
   Result := PSmallInt(aData)^;   (* Элемент - целое со знаком *)
  ET_WORD:
   Result := PWord(aData)^;   (* Элемент - целое без знака *)
//  ET_DATE = 5;   (* Дата    - целое без знака *)
//  ET_NMBR = 6;   (* Номер   - 3-х байтовое целое без знака *)
  ET_LONG:
   Result := PLongInt(aData)^;   (* Элемент - длинное целое со знаком *)
  ET_DWRD:
   Result := PLongWord(aData)^;   (* Элемент - длинное целое без знака *)
//  ET_FLOA = 9;   (* Элемент - single *)
//  ET_CURR =10;   (* Деньги  - double *)
//  ET_DFLT =11;   (* Элемент - double *)
 else
  Assert(False);
 end;
//#UC END# *55C89B830012_55599B5C014A_impl*
end;//ThtDataConverter.ToLargeInt

function ThtDataConverter.ToInteger(aData: Pointer;
  const aDesc: OPEL): Integer;
//#UC START# *55C89BB40093_55599B5C014A_var*
//#UC END# *55C89BB40093_55599B5C014A_var*
begin
//#UC START# *55C89BB40093_55599B5C014A_impl*
 Result := 0;
 case aDesc.nType of
  ET_CHAR:
   Result := StrToInt(MakeString(aData, aDesc));
//  ET_ARRA = 1;   (* Массив байтов заданной длины *)
  ET_BYTE:
   Result := PByte(aData)^;   (* Элемент - короткое целое (1 байт) без знака *)
  ET_INTR:
   Result := PSmallInt(aData)^;   (* Элемент - целое со знаком *)
  ET_WORD:
   Result := PWord(aData)^;   (* Элемент - целое без знака *)
//  ET_DATE = 5;   (* Дата    - целое без знака *)
//  ET_NMBR = 6;   (* Номер   - 3-х байтовое целое без знака *)
  ET_LONG:
   Result := PLongInt(aData)^;   (* Элемент - длинное целое со знаком *)
  ET_DWRD:
   Result := PLongWord(aData)^;   (* Элемент - длинное целое без знака *)
//  ET_FLOA = 9;   (* Элемент - single *)
//  ET_CURR =10;   (* Деньги  - double *)
//  ET_DFLT =11;   (* Элемент - double *)
 else
  Assert(False);
 end;
//#UC END# *55C89BB40093_55599B5C014A_impl*
end;//ThtDataConverter.ToInteger

function ThtDataConverter.ToStDate(aData: Pointer;
  const aDesc: OPEL): TStDate;
//#UC START# *55C89BC8017D_55599B5C014A_var*
//#UC END# *55C89BC8017D_55599B5C014A_var*
begin
//#UC START# *55C89BC8017D_55599B5C014A_impl*
 Result := 0;
 case aDesc.nType of
  ET_CHAR:
   Result := StrToInt(MakeString(aData, aDesc));
//  ET_ARRA = 1;   (* Массив байтов заданной длины *)
  ET_BYTE:
   Result := PByte(aData)^;   (* Элемент - короткое целое (1 байт) без знака *)
  ET_INTR:
   Result := PSmallInt(aData)^;   (* Элемент - целое со знаком *)
  ET_WORD:
   Result := PWord(aData)^;   (* Элемент - целое без знака *)
//  ET_DATE = 5;   (* Дата    - целое без знака *)
//  ET_NMBR = 6;   (* Номер   - 3-х байтовое целое без знака *)
  ET_LONG:
   Result := PLongInt(aData)^;   (* Элемент - длинное целое со знаком *)
  ET_DWRD:
   Result := PLongWord(aData)^;   (* Элемент - длинное целое без знака *)
//  ET_FLOA = 9;   (* Элемент - single *)
//  ET_CURR =10;   (* Деньги  - double *)
//  ET_DFLT =11;   (* Элемент - double *)
 else
  Assert(False);
 end;
//#UC END# *55C89BC8017D_55599B5C014A_impl*
end;//ThtDataConverter.ToStDate

function ThtDataConverter.ToStTime(aData: Pointer;
  const aDesc: OPEL): TStTime;
//#UC START# *55C89BDC012F_55599B5C014A_var*
//#UC END# *55C89BDC012F_55599B5C014A_var*
begin
//#UC START# *55C89BDC012F_55599B5C014A_impl*
 Result := 0;
 case aDesc.nType of
  ET_CHAR:
   Result := StrToInt(MakeString(aData, aDesc));
//  ET_ARRA = 1;   (* Массив байтов заданной длины *)
  ET_BYTE:
   Result := PByte(aData)^;   (* Элемент - короткое целое (1 байт) без знака *)
  ET_INTR:
   Result := PSmallInt(aData)^;   (* Элемент - целое со знаком *)
  ET_WORD:
   Result := PWord(aData)^;   (* Элемент - целое без знака *)
//  ET_DATE = 5;   (* Дата    - целое без знака *)
//  ET_NMBR = 6;   (* Номер   - 3-х байтовое целое без знака *)
  ET_LONG:
   Result := PLongInt(aData)^;   (* Элемент - длинное целое со знаком *)
  ET_DWRD:
   Result := PLongWord(aData)^;   (* Элемент - длинное целое без знака *)
//  ET_FLOA = 9;   (* Элемент - single *)
//  ET_CURR =10;   (* Деньги  - double *)
//  ET_DFLT =11;   (* Элемент - double *)
 else
  Assert(False);
 end;
//#UC END# *55C89BDC012F_55599B5C014A_impl*
end;//ThtDataConverter.ToStTime

function ThtDataConverter.ToString(aData: Pointer;
  const aDesc: OPEL): AnsiString;
//#UC START# *55FA9B9301D7_55599B5C014A_var*
//#UC END# *55FA9B9301D7_55599B5C014A_var*
begin
//#UC START# *55FA9B9301D7_55599B5C014A_impl*
 Result := '';
 case aDesc.nType of
  ET_CHAR:
   Result := MakeString(aData, aDesc);
//  ET_ARRA = 1;   (* Массив байтов заданной длины *)
  ET_BYTE:
   Result := IntToStr(PByte(aData)^);   (* Элемент - короткое целое (1 байт) без знака *)
  ET_INTR:
   Result := IntToStr(PSmallInt(aData)^);   (* Элемент - целое со знаком *)
  ET_WORD:
   Result := IntToStr(PWord(aData)^);   (* Элемент - целое без знака *)
//  ET_DATE = 5;   (* Дата    - целое без знака *)
//  ET_NMBR = 6;   (* Номер   - 3-х байтовое целое без знака *)
  ET_LONG:
   Result := IntToStr(PLongInt(aData)^);   (* Элемент - длинное целое со знаком *)
  ET_DWRD:
   Result := IntToStr(PLongWord(aData)^);   (* Элемент - длинное целое без знака *)
//  ET_FLOA = 9;   (* Элемент - single *)
//  ET_CURR =10;   (* Деньги  - double *)
//  ET_DFLT =11;   (* Элемент - double *)
 else
  Assert(False);
 end;
//#UC END# *55FA9B9301D7_55599B5C014A_impl*
end;//ThtDataConverter.ToString

function ThtDataConverter.ToByte(aData: Pointer;
  const aDesc: OPEL): Byte;
//#UC START# *562E0F8F02F3_55599B5C014A_var*
//#UC END# *562E0F8F02F3_55599B5C014A_var*
begin
//#UC START# *562E0F8F02F3_55599B5C014A_impl*
 Result := 0;
 case aDesc.nType of
  ET_CHAR:
   Result := StrToInt(MakeString(aData, aDesc));
//  ET_ARRA = 1;   (* Массив байтов заданной длины *)
  ET_BYTE:
   Result := PByte(aData)^;   (* Элемент - короткое целое (1 байт) без знака *)
  ET_INTR:
   Result := PSmallInt(aData)^;   (* Элемент - целое со знаком *)
  ET_WORD:
   Result := PWord(aData)^;   (* Элемент - целое без знака *)
//  ET_DATE = 5;   (* Дата    - целое без знака *)
//  ET_NMBR = 6;   (* Номер   - 3-х байтовое целое без знака *)
  ET_LONG:
   Result := PLongInt(aData)^;   (* Элемент - длинное целое со знаком *)
  ET_DWRD:
   Result := PLongWord(aData)^;   (* Элемент - длинное целое без знака *)
//  ET_FLOA = 9;   (* Элемент - single *)
//  ET_CURR =10;   (* Деньги  - double *)
//  ET_DFLT =11;   (* Элемент - double *)
 else
  Assert(False);
 end;
//#UC END# *562E0F8F02F3_55599B5C014A_impl*
end;//ThtDataConverter.ToByte

end.