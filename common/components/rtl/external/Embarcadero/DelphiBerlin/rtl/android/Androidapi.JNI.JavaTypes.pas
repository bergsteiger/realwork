{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.JNI.JavaTypes;

interface

uses
  Androidapi.JNIBridge;

type
// ===== Forward declarations =====

  JObject = interface;//java.lang.Object
  JInputStream = interface;//java.io.InputStream
  JByteArrayInputStream = interface;//java.io.ByteArrayInputStream
  JOutputStream = interface;//java.io.OutputStream
  JByteArrayOutputStream = interface;//java.io.ByteArrayOutputStream
  JAutoCloseable = interface;//java.lang.AutoCloseable
  JCloseable = interface;//java.io.Closeable
  JFile = interface;//java.io.File
  JFileDescriptor = interface;//java.io.FileDescriptor
  JFileFilter = interface;//java.io.FileFilter
  JFileInputStream = interface;//java.io.FileInputStream
  JFileOutputStream = interface;//java.io.FileOutputStream
  JFilenameFilter = interface;//java.io.FilenameFilter
  JFilterOutputStream = interface;//java.io.FilterOutputStream
  JThrowable = interface;//java.lang.Throwable
  JException = interface;//java.lang.Exception
  JIOException = interface;//java.io.IOException
  JPrintStream = interface;//java.io.PrintStream
  JWriter = interface;//java.io.Writer
  JPrintWriter = interface;//java.io.PrintWriter
  JRandomAccessFile = interface;//java.io.RandomAccessFile
  JReader = interface;//java.io.Reader
  JSerializable = interface;//java.io.Serializable
  JAbstractStringBuilder = interface;//java.lang.AbstractStringBuilder
  JBoolean = interface;//java.lang.Boolean
  JNumber = interface;//java.lang.Number
  JByte = interface;//java.lang.Byte
  JCharSequence = interface;//java.lang.CharSequence
  Jlang_Class = interface;//java.lang.Class
  JClassLoader = interface;//java.lang.ClassLoader
  JComparable = interface;//java.lang.Comparable
  JDouble = interface;//java.lang.Double
  JEnum = interface;//java.lang.Enum
  JFloat = interface;//java.lang.Float
  JRuntimeException = interface;//java.lang.RuntimeException
  JIllegalStateException = interface;//java.lang.IllegalStateException
  JInteger = interface;//java.lang.Integer
  JIterable = interface;//java.lang.Iterable
  JLong = interface;//java.lang.Long
  JPackage = interface;//java.lang.Package
  JRunnable = interface;//java.lang.Runnable
  JShort = interface;//java.lang.Short
  JStackTraceElement = interface;//java.lang.StackTraceElement
  JString = interface;//java.lang.String
  JStringBuffer = interface;//java.lang.StringBuffer
  JStringBuilder = interface;//java.lang.StringBuilder
  JThread = interface;//java.lang.Thread
  JThread_State = interface;//java.lang.Thread$State
  JThread_UncaughtExceptionHandler = interface;//java.lang.Thread$UncaughtExceptionHandler
  JThreadGroup = interface;//java.lang.ThreadGroup
  JAnnotation = interface;//java.lang.annotation.Annotation
  JAccessibleObject = interface;//java.lang.reflect.AccessibleObject
  JConstructor = interface;//java.lang.reflect.Constructor
  JField = interface;//java.lang.reflect.Field
  JGenericDeclaration = interface;//java.lang.reflect.GenericDeclaration
  JMethod = interface;//java.lang.reflect.Method
  Jreflect_Type = interface;//java.lang.reflect.Type
  JTypeVariable = interface;//java.lang.reflect.TypeVariable
  JBigInteger = interface;//java.math.BigInteger
  JBuffer = interface;//java.nio.Buffer
  JByteBuffer = interface;//java.nio.ByteBuffer
  JByteOrder = interface;//java.nio.ByteOrder
  JCharBuffer = interface;//java.nio.CharBuffer
  JDoubleBuffer = interface;//java.nio.DoubleBuffer
  JFloatBuffer = interface;//java.nio.FloatBuffer
  JIntBuffer = interface;//java.nio.IntBuffer
  JLongBuffer = interface;//java.nio.LongBuffer
  JMappedByteBuffer = interface;//java.nio.MappedByteBuffer
  JShortBuffer = interface;//java.nio.ShortBuffer
  JChannel = interface;//java.nio.channels.Channel
  JAbstractInterruptibleChannel = interface;//java.nio.channels.spi.AbstractInterruptibleChannel
  JSelectableChannel = interface;//java.nio.channels.SelectableChannel
  JAbstractSelectableChannel = interface;//java.nio.channels.spi.AbstractSelectableChannel
  JDatagramChannel = interface;//java.nio.channels.DatagramChannel
  JFileChannel = interface;//java.nio.channels.FileChannel
  JFileChannel_MapMode = interface;//java.nio.channels.FileChannel$MapMode
  JFileLock = interface;//java.nio.channels.FileLock
  JPipe = interface;//java.nio.channels.Pipe
  JPipe_SinkChannel = interface;//java.nio.channels.Pipe$SinkChannel
  JPipe_SourceChannel = interface;//java.nio.channels.Pipe$SourceChannel
  JReadableByteChannel = interface;//java.nio.channels.ReadableByteChannel
  JSelectionKey = interface;//java.nio.channels.SelectionKey
  JSelector = interface;//java.nio.channels.Selector
  JServerSocketChannel = interface;//java.nio.channels.ServerSocketChannel
  JSocketChannel = interface;//java.nio.channels.SocketChannel
  JWritableByteChannel = interface;//java.nio.channels.WritableByteChannel
  JAbstractSelector = interface;//java.nio.channels.spi.AbstractSelector
  JSelectorProvider = interface;//java.nio.channels.spi.SelectorProvider
  JCharset = interface;//java.nio.charset.Charset
  JCharsetDecoder = interface;//java.nio.charset.CharsetDecoder
  JCharsetEncoder = interface;//java.nio.charset.CharsetEncoder
  JCoderResult = interface;//java.nio.charset.CoderResult
  JCodingErrorAction = interface;//java.nio.charset.CodingErrorAction
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
  JUUID = interface;//java.util.UUID
  JBlockingQueue = interface;//java.util.concurrent.BlockingQueue
  JCallable = interface;//java.util.concurrent.Callable
  JCountDownLatch = interface;//java.util.concurrent.CountDownLatch
  JExecutor = interface;//java.util.concurrent.Executor
  JExecutorService = interface;//java.util.concurrent.ExecutorService
  JFuture = interface;//java.util.concurrent.Future
  JTimeUnit = interface;//java.util.concurrent.TimeUnit
  //JSecretKey = interface;//javax.crypto.SecretKey
  JEGL = interface;//javax.microedition.khronos.egl.EGL
  JEGL10 = interface;//javax.microedition.khronos.egl.EGL10
  JEGLConfig = interface;//javax.microedition.khronos.egl.EGLConfig
  JEGLContext = interface;//javax.microedition.khronos.egl.EGLContext
  JEGLDisplay = interface;//javax.microedition.khronos.egl.EGLDisplay
  JEGLSurface = interface;//javax.microedition.khronos.egl.EGLSurface
  JGL = interface;//javax.microedition.khronos.opengles.GL
  JGL10 = interface;//javax.microedition.khronos.opengles.GL10
  JJSONArray = interface;//org.json.JSONArray
  JJSONException = interface;//org.json.JSONException
  JJSONObject = interface;//org.json.JSONObject
  JJSONTokener = interface;//org.json.JSONTokener
  JXmlPullParser = interface;//org.xmlpull.v1.XmlPullParser
  JXmlSerializer = interface;//org.xmlpull.v1.XmlSerializer

// ===== Interface declarations =====

  JObjectClass = interface(IJavaClass)
    ['{83BD30EE-FE9B-470D-AD6C-23AEAABB7FFA}']
    {class} function init: JObject; cdecl;
  end;

  [JavaSignature('java/lang/Object')]
  JObject = interface(IJavaInstance)
    ['{32321F8A-4001-4BF8-92E7-6190D070988D}']
    function equals(o: JObject): Boolean; cdecl;
    function getClass: Jlang_Class; cdecl;
    function hashCode: Integer; cdecl;
    procedure notify; cdecl;
    procedure notifyAll; cdecl;
    function toString: JString; cdecl;
    procedure wait; cdecl; overload;
    procedure wait(millis: Int64); cdecl; overload;
    procedure wait(millis: Int64; nanos: Integer); cdecl; overload;
  end;
  TJObject = class(TJavaGenericImport<JObjectClass, JObject>) end;

  JInputStreamClass = interface(JObjectClass)
    ['{8D8C2F8A-AD54-42D0-ADA4-FC30FD95A933}']
    {class} function init: JInputStream; cdecl;
  end;

  [JavaSignature('java/io/InputStream')]
  JInputStream = interface(JObject)
    ['{5FD3C203-8A19-42A2-8FD2-643501DF62BC}']
    function available: Integer; cdecl;
    procedure close; cdecl;
    procedure mark(readlimit: Integer); cdecl;
    function markSupported: Boolean; cdecl;
    function read: Integer; cdecl; overload;
    function read(buffer: TJavaArray<Byte>): Integer; cdecl; overload;
    function read(buffer: TJavaArray<Byte>; byteOffset: Integer; byteCount: Integer): Integer; cdecl; overload;
    procedure reset; cdecl;
    function skip(byteCount: Int64): Int64; cdecl;
  end;
  TJInputStream = class(TJavaGenericImport<JInputStreamClass, JInputStream>) end;

  JByteArrayInputStreamClass = interface(JInputStreamClass)
    ['{1C0763C7-3F23-4531-A6E1-65AF97251C2F}']
    {class} function init(buf: TJavaArray<Byte>): JByteArrayInputStream; cdecl; overload;
    {class} function init(buf: TJavaArray<Byte>; offset: Integer; length: Integer): JByteArrayInputStream; cdecl; overload;
  end;

  [JavaSignature('java/io/ByteArrayInputStream')]
  JByteArrayInputStream = interface(JInputStream)
    ['{D8AE245D-6831-48AC-A6F5-1E480815A22D}']
    function available: Integer; cdecl;
    procedure close; cdecl;
    procedure mark(readlimit: Integer); cdecl;
    function markSupported: Boolean; cdecl;
    function read: Integer; cdecl; overload;
    function read(buffer: TJavaArray<Byte>; byteOffset: Integer; byteCount: Integer): Integer; cdecl; overload;
    procedure reset; cdecl;
    function skip(byteCount: Int64): Int64; cdecl;
  end;
  TJByteArrayInputStream = class(TJavaGenericImport<JByteArrayInputStreamClass, JByteArrayInputStream>) end;

  JOutputStreamClass = interface(JObjectClass)
    ['{769D969C-3DFB-417B-8B7E-AA5662FB1539}']
    {class} function init: JOutputStream; cdecl;
  end;

  [JavaSignature('java/io/OutputStream')]
  JOutputStream = interface(JObject)
    ['{308A10DA-ACF9-4EC3-B4BD-D9F9CEEB29A5}']
    procedure close; cdecl;
    procedure flush; cdecl;
    procedure write(buffer: TJavaArray<Byte>); cdecl; overload;
    procedure write(buffer: TJavaArray<Byte>; offset: Integer; count: Integer); cdecl; overload;
    procedure write(oneByte: Integer); cdecl; overload;
  end;
  TJOutputStream = class(TJavaGenericImport<JOutputStreamClass, JOutputStream>) end;

  JByteArrayOutputStreamClass = interface(JOutputStreamClass)
    ['{2F08E462-5F49-4A89-9ACD-F0A5CD01C3A8}']
    {class} function init: JByteArrayOutputStream; cdecl; overload;
    {class} function init(size: Integer): JByteArrayOutputStream; cdecl; overload;
  end;

  [JavaSignature('java/io/ByteArrayOutputStream')]
  JByteArrayOutputStream = interface(JOutputStream)
    ['{6AD653C4-3A67-4CCD-9B53-2E57D0DC0727}']
    procedure close; cdecl;
    procedure reset; cdecl;
    function size: Integer; cdecl;
    function toByteArray: TJavaArray<Byte>; cdecl;
    function toString: JString; cdecl; overload;
    function toString(hibyte: Integer): JString; cdecl; overload;//Deprecated
    function toString(charsetName: JString): JString; cdecl; overload;
    procedure write(buffer: TJavaArray<Byte>; offset: Integer; len: Integer); cdecl; overload;
    procedure write(oneByte: Integer); cdecl; overload;
    procedure writeTo(out_: JOutputStream); cdecl;
  end;
  TJByteArrayOutputStream = class(TJavaGenericImport<JByteArrayOutputStreamClass, JByteArrayOutputStream>) end;

  JAutoCloseableClass = interface(IJavaClass)
    ['{BC0BF424-12A8-4AA4-ABC4-29A2BCE762E3}']
  end;

  [JavaSignature('java/lang/AutoCloseable')]
  JAutoCloseable = interface(IJavaInstance)
    ['{48D31CFB-52DE-4C24-985E-3601B839C436}']
    procedure close; cdecl;
  end;
  TJAutoCloseable = class(TJavaGenericImport<JAutoCloseableClass, JAutoCloseable>) end;

  JCloseableClass = interface(JAutoCloseableClass)
    ['{CAFF3044-E3EC-444F-AF50-403A65BFA20B}']
  end;

  [JavaSignature('java/io/Closeable')]
  JCloseable = interface(JAutoCloseable)
    ['{DD3E86BD-46E1-44D8-84DD-B7607A3F9C56}']
    procedure close; cdecl;
  end;
  TJCloseable = class(TJavaGenericImport<JCloseableClass, JCloseable>) end;

  JFileClass = interface(JObjectClass)
    ['{D2CE81B7-01CE-468B-A2F2-B85DD35642EC}']
    {class} function _GetpathSeparator: JString; cdecl;
    {class} function _GetpathSeparatorChar: Char; cdecl;
    {class} function _Getseparator: JString; cdecl;
    {class} function _GetseparatorChar: Char; cdecl;
    {class} function init(dir: JFile; name: JString): JFile; cdecl; overload;
    {class} function init(path: JString): JFile; cdecl; overload;
    {class} function init(dirPath: JString; name: JString): JFile; cdecl; overload;
    {class} //function init(uri: JURI): JFile; cdecl; overload;
    {class} function createTempFile(prefix: JString; suffix: JString): JFile; cdecl; overload;
    {class} function createTempFile(prefix: JString; suffix: JString; directory: JFile): JFile; cdecl; overload;
    {class} function listRoots: TJavaObjectArray<JFile>; cdecl;
    {class} property pathSeparator: JString read _GetpathSeparator;
    {class} property pathSeparatorChar: Char read _GetpathSeparatorChar;
    {class} property separator: JString read _Getseparator;
    {class} property separatorChar: Char read _GetseparatorChar;
  end;

  [JavaSignature('java/io/File')]
  JFile = interface(JObject)
    ['{38C3EB7E-315A-47D2-9052-1E61170EB37F}']
    function canExecute: Boolean; cdecl;
    function canRead: Boolean; cdecl;
    function canWrite: Boolean; cdecl;
    function compareTo(another: JFile): Integer; cdecl;
    function createNewFile: Boolean; cdecl;
    function delete: Boolean; cdecl;
    procedure deleteOnExit; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function exists: Boolean; cdecl;
    function getAbsoluteFile: JFile; cdecl;
    function getAbsolutePath: JString; cdecl;
    function getCanonicalFile: JFile; cdecl;
    function getCanonicalPath: JString; cdecl;
    function getFreeSpace: Int64; cdecl;
    function getName: JString; cdecl;
    function getParent: JString; cdecl;
    function getParentFile: JFile; cdecl;
    function getPath: JString; cdecl;
    function getTotalSpace: Int64; cdecl;
    function getUsableSpace: Int64; cdecl;
    function hashCode: Integer; cdecl;
    function isAbsolute: Boolean; cdecl;
    function isDirectory: Boolean; cdecl;
    function isFile: Boolean; cdecl;
    function isHidden: Boolean; cdecl;
    function lastModified: Int64; cdecl;
    function length: Int64; cdecl;
    function list: TJavaObjectArray<JString>; cdecl; overload;
    function list(filter: JFilenameFilter): TJavaObjectArray<JString>; cdecl; overload;
    function listFiles: TJavaObjectArray<JFile>; cdecl; overload;
    function listFiles(filter: JFilenameFilter): TJavaObjectArray<JFile>; cdecl; overload;
    function listFiles(filter: JFileFilter): TJavaObjectArray<JFile>; cdecl; overload;
    function mkdir: Boolean; cdecl;
    function mkdirs: Boolean; cdecl;
    function renameTo(newPath: JFile): Boolean; cdecl;
    function setExecutable(executable: Boolean; ownerOnly: Boolean): Boolean; cdecl; overload;
    function setExecutable(executable: Boolean): Boolean; cdecl; overload;
    function setLastModified(time: Int64): Boolean; cdecl;
    function setReadOnly: Boolean; cdecl;
    function setReadable(readable: Boolean; ownerOnly: Boolean): Boolean; cdecl; overload;
    function setReadable(readable: Boolean): Boolean; cdecl; overload;
    function setWritable(writable: Boolean; ownerOnly: Boolean): Boolean; cdecl; overload;
    function setWritable(writable: Boolean): Boolean; cdecl; overload;
    function toString: JString; cdecl;
    //function toURI: JURI; cdecl;
    //function toURL: JURL; cdecl;//Deprecated
  end;
  TJFile = class(TJavaGenericImport<JFileClass, JFile>) end;

  JFileDescriptorClass = interface(JObjectClass)
    ['{B01F2343-4F8E-4FF8-838E-8FB9CFE304E2}']
    {class} function _Geterr: JFileDescriptor; cdecl;
    {class} function _Getin: JFileDescriptor; cdecl;
    {class} function _Getout: JFileDescriptor; cdecl;
    {class} function init: JFileDescriptor; cdecl;
    {class} property err: JFileDescriptor read _Geterr;
    {class} property &in: JFileDescriptor read _Getin;
    {class} property &out: JFileDescriptor read _Getout;
  end;

  [JavaSignature('java/io/FileDescriptor')]
  JFileDescriptor = interface(JObject)
    ['{B6D7B003-DD99-4563-93A3-F902501CD6C1}']
    procedure sync; cdecl;
    function toString: JString; cdecl;
    function valid: Boolean; cdecl;
  end;
  TJFileDescriptor = class(TJavaGenericImport<JFileDescriptorClass, JFileDescriptor>) end;

  JFileFilterClass = interface(IJavaClass)
    ['{74779212-F9FA-40FE-A5C2-41FBC7919220}']
  end;

  [JavaSignature('java/io/FileFilter')]
  JFileFilter = interface(IJavaInstance)
    ['{5A5564B5-D25E-4D6A-AF92-F0725E9011DE}']
    function accept(pathname: JFile): Boolean; cdecl;
  end;
  TJFileFilter = class(TJavaGenericImport<JFileFilterClass, JFileFilter>) end;

  JFileInputStreamClass = interface(JInputStreamClass)
    ['{A1EB6AE5-8562-4E38-8182-61F57E51733A}']
    {class} function init(file_: JFile): JFileInputStream; cdecl; overload;
    {class} function init(fd: JFileDescriptor): JFileInputStream; cdecl; overload;
    {class} function init(path: JString): JFileInputStream; cdecl; overload;
  end;

  [JavaSignature('java/io/FileInputStream')]
  JFileInputStream = interface(JInputStream)
    ['{55CBCA4D-B04C-442A-BD74-ADFFD715A1A5}']
    function available: Integer; cdecl;
    procedure close; cdecl;
    function getChannel: JFileChannel; cdecl;
    function getFD: JFileDescriptor; cdecl;
    function read: Integer; cdecl; overload;
    function read(buffer: TJavaArray<Byte>; byteOffset: Integer; byteCount: Integer): Integer; cdecl; overload;
    function skip(byteCount: Int64): Int64; cdecl;
  end;
  TJFileInputStream = class(TJavaGenericImport<JFileInputStreamClass, JFileInputStream>) end;

  JFileOutputStreamClass = interface(JOutputStreamClass)
    ['{4808736C-4C9B-46DF-A1B6-EB94324D9666}']
    {class} function init(file_: JFile): JFileOutputStream; cdecl; overload;
    {class} function init(file_: JFile; append: Boolean): JFileOutputStream; cdecl; overload;
    {class} function init(fd: JFileDescriptor): JFileOutputStream; cdecl; overload;
    {class} function init(path: JString): JFileOutputStream; cdecl; overload;
    {class} function init(path: JString; append: Boolean): JFileOutputStream; cdecl; overload;
  end;

  [JavaSignature('java/io/FileOutputStream')]
  JFileOutputStream = interface(JOutputStream)
    ['{3D49DAFB-A222-4001-9DBE-7FAE66E23404}']
    procedure close; cdecl;
    function getChannel: JFileChannel; cdecl;
    function getFD: JFileDescriptor; cdecl;
    procedure write(buffer: TJavaArray<Byte>; byteOffset: Integer; byteCount: Integer); cdecl; overload;
    procedure write(oneByte: Integer); cdecl; overload;
  end;
  TJFileOutputStream = class(TJavaGenericImport<JFileOutputStreamClass, JFileOutputStream>) end;

  JFilenameFilterClass = interface(IJavaClass)
    ['{E466E540-E65D-43EC-8913-E8F8AEEA354F}']
  end;

  [JavaSignature('java/io/FilenameFilter')]
  JFilenameFilter = interface(IJavaInstance)
    ['{B55A4F67-1AE9-41F5-BCF8-305D3902A782}']
    function accept(dir: JFile; filename: JString): Boolean; cdecl;
  end;
  TJFilenameFilter = class(TJavaGenericImport<JFilenameFilterClass, JFilenameFilter>) end;

  JFilterOutputStreamClass = interface(JOutputStreamClass)
    ['{4273682E-2DA8-4BA9-BFC7-A9356DC43D40}']
    {class} function init(out_: JOutputStream): JFilterOutputStream; cdecl;
  end;

  [JavaSignature('java/io/FilterOutputStream')]
  JFilterOutputStream = interface(JOutputStream)
    ['{B0DB7F97-9758-43B1-8FC4-19A12503CD3F}']
    procedure close; cdecl;
    procedure flush; cdecl;
    procedure write(buffer: TJavaArray<Byte>; offset: Integer; length: Integer); cdecl; overload;
    procedure write(oneByte: Integer); cdecl; overload;
  end;
  TJFilterOutputStream = class(TJavaGenericImport<JFilterOutputStreamClass, JFilterOutputStream>) end;

  JThrowableClass = interface(JObjectClass)
    ['{9B871585-74E6-4B49-B4C2-4DB387B0E599}']
    {class} function init: JThrowable; cdecl; overload;
    {class} function init(detailMessage: JString): JThrowable; cdecl; overload;
    {class} function init(detailMessage: JString; cause: JThrowable): JThrowable; cdecl; overload;
    {class} function init(cause: JThrowable): JThrowable; cdecl; overload;
  end;

  [JavaSignature('java/lang/Throwable')]
  JThrowable = interface(JObject)
    ['{44BECA0F-21B9-45A8-B21F-8806ABE80CE2}']
    procedure addSuppressed(throwable: JThrowable); cdecl;
    function fillInStackTrace: JThrowable; cdecl;
    function getCause: JThrowable; cdecl;
    function getLocalizedMessage: JString; cdecl;
    function getMessage: JString; cdecl;
    function getStackTrace: TJavaObjectArray<JStackTraceElement>; cdecl;
    function getSuppressed: TJavaObjectArray<JThrowable>; cdecl;
    function initCause(throwable: JThrowable): JThrowable; cdecl;
    procedure printStackTrace; cdecl; overload;
    procedure printStackTrace(err: JPrintStream); cdecl; overload;
    procedure printStackTrace(err: JPrintWriter); cdecl; overload;
    procedure setStackTrace(trace: TJavaObjectArray<JStackTraceElement>); cdecl;
    function toString: JString; cdecl;
  end;
  TJThrowable = class(TJavaGenericImport<JThrowableClass, JThrowable>) end;

  JExceptionClass = interface(JThrowableClass)
    ['{6E1BA58E-A106-4CC0-A40C-99F4E1188B10}']
    {class} function init: JException; cdecl; overload;
    {class} function init(detailMessage: JString): JException; cdecl; overload;
    {class} function init(detailMessage: JString; throwable: JThrowable): JException; cdecl; overload;
    {class} function init(throwable: JThrowable): JException; cdecl; overload;
  end;

  [JavaSignature('java/lang/Exception')]
  JException = interface(JThrowable)
    ['{6EA7D981-2F3C-44C4-B9D2-F581529C08E0}']
  end;
  TJException = class(TJavaGenericImport<JExceptionClass, JException>) end;

  JIOExceptionClass = interface(JExceptionClass)
    ['{24D5DABE-094D-45DB-9F6A-A5AB51B47322}']
    {class} function init: JIOException; cdecl; overload;
    {class} function init(detailMessage: JString): JIOException; cdecl; overload;
    {class} function init(message: JString; cause: JThrowable): JIOException; cdecl; overload;
    {class} function init(cause: JThrowable): JIOException; cdecl; overload;
  end;

  [JavaSignature('java/io/IOException')]
  JIOException = interface(JException)
    ['{7318D96A-B3D4-4168-BDAB-356A539E6399}']
  end;
  TJIOException = class(TJavaGenericImport<JIOExceptionClass, JIOException>) end;

  JPrintStreamClass = interface(JFilterOutputStreamClass)
    ['{4B5683E3-32D0-4225-9A80-FB961D9B334F}']
    {class} function init(out_: JOutputStream): JPrintStream; cdecl; overload;
    {class} function init(out_: JOutputStream; autoFlush: Boolean): JPrintStream; cdecl; overload;
    {class} function init(out_: JOutputStream; autoFlush: Boolean; charsetName: JString): JPrintStream; cdecl; overload;
    {class} function init(file_: JFile): JPrintStream; cdecl; overload;
    {class} function init(file_: JFile; charsetName: JString): JPrintStream; cdecl; overload;
    {class} function init(fileName: JString): JPrintStream; cdecl; overload;
    {class} function init(fileName: JString; charsetName: JString): JPrintStream; cdecl; overload;
  end;

  [JavaSignature('java/io/PrintStream')]
  JPrintStream = interface(JFilterOutputStream)
    ['{8B23171F-06EF-4D87-A463-863F687A7918}']
    function append(c: Char): JPrintStream; cdecl; overload;
    function append(charSequence: JCharSequence): JPrintStream; cdecl; overload;
    function append(charSequence: JCharSequence; start: Integer; end_: Integer): JPrintStream; cdecl; overload;
    function checkError: Boolean; cdecl;
    procedure close; cdecl;
    procedure flush; cdecl;
    procedure print(chars: TJavaArray<Char>); cdecl; overload;
    procedure print(c: Char); cdecl; overload;
    procedure print(d: Double); cdecl; overload;
    procedure print(f: Single); cdecl; overload;
    procedure print(i: Integer); cdecl; overload;
    procedure print(l: Int64); cdecl; overload;
    procedure print(o: JObject); cdecl; overload;
    procedure print(str: JString); cdecl; overload;
    procedure print(b: Boolean); cdecl; overload;
    procedure println; cdecl; overload;
    procedure println(chars: TJavaArray<Char>); cdecl; overload;
    procedure println(c: Char); cdecl; overload;
    procedure println(d: Double); cdecl; overload;
    procedure println(f: Single); cdecl; overload;
    procedure println(i: Integer); cdecl; overload;
    procedure println(l: Int64); cdecl; overload;
    procedure println(o: JObject); cdecl; overload;
    procedure println(str: JString); cdecl; overload;
    procedure println(b: Boolean); cdecl; overload;
    procedure write(buffer: TJavaArray<Byte>; offset: Integer; length: Integer); cdecl; overload;
    procedure write(oneByte: Integer); cdecl; overload;
  end;
  TJPrintStream = class(TJavaGenericImport<JPrintStreamClass, JPrintStream>) end;

  JWriterClass = interface(JObjectClass)
    ['{1B3FE1C9-6FF8-45AE-89D6-267E4CC1F003}']
  end;

  [JavaSignature('java/io/Writer')]
  JWriter = interface(JObject)
    ['{50C5DAA8-B851-43A7-8FF9-E827DC14E67B}']
    function append(c: Char): JWriter; cdecl; overload;
    function append(csq: JCharSequence): JWriter; cdecl; overload;
    function append(csq: JCharSequence; start: Integer; end_: Integer): JWriter; cdecl; overload;
    procedure close; cdecl;
    procedure flush; cdecl;
    procedure write(buf: TJavaArray<Char>); cdecl; overload;
    procedure write(buf: TJavaArray<Char>; offset: Integer; count: Integer); cdecl; overload;
    procedure write(oneChar: Integer); cdecl; overload;
    procedure write(str: JString); cdecl; overload;
    procedure write(str: JString; offset: Integer; count: Integer); cdecl; overload;
  end;
  TJWriter = class(TJavaGenericImport<JWriterClass, JWriter>) end;

  JPrintWriterClass = interface(JWriterClass)
    ['{0176F2C9-CDCB-40D9-B26E-E983BE269B0D}']
    {class} function init(out_: JOutputStream): JPrintWriter; cdecl; overload;
    {class} function init(out_: JOutputStream; autoFlush: Boolean): JPrintWriter; cdecl; overload;
    {class} function init(wr: JWriter): JPrintWriter; cdecl; overload;
    {class} function init(wr: JWriter; autoFlush: Boolean): JPrintWriter; cdecl; overload;
    {class} function init(file_: JFile): JPrintWriter; cdecl; overload;
    {class} function init(file_: JFile; csn: JString): JPrintWriter; cdecl; overload;
    {class} function init(fileName: JString): JPrintWriter; cdecl; overload;
    {class} function init(fileName: JString; csn: JString): JPrintWriter; cdecl; overload;
  end;

  [JavaSignature('java/io/PrintWriter')]
  JPrintWriter = interface(JWriter)
    ['{1C7483CD-045F-4478-A223-A9FBBF9C1D80}']
    function append(c: Char): JPrintWriter; cdecl; overload;
    function append(csq: JCharSequence): JPrintWriter; cdecl; overload;
    function append(csq: JCharSequence; start: Integer; end_: Integer): JPrintWriter; cdecl; overload;
    function checkError: Boolean; cdecl;
    procedure close; cdecl;
    procedure flush; cdecl;
    procedure print(charArray: TJavaArray<Char>); cdecl; overload;
    procedure print(ch: Char); cdecl; overload;
    procedure print(dnum: Double); cdecl; overload;
    procedure print(fnum: Single); cdecl; overload;
    procedure print(inum: Integer); cdecl; overload;
    procedure print(lnum: Int64); cdecl; overload;
    procedure print(obj: JObject); cdecl; overload;
    procedure print(str: JString); cdecl; overload;
    procedure print(bool: Boolean); cdecl; overload;
    procedure println; cdecl; overload;
    procedure println(chars: TJavaArray<Char>); cdecl; overload;
    procedure println(c: Char); cdecl; overload;
    procedure println(d: Double); cdecl; overload;
    procedure println(f: Single); cdecl; overload;
    procedure println(i: Integer); cdecl; overload;
    procedure println(l: Int64); cdecl; overload;
    procedure println(obj: JObject); cdecl; overload;
    procedure println(str: JString); cdecl; overload;
    procedure println(b: Boolean); cdecl; overload;
    procedure write(buf: TJavaArray<Char>); cdecl; overload;
    procedure write(buf: TJavaArray<Char>; offset: Integer; count: Integer); cdecl; overload;
    procedure write(oneChar: Integer); cdecl; overload;
    procedure write(str: JString); cdecl; overload;
    procedure write(str: JString; offset: Integer; count: Integer); cdecl; overload;
  end;
  TJPrintWriter = class(TJavaGenericImport<JPrintWriterClass, JPrintWriter>) end;

  JRandomAccessFileClass = interface(JObjectClass)
    ['{A3AAF4BA-F473-4135-AF7F-13B89D0BA76A}']
    {class} function init(file_: JFile; mode: JString): JRandomAccessFile; cdecl; overload;
    {class} function init(fileName: JString; mode: JString): JRandomAccessFile; cdecl; overload;
  end;

  [JavaSignature('java/io/RandomAccessFile')]
  JRandomAccessFile = interface(JObject)
    ['{59DD1A15-35C5-456F-BBE2-61B628DAE3DB}']
    procedure close; cdecl;
    function getChannel: JFileChannel; cdecl;
    function getFD: JFileDescriptor; cdecl;
    function getFilePointer: Int64; cdecl;
    function length: Int64; cdecl;
    function read: Integer; cdecl; overload;
    function read(buffer: TJavaArray<Byte>): Integer; cdecl; overload;
    function read(buffer: TJavaArray<Byte>; byteOffset: Integer; byteCount: Integer): Integer; cdecl; overload;
    function readBoolean: Boolean; cdecl;
    function readByte: Byte; cdecl;
    function readChar: Char; cdecl;
    function readDouble: Double; cdecl;
    function readFloat: Single; cdecl;
    procedure readFully(dst: TJavaArray<Byte>); cdecl; overload;
    procedure readFully(dst: TJavaArray<Byte>; offset: Integer; byteCount: Integer); cdecl; overload;
    function readInt: Integer; cdecl;
    function readLine: JString; cdecl;
    function readLong: Int64; cdecl;
    function readShort: SmallInt; cdecl;
    function readUTF: JString; cdecl;
    function readUnsignedByte: Integer; cdecl;
    function readUnsignedShort: Integer; cdecl;
    procedure seek(offset: Int64); cdecl;
    procedure setLength(newLength: Int64); cdecl;
    function skipBytes(count: Integer): Integer; cdecl;
    procedure write(buffer: TJavaArray<Byte>); cdecl; overload;
    procedure write(buffer: TJavaArray<Byte>; byteOffset: Integer; byteCount: Integer); cdecl; overload;
    procedure write(oneByte: Integer); cdecl; overload;
    procedure writeBoolean(val: Boolean); cdecl;
    procedure writeByte(val: Integer); cdecl;
    procedure writeBytes(str: JString); cdecl;
    procedure writeChar(val: Integer); cdecl;
    procedure writeChars(str: JString); cdecl;
    procedure writeDouble(val: Double); cdecl;
    procedure writeFloat(val: Single); cdecl;
    procedure writeInt(val: Integer); cdecl;
    procedure writeLong(val: Int64); cdecl;
    procedure writeShort(val: Integer); cdecl;
    procedure writeUTF(str: JString); cdecl;
  end;
  TJRandomAccessFile = class(TJavaGenericImport<JRandomAccessFileClass, JRandomAccessFile>) end;

  JReaderClass = interface(JObjectClass)
    ['{C04A4F72-F3EC-4774-9336-AA82265956FF}']
  end;

  [JavaSignature('java/io/Reader')]
  JReader = interface(JObject)
    ['{D163CFD3-9781-435C-8FF5-98667DCD8189}']
    procedure close; cdecl;
    procedure mark(readLimit: Integer); cdecl;
    function markSupported: Boolean; cdecl;
    function read: Integer; cdecl; overload;
    function read(buffer: TJavaArray<Char>): Integer; cdecl; overload;
    function read(buffer: TJavaArray<Char>; offset: Integer; count: Integer): Integer; cdecl; overload;
    function read(target: JCharBuffer): Integer; cdecl; overload;
    function ready: Boolean; cdecl;
    procedure reset; cdecl;
    function skip(charCount: Int64): Int64; cdecl;
  end;
  TJReader = class(TJavaGenericImport<JReaderClass, JReader>) end;

  JSerializableClass = interface(IJavaClass)
    ['{BFE14BCE-11F1-41B5-A14F-3217521E82BA}']
  end;

  [JavaSignature('java/io/Serializable')]
  JSerializable = interface(IJavaInstance)
    ['{D24AB8DC-4E6F-411D-9C40-2210F71A3B0D}']
  end;
  TJSerializable = class(TJavaGenericImport<JSerializableClass, JSerializable>) end;

  JAbstractStringBuilderClass = interface(JObjectClass)
    ['{A3321EF2-EA76-44CD-90CE-DFDADB9936BD}']
  end;

  [JavaSignature('java/lang/AbstractStringBuilder')]
  JAbstractStringBuilder = interface(JObject)
    ['{39A0E6C5-8F79-44ED-BECB-02252CA2F5C0}']
    function capacity: Integer; cdecl;
    function charAt(index: Integer): Char; cdecl;
    function codePointAt(index: Integer): Integer; cdecl;
    function codePointBefore(index: Integer): Integer; cdecl;
    function codePointCount(start: Integer; end_: Integer): Integer; cdecl;
    procedure ensureCapacity(min: Integer); cdecl;
    procedure getChars(start: Integer; end_: Integer; dst: TJavaArray<Char>; dstStart: Integer); cdecl;
    function indexOf(string_: JString): Integer; cdecl; overload;
    function indexOf(subString: JString; start: Integer): Integer; cdecl; overload;
    function lastIndexOf(string_: JString): Integer; cdecl; overload;
    function lastIndexOf(subString: JString; start: Integer): Integer; cdecl; overload;
    function length: Integer; cdecl;
    function offsetByCodePoints(index: Integer; codePointOffset: Integer): Integer; cdecl;
    procedure setCharAt(index: Integer; ch: Char); cdecl;
    procedure setLength(length: Integer); cdecl;
    function subSequence(start: Integer; end_: Integer): JCharSequence; cdecl;
    function substring(start: Integer): JString; cdecl; overload;
    function substring(start: Integer; end_: Integer): JString; cdecl; overload;
    function toString: JString; cdecl;
    procedure trimToSize; cdecl;
  end;
  TJAbstractStringBuilder = class(TJavaGenericImport<JAbstractStringBuilderClass, JAbstractStringBuilder>) end;

  JBooleanClass = interface(JObjectClass)
    ['{CD51CE90-BCDA-4291-99B0-7BC70033C3CB}']
    {class} function _GetFALSE: JBoolean; cdecl;
    {class} function _GetTRUE: JBoolean; cdecl;
    {class} function _GetTYPE: Jlang_Class; cdecl;
    {class} function init(string_: JString): JBoolean; cdecl; overload;
    {class} function init(value: Boolean): JBoolean; cdecl; overload;
    {class} function compare(lhs: Boolean; rhs: Boolean): Integer; cdecl;
    {class} function getBoolean(string_: JString): Boolean; cdecl;
    {class} function parseBoolean(s: JString): Boolean; cdecl;
    {class} function toString(value: Boolean): JString; cdecl; overload;
    {class} function valueOf(string_: JString): JBoolean; cdecl; overload;
    {class} function valueOf(b: Boolean): JBoolean; cdecl; overload;
    {class} property FALSE: JBoolean read _GetFALSE;
    {class} property TRUE: JBoolean read _GetTRUE;
    {class} property &TYPE: Jlang_Class read _GetTYPE;
  end;

  [JavaSignature('java/lang/Boolean')]
  JBoolean = interface(JObject)
    ['{21EAFAED-5848-48C2-9998-141B57439F6F}']
    function booleanValue: Boolean; cdecl;
    function compareTo(that: JBoolean): Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl; overload;
  end;
  TJBoolean = class(TJavaGenericImport<JBooleanClass, JBoolean>) end;

  JNumberClass = interface(JObjectClass)
    ['{9A30B143-2018-4C7B-9E9B-316F62D643C5}']
    {class} function init: JNumber; cdecl;
  end;

  [JavaSignature('java/lang/Number')]
  JNumber = interface(JObject)
    ['{DFF915A9-AFBE-4EDA-89AC-D0FE32A85482}']
    function byteValue: Byte; cdecl;
    function doubleValue: Double; cdecl;
    function floatValue: Single; cdecl;
    function intValue: Integer; cdecl;
    function longValue: Int64; cdecl;
    function shortValue: SmallInt; cdecl;
  end;
  TJNumber = class(TJavaGenericImport<JNumberClass, JNumber>) end;

  JByteClass = interface(JNumberClass)
    ['{EDEFB599-A2A8-49AD-B413-C2FCEBD19B11}']
    {class} function _GetMAX_VALUE: Byte; cdecl;
    {class} function _GetMIN_VALUE: Byte; cdecl;
    {class} function _GetSIZE: Integer; cdecl;
    {class} function _GetTYPE: Jlang_Class; cdecl;
    {class} function init(value: Byte): JByte; cdecl; overload;
    {class} function init(string_: JString): JByte; cdecl; overload;
    {class} function compare(lhs: Byte; rhs: Byte): Integer; cdecl;
    {class} function decode(string_: JString): JByte; cdecl;
    {class} function parseByte(string_: JString): Byte; cdecl; overload;
    {class} function parseByte(string_: JString; radix: Integer): Byte; cdecl; overload;
    {class} function toString(value: Byte): JString; cdecl; overload;
    {class} function valueOf(string_: JString): JByte; cdecl; overload;
    {class} function valueOf(string_: JString; radix: Integer): JByte; cdecl; overload;
    {class} function valueOf(b: Byte): JByte; cdecl; overload;
    {class} property MAX_VALUE: Byte read _GetMAX_VALUE;
    {class} property MIN_VALUE: Byte read _GetMIN_VALUE;
    {class} property SIZE: Integer read _GetSIZE;
    {class} property &TYPE: Jlang_Class read _GetTYPE;
  end;

  [JavaSignature('java/lang/Byte')]
  JByte = interface(JNumber)
    ['{882439AC-111F-445F-B6CD-2E1E8D793CDE}']
    function byteValue: Byte; cdecl;
    function compareTo(object_: JByte): Integer; cdecl;
    function doubleValue: Double; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function floatValue: Single; cdecl;
    function hashCode: Integer; cdecl;
    function intValue: Integer; cdecl;
    function longValue: Int64; cdecl;
    function shortValue: SmallInt; cdecl;
    function toString: JString; cdecl; overload;
  end;
  TJByte = class(TJavaGenericImport<JByteClass, JByte>) end;

  JCharSequenceClass = interface(IJavaClass)
    ['{85DCA69A-F296-4BB4-8FE2-5ECE0EBE6611}']
  end;

  [JavaSignature('java/lang/CharSequence')]
  JCharSequence = interface(IJavaInstance)
    ['{D026566C-D7C6-43E7-AECA-030E2C23A8B8}']
    function charAt(index: Integer): Char; cdecl;
    function length: Integer; cdecl;
    function subSequence(start: Integer; end_: Integer): JCharSequence; cdecl;
    function toString: JString; cdecl;
  end;
  TJCharSequence = class(TJavaGenericImport<JCharSequenceClass, JCharSequence>) end;

  Jlang_ClassClass = interface(JObjectClass)
    ['{E1A7F20A-FD87-4D67-9469-7492FD97D55D}']
    {class} function forName(className: JString): Jlang_Class; cdecl; overload;
    {class} function forName(className: JString; shouldInitialize: Boolean; classLoader: JClassLoader): Jlang_Class; cdecl; overload;
  end;

  [JavaSignature('java/lang/Class')]
  Jlang_Class = interface(JObject)
    ['{B056EDE6-77D8-4CDD-9864-147C201FD87C}']
    function asSubclass(c: Jlang_Class): Jlang_Class; cdecl;
    function cast(obj: JObject): JObject; cdecl;
    function desiredAssertionStatus: Boolean; cdecl;
    function getAnnotation(annotationType: Jlang_Class): JAnnotation; cdecl;
    function getAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function getCanonicalName: JString; cdecl;
    function getClassLoader: JClassLoader; cdecl;
    function getClasses: TJavaObjectArray<Jlang_Class>; cdecl;
    function getComponentType: Jlang_Class; cdecl;
    function getConstructors: TJavaObjectArray<JConstructor>; cdecl;
    function getDeclaredAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function getDeclaredClasses: TJavaObjectArray<Jlang_Class>; cdecl;
    function getDeclaredConstructors: TJavaObjectArray<JConstructor>; cdecl;
    function getDeclaredField(name: JString): JField; cdecl;
    function getDeclaredFields: TJavaObjectArray<JField>; cdecl;
    function getDeclaredMethods: TJavaObjectArray<JMethod>; cdecl;
    function getDeclaringClass: Jlang_Class; cdecl;
    function getEnclosingClass: Jlang_Class; cdecl;
    function getEnclosingConstructor: JConstructor; cdecl;
    function getEnclosingMethod: JMethod; cdecl;
    function getEnumConstants: TJavaObjectArray<JObject>; cdecl;
    function getField(name: JString): JField; cdecl;
    function getFields: TJavaObjectArray<JField>; cdecl;
    function getGenericInterfaces: TJavaObjectArray<Jreflect_Type>; cdecl;
    function getGenericSuperclass: Jreflect_Type; cdecl;
    function getInterfaces: TJavaObjectArray<Jlang_Class>; cdecl;
    function getMethods: TJavaObjectArray<JMethod>; cdecl;
    function getModifiers: Integer; cdecl;
    function getName: JString; cdecl;
    function getPackage: JPackage; cdecl;
    //function getProtectionDomain: JProtectionDomain; cdecl;
    //function getResource(resourceName: JString): JURL; cdecl;
    function getResourceAsStream(resourceName: JString): JInputStream; cdecl;
    function getSigners: TJavaObjectArray<JObject>; cdecl;
    function getSimpleName: JString; cdecl;
    function getSuperclass: Jlang_Class; cdecl;
    function getTypeParameters: TJavaObjectArray<JTypeVariable>; cdecl;
    function isAnnotation: Boolean; cdecl;
    function isAnnotationPresent(annotationType: Jlang_Class): Boolean; cdecl;
    function isAnonymousClass: Boolean; cdecl;
    function isArray: Boolean; cdecl;
    function isAssignableFrom(c: Jlang_Class): Boolean; cdecl;
    function isEnum: Boolean; cdecl;
    function isInstance(object_: JObject): Boolean; cdecl;
    function isInterface: Boolean; cdecl;
    function isLocalClass: Boolean; cdecl;
    function isMemberClass: Boolean; cdecl;
    function isPrimitive: Boolean; cdecl;
    function isSynthetic: Boolean; cdecl;
    function newInstance: JObject; cdecl;
    function toString: JString; cdecl;
  end;
  TJlang_Class = class(TJavaGenericImport<Jlang_ClassClass, Jlang_Class>) end;

  JClassLoaderClass = interface(JObjectClass)
    ['{453BE0D7-B813-4C83-A30C-F24C026FD112}']
    {class} function getSystemClassLoader: JClassLoader; cdecl;
    {class} //function getSystemResource(resName: JString): JURL; cdecl;
    {class} function getSystemResourceAsStream(resName: JString): JInputStream; cdecl;
    {class} function getSystemResources(resName: JString): JEnumeration; cdecl;
  end;

  [JavaSignature('java/lang/ClassLoader')]
  JClassLoader = interface(JObject)
    ['{17B43D0A-2016-44ED-84B5-9EAB55AF8FDD}']
    procedure clearAssertionStatus; cdecl;
    function getParent: JClassLoader; cdecl;
    //function getResource(resName: JString): JURL; cdecl;
    function getResourceAsStream(resName: JString): JInputStream; cdecl;
    function getResources(resName: JString): JEnumeration; cdecl;
    function loadClass(className: JString): Jlang_Class; cdecl;
    procedure setClassAssertionStatus(cname: JString; enable: Boolean); cdecl;
    procedure setDefaultAssertionStatus(enable: Boolean); cdecl;
    procedure setPackageAssertionStatus(pname: JString; enable: Boolean); cdecl;
  end;
  TJClassLoader = class(TJavaGenericImport<JClassLoaderClass, JClassLoader>) end;

  JComparableClass = interface(IJavaClass)
    ['{919AEA14-2451-4CFB-BFAB-387DB8BBE854}']
  end;

  [JavaSignature('java/lang/Comparable')]
  JComparable = interface(IJavaInstance)
    ['{AE58973C-F988-4AA5-969C-EBB4E2515276}']
    function compareTo(another: JObject): Integer; cdecl;
  end;
  TJComparable = class(TJavaGenericImport<JComparableClass, JComparable>) end;

  JDoubleClass = interface(JNumberClass)
    ['{1B133955-7ECE-4429-97CD-9118396AC3AE}']
    {class} function _GetMAX_EXPONENT: Integer; cdecl;
    {class} function _GetMAX_VALUE: Double; cdecl;
    {class} function _GetMIN_EXPONENT: Integer; cdecl;
    {class} function _GetMIN_NORMAL: Double; cdecl;
    {class} function _GetMIN_VALUE: Double; cdecl;
    {class} function _GetNEGATIVE_INFINITY: Double; cdecl;
    {class} function _GetNaN: Double; cdecl;
    {class} function _GetPOSITIVE_INFINITY: Double; cdecl;
    {class} function _GetSIZE: Integer; cdecl;
    {class} function _GetTYPE: Jlang_Class; cdecl;
    {class} function init(value: Double): JDouble; cdecl; overload;
    {class} function init(string_: JString): JDouble; cdecl; overload;
    {class} function compare(double1: Double; double2: Double): Integer; cdecl;
    {class} function doubleToLongBits(value: Double): Int64; cdecl;
    {class} function doubleToRawLongBits(value: Double): Int64; cdecl;
    {class} function isInfinite(d: Double): Boolean; cdecl; overload;
    {class} function isNaN(d: Double): Boolean; cdecl; overload;
    {class} function longBitsToDouble(bits: Int64): Double; cdecl;
    {class} function parseDouble(string_: JString): Double; cdecl;
    {class} function toHexString(d: Double): JString; cdecl;
    {class} function toString(d: Double): JString; cdecl; overload;
    {class} function valueOf(string_: JString): JDouble; cdecl; overload;
    {class} function valueOf(d: Double): JDouble; cdecl; overload;
    {class} property MAX_EXPONENT: Integer read _GetMAX_EXPONENT;
    {class} property MAX_VALUE: Double read _GetMAX_VALUE;
    {class} property MIN_EXPONENT: Integer read _GetMIN_EXPONENT;
    {class} property MIN_NORMAL: Double read _GetMIN_NORMAL;
    {class} property MIN_VALUE: Double read _GetMIN_VALUE;
    {class} property NEGATIVE_INFINITY: Double read _GetNEGATIVE_INFINITY;
    {class} property NaN: Double read _GetNaN;
    {class} property POSITIVE_INFINITY: Double read _GetPOSITIVE_INFINITY;
    {class} property SIZE: Integer read _GetSIZE;
    {class} property &TYPE: Jlang_Class read _GetTYPE;
  end;

  [JavaSignature('java/lang/Double')]
  JDouble = interface(JNumber)
    ['{81639AF9-E21C-4CB0-99E6-1E7F013E11CC}']
    function byteValue: Byte; cdecl;
    function compareTo(object_: JDouble): Integer; cdecl;
    function doubleValue: Double; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function floatValue: Single; cdecl;
    function hashCode: Integer; cdecl;
    function intValue: Integer; cdecl;
    function isInfinite: Boolean; cdecl; overload;
    function isNaN: Boolean; cdecl; overload;
    function longValue: Int64; cdecl;
    function shortValue: SmallInt; cdecl;
    function toString: JString; cdecl; overload;
  end;
  TJDouble = class(TJavaGenericImport<JDoubleClass, JDouble>) end;

  JEnumClass = interface(JObjectClass)
    ['{2DB4C98D-F244-4372-9487-E9B9E2F48391}']
    {class} function valueOf(enumType: Jlang_Class; name: JString): JEnum; cdecl;
  end;

  [JavaSignature('java/lang/Enum')]
  JEnum = interface(JObject)
    ['{0CFB5F00-FBF2-469D-806C-471A09BE1BAF}']
    function compareTo(o: JEnum): Integer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function getDeclaringClass: Jlang_Class; cdecl;
    function hashCode: Integer; cdecl;
    function name: JString; cdecl;
    function ordinal: Integer; cdecl;
    function toString: JString; cdecl;
  end;
  TJEnum = class(TJavaGenericImport<JEnumClass, JEnum>) end;

  JFloatClass = interface(JNumberClass)
    ['{E2E64017-238D-4910-8DF8-BD66A034BDFE}']
    {class} function _GetMAX_EXPONENT: Integer; cdecl;
    {class} function _GetMAX_VALUE: Single; cdecl;
    {class} function _GetMIN_EXPONENT: Integer; cdecl;
    {class} function _GetMIN_NORMAL: Single; cdecl;
    {class} function _GetMIN_VALUE: Single; cdecl;
    {class} function _GetNEGATIVE_INFINITY: Single; cdecl;
    {class} function _GetNaN: Single; cdecl;
    {class} function _GetPOSITIVE_INFINITY: Single; cdecl;
    {class} function _GetSIZE: Integer; cdecl;
    {class} function _GetTYPE: Jlang_Class; cdecl;
    {class} function init(value: Single): JFloat; cdecl; overload;
    {class} function init(value: Double): JFloat; cdecl; overload;
    {class} function init(string_: JString): JFloat; cdecl; overload;
    {class} function compare(float1: Single; float2: Single): Integer; cdecl;
    {class} function floatToIntBits(value: Single): Integer; cdecl;
    {class} function floatToRawIntBits(value: Single): Integer; cdecl;
    {class} function intBitsToFloat(bits: Integer): Single; cdecl;
    {class} function isInfinite(f: Single): Boolean; cdecl; overload;
    {class} function isNaN(f: Single): Boolean; cdecl; overload;
    {class} function parseFloat(string_: JString): Single; cdecl;
    {class} function toHexString(f: Single): JString; cdecl;
    {class} function toString(f: Single): JString; cdecl; overload;
    {class} function valueOf(string_: JString): JFloat; cdecl; overload;
    {class} function valueOf(f: Single): JFloat; cdecl; overload;
    {class} property MAX_EXPONENT: Integer read _GetMAX_EXPONENT;
    {class} property MAX_VALUE: Single read _GetMAX_VALUE;
    {class} property MIN_EXPONENT: Integer read _GetMIN_EXPONENT;
    {class} property MIN_NORMAL: Single read _GetMIN_NORMAL;
    {class} property MIN_VALUE: Single read _GetMIN_VALUE;
    {class} property NEGATIVE_INFINITY: Single read _GetNEGATIVE_INFINITY;
    {class} property NaN: Single read _GetNaN;
    {class} property POSITIVE_INFINITY: Single read _GetPOSITIVE_INFINITY;
    {class} property SIZE: Integer read _GetSIZE;
    {class} property &TYPE: Jlang_Class read _GetTYPE;
  end;

  [JavaSignature('java/lang/Float')]
  JFloat = interface(JNumber)
    ['{F13BF843-909A-4866-918B-B1B2B1A8F483}']
    function byteValue: Byte; cdecl;
    function compareTo(object_: JFloat): Integer; cdecl;
    function doubleValue: Double; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function floatValue: Single; cdecl;
    function hashCode: Integer; cdecl;
    function intValue: Integer; cdecl;
    function isInfinite: Boolean; cdecl; overload;
    function isNaN: Boolean; cdecl; overload;
    function longValue: Int64; cdecl;
    function shortValue: SmallInt; cdecl;
    function toString: JString; cdecl; overload;
  end;
  TJFloat = class(TJavaGenericImport<JFloatClass, JFloat>) end;

  JRuntimeExceptionClass = interface(JExceptionClass)
    ['{58C58616-58EF-4783-92DB-5AE4F2A079A7}']
    {class} function init: JRuntimeException; cdecl; overload;
    {class} function init(detailMessage: JString): JRuntimeException; cdecl; overload;
    {class} function init(detailMessage: JString; throwable: JThrowable): JRuntimeException; cdecl; overload;
    {class} function init(throwable: JThrowable): JRuntimeException; cdecl; overload;
  end;

  [JavaSignature('java/lang/RuntimeException')]
  JRuntimeException = interface(JException)
    ['{7CEA4E55-B247-4073-A601-7C2C6D8BEE22}']
  end;
  TJRuntimeException = class(TJavaGenericImport<JRuntimeExceptionClass, JRuntimeException>) end;

  JIllegalStateExceptionClass = interface(JRuntimeExceptionClass)
    ['{C0717EAB-C1D7-4E7A-A545-922D0CC4B532}']
    {class} function init: JIllegalStateException; cdecl; overload;
    {class} function init(detailMessage: JString): JIllegalStateException; cdecl; overload;
    {class} function init(message: JString; cause: JThrowable): JIllegalStateException; cdecl; overload;
    {class} function init(cause: JThrowable): JIllegalStateException; cdecl; overload;
  end;

  [JavaSignature('java/lang/IllegalStateException')]
  JIllegalStateException = interface(JRuntimeException)
    ['{47074700-88B6-49D2-A5F3-43540D5B910D}']
  end;
  TJIllegalStateException = class(TJavaGenericImport<JIllegalStateExceptionClass, JIllegalStateException>) end;

  JIntegerClass = interface(JNumberClass)
    ['{DA48E911-AB80-4875-993F-316B9F310559}']
    {class} function _GetMAX_VALUE: Integer; cdecl;
    {class} function _GetMIN_VALUE: Integer; cdecl;
    {class} function _GetSIZE: Integer; cdecl;
    {class} function _GetTYPE: Jlang_Class; cdecl;
    {class} function init(value: Integer): JInteger; cdecl; overload;
    {class} function init(string_: JString): JInteger; cdecl; overload;
    {class} function bitCount(i: Integer): Integer; cdecl;
    {class} function compare(lhs: Integer; rhs: Integer): Integer; cdecl;
    {class} function decode(string_: JString): JInteger; cdecl;
    {class} function getInteger(string_: JString): JInteger; cdecl; overload;
    {class} function getInteger(string_: JString; defaultValue: Integer): JInteger; cdecl; overload;
    {class} function getInteger(string_: JString; defaultValue: JInteger): JInteger; cdecl; overload;
    {class} function highestOneBit(i: Integer): Integer; cdecl;
    {class} function lowestOneBit(i: Integer): Integer; cdecl;
    {class} function numberOfLeadingZeros(i: Integer): Integer; cdecl;
    {class} function numberOfTrailingZeros(i: Integer): Integer; cdecl;
    {class} function parseInt(string_: JString): Integer; cdecl; overload;
    {class} function parseInt(string_: JString; radix: Integer): Integer; cdecl; overload;
    {class} function reverse(i: Integer): Integer; cdecl;
    {class} function reverseBytes(i: Integer): Integer; cdecl;
    {class} function rotateLeft(i: Integer; distance: Integer): Integer; cdecl;
    {class} function rotateRight(i: Integer; distance: Integer): Integer; cdecl;
    {class} function signum(i: Integer): Integer; cdecl;
    {class} function toBinaryString(i: Integer): JString; cdecl;
    {class} function toHexString(i: Integer): JString; cdecl;
    {class} function toOctalString(i: Integer): JString; cdecl;
    {class} function toString(i: Integer): JString; cdecl; overload;
    {class} function toString(i: Integer; radix: Integer): JString; cdecl; overload;
    {class} function valueOf(string_: JString): JInteger; cdecl; overload;
    {class} function valueOf(string_: JString; radix: Integer): JInteger; cdecl; overload;
    {class} function valueOf(i: Integer): JInteger; cdecl; overload;
    {class} property MAX_VALUE: Integer read _GetMAX_VALUE;
    {class} property MIN_VALUE: Integer read _GetMIN_VALUE;
    {class} property SIZE: Integer read _GetSIZE;
    {class} property &TYPE: Jlang_Class read _GetTYPE;
  end;

  [JavaSignature('java/lang/Integer')]
  JInteger = interface(JNumber)
    ['{A07D13BE-2418-4FCB-8CEB-F4160E5884D5}']
    function byteValue: Byte; cdecl;
    function compareTo(object_: JInteger): Integer; cdecl;
    function doubleValue: Double; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function floatValue: Single; cdecl;
    function hashCode: Integer; cdecl;
    function intValue: Integer; cdecl;
    function longValue: Int64; cdecl;
    function shortValue: SmallInt; cdecl;
    function toString: JString; cdecl; overload;
  end;
  TJInteger = class(TJavaGenericImport<JIntegerClass, JInteger>) end;

  JIterableClass = interface(IJavaClass)
    ['{EEADA3A8-2116-491E-ACC7-21F84F84D65A}']
  end;

  [JavaSignature('java/lang/Iterable')]
  JIterable = interface(IJavaInstance)
    ['{ABC85F3B-F161-4206-882A-FFD5F1DEFEA2}']
    function iterator: JIterator; cdecl;
  end;
  TJIterable = class(TJavaGenericImport<JIterableClass, JIterable>) end;

  JLongClass = interface(JNumberClass)
    ['{BA567CF5-58F3-41A7-BAA4-538606294DE9}']
    {class} function _GetMAX_VALUE: Int64; cdecl;
    {class} function _GetMIN_VALUE: Int64; cdecl;
    {class} function _GetSIZE: Integer; cdecl;
    {class} function _GetTYPE: Jlang_Class; cdecl;
    {class} function init(value: Int64): JLong; cdecl; overload;
    {class} function init(string_: JString): JLong; cdecl; overload;
    {class} function bitCount(v: Int64): Integer; cdecl;
    {class} function compare(lhs: Int64; rhs: Int64): Integer; cdecl;
    {class} function decode(string_: JString): JLong; cdecl;
    {class} function getLong(string_: JString): JLong; cdecl; overload;
    {class} function getLong(string_: JString; defaultValue: Int64): JLong; cdecl; overload;
    {class} function getLong(string_: JString; defaultValue: JLong): JLong; cdecl; overload;
    {class} function highestOneBit(v: Int64): Int64; cdecl;
    {class} function lowestOneBit(v: Int64): Int64; cdecl;
    {class} function numberOfLeadingZeros(v: Int64): Integer; cdecl;
    {class} function numberOfTrailingZeros(v: Int64): Integer; cdecl;
    {class} function parseLong(string_: JString): Int64; cdecl; overload;
    {class} function parseLong(string_: JString; radix: Integer): Int64; cdecl; overload;
    {class} function reverse(v: Int64): Int64; cdecl;
    {class} function reverseBytes(v: Int64): Int64; cdecl;
    {class} function rotateLeft(v: Int64; distance: Integer): Int64; cdecl;
    {class} function rotateRight(v: Int64; distance: Integer): Int64; cdecl;
    {class} function signum(v: Int64): Integer; cdecl;
    {class} function toBinaryString(v: Int64): JString; cdecl;
    {class} function toHexString(v: Int64): JString; cdecl;
    {class} function toOctalString(v: Int64): JString; cdecl;
    {class} function toString(n: Int64): JString; cdecl; overload;
    {class} function toString(v: Int64; radix: Integer): JString; cdecl; overload;
    {class} function valueOf(string_: JString): JLong; cdecl; overload;
    {class} function valueOf(string_: JString; radix: Integer): JLong; cdecl; overload;
    {class} function valueOf(v: Int64): JLong; cdecl; overload;
    {class} property MAX_VALUE: Int64 read _GetMAX_VALUE;
    {class} property MIN_VALUE: Int64 read _GetMIN_VALUE;
    {class} property SIZE: Integer read _GetSIZE;
    {class} property &TYPE: Jlang_Class read _GetTYPE;
  end;

  [JavaSignature('java/lang/Long')]
  JLong = interface(JNumber)
    ['{F2E23531-34CC-4607-94D6-F85B4F95FB43}']
    function byteValue: Byte; cdecl;
    function compareTo(object_: JLong): Integer; cdecl;
    function doubleValue: Double; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function floatValue: Single; cdecl;
    function hashCode: Integer; cdecl;
    function intValue: Integer; cdecl;
    function longValue: Int64; cdecl;
    function shortValue: SmallInt; cdecl;
    function toString: JString; cdecl; overload;
  end;
  TJLong = class(TJavaGenericImport<JLongClass, JLong>) end;

  JPackageClass = interface(JObjectClass)
    ['{1FC1C1DD-321C-4601-8946-916E19BD67FA}']
    {class} function getPackage(packageName: JString): JPackage; cdecl;
    {class} function getPackages: TJavaObjectArray<JPackage>; cdecl;
  end;

  [JavaSignature('java/lang/Package')]
  JPackage = interface(JObject)
    ['{E8F397DF-1FB0-4C08-B9CB-08C8B38917EE}']
    function getAnnotation(annotationType: Jlang_Class): JAnnotation; cdecl;
    function getAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function getDeclaredAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function getImplementationTitle: JString; cdecl;
    function getImplementationVendor: JString; cdecl;
    function getImplementationVersion: JString; cdecl;
    function getName: JString; cdecl;
    function getSpecificationTitle: JString; cdecl;
    function getSpecificationVendor: JString; cdecl;
    function getSpecificationVersion: JString; cdecl;
    function hashCode: Integer; cdecl;
    function isAnnotationPresent(annotationType: Jlang_Class): Boolean; cdecl;
    function isCompatibleWith(version: JString): Boolean; cdecl;
    function isSealed: Boolean; cdecl; overload;
    //function isSealed(url: JURL): Boolean; cdecl; overload;
    function toString: JString; cdecl;
  end;
  TJPackage = class(TJavaGenericImport<JPackageClass, JPackage>) end;

  JRunnableClass = interface(IJavaClass)
    ['{49A6EA8E-0ADB-4D8E-8FA3-F13D4ADCF281}']
  end;

  [JavaSignature('java/lang/Runnable')]
  JRunnable = interface(IJavaInstance)
    ['{BC131B27-7A72-4CAF-BB8E-170B8359B22E}']
    procedure run; cdecl;
  end;
  TJRunnable = class(TJavaGenericImport<JRunnableClass, JRunnable>) end;

  JShortClass = interface(JNumberClass)
    ['{FAD495F3-40B7-46DB-B3B6-8DBBD38D8E16}']
    {class} function _GetMAX_VALUE: SmallInt; cdecl;
    {class} function _GetMIN_VALUE: SmallInt; cdecl;
    {class} function _GetSIZE: Integer; cdecl;
    {class} function _GetTYPE: Jlang_Class; cdecl;
    {class} function init(string_: JString): JShort; cdecl; overload;
    {class} function init(value: SmallInt): JShort; cdecl; overload;
    {class} function compare(lhs: SmallInt; rhs: SmallInt): Integer; cdecl;
    {class} function decode(string_: JString): JShort; cdecl;
    {class} function parseShort(string_: JString): SmallInt; cdecl; overload;
    {class} function parseShort(string_: JString; radix: Integer): SmallInt; cdecl; overload;
    {class} function reverseBytes(s: SmallInt): SmallInt; cdecl;
    {class} function toString(value: SmallInt): JString; cdecl; overload;
    {class} function valueOf(string_: JString): JShort; cdecl; overload;
    {class} function valueOf(string_: JString; radix: Integer): JShort; cdecl; overload;
    {class} function valueOf(s: SmallInt): JShort; cdecl; overload;
    {class} property MAX_VALUE: SmallInt read _GetMAX_VALUE;
    {class} property MIN_VALUE: SmallInt read _GetMIN_VALUE;
    {class} property SIZE: Integer read _GetSIZE;
    {class} property &TYPE: Jlang_Class read _GetTYPE;
  end;

  [JavaSignature('java/lang/Short')]
  JShort = interface(JNumber)
    ['{48D3B355-1222-4BD6-94BF-F40B5EE8EF02}']
    function byteValue: Byte; cdecl;
    function compareTo(object_: JShort): Integer; cdecl;
    function doubleValue: Double; cdecl;
    function equals(object_: JObject): Boolean; cdecl;
    function floatValue: Single; cdecl;
    function hashCode: Integer; cdecl;
    function intValue: Integer; cdecl;
    function longValue: Int64; cdecl;
    function shortValue: SmallInt; cdecl;
    function toString: JString; cdecl; overload;
  end;
  TJShort = class(TJavaGenericImport<JShortClass, JShort>) end;

  JStackTraceElementClass = interface(JObjectClass)
    ['{21CBE31F-4A81-4CB3-ADB1-EA9B3166692E}']
    {class} function init(cls: JString; method: JString; file_: JString; line: Integer): JStackTraceElement; cdecl;
  end;

  [JavaSignature('java/lang/StackTraceElement')]
  JStackTraceElement = interface(JObject)
    ['{3304B89A-29EB-4B53-943F-E70F4252E8FF}']
    function equals(obj: JObject): Boolean; cdecl;
    function getClassName: JString; cdecl;
    function getFileName: JString; cdecl;
    function getLineNumber: Integer; cdecl;
    function getMethodName: JString; cdecl;
    function hashCode: Integer; cdecl;
    function isNativeMethod: Boolean; cdecl;
    function toString: JString; cdecl;
  end;
  TJStackTraceElement = class(TJavaGenericImport<JStackTraceElementClass, JStackTraceElement>) end;

  JStringClass = interface(JObjectClass)
    ['{E61829D1-1FD3-49B2-BAC6-FB0FFDB1A495}']
    {class} function _GetCASE_INSENSITIVE_ORDER: JComparator; cdecl;
    {class} function init: JString; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>): JString; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>; high: Integer): JString; cdecl; overload;//Deprecated
    {class} function init(data: TJavaArray<Byte>; offset: Integer; byteCount: Integer): JString; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>; high: Integer; offset: Integer; byteCount: Integer): JString; cdecl; overload;//Deprecated
    {class} function init(data: TJavaArray<Byte>; offset: Integer; byteCount: Integer; charsetName: JString): JString; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>; charsetName: JString): JString; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>; offset: Integer; byteCount: Integer; charset: JCharset): JString; cdecl; overload;
    {class} function init(data: TJavaArray<Byte>; charset: JCharset): JString; cdecl; overload;
    {class} function init(data: TJavaArray<Char>): JString; cdecl; overload;
    {class} function init(data: TJavaArray<Char>; offset: Integer; charCount: Integer): JString; cdecl; overload;
    {class} function init(toCopy: JString): JString; cdecl; overload;
    {class} function init(stringBuffer: JStringBuffer): JString; cdecl; overload;
    {class} function init(codePoints: TJavaArray<Integer>; offset: Integer; count: Integer): JString; cdecl; overload;
    {class} function init(stringBuilder: JStringBuilder): JString; cdecl; overload;
    {class} function copyValueOf(data: TJavaArray<Char>): JString; cdecl; overload;
    {class} function copyValueOf(data: TJavaArray<Char>; start: Integer; length: Integer): JString; cdecl; overload;
    {class} function valueOf(data: TJavaArray<Char>): JString; cdecl; overload;
    {class} function valueOf(data: TJavaArray<Char>; start: Integer; length: Integer): JString; cdecl; overload;
    {class} function valueOf(value: Char): JString; cdecl; overload;
    {class} function valueOf(value: Double): JString; cdecl; overload;
    {class} function valueOf(value: Single): JString; cdecl; overload;
    {class} function valueOf(value: Integer): JString; cdecl; overload;
    {class} function valueOf(value: Int64): JString; cdecl; overload;
    {class} function valueOf(value: JObject): JString; cdecl; overload;
    {class} function valueOf(value: Boolean): JString; cdecl; overload;
    {class} property CASE_INSENSITIVE_ORDER: JComparator read _GetCASE_INSENSITIVE_ORDER;
  end;

  [JavaSignature('java/lang/String')]
  JString = interface(JObject)
    ['{8579B374-1E68-4729-AE3C-C8DA0A6D6F9F}']
    function charAt(index: Integer): Char; cdecl;
    function codePointAt(index: Integer): Integer; cdecl;
    function codePointBefore(index: Integer): Integer; cdecl;
    function codePointCount(start: Integer; end_: Integer): Integer; cdecl;
    function compareTo(string_: JString): Integer; cdecl;
    function compareToIgnoreCase(string_: JString): Integer; cdecl;
    function concat(string_: JString): JString; cdecl;
    function &contains(cs: JCharSequence): Boolean; cdecl;
    function contentEquals(strbuf: JStringBuffer): Boolean; cdecl; overload;
    function contentEquals(cs: JCharSequence): Boolean; cdecl; overload;
    function endsWith(suffix: JString): Boolean; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function equalsIgnoreCase(string_: JString): Boolean; cdecl;
    procedure getBytes(start: Integer; end_: Integer; data: TJavaArray<Byte>; index: Integer); cdecl; overload;//Deprecated
    function getBytes: TJavaArray<Byte>; cdecl; overload;
    function getBytes(charsetName: JString): TJavaArray<Byte>; cdecl; overload;
    function getBytes(charset: JCharset): TJavaArray<Byte>; cdecl; overload;
    procedure getChars(start: Integer; end_: Integer; buffer: TJavaArray<Char>; index: Integer); cdecl;
    function hashCode: Integer; cdecl;
    function indexOf(c: Integer): Integer; cdecl; overload;
    function indexOf(c: Integer; start: Integer): Integer; cdecl; overload;
    function indexOf(string_: JString): Integer; cdecl; overload;
    function indexOf(subString: JString; start: Integer): Integer; cdecl; overload;
    function intern: JString; cdecl;
    function isEmpty: Boolean; cdecl;
    function lastIndexOf(c: Integer): Integer; cdecl; overload;
    function lastIndexOf(c: Integer; start: Integer): Integer; cdecl; overload;
    function lastIndexOf(string_: JString): Integer; cdecl; overload;
    function lastIndexOf(subString: JString; start: Integer): Integer; cdecl; overload;
    function length: Integer; cdecl;
    function matches(regularExpression: JString): Boolean; cdecl;
    function offsetByCodePoints(index: Integer; codePointOffset: Integer): Integer; cdecl;
    function regionMatches(thisStart: Integer; string_: JString; start: Integer; length: Integer): Boolean; cdecl; overload;
    function regionMatches(ignoreCase: Boolean; thisStart: Integer; string_: JString; start: Integer; length: Integer): Boolean; cdecl; overload;
    function replace(oldChar: Char; newChar: Char): JString; cdecl; overload;
    function replace(target: JCharSequence; replacement: JCharSequence): JString; cdecl; overload;
    function replaceAll(regularExpression: JString; replacement: JString): JString; cdecl;
    function replaceFirst(regularExpression: JString; replacement: JString): JString; cdecl;
    function split(regularExpression: JString): TJavaObjectArray<JString>; cdecl; overload;
    function split(regularExpression: JString; limit: Integer): TJavaObjectArray<JString>; cdecl; overload;
    function startsWith(prefix: JString): Boolean; cdecl; overload;
    function startsWith(prefix: JString; start: Integer): Boolean; cdecl; overload;
    function subSequence(start: Integer; end_: Integer): JCharSequence; cdecl;
    function substring(start: Integer): JString; cdecl; overload;
    function substring(start: Integer; end_: Integer): JString; cdecl; overload;
    function toCharArray: TJavaArray<Char>; cdecl;
    function toLowerCase: JString; cdecl; overload;
    function toLowerCase(locale: JLocale): JString; cdecl; overload;
    function toString: JString; cdecl;
    function toUpperCase: JString; cdecl; overload;
    function toUpperCase(locale: JLocale): JString; cdecl; overload;
    function trim: JString; cdecl;
  end;
  TJString = class(TJavaGenericImport<JStringClass, JString>) end;

  JStringBufferClass = interface(JAbstractStringBuilderClass)
    ['{F6BF4ECD-EA63-4AF3-A901-99D4221796D7}']
    {class} function init: JStringBuffer; cdecl; overload;
    {class} function init(capacity: Integer): JStringBuffer; cdecl; overload;
    {class} function init(string_: JString): JStringBuffer; cdecl; overload;
    {class} function init(cs: JCharSequence): JStringBuffer; cdecl; overload;
  end;

  [JavaSignature('java/lang/StringBuffer')]
  JStringBuffer = interface(JAbstractStringBuilder)
    ['{3CECFBBE-9C21-4D67-9F6F-52BB1DB2C638}']
    function append(b: Boolean): JStringBuffer; cdecl; overload;
    function append(ch: Char): JStringBuffer; cdecl; overload;
    function append(d: Double): JStringBuffer; cdecl; overload;
    function append(f: Single): JStringBuffer; cdecl; overload;
    function append(i: Integer): JStringBuffer; cdecl; overload;
    function append(l: Int64): JStringBuffer; cdecl; overload;
    function append(obj: JObject): JStringBuffer; cdecl; overload;
    function append(string_: JString): JStringBuffer; cdecl; overload;
    function append(sb: JStringBuffer): JStringBuffer; cdecl; overload;
    function append(chars: TJavaArray<Char>): JStringBuffer; cdecl; overload;
    function append(chars: TJavaArray<Char>; start: Integer; length: Integer): JStringBuffer; cdecl; overload;
    function append(s: JCharSequence): JStringBuffer; cdecl; overload;
    function append(s: JCharSequence; start: Integer; end_: Integer): JStringBuffer; cdecl; overload;
    function appendCodePoint(codePoint: Integer): JStringBuffer; cdecl;
    function charAt(index: Integer): Char; cdecl;
    function codePointAt(index: Integer): Integer; cdecl;
    function codePointBefore(index: Integer): Integer; cdecl;
    function codePointCount(beginIndex: Integer; endIndex: Integer): Integer; cdecl;
    function delete(start: Integer; end_: Integer): JStringBuffer; cdecl;
    function deleteCharAt(location: Integer): JStringBuffer; cdecl;
    procedure ensureCapacity(min: Integer); cdecl;
    procedure getChars(start: Integer; end_: Integer; buffer: TJavaArray<Char>; idx: Integer); cdecl;
    function indexOf(subString: JString; start: Integer): Integer; cdecl;
    function insert(index: Integer; ch: Char): JStringBuffer; cdecl; overload;
    function insert(index: Integer; b: Boolean): JStringBuffer; cdecl; overload;
    function insert(index: Integer; i: Integer): JStringBuffer; cdecl; overload;
    function insert(index: Integer; l: Int64): JStringBuffer; cdecl; overload;
    function insert(index: Integer; d: Double): JStringBuffer; cdecl; overload;
    function insert(index: Integer; f: Single): JStringBuffer; cdecl; overload;
    function insert(index: Integer; obj: JObject): JStringBuffer; cdecl; overload;
    function insert(index: Integer; string_: JString): JStringBuffer; cdecl; overload;
    function insert(index: Integer; chars: TJavaArray<Char>): JStringBuffer; cdecl; overload;
    function insert(index: Integer; chars: TJavaArray<Char>; start: Integer; length: Integer): JStringBuffer; cdecl; overload;
    function insert(index: Integer; s: JCharSequence): JStringBuffer; cdecl; overload;
    function insert(index: Integer; s: JCharSequence; start: Integer; end_: Integer): JStringBuffer; cdecl; overload;
    function lastIndexOf(subString: JString; start: Integer): Integer; cdecl;
    function offsetByCodePoints(index: Integer; codePointOffset: Integer): Integer; cdecl;
    function replace(start: Integer; end_: Integer; string_: JString): JStringBuffer; cdecl;
    function reverse: JStringBuffer; cdecl;
    procedure setCharAt(index: Integer; ch: Char); cdecl;
    procedure setLength(length: Integer); cdecl;
    function subSequence(start: Integer; end_: Integer): JCharSequence; cdecl;
    function substring(start: Integer): JString; cdecl; overload;
    function substring(start: Integer; end_: Integer): JString; cdecl; overload;
    function toString: JString; cdecl;
    procedure trimToSize; cdecl;
  end;
  TJStringBuffer = class(TJavaGenericImport<JStringBufferClass, JStringBuffer>) end;

  JStringBuilderClass = interface(JAbstractStringBuilderClass)
    ['{D9FACB66-EE60-4BCB-B5B2-248751CCF1B4}']
    {class} function init: JStringBuilder; cdecl; overload;
    {class} function init(capacity: Integer): JStringBuilder; cdecl; overload;
    {class} function init(seq: JCharSequence): JStringBuilder; cdecl; overload;
    {class} function init(str: JString): JStringBuilder; cdecl; overload;
  end;

  [JavaSignature('java/lang/StringBuilder')]
  JStringBuilder = interface(JAbstractStringBuilder)
    ['{F8A75A66-EA10-4337-9ECC-B0CA4FF4D9C5}']
    function append(b: Boolean): JStringBuilder; cdecl; overload;
    function append(c: Char): JStringBuilder; cdecl; overload;
    function append(i: Integer): JStringBuilder; cdecl; overload;
    function append(l: Int64): JStringBuilder; cdecl; overload;
    function append(f: Single): JStringBuilder; cdecl; overload;
    function append(d: Double): JStringBuilder; cdecl; overload;
    function append(obj: JObject): JStringBuilder; cdecl; overload;
    function append(str: JString): JStringBuilder; cdecl; overload;
    function append(sb: JStringBuffer): JStringBuilder; cdecl; overload;
    function append(chars: TJavaArray<Char>): JStringBuilder; cdecl; overload;
    function append(str: TJavaArray<Char>; offset: Integer; len: Integer): JStringBuilder; cdecl; overload;
    function append(csq: JCharSequence): JStringBuilder; cdecl; overload;
    function append(csq: JCharSequence; start: Integer; end_: Integer): JStringBuilder; cdecl; overload;
    function appendCodePoint(codePoint: Integer): JStringBuilder; cdecl;
    function delete(start: Integer; end_: Integer): JStringBuilder; cdecl;
    function deleteCharAt(index: Integer): JStringBuilder; cdecl;
    function insert(offset: Integer; b: Boolean): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; c: Char): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; i: Integer): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; l: Int64): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; f: Single): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; d: Double): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; obj: JObject): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; str: JString): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; ch: TJavaArray<Char>): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; str: TJavaArray<Char>; strOffset: Integer; strLen: Integer): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; s: JCharSequence): JStringBuilder; cdecl; overload;
    function insert(offset: Integer; s: JCharSequence; start: Integer; end_: Integer): JStringBuilder; cdecl; overload;
    function replace(start: Integer; end_: Integer; string_: JString): JStringBuilder; cdecl;
    function reverse: JStringBuilder; cdecl;
    function toString: JString; cdecl;
  end;
  TJStringBuilder = class(TJavaGenericImport<JStringBuilderClass, JStringBuilder>) end;

  JThreadClass = interface(JObjectClass)
    ['{AC2B33CB-D349-4506-8809-B9762209222B}']
    {class} function _GetMAX_PRIORITY: Integer; cdecl;
    {class} function _GetMIN_PRIORITY: Integer; cdecl;
    {class} function _GetNORM_PRIORITY: Integer; cdecl;
    {class} function init: JThread; cdecl; overload;
    {class} function init(runnable: JRunnable): JThread; cdecl; overload;
    {class} function init(runnable: JRunnable; threadName: JString): JThread; cdecl; overload;
    {class} function init(threadName: JString): JThread; cdecl; overload;
    {class} function init(group: JThreadGroup; runnable: JRunnable): JThread; cdecl; overload;
    {class} function init(group: JThreadGroup; runnable: JRunnable; threadName: JString): JThread; cdecl; overload;
    {class} function init(group: JThreadGroup; threadName: JString): JThread; cdecl; overload;
    {class} function init(group: JThreadGroup; runnable: JRunnable; threadName: JString; stackSize: Int64): JThread; cdecl; overload;
    {class} function activeCount: Integer; cdecl;
    {class} function currentThread: JThread; cdecl;
    {class} procedure dumpStack; cdecl;
    {class} function enumerate(threads: TJavaObjectArray<JThread>): Integer; cdecl;
    {class} function getAllStackTraces: TJavaObjectArray<JMap>; cdecl;
    {class} function getDefaultUncaughtExceptionHandler: JThread_UncaughtExceptionHandler; cdecl;
    {class} function holdsLock(object_: JObject): Boolean; cdecl;
    {class} function interrupted: Boolean; cdecl;
    {class} procedure setDefaultUncaughtExceptionHandler(handler: JThread_UncaughtExceptionHandler); cdecl;
    {class} procedure sleep(time: Int64); cdecl; overload;
    {class} procedure sleep(millis: Int64; nanos: Integer); cdecl; overload;
    {class} procedure yield; cdecl;
    {class} property MAX_PRIORITY: Integer read _GetMAX_PRIORITY;
    {class} property MIN_PRIORITY: Integer read _GetMIN_PRIORITY;
    {class} property NORM_PRIORITY: Integer read _GetNORM_PRIORITY;
  end;

  [JavaSignature('java/lang/Thread')]
  JThread = interface(JObject)
    ['{8E288CBE-F5A4-4D6E-98B7-D0B5075A0FCA}']
    procedure checkAccess; cdecl;
    function countStackFrames: Integer; cdecl;//Deprecated
    procedure destroy; cdecl;//Deprecated
    function getContextClassLoader: JClassLoader; cdecl;
    function getId: Int64; cdecl;
    function getName: JString; cdecl;
    function getPriority: Integer; cdecl;
    function getStackTrace: TJavaObjectArray<JStackTraceElement>; cdecl;
    function getState: JThread_State; cdecl;
    function getThreadGroup: JThreadGroup; cdecl;
    function getUncaughtExceptionHandler: JThread_UncaughtExceptionHandler; cdecl;
    procedure interrupt; cdecl;
    function isAlive: Boolean; cdecl;
    function isDaemon: Boolean; cdecl;
    function isInterrupted: Boolean; cdecl;
    procedure join; cdecl; overload;
    procedure join(millis: Int64); cdecl; overload;
    procedure join(millis: Int64; nanos: Integer); cdecl; overload;
    procedure resume; cdecl;//Deprecated
    procedure run; cdecl;
    procedure setContextClassLoader(cl: JClassLoader); cdecl;
    procedure setDaemon(isDaemon: Boolean); cdecl;
    procedure setName(threadName: JString); cdecl;
    procedure setPriority(priority: Integer); cdecl;
    procedure setUncaughtExceptionHandler(handler: JThread_UncaughtExceptionHandler); cdecl;
    procedure start; cdecl;
    procedure stop; cdecl; overload;//Deprecated
    procedure stop(throwable: JThrowable); cdecl; overload;//Deprecated
    procedure suspend; cdecl;//Deprecated
    function toString: JString; cdecl;
  end;
  TJThread = class(TJavaGenericImport<JThreadClass, JThread>) end;

  JThread_StateClass = interface(JEnumClass)
    ['{493F7CE3-3BE4-4CE5-9F96-7563BC2DC814}']
    {class} function _GetBLOCKED: JThread_State; cdecl;
    {class} function _GetNEW: JThread_State; cdecl;
    {class} function _GetRUNNABLE: JThread_State; cdecl;
    {class} function _GetTERMINATED: JThread_State; cdecl;
    {class} function _GetTIMED_WAITING: JThread_State; cdecl;
    {class} function _GetWAITING: JThread_State; cdecl;
    {class} function valueOf(name: JString): JThread_State; cdecl;
    {class} function values: TJavaObjectArray<JThread_State>; cdecl;
    {class} property BLOCKED: JThread_State read _GetBLOCKED;
    {class} property NEW: JThread_State read _GetNEW;
    {class} property RUNNABLE: JThread_State read _GetRUNNABLE;
    {class} property TERMINATED: JThread_State read _GetTERMINATED;
    {class} property TIMED_WAITING: JThread_State read _GetTIMED_WAITING;
    {class} property WAITING: JThread_State read _GetWAITING;
  end;

  [JavaSignature('java/lang/Thread$State')]
  JThread_State = interface(JEnum)
    ['{E3910394-C461-461E-9C1D-64E9BC367F84}']
  end;
  TJThread_State = class(TJavaGenericImport<JThread_StateClass, JThread_State>) end;

  JThread_UncaughtExceptionHandlerClass = interface(IJavaClass)
    ['{3E2F71F3-BF00-457C-9970-9F1DA9EA7498}']
  end;

  [JavaSignature('java/lang/Thread$UncaughtExceptionHandler')]
  JThread_UncaughtExceptionHandler = interface(IJavaInstance)
    ['{C9E75389-E9B3-45FF-9EA2-D7BC024DB9DA}']
    procedure uncaughtException(thread: JThread; ex: JThrowable); cdecl;
  end;
  TJThread_UncaughtExceptionHandler = class(TJavaGenericImport<JThread_UncaughtExceptionHandlerClass, JThread_UncaughtExceptionHandler>) end;

  JThreadGroupClass = interface(JObjectClass)
    ['{D7D65FE0-0CB7-4C72-9129-C344705D0F4C}']
    {class} function init(name: JString): JThreadGroup; cdecl; overload;
    {class} function init(parent: JThreadGroup; name: JString): JThreadGroup; cdecl; overload;
  end;

  [JavaSignature('java/lang/ThreadGroup')]
  JThreadGroup = interface(JObject)
    ['{5BF3F856-7BFB-444A-8059-341CBC2A10B2}']
    function activeCount: Integer; cdecl;
    function activeGroupCount: Integer; cdecl;
    function allowThreadSuspension(b: Boolean): Boolean; cdecl;//Deprecated
    procedure checkAccess; cdecl;
    procedure destroy; cdecl;
    function enumerate(threads: TJavaObjectArray<JThread>): Integer; cdecl; overload;
    function enumerate(threads: TJavaObjectArray<JThread>; recurse: Boolean): Integer; cdecl; overload;
    function enumerate(groups: TJavaObjectArray<JThreadGroup>): Integer; cdecl; overload;
    function enumerate(groups: TJavaObjectArray<JThreadGroup>; recurse: Boolean): Integer; cdecl; overload;
    function getMaxPriority: Integer; cdecl;
    function getName: JString; cdecl;
    function getParent: JThreadGroup; cdecl;
    procedure interrupt; cdecl;
    function isDaemon: Boolean; cdecl;
    function isDestroyed: Boolean; cdecl;
    procedure list; cdecl;
    function parentOf(g: JThreadGroup): Boolean; cdecl;
    procedure resume; cdecl;//Deprecated
    procedure setDaemon(isDaemon: Boolean); cdecl;
    procedure setMaxPriority(newMax: Integer); cdecl;
    procedure stop; cdecl;//Deprecated
    procedure suspend; cdecl;//Deprecated
    function toString: JString; cdecl;
    procedure uncaughtException(t: JThread; e: JThrowable); cdecl;
  end;
  TJThreadGroup = class(TJavaGenericImport<JThreadGroupClass, JThreadGroup>) end;

  JAnnotationClass = interface(IJavaClass)
    ['{E8A654D9-AA21-468D-AEF1-9261C6E3F760}']
  end;

  [JavaSignature('java/lang/annotation/Annotation')]
  JAnnotation = interface(IJavaInstance)
    ['{508C3063-7E6D-4963-B22F-27538F9D20CE}']
    function annotationType: Jlang_Class; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
  end;
  TJAnnotation = class(TJavaGenericImport<JAnnotationClass, JAnnotation>) end;

  JAccessibleObjectClass = interface(JObjectClass)
    ['{BFC4376F-593C-474E-804A-B2AD9F617DCC}']
    {class} procedure setAccessible(objects: TJavaObjectArray<JAccessibleObject>; flag: Boolean); cdecl; overload;
  end;

  [JavaSignature('java/lang/reflect/AccessibleObject')]
  JAccessibleObject = interface(JObject)
    ['{C062CF92-1A4F-4E32-94CB-2571A4C6A2DA}']
    function getAnnotation(annotationType: Jlang_Class): JAnnotation; cdecl;
    function getAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function getDeclaredAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function isAccessible: Boolean; cdecl;
    function isAnnotationPresent(annotationType: Jlang_Class): Boolean; cdecl;
    procedure setAccessible(flag: Boolean); cdecl; overload;
  end;
  TJAccessibleObject = class(TJavaGenericImport<JAccessibleObjectClass, JAccessibleObject>) end;

  JConstructorClass = interface(JObjectClass)
    ['{80E33E85-BECE-4E23-80BE-3F6D2AD32DA6}']
  end;

  [JavaSignature('java/lang/reflect/Constructor')]
  JConstructor = interface(JObject)
    ['{D765E763-03C2-4484-BF92-F8C5BC18BBC2}']
    function equals(other: JObject): Boolean; cdecl;
    function getAnnotation(annotationType: Jlang_Class): JAnnotation; cdecl;
    function getAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function getDeclaredAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function getDeclaringClass: Jlang_Class; cdecl;
    function getExceptionTypes: TJavaObjectArray<Jlang_Class>; cdecl;
    function getGenericExceptionTypes: TJavaObjectArray<Jreflect_Type>; cdecl;
    function getGenericParameterTypes: TJavaObjectArray<Jreflect_Type>; cdecl;
    function getModifiers: Integer; cdecl;
    function getName: JString; cdecl;
    function getParameterAnnotations: TJavaObjectBiArray<JAnnotation>; cdecl;
    function getParameterTypes: TJavaObjectArray<Jlang_Class>; cdecl;
    function getTypeParameters: TJavaObjectArray<JTypeVariable>; cdecl;
    function hashCode: Integer; cdecl;
    function isAnnotationPresent(annotationType: Jlang_Class): Boolean; cdecl;
    function isSynthetic: Boolean; cdecl;
    function isVarArgs: Boolean; cdecl;
    procedure setAccessible(flag: Boolean); cdecl;
    function toGenericString: JString; cdecl;
    function toString: JString; cdecl;
  end;
  TJConstructor = class(TJavaGenericImport<JConstructorClass, JConstructor>) end;

  JFieldClass = interface(JAccessibleObjectClass)
    ['{76F4F74B-58A0-4CA5-A596-B027AE99C55E}']
  end;

  [JavaSignature('java/lang/reflect/Field')]
  JField = interface(JAccessibleObject)
    ['{756027C5-4F1B-4A24-BEF9-70D5A951744A}']
    function equals(other: JObject): Boolean; cdecl;
    function &get(object_: JObject): JObject; cdecl;
    function getAnnotation(annotationType: Jlang_Class): JAnnotation; cdecl;
    function getBoolean(object_: JObject): Boolean; cdecl;
    function getByte(object_: JObject): Byte; cdecl;
    function getChar(object_: JObject): Char; cdecl;
    function getDeclaredAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function getDeclaringClass: Jlang_Class; cdecl;
    function getDouble(object_: JObject): Double; cdecl;
    function getFloat(object_: JObject): Single; cdecl;
    function getGenericType: Jreflect_Type; cdecl;
    function getInt(object_: JObject): Integer; cdecl;
    function getLong(object_: JObject): Int64; cdecl;
    function getModifiers: Integer; cdecl;
    function getName: JString; cdecl;
    function getShort(object_: JObject): SmallInt; cdecl;
    function getType: Jlang_Class; cdecl;
    function hashCode: Integer; cdecl;
    function isAnnotationPresent(annotationType: Jlang_Class): Boolean; cdecl;
    function isEnumConstant: Boolean; cdecl;
    function isSynthetic: Boolean; cdecl;
    procedure &set(object_: JObject; value: JObject); cdecl;
    procedure setBoolean(object_: JObject; value: Boolean); cdecl;
    procedure setByte(object_: JObject; value: Byte); cdecl;
    procedure setChar(object_: JObject; value: Char); cdecl;
    procedure setDouble(object_: JObject; value: Double); cdecl;
    procedure setFloat(object_: JObject; value: Single); cdecl;
    procedure setInt(object_: JObject; value: Integer); cdecl;
    procedure setLong(object_: JObject; value: Int64); cdecl;
    procedure setShort(object_: JObject; value: SmallInt); cdecl;
    function toGenericString: JString; cdecl;
    function toString: JString; cdecl;
  end;
  TJField = class(TJavaGenericImport<JFieldClass, JField>) end;

  JGenericDeclarationClass = interface(IJavaClass)
    ['{193301E7-C0FE-473C-BBC1-94DAF25C4497}']
  end;

  [JavaSignature('java/lang/reflect/GenericDeclaration')]
  JGenericDeclaration = interface(IJavaInstance)
    ['{BD87C28A-4E41-4E44-A2F9-03BB724E9ECC}']
    function getTypeParameters: TJavaObjectArray<JTypeVariable>; cdecl;
  end;
  TJGenericDeclaration = class(TJavaGenericImport<JGenericDeclarationClass, JGenericDeclaration>) end;

  JMethodClass = interface(JObjectClass)
    ['{C995BD27-1D77-48E5-B478-EB8E9E607020}']
  end;

  [JavaSignature('java/lang/reflect/Method')]
  JMethod = interface(JObject)
    ['{ED1B0770-0BD6-4D4A-B801-9D18AB92C834}']
    function equals(other: JObject): Boolean; cdecl;
    function getAnnotation(annotationType: Jlang_Class): JAnnotation; cdecl;
    function getAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function getDeclaredAnnotations: TJavaObjectArray<JAnnotation>; cdecl;
    function getDeclaringClass: Jlang_Class; cdecl;
    function getDefaultValue: JObject; cdecl;
    function getExceptionTypes: TJavaObjectArray<Jlang_Class>; cdecl;
    function getGenericExceptionTypes: TJavaObjectArray<Jreflect_Type>; cdecl;
    function getGenericParameterTypes: TJavaObjectArray<Jreflect_Type>; cdecl;
    function getGenericReturnType: Jreflect_Type; cdecl;
    function getModifiers: Integer; cdecl;
    function getName: JString; cdecl;
    function getParameterAnnotations: TJavaObjectBiArray<JAnnotation>; cdecl;
    function getParameterTypes: TJavaObjectArray<Jlang_Class>; cdecl;
    function getReturnType: Jlang_Class; cdecl;
    function getTypeParameters: TJavaObjectArray<JTypeVariable>; cdecl;
    function hashCode: Integer; cdecl;
    function isAnnotationPresent(annotationType: Jlang_Class): Boolean; cdecl;
    function isBridge: Boolean; cdecl;
    function isSynthetic: Boolean; cdecl;
    function isVarArgs: Boolean; cdecl;
    function toGenericString: JString; cdecl;
    function toString: JString; cdecl;
  end;
  TJMethod = class(TJavaGenericImport<JMethodClass, JMethod>) end;

  Jreflect_TypeClass = interface(IJavaClass)
    ['{843FF2A0-9372-4F7B-9CF7-C825AFD78970}']
  end;

  [JavaSignature('java/lang/reflect/Type')]
  Jreflect_Type = interface(IJavaInstance)
    ['{90AD4932-3D22-4B5B-B279-56EC7A2174CD}']
  end;
  TJreflect_Type = class(TJavaGenericImport<Jreflect_TypeClass, Jreflect_Type>) end;

  JTypeVariableClass = interface(Jreflect_TypeClass)
    ['{26AC832B-6883-4CDF-8BDC-49E5A1E6B0EF}']
  end;

  [JavaSignature('java/lang/reflect/TypeVariable')]
  JTypeVariable = interface(Jreflect_Type)
    ['{5635CD21-A6AD-420D-B742-599EC17C5931}']
    function getBounds: TJavaObjectArray<Jreflect_Type>; cdecl;
    function getGenericDeclaration: JGenericDeclaration; cdecl;
    function getName: JString; cdecl;
  end;
  TJTypeVariable = class(TJavaGenericImport<JTypeVariableClass, JTypeVariable>) end;

  JBigIntegerClass = interface(JNumberClass)
    ['{ACED883B-58FF-466A-80D3-BB30E54F84A5}']
    {class} function _GetONE: JBigInteger; cdecl;
    {class} function _GetTEN: JBigInteger; cdecl;
    {class} function _GetZERO: JBigInteger; cdecl;
    {class} function init(numBits: Integer; random: JRandom): JBigInteger; cdecl; overload;
    {class} function init(bitLength: Integer; certainty: Integer; random: JRandom): JBigInteger; cdecl; overload;
    {class} function init(value: JString): JBigInteger; cdecl; overload;
    {class} function init(value: JString; radix: Integer): JBigInteger; cdecl; overload;
    {class} function init(signum: Integer; magnitude: TJavaArray<Byte>): JBigInteger; cdecl; overload;
    {class} function init(value: TJavaArray<Byte>): JBigInteger; cdecl; overload;
    {class} function probablePrime(bitLength: Integer; random: JRandom): JBigInteger; cdecl;
    {class} function valueOf(value: Int64): JBigInteger; cdecl;
    {class} property ONE: JBigInteger read _GetONE;
    {class} property TEN: JBigInteger read _GetTEN;
    {class} property ZERO: JBigInteger read _GetZERO;
  end;

  [JavaSignature('java/math/BigInteger')]
  JBigInteger = interface(JNumber)
    ['{4B14E1DC-D46C-4434-BF1C-E804437732C3}']
    function abs: JBigInteger; cdecl;
    function add(value: JBigInteger): JBigInteger; cdecl;
    function &and(value: JBigInteger): JBigInteger; cdecl;
    function andNot(value: JBigInteger): JBigInteger; cdecl;
    function bitCount: Integer; cdecl;
    function bitLength: Integer; cdecl;
    function clearBit(n: Integer): JBigInteger; cdecl;
    function compareTo(value: JBigInteger): Integer; cdecl;
    function divide(divisor: JBigInteger): JBigInteger; cdecl;
    function divideAndRemainder(divisor: JBigInteger): TJavaObjectArray<JBigInteger>; cdecl;
    function doubleValue: Double; cdecl;
    function equals(x: JObject): Boolean; cdecl;
    function flipBit(n: Integer): JBigInteger; cdecl;
    function floatValue: Single; cdecl;
    function gcd(value: JBigInteger): JBigInteger; cdecl;
    function getLowestSetBit: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function intValue: Integer; cdecl;
    function isProbablePrime(certainty: Integer): Boolean; cdecl;
    function longValue: Int64; cdecl;
    function max(value: JBigInteger): JBigInteger; cdecl;
    function min(value: JBigInteger): JBigInteger; cdecl;
    function &mod(m: JBigInteger): JBigInteger; cdecl;
    function modInverse(m: JBigInteger): JBigInteger; cdecl;
    function modPow(exponent: JBigInteger; modulus: JBigInteger): JBigInteger; cdecl;
    function multiply(value: JBigInteger): JBigInteger; cdecl;
    function negate: JBigInteger; cdecl;
    function nextProbablePrime: JBigInteger; cdecl;
    function &not: JBigInteger; cdecl;
    function &or(value: JBigInteger): JBigInteger; cdecl;
    function pow(exp: Integer): JBigInteger; cdecl;
    function remainder(divisor: JBigInteger): JBigInteger; cdecl;
    function setBit(n: Integer): JBigInteger; cdecl;
    function shiftLeft(n: Integer): JBigInteger; cdecl;
    function shiftRight(n: Integer): JBigInteger; cdecl;
    function signum: Integer; cdecl;
    function subtract(value: JBigInteger): JBigInteger; cdecl;
    function testBit(n: Integer): Boolean; cdecl;
    function toByteArray: TJavaArray<Byte>; cdecl;
    function toString: JString; cdecl; overload;
    function toString(radix: Integer): JString; cdecl; overload;
    function &xor(value: JBigInteger): JBigInteger; cdecl;
  end;
  TJBigInteger = class(TJavaGenericImport<JBigIntegerClass, JBigInteger>) end;

  JBufferClass = interface(JObjectClass)
    ['{481ABEA6-E331-446F-BF1A-789FC5B36341}']
  end;

  [JavaSignature('java/nio/Buffer')]
  JBuffer = interface(JObject)
    ['{0F836282-2E7D-40FE-BFA9-9B58507FB238}']
    function &array: JObject; cdecl;
    function arrayOffset: Integer; cdecl;
    function capacity: Integer; cdecl;
    function clear: JBuffer; cdecl;
    function flip: JBuffer; cdecl;
    function hasArray: Boolean; cdecl;
    function hasRemaining: Boolean; cdecl;
    function isDirect: Boolean; cdecl;
    function isReadOnly: Boolean; cdecl;
    function limit: Integer; cdecl; overload;
    function limit(newLimit: Integer): JBuffer; cdecl; overload;
    function mark: JBuffer; cdecl;
    function position: Integer; cdecl; overload;
    function position(newPosition: Integer): JBuffer; cdecl; overload;
    function remaining: Integer; cdecl;
    function reset: JBuffer; cdecl;
    function rewind: JBuffer; cdecl;
    function toString: JString; cdecl;
  end;
  TJBuffer = class(TJavaGenericImport<JBufferClass, JBuffer>) end;

  JByteBufferClass = interface(JBufferClass)
    ['{7B879DB7-5B81-4A1F-B862-6127F1BE739D}']
    {class} function allocate(capacity: Integer): JByteBuffer; cdecl;
    {class} function allocateDirect(capacity: Integer): JByteBuffer; cdecl;
    {class} function wrap(array_: TJavaArray<Byte>): JByteBuffer; cdecl; overload;
    {class} function wrap(array_: TJavaArray<Byte>; start: Integer; byteCount: Integer): JByteBuffer; cdecl; overload;
  end;

  [JavaSignature('java/nio/ByteBuffer')]
  JByteBuffer = interface(JBuffer)
    ['{CB03FB80-318C-4812-97DE-59301638C25A}']
    function &array: TJavaArray<Byte>; cdecl;
    function arrayOffset: Integer; cdecl;
    function asCharBuffer: JCharBuffer; cdecl;
    function asDoubleBuffer: JDoubleBuffer; cdecl;
    function asFloatBuffer: JFloatBuffer; cdecl;
    function asIntBuffer: JIntBuffer; cdecl;
    function asLongBuffer: JLongBuffer; cdecl;
    function asReadOnlyBuffer: JByteBuffer; cdecl;
    function asShortBuffer: JShortBuffer; cdecl;
    function compact: JByteBuffer; cdecl;
    function compareTo(otherBuffer: JByteBuffer): Integer; cdecl;
    function duplicate: JByteBuffer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function &get: Byte; cdecl; overload;
    function &get(dst: TJavaArray<Byte>): JByteBuffer; cdecl; overload;
    function &get(dst: TJavaArray<Byte>; dstOffset: Integer; byteCount: Integer): JByteBuffer; cdecl; overload;
    function &get(index: Integer): Byte; cdecl; overload;
    function getChar: Char; cdecl; overload;
    function getChar(index: Integer): Char; cdecl; overload;
    function getDouble: Double; cdecl; overload;
    function getDouble(index: Integer): Double; cdecl; overload;
    function getFloat: Single; cdecl; overload;
    function getFloat(index: Integer): Single; cdecl; overload;
    function getInt: Integer; cdecl; overload;
    function getInt(index: Integer): Integer; cdecl; overload;
    function getLong: Int64; cdecl; overload;
    function getLong(index: Integer): Int64; cdecl; overload;
    function getShort: SmallInt; cdecl; overload;
    function getShort(index: Integer): SmallInt; cdecl; overload;
    function hasArray: Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isDirect: Boolean; cdecl;
    function order: JByteOrder; cdecl; overload;
    function order(byteOrder: JByteOrder): JByteBuffer; cdecl; overload;
    function put(b: Byte): JByteBuffer; cdecl; overload;
    function put(src: TJavaArray<Byte>): JByteBuffer; cdecl; overload;
    function put(src: TJavaArray<Byte>; srcOffset: Integer; byteCount: Integer): JByteBuffer; cdecl; overload;
    function put(src: JByteBuffer): JByteBuffer; cdecl; overload;
    function put(index: Integer; b: Byte): JByteBuffer; cdecl; overload;
    function putChar(value: Char): JByteBuffer; cdecl; overload;
    function putChar(index: Integer; value: Char): JByteBuffer; cdecl; overload;
    function putDouble(value: Double): JByteBuffer; cdecl; overload;
    function putDouble(index: Integer; value: Double): JByteBuffer; cdecl; overload;
    function putFloat(value: Single): JByteBuffer; cdecl; overload;
    function putFloat(index: Integer; value: Single): JByteBuffer; cdecl; overload;
    function putInt(value: Integer): JByteBuffer; cdecl; overload;
    function putInt(index: Integer; value: Integer): JByteBuffer; cdecl; overload;
    function putLong(value: Int64): JByteBuffer; cdecl; overload;
    function putLong(index: Integer; value: Int64): JByteBuffer; cdecl; overload;
    function putShort(value: SmallInt): JByteBuffer; cdecl; overload;
    function putShort(index: Integer; value: SmallInt): JByteBuffer; cdecl; overload;
    function slice: JByteBuffer; cdecl;
  end;
  TJByteBuffer = class(TJavaGenericImport<JByteBufferClass, JByteBuffer>) end;

  JByteOrderClass = interface(JObjectClass)
    ['{254AAEC7-B381-4D22-89B2-D2BB46C88689}']
    {class} function _GetBIG_ENDIAN: JByteOrder; cdecl;
    {class} function _GetLITTLE_ENDIAN: JByteOrder; cdecl;
    {class} function nativeOrder: JByteOrder; cdecl;
    {class} 
    {class} 
  end;

  [JavaSignature('java/nio/ByteOrder')]
  JByteOrder = interface(JObject)
    ['{70FDB472-70CD-4FB1-B5FC-D6442C186BD2}']
    function toString: JString; cdecl;
  end;
  TJByteOrder = class(TJavaGenericImport<JByteOrderClass, JByteOrder>) end;

  JCharBufferClass = interface(JBufferClass)
    ['{E542BA92-3ABD-4A87-9D97-65DD774C716C}']
    {class} function allocate(capacity: Integer): JCharBuffer; cdecl;
    {class} function wrap(array_: TJavaArray<Char>): JCharBuffer; cdecl; overload;
    {class} function wrap(array_: TJavaArray<Char>; start: Integer; charCount: Integer): JCharBuffer; cdecl; overload;
    {class} function wrap(chseq: JCharSequence): JCharBuffer; cdecl; overload;
    {class} function wrap(cs: JCharSequence; start: Integer; end_: Integer): JCharBuffer; cdecl; overload;
  end;

  [JavaSignature('java/nio/CharBuffer')]
  JCharBuffer = interface(JBuffer)
    ['{C499497D-72A7-49D7-AB4C-ADE9BBCAEA61}']
    function append(c: Char): JCharBuffer; cdecl; overload;
    function append(csq: JCharSequence): JCharBuffer; cdecl; overload;
    function append(csq: JCharSequence; start: Integer; end_: Integer): JCharBuffer; cdecl; overload;
    function &array: TJavaArray<Char>; cdecl;
    function arrayOffset: Integer; cdecl;
    function asReadOnlyBuffer: JCharBuffer; cdecl;
    function charAt(index: Integer): Char; cdecl;
    function compact: JCharBuffer; cdecl;
    function compareTo(otherBuffer: JCharBuffer): Integer; cdecl;
    function duplicate: JCharBuffer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function &get: Char; cdecl; overload;
    function &get(dst: TJavaArray<Char>): JCharBuffer; cdecl; overload;
    function &get(dst: TJavaArray<Char>; dstOffset: Integer; charCount: Integer): JCharBuffer; cdecl; overload;
    function &get(index: Integer): Char; cdecl; overload;
    function hasArray: Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isDirect: Boolean; cdecl;
    function length: Integer; cdecl;
    function order: JByteOrder; cdecl;
    function put(c: Char): JCharBuffer; cdecl; overload;
    function put(src: TJavaArray<Char>): JCharBuffer; cdecl; overload;
    function put(src: TJavaArray<Char>; srcOffset: Integer; charCount: Integer): JCharBuffer; cdecl; overload;
    function put(src: JCharBuffer): JCharBuffer; cdecl; overload;
    function put(index: Integer; c: Char): JCharBuffer; cdecl; overload;
    function put(str: JString): JCharBuffer; cdecl; overload;
    function put(str: JString; start: Integer; end_: Integer): JCharBuffer; cdecl; overload;
    function read(target: JCharBuffer): Integer; cdecl;
    function slice: JCharBuffer; cdecl;
    function subSequence(start: Integer; end_: Integer): JCharBuffer; cdecl;
    function toString: JString; cdecl;
  end;
  TJCharBuffer = class(TJavaGenericImport<JCharBufferClass, JCharBuffer>) end;

  JDoubleBufferClass = interface(JBufferClass)
    ['{05DB46C4-1C05-4F67-AE29-98B4A2703C63}']
    {class} function allocate(capacity: Integer): JDoubleBuffer; cdecl;
    {class} function wrap(array_: TJavaArray<Double>): JDoubleBuffer; cdecl; overload;
    {class} function wrap(array_: TJavaArray<Double>; start: Integer; doubleCount: Integer): JDoubleBuffer; cdecl; overload;
  end;

  [JavaSignature('java/nio/DoubleBuffer')]
  JDoubleBuffer = interface(JBuffer)
    ['{1A1190DA-622D-48E4-A9D4-675ABCFACDCD}']
    function &array: TJavaArray<Double>; cdecl;
    function arrayOffset: Integer; cdecl;
    function asReadOnlyBuffer: JDoubleBuffer; cdecl;
    function compact: JDoubleBuffer; cdecl;
    function compareTo(otherBuffer: JDoubleBuffer): Integer; cdecl;
    function duplicate: JDoubleBuffer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function &get: Double; cdecl; overload;
    function &get(dst: TJavaArray<Double>): JDoubleBuffer; cdecl; overload;
    function &get(dst: TJavaArray<Double>; dstOffset: Integer; doubleCount: Integer): JDoubleBuffer; cdecl; overload;
    function &get(index: Integer): Double; cdecl; overload;
    function hasArray: Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isDirect: Boolean; cdecl;
    function order: JByteOrder; cdecl;
    function put(d: Double): JDoubleBuffer; cdecl; overload;
    function put(src: TJavaArray<Double>): JDoubleBuffer; cdecl; overload;
    function put(src: TJavaArray<Double>; srcOffset: Integer; doubleCount: Integer): JDoubleBuffer; cdecl; overload;
    function put(src: JDoubleBuffer): JDoubleBuffer; cdecl; overload;
    function put(index: Integer; d: Double): JDoubleBuffer; cdecl; overload;
    function slice: JDoubleBuffer; cdecl;
  end;
  TJDoubleBuffer = class(TJavaGenericImport<JDoubleBufferClass, JDoubleBuffer>) end;

  JFloatBufferClass = interface(JBufferClass)
    ['{A60ABCB4-E169-4F72-B24F-991D48A476C4}']
    {class} function allocate(capacity: Integer): JFloatBuffer; cdecl;
    {class} function wrap(array_: TJavaArray<Single>): JFloatBuffer; cdecl; overload;
    {class} function wrap(array_: TJavaArray<Single>; start: Integer; floatCount: Integer): JFloatBuffer; cdecl; overload;
  end;

  [JavaSignature('java/nio/FloatBuffer')]
  JFloatBuffer = interface(JBuffer)
    ['{E416608F-FCBC-4B4E-B43B-E2C4794C95A6}']
    function &array: TJavaArray<Single>; cdecl;
    function arrayOffset: Integer; cdecl;
    function asReadOnlyBuffer: JFloatBuffer; cdecl;
    function compact: JFloatBuffer; cdecl;
    function compareTo(otherBuffer: JFloatBuffer): Integer; cdecl;
    function duplicate: JFloatBuffer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function &get: Single; cdecl; overload;
    function &get(dst: TJavaArray<Single>): JFloatBuffer; cdecl; overload;
    function &get(dst: TJavaArray<Single>; dstOffset: Integer; floatCount: Integer): JFloatBuffer; cdecl; overload;
    function &get(index: Integer): Single; cdecl; overload;
    function hasArray: Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isDirect: Boolean; cdecl;
    function order: JByteOrder; cdecl;
    function put(f: Single): JFloatBuffer; cdecl; overload;
    function put(src: TJavaArray<Single>): JFloatBuffer; cdecl; overload;
    function put(src: TJavaArray<Single>; srcOffset: Integer; floatCount: Integer): JFloatBuffer; cdecl; overload;
    function put(src: JFloatBuffer): JFloatBuffer; cdecl; overload;
    function put(index: Integer; f: Single): JFloatBuffer; cdecl; overload;
    function slice: JFloatBuffer; cdecl;
  end;
  TJFloatBuffer = class(TJavaGenericImport<JFloatBufferClass, JFloatBuffer>) end;

  JIntBufferClass = interface(JBufferClass)
    ['{23604D5E-E540-41E0-8E8C-F43F7B4DA36F}']
    {class} function allocate(capacity: Integer): JIntBuffer; cdecl;
    {class} function wrap(array_: TJavaArray<Integer>): JIntBuffer; cdecl; overload;
    {class} function wrap(array_: TJavaArray<Integer>; start: Integer; intCount: Integer): JIntBuffer; cdecl; overload;
  end;

  [JavaSignature('java/nio/IntBuffer')]
  JIntBuffer = interface(JBuffer)
    ['{18A20B5E-DB12-4AE4-B1C8-EDAE822D4438}']
    function &array: TJavaArray<Integer>; cdecl;
    function arrayOffset: Integer; cdecl;
    function asReadOnlyBuffer: JIntBuffer; cdecl;
    function compact: JIntBuffer; cdecl;
    function compareTo(otherBuffer: JIntBuffer): Integer; cdecl;
    function duplicate: JIntBuffer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function &get: Integer; cdecl; overload;
    function &get(dst: TJavaArray<Integer>): JIntBuffer; cdecl; overload;
    function &get(dst: TJavaArray<Integer>; dstOffset: Integer; intCount: Integer): JIntBuffer; cdecl; overload;
    function &get(index: Integer): Integer; cdecl; overload;
    function hasArray: Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isDirect: Boolean; cdecl;
    function order: JByteOrder; cdecl;
    function put(i: Integer): JIntBuffer; cdecl; overload;
    function put(src: TJavaArray<Integer>): JIntBuffer; cdecl; overload;
    function put(src: TJavaArray<Integer>; srcOffset: Integer; intCount: Integer): JIntBuffer; cdecl; overload;
    function put(src: JIntBuffer): JIntBuffer; cdecl; overload;
    function put(index: Integer; i: Integer): JIntBuffer; cdecl; overload;
    function slice: JIntBuffer; cdecl;
  end;
  TJIntBuffer = class(TJavaGenericImport<JIntBufferClass, JIntBuffer>) end;

  JLongBufferClass = interface(JBufferClass)
    ['{2DD88EBD-4825-41DD-81D4-547FE1186E0F}']
    {class} function allocate(capacity: Integer): JLongBuffer; cdecl;
    {class} function wrap(array_: TJavaArray<Int64>): JLongBuffer; cdecl; overload;
    {class} function wrap(array_: TJavaArray<Int64>; start: Integer; longCount: Integer): JLongBuffer; cdecl; overload;
  end;

  [JavaSignature('java/nio/LongBuffer')]
  JLongBuffer = interface(JBuffer)
    ['{C28DFBB8-1B26-447C-944E-74C879A70A89}']
    function &array: TJavaArray<Int64>; cdecl;
    function arrayOffset: Integer; cdecl;
    function asReadOnlyBuffer: JLongBuffer; cdecl;
    function compact: JLongBuffer; cdecl;
    function compareTo(otherBuffer: JLongBuffer): Integer; cdecl;
    function duplicate: JLongBuffer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function &get: Int64; cdecl; overload;
    function &get(dst: TJavaArray<Int64>): JLongBuffer; cdecl; overload;
    function &get(dst: TJavaArray<Int64>; dstOffset: Integer; longCount: Integer): JLongBuffer; cdecl; overload;
    function &get(index: Integer): Int64; cdecl; overload;
    function hasArray: Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isDirect: Boolean; cdecl;
    function order: JByteOrder; cdecl;
    function put(l: Int64): JLongBuffer; cdecl; overload;
    function put(src: TJavaArray<Int64>): JLongBuffer; cdecl; overload;
    function put(src: TJavaArray<Int64>; srcOffset: Integer; longCount: Integer): JLongBuffer; cdecl; overload;
    function put(src: JLongBuffer): JLongBuffer; cdecl; overload;
    function put(index: Integer; l: Int64): JLongBuffer; cdecl; overload;
    function slice: JLongBuffer; cdecl;
  end;
  TJLongBuffer = class(TJavaGenericImport<JLongBufferClass, JLongBuffer>) end;

  JMappedByteBufferClass = interface(JByteBufferClass)
    ['{8319CCA3-84E6-4EF9-9891-40E4EAF11FE0}']
  end;

  [JavaSignature('java/nio/MappedByteBuffer')]
  JMappedByteBuffer = interface(JByteBuffer)
    ['{744B5B84-744A-436D-ABFB-DC3EB2C9022A}']
    function force: JMappedByteBuffer; cdecl;
    function isLoaded: Boolean; cdecl;
    function load: JMappedByteBuffer; cdecl;
  end;
  TJMappedByteBuffer = class(TJavaGenericImport<JMappedByteBufferClass, JMappedByteBuffer>) end;

  JShortBufferClass = interface(JBufferClass)
    ['{7F52529D-4DFE-4414-B069-986D89949E27}']
    {class} function allocate(capacity: Integer): JShortBuffer; cdecl;
    {class} function wrap(array_: TJavaArray<SmallInt>): JShortBuffer; cdecl; overload;
    {class} function wrap(array_: TJavaArray<SmallInt>; start: Integer; shortCount: Integer): JShortBuffer; cdecl; overload;
  end;

  [JavaSignature('java/nio/ShortBuffer')]
  JShortBuffer = interface(JBuffer)
    ['{37B8425A-8596-4CA0-966F-629D0F25C8E9}']
    function &array: TJavaArray<SmallInt>; cdecl;
    function arrayOffset: Integer; cdecl;
    function asReadOnlyBuffer: JShortBuffer; cdecl;
    function compact: JShortBuffer; cdecl;
    function compareTo(otherBuffer: JShortBuffer): Integer; cdecl;
    function duplicate: JShortBuffer; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function &get: SmallInt; cdecl; overload;
    function &get(dst: TJavaArray<SmallInt>): JShortBuffer; cdecl; overload;
    function &get(dst: TJavaArray<SmallInt>; dstOffset: Integer; shortCount: Integer): JShortBuffer; cdecl; overload;
    function &get(index: Integer): SmallInt; cdecl; overload;
    function hasArray: Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isDirect: Boolean; cdecl;
    function order: JByteOrder; cdecl;
    function put(s: SmallInt): JShortBuffer; cdecl; overload;
    function put(src: TJavaArray<SmallInt>): JShortBuffer; cdecl; overload;
    function put(src: TJavaArray<SmallInt>; srcOffset: Integer; shortCount: Integer): JShortBuffer; cdecl; overload;
    function put(src: JShortBuffer): JShortBuffer; cdecl; overload;
    function put(index: Integer; s: SmallInt): JShortBuffer; cdecl; overload;
    function slice: JShortBuffer; cdecl;
  end;
  TJShortBuffer = class(TJavaGenericImport<JShortBufferClass, JShortBuffer>) end;

  JChannelClass = interface(JCloseableClass)
    ['{0902E632-8B6C-4FCD-9C18-C69A76F11C8B}']
  end;

  [JavaSignature('java/nio/channels/Channel')]
  JChannel = interface(JCloseable)
    ['{34601709-0C2E-4791-BFBD-703EE16A9203}']
    procedure close; cdecl;
    function isOpen: Boolean; cdecl;
  end;
  TJChannel = class(TJavaGenericImport<JChannelClass, JChannel>) end;

  JAbstractInterruptibleChannelClass = interface(JObjectClass)
    ['{D731C7B5-9CD9-4511-9F57-5CD66940B97E}']
  end;

  [JavaSignature('java/nio/channels/spi/AbstractInterruptibleChannel')]
  JAbstractInterruptibleChannel = interface(JObject)
    ['{DD7C42BD-DAA0-4134-A220-0DFAE23964AF}']
    procedure close; cdecl;
    function isOpen: Boolean; cdecl;
  end;
  TJAbstractInterruptibleChannel = class(TJavaGenericImport<JAbstractInterruptibleChannelClass, JAbstractInterruptibleChannel>) end;

  JSelectableChannelClass = interface(JAbstractInterruptibleChannelClass)
    ['{F0A109A2-C857-4C0B-91FC-DC9E4EA0D1F5}']
  end;

  [JavaSignature('java/nio/channels/SelectableChannel')]
  JSelectableChannel = interface(JAbstractInterruptibleChannel)
    ['{539916DF-2B5B-4EBC-B849-666F3DD4FF0C}']
    function blockingLock: JObject; cdecl;
    function configureBlocking(block: Boolean): JSelectableChannel; cdecl;
    function isBlocking: Boolean; cdecl;
    function isRegistered: Boolean; cdecl;
    function keyFor(sel: JSelector): JSelectionKey; cdecl;
    function provider: JSelectorProvider; cdecl;
    function register(selector: JSelector; operations: Integer): JSelectionKey; cdecl; overload;
    function register(sel: JSelector; ops: Integer; att: JObject): JSelectionKey; cdecl; overload;
    function validOps: Integer; cdecl;
  end;
  TJSelectableChannel = class(TJavaGenericImport<JSelectableChannelClass, JSelectableChannel>) end;

  JAbstractSelectableChannelClass = interface(JSelectableChannelClass)
    ['{37576352-D59D-443D-AF66-1C3123236500}']
  end;

  [JavaSignature('java/nio/channels/spi/AbstractSelectableChannel')]
  JAbstractSelectableChannel = interface(JSelectableChannel)
    ['{28EB411A-49FE-4194-9591-CC8E2349B35A}']
    function blockingLock: JObject; cdecl;
    function configureBlocking(blockingMode: Boolean): JSelectableChannel; cdecl;
    function isBlocking: Boolean; cdecl;
    function isRegistered: Boolean; cdecl;
    function keyFor(selector: JSelector): JSelectionKey; cdecl;
    function provider: JSelectorProvider; cdecl;
    function register(selector: JSelector; interestSet: Integer; attachment: JObject): JSelectionKey; cdecl;
  end;
  TJAbstractSelectableChannel = class(TJavaGenericImport<JAbstractSelectableChannelClass, JAbstractSelectableChannel>) end;

  JDatagramChannelClass = interface(JAbstractSelectableChannelClass)
    ['{39ACC9DA-3833-4EAA-ABDA-904EBB9D1D82}']
    {class} function open: JDatagramChannel; cdecl;
  end;

  [JavaSignature('java/nio/channels/DatagramChannel')]
  JDatagramChannel = interface(JAbstractSelectableChannel)
    ['{90205C70-B349-480B-BEFA-1B850C27F130}']
    //function connect(address: JSocketAddress): JDatagramChannel; cdecl;
    function disconnect: JDatagramChannel; cdecl;
    function isConnected: Boolean; cdecl;
    function read(target: JByteBuffer): Integer; cdecl; overload;
    function read(targets: TJavaObjectArray<JByteBuffer>; offset: Integer; length: Integer): Int64; cdecl; overload;
    function read(targets: TJavaObjectArray<JByteBuffer>): Int64; cdecl; overload;
    //function receive(target: JByteBuffer): JSocketAddress; cdecl;
    //function send(source: JByteBuffer; address: JSocketAddress): Integer; cdecl;
    //function socket: JDatagramSocket; cdecl;
    function validOps: Integer; cdecl;
    function write(source: JByteBuffer): Integer; cdecl; overload;
    function write(sources: TJavaObjectArray<JByteBuffer>; offset: Integer; length: Integer): Int64; cdecl; overload;
    function write(sources: TJavaObjectArray<JByteBuffer>): Int64; cdecl; overload;
  end;
  TJDatagramChannel = class(TJavaGenericImport<JDatagramChannelClass, JDatagramChannel>) end;

  JFileChannelClass = interface(JAbstractInterruptibleChannelClass)
    ['{35072FC4-075A-45BF-99F9-E2ED20581B95}']
  end;

  [JavaSignature('java/nio/channels/FileChannel')]
  JFileChannel = interface(JAbstractInterruptibleChannel)
    ['{DD170413-4811-4479-96FD-C32E336E8FA9}']
    procedure force(metadata: Boolean); cdecl;
    function lock: JFileLock; cdecl; overload;
    function lock(position: Int64; size: Int64; shared: Boolean): JFileLock; cdecl; overload;
    function map(mode: JFileChannel_MapMode; position: Int64; size: Int64): JMappedByteBuffer; cdecl;
    function position: Int64; cdecl; overload;
    function position(newPosition: Int64): JFileChannel; cdecl; overload;
    function read(buffer: JByteBuffer): Integer; cdecl; overload;
    function read(buffer: JByteBuffer; position: Int64): Integer; cdecl; overload;
    function read(buffers: TJavaObjectArray<JByteBuffer>): Int64; cdecl; overload;
    function read(buffers: TJavaObjectArray<JByteBuffer>; start: Integer; number: Integer): Int64; cdecl; overload;
    function size: Int64; cdecl;
    function transferFrom(src: JReadableByteChannel; position: Int64; count: Int64): Int64; cdecl;
    function transferTo(position: Int64; count: Int64; target: JWritableByteChannel): Int64; cdecl;
    function truncate(size: Int64): JFileChannel; cdecl;
    function tryLock: JFileLock; cdecl; overload;
    function tryLock(position: Int64; size: Int64; shared: Boolean): JFileLock; cdecl; overload;
    function write(src: JByteBuffer): Integer; cdecl; overload;
    function write(buffer: JByteBuffer; position: Int64): Integer; cdecl; overload;
    function write(buffers: TJavaObjectArray<JByteBuffer>): Int64; cdecl; overload;
    function write(buffers: TJavaObjectArray<JByteBuffer>; offset: Integer; length: Integer): Int64; cdecl; overload;
  end;
  TJFileChannel = class(TJavaGenericImport<JFileChannelClass, JFileChannel>) end;

  JFileChannel_MapModeClass = interface(JObjectClass)
    ['{428D8B72-313B-49EE-AC4B-6DD16908BBA5}']
    {class} function _GetPRIVATE: JFileChannel_MapMode; cdecl;
    {class} function _GetREAD_ONLY: JFileChannel_MapMode; cdecl;
    {class} function _GetREAD_WRITE: JFileChannel_MapMode; cdecl;
    {class} property &PRIVATE: JFileChannel_MapMode read _GetPRIVATE;
    {class} property READ_ONLY: JFileChannel_MapMode read _GetREAD_ONLY;
    {class} property READ_WRITE: JFileChannel_MapMode read _GetREAD_WRITE;
  end;

  [JavaSignature('java/nio/channels/FileChannel$MapMode')]
  JFileChannel_MapMode = interface(JObject)
    ['{15CFAED9-B5FC-454D-9463-507D14032869}']
    function toString: JString; cdecl;
  end;
  TJFileChannel_MapMode = class(TJavaGenericImport<JFileChannel_MapModeClass, JFileChannel_MapMode>) end;

  JFileLockClass = interface(JObjectClass)
    ['{5E237114-5198-4D43-8490-313B47A05E81}']
  end;

  [JavaSignature('java/nio/channels/FileLock')]
  JFileLock = interface(JObject)
    ['{03C7F0F6-5A57-4A51-A083-43258AA01093}']
    function channel: JFileChannel; cdecl;
    procedure close; cdecl;
    function isShared: Boolean; cdecl;
    function isValid: Boolean; cdecl;
    function overlaps(start: Int64; length: Int64): Boolean; cdecl;
    function position: Int64; cdecl;
    procedure release; cdecl;
    function size: Int64; cdecl;
    function toString: JString; cdecl;
  end;
  TJFileLock = class(TJavaGenericImport<JFileLockClass, JFileLock>) end;

  JPipeClass = interface(JObjectClass)
    ['{27E376BA-2D69-474C-AE28-C30BC063BEC0}']
    {class} function open: JPipe; cdecl;
  end;

  [JavaSignature('java/nio/channels/Pipe')]
  JPipe = interface(JObject)
    ['{E872278A-401B-414F-9AEF-3D9DC22CD9E9}']
    function sink: JPipe_SinkChannel; cdecl;
    function source: JPipe_SourceChannel; cdecl;
  end;
  TJPipe = class(TJavaGenericImport<JPipeClass, JPipe>) end;

  JPipe_SinkChannelClass = interface(JAbstractSelectableChannelClass)
    ['{F48BD363-BB19-4354-AFA3-45E78FE4C3FC}']
  end;

  [JavaSignature('java/nio/channels/Pipe$SinkChannel')]
  JPipe_SinkChannel = interface(JAbstractSelectableChannel)
    ['{53C39991-334C-48BF-85B4-7DDFD5859755}']
    function validOps: Integer; cdecl;
  end;
  TJPipe_SinkChannel = class(TJavaGenericImport<JPipe_SinkChannelClass, JPipe_SinkChannel>) end;

  JPipe_SourceChannelClass = interface(JAbstractSelectableChannelClass)
    ['{EFD0625C-C800-4F5A-9A61-9E30291FA04F}']
  end;

  [JavaSignature('java/nio/channels/Pipe$SourceChannel')]
  JPipe_SourceChannel = interface(JAbstractSelectableChannel)
    ['{256FD88E-5BBC-41E2-97DC-4546CF1220FD}']
    function validOps: Integer; cdecl;
  end;
  TJPipe_SourceChannel = class(TJavaGenericImport<JPipe_SourceChannelClass, JPipe_SourceChannel>) end;

  JReadableByteChannelClass = interface(JChannelClass)
    ['{3B4589E7-BD37-4B54-AC98-44050F3AE209}']
  end;

  [JavaSignature('java/nio/channels/ReadableByteChannel')]
  JReadableByteChannel = interface(JChannel)
    ['{D6B0CB63-51D0-48C6-882A-A44D30FD7521}']
    function read(buffer: JByteBuffer): Integer; cdecl;
  end;
  TJReadableByteChannel = class(TJavaGenericImport<JReadableByteChannelClass, JReadableByteChannel>) end;

  JSelectionKeyClass = interface(JObjectClass)
    ['{718617CF-8E56-41EF-982B-1DE5540C7639}']
    {class} function _GetOP_ACCEPT: Integer; cdecl;
    {class} function _GetOP_CONNECT: Integer; cdecl;
    {class} function _GetOP_READ: Integer; cdecl;
    {class} function _GetOP_WRITE: Integer; cdecl;
    {class} property OP_ACCEPT: Integer read _GetOP_ACCEPT;
    {class} property OP_CONNECT: Integer read _GetOP_CONNECT;
    {class} property OP_READ: Integer read _GetOP_READ;
    {class} property OP_WRITE: Integer read _GetOP_WRITE;
  end;

  [JavaSignature('java/nio/channels/SelectionKey')]
  JSelectionKey = interface(JObject)
    ['{22CE5584-F7C1-41E4-BA87-008827EFEEAA}']
    function attach(anObject: JObject): JObject; cdecl;
    function attachment: JObject; cdecl;
    procedure cancel; cdecl;
    function channel: JSelectableChannel; cdecl;
    function interestOps: Integer; cdecl; overload;
    function interestOps(operations: Integer): JSelectionKey; cdecl; overload;
    function isAcceptable: Boolean; cdecl;
    function isConnectable: Boolean; cdecl;
    function isReadable: Boolean; cdecl;
    function isValid: Boolean; cdecl;
    function isWritable: Boolean; cdecl;
    function readyOps: Integer; cdecl;
    function selector: JSelector; cdecl;
  end;
  TJSelectionKey = class(TJavaGenericImport<JSelectionKeyClass, JSelectionKey>) end;

  JSelectorClass = interface(JObjectClass)
    ['{E1CC5599-DD36-4998-A426-92BE0A6B5DC9}']
    {class} function open: JSelector; cdecl;
  end;

  [JavaSignature('java/nio/channels/Selector')]
  JSelector = interface(JObject)
    ['{0E8BCD73-DAF7-420A-8891-835ED1EC82BF}']
    procedure close; cdecl;
    function isOpen: Boolean; cdecl;
    function keys: JSet; cdecl;
    function provider: JSelectorProvider; cdecl;
    function select: Integer; cdecl; overload;
    function select(timeout: Int64): Integer; cdecl; overload;
    function selectNow: Integer; cdecl;
    function selectedKeys: JSet; cdecl;
    function wakeup: JSelector; cdecl;
  end;
  TJSelector = class(TJavaGenericImport<JSelectorClass, JSelector>) end;

  JServerSocketChannelClass = interface(JAbstractSelectableChannelClass)
    ['{D5B3AB40-C62C-4B8B-A579-A8B73DFCA5F8}']
    {class} function open: JServerSocketChannel; cdecl;
  end;

  [JavaSignature('java/nio/channels/ServerSocketChannel')]
  JServerSocketChannel = interface(JAbstractSelectableChannel)
    ['{5485D000-B8EE-4DCE-9DBE-8A094441F255}']
    function accept: JSocketChannel; cdecl;
    //function socket: JServerSocket; cdecl;
    function validOps: Integer; cdecl;
  end;
  TJServerSocketChannel = class(TJavaGenericImport<JServerSocketChannelClass, JServerSocketChannel>) end;

  JSocketChannelClass = interface(JAbstractSelectableChannelClass)
    ['{AC06A3C8-B76A-45CD-9CAA-C03E931A3828}']
    {class} function open: JSocketChannel; cdecl; overload;
    {class} //function open(address: JSocketAddress): JSocketChannel; cdecl; overload;
  end;

  [JavaSignature('java/nio/channels/SocketChannel')]
  JSocketChannel = interface(JAbstractSelectableChannel)
    ['{04388B66-A713-4476-98A7-A20D99310947}']
    //function connect(address: JSocketAddress): Boolean; cdecl;
    function finishConnect: Boolean; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnectionPending: Boolean; cdecl;
    function read(target: JByteBuffer): Integer; cdecl; overload;
    function read(targets: TJavaObjectArray<JByteBuffer>; offset: Integer; length: Integer): Int64; cdecl; overload;
    function read(targets: TJavaObjectArray<JByteBuffer>): Int64; cdecl; overload;
    //function socket: JSocket; cdecl;
    function validOps: Integer; cdecl;
    function write(source: JByteBuffer): Integer; cdecl; overload;
    function write(sources: TJavaObjectArray<JByteBuffer>; offset: Integer; length: Integer): Int64; cdecl; overload;
    function write(sources: TJavaObjectArray<JByteBuffer>): Int64; cdecl; overload;
  end;
  TJSocketChannel = class(TJavaGenericImport<JSocketChannelClass, JSocketChannel>) end;

  JWritableByteChannelClass = interface(JChannelClass)
    ['{C4B313F1-68CA-4254-A782-3473DAD7E786}']
  end;

  [JavaSignature('java/nio/channels/WritableByteChannel')]
  JWritableByteChannel = interface(JChannel)
    ['{58ABD8D1-20A0-4022-8CDE-C68B6A032191}']
    function write(buffer: JByteBuffer): Integer; cdecl;
  end;
  TJWritableByteChannel = class(TJavaGenericImport<JWritableByteChannelClass, JWritableByteChannel>) end;

  JAbstractSelectorClass = interface(JSelectorClass)
    ['{EF1FBF60-D39E-48AF-9326-CD3B500AFA56}']
  end;

  [JavaSignature('java/nio/channels/spi/AbstractSelector')]
  JAbstractSelector = interface(JSelector)
    ['{1583A67A-8E15-44A0-8943-EE898E4216F9}']
    procedure close; cdecl;
    function isOpen: Boolean; cdecl;
    function provider: JSelectorProvider; cdecl;
  end;
  TJAbstractSelector = class(TJavaGenericImport<JAbstractSelectorClass, JAbstractSelector>) end;

  JSelectorProviderClass = interface(JObjectClass)
    ['{52BA6B52-FF27-4051-B86B-4465C88E8830}']
    {class} function provider: JSelectorProvider; cdecl;
  end;

  [JavaSignature('java/nio/channels/spi/SelectorProvider')]
  JSelectorProvider = interface(JObject)
    ['{2217E1DD-E7B2-44E1-B932-E01CAAFF013A}']
    function inheritedChannel: JChannel; cdecl;
    function openDatagramChannel: JDatagramChannel; cdecl;
    function openPipe: JPipe; cdecl;
    function openSelector: JAbstractSelector; cdecl;
    function openServerSocketChannel: JServerSocketChannel; cdecl;
    function openSocketChannel: JSocketChannel; cdecl;
  end;
  TJSelectorProvider = class(TJavaGenericImport<JSelectorProviderClass, JSelectorProvider>) end;

  JCharsetClass = interface(JObjectClass)
    ['{8BBFEE2C-642D-4F32-8839-0C459948A70A}']
    {class} function availableCharsets: JSortedMap; cdecl;
    {class} function defaultCharset: JCharset; cdecl;
    {class} function forName(charsetName: JString): JCharset; cdecl;
    {class} function isSupported(charsetName: JString): Boolean; cdecl;
  end;

  [JavaSignature('java/nio/charset/Charset')]
  JCharset = interface(JObject)
    ['{0B41CD4C-80D6-45E5-997E-B83EF313AB67}']
    function aliases: JSet; cdecl;
    function canEncode: Boolean; cdecl;
    function compareTo(charset: JCharset): Integer; cdecl;
    function &contains(charset: JCharset): Boolean; cdecl;
    function decode(buffer: JByteBuffer): JCharBuffer; cdecl;
    function displayName: JString; cdecl; overload;
    function displayName(l: JLocale): JString; cdecl; overload;
    function encode(buffer: JCharBuffer): JByteBuffer; cdecl; overload;
    function encode(s: JString): JByteBuffer; cdecl; overload;
    function equals(obj: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function isRegistered: Boolean; cdecl;
    function name: JString; cdecl;
    function newDecoder: JCharsetDecoder; cdecl;
    function newEncoder: JCharsetEncoder; cdecl;
    function toString: JString; cdecl;
  end;
  TJCharset = class(TJavaGenericImport<JCharsetClass, JCharset>) end;

  JCharsetDecoderClass = interface(JObjectClass)
    ['{2F0FAD80-3FFC-419C-AD52-28071482CCA1}']
  end;

  [JavaSignature('java/nio/charset/CharsetDecoder')]
  JCharsetDecoder = interface(JObject)
    ['{F7AFF095-6D34-470F-B2C6-B68F75C40D26}']
    function averageCharsPerByte: Single; cdecl;
    function charset: JCharset; cdecl;
    function decode(in_: JByteBuffer): JCharBuffer; cdecl; overload;
    function decode(in_: JByteBuffer; out_: JCharBuffer; endOfInput: Boolean): JCoderResult; cdecl; overload;
    function detectedCharset: JCharset; cdecl;
    function flush(out_: JCharBuffer): JCoderResult; cdecl;
    function isAutoDetecting: Boolean; cdecl;
    function isCharsetDetected: Boolean; cdecl;
    function malformedInputAction: JCodingErrorAction; cdecl;
    function maxCharsPerByte: Single; cdecl;
    function onMalformedInput(newAction: JCodingErrorAction): JCharsetDecoder; cdecl;
    function onUnmappableCharacter(newAction: JCodingErrorAction): JCharsetDecoder; cdecl;
    function replaceWith(replacement: JString): JCharsetDecoder; cdecl;
    function replacement: JString; cdecl;
    function reset: JCharsetDecoder; cdecl;
    function unmappableCharacterAction: JCodingErrorAction; cdecl;
  end;
  TJCharsetDecoder = class(TJavaGenericImport<JCharsetDecoderClass, JCharsetDecoder>) end;

  JCharsetEncoderClass = interface(JObjectClass)
    ['{F107BD1C-B97C-4163-BFAC-1F620CC30D02}']
  end;

  [JavaSignature('java/nio/charset/CharsetEncoder')]
  JCharsetEncoder = interface(JObject)
    ['{6126DFBE-1E4C-4F67-8F42-A2B312E6CE96}']
    function averageBytesPerChar: Single; cdecl;
    function canEncode(c: Char): Boolean; cdecl; overload;
    function canEncode(sequence: JCharSequence): Boolean; cdecl; overload;
    function charset: JCharset; cdecl;
    function encode(in_: JCharBuffer): JByteBuffer; cdecl; overload;
    function encode(in_: JCharBuffer; out_: JByteBuffer; endOfInput: Boolean): JCoderResult; cdecl; overload;
    function flush(out_: JByteBuffer): JCoderResult; cdecl;
    function isLegalReplacement(replacement: TJavaArray<Byte>): Boolean; cdecl;
    function malformedInputAction: JCodingErrorAction; cdecl;
    function maxBytesPerChar: Single; cdecl;
    function onMalformedInput(newAction: JCodingErrorAction): JCharsetEncoder; cdecl;
    function onUnmappableCharacter(newAction: JCodingErrorAction): JCharsetEncoder; cdecl;
    function replaceWith(replacement: TJavaArray<Byte>): JCharsetEncoder; cdecl;
    function replacement: TJavaArray<Byte>; cdecl;
    function reset: JCharsetEncoder; cdecl;
    function unmappableCharacterAction: JCodingErrorAction; cdecl;
  end;
  TJCharsetEncoder = class(TJavaGenericImport<JCharsetEncoderClass, JCharsetEncoder>) end;

  JCoderResultClass = interface(JObjectClass)
    ['{FDEBE443-A1F2-4DCF-9AA7-5D674CE88E70}']
    {class} function _GetOVERFLOW: JCoderResult; cdecl;
    {class} function _GetUNDERFLOW: JCoderResult; cdecl;
    {class} function malformedForLength(length: Integer): JCoderResult; cdecl;
    {class} function unmappableForLength(length: Integer): JCoderResult; cdecl;
    {class} property OVERFLOW: JCoderResult read _GetOVERFLOW;
    {class} property UNDERFLOW: JCoderResult read _GetUNDERFLOW;
  end;

  [JavaSignature('java/nio/charset/CoderResult')]
  JCoderResult = interface(JObject)
    ['{2107C07D-63CF-408D-AAA0-8E36DDD4484C}']
    function isError: Boolean; cdecl;
    function isMalformed: Boolean; cdecl;
    function isOverflow: Boolean; cdecl;
    function isUnderflow: Boolean; cdecl;
    function isUnmappable: Boolean; cdecl;
    function length: Integer; cdecl;
    procedure throwException; cdecl;
    function toString: JString; cdecl;
  end;
  TJCoderResult = class(TJavaGenericImport<JCoderResultClass, JCoderResult>) end;

  JCodingErrorActionClass = interface(JObjectClass)
    ['{8E806C03-E513-41D4-AA2E-8E0A38670EF9}']
    {class} function _GetIGNORE: JCodingErrorAction; cdecl;
    {class} function _GetREPLACE: JCodingErrorAction; cdecl;
    {class} function _GetREPORT: JCodingErrorAction; cdecl;
    {class} property IGNORE: JCodingErrorAction read _GetIGNORE;
    {class} property REPLACE: JCodingErrorAction read _GetREPLACE;
    {class} property REPORT: JCodingErrorAction read _GetREPORT;
  end;

  [JavaSignature('java/nio/charset/CodingErrorAction')]
  JCodingErrorAction = interface(JObject)
    ['{46131CDD-61F4-4F10-8DC3-449D297DF12E}']
    function toString: JString; cdecl;
  end;
  TJCodingErrorAction = class(TJavaGenericImport<JCodingErrorActionClass, JCodingErrorAction>) end;

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

  // javax.crypto.SecretKey
  JEGLClass = interface(IJavaClass)
    ['{79C069DA-2C75-4159-BE9D-A05ACE86FDCE}']
  end;

  [JavaSignature('javax/microedition/khronos/egl/EGL')]
  JEGL = interface(IJavaInstance)
    ['{90E8D73C-9FF7-4CA4-B661-6A58F6A3C6C8}']
  end;
  TJEGL = class(TJavaGenericImport<JEGLClass, JEGL>) end;

  JEGL10Class = interface(JEGLClass)
    ['{D1DB03A9-8FA6-44E2-BB75-AE16D5A11CA2}']
    {class} function _GetEGL_ALPHA_FORMAT: Integer; cdecl;
    {class} function _GetEGL_ALPHA_MASK_SIZE: Integer; cdecl;
    {class} function _GetEGL_ALPHA_SIZE: Integer; cdecl;
    {class} function _GetEGL_BAD_ACCESS: Integer; cdecl;
    {class} function _GetEGL_BAD_ALLOC: Integer; cdecl;
    {class} function _GetEGL_BAD_ATTRIBUTE: Integer; cdecl;
    {class} function _GetEGL_BAD_CONFIG: Integer; cdecl;
    {class} function _GetEGL_BAD_CONTEXT: Integer; cdecl;
    {class} function _GetEGL_BAD_CURRENT_SURFACE: Integer; cdecl;
    {class} function _GetEGL_BAD_DISPLAY: Integer; cdecl;
    {class} function _GetEGL_BAD_MATCH: Integer; cdecl;
    {class} function _GetEGL_BAD_NATIVE_PIXMAP: Integer; cdecl;
    {class} function _GetEGL_BAD_NATIVE_WINDOW: Integer; cdecl;
    {class} function _GetEGL_BAD_PARAMETER: Integer; cdecl;
    {class} function _GetEGL_BAD_SURFACE: Integer; cdecl;
    {class} function _GetEGL_BLUE_SIZE: Integer; cdecl;
    {class} function _GetEGL_BUFFER_SIZE: Integer; cdecl;
    {class} function _GetEGL_COLORSPACE: Integer; cdecl;
    {class} function _GetEGL_COLOR_BUFFER_TYPE: Integer; cdecl;
    {class} function _GetEGL_CONFIG_CAVEAT: Integer; cdecl;
    {class} function _GetEGL_CONFIG_ID: Integer; cdecl;
    {class} function _GetEGL_CORE_NATIVE_ENGINE: Integer; cdecl;
    {class} function _GetEGL_DEFAULT_DISPLAY: JObject; cdecl;
    {class} function _GetEGL_DEPTH_SIZE: Integer; cdecl;
    {class} function _GetEGL_DONT_CARE: Integer; cdecl;
    {class} function _GetEGL_DRAW: Integer; cdecl;
    {class} function _GetEGL_EXTENSIONS: Integer; cdecl;
    {class} function _GetEGL_GREEN_SIZE: Integer; cdecl;
    {class} function _GetEGL_HEIGHT: Integer; cdecl;
    {class} function _GetEGL_HORIZONTAL_RESOLUTION: Integer; cdecl;
    {class} function _GetEGL_LARGEST_PBUFFER: Integer; cdecl;
    {class} function _GetEGL_LEVEL: Integer; cdecl;
    {class} function _GetEGL_LUMINANCE_BUFFER: Integer; cdecl;
    {class} function _GetEGL_LUMINANCE_SIZE: Integer; cdecl;
    {class} function _GetEGL_MAX_PBUFFER_HEIGHT: Integer; cdecl;
    {class} function _GetEGL_MAX_PBUFFER_PIXELS: Integer; cdecl;
    {class} function _GetEGL_MAX_PBUFFER_WIDTH: Integer; cdecl;
    {class} function _GetEGL_NATIVE_RENDERABLE: Integer; cdecl;
    {class} function _GetEGL_NATIVE_VISUAL_ID: Integer; cdecl;
    {class} function _GetEGL_NATIVE_VISUAL_TYPE: Integer; cdecl;
    {class} function _GetEGL_NONE: Integer; cdecl;
    {class} function _GetEGL_NON_CONFORMANT_CONFIG: Integer; cdecl;
    {class} function _GetEGL_NOT_INITIALIZED: Integer; cdecl;
    {class} function _GetEGL_NO_CONTEXT: JEGLContext; cdecl;
    {class} function _GetEGL_NO_DISPLAY: JEGLDisplay; cdecl;
    {class} function _GetEGL_NO_SURFACE: JEGLSurface; cdecl;
    {class} function _GetEGL_PBUFFER_BIT: Integer; cdecl;
    {class} function _GetEGL_PIXEL_ASPECT_RATIO: Integer; cdecl;
    {class} function _GetEGL_PIXMAP_BIT: Integer; cdecl;
    {class} function _GetEGL_READ: Integer; cdecl;
    {class} function _GetEGL_RED_SIZE: Integer; cdecl;
    {class} function _GetEGL_RENDERABLE_TYPE: Integer; cdecl;
    {class} function _GetEGL_RENDER_BUFFER: Integer; cdecl;
    {class} function _GetEGL_RGB_BUFFER: Integer; cdecl;
    {class} function _GetEGL_SAMPLES: Integer; cdecl;
    {class} function _GetEGL_SAMPLE_BUFFERS: Integer; cdecl;
    {class} function _GetEGL_SINGLE_BUFFER: Integer; cdecl;
    {class} function _GetEGL_SLOW_CONFIG: Integer; cdecl;
    {class} function _GetEGL_STENCIL_SIZE: Integer; cdecl;
    {class} function _GetEGL_SUCCESS: Integer; cdecl;
    {class} function _GetEGL_SURFACE_TYPE: Integer; cdecl;
    {class} function _GetEGL_TRANSPARENT_BLUE_VALUE: Integer; cdecl;
    {class} function _GetEGL_TRANSPARENT_GREEN_VALUE: Integer; cdecl;
    {class} function _GetEGL_TRANSPARENT_RED_VALUE: Integer; cdecl;
    {class} function _GetEGL_TRANSPARENT_RGB: Integer; cdecl;
    {class} function _GetEGL_TRANSPARENT_TYPE: Integer; cdecl;
    {class} function _GetEGL_VENDOR: Integer; cdecl;
    {class} function _GetEGL_VERSION: Integer; cdecl;
    {class} function _GetEGL_VERTICAL_RESOLUTION: Integer; cdecl;
    {class} function _GetEGL_WIDTH: Integer; cdecl;
    {class} function _GetEGL_WINDOW_BIT: Integer; cdecl;
    {class} property EGL_ALPHA_FORMAT: Integer read _GetEGL_ALPHA_FORMAT;
    {class} property EGL_ALPHA_MASK_SIZE: Integer read _GetEGL_ALPHA_MASK_SIZE;
    {class} property EGL_ALPHA_SIZE: Integer read _GetEGL_ALPHA_SIZE;
    {class} property EGL_BAD_ACCESS: Integer read _GetEGL_BAD_ACCESS;
    {class} property EGL_BAD_ALLOC: Integer read _GetEGL_BAD_ALLOC;
    {class} property EGL_BAD_ATTRIBUTE: Integer read _GetEGL_BAD_ATTRIBUTE;
    {class} property EGL_BAD_CONFIG: Integer read _GetEGL_BAD_CONFIG;
    {class} property EGL_BAD_CONTEXT: Integer read _GetEGL_BAD_CONTEXT;
    {class} property EGL_BAD_CURRENT_SURFACE: Integer read _GetEGL_BAD_CURRENT_SURFACE;
    {class} property EGL_BAD_DISPLAY: Integer read _GetEGL_BAD_DISPLAY;
    {class} property EGL_BAD_MATCH: Integer read _GetEGL_BAD_MATCH;
    {class} property EGL_BAD_NATIVE_PIXMAP: Integer read _GetEGL_BAD_NATIVE_PIXMAP;
    {class} property EGL_BAD_NATIVE_WINDOW: Integer read _GetEGL_BAD_NATIVE_WINDOW;
    {class} property EGL_BAD_PARAMETER: Integer read _GetEGL_BAD_PARAMETER;
    {class} property EGL_BAD_SURFACE: Integer read _GetEGL_BAD_SURFACE;
    {class} property EGL_BLUE_SIZE: Integer read _GetEGL_BLUE_SIZE;
    {class} property EGL_BUFFER_SIZE: Integer read _GetEGL_BUFFER_SIZE;
    {class} property EGL_COLORSPACE: Integer read _GetEGL_COLORSPACE;
    {class} property EGL_COLOR_BUFFER_TYPE: Integer read _GetEGL_COLOR_BUFFER_TYPE;
    {class} property EGL_CONFIG_CAVEAT: Integer read _GetEGL_CONFIG_CAVEAT;
    {class} property EGL_CONFIG_ID: Integer read _GetEGL_CONFIG_ID;
    {class} property EGL_CORE_NATIVE_ENGINE: Integer read _GetEGL_CORE_NATIVE_ENGINE;
    {class} property EGL_DEFAULT_DISPLAY: JObject read _GetEGL_DEFAULT_DISPLAY;
    {class} property EGL_DEPTH_SIZE: Integer read _GetEGL_DEPTH_SIZE;
    {class} property EGL_DONT_CARE: Integer read _GetEGL_DONT_CARE;
    {class} property EGL_DRAW: Integer read _GetEGL_DRAW;
    {class} property EGL_EXTENSIONS: Integer read _GetEGL_EXTENSIONS;
    {class} property EGL_GREEN_SIZE: Integer read _GetEGL_GREEN_SIZE;
    {class} property EGL_HEIGHT: Integer read _GetEGL_HEIGHT;
    {class} property EGL_HORIZONTAL_RESOLUTION: Integer read _GetEGL_HORIZONTAL_RESOLUTION;
    {class} property EGL_LARGEST_PBUFFER: Integer read _GetEGL_LARGEST_PBUFFER;
    {class} property EGL_LEVEL: Integer read _GetEGL_LEVEL;
    {class} property EGL_LUMINANCE_BUFFER: Integer read _GetEGL_LUMINANCE_BUFFER;
    {class} property EGL_LUMINANCE_SIZE: Integer read _GetEGL_LUMINANCE_SIZE;
    {class} property EGL_MAX_PBUFFER_HEIGHT: Integer read _GetEGL_MAX_PBUFFER_HEIGHT;
    {class} property EGL_MAX_PBUFFER_PIXELS: Integer read _GetEGL_MAX_PBUFFER_PIXELS;
    {class} property EGL_MAX_PBUFFER_WIDTH: Integer read _GetEGL_MAX_PBUFFER_WIDTH;
    {class} property EGL_NATIVE_RENDERABLE: Integer read _GetEGL_NATIVE_RENDERABLE;
    {class} property EGL_NATIVE_VISUAL_ID: Integer read _GetEGL_NATIVE_VISUAL_ID;
    {class} property EGL_NATIVE_VISUAL_TYPE: Integer read _GetEGL_NATIVE_VISUAL_TYPE;
    {class} property EGL_NONE: Integer read _GetEGL_NONE;
    {class} property EGL_NON_CONFORMANT_CONFIG: Integer read _GetEGL_NON_CONFORMANT_CONFIG;
    {class} property EGL_NOT_INITIALIZED: Integer read _GetEGL_NOT_INITIALIZED;
    {class} property EGL_NO_CONTEXT: JEGLContext read _GetEGL_NO_CONTEXT;
    {class} property EGL_NO_DISPLAY: JEGLDisplay read _GetEGL_NO_DISPLAY;
    {class} property EGL_NO_SURFACE: JEGLSurface read _GetEGL_NO_SURFACE;
    {class} property EGL_PBUFFER_BIT: Integer read _GetEGL_PBUFFER_BIT;
    {class} property EGL_PIXEL_ASPECT_RATIO: Integer read _GetEGL_PIXEL_ASPECT_RATIO;
    {class} property EGL_PIXMAP_BIT: Integer read _GetEGL_PIXMAP_BIT;
    {class} property EGL_READ: Integer read _GetEGL_READ;
    {class} property EGL_RED_SIZE: Integer read _GetEGL_RED_SIZE;
    {class} property EGL_RENDERABLE_TYPE: Integer read _GetEGL_RENDERABLE_TYPE;
    {class} property EGL_RENDER_BUFFER: Integer read _GetEGL_RENDER_BUFFER;
    {class} property EGL_RGB_BUFFER: Integer read _GetEGL_RGB_BUFFER;
    {class} property EGL_SAMPLES: Integer read _GetEGL_SAMPLES;
    {class} property EGL_SAMPLE_BUFFERS: Integer read _GetEGL_SAMPLE_BUFFERS;
    {class} property EGL_SINGLE_BUFFER: Integer read _GetEGL_SINGLE_BUFFER;
    {class} property EGL_SLOW_CONFIG: Integer read _GetEGL_SLOW_CONFIG;
    {class} property EGL_STENCIL_SIZE: Integer read _GetEGL_STENCIL_SIZE;
    {class} property EGL_SUCCESS: Integer read _GetEGL_SUCCESS;
    {class} property EGL_SURFACE_TYPE: Integer read _GetEGL_SURFACE_TYPE;
    {class} property EGL_TRANSPARENT_BLUE_VALUE: Integer read _GetEGL_TRANSPARENT_BLUE_VALUE;
    {class} property EGL_TRANSPARENT_GREEN_VALUE: Integer read _GetEGL_TRANSPARENT_GREEN_VALUE;
    {class} property EGL_TRANSPARENT_RED_VALUE: Integer read _GetEGL_TRANSPARENT_RED_VALUE;
    {class} property EGL_TRANSPARENT_RGB: Integer read _GetEGL_TRANSPARENT_RGB;
    {class} property EGL_TRANSPARENT_TYPE: Integer read _GetEGL_TRANSPARENT_TYPE;
    {class} property EGL_VENDOR: Integer read _GetEGL_VENDOR;
    {class} property EGL_VERSION: Integer read _GetEGL_VERSION;
    {class} property EGL_VERTICAL_RESOLUTION: Integer read _GetEGL_VERTICAL_RESOLUTION;
    {class} property EGL_WIDTH: Integer read _GetEGL_WIDTH;
    {class} property EGL_WINDOW_BIT: Integer read _GetEGL_WINDOW_BIT;
  end;

  [JavaSignature('javax/microedition/khronos/egl/EGL10')]
  JEGL10 = interface(JEGL)
    ['{5178914E-D8BE-44D4-AD82-ADE844D55BEE}']
    function eglChooseConfig(display: JEGLDisplay; attrib_list: TJavaArray<Integer>; configs: TJavaObjectArray<JEGLConfig>; config_size: Integer; num_config: TJavaArray<Integer>): Boolean; cdecl;
    function eglCopyBuffers(display: JEGLDisplay; surface: JEGLSurface; native_pixmap: JObject): Boolean; cdecl;
    function eglCreateContext(display: JEGLDisplay; config: JEGLConfig; share_context: JEGLContext; attrib_list: TJavaArray<Integer>): JEGLContext; cdecl;
    function eglCreatePbufferSurface(display: JEGLDisplay; config: JEGLConfig; attrib_list: TJavaArray<Integer>): JEGLSurface; cdecl;
    function eglCreatePixmapSurface(display: JEGLDisplay; config: JEGLConfig; native_pixmap: JObject; attrib_list: TJavaArray<Integer>): JEGLSurface; cdecl;
    function eglCreateWindowSurface(display: JEGLDisplay; config: JEGLConfig; native_window: JObject; attrib_list: TJavaArray<Integer>): JEGLSurface; cdecl;
    function eglDestroyContext(display: JEGLDisplay; context: JEGLContext): Boolean; cdecl;
    function eglDestroySurface(display: JEGLDisplay; surface: JEGLSurface): Boolean; cdecl;
    function eglGetConfigAttrib(display: JEGLDisplay; config: JEGLConfig; attribute: Integer; value: TJavaArray<Integer>): Boolean; cdecl;
    function eglGetConfigs(display: JEGLDisplay; configs: TJavaObjectArray<JEGLConfig>; config_size: Integer; num_config: TJavaArray<Integer>): Boolean; cdecl;
    function eglGetCurrentContext: JEGLContext; cdecl;
    function eglGetCurrentDisplay: JEGLDisplay; cdecl;
    function eglGetCurrentSurface(readdraw: Integer): JEGLSurface; cdecl;
    function eglGetDisplay(native_display: JObject): JEGLDisplay; cdecl;
    function eglGetError: Integer; cdecl;
    function eglInitialize(display: JEGLDisplay; major_minor: TJavaArray<Integer>): Boolean; cdecl;
    function eglMakeCurrent(display: JEGLDisplay; draw: JEGLSurface; read: JEGLSurface; context: JEGLContext): Boolean; cdecl;
    function eglQueryContext(display: JEGLDisplay; context: JEGLContext; attribute: Integer; value: TJavaArray<Integer>): Boolean; cdecl;
    function eglQueryString(display: JEGLDisplay; name: Integer): JString; cdecl;
    function eglQuerySurface(display: JEGLDisplay; surface: JEGLSurface; attribute: Integer; value: TJavaArray<Integer>): Boolean; cdecl;
    function eglSwapBuffers(display: JEGLDisplay; surface: JEGLSurface): Boolean; cdecl;
    function eglTerminate(display: JEGLDisplay): Boolean; cdecl;
    function eglWaitGL: Boolean; cdecl;
    function eglWaitNative(engine: Integer; bindTarget: JObject): Boolean; cdecl;
  end;
  TJEGL10 = class(TJavaGenericImport<JEGL10Class, JEGL10>) end;

  JEGLConfigClass = interface(JObjectClass)
    ['{96A2CBA0-853E-45DC-95EA-AA707DA29569}']
    {class} function init: JEGLConfig; cdecl;
  end;

  [JavaSignature('javax/microedition/khronos/egl/EGLConfig')]
  JEGLConfig = interface(JObject)
    ['{2647F2E5-3A3D-4D51-AB8D-5819899D7B8E}']
  end;
  TJEGLConfig = class(TJavaGenericImport<JEGLConfigClass, JEGLConfig>) end;

  JEGLContextClass = interface(JObjectClass)
    ['{75CB0600-343C-4078-A743-40B5C9E79FFF}']
    {class} function init: JEGLContext; cdecl;
    {class} function getEGL: JEGL; cdecl;
  end;

  [JavaSignature('javax/microedition/khronos/egl/EGLContext')]
  JEGLContext = interface(JObject)
    ['{768D920B-DB0B-4278-B16D-226D7BF1A971}']
    function getGL: JGL; cdecl;
  end;
  TJEGLContext = class(TJavaGenericImport<JEGLContextClass, JEGLContext>) end;

  JEGLDisplayClass = interface(JObjectClass)
    ['{1BCD3FCD-D59F-4D36-A5D2-F7492B04669F}']
    {class} function init: JEGLDisplay; cdecl;
  end;

  [JavaSignature('javax/microedition/khronos/egl/EGLDisplay')]
  JEGLDisplay = interface(JObject)
    ['{CB130B2B-7534-4FFF-9679-BD9B21F8FEC6}']
  end;
  TJEGLDisplay = class(TJavaGenericImport<JEGLDisplayClass, JEGLDisplay>) end;

  JEGLSurfaceClass = interface(JObjectClass)
    ['{E0F463FF-63B5-4F4D-BF36-6CDEDFE151EB}']
    {class} function init: JEGLSurface; cdecl;
  end;

  [JavaSignature('javax/microedition/khronos/egl/EGLSurface')]
  JEGLSurface = interface(JObject)
    ['{6BD5B09A-C1F7-4E46-A4E3-56F96C388D26}']
  end;
  TJEGLSurface = class(TJavaGenericImport<JEGLSurfaceClass, JEGLSurface>) end;

  JGLClass = interface(IJavaClass)
    ['{9E0B1F51-CA90-4AEB-8D45-C34729067041}']
  end;

  [JavaSignature('javax/microedition/khronos/opengles/GL')]
  JGL = interface(IJavaInstance)
    ['{210EA9DA-F5F9-4849-9FF2-28297F3CD7ED}']
  end;
  TJGL = class(TJavaGenericImport<JGLClass, JGL>) end;

  JGL10Class = interface(JGLClass)
    ['{11B00106-3641-4149-833C-F2A15DD0A1FB}']
    {class} function _GetGL_ADD: Integer; cdecl;
    {class} function _GetGL_ALIASED_LINE_WIDTH_RANGE: Integer; cdecl;
    {class} function _GetGL_ALIASED_POINT_SIZE_RANGE: Integer; cdecl;
    {class} function _GetGL_ALPHA: Integer; cdecl;
    {class} function _GetGL_ALPHA_BITS: Integer; cdecl;
    {class} function _GetGL_ALPHA_TEST: Integer; cdecl;
    {class} function _GetGL_ALWAYS: Integer; cdecl;
    {class} function _GetGL_AMBIENT: Integer; cdecl;
    {class} function _GetGL_AMBIENT_AND_DIFFUSE: Integer; cdecl;
    {class} function _GetGL_AND: Integer; cdecl;
    {class} function _GetGL_AND_INVERTED: Integer; cdecl;
    {class} function _GetGL_AND_REVERSE: Integer; cdecl;
    {class} function _GetGL_BACK: Integer; cdecl;
    {class} function _GetGL_BLEND: Integer; cdecl;
    {class} function _GetGL_BLUE_BITS: Integer; cdecl;
    {class} function _GetGL_BYTE: Integer; cdecl;
    {class} function _GetGL_CCW: Integer; cdecl;
    {class} function _GetGL_CLAMP_TO_EDGE: Integer; cdecl;
    {class} function _GetGL_CLEAR: Integer; cdecl;
    {class} function _GetGL_COLOR_ARRAY: Integer; cdecl;
    {class} function _GetGL_COLOR_BUFFER_BIT: Integer; cdecl;
    {class} function _GetGL_COLOR_LOGIC_OP: Integer; cdecl;
    {class} function _GetGL_COLOR_MATERIAL: Integer; cdecl;
    {class} function _GetGL_COMPRESSED_TEXTURE_FORMATS: Integer; cdecl;
    {class} function _GetGL_CONSTANT_ATTENUATION: Integer; cdecl;
    {class} function _GetGL_COPY: Integer; cdecl;
    {class} function _GetGL_COPY_INVERTED: Integer; cdecl;
    {class} function _GetGL_CULL_FACE: Integer; cdecl;
    {class} function _GetGL_CW: Integer; cdecl;
    {class} function _GetGL_DECAL: Integer; cdecl;
    {class} function _GetGL_DECR: Integer; cdecl;
    {class} function _GetGL_DEPTH_BITS: Integer; cdecl;
    {class} function _GetGL_DEPTH_BUFFER_BIT: Integer; cdecl;
    {class} function _GetGL_DEPTH_TEST: Integer; cdecl;
    {class} function _GetGL_DIFFUSE: Integer; cdecl;
    {class} function _GetGL_DITHER: Integer; cdecl;
    {class} function _GetGL_DONT_CARE: Integer; cdecl;
    {class} function _GetGL_DST_ALPHA: Integer; cdecl;
    {class} function _GetGL_DST_COLOR: Integer; cdecl;
    {class} function _GetGL_EMISSION: Integer; cdecl;
    {class} function _GetGL_EQUAL: Integer; cdecl;
    {class} function _GetGL_EQUIV: Integer; cdecl;
    {class} function _GetGL_EXP: Integer; cdecl;
    {class} function _GetGL_EXP2: Integer; cdecl;
    {class} function _GetGL_EXTENSIONS: Integer; cdecl;
    {class} function _GetGL_FALSE: Integer; cdecl;
    {class} function _GetGL_FASTEST: Integer; cdecl;
    {class} function _GetGL_FIXED: Integer; cdecl;
    {class} function _GetGL_FLAT: Integer; cdecl;
    {class} function _GetGL_FLOAT: Integer; cdecl;
    {class} function _GetGL_FOG: Integer; cdecl;
    {class} function _GetGL_FOG_COLOR: Integer; cdecl;
    {class} function _GetGL_FOG_DENSITY: Integer; cdecl;
    {class} function _GetGL_FOG_END: Integer; cdecl;
    {class} function _GetGL_FOG_HINT: Integer; cdecl;
    {class} function _GetGL_FOG_MODE: Integer; cdecl;
    {class} function _GetGL_FOG_START: Integer; cdecl;
    {class} function _GetGL_FRONT: Integer; cdecl;
    {class} function _GetGL_FRONT_AND_BACK: Integer; cdecl;
    {class} function _GetGL_GEQUAL: Integer; cdecl;
    {class} function _GetGL_GREATER: Integer; cdecl;
    {class} function _GetGL_GREEN_BITS: Integer; cdecl;
    {class} function _GetGL_IMPLEMENTATION_COLOR_READ_FORMAT_OES: Integer; cdecl;
    {class} function _GetGL_IMPLEMENTATION_COLOR_READ_TYPE_OES: Integer; cdecl;
    {class} function _GetGL_INCR: Integer; cdecl;
    {class} function _GetGL_INVALID_ENUM: Integer; cdecl;
    {class} function _GetGL_INVALID_OPERATION: Integer; cdecl;
    {class} function _GetGL_INVALID_VALUE: Integer; cdecl;
    {class} function _GetGL_INVERT: Integer; cdecl;
    {class} function _GetGL_KEEP: Integer; cdecl;
    {class} function _GetGL_LEQUAL: Integer; cdecl;
    {class} function _GetGL_LESS: Integer; cdecl;
    {class} function _GetGL_LIGHT0: Integer; cdecl;
    {class} function _GetGL_LIGHT1: Integer; cdecl;
    {class} function _GetGL_LIGHT2: Integer; cdecl;
    {class} function _GetGL_LIGHT3: Integer; cdecl;
    {class} function _GetGL_LIGHT4: Integer; cdecl;
    {class} function _GetGL_LIGHT5: Integer; cdecl;
    {class} function _GetGL_LIGHT6: Integer; cdecl;
    {class} function _GetGL_LIGHT7: Integer; cdecl;
    {class} function _GetGL_LIGHTING: Integer; cdecl;
    {class} function _GetGL_LIGHT_MODEL_AMBIENT: Integer; cdecl;
    {class} function _GetGL_LIGHT_MODEL_TWO_SIDE: Integer; cdecl;
    {class} function _GetGL_LINEAR: Integer; cdecl;
    {class} function _GetGL_LINEAR_ATTENUATION: Integer; cdecl;
    {class} function _GetGL_LINEAR_MIPMAP_LINEAR: Integer; cdecl;
    {class} function _GetGL_LINEAR_MIPMAP_NEAREST: Integer; cdecl;
    {class} function _GetGL_LINES: Integer; cdecl;
    {class} function _GetGL_LINE_LOOP: Integer; cdecl;
    {class} function _GetGL_LINE_SMOOTH: Integer; cdecl;
    {class} function _GetGL_LINE_SMOOTH_HINT: Integer; cdecl;
    {class} function _GetGL_LINE_STRIP: Integer; cdecl;
    {class} function _GetGL_LUMINANCE: Integer; cdecl;
    {class} function _GetGL_LUMINANCE_ALPHA: Integer; cdecl;
    {class} function _GetGL_MAX_ELEMENTS_INDICES: Integer; cdecl;
    {class} function _GetGL_MAX_ELEMENTS_VERTICES: Integer; cdecl;
    {class} function _GetGL_MAX_LIGHTS: Integer; cdecl;
    {class} function _GetGL_MAX_MODELVIEW_STACK_DEPTH: Integer; cdecl;
    {class} function _GetGL_MAX_PROJECTION_STACK_DEPTH: Integer; cdecl;
    {class} function _GetGL_MAX_TEXTURE_SIZE: Integer; cdecl;
    {class} function _GetGL_MAX_TEXTURE_STACK_DEPTH: Integer; cdecl;
    {class} function _GetGL_MAX_TEXTURE_UNITS: Integer; cdecl;
    {class} function _GetGL_MAX_VIEWPORT_DIMS: Integer; cdecl;
    {class} function _GetGL_MODELVIEW: Integer; cdecl;
    {class} function _GetGL_MODULATE: Integer; cdecl;
    {class} function _GetGL_MULTISAMPLE: Integer; cdecl;
    {class} function _GetGL_NAND: Integer; cdecl;
    {class} function _GetGL_NEAREST: Integer; cdecl;
    {class} function _GetGL_NEAREST_MIPMAP_LINEAR: Integer; cdecl;
    {class} function _GetGL_NEAREST_MIPMAP_NEAREST: Integer; cdecl;
    {class} function _GetGL_NEVER: Integer; cdecl;
    {class} function _GetGL_NICEST: Integer; cdecl;
    {class} function _GetGL_NOOP: Integer; cdecl;
    {class} function _GetGL_NOR: Integer; cdecl;
    {class} function _GetGL_NORMALIZE: Integer; cdecl;
    {class} function _GetGL_NORMAL_ARRAY: Integer; cdecl;
    {class} function _GetGL_NOTEQUAL: Integer; cdecl;
    {class} function _GetGL_NO_ERROR: Integer; cdecl;
    {class} function _GetGL_NUM_COMPRESSED_TEXTURE_FORMATS: Integer; cdecl;
    {class} function _GetGL_ONE: Integer; cdecl;
    {class} function _GetGL_ONE_MINUS_DST_ALPHA: Integer; cdecl;
    {class} function _GetGL_ONE_MINUS_DST_COLOR: Integer; cdecl;
    {class} function _GetGL_ONE_MINUS_SRC_ALPHA: Integer; cdecl;
    {class} function _GetGL_ONE_MINUS_SRC_COLOR: Integer; cdecl;
    {class} function _GetGL_OR: Integer; cdecl;
    {class} function _GetGL_OR_INVERTED: Integer; cdecl;
    {class} function _GetGL_OR_REVERSE: Integer; cdecl;
    {class} function _GetGL_OUT_OF_MEMORY: Integer; cdecl;
    {class} function _GetGL_PACK_ALIGNMENT: Integer; cdecl;
    {class} function _GetGL_PALETTE4_R5_G6_B5_OES: Integer; cdecl;
    {class} function _GetGL_PALETTE4_RGB5_A1_OES: Integer; cdecl;
    {class} function _GetGL_PALETTE4_RGB8_OES: Integer; cdecl;
    {class} function _GetGL_PALETTE4_RGBA4_OES: Integer; cdecl;
    {class} function _GetGL_PALETTE4_RGBA8_OES: Integer; cdecl;
    {class} function _GetGL_PALETTE8_R5_G6_B5_OES: Integer; cdecl;
    {class} function _GetGL_PALETTE8_RGB5_A1_OES: Integer; cdecl;
    {class} function _GetGL_PALETTE8_RGB8_OES: Integer; cdecl;
    {class} function _GetGL_PALETTE8_RGBA4_OES: Integer; cdecl;
    {class} function _GetGL_PALETTE8_RGBA8_OES: Integer; cdecl;
    {class} function _GetGL_PERSPECTIVE_CORRECTION_HINT: Integer; cdecl;
    {class} function _GetGL_POINTS: Integer; cdecl;
    {class} function _GetGL_POINT_FADE_THRESHOLD_SIZE: Integer; cdecl;
    {class} function _GetGL_POINT_SIZE: Integer; cdecl;
    {class} function _GetGL_POINT_SMOOTH: Integer; cdecl;
    {class} function _GetGL_POINT_SMOOTH_HINT: Integer; cdecl;
    {class} function _GetGL_POLYGON_OFFSET_FILL: Integer; cdecl;
    {class} function _GetGL_POLYGON_SMOOTH_HINT: Integer; cdecl;
    {class} function _GetGL_POSITION: Integer; cdecl;
    {class} function _GetGL_PROJECTION: Integer; cdecl;
    {class} function _GetGL_QUADRATIC_ATTENUATION: Integer; cdecl;
    {class} function _GetGL_RED_BITS: Integer; cdecl;
    {class} function _GetGL_RENDERER: Integer; cdecl;
    {class} function _GetGL_REPEAT: Integer; cdecl;
    {class} function _GetGL_REPLACE: Integer; cdecl;
    {class} function _GetGL_RESCALE_NORMAL: Integer; cdecl;
    {class} function _GetGL_RGB: Integer; cdecl;
    {class} function _GetGL_RGBA: Integer; cdecl;
    {class} function _GetGL_SAMPLE_ALPHA_TO_COVERAGE: Integer; cdecl;
    {class} function _GetGL_SAMPLE_ALPHA_TO_ONE: Integer; cdecl;
    {class} function _GetGL_SAMPLE_COVERAGE: Integer; cdecl;
    {class} function _GetGL_SCISSOR_TEST: Integer; cdecl;
    {class} function _GetGL_SET: Integer; cdecl;
    {class} function _GetGL_SHININESS: Integer; cdecl;
    {class} function _GetGL_SHORT: Integer; cdecl;
    {class} function _GetGL_SMOOTH: Integer; cdecl;
    {class} function _GetGL_SMOOTH_LINE_WIDTH_RANGE: Integer; cdecl;
    {class} function _GetGL_SMOOTH_POINT_SIZE_RANGE: Integer; cdecl;
    {class} function _GetGL_SPECULAR: Integer; cdecl;
    {class} function _GetGL_SPOT_CUTOFF: Integer; cdecl;
    {class} function _GetGL_SPOT_DIRECTION: Integer; cdecl;
    {class} function _GetGL_SPOT_EXPONENT: Integer; cdecl;
    {class} function _GetGL_SRC_ALPHA: Integer; cdecl;
    {class} function _GetGL_SRC_ALPHA_SATURATE: Integer; cdecl;
    {class} function _GetGL_SRC_COLOR: Integer; cdecl;
    {class} function _GetGL_STACK_OVERFLOW: Integer; cdecl;
    {class} function _GetGL_STACK_UNDERFLOW: Integer; cdecl;
    {class} function _GetGL_STENCIL_BITS: Integer; cdecl;
    {class} function _GetGL_STENCIL_BUFFER_BIT: Integer; cdecl;
    {class} function _GetGL_STENCIL_TEST: Integer; cdecl;
    {class} function _GetGL_SUBPIXEL_BITS: Integer; cdecl;
    {class} function _GetGL_TEXTURE: Integer; cdecl;
    {class} function _GetGL_TEXTURE0: Integer; cdecl;
    {class} function _GetGL_TEXTURE1: Integer; cdecl;
    {class} function _GetGL_TEXTURE10: Integer; cdecl;
    {class} function _GetGL_TEXTURE11: Integer; cdecl;
    {class} function _GetGL_TEXTURE12: Integer; cdecl;
    {class} function _GetGL_TEXTURE13: Integer; cdecl;
    {class} function _GetGL_TEXTURE14: Integer; cdecl;
    {class} function _GetGL_TEXTURE15: Integer; cdecl;
    {class} function _GetGL_TEXTURE16: Integer; cdecl;
    {class} function _GetGL_TEXTURE17: Integer; cdecl;
    {class} function _GetGL_TEXTURE18: Integer; cdecl;
    {class} function _GetGL_TEXTURE19: Integer; cdecl;
    {class} function _GetGL_TEXTURE2: Integer; cdecl;
    {class} function _GetGL_TEXTURE20: Integer; cdecl;
    {class} function _GetGL_TEXTURE21: Integer; cdecl;
    {class} function _GetGL_TEXTURE22: Integer; cdecl;
    {class} function _GetGL_TEXTURE23: Integer; cdecl;
    {class} function _GetGL_TEXTURE24: Integer; cdecl;
    {class} function _GetGL_TEXTURE25: Integer; cdecl;
    {class} function _GetGL_TEXTURE26: Integer; cdecl;
    {class} function _GetGL_TEXTURE27: Integer; cdecl;
    {class} function _GetGL_TEXTURE28: Integer; cdecl;
    {class} function _GetGL_TEXTURE29: Integer; cdecl;
    {class} function _GetGL_TEXTURE3: Integer; cdecl;
    {class} function _GetGL_TEXTURE30: Integer; cdecl;
    {class} function _GetGL_TEXTURE31: Integer; cdecl;
    {class} function _GetGL_TEXTURE4: Integer; cdecl;
    {class} function _GetGL_TEXTURE5: Integer; cdecl;
    {class} function _GetGL_TEXTURE6: Integer; cdecl;
    {class} function _GetGL_TEXTURE7: Integer; cdecl;
    {class} function _GetGL_TEXTURE8: Integer; cdecl;
    {class} function _GetGL_TEXTURE9: Integer; cdecl;
    {class} function _GetGL_TEXTURE_2D: Integer; cdecl;
    {class} function _GetGL_TEXTURE_COORD_ARRAY: Integer; cdecl;
    {class} function _GetGL_TEXTURE_ENV: Integer; cdecl;
    {class} function _GetGL_TEXTURE_ENV_COLOR: Integer; cdecl;
    {class} function _GetGL_TEXTURE_ENV_MODE: Integer; cdecl;
    {class} function _GetGL_TEXTURE_MAG_FILTER: Integer; cdecl;
    {class} function _GetGL_TEXTURE_MIN_FILTER: Integer; cdecl;
    {class} function _GetGL_TEXTURE_WRAP_S: Integer; cdecl;
    {class} function _GetGL_TEXTURE_WRAP_T: Integer; cdecl;
    {class} function _GetGL_TRIANGLES: Integer; cdecl;
    {class} function _GetGL_TRIANGLE_FAN: Integer; cdecl;
    {class} function _GetGL_TRIANGLE_STRIP: Integer; cdecl;
    {class} function _GetGL_TRUE: Integer; cdecl;
    {class} function _GetGL_UNPACK_ALIGNMENT: Integer; cdecl;
    {class} function _GetGL_UNSIGNED_BYTE: Integer; cdecl;
    {class} function _GetGL_UNSIGNED_SHORT: Integer; cdecl;
    {class} function _GetGL_UNSIGNED_SHORT_4_4_4_4: Integer; cdecl;
    {class} function _GetGL_UNSIGNED_SHORT_5_5_5_1: Integer; cdecl;
    {class} function _GetGL_UNSIGNED_SHORT_5_6_5: Integer; cdecl;
    {class} function _GetGL_VENDOR: Integer; cdecl;
    {class} function _GetGL_VERSION: Integer; cdecl;
    {class} function _GetGL_VERTEX_ARRAY: Integer; cdecl;
    {class} function _GetGL_XOR: Integer; cdecl;
    {class} function _GetGL_ZERO: Integer; cdecl;
    {class} property GL_ADD: Integer read _GetGL_ADD;
    {class} property GL_ALIASED_LINE_WIDTH_RANGE: Integer read _GetGL_ALIASED_LINE_WIDTH_RANGE;
    {class} property GL_ALIASED_POINT_SIZE_RANGE: Integer read _GetGL_ALIASED_POINT_SIZE_RANGE;
    {class} property GL_ALPHA: Integer read _GetGL_ALPHA;
    {class} property GL_ALPHA_BITS: Integer read _GetGL_ALPHA_BITS;
    {class} property GL_ALPHA_TEST: Integer read _GetGL_ALPHA_TEST;
    {class} property GL_ALWAYS: Integer read _GetGL_ALWAYS;
    {class} property GL_AMBIENT: Integer read _GetGL_AMBIENT;
    {class} property GL_AMBIENT_AND_DIFFUSE: Integer read _GetGL_AMBIENT_AND_DIFFUSE;
    {class} property GL_AND: Integer read _GetGL_AND;
    {class} property GL_AND_INVERTED: Integer read _GetGL_AND_INVERTED;
    {class} property GL_AND_REVERSE: Integer read _GetGL_AND_REVERSE;
    {class} property GL_BACK: Integer read _GetGL_BACK;
    {class} property GL_BLEND: Integer read _GetGL_BLEND;
    {class} property GL_BLUE_BITS: Integer read _GetGL_BLUE_BITS;
    {class} property GL_BYTE: Integer read _GetGL_BYTE;
    {class} property GL_CCW: Integer read _GetGL_CCW;
    {class} property GL_CLAMP_TO_EDGE: Integer read _GetGL_CLAMP_TO_EDGE;
    {class} property GL_CLEAR: Integer read _GetGL_CLEAR;
    {class} property GL_COLOR_ARRAY: Integer read _GetGL_COLOR_ARRAY;
    {class} property GL_COLOR_BUFFER_BIT: Integer read _GetGL_COLOR_BUFFER_BIT;
    {class} property GL_COLOR_LOGIC_OP: Integer read _GetGL_COLOR_LOGIC_OP;
    {class} property GL_COLOR_MATERIAL: Integer read _GetGL_COLOR_MATERIAL;
    {class} property GL_COMPRESSED_TEXTURE_FORMATS: Integer read _GetGL_COMPRESSED_TEXTURE_FORMATS;
    {class} property GL_CONSTANT_ATTENUATION: Integer read _GetGL_CONSTANT_ATTENUATION;
    {class} property GL_COPY: Integer read _GetGL_COPY;
    {class} property GL_COPY_INVERTED: Integer read _GetGL_COPY_INVERTED;
    {class} property GL_CULL_FACE: Integer read _GetGL_CULL_FACE;
    {class} property GL_CW: Integer read _GetGL_CW;
    {class} property GL_DECAL: Integer read _GetGL_DECAL;
    {class} property GL_DECR: Integer read _GetGL_DECR;
    {class} property GL_DEPTH_BITS: Integer read _GetGL_DEPTH_BITS;
    {class} property GL_DEPTH_BUFFER_BIT: Integer read _GetGL_DEPTH_BUFFER_BIT;
    {class} property GL_DEPTH_TEST: Integer read _GetGL_DEPTH_TEST;
    {class} property GL_DIFFUSE: Integer read _GetGL_DIFFUSE;
    {class} property GL_DITHER: Integer read _GetGL_DITHER;
    {class} property GL_DONT_CARE: Integer read _GetGL_DONT_CARE;
    {class} property GL_DST_ALPHA: Integer read _GetGL_DST_ALPHA;
    {class} property GL_DST_COLOR: Integer read _GetGL_DST_COLOR;
    {class} property GL_EMISSION: Integer read _GetGL_EMISSION;
    {class} property GL_EQUAL: Integer read _GetGL_EQUAL;
    {class} property GL_EQUIV: Integer read _GetGL_EQUIV;
    {class} property GL_EXP: Integer read _GetGL_EXP;
    {class} property GL_EXP2: Integer read _GetGL_EXP2;
    {class} property GL_EXTENSIONS: Integer read _GetGL_EXTENSIONS;
    {class} property GL_FALSE: Integer read _GetGL_FALSE;
    {class} property GL_FASTEST: Integer read _GetGL_FASTEST;
    {class} property GL_FIXED: Integer read _GetGL_FIXED;
    {class} property GL_FLAT: Integer read _GetGL_FLAT;
    {class} property GL_FLOAT: Integer read _GetGL_FLOAT;
    {class} property GL_FOG: Integer read _GetGL_FOG;
    {class} property GL_FOG_COLOR: Integer read _GetGL_FOG_COLOR;
    {class} property GL_FOG_DENSITY: Integer read _GetGL_FOG_DENSITY;
    {class} property GL_FOG_END: Integer read _GetGL_FOG_END;
    {class} property GL_FOG_HINT: Integer read _GetGL_FOG_HINT;
    {class} property GL_FOG_MODE: Integer read _GetGL_FOG_MODE;
    {class} property GL_FOG_START: Integer read _GetGL_FOG_START;
    {class} property GL_FRONT: Integer read _GetGL_FRONT;
    {class} property GL_FRONT_AND_BACK: Integer read _GetGL_FRONT_AND_BACK;
    {class} property GL_GEQUAL: Integer read _GetGL_GEQUAL;
    {class} property GL_GREATER: Integer read _GetGL_GREATER;
    {class} property GL_GREEN_BITS: Integer read _GetGL_GREEN_BITS;
    {class} property GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES: Integer read _GetGL_IMPLEMENTATION_COLOR_READ_FORMAT_OES;
    {class} property GL_IMPLEMENTATION_COLOR_READ_TYPE_OES: Integer read _GetGL_IMPLEMENTATION_COLOR_READ_TYPE_OES;
    {class} property GL_INCR: Integer read _GetGL_INCR;
    {class} property GL_INVALID_ENUM: Integer read _GetGL_INVALID_ENUM;
    {class} property GL_INVALID_OPERATION: Integer read _GetGL_INVALID_OPERATION;
    {class} property GL_INVALID_VALUE: Integer read _GetGL_INVALID_VALUE;
    {class} property GL_INVERT: Integer read _GetGL_INVERT;
    {class} property GL_KEEP: Integer read _GetGL_KEEP;
    {class} property GL_LEQUAL: Integer read _GetGL_LEQUAL;
    {class} property GL_LESS: Integer read _GetGL_LESS;
    {class} property GL_LIGHT0: Integer read _GetGL_LIGHT0;
    {class} property GL_LIGHT1: Integer read _GetGL_LIGHT1;
    {class} property GL_LIGHT2: Integer read _GetGL_LIGHT2;
    {class} property GL_LIGHT3: Integer read _GetGL_LIGHT3;
    {class} property GL_LIGHT4: Integer read _GetGL_LIGHT4;
    {class} property GL_LIGHT5: Integer read _GetGL_LIGHT5;
    {class} property GL_LIGHT6: Integer read _GetGL_LIGHT6;
    {class} property GL_LIGHT7: Integer read _GetGL_LIGHT7;
    {class} property GL_LIGHTING: Integer read _GetGL_LIGHTING;
    {class} property GL_LIGHT_MODEL_AMBIENT: Integer read _GetGL_LIGHT_MODEL_AMBIENT;
    {class} property GL_LIGHT_MODEL_TWO_SIDE: Integer read _GetGL_LIGHT_MODEL_TWO_SIDE;
    {class} property GL_LINEAR: Integer read _GetGL_LINEAR;
    {class} property GL_LINEAR_ATTENUATION: Integer read _GetGL_LINEAR_ATTENUATION;
    {class} property GL_LINEAR_MIPMAP_LINEAR: Integer read _GetGL_LINEAR_MIPMAP_LINEAR;
    {class} property GL_LINEAR_MIPMAP_NEAREST: Integer read _GetGL_LINEAR_MIPMAP_NEAREST;
    {class} property GL_LINES: Integer read _GetGL_LINES;
    {class} property GL_LINE_LOOP: Integer read _GetGL_LINE_LOOP;
    {class} property GL_LINE_SMOOTH: Integer read _GetGL_LINE_SMOOTH;
    {class} property GL_LINE_SMOOTH_HINT: Integer read _GetGL_LINE_SMOOTH_HINT;
    {class} property GL_LINE_STRIP: Integer read _GetGL_LINE_STRIP;
    {class} property GL_LUMINANCE: Integer read _GetGL_LUMINANCE;
    {class} property GL_LUMINANCE_ALPHA: Integer read _GetGL_LUMINANCE_ALPHA;
    {class} property GL_MAX_ELEMENTS_INDICES: Integer read _GetGL_MAX_ELEMENTS_INDICES;
    {class} property GL_MAX_ELEMENTS_VERTICES: Integer read _GetGL_MAX_ELEMENTS_VERTICES;
    {class} property GL_MAX_LIGHTS: Integer read _GetGL_MAX_LIGHTS;
    {class} property GL_MAX_MODELVIEW_STACK_DEPTH: Integer read _GetGL_MAX_MODELVIEW_STACK_DEPTH;
    {class} property GL_MAX_PROJECTION_STACK_DEPTH: Integer read _GetGL_MAX_PROJECTION_STACK_DEPTH;
    {class} property GL_MAX_TEXTURE_SIZE: Integer read _GetGL_MAX_TEXTURE_SIZE;
    {class} property GL_MAX_TEXTURE_STACK_DEPTH: Integer read _GetGL_MAX_TEXTURE_STACK_DEPTH;
    {class} property GL_MAX_TEXTURE_UNITS: Integer read _GetGL_MAX_TEXTURE_UNITS;
    {class} property GL_MAX_VIEWPORT_DIMS: Integer read _GetGL_MAX_VIEWPORT_DIMS;
    {class} property GL_MODELVIEW: Integer read _GetGL_MODELVIEW;
    {class} property GL_MODULATE: Integer read _GetGL_MODULATE;
    {class} property GL_MULTISAMPLE: Integer read _GetGL_MULTISAMPLE;
    {class} property GL_NAND: Integer read _GetGL_NAND;
    {class} property GL_NEAREST: Integer read _GetGL_NEAREST;
    {class} property GL_NEAREST_MIPMAP_LINEAR: Integer read _GetGL_NEAREST_MIPMAP_LINEAR;
    {class} property GL_NEAREST_MIPMAP_NEAREST: Integer read _GetGL_NEAREST_MIPMAP_NEAREST;
    {class} property GL_NEVER: Integer read _GetGL_NEVER;
    {class} property GL_NICEST: Integer read _GetGL_NICEST;
    {class} property GL_NOOP: Integer read _GetGL_NOOP;
    {class} property GL_NOR: Integer read _GetGL_NOR;
    {class} property GL_NORMALIZE: Integer read _GetGL_NORMALIZE;
    {class} property GL_NORMAL_ARRAY: Integer read _GetGL_NORMAL_ARRAY;
    {class} property GL_NOTEQUAL: Integer read _GetGL_NOTEQUAL;
    {class} property GL_NO_ERROR: Integer read _GetGL_NO_ERROR;
    {class} property GL_NUM_COMPRESSED_TEXTURE_FORMATS: Integer read _GetGL_NUM_COMPRESSED_TEXTURE_FORMATS;
    {class} property GL_ONE: Integer read _GetGL_ONE;
    {class} property GL_ONE_MINUS_DST_ALPHA: Integer read _GetGL_ONE_MINUS_DST_ALPHA;
    {class} property GL_ONE_MINUS_DST_COLOR: Integer read _GetGL_ONE_MINUS_DST_COLOR;
    {class} property GL_ONE_MINUS_SRC_ALPHA: Integer read _GetGL_ONE_MINUS_SRC_ALPHA;
    {class} property GL_ONE_MINUS_SRC_COLOR: Integer read _GetGL_ONE_MINUS_SRC_COLOR;
    {class} property GL_OR: Integer read _GetGL_OR;
    {class} property GL_OR_INVERTED: Integer read _GetGL_OR_INVERTED;
    {class} property GL_OR_REVERSE: Integer read _GetGL_OR_REVERSE;
    {class} property GL_OUT_OF_MEMORY: Integer read _GetGL_OUT_OF_MEMORY;
    {class} property GL_PACK_ALIGNMENT: Integer read _GetGL_PACK_ALIGNMENT;
    {class} property GL_PALETTE4_R5_G6_B5_OES: Integer read _GetGL_PALETTE4_R5_G6_B5_OES;
    {class} property GL_PALETTE4_RGB5_A1_OES: Integer read _GetGL_PALETTE4_RGB5_A1_OES;
    {class} property GL_PALETTE4_RGB8_OES: Integer read _GetGL_PALETTE4_RGB8_OES;
    {class} property GL_PALETTE4_RGBA4_OES: Integer read _GetGL_PALETTE4_RGBA4_OES;
    {class} property GL_PALETTE4_RGBA8_OES: Integer read _GetGL_PALETTE4_RGBA8_OES;
    {class} property GL_PALETTE8_R5_G6_B5_OES: Integer read _GetGL_PALETTE8_R5_G6_B5_OES;
    {class} property GL_PALETTE8_RGB5_A1_OES: Integer read _GetGL_PALETTE8_RGB5_A1_OES;
    {class} property GL_PALETTE8_RGB8_OES: Integer read _GetGL_PALETTE8_RGB8_OES;
    {class} property GL_PALETTE8_RGBA4_OES: Integer read _GetGL_PALETTE8_RGBA4_OES;
    {class} property GL_PALETTE8_RGBA8_OES: Integer read _GetGL_PALETTE8_RGBA8_OES;
    {class} property GL_PERSPECTIVE_CORRECTION_HINT: Integer read _GetGL_PERSPECTIVE_CORRECTION_HINT;
    {class} property GL_POINTS: Integer read _GetGL_POINTS;
    {class} property GL_POINT_FADE_THRESHOLD_SIZE: Integer read _GetGL_POINT_FADE_THRESHOLD_SIZE;
    {class} property GL_POINT_SIZE: Integer read _GetGL_POINT_SIZE;
    {class} property GL_POINT_SMOOTH: Integer read _GetGL_POINT_SMOOTH;
    {class} property GL_POINT_SMOOTH_HINT: Integer read _GetGL_POINT_SMOOTH_HINT;
    {class} property GL_POLYGON_OFFSET_FILL: Integer read _GetGL_POLYGON_OFFSET_FILL;
    {class} property GL_POLYGON_SMOOTH_HINT: Integer read _GetGL_POLYGON_SMOOTH_HINT;
    {class} property GL_POSITION: Integer read _GetGL_POSITION;
    {class} property GL_PROJECTION: Integer read _GetGL_PROJECTION;
    {class} property GL_QUADRATIC_ATTENUATION: Integer read _GetGL_QUADRATIC_ATTENUATION;
    {class} property GL_RED_BITS: Integer read _GetGL_RED_BITS;
    {class} property GL_RENDERER: Integer read _GetGL_RENDERER;
    {class} property GL_REPEAT: Integer read _GetGL_REPEAT;
    {class} property GL_REPLACE: Integer read _GetGL_REPLACE;
    {class} property GL_RESCALE_NORMAL: Integer read _GetGL_RESCALE_NORMAL;
    {class} property GL_RGB: Integer read _GetGL_RGB;
    {class} property GL_RGBA: Integer read _GetGL_RGBA;
    {class} property GL_SAMPLE_ALPHA_TO_COVERAGE: Integer read _GetGL_SAMPLE_ALPHA_TO_COVERAGE;
    {class} property GL_SAMPLE_ALPHA_TO_ONE: Integer read _GetGL_SAMPLE_ALPHA_TO_ONE;
    {class} property GL_SAMPLE_COVERAGE: Integer read _GetGL_SAMPLE_COVERAGE;
    {class} property GL_SCISSOR_TEST: Integer read _GetGL_SCISSOR_TEST;
    {class} property GL_SET: Integer read _GetGL_SET;
    {class} property GL_SHININESS: Integer read _GetGL_SHININESS;
    {class} property GL_SHORT: Integer read _GetGL_SHORT;
    {class} property GL_SMOOTH: Integer read _GetGL_SMOOTH;
    {class} property GL_SMOOTH_LINE_WIDTH_RANGE: Integer read _GetGL_SMOOTH_LINE_WIDTH_RANGE;
    {class} property GL_SMOOTH_POINT_SIZE_RANGE: Integer read _GetGL_SMOOTH_POINT_SIZE_RANGE;
    {class} property GL_SPECULAR: Integer read _GetGL_SPECULAR;
    {class} property GL_SPOT_CUTOFF: Integer read _GetGL_SPOT_CUTOFF;
    {class} property GL_SPOT_DIRECTION: Integer read _GetGL_SPOT_DIRECTION;
    {class} property GL_SPOT_EXPONENT: Integer read _GetGL_SPOT_EXPONENT;
    {class} property GL_SRC_ALPHA: Integer read _GetGL_SRC_ALPHA;
    {class} property GL_SRC_ALPHA_SATURATE: Integer read _GetGL_SRC_ALPHA_SATURATE;
    {class} property GL_SRC_COLOR: Integer read _GetGL_SRC_COLOR;
    {class} property GL_STACK_OVERFLOW: Integer read _GetGL_STACK_OVERFLOW;
    {class} property GL_STACK_UNDERFLOW: Integer read _GetGL_STACK_UNDERFLOW;
    {class} property GL_STENCIL_BITS: Integer read _GetGL_STENCIL_BITS;
    {class} property GL_STENCIL_BUFFER_BIT: Integer read _GetGL_STENCIL_BUFFER_BIT;
    {class} property GL_STENCIL_TEST: Integer read _GetGL_STENCIL_TEST;
    {class} property GL_SUBPIXEL_BITS: Integer read _GetGL_SUBPIXEL_BITS;
    {class} property GL_TEXTURE: Integer read _GetGL_TEXTURE;
    {class} property GL_TEXTURE0: Integer read _GetGL_TEXTURE0;
    {class} property GL_TEXTURE1: Integer read _GetGL_TEXTURE1;
    {class} property GL_TEXTURE10: Integer read _GetGL_TEXTURE10;
    {class} property GL_TEXTURE11: Integer read _GetGL_TEXTURE11;
    {class} property GL_TEXTURE12: Integer read _GetGL_TEXTURE12;
    {class} property GL_TEXTURE13: Integer read _GetGL_TEXTURE13;
    {class} property GL_TEXTURE14: Integer read _GetGL_TEXTURE14;
    {class} property GL_TEXTURE15: Integer read _GetGL_TEXTURE15;
    {class} property GL_TEXTURE16: Integer read _GetGL_TEXTURE16;
    {class} property GL_TEXTURE17: Integer read _GetGL_TEXTURE17;
    {class} property GL_TEXTURE18: Integer read _GetGL_TEXTURE18;
    {class} property GL_TEXTURE19: Integer read _GetGL_TEXTURE19;
    {class} property GL_TEXTURE2: Integer read _GetGL_TEXTURE2;
    {class} property GL_TEXTURE20: Integer read _GetGL_TEXTURE20;
    {class} property GL_TEXTURE21: Integer read _GetGL_TEXTURE21;
    {class} property GL_TEXTURE22: Integer read _GetGL_TEXTURE22;
    {class} property GL_TEXTURE23: Integer read _GetGL_TEXTURE23;
    {class} property GL_TEXTURE24: Integer read _GetGL_TEXTURE24;
    {class} property GL_TEXTURE25: Integer read _GetGL_TEXTURE25;
    {class} property GL_TEXTURE26: Integer read _GetGL_TEXTURE26;
    {class} property GL_TEXTURE27: Integer read _GetGL_TEXTURE27;
    {class} property GL_TEXTURE28: Integer read _GetGL_TEXTURE28;
    {class} property GL_TEXTURE29: Integer read _GetGL_TEXTURE29;
    {class} property GL_TEXTURE3: Integer read _GetGL_TEXTURE3;
    {class} property GL_TEXTURE30: Integer read _GetGL_TEXTURE30;
    {class} property GL_TEXTURE31: Integer read _GetGL_TEXTURE31;
    {class} property GL_TEXTURE4: Integer read _GetGL_TEXTURE4;
    {class} property GL_TEXTURE5: Integer read _GetGL_TEXTURE5;
    {class} property GL_TEXTURE6: Integer read _GetGL_TEXTURE6;
    {class} property GL_TEXTURE7: Integer read _GetGL_TEXTURE7;
    {class} property GL_TEXTURE8: Integer read _GetGL_TEXTURE8;
    {class} property GL_TEXTURE9: Integer read _GetGL_TEXTURE9;
    {class} property GL_TEXTURE_2D: Integer read _GetGL_TEXTURE_2D;
    {class} property GL_TEXTURE_COORD_ARRAY: Integer read _GetGL_TEXTURE_COORD_ARRAY;
    {class} property GL_TEXTURE_ENV: Integer read _GetGL_TEXTURE_ENV;
    {class} property GL_TEXTURE_ENV_COLOR: Integer read _GetGL_TEXTURE_ENV_COLOR;
    {class} property GL_TEXTURE_ENV_MODE: Integer read _GetGL_TEXTURE_ENV_MODE;
    {class} property GL_TEXTURE_MAG_FILTER: Integer read _GetGL_TEXTURE_MAG_FILTER;
    {class} property GL_TEXTURE_MIN_FILTER: Integer read _GetGL_TEXTURE_MIN_FILTER;
    {class} property GL_TEXTURE_WRAP_S: Integer read _GetGL_TEXTURE_WRAP_S;
    {class} property GL_TEXTURE_WRAP_T: Integer read _GetGL_TEXTURE_WRAP_T;
    {class} property GL_TRIANGLES: Integer read _GetGL_TRIANGLES;
    {class} property GL_TRIANGLE_FAN: Integer read _GetGL_TRIANGLE_FAN;
    {class} property GL_TRIANGLE_STRIP: Integer read _GetGL_TRIANGLE_STRIP;
    {class} property GL_TRUE: Integer read _GetGL_TRUE;
    {class} property GL_UNPACK_ALIGNMENT: Integer read _GetGL_UNPACK_ALIGNMENT;
    {class} property GL_UNSIGNED_BYTE: Integer read _GetGL_UNSIGNED_BYTE;
    {class} property GL_UNSIGNED_SHORT: Integer read _GetGL_UNSIGNED_SHORT;
    {class} property GL_UNSIGNED_SHORT_4_4_4_4: Integer read _GetGL_UNSIGNED_SHORT_4_4_4_4;
    {class} property GL_UNSIGNED_SHORT_5_5_5_1: Integer read _GetGL_UNSIGNED_SHORT_5_5_5_1;
    {class} property GL_UNSIGNED_SHORT_5_6_5: Integer read _GetGL_UNSIGNED_SHORT_5_6_5;
    {class} property GL_VENDOR: Integer read _GetGL_VENDOR;
    {class} property GL_VERSION: Integer read _GetGL_VERSION;
    {class} property GL_VERTEX_ARRAY: Integer read _GetGL_VERTEX_ARRAY;
    {class} property GL_XOR: Integer read _GetGL_XOR;
    {class} property GL_ZERO: Integer read _GetGL_ZERO;
  end;

  [JavaSignature('javax/microedition/khronos/opengles/GL10')]
  JGL10 = interface(JGL)
    ['{4F032613-C505-4409-A116-09343E69472F}']
    procedure glActiveTexture(texture: Integer); cdecl;
    procedure glAlphaFunc(func: Integer; ref: Single); cdecl;
    procedure glAlphaFuncx(func: Integer; ref: Integer); cdecl;
    procedure glBindTexture(target: Integer; texture: Integer); cdecl;
    procedure glBlendFunc(sfactor: Integer; dfactor: Integer); cdecl;
    procedure glClear(mask: Integer); cdecl;
    procedure glClearColor(red: Single; green: Single; blue: Single; alpha: Single); cdecl;
    procedure glClearColorx(red: Integer; green: Integer; blue: Integer; alpha: Integer); cdecl;
    procedure glClearDepthf(depth: Single); cdecl;
    procedure glClearDepthx(depth: Integer); cdecl;
    procedure glClearStencil(s: Integer); cdecl;
    procedure glClientActiveTexture(texture: Integer); cdecl;
    procedure glColor4f(red: Single; green: Single; blue: Single; alpha: Single); cdecl;
    procedure glColor4x(red: Integer; green: Integer; blue: Integer; alpha: Integer); cdecl;
    procedure glColorMask(red: Boolean; green: Boolean; blue: Boolean; alpha: Boolean); cdecl;
    procedure glColorPointer(size: Integer; type_: Integer; stride: Integer; pointer: JBuffer); cdecl;
    procedure glCompressedTexImage2D(target: Integer; level: Integer; internalformat: Integer; width: Integer; height: Integer; border: Integer; imageSize: Integer; data: JBuffer); cdecl;
    procedure glCompressedTexSubImage2D(target: Integer; level: Integer; xoffset: Integer; yoffset: Integer; width: Integer; height: Integer; format: Integer; imageSize: Integer; data: JBuffer); cdecl;
    procedure glCopyTexImage2D(target: Integer; level: Integer; internalformat: Integer; x: Integer; y: Integer; width: Integer; height: Integer; border: Integer); cdecl;
    procedure glCopyTexSubImage2D(target: Integer; level: Integer; xoffset: Integer; yoffset: Integer; x: Integer; y: Integer; width: Integer; height: Integer); cdecl;
    procedure glCullFace(mode: Integer); cdecl;
    procedure glDeleteTextures(n: Integer; textures: TJavaArray<Integer>; offset: Integer); cdecl; overload;
    procedure glDeleteTextures(n: Integer; textures: JIntBuffer); cdecl; overload;
    procedure glDepthFunc(func: Integer); cdecl;
    procedure glDepthMask(flag: Boolean); cdecl;
    procedure glDepthRangef(zNear: Single; zFar: Single); cdecl;
    procedure glDepthRangex(zNear: Integer; zFar: Integer); cdecl;
    procedure glDisable(cap: Integer); cdecl;
    procedure glDisableClientState(array_: Integer); cdecl;
    procedure glDrawArrays(mode: Integer; first: Integer; count: Integer); cdecl;
    procedure glDrawElements(mode: Integer; count: Integer; type_: Integer; indices: JBuffer); cdecl;
    procedure glEnable(cap: Integer); cdecl;
    procedure glEnableClientState(array_: Integer); cdecl;
    procedure glFinish; cdecl;
    procedure glFlush; cdecl;
    procedure glFogf(pname: Integer; param: Single); cdecl;
    procedure glFogfv(pname: Integer; params: TJavaArray<Single>; offset: Integer); cdecl; overload;
    procedure glFogfv(pname: Integer; params: JFloatBuffer); cdecl; overload;
    procedure glFogx(pname: Integer; param: Integer); cdecl;
    procedure glFogxv(pname: Integer; params: TJavaArray<Integer>; offset: Integer); cdecl; overload;
    procedure glFogxv(pname: Integer; params: JIntBuffer); cdecl; overload;
    procedure glFrontFace(mode: Integer); cdecl;
    procedure glFrustumf(left: Single; right: Single; bottom: Single; top: Single; zNear: Single; zFar: Single); cdecl;
    procedure glFrustumx(left: Integer; right: Integer; bottom: Integer; top: Integer; zNear: Integer; zFar: Integer); cdecl;
    procedure glGenTextures(n: Integer; textures: TJavaArray<Integer>; offset: Integer); cdecl; overload;
    procedure glGenTextures(n: Integer; textures: JIntBuffer); cdecl; overload;
    function glGetError: Integer; cdecl;
    procedure glGetIntegerv(pname: Integer; params: TJavaArray<Integer>; offset: Integer); cdecl; overload;
    procedure glGetIntegerv(pname: Integer; params: JIntBuffer); cdecl; overload;
    function glGetString(name: Integer): JString; cdecl;
    procedure glHint(target: Integer; mode: Integer); cdecl;
    procedure glLightModelf(pname: Integer; param: Single); cdecl;
    procedure glLightModelfv(pname: Integer; params: TJavaArray<Single>; offset: Integer); cdecl; overload;
    procedure glLightModelfv(pname: Integer; params: JFloatBuffer); cdecl; overload;
    procedure glLightModelx(pname: Integer; param: Integer); cdecl;
    procedure glLightModelxv(pname: Integer; params: TJavaArray<Integer>; offset: Integer); cdecl; overload;
    procedure glLightModelxv(pname: Integer; params: JIntBuffer); cdecl; overload;
    procedure glLightf(light: Integer; pname: Integer; param: Single); cdecl;
    procedure glLightfv(light: Integer; pname: Integer; params: TJavaArray<Single>; offset: Integer); cdecl; overload;
    procedure glLightfv(light: Integer; pname: Integer; params: JFloatBuffer); cdecl; overload;
    procedure glLightx(light: Integer; pname: Integer; param: Integer); cdecl;
    procedure glLightxv(light: Integer; pname: Integer; params: TJavaArray<Integer>; offset: Integer); cdecl; overload;
    procedure glLightxv(light: Integer; pname: Integer; params: JIntBuffer); cdecl; overload;
    procedure glLineWidth(width: Single); cdecl;
    procedure glLineWidthx(width: Integer); cdecl;
    procedure glLoadIdentity; cdecl;
    procedure glLoadMatrixf(m: TJavaArray<Single>; offset: Integer); cdecl; overload;
    procedure glLoadMatrixf(m: JFloatBuffer); cdecl; overload;
    procedure glLoadMatrixx(m: TJavaArray<Integer>; offset: Integer); cdecl; overload;
    procedure glLoadMatrixx(m: JIntBuffer); cdecl; overload;
    procedure glLogicOp(opcode: Integer); cdecl;
    procedure glMaterialf(face: Integer; pname: Integer; param: Single); cdecl;
    procedure glMaterialfv(face: Integer; pname: Integer; params: TJavaArray<Single>; offset: Integer); cdecl; overload;
    procedure glMaterialfv(face: Integer; pname: Integer; params: JFloatBuffer); cdecl; overload;
    procedure glMaterialx(face: Integer; pname: Integer; param: Integer); cdecl;
    procedure glMaterialxv(face: Integer; pname: Integer; params: TJavaArray<Integer>; offset: Integer); cdecl; overload;
    procedure glMaterialxv(face: Integer; pname: Integer; params: JIntBuffer); cdecl; overload;
    procedure glMatrixMode(mode: Integer); cdecl;
    procedure glMultMatrixf(m: TJavaArray<Single>; offset: Integer); cdecl; overload;
    procedure glMultMatrixf(m: JFloatBuffer); cdecl; overload;
    procedure glMultMatrixx(m: TJavaArray<Integer>; offset: Integer); cdecl; overload;
    procedure glMultMatrixx(m: JIntBuffer); cdecl; overload;
    procedure glMultiTexCoord4f(target: Integer; s: Single; t: Single; r: Single; q: Single); cdecl;
    procedure glMultiTexCoord4x(target: Integer; s: Integer; t: Integer; r: Integer; q: Integer); cdecl;
    procedure glNormal3f(nx: Single; ny: Single; nz: Single); cdecl;
    procedure glNormal3x(nx: Integer; ny: Integer; nz: Integer); cdecl;
    procedure glNormalPointer(type_: Integer; stride: Integer; pointer: JBuffer); cdecl;
    procedure glOrthof(left: Single; right: Single; bottom: Single; top: Single; zNear: Single; zFar: Single); cdecl;
    procedure glOrthox(left: Integer; right: Integer; bottom: Integer; top: Integer; zNear: Integer; zFar: Integer); cdecl;
    procedure glPixelStorei(pname: Integer; param: Integer); cdecl;
    procedure glPointSize(size: Single); cdecl;
    procedure glPointSizex(size: Integer); cdecl;
    procedure glPolygonOffset(factor: Single; units: Single); cdecl;
    procedure glPolygonOffsetx(factor: Integer; units: Integer); cdecl;
    procedure glPopMatrix; cdecl;
    procedure glPushMatrix; cdecl;
    procedure glReadPixels(x: Integer; y: Integer; width: Integer; height: Integer; format: Integer; type_: Integer; pixels: JBuffer); cdecl;
    procedure glRotatef(angle: Single; x: Single; y: Single; z: Single); cdecl;
    procedure glRotatex(angle: Integer; x: Integer; y: Integer; z: Integer); cdecl;
    procedure glSampleCoverage(value: Single; invert: Boolean); cdecl;
    procedure glSampleCoveragex(value: Integer; invert: Boolean); cdecl;
    procedure glScalef(x: Single; y: Single; z: Single); cdecl;
    procedure glScalex(x: Integer; y: Integer; z: Integer); cdecl;
    procedure glScissor(x: Integer; y: Integer; width: Integer; height: Integer); cdecl;
    procedure glShadeModel(mode: Integer); cdecl;
    procedure glStencilFunc(func: Integer; ref: Integer; mask: Integer); cdecl;
    procedure glStencilMask(mask: Integer); cdecl;
    procedure glStencilOp(fail: Integer; zfail: Integer; zpass: Integer); cdecl;
    procedure glTexCoordPointer(size: Integer; type_: Integer; stride: Integer; pointer: JBuffer); cdecl;
    procedure glTexEnvf(target: Integer; pname: Integer; param: Single); cdecl;
    procedure glTexEnvfv(target: Integer; pname: Integer; params: TJavaArray<Single>; offset: Integer); cdecl; overload;
    procedure glTexEnvfv(target: Integer; pname: Integer; params: JFloatBuffer); cdecl; overload;
    procedure glTexEnvx(target: Integer; pname: Integer; param: Integer); cdecl;
    procedure glTexEnvxv(target: Integer; pname: Integer; params: TJavaArray<Integer>; offset: Integer); cdecl; overload;
    procedure glTexEnvxv(target: Integer; pname: Integer; params: JIntBuffer); cdecl; overload;
    procedure glTexImage2D(target: Integer; level: Integer; internalformat: Integer; width: Integer; height: Integer; border: Integer; format: Integer; type_: Integer; pixels: JBuffer); cdecl;
    procedure glTexParameterf(target: Integer; pname: Integer; param: Single); cdecl;
    procedure glTexParameterx(target: Integer; pname: Integer; param: Integer); cdecl;
    procedure glTexSubImage2D(target: Integer; level: Integer; xoffset: Integer; yoffset: Integer; width: Integer; height: Integer; format: Integer; type_: Integer; pixels: JBuffer); cdecl;
    procedure glTranslatef(x: Single; y: Single; z: Single); cdecl;
    procedure glTranslatex(x: Integer; y: Integer; z: Integer); cdecl;
    procedure glVertexPointer(size: Integer; type_: Integer; stride: Integer; pointer: JBuffer); cdecl;
    procedure glViewport(x: Integer; y: Integer; width: Integer; height: Integer); cdecl;
  end;
  TJGL10 = class(TJavaGenericImport<JGL10Class, JGL10>) end;

  JJSONArrayClass = interface(JObjectClass)
    ['{34FBA399-2B13-49B4-BD53-5BDFE4653285}']
    {class} function init: JJSONArray; cdecl; overload;
    {class} function init(copyFrom: JCollection): JJSONArray; cdecl; overload;
    {class} function init(readFrom: JJSONTokener): JJSONArray; cdecl; overload;
    {class} function init(json: JString): JJSONArray; cdecl; overload;
    {class} function init(array_: JObject): JJSONArray; cdecl; overload;
  end;

  [JavaSignature('org/json/JSONArray')]
  JJSONArray = interface(JObject)
    ['{34738D80-ED10-413D-9467-36A3785DBFF4}']
    function equals(o: JObject): Boolean; cdecl;
    function &get(index: Integer): JObject; cdecl;
    function getBoolean(index: Integer): Boolean; cdecl;
    function getDouble(index: Integer): Double; cdecl;
    function getInt(index: Integer): Integer; cdecl;
    function getJSONArray(index: Integer): JJSONArray; cdecl;
    function getJSONObject(index: Integer): JJSONObject; cdecl;
    function getLong(index: Integer): Int64; cdecl;
    function getString(index: Integer): JString; cdecl;
    function hashCode: Integer; cdecl;
    function isNull(index: Integer): Boolean; cdecl;
    function join(separator: JString): JString; cdecl;
    function length: Integer; cdecl;
    function opt(index: Integer): JObject; cdecl;
    function optBoolean(index: Integer): Boolean; cdecl; overload;
    function optBoolean(index: Integer; fallback: Boolean): Boolean; cdecl; overload;
    function optDouble(index: Integer): Double; cdecl; overload;
    function optDouble(index: Integer; fallback: Double): Double; cdecl; overload;
    function optInt(index: Integer): Integer; cdecl; overload;
    function optInt(index: Integer; fallback: Integer): Integer; cdecl; overload;
    function optJSONArray(index: Integer): JJSONArray; cdecl;
    function optJSONObject(index: Integer): JJSONObject; cdecl;
    function optLong(index: Integer): Int64; cdecl; overload;
    function optLong(index: Integer; fallback: Int64): Int64; cdecl; overload;
    function optString(index: Integer): JString; cdecl; overload;
    function optString(index: Integer; fallback: JString): JString; cdecl; overload;
    function put(value: Boolean): JJSONArray; cdecl; overload;
    function put(value: Double): JJSONArray; cdecl; overload;
    function put(value: Integer): JJSONArray; cdecl; overload;
    function put(value: Int64): JJSONArray; cdecl; overload;
    function put(value: JObject): JJSONArray; cdecl; overload;
    function put(index: Integer; value: Boolean): JJSONArray; cdecl; overload;
    function put(index: Integer; value: Double): JJSONArray; cdecl; overload;
    function put(index: Integer; value: Integer): JJSONArray; cdecl; overload;
    function put(index: Integer; value: Int64): JJSONArray; cdecl; overload;
    function put(index: Integer; value: JObject): JJSONArray; cdecl; overload;
    function remove(index: Integer): JObject; cdecl;
    function toJSONObject(names: JJSONArray): JJSONObject; cdecl;
    function toString: JString; cdecl; overload;
    function toString(indentSpaces: Integer): JString; cdecl; overload;
  end;
  TJJSONArray = class(TJavaGenericImport<JJSONArrayClass, JJSONArray>) end;

  JJSONExceptionClass = interface(JExceptionClass)
    ['{D92F06D5-D459-4309-AE86-21A7EF971C64}']
    {class} function init(s: JString): JJSONException; cdecl;
  end;

  [JavaSignature('org/json/JSONException')]
  JJSONException = interface(JException)
    ['{236AB196-CC66-40D5-91E5-C3D202A9293C}']
  end;
  TJJSONException = class(TJavaGenericImport<JJSONExceptionClass, JJSONException>) end;

  JJSONObjectClass = interface(JObjectClass)
    ['{32FBF926-19C3-45AF-A29E-C312D95B34CC}']
    {class} function _GetNULL: JObject; cdecl;
    {class} function init: JJSONObject; cdecl; overload;
    {class} function init(copyFrom: JMap): JJSONObject; cdecl; overload;
    {class} function init(readFrom: JJSONTokener): JJSONObject; cdecl; overload;
    {class} function init(json: JString): JJSONObject; cdecl; overload;
    {class} function init(copyFrom: JJSONObject; names: TJavaObjectArray<JString>): JJSONObject; cdecl; overload;
    {class} function numberToString(number: JNumber): JString; cdecl;
    {class} function quote(data: JString): JString; cdecl;
    {class} function wrap(o: JObject): JObject; cdecl;
    {class} 
  end;

  [JavaSignature('org/json/JSONObject')]
  JJSONObject = interface(JObject)
    ['{7B4F68E8-ADFC-40EC-A119-37FA9778A11C}']
    function accumulate(name: JString; value: JObject): JJSONObject; cdecl;
    function &get(name: JString): JObject; cdecl;
    function getBoolean(name: JString): Boolean; cdecl;
    function getDouble(name: JString): Double; cdecl;
    function getInt(name: JString): Integer; cdecl;
    function getJSONArray(name: JString): JJSONArray; cdecl;
    function getJSONObject(name: JString): JJSONObject; cdecl;
    function getLong(name: JString): Int64; cdecl;
    function getString(name: JString): JString; cdecl;
    function has(name: JString): Boolean; cdecl;
    function isNull(name: JString): Boolean; cdecl;
    function keys: JIterator; cdecl;
    function length: Integer; cdecl;
    function names: JJSONArray; cdecl;
    function opt(name: JString): JObject; cdecl;
    function optBoolean(name: JString): Boolean; cdecl; overload;
    function optBoolean(name: JString; fallback: Boolean): Boolean; cdecl; overload;
    function optDouble(name: JString): Double; cdecl; overload;
    function optDouble(name: JString; fallback: Double): Double; cdecl; overload;
    function optInt(name: JString): Integer; cdecl; overload;
    function optInt(name: JString; fallback: Integer): Integer; cdecl; overload;
    function optJSONArray(name: JString): JJSONArray; cdecl;
    function optJSONObject(name: JString): JJSONObject; cdecl;
    function optLong(name: JString): Int64; cdecl; overload;
    function optLong(name: JString; fallback: Int64): Int64; cdecl; overload;
    function optString(name: JString): JString; cdecl; overload;
    function optString(name: JString; fallback: JString): JString; cdecl; overload;
    function put(name: JString; value: Boolean): JJSONObject; cdecl; overload;
    function put(name: JString; value: Double): JJSONObject; cdecl; overload;
    function put(name: JString; value: Integer): JJSONObject; cdecl; overload;
    function put(name: JString; value: Int64): JJSONObject; cdecl; overload;
    function put(name: JString; value: JObject): JJSONObject; cdecl; overload;
    function putOpt(name: JString; value: JObject): JJSONObject; cdecl;
    function remove(name: JString): JObject; cdecl;
    function toJSONArray(names: JJSONArray): JJSONArray; cdecl;
    function toString: JString; cdecl; overload;
    function toString(indentSpaces: Integer): JString; cdecl; overload;
  end;
  TJJSONObject = class(TJavaGenericImport<JJSONObjectClass, JJSONObject>) end;

  JJSONTokenerClass = interface(JObjectClass)
    ['{CFDB19D3-6222-4DBF-9012-1EF6EA1D518D}']
    {class} function init(in_: JString): JJSONTokener; cdecl;
    {class} function dehexchar(hex: Char): Integer; cdecl;
  end;

  [JavaSignature('org/json/JSONTokener')]
  JJSONTokener = interface(JObject)
    ['{A7330D36-4304-4864-BACD-547E8AF8AAAD}']
    procedure back; cdecl;
    function more: Boolean; cdecl;
    function next: Char; cdecl; overload;
    function next(c: Char): Char; cdecl; overload;
    function next(length: Integer): JString; cdecl; overload;
    function nextClean: Char; cdecl;
    function nextString(quote: Char): JString; cdecl;
    function nextTo(excluded: JString): JString; cdecl; overload;
    function nextTo(excluded: Char): JString; cdecl; overload;
    function nextValue: JObject; cdecl;
    procedure skipPast(thru: JString); cdecl;
    function skipTo(to_: Char): Char; cdecl;
    function syntaxError(message: JString): JJSONException; cdecl;
    function toString: JString; cdecl;
  end;
  TJJSONTokener = class(TJavaGenericImport<JJSONTokenerClass, JJSONTokener>) end;

  JXmlPullParserClass = interface(IJavaClass)
    ['{932020CD-42E1-42D5-A33D-5190366B7EE1}']
    {class} function _GetCDSECT: Integer; cdecl;
    {class} function _GetCOMMENT: Integer; cdecl;
    {class} function _GetDOCDECL: Integer; cdecl;
    {class} function _GetEND_DOCUMENT: Integer; cdecl;
    {class} function _GetEND_TAG: Integer; cdecl;
    {class} function _GetENTITY_REF: Integer; cdecl;
    {class} function _GetFEATURE_PROCESS_DOCDECL: JString; cdecl;
    {class} function _GetFEATURE_PROCESS_NAMESPACES: JString; cdecl;
    {class} function _GetFEATURE_REPORT_NAMESPACE_ATTRIBUTES: JString; cdecl;
    {class} function _GetFEATURE_VALIDATION: JString; cdecl;
    {class} function _GetIGNORABLE_WHITESPACE: Integer; cdecl;
    {class} function _GetNO_NAMESPACE: JString; cdecl;
    {class} function _GetPROCESSING_INSTRUCTION: Integer; cdecl;
    {class} function _GetSTART_DOCUMENT: Integer; cdecl;
    {class} function _GetSTART_TAG: Integer; cdecl;
    {class} function _GetTEXT: Integer; cdecl;
    {class} function _GetTYPES: TJavaObjectArray<JString>; cdecl;
    {class} property CDSECT: Integer read _GetCDSECT;
    {class} property COMMENT: Integer read _GetCOMMENT;
    {class} property DOCDECL: Integer read _GetDOCDECL;
    {class} property END_DOCUMENT: Integer read _GetEND_DOCUMENT;
    {class} property END_TAG: Integer read _GetEND_TAG;
    {class} property ENTITY_REF: Integer read _GetENTITY_REF;
    {class} property FEATURE_PROCESS_DOCDECL: JString read _GetFEATURE_PROCESS_DOCDECL;
    {class} property FEATURE_PROCESS_NAMESPACES: JString read _GetFEATURE_PROCESS_NAMESPACES;
    {class} property FEATURE_REPORT_NAMESPACE_ATTRIBUTES: JString read _GetFEATURE_REPORT_NAMESPACE_ATTRIBUTES;
    {class} property FEATURE_VALIDATION: JString read _GetFEATURE_VALIDATION;
    {class} property IGNORABLE_WHITESPACE: Integer read _GetIGNORABLE_WHITESPACE;
    {class} property NO_NAMESPACE: JString read _GetNO_NAMESPACE;
    {class} property PROCESSING_INSTRUCTION: Integer read _GetPROCESSING_INSTRUCTION;
    {class} property START_DOCUMENT: Integer read _GetSTART_DOCUMENT;
    {class} property START_TAG: Integer read _GetSTART_TAG;
    {class} property TEXT: Integer read _GetTEXT;
    {class} property TYPES: TJavaObjectArray<JString> read _GetTYPES;
  end;

  [JavaSignature('org/xmlpull/v1/XmlPullParser')]
  JXmlPullParser = interface(IJavaInstance)
    ['{047BC31A-D436-4663-A1F8-E304CC9B5CFE}']
    procedure defineEntityReplacementText(entityName: JString; replacementText: JString); cdecl;
    function getAttributeCount: Integer; cdecl;
    function getAttributeName(index: Integer): JString; cdecl;
    function getAttributeNamespace(index: Integer): JString; cdecl;
    function getAttributePrefix(index: Integer): JString; cdecl;
    function getAttributeType(index: Integer): JString; cdecl;
    function getAttributeValue(index: Integer): JString; cdecl; overload;
    function getAttributeValue(namespace: JString; name: JString): JString; cdecl; overload;
    function getColumnNumber: Integer; cdecl;
    function getDepth: Integer; cdecl;
    function getEventType: Integer; cdecl;
    function getFeature(name: JString): Boolean; cdecl;
    function getInputEncoding: JString; cdecl;
    function getLineNumber: Integer; cdecl;
    function getName: JString; cdecl;
    function getNamespace(prefix: JString): JString; cdecl; overload;
    function getNamespace: JString; cdecl; overload;
    function getNamespaceCount(depth: Integer): Integer; cdecl;
    function getNamespacePrefix(pos: Integer): JString; cdecl;
    function getNamespaceUri(pos: Integer): JString; cdecl;
    function getPositionDescription: JString; cdecl;
    function getPrefix: JString; cdecl;
    function getProperty(name: JString): JObject; cdecl;
    function getText: JString; cdecl;
    function getTextCharacters(holderForStartAndLength: TJavaArray<Integer>): TJavaArray<Char>; cdecl;
    function isAttributeDefault(index: Integer): Boolean; cdecl;
    function isEmptyElementTag: Boolean; cdecl;
    function isWhitespace: Boolean; cdecl;
    function next: Integer; cdecl;
    function nextTag: Integer; cdecl;
    function nextText: JString; cdecl;
    function nextToken: Integer; cdecl;
    procedure require(type_: Integer; namespace: JString; name: JString); cdecl;
    procedure setFeature(name: JString; state: Boolean); cdecl;
    procedure setInput(in_: JReader); cdecl; overload;
    procedure setInput(inputStream: JInputStream; inputEncoding: JString); cdecl; overload;
    procedure setProperty(name: JString; value: JObject); cdecl;
  end;
  TJXmlPullParser = class(TJavaGenericImport<JXmlPullParserClass, JXmlPullParser>) end;

  JXmlSerializerClass = interface(IJavaClass)
    ['{358A6AC9-1AF2-497F-BFBE-CF975CCAAF07}']
  end;

  [JavaSignature('org/xmlpull/v1/XmlSerializer')]
  JXmlSerializer = interface(IJavaInstance)
    ['{A16E0414-9A1D-499F-839F-E89BDA70DFB5}']
    function attribute(namespace: JString; name: JString; value: JString): JXmlSerializer; cdecl;
    procedure cdsect(text: JString); cdecl;
    procedure comment(text: JString); cdecl;
    procedure docdecl(text: JString); cdecl;
    procedure endDocument; cdecl;
    function endTag(namespace: JString; name: JString): JXmlSerializer; cdecl;
    procedure entityRef(text: JString); cdecl;
    procedure flush; cdecl;
    function getDepth: Integer; cdecl;
    function getFeature(name: JString): Boolean; cdecl;
    function getName: JString; cdecl;
    function getNamespace: JString; cdecl;
    function getPrefix(namespace: JString; generatePrefix: Boolean): JString; cdecl;
    function getProperty(name: JString): JObject; cdecl;
    procedure ignorableWhitespace(text: JString); cdecl;
    procedure processingInstruction(text: JString); cdecl;
    procedure setFeature(name: JString; state: Boolean); cdecl;
    procedure setOutput(os: JOutputStream; encoding: JString); cdecl; overload;
    procedure setOutput(writer: JWriter); cdecl; overload;
    procedure setPrefix(prefix: JString; namespace: JString); cdecl;
    procedure setProperty(name: JString; value: JObject); cdecl;
    procedure startDocument(encoding: JString; standalone: JBoolean); cdecl;
    function startTag(namespace: JString; name: JString): JXmlSerializer; cdecl;
    function text(text: JString): JXmlSerializer; cdecl; overload;
    function text(buf: TJavaArray<Char>; start: Integer; len: Integer): JXmlSerializer; cdecl; overload;
  end;
  TJXmlSerializer = class(TJavaGenericImport<JXmlSerializerClass, JXmlSerializer>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JObject', TypeInfo(Androidapi.JNI.JavaTypes.JObject));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JInputStream', TypeInfo(Androidapi.JNI.JavaTypes.JInputStream));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JByteArrayInputStream', TypeInfo(Androidapi.JNI.JavaTypes.JByteArrayInputStream));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JOutputStream', TypeInfo(Androidapi.JNI.JavaTypes.JOutputStream));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JByteArrayOutputStream', TypeInfo(Androidapi.JNI.JavaTypes.JByteArrayOutputStream));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAutoCloseable', TypeInfo(Androidapi.JNI.JavaTypes.JAutoCloseable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCloseable', TypeInfo(Androidapi.JNI.JavaTypes.JCloseable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFile', TypeInfo(Androidapi.JNI.JavaTypes.JFile));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFileDescriptor', TypeInfo(Androidapi.JNI.JavaTypes.JFileDescriptor));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFileFilter', TypeInfo(Androidapi.JNI.JavaTypes.JFileFilter));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFileInputStream', TypeInfo(Androidapi.JNI.JavaTypes.JFileInputStream));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFileOutputStream', TypeInfo(Androidapi.JNI.JavaTypes.JFileOutputStream));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFilenameFilter', TypeInfo(Androidapi.JNI.JavaTypes.JFilenameFilter));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFilterOutputStream', TypeInfo(Androidapi.JNI.JavaTypes.JFilterOutputStream));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JThrowable', TypeInfo(Androidapi.JNI.JavaTypes.JThrowable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JException', TypeInfo(Androidapi.JNI.JavaTypes.JException));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JIOException', TypeInfo(Androidapi.JNI.JavaTypes.JIOException));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JPrintStream', TypeInfo(Androidapi.JNI.JavaTypes.JPrintStream));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JWriter', TypeInfo(Androidapi.JNI.JavaTypes.JWriter));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JPrintWriter', TypeInfo(Androidapi.JNI.JavaTypes.JPrintWriter));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JRandomAccessFile', TypeInfo(Androidapi.JNI.JavaTypes.JRandomAccessFile));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JReader', TypeInfo(Androidapi.JNI.JavaTypes.JReader));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JSerializable', TypeInfo(Androidapi.JNI.JavaTypes.JSerializable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAbstractStringBuilder', TypeInfo(Androidapi.JNI.JavaTypes.JAbstractStringBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JBoolean', TypeInfo(Androidapi.JNI.JavaTypes.JBoolean));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JNumber', TypeInfo(Androidapi.JNI.JavaTypes.JNumber));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JByte', TypeInfo(Androidapi.JNI.JavaTypes.JByte));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCharSequence', TypeInfo(Androidapi.JNI.JavaTypes.JCharSequence));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.Jlang_Class', TypeInfo(Androidapi.JNI.JavaTypes.Jlang_Class));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JClassLoader', TypeInfo(Androidapi.JNI.JavaTypes.JClassLoader));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JComparable', TypeInfo(Androidapi.JNI.JavaTypes.JComparable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JDouble', TypeInfo(Androidapi.JNI.JavaTypes.JDouble));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JEnum', TypeInfo(Androidapi.JNI.JavaTypes.JEnum));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFloat', TypeInfo(Androidapi.JNI.JavaTypes.JFloat));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JRuntimeException', TypeInfo(Androidapi.JNI.JavaTypes.JRuntimeException));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JIllegalStateException', TypeInfo(Androidapi.JNI.JavaTypes.JIllegalStateException));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JInteger', TypeInfo(Androidapi.JNI.JavaTypes.JInteger));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JIterable', TypeInfo(Androidapi.JNI.JavaTypes.JIterable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JLong', TypeInfo(Androidapi.JNI.JavaTypes.JLong));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JPackage', TypeInfo(Androidapi.JNI.JavaTypes.JPackage));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JRunnable', TypeInfo(Androidapi.JNI.JavaTypes.JRunnable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JShort', TypeInfo(Androidapi.JNI.JavaTypes.JShort));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JStackTraceElement', TypeInfo(Androidapi.JNI.JavaTypes.JStackTraceElement));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JString', TypeInfo(Androidapi.JNI.JavaTypes.JString));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JStringBuffer', TypeInfo(Androidapi.JNI.JavaTypes.JStringBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JStringBuilder', TypeInfo(Androidapi.JNI.JavaTypes.JStringBuilder));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JThread', TypeInfo(Androidapi.JNI.JavaTypes.JThread));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JThread_State', TypeInfo(Androidapi.JNI.JavaTypes.JThread_State));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JThread_UncaughtExceptionHandler', TypeInfo(Androidapi.JNI.JavaTypes.JThread_UncaughtExceptionHandler));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JThreadGroup', TypeInfo(Androidapi.JNI.JavaTypes.JThreadGroup));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAnnotation', TypeInfo(Androidapi.JNI.JavaTypes.JAnnotation));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAccessibleObject', TypeInfo(Androidapi.JNI.JavaTypes.JAccessibleObject));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JConstructor', TypeInfo(Androidapi.JNI.JavaTypes.JConstructor));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JField', TypeInfo(Androidapi.JNI.JavaTypes.JField));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JGenericDeclaration', TypeInfo(Androidapi.JNI.JavaTypes.JGenericDeclaration));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JMethod', TypeInfo(Androidapi.JNI.JavaTypes.JMethod));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.Jreflect_Type', TypeInfo(Androidapi.JNI.JavaTypes.Jreflect_Type));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JTypeVariable', TypeInfo(Androidapi.JNI.JavaTypes.JTypeVariable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JBigInteger', TypeInfo(Androidapi.JNI.JavaTypes.JBigInteger));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JBuffer', TypeInfo(Androidapi.JNI.JavaTypes.JBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JByteBuffer', TypeInfo(Androidapi.JNI.JavaTypes.JByteBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JByteOrder', TypeInfo(Androidapi.JNI.JavaTypes.JByteOrder));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCharBuffer', TypeInfo(Androidapi.JNI.JavaTypes.JCharBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JDoubleBuffer', TypeInfo(Androidapi.JNI.JavaTypes.JDoubleBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFloatBuffer', TypeInfo(Androidapi.JNI.JavaTypes.JFloatBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JIntBuffer', TypeInfo(Androidapi.JNI.JavaTypes.JIntBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JLongBuffer', TypeInfo(Androidapi.JNI.JavaTypes.JLongBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JMappedByteBuffer', TypeInfo(Androidapi.JNI.JavaTypes.JMappedByteBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JShortBuffer', TypeInfo(Androidapi.JNI.JavaTypes.JShortBuffer));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JChannel', TypeInfo(Androidapi.JNI.JavaTypes.JChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAbstractInterruptibleChannel', TypeInfo(Androidapi.JNI.JavaTypes.JAbstractInterruptibleChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JSelectableChannel', TypeInfo(Androidapi.JNI.JavaTypes.JSelectableChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAbstractSelectableChannel', TypeInfo(Androidapi.JNI.JavaTypes.JAbstractSelectableChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JDatagramChannel', TypeInfo(Androidapi.JNI.JavaTypes.JDatagramChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFileChannel', TypeInfo(Androidapi.JNI.JavaTypes.JFileChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFileChannel_MapMode', TypeInfo(Androidapi.JNI.JavaTypes.JFileChannel_MapMode));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFileLock', TypeInfo(Androidapi.JNI.JavaTypes.JFileLock));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JPipe', TypeInfo(Androidapi.JNI.JavaTypes.JPipe));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JPipe_SinkChannel', TypeInfo(Androidapi.JNI.JavaTypes.JPipe_SinkChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JPipe_SourceChannel', TypeInfo(Androidapi.JNI.JavaTypes.JPipe_SourceChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JReadableByteChannel', TypeInfo(Androidapi.JNI.JavaTypes.JReadableByteChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JSelectionKey', TypeInfo(Androidapi.JNI.JavaTypes.JSelectionKey));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JSelector', TypeInfo(Androidapi.JNI.JavaTypes.JSelector));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JServerSocketChannel', TypeInfo(Androidapi.JNI.JavaTypes.JServerSocketChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JSocketChannel', TypeInfo(Androidapi.JNI.JavaTypes.JSocketChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JWritableByteChannel', TypeInfo(Androidapi.JNI.JavaTypes.JWritableByteChannel));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAbstractSelector', TypeInfo(Androidapi.JNI.JavaTypes.JAbstractSelector));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JSelectorProvider', TypeInfo(Androidapi.JNI.JavaTypes.JSelectorProvider));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCharset', TypeInfo(Androidapi.JNI.JavaTypes.JCharset));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCharsetDecoder', TypeInfo(Androidapi.JNI.JavaTypes.JCharsetDecoder));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCharsetEncoder', TypeInfo(Androidapi.JNI.JavaTypes.JCharsetEncoder));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCoderResult', TypeInfo(Androidapi.JNI.JavaTypes.JCoderResult));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCodingErrorAction', TypeInfo(Androidapi.JNI.JavaTypes.JCodingErrorAction));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAbstractCollection', TypeInfo(Androidapi.JNI.JavaTypes.JAbstractCollection));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAbstractList', TypeInfo(Androidapi.JNI.JavaTypes.JAbstractList));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAbstractMap', TypeInfo(Androidapi.JNI.JavaTypes.JAbstractMap));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JAbstractSet', TypeInfo(Androidapi.JNI.JavaTypes.JAbstractSet));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JArrayList', TypeInfo(Androidapi.JNI.JavaTypes.JArrayList));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JBitSet', TypeInfo(Androidapi.JNI.JavaTypes.JBitSet));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCalendar', TypeInfo(Androidapi.JNI.JavaTypes.JCalendar));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCollection', TypeInfo(Androidapi.JNI.JavaTypes.JCollection));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JComparator', TypeInfo(Androidapi.JNI.JavaTypes.JComparator));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JDate', TypeInfo(Androidapi.JNI.JavaTypes.JDate));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JDictionary', TypeInfo(Androidapi.JNI.JavaTypes.JDictionary));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JEnumSet', TypeInfo(Androidapi.JNI.JavaTypes.JEnumSet));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JEnumeration', TypeInfo(Androidapi.JNI.JavaTypes.JEnumeration));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JGregorianCalendar', TypeInfo(Androidapi.JNI.JavaTypes.JGregorianCalendar));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JHashMap', TypeInfo(Androidapi.JNI.JavaTypes.JHashMap));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JHashSet', TypeInfo(Androidapi.JNI.JavaTypes.JHashSet));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JHashtable', TypeInfo(Androidapi.JNI.JavaTypes.JHashtable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JIterator', TypeInfo(Androidapi.JNI.JavaTypes.JIterator));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JList', TypeInfo(Androidapi.JNI.JavaTypes.JList));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JListIterator', TypeInfo(Androidapi.JNI.JavaTypes.JListIterator));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JLocale', TypeInfo(Androidapi.JNI.JavaTypes.JLocale));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JMap', TypeInfo(Androidapi.JNI.JavaTypes.JMap));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.Jutil_Observable', TypeInfo(Androidapi.JNI.JavaTypes.Jutil_Observable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JObserver', TypeInfo(Androidapi.JNI.JavaTypes.JObserver));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JProperties', TypeInfo(Androidapi.JNI.JavaTypes.JProperties));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JQueue', TypeInfo(Androidapi.JNI.JavaTypes.JQueue));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JRandom', TypeInfo(Androidapi.JNI.JavaTypes.JRandom));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JSet', TypeInfo(Androidapi.JNI.JavaTypes.JSet));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JSortedMap', TypeInfo(Androidapi.JNI.JavaTypes.JSortedMap));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JTimeZone', TypeInfo(Androidapi.JNI.JavaTypes.JTimeZone));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JUUID', TypeInfo(Androidapi.JNI.JavaTypes.JUUID));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JBlockingQueue', TypeInfo(Androidapi.JNI.JavaTypes.JBlockingQueue));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCallable', TypeInfo(Androidapi.JNI.JavaTypes.JCallable));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JCountDownLatch', TypeInfo(Androidapi.JNI.JavaTypes.JCountDownLatch));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JExecutor', TypeInfo(Androidapi.JNI.JavaTypes.JExecutor));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JExecutorService', TypeInfo(Androidapi.JNI.JavaTypes.JExecutorService));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JFuture', TypeInfo(Androidapi.JNI.JavaTypes.JFuture));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JTimeUnit', TypeInfo(Androidapi.JNI.JavaTypes.JTimeUnit));
  //TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JSecretKey', TypeInfo(Androidapi.JNI.JavaTypes.JSecretKey));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JEGL', TypeInfo(Androidapi.JNI.JavaTypes.JEGL));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JEGL10', TypeInfo(Androidapi.JNI.JavaTypes.JEGL10));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JEGLConfig', TypeInfo(Androidapi.JNI.JavaTypes.JEGLConfig));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JEGLContext', TypeInfo(Androidapi.JNI.JavaTypes.JEGLContext));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JEGLDisplay', TypeInfo(Androidapi.JNI.JavaTypes.JEGLDisplay));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JEGLSurface', TypeInfo(Androidapi.JNI.JavaTypes.JEGLSurface));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JGL', TypeInfo(Androidapi.JNI.JavaTypes.JGL));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JGL10', TypeInfo(Androidapi.JNI.JavaTypes.JGL10));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JJSONArray', TypeInfo(Androidapi.JNI.JavaTypes.JJSONArray));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JJSONException', TypeInfo(Androidapi.JNI.JavaTypes.JJSONException));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JJSONObject', TypeInfo(Androidapi.JNI.JavaTypes.JJSONObject));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JJSONTokener', TypeInfo(Androidapi.JNI.JavaTypes.JJSONTokener));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JXmlPullParser', TypeInfo(Androidapi.JNI.JavaTypes.JXmlPullParser));
  TRegTypes.RegisterType('Androidapi.JNI.JavaTypes.JXmlSerializer', TypeInfo(Androidapi.JNI.JavaTypes.JXmlSerializer));
end;

initialization
  RegisterTypes;
end.


