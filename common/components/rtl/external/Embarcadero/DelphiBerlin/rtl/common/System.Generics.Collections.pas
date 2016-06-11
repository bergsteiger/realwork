{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Generics.Collections;

{$R-,T-,X+,H+,B-}

interface

uses
  System.Types, System.SysUtils, System.Generics.Defaults;

type
  TArray = class
  private
    class procedure QuickSort<T>(var Values: array of T; const Comparer: IComparer<T>;
      L, R: Integer); static;
    class procedure CheckArrays(Source, Destination: Pointer; SourceIndex, SourceLength, DestIndex, DestLength, Count: NativeInt); static;
  public
    class procedure Sort<T>(var Values: array of T); overload; static;
    class procedure Sort<T>(var Values: array of T; const Comparer: IComparer<T>); overload; static;
    class procedure Sort<T>(var Values: array of T;
      const Comparer: IComparer<T>; Index, Count: Integer); overload; static;

    class function BinarySearch<T>(const Values: array of T; const Item: T;
      out FoundIndex: Integer; const Comparer: IComparer<T>;
      Index, Count: Integer): Boolean; overload; static;
    class function BinarySearch<T>(const Values: array of T; const Item: T;
      out FoundIndex: Integer; const Comparer: IComparer<T>): Boolean; overload; static;
    class function BinarySearch<T>(const Values: array of T; const Item: T;
      out FoundIndex: Integer): Boolean; overload; static; static;

    class procedure Copy<T>(const Source: array of T; var Destination: array of T; SourceIndex, DestIndex, Count: NativeInt); overload; static;
    class procedure Copy<T>(const Source: array of T; var Destination: array of T; Count: NativeInt); overload; static;
  end;
  
  TCollectionNotification = (cnAdded, cnRemoved, cnExtracted);
  TCollectionNotifyEvent<T> = procedure(Sender: TObject; const Item: T;
    Action: TCollectionNotification) of object;

  TEnumerator<T> = class abstract
  protected
    function DoGetCurrent: T; virtual; abstract;
    function DoMoveNext: Boolean; virtual; abstract;
  public
    property Current: T read DoGetCurrent;
    function MoveNext: Boolean;
  end;

  TEnumerable<T> = class abstract
  private
  {$HINTS OFF}
    function ToArrayImpl(Count: Integer): TArray<T>; // used by descendants
  {$HINTS ON}
  protected
    function DoGetEnumerator: TEnumerator<T>; virtual; abstract;
  public
    destructor Destroy; override;
    function GetEnumerator: TEnumerator<T>;
    function ToArray: TArray<T>; virtual;
  end;

  [HPPGEN(HPPGenAttribute.mkFriend, 'DELPHICLASS TList__1<T>')]
  TListHelper = record
  private type
    TInternalNotifyEvent = procedure (const Item; Action: TCollectionNotification) of object;
    TInternalCompareEvent = function (const Left, Right): Integer of object;
    TInternalEmptyFunc = reference to function(const Item): Boolean;
    PInterface = ^IInterface;
    PBytes = ^TBytes;
  private var
    FCount: Integer;
    FTypeInfo: Pointer;
    FNotify: TInternalNotifyEvent;
    FCompare: TInternalCompareEvent;
    function GetFItems: PPointer; inline;
    function GetElType: Pointer; inline;
    function GetElSize: Integer; inline;
    function CheckDeleteRange(AIndex, ACount: Integer): Boolean; inline;
    procedure CheckItemRangeInline(AIndex: Integer); inline;
    procedure CheckInsertRange(AIndex: Integer); inline;
    procedure CheckItemRange(AIndex: Integer);
    function DoIndexOfFwd1(const Value): Integer;
    function DoIndexOfFwd2(const Value): Integer;
    function DoIndexOfFwd4(const Value): Integer;
    function DoIndexOfFwd8(const Value): Integer;
    function DoIndexOfFwdN(const Value): Integer;
    function DoIndexOfFwdMRef(const Value): Integer;
    function DoIndexOfRev1(const Value): Integer;
    function DoIndexOfRev2(const Value): Integer;
    function DoIndexOfRev4(const Value): Integer;
    function DoIndexOfRev8(const Value): Integer;
    function DoIndexOfRevN(const Value): Integer;
    function DoIndexOfRevMRef(const Value): Integer;
    procedure DoExtractItemFwd1(const Value; out Item);
    procedure DoExtractItemFwd2(const Value; out Item);
    procedure DoExtractItemFwd4(const Value; out Item);
    procedure DoExtractItemFwd8(const Value; out Item);
    procedure DoExtractItemFwdN(const Value; out Item);
    procedure DoExtractItemFwdString(const Value; out Item);
    procedure DoExtractItemFwdInterface(const Value; out Item);
    procedure DoExtractItemFwdVariant(const Value; out Item);
    procedure DoExtractItemFwdByteString(const Value; out Item);
{$IF not Defined(NEXTGEN)}
    procedure DoExtractItemFwdWideString(const Value; out Item);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure DoExtractItemFwdObject(const Value; out Item);
{$ENDIF}
    procedure DoExtractItemFwdManaged(const Value; out Item);
    procedure DoExtractItemRev1(const Value; out Item);
    procedure DoExtractItemRev2(const Value; out Item);
    procedure DoExtractItemRev4(const Value; out Item);
    procedure DoExtractItemRev8(const Value; out Item);
    procedure DoExtractItemRevN(const Value; out Item);
    procedure DoExtractItemRevString(const Value; out Item);
    procedure DoExtractItemRevInterface(const Value; out Item);
    procedure DoExtractItemRevVariant(const Value; out Item);
    procedure DoExtractItemRevByteString(const Value; out Item);
{$IF not Defined(NEXTGEN)}
    procedure DoExtractItemRevWideString(const Value; out Item);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure DoExtractItemRevObject(const Value; out Item);
{$ENDIF}
    procedure DoExtractItemRevManaged(const Value; out Item);
    procedure DoExchangeStringInline(Index1, Index2: Integer); inline;
    procedure DoExchangeInterfaceInline(Index1, Index2: Integer); inline;
    procedure DoExchangeVariantInline(Index1, Index2: Integer); inline;
    procedure DoExchangeDynArrayInline(Index1, Index2: Integer); inline;
    procedure DoExchangeByteStringInline(Index1, Index2: Integer); inline;
{$IF not Defined(NEXTGEN)}
    procedure DoExchangeWideStringInline(Index1, Index2: Integer); inline;
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure DoExchangeObjectInline(Index1, Index2: Integer); inline;
{$ENDIF}
    procedure DoExchangeString(Index1, Index2: Integer);
    procedure DoExchangeInterface(Index1, Index2: Integer);
    procedure DoExchangeVariant(Index1, Index2: Integer);
    procedure DoExchangeDynArray(Index1, Index2: Integer);
    procedure DoExchangeByteString(Index1, Index2: Integer);
{$IF not Defined(NEXTGEN)}
    procedure DoExchangeWideString(Index1, Index2: Integer);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure DoExchangeObject(Index1, Index2: Integer);
{$ENDIF}
    function DoRemoveFwd1(const Value): Integer;
    function DoRemoveFwd2(const Value): Integer;
    function DoRemoveFwd4(const Value): Integer;
    function DoRemoveFwd8(const Value): Integer;
    function DoRemoveFwdN(const Value): Integer;
    function DoRemoveFwdMRef(const Value): Integer;
    function DoRemoveFwdManaged(const Value): Integer;
{$IF Defined(WEAKREF)}
    function DoRemoveFwdWeak(const Value): Integer;
{$ENDIF}
    function DoRemoveRev1(const Value): Integer;
    function DoRemoveRev2(const Value): Integer;
    function DoRemoveRev4(const Value): Integer;
    function DoRemoveRev8(const Value): Integer;
    function DoRemoveRevN(const Value): Integer;
    function DoRemoveRevMRef(const Value): Integer;
    function DoRemoveRevManaged(const Value): Integer;
{$IF Defined(WEAKREF)}
    function DoRemoveRevWeak(const Value): Integer;
{$ENDIF}
    procedure SetItem1(const Value; AIndex: Integer);
    procedure SetItem2(const Value; AIndex: Integer);
    procedure SetItem4(const Value; AIndex: Integer);
    procedure SetItem8(const Value; AIndex: Integer);
    procedure SetItemManaged(const Value; AIndex: Integer);
    procedure SetItemN(const Value; AIndex: Integer);
{$IF Defined(AUTOREFCOUNT)}
    procedure DoInsertObject(AIndex: Integer; const Value);
    procedure DoSetItemObject(const Value; AIndex: Integer);
    function DoAddObject(const Value): Integer;
{$ENDIF}
    procedure DoInsertByteString(AIndex: Integer; const Value);
    procedure DoSetItemByteString(const Value; AIndex: Integer);
    function DoAddByteString(const Value): Integer;
{$IF not Defined(NEXTGEN)}
    procedure DoInsertWideString(AIndex: Integer; const Value);
    procedure DoSetItemWideString(const Value; AIndex: Integer);
    function DoAddWideString(const Value): Integer;
{$ENDIF}
    procedure DoInsertInterface(AIndex: Integer; const Value);
    procedure DoSetItemInterface(const Value; AIndex: Integer);
    procedure DoInsertString(AIndex: Integer; const Value);
    procedure DoSetItemString(const Value; AIndex: Integer);
    procedure DoInsertDynArray(AIndex: Integer; const Value);
    procedure DoSetItemDynArray(const Value; AIndex: Integer);
    procedure SetItemVariant(const Value; AIndex: Integer);
    procedure SetItemMRef(const Value; AIndex: Integer; TypeKind: TTypeKind); inline;
    function DoAddInterface(const Value): Integer;
    function DoAddString(const Value): Integer;
    function DoAddDynArray(const Value): Integer;
    procedure DoReverseMRef(Kind: TTypeKind); inline;
    procedure DoReverseString;
    procedure DoReverseInterface;
    procedure DoReverseVariant;
    procedure DoReverseDynArray;
    procedure DoReverseByteString;
{$IF not Defined(NEXTGEN)}
    procedure DoReverseWideString;
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure DoReverseObject;
{$ENDIF}
    function InternalAdd1(const Value): Integer;
    function InternalAdd2(const Value): Integer;
    function InternalAdd4(const Value): Integer;
    function InternalAdd8(const Value): Integer;
    function InternalAddN(const Value): Integer;
    function InternalAddVariant(const Value): Integer;
    function InternalAddMRef(const Value; TypeKind: TTypeKind): Integer; inline;
    function InternalAddManaged(const Value): Integer;
    procedure InternalGrow(ANewCount: Integer);
    procedure InternalGrowCheck(ANewCount: Integer);
    procedure InternalDeleteRange1(AIndex, ACount: Integer);
    procedure InternalDeleteRange2(AIndex, ACount: Integer);
    procedure InternalDeleteRange4(AIndex, ACount: Integer);
    procedure InternalDeleteRange8(AIndex, ACount: Integer);
    procedure InternalDeleteRangeN(AIndex, ACount: Integer);
    procedure InternalDeleteRangeMRef(AIndex, ACount: Integer);
    procedure InternalDeleteRangeManaged(AIndex, ACount: Integer);
{$IF Defined(WEAKREF)}
    procedure InternalDeleteRangeWeak(AIndex, ACount: Integer);
{$ENDIF}
    procedure InternalDoDelete1(AIndex: Integer; Action: TCollectionNotification);
    procedure InternalDoDelete2(AIndex: Integer; Action: TCollectionNotification);
    procedure InternalDoDelete4(AIndex: Integer; Action: TCollectionNotification);
    procedure InternalDoDelete8(AIndex: Integer; Action: TCollectionNotification);
    procedure InternalDoDeleteN(AIndex: Integer; Action: TCollectionNotification);
    procedure InternalDoDeleteMRef(AIndex: Integer; Action: TCollectionNotification);
    procedure InternalDoDeleteManaged(AIndex: Integer; Action: TCollectionNotification);
{$IF Defined(WEAKREF)}
    procedure InternalDoDeleteWeak(AIndex: Integer; Action: TCollectionNotification);
{$ENDIF}
    procedure InternalSetCapacity(Value: NativeInt);
    procedure InternalSetCount1(Value: Integer);
    procedure InternalSetCount2(Value: Integer);
    procedure InternalSetCount4(Value: Integer);
    procedure InternalSetCount8(Value: Integer);
    procedure InternalSetCountN(Value: Integer);
    procedure InternalSetCountMRef(Value: Integer);
    procedure InternalSetCountManaged(Value: Integer);
{$IF Defined(WEAKREF)}
    procedure InternalSetCountWeak(Value: Integer);
{$ENDIF}
    procedure InternalClear1;
    procedure InternalClear2;
    procedure InternalClear4;
    procedure InternalClear8;
    procedure InternalClearN;
    procedure InternalClearMRef;
    procedure InternalClearManaged;
{$IF Defined(WEAKREF)}
    procedure InternalClearWeak;
{$ENDIF}
    procedure InternalInsert1(AIndex: Integer; const Value);
    procedure InternalInsert2(AIndex: Integer; const Value);
    procedure InternalInsert4(AIndex: Integer; const Value);
    procedure InternalInsert8(AIndex: Integer; const Value);
    procedure InternalInsertN(AIndex: Integer; const Value);
    procedure InternalInsertVariant(AIndex: Integer; const Value);
    procedure InternalInsertMRef(AIndex: Integer; const Value; TypeKind: TTypeKind); inline;
    procedure InternalInsertManaged(AIndex: Integer; const Value);
    procedure InternalInsertRange1(AIndex: Integer; Values: Pointer; ACount: Integer);
    procedure InternalInsertRange2(AIndex: Integer; Values: Pointer; ACount: Integer);
    procedure InternalInsertRange4(AIndex: Integer; Values: Pointer; ACount: Integer);
    procedure InternalInsertRange8(AIndex: Integer; Values: Pointer; ACount: Integer);
    procedure InternalInsertRangeN(AIndex: Integer; Values: Pointer; ACount: Integer);
    procedure InternalInsertRangeManaged(AIndex: Integer; Values: Pointer; ACount: Integer);
    function InternalIndexOf1(const Value; Direction: Byte): Integer; inline;
    function InternalIndexOf2(const Value; Direction: Byte): Integer; inline;
    function InternalIndexOf4(const Value; Direction: Byte): Integer; inline;
    function InternalIndexOf8(const Value; Direction: Byte): Integer; inline;
    function InternalIndexOfN(const Value; Direction: Byte): Integer; inline;
    function InternalIndexOfMRef(const Value; Direction: Byte): Integer; inline;
    procedure InternalExtractItem1(const Value; out Item; Direction: Byte); inline;
    procedure InternalExtractItem2(const Value; out Item; Direction: Byte); inline;
    procedure InternalExtractItem4(const Value; out Item; Direction: Byte); inline;
    procedure InternalExtractItem8(const Value; out Item; Direction: Byte); inline;
    procedure InternalExtractItemN(const Value; out Item; Direction: Byte); inline;
    procedure InternalExtractItemMRef(const Value; Kind: TTypeKind; out Item; Direction: Byte); inline;
    procedure InternalExtractItemVariant(const Value; out Item; Direction: Byte); inline;
    procedure InternalExtractItemManaged(const Value; out Item; Direction: Byte); inline;
    procedure InternalExchange1(Index1, Index2: Integer);
    procedure InternalExchange2(Index1, Index2: Integer);
    procedure InternalExchange4(Index1, Index2: Integer);
    procedure InternalExchange8(Index1, Index2: Integer);
    procedure InternalExchangeN(Index1, Index2: Integer);
    procedure InternalExchangeMRef(Index1, Index2: Integer; Kind: TTypeKind); inline;
    procedure InternalExchangeManaged(Index1, Index2: Integer);
    procedure InternalMove1(CurIndex, NewIndex: Integer);
    procedure InternalMove2(CurIndex, NewIndex: Integer);
    procedure InternalMove4(CurIndex, NewIndex: Integer);
    procedure InternalMove8(CurIndex, NewIndex: Integer);
    procedure InternalMoveN(CurIndex, NewIndex: Integer);
    procedure InternalMoveMRef(CurIndex, NewIndex: Integer);
    procedure InternalMoveManaged(CurIndex, NewIndex: Integer);
    procedure InternalPackInline(const IsEmpty: TInternalEmptyFunc);
    procedure InternalPack1(const IsEmpty: TInternalEmptyFunc);
    procedure InternalPack2(const IsEmpty: TInternalEmptyFunc);
    procedure InternalPack4(const IsEmpty: TInternalEmptyFunc);
    procedure InternalPack8(const IsEmpty: TInternalEmptyFunc);
    procedure InternalPackN(const IsEmpty: TInternalEmptyFunc);
    procedure InternalPackManaged(const IsEmpty: TInternalEmptyFunc);
    function InternalRemove1(const Value; Direction: Byte): Integer; inline;
    function InternalRemove2(const Value; Direction: Byte): Integer; inline;
    function InternalRemove4(const Value; Direction: Byte): Integer; inline;
    function InternalRemove8(const Value; Direction: Byte): Integer; inline;
    function InternalRemoveN(const Value; Direction: Byte): Integer; inline;
    function InternalRemoveMRef(const Value; Direction: Byte): Integer; inline;
    function InternalRemoveManaged(const Value; Direction: Byte): Integer; inline;
{$IF Defined(WEAKREF)}
    function InternalRemoveWeak(const Value; Direction: Byte): Integer; inline;
{$ENDIF}
    procedure InternalReverse1;
    procedure InternalReverse2;
    procedure InternalReverse4;
    procedure InternalReverse8;
    procedure InternalReverseN;
    procedure InternalReverseMRef(Kind: TTypeKind); inline;
    procedure InternalReverseManaged;
    procedure InternalToArray(var Dest: Pointer);
    procedure InternalToArrayManaged(var Dest: Pointer);
    property FItems: PPointer read GetFItems;
    property ElType: Pointer read GetElType;
    property ElSize: Integer read GetElSize;
  end;

  TList<T> = class(TEnumerable<T>)
  private type
    arrayofT = array of T;
  var
    FListHelper: TListHelper; // FListHelper must always be followed by FItems
    FItems: arrayofT; // FItems must always be preceded by FListHelper
    FComparer: IComparer<T>;
    FOnNotify: TCollectionNotifyEvent<T>;

    function GetCapacity: Integer; inline;
    procedure SetCapacity(Value: Integer); overload; inline;
    procedure SetCount(Value: Integer); inline;
    function GetItem(Index: Integer): T; inline;
    procedure SetItem(Index: Integer; const Value: T); inline;
    procedure GrowCheck(ACount: Integer); inline;
    procedure DoDelete(Index: Integer; Notification: TCollectionNotification); inline;
    procedure InternalNotify(const Item; Action: TCollectionNotification);
    function InternalCompare(const Left, Right): Integer;
    property FCount: Integer read FListHelper.FCount write FListHelper.FCount;
  protected
    function ItemValue(const Item: T): NativeInt;
    function DoGetEnumerator: TEnumerator<T>; override;
    procedure Notify(const Item: T; Action: TCollectionNotification); virtual;
  public
  type
    TDirection = System.Types.TDirection;
    TEmptyFunc = reference to function (const L, R: T): Boolean;
    TListCompareFunc = reference to function (const L, R: T): Integer;

    constructor Create; overload;
    constructor Create(const AComparer: IComparer<T>); overload;
    constructor Create(const Collection: TEnumerable<T>); overload;
    destructor Destroy; override;

    class procedure Error(const Msg: string; Data: NativeInt); overload; virtual;
{$IFNDEF NEXTGEN}
    class procedure Error(Msg: PResStringRec; Data: NativeInt); overload;
{$ENDIF  NEXTGEN}

    function Add(const Value: T): Integer; inline;

    procedure AddRange(const Values: array of T); overload;
    procedure AddRange(const Collection: IEnumerable<T>); overload; inline;
    procedure AddRange(const Collection: TEnumerable<T>); overload; inline;

    procedure Insert(Index: Integer; const Value: T); inline;

    procedure InsertRange(Index: Integer; const Values: array of T); overload;
    procedure InsertRange(Index: Integer; const Collection: IEnumerable<T>); overload;
    procedure InsertRange(Index: Integer; const Collection: TEnumerable<T>); overload;

    procedure Pack; overload;
    procedure Pack(const IsEmpty: TEmptyFunc); overload;

    function Remove(const Value: T): Integer; inline;
    function RemoveItem(const Value: T; Direction: TDirection): Integer; inline;
    procedure Delete(Index: Integer); inline;
    procedure DeleteRange(AIndex, ACount: Integer); inline;
    function ExtractItem(const Value: T; Direction: TDirection): T; inline;
    function Extract(const Value: T): T; inline;

    procedure Exchange(Index1, Index2: Integer); inline;
    procedure Move(CurIndex, NewIndex: Integer); inline;

    function First: T; inline;
    function Last: T; inline;

    procedure Clear; inline;

    function Expand: TList<T>; inline;

    function Contains(const Value: T): Boolean; inline;
    function IndexOf(const Value: T): Integer; inline;
    function IndexOfItem(const Value: T; Direction: TDirection): Integer; inline;
    function LastIndexOf(const Value: T): Integer; inline;

    procedure Reverse; inline;

    procedure Sort; overload;
    procedure Sort(const AComparer: IComparer<T>); overload;
    function BinarySearch(const Item: T; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: T; out Index: Integer; const AComparer: IComparer<T>): Boolean; overload;
    
    procedure TrimExcess; inline;

    function ToArray: TArray<T>; override; final;

    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read FListHelper.FCount write SetCount;
    property Items[Index: Integer]: T read GetItem write SetItem; default;
    property List: arrayofT read FItems;

    property OnNotify: TCollectionNotifyEvent<T> read FOnNotify write FOnNotify;

    type
      TEnumerator = class(TEnumerator<T>)
      private
        FList: TList<T>;
        FIndex: Integer;
        function GetCurrent: T;
      protected
        function DoGetCurrent: T; override;
        function DoMoveNext: Boolean; override;
      public
        constructor Create(const AList: TList<T>);
        property Current: T read GetCurrent;
        function MoveNext: Boolean;
      end;

    function GetEnumerator: TEnumerator; reintroduce; inline;
  end;

  TThreadList<T> = class
  private
    FList: TList<T>;
    FLock: TObject;
    FDuplicates: TDuplicates;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const Item: T);
    procedure Clear;
    function LockList: TList<T>;
    procedure Remove(const Item: T); inline;
    procedure RemoveItem(const Item: T; Direction: TDirection);
    procedure UnlockList; inline;
    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
  end;

  TQueueHelper = record
  private
    FHead, FTail: Integer;
    FLH: TListHelper;
    procedure DynArraySetLength(Value: NativeInt); inline;
    function GetFItems: PPointer; inline;
    function GetElType: Pointer; inline;
    function GetElSize: Integer; inline;
    function GetNewCap: Integer; inline;
    procedure CheckEmpty; inline;
    procedure DequeueAdjust(Notification: TCollectionNotification; const Item); inline;
    procedure InternalDequeueString(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDequeueInterface(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDequeueDynArray(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDequeueByteString(Notification: TCollectionNotification; Peek: Boolean; out Item);
{$IF not Defined(NEXTGEN)}
    procedure InternalDequeueWideString(Notification: TCollectionNotification; Peek: Boolean; out Item);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure InternalDequeueObject(Notification: TCollectionNotification; Peek: Boolean; out Item);
{$ENDIF}
    procedure InternalDequeue1(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDequeue2(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDequeue4(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDequeue8(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDequeueN(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDequeueMRef(Notification: TCollectionNotification; Peek: Boolean; out Item; Kind: TTypeKind); inline;
    procedure InternalDequeueManaged(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalClearString;
    procedure InternalClearInterface;
    procedure InternalClearDynArray;
    procedure InternalClearByteString;
{$IF not Defined(NEXTGEN)}
    procedure InternalClearWideString;
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure InternalClearObject;
{$ENDIF}
    procedure InternalClear1;
    procedure InternalClear2;
    procedure InternalClear4;
    procedure InternalClear8;
    procedure InternalClearN;
    procedure InternalClearMRef(Kind: TTypeKind); inline;
    procedure InternalClearManaged;
    procedure EnqueueAdjust(const Value); inline;
    procedure InternalEnqueueString(const Value);
    procedure InternalEnqueueInterface(const Value);
    procedure InternalEnqueueByteString(const Value);
    procedure InternalEnqueueDynArray(const Value);
{$IF not Defined(NEXTGEN)}
    procedure InternalEnqueueWideString(const Value);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure InternalEnqueueObject(const Value);
{$ENDIF}
    procedure InternalEnqueue1(const Value);
    procedure InternalEnqueue2(const Value);
    procedure InternalEnqueue4(const Value);
    procedure InternalEnqueue8(const Value);
    procedure InternalEnqueueN(const Value);
    procedure InternalEnqueueMRef(const Value; Kind: TTypeKind); inline;
    procedure InternalEnqueueManaged(const Value);
    procedure InternalGrow1;
    procedure InternalGrow2;
    procedure InternalGrow4;
    procedure InternalGrow8;
    procedure InternalGrowN;
    procedure InternalGrowMRef;
    procedure InternalGrowManaged;
    procedure InternalSetCapacityInline(Value: Integer; ElemSize: Integer); inline;
    procedure InternalSetCapacity1(Value: Integer);
    procedure InternalSetCapacity2(Value: Integer);
    procedure InternalSetCapacity4(Value: Integer);
    procedure InternalSetCapacity8(Value: Integer);
    procedure InternalSetCapacityN(Value: Integer);
    procedure InternalSetCapacityMRef(Value: Integer);
    procedure InternalSetCapacityManaged(Value: Integer);
    property FItems: PPointer read GetFItems;
    property ElType: Pointer read GetElType;
    property ElSize: Integer read GetElSize;
  end;

  // Queue implemented over array, using wrapping.
  TQueue<T> = class(TEnumerable<T>)
  private type
    arrayOfT = array of T;
  private
    FQueueHelper: TQueueHelper; // FQueueHelper must always be followed by FItems
    FItems: arrayOfT; // FItems must always be preceded by FListHelper
    FOnNotify: TCollectionNotifyEvent<T>;
    procedure SetCapacity(Value: Integer); inline;
    function DoDequeue(Notification: TCollectionNotification): T; inline;
    procedure DoSetCapacity(Value: Integer); inline;
    function GetCapacity: Integer; inline;
    procedure InternalNotify(const Item; Action: TCollectionNotification);
    function InternalCompare(const Left, Right): Integer;
  protected
    function DoGetEnumerator: TEnumerator<T>; override;
    procedure Notify(const Item: T; Action: TCollectionNotification); virtual;
  public
    constructor Create; overload;
    constructor Create(const Collection: TEnumerable<T>); overload;
    destructor Destroy; override;
    procedure Enqueue(const Value: T); inline;
    function Dequeue: T; inline;
    function Extract: T; inline;
    function Peek: T; inline;
    procedure Clear; inline;
    procedure TrimExcess; inline;
    property Count: Integer read FQueueHelper.FLH.FCount;
    property Capacity: Integer read GetCapacity write DoSetCapacity;
    property OnNotify: TCollectionNotifyEvent<T> read FOnNotify write FOnNotify;
    function ToArray: TArray<T>; override; final;

    type
      TEnumerator = class(TEnumerator<T>)
      private
        FQueue: TQueue<T>;
        FIndex: Integer;
        function GetCurrent: T;
      protected
        function DoGetCurrent: T; override;
        function DoMoveNext: Boolean; override;
      public
        constructor Create(const AQueue: TQueue<T>);
        property Current: T read GetCurrent;
        function MoveNext: Boolean;
      end;
    
    function GetEnumerator: TEnumerator; reintroduce;
  end;
  
  TStackHelper = record
  private
    FLH: TListHelper;
    function GetFItems: PPointer; inline;
    function GetElType: Pointer; inline;
    function GetElSize: Integer; inline;
    procedure CheckEmpty; inline;
    procedure CheckGrow; inline;
    procedure InternalGrow;
    procedure InternalSetCapacity(Value: Integer);
    procedure PopAdjust(const Value; Notification: TCollectionNotification); inline;
    procedure InternalDoPopString(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDoPopInterface(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDoPopDynArray(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDoPopByteString(Notification: TCollectionNotification; Peek: Boolean; out Item);
{$IF not Defined(NEXTGEN)}
    procedure InternalDoPopWideString(Notification: TCollectionNotification; Peek: Boolean; out Item);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure InternalDoPopObject(Notification: TCollectionNotification; Peek: Boolean; out Item);
{$ENDIF}
    procedure InternalDoPop1(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDoPop2(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDoPop4(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDoPop8(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDoPopN(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalDoPopMRef(Notification: TCollectionNotification; Peek: Boolean; out Item; Kind: TTypeKind); inline;
    procedure InternalDoPopManaged(Notification: TCollectionNotification; Peek: Boolean; out Item);
    procedure InternalClearString;
    procedure InternalClearInterface;
    procedure InternalClearDynArray;
    procedure InternalClearByteString;
{$IF not Defined(NEXTGEN)}
    procedure InternalClearWideString;
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure InternalClearObject;
{$ENDIF}
    procedure InternalClear1;
    procedure InternalClear2;
    procedure InternalClear4;
    procedure InternalClear8;
    procedure InternalClearN;
    procedure InternalClearMRef(Kind: TTypeKind); inline;
    procedure InternalClearManaged;
    procedure PushAdjust(const Value); inline;
    procedure InternalPushString(const Value);
    procedure InternalPushInterface(const Value);
    procedure InternalPushDynArray(const Value);
    procedure InternalPushByteString(const Value);
{$IF not Defined(NEXTGEN)}
    procedure InternalPushWideString(const Value);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    procedure InternalPushObject(const Value);
{$ENDIF}
    procedure InternalPush1(const Value);
    procedure InternalPush2(const Value);
    procedure InternalPush4(const Value);
    procedure InternalPush8(const Value);
    procedure InternalPushN(const Value);
    procedure InternalPushMRef(const Value; Kind: TTypeKind); inline;
    procedure InternalPushManaged(const Value);
    property FItems: PPointer read GetFItems;
    property ElType: Pointer read GetElType;
    property ElSize: Integer read GetElSize;
  end;

  TStack<T> = class(TEnumerable<T>)
  private type
    arrayOfT = array of T;
  private
    FStackHelper: TStackHelper;
    FItems: arrayOfT;
    FOnNotify: TCollectionNotifyEvent<T>;
    function DoPop(Notification: TCollectionNotification): T; inline;
    procedure DoSetCapacity(Value: Integer); inline;
    function GetCapacity: Integer; inline;
    procedure InternalNotify(const Item; Action: TCollectionNotification);
  protected
    function DoGetEnumerator: TEnumerator<T>; override;
    procedure Notify(const Item: T; Action: TCollectionNotification); virtual;
  public
    constructor Create; overload;
    constructor Create(const Collection: TEnumerable<T>); overload;
    destructor Destroy; override;
    procedure Clear; inline;
    procedure Push(const Value: T); inline;
    function Pop: T; inline;
    function Peek: T; inline;
    function Extract: T; inline;
    procedure TrimExcess; inline;
    function ToArray: TArray<T>; override; final;
    property Count: Integer read FStackHelper.FLH.FCount;
    property Capacity: Integer read GetCapacity write DoSetCapacity;
    property OnNotify: TCollectionNotifyEvent<T> read FOnNotify write FOnNotify;

    type
      TEnumerator = class(TEnumerator<T>)
      private
        FStack: TStack<T>;
        FIndex: Integer;
        function GetCurrent: T;
      protected
        function DoGetCurrent: T; override;
        function DoMoveNext: Boolean; override;
      public
        constructor Create(const AStack: TStack<T>);
        property Current: T read GetCurrent;
        function MoveNext: Boolean;
      end;

    function GetEnumerator: TEnumerator; reintroduce;
  end;

  (*$HPPEMIT END OPENNAMESPACE*)
  (*$HPPEMIT END '  template<typename TKey, typename TValue>'*)
  (*$HPPEMIT END '  inline __fastcall TPair__2<TKey, TValue>::TPair__2(const TKey AKey, const TValue AValue) :'*)
  (*$HPPEMIT END '                                            Key(AKey), Value(AValue)'*)
  (*$HPPEMIT END '  {}'*)
  (*$HPPEMIT END CLOSENAMESPACE*)
  [HPPGEN(HPPGenAttribute.mkNonPackage)]
  TPair<TKey,TValue> = record
    Key: TKey;
    Value: TValue;
    constructor Create(const AKey: TKey; const AValue: TValue);
  end;

  // Hash table using linear probing
  TDictionary<TKey,TValue> = class(TEnumerable<TPair<TKey,TValue>>)
  private
    type
    TItem = record
      HashCode: Integer;
      Key: TKey;
      Value: TValue;
    end;
    TItemArray = array of TItem;
    private
    FItems: TItemArray;
    FCount: Integer;
      FComparer: IEqualityComparer<TKey>;
    FGrowThreshold: Integer;

    procedure SetCapacity(ACapacity: Integer);
    procedure Rehash(NewCapPow2: Integer);
    procedure Grow;
    function GetBucketIndex(const Key: TKey; HashCode: Integer): Integer;
    function Hash(const Key: TKey): Integer;
    function GetItem(const Key: TKey): TValue;
    procedure SetItem(const Key: TKey; const Value: TValue);
    procedure RehashAdd(HashCode: Integer; const Key: TKey; const Value: TValue);
    procedure DoAdd(HashCode, Index: Integer; const Key: TKey; const Value: TValue);
    procedure DoSetValue(Index: Integer; const Value: TValue);
    function DoRemove(const Key: TKey; HashCode: Integer; Notification: TCollectionNotification): TValue;
  protected
    function DoGetEnumerator: TEnumerator<TPair<TKey,TValue>>; override;
    procedure KeyNotify(const Key: TKey; Action: TCollectionNotification); virtual;
    procedure ValueNotify(const Value: TValue; Action: TCollectionNotification); virtual;
  public
    constructor Create(ACapacity: Integer = 0); overload;
    constructor Create(const AComparer: IEqualityComparer<TKey>); overload;
    constructor Create(ACapacity: Integer; const AComparer: IEqualityComparer<TKey>); overload;
    constructor Create(const Collection: TEnumerable<TPair<TKey,TValue>>); overload;
    constructor Create(const Collection: TEnumerable<TPair<TKey,TValue>>; const AComparer: IEqualityComparer<TKey>); overload;
    destructor Destroy; override;
    
    procedure Add(const Key: TKey; const Value: TValue);
    procedure Remove(const Key: TKey);
    function ExtractPair(const Key: TKey): TPair<TKey,TValue>;
    procedure Clear;
    procedure TrimExcess;
    function TryGetValue(const Key: TKey; out Value: TValue): Boolean;
    procedure AddOrSetValue(const Key: TKey; const Value: TValue);
    function ContainsKey(const Key: TKey): Boolean;
    function ContainsValue(const Value: TValue): Boolean;
    function ToArray: TArray<TPair<TKey,TValue>>; override; final;
    
    property Items[const Key: TKey]: TValue read GetItem write SetItem; default;
    property Count: Integer read FCount;
    
    type
      TPairEnumerator = class(TEnumerator<TPair<TKey,TValue>>)
      private
        FDictionary: TDictionary<TKey,TValue>;
        FIndex: Integer;
        function GetCurrent: TPair<TKey,TValue>;
      protected
        function DoGetCurrent: TPair<TKey,TValue>; override;
        function DoMoveNext: Boolean; override;
      public
        constructor Create(const ADictionary: TDictionary<TKey,TValue>);
        property Current: TPair<TKey,TValue> read GetCurrent;
        function MoveNext: Boolean;
      end;

      TKeyEnumerator = class(TEnumerator<TKey>)
      private
        FDictionary: TDictionary<TKey,TValue>;
        FIndex: Integer;
        function GetCurrent: TKey;
      protected
        function DoGetCurrent: TKey; override;
        function DoMoveNext: Boolean; override;
      public
        constructor Create(const ADictionary: TDictionary<TKey,TValue>);
        property Current: TKey read GetCurrent;
        function MoveNext: Boolean;
      end;

      TValueEnumerator = class(TEnumerator<TValue>)
      private
        FDictionary: TDictionary<TKey,TValue>;
        FIndex: Integer;
        function GetCurrent: TValue;
      protected
        function DoGetCurrent: TValue; override;
        function DoMoveNext: Boolean; override;
      public
        constructor Create(const ADictionary: TDictionary<TKey,TValue>);
        property Current: TValue read GetCurrent;
        function MoveNext: Boolean;
      end;

      TValueCollection = class(TEnumerable<TValue>)
      private
        [Weak] FDictionary: TDictionary<TKey,TValue>;
        function GetCount: Integer;
      protected
        function DoGetEnumerator: TEnumerator<TValue>; override;
      public
        constructor Create(const ADictionary: TDictionary<TKey,TValue>);
        function GetEnumerator: TValueEnumerator; reintroduce;
        function ToArray: TArray<TValue>; override; final;
        property Count: Integer read GetCount;
      end;

      TKeyCollection = class(TEnumerable<TKey>)
      private
        [Weak] FDictionary: TDictionary<TKey,TValue>;
        function GetCount: Integer;
      protected
        function DoGetEnumerator: TEnumerator<TKey>; override;
      public
        constructor Create(const ADictionary: TDictionary<TKey,TValue>);
        function GetEnumerator: TKeyEnumerator; reintroduce;
        function ToArray: TArray<TKey>; override; final;
        property Count: Integer read GetCount;
      end;
      
  private
    FOnKeyNotify: TCollectionNotifyEvent<TKey>;
    FOnValueNotify: TCollectionNotifyEvent<TValue>;
    FKeyCollection: TKeyCollection;
    FValueCollection: TValueCollection;
    function GetKeys: TKeyCollection;
    function GetValues: TValueCollection;
  public
    function GetEnumerator: TPairEnumerator; reintroduce;
    property Keys: TKeyCollection read GetKeys;
    property Values: TValueCollection read GetValues;
    property OnKeyNotify: TCollectionNotifyEvent<TKey> read FOnKeyNotify write FOnKeyNotify;
    property OnValueNotify: TCollectionNotifyEvent<TValue> read FOnValueNotify write FOnValueNotify;
  end;
  
  TObjectList<T: class> = class(TList<T>)
  private
    FOwnsObjects: Boolean;
  protected
    procedure Notify(const Value: T; Action: TCollectionNotification); override;
  public
    constructor Create(AOwnsObjects: Boolean = True); overload;
    constructor Create(const AComparer: IComparer<T>; AOwnsObjects: Boolean = True); overload;
    constructor Create(const Collection: TEnumerable<T>; AOwnsObjects: Boolean = True); overload;
    destructor Destroy; override;
    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;
  end;

  TObjectQueue<T: class> = class(TQueue<T>)
  private
    FOwnsObjects: Boolean;
  protected
    procedure Notify(const Value: T; Action: TCollectionNotification); override;
  public
    constructor Create(AOwnsObjects: Boolean = True); overload;
    constructor Create(const Collection: TEnumerable<T>; AOwnsObjects: Boolean = True); overload;
    procedure Dequeue;
    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;
  end;

  TObjectStack<T: class> = class(TStack<T>)
  private
    FOwnsObjects: Boolean;
  protected
    procedure Notify(const Value: T; Action: TCollectionNotification); override;
  public
    constructor Create(AOwnsObjects: Boolean = True); overload;
    constructor Create(const Collection: TEnumerable<T>; AOwnsObjects: Boolean = True); overload;
    procedure Pop;
    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;
  end;

  TDictionaryOwnerships = set of (doOwnsKeys, doOwnsValues);

  TObjectDictionary<TKey,TValue> = class(TDictionary<TKey,TValue>)
  private
    FOwnerships: TDictionaryOwnerships;
  protected
    procedure KeyNotify(const Key: TKey; Action: TCollectionNotification); override;
    procedure ValueNotify(const Value: TValue; Action: TCollectionNotification); override;
  public
    constructor Create(Ownerships: TDictionaryOwnerships; ACapacity: Integer = 0); overload;
    constructor Create(Ownerships: TDictionaryOwnerships;
      const AComparer: IEqualityComparer<TKey>); overload;
    constructor Create(Ownerships: TDictionaryOwnerships; ACapacity: Integer;
      const AComparer: IEqualityComparer<TKey>); overload;
  end;
  
  TThreadedQueue<T> = class
  private
    FQueue: array of T;
    FQueueSize, FQueueOffset: Integer;
    FQueueNotEmpty,
    FQueueNotFull: TObject;
    FQueueLock: TObject;
    FShutDown: Boolean;
    FPushTimeout, FPopTimeout: LongWord;
    FTotalItemsPushed, FTotalItemsPopped: LongWord;
  public
    constructor Create(AQueueDepth: Integer = 10; PushTimeout: LongWord = INFINITE; PopTimeout: LongWord = INFINITE);
    destructor Destroy; override;

    procedure Grow(ADelta: Integer);
    function PushItem(const AItem: T): TWaitResult; overload;
    function PushItem(const AItem: T; var AQueueSize: Integer): TWaitResult; overload;
    function PopItem: T; overload;
    function PopItem(var AQueueSize: Integer): T; overload;
    function PopItem(var AQueueSize: Integer; var AItem: T): TWaitResult; overload;
    function PopItem(var AItem: T): TWaitResult; overload;
    procedure DoShutDown;

    property QueueSize: Integer read FQueueSize;
    property ShutDown: Boolean read FShutDown;
    property TotalItemsPushed: LongWord read FTotalItemsPushed;
    property TotalItemsPopped: LongWord read FTotalItemsPopped;
  end;

  PObject = ^TObject;

function InCircularRange(Bottom, Item, TopInc: Integer): Boolean; inline;

implementation

uses System.Variants, System.TypInfo, System.SysConst, System.RTLConsts;

{ TArray }

class function TArray.BinarySearch<T>(const Values: array of T; const Item: T;
  out FoundIndex: Integer; const Comparer: IComparer<T>; Index,
  Count: Integer): Boolean;
var
  L, H: Integer;
  mid, cmp: Integer;
begin
  if (Index < Low(Values)) or ((Index > High(Values)) and (Count > 0))
    or (Index + Count - 1 > High(Values)) or (Count < 0)
    or (Index + Count < 0) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Count = 0 then
  begin
    FoundIndex := Index;
    Exit(False);
  end;
  
  Result := False;
  L := Index;
  H := Index + Count - 1;
  while L <= H do
  begin
    mid := L + (H - L) shr 1;
    cmp := Comparer.Compare(Values[mid], Item);
    if cmp < 0 then
      L := mid + 1
    else
    begin
      H := mid - 1;
      if cmp = 0 then
        Result := True;
    end;
  end;
  FoundIndex := L;
end;

class function TArray.BinarySearch<T>(const Values: array of T; const Item: T;
  out FoundIndex: Integer; const Comparer: IComparer<T>): Boolean;
begin
  Result := BinarySearch<T>(Values, Item, FoundIndex, Comparer,
    Low(Values), Length(Values));
end;

class function TArray.BinarySearch<T>(const Values: array of T; const Item: T;
  out FoundIndex: Integer): Boolean;
begin
  Result := BinarySearch<T>(Values, Item, FoundIndex, TComparer<T>.Default, 
    Low(Values), Length(Values));
end;

class procedure TArray.Copy<T>(const Source: array of T; var Destination: array of T; SourceIndex, DestIndex, Count: NativeInt);
begin
  CheckArrays(Pointer(@Source[0]), Pointer(@Destination[0]), SourceIndex, Length(Source), DestIndex, Length(Destination), Count);
  if IsManagedType(T) then
    System.CopyArray(Pointer(@Destination[DestIndex]), Pointer(@Source[SourceIndex]), TypeInfo(T), Count)
  else
    System.Move(Pointer(@Source[SourceIndex])^, Pointer(@Destination[DestIndex])^, Count * SizeOf(T));
end;

class procedure TArray.CheckArrays(Source, Destination: Pointer; SourceIndex, SourceLength, DestIndex, DestLength, Count: NativeInt);
begin
  if (SourceIndex < 0) or (DestIndex < 0) or (SourceIndex >= SourceLength) or (DestIndex >= DestLength) or
     (SourceIndex + Count > SourceLength) or (DestIndex + Count > DestLength) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Source = Destination then
    raise EArgumentException.CreateRes(@sSameArrays);
end;

class procedure TArray.Copy<T>(const Source: array of T; var Destination: array of T; Count: NativeInt);
begin
  Copy<T>(Source, Destination, 0, 0, Count);
end;

class procedure TArray.QuickSort<T>(var Values: array of T; const Comparer: IComparer<T>;
  L, R: Integer);
var
  I, J: Integer;
  pivot, temp: T;
begin
  if (Length(Values) = 0) or ((R - L) <= 0) then
    Exit;
  repeat
    I := L;
    J := R;
    pivot := Values[L + (R - L) shr 1];
    repeat
      while Comparer.Compare(Values[I], pivot) < 0 do
        Inc(I);
      while Comparer.Compare(Values[J], pivot) > 0 do
        Dec(J);
      if I <= J then
      begin
        if I <> J then
        begin
          temp := Values[I];
          Values[I] := Values[J];
          Values[J] := temp;
        end;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort<T>(Values, Comparer, L, J);
    L := I;
  until I >= R;
end;

class procedure TArray.Sort<T>(var Values: array of T);
begin
  QuickSort<T>(Values, TComparer<T>.Default, Low(Values), High(Values));
end;

class procedure TArray.Sort<T>(var Values: array of T; const Comparer: IComparer<T>);
begin
  QuickSort<T>(Values, Comparer, Low(Values), High(Values));
end;

class procedure TArray.Sort<T>(var Values: array of T; const Comparer: IComparer<T>;
  Index, Count: Integer);
begin
  if (Index < Low(Values)) or ((Index > High(Values)) and (Count > 0))
    or (Index + Count - 1 > High(Values)) or (Count < 0)
    or (Index + Count < 0) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Count <= 1 then
    Exit;
  QuickSort<T>(Values, Comparer, Index, Index + Count - 1);
end;

{ TListHelper }

type
  TLocalDynArray = packed record
  {$IFDEF CPU64BITS}
    _Padding: Integer; // Make 16 byte align for payload..
  {$ENDIF}
    RefCnt: Integer;
    Length: NativeInt;
    Data: array[0..1023] of Byte;
  end;

{$POINTERMATH ON}

procedure CopyArray(Dest, Source, TypeInfo: Pointer; ElemSize: Integer; Count: NativeInt);
begin
  if Count > 0 then
    if PByte(Dest) > PByte(Source) then
    begin
      Dest := PByte(Dest) + (Count - 1) * ElemSize;
      Source := PByte(Source) + (Count - 1) * ElemSize;
      while Count > 0 do
      begin
        System.CopyArray(Dest, Source, TypeInfo, 1);
        Dec(PByte(Dest), ElemSize);
        Dec(PByte(Source), ElemSize);
        Dec(Count);
      end;
    end else
      System.CopyArray(Dest, Source, TypeInfo, Count);
end;

function TListHelper.GetElSize: Integer;
begin
  Result := PDynArrayTypeInfo(PByte(FTypeInfo) + PDynArrayTypeInfo(FTypeInfo).name).elSize;
end;

function TListHelper.GetElType: Pointer;
begin
  Result := PDynArrayTypeInfo(PByte(FTypeInfo) + PDynArrayTypeInfo(FTypeInfo).name).elType^;
end;

function TListHelper.GetFItems: PPointer;
begin
  Result := PPointer(PByte(@Self) + SizeOf(Self));
end;

function TListHelper.CheckDeleteRange(AIndex, ACount: Integer): Boolean;
begin
  if (AIndex < 0) or (ACount < 0) or (AIndex + ACount > FCount) or (AIndex + ACount < 0) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  Result := ACount > 0;
end;

procedure TListHelper.CheckItemRangeInline(AIndex: Integer);
begin
  if (AIndex < 0) or (AIndex >= FCount) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
end;

procedure TListHelper.CheckInsertRange(AIndex: Integer);
begin
  if (AIndex < 0) or (AIndex > FCount) then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
end;

procedure TListHelper.CheckItemRange(AIndex: Integer);
begin
  CheckItemRangeInline(AIndex);
end;

procedure TListHelper.SetItem1(const Value; AIndex: Integer);
var
  OldItem: Byte;
begin
  CheckItemRangeInline(AIndex);

  OldItem := PByte(FItems^)[AIndex];
  PByte(FItems^)[AIndex] := Byte(Value);

  FNotify(OldItem, cnRemoved);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.SetItem2(const Value; AIndex: Integer);
var
  OldItem: Word;
begin
  CheckItemRangeInline(AIndex);

  OldItem := PWord(FItems^)[AIndex];
  PWord(FItems^)[AIndex] := Word(Value);

  FNotify(OldItem, cnRemoved);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.SetItem4(const Value; AIndex: Integer);
var
  OldItem: Cardinal;
begin
  CheckItemRangeInline(AIndex);

  OldItem := PCardinal(FItems^)[AIndex];
  PCardinal(FItems^)[AIndex] := Cardinal(Value);

  FNotify(OldItem, cnRemoved);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.SetItem8(const Value; AIndex: Integer);
var
  OldItem: UInt64;
begin
  CheckItemRangeInline(AIndex);

  OldItem := PUInt64(FItems^)[AIndex];
  PUInt64(FItems^)[AIndex] := UInt64(Value);

  FNotify(OldItem, cnRemoved);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.DoSetItemDynArray(const Value; AIndex: Integer);
type
  PBytes = ^TBytes;
var
  OldItem: Pointer;
begin
  OldItem := nil;
  try
    CheckItemRangeInline(AIndex);

    // Yes, this is "safe" to do without actually knowing the true dynamic array type for the assignments.
    // The first assignment is to a nil reference, so all that happens is the source array's reference count
    // is incremented. At this point I know that there are at least two references to the source array, so I
    // know that the second assignment won't try and deallocate the array. After the second assignment, the
    // old array reference will have at least 1 refcount.
    TBytes(OldItem) := PBytes(FItems^)[AIndex];
    PBytes(FItems^)[AIndex] := TBytes(Value);

    FNotify(OldItem, cnRemoved);
    FNotify(Value, cnAdded);
  finally
    // Here we do care about the type of the dynamic array since it is likely that the array will need to be
    // finalized. If the reference count of the array is 1, it will be properly freed here. If it is > 1, then
    // this will merely drop the local OldItem reference and set it to nil.
    // NOTE:  TBytes(OldItem) := nil; CANNOT be used here since that would pass in the type info for TBytes
    // into _DynArrayClear instead of the actual dynamic array type. Explicitly call DynArrayClear.
    DynArrayClear(OldItem, FTypeInfo);
  end;
end;

procedure TListHelper.DoSetItemInterface(const Value; AIndex: Integer);
var
  OldItem: IInterface;
begin
  CheckItemRangeInline(AIndex);

  OldItem := PInterface(FItems^)[AIndex];
  PInterface(FItems^)[AIndex] := IInterface(Value);

  FNotify(OldItem, cnRemoved);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.SetItemManaged(const Value; AIndex: Integer);
var
  SOldItem: array[0..63] of Byte;
  DOldItem: PByte;
  POldItem: PByte;
  ElemSize: Integer;
begin
  CheckItemRangeInline(AIndex);

  DOldItem := nil;
  POldItem := @SOldItem;
  FillChar(SOldItem, SizeOf(SOldItem), 0);
  try
    ElemSize := ElSize;
    if ElemSize > SizeOf(SOldItem) then
    begin
      DOldItem := AllocMem(ElemSize);
      POldItem := DOldItem;
    end;
    System.CopyArray(POldItem, PByte(FItems^) + (AIndex * ElemSize), ElType, 1); // oldItem := FItems[Index];
    System.CopyArray(PByte(FItems^) + (AIndex * ElemSize), @Value, ElType, 1); // FItems[Index] := Value;

    FNotify(POldItem[0], cnRemoved);
    FNotify(Value, cnAdded);
  finally
    FinalizeArray(POldItem, ElType, 1);
    FreeMem(DOldItem);
  end;
end;

procedure TListHelper.SetItemN(const Value; AIndex: Integer);
var
  SOldItem: array[0..64] of Byte;
  DOldItem: PByte;
  POldItem: PByte;
  ElemSize: Integer;
begin
  CheckItemRangeInline(AIndex);

  DOldItem := nil;
  POldItem := @SOldItem[0];
  try
    ElemSize := ElSize;
    if ElemSize > SizeOf(SOldItem) then
    begin
      GetMem(DOldItem, ElemSize);
      POldItem := DOldItem;
    end;
    Move(PByte(FItems^)[AIndex * ElemSize], POldItem[0], ElemSize);
    Move(Value, PByte(FItems^)[AIndex * ElemSize], ElemSize);

    FNotify(POldItem[0], cnRemoved);
    FNotify(Value, cnAdded);
  finally
    FreeMem(DOldItem);
  end;
end;

procedure TListHelper.DoSetItemString(const Value; AIndex: Integer);
var
  OldItem: string;
begin
  CheckItemRangeInline(AIndex);

  OldItem := PString(FItems^)[AIndex];
  PString(FItems^)[AIndex] := string(Value);

  FNotify(OldItem, cnRemoved);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.InternalExchange1(Index1, Index2: Integer);
var
  Temp: Byte;
begin
  Temp := PByte(FItems^)[Index1];
  PByte(FItems^)[Index1] := PByte(FItems^)[Index2];
  PByte(FItems^)[Index2] := Temp;
end;

procedure TListHelper.InternalExchange2(Index1, Index2: Integer);
var
  Temp: Word;
begin
  Temp := PWord(FItems^)[Index1];
  PWord(FItems^)[Index1] := PWord(FItems^)[Index2];
  PWord(FItems^)[Index2] := Temp;
end;

procedure TListHelper.InternalExchange4(Index1, Index2: Integer);
var
  Temp: Cardinal;
begin
  Temp := PCardinal(FItems^)[Index1];
  PCardinal(FItems^)[Index1] := PCardinal(FItems^)[Index2];
  PCardinal(FItems^)[Index2] := Temp;
end;

procedure TListHelper.InternalExchange8(Index1, Index2: Integer);
var
  Temp: UInt64;
begin
  Temp := PUInt64(FItems^)[Index1];
  PUInt64(FItems^)[Index1] := PUInt64(FItems^)[Index2];
  PUInt64(FItems^)[Index2] := Temp;
end;

procedure TListHelper.InternalExchangeManaged(Index1, Index2: Integer);
var
  STemp: array[0..63] of Byte;
  DTemp: PByte;
  PTemp: PByte;
  ElemSize: Integer;
begin
  DTemp := nil;
  PTemp := @STemp;
  try
    ElemSize := ElSize;
    if ElemSize > SizeOf(STemp) then
    begin
      DTemp := AllocMem(ElemSize);
      PTemp := DTemp;
    end else
      FillChar(STemp, ElemSize, 0);
    System.CopyArray(@PTemp[0], @PByte(FItems^)[Index1 * ElemSize], ElType, 1);
    System.CopyArray(@PByte(FItems^)[Index1 * ElemSize], @PByte(FItems^)[Index2 * ElemSize], ElType, 1);
    System.CopyArray(@PByte(FItems^)[Index2 * ElemSize], @PTemp[0], ElType, 1);
  finally
    FinalizeArray(PTemp, ElType, 1);
    FreeMem(DTemp);
  end;
end;

procedure TListHelper.InternalExchangeMRef(Index1, Index2: Integer; Kind: TTypeKind);
begin
  case Kind of
    TTypeKind.tkUString: DoExchangeString(Index1, Index2);
    TTypeKind.tkInterface: DoExchangeInterface(Index1, Index2);
    TTypeKind.tkVariant: DoExchangeVariant(Index1, Index2);
    TTypeKind.tkDynArray: DoExchangeDynArray(Index1, Index2);
{$IF Defined(AUTOREFCOUNT)}
    TTypeKind.tkClass: DoExchangeObject(Index1, Index2);
{$ENDIF}
    TTypeKind.tkLString: DoExchangeByteString(Index1, Index2);
{$IF not Defined(NEXTGEN)}
    TTypeKind.tkWString: DoExchangeWideString(Index1, Index2);
{$ENDIF}
  end;
end;

procedure TListHelper.InternalExchangeN(Index1, Index2: Integer);
var
  STemp: array[0..63] of Byte;
  DTemp: PByte;
  PTemp: PByte;
  ElemSize: Integer;
begin
  DTemp := nil;
  PTemp := @STemp;
  try
    ElemSize := ElSize;
    if ElemSize > SizeOf(STemp) then
    begin
      GetMem(DTemp, ElemSize);
      PTemp := DTemp;
    end;
    Move(PByte(FItems^)[Index1 * ElemSize], PTemp[0], ElemSize);
    Move(PByte(FItems^)[Index2 * ElemSize], PByte(FItems^)[Index1 * ElemSize], ElemSize);
    Move(PTemp[0], PByte(FItems^)[Index2 * ElemSize], ElemSize);
  finally
    FreeMem(DTemp);
  end;
end;

procedure TListHelper.InternalExtractItem1(const Value; out Item; Direction: Byte);
begin
  if Direction = Byte(TDirection.FromBeginning) then
    DoExtractItemFwd1(Value, Item)
  else
    DoExtractItemRev1(Value, Item);
end;

procedure TListHelper.InternalExtractItem2(const Value; out Item; Direction: Byte);
begin
  if Direction = Byte(TDirection.FromBeginning) then
    DoExtractItemFwd2(Value, Item)
  else
    DoExtractItemRev2(Value, Item);
end;

procedure TListHelper.InternalExtractItem4(const Value; out Item; Direction: Byte);
begin
  if Direction = Byte(TDirection.FromBeginning) then
    DoExtractItemFwd4(Value, Item)
  else
    DoExtractItemRev4(Value, Item);
end;

procedure TListHelper.InternalExtractItem8(const Value; out Item; Direction: Byte);
begin
  if Direction = Byte(TDirection.FromBeginning) then
    DoExtractItemFwd8(Value, Item)
  else
    DoExtractItemRev8(Value, Item);
end;

procedure TListHelper.InternalExtractItemManaged(const Value; out Item; Direction: Byte);
begin
  if Direction = Byte(TDirection.FromBeginning) then
    DoExtractItemFwdManaged(Value, Item)
  else
    DoExtractItemRevManaged(Value, Item);
end;

procedure TListHelper.InternalExtractItemMRef(const Value; Kind: TTypeKind; out Item; Direction: Byte);
begin
  case Kind of
    TTypeKind.tkUString:
      if Direction = Byte(TDirection.FromBeginning) then
        DoExtractItemFwdString(Value, Item)
      else
        DoExtractItemRevString(Value, Item);
    TTypeKind.tkInterface:
      if Direction = Byte(TDirection.FromBeginning) then
        DoExtractItemFwdInterface(Value, Item)
      else
        DoExtractItemRevInterface(Value, Item);
    TTypeKind.tkString:
      if Direction = Byte(TDirection.FromBeginning) then
        DoExtractItemFwdByteString(Value, Item)
      else
        DoExtractItemRevByteString(Value, Item);
{$IF not Defined(NEXTGEN)}
    TTypeKind.tkWString:
      if Direction = Byte(TDirection.FromBeginning) then
        DoExtractItemFwdWideString(Value, Item)
      else
        DoExtractItemRevWideString(Value, Item);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    TTypeKind.tkClass:
      if Direction = Byte(TDirection.FromBeginning) then
        DoExtractItemFwdObject(Value, Item)
      else
        DoExtractItemRevObject(Value, Item);
{$ENDIF}
  end;
end;

procedure TListHelper.InternalExtractItemN(const Value; out Item; Direction: Byte);
begin
  if Direction = Byte(TDirection.FromBeginning) then
    DoExtractItemFwdN(Value, Item)
  else
    DoExtractItemRevN(Value, Item);
end;

procedure TListHelper.InternalExtractItemVariant(const Value; out Item; Direction: Byte);
begin
  if Direction = Byte(TDirection.FromBeginning) then
    DoExtractItemFwdVariant(Value, Item)
  else
    DoExtractItemRevVariant(Value, Item);
end;

procedure TListHelper.SetItemVariant(const Value; AIndex: Integer);
var
  OldItem: Variant;
begin
  CheckItemRangeInline(AIndex);

  OldItem := PVariant(FItems^)[AIndex];
  PVariant(FItems^)[AIndex] := Variant(Value);

  FNotify(OldItem, cnRemoved);
  FNotify(Value, cnAdded);
end;

{$IF Defined(AUTOREFCOUNT)}
procedure TListHelper.DoSetItemObject(const Value; AIndex: Integer);
var
  OldItem: TObject;
begin
  CheckItemRangeInline(AIndex);

  OldItem := PObject(FItems^)[AIndex];
  PObject(FItems^)[AIndex] := TObject(Value);

  FNotify(OldItem, cnRemoved);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.DoInsertObject(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PPointer(FItems^)[AIndex], PPointer(FItems^)[AIndex + 1], (FCount - AIndex) * SizeOf(Pointer));
  PPointer(FItems^)[AIndex] := nil;
  PObject(FItems^)[AIndex] := TObject(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.DoAddObject(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PObject(FItems^)[FCount] := TObject(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;
{$ENDIF}

procedure TListHelper.DoSetItemByteString(const Value; AIndex: Integer);
var
  OldItem: RawByteString;
begin
  CheckItemRangeInline(AIndex);

  OldItem := PRawByteString(FItems^)[AIndex];
  PRawByteString(FItems^)[AIndex] := RawByteString(Value);

  FNotify(OldItem, cnRemoved);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.DoInsertByteString(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PPointer(FItems^)[AIndex], PPointer(FItems^)[AIndex + 1], (FCount - AIndex) * SizeOf(Pointer));
  PPointer(FItems^)[AIndex] := nil;
  PRawByteString(FItems^)[AIndex] := RawByteString(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.DoAddByteString(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PRawByteString(FItems^)[FCount] := RawByteString(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

{$IF not Defined(NEXTGEN)}
procedure TListHelper.DoSetItemWideString(const Value; AIndex: Integer);
var
  OldItem: WideString;
begin
  CheckItemRangeInline(AIndex);

  OldItem := PWideString(FItems^)[AIndex];
  PWideString(FItems^)[AIndex] := WideString(Value);

  FNotify(OldItem, cnRemoved);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.DoInsertWideString(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PPointer(FItems^)[AIndex], PPointer(FItems^)[AIndex + 1], (FCount - AIndex) * SizeOf(Pointer));
  PPointer(FItems^)[AIndex] := nil;
  PWideString(FItems^)[AIndex] := WideString(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.DoAddWideString(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PWideString(FItems^)[FCount] := WideString(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;
{$ENDIF}

function TListHelper.DoAddDynArray(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PBytes(FItems^)[FCount] := TBytes(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.DoAddInterface(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PInterface(FItems^)[FCount] := IInterface(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.DoAddString(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PString(FItems^)[FCount] := string(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.DoExchangeInterfaceInline(Index1, Index2: Integer);
var
  Temp: IInterface;
begin
  Temp := PInterface(FItems^)[Index1];
  PInterface(FItems^)[Index1] := PInterface(FItems^)[Index2];
  PInterface(FItems^)[Index2] := Temp;
end;

procedure TListHelper.DoExchangeStringInline(Index1, Index2: Integer);
var
  Temp: string;
begin
  Temp := PString(FItems^)[Index1];
  PString(FItems^)[Index1] := PString(FItems^)[Index2];
  PString(FItems^)[Index2] := Temp;
end;

procedure TListHelper.DoExchangeVariantInline(Index1, Index2: Integer);
var
  Temp: Variant;
begin
  Temp := PVariant(FItems^)[Index1];
  PVariant(FItems^)[Index1] := PVariant(FItems^)[Index2];
  PVariant(FItems^)[Index2] := Temp;
end;

procedure TListHelper.DoExchangeDynArrayInline(Index1, Index2: Integer);
var
  Temp: TBytes;
begin
  Temp := PBytes(FItems^)[Index1];
  PBytes(FItems^)[Index1] := PBytes(FItems^)[Index2];
  PBytes(FItems^)[Index2] := Temp;
end;

procedure TListHelper.DoExchangeByteStringInline(Index1, Index2: Integer);
var
  Temp: RawByteString;
begin
  Temp := PRawByteString(FItems^)[Index1];
  PRawByteString(FItems^)[Index1] := PRawByteString(FItems^)[Index2];
  PRawByteString(FItems^)[Index2] := Temp;
end;

{$IF not Defined(NEXTGEN)}
procedure TListHelper.DoExchangeWideStringInline(Index1, Index2: Integer);
var
  Temp: WideString;
begin
  Temp := PWideString(FItems^)[Index1];
  PWideString(FItems^)[Index1] := PWideString(FItems^)[Index2];
  PWideString(FItems^)[Index2] := Temp;
end;
{$ENDIF}

{$IF Defined(AUTOREFCOUNT)}
procedure TListHelper.DoExchangeObjectInline(Index1, Index2: Integer);
var
  Temp: TObject;
begin
  Temp := PObject(FItems^)[Index1];
  PObject(FItems^)[Index1] := PObject(FItems^)[Index2];
  PObject(FItems^)[Index2] := Temp;
end;
{$ENDIF}

procedure TListHelper.DoExchangeInterface(Index1, Index2: Integer);
begin
  DoExchangeInterfaceInline(Index1, Index2);
end;

procedure TListHelper.DoExchangeString(Index1, Index2: Integer);
begin
  DoExchangeStringInline(Index1, Index2);
end;

procedure TListHelper.DoExchangeVariant(Index1, Index2: Integer);
begin
  DoExchangeVariantInline(Index1, Index2);
end;

procedure TListHelper.DoExchangeDynArray(Index1, Index2: Integer);
begin
  DoExchangeDynArrayInline(Index1, Index2);
end;

procedure TListHelper.DoExchangeByteString(Index1, Index2: Integer);
begin
  DoExchangeByteStringInline(Index1, Index2);
end;

{$IF not Defined(NEXTGEN)}
procedure TListHelper.DoExchangeWideString(Index1, Index2: Integer);
begin
  DoExchangeWideStringInline(Index1, Index2);
end;
{$ENDIF}

{$IF Defined(AUTOREFCOUNT)}
procedure TListHelper.DoExchangeObject(Index1, Index2: Integer);
begin
  DoExchangeObjectInline(Index1, Index2);
end;
{$ENDIF}

procedure TListHelper.DoExtractItemFwd1(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwd1(Value);
  if Index < 0 then
    Byte(Item) := 0
  else
  begin
    Byte(Item) := PByte(FItems^)[Index];
    InternalDoDelete1(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRev1(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRev1(Value);
  if Index < 0 then
    Byte(Item) := 0
  else
  begin
    Byte(Item) := PByte(FItems^)[Index];
    InternalDoDelete1(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemFwd2(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwd2(Value);
  if Index < 0 then
    Word(Item) := 0
  else
  begin
    Word(Item) := PWord(FItems^)[Index];
    InternalDoDelete2(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRev2(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRev2(Value);
  if Index < 0 then
    Word(Item) := 0
  else
  begin
    Word(Item) := PWord(FItems^)[Index];
    InternalDoDelete2(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemFwd4(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwd4(Value);
  if Index < 0 then
    Cardinal(Item) := 0
  else
  begin
    Cardinal(Item) := PCardinal(FItems^)[Index];
    InternalDoDelete4(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRev4(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRev4(Value);
  if Index < 0 then
    Cardinal(Item) := 0
  else
  begin
    Cardinal(Item) := PCardinal(FItems^)[Index];
    InternalDoDelete4(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemFwd8(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwd8(Value);
  if Index < 0 then
    UInt64(Item) := 0
  else
  begin
    UInt64(Item) := PUInt64(FItems^)[Index];
    InternalDoDelete8(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRev8(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRev8(Value);
  if Index < 0 then
    UInt64(Item) := 0
  else
  begin
    UInt64(Item) := PUInt64(FItems^)[Index];
    InternalDoDelete8(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemFwdN(const Value; out Item);
var
  Index, ElemSize: Integer;
begin
  Index := DoIndexOfFwdN(Value);
  ElemSize := ElSize;
  if Index < 0 then
    FillChar(Item, ElemSize, 0)
  else
  begin
    Move(PByte(FItems^)[Index * ElemSize], Item, ElemSize);
    InternalDoDeleteN(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRevN(const Value; out Item);
var
  Index, ElemSize: Integer;
begin
  Index := DoIndexOfRevN(Value);
  ElemSize := ElSize;
  if Index < 0 then
    FillChar(Item, ElemSize, 0)
  else
  begin
    Move(PByte(FItems^)[Index * ElemSize], Item, ElemSize);
    InternalDoDeleteN(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemFwdInterface(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwdMRef(Value);
  if Index < 0 then
    IInterface(Item) := nil
  else
  begin
    IInterface(Item) := PInterface(FItems^)[Index];
    InternalDoDeleteMRef(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRevInterface(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRevMRef(Value);
  if Index < 0 then
    IInterface(Item) := nil
  else
  begin
    IInterface(Item) := PInterface(FItems^)[Index];
    InternalDoDeleteMRef(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemFwdManaged(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwdN(Value);
  if Index < 0 then
    FinalizeArray(@Item, ElType, 1)
  else
  begin
    System.CopyArray(@Item, PByte(FItems^) + (Index * ElSize), ElType, 1);
    InternalDoDeleteManaged(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRevManaged(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRevN(Value);
  if Index < 0 then
    FinalizeArray(@Item, ElType, 1)
  else
  begin
    System.CopyArray(@Item, PByte(FItems^) + (Index * ElSize), ElType, 1);
    InternalDoDeleteManaged(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemFwdString(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwdMRef(Value);
  if Index < 0 then
    string(Item) := ''
  else
  begin
    string(Item) := PString(FItems^)[Index];
    InternalDoDeleteMRef(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRevString(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRevMRef(Value);
  if Index < 0 then
    string(Item) := ''
  else
  begin
    string(Item) := PString(FItems^)[Index];
    InternalDoDeleteMRef(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemFwdVariant(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwdN(Value);
  if Index < 0 then
    VarClear(Variant(Item))
  else
  begin
    Variant(Item) := PVariant(FItems^)[Index];
    InternalDoDeleteManaged(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRevVariant(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRevN(Value);
  if Index < 0 then
    VarClear(Variant(Item))
  else
  begin
    Variant(Item) := PVariant(FItems^)[Index];
    InternalDoDeleteManaged(Index, cnExtracted);
  end;
end;

{$IF Defined(NEXTGEN)}
procedure TListHelper.DoExtractItemFwdObject(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwdMRef(Value);
  if Index < 0 then
    TObject(Item) := nil
  else
  begin
    TObject(Item) := PObject(FItems^)[Index];
    InternalDoDeleteMRef(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRevObject(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRevMRef(Value);
  if Index < 0 then
    TObject(Item) := nil
  else
  begin
    TObject(Item) := PObject(FItems^)[Index];
    InternalDoDeleteMRef(Index, cnExtracted);
  end;
end;
{$ENDIF}

procedure TListHelper.DoExtractItemFwdByteString(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwdMRef(Value);
  if Index < 0 then
    RawByteString(Item) := ''
  else
  begin
    RawByteString(Item) := PRawByteString(FItems^)[Index];
    InternalDoDeleteMRef(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRevByteString(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRevMRef(Value);
  if Index < 0 then
    RawByteString(Item) := ''
  else
  begin
    RawByteString(Item) := PRawByteString(FItems^)[Index];
    InternalDoDeleteMRef(Index, cnExtracted);
  end;
end;

{$IF not Defined(AUTOREFCOUNT)}
procedure TListHelper.DoExtractItemFwdWideString(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfFwdMRef(Value);
  if Index < 0 then
    WideString(Item) := ''
  else
  begin
    WideString(Item) := PWideString(FItems^)[Index];
    InternalDoDeleteMRef(Index, cnExtracted);
  end;
end;

procedure TListHelper.DoExtractItemRevWideString(const Value; out Item);
var
  Index: Integer;
begin
  Index := DoIndexOfRevMRef(Value);
  if Index < 0 then
    WideString(Item) := ''
  else
  begin
    WideString(Item) := PWideString(FItems^)[Index];
    InternalDoDeleteMRef(Index, cnExtracted);
  end;
end;
{$ENDIF}

function TListHelper.DoIndexOfFwd1(const Value): Integer;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    if FCompare(PByte(FItems^)[I], Byte(Value)) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfFwd2(const Value): Integer;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    if FCompare(PWord(FItems^)[I], Word(Value)) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfFwd4(const Value): Integer;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    if FCompare(PCardinal(FItems^)[I], Cardinal(Value)) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfFwd8(const Value): Integer;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    if FCompare(PUInt64(FItems^)[I], UInt64(Value)) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfFwdMRef(const Value): Integer;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    if FCompare(PPointer(FItems^)[I], Value) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfFwdN(const Value): Integer;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    if FCompare(PByte(FItems^)[I * ElSize], Byte(Value)) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfRev1(const Value): Integer;
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if FCompare(PByte(FItems^)[I], Byte(Value)) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfRev2(const Value): Integer;
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if FCompare(PWord(FItems^)[I], Word(Value)) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfRev4(const Value): Integer;
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if FCompare(PCardinal(FItems^)[I], Cardinal(Value)) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfRev8(const Value): Integer;
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if FCompare(PUInt64(FItems^)[I], UInt64(Value)) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfRevMRef(const Value): Integer;
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if FCompare(PPointer(FItems^)[I], Value) = 0 then
      Exit(I);
  Result := -1;
end;

function TListHelper.DoIndexOfRevN(const Value): Integer;
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if FCompare(PByte(FItems^)[I * ElSize], Byte(Value)) = 0 then
      Exit(I);
  Result := -1;
end;

procedure TListHelper.DoInsertDynArray(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PPointer(FItems^)[AIndex], PPointer(FItems^)[AIndex + 1], (FCount - AIndex) * SizeOf(Pointer));
  PPointer(FItems^)[AIndex] := nil;
  PBytes(FItems^)[AIndex] := TBytes(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.DoInsertInterface(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PPointer(FItems^)[AIndex], PPointer(FItems^)[AIndex + 1], (FCount - AIndex) * SizeOf(Pointer));
  PPointer(FItems^)[AIndex] := nil;
  PInterface(FItems^)[AIndex] := IInterface(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.DoInsertString(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PPointer(FItems^)[AIndex], PPointer(FItems^)[AIndex + 1], (FCount - AIndex) * SizeOf(Pointer));
  PPointer(FItems^)[AIndex] := nil;
  PString(FItems^)[AIndex] := string(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.DoRemoveFwd1(const Value): Integer;
begin
  Result := DoIndexOfFwd1(Value);
  if Result >= 0 then
    InternalDoDelete1(Result, cnRemoved);
end;

function TListHelper.DoRemoveFwd2(const Value): Integer;
begin
  Result := DoIndexOfFwd2(Value);
  if Result >= 0 then
    InternalDoDelete2(Result, cnRemoved);
end;

function TListHelper.DoRemoveFwd4(const Value): Integer;
begin
  Result := DoIndexOfFwd4(Value);
  if Result >= 0 then
    InternalDoDelete4(Result, cnRemoved);
end;

function TListHelper.DoRemoveFwd8(const Value): Integer;
begin
  Result := DoIndexOfFwd8(Value);
  if Result >= 0 then
    InternalDoDelete8(Result, cnRemoved);
end;

function TListHelper.DoRemoveFwdMRef(const Value): Integer;
begin
  Result := DoIndexOfFwdMRef(Value);
  if Result >= 0 then
    InternalDoDeleteMRef(Result, cnRemoved);
end;

function TListHelper.DoRemoveFwdManaged(const Value): Integer;
begin
  Result := DoIndexOfFwdN(Value);
  if Result >= 0 then
    InternalDoDeleteManaged(Result, cnRemoved);
end;

{$IF Defined(WEAKREF)}
function TListHelper.DoRemoveFwdWeak(const Value): Integer;
begin
  Result := DoIndexOfFwdN(Value);
  if Result >= 0 then
    InternalDoDeleteWeak(Result, cnRemoved);
end;
{$ENDIF}

function TListHelper.DoRemoveFwdN(const Value): Integer;
begin
  Result := DoIndexOfFwdN(Value);
  if Result >= 0 then
    InternalDoDeleteN(Result, cnRemoved);
end;

function TListHelper.DoRemoveRev1(const Value): Integer;
begin
  Result := DoIndexOfRev1(Value);
  if Result >= 0 then
    InternalDoDelete1(Result, cnRemoved);
end;

function TListHelper.DoRemoveRev2(const Value): Integer;
begin
  Result := DoIndexOfRev2(Value);
  if Result >= 0 then
    InternalDoDelete2(Result, cnRemoved);
end;

function TListHelper.DoRemoveRev4(const Value): Integer;
begin
  Result := DoIndexOfRev4(Value);
  if Result >= 0 then
    InternalDoDelete4(Result, cnRemoved);
end;

function TListHelper.DoRemoveRev8(const Value): Integer;
begin
  Result := DoIndexOfRev8(Value);
  if Result >= 0 then
    InternalDoDelete8(Result, cnRemoved);
end;

function TListHelper.DoRemoveRevMRef(const Value): Integer;
begin
  Result := DoIndexOfRevMRef(Value);
  if Result >= 0 then
    InternalDoDeleteMRef(Result, cnRemoved);
end;

function TListHelper.DoRemoveRevManaged(const Value): Integer;
begin
  Result := DoIndexOfRevN(Value);
  if Result >= 0 then
    InternalDoDeleteManaged(Result, cnRemoved);
end;

{$IF Defined(WEAKREF)}
function TListHelper.DoRemoveRevWeak(const Value): Integer;
begin
  Result := DoIndexOfRevN(Value);
  if Result >= 0 then
    InternalDoDeleteWeak(Result, cnRemoved);
end;
{$ENDIF}

function TListHelper.DoRemoveRevN(const Value): Integer;
begin
  Result := DoIndexOfRevN(Value);
  if Result >= 0 then
    InternalDoDeleteN(Result, cnRemoved);
end;

procedure TListHelper.DoReverseMRef(Kind: TTypeKind);
var
  b, e: Integer;
begin
  b := 0;
  e := FCount - 1;
  while b < e do
  begin
    case Kind of
      TTypeKind.tkUString: DoExchangeStringInline(b, e);
      TTypeKind.tkInterface: DoExchangeInterfaceInline(b, e);
      TTypeKind.tkDynArray: DoExchangeDynArrayInline(b, e);
      TTypeKind.tkVariant: DoExchangeVariantInline(b, e);
      TTypeKind.tkLString: DoExchangeByteStringInline(b, e);
{$IF not Defined(NEXTGEN)}
      TTypeKind.tkWString: DoExchangeWideStringInline(b, e);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
      TTypeKind.tkClass: DoExchangeObjectInline(b, e);
{$ENDIF}
    end;
    Inc(b);
    Dec(e);
  end;
end;

procedure TListHelper.DoReverseString;
begin
  DoReverseMRef(TTypeKind.tkUString);
end;

procedure TListHelper.DoReverseVariant;
begin
  DoReverseMRef(TTypeKind.tkVariant);
end;

procedure TListHelper.DoReverseDynArray;
begin
  DoReverseMRef(TTypeKind.tkDynArray);
end;

procedure TListHelper.DoReverseInterface;
begin
  DoReverseMRef(TTypeKind.tkInterface);
end;

procedure TListHelper.DoReverseByteString;
begin
  DoReverseMRef(TTypeKind.tkLString);
end;

{$IF not Defined(NEXTGEN)}
procedure TListHelper.DoReverseWideString;
begin
  DoReverseMRef(TTypeKind.tkWString);
end;
{$ENDIF}

{$IF Defined(AUTOREFCOUNT)}
procedure TListHelper.DoReverseObject;
begin
  DoReverseMRef(TTypeKind.tkClass);
end;
{$ENDIF}

function TListHelper.InternalAdd1(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PByte(FItems^)[FCount] := Byte(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.InternalAdd2(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PWord(FItems^)[FCount] := Word(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.InternalAdd4(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PCardinal(FItems^)[FCount] := Cardinal(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.InternalAdd8(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PUInt64(FItems^)[FCount] := UInt64(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.InternalAddManaged(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  System.CopyArray(PByte(FItems^) + (FCount * ElSize), @Value, ElType, 1);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

function TListHelper.InternalAddMRef(const Value; TypeKind: TTypeKind): Integer;
begin
  if IsConstValue(TypeKind) then
  begin
    case TypeKind of
      TTypeKind.tkUString: Result := DoAddString(Value);
      TTypeKind.tkDynArray: Result := DoAddDynArray(Value);
{$IF Defined(AUTOREFCOUNT)}
      TTypeKind.tkClass: Result := DoAddObject(Value);
{$ENDIF}
      TTypeKind.tkLString: Result := DoAddByteString(Value);
{$IF not Defined(NEXTGEN)}
      TTypeKind.tkWString: Result := DoAddWideString(Value);
{$ENDIF}
    else
      { TTypeKind.tkInterface: } Result := DoAddInterface(Value);
    end;
  end else
  begin
    Result := -1;
    if Result = -1 then Error(rePlatformNotImplemented);
  end;
end;

procedure TListHelper.SetItemMRef(const Value; AIndex: Integer; TypeKind: TTypeKind);
begin
  if IsConstValue(TypeKind) then
  begin
    case TypeKind of
      TTypeKind.tkUString: DoSetItemString(Value, AIndex);
      TTypeKind.tkDynArray: DoSetItemDynArray(Value, AIndex);
      TTypeKind.tkInterface: DoSetItemInterface(Value, AIndex);
{$IF Defined(AUTOREFCOUNT)}
      TTypeKind.tkClass: DoSetItemObject(Value, AIndex);
{$ENDIF}
      TTypeKind.tkLString: DoSetItemByteString(Value, AIndex);
{$IF not Defined(NEXTGEN)}
      TTypeKind.tkWString: DoSetItemWideString(Value, AIndex);
{$ENDIF}
    end;
  end else
    Error(rePlatformNotImplemented);
end;

function TListHelper.InternalAddVariant(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  PVariant(FItems^)[FCount] := Variant(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.InternalClear1;
begin
  InternalSetCount1(0);
  InternalSetCapacity(0);
end;

procedure TListHelper.InternalClear2;
begin
  InternalSetCount2(0);
  InternalSetCapacity(0);
end;

procedure TListHelper.InternalClear4;
begin
  InternalSetCount4(0);
  InternalSetCapacity(0);
end;

procedure TListHelper.InternalClear8;
begin
  InternalSetCount8(0);
  InternalSetCapacity(0);
end;

procedure TListHelper.InternalClearManaged;
begin
  InternalSetCountManaged(0);
  InternalSetCapacity(0);
end;

procedure TListHelper.InternalClearMRef;
begin
  InternalSetCountMRef(0);
  InternalSetCapacity(0);
end;

procedure TListHelper.InternalClearN;
begin
  InternalSetCountN(0);
  InternalSetCapacity(0);
end;

{$IF Defined(WEAKREF)}
procedure TListHelper.InternalClearWeak;
begin
  InternalSetCountWeak(0);
  InternalSetCapacity(0);
end;
{$ENDIF}

function TListHelper.InternalAddN(const Value): Integer;
begin
  InternalGrowCheck(FCount + 1);
  Result := FCount;
  Move(Value, PByte(FItems^)[FCount * ElSize], ElSize);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.InternalDeleteRange1(AIndex, ACount: Integer);
var
  SArray: array[0..1023] of Byte;
  DArray: array of Byte;
  PElem: PByte;
  tailCount, Size: NativeInt;
  I: Integer;
begin
  if CheckDeleteRange(AIndex, ACount) then
  begin
    if ACount > Length(SArray) then
    begin
      SetLength(DArray, ACount);
      PElem := @DArray[0];
    end else
      PElem := @SArray[0];
    Size := ACount * SizeOf(Byte);
    Move(PByte(FItems^)[AIndex], PElem[0], Size);

    tailCount := FCount - (AIndex + ACount);
    if tailCount > 0 then
    begin
      Move(PByte(FItems^)[AIndex + ACount], PByte(FItems^)[AIndex], tailCount * SizeOf(Byte));
      Inc(AIndex, tailCount);
    end;
    FillChar(PByte(FItems^)[AIndex], Size, 0);

    Dec(FCount, ACount);

    for I := 0 to ACount - 1 do
      FNotify(PElem[I], cnRemoved);
  end;
end;

procedure TListHelper.InternalDeleteRange2(AIndex, ACount: Integer);
var
  SArray: array[0..511] of Word;
  DArray: array of Word;
  PElem: PWord;
  tailCount, Size: NativeInt;
  I: Integer;
begin
  if CheckDeleteRange(AIndex, ACount) then
  begin
    if ACount > Length(SArray) then
    begin
      SetLength(DArray, ACount);
      PElem := @DArray[0];
    end else
      PElem := @SArray[0];
    Size := ACount * SizeOf(Word);
    Move(PWord(FItems^)[AIndex], PElem[0], Size);

    tailCount := FCount - (AIndex + ACount);
    if tailCount > 0 then
    begin
      Move(PWord(FItems^)[AIndex + ACount], PWord(FItems^)[AIndex], tailCount * SizeOf(Word));
      Inc(AIndex, tailCount);
    end;
    FillChar(PWord(FItems^)[AIndex], Size, 0);

    Dec(FCount, ACount);

    for I := 0 to ACount - 1 do
      FNotify(PElem[I], cnRemoved);
  end;
end;

procedure TListHelper.InternalDeleteRange4(AIndex, ACount: Integer);
var
  SArray: array[0..255] of Cardinal;
  DArray: array of Cardinal;
  PElem: PCardinal;
  tailCount, Size: NativeInt;
  I: Integer;
begin
  if CheckDeleteRange(AIndex, ACount) then
  begin
    if ACount > Length(SArray) then
    begin
      SetLength(DArray, ACount);
      PElem := @DArray[0];
    end else
      PElem := @SArray[0];
    Size := ACount * SizeOf(Cardinal);
    Move(PCardinal(FItems^)[AIndex], PElem[0], Size);

    tailCount := (FCount - (AIndex + ACount));
    if tailCount > 0 then
    begin
      Move(PCardinal(FItems^)[AIndex + ACount], PCardinal(FItems^)[AIndex], tailCount * SizeOf(Cardinal));
      Inc(AIndex, tailCount);
    end;
    FillChar(PCardinal(FItems^)[AIndex], Size, 0);

    Dec(FCount, ACount);

    for I := 0 to ACount - 1 do
      FNotify(PElem[I], cnRemoved);
  end;
end;

procedure TListHelper.InternalDeleteRange8(AIndex, ACount: Integer);
var
  SArray: array[0..127] of UInt64;
  DArray: array of UInt64;
  PElem: PUInt64;
  tailCount, Size: NativeInt;
  I: Integer;
begin
  if CheckDeleteRange(AIndex, ACount) then
  begin
    if ACount > Length(SArray) then
    begin
      SetLength(DArray, ACount);
      PElem := @DArray[0];
    end else
      PElem := @SArray[0];
    Size := ACount * SizeOf(UInt64);
    Move(PUInt64(FItems^)[AIndex], PElem[0], Size);

    tailCount := FCount - (AIndex + ACount);
    if tailCount > 0 then
    begin
      Move(PUInt64(FItems^)[AIndex + ACount], PUInt64(FItems^)[AIndex], tailCount * SizeOf(UInt64));
      Inc(AIndex, tailCount);
    end;
    FillChar(PUInt64(FItems^)[AIndex], Size, 0);

    Dec(FCount, ACount);

    for I := 0 to ACount - 1 do
      FNotify(PElem[I], cnRemoved);
  end;
end;

procedure TListHelper.InternalDeleteRangeManaged(AIndex, ACount: Integer);
var
  SArray: array[0..1023] of Byte;
  DArray: Pointer;
  PElem: PByte;
  tailCount, Size: NativeInt;
  I, ElemSize: Integer;
begin
  if CheckDeleteRange(AIndex, ACount) then
  begin
    ElemSize := ElSize;
    DArray := nil; // initialize the local dynarray
    PElem := @SArray[0];
    try
      Size := ACount * ElemSize;
      if Size > Length(SArray) then
      begin
        GetMem(DArray, Size);
        PElem := DArray;
      end;
      Move(PByte(FItems^)[AIndex * ElemSize], PElem[0], Size);

      tailCount := (FCount - (AIndex + ACount)) * ElemSize;
      if tailCount > 0 then
      begin
        Move(PByte(FItems^)[(AIndex + ACount) * ElemSize], PByte(FItems^)[AIndex * ElemSize], tailCount);
        FillChar(PByte(FItems^)[(FCount - ACount) * ElemSize], Size, 0);
      end else
        FillChar(PByte(FItems^)[AIndex * ElemSize], Size, 0);

      Dec(FCount, ACount);

      for I := 0 to ACount - 1 do
        FNotify(PElem[I * ElemSize], cnRemoved);
    finally
      if DArray <> nil then
      begin
        FinalizeArray(DArray, ElType, ACount);
        FreeMem(DArray);
      end else
        FinalizeArray(PElem, ElType, ACount);
    end;
  end;
end;

procedure TListHelper.InternalDeleteRangeMRef(AIndex, ACount: Integer);
var
  SArray: array[0..(1024 div SizeOf(Pointer)) - 1] of NativeInt;
  DArray: Pointer;
  PElem: PPointer;
  tailCount, Size: NativeInt;
  I: Integer;
begin
  if CheckDeleteRange(AIndex, ACount) then
  begin
    DArray := nil;
    PElem := @SArray[0];
    try
      Size := ACount;
      if Size > Length(SArray) then
      begin
        DynArraySetLength(DArray, FTypeInfo, 1, @Size);
        PElem := DArray;
      end;
      Move(PPointer(FItems^)[AIndex], PElem[0], ACount * SizeOf(Pointer));

      tailCount := FCount - (AIndex + ACount);
      if tailCount > 0 then
      begin
        Move(PPointer(FItems^)[AIndex + ACount], PPointer(FItems^)[AIndex], tailCount * SizeOf(Pointer));
        FillChar(PPointer(FItems^)[FCount - ACount], ACount * SizeOf(Pointer), 0);
      end else
        FillChar(PPointer(FItems^)[AIndex], ACount * SizeOf(Pointer), 0);

      Dec(FCount, ACount);

      for I := 0 to ACount - 1 do
        FNotify(PElem[I], cnRemoved);
    finally
      if DArray = nil then
        FinalizeArray(PElem, ElType, Size)
      else
        DynArrayClear(DArray, FTypeInfo);
    end;
  end;
end;

{$IF Defined(WEAKREF)}
procedure TListHelper.InternalDeleteRangeWeak(AIndex, ACount: Integer);
var
  SArray: TLocalDynArray;
  DArray: Pointer;
  PElem: PByte;
  tailCount, Size: NativeInt;
  I, ElemSize: Integer;
begin
  if CheckDeleteRange(AIndex, ACount) then
  begin
    ElemSize := ElSize;
    DArray := nil; // initialize the local dynarray
    PElem := @SArray.Data[0];
    try
      Size := ACount;
      if (Size * ElemSize) > Length(SArray.Data) then
      begin
        DynArraySetLength(DArray, FTypeInfo, 1, @Size);
        PElem := DArray;
      end else
      begin
        FillChar(SArray, SizeOf(SArray), 0);
        SArray.RefCnt := -1;
        SArray.Length := ACount;
      end;
      System.CopyArray(PElem, PByte(FItems^) + (AIndex * ElemSize), ElType, ACount);

      tailCount := FCount - (AIndex + ACount);
      if tailCount > 0 then
      begin
        System.CopyArray(PByte(FItems^) + (AIndex * ElemSize), PByte(FItems^) + ((AIndex + ACount) * ElemSize), ElType, tailCount);
        FinalizeArray(PByte(FItems^) + ((FCount - ACount) * ElemSize), ElType, ACount);
      end else
        FinalizeArray(PByte(FItems^) + (AIndex * ElemSize), ElType, ACount);

      Dec(FCount, ACount);

      for I := 0 to ACount - 1 do
        FNotify(PElem[I * ElemSize], cnRemoved);
    finally
      if DArray = nil then
        FinalizeArray(PElem, ElType, ACount)
      else
        DynArrayClear(DArray, FTypeInfo);
    end;
  end;
end;
{$ENDIF}

procedure TListHelper.InternalDeleteRangeN(AIndex, ACount: Integer);
var
  SArray: array[0..1023] of Byte;
  DArray: Pointer;
  PElem: PByte;
  tailCount, I, Size, ElemSize: Integer;
begin
  if CheckDeleteRange(AIndex, ACount) then
  begin
    ElemSize := ElSize;
    DArray := nil; // initialize the local dynarray
    try
      Size := ACount * ElemSize;
      if Size > Length(SArray) then
      begin
        GetMem(DArray, Size);
        PElem := DArray;
      end else
        PElem := @SArray[0];
      Move(PByte(FItems^)[AIndex * ElemSize], PElem[0], Size);

      tailCount := FCount - (AIndex + ACount);
      if tailCount > 0 then
      begin
        Move(PByte(FItems^)[(AIndex + ACount) * ElemSize], PByte(FItems^)[AIndex * ElemSize], tailCount * ElemSize);
        Inc(AIndex, tailCount);
      end;
      FillChar(PByte(FItems^)[AIndex * ElemSize], Size, 0);

      Dec(FCount, ACount);

      for I := 0 to ACount - 1 do
        FNotify(PElem[I * ElemSize], cnRemoved);
    finally
      FreeMem(DArray);
    end;
  end;
end;

procedure TListHelper.InternalDoDelete1(AIndex: Integer; Action: TCollectionNotification);
var
  oldItem: Byte;
begin
  CheckItemRangeInline(AIndex);
  oldItem := PByte(FItems^)[AIndex];
  Dec(FCount);
  if AIndex <> FCount then
    Move(PByte(FItems^)[AIndex + 1], PByte(FItems^)[AIndex], FCount - AIndex);
  PByte(FItems^)[FCount] := 0;
  FNotify(oldItem, Action);
end;

procedure TListHelper.InternalDoDelete2(AIndex: Integer; Action: TCollectionNotification);
var
  oldItem: Word;
begin
  CheckItemRangeInline(AIndex);
  oldItem := PWord(FItems^)[AIndex];
  Dec(FCount);
  if AIndex <> FCount then
    Move(PWord(FItems^)[AIndex + 1], PWord(FItems^)[AIndex], (FCount - AIndex) * SizeOf(Word));
  PWord(FItems^)[FCount] := 0;
  FNotify(oldItem, Action);
end;

procedure TListHelper.InternalDoDelete4(AIndex: Integer; Action: TCollectionNotification);
var
  oldItem: Cardinal;
begin
  CheckItemRangeInline(AIndex);
  oldItem := PCardinal(FItems^)[AIndex];
  Dec(FCount);
  if AIndex <> FCount then
    Move(PCardinal(FItems^)[AIndex + 1], PCardinal(FItems^)[AIndex], (FCount - AIndex) * SizeOf(Cardinal));
  PCardinal(FItems^)[FCount] := 0;
  FNotify(oldItem, Action);
end;

procedure TListHelper.InternalDoDelete8(AIndex: Integer; Action: TCollectionNotification);
var
  oldItem: UInt64;
begin
  CheckItemRangeInline(AIndex);
  oldItem := PUInt64(FItems^)[AIndex];
  Dec(FCount);
  if AIndex <> FCount then
    Move(PUInt64(FItems^)[AIndex + 1], PUInt64(FItems^)[AIndex], (FCount - AIndex) * SizeOf(UInt64));
  PUInt64(FItems^)[FCount] := 0;
  FNotify(oldItem, Action);
end;

procedure TListHelper.InternalDoDeleteManaged(AIndex: Integer; Action: TCollectionNotification);
var
  SOldItem: array[0..63] of Byte;
  DOldItem: PByte;
  OldItemP: PByte;
  ElemSize: Integer;
begin
  CheckItemRangeInline(AIndex);
  ElemSize := ElSize;
  DOldItem := nil;
  OldItemP := @SOldItem[0];
  try
    if ElemSize > SizeOf(SOldItem) then
    begin
      GetMem(DOldItem, ElemSize);
      OldItemP := DOldItem;
    end;
    Move(PByte(FItems^)[AIndex * ElemSize], OldItemP^, ElemSize);
    Dec(FCount);
    if AIndex <> FCount then
      Move(PByte(FItems^)[(AIndex + 1) * ElemSize], PByte(FItems^)[AIndex * ElemSize], (FCount - AIndex) * ElemSize);
    FillChar(PByte(FItems^)[FCount * ElemSize], ElemSize, 0);
    FNotify(OldItemP^, Action);
  finally
    FinalizeArray(OldItemP, ElType, 1);
    FreeMem(DOldItem);
  end;
end;

procedure TListHelper.InternalDoDeleteMRef(AIndex: Integer; Action: TCollectionNotification);
var
  oldItem: Pointer;
begin
  CheckItemRangeInline(AIndex);
  oldItem := PPointer(FItems^)[AIndex];
  try
    Dec(FCount);
    if AIndex <> FCount then
      Move(PPointer(FItems^)[AIndex + 1], PPointer(FItems^)[AIndex], (FCount - AIndex) * SizeOf(Pointer));
    PPointer(FItems^)[FCount] := nil;
    FNotify(oldItem, Action);
  finally
    FinalizeArray(@oldItem, ElType, 1);
  end;
end;

procedure TListHelper.InternalDoDeleteN(AIndex: Integer; Action: TCollectionNotification);
var
  SOldItem: array[0..63] of Byte;
  DOldItem: PByte;
  OldItemP: PByte;
  ElemSize: Integer;
begin
  CheckItemRangeInline(AIndex);
  DOldItem := nil;
  OldItemP := @SOldItem[0];
  try
    ElemSize := ElSize;
    if ElemSize > SizeOf(SOldItem) then
    begin
      GetMem(DOldItem, ElemSize);
      OldItemP := DOldItem;
    end;
    Move(PByte(FItems^)[AIndex * ElemSize], OldItemP^, ElemSize);
    Dec(FCount);
    if AIndex <> FCount then
      Move(PByte(FItems^)[(AIndex + 1) * ElemSize], PByte(FItems^)[AIndex * ElemSize], (FCount - AIndex) * ElemSize);
    FillChar(PByte(FItems^)[FCount * ElemSize], ElemSize, 0);
    FNotify(OldItemP^, Action);
  finally
    FreeMem(DOldItem);
  end;
end;

{$IF Defined(WEAKREF)}
procedure TListHelper.InternalDoDeleteWeak(AIndex: Integer; Action: TCollectionNotification);
var
  SOldItem: TLocalDynArray;
  DOldItem: Pointer;
  OldItemP: PByte;
  ElemSize: Integer;
  Size: NativeInt;
begin
  CheckItemRangeInline(AIndex);
  ElemSize := ElSize;
  DOldItem := nil;
  OldItemP := @SOldItem.Data[0];
  Size := 1;
  try
    if ElemSize > Length(SOldItem.Data) then
    begin
      DynArraySetLength(DOldItem, FTypeInfo, 1, @Size);
      OldItemP := DOldItem;
    end else
    begin
      FillChar(SOldItem, SizeOf(SOldItem), 0);
      SOldItem.RefCnt := -1;
      SOldItem.Length := 1;
    end;
    System.CopyArray(OldItemP, PByte(FItems^) + AIndex * ElemSize, ElType, 1);
    Dec(FCount);
    if AIndex <> FCount then
      System.CopyArray(PByte(FItems^) + AIndex * ElemSize, PByte(FItems^) + (AIndex + 1) * ElemSize, ElType, FCount - AIndex);
    FinalizeArray(PByte(FItems^) + FCount * ElemSize, ElType, 1);
    FNotify(OldItemP^, Action);
  finally
    if DOldItem = nil then
      FinalizeArray(OldItemP, ElType, 1)
    else
      DynArrayClear(DOldItem, FTypeInfo);
  end;
end;
{$ENDIF}

procedure TListHelper.InternalGrow(ANewCount: Integer);
var
  NewCount: Integer;
begin
  NewCount := DynArraySize(FItems^);
  if NewCount = 0 then
    NewCount := ANewCount
  else
    repeat
      NewCount := NewCount * 2;
      if NewCount < 0 then
        OutOfMemoryError;
    until NewCount >= ANewCount;
  InternalSetCapacity(NewCount);
end;

procedure TListHelper.InternalGrowCheck(ANewCount: Integer);
begin
  if ANewCount > DynArraySize(FItems^) then
    InternalGrow(ANewCount)
  else if ANewCount < 0 then
    OutOfMemoryError;
end;

function TListHelper.InternalIndexOf1(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(System.Types.TDirection.FromBeginning) then
    Result := DoIndexOfFwd1(Value)
  else
    Result := DoIndexOfRev1(Value);
end;

function TListHelper.InternalIndexOf2(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(System.Types.TDirection.FromBeginning) then
    Result := DoIndexOfFwd2(Value)
  else
    Result := DoIndexOfRev2(Value);
end;

function TListHelper.InternalIndexOf4(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(System.Types.TDirection.FromBeginning) then
    Result := DoIndexOfFwd4(Value)
  else
    Result := DoIndexOfRev4(Value);
end;

function TListHelper.InternalIndexOf8(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(System.Types.TDirection.FromBeginning) then
    Result := DoIndexOfFwd8(Value)
  else
    Result := DoIndexOfRev8(Value);
end;

function TListHelper.InternalIndexOfMRef(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(System.Types.TDirection.FromBeginning) then
    Result := DoIndexOfFwdMRef(Value)
  else
    Result := DoIndexOfRevMRef(Value);
end;

function TListHelper.InternalIndexOfN(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(System.Types.TDirection.FromBeginning) then
    Result := DoIndexOfFwdN(Value)
  else
    Result := DoIndexOfRevN(Value);
end;

procedure TListHelper.InternalInsert1(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PByte(FItems^)[AIndex], PByte(FItems^)[AIndex + 1], FCount - AIndex);
  PByte(FItems^)[AIndex] := Byte(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.InternalInsert2(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PWord(FItems^)[AIndex], PWord(FItems^)[AIndex + 1], (FCount - AIndex) * SizeOf(Word));
  PWord(FItems^)[AIndex] := Word(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.InternalInsert4(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PCardinal(FItems^)[AIndex], PCardinal(FItems^)[AIndex + 1], (FCount - AIndex) * SizeOf(Cardinal));
  PCardinal(FItems^)[AIndex] := Cardinal(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.InternalInsert8(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PUInt64(FItems^)[AIndex], PUInt64(FItems^)[AIndex + 1], (FCount - AIndex) * SizeOf(UInt64));
  PUInt64(FItems^)[AIndex] := UInt64(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.InternalInsertManaged(AIndex: Integer; const Value);
var
  ElemSize: Integer;
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  ElemSize := ElSize;
  if AIndex <> FCount then
    CopyArray(PByte(FItems^) + (AIndex + 1) * ElemSize, PByte(FItems^) + AIndex * ElemSize, ElType, ElemSize, FCount - AIndex);
  System.CopyArray(PByte(FItems^) + AIndex * ElemSize, @Value, ElType, 1);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.InternalInsertMRef(AIndex: Integer; const Value; TypeKind: TTypeKind);
begin
  if IsConstValue(TypeKind) then
  begin
    case TypeKind of
      TTypeKind.tkUString: DoInsertString(AIndex, Value);
      TTypeKind.tkDynArray: DoInsertDynArray(AIndex, Value);
      TTypeKind.tkInterface: DoInsertInterface(AIndex, Value);
{$IF Defined(AUTOREFCOUNT)}
      TTypeKind.tkClass: DoInsertObject(AIndex, Value);
{$ENDIF}
      TTypeKind.tkLString: DoInsertByteString(AIndex, Value);
{$IF not Defined(NEXTGEN)}
      TTypeKind.tkWString: DoInsertWideString(AIndex, Value);
{$ENDIF}
    end;
  end else
    Error(rePlatformNotImplemented);
end;

procedure TListHelper.InternalInsertN(AIndex: Integer; const Value);
var
  ElemSize: Integer;
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  ElemSize := ElSize;
  if AIndex <> FCount then
    Move(PByte(FItems^)[AIndex * ElemSize], PByte(FItems^)[(AIndex + 1) * ElemSize], (FCount - AIndex) * ElemSize);
  Move(Value, PByte(FItems^)[AIndex * ElemSize], ElemSize);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.InternalInsertRange1(AIndex: Integer; Values: Pointer; ACount: Integer);
var
  I: Integer;
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + ACount);
  if AIndex <> FCount then
    Move(PByte(FItems^)[AIndex], PByte(FItems^)[AIndex + ACount], FCount - AIndex);

  Move(PByte(Values)[0], PByte(FItems^)[AIndex], ACount);

  Inc(FCount, ACount);

  for I := 0 to ACount - 1 do
    FNotify(PByte(Values)[I], cnAdded);
end;

procedure TListHelper.InternalInsertRange2(AIndex: Integer; Values: Pointer; ACount: Integer);
var
  I: Integer;
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + ACount);
  if AIndex <> FCount then
    Move(PWord(FItems^)[AIndex], PWord(FItems^)[AIndex + ACount], (FCount - AIndex) * SizeOf(Word));

  Move(PWord(Values)[0], PWord(FItems^)[AIndex], ACount * SizeOf(Word));

  Inc(FCount, ACount);

  for I := 0 to ACount - 1 do
    FNotify(PWord(Values)[I], cnAdded);
end;

procedure TListHelper.InternalInsertRange4(AIndex: Integer; Values: Pointer; ACount: Integer);
var
  I: Integer;
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + ACount);
  if AIndex <> FCount then
    Move(PCardinal(FItems^)[AIndex], PCardinal(FItems^)[AIndex + ACount], (FCount - AIndex) * SizeOf(Cardinal));

  Move(PCardinal(Values)[0], PCardinal(FItems^)[AIndex], ACount * SizeOf(Cardinal));

  Inc(FCount, ACount);

  for I := 0 to ACount - 1 do
    FNotify(PCardinal(Values)[I], cnAdded);
end;

procedure TListHelper.InternalInsertRange8(AIndex: Integer; Values: Pointer; ACount: Integer);
var
  I: Integer;
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + ACount);
  if AIndex <> FCount then
    Move(PUInt64(FItems^)[AIndex], PUInt64(FItems^)[AIndex + ACount], (FCount - AIndex) * SizeOf(UInt64));

  Move(PUInt64(Values)[0], PUInt64(FItems^)[AIndex], ACount * SizeOf(UInt64));

  Inc(FCount, ACount);

  for I := 0 to ACount - 1 do
    FNotify(PUInt64(Values)[I], cnAdded);
end;

procedure TListHelper.InternalInsertRangeManaged(AIndex: Integer; Values: Pointer; ACount: Integer);
var
  I, ElemSize: Integer;
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + ACount);
  ElemSize := ElSize;
  if AIndex <> FCount then
    CopyArray(@PByte(FItems^)[(AIndex + ACount) * ElemSize], @PByte(FItems^)[AIndex * ElemSize], ElType, ElemSize, FCount - AIndex);

  CopyArray(@PByte(FItems^)[AIndex * ElemSize], @PByte(Values)[0], ElType, ElemSize, ACount);

  Inc(FCount, ACount);

  for I := 0 to ACount - 1 do
    FNotify(PByte(Values)[I * ElemSize], cnAdded);
end;

procedure TListHelper.InternalInsertRangeN(AIndex: Integer; Values: Pointer; ACount: Integer);
var
  I, ElemSize: Integer;
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + ACount);
  ElemSize := ElSize;
  if AIndex <> FCount then
    Move(PByte(FItems^)[AIndex * ElemSize], PByte(FItems^)[(AIndex + ACount) * ElemSize], (FCount - AIndex) * ElemSize);

  Move(PByte(Values)[0], PByte(FItems^)[AIndex * ElemSize], ACount * ElemSize);

  Inc(FCount, ACount);

  for I := 0 to ACount - 1 do
    FNotify(PByte(Values)[I * ElemSize], cnAdded);
end;

procedure TListHelper.InternalInsertVariant(AIndex: Integer; const Value);
begin
  CheckInsertRange(AIndex);

  InternalGrowCheck(FCount + 1);
  if AIndex <> FCount then
    Move(PVariant(FItems^)[AIndex], PVariant(FItems^)[AIndex + 1], (FCount - AIndex) * SizeOf(Variant));
  PVariant(FItems^)[AIndex] := Variant(Value);
  Inc(FCount);
  FNotify(Value, cnAdded);
end;

procedure TListHelper.InternalMove1(CurIndex, NewIndex: Integer);
var
  Temp: Byte;
begin
  if CurIndex <> NewIndex then
  begin
    CheckItemRangeInline(NewIndex);

    Temp := PByte(FItems^)[CurIndex];
    if CurIndex < NewIndex then
      Move(PByte(FItems^)[CurIndex + 1], PByte(FItems^)[CurIndex], NewIndex - CurIndex)
    else
      Move(PByte(FItems^)[NewIndex], PByte(FItems^)[NewIndex + 1], CurIndex - NewIndex);

    PByte(FItems^)[NewIndex] := Temp;
  end;
end;

procedure TListHelper.InternalMove2(CurIndex, NewIndex: Integer);
var
  Temp: Word;
begin
  if CurIndex <> NewIndex then
  begin
    CheckItemRangeInline(NewIndex);

    Temp := PWord(FItems^)[CurIndex];
    if CurIndex < NewIndex then
      Move(PWord(FItems^)[CurIndex + 1], PWord(FItems^)[CurIndex], (NewIndex - CurIndex) * SizeOf(Word))
    else
      Move(PWord(FItems^)[NewIndex], PWord(FItems^)[NewIndex + 1], (CurIndex - NewIndex) * SizeOf(Word));

    PWord(FItems^)[NewIndex] := Temp;
  end;
end;

procedure TListHelper.InternalMove4(CurIndex, NewIndex: Integer);
var
  Temp: Cardinal;
begin
  if CurIndex <> NewIndex then
  begin
    CheckItemRangeInline(NewIndex);

    Temp := PCardinal(FItems^)[CurIndex];
    if CurIndex < NewIndex then
      Move(PCardinal(FItems^)[CurIndex + 1], PCardinal(FItems^)[CurIndex], (NewIndex - CurIndex) * SizeOf(Cardinal))
    else
      Move(PCardinal(FItems^)[NewIndex], PCardinal(FItems^)[NewIndex + 1], (CurIndex - NewIndex) * SizeOf(Cardinal));

    PCardinal(FItems^)[NewIndex] := Temp;
  end;
end;

procedure TListHelper.InternalMove8(CurIndex, NewIndex: Integer);
var
  Temp: UInt64;
begin
  if CurIndex <> NewIndex then
  begin
    CheckItemRangeInline(NewIndex);

    Temp := PUInt64(FItems^)[CurIndex];
    if CurIndex < NewIndex then
      Move(PUInt64(FItems^)[CurIndex + 1], PUInt64(FItems^)[CurIndex], (NewIndex - CurIndex) * SizeOf(UInt64))
    else
      Move(PUInt64(FItems^)[NewIndex], PUInt64(FItems^)[NewIndex + 1], (CurIndex - NewIndex) * SizeOf(UInt64));

    PUInt64(FItems^)[NewIndex] := Temp;
  end;
end;

procedure TListHelper.InternalMoveManaged(CurIndex, NewIndex: Integer);
var
  STemp: array[0..63] of Byte;
  DTemp: PByte;
  PTemp: PByte;
  ElemSize: Integer;
begin
  if CurIndex <> NewIndex then
  begin
    CheckItemRangeInline(NewIndex);

    DTemp := nil;
    PTemp := @STemp;
    try
      ElemSize := ElSize;
      if ElemSize > SizeOf(STemp) then
      begin
        DTemp := AllocMem(ElemSize);
        PTemp := DTemp;
      end else
        FillChar(STemp, SizeOf(STemp), 0);
      System.CopyArray(@PTemp[0], @PByte(FItems^)[CurIndex * ElemSize], ElType, 1);
      if CurIndex < NewIndex then
        CopyArray(@PByte(FItems^)[CurIndex * ElemSize], @PByte(FItems^)[(CurIndex + 1) * ElemSize], ElType, ElemSize, NewIndex - CurIndex)
      else
        CopyArray(@PByte(FItems^)[(NewIndex + 1) * ElemSize], @PByte(FItems^)[NewIndex * ElemSize], ElType, ElemSize, CurIndex - NewIndex);
      FinalizeArray(@PByte(FItems^)[NewIndex * ElemSize], ElType, 1);
      System.CopyArray(@PByte(FItems^)[NewIndex * ElemSize], @PTemp[0], ElType, 1);
    finally
      FinalizeArray(PTemp, ElType, 1);
      FreeMem(DTemp);
    end;
  end;
end;

procedure TListHelper.InternalMoveMRef(CurIndex, NewIndex: Integer);
var
  Temp: Pointer;
begin
  if CurIndex <> NewIndex then
  begin
    CheckItemRangeInline(NewIndex);

    Temp := nil;
    AtomicExchange(Temp, PPointer(FItems^)[CurIndex]); // this sequence "transfers" the current reference to Temp
    PPointer(FItems^)[CurIndex] := nil;
    if CurIndex < NewIndex then
      Move(PPointer(FItems^)[CurIndex + 1], PPointer(FItems^)[CurIndex], (NewIndex - CurIndex) * SizeOf(Pointer))
    else
      Move(PPointer(FItems^)[NewIndex], PPointer(FItems^)[NewIndex + 1], (CurIndex - NewIndex) * SizeOf(Pointer));

    AtomicExchange(PPointer(FItems^)[NewIndex], Temp); // "transfer" the reference to the new location
  end;
end;

procedure TListHelper.InternalMoveN(CurIndex, NewIndex: Integer);
var
  STemp: array[0..63] of Byte;
  DTemp: PByte;
  PTemp: PByte;
  ElemSize: Integer;
begin
  if CurIndex <> NewIndex then
  begin
    CheckItemRangeInline(NewIndex);

    DTemp := nil;
    PTemp := @STemp;
    try
      ElemSize := ElSize;
      if ElemSize > SizeOf(STemp) then
      begin
        GetMem(DTemp, ElemSize);
        PTemp := DTemp;
      end;
      Move(PByte(FItems^)[CurIndex * ElemSize], PTemp[0], ElemSize);
      if CurIndex < NewIndex then
        Move(PByte(FItems^)[(CurIndex + 1) * ElemSize], PByte(FItems^)[CurIndex * ElemSize], (NewIndex - CurIndex) * ElemSize)
      else
        Move(PByte(FItems^)[NewIndex * ElemSize], PByte(FItems^)[(NewIndex + 1) * ElemSize], (CurIndex - NewIndex) * ElemSize);

      Move(PTemp[0], PByte(FItems^)[NewIndex * ElemSize], ElemSize);
    finally
      FreeMem(DTemp);
    end;
  end;
end;

procedure TListHelper.InternalPackInline(const IsEmpty: TInternalEmptyFunc);
var
  PackedCount: Integer;
  StartIndex: Integer;
  EndIndex: Integer;
  ElemSize: Integer;
begin
  if FCount = 0 then
    Exit;

  ElemSize := ElSize;
  PackedCount := 0;
  StartIndex := 0;
  repeat
    // Locate the first/next non-nil element in the list
//    while (StartIndex < FCount) and (FComparer.Compare(FItems[StartIndex], Default(T)) = 0) do
    while (StartIndex < FCount) and IsEmpty(PByte(FItems^)[StartIndex * ElemSize]) do
      Inc(StartIndex);

    if StartIndex < FCount then // There is nothing more to do
    begin
      // Locate the next nil pointer
      EndIndex := StartIndex;
//      while (EndIndex < FCount) and (FComparer.Compare(FItems[EndIndex], Default(T)) <> 0) do
      while (EndIndex < FCount) and not IsEmpty(PByte(FItems^)[EndIndex * ElemSize]) do
        Inc(EndIndex);
      Dec(EndIndex);

      // Move this block of non-null items to the index recorded in PackedToCount:
      // If this is a contiguous non-nil block at the start of the list then
      // StartIndex and PackedToCount will be equal (and 0) so don't bother with the move.
      if StartIndex > PackedCount then
        Move(PByte(FItems^)[StartIndex * ElemSize], PByte(FItems^)[PackedCount * ELemSize], (EndIndex - StartIndex + 1) * ElemSize);

      // Set the PackedToCount to reflect the number of items in the list
      // that have now been packed.
      Inc(PackedCount, EndIndex - StartIndex + 1);

      // Reset StartIndex to the element following EndIndex
      StartIndex := EndIndex + 1;
    end;
  until StartIndex >= FCount;

  // Set Count so that the 'free' item
  FCount := PackedCount;
end;

procedure TListHelper.InternalPack1(const IsEmpty: TInternalEmptyFunc);
begin
  InternalPackInline(IsEmpty);
end;

procedure TListHelper.InternalPack2(const IsEmpty: TInternalEmptyFunc);
begin
  InternalPackInline(IsEmpty);
end;

procedure TListHelper.InternalPack4(const IsEmpty: TInternalEmptyFunc);
begin
  InternalPackInline(IsEmpty);
end;

procedure TListHelper.InternalPack8(const IsEmpty: TInternalEmptyFunc);
begin
  InternalPackInline(IsEmpty);
end;

procedure TListHelper.InternalPackManaged(const IsEmpty: TInternalEmptyFunc);
var
  PackedCount : Integer;
  StartIndex : Integer;
  EndIndex : Integer;
  ElemSize: Integer;
begin
  if FCount = 0 then
    Exit;

  ElemSize := ElSize;
  PackedCount := 0;
  StartIndex := 0;
  repeat
    // Locate the first/next non-nil element in the list
//    while (StartIndex < FCount) and (FComparer.Compare(FItems[StartIndex], Default(T)) = 0) do
    while (StartIndex < FCount) and IsEmpty(PByte(FItems^)[StartIndex * ElemSize]) do
      Inc(StartIndex);

    if StartIndex < FCount then // There is nothing more to do
    begin
      // Locate the next nil pointer
      EndIndex := StartIndex;
//      while (EndIndex < FCount) and (FComparer.Compare(FItems[EndIndex], Default(T)) <> 0) do
      while (EndIndex < FCount) and not IsEmpty(PByte(FItems^)[EndIndex * ElemSize]) do
        Inc(EndIndex);
      Dec(EndIndex);

      // Move this block of non-null items to the index recorded in PackedToCount:
      // If this is a contiguous non-nil block at the start of the list then
      // StartIndex and PackedToCount will be equal (and 0) so don't bother with the move.
      if StartIndex > PackedCount then
        CopyArray(@PByte(FItems^)[PackedCount * ELemSize], @PByte(FItems^)[StartIndex * ElemSize], ElType, ElemSize, EndIndex - StartIndex + 1);

      // Set the PackedToCount to reflect the number of items in the list
      // that have now been packed.
      Inc(PackedCount, EndIndex - StartIndex + 1);

      // Reset StartIndex to the element following EndIndex
      StartIndex := EndIndex + 1;
    end;
  until StartIndex >= FCount;

  // Set Count so that the 'free' item
  FCount := PackedCount;
end;

procedure TListHelper.InternalPackN(const IsEmpty: TInternalEmptyFunc);
begin
  InternalPackInline(IsEmpty);
end;

function TListHelper.InternalRemove1(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(TDirection.FromBeginning) then
    Result := DoRemoveFwd1(Value)
  else
    Result := DoRemoveRev1(Value);
end;

function TListHelper.InternalRemove2(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(TDirection.FromBeginning) then
    Result := DoRemoveFwd2(Value)
  else
    Result := DoRemoveRev2(Value);
end;

function TListHelper.InternalRemove4(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(TDirection.FromBeginning) then
    Result := DoRemoveFwd4(Value)
  else
    Result := DoRemoveRev4(Value);
end;

function TListHelper.InternalRemove8(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(TDirection.FromBeginning) then
    Result := DoRemoveFwd8(Value)
  else
    Result := DoRemoveRev8(Value);
end;

function TListHelper.InternalRemoveMRef(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(TDirection.FromBeginning) then
    Result := DoRemoveFwdMRef(Value)
  else
    Result := DoRemoveRevMRef(Value);
end;

function TListHelper.InternalRemoveManaged(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(TDirection.FromBeginning) then
    Result := DoRemoveFwdManaged(Value)
  else
    Result := DoRemoveRevManaged(Value);
end;

{$IF Defined(WEAKREF)}
function TListHelper.InternalRemoveWeak(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(TDirection.FromBeginning) then
    Result := DoRemoveFwdWeak(Value)
  else
    Result := DoRemoveRevWeak(Value);
end;
{$ENDIF}

function TListHelper.InternalRemoveN(const Value; Direction: Byte): Integer;
begin
  if Direction = Byte(TDirection.FromBeginning) then
    Result := DoRemoveFwdN(Value)
  else
    Result := DoRemoveRevN(Value);
end;

procedure TListHelper.InternalReverse1;
var
  tmp: Byte;
  b, e: Integer;
begin
  b := 0;
  e := FCount - 1;
  while b < e do
  begin
    tmp := PByte(FItems^)[b];
    PByte(FItems^)[b] := PByte(FItems^)[e];
    PByte(FItems^)[e] := tmp;
    Inc(b);
    Dec(e);
  end;
end;

procedure TListHelper.InternalReverse2;
var
  tmp: Word;
  b, e: Integer;
begin
  b := 0;
  e := FCount - 1;
  while b < e do
  begin
    tmp := PWord(FItems^)[b];
    PWord(FItems^)[b] := PWord(FItems^)[e];
    PWord(FItems^)[e] := tmp;
    Inc(b);
    Dec(e);
  end;
end;

procedure TListHelper.InternalReverse4;
var
  tmp: Cardinal;
  b, e: Integer;
begin
  b := 0;
  e := FCount - 1;
  while b < e do
  begin
    tmp := PCardinal(FItems^)[b];
    PCardinal(FItems^)[b] := PCardinal(FItems^)[e];
    PCardinal(FItems^)[e] := tmp;
    Inc(b);
    Dec(e);
  end;
end;

procedure TListHelper.InternalReverse8;
var
  tmp: UInt64;
  b, e: Integer;
begin
  b := 0;
  e := FCount - 1;
  while b < e do
  begin
    tmp := PUInt64(FItems^)[b];
    PUInt64(FItems^)[b] := PUInt64(FItems^)[e];
    PUInt64(FItems^)[e] := tmp;
    Inc(b);
    Dec(e);
  end;
end;

procedure TListHelper.InternalReverseManaged;
var
  b, e: Integer;
begin
  b := 0;
  e := FCount - 1;
  while b < e do
  begin
    InternalExchangeManaged(b, e);
    Inc(b);
    Dec(e);
  end;
end;

procedure TListHelper.InternalReverseMRef(Kind: TTypeKind);
begin
  case Kind of
    TTypeKind.tkUString: DoReverseString;
    TTypeKind.tkInterface: DoReverseInterface;
    TTypeKind.tkVariant: DoReverseVariant;
    TTypeKind.tkDynArray: DoReverseDynArray;
    TTypeKind.tkLString: DoReverseByteString;
{$IF not Defined(NEXTGEN)}
    TTypeKind.tkWString: DoReverseWideString;
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    TTypeKind.tkClass: DoReverseObject;
{$ENDIF}
  end;
end;

procedure TListHelper.InternalReverseN;
var
  b, e: Integer;
begin
  b := 0;
  e := FCount - 1;
  while b < e do
  begin
    InternalExchangeN(b, e);
    Inc(b);
    Dec(e);
  end;
end;

procedure TListHelper.InternalSetCapacity(Value: NativeInt);
begin
  DynArraySetLength(FItems^, FTypeInfo, 1, @Value);
end;

procedure TListHelper.InternalSetCount1(Value: Integer);
begin
  if Value < 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Value > DynArraySize(FItems^) then
    InternalSetCapacity(Value);
  if Value < FCount then
    InternalDeleteRange1(Value, FCount - Value);
  FCount := Value;
end;

procedure TListHelper.InternalSetCount2(Value: Integer);
begin
  if Value < 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Value > DynArraySize(FItems^) then
    InternalSetCapacity(Value);
  if Value < FCount then
    InternalDeleteRange2(Value, FCount - Value);
  FCount := Value;
end;

procedure TListHelper.InternalSetCount4(Value: Integer);
begin
  if Value < 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Value > DynArraySize(FItems^) then
    InternalSetCapacity(Value);
  if Value < FCount then
    InternalDeleteRange4(Value, FCount - Value);
  FCount := Value;
end;

procedure TListHelper.InternalSetCount8(Value: Integer);
begin
  if Value < 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Value > DynArraySize(FItems^) then
    InternalSetCapacity(Value);
  if Value < FCount then
    InternalDeleteRange8(Value, FCount - Value);
  FCount := Value;
end;

procedure TListHelper.InternalSetCountManaged(Value: Integer);
begin
  if Value < 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Value > DynArraySize(FItems^) then
    InternalSetCapacity(Value);
  if Value < FCount then
    InternalDeleteRangeManaged(Value, FCount - Value);
  FCount := Value;
end;

procedure TListHelper.InternalSetCountMRef(Value: Integer);
begin
  if Value < 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Value > DynArraySize(FItems^) then
    InternalSetCapacity(Value);
  if Value < FCount then
    InternalDeleteRangeMRef(Value, FCount - Value);
  FCount := Value;
end;

{$IF Defined(WEAKREF)}
procedure TListHelper.InternalSetCountWeak(Value: Integer);
begin
  if Value < 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Value > DynArraySize(FItems^) then
    InternalSetCapacity(Value);
  if Value < FCount then
    InternalDeleteRangeWeak(Value, FCount - Value);
  FCount := Value;
end;
{$ENDIF}

procedure TListHelper.InternalSetCountN(Value: Integer);
begin
  if Value < 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  if Value > DynArraySize(FItems^) then
    InternalSetCapacity(Value);
  if Value < FCount then
    InternalDeleteRangeN(Value, FCount - Value);
  FCount := Value;
end;

procedure TListHelper.InternalToArray(var Dest: Pointer);
var
  LSize: NativeInt;
begin
  LSize := FCount;
  DynArraySetLength(Dest, FTypeInfo, 1, @LSize);
  Move(PByte(FItems^)[0], PByte(Dest)[0], LSize * ElSize);
end;

procedure TListHelper.InternalToArrayManaged(var Dest: Pointer);
var
  LSize: NativeInt;
begin
  LSize := FCount;
  DynArraySetLength(Dest, FTypeInfo, 1, @LSize);
  System.CopyArray(Dest, @PByte(FItems^)[0], ElType, LSize);
end;

{$POINTERMATH OFF}

{ TEnumerator<T> }

function TEnumerator<T>.MoveNext: Boolean;
begin
  Result := DoMoveNext;
end;

// The overridden destructor that simply invokes 'inherited' is
// required to instantiate the destructor for C++ code
destructor TEnumerable<T>.Destroy;
begin
  inherited;
end;

function TEnumerable<T>.GetEnumerator: TEnumerator<T>;
begin
  Result := DoGetEnumerator;
end;

function TEnumerable<T>.ToArray: TArray<T>;
var
  buf: TList<T>;
  x: T;
begin
  buf := TList<T>.Create;
  try
    for x in Self do
      buf.Add(x);
    Result := buf.ToArray; // relies on TList<T>.ToArray override
  finally
    buf.Free;
  end;
end;

function TEnumerable<T>.ToArrayImpl(Count: Integer): TArray<T>;
var
  Value: T;
begin
  // We assume our caller has passed correct Count
  SetLength(Result, Count);
  Count := 0;
  for Value in Self do
  begin
    Result[Count] := Value;
    Inc(Count);
  end;
end;

{ TList<T> }

function TList<T>.GetCapacity: Integer;
begin
  Result := Length(FItems);
end;

procedure TList<T>.SetCapacity(Value: Integer);
begin
  if Value < Count then
    Count := Value;
  SetLength(FItems, Value);
end;

procedure TList<T>.SetCount(Value: Integer);
begin
  if IsManagedType(T) then
  begin
{$IF Defined(WEAKREF)}
    if System.HasWeakRef(T) then
      FListHelper.InternalSetCountWeak(Value)
    else
{$ENDIF}
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FListHelper.InternalSetCountMRef(Value)
    else
      FListHelper.InternalSetCountManaged(Value);
  end else
  case SizeOf(T) of
    1: FListHelper.InternalSetCount1(Value);
    2: FListHelper.InternalSetCount2(Value);
    4: FListHelper.InternalSetCount4(Value);
    8: FListHelper.InternalSetCount8(Value);
  else
    FListHelper.InternalSetCountN(Value)
  end;
end;

function TList<T>.GetItem(Index: Integer): T;
begin
  FListHelper.CheckItemRange(Index);
  Result := FItems[Index];
end;

procedure TList<T>.SetItem(Index: Integer; const Value: T);
begin
  if IsManagedType(T) then
  begin
    if (SizeOf(T) = SizeOf(Pointer)) and not System.HasWeakRef(T) and (GetTypeKind(T) <> tkRecord) then
      FListHelper.SetItemMRef(Value, Index, GetTypeKind(T))
    else if GetTypeKind(T) = TTypeKind.tkVariant then
      FListHelper.SetItemVariant(Value, Index)
    else
      FListHelper.SetItemManaged(Value, Index);
  end else
  case SizeOf(T) of
    1: FListHelper.SetItem1(Value, Index);
    2: FListHelper.SetItem2(Value, Index);
    4: FListHelper.SetItem4(Value, Index);
    8: FListHelper.SetItem8(Value, Index);
  else
    FListHelper.SetItemN(Value, Index);
  end;
end;

//procedure TList<T>.Grow(ACount: Integer);
//begin
//  FListHelper.InternalGrow(Pointer(FItems), TypeInfo(arrayOfT), ACount);
//end;

procedure TList<T>.GrowCheck(ACount: Integer);
begin
  FListHelper.InternalGrowCheck(ACount);
end;

procedure TList<T>.Notify(const Item: T; Action: TCollectionNotification);
begin
  if Assigned(FOnNotify) then
    FOnNotify(Self, Item, Action);
end;

procedure TList<T>.Pack;
var
  IsEmpty: TListHelper.TInternalEmptyFunc;
begin
  IsEmpty := function (const Item): Boolean
    begin
      Result := FComparer.Compare(T(Item), Default(T)) = 0;
    end;
  if IsManagedType(T) then
    FListHelper.InternalPackManaged(IsEmpty)
  else
  case SizeOf(T) of
    1: FListHelper.InternalPack1(IsEmpty);
    2: FListHelper.InternalPack2(IsEmpty);
    4: FListHelper.InternalPack4(IsEmpty);
    8: FListHelper.InternalPack8(IsEmpty);
  else
    FListHelper.InternalPackN(IsEmpty);
  end;
end;

procedure TList<T>.Pack(const IsEmpty: TEmptyFunc);
var
  LIsEmpty: TListHelper.TInternalEmptyFunc;
begin
  LIsEmpty := function (const Item): Boolean
    begin
      Result := IsEmpty(T(Item), Default(T));
    end;
  if IsManagedType(T) then
    FListHelper.InternalPackManaged(LIsEmpty)
  else
  case SizeOf(T) of
    1: FListHelper.InternalPack1(LIsEmpty);
    2: FListHelper.InternalPack2(LIsEmpty);
    4: FListHelper.InternalPack4(LIsEmpty);
    8: FListHelper.InternalPack8(LIsEmpty);
  else
    FListHelper.InternalPackN(LIsEmpty);
  end;
end;

constructor TList<T>.Create;
begin
  Create(TComparer<T>.Default);
end;

constructor TList<T>.Create(const AComparer: IComparer<T>);
begin
  inherited Create;
  FListHelper.FNotify := InternalNotify;
  FListHelper.FCompare := InternalCompare;
  FListHelper.FTypeInfo := TypeInfo(arrayOfT);
  FComparer := AComparer;
  if FComparer = nil then
    FComparer := TComparer<T>.Default;
end;

constructor TList<T>.Create(const Collection: TEnumerable<T>);
begin
  inherited Create;
  FListHelper.FNotify := InternalNotify;
  FListHelper.FCompare := InternalCompare;
  FListHelper.FTypeInfo := TypeInfo(arrayOfT);
  FComparer := TComparer<T>.Default;
  InsertRange(0, Collection);
end;

destructor TList<T>.Destroy;
begin
  Capacity := 0;
  inherited;
end;

class procedure TList<T>.Error(const Msg: string; Data: NativeInt);
begin
  raise EListError.CreateFmt(Msg, [Data]) at ReturnAddress;
end;

{$IFNDEF NEXTGEN}
class procedure TList<T>.Error(Msg: PResStringRec; Data: NativeInt);
begin
  raise EListError.CreateFmt(LoadResString(Msg), [Data]) at ReturnAddress;
end;
{$ENDIF  NEXTGEN}

function TList<T>.DoGetEnumerator: TEnumerator<T>;
begin
  Result := GetEnumerator;
end;

function TList<T>.Add(const Value: T): Integer;
begin
  if IsManagedType(T) then
  begin
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      Result := FListHelper.InternalAddMRef(Value, GetTypeKind(T))
    else if GetTypeKind(T) = TTypeKind.tkVariant then
      Result := FListHelper.InternalAddVariant(Value)
    else
      Result := FListHelper.InternalAddManaged(Value);
  end else
  case SizeOf(T) of
    1: Result := FListHelper.InternalAdd1(Value);
    2: Result := FListHelper.InternalAdd2(Value);
    4: Result := FListHelper.InternalAdd4(Value);
    8: Result := FListHelper.InternalAdd8(Value);
  else
    Result := FListHelper.InternalAddN(Value);
  end;
end;
    
procedure TList<T>.AddRange(const Values: array of T);
begin
  InsertRange(Count, Values);
end;

procedure TList<T>.AddRange(const Collection: IEnumerable<T>);
begin
  InsertRange(Count, Collection);
end;

procedure TList<T>.AddRange(const Collection: TEnumerable<T>);
begin
  InsertRange(Count, Collection);
end;

function TList<T>.BinarySearch(const Item: T; out Index: Integer): Boolean;
begin
  Result := TArray.BinarySearch<T>(FItems, Item, Index, FComparer, 0, Count);
end;

function TList<T>.BinarySearch(const Item: T; out Index: Integer;
  const AComparer: IComparer<T>): Boolean;
begin
  Result := TArray.BinarySearch<T>(FItems, Item, Index, AComparer, 0, Count);
end;

procedure TList<T>.Insert(Index: Integer; const Value: T);
begin
  if IsManagedType(T) then
  begin
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FListHelper.InternalInsertMRef(Index, Value, GetTypeKind(T))
    else if GetTypeKind(T) = TTypeKind.tkVariant then
      FListHelper.InternalInsertVariant(Index, Value)
    else
      FListHelper.InternalInsertManaged(Index, Value);
  end else
  case SizeOf(T) of
    1: FListHelper.InternalInsert1(Index, Value);
    2: FListHelper.InternalInsert2(Index, Value);
    4: FListHelper.InternalInsert4(Index, Value);
    8: FListHelper.InternalInsert8(Index, Value);
  else
    FListHelper.InternalInsertN(Index, Value);
  end;
end;

procedure TList<T>.InsertRange(Index: Integer; const Values: array of T);
begin
  if IsManagedType(T) then
    FListHelper.InternalInsertRangeManaged(Index, @Values, Length(Values))
  else
  case SizeOf(T) of
    1: FListHelper.InternalInsertRange1(Index, @Values, Length(Values));
    2: FListHelper.InternalInsertRange2(Index, @Values, Length(Values));
    4: FListHelper.InternalInsertRange4(Index, @Values, Length(Values));
    8: FListHelper.InternalInsertRange8(Index, @Values, Length(Values));
  else
    FListHelper.InternalInsertRangeN(Index, @Values, Length(Values));
  end;
end;

procedure TList<T>.InsertRange(Index: Integer; const Collection: IEnumerable<T>);
var
  Item: T;
begin
  for Item in Collection do
  begin
    Insert(Index, Item);
    Inc(Index);
  end;
end;

procedure TList<T>.InsertRange(Index: Integer; const Collection: TEnumerable<T>);
var
  Item: T;
begin
  for Item in Collection do
  begin
    Insert(Index, Item);
    Inc(Index);
  end;
end;

function TList<T>.InternalCompare(const Left, Right): Integer;
begin
  Result := FComparer.Compare(T(Left), T(Right));
end;

procedure TList<T>.InternalNotify(const Item; Action: TCollectionNotification);
begin
  Notify(T(Item), Action);
end;

function TList<T>.ItemValue(const Item: T): NativeInt;
begin
  case SizeOf(T) of
    1: Result := PByte(@Item)[0] shl 0;
    2: Result := PByte(@Item)[0] shl 0 + PByte(@Item)[1] shl 8;
    3: Result := PByte(@Item)[0] shl 0 + PByte(@Item)[1] shl 8 + PByte(@Item)[2] shl 16;
{$IF SizeOf(Pointer) <= 4}
    4: Result := PByte(@Item)[0] shl 0 + PByte(@Item)[1] shl 8 + PByte(@Item)[2] shl 16 + PByte(@Item)[3] shl 24;
{$ELSE}
    4: Result := PByte(@Item)[0] shl 0 + PByte(@Item)[1] shl 8 + PByte(@Item)[2] shl 16 + PByte(@Item)[3] shl 24;
    5: Result := PByte(@Item)[0] shl 0 + PByte(@Item)[1] shl 8 + PByte(@Item)[2] shl 16 + PByte(@Item)[3] shl 24 +
       NativeInt(PByte(@Item)[4]) shl 32;
    6: Result := PByte(@Item)[0] shl 0 + PByte(@Item)[1] shl 8 + PByte(@Item)[2] shl 16 + PByte(@Item)[3] shl 24 +
       NativeInt(PByte(@Item)[4]) shl 32 + NativeInt(PByte(@Item)[5]) shl 40;
    7: Result := PByte(@Item)[0] shl 0 + PByte(@Item)[1] shl 8 + PByte(@Item)[2] shl 16 + PByte(@Item)[3] shl 24 +
       NativeInt(PByte(@Item)[4]) shl 32 + NativeInt(PByte(@Item)[5]) shl 40 + NativeInt(PByte(@Item)[6]) shl 48;
  else
    Result := PByte(@Item)[0] shl 0 + PByte(@Item)[1] shl 8 + PByte(@Item)[2] shl 16 + PByte(@Item)[3] shl 24 +
       NativeInt(PByte(@Item)[4]) shl 32 + NativeInt(PByte(@Item)[5]) shl 40 + NativeInt(PByte(@Item)[6]) shl 48 +
       NativeInt(PByte(@Item)[7]) shl 56;
{$ENDIF}
  end;
end;

procedure TList<T>.Exchange(Index1, Index2: Integer);
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FListHelper.InternalExchangeMRef(Index1, Index2, GetTypeKind(T))
    else
      FListHelper.InternalExchangeManaged(Index1, Index2)
  else
  case SizeOf(T) of
    1: FListHelper.InternalExchange1(Index1, Index2);
    2: FListHelper.InternalExchange2(Index1, Index2);
    4: FListHelper.InternalExchange4(Index1, Index2);
    8: FListHelper.InternalExchange8(Index1, Index2);
  else
    FListHelper.InternalExchangeN(Index1, Index2)
  end;
end;

procedure TList<T>.DoDelete(Index: Integer; Notification: TCollectionNotification);
begin
  if IsManagedType(T) then
  begin
{$IF Defined(WEAKREF)}
    if System.HasWeakRef(T) then
      FListHelper.InternalDoDeleteWeak(Index, Notification)
    else
{$ENDIF}
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FListHelper.InternalDoDeleteMRef(Index, Notification)
    else
      FListHelper.InternalDoDeleteManaged(Index, Notification);
  end else
  case SizeOf(T) of
    1: FListHelper.InternalDoDelete1(Index, Notification);
    2: FListHelper.InternalDoDelete2(Index, Notification);
    4: FListHelper.InternalDoDelete4(Index, Notification);
    8: FListHelper.InternalDoDelete8(Index, Notification);
  else
    FListHelper.InternalDoDeleteN(Index, Notification);
  end;
end;

procedure TList<T>.Delete(Index: Integer);
begin
  DoDelete(Index, cnRemoved);
end;

function TList<T>.ExtractItem(const Value: T; Direction: TDirection): T;
var
  Index: Integer;
begin
  if IsManagedType(T) then
  begin
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FListHelper.InternalExtractItemMRef(Value, GetTypeKind(T), Result, Byte(Direction))
    else if GetTypeKind(T) = TTypeKind.tkVariant then
      FListHelper.InternalExtractItemVariant(Value, Result, Byte(Direction))
    else
      FListHelper.InternalExtractItemManaged(Value, Result, Byte(Direction));
  end else
  case SizeOf(T) of
    1: FListHelper.InternalExtractItem1(Value, Result, Byte(Direction));
    2: FListHelper.InternalExtractItem2(Value, Result, Byte(Direction));
    4: FListHelper.InternalExtractItem4(Value, Result, Byte(Direction));
    8: FListHelper.InternalExtractItem8(Value, Result, Byte(Direction));
  else
    FListHelper.InternalExtractItemN(Value, Result, Byte(Direction))
  end;
end;

function TList<T>.Extract(const Value: T): T;
begin
  Result := ExtractItem(Value, TDirection.FromBeginning);
end;

function TList<T>.First: T;
begin
  Result := Items[0];
end;

function TList<T>.RemoveItem(const Value: T; Direction: TDirection): Integer;
begin
  if IsManagedType(T) then
{$IF Defined(WEAKREF)}
    if System.HasWeakRef(T) then
      FListHelper.InternalRemoveWeak(Value, Byte(Direction))
    else
{$ENDIF}
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      Result := FListHelper.InternalRemoveMRef(Value, Byte(Direction))
    else
      Result := FListHelper.InternalRemoveManaged(Value, Byte(Direction))
  else
  case SizeOf(T) of
    1: Result := FListHelper.InternalRemove1(Value, Byte(Direction));
    2: Result := FListHelper.InternalRemove2(Value, Byte(Direction));
    4: Result := FListHelper.InternalRemove4(Value, Byte(Direction));
    8: Result := FListHelper.InternalRemove8(Value, Byte(Direction));
  else
    Result := FListHelper.InternalRemoveN(Value, Byte(Direction))
  end;
end;

function TList<T>.Remove(const Value: T): Integer;
begin
  Result := RemoveItem(Value, TDirection.FromBeginning);
end;

procedure TList<T>.DeleteRange(AIndex, ACount: Integer);
begin
  if IsManagedType(T) then
  begin
{$IF Defined(WEAKREF)}
    if System.HasWeakRef(T) then
      FListHelper.InternalDeleteRangeWeak(AIndex, ACount)
    else
{$ENDIF}
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FListHelper.InternalDeleteRangeMRef(AIndex, ACount)
    else
      FListHelper.InternalDeleteRangeManaged(AIndex, ACount);
  end else
  case SizeOf(T) of
    1: FListHelper.InternalDeleteRange1(AIndex, ACount);
    2: FListHelper.InternalDeleteRange2(AIndex, ACount);
    4: FListHelper.InternalDeleteRange4(AIndex, ACount);
    8: FListHelper.InternalDeleteRange8(AIndex, ACount);
  else
    FListHelper.InternalDeleteRangeN(AIndex, ACount);
  end;
end;

procedure TList<T>.Clear;
begin
  if IsManagedType(T) then
  begin
{$IF Defined(WEAKREF)}
    if System.HasWeakRef(T) then
      FListHelper.InternalClearWeak
    else
{$ENDIF}
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FListHelper.InternalClearMRef
    else
      FListHelper.InternalClearManaged;
  end else
  case SizeOf(T) of
    1: FListHelper.InternalClear1;
    2: FListHelper.InternalClear2;
    4: FListHelper.InternalClear4;
    8: FListHelper.InternalClear8;
  else
    FListHelper.InternalClearN;
  end;
end;

function TList<T>.Expand: TList<T>;
begin
  if FListHelper.FCount = Length(FItems) then
    GrowCheck(FCount + 1);
  Result := Self;
end;

function TList<T>.IndexOfItem(const Value: T; Direction: TDirection): Integer;
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      Result := FListHelper.InternalIndexOfMRef(Value, Byte(Direction))
    else
      Result := FListHelper.InternalIndexOfN(Value, Byte(Direction))
  else
  case SizeOf(T) of
    1: Result := FListHelper.InternalIndexOf1(Value, Byte(Direction));
    2: Result := FListHelper.InternalIndexOf2(Value, Byte(Direction));
    4: Result := FListHelper.InternalIndexOf4(Value, Byte(Direction));
    8: Result := FListHelper.InternalIndexOf8(Value, Byte(Direction));
  else
    Result := FListHelper.InternalIndexOfN(Value, Byte(Direction));
  end;
end;

function TList<T>.IndexOf(const Value: T): Integer;
begin
  Result := IndexOfItem(Value, TDirection.FromBeginning);
end;

function TList<T>.Contains(const Value: T): Boolean;
begin
  Result := IndexOf(Value) >= 0;
end;

function TList<T>.Last: T;
begin
  Result := Items[Count - 1];
end;

function TList<T>.LastIndexOf(const Value: T): Integer;
begin
  Result := IndexOfItem(Value, TDirection.FromEnd);
end;

procedure TList<T>.Move(CurIndex, NewIndex: Integer);
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and not System.HasWeakRef(T) and (GetTypeKind(T) <> tkRecord) then
      FListHelper.InternalMoveMRef(CurIndex, NewIndex)
    else
      FListHelper.InternalMoveManaged(CurIndex, NewIndex)
  else
  case SizeOf(T) of
    1: FLIstHelper.InternalMove1(CurIndex, NewIndex);
    2: FLIstHelper.InternalMove2(CurIndex, NewIndex);
    4: FLIstHelper.InternalMove4(CurIndex, NewIndex);
    8: FLIstHelper.InternalMove8(CurIndex, NewIndex);
  else
    FLIstHelper.InternalMoveN(CurIndex, NewIndex);
  end;
end;

procedure TList<T>.Reverse;
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FListHelper.InternalReverseMRef(GetTypeKind(T))
    else
      FListHelper.InternalReverseManaged
  else
  case SizeOf(T) of
    1: FListHelper.InternalReverse1;
    2: FListHelper.InternalReverse2;
    4: FListHelper.InternalReverse4;
    8: FListHelper.InternalReverse8;
  else
    FListHelper.InternalReverseN;
  end;
end;

procedure TList<T>.Sort;
begin
  TArray.Sort<T>(FItems, FComparer, 0, Count);
end;

procedure TList<T>.Sort(const AComparer: IComparer<T>);
begin
  TArray.Sort<T>(FItems, AComparer, 0, Count);
end;

function TList<T>.ToArray: TArray<T>;
begin
  if IsManagedType(T) then
    FListHelper.InternalToArrayManaged(Pointer(Result))
  else
    FListHelper.InternalToArray(Pointer(Result));
end;

procedure TList<T>.TrimExcess;
begin
  FListHelper.InternalSetCapacity(Count);
end;

function TList<T>.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

{ TList<T>.TEnumerator }

constructor TList<T>.TEnumerator.Create(const AList: TList<T>);
begin
  inherited Create;
  FList := AList;
  FIndex := -1;
end;

function TList<T>.TEnumerator.DoGetCurrent: T;
begin
  Result := GetCurrent;
end;

function TList<T>.TEnumerator.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TList<T>.TEnumerator.GetCurrent: T;
begin
  Result := FList[FIndex];
end;

function TList<T>.TEnumerator.MoveNext: Boolean;
begin
  if FIndex >= FList.Count then
    Exit(False);
  Inc(FIndex);
  Result := FIndex < FList.Count;
end;

{$POINTERMATH ON}

{ TQueueHelper }

function TQueueHelper.GetElSize: Integer;
begin
  Result := FLH.ElSize;
end;

function TQueueHelper.GetElType: Pointer;
begin
  Result := FLH.ElType;
end;

function TQueueHelper.GetFItems: PPointer;
begin
  Result := FLH.FItems;
end;

procedure TQueueHelper.CheckEmpty;
begin
  if FLH.FCount = 0 then
    raise EListError.CreateRes(@SUnbalancedOperation);
end;

procedure TQueueHelper.DequeueAdjust(Notification: TCollectionNotification; const Item);
begin
  FTail := (FTail + 1) mod DynArraySize(FItems^);
  Dec(FLH.FCount);
  FLH.FNotify(Item, Notification);
end;

procedure TQueueHelper.DynArraySetLength(Value: NativeInt);
begin
  System.DynArraySetLength(FItems^, FLH.FTypeInfo, 1, @Value);
end;

procedure TQueueHelper.EnqueueAdjust(const Value);
begin
  FHead := (FHead + 1) mod DynArraySize(FItems^);
  Inc(FLH.FCount);
  FLH.FNotify(Value, cnAdded);
end;

function TQueueHelper.GetNewCap: Integer;
begin
  Result := DynArraySize(FItems^) * 2;
  if Result = 0 then
    Result := 4
  else if Result < 0 then
    OutOfMemoryError;
end;

procedure TQueueHelper.InternalSetCapacityInline(Value: Integer; ElemSize: Integer);
var
  TailCount, Offset: Integer;
begin
  Offset := Value - DynArraySize(FItems^);
  if Offset = 0 then
    Exit;

  // If head <= tail, then part of the queue wraps around
  // the end of the array; don't introduce a gap in the queue.
  if (FHead < FTail) or ((FHead = FTail) and (FLH.FCount > 0)) then
    TailCount := DynArraySize(FItems^) - FTail
  else
    TailCount := 0;

  if Offset > 0 then
    DynArraySetLength(Value);
  if TailCount > 0 then
  begin
    Move(PByte(FItems^)[FTail * ElemSize], PByte(FItems^)[(FTail + Offset) * ElemSize], TailCount * ElemSize);
    Inc(FTail, Offset);
  end else if FTail > 0 then
  begin
    Move(PByte(FItems^)[FTail * ElemSize], PByte(FItems^)[0], FLH.FCount * ElemSize);
    Dec(FHead, FTail);
    FTail := 0;
  end;
  if Offset < 0 then
  begin
    DynArraySetLength(Value);
    if Value = 0 then
      FHead := 0
    else
      FHead := FHead mod DynArraySize(FItems^);
  end;
end;

procedure TQueueHelper.InternalEnqueueString(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrowMRef;
  PString(FItems^)[FHead] := string(Value);
  EnqueueAdjust(Value);
end;

procedure TQueueHelper.InternalEnqueueInterface(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrowMRef;
  TListHelper.PInterface(FItems^)[FHead] := IInterface(Value);
  EnqueueAdjust(Value);
end;

procedure TQueueHelper.InternalEnqueueByteString(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrowMRef;
  PRawByteString(FItems^)[FHead] := RawByteString(Value);
  EnqueueAdjust(Value);
end;

procedure TQueueHelper.InternalEnqueueDynArray(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrowMRef;
  TListHelper.PBytes(FItems^)[FLH.FCount] := TBytes(Value);
  EnqueueAdjust(Value);
end;

{$IF not Defined(NEXTGEN)}
procedure TQueueHelper.InternalEnqueueWideString(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrowMRef;
  PWideString(FItems^)[FHead] := WideString(Value);
  EnqueueAdjust(Value);
end;
{$ENDIF}

{$IF Defined(AUTOREFCOUNT)}
procedure TQueueHelper.InternalEnqueueObject(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrowMRef;
  PObject(FItems^)[FHead] := TObject(Value);
  EnqueueAdjust(Value);
end;
{$ENDIF}

procedure TQueueHelper.InternalEnqueue1(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrow1;
  PByte(FItems^)[FHead] := Byte(Value);
  EnqueueAdjust(Value);
end;

procedure TQueueHelper.InternalEnqueue2(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrow2;
  PWord(FItems^)[FHead] := Word(Value);
  EnqueueAdjust(Value);
end;

procedure TQueueHelper.InternalEnqueue4(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrow4;
  PCardinal(FItems^)[FHead] := Cardinal(Value);
  EnqueueAdjust(Value);
end;

procedure TQueueHelper.InternalEnqueue8(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrow8;
  PUInt64(FItems^)[FHead] := UInt64(Value);
  EnqueueAdjust(Value);
end;

procedure TQueueHelper.InternalEnqueueManaged(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrowManaged;
  System.CopyArray(@PByte(FItems^)[FHead * ElSize], @Value, ElType, 1);
  EnqueueAdjust(Value);
end;

procedure TQueueHelper.InternalEnqueueMRef(const Value; Kind: TTypeKind);
begin
  case Kind of
    TTypeKind.tkUString: InternalEnqueueString(Value);
    TTypeKind.tkDynArray: InternalEnqueueDynArray(Value);
    TTypeKind.tkInterface: InternalEnqueueInterface(Value);
    TTypeKind.tkLString: InternalEnqueueByteString(Value);
{$IF not Defined(NEXTGEN)}
    TTypeKind.tkWString: InternalEnqueueWideString(Value);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    TTypeKind.tkClass: InternalEnqueueObject(Value);
{$ENDIF}
  end;
end;

procedure TQueueHelper.InternalEnqueueN(const Value);
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrowN;
  Move(Value, PByte(FItems^)[FHead * ElSize], ElSize);
  EnqueueAdjust(Value);
end;

procedure TQueueHelper.InternalDequeueString(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  string(Item) := PString(FItems^)[FTail];
  if not Peek then
  begin
    PString(FItems^)[FTail] := '';
    DequeueAdjust(Notification, Item);
  end;
end;

procedure TQueueHelper.InternalDequeueInterface(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  IInterface(Item) := TListHelper.PInterface(FItems^)[FTail];
  if not Peek then
  begin
    TListHelper.PInterface(FItems^)[FTail] := nil;
    DequeueAdjust(Notification, Item);
  end;
end;

procedure TQueueHelper.InternalDequeueByteString(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  RawByteString(Item) := PRawByteString(FItems^)[FTail];
  if not Peek then
  begin
    PRawByteString(FItems^)[FTail] := '';
    DequeueAdjust(Notification, Item);
  end;
end;

procedure TQueueHelper.InternalDequeueDynArray(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  TBytes(Item) := TListHelper.PBytes(FItems^)[FTail];
  if not Peek then
  begin
    TListHelper.PBytes(FItems^)[FTail] := nil;
    DequeueAdjust(Notification, Item);
  end;
end;

{$IF not Defined(NEXTGEN)}
procedure TQueueHelper.InternalDequeueWideString(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  WideString(Item) := PWideString(FItems^)[FTail];
  if not Peek then
  begin
    PWideString(FItems^)[FTail] := '';
    DequeueAdjust(Notification, Item);
  end;
end;
{$ENDIF}

{$IF Defined(AUTOREFCOUNT)}
procedure TQueueHelper.InternalDequeueObject(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  TObject(Item) := PObject(FItems^)[FTail];
  if not Peek then
  begin
    PObject(FItems^)[FTail] := nil;
    DequeueAdjust(Notification, Item);
  end;
end;
{$ENDIF}

procedure TQueueHelper.InternalDequeue1(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  Byte(Item) := PByte(FItems^)[FTail];
  if not Peek then
    DequeueAdjust(Notification, Item);
end;

procedure TQueueHelper.InternalDequeue2(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  Word(Item) := PWord(FItems^)[FTail];
  if not Peek then
    DequeueAdjust(Notification, Item);
end;

procedure TQueueHelper.InternalDequeue4(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  Cardinal(Item) := PCardinal(FItems^)[FTail];
  if not Peek then
    DequeueAdjust(Notification, Item);
end;

procedure TQueueHelper.InternalDequeue8(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  UInt64(Item) := PUInt64(FItems^)[FTail];
  if not Peek then
    DequeueAdjust(Notification, Item);
end;

procedure TQueueHelper.InternalDequeueManaged(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  System.CopyArray(@Item, @PByte(FItems^)[FTail * ElSize], ElType, 1);
  if not Peek then
  begin
    FinalizeArray(@PByte(FItems^)[FTail * ElSize], ElType, 1);
    DequeueAdjust(Notification, Item);
  end;
end;

procedure TQueueHelper.InternalDequeueMRef(Notification: TCollectionNotification; Peek: Boolean; out Item; Kind: TTypeKind);
begin
  case Kind of
    TTypeKind.tkUString: InternalDequeueString(Notification, Peek, Item);
    TTypeKind.tkDynArray: InternalDequeueDynArray(Notification, Peek, Item);
    TTypeKind.tkInterface: InternalDequeueInterface(Notification, Peek, Item);
    TTypeKind.tkLString: InternalDequeueByteString(Notification, Peek, Item);
{$IF not Defined(NEXTGEN)}
    TTypeKind.tkWString: InternalDequeueWideString(Notification, Peek, Item);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    TTypeKind.tkClass: InternalDequeueObject(Notification, Peek, Item);
{$ENDIF}
  end;
end;

procedure TQueueHelper.InternalDequeueN(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  Move(PByte(FItems^)[FTail * ElSize], Item, ElSize);
  if not Peek then
    DequeueAdjust(Notification, Item);
end;

procedure TQueueHelper.InternalClearString;
var
  Temp: string;
begin
  while FLH.FCount > 0 do
    InternalDequeueString(cnRemoved, False, Temp);
  FHead := 0;
  FTail := 0;
  FLH.FCount := 0;
end;

procedure TQueueHelper.InternalClearInterface;
var
  Temp: IInterface;
begin
  while FLH.FCount > 0 do
    InternalDequeueInterface(cnRemoved, False, Temp);
  FHead := 0;
  FTail := 0;
  FLH.FCount := 0;
end;

procedure TQueueHelper.InternalClearByteString;
var
  Temp: RawByteString;
begin
  while FLH.FCount > 0 do
    InternalDequeueByteString(cnRemoved, False, Temp);
  FHead := 0;
  FTail := 0;
  FLH.FCount := 0;
end;

procedure TQueueHelper.InternalClearDynArray;
var
  Temp: TBytes;
begin
  while FLH.FCount > 0 do
    InternalDequeueDynArray(cnRemoved, False, Temp);
  FHead := 0;
  FTail := 0;
  FLH.FCount := 0;
end;

{$IF not Defined(NEXTGEN)}
procedure TQueueHelper.InternalClearWideString;
var
  Temp: WideString;
begin
  while FLH.FCount > 0 do
    InternalDequeueWideString(cnRemoved, False, Temp);
  FHead := 0;
  FTail := 0;
  FLH.FCount := 0;
end;
{$ENDIF}

{$IF Defined(AUTOREFCOUNT)}
procedure TQueueHelper.InternalClearObject;
var
  Temp: TObject;
begin
  while FLH.FCount > 0 do
    InternalDequeueObject(cnRemoved, False, Temp);
  FHead := 0;
  FTail := 0;
  FLH.FCount := 0;
end;
{$ENDIF}

procedure TQueueHelper.InternalClear1;
var
  Temp: Byte;
begin
  while FLH.FCount > 0 do
    InternalDequeue1(cnRemoved, False, Temp);
  FHead := 0;
  FTail := 0;
  FLH.FCount := 0;
end;

procedure TQueueHelper.InternalClear2;
var
  Temp: Word;
begin
  while FLH.FCount > 0 do
    InternalDequeue2(cnRemoved, False, Temp);
  FHead := 0;
  FTail := 0;
  FLH.FCount := 0;
end;

procedure TQueueHelper.InternalClear4;
var
  Temp: Cardinal;
begin
  while FLH.FCount > 0 do
    InternalDequeue4(cnRemoved, False, Temp);
  FHead := 0;
  FTail := 0;
  FLH.FCount := 0;
end;

procedure TQueueHelper.InternalClear8;
var
  Temp: UInt64;
begin
  while FLH.FCount > 0 do
    InternalDequeue8(cnRemoved, False, Temp);
  FHead := 0;
  FTail := 0;
  FLH.FCount := 0;
end;

procedure TQueueHelper.InternalClearManaged;
var
  STemp: array[0..63] of Byte;
  DTemp: PByte;
  PTemp: PByte;
begin
  PTemp := @STemp[0];
  DTemp := nil;
  try
    if SizeOf(STemp) < ElSize then
    begin
      DTemp := AllocMem(ElSize);
      PTemp := DTemp;
    end else
      FillChar(STemp, SizeOf(STemp), 0);
    while FLH.FCount > 0 do
      InternalDequeueManaged(cnRemoved, False, PTemp[0]);
    FHead := 0;
    FTail := 0;
    FLH.FCount := 0;
  finally
    FinalizeArray(@PTemp[0], ElType, 1);
    FreeMem(DTemp);
  end;
end;

procedure TQueueHelper.InternalClearMRef(Kind: TTypeKind);
begin
  case Kind of
    TTypeKind.tkUString: InternalClearString;
    TTypeKind.tkDynArray: InternalClearDynArray;
    TTypeKind.tkInterface: InternalClearInterface;
    TTypeKind.tkLString: InternalClearByteString;
{$IF not Defined(NEXTGEN)}
    TTypeKind.tkWString: InternalClearWideString;
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    TTypeKind.tkClass: InternalClearObject;
{$ENDIF}
  end;
end;

procedure TQueueHelper.InternalClearN;
var
  STemp: array[0..63] of Byte;
  DTemp: PByte;
  PTemp: PByte;
begin
  PTemp := @STemp[0];
  DTemp := nil;
  try
    if SizeOf(STemp) < ElSize then
    begin
      GetMem(DTemp, ElSize);
      PTemp := DTemp;
    end;
    while FLH.FCount > 0 do
      InternalDequeueN(cnRemoved, False, PTemp[0]);
    FHead := 0;
    FTail := 0;
    FLH.FCount := 0;
  finally
    FreeMem(DTemp);
  end;
end;

procedure TQueueHelper.InternalGrow1;
begin
  InternalSetCapacity1(GetNewCap);
end;

procedure TQueueHelper.InternalGrow2;
begin
  InternalSetCapacity2(GetNewCap);
end;

procedure TQueueHelper.InternalGrow4;
begin
  InternalSetCapacity4(GetNewCap);
end;

procedure TQueueHelper.InternalGrow8;
begin
  InternalSetCapacity8(GetNewCap);
end;

procedure TQueueHelper.InternalGrowManaged;
begin
  InternalSetCapacityManaged(GetNewCap);
end;

procedure TQueueHelper.InternalGrowMRef;
begin
  InternalSetCapacityMRef(GetNewCap);
end;

procedure TQueueHelper.InternalGrowN;
begin
  InternalSetCapacityN(GetNewCap);
end;

procedure TQueueHelper.InternalSetCapacity1(Value: Integer);
begin
  InternalSetCapacityInline(Value, SizeOf(Byte));
end;

procedure TQueueHelper.InternalSetCapacity2(Value: Integer);
begin
  InternalSetCapacityInline(Value, SizeOf(Word));
end;

procedure TQueueHelper.InternalSetCapacity4(Value: Integer);
begin
  InternalSetCapacityInline(Value, SizeOf(Cardinal));
end;

procedure TQueueHelper.InternalSetCapacity8(Value: Integer);
begin
  InternalSetCapacityInline(Value, SizeOf(UInt64));
end;

procedure TQueueHelper.InternalSetCapacityManaged(Value: Integer);
var
  TailCount, Offset: Integer;
  Items: PByte;
begin
  Offset := Value - DynArraySize(FItems^);
  if Offset = 0 then
    Exit;

  // If head <= tail, then part of the queue wraps around
  // the end of the array; don't introduce a gap in the queue.
  if (FHead < FTail) or ((FHead = FTail) and (FLH.FCount > 0)) then
    TailCount := DynArraySize(FItems^) - FTail
  else
    TailCount := 0;

  if Offset > 0 then
    DynArraySetLength(Value);
  Items := PByte(FItems^);
  if TailCount > 0 then
  begin
    CopyArray(@Items[(FTail + Offset) * ElSize], @Items[FTail * ElSize], ElType, ElSize, TailCount);
    if Offset > 0 then
      FinalizeArray(@Items[FTail * ElSize], ElType, Offset)
    else if Offset < 0 then
      FinalizeArray(@Items[FLH.FCount * ElSize], ElType, (- Offset));
    Inc(FTail, Offset);
  end
  else if FTail > 0 then
  begin
    if FLH.FCount > 0 then
    begin
      CopyArray(@Items[0], @Items[FTail * ElSize], ElType, ElSize, FLH.FCount);
      FinalizeArray(@Items[FLH.FCount * ElSize], ElType, FTail);
    end;
    Dec(FHead, FTail);
    FTail := 0;
  end;
  if Offset < 0 then
  begin
    DynArraySetLength(Value);
    if Value = 0 then
      FHead := 0
    else
      FHead := FHead mod DynArraySize(FItems^);
  end;
end;

procedure TQueueHelper.InternalSetCapacityMRef(Value: Integer);
var
  TailCount, Offset: Integer;
begin
  Offset := Value - DynArraySize(FItems^);
  if Offset = 0 then
    Exit;

  // If head <= tail, then part of the queue wraps around
  // the end of the array; don't introduce a gap in the queue.
  if (FHead < FTail) or ((FHead = FTail) and (FLH.FCount > 0)) then
    TailCount := DynArraySize(FItems^) - FTail
  else
    TailCount := 0;

  if Offset > 0 then
    DynArraySetLength(Value);
  if TailCount > 0 then
  begin
    Move(PByte(FItems^)[FTail * SizeOf(Pointer)], PByte(FItems^)[(FTail + Offset) * SizeOf(Pointer)], TailCount * SizeOf(Pointer));
    if offset > 0 then
      FillChar(PByte(FItems^)[FTail * SizeOf(Pointer)], Offset * SizeOf(Pointer), 0)
    else if offset < 0 then
      FillChar(PByte(FItems^)[FLH.FCount * SizeOf(Pointer)], (-Offset) * SizeOf(Pointer), 0);
    Inc(FTail, Offset);
  end else if FTail > 0 then
  begin
    if FLH.FCount > 0 then
    begin
      Move(PByte(FItems^)[FTail * SizeOf(Pointer)], PByte(FItems^)[0], FLH.FCount * SizeOf(Pointer));
      FillChar(PByte(FItems^)[FLH.FCount * SizeOf(Pointer)], FTail * SizeOf(Pointer), 0);
    end;
    Dec(FHead, FTail);
    FTail := 0;
  end;
  if Offset < 0 then
  begin
    DynArraySetLength(Value);
    if Value = 0 then
      FHead := 0
    else
      FHead := FHead mod DynArraySize(FItems^);
  end;
end;

procedure TQueueHelper.InternalSetCapacityN(Value: Integer);
begin
  InternalSetCapacityInline(Value, ElSize);
end;

{$POINTERMATH OFF}

{ TQueue<T> }

procedure TQueue<T>.Notify(const Item: T; Action: TCollectionNotification);
begin
  if Assigned(FOnNotify) then
    FOnNotify(Self, Item, Action);
end;

constructor TQueue<T>.Create;
begin
  inherited Create;
  FQueueHelper.FLH.FNotify := InternalNotify;
  FQueueHelper.FLH.FCompare := InternalCompare;
  FQueueHelper.FLH.FTypeInfo := TypeInfo(arrayOfT);
end;

destructor TQueue<T>.Destroy;
begin
  Clear;
  inherited;
end;

procedure TQueue<T>.SetCapacity(Value: Integer);
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FQueueHelper.InternalSetCapacityMRef(Value)
    else
      FQueueHelper.InternalSetCapacityManaged(Value)
  else
  case SizeOf(T) of
    1: FQueueHelper.InternalSetCapacity1(Value);
    2: FQueueHelper.InternalSetCapacity2(Value);
    4: FQueueHelper.InternalSetCapacity4(Value);
    8: FQueueHelper.InternalSetCapacity8(Value);
  else
    FQueueHelper.InternalSetCapacityN(Value);
  end;
end;

function TQueue<T>.DoDequeue(Notification: TCollectionNotification): T;
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FQueueHelper.InternalDequeueMRef(Notification, False, Result, GetTypeKind(T))
    else
      FQueueHelper.InternalDequeueManaged(Notification, False, Result)
  else
  case SizeOf(T) of
    1: FQueueHelper.InternalDequeue1(Notification, False, Result);
    2: FQueueHelper.InternalDequeue2(Notification, False, Result);
    4: FQueueHelper.InternalDequeue4(Notification, False, Result);
    8: FQueueHelper.InternalDequeue8(Notification, False, Result);
  else
    FQueueHelper.InternalDequeueN(Notification, False, Result);
  end;
end;

function TQueue<T>.DoGetEnumerator: TEnumerator<T>;
begin
  Result := GetEnumerator;
end;

procedure TQueue<T>.DoSetCapacity(Value: Integer);
begin
  if Value < Count then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  SetCapacity(Value);
end;

function TQueue<T>.Dequeue: T;
begin
  Result := DoDequeue(cnRemoved);
end;

procedure TQueue<T>.Enqueue(const Value: T);
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FQueueHelper.InternalEnqueueMRef(Value, GetTypeKind(T))
    else
      FQueueHelper.InternalEnqueueManaged(Value)
  else
  case SizeOf(T) of
    1: FQueueHelper.InternalEnqueue1(Value);
    2: FQueueHelper.InternalEnqueue2(Value);
    4: FQueueHelper.InternalEnqueue4(Value);
    8: FQueueHelper.InternalEnqueue8(Value);
  else
    FQueueHelper.InternalEnqueueN(Value);
  end;
end;

function TQueue<T>.Extract: T;
begin
  Result := DoDequeue(cnExtracted);
end;

constructor TQueue<T>.Create(const Collection: TEnumerable<T>);
var
  Item: T;
begin
  inherited Create;
  FQueueHelper.FLH.FNotify := InternalNotify;
  FQueueHelper.FLH.FCompare := InternalCompare;
  FQueueHelper.FLH.FTypeInfo := TypeInfo(arrayOfT);
  for Item in Collection do
    Enqueue(Item);
end;

function TQueue<T>.Peek: T;
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FQueueHelper.InternalDequeueMRef(cnRemoved, True, Result, GetTypeKind(T))
    else
      FQueueHelper.InternalDequeueManaged(cnRemoved, True, Result)
  else
  case SizeOf(T) of
    1: FQueueHelper.InternalDequeue1(cnRemoved, True, Result);
    2: FQueueHelper.InternalDequeue2(cnRemoved, True, Result);
    4: FQueueHelper.InternalDequeue4(cnRemoved, True, Result);
    8: FQueueHelper.InternalDequeue8(cnRemoved, True, Result);
  else
    FQueueHelper.InternalDequeueN(cnRemoved, True, Result);
  end;
end;

procedure TQueue<T>.Clear;
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FQueueHelper.InternalClearMRef(GetTypeKind(T))
    else
      FQueueHelper.InternalClearManaged
  else
  case SizeOf(T) of
    1: FQueueHelper.InternalClear1;
    2: FQueueHelper.InternalClear2;
    4: FQueueHelper.InternalClear4;
    8: FQueueHelper.InternalClear8;
  else
    FQueueHelper.InternalClearN;
  end;
end;

function TQueue<T>.ToArray: TArray<T>;
begin
  Result := ToArrayImpl(Count);
end;

procedure TQueue<T>.TrimExcess;
begin
  SetCapacity(Count);
end;

function TQueue<T>.InternalCompare(const Left, Right): Integer;
begin
  Result := 0;
end;

procedure TQueue<T>.InternalNotify(const Item; Action: TCollectionNotification);
begin
  Notify(T(Item), Action);
end;

function TQueue<T>.GetCapacity: Integer;
begin
  Result := Length(FItems);
end;

function TQueue<T>.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

{ TQueue<T>.TEnumerator }

constructor TQueue<T>.TEnumerator.Create(const AQueue: TQueue<T>);
begin
  inherited Create;
  FQueue := AQueue;
  FIndex := -1;
end;

function TQueue<T>.TEnumerator.DoGetCurrent: T;
begin
  Result := GetCurrent;
end;

function TQueue<T>.TEnumerator.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TQueue<T>.TEnumerator.GetCurrent: T;
begin
  Result := FQueue.FItems[(FQueue.FQueueHelper.FTail + FIndex) mod Length(FQueue.FItems)];
end;

function TQueue<T>.TEnumerator.MoveNext: Boolean;
begin
  if FIndex >= FQueue.Count then
    Exit(False);
  Inc(FIndex);
  Result := FIndex < FQueue.Count;
end;

{$POINTERMATH ON}

{ TStackHelper }

function TStackHelper.GetElSize: Integer;
begin
  Result := FLH.ElSize;
end;

function TStackHelper.GetElType: Pointer;
begin
  Result := FLH.ElType
end;

function TStackHelper.GetFItems: PPointer;
begin
  Result := FLH.FItems;
end;

procedure TStackHelper.CheckEmpty;
begin
  if FLH.FCount = 0 then
    raise EListError.CreateRes(@SUnbalancedOperation);
end;

procedure TStackHelper.CheckGrow;
begin
  if FLH.FCount = DynArraySize(FItems^) then
    InternalGrow;
end;

procedure TStackHelper.PopAdjust(const Value; Notification: TCollectionNotification);
begin
  Dec(FLH.FCount);
  FLH.FNotify(Value, Notification);
end;

procedure TStackHelper.PushAdjust(const Value);
begin
  Inc(FLH.FCount);
  FLH.FNotify(Value, cnAdded);
end;

procedure TStackHelper.InternalDoPopString(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  string(Item) := PString(FItems^)[FLH.FCount - 1];
  if not Peek then
  begin
    PString(FItems^)[FLH.FCount - 1] := '';
    PopAdjust(Item, Notification);
  end;
end;

procedure TStackHelper.InternalDoPopInterface(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  IInterface(Item) := TListHelper.PInterface(FItems^)[FLH.FCount - 1];
  if not Peek then
  begin
    TListHelper.PInterface(FItems^)[FLH.FCount - 1] := nil;
    PopAdjust(Item, Notification);
  end;
end;

procedure TStackHelper.InternalDoPopByteString(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  RawByteString(Item) := PRawByteString(FItems^)[FLH.FCount - 1];
  if not Peek then
  begin
    PRawByteString(FItems^)[FLH.FCount - 1] := '';
    PopAdjust(Item, Notification);
  end;
end;

procedure TStackHelper.InternalDoPopDynArray(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  TBytes(Item) := TListHelper.PBytes(FItems^)[FLH.FCount - 1];
  if not Peek then
  begin
    TListHelper.PBytes(FItems^)[FLH.FCount - 1] := nil;
    PopAdjust(Item, Notification);
  end;
end;

{$IF not Defined(NEXTGEN)}
procedure TStackHelper.InternalDoPopWideString(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  WideString(Item) := PWideString(FItems^)[FLH.FCount - 1];
  if not Peek then
  begin
    PWideString(FItems^)[FLH.FCount - 1] := '';
    PopAdjust(Item, Notification);
  end;
end;
{$ENDIF}

{$IF Defined(AUTOREFCOUNT)}
procedure TStackHelper.InternalDoPopObject(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  TObject(Item) := PObject(FItems^)[FLH.FCount - 1];
  if not Peek then
  begin
    PObject(FItems^)[FLH.FCount - 1] := nil;
    PopAdjust(Item, Notification);
  end;
end;
{$ENDIF}

procedure TStackHelper.InternalClearString;
var
  Temp: string;
begin
  while FLH.FCount > 0 do
    InternalDoPopString(cnRemoved, False, Temp);
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;

procedure TStackHelper.InternalClearInterface;
var
  Temp: IInterface;
begin
  while FLH.FCount > 0 do
    InternalDoPopInterface(cnRemoved, False, Temp);
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;

procedure TStackHelper.InternalClearByteString;
var
  Temp: RawByteString;
begin
  while FLH.FCount > 0 do
    InternalDoPopByteString(cnRemoved, False, Temp);
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;

procedure TStackHelper.InternalClearDynArray;
var
  Temp: TBytes;
begin
  while FLH.FCount > 0 do
    InternalDoPopDynArray(cnRemoved, False, Temp);
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;

{$IF not Defined(NEXTGEN)}
procedure TStackHelper.InternalClearWideString;
var
  Temp: WideString;
begin
  while FLH.FCount > 0 do
    InternalDoPopWideString(cnRemoved, False, Temp);
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;
{$ENDIF}

{$IF Defined(AUTOREFCOUNT)}
procedure TStackHelper.InternalClearObject;
var
  Temp: TObject;
begin
  while FLH.FCount > 0 do
    InternalDoPopObject(cnRemoved, False, Temp);
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;
{$ENDIF}

procedure TStackHelper.InternalClear1;
var
  Temp: Byte;
begin
  while FLH.FCount > 0 do
    InternalDoPop1(cnRemoved, False, Temp);
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;

procedure TStackHelper.InternalClear2;
var
  Temp: Word;
begin
  while FLH.FCount > 0 do
    InternalDoPop2(cnRemoved, False, Temp);
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;

procedure TStackHelper.InternalClear4;
var
  Temp: Cardinal;
begin
  while FLH.FCount > 0 do
    InternalDoPop4(cnRemoved, False, Temp);
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;

procedure TStackHelper.InternalClear8;
var
  Temp: UInt64;
begin
  while FLH.FCount > 0 do
    InternalDoPop8(cnRemoved, False, Temp);
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;

procedure TStackHelper.InternalClearManaged;
var
  STemp: array[0..63] of Byte;
  DTemp: PByte;
  PTemp: PByte;
begin
  PTemp := @STemp[0];
  DTemp := nil;
  try
    if SizeOf(STemp) < ElSize then
    begin
      DTemp := AllocMem(ElSize);
      PTemp := DTemp;
    end else
      FillChar(STemp, SizeOf(STemp), 0);
    while FLH.FCount > 0 do
      InternalDoPopManaged(cnRemoved, False, PTemp[0]);
  finally
    FinalizeArray(@PTemp[0], ElType, 1);
    FreeMem(DTemp);
  end;
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;

procedure TStackHelper.InternalClearMRef(Kind: TTypeKind);
begin
  case Kind of
    TTypeKind.tkUString: InternalClearString;
    TTypeKind.tkDynArray: InternalClearDynArray;
    TTypeKind.tkInterface: InternalClearInterface;
    TTypeKind.tkLString: InternalClearByteString;
{$IF not Defined(NEXTGEN)}
    TTypeKind.tkWString: InternalClearWideString;
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    TTypeKind.tkClass: InternalClearObject;
{$ENDIF}
  end;
end;

procedure TStackHelper.InternalClearN;
var
  STemp: array[0..63] of Byte;
  DTemp: PByte;
  PTemp: PByte;
begin
  PTemp := @STemp[0];
  DTemp := nil;
  try
    if SizeOf(STemp) < ElSize then
    begin
      GetMem(DTemp, ElSize);
      PTemp := DTemp;
    end;
    while FLH.FCount > 0 do
      InternalDoPopN(cnRemoved, False, PTemp[0]);
  finally
    FreeMem(DTemp);
  end;
  DynArrayClear(FItems^, FLH.FTypeInfo);
end;

procedure TStackHelper.InternalDoPop1(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  Byte(Item) := PByte(FItems^)[FLH.FCount - 1];
  if not Peek then
    PopAdjust(Item, Notification);
end;

procedure TStackHelper.InternalDoPop2(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  Word(Item) := PWord(FItems^)[FLH.FCount - 1];
  if not Peek then
    PopAdjust(Item, Notification);
end;

procedure TStackHelper.InternalDoPop4(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  Cardinal(Item) := PCardinal(FItems^)[FLH.FCount - 1];
  if not Peek then
    PopAdjust(Item, Notification);
end;

procedure TStackHelper.InternalDoPop8(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  UInt64(Item) := PUInt64(FItems^)[FLH.FCount - 1];
  if not Peek then
    PopAdjust(Item, Notification);
end;

procedure TStackHelper.InternalDoPopManaged(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  System.CopyArray(@Item, @PByte(FItems^)[(FLH.FCount - 1) * ElSize], ElType, 1);
  if not Peek then
  begin
    FinalizeArray(@PByte(FItems^)[(FLH.FCount - 1) * ElSize], ElType, 1);
    PopAdjust(Item, Notification);
  end;
end;

procedure TStackHelper.InternalDoPopMRef(Notification: TCollectionNotification; Peek: Boolean; out Item; Kind: TTypeKind);
begin
  case Kind of
    TTypeKind.tkUString: InternalDoPopString(Notification, Peek, Item);
    TTypeKind.tkDynArray: InternalDoPopDynArray(Notification, Peek, Item);
    TTypeKind.tkInterface: InternalDoPopInterface(Notification, Peek, Item);
    TTypeKind.tkLString: InternalDoPopByteString(Notification, Peek, Item);
{$IF not Defined(NEXTGEN)}
    TTypeKind.tkWString: InternalDoPopWideString(Notification, Peek, Item);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    TTypeKind.tkClass: InternalDoPopObject(Notification, Peek, Item);
{$ENDIF}
  end;
end;

procedure TStackHelper.InternalDoPopN(Notification: TCollectionNotification; Peek: Boolean; out Item);
begin
  CheckEmpty;
  Move(PByte(FItems^)[(FLH.FCount - 1) * ElSize], Item, ElSize);
  if not Peek then
    PopAdjust(Item, Notification);
end;

procedure TStackHelper.InternalGrow;
var
  NewCap: NativeInt;
begin
  NewCap := DynArraySize(FItems^) * 2;
  if NewCap = 0 then
    NewCap := 4
  else if NewCap < 0 then
    OutOfMemoryError;
  DynArraySetLength(FItems^, FLH.FTypeInfo, 1, @NewCap);
end;

procedure TStackHelper.InternalPushString(const Value);
begin
  CheckGrow;
  PString(FItems^)[FLH.FCount] := string(Value);
  PushAdjust(Value);
end;

procedure TStackHelper.InternalPushInterface(const Value);
begin
  CheckGrow;
  TListHelper.PInterface(FItems^)[FLH.FCount] := IInterface(Value);
  PushAdjust(Value);
end;

procedure TStackHelper.InternalPushByteString(const Value);
begin
  CheckGrow;
  PRawByteString(FItems^)[FLH.FCount] := RawByteString(Value);
  PushAdjust(Value);
end;

procedure TStackHelper.InternalPushDynArray(const Value);
begin
  CheckGrow;
  TListHelper.PBytes(FItems^)[FLH.FCount] := TBytes(Value);
  PushAdjust(Value);
end;

{$IF not Defined(NEXTGEN)}
procedure TStackHelper.InternalPushWideString(const Value);
begin
  CheckGrow;
  PWideString(FItems^)[FLH.FCount] := WideString(Value);
  PushAdjust(Value);
end;
{$ENDIF}

{$IF Defined(AUTOREFCOUNT)}
procedure TStackHelper.InternalPushObject(const Value);
begin
  CheckGrow;
  PObject(FItems^)[FLH.FCount] := TObject(Value);
  PushAdjust(Value);
end;
{$ENDIF}

procedure TStackHelper.InternalPush1(const Value);
begin
  CheckGrow;
  PByte(FItems^)[FLH.FCount] := Byte(Value);
  PushAdjust(Value);
end;

procedure TStackHelper.InternalPush2(const Value);
begin
  CheckGrow;
  PWord(FItems^)[FLH.FCount] := Word(Value);
  PushAdjust(Value);
end;

procedure TStackHelper.InternalPush4(const Value);
begin
  CheckGrow;
  PCardinal(FItems^)[FLH.FCount] := Cardinal(Value);
  PushAdjust(Value);
end;

procedure TStackHelper.InternalPush8(const Value);
begin
  CheckGrow;
  PUInt64(FItems^)[FLH.FCount] := UInt64(Value);
  PushAdjust(Value);
end;

procedure TStackHelper.InternalPushManaged(const Value);
begin
  CheckGrow;
  System.CopyArray(@PByte(FItems^)[FLH.FCount * ElSize], @Value, ElType, 1);
  PushAdjust(Value);
end;

procedure TStackHelper.InternalPushMRef(const Value; Kind: TTypeKind);
begin
  case Kind of
    TTypeKind.tkUString: InternalPushString(Value);
    TTypeKind.tkDynArray: InternalPushDynArray(Value);
    TTypeKind.tkInterface: InternalPushInterface(Value);
    TTypeKind.tkLString: InternalPushByteString(Value);
{$IF not Defined(NEXTGEN)}
    TTypeKind.tkWString: InternalPushWideString(Value);
{$ENDIF}
{$IF Defined(AUTOREFCOUNT)}
    TTypeKind.tkClass: InternalPushObject(Value);
{$ENDIF}
  end;
end;

procedure TStackHelper.InternalPushN(const Value);
begin
  CheckGrow;
  Move(Value, PByte(FItems^)[FLH.FCount * ElSize], ElSize);
  PushAdjust(Value);
end;

procedure TStackHelper.InternalSetCapacity(Value: Integer);
var
  Size: NativeInt;
begin
  if Value < FLH.FCount then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  Size := Value;
  DynArraySetLength(FItems^, FLH.FTypeInfo, 1, @Size);
end;

{$POINTERMATH OFF}

{ TStack<T> }

procedure TStack<T>.Notify(const Item: T; Action: TCollectionNotification);
begin
  if Assigned(FOnNotify) then
    FOnNotify(Self, Item, Action);
end;

constructor TStack<T>.Create(const Collection: TEnumerable<T>);
var
  Item: T;
begin
  inherited Create;
  FStackHelper.FLH.FNotify := InternalNotify;
  FStackHelper.FLH.FTypeInfo := TypeInfo(arrayOfT);
  for Item in Collection do
    Push(Item);
end;

constructor TStack<T>.Create;
begin
  inherited Create;
  FStackHelper.FLH.FNotify := InternalNotify;
  FStackHelper.FLH.FTypeInfo := TypeInfo(arrayOfT);
end;

destructor TStack<T>.Destroy;
begin
  Clear;
  inherited;
end;

function TStack<T>.DoGetEnumerator: TEnumerator<T>;
begin
  Result := GetEnumerator;
end;

procedure TStack<T>.InternalNotify(const Item; Action: TCollectionNotification);
begin
  Notify(T(Item), Action);
end;

procedure TStack<T>.Push(const Value: T);
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FStackHelper.InternalPushMRef(Value, GetTypeKind(T))
    else
      FStackHelper.InternalPushManaged(Value)
  else
  case SizeOf(T) of
    1: FStackHelper.InternalPush1(Value);
    2: FStackHelper.InternalPush2(Value);
    4: FStackHelper.InternalPush4(Value);
    8: FStackHelper.InternalPush8(Value);
  else
    FStackHelper.InternalPushN(Value);
  end;
end;

function TStack<T>.DoPop(Notification: TCollectionNotification): T;
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FStackHelper.InternalDoPopMRef(Notification, False, Result, GetTypeKind(T))
    else
      FStackHelper.InternalDoPopManaged(Notification, False, Result)
  else
  case SizeOf(T) of
    1: FStackHelper.InternalDoPop1(Notification, False, Result);
    2: FStackHelper.InternalDoPop2(Notification, False, Result);
    4: FStackHelper.InternalDoPop4(Notification, False, Result);
    8: FStackHelper.InternalDoPop8(Notification, False, Result);
  else
    FStackHelper.InternalDoPopN(Notification, False, Result);
  end;
end;

procedure TStack<T>.DoSetCapacity(Value: Integer);
begin
  FStackHelper.InternalSetCapacity(Value);
end;

function TStack<T>.Extract: T;
begin
  Result := DoPop(cnExtracted);
end;

function TStack<T>.Peek: T;
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FStackHelper.InternalDoPopMRef(cnRemoved, True, Result, GetTypeKind(T))
    else
      FStackHelper.InternalDoPopManaged(cnRemoved, True, Result)
  else
  case SizeOf(T) of
    1: FStackHelper.InternalDoPop1(cnRemoved, True, Result);
    2: FStackHelper.InternalDoPop2(cnRemoved, True, Result);
    4: FStackHelper.InternalDoPop4(cnRemoved, True, Result);
    8: FStackHelper.InternalDoPop8(cnRemoved, True, Result);
  else
    FStackHelper.InternalDoPopN(cnRemoved, True, Result);
  end;
end;

function TStack<T>.Pop: T;
begin
  Result := DoPop(cnRemoved);
end;

procedure TStack<T>.Clear;
begin
  if IsManagedType(T) then
    if (SizeOf(T) = SizeOf(Pointer)) and (GetTypeKind(T) <> tkRecord) then
      FStackHelper.InternalClearMRef(GetTypeKind(T))
    else
      FStackHelper.InternalClearManaged
  else
  case SizeOf(T) of
    1: FStackHelper.InternalClear1;
    2: FStackHelper.InternalClear2;
    4: FStackHelper.InternalClear4;
    8: FStackHelper.InternalClear8;
  else
    FStackHelper.InternalClearN;
  end;
end;

function TStack<T>.ToArray: TArray<T>;
begin
  Result := ToArrayImpl(Count);
end;

procedure TStack<T>.TrimExcess;
begin
  SetLength(FItems, Count);
end;

function TStack<T>.GetCapacity: Integer;
begin
  Result := Length(FItems);
end;

function TStack<T>.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

constructor TStack<T>.TEnumerator.Create(const AStack: TStack<T>);
begin
  inherited Create;
  FStack := AStack;
  FIndex := -1;
end;

function TStack<T>.TEnumerator.DoGetCurrent: T;
begin
  Result := GetCurrent;
end;

function TStack<T>.TEnumerator.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TStack<T>.TEnumerator.GetCurrent: T;
begin
  Result := FStack.FItems[FIndex];
end;

function TStack<T>.TEnumerator.MoveNext: Boolean;
begin
  if FIndex >= FStack.Count then
    Exit(False);
  Inc(FIndex);
  Result := FIndex < FStack.Count;
end;

{ TPair<TKey,TValue> }

constructor TPair<TKey,TValue>.Create(const AKey: TKey; const AValue: TValue);
begin
  Key := AKey;
  Value := AValue;
end;

{ TDictionary<TKey,TValue> }
const
  EMPTY_HASH = -1;

procedure TDictionary<TKey,TValue>.Rehash(NewCapPow2: Integer);
var
  oldItems, newItems: TItemArray;
  i: Integer;
begin
  if NewCapPow2 = Length(FItems) then
    Exit
  else if NewCapPow2 < 0 then
    OutOfMemoryError;

  oldItems := FItems;
  SetLength(newItems, NewCapPow2);
  for i := 0 to Length(newItems) - 1 do
    newItems[i].HashCode := EMPTY_HASH;
  FItems := newItems;
  FGrowThreshold := NewCapPow2 shr 1 + NewCapPow2 shr 2; // 75%

  for i := 0 to Length(oldItems) - 1 do
    if oldItems[i].HashCode <> EMPTY_HASH then
      RehashAdd(oldItems[i].HashCode, oldItems[i].Key, oldItems[i].Value);
end;

procedure TDictionary<TKey,TValue>.SetCapacity(ACapacity: Integer);
var
  newCap: Integer;
begin
  if ACapacity < Count then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);

  if ACapacity = 0 then
    Rehash(0)
  else
  begin
    newCap := 4;
    while newCap < ACapacity do
      newCap := newCap shl 1;
    Rehash(newCap);
  end
end;

procedure TDictionary<TKey,TValue>.Grow;
var
  newCap: Integer;
begin
  newCap := Length(FItems) * 2;
  if newCap = 0 then
    newCap := 4;
  Rehash(newCap);
end;

function TDictionary<TKey,TValue>.GetBucketIndex(const Key: TKey; HashCode: Integer): Integer;
var
  start, hc: Integer;
begin
  if Length(FItems) = 0 then
    Exit(not High(Integer));

  start := HashCode and (Length(FItems) - 1);
  Result := start;
  while True do
  begin
    hc := FItems[Result].HashCode;

    // Not found: return complement of insertion point.
    if hc = EMPTY_HASH then
      Exit(not Result);

    // Found: return location.
    if (hc = HashCode) and FComparer.Equals(FItems[Result].Key, Key) then
      Exit(Result);

    Inc(Result);
    if Result >= Length(FItems) then
      Result := 0;
  end;
end;

function TDictionary<TKey,TValue>.Hash(const Key: TKey): Integer;
const
  PositiveMask = not Integer($80000000);
begin
  // Double-Abs to avoid -MaxInt and MinInt problems.
  // Not using compiler-Abs because we *must* get a positive integer;
  // for compiler, Abs(Low(Integer)) is a null op.
  Result := PositiveMask and ((PositiveMask and FComparer.GetHashCode(Key)) + 1);
end;

function TDictionary<TKey,TValue>.GetItem(const Key: TKey): TValue;
var
  index: Integer;
begin
  index := GetBucketIndex(Key, Hash(Key));
  if index < 0 then
    raise EListError.CreateRes(@SGenericItemNotFound);
  Result := FItems[index].Value;
end;

procedure TDictionary<TKey,TValue>.SetItem(const Key: TKey; const Value: TValue);
var
  index: Integer;
  oldValue: TValue;
begin
  index := GetBucketIndex(Key, Hash(Key));
  if index < 0 then
    raise EListError.CreateRes(@SGenericItemNotFound);

  oldValue := FItems[index].Value;
  FItems[index].Value := Value;

  ValueNotify(oldValue, cnRemoved);
  ValueNotify(Value, cnAdded);
end;

procedure TDictionary<TKey,TValue>.RehashAdd(HashCode: Integer; const Key: TKey; const Value: TValue);
var
  index: Integer;
begin
  index := not GetBucketIndex(Key, HashCode);
  FItems[index].HashCode := HashCode;
  FItems[index].Key := Key;
  FItems[index].Value := Value;
end;

procedure TDictionary<TKey,TValue>.KeyNotify(const Key: TKey; Action: TCollectionNotification);
begin
  if Assigned(FOnKeyNotify) then
    FOnKeyNotify(Self, Key, Action);
end;

procedure TDictionary<TKey,TValue>.ValueNotify(const Value: TValue; Action: TCollectionNotification);
begin
  if Assigned(FOnValueNotify) then
    FOnValueNotify(Self, Value, Action);
end;

constructor TDictionary<TKey,TValue>.Create(ACapacity: Integer = 0);
begin
  Create(ACapacity, nil);
end;

constructor TDictionary<TKey,TValue>.Create(const AComparer: IEqualityComparer<TKey>);
begin
  Create(0, AComparer);
end;

constructor TDictionary<TKey,TValue>.Create(ACapacity: Integer; const AComparer: IEqualityComparer<TKey>);
var
  cap: Integer;
begin
  inherited Create;
  if ACapacity < 0 then
    raise EArgumentOutOfRangeException.CreateRes(@SArgumentOutOfRange);
  FComparer := AComparer;
  if FComparer = nil then
    FComparer := TEqualityComparer<TKey>.Default;
  SetCapacity(ACapacity);
end;

constructor TDictionary<TKey, TValue>.Create(const Collection: TEnumerable<TPair<TKey, TValue>>);
var
  item: TPair<TKey,TValue>;
begin
  Create(0, nil);
  for item in Collection do
    AddOrSetValue(item.Key, item.Value);
end;

constructor TDictionary<TKey, TValue>.Create(const Collection: TEnumerable<TPair<TKey, TValue>>;
  const AComparer: IEqualityComparer<TKey>);
var
  item: TPair<TKey,TValue>;
begin
  Create(0, AComparer);
  for item in Collection do
    AddOrSetValue(item.Key, item.Value);
end;

destructor TDictionary<TKey,TValue>.Destroy;
begin
  Clear;
  FKeyCollection.Free;
  FValueCollection.Free;
  inherited;
end;

procedure TDictionary<TKey,TValue>.Add(const Key: TKey; const Value: TValue);
var
  index, hc: Integer;
begin
  if Count >= FGrowThreshold then
    Grow;
  
  hc := Hash(Key);
  index := GetBucketIndex(Key, hc);
  if index >= 0 then
    raise EListError.CreateRes(@SGenericDuplicateItem);
  
  DoAdd(hc, not index, Key, Value);
end;

function InCircularRange(Bottom, Item, TopInc: Integer): Boolean;
begin
  Result := (Bottom < Item) and (Item <= TopInc) // normal
    or (TopInc < Bottom) and (Item > Bottom) // top wrapped
    or (TopInc < Bottom) and (Item <= TopInc) // top and item wrapped
end;

function TDictionary<TKey,TValue>.DoRemove(const Key: TKey; HashCode: Integer;
  Notification: TCollectionNotification): TValue;
var
  gap, index, hc, bucket: Integer;
  LKey: TKey;
begin
  index := GetBucketIndex(Key, HashCode);
  if index < 0 then
    Exit(Default(TValue));

  // Removing item from linear probe hash table is moderately
  // tricky. We need to fill in gaps, which will involve moving items
  // which may not even hash to the same location.
  // Knuth covers it well enough in Vol III. 6.4.; but beware, Algorithm R
  // (2nd ed) has a bug: step R4 should go to step R1, not R2 (already errata'd).
  // My version does linear probing forward, not backward, however.

  // gap refers to the hole that needs filling-in by shifting items down.
  // index searches for items that have been probed out of their slot,
  // but being careful not to move items if their bucket is between
  // our gap and our index (so that they'd be moved before their bucket).
  // We move the item at index into the gap, whereupon the new gap is
  // at the index. If the index hits a hole, then we're done.

  // If our load factor was exactly 1, we'll need to hit this hole
  // in order to terminate. Shouldn't normally be necessary, though.
  FItems[index].HashCode := EMPTY_HASH;
  Result := FItems[index].Value;
  LKey := FItems[index].Key;

  gap := index;
  while True do
  begin
    Inc(index);
    if index = Length(FItems) then
      index := 0;

    hc := FItems[index].HashCode;
    if hc = EMPTY_HASH then
      Break;

    bucket := hc and (Length(FItems) - 1);
    if not InCircularRange(gap, bucket, index) then
    begin
      FItems[gap] := FItems[index];
      gap := index;
      // The gap moved, but we still need to find it to terminate.
      FItems[gap].HashCode := EMPTY_HASH;
    end;
  end;

  FItems[gap].HashCode := EMPTY_HASH;
  FItems[gap].Key := Default(TKey);
  FItems[gap].Value := Default(TValue);
  Dec(FCount);

  KeyNotify(LKey, Notification);
  ValueNotify(Result, Notification);
end;

procedure TDictionary<TKey,TValue>.Remove(const Key: TKey);
begin
  DoRemove(Key, Hash(Key), cnRemoved);
end;

function TDictionary<TKey,TValue>.ExtractPair(const Key: TKey): TPair<TKey,TValue>;
var
  hc, index: Integer;
begin
  hc := Hash(Key);
  index := GetBucketIndex(Key, hc);
  if index < 0 then
    Exit(TPair<TKey,TValue>.Create(Key, Default(TValue)));

  Result := TPair<TKey,TValue>.Create(Key, DoRemove(Key, hc, cnExtracted));
end;

procedure TDictionary<TKey,TValue>.Clear;
var
  i: Integer;
  oldItems: TItemArray;
begin
  oldItems := FItems;
  FCount := 0;
  SetLength(FItems, 0);
  SetCapacity(0);
  FGrowThreshold := 0;

  for i := 0 to Length(oldItems) - 1 do
  begin
    if oldItems[i].HashCode = EMPTY_HASH then
      Continue;
    KeyNotify(oldItems[i].Key, cnRemoved);
    ValueNotify(oldItems[i].Value, cnRemoved);
  end;
end;

function TDictionary<TKey, TValue>.ToArray: TArray<TPair<TKey,TValue>>;
begin
  Result := ToArrayImpl(Count);
end;

procedure TDictionary<TKey,TValue>.TrimExcess;
begin
  // Ensure at least one empty slot for GetBucketIndex to terminate.
  SetCapacity(Count + 1);
end;

function TDictionary<TKey,TValue>.TryGetValue(const Key: TKey; out Value: TValue): Boolean;
var
  index: Integer;
begin
  index := GetBucketIndex(Key, Hash(Key));
  Result := index >= 0;
  if Result then
    Value := FItems[index].Value
  else
    Value := Default(TValue);
end;

procedure TDictionary<TKey,TValue>.DoAdd(HashCode, Index: Integer; const Key: TKey; const Value: TValue);
begin
  FItems[Index].HashCode := HashCode;
  FItems[Index].Key := Key;
  FItems[Index].Value := Value;
  Inc(FCount);
  
  KeyNotify(Key, cnAdded);
  ValueNotify(Value, cnAdded);
end;

function TDictionary<TKey, TValue>.DoGetEnumerator: TEnumerator<TPair<TKey, TValue>>;
begin
  Result := GetEnumerator;
end;

procedure TDictionary<TKey,TValue>.DoSetValue(Index: Integer; const Value: TValue);
var
  oldValue: TValue;
begin
  oldValue := FItems[Index].Value;
  FItems[Index].Value := Value;
  
  ValueNotify(oldValue, cnRemoved);
  ValueNotify(Value, cnAdded);
end;

procedure TDictionary<TKey,TValue>.AddOrSetValue(const Key: TKey; const Value: TValue);
var
  hc: Integer;
  index: Integer;
begin
  hc := Hash(Key);
  index := GetBucketIndex(Key, hc);
  if index >= 0 then
    DoSetValue(index, Value)
  else
  begin
    // We only grow if we are inserting a new value.
    if Count >= FGrowThreshold then
    begin
      Grow;
      // We need a new Bucket Index because the array has grown.
      index := GetBucketIndex(Key, hc);
    end;
    DoAdd(hc, not index, Key, Value);
  end;
end;

function TDictionary<TKey,TValue>.ContainsKey(const Key: TKey): Boolean;
begin
  Result := GetBucketIndex(Key, Hash(Key)) >= 0;
end;

function TDictionary<TKey,TValue>.ContainsValue(const Value: TValue): Boolean;
var
  i: Integer;
  c: IEqualityComparer<TValue>;
begin
  c := TEqualityComparer<TValue>.Default;

  for i := 0 to Length(FItems) - 1 do
    if (FItems[i].HashCode <> EMPTY_HASH) and c.Equals(FItems[i].Value, Value) then
      Exit(True);
  Result := False;
end;

function TDictionary<TKey,TValue>.GetEnumerator: TPairEnumerator;
begin
  Result := TPairEnumerator.Create(Self);
end;

function TDictionary<TKey,TValue>.GetKeys: TKeyCollection;
begin
  if FKeyCollection = nil then
    FKeyCollection := TKeyCollection.Create(Self);
  Result := FKeyCollection;
end;

function TDictionary<TKey,TValue>.GetValues: TValueCollection;
begin
  if FValueCollection = nil then
    FValueCollection := TValueCollection.Create(Self);
  Result := FValueCollection;
end;

// Pairs

constructor TDictionary<TKey,TValue>.TPairEnumerator.Create(const ADictionary: TDictionary<TKey,TValue>);
begin
  inherited Create;
  FIndex := -1;
  FDictionary := ADictionary;
end;

function TDictionary<TKey, TValue>.TPairEnumerator.DoGetCurrent: TPair<TKey, TValue>;
begin
  Result := GetCurrent;
end;

function TDictionary<TKey, TValue>.TPairEnumerator.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TDictionary<TKey,TValue>.TPairEnumerator.GetCurrent: TPair<TKey,TValue>;
begin
  Result.Key := FDictionary.FItems[FIndex].Key;
  Result.Value := FDictionary.FItems[FIndex].Value;
end;

function TDictionary<TKey,TValue>.TPairEnumerator.MoveNext: Boolean;
begin
  while FIndex < Length(FDictionary.FItems) - 1 do
  begin
    Inc(FIndex);
    if FDictionary.FItems[FIndex].HashCode <> EMPTY_HASH then
      Exit(True);
  end;
  Result := False;
end;

// Keys

constructor TDictionary<TKey,TValue>.TKeyEnumerator.Create(const ADictionary: TDictionary<TKey,TValue>);
begin
  inherited Create;
  FIndex := -1;
  FDictionary := ADictionary;
end;

function TDictionary<TKey, TValue>.TKeyEnumerator.DoGetCurrent: TKey;
begin
  Result := GetCurrent;
end;

function TDictionary<TKey, TValue>.TKeyEnumerator.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TDictionary<TKey,TValue>.TKeyEnumerator.GetCurrent: TKey;
begin
  Result := FDictionary.FItems[FIndex].Key;
end;

function TDictionary<TKey,TValue>.TKeyEnumerator.MoveNext: Boolean;
begin
  while FIndex < Length(FDictionary.FItems) - 1 do
  begin
    Inc(FIndex);
    if FDictionary.FItems[FIndex].HashCode <> EMPTY_HASH then
      Exit(True);
  end;
  Result := False;
end;

// Values

constructor TDictionary<TKey,TValue>.TValueEnumerator.Create(const ADictionary: TDictionary<TKey,TValue>);
begin
  inherited Create;
  FIndex := -1;
  FDictionary := ADictionary;
end;

function TDictionary<TKey, TValue>.TValueEnumerator.DoGetCurrent: TValue;
begin
  Result := GetCurrent;
end;

function TDictionary<TKey, TValue>.TValueEnumerator.DoMoveNext: Boolean;
begin
  Result := MoveNext;
end;

function TDictionary<TKey,TValue>.TValueEnumerator.GetCurrent: TValue;
begin
  Result := FDictionary.FItems[FIndex].Value;
end;

function TDictionary<TKey,TValue>.TValueEnumerator.MoveNext: Boolean;
begin
  while FIndex < Length(FDictionary.FItems) - 1 do
  begin
    Inc(FIndex);
    if FDictionary.FItems[FIndex].HashCode <> EMPTY_HASH then
      Exit(True);
  end;
  Result := False;
end;

{ TObjectList<T> }

constructor TObjectList<T>.Create(AOwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
end;

constructor TObjectList<T>.Create(const AComparer: IComparer<T>; AOwnsObjects: Boolean);
begin
  inherited Create(AComparer);
  FOwnsObjects := AOwnsObjects;
end;

constructor TObjectList<T>.Create(const Collection: TEnumerable<T>; AOwnsObjects: Boolean);
begin
  inherited Create(Collection);
  FOwnsObjects := AOwnsObjects;
end;

destructor TObjectList<T>.Destroy;
begin
  inherited;
end;

procedure TObjectList<T>.Notify(const Value: T; Action: TCollectionNotification);
begin
  inherited;
  if OwnsObjects and (Action = cnRemoved) then
    Value.DisposeOf;
end;

{ TObjectQueue<T> }

constructor TObjectQueue<T>.Create(AOwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
end;

constructor TObjectQueue<T>.Create(const Collection: TEnumerable<T>; AOwnsObjects: Boolean);
begin
  inherited Create(Collection);
  FOwnsObjects := AOwnsObjects;
end;

procedure TObjectQueue<T>.Dequeue;
begin
  inherited Dequeue;
end;

procedure TObjectQueue<T>.Notify(const Value: T; Action: TCollectionNotification);
begin
  inherited;
  if OwnsObjects and (Action = cnRemoved) then
    Value.DisposeOf;
end;

{ TObjectStack<T> }

constructor TObjectStack<T>.Create(AOwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
end;

constructor TObjectStack<T>.Create(const Collection: TEnumerable<T>; AOwnsObjects: Boolean);
begin
  inherited Create(Collection);
  FOwnsObjects := AOwnsObjects;
end;

procedure TObjectStack<T>.Notify(const Value: T; Action: TCollectionNotification);
begin
  inherited;
  if OwnsObjects and (Action = cnRemoved) then
    Value.DisposeOf;
end;

procedure TObjectStack<T>.Pop;
begin
  inherited Pop;
end;

{ TObjectDictionary<TKey,TValue> }

procedure TObjectDictionary<TKey,TValue>.KeyNotify(const Key: TKey; Action: TCollectionNotification);
begin
  inherited;
  if (Action = cnRemoved) and (doOwnsKeys in FOwnerships) then
    PObject(@Key)^.DisposeOf;
end;

procedure TObjectDictionary<TKey,TValue>.ValueNotify(const Value: TValue; Action: TCollectionNotification);
begin
  inherited;
  if (Action = cnRemoved) and (doOwnsValues in FOwnerships) then
    PObject(@Value)^.DisposeOf;
end;

constructor TObjectDictionary<TKey,TValue>.Create(Ownerships: TDictionaryOwnerships; 
  ACapacity: Integer = 0);
begin
  Create(Ownerships, ACapacity, nil);
end;

constructor TObjectDictionary<TKey,TValue>.Create(Ownerships: TDictionaryOwnerships; 
  const AComparer: IEqualityComparer<TKey>);
begin
  Create(Ownerships, 0, AComparer);
end;

constructor TObjectDictionary<TKey,TValue>.Create(Ownerships: TDictionaryOwnerships; 
  ACapacity: Integer; const AComparer: IEqualityComparer<TKey>);
begin
  inherited Create(ACapacity, AComparer);
  if doOwnsKeys in Ownerships then
  begin
    if (TypeInfo(TKey) = nil) or (PTypeInfo(TypeInfo(TKey))^.Kind <> tkClass) then
      raise EInvalidCast.CreateRes(@SInvalidCast);
  end;

  if doOwnsValues in Ownerships then
  begin
    if (TypeInfo(TValue) = nil) or (PTypeInfo(TypeInfo(TValue))^.Kind <> tkClass) then
      raise EInvalidCast.CreateRes(@SInvalidCast);
  end;
  FOwnerships := Ownerships;
end;

{ TDictionary<TKey, TValue>.TValueCollection }

constructor TDictionary<TKey, TValue>.TValueCollection.Create(const ADictionary: TDictionary<TKey, TValue>);
begin
  inherited Create;
  FDictionary := ADictionary;
end;

function TDictionary<TKey, TValue>.TValueCollection.DoGetEnumerator: TEnumerator<TValue>;
begin
  Result := GetEnumerator;
end;

function TDictionary<TKey, TValue>.TValueCollection.GetCount: Integer;
begin
  Result := FDictionary.Count;
end;

function TDictionary<TKey, TValue>.TValueCollection.GetEnumerator: TValueEnumerator;
begin
  Result := TValueEnumerator.Create(FDictionary);
end;

function TDictionary<TKey, TValue>.TValueCollection.ToArray: TArray<TValue>;
begin
  Result := ToArrayImpl(FDictionary.Count);
end;

{ TDictionary<TKey, TValue>.TKeyCollection }

constructor TDictionary<TKey, TValue>.TKeyCollection.Create(
  const ADictionary: TDictionary<TKey, TValue>);
begin
  inherited Create;
  FDictionary := ADictionary;
end;

function TDictionary<TKey, TValue>.TKeyCollection.DoGetEnumerator: TEnumerator<TKey>;
begin
  Result := GetEnumerator;
end;

function TDictionary<TKey, TValue>.TKeyCollection.GetCount: Integer;
begin
  Result := FDictionary.Count;
end;

function TDictionary<TKey, TValue>.TKeyCollection.GetEnumerator: TKeyEnumerator;
begin
  Result := TKeyEnumerator.Create(FDictionary);
end;

function TDictionary<TKey, TValue>.TKeyCollection.ToArray: TArray<TKey>;
begin
  Result := ToArrayImpl(FDictionary.Count);
end;

{ TThreadedQueue<T> }

constructor TThreadedQueue<T>.Create(AQueueDepth: Integer = 10; PushTimeout: LongWord = INFINITE; PopTimeout: LongWord = INFINITE);
begin
  inherited Create;
  SetLength(FQueue, AQueueDepth);
  FQueueLock := TObject.Create;
  FQueueNotEmpty := TObject.Create;
  FQueueNotFull := TObject.Create;
  FPushTimeout := PushTimeout;
  FPopTimeout := PopTimeout;
end;

destructor TThreadedQueue<T>.Destroy;
begin
  DoShutDown;
  FQueueNotFull.Free;
  FQueueNotEmpty.Free;
  FQueueLock.Free;
  inherited;
end;

procedure TThreadedQueue<T>.Grow(ADelta: Integer);
begin
  TMonitor.Enter(FQueueLock);
  try
    SetLength(FQueue, Length(FQueue) + ADelta);
  finally
    TMonitor.Exit(FQueueLock);
  end;
  TMonitor.PulseAll(FQueueNotFull);
end;

function TThreadedQueue<T>.PopItem: T;
var
  LQueueSize: Integer;
begin
  PopItem(LQueueSize, Result);
end;

function TThreadedQueue<T>.PopItem(var AQueueSize: Integer; var AItem: T): TWaitResult;
begin
  AItem := Default(T);
  TMonitor.Enter(FQueueLock);
  try
    Result := wrSignaled;
    while (Result = wrSignaled) and (FQueueSize = 0) and not FShutDown do
      if not TMonitor.Wait(FQueueNotEmpty, FQueueLock, FPopTimeout) then
        Result := wrTimeout;

    if (FShutDown and (FQueueSize = 0)) or (Result <> wrSignaled) then
      Exit;

    AItem := FQueue[FQueueOffset];

    FQueue[FQueueOffset] := Default(T);

    Dec(FQueueSize);
    Inc(FQueueOffset);
    Inc(FTotalItemsPopped);

    if FQueueOffset = Length(FQueue) then
      FQueueOffset := 0;

  finally
    AQueueSize := FQueueSize;
    TMonitor.Exit(FQueueLock);
  end;

  TMonitor.Pulse(FQueueNotFull);
end;

function TThreadedQueue<T>.PopItem(var AItem: T): TWaitResult;
var
  LQueueSize: Integer;
begin
  Result := PopItem(LQueueSize, AItem);
end;

function TThreadedQueue<T>.PopItem(var AQueueSize: Integer): T;
begin
  PopItem(AQueueSize, Result);
end;

function TThreadedQueue<T>.PushItem(const AItem: T): TWaitResult;
var
  LQueueSize: Integer;
begin
  Result := PushItem(AItem, LQueueSize);
end;

function TThreadedQueue<T>.PushItem(const AItem: T; var AQueueSize: Integer): TWaitResult;
begin
  TMonitor.Enter(FQueueLock);
  try
    Result := wrSignaled;
    while (Result = wrSignaled) and (FQueueSize = Length(FQueue)) and not FShutDown do
      if not TMonitor.Wait(FQueueNotFull, FQueueLock, FPushTimeout) then
        Result := wrTimeout;

    if FShutDown or (Result <> wrSignaled) then
      Exit;

    FQueue[(FQueueOffset + FQueueSize) mod Length(FQueue)] := AItem;
    Inc(FQueueSize);
    Inc(FTotalItemsPushed);

  finally
    AQueueSize := FQueueSize;
    TMonitor.Exit(FQueueLock);
  end;

  TMonitor.Pulse(FQueueNotEmpty);
end;

procedure TThreadedQueue<T>.DoShutDown;
begin
  TMonitor.Enter(FQueueLock);
  try
    FShutDown := True;
  finally
    TMonitor.Exit(FQueueLock);
  end;
  TMonitor.PulseAll(FQueueNotFull);
  TMonitor.PulseAll(FQueueNotEmpty);
end;

{ TThreadList<T> }

procedure TThreadList<T>.Add(const Item: T);
begin
  LockList;
  try
    if (Duplicates = dupAccept) or
       (FList.IndexOf(Item) = -1) then
      FList.Add(Item)
    else if Duplicates = dupError then
      raise EListError.CreateFmt(SDuplicateItem, [FList.ItemValue(Item)]);
  finally
    UnlockList;
  end;
end;

procedure TThreadList<T>.Clear;
begin
  LockList;
  try
    FList.Clear;
  finally
    UnlockList;
  end;
end;

constructor TThreadList<T>.Create;
begin
  inherited Create;
  FLock := TObject.Create;
  FList := TList<T>.Create;
  FDuplicates := dupIgnore;
end;

destructor TThreadList<T>.Destroy;
begin
  LockList;    // Make sure nobody else is inside the list.
  try
    FList.Free;
    inherited Destroy;
  finally
    UnlockList;
    FLock.Free;
  end;
end;

function TThreadList<T>.LockList: TList<T>;
begin
  TMonitor.Enter(FLock);
  Result := FList;
end;

procedure TThreadList<T>.Remove(const Item: T);
begin
  RemoveItem(Item, TDirection.FromBeginning);
end;

procedure TThreadList<T>.RemoveItem(const Item: T; Direction: TDirection);
begin
  LockList;
  try
    FList.RemoveItem(Item, Direction);
  finally
    UnlockList;
  end;
end;

procedure TThreadList<T>.UnlockList;
begin
  TMonitor.Exit(FLock);
end;

end.

