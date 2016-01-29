unit k2Prim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Classes
 , l3Variant
 , l3Types
 , TypInfo
 , l3ProtoIntegerList
 , l3Interfaces
 , k2PropertyArray
;

type
 Tk2TypeTablePrim = class(Tl3ProtoObject)
  procedure AddCreatedListener(aListener: TNotifyEvent);
 end;//Tk2TypeTablePrim
 
 Tk2TypePrim = class;
 
 Tk2CustomPropertyPrim = class;
 
 Tk2Base = class(Tl3VariantDef)
 end;//Tk2Base
 
 Tk2TypeIDPrim = Byte;
 
 Tk2TypeIDSet = set of Tk2TypeIDPrim;
 
 Tk2TypeIDs = class(Tl3ProtoIntegerList)
  function Has(aTypeID: Integer): Boolean;
  procedure Include(aTypeID: Integer);
  procedure Assign(anOther: Tk2TypeIDs);
 end;//Tk2TypeIDs
 
 Tk2TypePrimPrim = class(Tk2Base)
  function IsDisabledChildTypeID(anID: Integer): Boolean;
   {* Проверяет, что тип ребёнка является запрещённым }
  procedure AddDisabledChildTypeID(anID: Integer);
   {* Добавляет тип запрещённого ребёнка }
  function DefaultChildTypeID: Tk2TypePrim;
  function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
  procedure InheritsFrom;
  function TagType: Tk2TypePrim;
 end;//Tk2TypePrimPrim
 
 Tk2CustomPropertyPrim = class(Tk2Base)
  {* Базовое описание свойств }
  procedure Create(anOwner: Tk2TypePrim);
  function IsThisArray(out theProp: Tl3VariantDef): Boolean;
  function TagType: Tk2TypePrim;
 end;//Tk2CustomPropertyPrim
 
 Ik2Op = Il3OpPack;
  {* Пачка операций. }
 
 Tk2PropertyArray = k2PropertyArray.Tk2PropertyArray;
 
 Tk2TypePrim = class(Tk2TypePrimPrim)
  {* Базовое описание типа }
 end;//Tk2TypePrim
 
 Tk2ArrayPropertyPrim = Tk2CustomPropertyPrim;
 
 Ik2Processor = l3Variant.Ik2Processor;
 
 Il3OpPackMode = l3Variant.Il3OpPackMode;
 
 Il3OpPack = l3Variant.Il3OpPack;
 
implementation

uses
 l3ImplUses
 , k2TypeTableCreatedListeners
 , k2Tags
 , k2Empty_Const
 , k2BaseHack
 , SysUtils
 , l3String
 , k2Attributes
;

type
 Pk2CustomPropertyPrim = ^Tk2CustomPropertyPrim;
 
end.
