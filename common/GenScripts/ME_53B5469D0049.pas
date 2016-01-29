unit k2SizedMemoryPool;

interface

uses
 l3IntfUses
 , Classes
 , l3Memory
 , k2Base
 , l3Variant
 , l3Interfaces
 , k2BaseStruct
;

 (*
 StreamCopying = interface
  procedure CopyFrom(Source: TStream;
   Count: Int64);
  procedure CopyTo(Dest: TStream;
   Count: Int64);
 end;//StreamCopying
 *)
 
 {$Define k2Tag_No_f_TagType}
 
type
 Tk2SizedMemoryPool = class(_k2Tag_)
  procedure Create(aType: Tk2Type); overload;
  procedure Create; overload;
  function Make(aType: Tk2Type): Il3TagRef; overload;
  procedure CreateFromStream(aStream: TStream);
  function CreateFromString(aString: Tl3PrimString): Tk2SizedMemoryPool;
  function CreateFromFile(const aFileName: AnsiString): Tk2SizedMemoryPool;
  procedure CreateFromIStream(const aStream: IStream);
  function SetAtomPrim(const aProp: _PropIn_;
   var V: Tk2Values): Boolean;
  procedure CopyFrom(Source: TStream;
   Count: Int64);
  procedure CopyTo(Dest: TStream;
   Count: Int64);
 end;//Tk2SizedMemoryPool
 
 Tk2RawData = Tk2SizedMemoryPool;
 
implementation

uses
 l3ImplUses
 , k2RawData_Const
 , k2MemoryPoolAdapter
 , k2MemoryStream
 , l3TempMemoryStream
 , k2Tags
 , l3Dict
 , k2Const
 , l3Const
 , SysUtils
 , l3String
 , k2Except
 , k2Strings
 , k2TagList
 , TypInfo
 , l3Stream
 , l3Base
 , k2Facade
 , k2OList_Const
 , k2Dictionary
 , k2NonOptimizeContext
 , k2VariantImpl
 , k2Bool_Const
 , k2String
 , k2NullTagImpl
 , k2Interfaces
 , k2DictionaryPrim
 , k2InterfaceFactory
 , ComObj
 , l3Types
 , l3BaseStream
;

end.
