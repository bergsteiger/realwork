unit m3StorageInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "m3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/m3/m3StorageInterfaces.pas"
// �����: 30.01.2002 16:54
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi Low Level::m3::m3StorageInterfaces
//
// ���������� ��� ������ � ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3Interfaces,
  l3Types,
  ActiveX,
  l3Core,
  l3PureMixIns
  ;

type
 Tm3StoreAccess = Integer;
  {* ��� ������� � ���������. }

const
  { ������ ������� � ���������. }
 m3_saRead = Tm3StoreAccess(STGM_READ or STGM_SHARE_EXCLUSIVE);
  { ������. }
 m3_saReadWrite = Tm3StoreAccess(STGM_READWRITE or STGM_SHARE_EXCLUSIVE);
  { ������ � ������. }
 m3_saCreate = Tm3StoreAccess(STGM_READWRITE or STGM_SHARE_EXCLUSIVE or STGM_CREATE);
  { ������ � ������ ��� ��������. }
  { ���� ��������. }
 m3_stNone = Pred(STGTY_STORAGE);
  { �� ���������. }
 m3_stStream = STGTY_STREAM;
  { ���������. }
 m3_stStorage = STGTY_Storage;
  { �����. }

type
 Tm3StoreType = m3_stNone..m3_stStream;
  {* ��� �������� ���������. }

 Pm3StoreType = ^Tm3StoreType;
  {* ��������� �� Tm3StoreType. }

 Tm3StoreMode = (
  {* ����� �������� �������� ��������. }
   m3_smCreate
 , m3_smOpen
 );//Tm3StoreMode

 Tm3StoreInfo = packed record
  {* ���������� �� �������� ���������. }
   rPosition : Int64;
   rStoreType : Tm3StoreType;
 end;//Tm3StoreInfo

 Tm3StorageElementID = Integer;

 Tm3StorageElementInfo = record
   rInfo : Tm3StoreInfo;
   rName : Tl3WString;
 end;//Tm3StorageElementInfo

 Im3StorageElementIDList = interface(IUnknown)
   ['{DDD05DF7-3219-4A89-88A3-AD2A21566229}']
  // Ml3ListEx
   function IndexOf(const anItem: Tm3StorageElementID): Integer;
   function Add(const anItem: Tm3StorageElementID): Integer;
  // Ml3List
   function pm_GetEmpty: Boolean;
   function pm_GetFirst: Tm3StorageElementID;
   function pm_GetLast: Tm3StorageElementID;
   function pm_GetItems(anIndex: Integer): Tm3StorageElementID;
   property Empty: Boolean
     read pm_GetEmpty;
   property First: Tm3StorageElementID
     read pm_GetFirst;
     {* ������ �������. }
   property Last: Tm3StorageElementID
     read pm_GetLast;
     {* ��������� �������. }
   property Items[anIndex: Integer]: Tm3StorageElementID
     read pm_GetItems;
     default;
  // Ml3CountHolder
   function pm_GetCount: Integer;
   property Count: Integer
     read pm_GetCount;
     {* ����� ���������. }
 end;//Im3StorageElementIDList

 TStatStg = ActiveX.TStatStg;

 Tm3StorageType = (
   m3_stArchive
 , m3_stPlugin
 , m3_stPlain
 );//Tm3StorageType

  Mm3StorageIterators_IterateIndexedF_Action = function (const anItem: Tm3StoreInfo;
  anIndex: Integer): Boolean;
   {* ��� �������������� ������� ��� Mm3StorageIterators.IterateIndexedF }

  Mm3StorageIterators_IterateAllF_Action = function (const anItem: Tm3StorageElementInfo): Boolean;
   {* ��� �������������� ������� ��� Mm3StorageIterators.IterateAllF }

(*
 Mm3StorageIterators = PureMixIn
   {iterator} procedure IterateIndexedF(anAction: Mm3StorageIterators_IterateIndexedF_Action);
   {iterator} procedure IterateAllF(anAction: Mm3StorageIterators_IterateAllF_Action);
 end;//Mm3StorageIterators
*)

 Tm3StoreElementIndex = Tm3StorageElementID;

 Im3IndexedStorage = interface;
 { - ��������������� �������� Im3IndexedStorage. }

 Tm3Store = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rStream : IStream;
   rStorage : Im3IndexedStorage;
   rResult : HResult;
 public
    function AsIStorage: IStorage;
 end;//Tm3Store

 Im3IndexedStorage = interface(IUnknown{, IStorage})
  {* ��������� � ������������ ������� �� �������. }
   ['{1962E532-4615-4D4A-9FAC-0F1E3402F097}']
   procedure ClearAll;
   procedure CopyFrom(const aSource: Im3IndexedStorage);
   function SetIndexParam(aBits: byte;
    aMaxBits: byte): Boolean;
     {* ������������� ��������� "������������" �������. }
   function DeleteStore(anIndex: Tm3StoreElementIndex): hResult;
     {* ������� ������� ���������. }
   function CreateStore(anIndex: Tm3StoreElementIndex;
    anAccess: Tm3StoreAccess;
    aStoreType: Tm3StoreType;
    out aStore: Tm3Store;
    aUseCompression: Boolean): hResult; overload; 
     {* ������� ������� ���������. }
   function OpenStore(anIndex: Tm3StoreElementIndex;
    anAccess: Tm3StoreAccess;
    aStoreType: Tm3StoreType;
    out aStore: Tm3Store;
    aUseCompression: Boolean): hResult; overload; 
     {* ��������� ������� ���������. }
   function CreateStore(const aName: Tl3WString;
    anAccess: Tm3StoreAccess;
    aStoreType: Tm3StoreType;
    out aStore: Tm3Store;
    aUseCompression: Boolean): hResult; overload; 
     {* ������� ������� ��������� }
   function OpenStore(const aName: Tl3WString;
    anAccess: Tm3StoreAccess;
    aStoreType: Tm3StoreType;
    out aStore: Tm3Store;
    aUseCompression: Boolean): hResult; overload; 
     {* ��������� ������� ��������� }
   function OpenStore(const aStoreInfo: Tm3StorageElementInfo;
    anAccess: Tm3StoreAccess;
    aUseCompression: Boolean): Tm3Store; overload; 
     {* ��������� ������� ���������. }
   function OpenStore(const aStoreInfo: Tm3StoreInfo;
    anAccess: Tm3StoreAccess;
    anIndex: Tm3StoreElementIndex;
    aUseCompression: Boolean): Tm3Store; overload; 
     {* ��������� ������� ��������� }
   function RenameElementA(const aOldName: Tl3WString;
    const aNewName: Tl3WString): hResult;
     {* ��������������� ������� ��������� }
   function ElementExists(const aName: Tl3WString): Boolean;
     {* ��������� ������������� �������� � ��������� ������ }
  // ������ �������������� � ����������� �����������
   function As_IStorage: IStorage;
  // MCommonStorage
   function DestroyElement(aName: PWideChar): HResult; stdcall;
   function EnumElements(unused1: Integer;
     unused2: Pointer;
     unused3: Integer;
     out theStatStg: IEnumStatStg): HResult; stdcall;
   function Stat(out theStatStg: TStatStg;
     aStatFlag: Integer): HResult; stdcall;
  // Mm3StorageIterators
   {iterator} procedure IterateIndexedF(anAction: Mm3StorageIterators_IterateIndexedF_Action);
   {iterator} procedure IterateAllF(anAction: Mm3StorageIterators_IterateAllF_Action);
 end;//Im3IndexedStorage

 Im3StorageHolder = interface(IUnknown)
   ['{0B097519-7C33-4780-AAAA-94D5ADD3FB09}']
   function StoreToCache(const aFileName: WideString;
     aSharedMode: Cardinal): Im3IndexedStorage;
   function Get_Storage: Im3IndexedStorage;
   property Storage: Im3IndexedStorage
     read Get_Storage;
 end;//Im3StorageHolder


function Tm3StoreInfo_C(aPosition: Int64;
     aType: Tm3StoreType): Tm3StoreInfo;

function Tm3StorageElementInfo_C(const anInfo: Tm3StoreInfo;
     const aName: Tl3WString): Tm3StorageElementInfo;
function L2Mm3StorageIteratorsIterateIndexedFAction(anAction: pointer): Mm3StorageIterators_IterateIndexedF_Action;
   {* ������� ������������ �������� ��� ��������� �������������� ������� ��� Mm3StorageIterators.IterateIndexedF }
function L2Mm3StorageIteratorsIterateAllFAction(anAction: pointer): Mm3StorageIterators_IterateAllF_Action;
   {* ������� ������������ �������� ��� ��������� �������������� ������� ��� Mm3StorageIterators.IterateAllF }

function Tm3Store_C(const aStream: IStream): Tm3Store; overload;
function Tm3Store_C(const aStorage: Im3IndexedStorage): Tm3Store; overload;
function Tm3Store_E: Tm3Store; overload;
function Tm3Store_E(aResult: hResult): Tm3Store; overload;

implementation

uses
  l3Base
  ;


function Tm3StoreInfo_C(aPosition: Int64;
       aType: Tm3StoreType): Tm3StoreInfo;
//#UC START# *5451F543029B_47208CA50237_var*
//#UC END# *5451F543029B_47208CA50237_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5451F543029B_47208CA50237_impl*
 Assert((aType = m3_stNone) OR (aType = m3_stStream) OR (aType = m3_stStorage));
 Assert(aPosition >= -1);
 Result.rPosition := aPosition;
 Result.rStoreType := aType;
//#UC END# *5451F543029B_47208CA50237_impl*
end;//Tm3StoreInfo.C


function Tm3StorageElementInfo_C(const anInfo: Tm3StoreInfo;
       const aName: Tl3WString): Tm3StorageElementInfo;
//#UC START# *5451F57B0181_5451F4E50226_var*
//#UC END# *5451F57B0181_5451F4E50226_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5451F57B0181_5451F4E50226_impl*
 Result.rInfo := anInfo;
 Result.rName := aName;
//#UC END# *5451F57B0181_5451F4E50226_impl*
end;//Tm3StorageElementInfo.C

// start class Mm3StorageIterators

function L2Mm3StorageIteratorsIterateIndexedFAction(anAction: pointer): Mm3StorageIterators_IterateIndexedF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2Mm3StorageIteratorsIterateIndexedFAction

function L2Mm3StorageIteratorsIterateAllFAction(anAction: pointer): Mm3StorageIterators_IterateAllF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2Mm3StorageIteratorsIterateAllFAction

function Tm3Store_C(const aStream: IStream): Tm3Store;
//#UC START# *5452154901F5_545210E8021B_var*
//#UC END# *5452154901F5_545210E8021B_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5452154901F5_545210E8021B_impl*
 Result.rStream := aStream;
 if (aStream = nil) then
  Result.rResult := E_NoInterface
 else
  Result.rResult := S_Ok; 
//#UC END# *5452154901F5_545210E8021B_impl*
end;//Tm3Store.C


function Tm3Store_C(const aStorage: Im3IndexedStorage): Tm3Store;
//#UC START# *5452156A0229_545210E8021B_var*
//#UC END# *5452156A0229_545210E8021B_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5452156A0229_545210E8021B_impl*
 Result.rStorage := aStorage;
 if (aStorage = nil) then
  Result.rResult := E_NoInterface
 else
  Result.rResult := S_Ok; 
//#UC END# *5452156A0229_545210E8021B_impl*
end;//Tm3Store.C

// start class Tm3Store

function Tm3Store.AsIStorage: IStorage;
//#UC START# *5452198301A0_545210E8021B_var*
//#UC END# *5452198301A0_545210E8021B_var*
begin
//#UC START# *5452198301A0_545210E8021B_impl*
 if (rStorage = nil) then
  Result := nil
 else
  Result := rStorage.As_IStorage;  
//#UC END# *5452198301A0_545210E8021B_impl*
end;//Tm3Store.AsIStorage

function Tm3Store_E: Tm3Store;
//#UC START# *545221CD0019_545210E8021B_var*
//#UC END# *545221CD0019_545210E8021B_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *545221CD0019_545210E8021B_impl*
 Result.rResult := E_NoInterface;
//#UC END# *545221CD0019_545210E8021B_impl*
end;//Tm3Store.E


function Tm3Store_E(aResult: hResult): Tm3Store;
//#UC START# *545227580181_545210E8021B_var*
//#UC END# *545227580181_545210E8021B_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *545227580181_545210E8021B_impl*
 Result.rResult := aResult;
//#UC END# *545227580181_545210E8021B_impl*
end;//Tm3Store.E

end.