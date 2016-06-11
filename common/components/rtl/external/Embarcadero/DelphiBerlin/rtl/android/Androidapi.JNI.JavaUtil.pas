{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.JavaUtil;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes;

type
// ===== Forward declarations =====

  JAbstractCollection = interface;//java.util.AbstractCollection
  JAbstractList = interface;//java.util.AbstractList
  JAbstractMap = interface;//java.util.AbstractMap
  JAbstractSet = interface;//java.util.AbstractSet
  JArrayList = interface;//java.util.ArrayList
  JBitSet = interface;//java.util.BitSet
  JCalendar = interface;//java.util.Calendar
  JCollection = interface;//java.util.Collection
  JComparator = interface;//java.util.Comparator
  JDate = interface;//java.util.Date
  JDictionary = interface;//java.util.Dictionary
  JEnumSet = interface;//java.util.EnumSet
  JEnumeration = interface;//java.util.Enumeration
  JGregorianCalendar = interface;//java.util.GregorianCalendar
  JHashMap = interface;//java.util.HashMap
  JHashSet = interface;//java.util.HashSet
  JHashtable = interface;//java.util.Hashtable
  JIterator = interface;//java.util.Iterator
  JList = interface;//java.util.List
  JListIterator = interface;//java.util.ListIterator
  JLocale = interface;//java.util.Locale
  JMap = interface;//java.util.Map
  Jutil_Observable = interface;//java.util.Observable
  JObserver = interface;//java.util.Observer
  JProperties = interface;//java.util.Properties
  JQueue = interface;//java.util.Queue
  JRandom = interface;//java.util.Random
  JSet = interface;//java.util.Set
  JSortedMap = interface;//java.util.SortedMap
  JTimeZone = interface;//java.util.TimeZone
  JTimer = interface;//java.util.Timer
  JTimerTask = interface;//java.util.TimerTask
  JUUID = interface;//java.util.UUID
  JAbstractExecutorService = interface;//java.util.concurrent.AbstractExecutorService
  JBlockingQueue = interface;//java.util.concurrent.BlockingQueue
  JCallable = interface;//java.util.concurrent.Callable
  JCountDownLatch = interface;//java.util.concurrent.CountDownLatch
  JDelayed = interface;//java.util.concurrent.Delayed
  JExecutor = interface;//java.util.concurrent.Executor
  JExecutorService = interface;//java.util.concurrent.ExecutorService
  JFuture = interface;//java.util.concurrent.Future
  JRejectedExecutionHandler = interface;//java.util.concurrent.RejectedExecutionHandler
  JScheduledFuture = interface;//java.util.concurrent.ScheduledFuture
  JThreadPoolExecutor = interface;//java.util.concurrent.ThreadPoolExecutor
  JScheduledThreadPoolExecutor = interface;//java.util.concurrent.ScheduledThreadPoolExecutor
  JThreadFactory = interface;//java.util.concurrent.ThreadFactory
  JTimeUnit = interface;//java.util.concurrent.TimeUnit

// ===== Interface declarations =====

  JAbstractCollectionClass = interface(JObjectClass)
    ['{27541496-F538-45DB-BFC7-9ED05E5680C3}']
  end;

  [JavaSignature('java/util/AbstractCollection')]
  JAbstractCollection = interface(JObject)
    ['{4A5BA15A-2B07-4768-AA91-4BA9C93882C1}']
    function add(object_: JObject): Boolean; cdecl;
    function addAll(collection: JCollection): Boolean; cdecl;
    procedure clear; cdecl;
    function &contains(object_: JObject): Boolean; cdecl;
    function containsAll(collection: JCollection): Boolean; cdecl;
    function isEmpty: Boolean; cdecl;
    function iterator: JIterator; cdecl;
    function remove(object_: JObject): Boolean; cdecl;
    function removeAll(collection: JCollection): Boolean; cdecl;
    function retainAll(collection: JCollection): Boolean; cdecl;
    function size: Integer; cdecl;
    function toArray: TJavaObjectArray<JObject>; cdecl; overload;
    function toArray(contents: TJavaObjectArray<JObject>): TJavaObjectArray<JObject>; cdecl; overload;
    function toString: JString; cdecl;
  end;
  TJAbstractCollection = class(TJavaGenericImport<JAbstractCollectionClass, JAbstractCollection>) end;

  JAbstractListClass = interface(JAbstractCollectionClass)
    ['{4495F751-BABA-4349-8D4B-997761ED3876}']
  end;

  [JavaSignature('java/util/AbstractList')]
  JAbstractList = interface(JAbstractCollection)
    ['{2E98325B-7293-4E06-A775-240FDD287E27}']
    procedure add(location: Integer; object_: JObject); cdecl; overload;
    function add(object_: JObject): Boolean; cdecl; overload;
    function addAll(location: Integer; collection: JCollection): Boolean; cdecl;
    procedure clear; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function &get(location: Integer): JObject; cdecl;
    function hashCode: Integer; cdecl;
    function indexOf(object_: JObject): Integer; cdecl;
    function iterator: JIterator; cdecl;
    function lastIndexOf(object_: JObject): Integer; cdecl;
    function listIterator: JListIterator; cdecl; overload;
    function listIterator(location: Integer): JListIterator; cdecl; overload;
    function remove(location: Integer): JObject; cdecl;
    function &set(location: Integer; object_: JObject): JObject; cdecl;
    function subList(start: Integer; end_: Integer): JList; cdecl;
  end;
  TJAbstractList = class(TJavaGenericImport<JAbstractListClass, JAbstractList>) end;

  JAbstractMapClass = interface(JObjectClass)
    ['{05119E45-9501-4270-B2BB-EE7E314695CB}']
  end;

  [JavaSignature('java/util/AbstractMap')]
  JAbstractMap = interface(JObject)
    ['{63FD2094-7BFB-41B4-AED8-F781B97F6EB6}']
    procedure clear; cdecl;
    function containsKey(key: JObject): Boolean; cdecl;
    function containsValue(value: JObject): Boolean; cdecl;
    function entrySet: JSet; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function &get(key: JObject): JObject; cdecl;
    function hashCode: Integer; cdecl;
    function isEmpty: Boolean; cdecl;
    function keySet: JSet; cdecl;
    function put(key: JObject; value: JObject): JObject; cdecl;
    procedure putAll(map: JMap); cdecl;
    function remove(key: JObject): JObject; cdecl;
    function size: Integer; cdecl;
    function toString: JString; cdecl;
    function values: JCollection; cdecl;
  end;
  TJAbstractMap = class(TJavaGenericImport<JAbstractMapClass, JAbstractMap>) end;

  JAbstractSetClass = interface(JAbstractCollectionClass)
    ['{C8EA147C-D0DB-4E27-B8B5-77A04711A2F3}']
  end;

  [JavaSignature('java/util/AbstractSet')]
  JAbstractSet = interface(JAbstractCollection)
    ['{A520B68E-843E-46B8-BBB3-1A40DE9E92CE}']
    function equals(object_: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function removeAll(collection: JCollection): Boolean; cdecl;
  end;
  TJAbstractSet = class(TJavaGenericImport<JAbstractSetClass, JAbstractSet>) end;

  JArrayListClass = interface(JAbstractListClass)
    ['{0CC7FC88-8B13-4F0A-9635-26FEEED49F94}']
    {class} function init(capacity: Integer): JArrayList; cdecl; overload;
    {class} function init: JArrayList; cdecl; overload;
    {class} function init(collection: JCollection): JArrayList; cdecl; overload;
  end;

  [JavaSignature('java/util/ArrayList')]
  JArrayList = interface(JAbstractList)
    ['{B1D54E97-F848-4301-BA5B-F32921164AFA}']
    function add(object_: JObject): Boolean; cdecl; overload;
    procedure add(index: Integer; object_: JObject); cdecl; overload;
    function addAll(collection: JCollection): Boolean; cdecl; overload;
    function addAll(index: Integer; collection: JCollection): Boolean; cdecl; overload;
    procedure clear; cdecl;
    function clone: JObject; cdecl;
    function &contains(object_: JObject): Boolean; cdecl;
    procedure ensureCapacity(minimumCapacity: Integer); cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function &get(index: Integer): JObject; cdecl;
    function hashCode: Integer; cdecl;
    function indexOf(object_: JObject): Integer; cdecl;
    function isEmpty: Boolean; cdecl;
    function iterator: JIterator; cdecl;
    function lastIndexOf(object_: JObject): Integer; cdecl;
    function remove(index: Integer): JObject; cdecl; overload;
    function remove(object_: JObject): Boolean; cdecl; overload;
    function &set(index: Integer; object_: JObject): JObject; cdecl;
    function size: Integer; cdecl;
    function toArray: TJavaObjectArray<JObject>; cdecl; overload;
    function toArray(contents: TJavaObjectArray<JObject>): TJavaObjectArray<JObject>; cdecl; overload;
    procedure trimToSize; cdecl;
  end;
  TJArrayList = class(TJavaGenericImport<JArrayListClass, JArrayList>) end;

  JBitSetClass = interface(JObjectClass)
    ['{1CB74061-9B52-4CCA-AB29-D87B5EE10BCB}']
    {class} function init: JBitSet; cdecl; overload;
    {class} function init(bitCount: Integer): JBitSet; cdecl; overload;
    {class} function valueOf(longs: TJavaArray<Int64>): JBitSet; cdecl; overload;
    {class} function valueOf(longBuffer: JLongBuffer): JBitSet; cdecl; overload;
    {class} function valueOf(bytes: TJavaArray<Byte>): JBitSet; cdecl; overload;
    {class} function valueOf(byteBuffer: JByteBuffer): JBitSet; cdecl; overload;
  end;

  [JavaSignature('java/util/BitSet')]
  JBitSet = interface(JObject)
    ['{2FBDF9C9-FEEE-4377-B2A2-D557CF0BEC31}']
    procedure &and(bs: JBitSet); cdecl;
    procedure andNot(bs: JBitSet); cdecl;
    function cardinality: Integer; cdecl;
    procedure clear(index: Integer); cdecl; overload;
    procedure clear; cdecl; overload;
    procedure clear(fromIndex: Integer; toIndex: Integer); cdecl; overload;
    function clone: JObject; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    procedure flip(index: Integer); cdecl; overload;
    procedure flip(fromIndex: Integer; toIndex: Integer); cdecl; overload;
    function &get(index: Integer): Boolean; cdecl; overload;
    function &get(fromIndex: Integer; toIndex: Integer): JBitSet; cdecl; overload;
    function hashCode: Integer; cdecl;
    function intersects(bs: JBitSet): Boolean; cdecl;
    function isEmpty: Boolean; cdecl;
    function length: Integer; cdecl;
    function nextClearBit(index: Integer): Integer; cdecl;
    function nextSetBit(index: Integer): Integer; cdecl;
    procedure &or(bs: JBitSet); cdecl;
    function previousClearBit(index: Integer): Integer; cdecl;
    function previousSetBit(index: Integer): Integer; cdecl;
    procedure &set(index: Integer); cdecl; overload;
    procedure &set(index: Integer; state: Boolean); cdecl; overload;
    procedure &set(fromIndex: Integer; toIndex: Integer; state: Boolean); cdecl; overload;
    procedure &set(fromIndex: Integer; toIndex: Integer); cdecl; overload;
    function size: Integer; cdecl;
    function toByteArray: TJavaArray<Byte>; cdecl;
    function toLongArray: TJavaArray<Int64>; cdecl;
    function toString: JString; cdecl;
    procedure &xor(bs: JBitSet); cdecl;
  end;
  TJBitSet = class(TJavaGenericImport<JBitSetClass, JBitSet>) end;

  JCalendarClass = interface(JObjectClass)
    ['{51237FAA-7CDF-4E7E-9AE8-282DC2A930A1}']
    {class} function _GetALL_STYLES: Integer; cdecl;
    {class} function _GetAM: Integer; cdecl;
    {class} function _GetAM_PM: Integer; cdecl;
    {class} function _GetAPRIL: Integer; cdecl;
    {class} function _GetAUGUST: Integer; cdecl;
    {class} function _GetDATE: Integer; cdecl;
    {class} function _GetDAY_OF_MONTH: Integer; cdecl;
    {class} function _GetDAY_OF_WEEK: Integer; cdecl;
    {class} function _GetDAY_OF_WEEK_IN_MONTH: Integer; cdecl;
    {class} function _GetDAY_OF_YEAR: Integer; cdecl;
    {class} function _GetDECEMBER: Integer; cdecl;
    {class} function _GetDST_OFFSET: Integer; cdecl;
    {class} function _GetERA: Integer; cdecl;
    {class} function _GetFEBRUARY: Integer; cdecl;
    {class} function _GetFIELD_COUNT: Integer; cdecl;
    {class} function _GetFRIDAY: Integer; cdecl;
    {class} function _GetHOUR: Integer; cdecl;
    {class} function _GetHOUR_OF_DAY: Integer; cdecl;
    {class} function _GetJANUARY: Integer; cdecl;
    {class} function _GetJULY: Integer; cdecl;
    {class} function _GetJUNE: Integer; cdecl;
    {class} function _GetLONG: Integer; cdecl;
    {class} function _GetMARCH: Integer; cdecl;
    {class} function _GetMAY: Integer; cdecl;
    {class} function _GetMILLISECOND: Integer; cdecl;
    {class} function _GetMINUTE: Integer; cdecl;
    {class} function _GetMONDAY: Integer; cdecl;
    {class} function _GetMONTH: Integer; cdecl;
    {class} function _GetNOVEMBER: Integer; cdecl;
    {class} function _GetOCTOBER: Integer; cdecl;
    {class} function _GetPM: Integer; cdecl;
    {class} function _GetSATURDAY: Integer; cdecl;
    {class} function _GetSECOND: Integer; cdecl;
    {class} function _GetSEPTEMBER: Integer; cdecl;
    {class} function _GetSHORT: Integer; cdecl;
    {class} function _GetSUNDAY: Integer; cdecl;
    {class} function _GetTHURSDAY: Integer; cdecl;
    {class} function _GetTUESDAY: Integer; cdecl;
    {class} function _GetUNDECIMBER: Integer; cdecl;
    {class} function _GetWEDNESDAY: Integer; cdecl;
    {class} function _GetWEEK_OF_MONTH: Integer; cdecl;
    {class} function _GetWEEK_OF_YEAR: Integer; cdecl;
    {class} function _GetYEAR: Integer; cdecl;
    {class} function _GetZONE_OFFSET: Integer; cdecl;
    {class} function getAvailableLocales: TJavaObjectArray<JLocale>; cdecl;
    {class} function getInstance: JCalendar; cdecl; overload;
    {class} function getInstance(locale: JLocale): JCalendar; cdecl; overload;
    {class} function getInstance(timezone: JTimeZone): JCalendar; cdecl; overload;
    {class} function getInstance(timezone: JTimeZone; locale: JLocale): JCalendar; cdecl; overload;
    {class} property ALL_STYLES: Integer read _GetALL_STYLES;
    {class} property AM: Integer read _GetAM;
    {class} property AM_PM: Integer read _GetAM_PM;
    {class} property APRIL: Integer read _GetAPRIL;
    {class} property AUGUST: Integer read _GetAUGUST;
    {class} property DATE: Integer read _GetDATE;
    {class} property DAY_OF_MONTH: Integer read _GetDAY_OF_MONTH;
    {class} property DAY_OF_WEEK: Integer read _GetDAY_OF_WEEK;
    {class} property DAY_OF_WEEK_IN_MONTH: Integer read _GetDAY_OF_WEEK_IN_MONTH;
    {class} property DAY_OF_YEAR: Integer read _GetDAY_OF_YEAR;
    {class} property DECEMBER: Integer read _GetDECEMBER;
    {class} property DST_OFFSET: Integer read _GetDST_OFFSET;
    {class} property ERA: Integer read _GetERA;
    {class} property FEBRUARY: Integer read _GetFEBRUARY;
    {class} property FIELD_COUNT: Integer read _GetFIELD_COUNT;
    {class} property FRIDAY: Integer read _GetFRIDAY;
    {class} property HOUR: Integer read _GetHOUR;
    {class} property HOUR_OF_DAY: Integer read _GetHOUR_OF_DAY;
    {class} property JANUARY: Integer read _GetJANUARY;
    {class} property JULY: Integer read _GetJULY;
    {class} property JUNE: Integer read _GetJUNE;
    {class} property LONG: Integer read _GetLONG;
    {class} property MARCH: Integer read _GetMARCH;
    {class} property MAY: Integer read _GetMAY;
    {class} property MILLISECOND: Integer read _GetMILLISECOND;
    {class} property MINUTE: Integer read _GetMINUTE;
    {class} property MONDAY: Integer read _GetMONDAY;
    {class} property MONTH: Integer read _GetMONTH;
    {class} property NOVEMBER: Integer read _GetNOVEMBER;
    {class} property OCTOBER: Integer read _GetOCTOBER;
    {class} property PM: Integer read _GetPM;
    {class} property SATURDAY: Integer read _GetSATURDAY;
    {class} property SECOND: Integer read _GetSECOND;
    {class} property SEPTEMBER: Integer read _GetSEPTEMBER;
    {class} property SHORT: Integer read _GetSHORT;
    {class} property SUNDAY: Integer read _GetSUNDAY;
    {class} property THURSDAY: Integer read _GetTHURSDAY;
    {class} property TUESDAY: Integer read _GetTUESDAY;
    {class} property UNDECIMBER: Integer read _GetUNDECIMBER;
    {class} property WEDNESDAY: Integer read _GetWEDNESDAY;
    {class} property WEEK_OF_MONTH: Integer read _GetWEEK_OF_MONTH;
    {class} property WEEK_OF_YEAR: Integer read _GetWEEK_OF_YEAR;
    {class} property YEAR: Integer read _GetYEAR;
    {class} property ZONE_OFFSET: Integer read _GetZONE_OFFSET;
  end;

  [JavaSignature('java/util/Calendar')]
  JCalendar = interface(JObject)
    ['{2C0409E5-97A4-47CA-9E75-6ACB1CA4515E}']
    procedure add(field: Integer; value: Integer); cdecl;
    function after(calendar: JObject): Boolean; cdecl;
    function before(calendar: JObject): Boolean; cdecl;
    procedure clear; cdecl; overload;
    procedure clear(field: Integer); cdecl; overload;
    function clone: JObject; cdecl;
    function compareTo(anotherCalendar: JCalendar): Integer; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function &get(field: Integer): Integer; cdecl;
    function getActualMaximum(field: Integer): Integer; cdecl;
    function getActualMinimum(field: Integer): Integer; cdecl;
    function getDisplayName(field: Integer; style: Integer; locale: JLocale): JString; cdecl;
    function getDisplayNames(field: Integer; style: Integer; locale: JLocale): JMap; cdecl;
    function getFirstDayOfWeek: Integer; cdecl;
    function getGreatestMinimum(field: Integer): Integer; cdecl;
    function getLeastMaximum(field: Integer): Integer; cdecl;
    function getMaximum(field: Integer): Integer; cdecl;
    function getMinimalDaysInFirstWeek: Integer; cdecl;
    function getMinimum(field: Integer): Integer; cdecl;
    function getTime: JDate; cdecl;
    function getTimeInMillis: Int64; cdecl;
    function getTimeZone: JTimeZone; cdecl;
    function hashCode: Integer; cdecl;
    function isLenient: Boolean; cdecl;
    function isSet(field: Integer): Boolean; cdecl;
    procedure roll(field: Integer; value: Integer); cdecl; overload;
    procedure roll(field: Integer; increment: Boolean); cdecl; overload;
    procedure &set(field: Integer; value: Integer); cdecl; overload;
    procedure &set(year: Integer; month: Integer; day: Integer); cdecl; overload;
    procedure &set(year: Integer; month: Integer; day: Integer; hourOfDay: Integer; minute: Integer); cdecl; overload;
    procedure &set(year: Integer; month: Integer; day: Integer; hourOfDay: Integer; minute: Integer; second: Integer); cdecl; overload;
    procedure setFirstDayOfWeek(value: Integer); cdecl;
    procedure setLenient(value: Boolean); cdecl;
    procedure setMinimalDaysInFirstWeek(value: Integer); cdecl;
    procedure setTime(date: JDate); cdecl;
    procedure setTimeInMillis(milliseconds: Int64); cdecl;
    procedure setTimeZone(timezone: JTimeZone); cdecl;
    function toString: JString; cdecl;
  end;
  TJCalendar = class(TJavaGenericImport<JCalendarClass, JCalendar>) end;

  JCollectionClass = interface(JIterableClass)
    ['{2737AA1B-2E7C-406D-AF35-8B012C7D5803}']
  end;

  [JavaSignature('java/util/Collection')]
  JCollection = interface(JIterable)
    ['{9E58EE70-C0A7-4660-BF62-945FAE9F5EC3}']
    function add(object_: JObject): Boolean; cdecl;
    function addAll(collection: JCollection): Boolean; cdecl;
    procedure clear; cdecl;
    function &contains(object_: JObject): Boolean; cdecl;
    function containsAll(collection: JCollection): Boolean; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isEmpty: Boolean; cdecl;
    function iterator: JIterator; cdecl;
    function remove(object_: JObject): Boolean; cdecl;
    function removeAll(collection: JCollection): Boolean; cdecl;
    function retainAll(collection: JCollection): Boolean; cdecl;
    function size: Integer; cdecl;
    function toArray: TJavaObjectArray<JObject>; cdecl; overload;
    function toArray(array_: TJavaObjectArray<JObject>): TJavaObjectArray<JObject>; cdecl; overload;
  end;
  TJCollection = class(TJavaGenericImport<JCollectionClass, JCollection>) end;

  JComparatorClass = interface(IJavaClass)
    ['{BFB6395F-2694-4292-A1B5-87CC1138FB77}']
  end;

  [JavaSignature('java/util/Comparator')]
  JComparator = interface(IJavaInstance)
    ['{0754C41C-92B8-483B-88F0-B48BFE216D46}']
    function compare(lhs: JObject; rhs: JObject): Integer; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
  end;
  TJComparator = class(TJavaGenericImport<JComparatorClass, JComparator>) end;

  JDateClass = interface(JObjectClass)
    ['{37EABF6D-C7EE-4AB5-BE8B-5E439112E116}']
    {class} function init: JDate; cdecl; overload;
    {class} function init(year: Integer; month: Integer; day: Integer): JDate; cdecl; overload;//Deprecated
    {class} function init(year: Integer; month: Integer; day: Integer; hour: Integer; minute: Integer): JDate; cdecl; overload;//Deprecated
    {class} function init(year: Integer; month: Integer; day: Integer; hour: Integer; minute: Integer; second: Integer): JDate; cdecl; overload;//Deprecated
    {class} function init(milliseconds: Int64): JDate; cdecl; overload;
    {class} function init(string_: JString): JDate; cdecl; overload;//Deprecated
    {class} function UTC(year: Integer; month: Integer; day: Integer; hour: Integer; minute: Integer; second: Integer): Int64; cdecl;//Deprecated
    {class} function parse(string_: JString): Int64; cdecl;//Deprecated
  end;

  [JavaSignature('java/util/Date')]
  JDate = interface(JObject)
    ['{282E2836-B390-44E4-A14F-EF481460BDF7}']
    function after(date: JDate): Boolean; cdecl;
    function before(date: JDate): Boolean; cdecl;
    function clone: JObject; cdecl;
    function compareTo(date: JDate): Integer; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function getDate: Integer; cdecl;//Deprecated
    function getDay: Integer; cdecl;//Deprecated
    function getHours: Integer; cdecl;//Deprecated
    function getMinutes: Integer; cdecl;//Deprecated
    function getMonth: Integer; cdecl;//Deprecated
    function getSeconds: Integer; cdecl;//Deprecated
    function getTime: Int64; cdecl;
    function getTimezoneOffset: Integer; cdecl;//Deprecated
    function getYear: Integer; cdecl;//Deprecated
    function hashCode: Integer; cdecl;
    procedure setDate(day: Integer); cdecl;//Deprecated
    procedure setHours(hour: Integer); cdecl;//Deprecated
    procedure setMinutes(minute: Integer); cdecl;//Deprecated
    procedure setMonth(month: Integer); cdecl;//Deprecated
    procedure setSeconds(second: Integer); cdecl;//Deprecated
    procedure setTime(milliseconds: Int64); cdecl;
    procedure setYear(year: Integer); cdecl;//Deprecated
    function toGMTString: JString; cdecl;//Deprecated
    function toLocaleString: JString; cdecl;//Deprecated
    function toString: JString; cdecl;
  end;
  TJDate = class(TJavaGenericImport<JDateClass, JDate>) end;

  JDictionaryClass = interface(JObjectClass)
    ['{33D1971B-B4C5-4FA5-9DE3-BD76F2FCBD29}']
    {class} function init: JDictionary; cdecl;
  end;

  [JavaSignature('java/util/Dictionary')]
  JDictionary = interface(JObject)
    ['{C52483EE-5BB5-4F8A-B6ED-411F1920D533}']
    function elements: JEnumeration; cdecl;
    function &get(key: JObject): JObject; cdecl;
    function isEmpty: Boolean; cdecl;
    function keys: JEnumeration; cdecl;
    function put(key: JObject; value: JObject): JObject; cdecl;
    function remove(key: JObject): JObject; cdecl;
    function size: Integer; cdecl;
  end;
  TJDictionary = class(TJavaGenericImport<JDictionaryClass, JDictionary>) end;

  JEnumSetClass = interface(JAbstractSetClass)
    ['{67EF0287-D91B-44E0-9574-4CA9974FBC38}']
    {class} function allOf(elementType: Jlang_Class): JEnumSet; cdecl;
    {class} function complementOf(s: JEnumSet): JEnumSet; cdecl;
    {class} function copyOf(s: JEnumSet): JEnumSet; cdecl; overload;
    {class} function copyOf(c: JCollection): JEnumSet; cdecl; overload;
    {class} function noneOf(elementType: Jlang_Class): JEnumSet; cdecl;
    {class} function &of(e: JEnum): JEnumSet; cdecl; overload;
    {class} function &of(e1: JEnum; e2: JEnum): JEnumSet; cdecl; overload;
    {class} function &of(e1: JEnum; e2: JEnum; e3: JEnum): JEnumSet; cdecl; overload;
    {class} function &of(e1: JEnum; e2: JEnum; e3: JEnum; e4: JEnum): JEnumSet; cdecl; overload;
    {class} function &of(e1: JEnum; e2: JEnum; e3: JEnum; e4: JEnum; e5: JEnum): JEnumSet; cdecl; overload;
    {class} function range(start: JEnum; end_: JEnum): JEnumSet; cdecl;
  end;

  [JavaSignature('java/util/EnumSet')]
  JEnumSet = interface(JAbstractSet)
    ['{C8A6B028-B797-406A-9EE4-B65671555D97}']
    function clone: JEnumSet; cdecl;
  end;
  TJEnumSet = class(TJavaGenericImport<JEnumSetClass, JEnumSet>) end;

  JEnumerationClass = interface(IJavaClass)
    ['{5E393BCD-3EF2-4764-A59C-37B4D44C289A}']
  end;

  [JavaSignature('java/util/Enumeration')]
  JEnumeration = interface(IJavaInstance)
    ['{8F9F8780-E6BE-4B67-A4F5-8EC28E1AE2EE}']
    function hasMoreElements: Boolean; cdecl;
    function nextElement: JObject; cdecl;
  end;
  TJEnumeration = class(TJavaGenericImport<JEnumerationClass, JEnumeration>) end;

  JGregorianCalendarClass = interface(JCalendarClass)
    ['{69F4EF00-93DA-4249-8A30-3A3E4A71DA03}']
    {class} function _GetAD: Integer; cdecl;
    {class} function _GetBC: Integer; cdecl;
    {class} function init: JGregorianCalendar; cdecl; overload;
    {class} function init(year: Integer; month: Integer; day: Integer): JGregorianCalendar; cdecl; overload;
    {class} function init(year: Integer; month: Integer; day: Integer; hour: Integer; minute: Integer): JGregorianCalendar; cdecl; overload;
    {class} function init(year: Integer; month: Integer; day: Integer; hour: Integer; minute: Integer; second: Integer): JGregorianCalendar; cdecl; overload;
    {class} function init(locale: JLocale): JGregorianCalendar; cdecl; overload;
    {class} function init(timezone: JTimeZone): JGregorianCalendar; cdecl; overload;
    {class} function init(timezone: JTimeZone; locale: JLocale): JGregorianCalendar; cdecl; overload;
    {class} property AD: Integer read _GetAD;
    {class} property BC: Integer read _GetBC;
  end;

  [JavaSignature('java/util/GregorianCalendar')]
  JGregorianCalendar = interface(JCalendar)
    ['{CB851885-16EA-49E7-8AAF-DBFE900DA328}']
    procedure add(field: Integer; value: Integer); cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function getActualMaximum(field: Integer): Integer; cdecl;
    function getActualMinimum(field: Integer): Integer; cdecl;
    function getGreatestMinimum(field: Integer): Integer; cdecl;
    function getGregorianChange: JDate; cdecl;
    function getLeastMaximum(field: Integer): Integer; cdecl;
    function getMaximum(field: Integer): Integer; cdecl;
    function getMinimum(field: Integer): Integer; cdecl;
    function hashCode: Integer; cdecl;
    function isLeapYear(year: Integer): Boolean; cdecl;
    procedure roll(field: Integer; value: Integer); cdecl; overload;
    procedure roll(field: Integer; increment: Boolean); cdecl; overload;
    procedure setGregorianChange(date: JDate); cdecl;
  end;
  TJGregorianCalendar = class(TJavaGenericImport<JGregorianCalendarClass, JGregorianCalendar>) end;

  JHashMapClass = interface(JAbstractMapClass)
    ['{AC953BC1-405B-4CDD-93D2-FBA77D171B56}']
    {class} function init: JHashMap; cdecl; overload;
    {class} function init(capacity: Integer): JHashMap; cdecl; overload;
    {class} function init(capacity: Integer; loadFactor: Single): JHashMap; cdecl; overload;
    {class} function init(map: JMap): JHashMap; cdecl; overload;
  end;

  [JavaSignature('java/util/HashMap')]
  JHashMap = interface(JAbstractMap)
    ['{FD560211-A7FE-4AB5-B510-BB43A31AA75D}']
    procedure clear; cdecl;
    function clone: JObject; cdecl;
    function containsKey(key: JObject): Boolean; cdecl;
    function containsValue(value: JObject): Boolean; cdecl;
    function entrySet: JSet; cdecl;
    function &get(key: JObject): JObject; cdecl;
    function isEmpty: Boolean; cdecl;
    function keySet: JSet; cdecl;
    function put(key: JObject; value: JObject): JObject; cdecl;
    procedure putAll(map: JMap); cdecl;
    function remove(key: JObject): JObject; cdecl;
    function size: Integer; cdecl;
    function values: JCollection; cdecl;
  end;
  TJHashMap = class(TJavaGenericImport<JHashMapClass, JHashMap>) end;

  JHashSetClass = interface(JAbstractSetClass)
    ['{7828E4D4-4F9F-493D-869E-92BE600444D5}']
    {class} function init: JHashSet; cdecl; overload;
    {class} function init(capacity: Integer): JHashSet; cdecl; overload;
    {class} function init(capacity: Integer; loadFactor: Single): JHashSet; cdecl; overload;
    {class} function init(collection: JCollection): JHashSet; cdecl; overload;
  end;

  [JavaSignature('java/util/HashSet')]
  JHashSet = interface(JAbstractSet)
    ['{A57B696D-8331-4C96-8759-7F2009371640}']
    function add(object_: JObject): Boolean; cdecl;
    procedure clear; cdecl;
    function clone: JObject; cdecl;
    function &contains(object_: JObject): Boolean; cdecl;
    function isEmpty: Boolean; cdecl;
    function iterator: JIterator; cdecl;
    function remove(object_: JObject): Boolean; cdecl;
    function size: Integer; cdecl;
  end;
  TJHashSet = class(TJavaGenericImport<JHashSetClass, JHashSet>) end;

  JHashtableClass = interface(JDictionaryClass)
    ['{0459EE5F-44DF-406D-B0F4-6D2F19D2222F}']
    {class} function init: JHashtable; cdecl; overload;
    {class} function init(capacity: Integer): JHashtable; cdecl; overload;
    {class} function init(capacity: Integer; loadFactor: Single): JHashtable; cdecl; overload;
    {class} function init(map: JMap): JHashtable; cdecl; overload;
  end;

  [JavaSignature('java/util/Hashtable')]
  JHashtable = interface(JDictionary)
    ['{7A995299-3381-4179-A8A2-21C4F0E2E755}']
    procedure clear; cdecl;
    function clone: JObject; cdecl;
    function &contains(value: JObject): Boolean; cdecl;
    function containsKey(key: JObject): Boolean; cdecl;
    function containsValue(value: JObject): Boolean; cdecl;
    function elements: JEnumeration; cdecl;
    function entrySet: JSet; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function &get(key: JObject): JObject; cdecl;
    function hashCode: Integer; cdecl;
    function isEmpty: Boolean; cdecl;
    function keySet: JSet; cdecl;
    function keys: JEnumeration; cdecl;
    function put(key: JObject; value: JObject): JObject; cdecl;
    procedure putAll(map: JMap); cdecl;
    function remove(key: JObject): JObject; cdecl;
    function size: Integer; cdecl;
    function toString: JString; cdecl;
    function values: JCollection; cdecl;
  end;
  TJHashtable = class(TJavaGenericImport<JHashtableClass, JHashtable>) end;

  JIteratorClass = interface(IJavaClass)
    ['{2E525F5D-C766-4F79-B800-BA5FFA909E90}']
  end;

  [JavaSignature('java/util/Iterator')]
  JIterator = interface(IJavaInstance)
    ['{435EBC1F-CFE0-437C-B49B-45B5257B6953}']
    function hasNext: Boolean; cdecl;
    function next: JObject; cdecl;
    procedure remove; cdecl;
  end;
  TJIterator = class(TJavaGenericImport<JIteratorClass, JIterator>) end;

  JListClass = interface(JCollectionClass)
    ['{8EA06296-143F-4381-9369-A77209B622F0}']
  end;

  [JavaSignature('java/util/List')]
  JList = interface(JCollection)
    ['{3F85C565-F3F4-42D8-87EE-F724F72113C7}']
    procedure add(location: Integer; object_: JObject); cdecl; overload;
    function add(object_: JObject): Boolean; cdecl; overload;
    function addAll(location: Integer; collection: JCollection): Boolean; cdecl; overload;
    function addAll(collection: JCollection): Boolean; cdecl; overload;
    procedure clear; cdecl;
    function &contains(object_: JObject): Boolean; cdecl;
    function containsAll(collection: JCollection): Boolean; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function &get(location: Integer): JObject; cdecl;
    function hashCode: Integer; cdecl;
    function indexOf(object_: JObject): Integer; cdecl;
    function isEmpty: Boolean; cdecl;
    function iterator: JIterator; cdecl;
    function lastIndexOf(object_: JObject): Integer; cdecl;
    function listIterator: JListIterator; cdecl; overload;
    function listIterator(location: Integer): JListIterator; cdecl; overload;
    function remove(location: Integer): JObject; cdecl; overload;
    function remove(object_: JObject): Boolean; cdecl; overload;
    function removeAll(collection: JCollection): Boolean; cdecl;
    function retainAll(collection: JCollection): Boolean; cdecl;
    function &set(location: Integer; object_: JObject): JObject; cdecl;
    function size: Integer; cdecl;
    function subList(start: Integer; end_: Integer): JList; cdecl;
    function toArray: TJavaObjectArray<JObject>; cdecl; overload;
    function toArray(array_: TJavaObjectArray<JObject>): TJavaObjectArray<JObject>; cdecl; overload;
  end;
  TJList = class(TJavaGenericImport<JListClass, JList>) end;

  JListIteratorClass = interface(JIteratorClass)
    ['{7541F5DD-8E71-44AE-ACD9-142ED2D42810}']
  end;

  [JavaSignature('java/util/ListIterator')]
  JListIterator = interface(JIterator)
    ['{B66BDA33-5CDD-43B1-B320-7353AE09C418}']
    procedure add(object_: JObject); cdecl;
    function hasNext: Boolean; cdecl;
    function hasPrevious: Boolean; cdecl;
    function next: JObject; cdecl;
    function nextIndex: Integer; cdecl;
    function previous: JObject; cdecl;
    function previousIndex: Integer; cdecl;
    procedure remove; cdecl;
    procedure &set(object_: JObject); cdecl;
  end;
  TJListIterator = class(TJavaGenericImport<JListIteratorClass, JListIterator>) end;

  JLocaleClass = interface(JObjectClass)
    ['{0A5D70AA-C01B-437F-97C8-FEE25C595AE7}']
    {class} function _GetCANADA: JLocale; cdecl;
    {class} function _GetCANADA_FRENCH: JLocale; cdecl;
    {class} function _GetCHINA: JLocale; cdecl;
    {class} function _GetCHINESE: JLocale; cdecl;
    {class} function _GetENGLISH: JLocale; cdecl;
    {class} function _GetFRANCE: JLocale; cdecl;
    {class} function _GetFRENCH: JLocale; cdecl;
    {class} function _GetGERMAN: JLocale; cdecl;
    {class} function _GetGERMANY: JLocale; cdecl;
    {class} function _GetITALIAN: JLocale; cdecl;
    {class} function _GetITALY: JLocale; cdecl;
    {class} function _GetJAPAN: JLocale; cdecl;
    {class} function _GetJAPANESE: JLocale; cdecl;
    {class} function _GetKOREA: JLocale; cdecl;
    {class} function _GetKOREAN: JLocale; cdecl;
    {class} function _GetPRC: JLocale; cdecl;
    {class} function _GetPRIVATE_USE_EXTENSION: Char; cdecl;
    {class} function _GetROOT: JLocale; cdecl;
    {class} function _GetSIMPLIFIED_CHINESE: JLocale; cdecl;
    {class} function _GetTAIWAN: JLocale; cdecl;
    {class} function _GetTRADITIONAL_CHINESE: JLocale; cdecl;
    {class} function _GetUK: JLocale; cdecl;
    {class} function _GetUNICODE_LOCALE_EXTENSION: Char; cdecl;
    {class} function _GetUS: JLocale; cdecl;
    {class} function init(language: JString): JLocale; cdecl; overload;
    {class} function init(language: JString; country: JString): JLocale; cdecl; overload;
    {class} function init(language: JString; country: JString; variant: JString): JLocale; cdecl; overload;
    {class} function forLanguageTag(languageTag: JString): JLocale; cdecl;
    {class} function getAvailableLocales: TJavaObjectArray<JLocale>; cdecl;
    {class} function getDefault: JLocale; cdecl;
    {class} function getISOCountries: TJavaObjectArray<JString>; cdecl;
    {class} function getISOLanguages: TJavaObjectArray<JString>; cdecl;
    {class} procedure setDefault(locale: JLocale); cdecl;
    {class} property CANADA: JLocale read _GetCANADA;
    {class} property CANADA_FRENCH: JLocale read _GetCANADA_FRENCH;
    {class} property CHINA: JLocale read _GetCHINA;
    {class} property CHINESE: JLocale read _GetCHINESE;
    {class} property ENGLISH: JLocale read _GetENGLISH;
    {class} property FRANCE: JLocale read _GetFRANCE;
    {class} property FRENCH: JLocale read _GetFRENCH;
    {class} property GERMAN: JLocale read _GetGERMAN;
    {class} property GERMANY: JLocale read _GetGERMANY;
    {class} property ITALIAN: JLocale read _GetITALIAN;
    {class} property ITALY: JLocale read _GetITALY;
    {class} property JAPAN: JLocale read _GetJAPAN;
    {class} property JAPANESE: JLocale read _GetJAPANESE;
    {class} property KOREA: JLocale read _GetKOREA;
    {class} property KOREAN: JLocale read _GetKOREAN;
    {class} property PRC: JLocale read _GetPRC;
    {class} property PRIVATE_USE_EXTENSION: Char read _GetPRIVATE_USE_EXTENSION;
    {class} property ROOT: JLocale read _GetROOT;
    {class} property SIMPLIFIED_CHINESE: JLocale read _GetSIMPLIFIED_CHINESE;
    {class} property TAIWAN: JLocale read _GetTAIWAN;
    {class} property TRADITIONAL_CHINESE: JLocale read _GetTRADITIONAL_CHINESE;
    {class} property UK: JLocale read _GetUK;
    {class} property UNICODE_LOCALE_EXTENSION: Char read _GetUNICODE_LOCALE_EXTENSION;
    {class} property US: JLocale read _GetUS;
  end;

  [JavaSignature('java/util/Locale')]
  JLocale = interface(JObject)
    ['{877ADE25-1D13-4963-9A17-17EE17B3A0A8}']
    function clone: JObject; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function getCountry: JString; cdecl;
    function getDisplayCountry: JString; cdecl; overload;
    function getDisplayCountry(locale: JLocale): JString; cdecl; overload;
    function getDisplayLanguage: JString; cdecl; overload;
    function getDisplayLanguage(locale: JLocale): JString; cdecl; overload;
    function getDisplayName: JString; cdecl; overload;
    function getDisplayName(locale: JLocale): JString; cdecl; overload;
    function getDisplayScript: JString; cdecl; overload;
    function getDisplayScript(locale: JLocale): JString; cdecl; overload;
    function getDisplayVariant: JString; cdecl; overload;
    function getDisplayVariant(locale: JLocale): JString; cdecl; overload;
    function getExtension(extensionKey: Char): JString; cdecl;
    function getExtensionKeys: JSet; cdecl;
    function getISO3Country: JString; cdecl;
    function getISO3Language: JString; cdecl;
    function getLanguage: JString; cdecl;
    function getScript: JString; cdecl;
    function getUnicodeLocaleAttributes: JSet; cdecl;
    function getUnicodeLocaleKeys: JSet; cdecl;
    function getUnicodeLocaleType(keyWord: JString): JString; cdecl;
    function getVariant: JString; cdecl;
    function hashCode: Integer; cdecl;
    function toLanguageTag: JString; cdecl;
    function toString: JString; cdecl;
  end;
  TJLocale = class(TJavaGenericImport<JLocaleClass, JLocale>) end;

  JMapClass = interface(IJavaClass)
    ['{2A7CE403-063B-45CA-9F4D-EA1E64304F1C}']
  end;

  [JavaSignature('java/util/Map')]
  JMap = interface(IJavaInstance)
    ['{BE6A5DBF-B121-4BF2-BC18-EB64729C7811}']
    procedure clear; cdecl;
    function containsKey(key: JObject): Boolean; cdecl;
    function containsValue(value: JObject): Boolean; cdecl;
    function entrySet: JSet; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function &get(key: JObject): JObject; cdecl;
    function hashCode: Integer; cdecl;
    function isEmpty: Boolean; cdecl;
    function keySet: JSet; cdecl;
    function put(key: JObject; value: JObject): JObject; cdecl;
    procedure putAll(map: JMap); cdecl;
    function remove(key: JObject): JObject; cdecl;
    function size: Integer; cdecl;
    function values: JCollection; cdecl;
  end;
  TJMap = class(TJavaGenericImport<JMapClass, JMap>) end;

  Jutil_ObservableClass = interface(JObjectClass)
    ['{2BD8C696-02FF-4378-A514-ACD431BEE106}']
    {class} function init: Jutil_Observable; cdecl;
  end;

  [JavaSignature('java/util/Observable')]
  Jutil_Observable = interface(JObject)
    ['{B8443F0E-B41C-4475-934B-1C917FCF617B}']
    procedure addObserver(observer: JObserver); cdecl;
    function countObservers: Integer; cdecl;
    procedure deleteObserver(observer: JObserver); cdecl;
    procedure deleteObservers; cdecl;
    function hasChanged: Boolean; cdecl;
    procedure notifyObservers; cdecl; overload;
    procedure notifyObservers(data: JObject); cdecl; overload;
  end;
  TJutil_Observable = class(TJavaGenericImport<Jutil_ObservableClass, Jutil_Observable>) end;

  JObserverClass = interface(IJavaClass)
    ['{8582EA20-ECD9-4C10-95BD-2C89B4D5BA6E}']
  end;

  [JavaSignature('java/util/Observer')]
  JObserver = interface(IJavaInstance)
    ['{452A1BDA-4B4E-406E-B455-BC56F012C1B7}']
    procedure update(observable: Jutil_Observable; data: JObject); cdecl;
  end;
  TJObserver = class(TJavaGenericImport<JObserverClass, JObserver>) end;

  JPropertiesClass = interface(JHashtableClass)
    ['{CA354A9C-C42E-41BD-B104-6058143813A5}']
    {class} function init: JProperties; cdecl; overload;
    {class} function init(properties: JProperties): JProperties; cdecl; overload;
  end;

  [JavaSignature('java/util/Properties')]
  JProperties = interface(JHashtable)
    ['{5F7AA87B-4EF0-4D76-923C-D7586F38760F}']
    function getProperty(name: JString): JString; cdecl; overload;
    function getProperty(name: JString; defaultValue: JString): JString; cdecl; overload;
    procedure list(out_: JPrintStream); cdecl; overload;
    procedure list(out_: JPrintWriter); cdecl; overload;
    procedure load(in_: JInputStream); cdecl; overload;
    procedure load(in_: JReader); cdecl; overload;
    procedure loadFromXML(in_: JInputStream); cdecl;
    function propertyNames: JEnumeration; cdecl;
    procedure save(out_: JOutputStream; comment: JString); cdecl;//Deprecated
    function setProperty(name: JString; value: JString): JObject; cdecl;
    procedure store(out_: JOutputStream; comment: JString); cdecl; overload;
    procedure store(writer: JWriter; comment: JString); cdecl; overload;
    procedure storeToXML(os: JOutputStream; comment: JString); cdecl; overload;
    procedure storeToXML(os: JOutputStream; comment: JString; encoding: JString); cdecl; overload;
    function stringPropertyNames: JSet; cdecl;
  end;
  TJProperties = class(TJavaGenericImport<JPropertiesClass, JProperties>) end;

  JQueueClass = interface(JCollectionClass)
    ['{3A0B6ECD-D788-4FFA-9C17-6F7A761FE1DC}']
  end;

  [JavaSignature('java/util/Queue')]
  JQueue = interface(JCollection)
    ['{1F7FBC68-484A-4622-AE37-764E1EC7AF04}']
    function add(e: JObject): Boolean; cdecl;
    function element: JObject; cdecl;
    function offer(e: JObject): Boolean; cdecl;
    function peek: JObject; cdecl;
    function poll: JObject; cdecl;
    function remove: JObject; cdecl;
  end;
  TJQueue = class(TJavaGenericImport<JQueueClass, JQueue>) end;

  JRandomClass = interface(JObjectClass)
    ['{C50FE36A-6283-4523-BF77-15BB7A7B0F92}']
    {class} function init: JRandom; cdecl; overload;
    {class} function init(seed: Int64): JRandom; cdecl; overload;
  end;

  [JavaSignature('java/util/Random')]
  JRandom = interface(JObject)
    ['{F1C05381-73F2-4991-853B-B22575DB43D2}']
    function nextBoolean: Boolean; cdecl;
    procedure nextBytes(buf: TJavaArray<Byte>); cdecl;
    function nextDouble: Double; cdecl;
    function nextFloat: Single; cdecl;
    function nextGaussian: Double; cdecl;
    function nextInt: Integer; cdecl; overload;
    function nextInt(n: Integer): Integer; cdecl; overload;
    function nextLong: Int64; cdecl;
    procedure setSeed(seed: Int64); cdecl;
  end;
  TJRandom = class(TJavaGenericImport<JRandomClass, JRandom>) end;

  JSetClass = interface(JCollectionClass)
    ['{A3E290FD-FD46-4DA8-B728-07B04920F5DE}']
  end;

  [JavaSignature('java/util/Set')]
  JSet = interface(JCollection)
    ['{07BF19A2-0C1C-4ABF-9028-1F99DD0E0A79}']
    function add(object_: JObject): Boolean; cdecl;
    function addAll(collection: JCollection): Boolean; cdecl;
    procedure clear; cdecl;
    function &contains(object_: JObject): Boolean; cdecl;
    function containsAll(collection: JCollection): Boolean; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isEmpty: Boolean; cdecl;
    function iterator: JIterator; cdecl;
    function remove(object_: JObject): Boolean; cdecl;
    function removeAll(collection: JCollection): Boolean; cdecl;
    function retainAll(collection: JCollection): Boolean; cdecl;
    function size: Integer; cdecl;
    function toArray: TJavaObjectArray<JObject>; cdecl; overload;
    function toArray(array_: TJavaObjectArray<JObject>): TJavaObjectArray<JObject>; cdecl; overload;
  end;
  TJSet = class(TJavaGenericImport<JSetClass, JSet>) end;

  JSortedMapClass = interface(JMapClass)
    ['{7665A1A5-0EE6-483D-A256-B13FA7E65230}']
  end;

  [JavaSignature('java/util/SortedMap')]
  JSortedMap = interface(JMap)
    ['{3FD4011C-7238-42A1-8E25-D7B3F130E88F}']
    function comparator: JComparator; cdecl;
    function firstKey: JObject; cdecl;
    function headMap(endKey: JObject): JSortedMap; cdecl;
    function lastKey: JObject; cdecl;
    function subMap(startKey: JObject; endKey: JObject): JSortedMap; cdecl;
    function tailMap(startKey: JObject): JSortedMap; cdecl;
  end;
  TJSortedMap = class(TJavaGenericImport<JSortedMapClass, JSortedMap>) end;

  JTimeZoneClass = interface(JObjectClass)
    ['{8F823620-CE10-44D5-82BA-24BFD63DCF80}']
    {class} function _GetLONG: Integer; cdecl;
    {class} function _GetSHORT: Integer; cdecl;
    {class} function init: JTimeZone; cdecl;
    {class} function getAvailableIDs: TJavaObjectArray<JString>; cdecl; overload;
    {class} function getAvailableIDs(offsetMillis: Integer): TJavaObjectArray<JString>; cdecl; overload;
    {class} function getDefault: JTimeZone; cdecl;
    {class} function getTimeZone(id: JString): JTimeZone; cdecl;
    {class} procedure setDefault(timeZone: JTimeZone); cdecl;
    {class} property LONG: Integer read _GetLONG;
    {class} property SHORT: Integer read _GetSHORT;
  end;

  [JavaSignature('java/util/TimeZone')]
  JTimeZone = interface(JObject)
    ['{9D5215F4-A1B5-4B24-8B0B-EB3B88A0328D}']
    function clone: JObject; cdecl;
    function getDSTSavings: Integer; cdecl;
    function getDisplayName: JString; cdecl; overload;
    function getDisplayName(locale: JLocale): JString; cdecl; overload;
    function getDisplayName(daylightTime: Boolean; style: Integer): JString; cdecl; overload;
    function getDisplayName(daylightTime: Boolean; style: Integer; locale: JLocale): JString; cdecl; overload;
    function getID: JString; cdecl;
    function getOffset(time: Int64): Integer; cdecl; overload;
    function getOffset(era: Integer; year: Integer; month: Integer; day: Integer; dayOfWeek: Integer; timeOfDayMillis: Integer): Integer; cdecl; overload;
    function getRawOffset: Integer; cdecl;
    function hasSameRules(timeZone: JTimeZone): Boolean; cdecl;
    function inDaylightTime(time: JDate): Boolean; cdecl;
    procedure setID(id: JString); cdecl;
    procedure setRawOffset(offsetMillis: Integer); cdecl;
    function useDaylightTime: Boolean; cdecl;
  end;
  TJTimeZone = class(TJavaGenericImport<JTimeZoneClass, JTimeZone>) end;

  JTimerClass = interface(JObjectClass)
    ['{52E301A5-4F00-4743-94D1-BA38347CC59F}']
    {class} function init(name: JString; isDaemon: Boolean): JTimer; cdecl; overload;
    {class} function init(name: JString): JTimer; cdecl; overload;
    {class} function init(isDaemon: Boolean): JTimer; cdecl; overload;
    {class} function init: JTimer; cdecl; overload;
  end;

  [JavaSignature('java/util/Timer')]
  JTimer = interface(JObject)
    ['{131F841C-9357-49F0-A688-9AC5506F4C5A}']
    procedure cancel; cdecl;
    function purge: Integer; cdecl;
    procedure schedule(task: JTimerTask; when: JDate); cdecl; overload;
    procedure schedule(task: JTimerTask; delay: Int64); cdecl; overload;
    procedure schedule(task: JTimerTask; delay: Int64; period: Int64); cdecl; overload;
    procedure schedule(task: JTimerTask; when: JDate; period: Int64); cdecl; overload;
    procedure scheduleAtFixedRate(task: JTimerTask; delay: Int64; period: Int64); cdecl; overload;
    procedure scheduleAtFixedRate(task: JTimerTask; when: JDate; period: Int64); cdecl; overload;
  end;
  TJTimer = class(TJavaGenericImport<JTimerClass, JTimer>) end;

  JTimerTaskClass = interface(JObjectClass)
    ['{DC15DA86-BDCC-42A9-8B9D-7348D4AE0F13}']
  end;

  [JavaSignature('java/util/TimerTask')]
  JTimerTask = interface(JObject)
    ['{B01AA454-6E9B-4A26-A31E-8D9A32E59816}']
    function cancel: Boolean; cdecl;
    procedure run; cdecl;
    function scheduledExecutionTime: Int64; cdecl;
  end;
  TJTimerTask = class(TJavaGenericImport<JTimerTaskClass, JTimerTask>) end;

  JUUIDClass = interface(JObjectClass)
    ['{F254C874-67C8-4832-9619-9F686CB8E466}']
    {class} function init(mostSigBits: Int64; leastSigBits: Int64): JUUID; cdecl;
    {class} function fromString(uuid: JString): JUUID; cdecl;
    {class} function nameUUIDFromBytes(name: TJavaArray<Byte>): JUUID; cdecl;
    {class} function randomUUID: JUUID; cdecl;
  end;

  [JavaSignature('java/util/UUID')]
  JUUID = interface(JObject)
    ['{B280C48F-E064-4030-BFD0-FB5970A78101}']
    function clockSequence: Integer; cdecl;
    function compareTo(uuid: JUUID): Integer; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function getLeastSignificantBits: Int64; cdecl;
    function getMostSignificantBits: Int64; cdecl;
    function hashCode: Integer; cdecl;
    function node: Int64; cdecl;
    function timestamp: Int64; cdecl;
    function toString: JString; cdecl;
    function variant: Integer; cdecl;
    function version: Integer; cdecl;
  end;
  TJUUID = class(TJavaGenericImport<JUUIDClass, JUUID>) end;

  JAbstractExecutorServiceClass = interface(JObjectClass)
    ['{3896A98A-B273-4500-B0D5-F7D69CD7D49E}']
    {class} function init: JAbstractExecutorService; cdecl;
  end;

  [JavaSignature('java/util/concurrent/AbstractExecutorService')]
  JAbstractExecutorService = interface(JObject)
    ['{7A846346-CB8B-442D-A705-40CB673B7A84}']
    function invokeAll(tasks: JCollection): JList; cdecl; overload;
    function invokeAll(tasks: JCollection; timeout: Int64; unit_: JTimeUnit): JList; cdecl; overload;
    function invokeAny(tasks: JCollection): JObject; cdecl; overload;
    function invokeAny(tasks: JCollection; timeout: Int64; unit_: JTimeUnit): JObject; cdecl; overload;
    function submit(task: JRunnable): JFuture; cdecl; overload;
    function submit(task: JRunnable; result: JObject): JFuture; cdecl; overload;
    function submit(task: JCallable): JFuture; cdecl; overload;
  end;
  TJAbstractExecutorService = class(TJavaGenericImport<JAbstractExecutorServiceClass, JAbstractExecutorService>) end;

  JBlockingQueueClass = interface(JQueueClass)
    ['{FEAC4030-F87A-4E78-9454-A48238AC00D8}']
  end;

  [JavaSignature('java/util/concurrent/BlockingQueue')]
  JBlockingQueue = interface(JQueue)
    ['{4F92390A-DED1-405E-894E-656C3AD20695}']
    function add(e: JObject): Boolean; cdecl;
    function &contains(o: JObject): Boolean; cdecl;
    function drainTo(c: JCollection): Integer; cdecl; overload;
    function drainTo(c: JCollection; maxElements: Integer): Integer; cdecl; overload;
    function offer(e: JObject): Boolean; cdecl; overload;
    function offer(e: JObject; timeout: Int64; unit_: JTimeUnit): Boolean; cdecl; overload;
    function poll(timeout: Int64; unit_: JTimeUnit): JObject; cdecl;
    procedure put(e: JObject); cdecl;
    function remainingCapacity: Integer; cdecl;
    function remove(o: JObject): Boolean; cdecl;
    function take: JObject; cdecl;
  end;
  TJBlockingQueue = class(TJavaGenericImport<JBlockingQueueClass, JBlockingQueue>) end;

  JCallableClass = interface(IJavaClass)
    ['{F12DB2A8-1E01-44A9-BFBE-C6F3E32F7A65}']
  end;

  [JavaSignature('java/util/concurrent/Callable')]
  JCallable = interface(IJavaInstance)
    ['{071A2E40-747B-4702-8DDB-D1749FB9B8FD}']
    function call: JObject; cdecl;
  end;
  TJCallable = class(TJavaGenericImport<JCallableClass, JCallable>) end;

  JCountDownLatchClass = interface(JObjectClass)
    ['{8BB952D3-8BF8-4704-BC03-DCE2997C03AC}']
    {class} function init(count: Integer): JCountDownLatch; cdecl;
  end;

  [JavaSignature('java/util/concurrent/CountDownLatch')]
  JCountDownLatch = interface(JObject)
    ['{302AA7D1-4CD0-45CB-868F-C1CF1209D276}']
    procedure await; cdecl; overload;
    function await(timeout: Int64; unit_: JTimeUnit): Boolean; cdecl; overload;
    procedure countDown; cdecl;
    function getCount: Int64; cdecl;
    function toString: JString; cdecl;
  end;
  TJCountDownLatch = class(TJavaGenericImport<JCountDownLatchClass, JCountDownLatch>) end;

  JDelayedClass = interface(JComparableClass)
    ['{67CD6011-1F40-4BCA-9E24-EDA55F6A4EA1}']
  end;

  [JavaSignature('java/util/concurrent/Delayed')]
  JDelayed = interface(JComparable)
    ['{2BE364E4-9B4A-4A34-BDED-D1D9773530BF}']
    function getDelay(unit_: JTimeUnit): Int64; cdecl;
  end;
  TJDelayed = class(TJavaGenericImport<JDelayedClass, JDelayed>) end;

  JExecutorClass = interface(IJavaClass)
    ['{0606DEEF-30E1-4E40-82A3-20FF3E89BD61}']
  end;

  [JavaSignature('java/util/concurrent/Executor')]
  JExecutor = interface(IJavaInstance)
    ['{B846ECEE-83CF-40BB-A4C5-FFC949DCEF15}']
    procedure execute(command: JRunnable); cdecl;
  end;
  TJExecutor = class(TJavaGenericImport<JExecutorClass, JExecutor>) end;

  JExecutorServiceClass = interface(JExecutorClass)
    ['{4CF14DA3-BA41-4F67-A2DE-F62C8B02177F}']
  end;

  [JavaSignature('java/util/concurrent/ExecutorService')]
  JExecutorService = interface(JExecutor)
    ['{37810DA0-1254-423D-B181-C62455CB5AE4}']
    function awaitTermination(timeout: Int64; unit_: JTimeUnit): Boolean; cdecl;
    function invokeAll(tasks: JCollection): JList; cdecl; overload;
    function invokeAll(tasks: JCollection; timeout: Int64; unit_: JTimeUnit): JList; cdecl; overload;
    function invokeAny(tasks: JCollection): JObject; cdecl; overload;
    function invokeAny(tasks: JCollection; timeout: Int64; unit_: JTimeUnit): JObject; cdecl; overload;
    function isShutdown: Boolean; cdecl;
    function isTerminated: Boolean; cdecl;
    procedure shutdown; cdecl;
    function shutdownNow: JList; cdecl;
    function submit(task: JCallable): JFuture; cdecl; overload;
    function submit(task: JRunnable; result: JObject): JFuture; cdecl; overload;
    function submit(task: JRunnable): JFuture; cdecl; overload;
  end;
  TJExecutorService = class(TJavaGenericImport<JExecutorServiceClass, JExecutorService>) end;

  JFutureClass = interface(IJavaClass)
    ['{1716BCA6-301F-4D84-956C-AC25D1787B40}']
  end;

  [JavaSignature('java/util/concurrent/Future')]
  JFuture = interface(IJavaInstance)
    ['{EFD52756-9DF1-45BD-9E0D-A36E3CDE3DB9}']
    function cancel(mayInterruptIfRunning: Boolean): Boolean; cdecl;
    function &get: JObject; cdecl; overload;
    function &get(timeout: Int64; unit_: JTimeUnit): JObject; cdecl; overload;
    function isCancelled: Boolean; cdecl;
    function isDone: Boolean; cdecl;
  end;
  TJFuture = class(TJavaGenericImport<JFutureClass, JFuture>) end;

  JRejectedExecutionHandlerClass = interface(IJavaClass)
    ['{59CBB7C6-368F-446D-92CB-DB8638AE3BBD}']
  end;

  [JavaSignature('java/util/concurrent/RejectedExecutionHandler')]
  JRejectedExecutionHandler = interface(IJavaInstance)
    ['{F75637CF-D111-4DE1-9820-CA00A2AA17C7}']
    procedure rejectedExecution(r: JRunnable; executor: JThreadPoolExecutor); cdecl;
  end;
  TJRejectedExecutionHandler = class(TJavaGenericImport<JRejectedExecutionHandlerClass, JRejectedExecutionHandler>) end;

  JScheduledFutureClass = interface(JDelayedClass)
    ['{6AEAD91E-6D96-4057-BD8D-8B28E3833E7E}']
  end;

  [JavaSignature('java/util/concurrent/ScheduledFuture')]
  JScheduledFuture = interface(JDelayed)
    ['{0D2AEB43-60E8-4488-9260-15E693B853DD}']
  end;
  TJScheduledFuture = class(TJavaGenericImport<JScheduledFutureClass, JScheduledFuture>) end;

  JThreadPoolExecutorClass = interface(JAbstractExecutorServiceClass)
    ['{DDC3110F-84AA-41F1-9D0F-9800A406A8A8}']
    {class} function init(corePoolSize: Integer; maximumPoolSize: Integer; keepAliveTime: Int64; unit_: JTimeUnit; workQueue: JBlockingQueue): JThreadPoolExecutor; cdecl; overload;
    {class} function init(corePoolSize: Integer; maximumPoolSize: Integer; keepAliveTime: Int64; unit_: JTimeUnit; workQueue: JBlockingQueue; threadFactory: JThreadFactory): JThreadPoolExecutor; cdecl; overload;
    {class} function init(corePoolSize: Integer; maximumPoolSize: Integer; keepAliveTime: Int64; unit_: JTimeUnit; workQueue: JBlockingQueue; handler: JRejectedExecutionHandler): JThreadPoolExecutor; cdecl; overload;
    {class} function init(corePoolSize: Integer; maximumPoolSize: Integer; keepAliveTime: Int64; unit_: JTimeUnit; workQueue: JBlockingQueue; threadFactory: JThreadFactory; handler: JRejectedExecutionHandler): JThreadPoolExecutor; cdecl; overload;
  end;

  [JavaSignature('java/util/concurrent/ThreadPoolExecutor')]
  JThreadPoolExecutor = interface(JAbstractExecutorService)
    ['{866B2F57-7E31-4566-876F-4A35D526D76C}']
    procedure allowCoreThreadTimeOut(value: Boolean); cdecl;
    function allowsCoreThreadTimeOut: Boolean; cdecl;
    function awaitTermination(timeout: Int64; unit_: JTimeUnit): Boolean; cdecl;
    procedure execute(command: JRunnable); cdecl;
    function getActiveCount: Integer; cdecl;
    function getCompletedTaskCount: Int64; cdecl;
    function getCorePoolSize: Integer; cdecl;
    function getKeepAliveTime(unit_: JTimeUnit): Int64; cdecl;
    function getLargestPoolSize: Integer; cdecl;
    function getMaximumPoolSize: Integer; cdecl;
    function getPoolSize: Integer; cdecl;
    function getQueue: JBlockingQueue; cdecl;
    function getRejectedExecutionHandler: JRejectedExecutionHandler; cdecl;
    function getTaskCount: Int64; cdecl;
    function getThreadFactory: JThreadFactory; cdecl;
    function isShutdown: Boolean; cdecl;
    function isTerminated: Boolean; cdecl;
    function isTerminating: Boolean; cdecl;
    function prestartAllCoreThreads: Integer; cdecl;
    function prestartCoreThread: Boolean; cdecl;
    procedure purge; cdecl;
    function remove(task: JRunnable): Boolean; cdecl;
    procedure setCorePoolSize(corePoolSize: Integer); cdecl;
    procedure setKeepAliveTime(time: Int64; unit_: JTimeUnit); cdecl;
    procedure setMaximumPoolSize(maximumPoolSize: Integer); cdecl;
    procedure setRejectedExecutionHandler(handler: JRejectedExecutionHandler); cdecl;
    procedure setThreadFactory(threadFactory: JThreadFactory); cdecl;
    procedure shutdown; cdecl;
    function shutdownNow: JList; cdecl;
    function toString: JString; cdecl;
  end;
  TJThreadPoolExecutor = class(TJavaGenericImport<JThreadPoolExecutorClass, JThreadPoolExecutor>) end;

  JScheduledThreadPoolExecutorClass = interface(JThreadPoolExecutorClass)
    ['{E97835A3-4211-4A02-AC53-E0951A70BFCE}']
    {class} function init(corePoolSize: Integer): JScheduledThreadPoolExecutor; cdecl; overload;
    {class} function init(corePoolSize: Integer; threadFactory: JThreadFactory): JScheduledThreadPoolExecutor; cdecl; overload;
    {class} function init(corePoolSize: Integer; handler: JRejectedExecutionHandler): JScheduledThreadPoolExecutor; cdecl; overload;
    {class} function init(corePoolSize: Integer; threadFactory: JThreadFactory; handler: JRejectedExecutionHandler): JScheduledThreadPoolExecutor; cdecl; overload;
  end;

  [JavaSignature('java/util/concurrent/ScheduledThreadPoolExecutor')]
  JScheduledThreadPoolExecutor = interface(JThreadPoolExecutor)
    ['{7E9D716D-A52D-440A-B55A-21B9832960C6}']
    procedure execute(command: JRunnable); cdecl;
    function getContinueExistingPeriodicTasksAfterShutdownPolicy: Boolean; cdecl;
    function getExecuteExistingDelayedTasksAfterShutdownPolicy: Boolean; cdecl;
    function getQueue: JBlockingQueue; cdecl;
    function getRemoveOnCancelPolicy: Boolean; cdecl;
    function schedule(command: JRunnable; delay: Int64; unit_: JTimeUnit): JScheduledFuture; cdecl; overload;
    function schedule(callable: JCallable; delay: Int64; unit_: JTimeUnit): JScheduledFuture; cdecl; overload;
    function scheduleAtFixedRate(command: JRunnable; initialDelay: Int64; period: Int64; unit_: JTimeUnit): JScheduledFuture; cdecl;
    function scheduleWithFixedDelay(command: JRunnable; initialDelay: Int64; delay: Int64; unit_: JTimeUnit): JScheduledFuture; cdecl;
    procedure setContinueExistingPeriodicTasksAfterShutdownPolicy(value: Boolean); cdecl;
    procedure setExecuteExistingDelayedTasksAfterShutdownPolicy(value: Boolean); cdecl;
    procedure setRemoveOnCancelPolicy(value: Boolean); cdecl;
    procedure shutdown; cdecl;
    function shutdownNow: JList; cdecl;
    function submit(task: JRunnable): JFuture; cdecl; overload;
    function submit(task: JRunnable; result: JObject): JFuture; cdecl; overload;
    function submit(task: JCallable): JFuture; cdecl; overload;
  end;
  TJScheduledThreadPoolExecutor = class(TJavaGenericImport<JScheduledThreadPoolExecutorClass, JScheduledThreadPoolExecutor>) end;

  JThreadFactoryClass = interface(IJavaClass)
    ['{CD4277E8-4960-409B-B76C-70D202901E27}']
  end;

  [JavaSignature('java/util/concurrent/ThreadFactory')]
  JThreadFactory = interface(IJavaInstance)
    ['{D96A16B3-CE4E-4293-9BB0-FE84575F7E19}']
    function newThread(r: JRunnable): JThread; cdecl;
  end;
  TJThreadFactory = class(TJavaGenericImport<JThreadFactoryClass, JThreadFactory>) end;

  JTimeUnitClass = interface(JEnumClass)
    ['{005AE9B1-228D-48C4-BFD2-41DCEE712F3B}']
    {class} function _GetDAYS: JTimeUnit; cdecl;
    {class} function _GetHOURS: JTimeUnit; cdecl;
    {class} function _GetMICROSECONDS: JTimeUnit; cdecl;
    {class} function _GetMILLISECONDS: JTimeUnit; cdecl;
    {class} function _GetMINUTES: JTimeUnit; cdecl;
    {class} function _GetNANOSECONDS: JTimeUnit; cdecl;
    {class} function _GetSECONDS: JTimeUnit; cdecl;
    {class} function valueOf(name: JString): JTimeUnit; cdecl;
    {class} function values: TJavaObjectArray<JTimeUnit>; cdecl;
    {class} property DAYS: JTimeUnit read _GetDAYS;
    {class} property HOURS: JTimeUnit read _GetHOURS;
    {class} property MICROSECONDS: JTimeUnit read _GetMICROSECONDS;
    {class} property MILLISECONDS: JTimeUnit read _GetMILLISECONDS;
    {class} property MINUTES: JTimeUnit read _GetMINUTES;
    {class} property NANOSECONDS: JTimeUnit read _GetNANOSECONDS;
    {class} property SECONDS: JTimeUnit read _GetSECONDS;
  end;

  [JavaSignature('java/util/concurrent/TimeUnit')]
  JTimeUnit = interface(JEnum)
    ['{97B8E3BD-6430-4597-B01D-CD2AD51ECB2C}']
    function convert(sourceDuration: Int64; sourceUnit: JTimeUnit): Int64; cdecl;
    procedure sleep(timeout: Int64); cdecl;
    procedure timedJoin(thread: JThread; timeout: Int64); cdecl;
    procedure timedWait(obj: JObject; timeout: Int64); cdecl;
    function toDays(duration: Int64): Int64; cdecl;
    function toHours(duration: Int64): Int64; cdecl;
    function toMicros(duration: Int64): Int64; cdecl;
    function toMillis(duration: Int64): Int64; cdecl;
    function toMinutes(duration: Int64): Int64; cdecl;
    function toNanos(duration: Int64): Int64; cdecl;
    function toSeconds(duration: Int64): Int64; cdecl;
  end;
  TJTimeUnit = class(TJavaGenericImport<JTimeUnitClass, JTimeUnit>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JAbstractCollection', TypeInfo(Androidapi.JNI.JavaUtil.JAbstractCollection));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JAbstractList', TypeInfo(Androidapi.JNI.JavaUtil.JAbstractList));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JAbstractMap', TypeInfo(Androidapi.JNI.JavaUtil.JAbstractMap));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JAbstractSet', TypeInfo(Androidapi.JNI.JavaUtil.JAbstractSet));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JArrayList', TypeInfo(Androidapi.JNI.JavaUtil.JArrayList));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JBitSet', TypeInfo(Androidapi.JNI.JavaUtil.JBitSet));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JCalendar', TypeInfo(Androidapi.JNI.JavaUtil.JCalendar));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JCollection', TypeInfo(Androidapi.JNI.JavaUtil.JCollection));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JComparator', TypeInfo(Androidapi.JNI.JavaUtil.JComparator));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JDate', TypeInfo(Androidapi.JNI.JavaUtil.JDate));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JDictionary', TypeInfo(Androidapi.JNI.JavaUtil.JDictionary));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JEnumSet', TypeInfo(Androidapi.JNI.JavaUtil.JEnumSet));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JEnumeration', TypeInfo(Androidapi.JNI.JavaUtil.JEnumeration));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JGregorianCalendar', TypeInfo(Androidapi.JNI.JavaUtil.JGregorianCalendar));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JHashMap', TypeInfo(Androidapi.JNI.JavaUtil.JHashMap));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JHashSet', TypeInfo(Androidapi.JNI.JavaUtil.JHashSet));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JHashtable', TypeInfo(Androidapi.JNI.JavaUtil.JHashtable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JIterator', TypeInfo(Androidapi.JNI.JavaUtil.JIterator));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JList', TypeInfo(Androidapi.JNI.JavaUtil.JList));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JListIterator', TypeInfo(Androidapi.JNI.JavaUtil.JListIterator));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JLocale', TypeInfo(Androidapi.JNI.JavaUtil.JLocale));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JMap', TypeInfo(Androidapi.JNI.JavaUtil.JMap));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.Jutil_Observable', TypeInfo(Androidapi.JNI.JavaUtil.Jutil_Observable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JObserver', TypeInfo(Androidapi.JNI.JavaUtil.JObserver));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JProperties', TypeInfo(Androidapi.JNI.JavaUtil.JProperties));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JQueue', TypeInfo(Androidapi.JNI.JavaUtil.JQueue));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JRandom', TypeInfo(Androidapi.JNI.JavaUtil.JRandom));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JSet', TypeInfo(Androidapi.JNI.JavaUtil.JSet));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JSortedMap', TypeInfo(Androidapi.JNI.JavaUtil.JSortedMap));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JTimeZone', TypeInfo(Androidapi.JNI.JavaUtil.JTimeZone));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JTimer', TypeInfo(Androidapi.JNI.JavaUtil.JTimer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JTimerTask', TypeInfo(Androidapi.JNI.JavaUtil.JTimerTask));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JUUID', TypeInfo(Androidapi.JNI.JavaUtil.JUUID));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JAbstractExecutorService', TypeInfo(Androidapi.JNI.JavaUtil.JAbstractExecutorService));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JBlockingQueue', TypeInfo(Androidapi.JNI.JavaUtil.JBlockingQueue));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JCallable', TypeInfo(Androidapi.JNI.JavaUtil.JCallable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JCountDownLatch', TypeInfo(Androidapi.JNI.JavaUtil.JCountDownLatch));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JDelayed', TypeInfo(Androidapi.JNI.JavaUtil.JDelayed));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JExecutor', TypeInfo(Androidapi.JNI.JavaUtil.JExecutor));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JExecutorService', TypeInfo(Androidapi.JNI.JavaUtil.JExecutorService));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JFuture', TypeInfo(Androidapi.JNI.JavaUtil.JFuture));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JRejectedExecutionHandler', TypeInfo(Androidapi.JNI.JavaUtil.JRejectedExecutionHandler));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JScheduledFuture', TypeInfo(Androidapi.JNI.JavaUtil.JScheduledFuture));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JThreadPoolExecutor', TypeInfo(Androidapi.JNI.JavaUtil.JThreadPoolExecutor));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JScheduledThreadPoolExecutor', TypeInfo(Androidapi.JNI.JavaUtil.JScheduledThreadPoolExecutor));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JThreadFactory', TypeInfo(Androidapi.JNI.JavaUtil.JThreadFactory));
  TRegTypes.RegisterType('Androidapi.JNI.JavaUtil.JTimeUnit', TypeInfo(Androidapi.JNI.JavaUtil.JTimeUnit));
end;

initialization
  RegisterTypes;
end.


