unit k2SizedMemoryPool;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2SizedMemoryPool.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::K2::Standard::k2SizedMemoryPool
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Interfaces,
  Classes,
  l3Memory,
  k2Base,
  l3Variant,
  k2TagList,
  k2Prim,
  k2BaseStruct,
  k2BaseTypes,
  l3Types,
  l3IID
  ;

(*
 StreamCopying = PureMixIn
   procedure CopyFrom(Source: TStream;
     Count: Int64);
   procedure CopyTo(Dest: TStream;
     Count: Int64);
 end;//StreamCopying
*)

 {$Define k2Tag_No_f_TagType}

type
 _k2Tag_Parent_ = Tl3SizedMemoryPool;
 {$Include ..\K2\k2Tag.imp.pas}
 Tk2SizedMemoryPool = class(_k2Tag_)
 protected
 // realized methods
   {$If not defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} //not k2TagIsAtomic
 public
 // realized methods
   procedure CopyFrom(Source: TStream;
     Count: Int64);
   procedure CopyTo(Dest: TStream;
     Count: Int64);
 protected
 // overridden protected methods
   procedure InitFields; override;
   function GetIsStream(out theStream: IStream): Boolean; override;
   function GetMemoryPoolAdapterClass: Rl3MemoryPoolAdapter; override;
   function GetMemoryStreamClass: Rl3MemoryStream; override;
   function GetIsOrd: Boolean; override;
   function GetTagType: Tl3VariantDef; override;
 public
 // public methods
   constructor Create(aType: Tk2Type); reintroduce; overload; 
   constructor Create; overload; 
   class function Make(aType: Tk2Type): Il3TagRef; overload; 
   constructor CreateFromStream(aStream: TStream);
   class function CreateFromString(aString: Tl3PrimString): Tk2SizedMemoryPool;
   class function CreateFromFile(const aFileName: AnsiString): Tk2SizedMemoryPool;
   constructor CreateFromIStream(const aStream: IStream);
 end;//Tk2SizedMemoryPool

 Tk2RawData = Tk2SizedMemoryPool;

implementation

uses
  SysUtils,
  ComObj,
  l3Stream,
  l3BaseStream,
  k2RawData_Const,
  k2MemoryPoolAdapter,
  k2MemoryStream,
  l3TempMemoryStream,
  k2Tags,
  l3Dict,
  k2Const,
  l3Const,
  l3String,
  k2Except,
  k2Strings,
  TypInfo,
  l3Base,
  k2Facade,
  k2OList_Const,
  k2Dictionary,
  k2NonOptimizeContext,
  k2VariantImpl,
  k2Bool_Const,
  k2String,
  k2List,
  k2NullTagImpl,
  k2Interfaces,
  k2DictionaryPrim,
  k2InterfaceFactory
  ;

type _Instance_R_ = Tk2SizedMemoryPool;

{$Include ..\K2\k2Tag.imp.pas}

// start class Tk2SizedMemoryPool

constructor Tk2SizedMemoryPool.Create(aType: Tk2Type);
//#UC START# *530770EB0342_53076BA10113_var*
//#UC END# *530770EB0342_53076BA10113_var*
begin
//#UC START# *530770EB0342_53076BA10113_impl*
 inherited Create;
 Assert(aType = k2_typRawData);
//#UC END# *530770EB0342_53076BA10113_impl*
end;//Tk2SizedMemoryPool.Create

constructor Tk2SizedMemoryPool.Create;
//#UC START# *530B592503D3_53076BA10113_var*
//#UC END# *530B592503D3_53076BA10113_var*
begin
//#UC START# *530B592503D3_53076BA10113_impl*
 inherited Create;
//#UC END# *530B592503D3_53076BA10113_impl*
end;//Tk2SizedMemoryPool.Create

class function Tk2SizedMemoryPool.Make(aType: Tk2Type): Il3TagRef;
//#UC START# *535786890241_53076BA10113_var*
var
 l_Inst : Tk2SizedMemoryPool;
//#UC END# *535786890241_53076BA10113_var*
begin
//#UC START# *535786890241_53076BA10113_impl*
 l_Inst := Create(aType);
 try
  Result := l_Inst.AsRef;
 finally
  FreeAndNil(l_Inst);
 end;//try..finally
//#UC END# *535786890241_53076BA10113_impl*
end;//Tk2SizedMemoryPool.Make

constructor Tk2SizedMemoryPool.CreateFromStream(aStream: TStream);
//#UC START# *53B552640177_53076BA10113_var*
var
 l_Stream : IStream;
 l_Read : Large;
 l_Written : Large;
 l_Position : Large;
//#UC END# *53B552640177_53076BA10113_var*
begin
//#UC START# *53B552640177_53076BA10113_impl*
 Create;
 l_Stream := l3Stream2IStream(aStream);
 Assert(l_Stream <> nil);
 try
  OleCheck(l_Stream.Seek(0, STREAM_SEEK_SET, l_Position));
  {$IfDef nsTest}
  Dec(g_IStreamCopyTo_Guard);
  try
  {$EndIf nsTest}
   OleCheck(l_Stream.CopyTo(Self As IStream, High(Large), l_Read, l_Written));
  {$IfDef nsTest}
  finally
   Inc(g_IStreamCopyTo_Guard);
  end;//try..finally
  {$EndIf nsTest}
 finally
  l_Stream := nil;
 end;//try..finally
//#UC END# *53B552640177_53076BA10113_impl*
end;//Tk2SizedMemoryPool.CreateFromStream

class function Tk2SizedMemoryPool.CreateFromString(aString: Tl3PrimString): Tk2SizedMemoryPool;
//#UC START# *53C00C140267_53076BA10113_var*
var
 l_IStream : IStream; 
 l_Stream : TStream;
//#UC END# *53C00C140267_53076BA10113_var*
begin
//#UC START# *53C00C140267_53076BA10113_impl*
 if not aString.QI(IStream, l_IStream) then
 begin
  Result := nil;
  Assert(false);
 end//not aString.QI(IStream, l_IStream)
 else
 begin
  l3IStream2Stream(l_IStream, l_Stream);
  try
   Result := CreateFromStream(l_Stream);
  finally
   FreeAndNil(l_Stream);
  end;//try..finally
 end;//not aString.QI(IStream, l_IStream)
//#UC END# *53C00C140267_53076BA10113_impl*
end;//Tk2SizedMemoryPool.CreateFromString

class function Tk2SizedMemoryPool.CreateFromFile(const aFileName: AnsiString): Tk2SizedMemoryPool;
//#UC START# *53C015EF00DE_53076BA10113_var*
var
 l_FileData : Tl3NamedFileStream;
//#UC END# *53C015EF00DE_53076BA10113_var*
begin
//#UC START# *53C015EF00DE_53076BA10113_impl*
 if DirectoryExists(aFileName) then
 // - это не файл, а директория - надо пока записать "пустышку"
  Result := nil
 else 
 if FileExists(aFileName) then
 begin
  l_FileData := Tl3NamedFileStream.Create(aFileName, l3_fmRead);
  try
   Result := CreateFromStream(l_FileData);
  finally
   FreeAndNil(l_FileData);
  end;//try..finally
 end//FileExists(anItem)
 else
  Result := nil;
//#UC END# *53C015EF00DE_53076BA10113_impl*
end;//Tk2SizedMemoryPool.CreateFromFile

constructor Tk2SizedMemoryPool.CreateFromIStream(const aStream: IStream);
//#UC START# *53C3CD600278_53076BA10113_var*
var
 l_Read : Int64;
 l_Written : Int64;
 l_Position : Int64;
//#UC END# *53C3CD600278_53076BA10113_var*
begin
//#UC START# *53C3CD600278_53076BA10113_impl*
 Create;
 {$IfDef nsTest}
 Dec(g_IStreamCopyTo_Guard);
 try
 {$EndIf nsTest}
  OleCheck(aStream.Seek(0, STREAM_SEEK_SET, l_Position));
  aStream.CopyTo(Self As IStream, High(Large), l_Read, l_Written);
 {$IfDef nsTest}
 finally
  Inc(g_IStreamCopyTo_Guard);
 end;//try..finally
 {$EndIf nsTest}
//#UC END# *53C3CD600278_53076BA10113_impl*
end;//Tk2SizedMemoryPool.CreateFromIStream

{$If not defined(k2TagIsAtomic)}
function Tk2SizedMemoryPool.SetAtomPrim(const aProp: _PropIn_;
  var V: Tk2Values): Boolean;
//#UC START# *49A545580241_53076BA10113_var*
//#UC END# *49A545580241_53076BA10113_var*
begin
//#UC START# *49A545580241_53076BA10113_impl*
 Assert(false);
 Result := false;
//#UC END# *49A545580241_53076BA10113_impl*
end;//Tk2SizedMemoryPool.SetAtomPrim
{$IfEnd} //not k2TagIsAtomic

procedure Tk2SizedMemoryPool.CopyFrom(Source: TStream;
  Count: Int64);
//#UC START# *53B55ED6016D_53076BA10113_var*
var
 l_Stream : TStream;
//#UC END# *53B55ED6016D_53076BA10113_var*
begin
//#UC START# *53B55ED6016D_53076BA10113_impl*
 Assert(Self <> nil);
 l3IStream2Stream(Self As IStream, l_Stream);
 try
  l_Stream.CopyFrom(Source, Count);
 finally
  FreeAndNil(l_Stream);
 end;//try..finally
//#UC END# *53B55ED6016D_53076BA10113_impl*
end;//Tk2SizedMemoryPool.CopyFrom

procedure Tk2SizedMemoryPool.CopyTo(Dest: TStream;
  Count: Int64);
//#UC START# *53B55EF0025D_53076BA10113_var*
var
 l_Stream : TStream;
//#UC END# *53B55EF0025D_53076BA10113_var*
begin
//#UC START# *53B55EF0025D_53076BA10113_impl*
 Assert(Self <> nil);
 l3IStream2Stream(Self As IStream, l_Stream);
 try
  Dest.CopyFrom(l_Stream, Count);
 finally
  FreeAndNil(l_Stream);
 end;//try..finally
//#UC END# *53B55EF0025D_53076BA10113_impl*
end;//Tk2SizedMemoryPool.CopyTo

procedure Tk2SizedMemoryPool.InitFields;
//#UC START# *47A042E100E2_53076BA10113_var*
//#UC END# *47A042E100E2_53076BA10113_var*
begin
//#UC START# *47A042E100E2_53076BA10113_impl*
 inherited;
 //f_TagType := k2_typRawData;
//#UC END# *47A042E100E2_53076BA10113_impl*
end;//Tk2SizedMemoryPool.InitFields

function Tk2SizedMemoryPool.GetIsStream(out theStream: IStream): Boolean;
//#UC START# *530B20AC019A_53076BA10113_var*
//#UC END# *530B20AC019A_53076BA10113_var*
begin
//#UC START# *530B20AC019A_53076BA10113_impl*
 Result := Supports(Self, IStream, theStream);
 Assert(Result);
//#UC END# *530B20AC019A_53076BA10113_impl*
end;//Tk2SizedMemoryPool.GetIsStream

function Tk2SizedMemoryPool.GetMemoryPoolAdapterClass: Rl3MemoryPoolAdapter;
//#UC START# *530B3ADB014E_53076BA10113_var*
//#UC END# *530B3ADB014E_53076BA10113_var*
begin
//#UC START# *530B3ADB014E_53076BA10113_impl*
 Result := Tk2MemoryPoolAdapter;
//#UC END# *530B3ADB014E_53076BA10113_impl*
end;//Tk2SizedMemoryPool.GetMemoryPoolAdapterClass

function Tk2SizedMemoryPool.GetMemoryStreamClass: Rl3MemoryStream;
//#UC START# *530B3F560201_53076BA10113_var*
//#UC END# *530B3F560201_53076BA10113_var*
begin
//#UC START# *530B3F560201_53076BA10113_impl*
 Result := Tk2MemoryStream;
//#UC END# *530B3F560201_53076BA10113_impl*
end;//Tk2SizedMemoryPool.GetMemoryStreamClass

function Tk2SizedMemoryPool.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_53076BA10113_var*
//#UC END# *532AE8F2009A_53076BA10113_var*
begin
//#UC START# *532AE8F2009A_53076BA10113_impl*
 Result := false;
//#UC END# *532AE8F2009A_53076BA10113_impl*
end;//Tk2SizedMemoryPool.GetIsOrd

function Tk2SizedMemoryPool.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_53076BA10113_var*
//#UC END# *533121AF0203_53076BA10113_var*
begin
//#UC START# *533121AF0203_53076BA10113_impl*
 Result := k2_typRawData;
//#UC END# *533121AF0203_53076BA10113_impl*
end;//Tk2SizedMemoryPool.GetTagType

end.