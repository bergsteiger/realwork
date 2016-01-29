unit l3Variant;

interface

uses
 l3IntfUses
 , l3Interfaces
 , Classes
 , l3Variants
 , l3Types
 , l3DataContainerWithoutIUnknownPrim
 , l3Const
 , k2BaseTypes
 , l3ProtoObject
;

 (*
 Mk2Storable = interface
  {* Методы тега отвечающие за сохранение/восстановление }
  procedure DoLoad;
  procedure ForceStore;
 end;//Mk2Storable
 *)
 
type
 Tk2VarKind = (
  k2_vkInteger
  , k2_vkString
  , k2_vkTransparent
  , k2_vkStream
 );//Tk2VarKind
 
 Il3OpPack = interface;
 
 Ik2Variant = interface;
 
 Tl3Variant = class;
 
 Tl3VariantDef = class;
 
 Ik2TagGenerator = interface
  {* Генератор тегов }
  procedure AddStringAtom(TagID: Integer;
   const Value: AnsiString;
   aCodePage: Integer); overload;
   {* добавить строковый атом. }
  procedure AddStringAtom(TagID: Integer;
   const Value: Tl3WString); overload;
   {* добавить строковый атом. }
  procedure AddStreamAtom(TagID: Integer;
   aStream: TStream);
   {* добавить атом из потока. }
  procedure AddTransparentAtom(TagID: Integer);
   {* добавить "прозрачный" атом. }
  procedure AddIntegerAtom(TagID: Integer;
   Value: Integer);
   {* добавить целочисленный атом. }
  procedure AddBoolAtom(TagID: Integer;
   Value: Boolean);
  procedure AddAtom(AtomIndex: Integer;
   aValue: Tl3Variant);
   {* добавить атом. }
  procedure AddAtomEx(AtomIndex: Integer;
   const Value: Ik2Variant);
  procedure Start;
   {* начать генерацию. }
  procedure StartChild(TypeID: Tl3VariantDef);
   {* начать дочерний объект тега. }
  procedure StartDefaultChild;
   {* начать дочерний объект тега с типом по-умолчанию. }
  procedure StartTag(TagID: Integer);
   {* начать вложеный тег. }
  procedure Finish(NeedUndo: Boolean);
   {* закрыть скобку этапа генерации. }
  procedure Rollback(CheckBrackets: Boolean);
   {* откатить все открытые "скобки". }
  function Pixel2Char(Pixel: Integer): Integer;
  procedure AddInt64Atom(aTagID: Integer;
   aValue: Int64);
   {* Добавляет 64-битный атом }
  function Char2Pixel(aCh: Integer): Integer;
 end;//Ik2TagGenerator
 
 Ik2UndoBuffer = interface
  {* Undo-буфер }
  function GetActiveObject(aSucc: Boolean): TObject;
  procedure ExecutedOperation(aContainer: TObject);
   {* нотификация буферу о новой пачке операций. }
  function Undo(const aProcessor: Ik2Processor): Boolean;
   {* отменить предыдущую операцию. }
  function Redo(const aProcessor: Ik2Processor): Boolean;
   {* вернуть отмененную операцию. }
  procedure Clear;
   {* Очистить буфер операций. }
 end;//Ik2UndoBuffer
 
 Ik2Processor = interface(Il3ChangeNotifier)
  {* Процессор операций. }
  function StartOp(OpCode: Integer;
   DoLock: Boolean): Il3OpPack;
   {* начать операцию. }
  function FinishOp(anOp: TObject): Boolean;
   {* закончить операцию. }
  function LastOp: Il3OpPack;
   {* предыдущая операция. }
  function InOp: Boolean;
   {* Пачка операций открыта. }
  procedure Lock;
   {* закрыть. }
  procedure Unlock;
   {* открыть. }
  function Undo: Boolean;
   {* отменить предыдущую операцию. }
  function Redo: Boolean;
   {* вернуть отмененную операцию. }
  procedure CheckInsert(aParent: Tl3Variant;
   var aChild: Tl3Variant;
   var anIndex: Integer);
   {* проверить операцию с параграфом. }
  procedure CheckDelete(aParent: Tl3Variant;
   aChild: Tl3Variant;
   anIndex: Integer);
   {* проверить операцию с параграфом. }
  procedure NotifyCompleted(aList: Tl3Variant;
   aChild: Tl3Variant);
  procedure NotifyInsert(aList: Tl3Variant;
   aProp: TObject;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: Il3OpPack);
  procedure NotifyDelete(aList: Tl3Variant;
   aProp: TObject;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: Il3OpPack);
  function NeedReplaceQuotes: Boolean;
   {* Опрелеляет - нужно ли заменять кавычки при вводе. }
  procedure NotifyPropChanged(aProp: TObject;
   aValues;
   const anOp: Il3OpPack);
   {* Сообщает об изменении свойства объекта }
 end;//Ik2Processor
 
 Il3OpPackMode = interface
  {* Пачка операций. }
  procedure MarkModified(aTarget: Tl3Variant);
  procedure InvertModified;
  function GetModified: Boolean;
  procedure CheckReadOnly;
  procedure DisableReadonly;
   {* Выключает режим проверки ReadOnly }
  procedure EnableReadOnly;
   {* Включает режим проверки ReadOnly }
  procedure CheckOn;
  procedure CheckOff;
  function IsCheckOff: Boolean;
 end;//Il3OpPackMode
 
 Il3OpPack = interface(Il3OpPackMode)
  {* Пачка операций. }
  function Undo(const aProcessor: Ik2Processor): Integer;
   {* откатывает все операции и возвращает их количество. }
  function Redo(const aProcessor: Ik2Processor): Integer;
   {* возвращает все операции и возвращает их количество. }
  procedure Lock;
   {* закрыть. }
  procedure Unlock;
   {* открыть. }
 end;//Il3OpPack
 
 Mk2Children_IterateChildrenF_Action = function(anItem: Tl3Variant;
  anIndex: Integer): Boolean;
  {* Тип подитеративной функции для Mk2Children.IterateChildrenF }
 
 Mk2Children_IterateChildrenBack_Action = function(anItem: Tl3Variant;
  anIndex: Integer): Boolean;
  {* Тип подитеративной функции для Mk2Children.IterateChildrenBack }
 
 Il3TagRef = interface;
 
 (*
 Mk2Children = interface
  {* Хранилище детей }
  procedure IterateChildrenF;
  procedure IterateChildrenBack;
  function AddChild(aChild: Tl3Variant;
   const aContext: Il3OpPack): Integer;
   {* добавить ребенка. }
  function DeleteChild(anIndex: Integer;
   const anOp: Il3OpPack;
   out theChild: Il3TagRef): Boolean; overload;
   {* удалить ребенка. }
  function DeleteChild(aChild: Tl3Variant;
   const Context: Il3OpPack): Boolean; overload;
   {* удалить ребенка. }
  function DeleteChild(anIndex: Integer;
   const anOp: Il3OpPack): Boolean; overload;
 end;//Mk2Children
 *)
 
 (*
 Mk2RefCount = interface
  {* Подсчёт ссылок }
  procedure SetRef(var aRef: Tl3Variant);
 end;//Mk2RefCount
 *)
 
 (*
 Mk2TypeInfoEx = interface(Mk2TypeInfo)
  function IsSame(aType: Tl3VariantDef): Boolean;
 end;//Mk2TypeInfoEx
 *)
 
 (*
 Mk2Owned = interface
 end;//Mk2Owned
 *)
 
 (*
 Mk2IntegerHolder = interface
  function rLong(anIndex: Integer;
   aDefault: Integer): Integer;
 end;//Mk2IntegerHolder
 *)
 
 (*
 Mk2PCharLenHolder = interface
 end;//Mk2PCharLenHolder
 *)
 
 (*
 Mk2BooleanHolder = interface
 end;//Mk2BooleanHolder
 *)
 
 (*
 Mk2StringHolder = interface
 end;//Mk2StringHolder
 *)
 
 (*
 Mk2TypeHolder = interface
 end;//Mk2TypeHolder
 *)
 
 (*
 Mk2TagHolder = interface
  function rAtomEx(const Path: TOpenLongArray;
   theIndex: PLongint): Tl3Variant;
   {* вернуть подтег. }
  function cAtom(anIndex: Integer;
   const aContext: Il3OpPack;
   anAtomType: Tl3VariantDef): Tl3Variant;
   {* проверить существование подтега и создать его при необходимости. }
  function cAtomEx(const aPath: TOpenLongArray;
   const aContext: Il3OpPack;
   theIndex: PLongint): Tl3Variant;
   {* проверить существование подтега и создать его при необходимости. }
 end;//Mk2TagHolder
 *)
 
 (*
 Mk2TagToolProvider = interface
  function QT(const IID: TGUID;
   out Obj;
   const aProcessor: Ik2Processor): Boolean;
   {* возвращает инструмент для работы с тегом, к которому привязан исходный инструмент. }
 end;//Mk2TagToolProvider
 *)
 
 (*
 Mk2Int64Holder = interface
 end;//Mk2Int64Holder
 *)
 
 (*
 Mk2TypeInfoPrim = interface
  function IsKindOf(anID: Tl3VariantDef): Boolean; overload;
   {* проверить наследование. }
  function IsKindOf(const anIDs: array of Tk2TypePrim): Boolean; overload;
   {* проверить наследование. }
  function IsKindOf(anAtomTypeID: Tl3VariantDef;
   const Exclude: array of Tk2TypePrim): Boolean; overload;
   {* проверить наследование. }
 end;//Mk2TypeInfoPrim
 *)
 
 (*
 Ml3VariantSame = interface
  function IsSame(anOther: Tl3Variant): Boolean; overload;
 end;//Ml3VariantSame
 *)
 
 (*
 Ml3Tag = interface
  function GetOwnInterface(const IID: TGUID;
   out Obj): Boolean;
   {* возвращает интерфейс НЕПОСРЕДСТВЕННО поддерживаемый реализацией инструмента. }
  function Box: Tl3Variant;
   {* ссылка на тег - для сохранения. }
 end;//Ml3Tag
 *)
 
 Tl3VariantPrim = class(Tl3DataContainerWithoutIUnknownPrim)
  function GetAsString: AnsiString;
  function GetIsOrd: Boolean;
  function GetIsKindOfPrim(aType: Tl3VariantDef): Boolean;
  function QI(const aGUID: TGUID;
   out theObj): Boolean;
  function GetAsPCharLen: Tl3WString;
  function IsOrd: Boolean;
  function IsKindOf(anID: Tl3VariantDef): Boolean; overload;
   {* проверить наследование. }
  function IsKindOf(const anIDs: array of Tk2TypePrim): Boolean; overload;
   {* проверить наследование. }
  function IsKindOf(anAtomTypeID: Tl3VariantDef;
   const Exclude: array of Tk2TypePrim): Boolean; overload;
   {* проверить наследование. }
 end;//Tl3VariantPrim
 
 Tl3VariantDef = class(Tl3VariantPrim)
  function IsProp: Boolean;
  function IsNull: Boolean;
  function MakeTag(aRef: Integer): Il3TagRef;
  function DoDoMakeTag(aRef: Integer): Il3TagRef;
  function GetIsProp: Boolean;
  function IsSame(aType: Tl3VariantDef): Boolean;
 end;//Tl3VariantDef
 
 Ml3TagHolder_IterateProperties_Action = function(anItem: Tl3Variant;
  anIndex: Tl3VariantDef): Boolean;
  {* Тип подитеративной функции для Ml3TagHolder.IterateProperties }
 
 (*
 Ml3TagHolder = interface
  procedure IterateProperties;
   {* перебирает все существующие свойства }
 end;//Ml3TagHolder
 *)
 
 (*
 Ml3TagBox = interface
  function AsObject: Tl3Variant;
 end;//Ml3TagBox
 *)
 
 Tl3Variant = class(_l3Changing_)
  function GetAsLong: Integer;
  function GetIsNull: Boolean;
  function GetIsTransparent: Boolean;
  function GetIsStream(out theStream: IStream): Boolean;
  function DoGetHasSubAtom(anIndex: Integer): Boolean;
  function TagType: Tl3VariantDef; overload;
  function AsRef: Il3TagRef;
  procedure DoSetRef(var theRef: Tl3Variant);
  function DoQT(const IID: TGUID;
   out Obj;
   const aProcessor: Ik2Processor): Boolean;
  function GetTagType: Tl3VariantDef;
  procedure SetAttr(anIndex: Integer;
   const aContext: Il3OpPack;
   aValue: Tl3Variant);
  function GetAttr(anIndex: Integer;
   out theValue: Tl3Variant): Boolean;
  procedure SetBoolAttr(anIndex: Integer;
   const aContext: Il3OpPack;
   aValue: Boolean);
  procedure SetIntAttr(anIndex: Integer;
   const aContext: Il3OpPack;
   aValue: Integer);
  procedure SetWStrAttr(anIndex: Integer;
   const aContext: Il3OpPack;
   const aValue: Tl3WString);
  procedure DoDoLoad;
  procedure DoForceStore;
  function DoIterateChildrenBack(Action: Mk2Children_IterateChildrenBack_Action;
   aHi: Tl3Index;
   aLo: Tl3Index;
   aLoadedOnly: Boolean): Integer;
  function DoAddChild(aChild: Tl3Variant;
   const aContext: Il3OpPack): Integer;
  function CheckAttr(const aPath: array of Integer;
   const aContext: Il3OpPack;
   DoCheck: Boolean;
   theIndex: PLongint): Tl3Variant;
  function DoCAtom(anIndex: Integer;
   const aContext: Il3OpPack;
   anAtomType: Tl3VariantDef): Tl3Variant;
  function GetAsBox: Tl3Variant;
  function GetAsRef: Il3TagRef;
  function GetInt64A(anIndex: Integer): Int64;
  procedure SetInt64A(anIndex: Integer;
   const aContext: Il3OpPack;
   aValue: Int64);
  function DoMarkModified: Boolean;
  procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
   All: Boolean);
  function DeleteChildPrim(anIndex: Integer;
   aChild: Tl3Variant;
   const aContext: Il3OpPack): Boolean;
  function DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
   aLo: Tl3Index;
   aHi: Tl3Index;
   aLoadedOnly: Boolean): Integer;
  procedure CheckSort(aProp: Tl3VariantDef);
  function FindChild(anAtom: Integer;
   aValue: Integer;
   const aContext: Il3OpPack;
   aNeedCreate: Boolean;
   theIndex: PLongint): Tl3Variant;
  function CloneTag: Il3TagRef;
  procedure WriteTag(const G: Ik2TagGenerator;
   Flags: Tk2StorePropertyFlags;
   Exclude: TByteSet);
   {* записать тег в генератор. }
  function AssignTag(Source: Tl3Variant;
   AssignMode: Tk2AssignModes;
   const Context: Il3OpPack): Boolean;
  procedure AssignCloneParams(aSource: Tl3Variant;
   AssignMode: Tk2AssignModes;
   const Context: Il3OpPack);
  procedure DeleteChildren(const Context: Il3OpPack);
   {* удалить всех детей. }
  procedure InsertChildTag(anIndex: Integer;
   aChild: Tl3Variant;
   const aContext: Il3OpPack);
   {* вставить ребенка. }
  function IndexOfChild(aChild: Tl3Variant): Integer;
  function rOwnAtom(anIndex: Integer): Tl3Variant;
  function GetLinkedInterface(const IID: TGUID;
   out Obj): Boolean;
  function CompareWithInt(aValue: Integer;
   anIndex: Integer): Integer;
   {* Сравнивает тег с целым. }
  function CompareWithTag(aTag: Tl3Variant;
   aSortIndex: Tl3SortIndex): Integer;
  function Box: Tl3Variant;
   {* ссылка на тег - для сохранения. }
  function Attr: Tl3Variant;
  function BoolA: Boolean;
  function IntA: Integer;
  function StrA: AnsiString;
  function Child: Tl3Variant;
  function BoolW: Boolean;
  function IntW: Integer;
  function StrW: AnsiString;
  function PCharLenA: Tl3PCharLen;
  function PCharLenW: Tl3WString;
  function AsString: AnsiString;
   {* свойство для преобразования к строкам Delphi }
  function AsWStr: Tl3WString;
   {* свойство для преобразования к типу Tl3PCharLen }
  function AsBool: Boolean;
   {* преобразовать к Boolean. }
  function AsLong: Integer;
  function AsObject: Tl3Variant;
  function AddChild(aChild: Tl3Variant;
   const aContext: Il3OpPack): Integer;
   {* добавить ребенка. }
  function ChildrenCount: Integer;
   {* Количество дочерних тегов. }
  procedure SetRef(var aRef: Tl3Variant);
  function DeleteChild(anIndex: Integer;
   const anOp: Il3OpPack;
   out theChild: Il3TagRef): Boolean; overload;
   {* удалить ребенка. }
  function DeleteChild(aChild: Tl3Variant;
   const Context: Il3OpPack): Boolean; overload;
   {* удалить ребенка. }
  function DeleteChild(anIndex: Integer;
   const anOp: Il3OpPack): Boolean; overload;
  procedure DoLoad;
  procedure ForceStore;
  function MarkModified: Boolean;
  function ChildrenCapacity: Integer;
   {* Потенциально возможное число детей }
  function Owner: Tl3Variant;
  procedure IterateChildrenF;
  procedure IterateChildrenBack;
  procedure IterateProperties;
   {* перебирает все существующие свойства }
  function rLong(anIndex: Integer;
   aDefault: Integer): Integer;
  function rAtomEx(const Path: TOpenLongArray;
   theIndex: PLongint): Tl3Variant;
   {* вернуть подтег. }
  function cAtom(anIndex: Integer;
   const aContext: Il3OpPack;
   anAtomType: Tl3VariantDef): Tl3Variant;
   {* проверить существование подтега и создать его при необходимости. }
  function cAtomEx(const aPath: TOpenLongArray;
   const aContext: Il3OpPack;
   theIndex: PLongint): Tl3Variant;
   {* проверить существование подтега и создать его при необходимости. }
  function HasSubAtom(anIndex: Integer): Boolean;
  function IsNull: Boolean;
   {* пустой тег? }
  function IsValid: Boolean;
   {* тег имеет значение? }
  function IsTransparent: Boolean;
   {* тег "прозрачный"? }
  function IsStream(out theStream: IStream): Boolean;
   {* Проверяет может ли тег приводиться к потоку. И приводит к потоку - если указатель на поток - не нулевой. }
  function QT(const IID: TGUID;
   out Obj;
   const aProcessor: Ik2Processor): Boolean;
   {* возвращает инструмент для работы с тегом, к которому привязан исходный инструмент. }
  function GetOwnInterface(const IID: TGUID;
   out Obj): Boolean;
   {* возвращает интерфейс НЕПОСРЕДСТВЕННО поддерживаемый реализацией инструмента. }
  function Int64A: Int64;
  function Int64W: Int64;
  function IsSame(anOther: Tl3Variant): Boolean; overload;
  function AttrW: Tl3Variant;
  function TagType: Tl3VariantDef; overload;
  function DateTimeA: TDateTime;
  function DateTimeW: TDateTime;
 end;//Tl3Variant
 
 Tl3Tag = Tl3Variant;
 
 Tl3PrimString = class(Tl3Tag)
  procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
  procedure Clear;
   {* Функция очистки объекта.  Для перекрытия в потомках. }
  procedure AssignString(aStr: Tl3PrimString);
   {* Присвает другую строку данной. }
  function Clone: Pointer;
   {* Создайт копию строки. }
 end;//Tl3PrimString
 
 Ik2Variant = interface
 end;//Ik2Variant
 
 Il3TagRef = interface
  function AsObject: Tl3Variant;
 end;//Il3TagRef
 
 Tl3Type = Tl3VariantDef;
 
 Ik2Tag = interface(Il3TagRef)
  {* Объект содержащий подъобекты и атомарные атрибуты }
  function IsOrd: Boolean;
  procedure IterateChildrenF;
  procedure IterateChildrenBack;
  function AddChild(aChild: Tl3Variant;
   const aContext: Il3OpPack): Integer;
   {* добавить ребенка. }
  function DeleteChild(anIndex: Integer;
   const anOp: Il3OpPack;
   out theChild: Il3TagRef): Boolean; overload;
   {* удалить ребенка. }
  function DeleteChild(aChild: Tl3Variant;
   const Context: Il3OpPack): Boolean; overload;
   {* удалить ребенка. }
  function DeleteChild(anIndex: Integer;
   const anOp: Il3OpPack): Boolean; overload;
  procedure SetRef(var aRef: Tl3Variant);
  procedure DoLoad;
  procedure ForceStore;
  function rLong(anIndex: Integer;
   aDefault: Integer): Integer;
  function rAtomEx(const Path: TOpenLongArray;
   theIndex: PLongint): Tl3Variant;
   {* вернуть подтег. }
  function cAtom(anIndex: Integer;
   const aContext: Il3OpPack;
   anAtomType: Tl3VariantDef): Tl3Variant;
   {* проверить существование подтега и создать его при необходимости. }
  function cAtomEx(const aPath: TOpenLongArray;
   const aContext: Il3OpPack;
   theIndex: PLongint): Tl3Variant;
   {* проверить существование подтега и создать его при необходимости. }
  function HasSubAtom(anIndex: Integer): Boolean;
  function QT(const IID: TGUID;
   out Obj;
   const aProcessor: Ik2Processor): Boolean;
   {* возвращает инструмент для работы с тегом, к которому привязан исходный инструмент. }
  function AsBool: Boolean;
   {* преобразовать к Boolean. }
  function AsLong: Integer;
  function IsNull: Boolean;
   {* пустой тег? }
  function IsTransparent: Boolean;
   {* тег "прозрачный"? }
  function IsValid: Boolean;
   {* тег имеет значение? }
  function IsStream(out theStream: IStream): Boolean;
   {* Проверяет может ли тег приводиться к потоку. И приводит к потоку - если указатель на поток - не нулевой. }
  function MarkModified: Boolean;
  function IsKindOf(anID: Tl3VariantDef): Boolean; overload;
   {* проверить наследование. }
  function IsKindOf(const anIDs: array of Tk2TypePrim): Boolean; overload;
   {* проверить наследование. }
  function IsKindOf(anAtomTypeID: Tl3VariantDef;
   const Exclude: array of Tk2TypePrim): Boolean; overload;
   {* проверить наследование. }
  function IsSame(anOther: Tl3Variant): Boolean; overload;
  function GetOwnInterface(const IID: TGUID;
   out Obj): Boolean;
   {* возвращает интерфейс НЕПОСРЕДСТВЕННО поддерживаемый реализацией инструмента. }
  function Box: Tl3Variant;
   {* ссылка на тег - для сохранения. }
  procedure IterateProperties;
   {* перебирает все существующие свойства }
 end;//Ik2Tag
 
 Pl3Variant = ^Tl3Variant;
 
 Tl3NullTag = class(Tl3ProtoObject, Il3TagRef)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function AsObject: Tl3Variant;
 end;//Tl3NullTag
 
 Tl3TagRef = class(Tl3ProtoObject, Il3TagRef)
  procedure Create(aTag: Tl3Tag);
  function Make(aTag: Tl3Tag): Il3TagRef;
  function AsObject: Tl3Variant;
 end;//Tl3TagRef
 
 Tk2In64Converter = record
 end;//Tk2In64Converter
 
implementation

uses
 l3ImplUses
 , l3Base
 , Windows
 , l3String
 , l3Chars
 , SysUtils
 , l3Date
;

end.
