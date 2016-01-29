unit m3SplittedFileStream;

interface

uses
 l3IntfUses
 , m3BaseStream
 , m3FileStream
 , l3Interfaces
 , Classes
 , m3StorageInterfaces
 , l3ProtoDataContainer
;

type
 Tm3InnerFileStream = class(Tm3FileStream)
 end;//Tm3InnerFileStream
 
 Tm3InnerFileStreamList = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tm3InnerFileStreamList
 
 Tm3SplittedFileStream = class(Tm3BaseStream)
  {* Файловый поток порезанный на куски }
  procedure Create(const aName: WideString;
   anAccess: Cardinal;
   aSharedMode: Cardinal;
   aDistribution: Cardinal;
   aFlags: Cardinal);
  function Make(const aName: WideString;
   anAccess: Cardinal;
   aSharedMode: Cardinal;
   aDistribution: Cardinal;
   aFlags: Cardinal): IStream;
  function FileByPos(aPos: Int64;
   var theFileOffset: Int64): Tm3InnerFileStream;
  function FileNameByIndex(anIndex: Integer): AnsiString;
  function FileIndexByPos(aPos: Int64): Integer;
  function NormalizePartSize(aPos: Int64;
   aSize: Integer): Integer;
  function CheckInfoStream(aNeedCreate: Boolean): Boolean;
  function NormalizeFileName(const aFileName: AnsiString): AnsiString;
  procedure SetDefaultSizeLimit(aValue: Cardinal);
 end;//Tm3SplittedFileStream
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Windows
 , ActiveX
 , l3String
 , l3Base
 , l3FileUtils
 , m2COMLib
 , l3Stream
 , l3Types
 , ComObj
 , l3MinMax
 , RTLConsts
;

end.
