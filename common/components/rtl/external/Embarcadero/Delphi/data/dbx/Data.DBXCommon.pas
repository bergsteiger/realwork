{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

/// <summary> DBX database driver framework </summary>
/// <remarks>
///  Design Goals.
///  <para>
///
///  Open.  Support for all popular database vendors.
///  </para>
///  <para>
///
///  Lightweight.  Emphasis on the most commonly needed database driver functionality
///  for a "set" oriented database application.
///  </para>
///  <para>
///
///  Versatile.  The DBX framework must be leveraged in a broad variety of
///  application contexts.  Managed, native, 32 bit and 64 bit platforms are
///  supported.  The dbExpress VCL has been greatly simplified by refactoring
///  to use the new DBX framework.  The DBX framework is easy to bridge to and
///  from ADO.NET.  Cross language support for both managed and native platforms,
///  for languages such as Object Pascal, C++, C# and Visual Basic.  Since the
///  framework is authored in Object Pascal, it is also now possible to create
///  100% Object Pascal drivers as well.
///  </para>
///  <para>
///
///  Performant.  Critical design goal is to ensure there are no significant
///  performance issues introduced by the framework.  The significant performance
///  issues should occur in the application, driver network protocol or the
///  database server itself.
///  </para>
///  <para>
///
///  Simple.  Nothing should be any more complicated than it needs to be.
///  In the initial development, this framework has been refactored many
///  times at various levels to simplify usage and overall organization.
///  </para>
///  <para>
///
///  Strongly typed.  A strongly typed framework is more reliable and in many
///  cases it is as performant or even more performant than a framework that
///  makes heavy use of pointers.  For example, on the .net platform, the pinvoke
///  layer can optimize marshaling of an integer parameter much better
///  than a pointer to an integer.  There are situations where processing data
///  as an array of bytes is more performant.  TDataSet's use of record buffers
///  is a good example of this.  For bulk read operations the DBX framework will
///  support a byte reader using byte arrays instead of pointers.  Array of byte
///  is safer and more portable  data structure than a pointer.
///  </para>
///  <para>
///
///  Inteface versioning.  Abstract base classes are used instead of Interfaces
///  for DBX to facilitate less brittle versioning of DBX.  Objects or value
///  types (packed records) are used for parameters of methods, events, and
///  constructors that could potentially need additional parameters in the future.
///  A dbx properties object is used for connection creation and
///  metadata constraint specification to make these interfaces less brittle and
///  more extensible.
///  </para>
///  <para>
///
///  Interface delegation.  All public methods of DBX classes are
///  virtual.  Public Property getter and setters are virtual methods and
///  not fields.  These two practices facilitate support of DBX delegation
///  drivers which are useful for driver profiling, tracing and auditing.
///  Another interesting application of driver delegation would be to create a
///  "thread safe" driver delegate. Such a delegate could provide thread
///  synchronized access to all public methods.
///  </para>
///  <para>
///
///  Thread safe.  Absolute thread safety is left to applications using DBX.
///  However, some thread safety issues are best handled by the DBX framework.
///  DBX thread safe operations include:
///    Loading and unloading of drivers.
///    Creation of connections
///  As mentioned above, a delegate Driver can be created to make the entire
///  public interface of DBX thread safe if needed.
///  </para>
///  <para>
///
///  Warning free.  No compiler warnings.
///  </para>
///  <para>
///
///  Driver loading.
///  </para>
///  <para>
///
///  If your application uses the DbExpress VCL, most everything should work the
///  way it always has.  Currently there is one exception.  The interface for native
///  drivers not written in pascal has changed.  The new interface is the
///  DynalinkExports.  DBX 3 used a weakly typed com based interface.  DBX4 is more
///  strongly typed (No pointers in the DBXCommon unit).  DBXDynalink uses a "flat export"
///  approach.  The use of flat exports will make it easier to version the interface going forward.
///  So for now there is a dbxadapter.dll that adapts any dbx3 driver to look like
///  a dbx4 driver.  Eventuallly the dbxadapter.dll will not be needed for native
///  deployments.  Managed deployments are a bit more trouble.  We use pinvoke
///  to call into native drivers on the .net platform.  Currently we use static
///  pinvoke to the dbxadapter.dll.  Dotnet 2 has better support for dynamic
///  pinvoke.  Eventually we will switch to this.  At that point dbxadapter.dll
///  will only be needed to connect to older dbx3 drivers.
///  </para>
///  <para>
///
///  The DBX4 driver can also statically or dynamically link drivers built as 100%
///  delphi packages.  The easiest way to link a driver package is to just include
///  it in a "uses" clause.  The driver loader will also load packages specified
///  in a config or ini file using the "LoadPackage" method.  This allows dynamic
///  loading of drivers that are never specified in a uses clause of any units
///  used by an applicaiton.  Note that the LoadPackage approach will only
///  be employed for applications that are built to use packages.
///  </para>
///  <para>
///
///  The DBXCommon unit contains base classes used by all DBX4 drivers.  Functionality
///  common to all drivers is implemented in DBXCommon.  Driver specific
///  functionality is implemented in classes that extend the DBXCommon classes and
///  implement the abstract virtual methods of the DBXCommon classes.
///  </para>
///  <para>
///
///  The DBXDynalink unit contains a DBX4 driver.
///  This driver delegates to non-pascal drivers that implement the DBXDynalinkExport
///  flat export interface discussed above.  DBXTrace is a delegate driver used for tracing.
///  The DbExpress VCL uses DBXCommon, DBXDynalink and DbxTrace as "default" drivers.
///  However this can be changed for statically linked applications
///  without modifying dbExpress vcl source code (SQLExpr.pas).  SQLExpr.pas uses
///  the unit DBXDefaultDrivers.  The DBXDefaultDrivers unit only contains a uses clause.
///  The DBXDefaultDrivers uses clause contains DBXCommon, DBXDynalink, and
///  DBXTrace.  DBXCommon must always be used.  However a statically linked
///  application could remove DBXTrace and replace DBXDynalink with a different
///  driver.
///  </para>
///  <para>
///
///  DBX4 driver writers will want to look at the initialization sections of
///  DBXDynalink and/or DBXTrace units.  These sections register themselves
///  with a singleton unit called the ClassRegistry.  The ClassRegistry is used
///  by the DBX4 driver loader to instantiate driver loader classes by name (a String).
///  The use of TPersistent was considered, however TPersistent is more for
///  streamable components.  The ClassRegistry is a simple, lightweight mechanism.
///  </para>
///  <para>
///
///
///  Areas subject to change/improve before the first release:
///  </para>
///  <para>
///
///  1) dbxadapter.dll will not be used for native apps, but will probably
///  be used for managed apps due to the use of static pinvoke.
///  </para>
///  <para>
///
///  2) The ability to link the existing c/c++ drivers statically into a delphi
///  app needs to be reenabled.  This can be done again.  Its just work.
///  </para>
/// </remarks>

unit Data.DBXCommon;

{$Z+}


interface

uses
  Data.DBXPlatform,
  System.Classes,
  System.IniFiles,
  System.SysUtils,
  Data.DBCommonTypes,
  Data.FMTBcd,
  Data.SqlTimSt,
  Data.DBXClassRegistry,
  Data.DBXJSON,
  System.SyncObjs,
  System.Generics.Collections
;

const

  DBXVersion25     = '2.5';
  DBXVersion30     = '3.0';
  DBXVersion40     = '4.0';

  ///<summary>
  ///  Default row buffering size to use for drivers that return true
  ///  for TDBXDatabaseMetaData.SupportsRowSetSize.
  ///  </summary>
  DBXDefaultRowSetSize  = 20;

{$IFDEF MACOS}
  LibraryPreferences = '/Library/Preferences/'; { Do not localize }
{$ENDIF}
  TDBXRegistryKey               = '\Software\Embarcadero\BDS\11.0\dbExpress'; { Do not localize }
  TDBXRegistryDriverValue       = 'Driver Registry File';           { Do not localize }
  TDBXRegistryConnectionValue   = 'Connection Registry File';   { Do not localize }

  TDBXDriverFile          = 'dbxdrivers.ini';            { Do not localize }
  TDBXConnectionFile      = 'dbxconnections.ini';    { Do not localize }

type

  // Forward declarations.
  //
  TDBXStreamReader = class;
  TDBXByteStreamReader = class;
  TDBXContext = class;
  TDBXValue = class;
  TDBXByteReader = class;
  TDBXConnection = class;
  TDBXDriverLoader = class;
  TDBXDelegateDriver = class;
  TDBXDelegateItem = class;
  TDBXConnectionFactory = class;
  TDBXDateValue = class;
  TDBXBooleanValue = class;
  TDBXTimeValue = class;
  TDBXWideStringValue = class;
  TDBXAnsiStringValue = class;
  TDBXAnsiMemoValue = class;
  TDBXWideMemoValue = class;
  TDBXUInt16Value = class;
  TDBXInt16Value = class;
  TDBXInt32Value = class;
  TDBXInt64Value = class;
  TDBXDoubleValue = class;
  TDBXByteArrayValue = class;
  TDBXTimeStampValue = class;
  TDBXBcdValue = class;
  TDBXRow = class;
  TDBXCommand = class;
  TDBXValueTypeList = class;
  TDBXConnectionBuilder = class;
  TDBXValueType = class;
  TDBXWritableValue = class;
  TDBXProperties = class;
  TDBXTransaction = class;
  TDBXDatabaseMetaData = class;
  TDBXPropertiesItem = class;
  TDBXDriver = class;
  TDBXParameterList = class;
  TDBXReader = class;
  TDBXParameter = class;
  TDBXCommandFactory = class;
  TDBXFormatter = class;
  TDBXJSONValue = class;
  TDBXCallbackValue = class;
  TX509Certificate = class;

  ///  <summary> Certificate validation callback signature</summary>
  ///  <param name="Owner">object that invoked the callback</param>
  ///  <param name="Certificate">X509 certificate</param>
  ///  <param name="ADepth">number of certificates to be validated</param>
  ///  <param name="Ok">boolean, expected to be true if the certificate is valid</param>
  TValidateCertificate = procedure(Owner: TObject; Certificate: TX509Certificate;
                                   const ADepth: Integer; var Ok: Boolean) of Object;


  TDBXSubDataTypes = class
    const
      ///<summary>Monetary sub type</summary>
      MoneySubType         = 21;

    { BLOB subtypes }

      ///<summary>8 bit char blob</summary>
      MemoSubType          = 22;
      ///<summary>Binary blob</summary>
      BinarySubType        = 23;
      ///<summary></summary>
//      SUB_TYPE_FMTMEMO       = 24;              { Formatted Text }
      ///<summary></summary>
//      SUB_TYPE_OLEOBJ        = 25;              { OLE object (Paradox) }
      ///<summary></summary>
//      SUB_TYPE_GRAPHIC       = 26;              { Graphics object }
      ///<summary></summary>
//      SUB_TYPE_DBSOLEOBJ     = 27;              { dBASE OLE object }
      ///<summary></summary>
//      SUB_TYPE_TYPEDBINARY   = 28;              { Typed Binary data }
      ///<summary></summary>
//      SUB_TYPE_ACCOLEOBJ     = 30;              { Access OLE object }
      ///<summary>Unicode blob</summary>
      WideMemoSubType      = 32;
      ///<summary>CLOB</summary>
      HMemoSubType         = 33;
      ///<summary>BLOB</summary>
      HBinarySubType       = 34;
      ///<summary>BFILE</summary>
      BFileSubType         = 36;

    { AnsiString / WideString subtype }

//      SUB_TYPE_PASSWORD      = 1;               { Password }

      ///<summary>Fixed length char</summary>
      FixedSubType         = 31;

      ///<summary>32 bit integer autoincrement</summary>
      AutoIncSubType       = 29;

      { ADT subtype }

      ///<summary>ADT for nested table (has no name)</summary>
      AdtNestedTableSubType = 35;

      ///<summary>DATE (OCIDate) with in an ADT</summary>
      AdtDateSubType       = 37;

      ///<summary>Oracle TimeStamp</summary>
      OracleTimeStampSubType  = 38;

      ///<summary>Oracle Interval</summary>
      OracleIntervalSubType   = 39;

      ///  <summary>Works in tandem with JSONValueType signaling the case where
      ///    user expects TObject instances (user types) and marshalling needs
      ///    to take place
      ///  </summary>
      UserSubType = 40;
  end;

  ///  <summary>Data types supported by DBX.</summary>
  TDBXDataTypes = class(TDBXSubDataTypes)
    const
      ///<summary></summary>
      UnknownType         = 0;
      ///<summary>8 bit Ansi String</summary>
      AnsiStringType         = 1;
      ///<summary>32 bit Date</summary>
      DateType            = 2;
      ///<summary>Blob with a subtype</summary>
      BlobType            = 3;
      ///<summary>16 big Boolean</summary>
      BooleanType            = 4;
      ///<summary>16 bit signed integer</summary>
      Int16Type           = 5;
      ///<summary>32 bit signed integer</summary>
      Int32Type           = 6;
      ///<summary>64 bit floating point</summary>
      DoubleType           = 7;
      ///<summary>TBcd decimal from the FMTBcd unit</summary>
      BcdType             = 8;               { BCD }
      ///<summary>Fixed length byte array</summary>
      BytesType           = 9;
      ///<summary>32 bit Time</summary>
      TimeType            = 10;
      ///<summary>TDateTime
      /// Internally managed as a <c>TDBXDataTypes.TimeStampType</c>
      ///</summary>
      DateTimeType           = 11;              { Time-stamp  (64 bit) }
      ///<summary>Unsigned 16 bit integer</summary>
      UInt16Type          = 12;
      ///<summary>Unsigned 32 bit integer</summary>
      UInt32Type          = 13;
//      ///<summary></summary>
//      FLOATIEEE       = 14;              { 80-bit IEEE float }
      ///<summary>Variable length byte array with maximum length of 64 kilobytes</summary>
      VarBytesType        = 15;
//      ///<summary></summary>
//      LOCKINFO        = 16;              { Look for LOCKINFO typedef }
      ///<summary>Oracle cursor type</summary>
      CursorType          = 17;
      ///<summary>64 bit integer</summary>
      Int64Type           = 18;
      ///<summary>unsigned 64 bit integer</summary>
      UInt64Type          = 19;
      ///<summary>Abstract data type</summary>
      AdtType             = 20;
      ///<summary>Array data type</summary>
      ArrayType           = 21;
      ///<summary>Reference data type</summary>
      RefType             = 22;
      ///<summary>Nested table data type</summary>
      TableType           = 23;
      ///<summary>TSQLTimeStamp in the SqlTimSt unit</summary>
      TimeStampType       = 24;
      ///<summary>Delphi Currency data type in System unit.
      ///  Internally managed as a <c>TDBXDataTypes.BCDType</c>
      ///</summary>
      CurrencyType        = 25;
      ///<summary>UCS2 unicode string</summary>
      WideStringType      = 26;

      ///<summary>32 bit floating point</summary>
      SingleType         = 27;

      ///<summary>8 bit signed integer</summary>
      Int8Type           = 28;
      ///<summary>8 bit unsigned integer</summary>
      UInt8Type          = 29;
      ///<summary>Object serialization</summary>
      ObjectType         = 30;
      ///<summary>Character array</summary>
      CharArrayType      = 31;
      ///<summary>Time Interval</summary>
      IntervalType       = 32;
      ///<summary>BinaryBlobType equivalent to <c>BlobType</c> with a
      ///<c>BinarySubType</c> sub type/
      ///</summary>
      BinaryBlobType       = 33;
      ///<summary>
      /// DBXConnection type for DataSnap server methods that receive or set the server side
      ///  connection.
      ///</summary>
      DBXConnectionType    = 34;
      ///<summary>
      /// Variant out or return parameter.  Not supported as a TDBXReader column.
      ///</summary>
      VariantType          = 35;
      TimeStampOffsetType   = 36;
      ///<summary>DBX type for a JSON value
      ///</summary>
      JsonValueType = 37;
      ///<summary>
      ///DBX type for a callback argument
      ///</summary>
      CallbackType  = 38;
      ///<summary>Maximum number of base types excluding sub types that
      ///  are supported by TDataSet type system.
      ///</summary>
      MaxBaseTypes  = 39;
  end;

  ///<summary>Type for TDBXDataTypes</summary>
  TDBXType = TInt32;
  ///<summary>Type for TDBXDataTypes.Date
  ///  Generally used as the Date portion of a TTimestamp which is defined as one plus
  ///  the number of days since 1/1/0001.
  ///</summary>
  TDBXDate  = type TInt32;
  ///<summary>Type for TDBXDataTypes.Date
  ///  Generally used as the Time portion of a TTimestamp which is defined as
  ///  the number of milliseconds since midnight.
  ///</summary>
  TDBXTime  = type TInt32;

///  <summary>Error codes for DBXError exceptions</summary>

  TDBXErrorCodes =  class
    const
      ///<summary>Successful completion.</summary>
      None                                = $0000;
      ///<summary>Non fatal warning.  Currently not used.</summary>
      Warning                             = $0001;
      ///<summary>Insuffucient memory to complete the operation.</summary>
      NoMemory                            = $0002;
      ///<summary>Field type is not supported by this driver.</summary>
      UnsupportedFieldType                = $0003;
      ///<summary>
      /// Unexpected internal error. DBX Object such as a connection,
      ///  command or reader may already be closed.
      ///</summary>
      InvalidHandle                       = $0004;
      ///<summary>
      ///  Unsupported feature for the driver in use.  Typical for unsupported
      ///  metadata related requests.
      ///</summary>
      NotSupported                        = $0005;
      ///<summary>Invalid value for a TDBXDataTypes.TIME field.</summary>
      InvalidTime                         = $0006;
      ///<summary>
      ///  Invalid value read operation attempted for a TDBXReader
      ///  or a TDBXParameter field.
      ///  Use a get method of the correct type for this field.
      ///</summary>
      InvalidType                         = $0007;
      ///<summary>
      ///  Ordinal used to access a DBXReader
      ///  column or a TDBXParameter is out of range.
      ///</summary>
      InvalidOrdinal                      = $0008;
      ///<summary>
      ///  Invalid use of a parameter.  Common causes include:  1) Parameter already
      ///  bound.
      ///  2) TDBXParameterDirections setting used is not supported by this driver.
      ///</summary>
      InvalidParameter                    = $0009;
      ///<summary>
      ////  Used internally by dynalink drivers to indicate that
      ///   a TDBXReader has no more rows.
      ///</summary>
      EoF                                 = $000A;
      ///<summary>
      ///  One or more parameters for a TDBXCommand has not been set.
      ///</summary>
      ParameterNotSet                     = $000B;
      ///<summary>User or the password provided for a TDBXConnection are not valid.</summary>
      InvalidUserOrPassword               = $000C;
      ///<summary>
      ///  Attempt to set a TDBXParameter with an invalid precision or
      ///  read a value with a TDBXDataTypes value that is not large enough.
      ///</summary>
      InvalidPrecision                    = $000D;
      ///<summary>
      ///  Unexpected error.  Insufficient storage provided to retrieve a TDBXParameter value.
      ///</summary>
      InvalidLength                       = $000E;
      ///<summary>
      ///  TDBXIsolations level used is not valid for this driver.
      ///</summary>
      InvalidIsolationLevel               = $000F;
      ///<summary>
      ///  Unexepected internal error.  Transaction
      ///  id is either expired or invalid.
      ///</summary>
      InvalidTransactionId                = $0010;
      ///<summary>
      ///  Unexepected internal error.  Transaction id is already in use by
      ///  an active transaction.
      ///</summary>
      DuplicateTransactionId              = $0011;
      ///<summary>
      ///  This driver is not available for the Delphi SKU purchased.
      ///</summary>
      DriverRestricted                    = $0012;
      ///<summary>
      ///  Operation cannot be completed with a transaction active for the
      ///  TDBXConnection.
      ///</summary>
      TransactionActive                   = $0013;
      ///<summary>
      ///  Support for multiple transactions is not enabled for this driver.
      ///</summary>
      MultipleTransactionNotEnabled       = $0014;
      ///<summary>
      ///  TDXConnection.Open connect operation failed.
      ///</summary>
      ConnectionFailed                    = $0015;
      ///<summary>
      ///  Driver could not be properly intialized.  Client library may be missing,
      ///  not installed properly, of the wrong version, or the driver may be missing from
      ///  the system path.
      ///</summary>
      DriverInitFailed                    = $0016;
      ///<summary>
      ///  Optimistic lock failed.  Oracle driver will return this for
      ///  "OCI-21700: object does not exist or is marked for delete"
      ///</summary>
      OptimisticLockFailed                = $0017;
      ///<summary>
      ///  Unexpected internal error accessing an Oracle REF object.
      ///</summary>
      InvalidReference                    = $0018;
      ///<summary>
      ///  Unexpected internal error accessing an Oracle REF object.
      ///</summary>
      NoTable                             = $0019;
      ///<summary>
      ///  Parametized query is missing a '?' parameter marker.
      ///</summary>
      MissingParameterMarker              = $001A;
      ///<summary>
      ///  Feature not implemented.
      ///</summary>
      NotImplemented                      = $001B;
      ///<summary>
      ///  Deprecated.  Driver is not compatible with version of VCL data access
      ///  components in use.  In the future this should be managed by the components
      ///  not the drivers.
      ///</summary>
      DriverIncompatible                  = $001C;
      ///<summary>
      ///  Argument used for an operation is invalid.
      ///</summary>
      InvalidArgument                     = $001D;
      ///<summary>
      ///  Attempted operation is invalid.
      ///</summary>
      InvalidOperation                    = $001E;
      ///<summary>
      ///  Unrecognized command type.
      ///</summary>
      UnrecognizedCommandType             = $001F;
      ///  <summary>Callback related errors
      ///  </summary>
      CallbackError                       = $0020;
      ///<summary>
      ///  Schema or user name separated by a '.' must be specified
      ///</summary>
      SchemaNameUnspecified               = $0021;
      ///<summary>
      ///  Database must be specified
      ///</summary>
      DatabaseUnspecified                 = $0022;
      ///<summary>
      ///  LibraryName must be specified
      ///</summary>
      LibraryNameUnspecified              = $0023;
      ///<summary>
      ///  GetDriverFunc must be specified
      ///</summary>
      GetDriverFuncUnspecified            = $0024;
      ///<summary>
      ///  VendorLib must be specified
      ///</summary>
      VendorLibUnspecified                = $0025;
      ///<summary>
      ///  Used internally by Dynalink drivers.  This is not an error.  It is used
      ///  to indicate that there either no more rows for a TDBXReader and also
      ///  to indicate that there is no more data when reading blob fields.
      ///</summary>
      NoData                              = $0064;
      ///<summary>
      ///  Max common errors.
      ///</summary>
      MaxCommonErrors                     = $0064;
      ///<summary>
      ///  Vendor specific error.
      ///</summary>
      VendorError                         = $0065;
      /// <summary> A server class with the same name has already been added to the server.
      /// </summary>
      ServerClassExists                   = $0066;
      /// <summary> A server method with the same name has already been added to the server.
      /// </summary>
      ServerMethodExists                  = $0067;
      /// <summary> A class with this name has not been added to the server class list.
      /// </summary>
      ServerClassMissing                  = $0068;
      /// <summary> A method with this name has not been added to the server method list.
      /// </summary>
      ServerMethodMissing                 = $0069;
     /// <summary>
     /// Invocation of server method failed.
     ///  </summary>
      ServerMethodFailed                  = $0070;
      /// <summary> A method with this name has not been added to the server method list.
      /// </summary>
      AuthorizationFailed                 = $0071;
  end;

  ///<summary></summary>
  TDBXErrorCode = TInt32;
  ///  <summary>Isolation levels supported by TDBXTransaction</summary>
//{$SCOPEDENUMS ON}
  TDBXIsolations       = class
    const
      ///<summary>
      /// Current transaction sees only changes that have been committed,
      /// but can receive an inconsistent view of the data if additional changes are committed before the transaction ends.
      ///</summary>
      ReadCommitted = 0;
      ///<summary>
      /// Current transaction is guaranteed a consistent view of the data,
      /// which includes only changes committed by other transactions at the start of the transaction.
      ///</summary>
      RepeatableRead = 1;
      ///<summary>
      /// Current transaction sees all changes made by other transactions,
      /// even if they have not yet been committed. This option is not available for the Oracle driver.
      ///</summary>
      DirtyRead = 2;
      ///<summary>
      /// Since DBX 4.
      /// Current transaction sees no changes made by other transactions including phantoms.
      ///</summary>
      Serializable = 3;
      ///<summary>
      /// Since DBX 4.
      /// Read only transaction that provides a transactionally consistent snapshot of the database.
      ///</summary>
      SnapShot = 4;
  end;
//{$SCOPEDENUMS OFF}
  TDBXIsolation = TInt32;

  ///  <summary>Parameter types supported by TDBXParameter</summary>
//{$SCOPEDENUMS ON}
  TDBXParameterDirections = class
    const
      ///<summary>
      /// The parameter type is unknown (generates an error).
      ///</summary>
        Unknown = 0;
      ///<summary>
      /// Input parameter.
      ///</summary>
        InParameter = 1;
      ///<summary>
      /// Output parameter.
      ///</summary>
        OutParameter = 2;
      ///<summary>
      /// Input/Output parameter.
      ///</summary>
        InOutParameter = 3;
      ///<summary>
      /// Return parameter.
      ///</summary>
        ReturnParameter = 4;
  end;
//{$SCOPEDENUMS OFF}
  TDBXParameterDirection = TInt32;

  ///<summary>Used internally by TDBXValuType bit fields.</summary>
  TDBXValueTypeFlags = class
    const
    ///<summary>Value is nullable</summary>
      Nullable        = $01;
    ///<summary>Value is read only</summary>
      ReadOnly        = $02;
    ///<summary>Value is searchable </summary>
      Searchable      = $04;
    ///<summary>Value is autoincrement</summary>
      AutoIncrement   = $08;
//    ///<summary>Value is exact blob</summary>
//      BlobSizeExact   = $10;
    ///<summary>Value type is readonly</summary>
      ReadOnlyType    = $20;
    ///<summary>Value type is hidden</summary>
      Hidden          = $40;
      /// <summary>
      ///   Used internally to indicate that most recent value types should
      ///   be used if applicable.  Only used by the most up to date driver
      ///   implementations since use of these types breaks old interfaces.
      ///  </summary>
      ExtendedType    = $80;
      ///  <summary>
      ///  Used internally to mark a server method in out parameter as being
      ///  a descendant of TDBXWritableValue.  These are nullable parameters
      ///  regardless of their type.
      ///  </summary>
      ValueParameter  = $100;
      ///  <summary>
      ///  Used to mark a parameter as being specified in the command text property
      ///  as a literal value.
      ///  </summary>
      Literal         = $200;
  end;

  ///<summary>
  ///
  ///</summary>
  ///<remarks> Better to use bits than a set because some drivers are written
  ///  in c/c++ </remarks>
  ///
  TDBXTraceFlags = class
    const
    ///<summary>Trace nothing.</summary>
      None        = $0000;
    ///<summary>prepared query statements</summary>
      Prepare     = $0001;
    ///<summary>executed query statements</summary>
      Execute     = $0002;
    ///<summary>errors</summary>
      Error       = $0004;
    ///<summary>command related operations.</summary>
      Command     = $0008;
    ///<summary>connect and disconnect</summary>
      Connect     = $0010;
    ///<summary>transaction commit, rollback</summary>
      Transact    = $0020;
    ///<summary>blob access</summary>
      Blob        = $0040;
    ///<summary>Miscellaneos</summary>
      Misc        = $0080;
    ///<summary>Vendor specific operations</summary>
      Vendor      = $0100;
    ///<summary>TDBXParamter access</summary>
      Parameter   = $0200;
    ///<summary>TDBXReader operations</summary>
      Reader      = $0400;
    ///<summary>Driver loading operations.</summary>
      DriverLoad = $0800;
    ///<summary>Meta data access operations.</summary>
      MetaData    = $1000;
    ///<summary>Driver operations.</summary>
      Driver      = $2000;
    ///<summary>Allow the trace handler to filter the <c>TDBXTraceEvent</c>.</summary>
      Custom      = $4000;
  end;
    ///<summary>Type used for TDBXTraceFlags</summary>
  TDBXTraceFlag = TInt32;
  ///<summary>
  ///
  ///</summary>
  ///<remarks> Better to use bits than a set because some drivers are written
  ///  in c/c++ </remarks>
  ///
  TDBXTraceLevels = class
    const
    ///<summary>Trace nothing.</summary>
      None      = 0;
    ///<summary>Debug trace</summary>
      Debug     = 1;
    ///<summary>Information tracing</summary>
      Info      = 2;
    ///<summary>Trace warnings</summary>
      Warn      = 3;
    ///<summary>Trace errors</summary>
      Error     = 4;
    ///<summary>Trace fatal errors</summary>
      Fatal     = 5;
    ///<summary>Trace for all levels</summary>
      Highest   = Fatal;
  end;
    ///<summary>Type used for TDBXTraceFlags</summary>
  TDBXTracelevel = TInt32;


  ///  <remarks> Common property names for both connections and drivers</remarks>
  TDBXPropertyNames = class
  const
    ///<summary>
    ///  Name of connection.  If connection properties are read from an ini file,
    ///  this is the ini file section name.
    ///  AdoDbxClient can use this property setting for a simple one property connection string.
    ///  Connection names can also be used to load a connection from a
    ///  TDBXConnectionFactory instance.
    ///</summary>
    ConnectionName              = 'ConnectionName';     { Do not localize }
    ///<summary>dbxdrivers.ini section that specifies what drivers are enabled.</summary>
    InstalledDrivers            = 'Installed Drivers';  { Do not localize }
    ///<summary>
    ///  Used by pre-DBX4 Dynalink drivers to specify exported entry point
    ///  for loading a pre-DBX4 driver.
    ///</summary>
    GetDriverFunc               = 'GetDriverFunc';      { Do not localize }
    ///<summary>
    ///  Used by Dynalink drivers.  Name of a vendor specific client library.
    ///</summary>
    VendorLib                   = 'VendorLib';          { Do not localize }
    ///<summary>
    ///  Used by Dynalink drivers.  Name of a 64-bit vendor specific client library.
    ///</summary>
    VendorLibWin64              = 'VendorLibWin64';          { Do not localize }
    ///<summary>
    ///  Used by Dynalink drivers.  Name of a vendor specific client library for Osx.
    ///</summary>
    VendorLibOsx                   = 'VendorLibOsx';          { Do not localize }
    ///<summary>
    ///  Currently only used by older linux versions of DbExpress to specify
    ///  localized error message file.
    ///</summary>
    ErrorResourceFile           = 'ErrorResourceFile';  { Do not localize }
    ///<summary>
    ///  Used by Dynalink drivers to specify the name of the Dynalink dll.
    ///</summary>
    LibraryName                 = 'LibraryName';        { Do not localize }
    ///<summary>
    ///  Used by Dynalink drivers to specify the name of the Dynalink dll for Osx.
    ///</summary>
    LibraryNameOsx                 = 'LibraryNameOsx';        { Do not localize }
    ///<summary>
    /// Unique name for a DBX driver.  Used by dbxconnections.ini to refer
    ///  to a connections driver in the dbxdrivers.ini file.
    ///</summary>
    DriverName                  = 'DriverName';         { Do not localize }
    ///<summary>
    ///  Hostname of a database server that a driver connects to.
    ///</summary>
    HostName                        = 'HostName';           { Do not localize }
    ///<summary>
    ///  String containing the Hostname/Server Name of a database that a driver connects to.
    ///</summary>
    DBHostName                        = 'DBHostName';           { Do not localize }
    ///<summary>
    ///  Port number of a database server that a driver connects to.
    ///</summary>
    Port                        = 'Port';               { Do not localize }
    ///<summary>
    ///  Name of a database to connect to.
    ///</summary>
    Database                    = 'Database';           { Do not localize }
    ///<summary>
    ///  Login user name used to connect to a database.
    ///</summary>
    UserName                    = 'User_Name';          { Do not localize }
    ///<summary>
    ///  Login password name used to connect to a database.
    ///</summary>
    Password                    = 'Password';           { Do not localize }
    ///<summary>
    ///  Connection string used to connect to a database
    ///</summary>
    ConnectionString            = 'ConnectionString';   { Do not localize }
    ///<summary>
    ///  Login role used to connect to a database.
    ///</summary>
    Role                        = 'Role';               { Do not localize }
    ///<summary>
    ///  Initial transaction isolation to use when connecting to a database.
    ///  Transaction isolation can also be specified when a transaction is
    ///  started.
    ///</summary>
    IsolationLevel              = 'IsolationLevel';     { Do not localize }
    ///<summary>
    /// Maximum blog size.  Set to -1 to specify no limit.
    ///</summary>
    MaxBlobSize                 = 'MaxBlobSize';        { Do not localize }
    ///<summary>
    /// Rowset size.  Default is 20.  Set to <= 0 to fetch all.
    ///</summary>
    RowSetSize                 = 'RowSetSize';        { Do not localize }
    ///<summary>
    ///  Delegate connection used by this connection.  Delegate connections
    ///  implement the DBX4 driver framework.  They can perform pre or post
    ///  processing of all public and protected methods, events and properties
    ///  before delegating to the real connection or another delegate connection.
    ///</summary>
    DelegateConnection          = 'DelegateConnection'; { Do not localize }
    ///  <remarks> Used to provide informative error message when driver cannot be loaded</remarks>
    DriverUnit                  = 'DriverUnit';         { Do not localize }
    ///  <summary>deprecated.  Preferable to just add the a comma plus the package
    ///   name to the end of the DriverPackageLoader property setting.
    ///  </summary>
    ///  <remarks> Used to load a native driver dynamically</remarks>
    DriverPackage               = 'DriverPackage';      { Do not localize }
    ///  <summary>deprecated.  Preferable to just add the a comma plus the assembly
    ///   name to the end of the DriverAssemblyLoader property setting.
    ///  </summary>
    ///  <remarks> Used to load a managed driver dynamically. </remarks>
    DriverAssembly              = 'DriverAssembly';      { Do not localize }
    ///  <summary>Comma separated class and package name.
    ///  </summary>
    ///  <remarks> Native Driver loader class used to load a native driver dynamically from a package</remarks>
    DriverPackageLoader         = 'DriverPackageLoader';      { Do not localize }
    ///  <summary>Comma separated class and package name.
    ///  </summary>
    ///  <remarks> Managed Driver loader class used to load a managed driver dynamically from an assembly </remarks>
    DriverAssemblyLoader        = 'DriverAssemblyLoader';      { Do not localize }
    ///<remarks>
    ///  Indicates that this driver is a delegate and can only be used in conjunction
    ///  with a non-delegate driver.
    ///</remarks>
    DelegateDriver              = 'DelegateDriver';      { Do not localize }
    /// <remarks>
    ///  Most applications should not need to use this property.
    ///  Provided for backwards compatibility of the dbExpress vcl.
    ///  The vcl components will use this setting to scope metadata requests.
    ///  This property should be set to [user-name].[override-schema-name].
    ///  For example, tables created by the MSSQL sa user are placed in the dbo
    ///  schema.  In this case SchemaOverride can be set to 'sa.dbo'.  This
    ///  will cause the vcl to specify the 'dbo' schema for metadata requests
    ///  when a connection is made using the 'sa' user.  SQL '%' like pattern
    ///  can also be used for the user-name and the override-schema-name.
    ///  For example, '%.%' would cause the schema to not be specified at
    ///  all for all users.
    ///</remarks>
    SchemaOverride              = 'SchemaOverride';      { Do not localize }
    ///  <remarks> Native MetaData loader class used to load a native driver dynamically from a package</remarks>
    MetaDataPackageLoader       = 'MetaDataPackageLoader';      { Do not localize }
    ///  <remarks> Managed MetaData loader class used to load a managed driver dynamically from an assembly </remarks>
    MetaDataAssemblyLoader      = 'MetaDataAssemblyLoader';      { Do not localize }
    ///<remarks>
    ///  Can be specified as a driver property as an override of the
    ///  <c>TDBXConnection.ProductVersion</c> property.  This may be necessary
    ///  for drivers that do not have the ability to report the product
    ///  version.
    ///  The ProductVersion is a number in the format nn.nn.nnnn
    ///</remarks>
    ProductVersion               = 'ProductVersion';      { Do not localize }
    ///<summary>
    ///  Provides the product name for the DBX4 metadata.
    ///  </summary>
    ProductName                  = 'ProductName';      { Do not localize }
    ///<summary>
    ///  When connecting to a DataSnap server, this is the name of a server method
    ///  that returns an instance of a TDBXConnection.  All sql and sql stored
    ///  procedure commands will be executed against this TDBXConnection instance.
    ///  This allows a client and server methods to share the same database connection
    ///  There is a built-in <c>DSAdmin.GetConnection</c> method that takes a single
    ///  input parameter which is the name of a connection in ther server side
    ///  dbxconnections.ini file and returns a TDBXConnection instance.  To
    ///  set the <c>ServerConnection</c> using this server method for a connection
    ///  called "myoracleconnection", set <c>ServerConnection</c> to
    ///  DSAdmin.GetConnection("myoracleconnection").  Alternatively
    ///  you can implement your own server method that returns a TDBXConnection
    ///  instance.
    ///  </summary>
    ServerConnection         = 'ServerConnection';      { Do not localize }

    ///<summary>
    ///  This allows a client to specify what indy implementation to use.
    ///  Default indy implementation will be used if left blank.
    ///  </summary>
    IPImplementationID = 'IPImplementationID';          { Do not localize }

    ///<summary>
    ///  can be passed to the <c>TDBXConnection.GetVendorProperty</c> method, to
    ///  determine if the driver supports parameter metadata.  If parameter metadata
    ///  is supported, then executing <c>TDBXCommand.Prepare</c> method will cause
    ///  the <c>TDBXCommand</c> parameter list to be automatically populated with
    /// parameters for the command.  Note that if the parameters were already
    ///  added to the command, parameters will not be automatically added.
    ///</summary>
    SupportsParameterMetadata = 'SupportsParameterMetaData';      { Do not localize }

    ///<summary>
    ///  Maximum time to wait for a new connection to be opened.  When the specified
    ///  time expires, an exception will be thrown.  Not all driver's support this
    ///  operation.
    ///  </summary>
    ConnectTimeout = 'ConnectTimeout';      { Do not localize }
    ///<summary>
    ///  Buffer size in kilobytes to use for client driver transport read and
    ///  write operations.  Currently used by DBXClient.
    ///  </summary>
    BufferKBSize = 'BufferKBSize';      { Do not localize }

    ///<summary>
    ///  If set to true, dynalink drivers will automatically unload their dll
    ///  when there are no longer any open connections that use the driver.
    ///  </summary>
    AutoUnloadDriver         = 'AutoUnloadDriver';      { Do not localize }

    ///<summary>
    ///  Protocol to use when connecting to a DataSnap Server (tcp/ip, http, https)
    ///  tcp/ip is used by default if unspecified.
    ///  </summary>
    CommunicationProtocol = 'CommunicationProtocol';   { Do not localize }

    ///<summary>
    ///  IPVersion to use through Indy when connecting to a DataSnap Server (IPv6, IPv4)
    ///  IPv4 is used by default if unspecified.
    ///  </summary>
    CommunicationIPVersion = 'CommunicationIPVersion'; { Do not localize }

    ///<summary>
    /// Specifies the path to a DataSnap Server Web Application.
    /// </summary>
    /// <remarks>
    /// Use this property to
    /// specify the virtual directory of a DataSnap Server ISAPI dll, for example.
    /// </remarks>
    URLPath = 'URLPath';  { Do not localize }

    ///<summary>
    ///  User name that is recognized by the DataSnap Server. This is a different
    ///  concept than a database user that is used for creating a database connection.
    ///</summary>
    DSAuthenticationUser = 'DSAuthenticationUser'; { Do not localize }

    ///<summary>
    ///  Password required for a DataSnap user to authenticate with the server.
    ///</summary>
    DSAuthenticationPassword = 'DSAuthenticationPassword'; { Do not localize }

    ///<summary>
    ///  Authentication scheme used to pass user and password to the server.
    ///</summary>
    DSAuthenticationScheme = 'DSAuthenticationScheme'; { Do not localize }

    ///<summary>
    ///  Maximum time to wait for a data packet to be exchange.  When the specified
    ///  time expires, an exception will be thrown.  Not all drivers support this
    ///  operation.
    ///  </summary>
    CommunicationTimeout = 'CommunicationTimeout';  { Do not localize }

    ///  <summary>
    ///    Key for filters configuration
    ///  </summary>
    Filters = 'Filters'; { Do not localize }

    /// <summary>key for URL path toward DS HTTP Service</summary>
    DatasnapContext = 'DatasnapContext';  { Do not localize }

    /// <summary>Host to proxy DataSnap requests through.</summary>
    DSProxyHost = 'DSProxyHost';  { Do not localize }

    /// <summary>Host's port to proxy DataSnap requests through.</summary>
    DSProxyPort = 'DSProxyPort';  { Do not localize }

    /// <summary>User name for proxy authentication.</summary>
    DSProxyUsername = 'DSProxyUsername';  { Do not localize }

    /// <summary>Password for proxy authentication.</summary>
    DSProxyPassword = 'DSProxyPassword';  { Do not localize }

    /// <summary>Displayed name of driver used in Data Explorer and Object Inspector</summary>
    DisplayDriverName = 'DisplayDriverName'; { Do not localize }
  end;


  ///<summary>The type of command to be executed by a command</summary>
  TDBXCommandTypes = class
    const
      ///<summary>Used for any SQL statement including selects, inserts, updates, deletes, etc</summary>
      DbxSQL                 = 'Dbx.SQL';
      ///<summary>Used for any stored procedure</summary>
      DbxStoredProcedure     = 'Dbx.StoredProcedure';
      ///<summary>Used to retrieve all rows an columns of a table</summary>
      DbxTable              = 'Dbx.Table';
      ///<summary>
      ///  Used to retrieve metadata of objects such as tables and columns
      ///  that are accessible from a <c>TDBXConnection</c>
      ///</summary>
      DbxMetaData            = 'Dbx.MetaData';
      ///<summary>deprecated.  Do not use.</summary>
      DbxCommand             = 'Dbx.Command';
      ///<summary>
      /// Command type for <c>TDBXPool</c> commands
      ///</summary>
      DbxPool               = 'Dbx.Pool'; { do not localize }
      ///<summary>
      /// Command type for DataSnap server method commands
      ///</summary>
      DSServerMethod        = 'DataSnap.ServerMethod';
  end;


  ///<summary>
  ///  List of "show" commands that can be executed when the <c>TDBXCommand.CommandType</c>
  ///  property is set to <c>TDBXCommandTypes.DBXMetadata</c>
  ///</summary>
  TDBXMetaDataCommands = class
    const
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetDatabase'.  When the command is executed
      ///  a <c>TDBXReader</c> instance is returned with a single row of database
      ///  specific metadata.
      ///</summary>
      GetDatabase                  = 'GetDatabase';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetDataTypes'.  When the command is executed
      ///  a <c>TDBXReader</c> instance is returned with metadata for the data
      ///  types supported by the driver.
      ///</summary>
      GetDataTypes                 = 'GetDataTypes';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetTables [[[catalog.]schema.]table [table-types]]'.
      ///  'table-types' is a space separated list of one or more of the constants
      ///  in <c>TDBXMetadataTypeTypes</c>.
      ///  When the command is executed
      ///  a <c>TDBXReader</c> instance is returned with metadata
      ///  for the specified table(s).
      ///</summary>
      GetTables                    = 'GetTables';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetColumns [[[catalog.]schema.]table]'.
      ///  When the command is executed
      ///  a <c>TDBXReader</c> instance is returned with metadata for the
      ///  columns of the specified table(s).
      ///</summary>
      GetColumns                   = 'GetColumns';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetForeignKeys [[[catalog.]schema.]table]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with metadata for the foreign keys of the specified table(s).
      ///</summary>
      GetForeignKeys               = 'GetForeignKeys';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetForeignKeyColumns [[[catalog.]schema.]table [foreign-key] [PrimaryKey|ForeignKey]]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with metadata for each column pair in the foreign keys of the specified table(s).
      ///</summary>
      GetForeignKeyColumns          = 'GetForeignKeyColumns';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetIndexes [[[catalog.]schema.]table]'.
      ///  When the command is executed
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with metadata for the indexes of the specified table(s).
      ///</summary>
      GetIndexes                   = 'GetIndexes';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetIndexColumns [[[catalog.]schema.]table [index]]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with metadata for the columns in the indexes of the specified table(s).
      ///</summary>
      GetIndexColumns              = 'GetIndexColumns';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetPackages [[[catalog.]schema.]package]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  metadata for the specified package(s).
      ///</summary>
      GetPackages                  = 'GetPackages';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetProcedures [[[catalog.]schema.]procedure [procedure-type]]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with metadata for the specified procedure(s).
      ///</summary>
      GetProcedures                = 'GetProcedures';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetProcedureParameters [[[catalog.]schema.]procedure]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with metadata for the parameters of the specified procedure(s).
      ///</summary>
      GetProcedureParameters       = 'GetProcedureParameters';
      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetUsers'.  When the command is executed
      ///  a <c>TDBXReader</c> instance is returned metadata for the
      ///  specified user(s).
      ///</summary>
      GetUsers                     = 'GetUsers';

      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetViews [[[catalog.]schema.]view]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with metadata for the view(s) specified.
      ///</summary>
      ///<remarks>DBX 4</remarks>
      GetViews                     = 'GetViews';

      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetSynonyms [[[catalog.]schema.]synonym]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with metadata for the synonym(s) specified.
      ///</summary>
      ///<remarks>DBX 4</remarks>
      GetSynonyms                  = 'GetSynonyms';

      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetCatalogs'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with a list of existings catalogs in the database.
      ///</summary>
      ///<remarks>DBX 4</remarks>
      GetCatalogs                  = 'GetCatalogs';

      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetSchemas [catalog]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with a list of existings schemas in the specified catalog(s).
      ///</summary>
      ///<remarks>DBX 4</remarks>
      GetSchemas                   = 'GetSchemas';

      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetProcedureSources [[[catalog.]schema.]procedure]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with the source of the specified procedure(s).
      ///</summary>
      ///<remarks>DBX 4</remarks>
      GetProcedureSources          = 'GetProcedureSources';

      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetPackageProcedures [[[[[catalog.]schema.]package].procedure] [procedure-type]]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with metadata for the specified package procedure(s).
      ///</summary>
      ///<remarks>DBX 4</remarks>
      GetPackageProcedures         = 'GetPackageProcedures';

      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetPackageProcedureParameters [[[[catalog.]schema.]package].procedure]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with metadata for the parameters of the specified package procedure(s).
      ///</summary>
      ///<remarks>DBX 4</remarks>
      GetPackageProcedureParameters = 'GetPackageProcedureParameters';

      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetPackageSources [[[catalog.]schema.]package]'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with the source of the specified package(s).
      ///</summary>
      ///<remarks>DBX 4</remarks>
      GetPackageSources            = 'GetPackageSources';

      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetRoles'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with a list of existings role(s).
      ///</summary>
      GetRoles                     = 'GetRoles';

      ///<summary>
      ///  Set <c>TDBXCommand.Text</c> to 'GetReservedWords'.
      ///  When the command is executed a <c>TDBXReader</c> instance is returned
      ///  with a list of reserved words for the database.
      ///</summary>
      GetReservedWords             = 'GetReservedWords';
  end;


  TDBXMetaDataKeyword = class
  const
    PrimaryKey = 'PrimaryKey';
    ForeignKey = 'ForeignKey';
  end;

  TDBXMetaDatabaseColumnNames = class
  const
    ///<summary>
    ///  deprecated.  Use <c>QuotePrefix</c> and <c>QuoteSuffix</c>
    ///</summary>
    QuoteChar                    = 'QuoteChar';
    ProcedureQuoteChar           = 'ProcedureQuoteChar';
    MaxCommands                  = 'MaxCommands';
    SupportsTransactions         = 'SupportsTransactions';
    SupportsNestedTransactions   = 'SupportsNestedTransactions';
    SupportsRowSetSize           = 'SupportsRowSetSize';
    ProductVersion               = 'ProductVersion';
    ProductName                  = 'ProductName';
    QuotePrefix                  = 'QuotePrefix';
    QuoteSuffix                  = 'QuoteSuffix';
    SupportsLowerCaseIdentifiers = 'SupportsLowerCaseIdentifiers';
    SupportsUpperCaseIdentifiers = 'SupportsUpperCaseIdentifiers';
    SupportsSPReturnCode         = 'SupportsSPReturnCode';
    SupportsParameterMetadata    = 'SupportsParameterMetadata';
    SupportsCatalogFunctions     = 'SupportsCatalogFunctions';
    SupportsCatalogs             = 'SupportsCatalogs';
    SupportsSchemas              = 'SupportsSchemas';
  end;



  ///<summary>
  ///  One or more of these contants may be passed to the 'GetTables' metadata
  ///  command.
  ///</summary>
  ///  <seeAlso>
  ///  <c>TDBXMetaDataCommands.Tables</c>
  ///  </seeAlso>
  TDBXMetaDataTableTypes = class
    const
      ///<summary>
      ///  Get tables.
      ///</summary>
      Table                    = 'Table';
      ///<summary>
      ///  Get Views
      ////</summary>
      View                     = 'View';
      ///<summary>
      ///  Get System tables
      ///</summary>
      SystemTable              = 'SystemTable';
      ///<summary>
      ///  Get synonyms
      ///</summary>
      Synonym                  = 'Synonym';
      ///<summary>
      ///  Get System views
      ///</summary>
      SystemView               = 'SystemView';
  end;


  ///<summary>
  ///  One or more of these contants may be passed to the 'GetProcedures' metadata
  ///  command.
  ///</summary>
  ///  <seeAlso>
  ///  <c>TDBXMetaDataCommands.Tables</c>
  ///  </seeAlso>
  TDBXMetaDataProcedureTypes = class
    const
      ///<summary>
      ///  Get procedures.
      ///</summary>
      ProcedureType            = 'Procedure';
      ///<summary>
      ///  Get functions.
      ////</summary>
      FunctionType             = 'Function';
  end;



  TDBXChars = array of Char;
  TWideStringArray = array of string;
  TDBXValueArray = array of TDBXValue;
  TDBXWritableValueArray = array of TDBXWritableValue;
  TDBXParameterArray = array of TDBXParameter;
  TDBXReaderArray = array of TDBXReader;

  ///<summary>
  ///  Exception type for all DBX errors.
  ///</summary>

  TDBXError = class(Exception)
    private
      FErrorCode:     TDBXErrorCode;
      FErrorMessage:  string;
    public
      constructor Create(ErrorCode: TDBXErrorCode; const ErrorMessage: string); overload;
      constructor Create(ErrorCode: TDBXErrorCode; const ErrorMessage: string; const InnerException: Exception); overload;
      ///<summary>
      ///  Convert known error codes to a String.
      ///</summary>
      class function ErrorCodeToString(ErrorCode: TDBXErrorCode): string; static;
      ///<summary>
      ///  TDBXErrorCode for this error.  See the const section of TDBXErrorCodes
      ///  for a list of common error codes with explanations.
      ///</summary>
      property ErrorCode: TDBXErrorCode read FErrorCode;
      ///<summary>
      ///  String containing an explanation of the error.
      ///</summary>
      property Message: string read FErrorMessage;
  end;

  ///<summary>
  ///  Event handler that can be set on the TDBXConnection.OnErrorEvent property
  ///  This event is called just before a TDBXError exception is raised.
  ///  This allows implementors to perform processing before the exception is
  ///  raised.  The DbExpress vcl components use this event to raise an exception
  ///  of a different type.
  ///</summary>
  TDBXErrorEvent = procedure(DBXError: TDBXError) of object;


  ///<summary>
  ///  TDBXTraceInfo is passed in to TDBXTraceEvent handlers.
  ///</summary>
  TDBXTraceInfo = packed record
    private
      FTraceMessage:        string;
      FTraceFlag:           TDBXTraceFlag;
      FTraceLevel:          TDBXTraceLevel;
      FCustomCategory:      string;
    public
      ///<summary>
      ///  Trace information for a trace TDBXTraceEvent.
      ///</summary>
      property Message: string read FTraceMessage write FTraceMessage;
      ///<summary>
      ///  One of TDBXTracFlag tracing categories for a TDBXTraceEvent.
      ///</summary>
      property TraceFlag: TDBXTraceFlag read FTraceFlag write FTraceFlag;
      ///<summary>
      ///  One of TDBXTracLevel tracing levels for a TDBXTraceEvent.
      ///</summary>
      property TraceLevel: TDBXTraceLevel read FTraceLevel write FTraceLevel;
      ///<summary>
      ///  Custom category used when <c>TDBXTraceFlag</c> set to <c>TDBXTraceFlags.Custom</c>
      ///</summary>
      property CustomCategory: string read FCustomCategory write FCustomCategory;
  end;

  ///<summary>
  ///  This event provides tracing information for DBX database drivers.
  ///  TDBXConnection has a TDBXTraceEvent property called OnTrace.
  ///  The TDBXTrace delegate uses this event to provide DBX framework level
  ///  tracing.
  ///</summary>
  TDBXTraceEvent = function (TraceInfo: TDBXTraceInfo): CBRType of object;

  /// <summary>An event procedure for use in an events collection.</summary>
  TEventPointer = procedure of object;

  /// <summary>A collection of event procedures.</summary>
  TEventsCollection = class
  private
    FEvents: TDictionary<string, TEventPointer>;
    function GetEvent(const AName: string): TEventPointer;
    procedure SetEvent(const AName: string; AValue: TEventPointer);
  public
    /// <summary>Creates a new instance of TEventsCollection.</summary>
    constructor Create;
    /// <summary>Frees resources and destroys the current instance.</summary>
    destructor Destroy; override;
    /// <summary>Replaces the events stored in this instance with the events of the given instance.
    /// </summary>
    procedure SetValues(Collection: TDictionary<string, TEventPointer>);
    /// <summary>Collection of events, accessible by name.</summary>
    property Events[const AName: string]: TEventPointer read GetEvent write SetEvent;
    /// <summary>Dictionary of all events.</summary>
    property AllEvents: TDictionary<string, TEventPointer> read FEvents;
  end;

  ///<summary>
  ///  Simple class to manage connection and driver level name/value pair
  ///  property settings.
  ///</summary>
  TDBXProperties = class(TPersistent)
  private
    [Weak]FDBXContext:        TDBXContext;
    FProperties:              TStrings;
    [Weak]FOwner:             TObject;
    [Weak]FComponentOwner:    TComponent;
    FOnChange: TNotifyEvent;
    FEvents: TEventsCollection;
    function GetValue(const Name: string): string;
    procedure SetValue(const Name, Value: string);
    function GetCount: Integer;
  protected
    procedure DoOnChange(Sender: TObject); virtual;
  public
    constructor Create(DBXContext: TDBXContext); overload; virtual;
    constructor Create; overload; virtual;
    ///<summary>
    ///  Get property value as a Boolean.
    ///</summary>
    function GetBoolean(const Name: string): Boolean;
    ///<summary>
    ///  Get property value as an Integer.
    ///</summary>
    function GetInteger(const Name: string): Integer;
    ///<summary>
    ///  Get property value as a string.  Throws an exception
    ///  if this TDBXProperties instance does not contain a property with the
    ///  given name.
    ///</summary>
    function GetRequiredValue(const Name: string): string;
    destructor Destroy; override;
    ///<summary>
    ///  Creates a new instance of TDBXProperties with a copy of the same name/value pairs
    ///</summary>
    function   Clone: TDBXProperties;
                                         
    procedure SetComponentOwner(AOwner: TComponent);
    function GetOwner: TPersistent; override;
    ///<summary>
    ///  Add the name/value pairs from List into this instance of TDBXProperties.
    ///</summary>
    procedure AddProperties(List: TStrings);
    ///<summary>
    ///  Add the name/value pairs from List into this instance of TDBXProperties
    /// if they don't already exist in this instance of TDBXProperties.
    ///</summary>
    procedure AddUniqueProperties(List: TStrings); overload;
    ///<summary>Update the property or insert a new one if it doesn't exist</summary>
    procedure MergeProperties(List: TStrings);
    ///<summary>
    ///  Set the semicolon separated name/value pairs from ConnectionString into
    ///  this instance of TDBXProperties.
    ///</summary>
    procedure SetProperties(const ConnectionString: string); overload;
    ///<summary>
    ///  Add a name/value pair.
    ///</summary>
    procedure Add(const Name, Value: string);
    ///<summary>
    ///  Get the Names and Values as two separate TWideStringArray lists.
    ///</summary>
    procedure GetLists(var Names, Values: TWideStringArray);
    ///<summary>
    /// Clears all stored properties
    ///</summary>
    procedure Clear;
    ///<summary>
    ///  String index property accessor.
    ///</summary>
    property Values[const Name: string]: string read GetValue write SetValue; default;
    ///<summary>
    ///  Get Name/Value pairs as a TStrings.
    ///</summary>
    property Properties: TStrings read FProperties;
    ///<summary>
    ///  Get the number of properties stored.
    ///</summary>
    property Count: Integer read GetCount;
    ///<summary>
    ///  Is triggered when the properties are changed.
    ///</summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    ///<summary>Collection of event procedures, stored by name.</summary>
    property Events: TEventsCollection read FEvents write FEvents;
  end;

  TDBXPropertiesClass = class of TDBXProperties;

  ///<summary>
  ///  Abstract base class used for creating new instances of <c>TDBXConnection</c>
  ///  <c>TDBXConnectionFactory.GetConnectionFactory</c> is a class static method
  ///  that returns a <c>TDBXConnectionFactory</c> singleton.  Currently this
  ///  singleton instance defaults to a <c>TDBXIniFileConnectionFactory</c>
  ///  The ini files are loaded from the file names specified under the
  ///   <c>HKEY_CURRENT_USER\TDBXRegistryKey</c> windows registry setting.  If this registry
  ///  key is not set, then the ini files are loaded from the location of
  ///  the application exe file.
  ///  <para>
  ///  A <c>TDBXConnectionFactory</c> manages a collection of named driver and
  ///  connection property sets.  A separate<c>TDBXProperties</c> object is
  ///  used for each driver and connection property set.  The driver properties
  ///  contain enough information to load and instantiate a driver implementation.
  ///  The connection properties include driver properties and contain enought
  ///  information to instantiate a connection.
  ///  </para>
  ///</summary>
  TDBXConnectionFactory = class
  private
    FDBXDefaultFormatter:  TDBXFormatter;

    class function  OpenConnectionFactory(const DriverFileName, ConnectionFileName: string): TDBXConnectionFactory;

    function CreateDelegatePath(const ConnectionName: string; DBXProperties: TDBXProperties): TDBXDelegateItem; overload;
    function CreateDelegatePath(const Prefix: string;
                                Depth: Integer;
                                DelegateItem:   TDBXDelegateItem;
                                DBXProperties: TDBXProperties): TDBXDelegateItem; overload;
    function HasConnectionPropertiesItem(const ConnectionName : string) : TDBXPropertiesItem;
    function GetConnectionPropertiesItem(const ConnectionName : string) : TDBXPropertiesItem;
    function CombineDriverProperties(ConProperties: TDBXProperties): TDBXProperties;

  private
    class var
      ConnectionFactorySingleton: TDBXConnectionFactory;
      FLock: TObject;
    var
      FDrivers:               TDictionary<string, TDBXProperties>;
      FConnectionProperties:  TDictionary<string, TDBXPropertiesItem>;

    function GetDriver(const DriverName: string; DriverProperties: TDBXProperties) : TDBXDelegateDriver; overload;
    function getDriverName(ConnectionProperties: TDBXProperties): string;

    function GetConnection(const DBXContext: TDBXContext;
      const ConnectionProperties: TDBXProperties): TDBXConnection; overload;
    function GetConnection( const DBXContext: TDBXContext;
                            const ConnectionName : string;
                            const UserName: string;
                            const Password: string) : TDBXConnection; overload;

  strict protected
    FDBXContext:  TDBXContext;

//    procedure CreateDelegatePaths;


  protected
    function  GetTraceInfoEvent: TDBXTraceEvent; virtual;
    procedure SetTraceInfoEvent(const TraceInfoEvent: TDBXTraceEvent); virtual;
    function  GetErrorEvent: TDBXErrorEvent; virtual;
    procedure SetErrorEvent(const ErrorEvent: TDBXErrorEvent); virtual;
    function  GetTraceFlags: TDBXTraceFlag; virtual;
    procedure SetTraceFlags(const TraceFlags: TDBXTraceFlag); virtual;

    procedure LoadDrivers; virtual;
    procedure LoadConnections; virtual;

    procedure DerivedOpen; virtual;
    procedure DerivedClose; virtual;

  public
    constructor Create;
    destructor Destroy; override;
    class constructor Create;
    class destructor Destroy;
    ///<summary>
    ///  Opens the factory making it ready for use.
    ///</summary>
    procedure Open; virtual;
    ///<summary>
    ///  Closes the factory.  A call to Close and then Open can be used to
    ///  reload the contents of a factory.
    ///</summary>
    procedure Close; virtual;

    ///  <summary>
    ///  Adds the names of all connections in the factory to the Items list.
    ///  </summary>
    procedure GetConnectionItems(Items: TStrings);
    procedure GetRegisteredDriverNames(DriverNames: TStringList);
    procedure GetDriverNames(Items: TStrings);


    ///<returns><c>TDBXProperties</c> instance of connection properties for <c>ConnectionName</c>, nil if connection not registered.</returns>
    function HasConnectionProperties(const ConnectionName : string) : TDBXProperties;
    ///<returns><c>TDBXProperties</c> instance of connection properties for <c>ConnectionName</c></returns>
    function GetConnectionProperties(const ConnectionName : string) : TDBXProperties;
    ///<returns><c>TDBXProperties</c> instance of driver properties for <c>DriverName</c></returns>
    function GetDriverProperties(const DriverName : string) : TDBXProperties;
    ///<returns><c>TDBXProperties</c> instance of driver properties for <c>DriverName</c>, nil if driver not registered.</returns>
    function HasDriverProperties(const DriverName : string) : TDBXProperties;
    ///<remarks>Call TDBXDriver.Free when the returned value is no longer needed.</remarks>
    ///<returns><c>TDBXDriver</c> instance for <c>DriverName</c></returns>
    function GetDriver(const DriverName : string) : TDBXDriver; overload;
    ///<remarks>Call TDBXDriver.Free when the returned value is no longer needed.</remarks>
    ///<remarks>Call TDBXDriver.Free when the returned value is no longer needed.</remarks>
    ///<returns><c>TDBXDriver</c> instance for <c>ConnectionName</c></returns>
    function GetConnectionDriver(const ConnectionName : string) : TDBXDelegateDriver; overload;
    ///<remarks>
    ///  Call TDBXConnection.Free when the returned value is no longer needed.
    ///  If <c>UserName</c> is set to an empty string,
    ///  then <c>ConnectionName</c>s associated <c>TDBXProperties</c> setting for
    ///  <c>TDBXPropertyNames.UserName</c> will be used.
    ///  If <c>Password</c> is set to an empty string,
    ///  then <c>ConnectionName</c>s associated <c>TDBXProperties</c> setting for
    ///  <c>TDBXPropertyNames.Password</c> will be used.
    ///</remarks>
    ///<returns><c>TDBXConnection</c> instance.</returns>
    function GetConnection( const ConnectionName : string;
                            const UserName: string;
                            const Password: string) : TDBXConnection; overload;
    ///<remarks>
    ///  Call TDBXConneciton.Free when the returned value is no longer needed.
    ///</remarks>
    ///<returns><c>TDBXConnection</c> instance.</returns>
    function GetConnection(ConnectionProperties : TDBXProperties) : TDBXConnection; overload;

    ///<summary>
    ///  This method can be called only once when an application is initialized
    ///  to change the default <c>TDBXConnectionFactory</c> singleton that
    ///  is returned by the class static <c>GetConnectionFactory</c> method.
    ///</summary>
    class procedure SetConnectionFactory(const ConnectionFactory: TDBXConnectionFactory); static;
    ///<returns>
    ///  The class static <c>TDBXConnectionFactory</c> singleton that can
    ///  be used to create new <c>TDBXConnection</c> instances.
    ///</returns>
    class function  GetConnectionFactory: TDBXConnectionFactory; static;
    class procedure Lock;
    class procedure Unlock;

    ///<summary>
    ///  The <c>TDBXErrorEvent</c> handler is called before a <c>TDBXError</c> exception is
    ///  raised.  This <c>TDBXErrorEvent</c> will be propagated to all <c>TDBXConnection</c>
    ///  and <c>TDBXDriver</c> instances created by this <c>TDBXConnectionFactory</c>
    ///</summary>
    ///<returns><c>TDBXErrorEvent</c> handler.</returns>
    property OnError: TDBXErrorEvent read GetErrorEvent write SetErrorEvent;
    ///<summary>
    ///  The <c>TDBXTraceInfoEvent</c> handler is called for driver trace events
    ///  This <c>TDBXTraceInfoEvent</c> will be propagated to all <c>TDBXConnection</c>
    ///  and <c>TDBXDriver</c> instances created by this <c>TDBXConnectionFactory</c>
    ///</summary>
    ///<returns><c>TDBXTraceInfoEvent</c> handler.</returns>
    property OnTrace: TDBXTraceEvent read GetTraceInfoEvent write SetTraceInfoEvent;
    ///<returns>The <c>TDBXTraceFlags</c> that tracing should be enabled for.</returns>
    property TraceFlags: TDBXTraceFlag read GetTraceFlags write SetTraceFlags;
//    property ConnectionFactory: TDBXConnectionFactory read GetConnectionFactory write SetConnectionFactory;
    ///<summary>
    /// The TDBXFormatter instance used to parse and format string representations
    ///  for <c>TDBXDate</c>, <c>TDBXTime</c>, <c>TSqlTimeStamp</c>, and <c>TBcd</c> values
    ///  using the "As" properties of <c>TDBXValue</c> and <c>TDBXWritableValue</c>.
    ///  The <c>TDBXConnectionFactory</c> provides a default implementation of
    ///  <c>TDBXFormatter</c> for all connections.
    ///</summary>
    ///<returns>The default formatter used for connection created by this factory.</returns>
    property DBXFormatter: TDBXFormatter read FDBXDefaultFormatter write FDBXDefaultFormatter;

  end;


  ///<summary>
  ///  Implementation of <c>TDBXConnectionFactory</c> that loads driver
  ///  and connection properties from the dbxdrivers.ini and dbxconnections.ini
  ///  files.
  ///</summary>
  TDBXIniFileConnectionFactory = class(TDBXConnectionFactory)
  private
    FConnectionsFile:   string;
    FDriversFile:       string;

    function LoadSectionProperties(IniFile: TMemIniFile; Section: string;
                                      LoadConnection: Boolean) : TDBXProperties;
    function LoadDriver(DriverIni: TMemIniFile; const DriverName: string) : TDBXProperties;

  protected
    procedure LoadDrivers; override;
    procedure LoadConnections; override;
  public
    constructor Create;
//    class function LoadIniFile(FileName: string): TMemIniFile; static;
    destructor Destroy; override;
    ///  <summary>
    ///  Adds the names of all Drivers in the factory to the Items list.
    ///  </summary>
    procedure GetDriverItems(Items: TStrings);
    ///<returns>File name for the drivers ini file.</returns>
    property DriversFile: string read FDriversFile write FDriversFile;
    ///<returns>File name for the connections ini file.</returns>
    property ConnectionsFile: string read FConnectionsFile write FConnectionsFile;
  end;


  ///<summary>
  ///  Implementation of <c>TDBXConnectionFactory</c> that does not
  ///  loads driver and connection properties.  Used by vcl when
  ///  the dbxconnections.ini and dbxdrivers.ini files cannot be found.
  ///</summary>
  TDBXMemoryConnectionFactory = class(TDBXConnectionFactory)
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TDBXCreateCommandEvent = function (DbxContext: TDBXContext; Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand of object;

  TDBXCreateCommand = class
  private
    FOnCreateCommand: TDBXCreateCommandEvent;
  end;

  TDBXDriverClass = class of TDBXDriver;

  ///<summary>
  ///  Used by driver implementors.
  ///  Collection of parameters needed when loading a driver.  By collecting
  ///  these in a single record, parameters can be added without necessarily
  ///  breaking older drivers.
  ///</summary>
  TDBXDriverDef = packed record
    FDriverName:        string;
    FDriverProperties:  TDBXProperties;
    FDBXContext:        TDBXContext;
  end;

  ///<summary>
  ///  Driver class for DBX framework.  Loads client libraries if needed.
  ///  <para>
  ///  The DBX framework manages reference counts for all drivers that are
  ///  loaded.  When all <c>TDBXConnection</c> and <c>TDBXDriver</c> instances
  ///  are freed, the driver is unloaded.  So if an application holds on to
  ///  an instance of TDBXConnection or TDBXDriver, that driver will not
  ///  be unloaded.
  ///  </para>
  ///</summary>
  TDBXDriver = class
  private
    FDriverName:              string;
    FReferenceCount:          TInt32;
    FDriverProperties:        TDBXProperties;
    FMetaDataCommandFactory:  TDBXCommandFactory;
    FCachedUntilFinalization: Boolean;
    procedure AddReference;
    procedure RemoveReference;

    procedure UncacheAtFinalization;
  strict protected
    procedure CacheUntilFinalization;
  protected
    [Weak]FDBXContext:              TDBXContext;
    FDriverLoader:            TDBXDriverLoader;
    FCommandFactories:        TDictionary<string, TDBXCreateCommand>;

    function  GetDriverProperties: TDBXProperties; virtual;
    procedure InitDriverProperties(const DriverProperties: TDBXProperties); virtual;
    function  GetDriverName: string; virtual;
    procedure SetDriverName(const DriverName: string); virtual;

    ///<summary>
    /// Used by TDBXConnectionFactory to create instances of TDBXConnection.
    ///</summary>
    function  CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection; virtual; abstract;
    procedure Close; virtual; abstract;
    function  CreateMorphCommand(DbxContext: TDBXContext; Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand; virtual;
    procedure LoadMetaDataCommandFactory(const MetaDataCommandFactoryClassName: string; const MetaDataCommandFactoryPackageName: string);
    procedure AddCommandFactory(const Name: string; OnCreateCommand: TDBXCreateCommandEvent); overload;
    procedure AddCommandFactory(const Name: string; CommandFactory: TDBXCommandFactory); overload;
  public
    ///<summary>
    ///  Used by drivers that use the newer <c>TDBXDriverRegistry.RegisterDriverClass</c>.
    ///  Virtual constructor.
    ///</summary>
    constructor Create(DriverDef: TDBXDriverDef); overload; virtual;
    ///<summary>
    ///  Used by drivers that use the older <c>TClassRegistry.GetClassRegistry.RegisterRegistryClass</c>
    ///  Non-virtual constructor.
    ///</summary>
    constructor Create; overload;
    ///<summary>
    /// Returns a list of driver level properties.  All other published properties
    /// should be "connection default" properties.
    ///</summary>
    procedure GetDriverPropertyNames(List: TStrings); virtual;
    ///<summary>
    /// Returns class reference for this driver.  Useful when working
    /// with an instance of TDBXDriverDelegate to ensure the class reference
    /// of the acutual driver being delegated is retrieved.
    ///</summary>
    function GetDriverClass: TClass; virtual;
    destructor Destroy; override;
    ///<summary>
    /// Returns version information for this driver.
    ///</summary>
    function GetDriverVersion: string; virtual; abstract;
    ///<summary>
    ///  Returns a unique name for this driver.
    ///</summary>
    property DriverName: string Read GetDriverName write SetDriverName;
    ///<summary>
    ///  Returns a driver specific properties for this TDBXDriver instance.
    ///</summary>
    property DriverProperties: TDBXProperties read GetDriverProperties;
    ///<summary>
    /// Returns version information for this driver.
    ///</summary>
    property DriverVersion: string read GetDriverVersion;

  end;

  TDBXStateItem = class
    public
      procedure Close; virtual; abstract;
  end;

  TDBXStateItemList = class
    public
      destructor Destroy; override;
      function GetStateItem(Name: string): TDBXStateItem;
      procedure AddStateItem(Name: string; Item: TDBXStateItem);
      procedure RemoveAndFreeStateItem(Name: string);
  end;
  ///<summary>
  ///  Connection for the DBX framework.  Provides support for creating
  ///  commands, retrieving database related metadata and transaction
  ///  management.
  ///</summary>
  TDBXConnection = class
  private
    FDriverDelegate:                TDBXDriver;
    FTransactionStack:              TDBXTransaction;
    FDatabaseMetaData:              TDBXDatabaseMetaData;
    FOpen:                          Boolean;

    FProductVersion:                string;
    FProductVersionInitialized:     Boolean;
    FMetaDataReader:                TObject;
    FCommands:                      TList<TDBXCommand>;

    procedure CheckTransaction(Transaction: TDBXTransaction);
    procedure FreeTransactions(StartTransaction: TDBXTransaction);

    procedure AddCommand(Command: TDBXCommand);
    procedure RemoveCommand(Command: TDBXCommand);

  strict protected
    FIsolationLevel:    TDBXIsolation;

  protected
    FDBXContext:       TDBXContext;
    FConnectionProperties : TDBXProperties;

    procedure CloseAllCommands;
    procedure RollbackAllTransactions;
    function  CreateAndBeginTransaction(const Isolation: TDBXIsolation): TDBXTransaction; virtual; abstract;
    procedure Commit(const Transaction: TDBXTransaction); virtual; abstract;
    procedure Rollback(const Transaction: TDBXTransaction); virtual; abstract;

    // protected virtual property accessors that can be delegated
    // by a descendent.
    //
    function  GetDatabaseMetaData: TDBXDatabaseMetaData; virtual;
    function  GetConnectionProperties: TDBXProperties; virtual;
    procedure SetConnectionProperties(const Value: TDBXProperties); virtual;
    function  GetTraceInfoEvent: TDBXTraceEvent; virtual;
    procedure SetTraceInfoEvent(const TraceInfoEvent: TDBXTraceEvent); virtual;
    function  GetTraceFlags: TDBXTraceFlag; virtual;
    procedure SetTraceFlags(const TraceFlags: TDBXTraceFlag); virtual;
    function  GetErrorEvent: TDBXErrorEvent; virtual;
    procedure SetErrorEvent(const ErrorEvent: TDBXErrorEvent); virtual;
    function  GetDBXFormatter: TDBXFormatter; virtual;
    procedure SetDBXFormatter(const DBXFormatter: TDBXFormatter); virtual;
    function  GetIsOpen: Boolean; virtual;
    procedure Open; virtual;

    function  DerivedCreateCommand: TDBXCommand; virtual;
    procedure DerivedOpen; virtual; abstract;
    procedure DerivedGetCommandTypes(const List: TStrings); virtual; abstract;
    procedure DerivedGetCommands(const CommandType: string; const List: TStrings); virtual; abstract;
    procedure DerivedClose; virtual; abstract;


    function  CreateMorphCommand(MorphicCommand: TDBXCommand): TDBXCommand; virtual;
    ///<summary>
    ///  Drivers should return an empty string if this is not implemented.
    ///  Otherwise the return value should be in the format specified
    ///  in the documentation for <c>TDBXConnection.ProductVersion</c>
    ///  This property can also be overriden by setting the
    ///  <c>TDBXPropertyNames.ProductVersion</c> connection property.
    ///  <seeAlso>
    ///  <c>TDBXDatabaseMetadata.ProductVersion</c>  This is the method applications
    ///  should use to obtain the product version.
    ///  </seeAlso>
    ///  </summary>
    function GetProductVersion: string; virtual;

    function GetProductName: string; virtual;

    function GetConnectionProperty(const Name: string): string; virtual;

    constructor Create(ConnectionBuilder:  TDBXConnectionBuilder);

  public
    destructor Destroy; override;
    ///<summary>
    ///  Closes the connection and any associated resources.  Normally this is
    ///  called by the destructor.
    ///</summary>
    procedure Close; virtual;

    ///<remarks>
    ///  When the work for the transaction is complete, call <c>CommitAndFree</c>,
    ///  <c>RollbackAndFree</c>, or <c>RollbackIncompleteAndFree</c>.
    ///</remarks>
    ///<returns> <c>TDBXTransaction</c> instance for the new transaction</returns>
    function  BeginTransaction(Isolation: TDBXIsolation): TDBXTransaction; overload; virtual;
    ///<remarks>
    ///  When the work for the transaction is complete, call <c>CommitAndFree</c>,
    ///  <c>RollbackAndFree</c>, or <c>RollbackIncompleteAndFree</c>.
    ///</remarks>
    ///<returns> <c>TDBXTransaction</c> instance for the new transaction</returns>
    function  BeginTransaction: TDBXTransaction; overload; virtual;
    ///<summary>
    ///  Commits the work for the <c>Transaction</c>.  Any active transactions
    ///  that were begun after this transaction will be freed and effectively
    ///  committed as well.  The var <c>Transaction</c> instance is set to nil.
    ///</summary>
    ///<exception>Raises an exception if <c>Transaction</c> is not an active transaction</exception>
    procedure CommitFreeAndNil(var Transaction: TDBXTransaction); virtual;
    ///<summary>
    ///  Commits the work for the <c>Transaction</c> on the top of the stack.
    ///</summary>
    procedure CommitTransaction; virtual;
    ///<summary>
    ///  Rollbacks the work for the <c>Transaction</c>.  Any active transactions
    ///  that were begun after this transaction will be freed and effectively
    ///  rolledback as well.  The var <c>Transaction</c> instance is set to nil.
    ///</summary>
    ///<exception>Raises an exception if <c>Transaction</c> is not an active transaction</exception>
    procedure RollbackFreeAndNil(var Transaction: TDBXTransaction); virtual;
    ///<remarks>
    ///  Unlike <c>RollbackFreeAndNil</c> procedure, this procedure does not
    ///  throw an exception if <c>Transaction</c> is invalid or set to nil.
    ///  This method is ideally used in a finally (or except) block.  The try block will
    ///  use either <c>CommitFreeAndNil</c> or <c>RollbackFreeAndNil</c>,
    ///  the <c>Transaction</c> will have already been completed, freed
    ///  and set to nil.  If an exception is not raised in the try block,
    ///  a call to <c>RollbackIncompleteAndFree</c> in the finally block
    ///  will do nothing because the <c>Transaction</c> instance is no longer
    ///  valid.  If an exception is raised, then a call to <c>RollbackIncompleteAndFree</c>
    ///  in the finally block will rollback, free and nill the <c>Transaction</c>
    ///  instance.
    ///</remarks>
    ///<summary>
    ///  Rollbacks the work for the <c>Transaction</c>.  Any active transactions
    ///  that were begun after this transaction will be freed and effectively
    ///  rolledback as well.  The var <c>Transaction</c> instance is set to nil.
    ///</summary>
    procedure RollbackIncompleteFreeAndNil(var Transaction: TDBXTransaction); virtual;
    ///<summary>
    ///  Rolls back the work for the <c>Transaction</c> on the top of the stack.
    ///</summary>
    procedure RollbackTransaction; virtual;
    ///<remarks>
    ///  Default <c>CommandType</c> property setting is <c>TDBXCommandTypes.SQLStatement</c>.
    ///  Call <c>Free</c> when the <c>TDBXCommand</c> is no longer needed.
    ///</remarks>
    ///<returns>A <c>TDBXCommand</c> that can be used to execute commands.</returns>
    function CreateCommand: TDBXCommand; overload; virtual;
    ///<summary>
    ///  Populates the list will the supported command types for this connection.
    ///  <c>TDBXCommandTypes</c> provides constant names for the most common
    ///  command types.
    ///</summary>
    procedure GetCommandTypes(List: TStrings);
    ///<summary>
    ///  Populates the list with the known commands for <c>CommandType</c>
    ///</summary>
    procedure GetCommands(const CommandType: string; List: TStrings);
    ///  <summary>
    ///  Driver vendors can implement this method to provide driver specific
    ///  property access.  Returns an empty string if not implemented.
    ///  Currently used by <c>GetProductVersion</c> to obtain the product
    ///  version.
    ///  </summary>
    function GetVendorProperty(const Name: string): string; virtual;
    ///  <summary>
    ///    Returns whether the Transaction instance is on the transaction stack
    ///  </summary>
    function HasTransaction(Transaction: TDBXTransaction): Boolean;
    ///<returns>
    ///  <c>TDBXProperties</c> containing connection properties used to create
    /// this connection.
    ///</returns>
    property ConnectionProperties: TDBXProperties read GetConnectionProperties write SetConnectionProperties;
    ///<returns>
    ///  <c>TDBXDatabaseMetaData</c> instance for this connection.
    ///</returns>
    property DatabaseMetaData: TDBXDatabaseMetaData read GetDatabaseMetaData;
    ///<returns>
    ///  Event handler used for receiving trace events.
    ///</returns>
    property OnTrace: TDBXTraceEvent read GetTraceInfoEvent write SetTraceInfoEvent;
    ///<returns>
    ///  Trace flags that can be used to enable or disable tracing categories.
    ///</returns>
    property TraceFlags: TDBXTraceFlag read GetTraceFlags write SetTraceFlags;
    ///<returns>
    ///  Error handling event that will be called just before any DBX
    ///  <c>TDBXError</c> exception is raised.
    ///</returns>
    property OnErrorEvent: TDBXErrorEvent read GetErrorEvent write SetErrorEvent;
    ///<returns>
    ///  Is this connection open.
    ///</returns>
    property IsOpen: Boolean read GetIsOpen;
    ///<summary>
    /// The TDBXFormatter instance used to parse and format string representations
    ///  for <c>TDBXDate</c>, <c>TDBXTime</c>, <c>TSqlTimeStamp</c>, and <c>TBcd</c> values
    ///  using the "As" properties of <c>TDBXValue</c> and <c>TDBXWritableValue</c>.
    ///  The <c>TDBXConnectionFactory</c> provides a default implementation of
    ///  <c>TDBXFormatter</c> for all connections.
    ///</summary>
    ///<returns>
    /// TDBXFormatter instance used by this connection.
    ///</returns>
    property DBXFormatter: TDBXFormatter read GetDBXFormatter write SetDBXFormatter;
    ///  <summary>
    ///  Return empty string if not implemented.  Otherwise a
    ///  string is returned with the format ##.##.#### where the first two digits are
    ///  the major version, the second two digits are the minor version,
    ///  and the last four digits are the release version.  This value
    ///  can be overridden by setting the <c>TDBXPropertyNames.ProductVersion</c>
    ///  connection property.
    ///  </summary>
    property ProductVersion: string read GetProductVersion;
    ///<summary>
    ///  Provide product name if supported.
    /// The default implementation will look at the <c>TDBXPropertyNames.ProductName</c>
    /// driver property first.  It will Call <c>GetVendorProperty</c> second.
    /// <c>TDBXPropertyNames.DriverName</c> property will be used as a last resort.
    ///  </summary>
    property ProductName: string read GetProductName;
    ///  <summary>
    ///  Returns the value of a property used when the connection was opened.
    ///  </summary>
    property ConnectionProperty[const Name: string]: string read GetConnectionProperty;

//    property MetaDataReader: TObject read FMetaDataReader write FMetaDataReader;

  end;


  ///<summary>
  ///  A <c>TDBXTransaction</c> is created by calling <c>TDBXConnection.BeginTransaction</c>
  ///  <c>TDBXConnection.CommitFreeAndNil</c>, <c>TDBXConnection.RollbackFreeAndNil</c>,
  ///  or <c>TDBXConnection.RollbackIncompleteFreeAndNil</c> must be called to complete
  ///  a transaction.  The <c>TDBXIsolation</c> transaction isolation level can be set
  ///  when the transaction is begun.  <c>TDBXConnection.TDBXDatabaseMetadata.SupportsTransactions</c>
  ///  must be true for an application to be able to use transactions.
  ///  Nested transactions can be used if <c>TDBXConnection.TDBXDatabaseMetadata.SupportsTransactions</c>
  ///  is true.
  ///</summary>
  TDBXTransaction = class
    private
      FNext:        TDBXTransaction;
      [Weak]FConnection:  TDBXConnection;
    strict protected
      FIsolationLevel:    TDBXIsolation;
    protected
      constructor Create(Connection:  TDBXConnection);
    public
  ///<returns>
  ///  The <c>TDBXConnection</c> instance that created this <c>TDBXTransaction</c> instance.
  ///</returns>
    property Connection: TDBXConnection read FConnection;
  end;

  ///<summary>
  ///  <c>TDBXDatabaseMetadata</c> provides convenient access to common
  ///  database specific metadata.  This metadata can also be retrieved
  ///  by creating a <c>TDBXCommand</c> with a <c>TDBXCommandType.DbxMetadata</c>
  ///  setting the <c>TDBXCommand.Text</c> property to 'GetDatabase' and then
  ///  calling <c>TDBXCommand.ExecuteQuery</c>.  For most applications it is
  ///  more efficient to retrieve this metadata from <c>TDBXDatabaseMetaData</c>
  ///  because <c>TDBXDatabaseMetadata</c> executes the 'GetDatabase' command once
  ///  and caches the retrieved metadata.
  ///</summary>
  TDBXDatabaseMetaData = class
  private
    FQuoteChar:                     string;
    FProcedureQuoteChar:            string;
    FSupportsTransactions:          Boolean;
    FSupportsNestedTransactions:    Boolean;
    FMaxCommands:                   TInt32;
    FSupportsRowSetSize:            Boolean;
    FQuotePrefix:                   string;
    FQuoteSuffix:                   string;
    FSupportsLowerCaseIdentifiers:  Boolean;
    FSupportsUpperCaseIdentifiers:  Boolean;
    FSupportsSPReturnCode:          Boolean;
    FMetaDataVersion:               string;
    FSupportsParameterMetadata:     Boolean;
    FSupportsCatalogFunctions:      Boolean;
    FSupportsCatalogs:              Boolean;
    FSupportsSchemas:               Boolean;

    procedure Init(Connection: TDBXConnection);

  protected
    [Weak]FDBXContext:           TDBXContext;
    constructor Create(DBXContext: TDBXContext);
  public

    ///<summary>
    ///  deprecated.  Use <c>QuotePrefix</c> and <c>QuoteSuffix</c>
    ///</summary>
    ///<returns>Quote character used for quoting identifiers in the TDBXCommand.Text property.</returns>
    property QuoteChar: string read FQuoteChar;
    ///<returns>Quote character used for quoting identifiers for stored procedures in the TDBXCommand.Text property.</returns>
    property ProcedureQuoteChar: string read FProcedureQuoteChar;
    ///<returns>Does the driver support transactions.</returns>
    property SupportsTransactions: Boolean read FSupportsTransactions;
    ///<returns>Does the driver support nested transactions.</returns>
    property SupportsNestedTransactions: Boolean read FSupportsNestedTransactions;
    ///<returns>Maximum number of commands that can be created.</returns>
    property MaxCommands: TInt32 read FMaxCommands;
    ///<returns>Is <c>TDBXCommand.RowSetSize</c> property supported to control row buffering when executing queries.</returns>
    property SupportsRowSetSize: Boolean read FSupportsRowSetSize;
    ///<returns>Character to start a quoted identifier.</returns>
    property QuotePrefix: string read FQuotePrefix;
    ///<returns>Character to end a quoted identifier.</returns>
    property QuoteSuffix: string read FQuoteSuffix;
    ///<returns>Lowercase identifiers are stored in lowercase characters on the database.</returns>
    property SupportsLowerCaseIdentifiers: Boolean read FSupportsLowerCaseIdentifiers;
    ///<returns>Uppercase identifiers are stored in uppercase characters on the database.</returns>
    property SupportsUpperCaseIdentifiers: Boolean read FSupportsUpperCaseIdentifiers;
    ///<returns>Returns DBX version of metadata supported.
    ///Curently this value is either <c>DBXVersion30</c> or <c>DBXVersion40</c>.
    ///</returns>
    property MetaDataVersion: string read FMetaDataVersion;
    ///<returns>Returns true if the stored procedures can return an integer code</returns>
    property SupportsSPReturnCode: Boolean read FSupportsSPReturnCode;
    ///<returns>Does the driver support parameter metadata</returns>
    property SupportsParameterMetadata: Boolean read FSupportsParameterMetaData;
    ///<returns>Does the driver use catalog functions rather than metadata queries</returns>
    property SupportsCatalogFunctions: Boolean read FSupportsCatalogFunctions;
    ///<returns>Does the driver support catalogs</returns>
    property SupportsCatalogs: Boolean read FSupportsCatalogs;
    ///<returns>Does the driver support schemas</returns>
    property SupportsSchemas: Boolean read FSupportsSchemas;
  end;



  ///<summary>
  ///  <c>TDBXCommand</c> is typically used to execute sql statements and
  ///  stored procedures.  The desired command to execute is specfied with
  ///  the <c>TDBXCommand.Text</c> property.  Parameters can be added and
  ///  accessed through the <c>TDBXCommand.Parameters</c> property.
  ///  Parameters can be created by calling the <c>TDBXCommand.CreateParameter</c> method.
  ///  <c>TDBXCommand</c> can alo be used to execute other types of commands.
  ///  <c>TDBXCommandTypes</c> contains constants for common command types.
  ///  Because the command type is represented as a String, Driver implementations
  ///  can use this as a namespace to create additional types of commands.
  ///  For example, the <c>TDBXPool</c> delegate driver has a command type that allows
  ///  a command to return a <c>TDBXReader</c> with information on the
  ///  active connection pools.
  ///  <c>TDBXCommand</c> instances can be created by calling one of the
  ///  <c>TDBXConnection.CreateCommand</c> methods.  As soon as an application
  ///  is finished using a command, the <c>TDBXCommand.Free</c> method
  ///  must be called.  This will release the memory for the command and
  ///  any associated resources.
  ///</summary>
  TDBXCommand = class
  private
    FCommandType:       string;
    FText:              string;
    [Weak]FLastReader:  TDBXReader;
    FOpen:              Boolean;
    FPrepared:          Boolean;
    FCommandTimeout:    Integer;
    [Weak]FConnection:  TDBXConnection;
    FConnectionClosed:  Boolean;
    FFreeOnCloseList:   TList<TObject>;

    procedure CommandExecuting;
    procedure CommandExecuted;
    procedure SetParameters;
    procedure ConnectionClosing;
    procedure FreeOnExecuteObjects;        

  strict protected
    FParameters:      TDBXParameterList;

    procedure NotImplemented;


  protected
    [Weak]FDBXContext: TDBXContext;

    constructor Create(DBXContext: TDBXContext);
    procedure CloseReader; virtual;
    procedure SetCommandType(const CommandType: string); virtual;
    function  GetCommandType: string; virtual;
    function  GetText: string; virtual;
    procedure SetText(const Value: string); virtual;

    procedure SetRowSetSize(const RowSetSize: Int64); virtual; abstract;
    procedure SetMaxBlobSize(const MaxBlobSize: Int64); virtual; abstract;
    function  GetRowsAffected: Int64; virtual; abstract;
    procedure SetCommandTimeout(const Timeout: Integer); virtual;
    function  GetCommandTimeout: Integer; virtual;

    function  GetErrorEvent: TDBXErrorEvent; virtual;
    function  CreateParameterRow: TDBXRow; virtual;
    procedure CreateParameters(Command: TDBXCommand); virtual;
    function  GetParameters: TDBXParameterList; virtual;
    procedure Open; virtual;

    function  DerivedGetNextReader: TDBXReader; virtual; abstract;
    procedure DerivedOpen; virtual; abstract;
    procedure DerivedClose; virtual; abstract;
    procedure DerivedPrepare; virtual; abstract;
    function  DerivedExecuteQuery: TDBXReader; virtual; abstract;
    procedure DerivedExecuteUpdate; virtual; abstract;
    procedure DerivedClearParameters; virtual;

  public

    destructor Destroy; override;
    ///<summary>
    ///  Register an arbitrary object with the command to be freed the next time
    ///  the command is executed or closed or freed.
    ///</summary>
    procedure FreeOnExecute(Value: TObject); virtual;
    ///<summary>
    ///  Close the command and any associated resources.  Normally called
    ///  by the destructor.
    ///</summary>
    procedure Close; virtual;

    ///<summary>
    ///  This method should be called before calling any of the <c>Execute*</c>
    ///  methods.
    ///  If no parameters have been setup, the driver supports parameter metadata,
    ///  and the dynamic sql statement contains parameters, prepare will setup
    ///  the command's parameters.
    ///</summary>
    procedure Prepare; virtual;
    ///<summary>
    ///  Executes a command that returns an instance of <c>TDBXReader</c>.
    ///  methods.  As soon as an application is done with a reader, the
    ///  <c>TDBXReader.Free</c> method should be called to free up resources.
    ///</summary>
    function  ExecuteQuery: TDBXReader; virtual;
    ///<summary>
    ///  Executes a command that performs an update operation.
    ///</summary>
    procedure ExecuteUpdate; virtual;
    ///<summary>
    ///  For commands that return more then one reader.
    ///</summary>
    ///<returns>The next instance of <c>TDBXReader</c>.  If there are no more <c>TDBXReader</c> instances, nil is returned.</returns>
    function  GetNextReader: TDBXReader; virtual;
    ///<summary>
    ///  Create a parameter that can be added to the <c>Parameters</c> list.
    ///</summary>
    ///<returns>Allocates a new instance of <c>TDBXParameter</c>.</returns>
    function  CreateParameter: TDBXParameter; virtual;

    ///<returns>
    /// The number of rows updated from the last call to <c>ExecuteUpdate</c>.
    ///</returns>
    property RowsAffected: Int64 read GetRowsAffected;

    ///<summary>
    ///  command to execute.  when <c>CommandType</c> is set to
    ///  <c>TDBXCommandTypes.SQLStatement</c>, <c>Text</c> can be set to
    ///  sql statements such as select, insert, update, and delete.
    ///</summary>
    property Text: string read GetText write SetText;
    ///<summary>
    ///  Row buffering property used to optimize reading data from <c>TDBXReader</c> instances.
    ///  returned from <c>ExecuteQuery</c>
    ///  Only takes affect for database vendors that return true from the
    ///  <c>TDBXDataBaseMetadata.SupportsRowSetSize</c> property.
    ///</summary>
    property RowSetSize: Int64 write SetRowSetSize;
    ///<summary>
    ///  Set the maximum blob size allowed for <c>TDBXReader</c> instances
    ///  returned from <c>ExecuteQuery</c>.
    ///</summary>
    property MaxBlobSize: Int64 write SetMaxBlobSize;
    ///<summary>
    ///  Typically set to one of the constant strings specified in
    ///  <c>TDBXCommandTypes</c>.  However, driver implmentors can
    ///  used this property as a namespace to create new types of commands.
    ///</summary>
    property CommandType: string read GetCommandType write SetCommandType;
    ///<summary>
    ///  Get the <c>TDBXParametersList</c> list of parameters that will
    ///  be used to get and set parameters for <c>Text</c> commands that
    ///  contain '?' parameter markers.
    ///</summary>
    property Parameters: TDBXParameterList read GetParameters;
    ///<summary>
    ///  Get the error handling event provide by the <c>TDBXConnection</c>
    ///  that created this command.
    ///</summary>
    property OnErrorEvent: TDBXErrorEvent read GetErrorEvent;
    ///<returns>
    /// true if this has been prepared.
    ///</returns>
    property IsPrepared: Boolean read FPrepared;
    /// <summary> Timeout value for the execution of a command.
    ///  </summary>
    ///  <remarks>
    ///  Not all drivers support this.  Time in seconds to wait for
    ///  a command to execute.
    ///  </remarks>
    property CommandTimeout: Integer read GetCommandTimeout write SetCommandTimeout;

  end;

  /// <summary>
  ///  Used by driver implementations to morphing from one command type
  ///  to another through delegation.
  /// </summary>
  TDBXMorphicCommand = class(TDBXCommand)
  strict protected
    [Weak]FConnection:      TDBXConnection;
    FCommand:         TDBXCommand;
    FRowSetSize:      Int64;
    FMaxBlobSize:     Int64;

    procedure CopyProperties(Command: TDBXCommand);

  protected
    function  GetRowsAffected: Int64; override;
    procedure SetCommandType(const Value: string); override;
    procedure SetText(const Value: string); override;
    function  CreateParameterRow: TDBXRow; override;
    function  GetParameters: TDBXParameterList; override;
    procedure CreateParameters(Command: TDBXCommand); override;

    procedure SetMaxBlobSize(const MaxBlobSize: Int64); override;
    procedure SetRowSetSize(const Value: Int64); override;
    procedure DerivedOpen; override;
    procedure DerivedClose; override;

    function  DerivedGetNextReader: TDBXReader; override;
    function  DerivedExecuteQuery: TDBXReader; override;
    procedure DerivedExecuteUpdate; override;
    procedure DerivedPrepare; override;
    procedure CloseReader; override;

  public
    constructor Create(DBXContext: TDBXContext; Connection: TDBXConnection);
    destructor Destroy; override;

    procedure FreeOnExecute(Value: TObject); override;
    procedure Prepare; override;
    function  ExecuteQuery: TDBXReader; override;
    procedure ExecuteUpdate; override;
    function  GetNextReader: TDBXReader; override;
  end;


  TDBXValueList = class
  private
    FValues:      TDBXWritableValueArray;
    FValueCount:  TInt32;
    FLastOrdinal: TInt32;
    FClosed:      Boolean;
    function FindOrdinal(const Name: string; const StartOrdinal, EndOrdinal: TInt32): TInt32; overload; virtual;
    procedure InvalidOrdinal(const Ordinal: TInt32);
    procedure InvalidName(const Name: string; const Ordinal: TInt32);
  strict protected
    [Weak]FDBXContext:  TDBXContext;

    procedure FailIfClosed;
    property DBXContext: TDBXContext read FDBXContext;
  protected
    procedure ClearValues;
    procedure SetValues(const Values: TDBXValueArray); overload; virtual;
    procedure SetValues(const Values: TDBXWritableValueArray); overload; virtual;
    procedure SetValues(const Values: TDBXWritableValueArray; const Count: Integer); overload; virtual;
    function GetValue(const Ordinal: TInt32): TDBXValue; virtual;
    function GetValueByName(const Name: string): TDBXValue; virtual;
    function GetValueType(const Ordinal: TInt32): TDBXValueType; virtual;

    function GetColumnCount: TInt32; virtual;
  public
    constructor Create(DBXContext: TDBXContext);
    destructor Destroy; override;
    ///<summary>
    ///  Must call <c>Next</c> at least once for this property to
    ///  return a meaningful result.
    ///  <returns>true if there are no more rows</returns>
    ///</summary>
    property Closed: Boolean read FClosed;

    ///  <returns>Ordinal position in the <c>Value</c> array property for the <c>Name</c> column.</returns>
    function GetOrdinal(const Name: string): TInt32; overload; virtual;

    ///  <returns>Number of columns that can be accessed from the <c>Value</c> array property.</returns>
    property ColumnCount: TInt32 read GetColumnCount;

    ///  <returns>Returns the instance of <c>TDBXValueType</c> at the <c>Ordinal</c> position.</returns>
    property ValueType[const Ordinal: TInt32]: TDBXValueType read GetValueType;
//    property ValueType[const Name: string]: TDBXValueType read GetValueTypeByName; overload;
    property Values: TDBXWritableValueArray read FValues;
  end;

  TDBXWritableValueList = class(TDBXValueList)
  protected
    function GetWritableValue(const Ordinal: TInt32): TDBXWritableValue; virtual;
//    function GetWritableValueByName(const Name: string): TDBXWritableValue; virtual;
  public
    constructor Create(DBXContext: TDBXContext);

    ///  <returns>Returns the instance of <c>TDBXValue</c> at the <c>Ordinal</c> position.</returns>
    property Value[const Ordinal: TInt32]: TDBXWritableValue read GetWritableValue; default;
    ///  <returns>Returns the instance of <c>TDBXValue</c> at the <c>Name</c> position.</returns>
//    property Value[const Name: string]: TDBXWritableValue read GetWritableValueByName; default;


end;

  ///<summary>
  ///  <c>TDBXReader</c> is returned from <c>TDBXCommand.ExecuteQuery</c>.
  ///  <c>TDBXReader</c> provides a forward only cursor throw a collection
  ///  or rows.  Call the <c>TDBXReader.Next</c> method to access the first
  ///  and successive rows in the collection.  When an application is no longer needs a <c>TDBXReader</c> instance
  ///  it should call the <c>TDBXReader.Free</c> method.  This will ensure that all resources associated
  ///  with the <c>TDBXReader</c> are released.
  ///  <para>
  ///  Row values can be accessed using the <c>TDBXReaderValue</c> array property.
  ///  This <c>TDBXReader.Value</c> property is overloaded so that it can be
  ///  indexed either by ordinal position or by column name.
  ///  </para>
  ///</summary>
  TDBXReader = class(TDBXValueList)
  private
    FByteReader:    TDBXByteReader;
    [Weak]FCommand: TDBXCommand;

    procedure   CommandCloseReader;
    procedure   CloseReader;
  strict protected
    FDbxRow:      TDBXRow;

    function  GetErrorEvent: TDBXErrorEvent;
  protected
    constructor Create(DBXContext: TDBXContext; DbxRow: TDBXRow; ByteReader: TDBXByteReader);

    function  DerivedNext: Boolean; virtual; abstract;
    procedure DerivedClose; virtual; abstract;

    function GetByteReader: TDBXByteReader; virtual;
    function GetReaderHandle: Integer; virtual;
    function IsUpdateable: Boolean; virtual;
    function GetRowHandle: Integer; virtual;
    ///<summary>Returns the active row from the reader</summary>
    function GetRow: TDBXRow;
  public
    destructor Destroy; override;
    ///<summary>
    ///  Closes TDBXReader and releases all resources.  TDBXReader cannot be used
    ///  again after this method is called. Most applications should just free
    ///  the reader to close the TDBXReader.
    ///</summary>
    procedure Close;

    ///<summary>
    ///  This method must be called to navigate to the first and successive
    ///  rows.
    ///  <returns>false then there are no more rows</returns>
    ///</summary>
    function Next: Boolean; virtual;

    ///<summary>
    ///  Position the reader before the first row.
    ///  <returns>true if this operation is supported and the reader can complete
    ///  the operation.  Some readers may only be able to support this operation
    ///  for small row sets.
    /// </returns>
    ///</summary>
    function Reset: Boolean; virtual;

    ///<returns>
    ///  Return the object type name for ADT and Array Types.
    ///  The Oracle driver supports these data types.
    ///</returns>
    function GetObjectTypeName(Ordinal: TInt32): string; virtual;
    ///  <returns>Ordinal position in the <c>Value</c> array property for the <c>Name</c> column.</returns>
//    function GetOrdinal(Name: string): TInt32; overload; virtual;

    ///<summary>
    ///  Used by TDataSet to read values from a byte array instead
    ///  of as distinct scalar values.
    ///  <returns><c>TDBXByteReader</c></returns>
    ///</summary>
    property ByteReader: TDBXByteReader read GetByteReader;

    ///  <returns><c>TDBXErrorEvent</c> error handling event for this <c>TDBXReader</c>.</returns>
    property OnErrorEvent: TDBXErrorEvent read GetErrorEvent;
    ///<summary>
    ///  Unique id for this reader.
    ///  </summary>
    property RowHandle: Integer read GetRowHandle;
    ///<summary>
    ///  Indicates if this reader contains data that can be edited and saved back to
    ///  the original source.
    ///  </summary>
    property Updateable: Boolean read IsUpdateable;

    ///  <returns>Returns the instance of <c>TDBXValue</c> at the <c>Ordinal</c> position.</returns>
    property Value[const Ordinal: TInt32]: TDBXValue read GetValue; default;
    ///  <returns>Returns the instance of <c>TDBXValue</c> at the <c>Name</c> position.</returns>
    property Value[const Name: string]: TDBXValue read GetValueByName; default;
  end;


  ///<summary>
  ///  Metadata for TDBXReader columns and TDBXParameter parameters.
  ///</summary>
  TDBXValueType = class
  private
    FName:                string;
    FCaption:             string;
    FOrdinal:             TInt32;
    FDataType:            TDBXType;
    FSubType:             TDBXType;
    FSize:                Int64;
    FPrecision:           Int64;
    FScale:               TInt32;
    FChildPosition:       TInt32;
    FFlags:               TInt32;
    FParameterDirection:  TDBXParameterDirection;
  private
    [Weak]FDbxRow:            TDBXRow;

    function IsNullable: Boolean;
    function IsReadOnly: Boolean;
    function IsSearchable: Boolean;
    function IsAutoIncrement: Boolean;
//      function IsBlobSizeExact: Boolean;
    function IsReadOnlyType: Boolean;
  strict protected
    [Weak]FDBXContext:        TDBXContext;
  protected
    procedure SetDbxRow(const DbxRow: TDBXRow); virtual;

    procedure SetParameterDirection(const ParameterDirection: TDBXParameterDirection); virtual;

    procedure SetName(const Name: string); virtual;
    procedure SetDisplayName(const Caption: string); virtual;
    procedure SetOrdinal(const Ordinal: TInt32); virtual;
    procedure SetDataType(const DataType: TDBXType); virtual;
    procedure SetSubType(const SubType: TDBXType); virtual;
    procedure SetPrecision(const Precision: Int64); virtual;
    procedure SetScale(const Scale: TInt32); virtual;
    procedure SetChildPosition(const ChildPosition: TInt32); virtual;
    procedure SetFlags(const Flags: TInt32); virtual;
    procedure SetNullable(const NullableValue: Boolean); virtual;
    procedure SetSize(const Size: Int64); virtual;
    procedure SetHidden(const Hidden: LongBool); virtual;
    procedure SetValueParameter(const ValueParameter: Boolean); virtual;
    procedure SetLiteral(const Literal: Boolean); virtual;

    function  GetParameterDirection: TDBXParameterDirection; virtual;
    function  GetName: string; virtual;
    function  GetDisplayName: string; virtual;
    function  GetOrdinal: TInt32 ; virtual;
    function  GetDataType: TDBXType; virtual;
    function  GetSubType: TDBXType; virtual;
    function  GetPrecision: Int64; virtual;
    function  GetScale: TInt32; virtual;
    function  GetChildPosition: TInt32; virtual;
    function  GetFlags: TInt32; virtual;
    function  GetSize: Int64; virtual;
    function  GetHidden: LongBool; virtual;
    function  GetValueParameter: Boolean; virtual;
    function  GetLiteral: Boolean; virtual;
  private
    FModified:          Boolean;
    procedure FailIfReadOnlyType;
    // Once set, this should never be possible to unset.
    // Used by values that belong to a reader.
    //
    procedure SetReadOnlyType;
    property DBXContext: TDBXContext read FDBXContext;
  public
    constructor Create(DBXContext: TDBXContext); overload;
    constructor Create; overload;
    destructor Destroy; override;

    public function Clone: TDBXValueType;
    public function WritableClone: TDBXValueType;

    class function DataTypeName(DataType: TDBXType): string; static;
    class procedure InvalidTypeAccess(ExpectedDataType, DataType: TDBXType); static;
    ///<returns>
    ///  Name for this value.  This value can be used as an index
    ///  TDBXReader.Value and TDBXParameterList.Parameter array properties.
    ///</returns>
    property Name: string read FName write SetName;
    ///<returns>
    ///  Caption for this value.  This value can be used as a label
    ///  or caption heading for this value.
    ///</returns>
    property DisplayName: string read FCaption write SetDisplayName;
    ///<returns>
    ///  Value data type.  Returns one of the const values from TDBXDataTypes.
    ///</returns>
    property DataType: TDBXType read GetDataType write SetDataType;
    ///<returns>
    ///  Ordinal position of this value for a TDBXReader or TDBXParameterList.
    ///</returns>
    property Ordinal: TInt32 read GetOrdinal write SetOrdinal;
    ///<returns>
    ///  Value sub type.  Returns one of the "sub type" const values from TDBXDataTypes.
    ///</returns>
    property SubType: TInt32 read GetSubType write SetSubType;
    ///<returns>
    ///  The maximum number of digits allowed in the parameter, including both significant
    ///  and fractional.
    ///</returns>
    property Precision: Int64 read GetPrecision write SetPrecision;
    ///<returns>
    ///  Gets or sets the maximum number of digits used to represent the Value property.
    ///</returns>
    property Scale: TInt32 read GetScale write SetScale;
    ///<returns>
    ///  Used by TDBXParameter instances.  Child position of Oracle ADT and Array types
    ///</returns>
    property ChildPosition: TInt32 read GetChildPosition write SetChildPosition;
    ///<returns>
    ///  Used by drivers to set TDBXValue metadata for TDBXReaders.
    ///</returns>
    property ValueTypeFlags: TInt32  read GetFlags write SetFlags;
    ///<returns>
    ///  Gets and sets the size of the parameter value in bytes.
    ///  For string data this gets or sets the size of the parameter in characters.
    ///</returns>
    property Size: Int64  read GetSize write SetSize;

    ///<returns>
    ///  Gets or sets the value that determines whether or not a value can be set to null.
    ///</returns>
    property Nullable: Boolean read IsNullable write SetNullable;
    ///<returns>
    ///  Gets or sets the value that determines whether or this value can be set.
    ///</returns>
    property ReadOnly: Boolean read IsReadOnly;
    ///<returns>
    ///  Gets or sets the value that determines whether or this value is searchable.
    ///</returns>
    property Searchable: Boolean read IsSearchable;
    ///<returns>
    ///Gets or sets the value that determines whether or not this is an autoincrement value
    ///</returns>
    property AutoIncrement: Boolean read IsAutoIncrement;
    ///<returns>
    ///Gets or sets the value that determines whether or not this is a hidden value
    ///</returns>
    property Hidden: LongBool read GetHidden write SetHidden;
//    property BlobSizeExact: Boolean read IsBlobSizeExact;
    ///<returns>
    ///  Gets or sets the direction of a parameter.  This parameter can be set to one
    ///  of the TDBXParameterDirections const values.
    ///</returns>
    property ParameterDirection: TDBXParameterDirection read GetParameterDirection write SetParameterDirection;

    ///  <summary>
    ///  Used internally to mark a server method in out parameter as being
    ///  a descendant of TDBXWritableValue.  These are nullable parameters
    ///  regardless of their type.
    ///  </summary>
    property ValueParameter: Boolean read GetValueParameter write SetValueParameter;
    ///  <summary>
    ///  Used to mark a parameter as being specified in the command text property
    ///  as a literal value.
    ///  </summary>
    property Literal: Boolean read GetLiteral write SetLiteral;
  end;


  ///<summary>
  ///  <c>TDBXParameter</c> should be created by calling <c>TDBXCommand.CreateParameter</c>
  ///  for each "?" parameter marker specfied in the <c>TDBXCommand.Text</c>
  ///  property.  Once a <c>TDBXParameter</c> is created, it must be added to
  ///  a <c>TDBXCommand</c> parameter list by calling <c>TDBXCommand.Parameters.AddParameter</c> method.
  ///</summary>
  TDBXParameter = class(TDBXValueType)
    private
      FValue:                   TDBXWritableValue;
      [Weak]FConnectionHandler: TObject;
      FTypeName:                string;
      procedure UpdateParameterType(SetDataType: TDBXType);
      procedure CopyByteValue(Source: TDBXValue; Dest: TDBXWritableValue);
      procedure AssignValue(Source: TDBXValue);
      procedure AssignType(Source: TDBXParameter); virtual;
    protected
      function  GetValue: TDBXWritableValue; virtual;
      procedure SetParameter; virtual;
    public
      constructor Create(DbxContext: TDBXContext); overload;
      constructor Create(DbxContext: TDBXContext; Row: TDBXRow); overload;
      constructor Create(DbxContext: TDBXContext; Row: TDBXRow; Source: TDBXParameter); overload;
      destructor Destroy; override;
      ///<summary>Copies field values from Source into this object.
      ///  </summary>
      procedure Assign(Source: TDBXParameter); virtual;
      ///<summary>
      /// Creates a new parameter instance with the same field values as
      /// this object has.
      ///  </summary>
      function Clone: TObject; virtual;
      ///<returns>Returns a <c>TDBXWritableValue</c> instance that can be used to read and write parameter values.</returns>
      property Value: TDBXWritableValue read GetValue;
      ///<returns>The name of the type for this parameter or '' if not specified</returns>
      property TypeName: string read FTypeName write FTypeName;
      property ConnectionHandler: TObject read FConnectionHandler write FConnectionHandler;
  end;

  TDBXValueTypeArray = array of TDBXValueType;


  ///<summary>
  ///  The <c>TDBXCommand.Parameters</c> property returns an instance of <c>TDBXParameterList</c>
  ///  The <c>TDBXParameterList</c> manages a collection of <c>TDBXParameter</c>
  ///  instances that can be used to get and set parameters for a <c>TDBXCommand</c>.
  ///  The lifetime of all <c>TDBXParameter</c> instances added to this list will
  ///  be managed by this list.  So when <c>TDBXParameterList.Free</c> is called,
  ///  <c>TDBXParameter.Free</c> will also be called for all items in the list.
  ///</summary>
  TDBXParameterList = class
    private
      FValueTypes:    TDBXValueTypeList;
      [Weak]FCommand: TDBXCommand;
      FParameterRow:  TDBXRow;

      function GetParameterByName(const Name: string): TDBXParameter;
      procedure InvalidOrdinal(Ordinal: TInt32);
    strict protected
      procedure SetPendingOutParameter(const Ordinal: Integer);
      function GetRow: TDBXRow; virtual;
    protected
      [Weak]FDBXContext:    TDBXContext;

      constructor Create(DBXContext: TDBXContext; Command: TDBXCommand); overload;
      function GetParameterByOrdinal(const Ordinal: TInt32): TDBXParameter; virtual;
      function GetCount: TInt32; virtual;
    public
      constructor Create(DBXContext: TDBXContext; DBXRow: TDBXRow); overload;
      destructor Destroy; override;

      ///<summary>
      ///  Set the length of the list to <c>Count</c> size.  If this grows the list,
      ///  new items will be set to null.  If this shrinks the list, items
      ///  beyond the new length will be released by calling the <c>Free</c> method.
      ///</summary>
      procedure   SetCount(const Count: TInt32); virtual;
      ///<summary>
      ///  Add a <c>TDBXParameter</c> instance to this list.
      ///</summary>
      procedure   AddParameter(Parameter: TDBXParameter); virtual;
      ///<summary>
      ///  Add a <c>TDBXParameter</c> instance to this list at the <c>Ordinal</c> position.
      ///</summary>
      procedure   SetParameter(const Ordinal: Integer; const Parameter: TDBXParameter); virtual;
      ///<summary>
      ///  Insert a <c>TDBXParameter</c> instance to this list at the <c>Ordinal</c> position.
      ///</summary>
      procedure   InsertParameter(Ordinal: Integer; Parameter: TDBXParameter); virtual;
      ///<summary>
      ///  Remove the <c>TDBXParameter</c> instance from this list at the <c>Ordinal</c> position.
      ///  The <c>Free</c> method will be called for the removed parameter.
      ///</summary>
      procedure   RemoveParameter(Ordinal: Integer); overload; virtual;
      ///<summary>
      ///  Remove the <c>TDBXParameter</c> instance from this list.
      ///  The <c>Free</c> method will be called for the removed parameter.
      ///</summary>
      procedure   RemoveParameter(Parameter: TDBXParameter); overload; virtual;
      ///<summary>
      ///  Remove and and call <c>Free</c> for all parameters.
      ///</summary>
      procedure   ClearParameters; overload; virtual;
      ///<summary>
      ///  Remove all parameters, but don't call <c>Free</c>.
      ///</summary>
      procedure   RemoveParameters; virtual;

      ///<returns>
      ///  The ordinal for the <c>Name</c>parameter.
      ///</returns>
      function    GetOrdinal(const Name: string): Integer; virtual;
      ///<returns>
      ///  The number of parameters in this list.
      ///</returns>
      property    Count: TInt32 read GetCount write SetCount;
      ///<returns>
      ///  <c>TDBXParameter</c> instance at the <c>Ordinal</c> postion in the list.
      ///</returns>
      property    Parameter[const Ordinal: TInt32]: TDBXParameter read GetParameterByOrdinal; default;
      ///<returns>
      ///  <c>TDBXParameter</c> instance that has the <c>Name</c> property provided.
      ///</returns>
      property    Parameter[const Name: string]: TDBXParameter read GetParameterByName; default;
  end;


  ///<summary>
  ///  This class is to get and set values for both TDBXReader.Value and
  ///  TDBXParameterList.Value properties.
  ///</summary>
  TDBXValue = class
    private
      FValueType:       TDBXValueType;
      FGeneration:      TInt32;
      FIsNull:          LongBool;

      procedure InvalidOperation; virtual;
      class procedure UnsupportedFieldType(DBXContext: TDBXContext; ValueType: TDBXValueType); static;
      procedure CopyRowValue(Row: TDBXRow); overload; virtual;
    protected
      [Weak]FDbxRow:    TDBXRow;

      constructor Create(ValueType: TDBXValueType);
      function GetDbxContext: TDBXContext;
      property DbxContext: TDBXContext read GetDbxContext;
      function GetNonDelegate: TDBXValue; virtual;
      /// <summary>Applies a type conversion to Boolean if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a Boolean representation of the value.</returns>
      function GetAsBoolean: Boolean; virtual;
      /// <summary>Applies a type conversion to Byte if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a Byte representation of the value.</returns>
      function GetAsUInt8: Byte; virtual;
      /// <summary>Applies a type conversion to ShortInt if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a ShortInt representation of the value.</returns>
      function GetAsInt8: ShortInt; virtual;
      /// <summary>Applies a type conversion to Word if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; virtual;
      /// <summary>Applies a type conversion to SmallInt if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a SmallInt representation of the value.</returns>
      function GetAsInt16: SmallInt; virtual;
      /// <summary>Applies a type conversion to LongInt if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a LongInt representation of the value.</returns>
      function GetAsInt32: TInt32; virtual;
      /// <summary>Applies a type conversion to Int64 if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> an Int64 representation of the value.</returns>
      function GetAsInt64: Int64; virtual;
      /// <summary>Applies a type conversion to string if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> an string representation of the value.</returns>
      function GetAsString: string; virtual;
      /// <summary>Applies a type conversion to Single if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a Single representation of the value.</returns>
      function GetAsSingle: Single; virtual;
      /// <summary>Applies a type conversion to Double if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a Double representation of the value.</returns>
      function GetAsDouble: Double; virtual;
      /// <summary>Applies a type conversion to TBcd if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; virtual;
      /// <summary>Applies a type conversion to TDBXDate if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a TDBXDate representation of the value.</returns>
      function GetAsDate: TDBXDate; virtual;
      /// <summary>Applies a type conversion to TDBXTime if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a TDBXTime representation of the value.</returns>
      function GetAsTime: TDBXTime; virtual;
      /// <summary>Applies a type conversion to TSQLTimeStamp if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a TSQLTimeStamp representation of the value.</returns>
      function GetAsTimeStamp: TSQLTimeStamp; virtual;
      /// <summary>Applies a type conversion to TSQLTimeStampOffset if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a TSQLTimeStampOffset representation of the value.</returns>
      function GetAsTimeStampOffset: TSQLTimeStampOffset; virtual;
      /// <summary>Applies a type conversion to TDateTime if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a TDateTime representation of the value.</returns>
      function GetAsDateTime: TDateTime; virtual;
      /// <summary>Applies a type conversion to Currency if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a Currency representation of the value.</returns>
      function GetAsCurrency: Currency; virtual;
       /// <summary>Applies a type conversion to OleVariant if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> an OleVariant representation of the value.</returns>
      function GetAsVariant: OleVariant; virtual;
       /// <summary>Applies a type conversion to TStream if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a TStream representation of the value.</returns>
      function GetAsStream: TStream; virtual;
      /// <summary>Applies a type conversion to TDBXReader if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      /// <returns> a TDBXReader representation of the value.</returns>
      function GetAsDBXReader: TDBXReader; virtual;
    public
      destructor Destroy; override;

      ///<summary>
      ///  This class is to get and set values for both TDBXReader.Value and
      ///  TDBXParameterList.Value properties.
      ///</summary>
      class function CreateValue(DBXContext: TDBXContext; ValueType: TDBXValueType; DbxRow: TDBXRow; ReadOnlyType: Boolean): TDBXWritableValue; overload; static;
      class function CreateValue(ValueType: TDBXValueType): TDBXWritableValue; overload; static;

      ///<summary>
      ///  Returns true if the value is null.  This method should be called
      ///  before calling any of the TDBXValue.Get methods.  If the value
      ///  is null, the TDBXValue.Get methods will throw an TDBXError
      ///  exception if they are called.
      ///</summary>
      function IsNull: Boolean; virtual; abstract;

      ///<summary>
      ///  Gets the size in bytes for a TDBXValue.  For string TDBXDataTypes
      ///  the number of characters is returned.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetValueSize: Int64; virtual;
      ///<summary>
      ///  Gets the String value for TDBXValues with a TDBXDataType of TDBXDataTypes.AnsiStringType.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
{$IFNDEF NEXTGEN}
      function GetAnsiString: AnsiString; virtual;
{$ENDIF !NEXTGEN}
      ///<summary>
      ///  Gets the TDBXDate value for TDBXValues with a TDBXDataType of TDBXDataTypes.DateType.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetDate: TDBXDate; virtual;
      ///<summary>
      ///  Gets the Boolean value for TDBXValues with a TDBXDataType of TDBXDataTypes.BooleanType
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetBoolean: Boolean; overload; virtual;
      ///<summary>
      ///  Gets the TDBXTime value for TDBXValues with a TDBXDataType of TDBXDataTypes.TimeType.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetTime: TDBXTime; virtual;
      ///<summary>
      ///  Gets the string value for TDBXValues with a TDBXDataType of TDBXDataTypes.string.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetWideString: string; overload; virtual;
      ///<summary>
      ///  Gets the String value for TDBXValues with a TDBXDataType of TDBXDataTypes.string.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetString: string; overload; virtual;
      ///<summary>
      ///  Gets the Byte value for TDBXValues with a TDBXDataType of TDBXDataTypes.UInt8Type.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetUInt8: Byte; overload; virtual;
      ///<summary>
      ///  Gets the ShortInt value for TDBXValues with a TDBXDataType of TDBXDataTypes.Int8Type.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetInt8: ShortInt; overload; virtual;
      ///<summary>
      ///  Gets the Word value for TDBXValues with a TDBXDataType of TDBXDataTypes.UInt16Type.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetUInt16: Word; overload; virtual;
      ///<summary>
      ///  Gets the SmallInt value for TDBXValues with a TDBXDataType of TDBXDataTypes.Int16Type.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetInt16: SmallInt; overload; virtual;
      ///<summary>
      ///  Gets the TInt32 value for TDBXValues with a TDBXDataType of TDBXDataTypes.Int32Type.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetInt32: TInt32; overload; virtual;
      ///<summary>
      ///  Gets the Int64 value for TDBXValues with a TDBXDataType of TDBXDataTypes.Int64Type.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetInt64: Int64; overload; virtual;
      ///<summary>
      ///  Gets the Single value for TDBXValues with a TDBXDataType of TDBXDataTypes.SingleType.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetSingle: Single; virtual;
      ///<summary>
      ///  Gets the Double value for TDBXValues with a TDBXDataType of TDBXDataTypes.DoubleType.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetDouble: Double; virtual;
      ///<summary>
      ///  Gets the byte array value for TDBXValues with a TDBXDataType of TDBXDataTypes.BytesType
      ///  and TDBXDataType.BlobType.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetBytes(Offset: Int64; const Buffer: TArray<Byte>; BufferOffset, Length: Int64): Int64; overload; virtual;
      ///<summary>
      ///  Gets the TSQLTimeStamp value for TDBXValues with a TDBXDataType of TDBXDataTypes.TimeStampType.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetTimeStamp: TSQLTimeStamp; virtual;
      ///<summary>
      ///  Gets the TSQLTimeStampOffset value for TDBXValues with a TDBXDataType of TDBXDataTypes.TimeStampOffsetType.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetTimeStampOffset: TSQLTimeStampOffset; virtual;
      ///<summary>
      ///  Gets the TBcd value for TDBXValues with a TDBXDataType of TDBXDataTypes.BcdType.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetBcd: TBcd; virtual;
      ///<summary>
      ///  Gets the TObject value for TDBXValues with a TDBXDataType of TDBXDataTypes.DBXTable.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetDBXReader(AInstanceOwner: Boolean): TDBXReader; overload; virtual;
      ///<summary>
      ///  Gets the TObject value for TDBXValues with a TDBXDataType of TDBXDataTypes.DBXTable.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetDBXReader: TDBXReader; overload; virtual;
      ///<summary>
      ///  Gets the <c>TDBXInstance</c> for <c>TDBXValue</c> values with a <c>TDBXDataType</c>
      ///  of <c>TDBXDataTypes.DBXConnetion</c>.  This is used for DataSnap server methods
      ///  to specify a database connection context.
      ///</summary>
      function GetDBXConnection: TDBXConnection; virtual;
      ///<summary>
      ///  Gets the TStream value for binary data types.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetStream(AInstanceOwner: Boolean): TStream; overload; virtual;
      ///<summary>
      ///  Gets the TStream value for binary data types.
      ///  Throws a TDBXError exception if TDBXValue.IsNull is true.
      ///</summary>
      function GetStream: TStream; overload; virtual;
      /// <summary> Returns the JSON value from row buffer
      /// </summary>
      function GetJSONValue: TJSONValue; overload; virtual;
      /// <summary> Returns the JSON value from row buffer
      /// </summary>
      function GetJSONValue(AInstanceOwner: Boolean): TJSONValue; overload; virtual;
      /// <summary> Callback getter
      /// </summary>
      function GetCallbackValue: TDBXCallback; virtual;

      /// <summary> Returns the object value from row buffer from the recognized types
      /// </summary>
      function GetObjectValue: TObject; overload; virtual;
      /// <summary> Returns the object value from row buffer from the recognized types
      /// </summary>
      function GetObjectValue(AInstanceOwner: Boolean): TObject; overload; virtual;

      ///<summary>
      ///  Same as <c>GetWideString</c> except that if the value is null, the specified
      ///  <c>defaultValue</c> is used instead.
      ///</summary>
      function GetWideString(defaultValue: string): string; overload; virtual;
      ///<summary>
      ///  Same as <c>GetBoolean</c> except that if the value is null, the specified
      ///  <c>defaultValue</c> is used instead.
      ///</summary>
      function GetBoolean(defaultValue: Boolean): Boolean; overload; virtual;
      ///<summary>
      ///  Same as <c>GetUInt8</c> except that if the value is null, the specified
      ///  <c>defaultValue</c> is used instead.
      ///</summary>
      function GetUInt8(defaultValue: Byte): Byte; overload; virtual;
      ///<summary>
      ///  Same as <c>GetInt8</c> except that if the value is null, the specified
      ///  <c>defaultValue</c> is used instead.
      ///</summary>
      function GetInt8(defaultValue: Shortint): Shortint; overload; virtual;
      ///<summary>
      ///  Same as <c>GetUInt16</c> except that if the value is null, the specified
      ///  <c>defaultValue</c> is used instead.
      ///</summary>
      function GetUInt16(defaultValue: Word): Word; overload; virtual;
      ///<summary>
      ///  Same as <c>GetInt16</c> except that if the value is null, the specified
      ///  <c>defaultValue</c> is used instead.
      ///</summary>
      function GetInt16(defaultValue: Smallint): Smallint; overload; virtual;
      ///<summary>
      ///  Same as <c>GetInt32</c> except that if the value is null, the specified
      ///  <c>defaultValue</c> is used instead.
      ///</summary>
      function GetInt32(defaultValue: TInt32): TInt32; overload; virtual;
      ///<summary>
      ///  Same as <c>GetInt64</c> except that if the value is null, the specified
      ///  <c>defaultValue</c> is used instead.
      ///</summary>
      function GetInt64(defaultValue: Int64): Int64; overload; virtual;

      ///  <summary>
      ///  </summary>
      ///  <returns>true if the values are equal.</returns>
      function EqualsValue(Other: TDBXValue): Boolean; virtual;
      ///  <summary>
      ///    Compares current value with Other
      ///  </summary>
      ///  <remarks>
      ///    It is the caller's responsibility to check for null values and make
      ///    an appropriate decision.
      ///  </remarks>
      ///  <returns>0 if the values are equal, -1 if current value is less then Other, 1 otherwise.</returns>
      function Compare(Other: TDBXValue): Smallint; virtual;

      ///<summary>
      ///  Gets the TDBXValueType for this TDBXValue.
      ///</summary>
      property ValueType: TDBXValueType read FValueType;

      /// <summary>Applies a type conversion to string if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a string representation of the value.</returns>
      property AsString: string read GetAsString;
      /// <summary>Applies a type conversion to Boolean if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a Boolean representation of the value.</returns>
      property AsBoolean: Boolean read GetAsBoolean;
      /// <summary>Applies a type conversion to Byte if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a Byte representation of the value.</returns>
      property AsUInt8: Byte read GetAsUInt8;
      /// <summary>Applies a type conversion to ShortInt if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a ShortInt representation of the value.</returns>
      property AsInt8: ShortInt read GetAsInt8;
      /// <summary>Applies a type conversion to Word if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a Word representation of the value.</returns>
      property AsUInt16: Word read GetAsUInt16;
      /// <summary>Applies a type conversion to SmallInt if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a SmallInt representation of the value.</returns>
      property AsInt16: SmallInt read GetAsInt16;
      /// <summary>Applies a type conversion to Integer if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an Integer representation of the value.</returns>
      property AsInt32: Integer read GetAsInt32;
      /// <summary>Applies a type conversion to Int64 if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an Int64 representation of the value.</returns>
      property AsInt64: Int64 read GetAsInt64;
      /// <summary>Applies a type conversion to Single if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a Single representation of the value.</returns>
      property AsSingle: Single read GetAsSingle;
      /// <summary>Applies a type conversion to Double if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an Double representation of the value.</returns>
      property AsDouble: Double read GetAsDouble;
      /// <summary>Applies a type conversion to TBcd if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an <c>TBcd</c> representation of the value.</returns>
      property AsBcd: TBcd read GetAsBcd;
      /// <summary>Applies a type conversion to TDBXDate if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a <c>TDBXDate</c> representation of the value.</returns>
      property AsDate: TDBXDate read GetAsDate;
      /// <summary>Applies a type conversion to TDBXTime if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a <c>TDBXTime</c> representation of the value.</returns>
      property AsTime: TDBXTime read GetAsTime;
      /// <summary>Applies a type conversion to TSQLTimeStamp if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an TSQLTimeStamp representation of the value.</returns>
      property AsTimeStamp: TSQLTimeStamp read GetAsTimestamp;
      /// <summary>Applies a type conversion to TDateTime if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an TSQLTimeStamp representation of the value.</returns>
      property AsDateTime: TDateTime read GetAsDateTime;
      /// <summary>Applies a type conversion to OleVariant if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an Variant representation of the value.</returns>
      property AsVariant: OleVariant read GetAsVariant;
      /// <summary>Applies a type conversion to TStream if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an TStream representation of the value.</returns>
      property AsStream: TStream read GetAsStream;
      /// <summary>Applies a type conversion to TDBXReader if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an TDBXReader representation of the value.</returns>
      property AsDBXReader: TDBXReader read GetAsDBXReader;
  end;

  ///<summary>
  ///  Extension of TDBXValue that adds the ability to set a value.
  ///  This is only used by TDBXParameter.Value.  TDBXReader.Value array
  ///  property uses the readonly TDBXValue.
  ///</summary>
  TDBXWritableValue = class(TDBXValue)
    private
      FSetPending:      Boolean;
      procedure UpdateType; virtual;
      procedure SetRowValue; overload; virtual;
      function GetStreamReader: TDBXStreamReader; virtual;
    protected
      constructor Create(ValueType: TDBXValueType);
      procedure SetPendingValue; virtual;
      procedure SetAsBoolean(const Value: Boolean); virtual;
      procedure SetAsUInt8(const Value: Byte); virtual;
      procedure SetAsInt8(const Value: ShortInt); virtual;
      /// <summary>Applies a type conversion from Word if needed.  If there is no supported
      ///   conversion to this type, an exception is raised.
      /// </summary>
      procedure SetAsUInt16(const Value: Word); virtual;
      procedure SetAsInt16(const Value: SmallInt); virtual;
      procedure SetAsInt32(const Value: TInt32); virtual;
      procedure SetAsInt64(const Value: Int64); virtual;
      procedure SetAsString(const Value: string); virtual;
      procedure SetAsSingle(const Value: Single); virtual;
      procedure SetAsDouble(const Value: Double); virtual;
      procedure SetAsBcd(const Value: TBcd); virtual;
      procedure SetAsDate(const Value: TDBXDate); virtual;
      procedure SetAsTime(const Value: TDBXTime); virtual;
      procedure SetAsTimeStamp(const Value: TSQLTimeStamp); virtual;
      procedure SetAsTimeStampOffset(const Value: TSQLTimeStampOffset); virtual;
      procedure SetAsDateTime(const Value: TDateTime); virtual;
      procedure SetAsCurrency(const Value: Currency); virtual;
      procedure SetAsCurrencyValue(const Value: Currency; Precision: Integer; Decimals: Integer); virtual;
      procedure SetAsVariant(const Value: OleVariant); virtual;
      procedure SetAsStream(const Value: TStream); virtual;
      procedure SetAsDBXReader(const Value: TDBXReader); virtual;
    public
      destructor Destroy; override;
      /// <summary>
      ///   Marks the writable value as pending if it isn't already.
      /// </summary>
      /// <remarks>
      ///   Useful, for example, when you want to preserve the current value when it hasn't been modified.
      /// </remarks>
      procedure MarkAsPending;
      ///<summary>
      ///  Sets a TDBXWritable of any type to null.
      ///</summary>
      procedure SetNull; virtual;
      ///<summary>
      ///  Sets the TSQLTimeStamp Value for TDBXValues with a TDBXDataType of TDBXDataTypes.TimeStampType.
      ///</summary>
      procedure SetTimeStamp(const Value: TSQLTimeStamp); virtual;
      procedure SetTimeStampOffset(const Value: TSQLTimeStampOffset); virtual;
      ///<summary>
      ///  Sets the TBcd Value for TDBXValues with a TDBXDataType of TDBXDataTypes.BcdType.
      ///</summary>
      procedure SetBcd(const Value: TBcd); virtual;
      ///<summary>
      ///  Sets the String Value for TDBXValues with a TDBXDataType of TDBXDataTypes.AnsiStringType.
      ///</summary>
{$IFNDEF NEXTGEN}
      procedure SetAnsiString(const Value: AnsiString); virtual;
{$ENDIF !NEXTGEN}
      ///<summary>
      ///  Sets the Boolean Value for TDBXValues with a TDBXDataType of TDBXDataTypes.BooleanType.
      ///</summary>
      procedure SetBoolean(const Value: Boolean); virtual;
      ///<summary>
      ///  Sets the TDBXDate Value for TDBXValues with a TDBXDataType of TDBXDataTypes.DateType.
      ///</summary>
      procedure SetDate(const Value: TDBXDate); virtual;
      ///<summary>
      ///  Sets the TDBXTime Value for TDBXValues with a TDBXDataType of TDBXDataTypes.TimeType.
      ///</summary>
      procedure SetTime(const Value: TDBXTime); virtual;
      ///<summary>
      ///  Sets the string Value for TDBXValues with a TDBXDataType of TDBXDataTypes.string.
      ///</summary>
      procedure SetWideString(const Value: string); virtual;
      ///<summary>
      ///  Sets the String Value for TDBXValues with a TDBXDataType of TDBXDataTypes.string.
      ///</summary>
      procedure SetString(const Value: string); virtual;
      ///<summary>
      ///  Sets the Byte Value for TDBXValues with a TDBXDataType of TDBXDataTypes.UInt8Type.
      ///</summary>
      procedure SetUInt8(const Value: Byte); virtual;
      ///<summary>
      ///  Sets the ShortInt Value for TDBXValues with a TDBXDataType of TDBXDataTypes.Int8Type.
      ///</summary>
      procedure SetInt8(const Value: ShortInt); virtual;
      ///<summary>
      ///  Sets the Word Value for TDBXValues with a TDBXDataType of TDBXDataTypes.UInt16Type.
      ///</summary>
      procedure SetUInt16(const Value: Word); virtual;
      ///<summary>
      ///  Sets the SmallInt Value for TDBXValues with a TDBXDataType of TDBXDataTypes.Int16Type.
      ///</summary>
      procedure SetInt16(const Value: SmallInt); virtual;
      ///<summary>
      ///  Sets the TInt32 Value for TDBXValues with a TDBXDataType of TDBXDataTypes.Int32Type.
      ///</summary>
      procedure SetInt32(const Value: TInt32); virtual;
      ///<summary>
      ///  Sets the Int64 Value for TDBXValues with a TDBXDataType of TDBXDataTypes.Int64Type.
      ///</summary>
      procedure SetInt64(const Value: Int64); virtual;
      ///<summary>
      ///  Sets the Single Value for TDBXValues with a TDBXDataType of TDBXDataTypes.DoubleType.
      ///</summary>
      procedure SetSingle(const Value: Single); virtual;
      ///<summary>
      ///  Sets the Double Value for TDBXValues with a TDBXDataType of TDBXDataTypes.DoubleType.
      ///</summary>
      procedure SetDouble(const Value: Double); virtual;
      ///<summary>
      ///  Sets the open array Value for TDBXValues with a TDBXDataType of TDBXDataTypes.BytesType
      ///  or TDBXTypes.BlobType.
      ///</summary>
      procedure SetStaticBytes( Offset:       Int64;
                          const Buffer: array of Byte;
                          BufferOffset: Int64;
                          Length:       Int64); virtual;
      ///<summary>
      ///  Sets the dynamic array Value for TDBXValues with a TDBXDataType of TDBXDataTypes.BytesType
      ///  or TDBXTypes.BlobType.
      ///</summary>
      procedure SetDynamicBytes( Offset:       Int64;
                          const Buffer:   TArray<Byte>;
                          BufferOffset: Int64;
                          Length:       Int64); virtual;
      ///<summary>
      ///  Sets the TDBXReader Value for TDBXValues with a TDBXDataType of <c>TDBXDataTypes.DBXTableType</c>.
      ///  <c>AInstanceOwner</c> defaults to true if this parameter is not specified.  If
      ///  <c>AInstanceOnwer</c> is true, this instance of <c>TDBXWritableValue</c> will
      ///  take care of freeing the <c>TDBXReader</c> instance when it is no longer
      ///  needed.
      ///</summary>
      procedure SetDBXReader(const Value: TDBXReader; const AInstanceOwner: Boolean); overload; virtual;
      ///<summary>
      ///  Sets the TStream Value for TDBXValues with a TDBXDataType of <c>TDBXDataTypes.DBXTableType</c>.
      ///  <c>AInstanceOwner</c> defaults to true if this parameter is not specified.  If
      ///  <c>AInstanceOnwer</c> is true, this instance of <c>TDBXWritableValue</c> will
      ///  take care of freeing the <c>TStream</c> instance when it is no longer
      ///  needed.
      ///</summary>
      procedure SetStream(const Stream: TStream; const AInstanceOwner: Boolean); virtual;
      ///<summary>
      ///  Sets the TDBXConnection Value for TDBXValues with a TDBXDataType of <c>TDBXDataTypes.DBXConnectionType</c>.
      ///  used by DataSnap server methods that receive or set the server side
      ///  database connection.
      ///</summary>
      procedure SetDBXConnection(const Value: TDBXConnection); virtual;
      /// <summary> Changes the JSON value, updates the row data
      /// </summary>
      procedure SetJSONValue(const Value: TJSONValue; const AInstanceOwner: Boolean); virtual;
      /// <summary> Generic value accessor, accepts serializable data
      /// </summary>
      procedure SetObjectValue(const Value: TObject; const AInstanceOwner: Boolean); virtual;
      /// <summary> Callback setter
      /// </summary>
      procedure SetCallbackValue(const Value: TDBXCallback); virtual;
      ///<summary>
      ///  Assigns the contents of a <c>TDBXValue</c> to this <c>TDBXWritableValue</c>
      ///</summary>
      procedure SetValue(const Value: TDBXValue); virtual;

      /// <summary>Applies a type conversion to/from string if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a string representation of the value.</returns>
      property AsString: string read GetAsString write SetAsString;

      /// <summary>Applies a type conversion to/from Boolean if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a Boolean representation of the value.</returns>
      property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
      /// <summary>Applies a type conversion to/from Byte if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a Byte representation of the value.</returns>
      property AsUInt8: Byte read GetAsUInt8 write SetAsUInt8;
      /// <summary>Applies a type conversion to/from ShortInt if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a ShortInt representation of the value.</returns>
      property AsInt8: ShortInt read GetAsInt8 write SetAsInt8;
      /// <summary>Applies a type conversion to/from Word if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a Word representation of the value.</returns>
      property AsUInt16: Word read GetAsUInt16 write SetAsUInt16;
      /// <summary>Applies a type conversion to/from SmallInt if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a SmallInt representation of the value.</returns>
      property AsInt16: SmallInt read GetAsInt16 write SetAsInt16;
      /// <summary>Applies a type conversion to/from Integer if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an Integer representation of the value.</returns>
      property AsInt32: Integer read GetAsInt32 write SetAsInt32;
      /// <summary>Applies a type conversion to/from Int64 if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an Int64 representation of the value.</returns>
      property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
      /// <summary>Applies a type conversion to/from Single if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a Single representation of the value.</returns>
      property AsSingle: Single read GetAsSingle write SetAsSingle;
      /// <summary>Applies a type conversion to/from Double if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a Double representation of the value.</returns>
      property AsDouble: Double read GetAsDouble write SetAsDouble;
      /// <summary>Applies a type conversion to/from TBcd if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a <c>TBcd</c> representation of the value.</returns>
      property AsBcd: TBcd read GetAsBcd write SetAsBcd;
      /// <summary>Applies a type conversion to/from TDBXDate if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a <c>TDBXDate</c> representation of the value.</returns>
      property AsDate: TDBXDate read GetAsDate write SetAsDate;
      /// <summary>Applies a type conversion to/from TDBXTime if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a <c>TDBXTime</c> representation of the value.</returns>
      property AsTime: TDBXTime read GetAsTime write SetAsTime;
      /// <summary>Applies a type conversion to/from TSQLTimeStamp if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a TSQLTimeStamp representation of the value.</returns>
      property AsTimeStamp: TSQLTimeStamp read GetAsTimestamp write SetAsTimestamp;
      /// <summary>Applies a type conversion to/from TSQLTimeStampOffset if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a TSQLTimeStampOffset representation of the value.</returns>
      property AsTimeStampOffset: TSQLTimeStampOffset read GetAsTimestampOffset write SetAsTimestampOffset;
      /// <summary>Applies a type conversion to/from TDateTime if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a TDateTime representation of the value.</returns>
      property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
      /// <summary>Applies a type conversion to/from Currency if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a Currency representation of the value.</returns>
      property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
      /// <summary>Applies a type conversion to/from OleVariant if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> an OleVariant representation of the value.</returns>
      property AsVariant: OleVariant read GetAsVariant write SetAsVariant;
      /// <summary>Applies a type conversion to/from TStream if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a TStream representation of the value.</returns>
      property AsStream: TStream read GetAsStream write SetAsStream;
      /// <summary>Applies a type conversion to/from TDBXReader if needed.  If there is no supported
      /// conversion to this type, an exception is raised.
      /// </summary>
      ///  <returns> a TDBXReader representation of the value.</returns>
      property AsDBXReader: TDBXReader read GetAsDBXReader write SetAsDBXReader;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for Parameters that have no type.
  ///</summary>
  TDBXNullValue = class(TDBXWritableValue)
    protected
      constructor Create(ValueType: TDBXValueType);
    public
      destructor Destroy; override;
      function IsNull:Boolean; override;
  end;
  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.AnsiStringType</c> values.
  ///</summary>
  TDBXAnsiStringValue = class(TDBXWritableValue)
    private
      FValue:           TArray<Byte>;
      FOverFlowBytes:   TDBXByteStreamReader;
      procedure SetOverflowBytes(const OverFlowBytes: TDBXByteStreamReader);
      function GetStreamReader: TDBXStreamReader; override;
      procedure UpdateType; override;
    protected
      constructor Create(ValueType: TDBXValueType);
    public
      destructor Destroy; override;
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull:Boolean; override;
{$IFNDEF NEXTGEN}
      /// <summary>Gets AnsiString value.</summary>
      /// <returns> the AnsiString value.</returns>
      function GetAnsiString: AnsiString; override;
      /// <summary>Sets AnsiString value.</summary>
      procedure SetAnsiString(const Value: AnsiString); override;
{$ELSE}
      function GetString: string; override;
      procedure SetString(const Value: string); override;
{$ENDIF}
      /// <summary>Applies a type conversion from AnsiString to string.</summary>
      /// <returns> a string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Compares the AnsiString to 'True'</summary>
      /// <returns> a Boolean representation of the string comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from AnsiString to Byte.</summary>
      /// <returns> a Byte representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsUInt8: Byte; override;
      /// <summary>Applies a type conversion from AnsiString to ShortInt.</summary>
      /// <returns> a ShortInt representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from AnsiString to Word.</summary>
      /// <returns> a Word representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from AnsiString to SmallInt.</summary>
      /// <returns> a SmallInt representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from AnsiString to LongInt.</summary>
      /// <returns> a LongInt representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Applies a type conversion from AnsiString to Int64.</summary>
      /// <returns> an Int64 representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsInt64: Int64; override;
      /// <summary>Applies a type conversion from AnsiString to Single.</summary>
      /// <returns> a Single representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsSingle: Single; override;
      /// <summary>Applies a type conversion from AnsiString to Double.</summary>
      /// <returns> a Double representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsDouble: Double; override;
      /// <summary>Applies a type conversion from AnsiString to TBcd.</summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Applies a type conversion from AnsiString to TDBXDate.</summary>
      /// <returns> a TDBXDate representation of the value.</returns>
      function GetAsDate: TDBXDate; override;
      /// <summary>Applies a type conversion from AnsiString to TDBXTime.</summary>
      /// <returns> a TDBXTime representation of the value.</returns>
      function GetAsTime: TDBXTime; override;
      /// <summary>Applies a type conversion from AnsiString to TSQLTimeStamp.</summary>
      /// <returns> a TSQLTimeStamp representation of the value.</returns>
      function GetAsTimeStamp: TSQLTimeStamp; override;
      /// <summary>Sets the value after applying a type conversion from
      ///   string to AnsiString.
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   Boolean to AnsiString.
      /// </summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   Byte to AnsiString.
      /// </summary>
      procedure SetAsUInt8(const Value: Byte); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   ShortInt to AnsiString.
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   Word to AnsiString.
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   SmallInt to AnsiString.
      /// </summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   LongInt to AnsiString.
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   Int64 to AnsiString.
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   Single to AnsiString.
      /// </summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   Double to AnsiString.
      /// </summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   TBcd to AnsiString.
      /// </summary>
      procedure SetAsBcd(const Value: TBcd); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   TDBXDate to AnsiString.
      /// </summary>
      procedure SetAsDate(const Value: TDBXDate); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   TDBXTime to AnsiString.
      /// </summary>
      procedure SetAsTime(const Value: TDBXTime); override;
      /// <summary>Sets the value after applying a type conversion from
      ///   TSQLTimeStamp to AnsiString.
      /// </summary>
      procedure SetAsTimeStamp(const Value: TSQLTimeStamp); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compare compares the current TDBXAnsiStringValue with the Other parameter, without case sensitivity.</summary>
      ///<returns>Returns a value less than 0 if the current TDBXAnsiStringValue
      ///  is smaller than Other, a value greater than 0 if the current
      ///  TDBXAnsiStringValue is greater than Other, and 0 if they are equal.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.DateType</c> values.
  ///</summary>
  TDBXDateValue = class(TDBXWritableValue)
    private
      FDate: TDBXDate;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
   public
      function GetAsDateTime: TDateTime; override;
      procedure SetAsDateTime(const Value: TDateTime); override;
      function IsNull: Boolean; override;
      function GetDate: TDBXDate; override;
      procedure SetDate(const Value: TDBXDate); override;
      function GetAsString: string; override;
      function GetAsDate: TDBXDate; override;
      function GetAsTimeStamp: TSQLTimeStamp; override;
      procedure SetAsString(const Value: string); override;
      procedure SetAsDate(const Value: TDBXDate); override;
      procedure SetAsTimeStamp(const Value: TSQLTimestamp); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXDateValue with another TDBXDateValue given
      ///  by a parameter.
      ///</summary>
      ///<returns>Returns -1 if the current TDBXDateValue is before Other, 1 if
      ///  the current TDBXDateValue is after Other, and 0 if they are the same date.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.CursorType</c>.
  ///  Used for Oracle drivers to specify that a Reader (Oracle Cursor) will be returned
  ///  from the execution of a stored procedure.
  ///</summary>
  TDBXCursorValue = class(TDBXWritableValue)
    public
      function IsNull: Boolean; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.BooleanType</c> values.
  ///</summary>
  TDBXBooleanValue = class(TDBXWritableValue)
    private
      FBoolean: LongBool;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Returns the Boolean value.</summary>
      /// <returns> the Boolean value.</returns>
      function GetBoolean: Boolean; override;
      /// <summary>Sets the Boolean value</summary>
      procedure SetBoolean(const Value: Boolean); override;
      /// <summary>Applies a type conversion from Boolean to string.</summary>
      /// <returns> an string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Returns the Boolean value.</summary>
      /// <returns> the Boolean value.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from Boolean to Byte.</summary>
      /// <returns> a Byte representation of the value.</returns>
      function GetAsUInt8: Byte; override;
      /// <summary>Applies a type conversion from Boolean to ShortInt.</summary>
      /// <returns> a ShortInt representation of the value.</returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from Boolean to Word.</summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from Boolean to SmallInt.</summary>
      /// <returns> a SmallInt representation of the value.</returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from Boolean to LongInt.</summary>
      /// <returns> a LongInt representation of the value.</returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Applies a type conversion from Boolean to Int64.</summary>
      /// <returns> an Int64 representation of the value.</returns>
      function GetAsInt64: Int64; override;
      /// <summary>Sets the value after applying a type conversion from string
      ///   to Boolean.
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the Boolean value</summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Byte
      ///   to Boolean.
      /// </summary>
      procedure SetAsUInt8(const Value: Byte); override;
      /// <summary>Sets the value after applying a type conversion from ShortInt
      ///   to Boolean.
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from Word
      ///   to Boolean.
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt
      ///   to Boolean.
      /// </summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from LongInt
      ///   to Boolean.
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from Int64
      ///   to Boolean.
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      procedure SetValue(const Value: TDBXValue); override;
      function EqualsValue(Other: TDBXValue): Boolean; override;
      ///<summary>Compares the TDBXBooleanValue with another TDBXBooleanValue,
      ///  given by the parameter.
      ///</summary>
      ///<returns>Returns 0 if the two values are equal, 1 if the current
      ///  TDBXBooleanValue is True and Other is False, and -1 otherwise.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.TimeType</c> values.
  ///</summary>
  TDBXTimeValue = class(TDBXWritableValue)
    private
      FTime: TDBXTime;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      function IsNull: Boolean; override;
      function GetTime: TDBXTime; override;
      procedure SetTime(const Value: TDBXTime); override;
      function GetAsString: string; override;
      function GetAsTime: TDBXTime; override;
      function GetAsTimeStamp: TSQLTimeStamp; override;
      function GetAsDateTime: TDateTime; override;
      procedure SetAsDateTime(const Value: TDateTime); override;
      procedure SetAsString(const Value: string); override;
      procedure SetAsTime(const Value: TDBXTime); override;
      procedure SetAsTimeStamp(const Value: TSQLTimestamp); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXTimeValue with another TDBXTimeValue,
      ///  given by the parameter.
      ///</summary>
      ///<returns>Returns 0 if the two values are equal, 1 if the current
      ///  TDBXTimeValue is greater than Other, and -1 otherwise.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.WideStringType</c> values.
  ///</summary>
  TDBXWideStringValue = class(TDBXWritableValue)
    private
      FWideString:          string;
      FOverFlowBytes:       TDBXByteStreamReader;
      procedure UpdateType; override;
      procedure SetOverflowBytes(const OverFlowBytes: TDBXByteStreamReader);
      function GetStreamReader: TDBXStreamReader; override;
    protected
      constructor Create(ValueType: TDBXValueType);
    public
      destructor Destroy; override;
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Returns the string.</summary>
      /// <returns> the string.</returns>
      function GetWideString: string; override;
      /// <summary>Returns the string.</summary>
      /// <returns> the string.</returns>
      function GetAsString: string; override;
      /// <summary>Compares the string to 'True'</summary>
      /// <returns> a Boolean representation of the string comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from string to Byte.</summary>
      /// <returns> a Byte representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsUInt8: Byte; override;
      /// <summary>Applies a type conversion from string to ShortInt.</summary>
      /// <returns> a ShortInt representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from string to Word.</summary>
      /// <returns> a Word representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from string to SmallInt.</summary>
      /// <returns> a SmallInt representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from string to LongInt.</summary>
      /// <returns> a LongInt representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Applies a type conversion from string to Int64.</summary>
      /// <returns> an Int64 representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsInt64: Int64; override;
      /// <summary>Applies a type conversion from string to Single.</summary>
      /// <returns> a Single representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsSingle: Single; override;
      /// <summary>Applies a type conversion from string to Double.</summary>
      /// <returns> a Double representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsDouble: Double; override;
      /// <summary>Applies a type conversion from string to TBcd.</summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Applies a type conversion from string to TDBXDate.</summary>
      /// <returns> a TDBXDate representation of the value.</returns>
      function GetAsDate: TDBXDate; override;
      /// <summary>Applies a type conversion from string to TDBXTime.</summary>
      /// <returns> a TDBXTime representation of the value.</returns>
      function GetAsTime: TDBXTime; override;
      /// <summary>Applies a type conversion from string to TSQLTimeStamp.</summary>
      /// <returns> a TSQLTimeStamp representation of the value on success or 0 if the
      ///   conversion fails.
      /// </returns>
      function GetAsTimeStamp: TSQLTimeStamp; override;
      /// <summary>Sets the string value.</summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from Boolean
      ///   to string.
      /// </summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Byte
      ///   to string.
      /// </summary>
      procedure SetAsUInt8(const Value: Byte); override;
      /// <summary>Sets the value after applying a type conversion from ShortInt
      ///   to string.
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from Word
      ///   to string.
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt
      ///   to string.
      /// </summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from LongInt
      ///   to string.
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from Int64
      ///   to string.
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the value after applying a type conversion from Single
      ///   to string.
      /// </summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the value after applying a type conversion from Double
      ///   to string.
      /// </summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the value after applying a type conversion from TBcd
      ///   to string.
      /// </summary>
      procedure SetAsBcd(const Value: TBcd); override;
      /// <summary>Sets the value after applying a type conversion from TDBXDate
      ///   to string.
      /// </summary>
      procedure SetAsDate(const Value: TDBXDate); override;
      /// <summary>Sets the value after applying a type conversion from TDBXTime
      ///   to string.
      /// </summary>
      procedure SetAsTime(const Value: TDBXTime); override;
      /// <summary>Sets the value after applying a type conversion from TSQLTimeStamp
      ///   to string.
      /// </summary>
      procedure SetAsTimeStamp(const Value: TSQLTimeStamp); override;
      procedure SetValue(const Value: TDBXValue); override;
      function EqualsValue(Other: TDBXValue): Boolean; override;
      ///<summary>Compare compares the current TDBXWideStringValue with the Other parameter, without case sensitivity.</summary>
      ///<returns>Returns a value less than 0 if the current TDBXWideStringValue
      ///  is smaller than Other, a value greater than 0 if the current
      ///  TDBXWideStringValue is greater than Other, and 0 if they are equal.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.Int8Type</c> values.
  ///</summary>
  TDBXInt8Value = class(TDBXWritableValue)
    private
      FInt8: ShortInt;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      /// <summary>Returns the ShortInt value.</summary>
      /// <returns> the ShortInt value.</returns>
      function GetInt8: ShortInt; override;
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Sets the ShortInt value.</summary>
      procedure SetInt8(const Value: ShortInt); override;
      /// <summary>Returns the ShortInt value.</summary>
      /// <returns> the ShortInt value.</returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from ShortInt to Word.</summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from ShortInt to SmallInt.</summary>
      /// <returns> a SmallInt representation of the value.</returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from ShortInt to LongInt.</summary>
      /// <returns> a LongInt representation of the value.</returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Compares the ShortInt to 0</summary>
      /// <returns> a Boolean representation of the comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from ShortInt to Int64.</summary>
      /// <returns> an Int64 representation of the value.</returns>
      function GetAsInt64: Int64; override;
      /// <summary>Applies a type conversion from ShortInt to string.</summary>
      /// <returns> a string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Applies a type conversion from ShortInt to Single.</summary>
      /// <returns> a Single representation of the value.</returns>
      function GetAsSingle: Single; override;
      /// <summary>Applies a type conversion from ShortInt to Double.</summary>
      /// <returns> a Double representation of the value.</returns>
      function GetAsDouble: Double; override;
      /// <summary>Applies a type conversion from ShortInt to TBcd.</summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Sets the ShortInt value.</summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from Word
      ///   to ShortInt.  An exception is raised if Value >= High(ShortInt).
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt
      ///   to ShortInt.  An exception is raised if Value >= High(ShortInt)
      ///   or Value <= Low(ShortInt).
      /// </summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from LongInt
      ///   to ShortInt.  An exception is raised if Value >= High(ShortInt)
      ///   or Value <= Low(ShortInt).
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from Boolean
      ///   to ShortInt.
      /// </summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Int64
      ///   to ShortInt.  An exception is raised if Value >= High(ShortInt)
      ///   or Value <= Low(ShortInt).
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the value after applying a type conversion from string
      ///   to ShortInt.  An exception is raised if Value >= High(ShortInt)
      ///   or Value <= Low(ShortInt).
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from Single
      ///   to ShortInt.  This value is rounded.  An exception is raised if
      ///   Value >= High(ShortInt) or Value <= Low(ShortInt).
      /// </summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the value after applying a type conversion from Double
      ///   to ShortInt.  This value is rounded.  An exception is raised if
      ///   Value >= High(ShortInt) or Value <= Low(ShortInt).
      /// </summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt
      ///   to ShortInt.  This value is rounded.  An exception is raised if
      ///   Value >= High(ShortInt) or Value <= Low(ShortInt).
      /// </summary>
      procedure SetAsBcd(const Value: TBcd); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXInt8Value with another TDBXInt8Value,
      ///  given by the parameter.
      ///</summary>
      ///<returns>Returns 0 if the two values are equal, 1 if the current
      ///  TDBXInt8Value is greater than Other, and -1 otherwise.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  TDBXUInt8Value = class(TDBXWritableValue)
    private
      FUInt8: Byte;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      /// <summary>Returns the Byte value.</summary>
      /// <returns> the Byte value.</returns>
      function GetUInt8: Byte; override;
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Sets the Byte value.</summary>
      procedure SetUInt8(const Value: Byte); override;
      /// <summary>Applies a type conversion from Byte to ShortInt.</summary>
      /// <returns> a ShortInt representation of the value.</returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from Byte to Word.</summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from Byte to SmallInt.</summary>
      /// <returns> a SmallInt representation of the value.</returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from Byte to LongInt.</summary>
      /// <returns> a LongInt representation of the value.</returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Compares the Byte to 0</summary>
      /// <returns> a Boolean representation of the comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from Byte to Int64.</summary>
      /// <returns> a Int64 representation of the value.</returns>
      function GetAsInt64: Int64; override;
      /// <summary>Applies a type conversion from Byte to string.</summary>
      /// <returns> an string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Applies a type conversion from Byte to Single.</summary>
      /// <returns> a Single representation of the value.</returns>
      function GetAsSingle: Single; override;
      /// <summary>Applies a type conversion from Byte to Double.</summary>
      /// <returns> a Double representation of the value.</returns>
      function GetAsDouble: Double; override;
      /// <summary>Applies a type conversion from Byte to TBcd.</summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Sets the value after applying a type conversion from ShortInt
      ///   to Byte.  An exception is raised if Value < Low(Byte)
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from Word
      ///   to Byte.  An exception is raised if Value >= High(Byte)
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt
      ///   to Byte.  An exception is raised if Value <= Low(Byte)
      ///   or Value >= High(Byte).
      /// </summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from LongInt
      ///   to Byte.  An exception is raised if Value <= Low(Byte)
      ///   or Value >= High(Byte).
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from Boolean
      ///   to Byte.
      /// </summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Int64
      ///   to Byte.  An exception is raised if Value <= Low(Byte)
      ///   or Value >= High(Byte).
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the value after applying a type conversion from string
      ///   to Byte.  An exception is raised if Value <= Low(Byte)
      ///   or Value >= High(Byte).
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from Single
      ///   to Byte.  The value is rounded.  An exception is raised if Value <= Low(Byte)
      ///   or Value >= High(Byte).
      /// </summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the value after applying a type conversion from Double
      ///   to Byte.  The value is rounded.  An exception is raised if Value <= Low(Byte)
      ///   or Value >= High(Byte).
      /// </summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the value after applying a type conversion from TBcd
      ///   to Byte.  An exception is raised if Value <= Low(Byte)
      ///   or Value >= High(Byte).
      /// </summary>
      procedure SetAsBcd(const Value: TBcd); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXUInt8Value with another TDBXUInt8Value,
      ///  given by the parameter.
      ///</summary>
      ///<returns>Returns 0 if the two values are equal, 1 if the current
      ///  TDBXUInt8Value is greater than Other, and -1 otherwise.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.Int16Type</c> values.
  ///</summary>
  TDBXInt16Value = class(TDBXWritableValue)
    private
      FInt16: SmallInt;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      /// <summary>Returns the SmallInt value.</summary>
      /// <returns> The SmallInt value.</returns>
      function GetInt16: SmallInt; override;
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Sets the SmallInt value</summary>
      procedure SetInt16(const Value: SmallInt); override;
      /// <summary>Applies a type conversion from SmallInt to Byte.</summary>
      /// <returns> a Byte representation of the value.</returns>
      function GetAsUInt8: Byte; override;
      /// <summary>Applies a type conversion from SmallInt to ShortInt.</summary>
      /// <returns> a ShortInt representation of the value.</returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from SmallInt to Word.</summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; override;
      /// <summary>Returns the SmallInt value.</summary>
      /// <returns> The SmallInt value.</returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from SmallInt to LongInt.</summary>
      /// <returns> a LongInt representation of the value.</returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Compares the SmallInt to 0</summary>
      /// <returns> a Boolean representation of the comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from SmallInt to Int64.</summary>
      /// <returns> an Int64 representation of the value.</returns>
      function GetAsInt64: Int64; override;
      /// <summary>Applies a type conversion from SmallInt to string.</summary>
      /// <returns> an string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Applies a type conversion from SmallInt to Single.</summary>
      /// <returns> a Single representation of the value.</returns>
      function GetAsSingle: Single; override;
      /// <summary>Applies a type conversion from SmallInt to Double.</summary>
      /// <returns> a Double representation of the value.</returns>
      function GetAsDouble: Double; override;
      /// <summary>Applies a type conversion from SmallInt to TBcd.</summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Sets the value after applying a type conversion from Byte
      ///   to SmallInt.
      /// </summary>
      procedure SetAsUInt8(const Value: Byte); override;
      /// <summary>Sets the value after applying a type conversion from ShortInt
      ///   to SmallInt.
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from Word
      ///   to SmallInt.  An exception is raised if Value >= High(SmallInt).
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the SmallInt value</summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from LongInt
      ///   to SmallInt.  An exception is raised if Value >= High(SmallInt) or
      ///   Value <= Low(SmallInt).
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from Boolean
      ///   to SmallInt.
      /// </summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Int64
      ///   to SmallInt.  An exception is raised if Value >= High(SmallInt) or
      ///   Value <= Low(SmallInt).
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the value after applying a type conversion from string
      ///   to SmallInt.  An exception is raised if Value >= High(SmallInt) or
      ///   Value <= Low(SmallInt).
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from Single
      ///   to SmallInt.  The value is rounded.  An exception is raised if
      ///   Value >= High(SmallInt) or Value < Low(SmallInt).
      /// </summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the value after applying a type conversion from Double
      ///   to SmallInt.  The value is rounded.  An exception is raised if
      ///   Value >= High(SmallInt) or Value < Low(SmallInt).
      /// </summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the value after applying a type conversion from TBcd
      ///   to SmallInt.  An exception is raised if Value >= High(SmallInt) or
      ///   Value <= Low(SmallInt).
      /// </summary>
      procedure SetAsBcd(const Value: TBcd); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXInt16Value with another TDBXInt16Value given
      ///  by a parameter.
      ///</summary>
      ///<returns>returns -1 if the current TDBXInt16Value is smaller than Other,
      ///  1 if the current TDBXInt16Value is greater than Other, and 0 if they
      ///  are equal.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.UInt16Type</c> values.
  ///</summary>
  TDBXUInt16Value = class(TDBXWritableValue)
    private
      FUInt16: Word;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      /// <summary>Returns the Word value.</summary>
      /// <returns>a Word representation of the value.</returns>
      function GetUInt16: Word; override;
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Sets Word value</summary>
      procedure SetUInt16(const Value: Word); override;
      /// <summary>Applies a type conversion from Word to Byte.</summary>
      /// <returns> a Byte representation of the value.</returns>
      function GetAsUInt8: Byte; override;
      /// <summary>Applies a type conversion from Word to ShortInt.</summary>
      /// <returns> a ShortInt representation of the value.</returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Returns the Word value.</summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from Word to SmallInt.</summary>
      /// <returns> a SmallInt representation of the value.</returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from Word to LongInt.</summary>
      /// <returns> a LongInt representation of the value.</returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Compares the Word to 0.</summary>
      /// <returns> a Boolean representation of the comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from Word to Int64.</summary>
      /// <returns> an Int64 representation of the value.</returns>
      function GetAsInt64: Int64; override;
      /// <summary>Applies a type conversion from Word to string.</summary>
      /// <returns> an string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Applies a type conversion from Word to Single.</summary>
      /// <returns> a Single representation of the value.</returns>
      function GetAsSingle: Single; override;
      /// <summary>Applies a type conversion from Word to Double.</summary>
      /// <returns> a Double representation of the value.</returns>
      function GetAsDouble: Double; override;
      /// <summary>Applies a type conversion from Word to TBcd.</summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Sets the value after applying a type conversion from Byte to Word</summary>
      procedure SetAsUInt8(const Value: Byte); override;
      /// <summary>Sets the value after applying a type conversion from ShortInt to Word.
      ///   An exception is raised if Value < 0.
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets Word value</summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt to Word.
      ///   An exception is raised if Value < 0.
      ///</summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from LongInt to Word.
      ///   An exception is raised if Value < 0 or Value >= High(Word).
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from Boolean to Word</summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Int64 to Word.
      ///   An exception is raised if Value < 0 or Value >= High(Word).
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the value after applying a type conversion from string to Word.
      ///   An exception is raised if, after converting to Integer, Value < 0 or Value >= High(Word).
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from Single to Word.
      ///   An exception is raised if Value < 0 or Value >= High(Word).
      /// </summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the value after applying a type conversion from Double to Word.
      ///   An exception is raised if Value < 0 or Value >= High(Word).
      /// </summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the value after applying a type conversion from TBcd to Word.
      ///   An exception is raised if Value < 0 or Value >= High(Word)
      /// </summary>
      procedure SetAsBcd(const Value: TBcd); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXUIntValue with another TDBXUInt16Value,
      ///  given by the parameter.
      ///</summary>
      ///<returns>Returns 0 if the two values are equal, 1 if the current
      ///  TDBXUInt16Value is greater than Other, and -1 otherwise.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.Int32Type</c> values.
  ///</summary>
  TDBXInt32Value = class(TDBXWritableValue)
    private
      FInt32: TInt32;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Returns the LongInt value</summary>
      /// <returns> the LongInt value.</returns>
      function GetInt32: TInt32; override;
      /// <summary>Sets the LongInt value</summary>
      procedure SetInt32(const Value: TInt32); override;
      /// <summary>Applies a type conversion from LongInt to string.</summary>
      /// <returns> an string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Compares the LongInt to 0</summary>
      /// <returns> a Boolean representation of the comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from LongInt to Byte.</summary>
      /// <returns> a Byte representation of the value.</returns>
      function GetAsUInt8: Byte; override;
      /// <summary>Applies a type conversion from LongInt to ShortInt.</summary>
      /// <returns> a ShortInt representation of the value.</returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from LongInt to Word.</summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from LongInt to SmallInt.</summary>
      /// <returns> a SmallInt representation of the value.</returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Returns the LongInt value</summary>
      /// <returns> the LongInt value.</returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Applies a type conversion from LongInt to Int64.</summary>
      /// <returns> an Int64 representation of the value.</returns>
      function GetAsInt64: Int64; override;
      /// <summary>Applies a type conversion from LongInt to Single.</summary>
      /// <returns> a Single representation of the value.</returns>
      function GetAsSingle: Single; override;
      /// <summary>Applies a type conversion from LongInt to Double.</summary>
      /// <returns> a Double representation of the value.</returns>
      function GetAsDouble: Double; override;
      /// <summary>Applies a type conversion from LongInt to TBcd.</summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Returns the TDBXTime value</summary>
      /// <returns> the TDBXTime value.</returns>
      function GetAsTime: TDBXTime; override;
      /// <summary>Sets the value after applying a type conversion from string
      ///   to LongInt.
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from Boolean
      ///   to LongInt.
      /// </summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Byte
      ///   to LongInt.
      /// </summary>
      procedure SetAsUInt8(const Value: Byte); override;
      /// <summary>Sets the value after applying a type conversion from ShortInt
      ///   to LongInt.
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from Word
      ///   to LongInt.
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt
      ///   to LongInt.
      /// </summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the LongInt value</summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from Int64
      ///   to LongInt.  An exception is raised if Value <= Low(LongInt)
      ///   or Value >= High(LongInt).
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the value after applying a type conversion from Single
      ///   to LongInt.  The value is rounded.  An exception is raised if
      ///   Value <= Low(LongInt) or Value >= High(LongInt).
      /// </summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the value after applying a type conversion from Double
      ///   to LongInt.  The value is rounded.  An exception is raised if
      ///   Value <= Low(LongInt) or Value >= High(LongInt).
      /// </summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the value after applying a type conversion from Single
      ///   to LongInt.
      /// </summary>
      procedure SetAsBcd(const Value: TBcd); override;
      /// <summary>Sets the TDBXTime value</summary>
      procedure SetAsTime(const Value: TDBXTime); override;
      procedure SetValue(const Value: TDBXValue); override;
      function EqualsValue(Other: TDBXValue): Boolean; override;
      ///<summary>Compares the TDBXInt32Value with another TDBXInt32Value,
      ///  given by the parameter.
      ///</summary>
      ///<returns>Returns 0 if the two values are equal, 1 if the current
      ///  TDBXInt32Value is greater than Other, and -1 otherwise.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.Int64Type</c> values.
  ///</summary>
  TDBXInt64Value = class(TDBXWritableValue)
    private
      FInt64: Int64;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Returns the Int64 value.</summary>
      /// <returns> The Int64 value.</returns>
      function GetInt64: Int64; override;
      /// <summary>Sets the Int64 value.</summary>
      procedure SetInt64(const Value: Int64); override;
      /// <summary>Applies a type conversion from Int64 to string.</summary>
      /// <returns> an string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Compares the Int64 to 0</summary>
      /// <returns> a Boolean representation of the comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from Int64 to Byte.</summary>
      /// <returns> a Byte representation of the value.</returns>
      function GetAsUInt8: Byte; override;
      /// <summary>Applies a type conversion from Int64 to ShortInt.</summary>
      /// <returns> a ShortInt representation of the value.</returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from Int64 to Word.</summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from Int64 to SmallInt.</summary>
      /// <returns> a SmallInt representation of the value.</returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from Int64 to LongInt.</summary>
      /// <returns> a LongInt representation of the value.</returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Returns the Int64 value.</summary>
      /// <returns> the Int64 value.</returns>
      function GetAsInt64: Int64; override;
      /// <summary>Applies a type conversion from Int64 to Single.</summary>
      /// <returns> a Single representation of the value.</returns>
      function GetAsSingle: Single; override;
      /// <summary>Applies a type conversion from Int64 to Double.</summary>
      /// <returns> a Double representation of the value.</returns>
      function GetAsDouble: Double; override;
      /// <summary>Applies a type conversion from Int64 to TBcd.</summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Sets the value after applying a type conversion from string
      ///   to Int64.
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from Boolean
      ///   to Int64.
      /// </summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Byte
      ///   to Int64.
      /// </summary>
      procedure SetAsUInt8(const Value: Byte); override;
      /// <summary>Sets the value after applying a type conversion from ShortInt
      ///   to Int64.
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from Word
      ///   to Int64.
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt
      ///   to Int64.
      /// </summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from LongInt
      ///   to Int64.
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the Int64 value.</summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the value after applying a type conversion from Single
      ///   to Int64.  An exception is raised if Value <= Low(Int64)
      ///   or Value >= High(Int64).
      /// </summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the value after applying a type conversion from Double
      ///   to Int64.  An exception is raised if Value <= Low(Int64)
      ///   or Value >= High(Int64).
      /// </summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the value after applying a type conversion from TBcd
      ///   to Int64.  An exception is raised if Value <= Low(Int64)
      ///   or Value >= High(Int64).
      /// </summary>
      procedure SetAsBcd(const Value: TBcd); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXInt64Value with another TDBXInt64Value,
      ///  given by the parameter.
      ///</summary>
      ///<returns>Returns 0 if the two values are equal, 1 if the current
      ///  TDBXInt64Value is greater than Other, and -1 otherwise.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
      /// <summary>Compares the TDBXInt64Value with another TDBXInt64Value,
      ///   given by the parameter.
      /// </summary>
      /// <returns>true if the values are equal.</returns>
      function EqualsValue(Other: TDBXValue): Boolean; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.DoubleType</c> values.
  ///</summary>
  TDBXDoubleValue = class(TDBXWritableValue)
    private
      FDouble: Double;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Returns the Double value</summary>
      /// <returns> the Double value.</returns>
      function GetDouble: Double; override;
      /// <summary>Sets the Double value</summary>
      procedure SetDouble(const Value: Double); override;
      /// <summary>Applies a type conversion from Double to string.</summary>
      /// <returns> a string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Compares the Double to 0</summary>
      /// <returns> a Boolean representation of the comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from Double to Byte.  Result is rounded.</summary>
      /// <returns> a Byte representation of the value.</returns>
      function GetAsUInt8: Byte; override;
      /// <summary>Applies a type conversion from Double to ShortInt.  Result is rounded.</summary>
      /// <returns> a ShortInt representation of the value.</returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from Double to Word.  Result is rounded.</summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from Double to SmallInt.  Result is rounded.</summary>
      /// <returns> a SmallInt representation of the value.</returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from Double to LongInt.  Result is rounded.</summary>
      /// <returns> a LongInt representation of the value.</returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Applies a type conversion from Double to Int64.  Result is rounded.</summary>
      /// <returns> a Int64 representation of the value.</returns>
      function GetAsInt64: Int64; override;
      /// <summary>Applies a type conversion from Double to Single.</summary>
      /// <returns> a Single representation of the value.</returns>
      function GetAsSingle: Single; override;
      /// <summary>Returns the double value</summary>
      /// <returns> the double value.</returns>
      function GetAsDouble: Double; override;
      /// <summary>Applies a type conversion from Double to TBcd.</summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Sets the value after applying a type conversion from string
      ///   to Double.  If the value cannot be converted, 0 is set instead.
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from Boolean
      ///   to Double.
      /// </summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Byte
      ///   to Double.
      /// </summary>
      procedure SetAsUInt8(const Value: Byte); override;
      /// <summary>Sets the value after applying a type conversion from ShortInt
      ///   to Double.
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from Word
      ///   to Double.
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt
      ///   to Double.
      /// </summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from LongInt
      ///   to Double.
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from Int64
      ///   to Double.
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the value after applying a type conversion from Single
      ///   to Double.
      /// </summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the Double value.</summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the value after applying a type conversion from TBcd
      ///   to Double.
      /// </summary>
      procedure SetAsBcd(const Value: TBcd); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXDoubleValue with another TDBXDoubleValue given
      ///  by a parameter.
      ///</summary>
      ///<results> returns -1 if the current TDBXDoubleValue is smaller than
      ///  Other, 1 if the current TDBXDoubleValue is greater than Other, and 0
      ///  if they are equal.
      ///</results>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.SingleType</c> values.
  ///</summary>
  TDBXSingleValue = class(TDBXWritableValue)
    private
      FSingle: Single;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Returns the Single value.</summary>
      /// <returns> the Single value.</returns>
      function GetSingle: Single; override;
      /// <summary>Sets the Single value</summary>
      procedure SetSingle(const Value: Single); override;
      /// <summary>Applies a type conversion from Single to string.</summary>
      /// <returns> an string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Compares the Single to 0</summary>
      /// <returns> a Boolean representation of the comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from Single to Byte.  Result is rounded</summary>
      /// <returns> a Byte representation of the value.</returns>
      function GetAsUInt8: Byte; override;
      /// <summary>Applies a type conversion from Single to ShortInt.  Result is rounded</summary>
      /// <returns> a ShortInt representation of the value.</returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from Single to Word.  Result is rounded</summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from Single to SmallInt.  Result is rounded</summary>
      /// <returns> a SmallInt representation of the value.</returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from Single to LongInt.  Result is rounded</summary>
      /// <returns> a LongInt representation of the value.</returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Applies a type conversion from Single to Int64.  Result is rounded</summary>
      /// <returns> an Int64 representation of the value.</returns>
      function GetAsInt64: Int64; override;
      /// <summary>Returns the Single value.</summary>
      /// <returns> the Single value.</returns>
      function GetAsSingle: Single; override;
      /// <summary>Applies a type conversion from Single to Double.</summary>
      /// <returns> a Double representation of the value.</returns>
      function GetAsDouble: Double; override;
      /// <summary>Applies a type conversion from Single to TBcd.</summary>
      /// <returns> a TBcd representation of the value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Sets the value after applying a type conversion from string
      ///   to Single.
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from Boolean
      ///   to Single.
      /// </summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Byte
      ///   to Single.
      /// </summary>
      procedure SetAsUInt8(const Value: Byte); override;
      /// <summary>Sets the value after applying a type conversion from ShortInt
      ///   to Single.
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from Word
      ///   to Single.
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt
      ///   to Single.
      /// </summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from LongInt
      ///   to Single.
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from Int64
      ///   to Single.
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the Single value</summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the value after applying a type conversion from Double
      ///   to Single.
      /// </summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the value after applying a type conversion from TBcd
      ///   to Single.
      /// </summary>
      procedure SetAsBcd(const Value: TBcd); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXSingleValue with another TDBXSingleValue,
      ///  given by the parameter.
      ///</summary>
      ///<returns>Returns 0 if the two values are equal, 1 if the current
      ///  TDBXSingleValue is greater than Other, and -1 otherwise.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.BcdType</c> values.
  ///</summary>
  TDBXBcdValue = class(TDBXWritableValue)
    private
      FBcd: TBcd;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      /// <summary>Returns True if the value is null.</summary>
      /// <returns> True if the value is null.</returns>
      function IsNull: Boolean; override;
      /// <summary>Gets the TBcd value.</summary>
      /// <returns> the TBcd value.</returns>
      function GetBcd: TBcd; override;
      /// <summary>Sets the TBcd value.</summary>
      procedure SetBcd(const Value: TBcd); override;
      /// <summary>Applies a type conversion from TBcd to string.</summary>
      /// <returns> an string representation of the value.</returns>
      function GetAsString: string; override;
      /// <summary>Compares the TBcd to '0'</summary>
      /// <returns> a Boolean representation of the string comparison.</returns>
      function GetAsBoolean: Boolean; override;
      /// <summary>Applies a type conversion from TBcd to Byte.</summary>
      /// <returns> a Byte representation of the value.</returns>
      function GetAsUInt8: Byte; override;
      /// <summary>Applies a type conversion from TBcd to ShortInt.</summary>
      /// <returns> a ShortInt representation of the value.</returns>
      function GetAsInt8: ShortInt; override;
      /// <summary>Applies a type conversion from TBcd to Word.</summary>
      /// <returns> a Word representation of the value.</returns>
      function GetAsUInt16: Word; override;
      /// <summary>Applies a type conversion from TBcd to SmallInt.</summary>
      /// <returns> a SmallInt representation of the value.</returns>
      function GetAsInt16: SmallInt; override;
      /// <summary>Applies a type conversion from TBcd to LongInt.</summary>
      /// <returns> a LongInt representation of the value.</returns>
      function GetAsInt32: TInt32; override;
      /// <summary>Applies a type conversion from TBcd to Int64.</summary>
      /// <returns> an Int64 representation of the value.</returns>
      function GetAsInt64: Int64; override;
      /// <summary>Applies a type conversion from TBcd to Single.</summary>
      /// <returns> a Single representation of the value.</returns>
      function GetAsSingle: Single; override;
      /// <summary>Applies a type conversion from TBcd to Double.</summary>
      /// <returns> a Double representation of the value.</returns>
      function GetAsDouble: Double; override;
      /// <summary>Returns the TBcd value.</summary>
      /// <returns> The TBcd value.</returns>
      function GetAsBcd: TBcd; override;
      /// <summary>Sets the value after applying a type conversion from string
      ///   to TBcd.
      /// </summary>
      procedure SetAsString(const Value: string); override;
      /// <summary>Sets the value after applying a type conversion from Boolean
      ///   to TBcd.
      /// </summary>
      procedure SetAsBoolean(const Value: Boolean); override;
      /// <summary>Sets the value after applying a type conversion from Byte
      ///   to TBcd.
      /// </summary>
      procedure SetAsUInt8(const Value: Byte); override;
      /// <summary>Sets the value after applying a type conversion from ShortInt
      ///   to TBcd.
      /// </summary>
      procedure SetAsInt8(const Value: ShortInt); override;
      /// <summary>Sets the value after applying a type conversion from Word
      ///   to TBcd.
      /// </summary>
      procedure SetAsUInt16(const Value: Word); override;
      /// <summary>Sets the value after applying a type conversion from SmallInt
      ///   to TBcd.
      /// </summary>
      procedure SetAsInt16(const Value: SmallInt); override;
      /// <summary>Sets the value after applying a type conversion from LongInt
      ///   to TBcd.
      /// </summary>
      procedure SetAsInt32(const Value: TInt32); override;
      /// <summary>Sets the value after applying a type conversion from Int64
      ///   to TBcd.
      /// </summary>
      procedure SetAsInt64(const Value: Int64); override;
      /// <summary>Sets the value after applying a type conversion from Single
      ///   to TBcd.
      /// </summary>
      procedure SetAsSingle(const Value: Single); override;
      /// <summary>Sets the value after applying a type conversion from Double
      ///   to TBcd.
      /// </summary>
      procedure SetAsDouble(const Value: Double); override;
      /// <summary>Sets the TBcd value</summary>
      procedure SetAsBcd(const Value: TBcd); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXBcdValue with another TDBXBcdValue,
      ///  given by the parameter.
      ///</summary>
      ///<returns>Returns 0 if the two values are equal, 1 if the current
      ///  TDBXBcdValue is greater than Other, and -1 otherwise.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.ByteArrayType</c> values.
  ///</summary>
  TDBXByteArrayValue = class(TDBXWritableValue)
    private
      // There is an issue dynalink driver output params that have been
      // handled with the use of a second FNullGeneration in addition to FGeneration.
      // The dynalink drivers do not implement support for getting the length using GetValueSize.
      // of a blob output parameter.  There is support for getting the length of
      // blob reader values.  This creates some challenges since the implementation
      // of IsNull relies on calling GetValueSize.  The null value is retrieved
      // when calling GetBytes to get the actual value.  However since these values
      // are large, they are not saved of as most other value do.  They have to be
      // retrieved for each call to GetBytes.  A separate generation for
      // null is used so that IsNull does not need to call GetValueLength if GetBytes has
      // already been called.  Ideally we would add support for GetValueSize in
      // the dynalink drivers.  If this is done, we could get rid fof FNullGeneration,
      // However it can provide a slight performance in cases where the GetBytes is called
      // and then IsNull is called.
      FNullGeneration:  TInt32;
      // Memo field class extensions use this to save off the value read from GetBytes.
      FBytes:           TArray<Byte>;
      FByteLength:      Int64;
      FOffset:          Int64;
      FBufferOffset:    Int64;
      FOverFlowBytes:   TDBXStreamReader;

      procedure SetRowValue; override;
      procedure SetOverflowBytes(const OverFlowBytes: TDBXStreamReader);
      function GetStreamReader: TDBXStreamReader; override;
    protected
      constructor Create(ValueType: TDBXValueType);
    public
      destructor Destroy; override;
      function IsNull: Boolean; override;
      function GetBytes(Offset: Int64; const Buffer: TArray<Byte>; BufferOffset, Length: Int64): Int64; override;
      function GetValueSize: Int64; override;
      procedure SetStaticBytes( Offset:       Int64;
                          const Buffer: array of Byte;
                          BufferOffset: Int64;
                          Length:       Int64); override;
      procedure SetDynamicBytes( Offset:       Int64;
                          const Buffer:   TArray<Byte>;
                          BufferOffset: Int64;
                          Length:       Int64); override;
  end;

  ///<summary>
  ///  Used internally by driver implementations and <c>TDBXStreamValue</c>
  ///</summary>
  TDBXStreamReader = class abstract
  public
    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Size: Integer): Integer; virtual; abstract;
    function Eos: Boolean; virtual; abstract;
    function Size: Int64; virtual; abstract;
    procedure Close; virtual; abstract;
  end;

  ///<summary>
  ///  Used internally by driver implementations and <c>TDBXStreamValue</c>
  ///</summary>
  TDBXLookAheadStreamReader = class(TDBXStreamReader)
    private
      FStream:            TStream;
      FEOS:               Boolean;
      FHasLookAheadByte:  Boolean;
      FLookAheadByte:     Byte;
      FInstanceOwner:     Boolean;
    public
      destructor Destroy; override;
      procedure SetStream(const Stream: TStream; const AInstanceOwner: Boolean);
      function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
      function Eos: Boolean; override;
      function Size: Int64; override;
      procedure Close; override;
      function ConvertToMemoryStream: TStream;
      ///<summary>Used internally by driver implementations and TDBXStreamValue.
      ///  If InstanceOwner is true then the stream referenced is freed when
      ///  TDBXLookAheadStreamReader is destroyed.
      ///</summary>
      property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
  end;

  ///<summary>
  ///  Used internally by driver implementations and <c>TDBXStreamValue</c>
  ///</summary>
  TDBXByteStreamReader = class(TDBXStreamReader)
    FBytes:             TArray<Byte>;
    FOffset:            Integer;
    FCount:             Integer;
    FPosition:          Integer;
    FEOS:               Boolean;
    private
    public
      constructor Create(Bytes: TArray<Byte>; Offset: Integer; Count: Integer);
      destructor Destroy; override;
      function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
      function Eos: Boolean; override;
      function Size: Int64; override;
      procedure Close; override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.ByteArrayType</c> values.
  ///</summary>
  TDBXStreamValue = class(TDBXByteArrayValue)
    private
      FStreamStreamReader:    TDBXLookAheadStreamReader;
      FByteStreamReader:      TDBXByteStreamReader;
      FExtendedType:          Boolean;
      FLastSize:              Integer;
      FInstanceOwner:         Boolean;
      FLastReadStream:        TStream;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
      function GetStreamReader: TDBXStreamReader; override;
      procedure FreeLastReadStream;
    protected
      procedure SetAsVariant(const Value: OleVariant); override;
    public
      constructor Create(ValueType: TDBXValueType);
      procedure UpdateType; override;
      procedure SetNull; override;
      destructor Destroy; override;
//      function  IsNull: Boolean; override;
      function  GetStream(AInstanceOwner: Boolean): TStream; override;
      function  GetStream: TStream; override;
      function  GetValueSize: Int64; override;
      procedure SetDynamicBytes( Offset:       Int64;
                          const Buffer:   TArray<Byte>;
                          BufferOffset: Int64;
                          Count:       Int64); override;
      procedure SetStream(const Stream: TStream; const AInstanceOwner: Boolean); override;
      procedure SetValue(const Value: TDBXValue); override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.WideStringType</c> values.
  ///</summary>
  TDBXWideCharsValue = class(TDBXWideStringValue)
    private
      FCount:               Integer;
      FWideChars:           TDBXWideChars;
      FRefValue:            string;
      procedure UpdateType; override;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    protected
      property WideCharsCount: Integer Read FCount;
      property WideChars: TDBXWideChars read FWideChars;
    public
      constructor Create(ValueType: TDBXValueType);
      destructor Destroy; override;
      function IsNull: Boolean; override;
      procedure SetWideString(const Value: string); override;
      function GetWideString: string; override;
      function  GetStream(AInstanceOwner: Boolean): TStream; override;
      function GetValueSize: Int64; override;
      function GetBytes(Offset: Int64; const Value: TArray<Byte>; BufferOffset, Length: Int64): Int64; overload; override;
      procedure SetDynamicBytes(Offset: Int64; const Buffer: TArray<Byte>; BufferOffset, Length: Int64); override;
      ///<summary>Compare compares the current TDBXWideCharsValue with the Other parameter, without case sensitivity.</summary>
      ///<returns>Returns a value less than 0 if the current TDBXWideCharsValue
      ///  is smaller than Other, a value greater than 0 if the current
      ///  TDBXWideCharsValue is greater than Other, and 0 if they are equal.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  TDBXStringValue = class(TDBXWideStringValue)
    private
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      constructor Create(ValueType: TDBXValueType);
      destructor Destroy; override;
      function IsNull: Boolean; override;
      function GetWideString: string; override;
      procedure SetWideString(const Value: string); override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.AnsiStringType</c> values.
  ///</summary>
  TDBXAnsiCharsValue = class(TDBXAnsiStringValue)
    private
      FCount:               Integer;
      FBytes:               TArray<Byte>;
      FRefValue:            TArray<Byte>;
      procedure UpdateType; override;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      constructor Create(ValueType: TDBXValueType);
      function IsNull: Boolean; override;
{$IFNDEF NEXTGEN}
      procedure SetAnsiString(const Value: AnsiString); override;
      function GetAnsiString: AnsiString; override;
{$ELSE}
      procedure SetString(const Value: string); override;
      function GetString: string; override;
{$ENDIF}
      function GetStream(AInstanceOwner: Boolean): TStream; override;
      function GetValueSize: Int64; override;
      function GetBytes(Offset: Int64; const Value: TArray<Byte>; BufferOffset, Length: Int64): Int64; overload; override;
      procedure SetStaticBytes( Offset:       Int64;
                          const Buffer: array of Byte;
                          BufferOffset: Int64;
                          Length:       Int64); override;
      procedure SetDynamicBytes( Offset:       Int64;
                          const Buffer:   TArray<Byte>;
                          BufferOffset: Int64;
                          Length:       Int64); override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.TimeStampType</c> values.
  ///</summary>
  TDBXTimeStampValue = class(TDBXWritableValue)
    private
      FTimeStamp: TSQLTimeStamp;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      function IsNull: Boolean; override;
      function GetTimeStamp: TSQLTimeStamp; override;
      procedure SetTimeStamp(const Value: TSQLTimeStamp); override;
      function GetAsString: string; override;
      function GetAsDate: TDBXDate; override;
      function GetAsTime: TDBXTime; override;
      function GetAsTimeStamp: TSQLTimeStamp; override;
      function GetAsDateTime: TDateTime; override;
      procedure SetAsString(const Value: string); override;
      procedure SetAsDate(const Value: TDBXDate); override;
      procedure SetAsTime(const Value: TDBXTime); override;
      procedure SetAsTimeStamp(const Value: TSQLTimeStamp); override;
      procedure SetAsDateTime(const Value: TDateTime); override;
      procedure SetValue(const Value: TDBXValue); override;
      ///<summary>Compares the TDBXTimeStampValue with another TDBXTimeStampValue,
      ///  given by the parameter.
      ///</summary>
      ///<returns>Returns 0 if the two values are equal, 1 if the current
      ///  TDBXTimeStampValue is greater than Other, and -1 otherwise.
      ///</returns>
      function Compare(Other: TDBXValue): Smallint; override;
  end;

  TDBXTimeStampOffsetValue = class(TDBXWritableValue)
    private
      FTimeStampOffset: TSQLTimeStampOffset;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    public
      function IsNull: Boolean; override;
      function GetTimeStampOffset: TSQLTimeStampOffset; override;
      procedure SetTimeStampOffset(const Value: TSQLTimeStampOffset); override;
      function GetAsString: string; override;
//      function GetAsDate: TDBXDate; override;
//      function GetAsTime: TDBXTime; override;
//      function GetAsTimeStamp: TSQLTimeStamp; override;
//      function GetAsDateTime: TDateTime; override;
      procedure SetAsString(const Value: string); override;
//      procedure SetAsDate(const Value: TDBXDate); override;
//      procedure SetAsTime(const Value: TDBXTime); override;
//      procedure SetAsTimeStamp(const Value: TSQLTimeStamp); override;
//      procedure SetAsDateTime(const Value: TDateTime); override;
      procedure SetValue(const Value: TDBXValue); override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.DbxTableType</c>.
  ///</summary>
  TDBXReaderValue = class(TDBXWritableValue)
    private
      FDBXReader: TDBXReader;
      FRowReader: Boolean;
      FHandle:    Integer;
      FInstanceOwner: Boolean;
      FMaxRows:   Integer;
      procedure SetRowValue; override;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    protected
      function GetHandle: Integer; virtual;
      procedure SetHandle(const Handle: Integer); virtual;
    public
      destructor Destroy; override;
      function IsNull: Boolean; override;
      function GetDBXReader: TDBXReader; override;
      function GetDBXReader(AInstanceOwner: Boolean): TDBXReader; override;
      procedure SetDBXReader(const Value: TDBXReader; const AInstanceOwner: Boolean); overload; override;
      function GetMaxRows: Integer; virtual;
      procedure SetValue(const Value: TDBXValue); override;
      procedure SetNull; override;
      property Handle: Integer read GetHandle write SetHandle;
  end;
  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.DbxConnectionType</c>.
  ///</summary>
  TDBXConnectionValue = class(TDBXWritableValue)
    private
      FDBXConnection: TDBXConnection;
      procedure SetRowValue; override;
    public
      destructor Destroy; override;
      function IsNull: Boolean; override;
      function GetDBXConnection: TDBXConnection; override;
      procedure SetDBXConnection(const Value: TDBXConnection); override;
      procedure SetValue(const Value: TDBXValue); override;
  end;


  ///<summary>
  ///  A context object mostly of use to DBX driver writers.  Access to a TDBXContext
  ///  instance should not be provided applications using the DBX framework.  The TDBXContext
  ///  contains members that need to be shared across a single TDBXConnection
  ///  and all of the objects such as a TDBXCommand or a TDBXReader.
  ///  All objects created directly or indirectly from a TDBXConnection use
  ///  the same instance of TDBXContext as the TDBXConnection they were created
  ///  by.
  ///</summary>
  TDBXContext = class
    private
      FOnError:               TDBXErrorEvent;
      FOnTrace:               TDBXTraceEvent;
      FTraceFlags:            TDBXTraceFlag;
      FTraceLevel:            TDBXTraceLevel;

      FClosedByteReader:      TDBXByteReader;
      FDBXFormatter:          TDBXFormatter;

      procedure SetOnError(const Value: TDBXErrorEvent);
      procedure SetOnTrace(const Value: TDBXTraceEvent);
      procedure SetTraceFlags(const Value: TDBXTraceFlag);
      procedure SetTraceLevel(const Value: TDBXTraceFlag);
      procedure SetDBXFormatter(const DBXFormatter: TDBXFormatter);

    protected
      [Weak]FOnErrorDBXContext:     TDBXContext;
      [Weak]FOnTraceDBXContext:     TDBXContext;

      function Trace(TraceLevel:  TDBXTraceLevel; TraceFlag: TDBXTraceFlag; CustomCategory: string; TraceMessage: string): CBRType; overload;
      constructor Create(DBXContext: TDBXContext); overload;
    public
      constructor Create; overload;
      destructor Destroy; override;

      ///<summary>
      ///  Is tracing enabled for the TDBXTraceFlag
      ///</summary>
      function IsTracingLevel(TraceLevel:  TDBXTraceLevel): Boolean;
      ///<summary>
      ///  Is tracing enabled for the TDBXTraceFlag
      ///</summary>
      function IsTracing(TraceFlags:  TDBXTraceFlag): Boolean;
      ///<summary>
      ///  Is tracing enabled for this Category
      ///</summary>
      function IsTracingCategory(Category:  string): Boolean;
      ///<summary>
      ///  Call the TDBXTraceEvent handler with TraceFlag and TraceMessage.
      ///</summary>
      function Trace(TraceFlag: TDBXTraceFlag; TraceMessage: string): CBRType; overload;
      ///<summary>
      ///  Call the TDBXTraceEvent handler with TraceLevel, TraceFlag and TraceMessage.
      ///</summary>
      function Trace(TraceLevel:  TDBXTraceLevel; TraceFlag: TDBXTraceFlag; TraceMessage: string): CBRType; overload;
      ///<summary>
      ///  Call the TDBXTraceEvent handler with TraceLevel, CustomCategory and TraceMessage.
      ///</summary>
      function Trace(TraceLevel:  TDBXTraceLevel; CustomCategory: string; TraceMessage: string): CBRType; overload;
      ///<summary>
      ///  Call the TDBXErrorEvent with ErrorCode and ErrorMessage.
      ///</summary>
      procedure Error(ErrorCode: TDBXErrorCode; ErrorMessage: string); overload;
      ///<summary>
      ///  Call the TDBXErrorEvent with ErrorCode and ErrorMessage.
      ///</summary>
      procedure Error(ErrorCode: TDBXErrorCode; ErrorMessage: string; InnerException: Exception); overload;

      ///<summary>
      ///  Get or set the TDBXErrorEvent handler.
      ///</summary>
      property OnError:    TDBXErrorEvent read FOnError write SetOnError;
      ///<summary>
      ///  Get or set the TDBXTraceEvent handler.
      ///</summary>
      property OnTrace:    TDBXTraceEvent read FOnTrace write SetOnTrace;
      ///<summary>
      ///  Get or set the collection of TDBXTraceFlags constants to enable
      ///  tracing for.
      ///</summary>
      property TraceFlags: TDBXTraceFlag read FTraceFlags write SetTraceFlags;
      ///<summary>
      ///  Get or set the trace level to one of the values in <c>TDBXTraceLevels</c>
      ///</summary>
      property TraceLevel: TDBXTraceLevel read FTraceLevel write SetTraceLevel;
      ///<summary>
      ///  Used by the framework to mark TDBXByteReaders that have no more rows
      ///  as being closed.
      ///</summary>
      property ClosedByteReader: TDBXByteReader read FClosedByteReader;
    ///<summary>
    /// The TDBXFormatter instance used to parse and format string representations
    ///  for <c>TDBXDate</c>, <c>TDBXTime</c>, <c>TSqlTimeStamp</c>, and <c>TBcd</c> values
    ///  using the "As" properties of <c>TDBXValue</c> and <c>TDBXWritableValue</c>.
    ///  The <c>TDBXConnectionFactory</c> provides a default implementation of
    ///  <c>TDBXFormatter</c> for all connections.
    ///</summary>
      property DBXFormatter: TDBXFormatter read FDBXFormatter write SetDBXFormatter;
  end;

  ///<summary>
  ///  Used by dbExpress related TDataSet components.
  ///  Allows for primitive retrieval of data using byte arrays.
  ///  Not for general usage.
  ///</summary>
  TDBXByteReader = class
    strict protected
      [Weak]FDBXContext: TDBXContext;
    protected
      constructor Create(DBXContext: TDBXContext);
    public
{$IFNDEF NEXTGEN}
      procedure GetAnsiString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
{$ENDIF !NEXTGEN}
      procedure GetWideString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      ///<summary>
      /// Abstract method whose intent is to allow retrieval of Word values
      /// into a byte array. TDBXByteReader descendants must implement this method.
      ///</summary>
      procedure GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetInt32(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetInt64(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetSingle(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetDouble(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetBcd(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetTimeStamp(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetTimeStampOffset(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetTime(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;
      procedure GetDate(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual; abstract;

      procedure GetByteLength(Ordinal: TInt32; var Length: Int64; var IsNull: LongBool); virtual; abstract;
      function  GetBytes(Ordinal: TInt32; Offset: Int64; const Value: TArray<Byte>;
                                 ValueOffset, Length: Int64; var IsNull: LongBool): Int64; virtual; abstract;
      procedure GetBoolean(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); virtual;
  end;

  ///<summary>
  ///  Used by driver implementors that do not want to provide an optimized
  ///  TDBXByteReader implementation.  This is an implementation of
  ///  TDBXByteReader on top of a TDBXReader implementation.
  ///</summary>
  TDBXReaderByteReader = class(TDBXByteReader)
    private
      [Weak]FDbxReader:  TDBXReader;
    public
      constructor Create(DBXContext: TDBXContext; DbxReader: TDBXReader);
{$IFNDEF NEXTGEN}
      procedure GetAnsiString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
{$ENDIF !NEXTGEN}
      procedure GetWideString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
                                                                                           
//      and allow these to be treated as 16-bit unsigned/signed integers
      ///<summary>Returns the Word value for a TDBXReaderByteReader instance in an array of bytes.</summary>
      procedure GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetInt32(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetInt64(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetSingle(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetDouble(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetBcd(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetTimeStamp(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetTimeStampOffset(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetTime(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetDate(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;

      procedure GetByteLength(Ordinal: TInt32; var Length: Int64; var IsNull: LongBool); override;
      function  GetBytes(Ordinal: TInt32; Offset: Int64; const Value: TArray<Byte>;
                                 ValueOffset, Length: Int64; var IsNull: LongBool): Int64; override;
  end;

  ///<summary>
  ///  Used internally by <c>TDBXParameterList</c> to manage a list of
  ///  <c>TDBXValueType</c> instances.
  ///</summary>
  TDBXValueTypeList = class
    strict private
      FValueTypeArray:  array of TDBXValueType;
      FLastOrdinal:     Integer;
      function FindOrdinal(const Name: string; StartOrdinal, EndOrdinal: TInt32): TInt32; virtual;
    private
      function  GetValueType(const Ordinal: TInt32): TDBXValueType; inline;
      function  GetOrdinal(const Name: string): TInt32; virtual;
      procedure SetCount(const Count: TInt32);
      function  GetCount: TInt32;
      procedure Add(ValueType: TDBXValueType);
      procedure Insert(Ordinal: TInt32; ValueType: TDBXValueType);
      procedure Remove(ValueType: TDBXValueType); overload;
      procedure Remove(Ordinal: TInt32); overload;
      procedure SetValueType(const Ordinal: TInt32; ValueType: TDBXValueType);
      procedure Clear;
      procedure RemoveAll;
      property Count: TInt32 read GetCount;
      property Values[const Ordinal: TInt32]: TDBXValueType read GetValueType; default;
    public
      destructor  Destroy; override;
  end;

//  TDBXTableRow = class abstract
//  protected
//    function GetOriginalRow: TDBXTableRow; virtual; abstract;
//    function GetColumns: TDBXValueTypeArray; virtual; abstract;
//    procedure SetColumns(const Columns: TDBXValueTypeArray); virtual; abstract;
//    procedure SetDBXTableName(const Name: string); virtual; abstract;
//    function GetDBXTableName: string; virtual;  abstract;
//    function GetDBXContext: TDBXContext; virtual; abstract;
//    procedure SetDBXContext(Context: TDBXContext); virtual; abstract;
//  public
//    function GetOrdinal(const ColumnName: string): Integer; virtual; abstract;
//    function GetValue(const Ordinal: Integer): TDBXWritableValue; virtual; abstract;
//  public
//    property DBXTableName: string read GetDBXTableName write SetDBXTableName;
//    property OriginalRow: TDBXTableRow read GetOriginalRow;
//    property Columns: TDBXValueTypeArray read GetColumns write SetColumns;
//    property Values[const Ordinal: TInt32]: TDBXWritableValue read GetValue; default;
//
//  end;


//------------------------------------------------------------------------------
// Classes below should only be of interest to driver implementors.
//------------------------------------------------------------------------------

  ///<summary>
  ///  Only used by driver implementors to have access to private or protected
  ///  constructors, procedures or functions.
  ///</summary>
  TDBXDriverHelp = class
  public
    class function CreateTDBXParameter(DBXContext: TDBXContext): TDBXParameter; static;
    class function CreateTDBXValueType(DBXContext: TDBXContext): TDBXValueType; overload; static;
    class function CreateTDBXValueType(DBXContext: TDBXContext; DBXRow: TDBXRow): TDBXValueType; overload; static;
    class function CreateTDBXProperties(DBXContext: TDBXContext): TDBXProperties; static;
    class function CreateTDBXContext: TDBXContext; static;
    class function GetStreamReader(Value: TDBXValue): TDBXStreamReader; overload; static;
    class procedure UpdateParameterType(Parameter: TDBXParameter);
    class function IsReadOnlyValueType(ValueType: TDBXValueType): Boolean; static;
    class procedure SetPendingValue(Value: TDBXWritableValue);
    class function GetNonDelegate(Value: TDBXValue): TDBXValue; static; inline;
    class procedure SetOverflowBytes(Value: TDBXByteArrayValue; streamReader: TDBXByteStreamReader); overload; static; inline;
    class procedure SetOverflowBytes(Value: TDBXWideStringValue; streamReader: TDBXByteStreamReader); overload; static; inline;
    class procedure SetOverflowBytes(Value: TDBXAnsiStringValue; streamReader: TDBXByteStreamReader); overload; static; inline;
    class function HasOverflowBytes(Value: TDBXWritableValue): Boolean; static; inline;
    class procedure CopyRowValue(Value: TDBXValue; DBXRow: TDBXRow); static; inline;
    class function GetConnection(ConnectionFactory: TDBXConnectionFactory;
                                 DBXContext: TDBXContext;
                                 ConnectionName: string
                                 ): TDBXConnection; static; inline;
    class procedure SetMetaDataReader(Connection: TDBXConnection; MetaDataReader: TObject); static;
    class function GetMetaDataReader(Connection: TDBXConnection): TObject; static;
end;

  ///<summary>
  ///  Used by driver implementors.
  ///  <c>TDBXDriverLoader</c> implementations can be registered with the
  ///  <c>TDBXDriverRegistry</c> to load a driver by a string based name.
  ///</summary>
  TDBXDriverLoader = class(TClassRegistryObject)
    protected
      FLoaderName:            string;
    public
  ///<summary>
  ///  Load the driver using the provided parameters in <c>DriverDef</c>.
  ///</summary>
      function Load(DriverDef: TDBXDriverDef): TDBXDriver; virtual; abstract;
  end;

  TDBXDriverLoaderClass = class of TDBXDriverLoader;

  ///<summary>
  ///  Used by driver implementors.
  ///  A registry of <c>TDBXDriverLoader</c>s that is keyed by a string
  ///  name for the driver.
  ///</summary>
  TDBXDriverRegistry = class
    private
      FDriverLoaders: TDictionary<string, TDBXDriverLoader>;
      FDriverClasses: TDictionary<string, TDBXDriverClass>;
      FCounter: Integer;
      FDrivers: TThreadList<TDBXDriver>;
      class var
        DBXDriverRegistry: TDBXDriverRegistry;

      function  FindDriver(List: TList<TDBXDriver>; const DriverName: string): Integer;
      procedure FreeAllDrivers(Loader: TDBXDriverLoader);
      procedure FreeAllLoaders;
      procedure InternalRegisterLoader(const LoaderClassName: string; Loader: TDBXDriverLoader);
      procedure LoadMetaDataCommandFactory(Driver: TDBXDriver);
      function  LoadDriver(DriverDef: TDBXDriverDef; List: TList<TDBXDriver>): TDBXDriver;

      function  GetDriver(DriverDef: TDBXDriverDef): TDBXDriver;
      procedure DriverLoadError(DriverDef: TDBXDriverDef; PackageName: string);
      procedure FreeDriver(Driver: TDBXDriver);
      procedure CloseAllDrivers;
      procedure GetRegisteredDriverNames(DriverNameList: TStringList);
      procedure GetRegisteredDriverLoaderNames(DriverLoaderNameList: TStringList);
      procedure GetRegisteredDriverClassNames(DriverClassNameList: TStringList);
    public
      constructor Create;
      destructor Destroy; override;

      class procedure RegisterDriverClass(DriverName: string; DriverClass: TDBXDriverClass); static;
      class procedure UnregisterDriverClass(DriverName: string); static;
      class procedure RegisterDriver(DriverName: string; Driver: TDBXDriver); static;
  end;

  ///<summary>
  ///  Delegate driver base class.
  ///  The TDBXConnectionFactory.GetDriver method also returns an instance
  ///  of TDBXDelegateDriver so that it can control the loading and unloading
  ///  of drivers.
  ///</summary>
  TDBXDelegateDriver = class(TDBXDriver)
  private
    [Weak]FDriver:    TDBXDriver;
  protected
    function  GetDriverProperties: TDBXProperties; override;
    procedure InitDriverProperties(const DriverProperties: TDBXProperties); override;
    function  GetDriverName: string; override;
    procedure SetDriverName(const DriverName: string); override;
    function  CreateConnection(ConnectionBuilder:  TDBXConnectionBuilder): TDBXConnection; override;
    procedure Close; override;
    function  CreateMorphCommand(DbxContext: TDBXContext; Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand; override;
  public
    constructor Create(Driver: TDBXDriver);
    destructor Destroy; override;
    function GetDriverClass: TClass; override;
    function GetDriverVersion: string; override;
  end;

  ///<summary>
  ///  Used by driver implementors.
  ///</summary>
  TDBXDelegateItem = class
    private
      procedure FreeProperties;
    public
      FName:        string;
      FProperties:  TDBXProperties;
      FNext:        TDBXDelegateItem;
      destructor Destroy; override;
  end;

  ///<summary>
  ///  Used by driver implementors.
  ///</summary>
  TDBXPropertiesItem = class
    FProperties:    TDBXProperties;
    FDeletgatePath: TDBXDelegateItem;
    constructor Create(Properties: TDBXProperties);
    destructor Destroy; override;
  end;

  ///<summary>
  ///  Utility class used by driver writers when connections are created.
  ///  Particularly important for chaining delegate connections in front
  ///  of a database connection.
  ///</summary>
  TDBXConnectionBuilder = class
    private

      [Weak]FInputConnectionProperties: TDBXProperties;
      FInputConnectionName:       string;
      FInputUserName:             string;
      FInputPassword:             string;

      [Weak]FConnectionFactory:         TDBXConnectionFactory;
      FDelegatePath:              TDBXDelegateItem;
      FDBXContext:                TDBXContext;

      FDelegateDriver:            TDBXDelegateDriver;

      function GetConnectionProperties: TDBXProperties;
      function GetDelegationSignature: string;
      procedure Assign(Source: TDBXConnectionBuilder);
      function CreateConnection: TDBXConnection;
    protected
      constructor Create; overload;
      constructor Create(Source: TDBXConnectionBuilder); overload;
    public
      destructor Destroy; override;
      ///<summary>
      ///  Used by delegate driver implementations to request the creation
      ///  of the connection the delegate connection delegates to.
      ///</summary>
      function CreateDelegateeConnection: TDBXConnection;
      ///<summary>
      ///  TDBXConnection properties provided by the current delegate or database
      ///  connection being created.
      ///</summary>
      property ConnectionProperties: TDBXProperties read GetConnectionProperties;
      ///<summary>
      ///  A '/' slash separated list of the delegate delegate drivers and the database
      ///  dirver used to create a connection by this TDBXConnectionBuilder instance.
      ///</summary>
      property DelegationSignature: string read GetDelegationSignature;

      ///<summary>
      ///  First database TDBXProperties when a connection was requested from
      ///  a TDBXConnectionFactory.
      ///</summary>
      property InputConnectionProperties: TDBXProperties read FInputConnectionProperties;
      ///<summary>
      ///  First database connection name when a connection was requested from
      ///  a TDBXConnectionFactory.
      ///</summary>
      property InputConnectionName: string read FInputConnectionName;
      ///<summary>
      ///  First database user name when a connection was requested from
      ///  a TDBXConnectionFactory.
      ///</summary>
      property InputUserName: string read FInputUserName;
      ///<summary>
      ///  First database password when a connection was requested from
      ///  a TDBXConnectionFactory.
      ///</summary>
      property InputPassword: string read FInputPassword;
      ///<summary>
      ///  DBXContext to be used for the database connection.  Delegate connections
      ///  should not use this instance of DbxContext.  They should create their
      ///  own instead.
      ///</summary>
      property DbxContext: TDBXContext read FDbxContext;

  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.MemoSubType</c> values.
  ///</summary>
  TDBXAnsiMemoValue = class(TDBXByteArrayValue)
    private
      procedure GetFBytes;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    protected
      constructor Create(ValueType: TDBXValueType);
    public
      destructor Destroy; override;
      function IsNull: Boolean; override;
{$IFNDEF NEXTGEN}
      function GetAnsiString: AnsiString; override;
      procedure SetAnsiString(const Value: AnsiString); override;
{$ELSE}
      function GetString: string; override;
      procedure SetString(const Value: string); override;
{$ENDIF}
      function GetAsString: string; override;
      procedure SetAsString(const Value: string); override;
      procedure SetValue(const Value: TDBXValue); override;
  end;

  ///<summary>
  ///  Implementation of <c>TDBXWritableValue</c> for <c>TDBXDataTypes.MemoSubType</c> values.
  ///</summary>
  TDBXWideMemoValue = class(TDBXByteArrayValue)
    private
      procedure GetFBytes;
      procedure CopyRowValue(Row: TDBXRow); overload; override;
    protected
      constructor Create(ValueType: TDBXValueType);
    public
      destructor Destroy; override;
      function IsNull: Boolean; override;
      function GetWideString: string; override;
      procedure SetWideString(const Value: string); override;
      function GetAsString: string; override;
      procedure SetAsString(const Value: string); override;
      procedure SetValue(const Value: TDBXValue); override;
  end;

  ///<summary>
  ///  Implemented by Driver implementations.  This is not used directly by applications.
  ///</summary>
  TDBXRow = class
    strict protected
      [Weak]FDBXContext:      TDBXContext;

      property  DBXContext: TDBXContext read FDBXContext;
    protected
      FGeneration:      TInt32;
      procedure NotImplemented; virtual;
      procedure GetAnsiString(DbxValue: TDBXAnsiStringValue; var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool); virtual;
      procedure GetWideString(DbxValue: TDBXWideStringValue; var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool); overload; virtual;
      procedure GetWideString(DbxValue: TDBXWideStringValue; var Value: string; var IsNull: LongBool); overload; virtual;
      procedure GetBoolean(DbxValue: TDBXBooleanValue; var Value: LongBool; var IsNull: LongBool); virtual;
      procedure GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte; var IsNull: LongBool); virtual;
      procedure GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt; var IsNull: LongBool); virtual;
      ///<summary>Returns a Word from the row.  Descendants should implement as
      ///  an exception is raised by default.
      ///</summary>
      procedure GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word; var IsNull: LongBool); virtual;
      procedure GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt; var IsNull: LongBool); virtual;
      procedure GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32; var IsNull: LongBool); virtual;
      procedure GetInt64(DbxValue: TDBXInt64Value; var Value: Int64; var IsNull: LongBool); virtual;
      procedure GetSingle(DbxValue: TDBXSingleValue; var Value: Single; var IsNull: LongBool); virtual;
      procedure GetDouble(DbxValue: TDBXDoubleValue; var Value: Double; var IsNull: LongBool); virtual;
      procedure GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd; var IsNull: LongBool); virtual;
      procedure GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate; var IsNull: LongBool); virtual;
      procedure GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime; var IsNull: LongBool); virtual;
      procedure GetTimeStamp(DbxValue: TDBXTimeStampValue; var Value: TSQLTimeStamp; var IsNull: LongBool); virtual;
      procedure GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue; var Value: TSQLTimeStampOffset; var IsNull: LongBool); virtual;
      procedure GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64; const Buffer: TArray<Byte>; BufferOffset, Length: Int64; var ReturnLength: Int64; var IsNull: LongBool); virtual;
      procedure GetByteLength(DbxValue: TDBXByteArrayValue; var ByteLength: Int64; var IsNull: LongBool); virtual;
      procedure GetDBXReader(DbxValue: TDBXReaderValue; var Value: TDBXReader; var IsNull: LongBool); virtual;
      procedure GetDBXConnection(DbxValue: TDBXConnectionValue; var Value: TDBXConnection; var IsNull: LongBool); virtual;

      procedure GetJSONValue(DbxValue: TDBXJSONValue; var Value: TJSONValue; var IsNull: LongBool); virtual;
      procedure SetJSONValue(DbxValue: TDBXJSONValue; Value: TJSONValue); virtual;
      procedure GetCallbackValue(DbxValue: TDBXCallbackValue; var Value: TDBXCallback; var IsNull: LongBool); virtual;
      procedure SetCallbackValue(DbxValue: TDBXCallbackValue; Value: TDBXCallback); virtual;

      function  IsStoredNull(DbxValue: TDBXValue): Boolean; virtual;

      procedure SetNull(DbxValue: TDBXValue); virtual;
      {$IFNDEF NEXTGEN}
      procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString); virtual;
      procedure SetAnsiString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString); virtual;
      {$ELSE}
      procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: string); virtual;
      {$ENDIF}
      procedure SetWideString(DbxValue: TDBXWideStringValue; const Value: string); virtual;

      procedure SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean); virtual;
      procedure SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte); virtual;
      procedure SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt); virtual;
      ///<summary>Sets a Word in a row.  Descendants should implement as
      ///  an exception is raised by default.
      ///</summary>
      procedure SetUInt16(DbxValue: TDBXUInt16Value; Value: Word); virtual;
      procedure SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt); virtual;
      procedure SetInt32(DbxValue: TDBXInt32Value; Value: TInt32); virtual;
      procedure SetInt64(DbxValue: TDBXInt64Value; Value: Int64); virtual;
      procedure SetSingle(DbxValue: TDBXSingleValue; Value: Single); virtual;
      procedure SetDouble(DbxValue: TDBXDoubleValue; Value: Double); virtual;

      procedure SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd); virtual;

      procedure SetDate(DbxValue: TDBXDateValue; Value: TDBXDate); virtual;
      procedure SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime); virtual;

      procedure SetTimestamp(DbxValue: TDBXTimeStampValue; var Value: TSQLTimeStamp); virtual;
      procedure SetTimestampOffset(DbxValue: TDBXTimeStampOffsetValue; var Value: TSQLTimeStampOffset); virtual;

      procedure SetDynamicBytes( DbxValue:     TDBXValue;
                          Offset:       Int64;
                          const Buffer: TArray<Byte>;
                          BufferOffset: Int64;
                          Length:       Int64); virtual;

      function GetObjectTypeName(Ordinal: TInt32): string; virtual;
      procedure SetValueType(ValueType: TDBXValueType); virtual;
      ///<summary>Returns the current value of Generation</summary>
      function GetGeneration: TInt32; virtual;
      ///<summary>Generation is used to help determine whether the active row has
      ///  changed, and that the data needs to be refreshed.
      ///</summary>
      property Generation: TInt32 read GetGeneration;
      function  UseExtendedTypes: Boolean; virtual;
      procedure GetWideChars(DbxValue: TDBXWideStringValue; var WideChars: TDBXWideChars; var Count: Integer; var IsNull: LongBool); virtual;
      procedure GetAnsiChars(DbxValue: TDBXAnsiStringValue; var AnsiChars: TDBXAnsiChars; var Count: Integer; var IsNull: LongBool); virtual;
      procedure GetStream(DbxValue: TDBXStreamValue; var Stream: TStream; var IsNull: LongBool); overload; virtual;
      procedure GetStream(DbxValue: TDBXWideStringValue; var Stream: TStream; var IsNull: LongBool); overload; virtual;
      procedure GetStream(DbxValue: TDBXAnsiStringValue; var Stream: TStream; var IsNull: LongBool); overload; virtual;
      procedure GetStreamBytes(DbxValue: TDBXStreamValue; const Buffer: TArray<Byte>; BufferOffset, Length, ReturnLength: Int64; var IsNull: LongBool); virtual;
      procedure GetStreamLength(DbxValue: TDBXStreamValue; StreamLength: Int64; var IsNull: LongBool); virtual;

      procedure SetWideChars(DbxValue: TDBXWideStringValue; const Value: string); virtual;
      {$IFNDEF NEXTGEN}
      procedure SetAnsiChars(DbxValue: TDBXAnsiStringValue; const Value: AnsiString); virtual;
      procedure SetAnsiMemo(DbxValue: TDBXAnsiMemoValue; const Value: AnsiString); virtual;
      {$ENDIF !NEXTGEN}
      procedure SetWideMemo(DbxValue: TDBXWideMemoValue; const Value: string); virtual;
      procedure SetStream(DbxValue:     TDBXStreamValue;
                          StreamReader: TDBXStreamReader); overload; virtual;
      procedure SetDBXReader(DbxValue: TDBXReaderValue; Value: TDBXReader); virtual;
      procedure SetDBXConnection(DbxValue: TDBXConnectionValue; Value: TDBXConnection); virtual;

      procedure GetLength(DbxValue: TDBXValue; var ByteLength: Int64; var IsNull: LongBool); virtual;
      function  CreateCustomValue(const ValueType: TDBXValueType): TDBXValue; virtual;
      procedure ValueSet(Value: TDBXWritableValue); virtual;
      procedure ValueNotSet(const Value: TDBXWritableValue); virtual;
      constructor Create(DBXContext: TDBXContext);
    public
      procedure ClearParameters; virtual;
      procedure NewRowGeneration;
  end;


  TDBXCommandFactory = class
  public
    function CreateCommand(DbxContext: TDBXContext; Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand; virtual; abstract;
  end;

    ///<summary>
    /// The TDBXFormatter instance used to parse and format string representations
    ///  for <c>TDBXDate</c>, <c>TDBXTime</c>, <c>TSqlTimeStamp</c>, and <c>TBcd</c> values
    ///  using the "As" properties of <c>TDBXValue</c> and <c>TDBXWritableValue</c>.
    ///  The <c>TDBXConnectionFactory</c> provides a default implementation of
    ///  <c>TDBXFormatter</c> for all connections.
    ///</summary>
  TDBXFormatter = class
    /// <summary>
    ///  Convert date to String.
    /// </summary>
    function  DateToString(DBXDateValue:  TDBXDateValue): string; virtual; abstract;
    /// <summary>
    ///  Convert String to TDBXDate.
    /// </summary>
    procedure StringToDate(StringValue: string; DBXDateValue:  TDBXDateValue); virtual; abstract;

    /// <summary>
    ///  Convert time to String.
    /// </summary>
    function  TimeToString(DBXTimeValue:  TDBXTimeValue): string; virtual; abstract;
    /// <summary>
    ///  Convert String to TDBXTime.
    /// </summary>
    procedure StringToTime(StringValue: string; DBXTimeValue:  TDBXTimeValue); virtual; abstract;

    /// <summary>
    ///  Convert TSQLTimestamp to String.
    /// </summary>
    function  TimestampToString(DBXTimestampValue:  TDBXTimestampValue): string; virtual; abstract;
    /// <summary>
    ///  Convert String to TSQLTimestamp.
    /// </summary>
    procedure StringToTimestamp(StringValue: string; DBXTimestampValue:  TDBXTimestampValue); virtual; abstract;

    /// <summary>
    ///  Convert TSQLTimestampOffset to String.
    /// </summary>
    function  TimestampOffsetToString(DBXTimestampOffsetValue:  TDBXTimestampOffsetValue): string; virtual; abstract;
    /// <summary>
    ///  Convert String to TSQLTimestampOffset.
    /// </summary>
    procedure StringToTimestampOffset(StringValue: string; DBXTimestampOffsetValue:  TDBXTimestampOffsetValue); virtual; abstract;

    /// <summary>
    ///  Convert TBcd to String.
    /// </summary>
    function  BcdToString(DBXBcdValue:  TDBXBcdValue): string; virtual; abstract;
    /// <summary>
    ///  Convert String to TBcd.
    /// </summary>
    procedure StringToBcd(StringValue: string; DBXBcdValue:  TDBXBcdValue); virtual; abstract;
  end;

  TDBXStream = class(TStream)
    function ReadBytes(const Buffer: TArray<Byte>; Offset, Count: Longint): Longint; virtual; abstract;
    function Seek(Offset: Longint; Origin: Word): Longint; overload; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; overload; override;
  end;

  TDBXStreamReaderStream = class(TDBXStream)
    private
      FStartedRead:       Boolean;
      FBuffer:            TArray<Byte>;
      FOffset:            Integer;
      FReader:            TDBXStreamReader;
    protected
      function GetSize: Int64; override;
    public
      function Read(var Buffer; Count: Longint): Longint; override;
      function Write(const Buffer; Count: Longint): Longint; override;
      function ReadBytes(const Buffer: TArray<Byte>; Offset, Count: Longint): Longint; override;
      function Seek(Offset: Longint; Origin: Word): Longint; overload; override;
      function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; overload; override;
      constructor Create(Reader: TDBXStreamReader; Size: Int64);
      destructor Destroy; override;
  end;


  TDBXBytesStream = class(TDBXStream)
    private
      FBuffer:            TArray<Byte>;
      FOffset:            Integer;
      FSize:              Integer;
    protected
      function GetSize: Int64; override;
    public
      function Read(var Buffer; Count: Longint): Longint; override;
      function Write(const Buffer; Count: Longint): Longint; override;
      function ReadBytes(const Buffer: TArray<Byte>; Offset, Count: Longint): Longint; override;
      constructor Create(Bytes: TArray<Byte>; Size: Int64);
  end;

  
  /// <summary> Bridge class between DBX and JSON. Extracts and saves a JSON value in a DBXRow
  /// </summary>
  /// <remarks> Extracts and saves a JSON value in a DBXRow
  ///
  /// </remarks>
  TDBXJSONValue = class(TDBXWritableValue)
  private
    FJsonValue: TJSONValue;
    FInstanceOwner: Boolean;
  public

    /// <summary> Ctr for JSON value.
    /// </summary>
    /// <remarks>
    /// </remarks>
    /// <param name="valueType">value type meta data</param>
    constructor Create(const ValueType: TDBXValueType);
    destructor Destroy; override;
    /// <summary> see com.borland.dbx.table.DBXWritableValue#setRowValue()
    /// </summary>
    procedure SetRowValue; override;

    /// <summary> Returns estimated byte size
    ///
    /// </summary>
    /// <returns>int - estimated byte size</returns>
    function EstimatedByteSize: Integer; virtual;

    /// <summary> Serializes current value in a byte container
    ///
    /// </summary>
    /// <param name="data">- byte container</param>
    /// <param name="offset">- container free position</param>
    /// <returns>number of bytes used</returns>
    function ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer; virtual;

    /// <summary> Changes the JSON value with value from row buffer
    ///
    /// </summary>
    /// <param name="data">- JSON value byte stream</param>
    /// <param name="off">- offset to start parsing from</param>
    /// <param name="count">- serialized size</param>
    /// <returns>JSON Value instance</returns>
    /// <exception> DBXError if parse fails</exception>
    function CreateJSONValue(const Data: TArray<Byte>; const Off: Integer; const Count: Integer): TJSONValue; virtual;

    /// <summary> Returns true if the value is unknown
    /// </summary>
    function IsNull: Boolean; override;

    /// <summary> Returns the JSON value from row buffer
    /// </summary>
    function GetJSONValue: TJSONValue; override;
    function GetJSONValue(AInstanceOwner: Boolean): TJSONValue; override;
    function GetObjectValue: TObject; override;
    function GetObjectValue(AInstanceOwner: Boolean): TObject; override;

    /// <summary> Returns the JSON value as a string
    /// </summary>
    function GetWideString: string; override;

    /// <summary> Changes the JSON value, updates the row data
    /// </summary>
    procedure SetJSONValue(const Value: TJSONValue; const AInstanceOwner: Boolean); override;
    procedure SetObjectValue(const Value: TObject; const AInstanceOwner: Boolean); override;
    procedure SetValue(const Value: TDBXValue); override;
    procedure SetNull; override;
  end;

  /// <summary> DBXCallback holder
  ///
  /// </summary>
  TDBXCallbackValue = class(TDBXWritableValue)
  private
    FDbxCallback: TDBXCallback;
  protected
    /// <summary> see com.borland.dbx.table.DBXWritableValue#setRowValue()
    /// </summary>
    procedure SetRowValue; override;
  public
    constructor Create(const ValueType: TDBXValueType);
    destructor Destroy; override;
    function IsNull: Boolean; override;
  public
    procedure SetCallbackValue(const Value: TDBXCallback); override;
    function GetCallbackValue: TDBXCallback; override;
    procedure SetOrdinal(const Ordinal: Integer); virtual;
    procedure SetConnectionHandler(const ConnectionHandler: TObject); virtual;
    procedure SetObjectValue(const Value: TObject; const AInstanceOwner: Boolean); override;
    function CreateCallbackDelegate(ordinal: Integer): TDBXCallback; virtual;
    procedure SetValue(const Value: TDBXValue); override;
  public
    property Ordinal: Integer write SetOrdinal;
    property ConnectionHandler: TObject write SetConnectionHandler;
  end;


  ///  <summary>  Describes the communication layer APIA regular use-case is open [read|write]+ close, and the object can be re-used.
  ///  <remarks>
  ///   In cases where the communication layer needs to be terminated (timeouts, abrupt exit) terminate method needs to be called.
  ///   After being terminated the object cannot be reused.
  ///  </remarks>
  ///  </summary>
  TDBXCommunicationLayer = class abstract(TFactoryObject)
  private
    FTerminated: Boolean;
    FConnectTimeout: Integer;
    FCommunicationTimeout: Integer;
  protected
    procedure SetConnectTimeout(Duration: Integer); virtual;
    function GetConnectTimeout: Integer; virtual;
  public

    /// <summary> Opens the communication based on parameters present in the property object.
    /// </summary>
    /// <remarks> Preceeds any Read or Write operation
    ///
    /// </remarks>
    /// <param name="dbxProperties">- property collection, usually with host name and port number</param>
    procedure Open(const DbxProperties: TDBXProperties); virtual; abstract;

    /// <summary> Closes the communication channel.
    /// </summary>
    /// <remarks>
    ///  No Read or Write methods are to be called past it.
    /// </remarks>
    procedure Close; virtual; abstract;

    /// <summary> Reads count bytes into the byte buffer.
    /// </summary>
    /// <remarks>
    /// </remarks>
    /// <param name="buffer">- byte buffer</param>
    /// <param name="offset">- offset from where the bytes are stored, expected to be zero</param>
    /// <param name="count">- expected byte count to be read. It is assumed that buffer has
    ///    enough memory allocated to store all of them.</param>
    /// <returns>- the actual read byte count. -1 on error</returns>
    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; virtual; abstract;

    /// <summary> Performs the write operation for given byte buffer.
    /// </summary>
    /// <remarks>
    /// </remarks>
    /// <param name="buffer">- byte buffer</param>
    /// <param name="offset">- location of the first byte to be written from</param>
    /// <param name="count">- expected byte count to be written. It is assumed that buffer
    ///    has enough capacity for it.</param>
    /// <returns></returns>
    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; virtual; abstract;
    
    /// <summary>
    /// </summary>
    /// <returns>distinctive communication layer information</returns>
    function Info: string; virtual; abstract;

    ///  <summary>Terminate current communication state.</summary>
    ///  <remarks>The communication layer state is reset, one needs to start over</remarks>
    procedure Terminate; virtual;

    property Terminated: Boolean read FTerminated;
    ///  <summary>Maximum number of milliseconds for the connection to be established</summary>
    ///  <remarks>value of zero means indefinite wait for the connection to be established</remarks>
    property ConnectTimeout: Integer read GetConnectTimeout write SetConnectTimeout;
    ///  <summary>Maximum number of milliseconds for a data packet to be received</summary>
    ///  <remarks>Exceeding the timeout considers the correspondent partner closed.
    ///    Value of zero means indefinite wait for the connection to be established.
    ///  </remarks>
    property CommunicationTimeout: Integer read FCommunicationTimeout write FCommunicationTimeout;
  end;

  ///  <summary> DBX scheduler event is a no-argument (anonymous) procedure
  ///  </summary>
  TDBXScheduleEvent = reference to procedure;

  ///  <summary> DBX Scheduler is a light-weight transient scheduler for user
  ///    registered events.
  ///  </summary>
  TDBXScheduler = class
  private
    type TDBXSchedulerRec = class
    private
      FEvent: TDBXScheduleEvent;
      FTime: TDateTime;
      FID: NativeInt;
    end;

    type TDBXSchedulerThread = class(TThread)
    private
      FEventSemaphore: TObject;
      FLastFailure: TDateTime;
    protected
{$IFNDEF POSIX}
      procedure SetCurrentThreadName(const Name: string);
{$ENDIF}
      procedure Execute; override;
    public
      constructor Create(EventSem: TObject);
    end;

  strict private
    FEvents: TList<TDBXSchedulerRec>;
    FThread: TDBXSchedulerThread;
    FSync:           TCriticalSection;
    FEventSemaphore: TObject;
  private
    class var FInstance: TDBXScheduler;
  protected
    procedure StartSchedulerThread;
    procedure StopSchedulerThread;
    function PeekTime: TDateTime;
    function PeekEvent: TDBXScheduleEvent;
    procedure Pop;
    function EventCount: Integer;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    ///  <summary> Registers a user event
    ///  </summary>
    ///  <remarks> The event is a reference to a zero-argument procedure. The
    ///    event is executed now + delta. This method is thread safe.
    ///  </remarks>
    ///  <param name="Id">user event id, it can be used later on for cancellation</param>
    ///  <param name="Proc">user event</param>
    ///  <param name="Delta">time in miliseconds when user event is expected</param>
    procedure AddEvent(Id: NativeInt; Proc: TDBXScheduleEvent; Delta: Integer);
    ///  <summary> Cancels a registered user event based on event id </summary>
    ///  <param name="Id">user event id</param>
    function CancelEvent(Id: NativeInt): Boolean;
    ///  <summary> Clears all pending user events, clears all used memory
    ///  </summary>
    ///  <remarks>This method is thread safe</remarks>
    procedure CloseScheduler;
    ///  <summary> Singleton property </summary>
    class property Instance: TDBXScheduler read FInstance;
  end;

  ///  <summary> Represents the abstract notion of a principal, used to represent
  ///    any entity, such as an individual, a corporation, and a login id
  ///  </summary>
  TPrincipal = class abstract
  public
    function GetName: string; virtual; abstract;
  end;

  ///  <summary> This class represents an X.500 Principal. X500Principals are
  ///    represented by distinguished names such as "CN=Thawte, OU=Embarcadero, O=Thawte, C=US"
  ///  </summary>
  TX500Principal = class abstract(TPrincipal)
  public
    ///  <returns> Returns the distinguished name in ASN.1 DER encoded form </returns>
    function GetEncoded: Longint; virtual; abstract;
  end;

  ECertificateExpiredException = class(Exception)
  end;

  ECertificateNotYetValidException = class(Exception)
  end;

  ECertificateParsingException = class(Exception)
  end;

  ///  <summary> The Key interface is the top-level interface for all keys.
  ///            It defines the functionality shared by all key objects.
  ///  </summary>
  ///  <remarks> All keys have three attributes: An Algorithm, an encoded form and a format.
  ///  </remarks>
  TKey = class abstract
  public
    ///  <summary> Returns the standard algorithm name for this key.
    ///  </summary>
    ///  <remarks> For example, "DSA" would indicate that this key is a DSA key.
    ///  </remarks>
    ///  <returns> the name of the algorithm associated with this key.
    ///  </returns>
    function GetAlgorithm: string; virtual; abstract;
    ///  <summary> Returns the name of the primary encoding format of this key, or null if this key does not support encoding.
    ///  </summary>
    ///  <remarks> The primary encoding format is named in terms of the appropriate ASN.1 data format, if an ASN.1 specification for this key exists.
    ///  </remarks>
    ///  <returns> the primary encoding format of the key.
    ///  </returns>
    function GetFormat: string; virtual; abstract;
    ///  <summary> Returns the key in its primary encoding format, or null if this key does not support encoding.
    ///  </summary>
    ///  <returns> the encoded key, or null if the key does not support encoding.
    ///  </returns>
    function GetEncoded: TArray<Byte>; virtual; abstract;
  end;

  ///  <summary> Subclass of TKey specifically for Public Keys
  ///  </summary>
  TPublicKey = class abstract(TKey)
  end;

  ///  <summary> Abstract class for managed certificates.
  ///  </summary>
  TCertificate = class abstract
  public
    ///  <summary> Gets the encoded form of this certificate.
    ///  </summary>
    ///  <returns> the encoded form of this certificate.
    ///  </returns>
    function GetEncoded: TArray<Byte>; overload; virtual; abstract;
    ///  <summary> Gets the public key from this certificate.
    ///  </summary>
    ///  <returns> the public key from this certificate.
    ///  </returns>
    function GetPublicKey: TPublicKey; overload; virtual; abstract;
    ///  <summary> Gets the type of this certificate.
    ///  </summary>
    ///  <returns> the type of this certificate.
    ///  </returns>
    function GetType: string; overload; virtual; abstract;
    ///  <summary> Verifies that this certificate was signed using the private
    ///     key that corresponds to the specified public key.
    ///  </summary>
    ///  <returns> True if verified, false otherwise
    ///  </returns>
    function Verify(key: TPublicKey): Boolean; overload; virtual; abstract;
  end;

  ///  <summary> X.509 Implementation of TCertificate, adding new functionality as appropriate.
  ///  </summary>
  TX509Certificate = class abstract(TCertificate)
  public
    ///  <summary> Specifies the type of this certificate (X.509) for all subclasses of this </summary>
    ///  <returns> X.509 (The Certificate format type) </returns>
    function GetType: string; override;
    ///  <summary> Checks that the certificate is currently valid. Valid if the
    ///     current date and time are within the validity period given in the certificate.
    ///  </summary>
    ///  <remarks> The validity period consists of two date/time values: NotBefore and NotAfter (TDateTime)
    ///     If Validity check fails, then this procedure throws an appropriate exception.
    ///     Throws:
    ///       ECertificateExpiredException - if the certificate has expired.
    ///       ECertificateNotYetValidException - if the certificate is not yet valid.
    ///  </remarks>
    procedure CheckValidity; overload; virtual; abstract;
    ///  <summary>Checks that the given date is within the certificate's validity period.
    ///     In other words, this determines whether the certificate would be valid at the given date/time.
    ///  </summary>
    ///  <remarks>  The validity period consists of two date/time values: NotBefore and NotAfter (TDateTime)
    ///     If Validity check fails, then this procedure throws an appropriate exception.
    ///     Throws:
    ///       ECertificateExpiredException - if the certificate has expired with respect of ADate supplied.
    ///       ECertificateNotYetValidException - if the certificate is not yet valid with respect of ADate supplied.
    ///  </remarks>
    ///  <param name="ADate">the Date to check against to see if this certificate is valid at that date/time.</param>
    procedure CheckValidity(ADate: TDateTime); overload; virtual; abstract;
    ///  <summary> Gets the certificate constraints path length from the critical BasicConstraints extension.
    ///  </summary>
    ///  <remarks> Specifies whether the subject of the certificate is a Certificate Authority (CA) and if so,
    ///     how deep a certification path may exist through that CA. -1 will be returned if CA is False.
    ///  </remarks>
    ///  <returns> The length if the subject is a CA, otherwise -1.
    ///    If the subject is a CA but no length was specified, then Max(Integer) is returned
    ///    to indicate that there is no limit to the allowed length of the certification path.
    ///  </returns>
    function GetBasicConstraints: Integer; virtual; abstract;
    ///  <summary> Gets the issuer (issuer distinguished name) value from the certificate
    ///  </summary>
    ///  <remarks> The issuer name field contains an X.500 distinguished name (DN)
    ///  </remarks>
    ///  <returns> the issuer (issuer distinguished name) value from the certificate
    ///  </returns>
    function GetIssuerX500Principal: TX500Principal; virtual; abstract;
    ///  <summary> Gets the notAfter date from the validity period of the certificate.
    ///  </summary>
    ///  <returns> the end date of the validity period.
    ///  </returns>
    function GetNotAfter: TDateTime; virtual; abstract;
    ///  <summary> Gets the notBefore date from the validity period of the certificate.
    ///  </summary>
    ///  <returns> the start date of the validity period.
    ///  </returns>
    function GetNotBefore: TDateTime; virtual; abstract;
    ///  <summary> Gets the serialNumber value from the certificate.
    ///  </summary>
    ///  <remarks> The serial number is a unique number assigned by the CA to each certificate.
    ///  </remarks>
    ///  <returns> the serial number
    ///  </returns>
    function GetSerialNumber: string; virtual; abstract;
    ///  <summary> Gets the signature algorithm name for the certificate signature algorithm.
    ///  </summary>
    ///  <remarks> An example is the string "SHA-1/DSA"
    ///  </remarks>
    ///  <returns> the signature algorithm name
    ///  </returns>
    function GetSigAlgName: string; virtual; abstract;
    ///  <summary> Gets the signature value (the raw signature bits) from the certificate.
    ///  </summary>
    ///  <remarks> This returns the signature as a string to be compatable with TIdX509SigInfo
    ///  </remarks>
    ///  <returns> the signature
    ///  </returns>
    function GetSignature: string; virtual; abstract;
    ///  <summary> Returns the subject (subject distinguished name) value from the certificate as a TX500Principal
    ///  </summary>
    ///  <returns> a TX500Principal representing the subject distinguished name
    ///  </returns>
    function GetSubjectX500Principal: TX500Principal; virtual; abstract;
    ///  <summary> Gets the version (version number) value from the certificate.
    ///  </summary>
    ///  <remarks> The ASN.1 definition for this is:
    ///            version  [0] EXPLICIT Version DEFAULT v1
    ///            Version ::= INTEGER { v1(0), v2(1), v3(2) }
    ///  </remarks>
    ///  <returns> the version number, i.e. 1, 2 or 3
    ///  </returns>
    function GetVersion: LongInt; virtual; abstract;
  end;

  /// <summary> Abstract class for common functionality of Command Handlers,
  ///    which manage TDBXCommand instances as well as error messages.
  /// </summary>
  TRequestCommandHandler = class abstract
  public
    /// <summary> Adds an error message to the handler.
    /// </summary>
    procedure AddCommandError(ErrorMessage: string); virtual; abstract;
    /// <summary> Adds a TDBXCommand for this handler
    /// </summary>
    procedure AddCommand(Command: TDBXCommand; DBXConnection: TDBXConnection); virtual; abstract;
    /// <summary> Clears the stored commands/errors
    /// </summary>
    procedure ClearCommands; virtual; abstract;
  end;

  /// <summary> Abstract class for a result command handler which manages one or more commands, and their
  ///   parameters. The parameters exposed by these functions may be a subset of the commands parameters.
  /// </summary>
  TResultCommandHandler = class abstract
  public
    /// <summary> Returns the number of commands handled by this instance
    /// </summary>
    function GetCommandCount: Integer; virtual; abstract;
    /// <summary> Returns the number of managed parameters for the command at the given index
    /// </summary>
    function GetParameterCount(Index: Integer): Integer; virtual; abstract;
    /// <summary> Returns the Command at the given index
    /// </summary>
    function GetCommand(Index: Integer): TDBXCommand; virtual; abstract;
    /// <summary> Returns the parameter of the command for the given indices
    /// </summary>
    function GetCommandParameter(CommandIndex: Integer; ParameterIndex: Integer): TDBXParameter; overload; virtual; abstract;
    /// <summary> Returns the parameter at the given index of the specified Command
    /// </summary>
    function GetCommandParameter(Command: TDBXCommand; Index: Integer): TDBXParameter; overload; virtual; abstract;
  end;

procedure InitializeConnectionFactorySingletonFromINIFile(const DriverFileName, ConnectionFileName: string);

implementation

uses
  Data.DBXCommonResStrs,
  Data.DSUtil,
  System.Generics.Defaults,
  System.Variants
{$IFNDEF POSIX}
  ,Winapi.Windows,
  System.Win.Registry
{$ENDIF}
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

const
  // Set TDBXReader.FCount to NewReaderCount to trigger error message
  // that TDBXReader.Next needs to be called.
  //
  NewReaderCount    = -1;
  // Set TDBXReader.FCount to ClosedReadercount to trigger error message
  // that a TDBXReader can no longer be used.  This will occur when
  // TDBXReader.Next returns false.
  //
  ClosedReaderCount = -2;

  // Use DefaultDriverClassName and DefaultDriverPackageName if
  // proper definitions are missing from the driver section.
  DefaultDriverClassName = 'TDBXDynalinkDriverLoader'; // Do not localize
  DefaultDriverPackageName = 'DbxCommonDriver' + PackageVersion + '.bpl'; // Do not localize

  DBXSchedulerThreadName = 'DBXSchedulerThread'; // Do not localize
  MsToDay = 1.0/24.0/60.0/60.0/1000.0;

type

  TDBXDefaultFormatter = class(TDBXFormatter)
  protected
    class var
      FDBXDefaultFormatterSingleton: TDBXFormatter;
      FDBXDefaultFormatterSingletonOwned: Boolean;
    var
      DateFormat:       TFormatSettings;
      TimeFormat:       TFormatSettings;
      TimeStampFormat:  TFormatSettings;

  public
    constructor Create; virtual;
    class function   GetDefaultDBXFormatter: TDBXFormatter; static;
    class procedure  SetDefaultDBXFormatter(DBXFormatter: TDBXFormatter); static;
    function  DateToString(DBXDateValue:  TDBXDateValue): string; override;
    procedure StringToDate(StringValue: string; DBXDateValue:  TDBXDateValue); override;

    function  TimeToString(DBXTimeValue:  TDBXTimeValue): string; override;
    procedure StringToTime(StringValue: string; DBXTimeValue:  TDBXTimeValue); override;

    function  TimestampToString(DBXTimestampValue:  TDBXTimestampValue): string; override;
    procedure StringToTimestamp(StringValue: string; DBXTimestampValue:  TDBXTimestampValue); override;

    function  TimestampOffsetToString(DBXTimestampOffsetValue:  TDBXTimestampOffsetValue): string; override;
    procedure StringToTimestampOffset(StringValue: string; DBXTimestampOffsetValue:  TDBXTimestampOffsetValue); override;

    function  BcdToString(DBXBcdValue:  TDBXBcdValue): string; override;
    procedure StringToBcd(StringValue: string; DBXBcdValue:  TDBXBcdValue); override;
  end;

  TDBXAnsiStringBuilderValue = class(TDBXAnsiStringValue)
  private
    FStringBuilder:   TDBXAnsiStringBuilder;
    FCount: Integer; // keeps track of original value length
    procedure SetRowValue; override;
    procedure CopyRowValue(Row: TDBXRow); overload; override;
    procedure UpdateType; override;
  protected
    constructor Create(ValueType: TDBXValueType);
  public
    destructor Destroy; override;
    function IsNull:Boolean; override;
{$IFNDEF NEXTGEN}
    function GetAnsiString: AnsiString; override;
    procedure SetAnsiString(const Value: AnsiString); override;
{$ELSE}
    function GetString: string; override;
    procedure SetString(const Value: string); override;
{$ENDIF}
  end;

  TDBXWideStringBuilderValue = class(TDBXWideStringValue)
  private
    FWideStringBuilder:   TDBXWideStringBuilder;
    procedure UpdateType; override;
    procedure SetRowValue; override;
    procedure CopyRowValue(Row: TDBXRow); overload; override;
  protected
    constructor Create(ValueType: TDBXValueType);
  public
    destructor Destroy; override;
    function IsNull: Boolean; override;
    function GetWideString: string; override;
    procedure SetWideString(const Value: string); override;
  end;

  TDBXClosedByteReader = class(TDBXByteReader)
  private
    procedure InvalidOperation;
  protected
    constructor Create(DBXContext: TDBXContext);
  public
{$IFNDEF NEXTGEN}
    procedure GetAnsiString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
{$ENDIF !NEXTGEN}
    procedure GetWideString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetInt32(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetInt64(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetSingle(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetDouble(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetBcd(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetTimeStamp(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetTimeStampOffset(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetTime(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
    procedure GetDate(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;

    procedure GetByteLength(Ordinal: TInt32; var Length: Int64; var IsNull: LongBool); override;
    function  GetBytes(Ordinal: TInt32; Offset: Int64; const Value: TArray<Byte>;
                               ValueOffset, Length: Int64; var IsNull: LongBool): Int64; override;
  end;


function TDBXConnectionFactory.CombineDriverProperties(
  ConProperties: TDBXProperties): TDBXProperties;
var
  DriverProperties:   TDBXProperties;
  DriverName: string;
  ConnectionName: string;
  FactoryConProperties: TDBXProperties;
begin
  Result := TDBXProperties.Create;
  Result.AddProperties(ConProperties.FProperties);
  DriverName := ConProperties[TDBXPropertyNames.DriverName];
  if DriverName = '' then
  begin
    ConnectionName := ConProperties[TDBXPropertyNames.ConnectionName];
    if ConnectionName <> '' then
    begin
      FactoryConProperties := HasConnectionProperties(ConnectionName);
      if FactoryConProperties <> nil then
      begin
        Result.AddUniqueProperties(FactoryConProperties.FProperties);
        DriverName := Result[TDBXPropertyNames.DriverName];
      end;
    end;

  end;
  if DriverName <> '' then
  begin
    DriverProperties := HasDriverProperties(DriverName);
    if DriverProperties <> nil then
      Result.AddUniqueProperties(DriverProperties.FProperties);
  end;
  Result.SetComponentOwner(ConProperties.GetOwner as TComponent);
  Result.Events.SetValues(ConProperties.Events.AllEvents);
end;

procedure TDBXConnectionFactory.Close;
begin
  FreeAndNil(FDrivers);
  FConnectionProperties.Free;
  FreeAndNil(FDBXContext);
  DerivedClose;
end;

constructor TDBXConnectionFactory.Create;
begin
  inherited Create;
  FDBXDefaultFormatter := TDBXDefaultFormatter.Create;
end;

destructor TDBXConnectionFactory.Destroy;
begin
  Close;
  FDBXDefaultFormatter.Free;
  inherited Destroy;
end;

class constructor TDBXConnectionFactory.Create;
begin
  inherited;
  if FLock = nil then
    FLock := TObject.Create;
end;

class destructor TDBXConnectionFactory.Destroy;
begin
  FreeAndNil(TDBXConnectionFactory.FLock);
  inherited;
end;

function TDBXConnectionFactory.GetConnection(
  const ConnectionName: string;
  const UserName: string;
  const Password: string): TDBXConnection;
begin
  Result := GetConnection(FDBXContext, ConnectionName, userName, Password);
end;

function TDBXConnectionFactory.GetConnection(
  ConnectionProperties: TDBXProperties): TDBXConnection;
begin
  Result := GetConnection(FDBXContext, ConnectionProperties);
end;

function TDBXConnectionFactory.GetConnection(const DBXContext: TDBXContext;
  const ConnectionProperties: TDBXProperties): TDBXConnection;
var
  ConnectionBuilder:  TDBXConnectionBuilder;
  DelegatePath:       TDBXDelegateItem;
  CombinedProperties: TDBXProperties;
begin
  CombinedProperties := CombineDriverProperties(ConnectionProperties);
  DelegatePath := CreateDelegatePath('', CombinedProperties);
  ConnectionBuilder := TDBXConnectionBuilder.Create;
  try
    ConnectionBuilder.FDelegatePath               := DelegatePath;
    ConnectionBuilder.FConnectionFactory          := Self;
    ConnectionBuilder.FDBXContext                 := TDBXContext.Create(DBXContext);
    ConnectionBuilder.FInputConnectionName        := CombinedProperties[TDBXPropertyNames.ConnectionName];
    ConnectionBuilder.FInputConnectionProperties  := ConnectionProperties;
    ConnectionBuilder.FInputUserName              := CombinedProperties[TDBXPropertyNames.UserName];
    ConnectionBuilder.FInputPassword              := CombinedProperties[TDBXPropertyNames.Password];
    Result := ConnectionBuilder.CreateConnection;
    try
      Result.Open;
    except
      Result.Free;
      raise;
    end;
  finally
    ConnectionBuilder.Free;
  end;
end;


function TDBXConnectionFactory.CreateDelegatePath(
  const Prefix:         string;
  Depth:          Integer;
  DelegateItem:   TDBXDelegateItem;
  DBXProperties:  TDBXProperties): TDBXDelegateItem;
var
  DelegateName:       string;
  NewDelegateItem:    TDBXDelegateItem;
  NewProperties:      TDBXProperties;
  CombinedProperties: TDBXProperties;
  StringList:         TStringList;
  NestedDelegateName: string;
  NewPrefix:          string;
  Index:              Integer;
  Key:                string;
  Value:              string;
  NewPrefixLength:    Integer;
begin
  if Depth > 16 then
  begin
    StringList := TStringList.Create;
    try
      while DelegateItem <> nil do
      begin
        StringList.Add(DelegateItem.FName);
        DelegateItem := DelegateItem.FNext;
      end;

      FDBXContext.Error(TDBXErrorCodes.DriverInitFailed, Format(SInvalidDelegationDepth, [StringList.DelimitedText]));
    finally
      StringList.Free;
    end;
  end;
  DelegateName := DBXProperties[TDBXPropertyNames.DelegateConnection];
  if DelegateName = '' then
    Result := DelegateItem
  else
  begin
    NewPrefix := DelegateName+'.';
    NestedDelegateName := DBXProperties[NewPrefix+TDBXPropertyNames.DriverName];
    if NestedDelegateName <> '' then
    begin
      NewProperties := TDBXProperties.Create;
      try
        NewPrefixLength := NewPrefix.Length;
        for Index := 0 to DBXProperties.Properties.Count - 1 do
        begin
          Key   := DBXProperties.Properties.Names[Index];
          Value := DBXProperties.FProperties.ValueFromIndex[Index];
          if Key.IndexOf('.') >= 0 then
          begin
            if Key.IndexOf(NewPrefix) = 0 then
              NewProperties.Add(Key.SubString(NewPrefixLength, Key.Length-NewPrefixLength), Value)
            else
              NewProperties.Add(Key, Value)
          end;
        end;
        CombinedProperties := CombineDriverProperties(NewProperties);
      finally
        NewProperties.Free;
      end;
    end
    else
      CombinedProperties   := CombineDriverProperties(GetConnectionProperties(DelegateName));
    NewDelegateItem             := TDBXDelegateItem.Create;
    try
      NewDelegateItem.FNext       := DelegateItem;
      NewDelegateItem.FName       := DelegateName;
      NewDelegateItem.FProperties := CombinedProperties;
      Result := CreateDelegatePath('', Depth+1, NewDelegateItem, NewDelegateItem.FProperties);
      NewDelegateItem := nil;
    finally
      NewDelegateItem.Free;
    end;
  end;
end;

function TDBXConnectionFactory.CreateDelegatePath(
  const ConnectionName: string;
  DBXProperties: TDBXProperties): TDBXDelegateItem;
var
  Depth:              Integer;
  FirstDelegateItem:  TDBXDelegateItem;
begin
  Depth                         := 0;
  FirstDelegateItem             := TDBXDelegateItem.Create;
  try
    FirstDelegateItem.FName       := ConnectionName;
    FirstDelegateItem.FProperties := DBXProperties;
    Result := CreateDelegatePath('', Depth, FirstDelegateItem, DBXProperties);
    FirstDelegateItem := nil;
  finally
    FirstDelegateItem.Free;
  end;
end;

function TDBXConnectionFactory.GetConnection(const DBXContext: TDBXContext;
  const ConnectionName, UserName, Password: string): TDBXConnection;
var
  ConnectionBuilder:    TDBXConnectionBuilder;
  DelegatePath:         TDBXDelegateItem;
  PropertyItem:         TDBXPropertiesItem;
  Connection:           TDBXConnection;
  Properties:           TDBXProperties;
  CombinedProperties:   TDBXProperties;
begin
  PropertyItem        := GetConnectionPropertiesItem(ConnectionName);
  Properties          := PropertyItem.FProperties;
  CombinedProperties  := CombineDriverProperties(Properties);
  DelegatePath        := CreateDelegatePath('', CombinedProperties);
  if (UserName <> '') or (Password <> '') then
  begin
    if UserName <> '' then
      CombinedProperties[TDBXPropertyNames.UserName] := UserName;
    if Password <> '' then
      CombinedProperties[TDBXPropertyNames.Password] := Password;
  end;
  ConnectionBuilder := TDBXConnectionBuilder.Create;
  Connection        := nil;
  try
    ConnectionBuilder.FDelegatePath               := DelegatePath;
    ConnectionBuilder.FConnectionFactory          := Self;
    ConnectionBuilder.FDBXContext                 := TDBXContext.Create(DBXContext);
    ConnectionBuilder.FInputConnectionName        := ConnectionName;
    ConnectionBuilder.FInputConnectionProperties  := Properties;
    ConnectionBuilder.FInputUserName              := CombinedProperties[TDBXPropertyNames.UserName];
    ConnectionBuilder.FInputPassword              := CombinedProperties[TDBXPropertyNames.Password];
    Connection := ConnectionBuilder.CreateConnection;
    Connection.Open;
    Result     := Connection;
    Connection := nil;
  finally
    Connection.Free;
    ConnectionBuilder.Free;
  end;
end;

function TDBXConnectionFactory.GetConnectionDriver(
  const ConnectionName: string): TDBXDelegateDriver;
var
  DriverName: string;
  ConnectionProperties: TDBXProperties;
begin
  ConnectionProperties  := GetConnectionProperties(ConnectionName);
  DriverName            := GetDriverName(ConnectionProperties);
  Result := GetDriver(DriverName, GetDriverProperties(DriverName));
end;

function TDBXConnectionFactory.GetConnectionProperties(
  const ConnectionName: string): TDBXProperties;
begin
  Result := GetConnectionPropertiesItem(ConnectionName).FProperties;
end;

function TDBXConnectionFactory.GetConnectionPropertiesItem(
  const ConnectionName: string): TDBXPropertiesItem;
begin
  Result := HasConnectionPropertiesItem(ConnectionName);
  if Result = nil then
    FDBXContext.Error(TDBXErrorCodes.InvalidArgument, Format(sInvalidArgument, [ConnectionName]));
end;

function TDBXConnectionFactory.GetDriver(
  const DriverName: string;
  DriverProperties: TDBXProperties): TDBXDelegateDriver;
var
  DriverDef:  TDBXDriverDef;
begin
  DriverDef.FDriverName       := DriverName;
  DriverDef.FDriverProperties := DriverProperties;
  DriverDef.FDBXContext       := FDBXContext;


  TDBXDriverRegistry.DBXDriverRegistry.FDrivers.LockList;
  try
    Result := TDBXDelegateDriver.Create(TDBXDriverRegistry.DBXDriverRegistry.GetDriver(DriverDef));
  finally
    TDBXDriverRegistry.DBXDriverRegistry.FDrivers.UnLockList;
  end;
end;

function TDBXConnectionFactory.GetDriver(const DriverName: string): TDBXDriver;
begin
  Result := GetDriver(DriverName, HasDriverProperties(DriverName));
end;

function TDBXConnectionFactory.getDriverName(
  ConnectionProperties: TDBXProperties): string;
begin
  Result := ConnectionProperties[TDBXPropertyNames.DriverName];
end;

function TDBXConnectionFactory.HasConnectionProperties(
  const ConnectionName: string): TDBXProperties;
var
  Item: TDBXPropertiesItem;
begin
  Item := HasConnectionPropertiesItem(ConnectionName);
  if Item = nil then
    Result := nil
  else
    Result := Item.FProperties;
end;

function TDBXConnectionFactory.HasConnectionPropertiesItem(
  const ConnectionName: string): TDBXPropertiesItem;
begin
  if FConnectionProperties.ContainsKey(ConnectionName) then
    Result := FConnectionProperties.Items[ConnectionName]
  else
    Result := nil;
end;

function TDBXConnectionFactory.HasDriverProperties(
  const DriverName: string): TDBXProperties;
begin
  if FDrivers.ContainsKey(DriverName) then
    Result := FDrivers.Items[DriverName]
  else
    Result := nil;
end;

function TDBXConnectionFactory.GetDriverProperties(
  const DriverName: string): TDBXProperties;
begin
  Result := HasDriverProperties(DriverName);
end;

function TDBXConnectionFactory.GetErrorEvent: TDBXErrorEvent;
begin
  Result := FDBXContext.OnError;
end;


procedure TDBXConnectionFactory.GetRegisteredDriverNames(DriverNames: TStringList);
begin
  TDBXDriverRegistry.DBXDriverRegistry.GetRegisteredDriverNames(DriverNames);
end;

function TDBXConnectionFactory.GetTraceFlags: TDBXTraceFlag;
begin
  Result := FDBXContext.TraceFlags;
end;

function TDBXConnectionFactory.GetTraceInfoEvent: TDBXTraceEvent;
begin
  Result := FDBXContext.OnTrace;
end;

procedure TDBXConnectionFactory.LoadDrivers;
var
  List: TStringList;
  I: Integer;
  Driver: TDBXDriver;
  Props: TDBXProperties;
begin
  List := TStringList.Create;
  try
    TDBXDriverRegistry.DBXDriverRegistry.GetRegisteredDriverClassNames(List);
    for I := 0 to List.Count - 1 do
    begin
      Driver := GetDriver(List[I]);
      try
        if FDrivers.ContainsKey(List[I]) then
        begin
          Props := FDrivers.Items[List[I]];
          Driver.FDriverProperties := Props.Clone;
          FDrivers.Remove(List[I]);
          FDrivers.Add(List[I], Driver.GetDriverProperties.Clone);
        end
        else
        begin
          Props := Driver.GetDriverProperties;
          if Props <> nil then
            FDrivers.Add(List[I], Props.Clone);
        end
      finally
        Driver.Free;
      end;
    end;
  finally
    List.Free;
  end;
end;

procedure TDBXConnectionFactory.LoadConnections;
begin
end;

procedure TDBXConnectionFactory.DerivedOpen;
begin
  LoadDrivers;
  LoadConnections;
end;

procedure TDBXConnectionFactory.DerivedClose;
begin
end;

procedure TDBXConnectionFactory.GetDriverNames(Items: TStrings);
begin
  Items.Clear;
  Items.AddStrings(FDrivers.Keys.ToArray, TArray<TObject>(FDrivers.Values.ToArray));
end;

procedure TDBXConnectionFactory.Open;
var
  LDrivers: TDictionary<string, TDBXProperties>;
begin
  if FDrivers = nil then
  begin
    try
      LDrivers := TObjectDictionary<string, TDBXProperties>.Create([doOwnsValues], TIStringComparer.Ordinal);
      if TInterlocked.CompareExchange<TDictionary<string, TDBXProperties>>(FDrivers, LDrivers, nil) <> nil then
        LDrivers.Free
      else
      begin
        FConnectionProperties     := TObjectDictionary<string, TDBXPropertiesItem>.Create([doOwnsValues], TIStringComparer.Ordinal);
        FDBXContext               := TDBXContext.Create;
        FDBXContext.FDBXFormatter :=  FDBXDefaultFormatter;
        DerivedOpen;
      end;
    except
      Close;
      raise;
    end;
  end;
end;

class function TDBXConnectionFactory.OpenConnectionFactory(
  const DriverFileName, ConnectionFileName: string): TDBXConnectionFactory;
var
  ConnectionFactory:  TDBXIniFileConnectionFactory;
begin
  if FileExists(ConnectionFileName) or FileExists(DriverFileName) then
  begin
    ConnectionFactory := TDBXIniFileConnectionFactory.Create;
    try
      ConnectionFactory.ConnectionsFile := ConnectionFileName;
      ConnectionFactory.DriversFile     := DriverFileName;

      ConnectionFactory.Open;
      Result := ConnectionFactory;
    except
      ConnectionFactory.Free;
      Result := nil;
    end;
  end else
    Result := nil;
end;

class function TDBXConnectionFactory.GetConnectionFactory: TDBXConnectionFactory;
var
  AppDir:             string;
  DriverFileName:     string;
  ConnectionFileName: string;

  function ConfigFilesFound: Boolean;
  begin
    Result := (DriverFileName <> '') and FileExists(DriverFileName);
  end;

{$IFNDEF POSIX}
{$IFNDEF NEXTGEN}
  function GetConnectionFromRegistry(const RegRootKey: HKEY): Boolean;
  var
    Registry: TRegistry;
  begin
    Registry := TRegistry.Create;
    try
      Registry.RootKey := RegRootKey;
      if Registry.OpenKeyReadOnly(TDBXRegistryKey) then
      begin
        DriverFileName      := Registry.ReadString(TDBXRegistryDriverValue);
        ConnectionFileName  := Registry.ReadString(TDBXRegistryConnectionValue);
      end;
    finally
      Registry.Destroy;
    end;
    Result := ConfigFilesFound;
  end;
{$ENDIF}
{$ENDIF}

  function GetConnectionFromExeDirectory: Boolean;
  var
    AppName: string;
  begin
    AppName := ParamStr(0);
    if AppName <> '' then
    begin
      AppDir := ExtractFileDir(AppName);
      DriverFileName :=  AppDir+'/'+TDBXDriverFile;
      ConnectionFileName := AppDir+'/'+TDBXConnectionFile;
    end;
    Result := ConfigFilesFound;
  end;

{$IFDEF MACOS}
  function GetConnectionFromPreferences: Boolean;
  begin
    Result := False;

    DriverFilename := GetEnvironmentVariable('HOME') + LibraryPreferences + TDBXDriverFile;
    ConnectionFilename := GetEnvironmentVariable('HOME') + LibraryPreferences + TDBXConnectionFile;
    if FileExists(ConnectionFileName) or FileExists(DriverFileName) then
    begin
      Result := True;
      Exit;
    end;

    DriverFilename := LibraryPreferences + TDBXDriverFile;
    ConnectionFilename := LibraryPreferences + TDBXConnectionFile;
    if FileExists(ConnectionFileName) or FileExists(DriverFileName) then
      Result := True;
  end;
{$ENDIF}

begin
  Result := nil;
  TDBXDriverRegistry.DBXDriverRegistry.FDrivers.LockList;
  try
    if ConnectionFactorySingleton = nil then
    begin
      DriverFileName := '';
      ConnectionFileName := '';

      if GetConnectionFromExeDirectory
{$IFNDEF POSIX}
{$IFNDEF NEXTGEN}
         or GetConnectionFromRegistry(HKEY_CURRENT_USER) or
         GetConnectionFromRegistry(HKEY_LOCAL_MACHINE)
{$ENDIF}
{$ENDIF}
{$IFDEF MACOS}
         or GetConnectionFromPreferences
{$ENDIF}
      then
      begin
        ConnectionFactorySingleton := OpenConnectionFactory(DriverFileName, ConnectionFileName);
      end;

      if ConnectionFactorySingleton = nil then
      begin
        ConnectionFactorySingleton := TDBXMemoryConnectionFactory.Create;
        ConnectionFactorySingleton.Open;
      end;

      if ConnectionFactorySingleton = nil then
        raise TDBXError.Create(TDBXErrorCodes.DriverInitFailed,
            Format(SConnectionFactoryInitFailed, [AppDir, TDBXRegistryKey]));
    end
    else
      ConnectionFactorySingleton.Open;
    Result := ConnectionFactorySingleton;
  finally
    TDBXDriverRegistry.DBXDriverRegistry.FDrivers.UnLockList;
  end;
end;

procedure TDBXConnectionFactory.GetConnectionItems(Items: TStrings);
begin
  Items.AddStrings(FConnectionProperties.Keys.ToArray);
end;

class procedure TDBXConnectionFactory.Lock;
begin
  TMonitor.Enter(FLock);
end;

class procedure TDBXConnectionFactory.Unlock;
begin
  TMonitor.Exit(FLock);
end;

class procedure TDBXConnectionFactory.SetConnectionFactory(
  const ConnectionFactory: TDBXConnectionFactory);
begin
  if ConnectionFactorySingleton <> nil then
    raise TDBXError.Create(TDBXErrorCodes.InvalidArgument, SSetSingletonOnce);
  ConnectionFactorySingleton := ConnectionFactory;
end;

procedure TDBXConnectionFactory.SetErrorEvent(const ErrorEvent: TDBXErrorEvent);
begin
  FDBXContext.OnError := ErrorEvent;
end;

procedure TDBXConnectionFactory.SetTraceFlags(const TraceFlags: TDBXTraceFlag);
begin
  FDBXContext.TraceFlags := TraceFlags;
end;

procedure TDBXConnectionFactory.SetTraceInfoEvent(
  const TraceInfoEvent: TDBXTraceEvent);
begin
  FDBXContext.OnTrace := TraceInfoEvent;
end;

function TDBXIniFileConnectionFactory.LoadSectionProperties(IniFile: TMemIniFile;
  Section: string;
  LoadConnection: Boolean): TDBXProperties;
var
  ConnectionProperties: TDBXProperties;
  Properties : TStringList;
  TrimProperties : TStringList;
  Index: TInt32;
begin
  Properties := nil;
  ConnectionProperties := nil;
  TrimProperties := nil;
  try
    ConnectionProperties := TDBXProperties.Create;
    Properties := TStringList.Create;
    IniFile.ReadSectionValues(Section, Properties);

    TrimProperties := TStringList.Create;

    for Index := 0 to Properties.Count - 1 do
      TrimProperties.Add(Properties.Names[Index] + '=' + Properties.ValueFromIndex[Index].Trim);

    if LoadConnection then
      TrimProperties.Add(TDBXPropertyNames.ConnectionName + '=' + Section);

    FreeAndNil(ConnectionProperties.FProperties);
    ConnectionProperties.FProperties := TrimProperties;
    TrimProperties := nil;
    Result := ConnectionProperties;
    Result.FOwner := Self;
    ConnectionProperties := nil;
  finally
    Properties.Free;
    TrimProperties.Free;
    ConnectionProperties.Free;
  end;
end;

procedure TDBXIniFileConnectionFactory.LoadConnections;
var
  ConnectionFile        : TMemIniFile;
  SectionList           : TStringList;
  Index                 : TInt32;
  DBXProperties         : TDBXProperties;
begin
  inherited;
  if FConnectionsFile <> '' then
  begin
    ConnectionFile := nil;
    SectionList    := nil;
    try
      ConnectionFile := TMemIniFile.Create(FConnectionsFile);
      SectionList   := TStringList.Create;
      ConnectionFile.ReadSections(SectionList);
      for Index := 0 to SectionList.Count - 1 do
      begin
        DBXProperties := LoadSectionProperties(ConnectionFile, SectionList.Strings[Index], true);
        FConnectionProperties.Add(SectionList.Strings[Index], TDBXPropertiesItem.Create(DbxProperties));
      end;
    finally
      ConnectionFile.Free;
      SectionList.Free;
    end;
  end;
end;

function TDBXIniFileConnectionFactory.LoadDriver(DriverIni : TMemIniFile; const DriverName: string) : TDBXProperties;
begin
  Result := LoadSectionProperties(DriverIni, DriverName, false);
end;

procedure TDBXIniFileConnectionFactory.LoadDrivers;
var
  DriverFile        : TMemIniFile;
  EnabledDriverList : TStringList;
  Index             : TInt32;
begin
  if FDriversFile <> '' then
  begin
    EnabledDriverList := nil;
    DriverFile        := nil;
    try
      DriverFile := TMemIniFile.Create(FDriversFile);
      EnabledDriverList := TStringList.Create;
      DriverFile.ReadSection(TDBXPropertyNames.InstalledDrivers, EnabledDriverList);

      if EnabledDriverList.Count = 0 then
        FDBXContext.Error(TDBXErrorCodes.DriverInitFailed, Format(SNotDefinedIn, [TDBXPropertyNames.InstalledDrivers, FDriversFile]));

      for Index := 0 to EnabledDriverList.Count - 1 do
      begin
        if not FDrivers.ContainsKey(EnabledDriverList[Index]) then
          FDrivers.Add(EnabledDriverList[Index], LoadDriver(DriverFile, EnabledDriverList[Index]));
      end;

    finally
      EnabledDriverList.Free;
      DriverFile.Free;
    end;
  end;
  inherited;
end;

constructor TDBXIniFileConnectionFactory.Create;
begin
  inherited Create;
  FConnectionsFile := '';
  FDriversFile := '';
end;

destructor TDBXIniFileConnectionFactory.Destroy;
begin
  inherited Destroy;
  FConnectionsFile := '';
  FDriversFile := '';
end;

procedure TDBXIniFileConnectionFactory.GetDriverItems(Items: TStrings);
begin
  Items.AddStrings(FDrivers.Keys.ToArray);
end;

{ TConnectionProperties }

procedure TDBXProperties.Add(const Name, Value: string);
begin
  FProperties.Add(Name+'='+Value);
end;

procedure TDBXProperties.AddProperties(List: TStrings);
var
  Index: Integer;
begin
  FProperties.BeginUpdate;
  try
    for Index := 0 to List.Count - 1 do
      FProperties.Add(List.Names[Index] + '=' + Trim(List.ValueFromIndex[Index]));
  finally
    FProperties.EndUpdate;
  end;
end;

procedure TDBXProperties.AddUniqueProperties(List: TStrings);
var
  Index: Integer;
begin
  for Index := 0 to List.Count - 1 do
  begin
    if FProperties.IndexOfName(List.Names[Index]) < 0 then
      FProperties.Add(List.Names[Index] + '=' + Trim(List.ValueFromIndex[Index]));
  end;
end;

procedure TDBXProperties.SetComponentOwner(AOwner: TComponent);
begin
  FComponentOwner := AOwner;
end;

procedure TDBXProperties.SetProperties(const ConnectionString: string);
begin
  FProperties.Delimiter := ';';
  FProperties.StrictDelimiter := True;
  FProperties.DelimitedText := ConnectionString;
end;

procedure TDBXProperties.Clear;
begin
  FProperties.Clear;
end;

function TDBXProperties.Clone: TDBXProperties;
begin
  Result := TDBXPropertiesClass(ClassType).Create(FDBXContext);
  Result.MergeProperties(Properties);
end;

constructor TDBXProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create;
  FDBXContext := DBXContext;
  FProperties := TStringList.Create;
  FOnChange := nil;
  TStringList(FProperties).OnChange := DoOnChange;
  FEvents := TEventsCollection.Create;
end;

constructor TDBXProperties.Create;
begin
  inherited;
  FProperties := TStringList.Create;
  FOnChange := nil;
  TStringList(FProperties).OnChange := DoOnChange;
  FEvents := TEventsCollection.Create;
end;

destructor TDBXProperties.Destroy;
var
  Index : TInt32;
begin
  inherited;
  if FProperties <> nil then
  begin
    TStringList(FProperties).OnChange := nil;
    for Index := 0 to FProperties.Count - 1 do
      FProperties.Objects[Index].DisposeOf;
  end;
  FEvents.Free;
  FProperties.Free;
end;

procedure TDBXProperties.DoOnChange(Sender: TObject);
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TDBXProperties.GetBoolean(const Name: string): Boolean;
var
  Value: string;
begin
  Result := False;
  Value := Values[Name];
  if Value <> '' then
  begin
    if (Value.Chars[0] = 't') or (Value.Chars[0] = 'T') then
      Result := True;
  end;
end;

function TDBXProperties.GetCount: Integer;
begin
  Result := FProperties.Count;
end;

function TDBXProperties.GetInteger(const Name: string): Integer;
var
  Value: string;
begin
  Result := -1;
  Value := Values[Name];
  if Value <> '' then
    Result := StrToInt(Value);
end;

procedure TDBXProperties.GetLists(var Names, Values: TWideStringArray);
var
  Index: Integer;
  Count: Integer;
begin
  Count := FProperties.Count;
  SetLength(Names, Count);
  SetLength(Values, Count);
  for Index := 0 to Count - 1 do
  begin
    Names[Index]  := FProperties.Names[Index];
    Values[Index] := FProperties.ValueFromIndex[Index];
  end;
end;

function TDBXProperties.GetRequiredValue(const Name: string): string;
var
  Message: string;
begin
  Result := FProperties.Values[Name];
  if Result = '' then
  begin
    Message := string.Format(SRequiredProperty, [Name]);
    if FDBXContext <> nil then
      FDBXContext.Error(TDBXErrorCodes.InvalidArgument, message)
    else
      raise TDBXError.Create(TDBXErrorCodes.InvalidArgument, message);
  end;
end;

function TDBXProperties.GetValue(const Name: string): string;
begin
  Result := FProperties.Values[Name]
end;

function TDBXProperties.GetOwner: TPersistent;
begin
  Result := FComponentOwner;
end;

procedure TDBXProperties.SetValue(const Name, Value: string);
begin
  FProperties.Values[Name] := Value;
end;

procedure TDBXProperties.MergeProperties(List: TStrings);
var
  Index: Integer;
  Pos: Integer;
  Key: string;
begin
  FProperties.BeginUpdate;
  try
    for Index := 0 to List.Count - 1 do
    begin
      Key := List.Names[Index];
      Pos := FProperties.IndexOfName(Key);
      if Pos < 0 then
        FProperties.Add(Key + '=' + List.ValueFromIndex[Index].Trim)
      else
        FProperties[Pos] := Key + '=' + List.ValueFromIndex[Index];
    end;
  finally
    FProperties.EndUpdate;
  end;
end;

procedure TDBXDriver.AddCommandFactory(const Name: string;
  OnCreateCommand: TDBXCreateCommandEvent);
var
  CreateCommandObject: TDBXCreateCommand;
begin
  CreateCommandObject := TDBXCreateCommand.Create;
  CreateCommandObject.FOnCreateCommand := OnCreateCommand;
  FCommandFactories.Add(Name, CreateCommandObject);
end;

procedure TDBXDriver.LoadMetaDataCommandFactory(const MetaDataCommandFactoryClassName: string; const MetaDataCommandFactoryPackageName: string);
var
  ClassRegistry: TClassRegistry;
begin
  ClassRegistry := TClassRegistry.GetClassRegistry;
  if ClassRegistry.HasClass(MetaDataCommandFactoryClassName) then
  begin
    FMetaDataCommandFactory := TDBXCommandFactory(ClassRegistry.CreateInstance(MetaDataCommandFactoryClassName));
    AddCommandFactory(TDBXCommandTypes.DbxMetaData, FMetaDataCommandFactory.CreateCommand);
  end
  else
  begin
    if FDBXContext = nil then
      FDBXContext := TDBXContext.Create;
    FDBXContext.Error(TDBXErrorCodes.DriverInitFailed, Format(SMetaDataLoadError, [MetaDataCommandFactoryClassName, MetaDataCommandFactoryPackageName, FDriverProperties[TDBXPropertyNames.DriverUnit]]));
  end;
end;

procedure TDBXDriver.AddCommandFactory(const Name: string;
  CommandFactory: TDBXCommandFactory);
begin
  AddCommandFactory(Name, CommandFactory.CreateCommand);
end;

procedure TDBXDriver.AddReference;
begin
  TDBXDriverRegistry.DBXDriverRegistry.FDrivers.LockList;
  try
    Inc(FReferenceCount);
  finally
    TDBXDriverRegistry.DBXDriverRegistry.FDrivers.UnLockList;
  end;
end;


procedure TDBXDriver.CacheUntilFinalization;
begin
  if not FCachedUntilFinalization then
  begin
    FCachedUntilFinalization := True;
    AddReference;
  end;
end;

procedure TDBXDriver.UncacheAtFinalization;
begin
  if FCachedUntilFinalization then
    RemoveReference;
end;

constructor TDBXDriver.Create;
begin
  inherited Create;
  FCommandFactories := TObjectDictionary<string, TDBXCreateCommand>.Create([doOwnsValues], TIStringComparer.Ordinal);
end;

constructor TDBXDriver.Create(DriverDef: TDBXDriverDef);
begin
  inherited Create;
  FCommandFactories := TObjectDictionary<string, TDBXCreateCommand>.Create([doOwnsValues], TIStringComparer.Ordinal);
end;

function TDBXDriver.CreateMorphCommand(DbxContext: TDBXContext;
  Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
var
  CommandFactory:  TDBXCreateCommand;
begin
  Result := nil;
  if FCommandFactories.ContainsKey(MorphicCommand.CommandType) then
  begin
    CommandFactory := FCommandFactories.Items[MorphicCommand.CommandType];
    Result := CommandFactory.FOnCreateCommand(DbxContext, Connection, MorphicCommand);
  end;

  if (Result = nil) and FCommandFactories.ContainsKey('') then
  begin
    CommandFactory := FCommandFactories.Items[''];
    Result := CommandFactory.FOnCreateCommand(DbxContext, Connection, MorphicCommand);
  end;
end;

destructor TDBXDriver.Destroy;
var
  Drivers: TThreadList<TDBXDriver>;
  List: TList<TDBXDriver>;
  Index: Integer;
  DriverRegistry: TDBXDriverRegistry;
begin
  Close;
  DriverRegistry := TDBXDriverRegistry.DBXDriverRegistry;
  if (DriverRegistry <> nil) and (DriverName <> '') then
  begin
    Drivers := DriverRegistry.FDrivers;
    List := Drivers.LockList;
    try
      Index := TDBXDriverRegistry.DBXDriverRegistry.FindDriver(List, DriverName);
      if (Index >= 0) and (List[Index] = Self) then
      begin
        List.Delete(Index);
      end;
    finally
      Drivers.UnlockList;
    end;
  end;
  FCommandFactories.Free;
  FMetaDataCommandFactory.Free;
  FDriverProperties.Free;
  inherited;
end;

function TDBXDriver.GetDriverClass: TClass;
begin
  Result := Self.ClassType;
end;

function TDBXDriver.GetDriverName: string;
begin
  Result := FDriverName;
end;

function TDBXDriver.GetDriverProperties: TDBXProperties;
begin
  Result := FDriverProperties;
end;

procedure TDBXDriver.GetDriverPropertyNames(List: TStrings);
begin
  List.Add(TDBXPropertyNames.DriverUnit);
  List.Add(TDBXPropertyNames.GetDriverFunc);
  List.Add(TDBXPropertyNames.VendorLib);
  List.Add(TDBXPropertyNames.LibraryName);
  List.Add(TDBXPropertyNames.DriverAssembly);
  List.Add(TDBXPropertyNames.DriverPackage);
  List.Add(TDBXPropertyNames.DriverPackageLoader);
  List.Add(TDBXPropertyNames.MetaDataPackageLoader);
  List.Add(TDBXPropertyNames.MetaDataAssemblyLoader);
end;

procedure TDBXDriver.RemoveReference;
begin
  TDBXDriverRegistry.DBXDriverRegistry.FDrivers.LockList;
  try
    Dec(FReferenceCount);
    if FReferenceCount < 1 then
      TDBXDriverRegistry.DBXDriverRegistry.FreeDriver(Self);
  finally
    TDBXDriverRegistry.DBXDriverRegistry.FDrivers.UnLockList;
  end;
end;

procedure TDBXDriver.SetDriverName(const DriverName: string);
begin
  FDriverName := DriverName;
end;

procedure TDBXDriver.InitDriverProperties(const DriverProperties: TDBXProperties);
begin
  Assert(FDriverProperties = nil, 'Can only init once');
  FDriverProperties := DriverProperties;
end;

//function TDBXDriver.HasDBX4MetaData: Boolean;
//begin
//  Result := (FMetaDataCommandFactory <> nil);
//end;

{ TDBXError }

constructor TDBXError.Create(ErrorCode: TDBXErrorCode; const ErrorMessage: string);
begin
  if ErrorMessage = '' then
    FErrorMessage := Format(SDefaultErrorMessage, [ErrorCodeToString(ErrorCode)])
  else
    FErrorMessage := ErrorMessage;
  inherited Create(FErrorMessage);
  FErrorCode    := ErrorCode;
end;

constructor TDBXError.Create(ErrorCode: TDBXErrorCode;
  const ErrorMessage: string; const InnerException: Exception);
begin
  Create(ErrorCode, ErrorMessage);  // Delphi runtim automatically sets the InnerException.
end;

class function TDBXError.ErrorCodeToString(ErrorCode: TDBXErrorCode): string;
begin
  case ErrorCode of
    TDBXErrorCodes.None:                              Result := SDBXErrNone;
    TDBXErrorCodes.Warning:                           Result := SDBXErrWarning;
    TDBXErrorCodes.NoMemory:                          Result := SDBXErrNoMemory;
    TDBXErrorCodes.UnsupportedFieldType:              Result := SDBXErrUnsupportedFieldType;
    TDBXErrorCodes.InvalidHandle:                     Result := SDBXErrInvalidHandle;
    TDBXErrorCodes.NotSupported:                      Result := SDBXErrNotSupported;
    TDBXErrorCodes.InvalidTime:                       Result := SDBXErrInvalidTime;
    TDBXErrorCodes.InvalidType:                       Result := SDBXErrInvalidType;
    TDBXErrorCodes.InvalidOrdinal:                    Result := SDBXErrInvalidOrdinal;
    TDBXErrorCodes.InvalidParameter:                  Result := SDBXErrInvalidParameter;
    TDBXErrorCodes.EOF:                               Result := SDBXErrEOF;
    TDBXErrorCodes.ParameterNotSet:                   Result := SDBXErrParameterNotSet;
    TDBXErrorCodes.InvalidUserOrPassword:             Result := SDBXErrInvalidUserOrPassword;
    TDBXErrorCodes.InvalidPrecision:                  Result := SDBXErrInvalidPrecision;
    TDBXErrorCodes.InvalidLength:                     Result := SDBXErrInvalidLength;
    TDBXErrorCodes.InvalidIsolationLevel:             Result := SDBXErrInvalidIsolationLevel;
    TDBXErrorCodes.InvalidTransactionId:              Result := SDBXErrInvalidTransactionId;
    TDBXErrorCodes.DuplicateTransactionId:            Result := SDBXErrDuplicateTransactionId;
    TDBXErrorCodes.DriverRestricted:                  Result := SDBXErrDriverRestricted;
    TDBXErrorCodes.TransactionActive:                 Result := SDBXErrTransactionActive;
    TDBXErrorCodes.MultipleTransactionNotEnabled:     Result := SDBXErrMultipleTransactionNotEnabled;
    TDBXErrorCodes.ConnectionFailed:                  Result := SDBXErrConnectionFailed;
    TDBXErrorCodes.DriverInitFailed:                  Result := SDBXErrDriverInitFailed;
    TDBXErrorCodes.OptimisticLockFailed:              Result := SDBXErrOptimisticLockFailed;
    TDBXErrorCodes.InvalidReference:                  Result := SDBXErrInvalidReference;
    TDBXErrorCodes.NoTable:                           Result := SDBXErrNoTable;
    TDBXErrorCodes.MissingParameterMarker:            Result := SDBXErrMissingParameterMarker;
    TDBXErrorCodes.NotImplemented:                    Result := SDBXErrNotImplemented;
    TDBXErrorCodes.DriverIncompatible:                Result := SDBXErrDriverIncompatible;
    TDBXErrorCodes.InvalidArgument:                   Result := SDBXErrInvalidArgument;
    TDBXErrorCodes.NoData:                            Result := SDBXErrNoData;
    TDBXErrorCodes.VendorError:                       Result := SDBXErrVendorError;
    TDBXErrorCodes.UnrecognizedCommandType:           Result := SDBXErrUnrecognizedCommandType;
    TDBXErrorCodes.SchemaNameUnspecified:             Result := SDBXErrSchemaNameUnspecified;
    TDBXErrorCodes.DatabaseUnspecified:               Result := SDBXErrDatabaseUnspecified;
    TDBXErrorCodes.LibraryNameUnspecified:            Result := SDBXErrLibraryNameUnspecified;
    TDBXErrorCodes.GetDriverFuncUnspecified:          Result := SDBXErrGetDriverFuncUnspecified;
    TDBXErrorCodes.VendorLibUnspecified:              Result := SDBXErrVendorLibUnspecified;
    else
      Result := SErrorCode + IntToStr(Integer(ErrorCode));
  end;

end;
{ TDBXConnectionValue }

destructor TDBXConnectionValue.Destroy;
begin

  inherited;
end;

function TDBXConnectionValue.GetDBXConnection: TDBXConnection;
begin
  Result := FDBXConnection;
end;

function TDBXConnectionValue.IsNull: Boolean;
begin
  Result := FIsNull;
end;

procedure TDBXConnectionValue.SetDBXConnection(const Value: TDBXConnection);
begin
  if Value = nil then
    SetNull
  else
  begin
    FIsNull := false;
    FDBXConnection := Value;

  end;

end;

procedure TDBXConnectionValue.SetRowValue;
begin
end;


procedure TDBXConnectionValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetDBXConnection(Value.GetDBXConnection);
end;

{ TDBXValueType }

function TDBXValueType.Clone: TDBXValueType;
begin
  Result := TDBXValueType.Create(FDBXContext);
  Result.FName                := FName;
  Result.FOrdinal             := FOrdinal;
  Result.FDataType            := FDataType;
  Result.FSubType             := FSubType;
  Result.FSize                := FSize;
  Result.FPrecision           := FPrecision;
  Result.FScale               := FScale;
  Result.FChildPosition       := FChildPosition;
  Result.FFlags               := FFlags;
  Result.FParameterDirection  := FParameterDirection;
end;

function TDBXValueType.WritableClone: TDBXValueType;
begin
  Result := Clone;
  Result.FFlags := Result.FFlags and not TDBXValueTypeFlags.ReadOnlyType;
end;

constructor TDBXValueType.Create(DBXContext: TDBXContext);
begin
  inherited Create;
  FDBXContext := DBXContext;
end;

constructor TDBXValueType.Create;
begin
  inherited Create;
end;

//procedure TDBXValueType.FailIfReadOnly;
//begin
// Ado drivers allow this.
//  if      (ParameterDirection <> TDBXParameterDirections.InParameter)
//     and  (ParameterDirection <> TDBXParameterDirections.InOutParameter) then
//  begin
//    FDBXContext.Error(TDBXErrorCodes.InvalidParameter,
//      Format(SReadOnlyParameter, [FName]));
//  end;
//end;

procedure TDBXValueType.FailIfReadOnlyType;
begin
  if IsReadOnlyType then
    FDBXContext.Error(TDBXErrorCodes.InvalidParameter,
      Format(SReadOnlyType, [FName]));
end;

function TDBXValueType.GetDisplayName: string;
begin
  Result := FCaption;
end;

function TDBXValueType.GetChildPosition: TInt32;
begin
  Result := FChildPosition;
end;

function TDBXValueType.GetDataType: TDBXType;
begin
  Result := FDataType;
end;

function TDBXValueType.GetFlags: TInt32;
begin
  Result := FFlags;
end;

function TDBXValueType.GetHidden: LongBool;
begin
  Result := (GetFlags and TInt32(TDBXValueTypeFlags.Hidden)) <> 0;
end;

function TDBXValueType.GetLiteral: Boolean;
begin
  Result := (GetFlags and TInt32(TDBXValueTypeFlags.Literal)) <> 0;
end;

function TDBXValueType.GetName: string;
begin
  Result := FName;
end;


function TDBXValueType.GetOrdinal: TInt32;
begin
  Result := FOrdinal;
end;

function TDBXValueType.GetParameterDirection: TDBXParameterDirection;
begin
  Result := FParameterDirection;
end;

function TDBXValueType.GetPrecision: Int64;
begin
  Result := FPrecision;
end;

function TDBXValueType.GetScale: TInt32;
begin
  Result := FScale;
end;

function TDBXValueType.GetSize: Int64;
begin
  Result := FSize;
end;

function TDBXValueType.GetSubType: TDBXType;
begin
  Result := FSubType;
end;

function TDBXValueType.GetValueParameter: Boolean;
begin
  Result := (GetFlags and TInt32(TDBXValueTypeFlags.ValueParameter)) <> 0;
end;

function TDBXValueType.IsAutoIncrement: Boolean;
begin
  Result := (GetFlags and TInt32(TDBXValueTypeFlags.AutoIncrement)) <> 0;
end;

//function TDBXValueType.IsBlobSizeExact: Boolean;
//begin
//  Result := (GetFlags and TInt32(TDBXValueTypeFlags.BlobSizeExact)) <> 0;
//end;

function TDBXValueType.IsNullable: Boolean;
begin
  Result := (GetFlags and TInt32(TDBXValueTypeFlags.Nullable)) <> 0;
end;

function TDBXValueType.IsReadOnly: Boolean;
begin
  Result := (GetFlags and TInt32(TDBXValueTypeFlags.ReadOnly)) <> 0;
end;

function TDBXValueType.IsReadOnlyType: Boolean;
begin
  Result := (GetFlags and TInt32(TDBXValueTypeFlags.ReadOnlyType)) <> 0;
end;

function TDBXValueType.IsSearchable: Boolean;
begin
  Result := (GetFlags and TInt32(TDBXValueTypeFlags.Searchable)) <> 0;
end;

procedure TDBXValueType.SetDisplayName(const Caption: string);
begin
  FCaption := Caption;
end;

procedure TDBXValueType.SetChildPosition(const ChildPosition: TInt32);
begin
  FailIfReadOnlyType;
  if ChildPosition <> FChildPosition then
  begin
    FChildPosition := ChildPosition;
    FModified := true;
  end;
end;

procedure TDBXValueType.SetDataType(const DataType: TInt32);
begin
  FailIfReadOnlyType;
  if FDataType <> DataType then
  begin
    FDataType := DataType;
    FModified := true;
  end;
end;


procedure TDBXValueType.SetDbxRow(const DbxRow: TDBXRow);
begin
  if FDbxRow <> DbxRow then
  begin
    FDbxRow := DbxRow;
    FModified := true;
  end;
end;

procedure TDBXValueType.SetFlags(const Flags: TInt32);
begin
  if FFlags <> Flags then
  begin
    FailIfReadOnlyType;
    FFlags := Flags;
    FModified := true;
  end;
end;

procedure TDBXValueType.SetHidden(const Hidden: LongBool);
begin
  SetFlags(GetFlags or TInt32(TDBXValueTypeFlags.Hidden));
end;

procedure TDBXValueType.SetLiteral(const Literal: Boolean);
begin
  SetFlags(GetFlags or TInt32(TDBXValueTypeFlags.Literal));
end;

procedure TDBXValueType.SetSize(const Size: Int64);
begin
  FailIfReadOnlyType;
  if FSize <> Size then
  begin
    FSize := Size;
    FModified := true;
  end;
end;


procedure TDBXValueType.SetPrecision(const Precision: Int64);
begin
  FailIfReadOnlyType;
  FPrecision := Precision;
end;

procedure TDBXValueType.SetReadOnlyType;
begin
  SetFlags(FFlags or TDBXValueTypeFlags.ReadOnlyType);
end;

procedure TDBXValueType.SetScale(const Scale: TInt32);
begin
  FailIfReadOnlyType;
  FScale := Scale;
end;

procedure TDBXValueType.SetName(const Name: string);
begin
  FailIfReadOnlyType;
  FName := Name;
end;


procedure TDBXValueType.SetNullable(const NullableValue: Boolean);
begin
  FailIfReadOnlyType;
  if Nullable <> NullableValue then
  begin
    if NullableValue then
      FFlags := FFlags + TDBXValueTypeFlags.Nullable
    else
      FFlags := FFlags - TDBXValueTypeFlags.Nullable;

    FModified := true;
  end;

end;

procedure TDBXValueType.SetOrdinal(const Ordinal: TInt32);
begin
  FailIfReadOnlyType;
  if FOrdinal <> Ordinal then
  begin
    FOrdinal := Ordinal;
    FModified := true;
  end;
end;

procedure TDBXValueType.SetSubType(const SubType: TInt32);
begin
  FailIfReadOnlyType;
  FSubType := SubType;
end;

procedure TDBXValueType.SetValueParameter(const ValueParameter: Boolean);
begin
  SetFlags(FFlags or TDBXValueTypeFlags.ValueParameter);
end;

class function TDBXValueType.DataTypeName(DataType: TDBXType): string;
begin
  case DataType of
    TDBXDataTypes.UnknownType         : Result := 'UNKNOWN';
    TDBXDataTypes.AnsiStringType      : Result := 'ZSTRING';
    TDBXDataTypes.DateType            : Result := 'DATE';
    TDBXDataTypes.BlobType            : Result := 'BLOB';
    TDBXDataTypes.BooleanType         : Result := 'BOOL';
    TDBXDataTypes.UInt8Type           : Result := 'UINT8';
    TDBXDataTypes.Int8Type            : Result := 'INT8';
    TDBXDataTypes.Int16Type           : Result := 'INT16';
    TDBXDataTypes.Int32Type           : Result := 'INT32';
    TDBXDataTypes.SingleType          : Result := 'SINGLE';
    TDBXDataTypes.DoubleType          : Result := 'DOUBLE';
    TDBXDataTypes.BcdType             : Result := 'BCD';
    TDBXDataTypes.BytesType           : Result := 'BYTES';
    TDBXDataTypes.TimeType            : Result := 'TIME';
    TDBXDataTypes.DateTimeType            : Result := 'DATETIME';
    TDBXDataTypes.UINT16Type          : Result := 'UINT16';
    TDBXDataTypes.Uint32Type          : Result := 'UINT32';
//      FLOATIEEE         : Result := 'FLOATIEE';
    TDBXDataTypes.VarBytesType        : Result := 'VARBYTES';
//      LOCKINFO          : Result := 'LOCKINFO';
    TDBXDataTypes.CursorType          : Result := 'CURSOR';
    TDBXDataTypes.Int64Type           : Result := 'INT64';
    TDBXDataTypes.Uint64Type          : Result := 'UINT64';
    TDBXDataTypes.AdtType             : Result := 'ADT';
    TDBXDataTypes.ArrayType           : Result := 'ARRAY_TYPE';
    TDBXDataTypes.RefType             : Result := 'REF';
    TDBXDataTypes.TableType           : Result := 'TABLE';
    TDBXDataTypes.TimeStampType       : Result := 'TIMESTAMP';
//      FMTBCD            : Result := 'FMTBCD';
    TDBXDataTypes.WideStringType      : Result := 'WideString';
    TDBXDataTypes.CurrencyType        : Result := 'Currency';
    TDBXDataTypes.VariantType         : Result := 'Variant';
    TDBXDataTypes.TimeStampOffsetType  : Result := 'TIMESTAMPOFFSET';
    TDBXDataTypes.JsonValueType       : Result := 'JSON';
    else
      Result := 'UNKNOWN('+IntToStr(DataType)+')';
  end;
  Result := 'TDBXTypes.' + Result;
end;

destructor TDBXValueType.Destroy;
begin
  inherited;
end;

class procedure TDBXValueType.InvalidTypeAccess(ExpectedDataType, DataType: TDBXType);
begin
  raise TDBXError.Create(
    TDBXErrorCodes.InvalidType,
    Format(SInvalidTypeAccess,
                [ TDBXValueType.DataTypeName(ExpectedDataType),
                  TDBXValueType.DataTypeName(DataType)
                ]
              )
    );
end;


{ TDBXDriverRegistry }

constructor TDBXDriverRegistry.Create;
begin
  inherited Create;
  FDriverLoaders    := TObjectDictionary<string, TDBXDriverLoader>.Create([doOwnsValues], TIStringComparer.Ordinal);
  FDriverClasses    := TDictionary<string, TDBXDriverClass>.Create(TIStringComparer.Ordinal);
  FDrivers          := TThreadList<TDBXDriver>.Create;
end;

destructor TDBXDriverRegistry.Destroy;
begin
  inherited;
  FreeAllLoaders;
  FDriverLoaders.Free;
  FDriverClasses.Free;
  FDrivers.Free;
end;

function TDBXDriverRegistry.FindDriver(List: TList<TDBXDriver>;
  const DriverName: string): Integer;
var
  Index: TInt32;
  Driver: TDBXDriver;
begin
  Result := -1;
  for Index := 0 to List.Count - 1 do
  begin
    Driver := List[Index];
    if SameText(Driver.DriverName, DriverName) then
    begin
      Result := Index;
      Exit;
    end;
  end;
end;

procedure TDBXDriverRegistry.DriverLoadError(DriverDef: TDBXDriverDef; PackageName: string);
var
  DBXContext: TDBXContext;
begin
  DBXContext := DriverDef.FDBXContext;
  DBXContext.Error(TDBXErrorCodes.DriverInitFailed, Format(sUnknownDriver, [DriverDef.FDriverName]));
end;

procedure SplitTypeIntoClassAndPackage(var ClassName: string; var PackageName: string);
var
  Pos: Integer;
begin
  for Pos := 0 to ClassName.Length - 1 do
  begin
    if ClassName.Chars[Pos] = ',' then
    begin
      PackageName := ClassName.SubString(Pos+1, ClassName.Length-Pos);
      ClassName := ClassName.SubString(0, Pos);
      break;
    end;
  end;
end;

function RegisterClassLoader(DriverProperties: TDBXProperties; ClassNameProp: string; ClassNameDefault: string; PackageNameProp: string; PackageDefault: string; out ResultPackageName: string): string;
var
  ClassRegistry: TClassRegistry;
  ClassName: string;
  PackageName: string;
begin
  if Assigned(DriverProperties) then
  begin
    ClassName := DriverProperties.GetValue(ClassNameProp);
    PackageName := DriverProperties.GetValue(PackageNameProp);
    SplitTypeIntoClassAndPackage(ClassName, PackageName);
    if ClassName = '' then
      ClassName := ClassNameDefault;
    if PackageName = '' then
      PackageName := PackageDefault;
  end
  else
  begin
    ClassName := ClassNameDefault;
    PackageName := PackageDefault;
  end;

  if ClassName <> '' then
  begin
    ClassRegistry := TClassRegistry.GetClassRegistry;
    if not ClassRegistry.HasClass(ClassName) then
    begin
      if ModuleIsPackage then
        ClassRegistry.RegisterPackageClass(ClassName, PackageName);
    end;
  end;

  Result := ClassName;
  ResultPackageName := PackageName;
end;

procedure TDBXDriverRegistry.LoadMetaDataCommandFactory(Driver: TDBXDriver);
var
  MetaDataClassName: string;
  MetaDataPackageName: string;
  DriverProperties: TDBXProperties;
begin
  DriverProperties := Driver.FDriverProperties;
  MetaDataClassName := RegisterClassLoader(DriverProperties, TDBXPropertyNames.MetaDataPackageLoader, '', '', '', MetaDataPackageName);
  if MetaDataClassName <> '' then
    Driver.LoadMetaDataCommandFactory(MetaDataClassName, MetaDataPackageName);
end;

function TDBXDriverRegistry.LoadDriver(DriverDef: TDBXDriverDef; List: TList<TDBXDriver>): TDBXDriver;
var
  DriverLoader: TDBXDriverLoader;
begin
  Result := nil;
  for DriverLoader in FDriverLoaders.Values do
  begin
    Result := DriverLoader.Load(DriverDef);
    if Result <> nil then
    begin
      Result.FDriverLoader := DriverLoader;
      Result.SetDriverName(DriverDef.FDriverName);
      List.Add(Result);
      if Assigned(DriverDef.FDriverProperties) and not Assigned(Result.FDriverProperties) then
        Result.InitDriverProperties(DriverDef.FDriverProperties.Clone);
      LoadMetaDataCommandFactory(Result);
      Break;
    end;
  end;
end;

class procedure TDBXDriverRegistry.RegisterDriver(DriverName: string;
  Driver: TDBXDriver);
begin

end;

class procedure TDBXDriverRegistry.RegisterDriverClass(DriverName: string;
  DriverClass: TDBXDriverClass);
begin
  if not DBXDriverRegistry.FDriverClasses.ContainsKey(DriverName) then
    DBXDriverRegistry.FDriverClasses.Add(DriverName, DriverClass);
end;

class procedure TDBXDriverRegistry.UnregisterDriverClass(DriverName: string);
begin
  if DBXDriverRegistry <> nil then
    DBXDriverRegistry.FDriverClasses.Remove(DriverName);
end;

function TDBXDriverRegistry.GetDriver(DriverDef: TDBXDriverDef): TDBXDriver;
var
  List: TList<TDBXDriver>;
  Index: Integer;
  ClassName, PackageName: string;
  ClassRegistry: TClassRegistry;
  LoaderObject: TObject;
  DriverClass: TDBXDriverClass;
  Driver: TDBXDriver;
begin
  Result := nil;
  List := FDrivers.LockList;
  try
    Index := FindDriver(List, DriverDef.FDriverName);
    if Index < 0 then
    begin
      if FDriverClasses.ContainsKey(DriverDef.FDriverName) then
      begin
        DriverClass := FDriverClasses.Items[DriverDef.FDriverName];
        Driver := DriverClass.Create(DriverDef);
        Driver.DriverName := DriverDef.FDriverName;
        List.Add(Driver);
        LoadMetaDataCommandFactory(Driver);
      end
      else
      begin
        if (DriverDef.FDriverProperties <> nil) then
          Result := LoadDriver(DriverDef, List);
        if not Assigned(Result) then
        begin
          ClassRegistry := TClassRegistry.GetClassRegistry;
          ClassName := DriverDef.FDriverName;
          if not ClassRegistry.HasClass(ClassName) and (DriverDef.FDriverProperties <> nil) then
            ClassName := RegisterClassLoader(DriverDef.FDriverProperties, TDBXPropertyNames.DriverPackageLoader, DefaultDriverClassName, TDBXPropertyNames.DriverPackage, DefaultDriverPackageName, PackageName);
          if ClassRegistry.HasClass(ClassName) then
          begin
            LoaderObject := ClassRegistry.CreateInstance(ClassName);
            InternalRegisterLoader(ClassName, LoaderObject as TDBXDriverLoader);
            Result := LoadDriver(DriverDef, List);
          end;
        end;
      end;

      Index := FindDriver(List, DriverDef.FDriverName);
    end;
    if Index >= 0 then
    begin
      Result := List[Index];
      if DriverDef.FDriverProperties <> nil then
      begin
        if Result.GetDriverProperties = nil then
          Result.InitDriverProperties(DriverDef.FDriverProperties.Clone)
        else
          Result.DriverProperties.MergeProperties(DriverDef.FDriverProperties.Properties);
      end;
    end;
  finally
    FDrivers.UnlockList;
  end;

  if not Assigned(Result) then
    DriverLoadError(DriverDef, PackageName);
end;


procedure TDBXDriverRegistry.GetRegisteredDriverClassNames(
  DriverClassNameList: TStringList);
var
  Key: string;
begin
  for Key in FDriverClasses.Keys do
    DriverClassNameList.Add(Key);
end;

procedure TDBXDriverRegistry.GetRegisteredDriverLoaderNames(
  DriverLoaderNameList: TStringList);
begin
  DriverLoaderNameList.AddStrings(FDriverLoaders.Keys.ToArray);
end;

procedure TDBXDriverRegistry.GetRegisteredDriverNames(
  DriverNameList: TStringList);
begin
  GetRegisteredDriverLoaderNames(DriverNameList);
  GetRegisteredDriverClassNames(DriverNameList);
end;

procedure TDBXDriverRegistry.InternalRegisterLoader(const LoaderClassName: string; Loader: TDBXDriverLoader);
begin
  Inc(FCounter);
  FDrivers.LockList;
  try
    if FDriverLoaders.ContainsKey(Loader.FLoaderName) then
      raise TDBXError.Create(TDBXErrorCodes.DriverInitFailed, SDriverAlreadyRegistered + Loader.FLoaderName);
    Loader.FLoaderName := LoaderClassName;
    FDriverLoaders.Add(Loader.FLoaderName, Loader);
  finally
    FDrivers.UnlockList;
  end;
end;

procedure TDBXDriverRegistry.FreeDriver(Driver: TDBXDriver);
var
  Index: Integer;
  List: TList<TDBXDriver>;
begin
  List := FDrivers.LockList;
  try
    Index := FindDriver(List, Driver.DriverName);
    Assert(Index > -1);
    if Index > -1 then
    begin
      List.Delete(Index);
      Driver.Free;
    end;
  finally
    FDrivers.UnlockList;
  end;
end;

procedure TDBXDriverRegistry.CloseAllDrivers;
var
  List: TList<TDBXDriver>;
  Index: TInt32;
  Driver: TDBXDriver;
begin
  List := FDrivers.LockList;
  try
    Index := List.Count - 1;
    while Index >= 0 do
    begin
      Driver := List[Index];
      Driver.UncacheAtFinalization;
      Dec(Index);
    end;
    Index := 0;
    while Index < List.Count do
    begin
      Driver := List[Index];
      Driver.Close;
      Inc(Index);
    end;
  finally
    FDrivers.UnlockList;
  end;
end;

procedure TDBXDriverRegistry.FreeAllDrivers(Loader: TDBXDriverLoader);
var
  List: TList<TDBXDriver>;
  Index: TInt32;
  Driver: TDBXDriver;
begin
  List := FDrivers.LockList;
  try
    Index := 0;
    while Index < List.Count do
    begin
      Driver := List[Index];
      if Driver.FDriverLoader = Loader then
      begin
        List.Delete(Index);
        Driver.Free;
      end
      else
        Inc(Index);
    end;
  finally
    FDrivers.UnlockList;
  end;
end;

procedure TDBXDriverRegistry.FreeAllLoaders;
var
  LDriverLoader: TDBXDriverLoader;
begin
  FDrivers.LockList;
  try
    for LDriverLoader in FDriverLoaders.Values do
      FreeAllDrivers(LDriverLoader);
  finally
    FDrivers.UnlockList;
  end;
end;

{ TDBXConnection }

constructor TDBXConnection.Create(ConnectionBuilder:  TDBXConnectionBuilder);
begin
  inherited Create;
  FCommands             := TList<TDBXCommand>.Create;
  FDriverDelegate       := ConnectionBuilder.FDelegateDriver;
  FConnectionProperties := ConnectionBuilder.ConnectionProperties;
  FDBXContext      := TDBXContext.Create;
  if ConnectionBuilder.FDBXContext <> nil then
  begin
    FDBXContext.OnError := ConnectionBuilder.FDBXContext.OnError;
    FDBXContext.OnTrace := ConnectionBuilder.FDBXContext.OnTrace;
    FDBXContext.TraceFlags := ConnectionBuilder.FDBXContext.TraceFlags;
    FDBXContext.FDBXFormatter := ConnectionBuilder.FDBXContext.FDBXFormatter;
  end;
end;


function TDBXConnection.DerivedCreateCommand: TDBXCommand;
begin
  Result := TDBXMorphicCommand.Create(FDBXContext, Self);
end;

destructor TDBXConnection.Destroy;
begin
  // Can cause problems for some drivers like the dynalinks to close twice.
  //
  if IsOpen then
    Close;
  FDriverDelegate.Free;
  FDBXContext.Free;
  FMetaDataReader.Free;
  FConnectionProperties.Free;
  FCommands.Free;
  inherited Destroy;
end;

function TDBXConnection.CreateMorphCommand(MorphicCommand: TDBXCommand): TDBXCommand;
begin
  Result := TDBXDriver(FDriverDelegate).CreateMorphCommand(FDBXContext, Self, MorphicCommand);
end;

function TDBXConnection.CreateCommand: TDBXCommand;
begin
  Result := DerivedCreateCommand;
  if Assigned(DatabaseMetaData) and DatabaseMetaData.SupportsRowSetSize then
    if ConnectionProperty[TDBXPropertyNames.RowSetSize] <> '' then
      Result.SetRowSetSize(StrToInt(ConnectionProperty[TDBXPropertyNames.RowSetSize]))
    else
      Result.SetRowSetSize(DBXDefaultRowSetSize);
  AddCommand(Result);
end;


procedure TDBXConnection.Open;
begin
  // mark the state open so memory can be deallocated
  // even if derived open or meta query fail
  FOpen := true;

  DerivedOpen;
  DatabaseMetaData;
end;

procedure TDBXConnection.Close;
begin
  CloseAllCommands;
  RollbackAllTransactions;
  DerivedClose;
  SetTraceInfoEvent(nil);
  FreeAndNil(FDatabaseMetaData);
  FOpen := false;
end;

procedure TDBXConnection.CloseAllCommands;
begin
  while FCommands.Count > 0 do
    FCommands[0].ConnectionClosing;
end;


function TDBXConnection.HasTransaction(Transaction: TDBXTransaction): Boolean;
var
  Current: TDBXTransaction;
begin
  Current := FTransactionStack;
  while Current <> nil do
  begin
    if Current = Transaction then
    begin
      Result := true;
      exit;
    end;
    Current := Current.FNext;
  end;
  Result := False;
end;


procedure TDBXConnection.CheckTransaction(Transaction: TDBXTransaction);
begin
  if HasTransaction(Transaction) = False then
    FDBXContext.Error(TDBXErrorCodes.InvalidArgument, sInvalidTransaction);
end;

procedure TDBXConnection.FreeTransactions(StartTransaction: TDBXTransaction);
var
  Current: TDBXTransaction;
  Next:   TDBXTransaction;
begin
  Current := FTransactionStack;
  while (Current <> nil)  do
  begin
    Next := Current.FNext;
    Current.FConnection := nil;
    Current.Free;
    if (Current = StartTransaction) then
    begin
      Current := Next;
      break;
    end;
    Current := Next;
  end;
  FTransactionStack := Current;
end;

function TDBXConnection.GetDatabaseMetaData: TDBXDatabaseMetaData;
begin
  if FDatabaseMetaData = nil then
  begin
    FDatabaseMetaData := TDBXDatabaseMetaData.Create(FDBXContext);
    FDatabaseMetaData.Init(Self);
  end;
  Result := FDatabaseMetaData;
end;

function TDBXConnection.GetTraceFlags: TDBXTraceFlag;
begin
  Result := FDBXContext.TraceFlags;
end;

function TDBXConnection.GetTraceInfoEvent: TDBXTraceEvent;
begin
  Result := FDBXContext.OnTrace;
end;


function TDBXConnection.BeginTransaction(
  Isolation: TDBXIsolation): TDBXTransaction;
begin
  Result := CreateAndBeginTransaction(Isolation);
  Result.FConnection := Self;
  if FTransactionStack <> nil then
    Result.FNext := FTransactionStack;
  FTransactionStack := Result;
end;

procedure TDBXConnection.AddCommand(Command: TDBXCommand);
begin
  FCommands.Add(Command);
  Command.FConnection := Self;
end;

function TDBXConnection.BeginTransaction: TDBXTransaction;
begin
  Result := BeginTransaction(FIsolationLevel);
end;

procedure TDBXConnection.CommitTransaction;
begin
  CommitFreeAndNil(FTransactionStack);
end;

procedure TDBXConnection.CommitFreeAndNil(var Transaction: TDBXTransaction);
begin
  CheckTransaction(Transaction);
  Commit(Transaction);
  FreeTransactions(Transaction);
  Transaction := nil;
end;

procedure TDBXConnection.RemoveCommand(Command: TDBXCommand);
begin
  FCommands.Remove(Command);
  Command.FConnection := nil;
end;

procedure TDBXConnection.RollbackAllTransactions;
begin
  while FTransactionStack <> nil do
    RollbackFreeAndNil(FTransactionStack);
end;

procedure TDBXConnection.RollbackFreeAndNil(var Transaction: TDBXTransaction);
begin
  CheckTransaction(Transaction);
  Rollback(Transaction);
  FreeTransactions(Transaction);
  Transaction := nil;
end;

procedure TDBXConnection.RollbackIncompleteFreeAndNil(var Transaction: TDBXTransaction);
begin
  if HasTransaction(Transaction) then
    RollbackFreeAndNil(Transaction);
  Transaction := nil;
end;

procedure TDBXConnection.RollbackTransaction;
begin
  RollbackFreeAndNil(FTransactionStack);
end;

procedure TDBXConnection.GetCommandTypes(List: TStrings);
begin
  // The minimum types that must be supported by a driver.
  //
  List.Add(TDBXCommandTypes.DbxSQL);
  List.Add(TDBXCommandTypes.DbxStoredProcedure);
  List.Add(TDBXCommandTypes.DbxTable);
  List.Add(TDBXCommandTypes.DbxMetaData);
  DerivedGetCommandTypes(List);
end;

procedure TDBXConnection.GetCommands(const CommandType: string;
  List: TStrings);
begin
  if CommandType = TDBXCommandTypes.DbxMetaData then
  begin
    List.Add(TDBXMetaDataCommands.GetDatabase);
    List.Add(TDBXMetaDataCommands.GetTables);
    List.Add(TDBXMetaDataCommands.GetColumns);
    List.Add(TDBXMetaDataCommands.GetIndexes);
    List.Add(TDBXMetaDataCommands.GetPackages);
    List.Add(TDBXMetaDataCommands.GetProcedures);
    List.Add(TDBXMetaDataCommands.GetProcedureParameters);
    List.Add(TDBXMetaDataCommands.GetUsers);
    List.Add(TDBXMetaDataCommands.GetDataTypes);
    List.Add(TDBXMetaDataCommands.GetCatalogs);
    List.Add(TDBXMetaDataCommands.GetSchemas);
    List.Add(TDBXMetaDataCommands.GetViews);
    List.Add(TDBXMetaDataCommands.GetSynonyms);
    List.Add(TDBXMetaDataCommands.GetForeignKeys);
    List.Add(TDBXMetaDataCommands.GetForeignKeyColumns);
    List.Add(TDBXMetaDataCommands.GetIndexColumns);
    List.Add(TDBXMetaDataCommands.GetPackageSources);
    List.Add(TDBXMetaDataCommands.GetProcedureSources);
    List.Add(TDBXMetaDataCommands.GetRoles);
    List.Add(TDBXMetaDataCommands.GetReservedWords);
  end;
  DerivedGetCommands(CommandType, List);
end;

function TDBXConnection.GetConnectionProperties: TDBXProperties;
begin
  Result := FConnectionProperties;
end;

function TDBXConnection.GetErrorEvent: TDBXErrorEvent;
begin
  Result := FDBXContext.OnError;
end;

function TDBXConnection.GetIsOpen: Boolean;
begin
  Result := FOpen;
end;

function TDBXConnection.GetProductVersion: string;
var
  ProductVersionProperty: string;
begin
  if not FProductVersionInitialized then
  begin
    ProductVersionProperty := FDriverDelegate.DriverProperties[TDBXPropertyNames.ProductVersion];
    if ProductVersionProperty <> '' then
      FProductVersion := ProductVersionProperty
    else
      FProductVersion := GetVendorProperty(TDBXPropertyNames.ProductVersion);
    FProductVersionInitialized := true;
  end;
  Result := FProductVersion;
end;

function TDBXConnection.GetProductName: string;
begin
  Result := FDriverDelegate.DriverProperties[TDBXPropertyNames.ProductName];
  if Result = '' then
  begin
    Result := GetVendorProperty(TDBXPropertyNames.ProductName);
    if Result = '' then
      Result := FConnectionProperties[TDBXPropertyNames.DriverName];
  end;
end;

function TDBXConnection.GetConnectionProperty(const Name: string): string;
begin
  Result := FConnectionProperties[Name];
end;

function TDBXConnection.GetVendorProperty(const Name: string): string;
begin
  Result := '';
end;

procedure TDBXConnection.SetErrorEvent(const ErrorEvent: TDBXErrorEvent);
begin
  FDBXContext.OnError := ErrorEvent;
end;

procedure TDBXConnection.SetConnectionProperties(const Value: TDBXProperties);
begin
  FConnectionProperties := Value;
end;

function TDBXConnection.GetDBXFormatter: TDBXFormatter;
begin
  Result := FDBXContext.DBXFormatter;
end;

procedure TDBXConnection.SetDBXFormatter(const DBXFormatter: TDBXFormatter);
begin
  FDBXContext.DBXFormatter := DBXFormatter;
end;

procedure TDBXConnection.SetTraceFlags(const TraceFlags: TDBXTraceFlag);
begin
  FDBXContext.TraceFlags := TraceFlags;
end;

procedure TDBXConnection.SetTraceInfoEvent(const TraceInfoEvent: TDBXTraceEvent);
begin
  FDBXContext.OnTrace := TraceInfoEvent;
end;

{ TDBXCommand }

function TDBXCommand.CreateParameter: TDBXParameter;
begin
  Result := TDBXParameter.Create(FDbxContext);
end;

function TDBXCommand.CreateParameterRow: TDBXRow;
begin
  NotImplemented;
  Result := nil;
end;

procedure TDBXCommand.CreateParameters(Command: TDBXCommand);
begin
  FParameters   := TDBXParameterList.Create(FDBXContext, Command);
end;

constructor TDBXCommand.Create(DBXContext: TDBXContext);
begin
  inherited Create;
  FCommandType := TDBXCommandTypes.DbxSQL;
  FDBXContext  := DBXContext;
end;

destructor TDBXCommand.Destroy;
begin
  Close;
  FFreeOnCloseList.Free;
  if FConnection <> nil then
    FConnection.RemoveCommand(Self);
  inherited;
end;

procedure TDBXCommand.SetCommandType(const CommandType: string);
begin
  if FCommandType <> CommandType then
  begin
    if FOpen then
      Close;
    FCommandType := CommandType;
  end;
end;

procedure TDBXCommand.SetParameters;
var
  HighParam:    Integer;
  Ordinal:      Integer;
begin
  DerivedClearParameters;
  HighParam := FParameters.Count -1;
  for Ordinal := 0 to HighParam do
    FParameters[Ordinal].SetParameter;
end;

function TDBXCommand.ExecuteQuery: TDBXReader;
begin
  if FText = '' then
    FDBXContext.Error(TDBXErrorCodes.InvalidOperation, SNoStatementToExecute);
  CommandExecuting;
  Result := DerivedExecuteQuery;
  if Result <> nil then
    Result.FCommand := Self;
  FLastReader := Result;
  CommandExecuted;
end;

procedure TDBXCommand.ExecuteUpdate;
begin
  if FText = '' then
    FDBXContext.Error(TDBXErrorCodes.InvalidOperation, SNoStatementToExecute);
  CommandExecuting;
  DerivedExecuteUpdate;
  CommandExecuted;
end;


procedure TDBXCommand.FreeOnExecute(Value: TObject);
begin
  if FFreeOnCloseList = nil then
    FFreeOnCloseList := TObjectList<TObject>.Create;
  FFreeOnCloseList.Add(Value);
end;

procedure TDBXCommand.FreeOnExecuteObjects;
begin
  if Assigned(FFreeOnCloseList) then
    FFreeOnCloseList.Clear;
end;

procedure TDBXCommand.CloseReader;
begin
  if FLastReader <> nil then
  begin
    FLastReader.FCommand := nil;
    FLastReader.CommandCloseReader;
    FLastReader := nil;
  end;
end;

procedure TDBXCommand.CommandExecuted;
begin
  if (FParameters <> nil) and (FParameters.FParameterRow <> nil) then
    inc(FParameters.FParameterRow.FGeneration);
end;

procedure TDBXCommand.CommandExecuting;
begin
  if Assigned(FFreeOnCloseList) then  
    FreeOnExecuteObjects;
  Open;
  CloseReader;
  if (FParameters <> nil) and (FParameters.Count > 0) then
  begin
    if not FPrepared then
      Prepare;
    SetParameters;
  end;
end;

procedure TDBXCommand.ConnectionClosing;
begin
  FConnection.RemoveCommand(Self);
  Close;
  FConnectionClosed := True;
end;

function TDBXCommand.GetCommandType: string;
begin
  Result := FCommandType;
end;

function TDBXCommand.GetErrorEvent: TDBXErrorEvent;
begin
  Result := FDBXContext.OnError;
end;

function TDBXCommand.GetNextReader: TDBXReader;
begin
  CloseReader;
  Result := DerivedGetNextReader;
  if Assigned(Result) then
    Result.FCommand := Self;
end;

function TDBXCommand.GetParameters: TDBXParameterList;
begin
  Open;
  if FParameters = nil then
    CreateParameters(Self);
  Result := FParameters;
end;

function TDBXCommand.GetText: string;
begin
  Result := FText;
end;

procedure TDBXCommand.Prepare;
begin
  Open;
  if FPrepared then
    FDBXContext.Error(TDBXErrorCodes.InvalidOperation, SAlreadyPrepared);

  DerivedPrepare;
  FPrepared := true;
end;

procedure TDBXCommand.SetText(const Value: string);
begin
  if FOpen and FPrepared and (FParameters <> nil) and (FParameters.Count > 0)
     and (FText <> Value) then
    Close;
  FPrepared := false;
  FText := Value;
end;

procedure TDBXCommand.NotImplemented;
var
  DBXError: TDBXError;
begin
  if FDBXContext = nil then
  begin
    DBXError := TDBXError.Create(TDBXErrorCodes.NotImplemented, sNotImplemented);
    raise DBXError;
  end
  else
    FDBXContext.Error(TDBXErrorCodes.NotImplemented, sNotImplemented)
end;

procedure TDBXCommand.Open;
begin
  if not FOpen then
  begin
    if FConnectionClosed then
      raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, SConnectionClosed);
    DerivedOpen;
    FOpen := true;
  end;
end;

procedure TDBXCommand.DerivedClearParameters;
begin

end;

procedure TDBXCommand.Close;
begin
  if Assigned(FFreeOnCloseList) then  
    FreeOnExecuteObjects;
  CloseReader;
  FreeAndNil(FParameters);
  if FOpen then
  begin
    DerivedClose;
    FOpen := false;
    FPrepared := false;
  end;
end;

{ TDBXMorphicCommand }

constructor TDBXMorphicCommand.Create(DBXContext: TDBXContext; Connection: TDBXConnection);
begin
  inherited Create(DBXContext);
  FConnection  := Connection;
  if Connection.ConnectionProperty[TDBXPropertyNames.RowSetSize] <> '' then
    FRowSetSize  := StrToInt(Connection.ConnectionProperty[TDBXPropertyNames.RowSetSize])
  else
    FRowSetSize := DBXDefaultRowSetSize;
  FMaxBlobSize := -1;
end;

procedure TDBXMorphicCommand.CreateParameters(Command: TDBXCommand);
begin
  FCommand.CreateParameters(Command);
end;

destructor TDBXMorphicCommand.Destroy;
begin
  inherited;
  FCommand.Free;
end;

function TDBXMorphicCommand.ExecuteQuery: TDBXReader;
begin
  Open;
  Result := FCommand.ExecuteQuery;
end;

procedure TDBXMorphicCommand.ExecuteUpdate;
begin
  Open;
  FCommand.ExecuteUpdate;
end;

function TDBXMorphicCommand.GetParameters: TDBXParameterList;
begin
  Open;
  Result := FCommand.GetParameters;
end;

function TDBXMorphicCommand.CreateParameterRow: TDBXRow;
begin
  Result := FCommand.CreateParameterRow;
end;

function TDBXMorphicCommand.GetRowsAffected: Int64;
begin
  Result := FCommand.RowsAffected;
end;

procedure TDBXMorphicCommand.FreeOnExecute(Value: TObject);
begin
  if FCommand.FFreeOnCloseList = nil then
    FCommand.FFreeOnCloseList := TObjectList<TObject>.Create;
  FCommand.FFreeOnCloseList.Add(Value);
end;

procedure TDBXMorphicCommand.Prepare;
begin
  Open;
  FCommand.Prepare;
end;

function TDBXMorphicCommand.GetNextReader: TDBXReader;
begin
  Result := FCommand.GetNextReader;
end;


procedure TDBXMorphicCommand.DerivedClose;
begin
  if FCommand <> nil then
    FCommand.Close;
end;

function TDBXMorphicCommand.DerivedExecuteQuery: TDBXReader;
begin
  Result := FCommand.DerivedExecuteQuery;
end;

procedure TDBXMorphicCommand.DerivedExecuteUpdate;
begin
  FCommand.DerivedExecuteUpdate;
end;

function TDBXMorphicCommand.DerivedGetNextReader: TDBXReader;
begin
  Result := FCommand.DerivedGetNextReader;
end;

procedure TDBXMorphicCommand.DerivedOpen;
begin
  if FCommand = nil then
  begin
    FCommand := FConnection.CreateMorphCommand(Self);
    CopyProperties(FCommand);
  end else
    FCommand.Open;
end;

procedure TDBXMorphicCommand.DerivedPrepare;
begin
  FCommand.DerivedPrepare;
end;

procedure TDBXMorphicCommand.SetMaxBlobSize(const MaxBlobSize: Int64);
begin
  FMaxBlobSize := MaxBlobSize;
  if FCommand <> nil then
    FCommand.MaxBlobSize  := MaxBlobSize;
end;

procedure TDBXMorphicCommand.SetRowSetSize(const Value: Int64);
begin
  FRowSetSize := Value;
  if FCommand <> nil then
    FCommand.RowSetSize := Value;
end;

procedure TDBXMorphicCommand.SetCommandType(const Value: string);
begin
  if Value <> GetCommandType then
  begin
    FreeAndNil(FCommand);
    inherited SetCommandType(Value);
  end;
end;

procedure TDBXMorphicCommand.SetText(const Value: string);
begin
  inherited SetText(Value);
  if FCommand <> nil then
    FCommand.Text := Value;
end;

procedure TDBXMorphicCommand.CopyProperties(Command: TDBXCommand);
begin
  Command.Text := Text;
  Command.CommandType := CommandType;
  if FMaxBlobSize > -1 then
    Command.MaxBlobSize := FMaxBlobSize;
  if FRowSetSize <> DBXDefaultRowSetSize then
    Command.RowSetSize := FRowSetSize;
  FCommand.Open;
end;

procedure TDBXMorphicCommand.CloseReader;
begin
  if FCommand <> nil then
    FCommand.CloseReader;
end;

{ TDBXReader }

destructor TDBXReader.Destroy;
begin
  Close;
  inherited;
end;

procedure TDBXReader.Close;
begin
  if FCommand <> nil then
  begin
    FCommand.CloseReader;
    FCommand := nil;
  end;
  CloseReader;
  FreeAndNil(FDbxRow);
  FValues := nil;
end;

procedure TDBXReader.CloseReader;
var
  Ordinal: TInt32;
begin
  if not FClosed then
  begin
    if (FDBXContext <> nil) and (FByteReader <> FDBXContext.ClosedByteReader) then
    begin
      FreeAndNil(FByteReader);
      FByteReader := FDBXContext.ClosedByteReader;
    end;
    if Length(FValues) > 0 then
    begin
      for Ordinal := 0 to High(FValues) do
        begin
          FValues[Ordinal].Free;
          FValues[Ordinal] := nil;
        end;
    end;
    FValueCount := ClosedReaderCount;
  end;
  FClosed := true;
end;

procedure TDBXReader.CommandCloseReader;
begin
  DerivedClose;
  CloseReader;
end;

constructor TDBXReader.Create(DBXContext: TDBXContext; DbxRow: TDBXRow; ByteReader: TDBXByteReader);
begin
  inherited Create(DBXContext);
  FDbxRow     := DbxRow;
  FByteReader := ByteReader;
  FValueCount := NewReaderCount
end;

constructor TDBXValueList.Create(DBXContext: TDBXContext);
begin
  inherited Create;
  FDBXContext := DBXContext;
end;

procedure TDBXValueList.ClearValues;
var
  Index: Integer;
begin
  for Index := 0 to High(FValues) do
  begin
    FValues[Index].Free;
  end;
  SetLength(FValues, 0);
end;

destructor TDBXValueList.Destroy;
begin
  ClearValues;
  inherited;
end;

procedure TDBXValueList.FailIfClosed;
begin
  if FClosed then
    FDBXContext.Error(TDBXErrorCodes.NoData, SReaderClosed);
end;

function TDBXReader.Next: Boolean;
begin
  if FValueCount < 0 then
  begin
    if FValueCount = NewReaderCount then
      FValueCount := Length(FValues)
    else
    begin
      Result := False;
      Exit;
    end;
  end;
  if DerivedNext then
    begin
      inc(FDbxRow.FGeneration);
      Result := True;
    end
  else
    begin
      // Unidirectional so free up underlying resources.
      //
      if Assigned(FCommand) then
        FCommand.CloseReader;
      Result := False;
    end;
end;



function TDBXReader.Reset: Boolean;
begin
  Result := false;
end;

{ TDBXTransaction }

constructor TDBXTransaction.Create;
begin
  inherited Create;
end;

{ TDBXParameters }

procedure TDBXParameterList.AddParameter(Parameter: TDBXParameter);
begin
  if FParameterRow = nil then
    FParameterRow := FCommand.CreateParameterRow;
  Parameter.SetDbxRow(FParameterRow);
  FValueTypes.Add(Parameter);
end;

procedure TDBXParameterList.SetParameter(const Ordinal: Integer;
  const Parameter: TDBXParameter);
begin
  if (FParameterRow = nil) and (FCommand <> nil) then
    FParameterRow := FCommand.CreateParameterRow;
  Parameter.SetDbxRow(FParameterRow);
  FValueTypes.SetValueType(Ordinal, Parameter);
end;


procedure TDBXParameterList.SetPendingOutParameter(const Ordinal: Integer);
begin
  Parameter[Ordinal].SetParameter;
end;

procedure TDBXParameterList.SetCount(const Count: TInt32);
begin
  FValueTypes.SetCount(Count);
end;


procedure TDBXParameterList.ClearParameters;
begin
  if Assigned(FValueTypes) then
    FValueTypes.Clear;
end;

constructor TDBXParameterList.Create(DBXContext: TDBXContext; DBXRow: TDBXRow);
begin
  inherited Create;
  FDBXContext       := DBXContext;
  FParameterRow     := DBXRow;
  FValueTypes       := TDBXValueTypeList.Create;
end;

constructor TDBXParameterList.Create(DBXContext: TDBXContext; Command: TDBXCommand);
begin
  inherited Create;
  FDBXContext       := DBXContext;
  FCommand          := Command;
  FValueTypes           := TDBXValueTypeList.Create;
end;

destructor TDBXParameterList.Destroy;
begin
  FParameterRow.Free;
  FValueTypes.Free;
  inherited;
end;

{ TDBXValue }

constructor TDBXValue.Create(ValueType: TDBXValueType);
begin
  inherited Create;
  FValueType  := ValueType;
  FGeneration := -1;
  FIsNull     := true;
end;

class procedure TDBXValue.UnsupportedFieldType(DBXContext: TDBXContext;
  ValueType: TDBXValueType);
var
  LMessage: string;
begin
  LMessage := Format(SUnexpectedDataType, [IntToStr(ValueType.DataType)]);

  if DBXContext <> nil then
    DBXContext.Error(TDBXErrorCodes.UnsupportedFieldType, LMessage)
  else
    raise TDBXError.Create(TDBXErrorCodes.UnsupportedFieldType, LMessage);
end;

class function TDBXValue.CreateValue(ValueType: TDBXValueType): TDBXWritableValue;
begin
   Result := CreateValue(nil, ValueType, nil, false);
end;

class function TDBXValue.CreateValue(DBXContext: TDBXContext;
  ValueType: TDBXValueType; DbxRow: TDBXRow; ReadOnlyType: Boolean): TDBXWritableValue;
begin
    if ReadOnlyType then
      ValueType.SetReadOnlyType;

    Result := nil;
    // Because parameters can be created and their values set before they are
    // associated with a command, we may not be able to create a custom value object
    // object at first.  When the command is eventually associated with
    // the command, any custom value object will be created if needed.
    //
    if DbxRow <> nil then
    begin
      Result := TDBXWritableValue(DbxRow.CreateCustomValue(ValueType));
    end;

    if Result = nil then
    begin
      case ValueType.DataType of
        TDBXDataTypes.JsonValueType:
            Result := TDBXJSONValue.Create(ValueType);
        TDBXDataTypes.AnsiStringType:
            Result := TDBXAnsiStringBuilderValue.Create(ValueType);
        TDBXDataTypes.WideStringType:
            Result := TDBXWideStringBuilderValue.Create(ValueType);
        TDBXDataTypes.DateType:
            Result := TDBXDateValue.Create(ValueType);
        TDBXDataTypes.BooleanType:
            Result := TDBXBooleanValue.Create(ValueType);
        TDBXDataTypes.TimeType:
            Result := TDBXTimeValue.Create(ValueType);
        TDBXDataTypes.Int8Type:
            Result := TDBXInt8Value.Create(ValueType);
        TDBXDataTypes.UInt8Type:
            Result := TDBXUInt8Value.Create(ValueType);
        TDBXDataTypes.Int16Type:
            Result := TDBXInt16Value.Create(ValueType);
        TDBXDataTypes.UInt16Type:
            Result := TDBXUInt16Value.Create(ValueType);
        TDBXDataTypes.Int32Type:
            Result := TDBXInt32Value.Create(ValueType);
        TDBXDataTypes.Int64Type:
            Result := TDBXInt64Value.Create(ValueType);
        TDBXDataTypes.DoubleType:
            Result := TDBXDoubleValue.Create(ValueType);
        TDBXDataTypes.SingleType:
            Result := TDBXSingleValue.Create(ValueType);
        TDBXDataTypes.BcdType,
        TDBXDataTypes.CurrencyType:
            Result := TDBXBcdValue.Create(ValueType);
        TDBXDataTypes.VarBytesType,
        TDBXDataTypes.BytesType,
        TDBXDataTypes.AdtType,
        TDBXDataTypes.ArrayType,
        TDBXDataTypes.BlobType:
            case ValueType.SubType of
              TDBXDataTypes.HMemoSubType,
              TDBXDataTypes.MemoSubType:
                Result := TDBXAnsiMemoValue.Create(ValueType);
              TDBXDataTypes.WideMemoSubType:
                Result := TDBXWideMemoValue.Create(ValueType);
              else
                Result := TDBXStreamValue.Create(ValueType);
            end;
        TDBXDataTypes.VariantType:
          Result := TDBXStreamValue.Create(ValueType);
        TDBXDataTypes.BinaryBlobType:
          Result := TDBXStreamValue.Create(ValueType);
        TDBXDataTypes.CursorType:
            Result := TDBXCursorValue.Create(ValueType);
        TDBXDataTypes.TimeStampType:
            Result := TDBXTimeStampValue.Create(ValueType);
        TDBXDataTypes.DateTimeType:
            Result := TDBXTimeStampValue.Create(ValueType);
        TDBXDataTypes.TableType:
            Result := TDBXReaderValue.Create(ValueType);
        TDBXDataTypes.DBXConnectionType:
            Result := TDBXConnectionValue.Create(ValueType);
        TDBXDataTypes.TimeStampOffsetType:
            Result := TDBXTimeStampOffsetValue.Create(ValueType);
        TDBXDataTypes.CallbackType:
            Result := TDBXCallbackValue.Create(ValueType);
        else
        begin
          Result := nil;
          UnsupportedFieldType(DBXContext, ValueType);
        end;
      end;
    end;
    ValueType.FDbxRow := DbxRow;
    Result.FDbxRow    := DbxRow;

end;

destructor TDBXValue.Destroy;
begin
  FValueType.Free;
  inherited;
end;


function TDBXValue.EqualsValue(Other: TDBXValue): Boolean;
begin
  Result := Compare(Other) = 0;
end;

procedure TDBXValue.InvalidOperation;
begin
  // Should never get here.
  //
  ValueType.DBXContext.Error(TDBXErrorCodes.NotImplemented, sNotImplemented);
end;

constructor TDBXWritableValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
end;


destructor TDBXWritableValue.Destroy;
begin
  inherited;
end;

procedure TDBXWritableValue.SetBcd(const Value: TBcd);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BcdType);
end;

procedure TDBXWritableValue.SetSingle(const Value: Single);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.SingleType);
end;

procedure TDBXWritableValue.SetStaticBytes(Offset: Int64; const Buffer: array of Byte;
  BufferOffset, Length: Int64);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BytesType);
end;

procedure TDBXWritableValue.SetStream(const Stream: TStream; const AInstanceOwner: Boolean);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BytesType);
end;

procedure TDBXWritableValue.SetDynamicBytes(Offset: Int64; const Buffer: TArray<Byte>; BufferOffset,
  Length: Int64);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BytesType);
end;

procedure TDBXWritableValue.SetBoolean(const Value: Boolean);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BooleanType);
end;

procedure TDBXWritableValue.SetDate(const Value: TDBXDate);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.DateType);
end;

procedure TDBXWritableValue.SetDBXConnection(const Value: TDBXConnection);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.DBXConnectionType);
end;

procedure TDBXWritableValue.SetJSONValue(const Value: TJSONValue; const AInstanceOwner: Boolean);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.JsonValueType);
end;

procedure TDBXWritableValue.SetCallbackValue(const Value: TDBXCallback);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.CallbackType);
end;

procedure TDBXWritableValue.SetObjectValue(const Value: TObject; const AInstanceOwner: Boolean);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.JsonValueType);
end;

procedure TDBXWritableValue.SetDBXReader(const Value: TDBXReader; const AInstanceOwner: Boolean);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.TableType);
end;

//procedure TDBXWritableValue.SetDbxRow(DbxRow: TDBXRow);
//begin
//    FDbxRow := DbxRow;
//end;

procedure TDBXWritableValue.SetDouble(const Value: Double);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.DoubleType);
end;

procedure TDBXWritableValue.SetInt16(const Value: SmallInt);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.Int16Type);
end;

procedure TDBXWritableValue.SetInt32(const Value: TInt32);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.Int32Type);
end;

procedure TDBXWritableValue.SetInt64(const Value: Int64);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.Int64Type);
end;


procedure TDBXWritableValue.SetInt8(const Value: ShortInt);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.Int8Type);
end;

procedure TDBXWritableValue.SetNull;
begin
  FIsNull := true;
  FSetPending := true;

  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXWritableValue.SetPendingValue;
begin
  if FSetPending then
  begin
    if FIsNull then
      FDbxRow.SetNull(Self)
    else
      SetRowValue;
  end else
    FDbxRow.ValueNotSet(Self);
end;

function TDBXValue.Compare(Other: TDBXValue): Smallint;
begin
  InvalidOperation;
  Result := 0;
end;

procedure TDBXValue.CopyRowValue(Row: TDBXRow);
begin
  InvalidOperation;
end;

procedure TDBXWritableValue.SetRowValue;
begin
  InvalidOperation;
end;

{$IFNDEF NEXTGEN}
procedure TDBXWritableValue.SetAnsiString(const Value: AnsiString);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.AnsiStringType);
end;
{$ENDIF !NEXTGEN}

procedure TDBXWritableValue.SetAsBcd(const Value: TBcd);
begin
  SetBcd(Value);
end;

procedure TDBXWritableValue.SetAsBoolean(const Value: Boolean);
begin
  SetBoolean(Value);
end;

procedure TDBXWritableValue.SetAsCurrency(const Value: Currency);
begin
  SetAsCurrencyValue(Value, 32, 4);
end;

procedure TDBXWritableValue.SetAsCurrencyValue(const Value: Currency; Precision: Integer; Decimals: Integer);
var
  BcdValue: TBcd;
begin
  CurrToBCD(Value, BcdValue, Precision, Decimals);
  SetAsBcd(BcdValue);
end;

procedure TDBXWritableValue.SetAsDate(const Value: TDBXDate);
begin
  SetDate(Value);
end;

procedure TDBXWritableValue.SetAsDateTime(const Value: TDateTime);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.TimeStampType);
end;

procedure TDBXWritableValue.SetAsDBXReader(const Value: TDBXReader);
begin
  SetDBXReader(Value, True);
end;

procedure TDBXWritableValue.SetAsDouble(const Value: Double);
begin
  SetDouble(Value);
end;

procedure TDBXWritableValue.SetAsInt16(const Value: SmallInt);
begin
  SetInt16(Value);
end;

procedure TDBXWritableValue.SetAsInt32(const Value: TInt32);
begin
  SetInt32(Value);
end;

procedure TDBXWritableValue.SetAsInt64(const Value: Int64);
begin
  SetInt64(Value);
end;

procedure TDBXWritableValue.SetAsInt8(const Value: ShortInt);
begin
  SetInt8(Value);
end;

procedure TDBXWritableValue.SetAsSingle(const Value: Single);
begin
  SetSingle(Value);
end;

procedure TDBXWritableValue.SetAsStream(const Value: TStream);
begin
  SetStream(Value, True);
end;

procedure TDBXWritableValue.SetAsString(const Value: string);
begin
  SetString(Value);
end;

procedure TDBXWritableValue.SetAsTime(const Value: TDBXTime);
begin
  SetTime(Value);
end;

procedure TDBXWritableValue.SetAsTimestamp(const Value: TSQLTimeStamp);
begin
  SetTimeStamp(Value);
end;

procedure TDBXWritableValue.SetAsTimestampOffset(const Value: TSQLTimeStampOffset);
begin
  SetTimeStampOffset(Value);
end;

procedure TDBXWritableValue.SetAsUInt16(const Value: Word);
begin
  SetUInt16(Value);
end;

procedure TDBXWritableValue.SetAsUInt8(const Value: Byte);
begin
  SetUInt8(Value);
end;

procedure TDBXWritableValue.SetAsVariant(const Value: OleVariant);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BytesType);
end;

function TDBXWritableValue.GetStreamReader: TDBXStreamReader;
begin
  Result := nil;
end;

procedure TDBXWritableValue.MarkAsPending;
begin
  if not FSetPending then
    FSetPending := true;
end;

procedure TDBXWritableValue.SetTime(const Value: TDBXTime);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.TimeType);
end;

procedure TDBXWritableValue.SetTimeStamp(const Value: TSQLTimeStamp);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.TimeStampType);
end;

procedure TDBXWritableValue.SetTimeStampOffset(const Value: TSQLTimeStampOffset);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.TimeStampOffsetType);
end;

procedure TDBXWritableValue.SetUInt16(const Value: Word);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.UInt16Type);
end;

procedure TDBXWritableValue.SetUInt8(const Value: Byte);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.UInt8Type);
end;

procedure TDBXWritableValue.SetValue(const Value: TDBXValue);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.UnknownType);
end;

procedure TDBXWritableValue.SetWideString(const Value: string);
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.WideStringType);
end;

procedure TDBXWritableValue.SetString(const Value: string);
begin
  // Temp.
  SetWideString(Value);
//  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.WideStringType);
end;

function TDBXValue.GetBcd: TBcd;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BcdType);
  Result := NullBcd;
end;

function TDBXValue.GetBoolean(defaultValue: Boolean): Boolean;
begin
  if IsNull then
    Result := defaultValue
  else
    Result := GetBoolean;
end;

function TDBXValue.GetBoolean: Boolean;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BooleanType);
  Result := false;
end;

function TDBXValue.GetBytes(Offset: Int64; const Buffer: TArray<Byte>;
  BufferOffset, Length: Int64): Int64;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BytesType);
  Result := 0;
end;

function TDBXValue.GetDate: TDBXDate;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.DateType);
  Result := 0;
end;

function TDBXValue.GetDBXConnection: TDBXConnection;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.DBXConnectionType);
  Result := nil;
end;

function TDBXValue.GetDbxContext: TDBXContext;
begin
  Result := FValueType.DBXContext;
end;

function TDBXValue.GetDBXReader: TDBXReader;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.TableType);
  Result := nil;
end;

function TDBXValue.GetDBXReader(AInstanceOwner: Boolean): TDBXReader;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.TableType);
  Result := nil;
end;

function TDBXValue.GetDouble: Double;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.DoubleType);
  Result := 0;
end;

function TDBXValue.GetInt16: SmallInt;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.Int16Type);
  Result := 0;
end;

function TDBXValue.GetInt32: TInt32;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.Int32Type);
  Result := 0;
end;

function TDBXValue.GetInt64: Int64;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.Int64Type);
  Result := 0;
end;

{$IFNDEF NEXTGEN}
function TDBXValue.GetAnsiString: AnsiString;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.AnsiStringType);
  Result := '';
end;
{$ENDIF !NEXTGEN}

function TDBXValue.GetAsBcd: TBcd;
begin
  Result := GetBcd;
end;

function TDBXValue.GetAsBoolean: Boolean;
begin
  Result := GetBoolean;
end;

function TDBXValue.GetAsCurrency: Currency;
var
  BcdValue: TBcd;
begin
  BcdValue := GetBcd;
  Result := 0;
  BcdToCurr(BcdValue, Result);
end;

function TDBXValue.GetAsDate: TDBXDate;
begin
  Result := GetDate;
end;


function TDBXValue.GetAsDateTime: TDateTime;
begin
  InvalidOperation;
  Result := 0;
end;

function TDBXValue.GetAsDBXReader: TDBXReader;
begin
  Result := GetDBXReader(True);
end;

function TDBXValue.GetAsDouble: Double;
begin
  Result := GetDouble;
end;

function TDBXValue.GetAsInt16: SmallInt;
begin
  Result := GetInt16;
end;

function TDBXValue.GetAsInt32: TInt32;
begin
  Result := GetInt32;
end;

function TDBXValue.GetAsInt64: Int64;
begin
  Result := GetInt64;
end;

function TDBXValue.GetAsInt8: ShortInt;
begin
  Result := GetInt8;
end;

function TDBXValue.GetAsVariant: OleVariant;
var
  Stream: TStream;
begin
  if IsNull then
    Result := Null
  else
  begin
    Stream := GetStream(False);
    try
      Data.DSUtil.StreamToVariant(Stream, Result);
    finally
      Stream.Free;
    end;
  end;
end;

function TDBXValue.GetAsSingle: Single;
begin
  Result := GetSingle;
end;

function TDBXValue.GetAsStream: TStream;
begin
  Result := GetStream(True);
end;

function TDBXValue.GetAsString: string;
begin
  Result := GetWideString;
end;


function TDBXValue.GetAsTime: TDBXTime;
begin
  Result := GetTime;
end;

function TDBXValue.GetAsTimeStamp: TSQLTimeStamp;
begin
  Result := GetTimeStamp;
end;

function TDBXValue.GetAsTimeStampOffset: TSQLTimeStampOffset;
begin
  Result := GetTimeStampOffset;
end;

function TDBXValue.GetAsUInt16: Word;
begin
  Result := GetUInt16;
end;

function TDBXValue.GetAsUInt8: Byte;
begin
  Result := GetUInt8;
end;

function TDBXValue.GetTimeStamp: TSQLTimeStamp;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.TimeStampType);
  Result := NullSQLTimeStamp;
end;

function TDBXValue.GetTimeStampOffset: TSQLTimeStampOffset;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.TimeStampOffsetType);
  Result := NullSQLTimeStampOffset;
end;

function TDBXValue.GetUInt8: Byte;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.UInt8Type);
  Result := 0;
end;

function TDBXValue.GetValueSize: Int64;
begin
  Result := ValueType.Size;
end;

function TDBXValue.GetWideString(defaultValue: string): string;
begin
  if IsNull then
    Result := defaultValue
  else
    Result := getWideString;
end;

function TDBXValue.GetTime: TDBXTime;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.TimeType);
  Result := 0;
end;

function TDBXValue.GetWideString: string;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.WideStringType);
  Result := '';
end;

function TDBXValue.GetString: string;
begin
// Temp.
  Result := GetWideString;
//  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.WideStringType);
//  Result := '';
end;

procedure TDBXWritableValue.UpdateType;
begin
end;


function TDBXReader.GetByteReader: TDBXByteReader;
begin
  Result := FByteReader;
end;

function TDBXValueList.GetColumnCount: TInt32;
begin
  Result := Length(FValues);
end;

function TDBXReader.GetErrorEvent: TDBXErrorEvent;
begin
  Result := FDBXContext.OnError;
end;


function TDBXReader.GetReaderHandle: Integer;
begin
  Result := -1;
end;

function TDBXReader.GetRow: TDBXRow;
begin
  Result := FDbxRow;
end;

function TDBXReader.GetRowHandle: Integer;
begin
  Result := 0;
end;

// place this in a separate method to avoid the hit
// of string finalization in frequently called method(s).
//
procedure TDBXValueList.InvalidName(const Name: string; const Ordinal: TInt32);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOrdinal, Format(SInvalidOrdinal, [Ordinal]));
end;

procedure TDBXValueList.InvalidOrdinal(const Ordinal: TInt32);
begin
  if FValueCount = ClosedReaderCount then
    FDBXContext.Error(TDBXErrorCodes.NoData, SReaderClosed);

  if FValueCount = NewReaderCount then
    FDBXContext.Error(TDBXErrorCodes.NoData, SReaderNew);

  raise TDBXError.Create(TDBXErrorCodes.InvalidOrdinal,
                             Format(SInvalidOrdinal, [Ordinal]));
end;

function TDBXValueList.GetValue(const Ordinal: TInt32): TDBXValue;
begin
  if (Ordinal < 0) or (Ordinal >= FValueCount) then
    InvalidOrdinal(Ordinal);
  Result := FValues[Ordinal];
end;

function TDBXValueList.GetValueByName(const Name: string): TDBXValue;
begin
  Result := FValues[GetOrdinal(Name)];
end;

function TDBXValueList.GetValueType(const Ordinal: TInt32): TDBXValueType;
begin
  FailIfClosed;
  if (Ordinal < 0) or (Ordinal >= Length(FValues)) then
    InvalidOrdinal(Ordinal);
  Result := FValues[Ordinal].FValueType;
end;

function TDBXReader.GetObjectTypeName(Ordinal: TInt32): string;
begin
  Result := FDbxRow.GetObjectTypeName(Ordinal);
end;

function TDBXReader.IsUpdateable: Boolean;
begin
  Result := False;
end;

function TDBXValueList.GetOrdinal(const Name: string): TInt32;
begin
  // Simple optimization that always starts scanning from the Ordinal
  // position of the last found name.
  //
  Result := FindOrdinal(Name, FLastOrdinal, Length(FValues));
  if (Result < 0) then
  begin
    if (FLastordinal > 0) then
      Result := FindOrdinal(Name, 0, FLastOrdinal);
    if (Result < 0) then
      InvalidName(Name, Result);
  end;
end;

function TDBXValueList.FindOrdinal(const Name: string; const StartOrdinal,
  EndOrdinal: TInt32): TInt32;
var
  Ordinal:      Integer;
begin
  for Ordinal := StartOrdinal to EndOrdinal - 1 do
  begin
    if Assigned(FValues[Ordinal]) and (string.Compare(FValues[Ordinal].ValueType.Name, Name, True) = 0) then
    begin
      FLastOrdinal := Ordinal;
      Result := Ordinal;
      Exit;
    end;
  end;
  Result := -1;
end;

function TDBXValueTypeList.FindOrdinal(const Name: string; StartOrdinal,
  EndOrdinal: TInt32): TInt32;
var
  Ordinal:      Integer;
  CurrentName:  string;
begin
  for Ordinal := StartOrdinal to EndOrdinal - 1 do
  begin
    CurrentName := Values[Ordinal].Name;
    if string.Compare(CurrentName, Name, True) = 0 then
    begin
      FLastOrdinal := Ordinal;
      Result := Ordinal;
      Exit;
    end;
  end;
  Result := -1;
end;

procedure TDBXValueTypeList.Add(ValueType: TDBXValueType);
var
  Count: TInt32;
begin
  Count := Length(FValueTypeArray);
  ValueType.Ordinal := Count;
  SetLength(FValueTypeArray, Count+1);
  FValueTypeArray[Count] := ValueType;
end;

procedure TDBXValueTypeList.Clear;
var
  Index: Integer;
begin
  for Index := Low(FValueTypeArray) to High(FValueTypeArray) do
  begin
    FValueTypeArray[Index].Free;
  end;
  SetLength(FValueTypeArray, 0);
end;

destructor TDBXValueTypeList.Destroy;
begin
  Clear;
  FValueTypeArray := nil;
  inherited;
end;

function TDBXValueTypeList.GetCount: TInt32;
begin
  Result := Length(FValueTypeArray);
end;

function TDBXValueTypeList.GetOrdinal(const Name: string): TInt32;
begin
  // Simple optimization that always starts scanning from the Ordinal
  // position of the last found name.
  //
  Result := FindOrdinal(Name, FLastOrdinal, Count);
  if (Result < 0) and (FLastordinal > 0) then
    Result := FindOrdinal(Name, 0, FLastOrdinal);
end;

function TDBXValueTypeList.GetValueType(const Ordinal: TInt32): TDBXValueType;
begin
  Result := FValueTypeArray[Ordinal];
end;

procedure TDBXValueTypeList.Insert(Ordinal: TInt32; ValueType: TDBXValueType);
var
  Count, DestOrdinal, SourceOrdinal: Integer;
begin
  Count := Length(FValueTypeArray);
  if (Ordinal < 0) or (Ordinal > Count) then
    raise ERangeError.Create('');

  SetLength(FValueTypeArray, Count+1);
  if Count > 0 then
  begin
    DestOrdinal   := Count;
    SourceOrdinal := DestOrdinal -1;
    while DestOrdinal > Ordinal do
    begin
      FValueTypeArray[DestOrdinal] := FValueTypeArray[SourceOrdinal];
      Dec(DestOrdinal);
      Dec(SourceOrdinal);
    end;
  end;
  FValueTypeArray[Ordinal] := ValueType;
end;

procedure TDBXValueTypeList.Remove(ValueType: TDBXValueType);
begin
  Assert(ValueType = FValueTypeArray[ValueType.Ordinal]);
  Remove(ValueType.Ordinal);
end;

procedure TDBXValueTypeList.Remove(Ordinal: TInt32);
var
  Count, DestOrdinal, SourceOrdinal: Integer;
begin
  DestOrdinal   := Ordinal;
  SourceOrdinal := Ordinal+1;
  Count         := Length(FValueTypeArray);
  if (Ordinal < 0) or (Ordinal >= Count) then
    raise ERangeError.Create('');
  while SourceOrdinal < Count do
  begin
    FValueTypeArray[DestOrdinal] := FValueTypeArray[SourceOrdinal];
    Inc(DestOrdinal);
    Inc(SourceOrdinal);
  end;
  SetLength(FValueTypeArray, Count-1);
end;

procedure TDBXValueTypeList.RemoveAll;
begin
  SetLength(FValueTypeArray, 0);
end;

procedure TDBXValueTypeList.SetCount(const Count: TInt32);
var
  Ordinal: Integer;
begin
  if FValueTypeArray <> nil then
  begin
    for Ordinal := Count to High(FValueTypeArray) do
      FValueTypeArray[Ordinal].Free;
  end;
  SetLength(FValueTypeArray, Count);
end;

procedure TDBXValueTypeList.SetValueType(const Ordinal: TInt32; ValueType: TDBXValueType);
begin
  ValueType.Ordinal := Ordinal;
  FValueTypeArray[Ordinal] := ValueType;
end;



function TDBXValue.GetInt16(defaultValue: Smallint): Smallint;
begin
  if IsNull then
    Result := defaultValue
  else
    Result := GetInt16;
end;

function TDBXValue.GetInt32(defaultValue: TInt32): TInt32;
begin
  if IsNull then
    Result := defaultValue
  else
    Result := GetInt32;
end;

function TDBXValue.GetInt64(defaultValue: Int64): Int64;
begin
  if IsNull then
    Result := defaultValue
  else
    Result := GetInt64;
end;

function TDBXValue.GetInt8(defaultValue: Shortint): Shortint;
begin
  if IsNull then
    Result := defaultValue
  else
    Result := GetInt8;
end;

function TDBXValue.GetUInt16: Word;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.UInt16Type);
  Result := 0;
end;

function TDBXValue.GetUInt16(defaultValue: Word): Word;
begin
  if IsNull then
    Result := defaultValue
  else
    Result := GetUInt16;
end;

function TDBXValue.GetUInt8(defaultValue: Byte): Byte;
begin
  if IsNull then
    Result := defaultValue
  else
    Result := GetUInt8;
end;

function TDBXValue.GetInt8: ShortInt;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.Int8Type);
  Result := 0;
end;

function TDBXValue.GetNonDelegate: TDBXValue;
begin
  Result := self;
end;

function TDBXValue.GetSingle: Single;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.SingleType);
  Result := 0;
end;

function TDBXValue.GetStream(AInstanceOwner: Boolean): TStream;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BytesType);
  Result := nil;
end;

function TDBXValue.GetJSONValue: TJSONValue;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.JsonValueType);
  Result := nil;
end;

function TDBXValue.GetJSONValue(AInstanceOwner: Boolean): TJSONValue;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.JsonValueType);
  Result := nil;
end;

function TDBXValue.GetCallbackValue: TDBXCallback;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.CallbackType);
  Result := nil;
end;

function TDBXValue.GetObjectValue: TObject;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.JsonValueType);
  Result := nil;
end;

function TDBXValue.GetObjectValue(AInstanceOwner: Boolean): TObject;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.JsonValueType);
  Result := nil;
end;

function TDBXValue.GetStream: TStream;
begin
  TDBXValueType.InvalidTypeAccess(ValueType.DataType, TDBXDataTypes.BytesType);
  Result := nil;
end;

{ TDBXDatabaseMetaData }

constructor TDBXDatabaseMetaData.Create(DBXContext: TDBXContext);
begin
  inherited Create;
  FDBXContext := DBXContext;
end;

procedure TDBXDatabaseMetaData.Init(Connection: TDBXConnection);
var
  Reader:   TDBXReader;
  Command:  TDBXCommand;
begin
  inherited Create;
  Reader    := nil;
  Command   := nil;
  try
    Command             := Connection.DerivedCreateCommand;
    Command.CommandType := TDBXCommandTypes.DbxMetaData;
    Command.Text        := TDBXMetaDataCommands.GetDatabase;
    Reader              := Command.ExecuteQuery;

    Reader.Next;

    FQuoteChar                  := Reader[TDBXMetaDatabaseColumnNames.QuoteChar].GetWideString;
    FProcedureQuoteChar         := Reader[TDBXMetaDatabaseColumnNames.ProcedureQuoteChar].GetWideString;
    FMaxCommands                := Reader[TDBXMetaDatabaseColumnNames.MaxCommands].GetInt32;
    FSupportsTransactions       := Reader[TDBXMetaDatabaseColumnNames.SupportsTransactions].GetBoolean;
    FSupportsNestedTransactions := Reader[TDBXMetaDatabaseColumnNames.SupportsNestedTransactions].GetBoolean;
    FSupportsRowSetSize         := Reader[TDBXMetaDatabaseColumnNames.SupportsRowSetSize].GetBoolean;

    // MetaData from a MetaDataProvider has more information:
    if Reader.ColumnCount >= 10 then
    begin
      FMetaDataVersion              := DBXVersion40;
      FQuotePrefix                  := Reader[TDBXMetaDatabaseColumnNames.QuotePrefix].GetWideString;
      FQuoteSuffix                  := Reader[TDBXMetaDatabaseColumnNames.QuoteSuffix].GetWideString;
      FSupportsLowerCaseIdentifiers := Reader[TDBXMetaDatabaseColumnNames.SupportsLowerCaseIdentifiers].GetBoolean;
      FSupportsUpperCaseIdentifiers := Reader[TDBXMetaDatabaseColumnNames.SupportsUpperCaseIdentifiers].GetBoolean;
      FSupportsSPReturnCode         := Reader[TDBXMetaDatabaseColumnNames.SupportsSPReturnCode].GetBoolean;
      if Reader.FindOrdinal(TDBXMetaDatabaseColumnNames.SupportsParameterMetadata, 0, Length(Reader.Values)) <> -1 then
        FSupportsParameterMetadata    := Reader[TDBXMetaDatabaseColumnNames.SupportsParameterMetadata].GetBoolean;
      if Reader.FindOrdinal(TDBXMetaDatabaseColumnNames.SupportsCatalogFunctions, 0, Length(Reader.Values)) <> -1 then
        FSupportsCatalogFunctions     := Reader[TDBXMetaDatabaseColumnNames.SupportsCatalogFunctions].GetBoolean;
      if Reader.FindOrdinal(TDBXMetaDatabaseColumnNames.SupportsCatalogs, 0, Length(Reader.Values)) <> -1 then
        FSupportsCatalogs     := Reader[TDBXMetaDatabaseColumnNames.SupportsCatalogs].GetBoolean;
      if Reader.FindOrdinal(TDBXMetaDatabaseColumnNames.SupportsSchemas, 0, Length(Reader.Values)) <> -1 then
        FSupportsSchemas     := Reader[TDBXMetaDatabaseColumnNames.SupportsSchemas].GetBoolean;
    end
    else if Self is TDBXDataBaseMetadata then
      FMetaDataVersion              := DBXVersion30;
  finally
    Reader.Free;
    Command.Free;
  end;
end;


{ TDBXParameter }


constructor TDBXParameter.Create(DbxContext: TDBXContext);
begin
  inherited Create(DbxContext);
  ParameterDirection := TDBXParameterDirections.InParameter;
  FModified   := true;
end;
constructor TDBXParameter.Create(DbxContext: TDBXContext; Row: TDBXRow; Source: TDBXParameter);
begin
  inherited Create(DbxContext);
  FDbxRow := Row;
  AssignType(Source);
end;

constructor TDBXParameter.Create(DbxContext: TDBXContext; Row: TDBXRow);
begin
  inherited Create(DbxContext);
  FDbxRow := Row;
end;

destructor TDBXParameter.Destroy;
begin
  if FValue <> nil then
  begin
    Assert(FValue.FValueType = Self);
    FValue.FValueType := nil;
    // FValue can be present several times in the parameter list
    FValue.Free;
  end;
  inherited;
end;

function TDBXParameter.GetValue: TDBXWritableValue;
begin
  if FModified then
    UpdateParameterType(DataType);
  Result := FValue;
end;

procedure TDBXParameter.SetParameter;
begin
  if FModified then
  begin
    UpdateParameterType(DataType);
  end;
  Value.SetPendingValue;
end;

procedure TDBXParameter.CopyByteValue(Source: TDBXValue; Dest: TDBXWritableValue);
var
  Buf: TArray<Byte>;
  Count: Integer;
begin
  Count := Integer(Source.GetValueSize);
  SetLength(Buf, Count);
  Source.GetBytes(0, Buf, 0, Count);
  Dest.SetDynamicBytes(0, Buf, 0, Count);
end;

procedure TDBXParameter.AssignValue(Source: TDBXValue);
begin
  if Assigned(Source) then
  begin
    if Source.IsNull then
      FValue.SetNull
    else
    begin
      // This should be more virtual, but I am not allowed to make interface
      // breaking changes in this release.
      //
      case DataType of
        TDBXDataTypes.AnsiStringType:
{$IFNDEF NEXTGEN}
            FValue.SetAnsiString(Source.GetAnsiString);
{$ELSE}
            FValue.SetString(Source.GetString);
{$ENDIF !NEXTGEN}
        TDBXDataTypes.DateType:
            FValue.SetDate(Source.GetDate);
        TDBXDataTypes.BooleanType:
            FValue.SetBoolean(Source.GetBoolean);
        TDBXDataTypes.TimeType:
            FValue.SetTime(Source.GetTime);
        TDBXDataTypes.WideStringType:
            FValue.SetWideString(Source.GetWideString);
        TDBXDataTypes.Int8Type:
            FValue.SetInt8(Source.GetInt8);
        TDBXDataTypes.UInt8Type:
            FValue.SetUInt8(Source.GetUInt8);
        TDBXDataTypes.Int16Type:
            FValue.SetInt16(Source.GetInt16);
        TDBXDataTypes.UInt16Type:
            FValue.SetUInt16(Source.GetUInt16);
        TDBXDataTypes.Int32Type:
            FValue.SetInt32(Source.GetInt32);
        TDBXDataTypes.Int64Type:
            FValue.SetInt64(Source.GetInt64);
        TDBXDataTypes.SingleType:
            FValue.SetSingle(Source.GetSingle);
        TDBXDataTypes.DoubleType:
            FValue.SetDouble(Source.GetDouble);
        TDBXDataTypes.BcdType:
            FValue.SetBcd(Source.GetBcd);
        TDBXDataTypes.VarBytesType,
        TDBXDataTypes.BytesType,
        TDBXDataTypes.AdtType,
        TDBXDataTypes.ArrayType,
        TDBXDataTypes.BlobType:
        begin
          case SubType of
            TDBXDataTypes.MemoSubType:
{$IFNDEF NEXTGEN}
              FValue.SetAnsiString(Source.GetAnsiString);
{$ELSE}
              FValue.SetString(Source.GetString);
{$ENDIF !NEXTGEN}
            TDBXDataTypes.WideMemoSubType:
              FValue.SetWideString(Source.GetWideString);
            else
              CopyByteValue(Source, FValue);
          end;
        end;
        TDBXDataTypes.CursorType:
          ;
        TDBXDataTypes.TimeStampType:
            FValue.SetTimeStamp(Source.GetTimeStamp);
        TDBXDataTypes.TimeStampOffsetType:
            FValue.SetTimeStampOffset(Source.GetTimeStampOffset);
      end;
    end;
  end;
end;

function TDBXParameter.Clone: TObject;
var
  Copy: TDBXParameter;
begin
  Copy := TDBXParameter.Create(FDBXContext);
  Copy.Assign(Self);
  Result := Copy;
end;


procedure TDBXParameter.AssignType(Source: TDBXParameter);
begin
  FName               := Source.FName;
  FOrdinal            := -1;
  FDataType           := Source.DataType;
  FSubType            := Source.SubType;
  FSize               := Source.FSize;
  FPrecision          := Source.FPrecision;
  FScale              := Source.FScale;
  FChildPosition      := 0;
  FFlags              := Source.FFlags;
  FParameterDirection := Source.FParameterDirection;
  FDbxRow             := nil;
  FModified           := true;
  FDBXContext         := Source.DBXContext;
end;

procedure TDBXParameter.Assign(Source: TDBXParameter);
begin
  AssignType(Source);
  if Assigned(Source) then
  begin
    FValue              := TDBXWritableValue(TDBXValue.CreateValue(Source.DBXContext, Self, nil, false));
    AssignValue(Source.GetValue);
  end;
end;

procedure TDBXValueType.SetParameterDirection(const ParameterDirection: TDBXParameterDirection);
begin
  if ParameterDirection <> FParameterDirection then
  begin
    FParameterDirection := ParameterDirection;
    FModified := true;
  end
end;

function CheckIsNewValueType(Value: TDBXWritableValue; ValueType: TDBXValueType): Boolean;
begin
  case ValueType.DataType of
    TDBXDataTypes.AnsiStringType:
      Result := (Value is TDBXAnsiStringBuilderValue) or (Value is TDBXAnsiCharsValue);
    TDBXDataTypes.WideStringType:
      Result := (Value is TDBXWideStringBuilderValue) or (Value is TDBXStringValue)
                  or (Value is TDBXWideCharsValue);
    TDBXDataTypes.DateType:
      Result := Value is TDBXDateValue;
    TDBXDataTypes.BooleanType:
      Result := Value is TDBXBooleanValue;
    TDBXDataTypes.TimeType:
      Result := Value is TDBXTimeValue;
    TDBXDataTypes.Int8Type:
      Result := Value is TDBXInt8Value;
    TDBXDataTypes.UInt8Type:
      Result := Value is TDBXUInt8Value;
    TDBXDataTypes.Int16Type:
      Result := Value is TDBXInt16Value;
    TDBXDataTypes.UInt16Type:
      Result := Value is TDBXUInt16Value;
    TDBXDataTypes.Int32Type:
      Result := Value is TDBXInt32Value;
    TDBXDataTypes.Int64Type:
      Result := Value is TDBXInt64Value;
    TDBXDataTypes.DoubleType:
      Result := Value is TDBXDoubleValue;
    TDBXDataTypes.SingleType:
      Result := Value is TDBXSingleValue;
    TDBXDataTypes.BcdType,
    TDBXDataTypes.CurrencyType:
      Result := Value is TDBXBcdValue;
    TDBXDataTypes.VarBytesType,
    TDBXDataTypes.BytesType,
    TDBXDataTypes.AdtType,
    TDBXDataTypes.ArrayType,
    TDBXDataTypes.BlobType:
      case ValueType.SubType of
        TDBXDataTypes.HMemoSubType,
        TDBXDataTypes.MemoSubType:
          Result := (Value is TDBXAnsiMemoValue) or (Value is TDBXAnsiCharsValue)
                      or (Value is TDBXStringValue);
        TDBXDataTypes.WideMemoSubType:
          Result := (Value is TDBXWideMemoValue) or (Value is TDBXWideCharsValue)
                      or (Value is TDBXStringValue);
        else
          Result := Value is TDBXStreamValue;
      end;
    TDBXDataTypes.VariantType:
      Result := Value is TDBXStreamValue;
    TDBXDataTypes.BinaryBlobType:
      Result := Value is TDBXStreamValue;
    TDBXDataTypes.CursorType:
      Result := Value is TDBXCursorValue;
    TDBXDataTypes.TimeStampType:
      Result := Value is TDBXTimeStampValue;
    TDBXDataTypes.DateTimeType:
      Result := Value is TDBXTimeStampValue;
    TDBXDataTypes.TableType:
      Result := Value is TDBXReaderValue;
    TDBXDataTypes.DBXConnectionType:
      Result := Value is TDBXConnectionValue;
    TDBXDataTypes.UnknownType:
      Result := Value is TDBXNullValue;
    TDBXDataTypes.TimeStampOffsetType:
      Result := Value is TDBXTimeStampOffsetValue;
    else
      Result := False;
  end;
end;

procedure TDBXParameter.UpdateParameterType(SetDataType: TDBXType);
var
  NewValue: TDBXValue;
  OldValue: TDBXWritableValue;
begin
  if DataType = TDBXDataTypes.UnknownType then
    DataType := SetDataType;

  if (FValue = nil) then
  begin
    if (DataType = TDBXDataTypes.UnknownType) then
      FValue := TDBXNullValue.Create(Self)
    else
      FValue := TDBXValue.CreateValue(FDBXContext, Self, FDbxRow, false);
  end
  else if not CheckIsNewValueType(FValue, Self) then
  begin
    Assert(FValue.FValueType = Self);
    FValue.FValueType := nil;
    FreeAndNil(FValue);
    if (DataType = TDBXDataTypes.UnknownType) then
      FValue := TDBXNullValue.Create(Self)
    else
      FValue := TDBXWritableValue(TDBXValue.CreateValue(FDBXContext, Self, FDbxRow, false));
  end;

  NewValue := nil;
  OldValue := nil;
  if FDbxRow <> nil then
  begin
    if FValue.FDbxRow = nil then
    begin
      FValue.FDbxRow := FDbxRow;
      NewValue := FDBXRow.CreateCustomValue(Self);
      if NewValue <> nil then
      try
        OldValue := FValue;
        FValue := TDBXWritableValue(NewValue);
        FValue.FDbxRow := FDbxRow;
      except
        if OldValue <> FValue then
          FValue := OldValue;
        NewValue.Free;
        raise;
      end;
    end;
    FDbxRow.SetValueType(FValue.ValueType);
  end;

  FValue.UpdateType;

  if FDBXRow <> nil then
    FModified := false;

  if (NewValue <> nil) and (OldValue <> nil) then
  begin
    try
      TDBXParameter(Self).AssignValue(OldValue);
    finally
      OldValue.FValueType := nil;
      OldValue.Free;
    end;
  end;

end;



function TDBXParameterList.GetCount: TInt32;
begin
  if Assigned(FValueTypes) then
    Result := FValueTypes.Count
  else
    Result := 0;
end;

function TDBXParameterList.GetOrdinal(const Name: string): Integer;
begin
  Result := FValueTypes.GetOrdinal(Name);
end;

function TDBXParameterList.GetParameterByName(
  const Name: string): TDBXParameter;
begin
  Result := GetParameterByOrdinal(GetOrdinal(Name));
end;

procedure TDBXParameterList.InvalidOrdinal(Ordinal: TInt32);
begin
    raise TDBXError.Create(TDBXErrorCodes.InvalidOrdinal,
                               Format(SInvalidOrdinal, [Ordinal]));
end;

function TDBXParameterList.GetParameterByOrdinal(
  const Ordinal: TInt32): TDBXParameter;
var
  ValueType: TDBXValueType;
begin
  if (Ordinal < 0) or (Ordinal >= Count) then
    InvalidOrdinal(Ordinal);
  ValueType := FValueTypes[Ordinal];
  if ValueType = nil then
    Result := nil
  else
    Result := TDBXParameter(ValueType);
end;



function TDBXParameterList.GetRow: TDBXRow;
begin
  Result := FParameterRow;
end;

procedure TDBXParameterList.InsertParameter(Ordinal: Integer;
  Parameter: TDBXParameter);
begin
  FValueTypes.Insert(Ordinal, Parameter);
end;


procedure TDBXParameterList.RemoveParameter(Parameter: TDBXParameter);
begin
  FValueTypes.Remove(Parameter.Ordinal);
end;

procedure TDBXParameterList.RemoveParameters;
begin
  if Assigned(FValueTypes) then
    FValueTypes.RemoveAll;
end;

procedure TDBXParameterList.RemoveParameter(Ordinal: Integer);
begin
  FValueTypes.Remove(FValueTypes[Ordinal]);
end;

{ TDBXByteReader }

constructor TDBXByteReader.Create(DBXContext: TDBXContext);
begin
  inherited Create;
  FDBXContext := DBXContext;
end;


{ TDBXContext }



constructor TDBXContext.Create(DBXContext: TDBXContext);
begin
  inherited Create;
  FOnError            := DBXContext.FOnError;
  FOnTrace            := DBXContext.FOnTrace;
  FTraceFlags         := DBXContext.FTraceFlags;
  FTraceLevel         := DBXContext.FTraceLevel;
  FOnErrorDBXContext  := DBXContext.FOnErrorDBXContext;
  FOnTraceDBXContext  := DBXContext.FOnTraceDBXContext;
  FDBXFormatter       := DBXContext.FDBXFormatter;
end;

constructor TDBXContext.Create;
begin
  inherited Create;
  FTraceFlags := TDBXTraceFlags.Prepare
                  or TDBXTraceFlags.Execute
                  or TDBXTraceFlags.Error
                  or TDBXTraceFlags.Command
                  or TDBXTraceFlags.Connect
                  or TDBXTraceFlags.Blob
                  or TDBXTraceFlags.Misc
//                  or TDBXTraceFlags.VENDOR
                  or TDBXTraceFlags.Parameter
                  or TDBXTraceFlags.Reader
                  or TDBXTraceFlags.DriverLoad
                  or TDBXTraceFlags.Custom
                  ;
  FTraceLevel := TDBXTraceLevels.Highest;
  FClosedByteReader := TDBXClosedByteReader.Create(Self);
end;

destructor TDBXContext.Destroy;
begin
  FClosedByteReader.Free;
  inherited;
end;

procedure TDBXContext.Error(ErrorCode: TDBXErrorCode;
  ErrorMessage: string; InnerException: Exception);
begin
  Error(ErrorCode, ErrorMessage); // Delphi RTL sets the inner exception.
end;

procedure TDBXContext.Error(ErrorCode: TDBXErrorCode;
  ErrorMessage: string);
var
  DBXError: TDBXError;
begin
  DBXError := TDBXError.Create(ErrorCode, ErrorMessage);

  if FOnErrorDBXContext <> nil then
    if Assigned(FOnErrorDBXContext.FOnError) then
    begin
      FOnErrorDBXContext.FOnError(DBXError);
    end;
  raise DBXError;
end;

function TDBXContext.isTracing(TraceFlags: TDBXTraceFlag): Boolean;
begin
  if FOnTraceDBXContext <> nil then
  begin
    if (FOnTraceDBXContext.FOnTraceDBXContext <> nil) and ((TraceFlags and FTraceFlags) <> 0) then
      Result := true
    else
      Result := false;
  end else
    Result := false;
end;

function TDBXContext.IsTracingCategory(Category: string): Boolean;
begin
  Result := true;
end;

function TDBXContext.IsTracingLevel(TraceLevel: TDBXTraceLevel): Boolean;
begin
  if FOnTraceDBXContext <> nil then
  begin
    if (FOnTraceDBXContext.FOnTraceDBXContext <> nil) and (FTraceLevel <= Tracelevel) then
      Result := true
    else
      Result := false;
  end else
    Result := false;
end;

procedure TDBXContext.SetDBXFormatter(const DBXFormatter: TDBXFormatter);
begin
  FDBXFormatter := DBXFormatter;
end;

procedure TDBXContext.SetOnError(const Value: TDBXErrorEvent);
begin
  FOnError := Value;
  if Assigned(Value) then
    FOnErrorDBXContext := Self
  else
    FOnErrorDBXContext := nil;
end;

procedure TDBXContext.SetOnTrace(const Value: TDBXTraceEvent);
begin
  FOnTrace := Value;
  if Assigned(Value) then
    FOnTraceDBXContext := Self
  else
    FOnTraceDBXContext := nil;
end;

procedure TDBXContext.SetTraceFlags(const Value: TDBXTraceFlag);
begin
  FTraceFlags         := Value;
  FOnTraceDBXContext  := Self;
end;


procedure TDBXContext.SetTraceLevel(const Value: TDBXTraceFlag);
begin
  FTraceLevel := Value;
end;

function TDBXContext.Trace(TraceLevel: TDBXTraceLevel; TraceFlag: TDBXTraceFlag;
  CustomCategory, TraceMessage: string): CBRType;
var
  TraceInfo:  TDBXTraceInfo;
begin
  if (FOnTraceDBXContext <> nil) and Assigned(FOnTraceDBXContext.FOnTrace) then
  begin
    TraceInfo.Message   := TraceMessage;
    TraceInfo.TraceFlag := TraceFlag;
    TraceInfo.TraceLevel := TraceLevel;
    TraceInfo.CustomCategory := CustomCategory;

    Result := FOnTraceDBXContext.FOnTrace(TraceInfo);
  end else
    Result := cbrCONTINUE;
end;

function TDBXContext.Trace(TraceLevel: TDBXTraceLevel; TraceFlag: TDBXTraceFlag;
  TraceMessage: string): CBRType;
begin
  Result := Trace(TraceLevel, TraceFlag, '', TraceMessage);
end;

function TDBXContext.Trace(TraceFlag: TDBXTraceFlag;
  TraceMessage: string): CBRType;
begin
  Result := Trace(TDBXTraceLevels.Highest, TraceFlag, '', TraceMessage);
end;

function TDBXContext.Trace(TraceLevel: TDBXTraceLevel; CustomCategory,
  TraceMessage: string): CBRType;
begin
  Result := Trace(TraceLevel, TDBXTraceFlags.Custom, CustomCategory, TraceMessage);
end;

{ TDBXDelegateDriver }

procedure TDBXDelegateDriver.Close;
begin

end;

constructor TDBXDelegateDriver.Create(Driver: TDBXDriver);
begin
  inherited Create;
    FDriver := Driver;
    Driver.AddReference;
end;

destructor TDBXDelegateDriver.Destroy;
begin
  if FDriver <> nil then
    FDriver.RemoveReference;
  FDriver := nil;
  inherited;
end;

function TDBXDelegateDriver.CreateMorphCommand(DbxContext: TDBXContext;
  Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
begin
  Result := TDBXDriver(FDriver).CreateMorphCommand(DbxContext, Connection, MorphicCommand);
end;

function TDBXDelegateDriver.CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection;
begin
    Result := FDriver.CreateConnection(ConnectionBuilder);
end;

function TDBXDelegateDriver.GetDriverClass: TClass;
begin
  Result := FDriver.GetDriverClass;
end;

function TDBXDelegateDriver.GetDriverName: string;
begin
  if FDriver = nil then
    Result := ''
  else
    Result := FDriver.GetDriverName;
end;

function TDBXDelegateDriver.GetDriverProperties: TDBXProperties;
begin
  Result := FDriver.GetDriverProperties;
end;

function TDBXDelegateDriver.GetDriverVersion: string;
begin
  Result := FDriver.GetDriverVersion;
end;

procedure TDBXDelegateDriver.SetDriverName(const DriverName: string);
begin
  FDriver.SetDriverName(DriverName);
end;

procedure TDBXDelegateDriver.InitDriverProperties(const DriverProperties: TDBXProperties);
begin
  FDriver.InitDriverProperties(DriverProperties);
end;


{ TDBXAnsiStringBuilderValue }

procedure TDBXAnsiStringBuilderValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetDynamicBytes(Self, 0, FValue, 0, Length(FValue));
end;

procedure TDBXAnsiStringBuilderValue.SetRowValue;
begin
  FDbxRow.SetDynamicBytes(Self, 0, FValue, 0, Length(FValue));
end;

{$IFNDEF NEXTGEN}
function TDBXAnsiStringBuilderValue.GetAnsiString: AnsiString;
var
  LAnsiStr: AnsiString;
  Len: Integer;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetAnsiString(Self, FStringBuilder, FIsNull);
    if FIsNull then
    begin
      SetLength(FValue, 0);
      FCount := 0;
    end
    else
    begin
      TDBXPlatform.CopyStringBuilder(FStringBuilder, LAnsiStr);
      FValue := BytesOf(LAnsiStr);
      FCount := Length(FValue);
    end;
    FGeneration := FDbxRow.Generation;
  end;
  Len := Length(FValue);
  if Len > 0 then
  begin
    if (FCount > 0) and (FCount < Len) then
      Len := FCount;
    Result := TMarshal.AsAnsi(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(FValue), Len))
  end
  else
    Result := '';
end;

procedure TDBXAnsiStringBuilderValue.SetAnsiString(const Value: AnsiString);
var
  Len: Integer;
begin
//  ValueType.FailIfReadOnly;
  FIsNull := False;
  FValue := BytesOf(Value);
  Len := Length(FValue);
  FCount := Len;
  SetLength(FValue, Len+1);
  FValue[Len] := 0;
  FSetPending := True;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;
{$ELSE}
function TDBXAnsiStringBuilderValue.GetString: string;
var
  Len: Integer;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetAnsiString(Self, FStringBuilder, FIsNull);
    if FIsNull then
    begin
      SetLength(FValue, 0);
      FCount := 0;
    end
    else
    begin
      FCount := Length(FStringBuilder);
      SetLength(FValue, FCount);
      if FCount > 0 then
        Move(FStringBuilder^, FValue[0], FCount);
    end;
    FGeneration := FDbxRow.Generation;
  end;
  Len := Length(FValue);
  if Len > 0 then
  begin
    if (FCount > 0) and (FCount < Len) then
      Len := FCount;
    Result := TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(FValue), Len);
  end
  else
    Result := '';
end;

procedure TDBXAnsiStringBuilderValue.SetString(const Value: string);
var
  LEncoding: TEncoding;
  LMarshaller: TMarshaller;
  LWrapper: TPtrWrapper;
  LCount: Integer;
begin
  FIsNull := False;
  LWrapper := LMarshaller.AsAnsi(Value);
  // workaround for TMarshaller not returning length information
  LEncoding := TEncoding.GetEncoding(DefaultSystemCodePage);
  try
    LCount := LEncoding.GetByteCount(Value);
  finally
    LEncoding.Free;
  end;
  SetLength(FValue, LCount);
  FCount := LCount;
  TMarshal.Copy(LWrapper, FValue, 0, LCount);
  SetLength(FValue, LCount+1);
  FValue[LCount] := 0;
  FSetPending := True;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;
{$ENDIF !NEXTGEN}

procedure TDBXAnsiStringBuilderValue.UpdateType;
begin
  // Add one because dynalink drivers will always set a null byte
  // even if the length is 0.
  //
  TDBXPlatform.ResizeStringBuilder(FStringBuilder, ValueType.Size+1);
end;

constructor TDBXAnsiStringBuilderValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
  // Add one because dynalink drivers will always set a null byte
  // even if the length is 0.
  //
  FStringBuilder      := TDBXPlatform.CreateStringBuilder(ValueType.Size+1);

end;

function TDBXAnsiStringBuilderValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetAnsiString(Self, FStringBuilder, FIsNull);
    if FIsNull then
      SetLength(FValue, 0)
    else
    begin
      FCount := Length(FStringBuilder);
      SetLength(FValue, FCount);
      if FCount > 0 then
        Move(FStringBuilder^, FValue[0], FCount);
    end;
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

destructor TDBXAnsiStringBuilderValue.Destroy;
begin
  TDBXPlatform.FreeAndNilStringBuilder(FStringBuilder);
  inherited;
end;

{ TDBXAnsiStringValue }

procedure TDBXAnsiStringValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
{$IFDEF NEXTGEN}
    SetString(Value.GetString);
{$ELSE}
    SetAnsiString(Value.GetAnsiString);
{$ENDIF}
end;

{$IFNDEF NEXTGEN}
procedure TDBXAnsiStringValue.SetAnsiString(const Value: AnsiString);
begin
  inherited;
end;
{$ELSE}
procedure TDBXAnsiStringValue.SetString(const Value: string);
begin
  inherited;
end;
{$ENDIF}

procedure TDBXAnsiStringValue.SetAsBcd(const Value: TBcd);
var
  BcdValue: TDBXBcdValue;
begin
  BcdValue := TDBXBcdValue.Create(nil);
  try
    BcdValue.SetBcd(Value);
    SetAsString(TDBXDefaultFormatter.GetDefaultDBXFormatter.BcdToString(BcdValue));
  finally
    BcdValue.Free;
  end;
end;

procedure TDBXAnsiStringValue.SetAsBoolean(const Value: Boolean);
begin
  SetAsString(BoolToStr(Value, True));
end;

procedure TDBXAnsiStringValue.SetAsDate(const Value: TDBXDate);
var
  DateValue: TDBXDateValue;
begin
  DateValue := TDBXDateValue.Create(nil);
  try
    DateValue.SetDate(Value);
    SetAsString(TDBXDefaultFormatter.GetDefaultDBXFormatter.DateToString(DateValue));
  finally
    DateValue.Free;
  end;
end;

procedure TDBXAnsiStringValue.SetAsDouble(const Value: Double);
begin
  SetAsString(FloatToStr(Value));
end;

procedure TDBXAnsiStringValue.SetAsInt16(const Value: SmallInt);
begin
  SetAsString(IntToStr(Value));
end;

procedure TDBXAnsiStringValue.SetAsInt32(const Value: TInt32);
begin
  SetAsString(IntToStr(Value));
end;

procedure TDBXAnsiStringValue.SetAsInt64(const Value: Int64);
begin
  SetAsString((IntToStr(Value)));
end;

procedure TDBXAnsiStringValue.SetAsInt8(const Value: ShortInt);
begin
  SetAsString((IntToStr(Value)));
end;

procedure TDBXAnsiStringValue.SetAsSingle(const Value: Single);
begin
  SetAsString((FloatToStr(Value)));
end;

procedure TDBXAnsiStringValue.SetAsString(const Value: string);
begin
{$IFDEF NEXTGEN}
  inherited;
{$ELSE}
  SetAnsiString(AnsiString(Value));
{$ENDIF}
end;

procedure TDBXAnsiStringValue.SetAsTime(const Value: TDBXTime);
var
  TimeValue: TDBXTimeValue;
begin
  TimeValue := TDBXTimeValue.Create(nil);
  try
    TimeValue.SetTime(Value);
    SetAsString((TDBXDefaultFormatter.GetDefaultDBXFormatter.TimeToString(TimeValue)));
  finally
    TimeValue.Free;
  end;
end;

procedure TDBXAnsiStringValue.SetAsTimeStamp(const Value: TSQLTimeStamp);
var
  TimestampValue: TDBXTimestampValue;
begin
  TimestampValue := TDBXTimeStampValue.Create(nil);
  try
    TimestampValue.SetTimeStamp(Value);
    SetAsString((TDBXDefaultFormatter.GetDefaultDBXFormatter.TimestampToString(TimestampValue)));
  finally
    TimestampValue.Free;
  end;
end;

procedure TDBXAnsiStringValue.SetAsUInt16(const Value: Word);
begin
  SetAsString((IntToStr(Value)));
end;

procedure TDBXAnsiStringValue.SetAsUInt8(const Value: Byte);
begin
  SetAsString((IntToStr(Value)));
end;

procedure TDBXAnsiStringValue.UpdateType;
begin
  inherited;
end;

function TDBXAnsiStringValue.Compare(Other: TDBXValue): Smallint;
begin
  Result := AnsiCompareText(AsString, Other.AsString)
end;

constructor TDBXAnsiStringValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
end;

function TDBXAnsiStringValue.IsNull: Boolean;
begin
  InvalidOperation;
  Result := false;
end;

destructor TDBXAnsiStringValue.Destroy;
begin
  FOverFlowBytes.Free;
  inherited;
end;

{$IFNDEF NEXTGEN}
function TDBXAnsiStringValue.GetAnsiString: AnsiString;
begin
  Result := '';
end;
{$ELSE}
function TDBXAnsiStringValue.GetString: string;
begin
  Result := '';
end;
{$ENDIF}

function TDBXAnsiStringValue.GetAsBcd: TBcd;
var
  BcdValue: TDBXBcdValue;
begin
  BcdValue := TDBXBcdValue.Create(nil);
  try
    TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToBcd(GetAsString, BcdValue);
    Result := BcdValue.GetBcd;
  finally
    BcdValue.Free;
  end;
end;

function TDBXAnsiStringValue.GetAsBoolean: Boolean;
begin
  Result := GetAsString = 'True';
end;

function TDBXAnsiStringValue.GetAsDate: TDBXDate;
var
  DateValue: TDBXDateValue;
begin
  DateValue := TDBXDateValue.Create(nil);
  try
    TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToDate(GetAsString, DateValue);
    Result := DateValue.GetDate;
  finally
    DateValue.Free;
  end;
end;

function TDBXAnsiStringValue.GetAsDouble: Double;
begin
  Result := StrToFloatDef(GetAsString, 0);
end;

function TDBXAnsiStringValue.GetAsInt16: SmallInt;
begin
  Result := StrToIntDef(GetAsString, 0);
end;

function TDBXAnsiStringValue.GetAsInt32: TInt32;
begin
  Result := StrToIntDef(GetAsString, 0);
end;

function TDBXAnsiStringValue.GetAsInt64: Int64;
begin
  Result := StrToInt64Def(GetAsString, 0);
end;

function TDBXAnsiStringValue.GetAsInt8: ShortInt;
begin
  Result := StrToIntDef(GetAsString, 0);
end;

function TDBXAnsiStringValue.GetAsSingle: Single;
begin
  Result := StrToFloatDef(GetAsString, 0);
end;

function TDBXAnsiStringValue.GetAsString: string;
begin
{$IFDEF NEXTGEN}
  Result := GetString;
{$ELSE}
  Result := string(GetAnsiString);
{$ENDIF}
end;

function TDBXAnsiStringValue.GetAsTime: TDBXTime;
var
  TimeValue: TDBXTimeValue;
begin
  TimeValue := TDBXTimeValue.Create(nil);
  try
    TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToTime(GetAsString, TimeValue);
    Result := TimeValue.GetTime;
  finally
    TimeValue.Free;
  end;
end;

function TDBXAnsiStringValue.GetAsTimeStamp: TSQLTimeStamp;
var
  TimestampValue: TDBXTimestampValue;
begin
  TimestampValue := TDBXTimestampValue.Create(nil);
  try
    TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToTimestamp(GetAsString, TimestampValue);
    Result := TimestampValue.GetTimeStamp;
  finally
    TimestampValue.Free;
  end;
end;

function TDBXAnsiStringValue.GetAsUInt16: Word;
begin
  Result := StrToIntDef(GetAsString, 0);
end;

function TDBXAnsiStringValue.GetAsUInt8: Byte;
begin
  Result := StrToIntDef(GetAsString, 0);
end;

function TDBXAnsiStringValue.GetStreamReader: TDBXStreamReader;
begin
  Result := FOverFlowBytes;
end;

procedure TDBXAnsiStringValue.SetOverflowBytes(
  const OverFlowBytes: TDBXByteStreamReader);
begin
  FreeAndNil(FOverFlowBytes);
  FOverFlowBytes := OverFlowBytes;
end;

{ TDBXAnsiMemoValue }

procedure TDBXAnsiMemoValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
  begin
    Row.SetDynamicBytes(Self, 0, FBytes, 0, Length(FBytes));
  end;
end;

constructor TDBXAnsiMemoValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
end;

destructor TDBXAnsiMemoValue.Destroy;
begin
  FBytes := nil;
  inherited;
end;

{$IFNDEF NEXTGEN}
function TDBXAnsiMemoValue.GetAnsiString: AnsiString;
begin
  GetFBytes;
  if Length(FBytes) > 0 then
    Result := TMarshal.AsAnsi(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(FBytes), Length(FBytes)))
  else
    Result := '';
end;

procedure TDBXAnsiMemoValue.SetAnsiString(const Value: AnsiString);
begin
  SetDynamicBytes(0, BytesOf(Value), 0, Length(Value));
end;
{$ELSE}
function TDBXAnsiMemoValue.GetString: string;
begin
  GetFBytes;
  if Length(FBytes) > 0 then
    Result := TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(FBytes), Length(FBytes))
  else
    Result := '';
end;

procedure TDBXAnsiMemoValue.SetString(const Value: string);
var
  LEncoding: TEncoding;
  LMarshaller: TMarshaller;
  LWrapper: TPtrWrapper;
  LBytes: TArray<Byte>;
  LCount: Integer;
begin
  FIsNull := false;
  LWrapper := LMarshaller.AsAnsi(Value);
  // workaround for TMarshaller not returning length information
  LEncoding := TEncoding.GetEncoding(DefaultSystemCodePage);
  try
    LCount := LEncoding.GetByteCount(Value);
  finally
    LEncoding.Free;
  end;
  SetLength(LBytes, LCount);
  TMarshal.Copy(LWrapper, LBytes, 0, LCount);
  SetDynamicBytes(0, LBytes, 0, LCount);
end;
{$ENDIF}

function TDBXAnsiMemoValue.GetAsString: string;
begin
{$IFDEF NEXTGEN}
  Result := GetString;
{$ELSE}
  Result := string(GetAnsiString);
{$ENDIF}
end;

procedure TDBXAnsiMemoValue.SetAsString(const Value: string);
begin
{$IFDEF NEXTGEN}
  SetString(Value);
{$ELSE}
  SetAnsiString(AnsiString(Value));
{$ENDIF}
end;

procedure TDBXAnsiMemoValue.SetValue(const Value: TDBXValue);
begin
{$IFDEF NEXTGEN}
  SetAsString(Value.GetAsString);
{$ELSE}
  SetAnsiString(Value.GetAnsiString);
{$ENDIF}
end;

procedure TDBXAnsiMemoValue.GetFBytes;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetByteLength(Self, FByteLength, FIsNull);
    if FIsNull then
      FBytes := nil
    else
    begin
      // Most of the drivers don't fail with no data if you ask for
      // the blob more than once.  If string is asked for, save it like
      // we do for other data types.
      //
      SetLength(FBytes, FByteLength);
      GetBytes(0, FBytes, 0, FByteLength);
      // ASA driver appends null for datatype=3 subtype=22.
      //
      if (FByteLength > 0) and (FBytes[FByteLength-1] = Byte(0)) then
        SetLength(FBytes, FByteLength-1);

    end;
    FGeneration := FDbxRow.Generation;
  end;
end;

function TDBXAnsiMemoValue.IsNull: Boolean;
begin
  GetFBytes;
  Result := FIsNull;
end;

{ TDBXDateValue }

procedure TDBXDateValue.SetDate(const Value: TDBXDate);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FDate := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

function TDBXDateValue.Compare(Other: TDBXValue): Smallint;
begin
  if AsDate = Other.AsDate then
    Result := 0
  else if AsDate < Other.AsDate then
    Result := -1
  else
    Result := 1;
end;

procedure TDBXDateValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetDate(Self, GetDate);
end;

procedure TDBXDateValue.SetRowValue;
begin
  FDbxRow.SetDate(Self, FDate);
end;

procedure TDBXDateValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetDate(Value.GetDate);
end;

function TDBXDateValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetDate(Self, FDate, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

function TDBXDateValue.GetAsDate: TDBXDate;
begin
  Result := GetDate;
end;

function TDBXDateValue.GetAsDateTime: TDateTime;
var
  TimeStamp: TTimeStamp;
begin
  TimeStamp.Time := 0;
  TimeStamp.Date := GetDate;
  Result := TimeStampToDateTime(TimeStamp);
end;

function TDBXDateValue.GetAsString: string;
begin
  Result := TDBXDefaultFormatter.GetDefaultDBXFormatter.DateToString(Self);
end;

function TDBXDateValue.GetAsTimeStamp: TSQLTimeStamp;
var
  Time: TTimeStamp;
begin
  Time.Time := 0;
  Time.Date := GetDate;
  Result := DateTimeToSQLTimeStamp(TimeStampToDateTime(Time));
end;

procedure TDBXDateValue.SetAsDate(const Value: TDBXDate);
begin
  SetDate(Value);
end;

procedure TDBXDateValue.SetAsDateTime(const Value: TDateTime);
begin
  SetDate(DateTimeToTimeStamp(Value).Date);
end;

procedure TDBXDateValue.SetAsString(const Value: string);
begin
  TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToDate(Value, Self);
end;

procedure TDBXDateValue.SetAsTimeStamp(const Value: TSQLTimeStamp);
begin
  SetDate(DateTimeToTimeStamp(SQLTimeStampToDateTime(Value)).Date);
end;

function TDBXDateValue.GetDate: TDBXDate;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetDate(Self, FDate, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FDate;
end;

{ TDBXBooleanValue }

procedure TDBXBooleanValue.SetAsInt16(const Value: SmallInt);
begin
  SetAsInt32(Value);
end;

procedure TDBXBooleanValue.SetAsInt32(const Value: TInt32);
begin
  SetBoolean(Value <> 0);
end;

procedure TDBXBooleanValue.SetAsInt64(const Value: Int64);
begin
  SetBoolean(Value <> 0);
end;

procedure TDBXBooleanValue.SetAsInt8(const Value: ShortInt);
begin
  SetAsInt32(Value);
end;

procedure TDBXBooleanValue.SetAsString(const Value: string);
begin
  SetBoolean(UpperCase(Value) <> 'FALSE');
end;

procedure TDBXBooleanValue.SetAsUInt16(const Value: Word);
begin
  SetAsInt32(Value);
end;

procedure TDBXBooleanValue.SetAsUInt8(const Value: Byte);
begin
  SetAsInt32(Value);
end;

procedure TDBXBooleanValue.SetAsBoolean(const Value: Boolean);
begin
  SetBoolean(Value);
end;

procedure TDBXBooleanValue.SetBoolean(const Value: Boolean);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FBoolean := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

function TDBXBooleanValue.Compare(Other: TDBXValue): Smallint;
begin
  // false < true
  if AsBoolean = Other.AsBoolean then
    Result := 0
  else if AsBoolean then
    Result := 1
  else
    Result := -1
end;

procedure TDBXBooleanValue.CopyRowValue(Row: TDBXRow);
begin
  if isNull then
    Row.SetNull(Self)
  else
    Row.SetBoolean(Self, GetBoolean);
end;

procedure TDBXBooleanValue.SetRowValue;
begin
  FDbxRow.SetBoolean(Self, FBoolean);
end;

procedure TDBXBooleanValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetBoolean(Value.GetAsBoolean);
end;

function TDBXBooleanValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetBoolean(Self, FBoolean, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

function TDBXBooleanValue.EqualsValue(Other: TDBXValue): Boolean;
begin
  Result := GetBoolean = Other.GetBoolean;
end;

function TDBXBooleanValue.GetAsInt16: SmallInt;
begin
  Result := Ord(GetBoolean);
end;

function TDBXBooleanValue.GetAsInt32: TInt32;
begin
  Result := GetAsInt16;
end;

function TDBXBooleanValue.GetAsInt64: Int64;
begin
  Result := GetAsInt16;
end;

function TDBXBooleanValue.GetAsInt8: ShortInt;
begin
  Result := GetAsInt16;
end;

function TDBXBooleanValue.GetAsString: string;
begin
  Result := BoolToStr(GetBoolean, True);
end;

function TDBXBooleanValue.GetAsUInt16: Word;
begin
  Result := GetAsInt16;
end;

function TDBXBooleanValue.GetAsUInt8: Byte;
begin
  Result := GetAsInt16;
end;

function TDBXBooleanValue.GetAsBoolean: Boolean;
begin
  Result := GetBoolean;
end;

function TDBXBooleanValue.GetBoolean: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetBoolean(Self, FBoolean, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FBoolean;
end;

{ TDBXTimeValue }

function TDBXTimeValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetTime(Self, FTime, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

function TDBXTimeValue.Compare(Other: TDBXValue): Smallint;
begin
  if AsTime = Other.AsTime then
    Result := 0
  else if AsTime < Other.AsTime then
    Result := -1
  else
    Result := 1;
end;

procedure TDBXTimeValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetTime(Self, GetTime);
end;

procedure TDBXTimeValue.SetRowValue;
begin
  FDbxRow.SetTime(Self, FTime);
end;

procedure TDBXTimeValue.SetTime(const Value: TDBXTime);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FTime := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXTimeValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetTime(Value.GetTime);
end;

function TDBXTimeValue.GetAsDateTime: TDateTime;
var
  TimeStamp: TTimeStamp;
begin
  TimeStamp.Time := GetTime;
  TimeStamp.Date := DateDelta;
  Result := TimeStampToDateTime(TimeStamp);
end;

function TDBXTimeValue.GetAsString: string;
begin
  Result := TDBXDefaultFormatter.GetDefaultDBXFormatter.TimeToString(Self);
end;

function TDBXTimeValue.GetAsTime: TDBXTime;
begin
  Result := GetTime;
end;

function TDBXTimeValue.GetAsTimeStamp: TSQLTimeStamp;
var
  Time: TTimeStamp;
begin
  Time.Time := GetTime;
  Time.Date := DateDelta;
  Result := DateTimeToSQLTimeStamp(TimeStampToDateTime(Time));
end;

procedure TDBXTimeValue.SetAsDateTime(const Value: TDateTime);
begin
  SetTime(DateTimeToTimeStamp(Value).Time);
end;

procedure TDBXTimeValue.SetAsString(const Value: string);
begin
  TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToTime(Value, Self);
end;

procedure TDBXTimeValue.SetAsTime(const Value: TDBXTime);
begin
  SetTime(Value);
end;

procedure TDBXTimeValue.SetAsTimeStamp(const Value: TSQLTimeStamp);
begin
  SetTime(DateTimeToTimeStamp(SQLTimeStampToDateTime(Value)).Time);
end;

function TDBXTimeValue.GetTime: TDBXTime;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetTime(Self, FTime, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FTime;
end;

{ TDBXWideStringValue }

procedure TDBXWideStringValue.SetAsBcd(const Value: TBcd);
var
  BcdValue: TDBXBcdValue;
begin
  BcdValue := TDBXBcdValue.Create(nil);
  try
    BcdValue.SetBcd(Value);
    SetWideString(TDBXDefaultFormatter.GetDefaultDBXFormatter.BcdToString(BcdValue));
  finally
    BcdValue.Free;
  end;
end;

procedure TDBXWideStringValue.SetAsBoolean(const Value: Boolean);
begin
  SetWideString(BoolToStr(Value, True));
end;

procedure TDBXWideStringValue.SetAsDate(const Value: TDBXDate);
var
  DateValue: TDBXDateValue;
begin
  DateValue := TDBXDateValue.Create(nil);
  try
    DateValue.SetDate(Value);
    SetWideString(TDBXDefaultFormatter.GetDefaultDBXFormatter.DateToString(DateValue));
  finally
    DateValue.Free;
  end;
end;

procedure TDBXWideStringValue.SetAsDouble(const Value: Double);
begin
  SetWideString(FloatToStr(Value));
end;

procedure TDBXWideStringValue.SetAsInt16(const Value: SmallInt);
begin
  SetWideString(IntToStr(Value));
end;

procedure TDBXWideStringValue.SetAsInt32(const Value: TInt32);
begin
  SetWideString(IntToStr(Value));
end;

procedure TDBXWideStringValue.SetAsInt64(const Value: Int64);
begin
  SetWideString(IntToStr(Value));
end;

procedure TDBXWideStringValue.SetAsInt8(const Value: ShortInt);
begin
  SetWideString(IntToStr(Value));
end;

procedure TDBXWideStringValue.SetAsSingle(const Value: Single);
begin
  SetWideString(FloatToStr(Value));
end;

procedure TDBXWideStringValue.SetAsString(const Value: string);
begin
  SetWideString(Value);
end;

procedure TDBXWideStringValue.SetAsTime(const Value: TDBXTime);
var
  TimeValue: TDBXTimeValue;
begin
  TimeValue := TDBXTimeValue.Create(nil);
  try
    TimeValue.SetTime(Value);
    SetWideString(TDBXDefaultFormatter.GetDefaultDBXFormatter.TimeToString(TimeValue));
  finally
    TimeValue.Free;
  end;
end;

procedure TDBXWideStringValue.SetAsTimeStamp(const Value: TSQLTimeStamp);
var
  TimestampValue: TDBXTimestampValue;
begin
  TimestampValue := TDBXTimeStampValue.Create(nil);
  try
    TimestampValue.SetTimeStamp(Value);
    SetWideString(TDBXDefaultFormatter.GetDefaultDBXFormatter.TimestampToString(TimestampValue));
  finally
    TimestampValue.Free;
  end;
end;

procedure TDBXWideStringValue.SetAsUInt16(const Value: Word);
begin
  SetWideString(IntToStr(Value));
end;

procedure TDBXWideStringValue.SetAsUInt8(const Value: Byte);
begin
  SetWideString(IntToStr(Value));
end;

procedure TDBXWideStringValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetWideString(Value.GetAsString);
end;

procedure TDBXWideStringValue.UpdateType;
begin
end;

function TDBXWideStringValue.Compare(Other: TDBXValue): Smallint;
begin
  Result := AnsiCompareText(AsString, Other.AsString)
end;

constructor TDBXWideStringValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
end;

function TDBXWideStringValue.IsNull: Boolean;
begin
  Result := true;
end;

destructor TDBXWideStringValue.Destroy;
begin
  FOverFlowBytes.Free;
  inherited;
end;

function TDBXWideStringValue.EqualsValue(Other: TDBXValue): Boolean;
begin
  Result := GetWideString = other.GetWideString();
end;

function TDBXWideStringValue.GetAsBcd: TBcd;
var
  BcdValue: TDBXBcdValue;
begin
  BcdValue := TDBXBcdValue.Create(nil);
  try
    TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToBcd(GetWideString, BcdValue);
    Result := BcdValue.GetBcd;
  finally
    BcdValue.Free;
  end;
end;

function TDBXWideStringValue.GetAsBoolean: Boolean;
begin
  Result := GetWideString = 'True';
end;

function TDBXWideStringValue.GetAsDate: TDBXDate;
var
  DateValue: TDBXDateValue;
begin
  DateValue := TDBXDateValue.Create(nil);
  try
    TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToDate(GetWideString, DateValue);
    Result := DateValue.GetDate;
  finally
    DateValue.Free;
  end;
end;

function TDBXWideStringValue.GetAsDouble: Double;
begin
  Result := StrToFloatDef(GetWideString, 0);
end;

function TDBXWideStringValue.GetAsInt16: SmallInt;
begin
  Result := StrToIntDef(GetWideString, 0);
end;

function TDBXWideStringValue.GetAsInt32: TInt32;
begin
  Result := StrToIntDef(GetWideString, 0);
end;

function TDBXWideStringValue.GetAsInt64: Int64;
begin
  Result := StrToInt64Def(GetWideString, 0);
end;

function TDBXWideStringValue.GetAsInt8: ShortInt;
begin
  Result := StrToIntDef(GetWideString, 0);
end;

function TDBXWideStringValue.GetAsSingle: Single;
begin
  Result := StrToFloatDef(GetWideString, 0);
end;

function TDBXWideStringValue.GetAsString: string;
begin
  Result := GetWideString;
end;

function TDBXWideStringValue.GetAsTime: TDBXTime;
var
  TimeValue: TDBXTimeValue;
begin
  TimeValue := TDBXTimeValue.Create(nil);
  try
    TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToTime(GetWideString, TimeValue);
    Result := TimeValue.GetTime;
  finally
    TimeValue.Free;
  end;
end;

function TDBXWideStringValue.GetAsTimeStamp: TSQLTimeStamp;
var
  TimestampValue: TDBXTimestampValue;
begin
  TimestampValue := TDBXTimestampValue.Create(nil);
  try
    TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToTimestamp(GetWideString, TimestampValue);
    Result := TimestampValue.GetTimeStamp;
  finally
    TimestampValue.Free;
  end;
end;

function TDBXWideStringValue.GetAsUInt16: Word;
begin
  Result := StrToIntDef(GetWideString, 0);
end;

function TDBXWideStringValue.GetAsUInt8: Byte;
begin
  Result := StrToIntDef(GetWideString, 0);
end;

function TDBXWideStringValue.GetWideString: string;
begin
  Result := '';
end;


{ TDBXWideMemoValue }

procedure TDBXWideMemoValue.SetAsString(const Value: string);
begin
  SetWideString(Value);
end;

procedure TDBXWideMemoValue.SetValue(const Value: TDBXValue);
begin
  SetWideString(Value.GetWideString);
end;

procedure TDBXWideMemoValue.SetWideString(const Value: string);
var
  LBytes: TBytes;
begin
  {$IFDEF NEXTGEN}
  LBytes := TEncoding.ANSI.GetBytes(Value);
  SetDynamicBytes(0, LBytes, 0, Length(LBytes));
  {$ELSE}
                                                             
  //   See Data.DB.TBlobField.SetAsWideString
  LBytes := TDBXPlatform.WideStrToBytes(Value);
  SetDynamicBytes(0, LBytes, 0, Length(LBytes));
  {$ENDIF}
end;

procedure TDBXWideMemoValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
  begin
    Row.SetWideMemo(Self, GetWideString);
  end;
end;

constructor TDBXWideMemoValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
  // Add one because dynalink drivers will always set a null byte
  // even if the length is 0.
  //
//  FStringBuilder      := TDBXPlatform.CreateStringBuilder(ValueType.Size+1);

end;

destructor TDBXWideMemoValue.Destroy;
begin
  FBytes := nil;
  inherited;
end;

function TDBXWideMemoValue.GetWideString: string;
begin
  GetFBytes;
//    Result := string(Buffer);
  Result := string(TDBXPlatform.BytesToWideStr(FBytes));
end;

function TDBXWideMemoValue.IsNull: Boolean;
begin
  GetFBytes;
  Result := FIsNull;
end;


function TDBXWideMemoValue.GetAsString: string;
begin
  Result := GetWideString;
end;

procedure TDBXWideMemoValue.GetFBytes;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetByteLength(Self, FByteLength, FIsNull);
    if FIsNull then
      FBytes := nil
    else
    begin
      SetLength(FBytes, FByteLength);
      // mssql driver encountered InvalidParameter error when calling
      // GetBytes with a 0 length.
      //
      if FByteLength > 0 then
        GetBytes(0, FBytes, 0, FByteLength);
      // ASA driver appends null for datatype=3 subtype=22. See TDBXAnsiMemoValue.getAnsiString.
      // Do it for wide strings also just in case.
      //
      if (FByteLength > 1)
      and (FBytes[FByteLength-1] = Byte(0))
      and (FBytes[FByteLength-2] = Byte(0)) then
      begin
        SetLength(FBytes, FByteLength-2);
      end;
    end;
    FGeneration := FDbxRow.Generation;
  end;
end;

{ TDBXWideStringValue }

procedure TDBXStringValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetWideChars(Self, GetWideString);
end;

constructor TDBXStringValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
end;

destructor TDBXStringValue.Destroy;
begin
  inherited;
end;

function TDBXStringValue.GetWideString: string;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetWideString(Self, FWideString, FIsNull);
    if FIsNull then
      FWideString := '';
    FGeneration := FDbxRow.Generation;
  end;
  Result := FWideString;
end;

function TDBXStringValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetWideString(Self, FWideString, FIsNull);
    if FIsNull then
      FWideString := '';
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;


procedure TDBXStringValue.SetRowValue;
begin
  FDbxRow.SetWideChars(Self, FWideString);
end;

procedure TDBXStringValue.SetWideString(const Value: string);
begin
  FIsNull := false;
  FWideString := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
//  FDbxRow.SetWideChars(Self, FWideString);
end;


procedure TDBXWideStringBuilderValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetWideChars(Self, GetWideString);
end;

procedure TDBXWideStringBuilderValue.SetRowValue;
begin
  FDbxRow.SetWideChars(Self, FWideString);
end;

procedure TDBXWideStringBuilderValue.SetWideString(const Value: string);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FWideString := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXWideStringBuilderValue.UpdateType;
begin
  // Add one because dynalink drivers will always set a null byte
  // even if the length is 0.
  //
  TDBXPlatform.ResizeWideStringBuilder(FWideStringBuilder, ValueType.Size+1);
end;

constructor TDBXWideStringBuilderValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
  if (ValueType.GetFlags and TDBXValueTypeFlags.ExtendedType) = 0 then
  begin
    // Add one because dynalink drivers will always set a null byte
    // even if the length is 0.
    //
    FWideStringBuilder  := TDBXPlatform.CreateWideStringBuilder(ValueType.Size+1);
  end;
end;

function TDBXWideStringBuilderValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetWideString(Self, FWideStringBuilder, FIsNull);
    if FIsNull then
      FWideString := ''
    else
      TDBXPlatform.CopyWideStringBuilder(FWideStringBuilder, FWideString);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

destructor TDBXWideStringBuilderValue.Destroy;
begin
  TDBXPlatform.FreeAndNilWideStringBuilder(FWideStringBuilder);
  inherited;
end;

function TDBXWideStringBuilderValue.GetWideString: string;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetWideString(Self, FWideStringBuilder, FIsNull);
    if FIsNull then
      FWideString := ''
    else
      TDBXPlatform.CopyWideStringBuilder(FWideStringBuilder, FWideString);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FWideString;
end;

{ TDBXInt16Value }


procedure TDBXInt16Value.SetInt16(const Value: SmallInt);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FInt16 := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

function TDBXInt16Value.Compare(Other: TDBXValue): Smallint;
begin
  if AsInt16 = Other.AsInt16 then
    Result := 0
  else if AsInt16 < Other.AsInt16 then
    Result := -1
  else
    Result := 1
end;

procedure TDBXInt16Value.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetInt16(Self, GetInt16);
end;

procedure TDBXInt16Value.SetRowValue;
begin
  FDbxRow.SetInt16(Self, FInt16);
end;

procedure TDBXInt16Value.SetAsBcd(const Value: TBcd);
var
  IntValue: Integer;
begin
  IntValue := BcdToInteger(Value);
  if (IntValue <= High(SmallInt)) and (IntValue >= Low(SmallInt)) then
    SetInt16(IntValue)
  else
    inherited;
end;

procedure TDBXInt16Value.SetAsBoolean(const Value: Boolean);
begin
  SetInt16(Ord(Value));
end;

procedure TDBXInt16Value.SetAsDouble(const Value: Double);
begin
  if (Value <= High(SmallInt)) and (Value >= Low(SmallInt)) then
    SetInt16(Round(Value))
  else
    inherited;
end;

procedure TDBXInt16Value.SetAsInt16(const Value: Smallint);
begin
  SetInt16(Value);
end;

procedure TDBXInt16Value.SetAsInt32(const Value: TInt32);
begin
  if (Value <= High(SmallInt)) and (Value >= Low(SmallInt)) then
    SetInt16(Value)
  else
    inherited;
end;

procedure TDBXInt16Value.SetAsInt64(const Value: Int64);
begin
  if (Value <= High(SmallInt)) and (Value >= Low(SmallInt)) then
    SetInt16(Value)
  else
    inherited;
end;

procedure TDBXInt16Value.SetAsInt8(const Value: ShortInt);
begin
  SetInt16(Value);
end;

procedure TDBXInt16Value.SetAsSingle(const Value: Single);
begin
  if (Value <= High(SmallInt)) and (Value >= Low(SmallInt)) then
    SetInt16(Round(Value))
  else
    inherited;
end;

procedure TDBXInt16Value.SetAsString(const Value: string);
var
  IntValue: Integer;
begin
  IntValue := StrToInt(Value);
  if (IntValue <= High(SmallInt)) and (IntValue >= Low(Smallint)) then
    SetInt16(IntValue)
  else
    inherited;
end;

procedure TDBXInt16Value.SetAsUInt16(const Value: Word);
begin
  if Value < Word(High(SmallInt)) then
    SetInt16(Value)
  else
    inherited;
end;

procedure TDBXInt16Value.SetAsUInt8(const Value: Byte);
begin
  SetInt16(Value);
end;

procedure TDBXInt16Value.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetInt16(Value.GetAsInt16)
end;

function TDBXInt16Value.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetInt16(Self, FInt16, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

function TDBXInt16Value.GetAsBcd: TBcd;
begin
  Result := IntegerToBcd(GetInt16);
end;

function TDBXInt16Value.GetAsBoolean: Boolean;
begin
  Result := GetInt16 <> 0;
end;

function TDBXInt16Value.GetAsDouble: Double;
begin
  Result := GetInt16;
end;

function TDBXInt16Value.GetAsInt16: SmallInt;
begin
  Result := GetInt16;
end;

function TDBXInt16Value.GetAsInt32: TInt32;
begin
  Result := GetInt16;
end;

function TDBXInt16Value.GetAsInt64: Int64;
begin
  Result := GetInt16;
end;

function TDBXInt16Value.GetAsInt8: ShortInt;
begin
  Result := GetInt16;
end;

function TDBXInt16Value.GetAsSingle: Single;
begin
  Result := GetInt16;
end;

function TDBXInt16Value.GetAsString: string;
begin
  Result := IntToStr(GetInt16);
end;

function TDBXInt16Value.GetAsUInt16: Word;
begin
  Result := GetInt16;
end;

function TDBXInt16Value.GetAsUInt8: Byte;
begin
  Result := GetInt16;
end;

function TDBXInt16Value.GetInt16: SmallInt;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetInt16(Self, FInt16, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FInt16;
end;

{ TDBXInt32Value }


procedure TDBXInt32Value.SetAsBcd(const Value: TBcd);
begin
  SetInt32(BcdToInteger(Value));
end;

procedure TDBXInt32Value.SetAsBoolean(const Value: Boolean);
begin
  SetInt32(Ord(Value));
end;

procedure TDBXInt32Value.SetAsDouble(const Value: Double);
begin
  if (Value <= High(TInt32)) and (Value >= Low(TInt32)) then
    SetInt32(Round(Value))
  else
    inherited;
end;

procedure TDBXInt32Value.SetAsInt16(const Value: SmallInt);
begin
  SetInt32(Value);
end;

procedure TDBXInt32Value.SetAsInt32(const Value: TInt32);
begin
  SetInt32(Value);
end;

procedure TDBXInt32Value.SetAsInt64(const Value: Int64);
begin
  if (Value <= High(TInt32)) and (Value >= Low(TInt32)) then
    SetInt32(Value)
  else
    inherited;
end;

procedure TDBXInt32Value.SetAsInt8(const Value: ShortInt);
begin
  SetInt32(Value);
end;

procedure TDBXInt32Value.SetAsSingle(const Value: Single);
begin
  if (Value <= High(TInt32)) and (Value >= Low(TInt32)) then
    SetInt32(Round(Value))
  else
    inherited;
end;

procedure TDBXInt32Value.SetAsString(const Value: string);
begin
  SetInt32(StrToInt(Value));
end;

procedure TDBXInt32Value.SetAsTime(const Value: TDBXTime);
begin
  SetInt32(Value);
end;

procedure TDBXInt32Value.SetAsUInt16(const Value: Word);
begin
  SetInt32(Value);
end;

procedure TDBXInt32Value.SetAsUInt8(const Value: Byte);
begin
  SetInt32(Value);
end;

procedure TDBXInt32Value.SetInt32(const Value: TInt32);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FInt32 := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

function TDBXInt32Value.Compare(Other: TDBXValue): Smallint;
begin
  if AsInt32 = Other.AsInt32 then
    Result := 0
  else if AsInt32 < Other.AsInt32 then
    Result := -1
  else
    Result := 1
end;

procedure TDBXInt32Value.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetInt32(Self, GetInt32);
end;

procedure TDBXInt32Value.SetRowValue;
begin
  FDbxRow.SetInt32(Self, FInt32);
end;

procedure TDBXInt32Value.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetInt32(Value.GetAsInt32);
end;

function TDBXInt32Value.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetInt32(Self, FInt32, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

function TDBXInt32Value.EqualsValue(Other: TDBXValue): Boolean;
begin
  Result := GetInt32 = Other.GetInt32;
end;

function TDBXInt32Value.GetAsBcd: TBcd;
begin
  Result := IntegerToBcd(GetInt32);
end;

function TDBXInt32Value.GetAsBoolean: Boolean;
begin
  Result := GetInt32 <> 0;
end;

function TDBXInt32Value.GetAsDouble: Double;
begin
  Result := GetInt32;
end;

function TDBXInt32Value.GetAsInt16: SmallInt;
begin
  Result := GetInt32;
end;

function TDBXInt32Value.GetAsInt32: TInt32;
begin
  Result := GetInt32;
end;

function TDBXInt32Value.GetAsInt64: Int64;
begin
  Result := GetInt32;
end;

function TDBXInt32Value.GetAsInt8: ShortInt;
begin
  Result := GetInt32;
end;

function TDBXInt32Value.GetAsSingle: Single;
begin
  Result := GetInt32;
end;

function TDBXInt32Value.GetAsString: string;
begin
  Result := IntToStr(GetInt32);
end;

function TDBXInt32Value.GetAsTime: TDBXTime;
begin
  Result := GetInt32;
end;

function TDBXInt32Value.GetAsUInt16: Word;
begin
  Result := GetInt32;
end;

function TDBXInt32Value.GetAsUInt8: Byte;
begin
  Result := GetInt32;
end;

function TDBXInt32Value.GetInt32: TInt32;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetInt32(Self, FInt32, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FInt32;
end;

{ TDBXInt64Value }


procedure TDBXInt64Value.SetAsBcd(const Value: TBcd);
var
  Int64Value: Int64;
begin
  Int64Value := BcdToInteger(Value);
  if (Int64Value <= High(Int64)) and (Int64Value >= Low(Int64)) then
    SetInt64(Int64Value)
  else
    inherited;
end;

procedure TDBXInt64Value.SetAsBoolean(const Value: Boolean);
begin
  SetInt64(Ord(Value));
end;

procedure TDBXInt64Value.SetAsDouble(const Value: Double);
begin
  if (Value <= High(Int64)) and (Value >= Low(Int64)) then
    SetInt64(Round(Value))
  else
    inherited;
end;

procedure TDBXInt64Value.SetAsInt16(const Value: SmallInt);
begin
  SetInt64(Value);
end;

procedure TDBXInt64Value.SetAsInt32(const Value: TInt32);
begin
  SetInt64(Value);
end;

procedure TDBXInt64Value.SetAsInt64(const Value: Int64);
begin
  SetInt64(Value);
end;

procedure TDBXInt64Value.SetAsInt8(const Value: ShortInt);
begin
  SetInt64(Value);
end;

procedure TDBXInt64Value.SetAsSingle(const Value: Single);
begin
  if (Value <= High(Int64)) and (Value >= Low(Int64)) then
    SetInt64(Round(Value))
  else
    inherited;
end;

procedure TDBXInt64Value.SetAsString(const Value: string);
begin
  SetInt64(StrToInt64(Value));
end;

procedure TDBXInt64Value.SetAsUInt16(const Value: Word);
begin
  SetInt64(Value);
end;

procedure TDBXInt64Value.SetAsUInt8(const Value: Byte);
begin
  SetInt64(Value);
end;

procedure TDBXInt64Value.SetInt64(const Value: Int64);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FInt64 := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

function TDBXInt64Value.Compare(Other: TDBXValue): Smallint;
begin
  if AsInt64 = Other.AsInt64 then
    Result := 0
  else if AsInt64 < Other.AsInt64 then
    Result := -1
  else
    Result := 1
end;

procedure TDBXInt64Value.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetInt64(Self, GetInt64);
end;

function TDBXInt64Value.EqualsValue(Other: TDBXValue): Boolean;
begin
  Result := GetInt64 = Other.GetInt64;
end;

procedure TDBXInt64Value.SetRowValue;
begin
  FDbxRow.SetInt64(Self, FInt64);
end;

procedure TDBXInt64Value.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetInt64(Value.getAsInt64);
end;

function TDBXInt64Value.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetInt64(Self, FInt64, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

function TDBXInt64Value.GetAsBcd: TBcd;
begin
  Result := IntegerToBcd(GetInt64);
end;

function TDBXInt64Value.GetAsBoolean: Boolean;
begin
  Result := GetInt64 <> 0;
end;

function TDBXInt64Value.GetAsDouble: Double;
begin
  Result := GetInt64;
end;

function TDBXInt64Value.GetAsInt16: SmallInt;
begin
  Result := GetInt64;
end;

function TDBXInt64Value.GetAsInt32: TInt32;
begin
  Result := GetInt64;
end;

function TDBXInt64Value.GetAsInt64: Int64;
begin
  Result := GetInt64;
end;

function TDBXInt64Value.GetAsInt8: ShortInt;
begin
  Result := GetInt64;
end;

function TDBXInt64Value.GetAsSingle: Single;
begin
  Result := GetInt64;
end;

function TDBXInt64Value.GetAsString: string;
begin
  Result := IntToStr(GetInt64);
end;

function TDBXInt64Value.GetAsUInt16: Word;
begin
  Result := GetInt64;
end;

function TDBXInt64Value.GetAsUInt8: Byte;
begin
  Result := GetInt64;
end;

function TDBXInt64Value.GetInt64: Int64;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetInt64(Self, FInt64, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FInt64;
end;

{ TDBXSingleValue }

function TDBXSingleValue.Compare(Other: TDBXValue): Smallint;
begin
  if AsSingle = Other.AsSingle then
    Result := 0
  else if AsSingle < Other.AsSingle then
    Result := -1
  else
    Result := 1
end;

procedure TDBXSingleValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetSingle(Self, GetSingle);
end;

procedure TDBXSingleValue.SetAsBcd(const Value: TBcd);
begin
  SetSingle(BcdToDouble(Value));
end;

procedure TDBXSingleValue.SetAsBoolean(const Value: Boolean);
begin
  SetSingle(Ord(Value));
end;

procedure TDBXSingleValue.SetAsDouble(const Value: Double);
begin
  SetSingle(Value);
end;

procedure TDBXSingleValue.SetAsInt16(const Value: SmallInt);
begin
  SetSingle(Value);
end;

procedure TDBXSingleValue.SetAsInt32(const Value: TInt32);
begin
  SetSingle(Value);
end;

procedure TDBXSingleValue.SetAsInt64(const Value: Int64);
begin
  SetSingle(Value);
end;

procedure TDBXSingleValue.SetAsInt8(const Value: ShortInt);
begin
  SetSingle(Value);
end;

procedure TDBXSingleValue.SetAsSingle(const Value: Single);
begin
  SetSingle(Value);
end;

procedure TDBXSingleValue.SetAsString(const Value: string);
begin
  SetSingle(StrToFloat(Value));
end;

procedure TDBXSingleValue.SetAsUInt16(const Value: Word);
begin
  SetSingle(Value);
end;

procedure TDBXSingleValue.SetAsUInt8(const Value: Byte);
begin
  SetSingle(Value);
end;

procedure TDBXSingleValue.SetRowValue;
begin
  FDbxRow.SetSingle(Self, FSingle);
end;

function TDBXSingleValue.GetAsBcd: TBcd;
begin
  Result := DoubleToBcd(GetSingle);
end;

function TDBXSingleValue.GetAsBoolean: Boolean;
begin
  Result := GetSingle <> 0;
end;

function TDBXSingleValue.GetAsDouble: Double;
begin
  Result := GetSingle;
end;

function TDBXSingleValue.GetAsInt16: SmallInt;
begin
  Result := Round(GetSingle);
end;

function TDBXSingleValue.GetAsInt32: TInt32;
begin
  Result := Round(GetSingle);
end;

function TDBXSingleValue.GetAsInt64: Int64;
begin
  Result := Round(GetSingle);
end;

function TDBXSingleValue.GetAsInt8: ShortInt;
begin
  Result := Round(GetSingle);
end;

function TDBXSingleValue.GetAsSingle: Single;
begin
  Result := GetSingle;
end;

function TDBXSingleValue.GetAsString: string;
begin
  Result := FloatToStr(GetSingle);
end;

function TDBXSingleValue.GetAsUInt16: Word;
begin
  Result := Round(GetSingle);
end;

function TDBXSingleValue.GetAsUInt8: Byte;
begin
  Result := Round(GetSingle);
end;

function TDBXSingleValue.GetSingle: Single;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetSingle(Self, FSingle, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FSingle;
end;

function TDBXSingleValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetSingle(Self, FSingle, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

procedure TDBXSingleValue.SetSingle(const Value: Single);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FSingle := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXSingleValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetSingle(Value.GetSingle);
end;

{ TDBXDoubleValue }


procedure TDBXDoubleValue.SetAsBcd(const Value: TBcd);
begin
  SetDouble(BcdToDouble(Value));
end;

procedure TDBXDoubleValue.SetAsBoolean(const Value: Boolean);
begin
  SetDouble(Ord(Value));
end;

procedure TDBXDoubleValue.SetAsDouble(const Value: Double);
begin
  SetDouble(Value);
end;

procedure TDBXDoubleValue.SetAsInt16(const Value: SmallInt);
begin
  SetDouble(Value);
end;

procedure TDBXDoubleValue.SetAsInt32(const Value: TInt32);
begin
  SetDouble(Value);
end;

procedure TDBXDoubleValue.SetAsInt64(const Value: Int64);
begin
  SetDouble(Value);
end;

procedure TDBXDoubleValue.SetAsInt8(const Value: ShortInt);
begin
  SetDouble(Value);
end;

procedure TDBXDoubleValue.SetAsSingle(const Value: Single);
begin
  SetDouble(Value);
end;

procedure TDBXDoubleValue.SetAsString(const Value: string);
begin
  SetDouble(StrToFloatDef(Value, 0));
end;

procedure TDBXDoubleValue.SetAsUInt16(const Value: Word);
begin
  SetDouble(Value);
end;

procedure TDBXDoubleValue.SetAsUInt8(const Value: Byte);
begin
  SetDouble(Value);
end;

procedure TDBXDoubleValue.SetDouble(const Value: Double);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FDouble := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

function TDBXDoubleValue.Compare(Other: TDBXValue): Smallint;
begin
  if AsDouble = Other.AsDouble then
    Result := 0
  else if AsDouble < Other.AsDouble then
    Result := -1
  else
    Result := 1
end;

procedure TDBXDoubleValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetDouble(Self, GetDouble);
end;

procedure TDBXDoubleValue.SetRowValue;
begin
  FDbxRow.SetDouble(Self, FDouble);
end;

procedure TDBXDoubleValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetDouble(Value.GetDouble);
end;

function TDBXDoubleValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetDouble(Self, FDouble, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

function TDBXDoubleValue.GetAsBcd: TBcd;
begin
  Result := DoubleToBcd(GetDouble);
end;

function TDBXDoubleValue.GetAsBoolean: Boolean;
begin
  Result := GetDouble <> 0;
end;

function TDBXDoubleValue.GetAsDouble: Double;
begin
  Result := GetDouble;
end;

function TDBXDoubleValue.GetAsInt16: SmallInt;
begin
  Result := Round(GetDouble);
end;

function TDBXDoubleValue.GetAsInt32: TInt32;
begin
  Result := Round(GetDouble);
end;

function TDBXDoubleValue.GetAsInt64: Int64;
begin
  Result := Round(GetDouble);
end;

function TDBXDoubleValue.GetAsInt8: ShortInt;
begin
  Result := Round(GetDouble);
end;

function TDBXDoubleValue.GetAsSingle: Single;
begin
  Result := GetDouble;
end;

function TDBXDoubleValue.GetAsString: string;
begin
  Result := FloatToStr(GetDouble);
end;

function TDBXDoubleValue.GetAsUInt16: Word;
begin
  Result := Round(GetDouble);
end;

function TDBXDoubleValue.GetAsUInt8: Byte;
begin
  Result := Round(GetDouble);
end;

function TDBXDoubleValue.GetDouble: Double;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetDouble(Self, FDouble, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FDouble;
end;

{ TDBXByteArrayValue }

constructor TDBXByteArrayValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
  FNullGeneration := -1;
end;

destructor TDBXByteArrayValue.Destroy;
begin
  FBytes := nil;
  FOverFlowBytes.Free;
  inherited;
end;

function TDBXByteArrayValue.GetBytes(Offset: Int64; const Buffer: TArray<Byte>;
  BufferOffset, Length: Int64): Int64;
//var
//  MaxBytes: Int64;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    Result := 0;
    if (FNullGeneration <> FDbxRow.Generation) or (not FIsNull) and (Length > 0) then
      FDbxRow.GetBytes(Self, Offset, Buffer, BufferOffset, Length, Result, FIsNull);
    // Read every time.  Some classe "memo" class extensions will save this off
    // in fbytes and then set the generation.  At this point nothing has been
    // saved, so force a read on next call by not setting the generation.
    //
    FNullGeneration := FDbxRow.Generation;
    if FIsNull then
      FGeneration := FNullGeneration;
  end else if FSetPending then
  begin
    Result := Length;
    if Result > FByteLength then
      Result := FByteLength;
    TDBXPlatform.CopyByteArray(FBytes, FBufferOffset, Buffer, BufferOffset, Result);
  end else if Assigned(FBytes) and (FByteLength > -1) then
  begin
//    MaxBytes := Length;
//    if MaxBytes > FByteLength then
//      MaxBytes := FByteLength;
    TDBXPlatform.CopyByteArray(FBytes, 0, Buffer, BufferOffset, Length);
    Result := FByteLength;
  end else
    Result := 0;
end;



function TDBXByteArrayValue.GetStreamReader: TDBXStreamReader;
begin
  Result := FOverFlowBytes;
end;

procedure TDBXByteArrayValue.SetStaticBytes(Offset: Int64;
  const Buffer: array of Byte; BufferOffset, Length: Int64);
begin
  FIsNull := false;
  FOffset       := Offset;
  SetLength(FBytes, Length);
  Move(Buffer[BufferOffset], FBytes[Offset], Length);
  FBufferOffset := BufferOffset;
  FByteLength   := Length;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXStreamValue.SetAsVariant(const Value: OleVariant);
var
  Stream: TStream;
  StreamSize: Integer;
begin
  if VarIsNull(Value) then
    SetNull
  else
  begin
    Stream := TMemoryStream.Create;
    Stream.Size := FLastSize;
    Data.DSUtil.VariantToStream(Value, Stream);
    try
      SetStream(Stream, true);
      StreamSize := Stream.Position;
      if (FLastSize < StreamSize) and (StreamSize < $2000) then
        FLastSize := StreamSize;
      Stream := nil;
    finally
      Stream.Free;
    end;
  end;
end;

procedure TDBXStreamValue.SetValue(const Value: TDBXValue);
//var
//  Bytes:        TArray<Byte>;
//  ValueSize:    Int64;
//  SourceValue:  TDBXStreamValue;
begin
  if Value.IsNull then
    SetNull
  else
  begin
    SetStream(Value.GetStream(False), True);

//    SourceValue := (Value as TDBXStreamValue);
//    if SourceValue.FStreamStreamReader <> nil then
//      SetStream(GetStream, False)
//    else
//    begin
//      ValueSize := Value.GetValueSize;
//      SetLength(Bytes, ValueSize);
//      Value.GetBytes(0, Bytes, 0, Length(Bytes));
//      SetDynamicBytes(0, Bytes, 0, Length(Bytes));
//    end;
  end;
end;

procedure TDBXByteArrayValue.SetDynamicBytes(Offset: Int64; const Buffer: TArray<Byte>;
  BufferOffset, Length: Int64);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FOffset       := Offset;
  FBytes        := Buffer;
  FBufferOffset := BufferOffset;
  FByteLength   := Length;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FNullGeneration := FGeneration;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXByteArrayValue.SetOverflowBytes(const OverFlowBytes: TDBXStreamReader);
begin
  FreeAndNil(FOverFlowBytes);
  FOverFlowBytes := OverFlowBytes;
end;

//procedure TDBXByteArrayValue.CopyRowValue(Row: TDBXRow);
//var
//  Bytes: TArray<Byte>;
//begin
//  if IsNull then
//    Row.SetNull(Self)
//  else
//  begin
//    SetLength(Bytes, FByteLength);
//    GetBytes(0, Bytes, 0, FByteLength);
//    Row.SetDynamicBytes(Self, 0, Bytes, 0, FByteLength);
//  end;
//end;

procedure TDBXByteArrayValue.SetRowValue;
begin
  FDbxRow.SetDynamicBytes(Self, FOffset, FBytes, FBufferOffset, FByteLength);
end;

function TDBXByteArrayValue.GetValueSize: Int64;
begin
  if IsNull then
    Result := -1
  else
    Result := FByteLength;
end;

function TDBXByteArrayValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FNullGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetByteLength(Self, FByteLength, FIsNull);
    FNullGeneration := FDbxRow.Generation;
    if FIsNull then
      FGeneration := FNullGeneration;
  end;
  Result := FIsNull;
end;

{ TDBXTimeStampValue }


function TDBXTimeStampValue.Compare(Other: TDBXValue): Smallint;
begin
  if AsDateTime = Other.AsDateTime then
    Result := 0
  else if AsDateTime < Other.AsDateTime then
    Result := -1
  else
    Result := 1
end;

procedure TDBXTimeStampValue.CopyRowValue(Row: TDBXRow);
var
  Value: TSQLTimeStamp;
begin
  if IsNull then
    Row.SetNull(Self)
  else
  begin
    Value := GetTimeStamp;
    Row.SetTimestamp(Self, Value);
  end;
end;

procedure TDBXTimeStampValue.SetRowValue;
begin
  FDbxRow.SetTimestamp(Self, FTimeStamp);
end;

procedure TDBXTimeStampValue.SetTimeStamp(const Value: TSQLTimeStamp);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FTimeStamp := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXTimeStampValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetTimeStamp(Value.GetTimeStamp);
end;

function TDBXTimeStampValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetTimeStamp(Self, FTimeStamp, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

function TDBXTimeStampValue.GetAsDate: TDBXDate;
begin
  Result := DateTimeToTimeStamp(SQLTimeStampToDateTime(GetTimeStamp)).Date;
end;


function TDBXTimeStampValue.GetAsDateTime: TDateTime;
begin
  Result := SQLTimeStampToDateTime(GetTimeStamp);
end;

function TDBXTimeStampValue.GetAsString: string;
begin
  Result := TDBXDefaultFormatter.GetDefaultDBXFormatter.TimestampToString(Self);
end;

function TDBXTimeStampValue.GetAsTime: TDBXTime;
begin
  Result := DateTimeToTimeStamp(SQLTimeStampToDateTime(GetTimeStamp)).Time;
end;

function TDBXTimeStampValue.GetAsTimeStamp: TSQLTimeStamp;
begin
  Result := GetTimeStamp;
end;

procedure TDBXTimeStampValue.SetAsDate(const Value: TDBXDate);
var
  Time: TTimeStamp;
begin
  Time.Time := 0;
  Time.Date := Value;
  SetTimeStamp(DateTimeToSQLTimeStamp(TimeStampToDateTime(Time)));
end;


procedure TDBXTimeStampValue.SetAsDateTime(const Value: TDateTime);
begin
  SetTimeStamp(DateTimeToSQLTimeStamp(Value));
end;

procedure TDBXTimeStampValue.SetAsString(const Value: string);
begin
  TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToTimestamp(Value, Self);
end;

procedure TDBXTimeStampValue.SetAsTime(const Value: TDBXTime);
var
  Time: TTimeStamp;
begin
  Time.Time := Value;
  Time.Date := DateDelta;
  SetTimeStamp(DateTimeToSQLTimeStamp(TimeStampToDateTime(Time)));
end;

procedure TDBXTimeStampValue.SetAsTimestamp(const Value: TSQLTimeStamp);
begin
  SetTimeStamp(Value);
end;

function TDBXTimeStampValue.GetTimeStamp: TSQLTimeStamp;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetTimeStamp(Self, FTimeStamp, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FTimeStamp;
end;

{ TDBXBcdValue }


procedure TDBXBcdValue.SetAsSingle(const Value: Single);
begin
  SetBcd(DoubleToBcd(Value));
end;

procedure TDBXBcdValue.SetAsString(const Value: string);
begin
  TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToBcd(Value, Self);
end;

procedure TDBXBcdValue.SetAsUInt16(const Value: Word);
begin
  SetBcd(IntegerToBcd(Value));
end;

procedure TDBXBcdValue.SetAsUInt8(const Value: Byte);
begin
  SetBcd(IntegerToBcd(Value));
end;

procedure TDBXBcdValue.SetAsBcd(const Value: TBcd);
begin
  SetBcd(Value);
end;

procedure TDBXBcdValue.SetAsBoolean(const Value: Boolean);
begin
  SetBcd(IntegerToBcd(Ord(Value)));
end;

procedure TDBXBcdValue.SetAsDouble(const Value: Double);
begin
  SetBcd(DoubleToBcd(Value));
end;

procedure TDBXBcdValue.SetAsInt16(const Value: SmallInt);
begin
  SetBcd(IntegerToBcd(Value));
end;

procedure TDBXBcdValue.SetAsInt32(const Value: TInt32);
begin
  SetBcd(IntegerToBcd(Value));
end;

procedure TDBXBcdValue.SetAsInt64(const Value: Int64);
begin
  SetBcd(IntegerToBcd(Value));
end;

procedure TDBXBcdValue.SetAsInt8(const Value: ShortInt);
begin
  SetBcd(IntegerToBcd(Value));
end;

procedure TDBXBcdValue.SetBcd(const Value: TBcd);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FBcd := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

function TDBXBcdValue.Compare(Other: TDBXValue): Smallint;
begin
  Result := BCDCompare(AsBcd, Other.AsBcd);
end;

procedure TDBXBcdValue.CopyRowValue(Row: TDBXRow);
var
  Value: TBcd;
begin
  if IsNull then
    Row.SetNull(Self)
  else
  begin
    Value := GetBcd;
    Row.SetBCD(Self, Value);
  end;
end;

procedure TDBXBcdValue.SetRowValue;
begin
  FDbxRow.SetBCD(Self, FBcd);
end;

procedure TDBXBcdValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetBcd(Value.GetBcd);
end;

function TDBXBcdValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetBcd(Self, FBcd, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

function TDBXBcdValue.GetAsBcd: TBcd;
begin
  Result := GetBcd;
end;

function TDBXBcdValue.GetAsBoolean: Boolean;
begin
  Result := BcdToStr(GetBcd) <> '0';
end;

function TDBXBcdValue.GetAsDouble: Double;
begin
  Result := BcdToDouble(GetBcd);
end;

function TDBXBcdValue.GetAsInt16: SmallInt;
begin
  Result := BcdToInteger(GetBcd);
end;

function TDBXBcdValue.GetAsInt32: TInt32;
begin
  Result := BcdToInteger(GetBcd);
end;

function TDBXBcdValue.GetAsInt64: Int64;
begin
  Result := BcdToInteger(GetBcd);
end;

function TDBXBcdValue.GetAsInt8: ShortInt;
begin
  Result := BcdToInteger(GetBcd);
end;

function TDBXBcdValue.GetAsSingle: Single;
begin
  Result := BcdToDouble(GetBcd);
end;

function TDBXBcdValue.GetAsString: string;
begin
  Result := TDBXDefaultFormatter.GetDefaultDBXFormatter.BcdToString(Self);
end;

function TDBXBcdValue.GetAsUInt16: Word;
begin
  Result := BcdToInteger(GetBcd);
end;

function TDBXBcdValue.GetAsUInt8: Byte;
begin
  Result := BcdToInteger(GetBcd);
end;

function TDBXBcdValue.GetBcd: TBcd;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetBcd(Self, FBcd, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FBcd;
end;


{ TDBXClosedByteReader }

constructor TDBXClosedByteReader.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
end;

procedure TDBXClosedByteReader.GetBcd(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

function TDBXClosedByteReader.GetBytes(Ordinal: TInt32; Offset: Int64;
  const Value: TArray<Byte>; ValueOffset, Length: Int64;
  var IsNull: LongBool): Int64;
begin
  InvalidOperation;
  Result := 0;
end;

procedure TDBXClosedByteReader.GetByteLength(Ordinal: TInt32; var Length: Int64;
  var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetDate(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetDouble(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;


procedure TDBXClosedByteReader.GetInt16(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetInt32(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetInt64(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetInt8(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetSingle(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

{$IFNDEF NEXTGEN}
procedure TDBXClosedByteReader.GetAnsiString(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;
{$ENDIF !NEXTGEN}

procedure TDBXClosedByteReader.GetTime(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetTimeStamp(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetTimeStampOffset(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.GetWideString(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  InvalidOperation;
end;

procedure TDBXClosedByteReader.InvalidOperation;
begin
  FDBXContext.Error(TDBXErrorCodes.NoData, SReaderClosed);
end;

{ TDBXRow }

procedure TDBXRow.ClearParameters;
begin

end;

constructor TDBXRow.Create(DBXContext: TDBXContext);
begin
  inherited Create;
  FDBXContext := DBXContext;
  FGeneration := -1;
end;


procedure TDBXRow.GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetBoolean(DbxValue: TDBXBooleanValue; var Value,
  IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetByteLength(DbxValue: TDBXByteArrayValue;
  var ByteLength: Int64; var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Length: Int64; var ReturnLength: Int64;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetDouble(DbxValue: TDBXDoubleValue; var Value: Double;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

function TDBXRow.GetGeneration: TInt32;
begin
  exit(FGeneration);
end;

procedure TDBXRow.GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

function TDBXRow.GetObjectTypeName(Ordinal: TInt32): string;
begin
  NotImplemented;
end;

procedure TDBXRow.GetDBXConnection(DbxValue: TDBXConnectionValue;
  var Value: TDBXConnection; var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetDBXReader(DbxValue: TDBXReaderValue; var Value: TDBXReader;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetStream(DbxValue: TDBXStreamValue; var Stream: TStream;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetJSONValue(DbxValue: TDBXJSONValue; var Value: TJSONValue; var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.SetJSONValue(DbxValue: TDBXJSONValue; Value: TJSONValue);
begin
  NotImplemented;
end;

procedure TDBXRow.GetCallbackValue(DbxValue: TDBXCallbackValue; var Value: TDBXCallback; var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.SetCallbackValue(DbxValue: TDBXCallbackValue; Value: TDBXCallback);
begin
  NotImplemented;
end;

function TDBXRow.IsStoredNull(DbxValue: TDBXValue): Boolean;
begin
  NotImplemented;
  Result := false;
end;

function TDBXRow.CreateCustomValue(const ValueType: TDBXValueType): TDBXValue;
begin
  Result := nil;
end;


procedure TDBXRow.GetLength(DbxValue: TDBXValue; var ByteLength: Int64;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetSingle(DbxValue: TDBXSingleValue; var Value: Single;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetStream(DbxValue: TDBXWideStringValue; var Stream: TStream;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetStream(DbxValue: TDBXAnsiStringValue; var Stream: TStream;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetStreamBytes(DbxValue: TDBXStreamValue;
  const Buffer: TArray<Byte>; BufferOffset, Length, ReturnLength: Int64;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetStreamLength(DbxValue: TDBXStreamValue;
  StreamLength: Int64; var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetAnsiString(DbxValue: TDBXAnsiStringValue;
  var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetTimeStamp(DbxValue: TDBXTimeStampValue;
  var Value: TSQLTimeStamp; var IsNull: LongBool);
begin
  NotImplemented;
end;


procedure TDBXRow.GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue;
  var Value: TSQLTimeStampOffset; var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetWideChars(DbxValue: TDBXWideStringValue;
  var WideChars: TDBXWideChars; var Count: Integer;  var IsNull: LongBool);
begin
  NotImplemented;
end;
procedure TDBXRow.GetWideString(DbxValue: TDBXWideStringValue;
  var Value: string; var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetAnsiChars(DbxValue: TDBXAnsiStringValue;
  var AnsiChars: TDBXAnsiChars; var Count: Integer;  var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.GetWideString(DbxValue: TDBXWideStringValue;
  var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool);
begin
  NotImplemented;
end;

procedure TDBXRow.NotImplemented;
var
  DBXError: TDBXError;
begin
  if FDBXContext = nil then
  begin
    DBXError := TDBXError.Create(TDBXErrorCodes.NotImplemented, sNotImplemented);
    raise DBXError;
  end
  else
    FDBXContext.Error(TDBXErrorCodes.NotImplemented, sNotImplemented)
end;

procedure TDBXRow.NewRowGeneration;
begin
  inc(FGeneration);
end;

procedure TDBXRow.SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd);
begin
  NotImplemented;
end;

procedure TDBXRow.SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean);
begin
  NotImplemented;
end;

procedure TDBXRow.SetDate(DbxValue: TDBXDateValue; Value: TDBXDate);
begin
  NotImplemented;
end;

procedure TDBXRow.SetDouble(DbxValue: TDBXDoubleValue; Value: Double);
begin
  NotImplemented;
end;

procedure TDBXRow.SetDynamicBytes(DbxValue: TDBXValue; Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Length: Int64);
begin
  NotImplemented;
end;

procedure TDBXRow.SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt);
begin
  NotImplemented;
end;

procedure TDBXRow.SetInt32(DbxValue: TDBXInt32Value; Value: TInt32);
begin
  NotImplemented;
end;

procedure TDBXRow.SetInt64(DbxValue: TDBXInt64Value; Value: Int64);
begin
  NotImplemented;
end;

procedure TDBXRow.SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt);
begin
  NotImplemented;
end;

procedure TDBXRow.SetNull(DbxValue: TDBXValue);
begin
  NotImplemented;
end;

procedure TDBXRow.SetDBXConnection(DbxValue: TDBXConnectionValue;
  Value: TDBXConnection);
begin
  NotImplemented;
end;

procedure TDBXRow.SetDBXReader(DbxValue: TDBXReaderValue; Value: TDBXReader);
begin
  NotImplemented;
end;

procedure TDBXRow.SetSingle(DbxValue: TDBXSingleValue; Value: Single);
begin
  NotImplemented;
end;

procedure TDBXRow.SetStream(DbxValue: TDBXStreamValue; StreamReader: TDBXStreamReader);
begin
  NotImplemented;
end;

procedure TDBXRow.SetWideChars(DbxValue: TDBXWideStringValue;
  const Value: string);
begin
  SetWideString(DbxValue, Value);
end;

procedure TDBXRow.SetWideMemo(DbxValue: TDBXWideMemoValue;
  const Value: string);
begin
  NotImplemented;
end;

{$IFNDEF NEXTGEN}
procedure TDBXRow.SetAnsiChars(DbxValue: TDBXAnsiStringValue;
  const Value: AnsiString);
begin
  SetAnsiString(DbxValue, Value);
end;

procedure TDBXRow.SetAnsiMemo(DbxValue: TDBXAnsiMemoValue;
  const Value: AnsiString);
begin
  NotImplemented;
end;

procedure TDBXRow.SetString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString);
begin
  NotImplemented;
end;

procedure TDBXRow.SetAnsiString(DbxValue: TDBXAnsiStringValue;
  const Value: AnsiString);
begin
  NotImplemented;
end;
{$ELSE}
procedure TDBXRow.SetString(DbxValue: TDBXAnsiStringValue; const Value: string);
begin
  NotImplemented;
end;
{$ENDIF !NEXTGEN}

function TDBXRow.UseExtendedTypes: Boolean;
begin
  Result := false;
end;

procedure TDBXRow.ValueNotSet(const Value: TDBXWritableValue);
begin

end;

procedure TDBXRow.ValueSet(Value: TDBXWritableValue);
begin

end;

procedure TDBXRow.SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime);
begin
  NotImplemented;
end;

procedure TDBXRow.SetTimestamp(DbxValue: TDBXTimeStampValue;
  var Value: TSQLTimeStamp);
begin
  NotImplemented;
end;

procedure TDBXRow.SetTimestampOffset(DbxValue: TDBXTimeStampOffsetValue;
  var Value: TSQLTimeStampOffset);
begin
  NotImplemented;
end;

procedure TDBXRow.SetUInt16(DbxValue: TDBXUInt16Value; Value: Word);
begin
  NotImplemented;
end;

procedure TDBXRow.SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte);
begin
  NotImplemented;
end;

procedure TDBXRow.SetValueType(ValueType: TDBXValueType);
begin
  NotImplemented;
end;

procedure TDBXRow.SetWideString(DbxValue: TDBXWideStringValue;
  const Value: string);
begin
  NotImplemented;
end;

{ TDBXConnectionBuilder }

procedure TDBXConnectionBuilder.Assign(Source: TDBXConnectionBuilder);
begin
  FDBXContext          := TDBXContext.Create(Source.FDBXContext);
  FInputConnectionName := Source.FInputConnectionName;
  FInputUserName       := Source.FInputUserName;
  FInputPassword       := Source.FInputPassword;
  FConnectionFactory   := Source.FConnectionFactory;
  FInputConnectionProperties  := Source.FInputConnectionProperties;
  FDelegatePath               := Source.FDelegatePath;
end;

destructor TDBXConnectionBuilder.Destroy;
begin
  FDBXContext.Free;
  FDelegateDriver.Free;
  FDelegatePath.Free;
  inherited;
end;

constructor TDBXConnectionBuilder.Create(Source: TDBXConnectionBuilder);
begin
  inherited Create;
  Assign(Source);
end;

constructor TDBXConnectionBuilder.Create;
begin
  inherited;
end;

function TDBXConnectionBuilder.CreateConnection: TDBXConnection;
var
  DriverName:             string;
  DriverProperties:       TDBXProperties;
  ConnectionProperties:   TDBXProperties;
  NextConnectionBuilder:  TDBXConnectionBuilder;
  ClonedProperties:       TDBXProperties;

  function GetUpdatedDriverProperties: TDBXProperties;
  const
    DriverPropStrs: array[0..10] of string =
      (TDBXPropertyNames.DriverUnit, TDBXPropertyNames.DriverPackageLoader,
       TDBXPropertyNames.DriverAssemblyLoader, TDBXPropertyNames.MetaDataPackageLoader,
       TDBXPropertyNames.MetaDataAssemblyLoader, TDBXPropertyNames.GetDriverFunc,
       TDBXPropertyNames.LibraryName, TDBXPropertyNames.LibraryNameOsx,
       TDBXPropertyNames.VendorLib, TDBXPropertyNames.VendorLibWin64,
       TDBXPropertyNames.VendorLibOsx);
  var
    DriverPropStr: string;
    DriverPropIndex, Pos: Integer;
  begin
    Result := FConnectionFactory.GetDriverProperties(DriverName);
    for DriverPropStr in DriverPropStrs do
    begin
      DriverPropIndex := Result.Properties.IndexOfName(DriverPropStr);
      if (DriverPropIndex <> -1) then
      begin
        Pos := ConnectionProperties.Properties.IndexOfName(DriverPropStr);
        if Pos <> -1 then
          Result.Properties[DriverPropIndex] := DriverPropStr + '=' + ConnectionProperties.Properties.ValueFromIndex[Pos];
      end;
    end;
  end;

begin
  Result := nil;
  ClonedProperties := nil;
  ConnectionProperties := FDelegatePath.FProperties;
  DriverName := FConnectionFactory.GetDriverName(ConnectionProperties);

  if FConnectionFactory.FDrivers.ContainsKey(DriverName) then
    DriverProperties := GetUpdatedDriverProperties
  else
  begin
    DriverProperties := ConnectionProperties.Clone;
    ClonedProperties := DriverProperties;
  end;

  NextConnectionBuilder := TDBXConnectionBuilder.Create(Self);
  try
    NextConnectionBuilder.FDelegateDriver := FConnectionFactory.GetDriver(DriverName, DriverProperties);
    try
      Result := NextConnectionBuilder.FDelegateDriver.CreateConnection(NextConnectionBuilder);
      Result.ConnectionProperties.AddUniqueProperties(DriverProperties.Properties);
    except
      FreeAndNil(NextConnectionBuilder.FDelegateDriver);
      raise;
    end;
    //Gets taken by the TDBXConnection.Create.
    //
    NextConnectionBuilder.FDelegatePath.FProperties := nil;
  finally
    // Was borrowed in the constructor.
    //
    NextConnectionBuilder.FDelegatePath := nil;
    NextConnectionBuilder.FDelegateDriver := nil;
    NextConnectionBuilder.Free;
    ClonedProperties.Free;
  end;
end;

function TDBXConnectionBuilder.CreateDelegateeConnection: TDBXConnection;
var
  SaveDelegatePath:   TDBXDelegateItem;
begin
  SaveDelegatePath := FDelegatePath;
  FDelegatePath := FDelegatePath.FNext;
  try
    Result := CreateConnection;
  finally
    FDelegatePath := SaveDelegatePath;
  end;
end;


function TDBXConnectionBuilder.GetConnectionProperties: TDBXProperties;
begin
  Result := FDelegatePath.FProperties;
end;

function TDBXConnectionBuilder.GetDelegationSignature: string;
var
  DelegateItem: TDBXDelegateItem;
begin
  Result := FDelegatePath.FName;
  DelegateItem := FDelegatePath.FNext;;
  while DelegateItem <> nil do
  begin
    Result        := Result + '/' + DelegateItem.FName; { Do not localize }
    DelegateItem  := DelegateItem.FNext;
  end;
end;

{ TDBXDelegateItem }

destructor TDBXDelegateItem.Destroy;
begin
  FProperties.Free;
  FNext.Free;
  inherited;
end;

procedure TDBXDelegateItem.FreeProperties;
begin
  FreeAndNil(FProperties);
  if FNext <> nil then
    FNext.FreeProperties;
end;

{ TDBXPropertiesItem }

constructor TDBXPropertiesItem.Create(Properties: TDBXProperties);
begin
  inherited Create;
  FProperties := Properties;
end;

destructor TDBXPropertiesItem.Destroy;
begin
  FProperties.Free;
  FDeletgatePath.Free;
  inherited;
end;


{ TDBXReaderByteReader }

constructor TDBXReaderByteReader.Create(DBXContext: TDBXContext;
  DbxReader: TDBXReader);
begin
  inherited Create(DBXContext);
  FDbxReader := DbxReader;
end;

procedure TDBXReaderByteReader.GetBcd(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyBcd(ValueObject.GetBcd, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetByteLength(Ordinal: TInt32; var Length: Int64;
  var IsNull: LongBool);
begin
  isNull := FDbxReader.Value[Ordinal].IsNull;
  if not IsNull then
    Length := FDbxReader.Value[Ordinal].GetValueSize;
end;

function TDBXReaderByteReader.GetBytes(Ordinal: TInt32; Offset: Int64;
  const Value: TArray<Byte>; ValueOffset, Length: Int64;
  var IsNull: LongBool): Int64;
begin
  if FDBXReader.Value[Ordinal].IsNull then
  begin
    Result := -1;
    IsNull := True;
  end
  else
  begin
    Result := FDbxReader.Value[Ordinal].GetBytes(Offset, Value, ValueOffset, Length);
    IsNull := False;
  end;
end;

procedure TDBXReaderByteReader.GetDate(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyInt32(ValueObject.GetDate, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetDouble(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyInt64(TDBXPlatform.DoubleToInt64Bits(ValueObject.GetDouble), Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetInt16(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    if ValueObject.ValueType.DataType = TDBXDataTypes.BooleanType then
    begin
      if ValueObject.GetBoolean then
        TDBXPlatform.CopyInt16(1, Value, 0)
      else
        TDBXPlatform.CopyInt16(0, Value, 0);
    end
    else
      TDBXPlatform.CopyInt16(ValueObject.GetInt16, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetInt32(Ordinal: TInt32;
   const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyInt32(ValueObject.GetInt32, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetInt64(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyInt64(ValueObject.GetInt64, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetInt8(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyInt8(ValueObject.GetInt8, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetSingle(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyInt32(TDBXPlatform.SingleToInt32Bits(ValueObject.GetSingle), Value, 0);
  end;
end;

{$IFNDEF NEXTGEN}
procedure TDBXReaderByteReader.GetAnsiString(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  Index: Integer;
  LByte: Byte;
  AnsiStrValue: AnsiString;
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := True
  else
  begin
    IsNull := False;
    AnsiStrValue := FDbxReader[Ordinal].GetAnsiString;
    Index := Offset;
    for LByte in BytesOf(AnsiStrValue) do
    begin
      Value[Index] := LByte;
      Inc(Index);
    end;
    Value[Index] := Byte(0);
  end;
end;
{$ENDIF !NEXTGEN}

procedure TDBXReaderByteReader.GetTime(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyInt32(ValueObject.GetTime, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetTimeStamp(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopySqlTimeStamp(ValueObject.GetTimeStamp, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetTimeStampOffset(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopySqlTimeStampOffset(ValueObject.GetTimeStampOffset, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    if ValueObject.GetBoolean then
      TDBXPlatform.CopyUInt16(1, Value, 0)
    else
      TDBXPlatform.CopyUInt16(0, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyUInt8(ValueObject.GetUInt8, Value, 0);
  end;
end;

procedure TDBXReaderByteReader.GetWideString(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  Index: Integer;
  WideStringValue: string;
  Count: Integer;
  Ch: WideChar;
  ValueObject: TDBXValue;
begin
  // Need to optimize this in a cross platform way.
  // However, this particular method is not heavily used at this time.
  //
  ValueObject := FDbxReader[Ordinal];
  if ValueObject.IsNull then
    IsNull := True
  else
  begin
    IsNull := False;
    WideStringValue := FDbxReader[Ordinal].GetWideString;
    Count := WideStringValue.Length;
    Index := Offset;
    while Count > 0 do
    begin
      Ch := WideStringValue.Chars[Index div 2];
      Value[Index] := Byte(Ch);
      Inc(Index);
      Value[Index] := Byte(Integer(Ch) shr 8);
      Inc(Index);
      Dec(Count);
    end;
    Value[Index] := Byte(0);
    Value[Index+1] := Byte(0);
  end;
end;

{ TDBXDriverHelp }

class function TDBXDriverHelp.CreateTDBXContext: TDBXContext;
begin
  Result := TDBXContext.Create;
end;

class function TDBXDriverHelp.CreateTDBXParameter(
  DBXContext: TDBXContext): TDBXParameter;
begin
  Result := TDBXParameter.Create(DBXContext);
end;

class function TDBXDriverHelp.CreateTDBXProperties(
  DBXContext: TDBXContext): TDBXProperties;
begin
  Result := TDBXProperties.Create(DBXContext);
end;

class function TDBXDriverHelp.CreateTDBXValueType(
  DBXContext: TDBXContext): TDBXValueType;
begin
  Result := TDBXValueType.Create(DBXContext);
end;

class function TDBXDriverHelp.CreateTDBXValueType(
  DBXContext: TDBXContext; DBXRow: TDBXRow): TDBXValueType;
begin
  Result := TDBXValueType.Create(DBXContext);
  Result.FDbxRow := DBXRow;
end;


class function TDBXDriverHelp.GetConnection(
  ConnectionFactory: TDBXConnectionFactory; DBXContext: TDBXContext;
  ConnectionName: string): TDBXConnection;
begin
  Result := ConnectionFactory.GetConnection(DBXContext, ConnectionFactory.GetConnectionPropertiesItem(ConnectionName).FProperties);
end;

class function TDBXDriverHelp.GetMetaDataReader(
  Connection: TDBXConnection): TObject;
begin
  Result := Connection.FMetaDataReader;
end;

class function TDBXDriverHelp.GetNonDelegate(Value: TDBXValue): TDBXValue;
begin
  Result := Value.GetNonDelegate;
end;


class function TDBXDriverHelp.GetStreamReader(
  Value: TDBXValue): TDBXStreamReader;
begin
  Result := (TDBXDriverHelp.GetNonDelegate(Value) as TDBXWritableValue)
             .GetStreamReader;
end;

class function TDBXDriverHelp.IsReadOnlyValueType(
  ValueType: TDBXValueType): Boolean;
begin
  Result := ValueType.IsReadOnlyType;
end;

class procedure TDBXDriverHelp.SetOverflowBytes(Value: TDBXWideStringValue;
  streamReader: TDBXByteStreamReader);
begin
  value.SetOverflowBytes(streamReader);
end;

class procedure TDBXDriverHelp.SetMetaDataReader(Connection: TDBXConnection;
  MetaDataReader: TObject);
begin
  Connection.FMetaDataReader := MetaDataReader;
end;

class procedure TDBXDriverHelp.SetOverflowBytes(Value: TDBXAnsiStringValue;
  streamReader: TDBXByteStreamReader);
begin
  value.SetOverflowBytes(streamReader);
end;

class function TDBXDriverHelp.HasOverflowBytes(Value: TDBXWritableValue): Boolean;
var
  StreamReader: TDBXStreamReader;
begin
  if Value.IsNull then
    Result := false
  else
  begin
    StreamReader := value.GetStreamReader;
    Result := (StreamReader <> nil) and not StreamReader.Eos;
  end;
end;

class procedure TDBXDriverHelp.SetOverflowBytes(Value: TDBXByteArrayValue;
  streamReader: TDBXByteStreamReader);
begin
  value.SetOverflowBytes(streamReader);
end;

class procedure TDBXDriverHelp.SetPendingValue(Value: TDBXWritableValue);
begin
  Value.SetPendingValue;
end;

class procedure TDBXDriverHelp.CopyRowValue(Value: TDBXValue;
  DBXRow: TDBXRow);
begin
  Value.CopyRowValue(DBXRow);
end;

{ TDBXCursorValue }

function TDBXCursorValue.IsNull: Boolean;
begin
  Result := True;
end;

{ TDBXMemoryConnectionFactory }

constructor TDBXMemoryConnectionFactory.Create;
begin
  inherited Create;
end;

destructor TDBXMemoryConnectionFactory.Destroy;
begin

  inherited;
end;

{ TDBXWideCharsValue }

constructor TDBXWideCharsValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
  FCount := 0;
  SetLength(FWideChars, 0);
  UpdateType;
end;

destructor TDBXWideCharsValue.Destroy;
begin
  SetLength(FWideChars, 0);
  FRefValue := EmptyStr;
  inherited Destroy;
end;

function TDBXWideCharsValue.GetStream(AInstanceOwner: Boolean): TStream;
begin
  FDbxRow.GetStream(Self, Result, FIsNull);
end;

procedure TDBXWideCharsValue.SetWideString(const Value: string);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := false;
  FRefValue := FWideString;
  FWideString := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

function TDBXWideCharsValue.GetWideString: string;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetWideChars(Self, FWideChars, FCount, FIsNull);
    FGeneration := FDbxRow.Generation;
    if FIsNull then
      FWideString := EmptyStr
    else
      FWideString := TDBXPlatform.CreateWideString(FWideChars, FCount);
  end;
  Result := FWideString
end;

function TDBXWideCharsValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetWideChars(Self, FWideChars, FCount, FIsNull);
    FGeneration := FDbxRow.Generation;
    FWideString := TDBXPlatform.CreateWideString(FWideChars, FCount);
  end;
  Result := FIsNull;
end;

function TDBXWideCharsValue.Compare(Other: TDBXValue): Smallint;
begin
  Result := AnsiCompareText(AsString, Other.AsString)
end;

procedure TDBXWideCharsValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetWideChars(Self, GetWideString)
end;

procedure TDBXWideCharsValue.SetDynamicBytes(Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Length: Int64);
var
  WideCount: Integer;
begin
  FIsNull := False;
  WideCount := Length div 2;
  if FCount < WideCount then
  begin
    // resize current content
    SetLength(FWideChars, WideCount);
  end;

  // copy the bytes as chars
  TDBXPlatform.CopyBytesToWideChars(Buffer, BufferOffset, FWideChars, 0, Length);
  FCount := WideCount;

  FGeneration := FDbxRow.Generation;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FDbxRow.ValueSet(Self);
  end;
  FWideString := TDBXPlatform.CreateWideString(FWideChars, FCount);
end;

procedure TDBXWideCharsValue.SetRowValue;
begin
  FDbxRow.SetWideChars(Self, FWideString)
end;

procedure TDBXWideCharsValue.UpdateType;
begin
  inherited UpdateType;
end;

function TDBXWideCharsValue.GetBytes(Offset: Int64; const Value: TArray<Byte>;
  BufferOffset, Length: Int64): Int64;
var
  Chars: TDBXWideChars;
  Count:  Integer;
  Index:  Integer;
  Ch:     WideChar;
begin
  Chars := WideChars;
  Count := WideCharsCount;
  Index := Offset;
  while Count > 0 do
  begin
    Ch := Chars[(Index div 2)];
    Value[Index] := Byte(Ch);
    inc(Index);
    Value[Index] := Byte(Integer(Ch) shr 8);
    inc(Index);
    dec(Count);
  end;
  Result := WideCharsCount*2;
end;

function TDBXWideStringValue.GetStreamReader: TDBXStreamReader;
begin
  Result := FOverFlowBytes;
end;

procedure TDBXWideStringValue.SetOverflowBytes(const OverFlowBytes: TDBXByteStreamReader);
begin
  FreeAndNil(FOverFlowBytes);
  FOverFlowBytes := OverFlowBytes;
end;


function TDBXWideCharsValue.GetValueSize: Int64;
begin
  if IsNull then
    Result := -1
  else
    Result := (WideCharsCount)*2;
end;

{ TDBXAnsiCharsValue }

constructor TDBXAnsiCharsValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
  UpdateType;
end;

function TDBXAnsiCharsValue.GetStream(AInstanceOwner: Boolean): TStream;
begin
  FDbxRow.GetStream(Self, Result, FIsNull);
end;

procedure TDBXAnsiCharsValue.SetStaticBytes(Offset: Int64;
  const Buffer: array of Byte; BufferOffset, Length: Int64);
begin
  FIsNull := False;
  if FCount < Length then
  begin
    // resize current content
    SetLength(FBytes, Length);
  end;

  // copy the bytes as chars
  Move(Buffer[BufferOffset], FBytes[Offset], Length);
  FCount := Length;

  FGeneration := FDbxRow.Generation;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FDbxRow.ValueSet(Self);
  end;
  SetLength(FValue, Length);
  TDBXPlatform.CopyByteArray(FBytes, 0, FValue, 0, Length);
end;

procedure TDBXAnsiCharsValue.SetDynamicBytes(Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Length: Int64);
begin
  FIsNull := False;
  if FCount < Length then
  begin
    // resize current content
    SetLength(FBytes, Length);
  end;

  // copy the bytes as chars
  TDBXPlatform.CopyByteArray(Buffer, BufferOffset, FBytes, 0, Length);
  FCount := Length;

  FGeneration := FDbxRow.Generation;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FDbxRow.ValueSet(Self);
  end;
  SetLength(FValue, Length);
  TDBXPlatform.CopyByteArray(FBytes, 0, FValue, 0, Length);
end;

{$IFNDEF NEXTGEN}
function TDBXAnsiCharsValue.GetAnsiString: AnsiString;
var
  LAnsiChars: TDBXAnsiChars;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetAnsiChars(Self, LAnsiChars, FCount, FIsNull);
    SetLength(FBytes, FCount);
    if FCount > 0 then
      Move(LAnsiChars[0], FBytes[0], FCount);
    FGeneration := FDbxRow.Generation;
    if FIsNull then
      SetLength(FValue, 0)
    else
    begin
      SetLength(FValue, FCount);
      TDBXPlatform.CopyByteArray(FBytes, 0, FValue, 0, FCount);
    end;
  end;
  if Length(FValue) > 0 then
    Result := TMarshal.AsAnsi(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(FValue), Length(FValue)))
  else
    Result := '';
end;

procedure TDBXAnsiCharsValue.SetAnsiString(const Value: AnsiString);
begin
//  ValueType.FailIfReadOnly;
  FIsNull := False;
  SetLength(FRefValue, Length(FValue));
  TDBXPlatform.CopyByteArray(FValue, 0, FRefValue, 0, Length(FValue));
  FValue := BytesOf(Value);
  FCount := Length(FValue);
  SetLength(FBytes, FCount);
  TDBXPlatform.CopyByteArray(FValue, 0, FBytes, 0, FCount);
  FSetPending := True;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;
{$ELSE}
procedure TDBXAnsiCharsValue.SetString(const Value: string);
var
  LEncoding: TEncoding;
  LMarshaller: TMarshaller;
  LWrapper: TPtrWrapper;
begin
  FIsNull := False;
  SetLength(FRefValue, Length(FValue));
  TDBXPlatform.CopyByteArray(FValue, 0, FRefValue, 0, Length(FValue));
  LWrapper := LMarshaller.AsAnsi(Value);
  // workaround for TMarshaller not returning length information
  LEncoding := TEncoding.GetEncoding(DefaultSystemCodePage);
  try
    FCount := LEncoding.GetByteCount(Value);
  finally
    LEncoding.Free;
  end;
  SetLength(FValue, FCount);
  TMarshal.Copy(LWrapper, FValue, 0, FCount);
  SetLength(FBytes, FCount);
  TDBXPlatform.CopyByteArray(FValue, 0, FBytes, 0, FCount);
  FSetPending := True;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

function TDBXAnsiCharsValue.GetString: string;
var
  LAnsiChars: TDBXAnsiChars;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetAnsiChars(Self, LAnsiChars, FCount, FIsNull);
    SetLength(FBytes, FCount);
    if FCount > 0 then
      Move(LAnsiChars[0], FBytes[0], FCount);
    FGeneration := FDbxRow.Generation;
    if FIsNull then
      SetLength(FValue, 0)
    else
    begin
      SetLength(FValue, FCount);
      TDBXPlatform.CopyByteArray(FBytes, 0, FValue, 0, FCount);
    end;
  end;
  if Length(FValue) > 0 then
    Result := TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(FValue), Length(FValue))
  else
    Result := '';
end;
{$ENDIF !NEXTGEN}

function TDBXAnsiCharsValue.IsNull: Boolean;
var
  LAnsiChars: TDBXAnsiChars;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetAnsiChars(Self, LAnsiChars, FCount, FIsNull);
    FGeneration := FDbxRow.Generation;
    SetLength(FValue, FCount);
    if FCount > 0 then
      Move(LAnsiChars[0], FValue[0], FCount);
  end;
  Result := FIsNull;
end;

procedure TDBXAnsiCharsValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetDynamicBytes(Self, 0, FValue, 0, FCount);
end;

procedure TDBXAnsiCharsValue.SetRowValue;
begin
  FDbxRow.SetDynamicBytes(Self, 0, FValue, 0, FCount);
end;

procedure TDBXAnsiCharsValue.UpdateType;
begin
  inherited UpdateType;
end;


function TDBXAnsiCharsValue.GetBytes(Offset: Int64; const Value: TArray<Byte>;
  BufferOffset, Length: Int64): Int64;
var
  LAnsiChars: TDBXAnsiChars;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetAnsiChars(Self, LAnsiChars, FCount, FIsNull);
    SetLength(FBytes, FCount);
    if FCount > 0 then
      Move(LAnsiChars[0], FBytes[0], FCount);
    FGeneration := FDbxRow.Generation;
    if FIsNull then
      SetLength(FValue, 0)
    else
    begin
      SetLength(FValue, FCount);
      TDBXPlatform.CopyByteArray(FBytes, 0, FValue, 0, FCount);
    end;
  end;
  Result := FCount;
  TDBXPlatform.CopyByteArray(FBytes, Offset, Value, Offset, FCount);
end;

function TDBXAnsiCharsValue.GetValueSize: Int64;
begin
  if IsNull then
    Result := -1
  else
    Result := FCount;
end;

{ TDBXBinaryValue }

constructor TDBXStreamValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
  UpdateType;
end;

destructor TDBXStreamValue.Destroy;
begin
  FreeLastReadStream;
  FStreamStreamReader.Free;
  FByteStreamReader.Free;
  inherited;
end;

procedure TDBXStreamValue.FreeLastReadStream;
begin
  if FInstanceOwner then
  begin
    if (FStreamStreamReader <> nil) and (FStreamStreamReader.FStream = FLastReadStream) then
      FStreamStreamReader.FStream := nil;
    FreeAndNil(FLastReadStream);
  end;
end;

function TDBXStreamValue.GetStream(AInstanceOwner: Boolean): TStream;
begin
  Result := GetStream;
  FInstanceOwner := AInstanceOwner;
  if (FStreamStreamReader <> nil) and (Result = FStreamStreamReader.FStream) then
    FStreamStreamReader.FInstanceOwner := AInstanceOwner;
end;

function TDBXStreamValue.GetStream: TStream;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    Result := nil;
    FDbxRow.GetStream(Self, Result, FIsNull);
  end
  else if FSetPending and not FIsNull and (FStreamStreamReader <> nil) then
    Result := FStreamStreamReader.ConvertToMemoryStream
  else if FSetPending and not FIsNull and (Length(FBytes) > 0) then
    Result := TBytesStream.Create(FBytes)
  else
    Result := nil;
  //If the stream being returned is the same as the last read stream, don't free it
  if FLastReadStream <> Result then
    FreeLastReadStream;
  FLastReadStream := Result;
end;

function TDBXStreamValue.GetValueSize: Int64;
begin
  if FExtendedType then
  begin
    if IsNull then
      Result := -1
    else
      Result := FByteLength;
  end
  else
    Result := inherited GetValueSize;
end;

//function TDBXStreamValue.IsNull: Boolean;
//begin
//  if FExtendedType then
//  begin
//    if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
//    begin
//      Assert(false);
////      FDbxRow.GetStream(Self, nil, FIsNull);
//      FGeneration := FDbxRow.Generation;
//    end;
//    Result := FIsNull;
//  end else
//    Result := inherited IsNull;
//end;

procedure TDBXStreamValue.SetDynamicBytes(Offset: Int64; const Buffer: TArray<Byte>; BufferOffset,
  Count: Int64);
begin
  if FExtendedType then
  begin
  //  ValueType.FailIfReadOnly;
    FIsNull := false;
    FreeAndNil(FStreamStreamReader);
    FreeAndNil(FByteStreamReader);
    FByteStreamReader := TDBXByteStreamReader.Create(Buffer, BufferOffset, Count);
    FSetPending := true;
    if FDbxRow <> nil then
    begin
      FGeneration := FDbxRow.Generation;
      FDbxRow.ValueSet(Self);
    end;
  end else
    inherited SetDynamicBytes(Offset, Buffer, BufferOffset, Count);
end;

procedure TDBXStreamValue.SetNull;
begin
  inherited;
  FreeLastReadStream;
end;

procedure TDBXStreamValue.CopyRowValue(Row: TDBXRow);
var
  StreamReader: TDBXLookAheadStreamReader;
begin
  if IsNull then
    Row.SetNull(Self)
  else
  begin
//    if FExtendedType then
    begin
      StreamReader := TDBXLookAheadStreamReader.Create;
      try
        StreamReader.SetStream(GetStream(False), True);
        Row.SetStream(Self, StreamReader);
        if not StreamReader.Eos then
        begin
          SetOverflowBytes(StreamReader);
          Assert(FOverFlowBytes <> nil);
          StreamReader := nil;
        end;
      finally
        StreamReader.Free;
      end;
    end
//    else
//      inherited CopyRowValue(Row);
  end;
end;

function TDBXStreamValue.GetStreamReader: TDBXStreamReader;
begin
  if FOverFlowBytes <> nil then
    Result := FOverFlowBytes
  else if FStreamStreamReader <> nil then
    Result := FStreamStreamReader
  else
    Result := FByteStreamReader;
end;

procedure TDBXStreamValue.SetRowValue;
begin
  if FExtendedType then
  begin
    if FStreamStreamReader <> nil then
      FDbxRow.SetStream(Self, FStreamStreamReader)
    else if FByteStreamReader <> nil then
      FDbxRow.SetStream(Self, FByteStreamReader)
    else
      inherited SetRowValue;
  end else
    inherited SetRowValue;
end;

procedure TDBXStreamValue.SetStream(const Stream: TStream; const AInstanceOwner: Boolean);
begin
  // Make sure the ExtendedType bit is set in order to allow the correct data
  // to be set later in SetRowValue.  Otherwise, data will be set in the inherited from
  // the base bytes array buffer instead of this stream
  FExtendedType := True;

  FreeLastReadStream;
//  ValueType.FailIfReadOnly;
  if Stream = nil then
    SetNull
  else
  begin
    FIsNull := false;
    FreeAndNil(FByteStreamReader);
    if FStreamStreamReader = nil then
      FStreamStreamReader := TDBXLookAheadStreamReader.Create;
    FStreamStreamReader.SetStream(Stream, AInstanceOwner);
    FSetPending := true;
    if FDbxRow <> nil then
    begin
      FGeneration := FDbxRow.Generation;
      FDbxRow.ValueSet(Self);
    end;
  end;
end;

procedure TDBXStreamValue.UpdateType;
begin
  if ((ValueType.GetFlags and TDBXValueTypeFlags.ExtendedType) <> 0)
      or ((FDbxRow <> nil) and FDbxRow.UseExtendedTypes) then
    FExtendedType := true
  else
    FExtendedType := false;
end;

{ TDBXLookAheadStreamReader }

// A MemoryStream can always seeek to the start.
//
procedure TDBXLookAheadStreamReader.Close;
begin

end;

function TDBXLookAheadStreamReader.ConvertToMemoryStream: TStream;
var
  Stream: TMemoryStream;
  StreamTemp: TStream;
  Count, ReadBytes: Integer;
  Buffer: TArray<Byte>;
begin
  if FStream = nil then
    Result := nil
  else
  begin
    Count := Size;
    if not (FStream is TMemoryStream) then
    begin
      Stream := TMemoryStream.Create;
      if Count >= 0 then
        Stream.SetSize(Count);
      if FHasLookAheadByte then
        Stream.Write(FLookAheadByte, 1);
      SetLength(Buffer, 32000);
      while True do
      begin
        ReadBytes := FStream.Read(Buffer[0], Length(Buffer));
        if ReadBytes > 0 then
          Stream.Write(Buffer[0], ReadBytes)
        else
          Break;
      end;
      StreamTemp := FStream;
      FStream := Stream;
      FreeAndNil(StreamTemp);
    end;
    FStream.Seek(0, soFromBeginning);
    FHasLookAheadByte := False;

    Result := FStream;
  end;
end;

destructor TDBXLookAheadStreamReader.Destroy;
begin
  if FInstanceOwner then
    FStream.Free;
  inherited;
end;

function TDBXLookAheadStreamReader.EOS: Boolean;
begin
  if (not FEOS) and (not FHasLookAheadByte) then
  begin
    if FStream.Read(FLookAheadByte, 1) = 1 then
      FHasLookAheadByte := true
    else
      FEOS := true;
  end;
  Result := FEOS;
end;

function TDBXLookAheadStreamReader.Read(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
begin
  if FHasLookAheadByte then
  begin
    Buffer[Offset] := FLookAheadByte;
    FHasLookAheadByte := false;
    Result := FStream.Read(buffer[Offset+1], Count - 1) + 1;
  end else
    Result := FStream.Read(Buffer[Offset], Count);

  if Result < Count then
    FEOS := true;
end;

procedure TDBXLookAheadStreamReader.SetStream(const Stream: TStream; const AInstanceOwner: Boolean);
begin
  if FInstanceOwner then
    FreeAndNil(FStream);
  FInstanceOwner    := AInstanceOwner;
  FEOS              := false;
  FHasLookAheadByte := false;
  FStream           := Stream;
end;

function TDBXLookAheadStreamReader.Size: Int64;
begin
  Result := -1;
end;

{ TDBXCommandEX }

function TDBXCommand.GetCommandTimeout: Integer;
begin
  Result := FCommandTimeout;
end;

procedure TDBXCommand.SetCommandTimeout(const Timeout: Integer);
begin
  FCommandTimeout := Timeout;
end;

{ TDBXByteReader }

procedure TDBXByteReader.GetBoolean(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  GetInt16(Ordinal, Value, Offset, IsNull);
end;

{ TDBXByteStreamReader }

destructor TDBXByteStreamReader.Destroy;
begin
  FBytes := nil;
  inherited;
end;

function TDBXByteStreamReader.EOS: Boolean;
begin
  Result := (FCount = FPosition);
end;

function TDBXByteStreamReader.Read(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
var
  Available : Integer;
begin
  Result := Count;
  Available := FCount - FPosition;
  if Result > Available then
    Result := Available;
  TDBXPlatform.CopyByteArray(FBytes, FPosition, Buffer, Offset, Result);
  FPosition := FPosition + Result;
end;

procedure TDBXByteStreamReader.Close;
begin

end;

constructor TDBXByteStreamReader.Create(Bytes: TArray<Byte>; Offset, Count: Integer);
begin
  inherited Create;
  FBytes := Bytes;
  FOffset := Offset;
  FCount := Count;
  FPosition := 0;
end;

function TDBXByteStreamReader.Size: Int64;
begin
  Result := FCount;
end;

{ TDBXStateItemList }

procedure TDBXStateItemList.AddStateItem(Name: string; Item: TDBXStateItem);
begin

end;

destructor TDBXStateItemList.Destroy;
begin

  inherited;
end;

function TDBXStateItemList.GetStateItem(Name: string): TDBXStateItem;
begin
  Result := nil;
end;

procedure TDBXStateItemList.RemoveAndFreeStateItem(Name: string);
begin

end;

class procedure TDBXDriverHelp.UpdateParameterType(Parameter: TDBXParameter);
begin
  Parameter.UpdateParameterType(Parameter.DataType);
end;

{ TDBXNullValue }

constructor TDBXNullValue.Create(ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
  FIsNull     := true;
  FSetPending := true;
end;

destructor TDBXNullValue.Destroy;
begin

  inherited;
end;

function TDBXNullValue.IsNull: Boolean;
begin
  Result := true;
end;


{ TDBXDefaultFormatter }

constructor TDBXDefaultFormatter.Create;
begin
  inherited Create;
  DateFormat.DateSeparator := '-';                  {Do not resource}
  DateFormat.ShortDateFormat := 'YYYY-MM-DD';       {Do not resource}
  DateFormat.LongDateFormat := 'YYYY-MM-DD';        {Do not resource}

  TimeFormat.TimeSeparator := ':';                  {Do not resource}
  TimeFormat.DecimalSeparator := '.';              {Do not resource}
  TimeFormat.ShortTimeFormat := 'hh:nn:ss';         {Do not resource}
  TimeFormat.LongTimeFormat := 'hh:nn:ss';          {Do not resource}

  TimeStampFormat.DateSeparator := '-';             {Do not resource}
  TimeStampFormat.DecimalSeparator := '.';          {Do not resource}
  TimeStampFormat.ShortDateFormat := 'YYYY-MM-DD';  {Do not resource}
  TimeStampFormat.LongDateFormat := 'YYYY-MM-DD';   {Do not resource}
  TimeStampFormat.TimeSeparator := ':';             {Do not resource}
  TimeStampFormat.ShortTimeFormat := 'hh:nn:ss';    {Do not resource}
  TimeStampFormat.LongTimeFormat := 'hh:nn:ss';     {Do not resource}
end;

function TDBXDefaultFormatter.BcdToString(
  DBXBcdValue: TDBXBcdValue): string;
begin
  Result := BcdToStr(DBXBcdValue.GetBcd);
end;

procedure TDBXDefaultFormatter.StringToBcd(StringValue: string;
  DBXBcdValue: TDBXBcdValue);
begin
  DBXBcdValue.SetBcd(StrToBcd(StringValue));
end;

function TDBXDefaultFormatter.DateToString(
  DBXDateValue: TDBXDateValue): string;
var
  Date: TDateTime;
  Time: TTimeStamp;
begin
  Time.Time := 0;
  Time.Date := DBXDateValue.GetDate;
  Date := TimeStampToDateTime(Time);
  Result := DateToStr(Date,DateFormat);
end;

class function TDBXDefaultFormatter.GetDefaultDBXFormatter: TDBXFormatter;
begin
  if FDBXDefaultFormatterSingleton = nil then
  begin
    FDBXDefaultFormatterSingleton := TDBXDefaultFormatter.Create;
    // Singleton should be destroyed on finalization
    FDBXDefaultFormatterSingletonOwned := true;
  end;
  Result := FDBXDefaultFormatterSingleton;
end;

class procedure TDBXDefaultFormatter.SetDefaultDBXFormatter(
  DBXFormatter: TDBXFormatter);
begin
  if FDBXDefaultFormatterSingleton <> nil then
    raise TDBXError.Create(TDBXErrorCodes.InvalidArgument, SSetSingletonOnce);
  FDBXDefaultFormatterSingleton := DBXFormatter;
end;

procedure TDBXDefaultFormatter.StringToDate(StringValue: string;
  DBXDateValue: TDBXDateValue);
var
  Date: TDateTime;
  Time: TTimeStamp;
begin
  Date := StrToDate(StringValue,DateFormat);
  Time := DateTimeToTimeStamp(Date);
  DBXDateValue.SetDate(Time.Date);
end;

procedure TDBXDefaultFormatter.StringToTime(StringValue: string;
  DBXTimeValue: TDBXTimeValue);
var
  Date: TDateTime;
  Time: TTimeStamp;
begin
  Date := StrToTime(StringValue, TimeFormat);
  Time := DateTimeToTimeStamp(Date);
  DBXTimeValue.SetTime(Time.Time);
end;

function TDBXDefaultFormatter.TimeToString(
  DBXTimeValue: TDBXTimeValue): string;
var
  Date: TDateTime;
  Time: TTimeStamp;
begin
  Time.Time := DBXTimeValue.GetTime;
  Time.Date := DateDelta;
  Date := TimeStampToDateTime(Time);
  Result := TimeToStr(Date, TimeFormat);
end;

procedure TDBXDefaultFormatter.StringToTimestamp(StringValue: string;
  DBXTimestampValue: TDBXTimestampValue);
var
  Date: TDateTime;
begin
  Date := StrToDateTime(StringValue, TimeStampFormat);
  DBXTimestampValue.SetTimeStamp(DateTimeToSQLTimeStamp(Date));
end;

procedure TDBXDefaultFormatter.StringToTimestampOffset(
  StringValue: string;
  DBXTimestampOffsetValue: TDBXTimestampOffsetValue);
begin
  DBXTimestampOffsetValue.SetTimeStampOffset(StrToSQLTimeStampOffset(StringValue));
end;

function TDBXDefaultFormatter.TimestampOffsetToString(
  DBXTimestampOffsetValue: TDBXTimestampOffsetValue): string;
begin
  Result := SQLTimeStampOffsetToStr('', DBXTimestampOffsetValue.GetTimeStampOffset);
end;

function TDBXDefaultFormatter.TimestampToString(
  DBXTimestampValue: TDBXTimestampValue): string;
var
  Date: TDateTime;
begin
  Date := SQLTimeStampToDateTime(DBXTimestampValue.GetTimeStamp);
  Result := DateTimeToStr(Date, TimeStampFormat);
  Result := Result + '.' {Do not resource}
            + IntToStr(DBXTimestampValue.GetTimeStamp.Fractions);
end;


{ TDBXTableValue }

function TDBXReaderValue.GetDBXReader(AInstanceOwner: Boolean): TDBXReader;
begin
  Result := GetDBXReader;
  FInstanceOwner := AInstanceOwner;
end;

function TDBXReaderValue.GetDBXReader: TDBXReader;
begin
  if IsNull then
    Result := nil
  else
  begin
    Result := FDBXReader;
  end;
end;

function TDBXReaderValue.GetHandle: Integer;
begin
  Result := FHandle;
end;


function TDBXReaderValue.GetMaxRows: Integer;
begin
  Result := FMaxRows;
end;

function TDBXReaderValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetDBXReader(Self, FDBXReader, FIsNull);
    FGeneration := FDbxRow.Generation;
    FRowReader := True;
  end;
  Result := FIsNull;
end;

procedure TDBXReaderValue.SetDBXReader(const Value: TDBXReader; const AInstanceOwner: Boolean);
begin
  if Value = nil then
    SetNull
  else
  begin
    FIsNull := false;
    if (FDBXReader <> Value) and FInstanceOwner then
      FreeAndNil(FDBXReader);
    FDBXReader := Value;
    FInstanceOwner := AInstanceOwner;
    FSetPending := true;
    if FDbxRow <> nil then
    begin
      FGeneration := FDbxRow.Generation;
      FDbxRow.ValueSet(Self);
    end;
  end;
  FRowReader := False;
end;

procedure TDBXReaderValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetDBXReader(Value.GetDBXReader, False);
end;

procedure TDBXReaderValue.SetHandle(const Handle: Integer);
begin
  FHandle := Handle;
end;

procedure TDBXReaderValue.SetNull;
begin
  if FInstanceOwner then
    FreeAndNil(FDBXReader);
  FDBXReader := nil;
  inherited SetNull;
end;

procedure TDBXReaderValue.SetRowValue;
begin
  FDbxRow.SetDBXReader(Self, FDBXReader);
end;

procedure TDBXReaderValue.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetDBXReader(Self, GetDBXReader(True));
end;
destructor TDBXReaderValue.Destroy;
begin
  if FInstanceOwner then
    FDBXReader.Free;
  inherited Destroy;
end;

function TDBXStream.Seek(Offset: Integer; Origin: Word): Longint;
begin
  if (Offset <> 0) and (Origin <> soFromBeginning) then
    inherited Seek(Offset, Origin);
  Result := 0;
end;

function TDBXStream.Seek(const Offset: Int64;
  Origin: TSeekOrigin): Int64;
begin
  if (Offset <> 0) and (Origin <> soBeginning) then
    raise TDBXError.Create(TDBXErrorCodes.NotSupported, '');
  Result := 0;
end;

function TDBXStreamReaderStream.GetSize: Int64;
begin
  Result := FReader.Size;
end;

function TDBXStreamReaderStream.Read(var Buffer; Count: Integer): Longint;
var
  Available, Remaining, TransferBytes: Integer;
  DestPointer: PByte;
begin
  Result := 0;
  DestPointer := Addr(Buffer);

  // in case position has been moved, we can fill the bytes based on what we already have
  if FStartedRead and (FOffset < Length(FBuffer)) then
  begin
    Available := Length(FBuffer) - FOffset;
    if Available >= Count then
    begin
      // We have all the bytes requested from cursor available already
      // So move those out and finish
      Result := Count;
      Move(FBuffer[FOffset], DestPointer^, Count);
      Inc(FOffset, Count);
      Exit;
    end
    else
    begin
      Result := Available;
      Move(FBuffer[FOffset], DestPointer^, Available);
      Inc(DestPointer, Available);
      Inc(FOffset, Available);
      Count := Count - Available;
    end;
    assert(FOffset = Length(FBuffer));
  end;

  Remaining := Count;
  while (Result < Count) and (not FReader.Eos) do
  begin
    FStartedRead := True;
    Available := Length(FBuffer) - FOffset;
    if Available < Count then
    begin
      SetLength(FBuffer, FOffset+Count);
      Available := Count;
    end;
    if Remaining < Available then
      Available := Remaining;
    TransferBytes := FReader.Read(FBuffer, FOFfset, Available);
    dec(Remaining, TransferBytes);
    Assert(Length(FBuffer) >= (TransferBytes+FOffset));
    Move(FBuffer[FOffset], DestPointer^, TransferBytes);
    Inc(FOffset, TransferBytes);
    SetLength(FBuffer, FOffset);
    Inc(DestPointer, TransferBytes);
    Result := Result + TransferBytes;
  end;
end;

function TDBXStreamReaderStream.ReadBytes(const Buffer: TArray<Byte>; Offset, Count: Longint): Longint;
begin
  Result := Read(Buffer[Offset], Count);
end;

function TDBXStreamReaderStream.Seek(Offset: Integer; Origin: Word): Longint;
var
  LVal: Integer;
begin
  // seek if the range is valid
  if Origin = soFromCurrent then
  begin
    LVal := FOffset + Offset;
    if (LVal >= 0) and (LVal < Length(FBuffer)) then
      FOffset := LVal;
  end
  else if Origin = soFromBeginning then
  begin
    if (Offset >= 0) and (Offset < Length(FBuffer)) then
      FOffset := Offset;
  end
  else if Origin = soFromEnd then
  begin
    if (Offset >= 0) and ((Length(FBuffer) - Offset) > 0) then
      FOffset := Length(FBuffer) - Offset;
  end;

  Result := FOffset;
end;

function TDBXStreamReaderStream.Seek(const Offset: Int64;
  Origin: TSeekOrigin): Int64;
begin
  if Origin = soBeginning then
    Result := Seek(Integer(Offset), soFromBeginning)
  else if Origin = soEnd then
    Result := Seek(Integer(Offset), soFromEnd)
  else if Origin = soCurrent then
    Result := Seek(Integer(Offset), soFromCurrent)
  else
    Result := FOffset;
end;

function TDBXStreamReaderStream.Write(const Buffer; Count: Integer): Longint;
begin
  Result := 0;
end;

constructor TDBXStreamReaderStream.Create(Reader: TDBXStreamReader;
  Size: Int64);
begin
  inherited Create;
  FReader := Reader;
  SetLength(FBuffer, Integer(Size));
  FStartedRead := False;
end;

destructor TDBXStreamReaderStream.Destroy;
begin
  FReader.Free;
  inherited Destroy;
end;

{ TDBXClientBytesStream }

constructor TDBXBytesStream.Create(Bytes: TArray<Byte>; Size: Int64);
begin
  inherited Create;
  FBuffer := Bytes;
  FSize   := Size;
end;

function TDBXBytesStream.GetSize: Int64;
begin
  Result := FSize;
end;

function TDBXBytesStream.Read(var Buffer; Count: Integer): Longint;
var
  TransferBytes: Integer;
begin
  TransferBytes := FSize - FOffset;
  if TransferBytes > Count then
    TransferBytes := Count;
  if TransferBytes > 0 then
  begin
    Move(FBuffer[FOffset], Buffer, TransferBytes);
    inc(FOffset, TransferBytes);
    Result := TransferBytes;
  end
  else if TransferBytes = 0 then
    Result := TransferBytes
  else
    Result := -1;
end;
function TDBXBytesStream.ReadBytes(const Buffer: TArray<Byte>; Offset, Count: Longint): Longint;
begin
  Result := Read(Buffer[Offset], Count);
end;

function TDBXBytesStream.Write(const Buffer; Count: Integer): Longint;
begin
  Result := 0;
end;

{ TDBXWritableValueList }

constructor TDBXWritableValueList.Create(DBXContext: TDBXContext);
begin
 inherited Create(DBXContext);
end;

function TDBXWritableValueList.GetWritableValue(
  const Ordinal: TInt32): TDBXWritableValue;
begin
  if (Ordinal < 0) or (Ordinal >= FValueCount) then
    InvalidOrdinal(Ordinal);
  Result := FValues[Ordinal];
end;

// For compatibility where caller still passes in TDBXValueArray and not a
// TDBXWritableValueArray.
//
procedure TDBXValueList.SetValues(const Values: TDBXValueArray);
var
  Count, Index: Integer;
begin
  Count := Length(Values);
  SetLength(FValues, Count);
  for Index := 0 to Count - 1 do
  begin
    FValues[Index] := TDBXWritableValue(Values[Index]);
  end;
end;

// Called by TDBXReader
//
procedure TDBXValueList.SetValues(
  const Values: TDBXWritableValueArray);
begin
  FValues := Values;
  // Do not set FValueCount.  This is performed after the first call to next.
  //
end;

// Called by TDBXTable
//
procedure TDBXValueList.SetValues(const Values: TDBXWritableValueArray;
  const Count: Integer);
begin
  FValues := Values;
  FValueCount := Count;
end;


{ TDBXTimeStampOffsetValue }

procedure TDBXTimeStampOffsetValue.CopyRowValue(Row: TDBXRow);
var
  Value: TSQLTimeStampOffset;
begin
  if IsNull then
    Row.SetNull(Self)
  else
  begin
    Value := GetTimeStampOffset;
    Row.SetTimestampOffset(Self, Value);
  end;
end;

//function TDBXTimeStampOffsetValue.GetAsDate: TDBXDate;
//begin
//
//end;
//
//function TDBXTimeStampOffsetValue.GetAsDateTime: TDateTime;
//begin
//
//end;
//
function TDBXTimeStampOffsetValue.GetAsString: string;
begin
  Result := TDBXDefaultFormatter.GetDefaultDBXFormatter.TimestampOffsetToString(Self);
end;
//
//function TDBXTimeStampOffsetValue.GetAsTime: TDBXTime;
//begin
//
//end;
//
//function TDBXTimeStampOffsetValue.GetAsTimeStamp: TSQLTimeStamp;
//begin
//
//end;

function TDBXTimeStampOffsetValue.GetTimeStampOffset: TSQLTimeStampOffset;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetTimeStampOffset(Self, FTimeStampOffset, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FTimeStampOffset;
end;

function TDBXTimeStampOffsetValue.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetTimeStampOffset(Self, FTimeStampOffset, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

//procedure TDBXTimeStampOffsetValue.SetAsDate(const Value: TDBXDate);
//begin
//  inherited;
//
//end;
//
//procedure TDBXTimeStampOffsetValue.SetAsDateTime(const Value: TDateTime);
//begin
//  inherited;
//
//end;
//
procedure TDBXTimeStampOffsetValue.SetAsString(const Value: string);
begin
  TDBXDefaultFormatter.GetDefaultDBXFormatter.StringToTimestampOffset(Value, Self);
end;
//
//procedure TDBXTimeStampOffsetValue.SetAsTime(const Value: TDBXTime);
//begin
//  inherited;
//
//end;
//
//procedure TDBXTimeStampOffsetValue.SetAsTimeStamp(const Value: TSQLTimeStamp);
//begin
//  inherited;
//
//end;

procedure TDBXTimeStampOffsetValue.SetRowValue;
begin
  FDbxRow.SetTimestampOffset(Self, FTimeStampOffset);
end;

procedure TDBXTimeStampOffsetValue.SetTimeStampOffset(const Value: TSQLTimeStampOffset);
begin
  FIsNull := false;
  FTimeStampOffset := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXTimeStampOffsetValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetTimeStampOffset(Value.GetTimeStampOffset);
end;

{ TDBXInt8Value }

function TDBXInt8Value.Compare(Other: TDBXValue): Smallint;
begin
  if AsInt8 = Other.AsInt8 then
    Result := 0
  else if AsInt8 < Other.AsInt8 then
    Result := -1
  else
    Result := 1
end;

procedure TDBXInt8Value.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetInt8(Self, GetInt8);
end;

function TDBXInt8Value.GetAsBcd: TBcd;
begin
  Result := IntegerToBcd(GetInt8);
end;

function TDBXInt8Value.GetAsBoolean: Boolean;
begin
  Result := GetInt8 <> 0;
end;

function TDBXInt8Value.GetAsDouble: Double;
begin
  Result := GetInt8;
end;

function TDBXInt8Value.GetAsInt16: SmallInt;
begin
  Result := GetInt8;
end;

function TDBXInt8Value.GetAsInt32: TInt32;
begin
  Result := GetInt8;
end;

function TDBXInt8Value.GetAsInt64: Int64;
begin
  Result := GetInt8;
end;

function TDBXInt8Value.GetAsInt8: ShortInt;
begin
  Result := GetInt8;
end;

function TDBXInt8Value.GetAsSingle: Single;
begin
  Result := GetInt8;
end;

function TDBXInt8Value.GetAsString: string;
begin
  Result := IntToStr(GetInt8);
end;

function TDBXInt8Value.GetAsUInt16: Word;
begin
  Result := GetInt8;
end;

function TDBXInt8Value.GetInt8: ShortInt;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetInt8(Self, FInt8, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FInt8;
end;

function TDBXInt8Value.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetInt8(Self, FInt8, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

procedure TDBXInt8Value.SetAsBcd(const Value: TBcd);
var
  IntValue: Integer;
begin
  IntValue := BcdToInteger(Value);
  if (IntValue <= High(ShortInt)) and (IntValue >= Low(ShortInt)) then
    SetInt8(IntValue)
  else
    inherited;
end;

procedure TDBXInt8Value.SetAsBoolean(const Value: Boolean);
begin
  SetInt8(Ord(Value));
end;

procedure TDBXInt8Value.SetAsDouble(const Value: Double);
begin
  if (Value <= High(ShortInt)) and (Value >= Low(ShortInt)) then
    SetInt8(Round(Value))
  else
    inherited;
end;

procedure TDBXInt8Value.SetAsInt16(const Value: SmallInt);
begin
  if (Value <= High(ShortInt)) and (Value >= Low(ShortInt)) then
    SetInt8(Value)
  else
    inherited;
end;

procedure TDBXInt8Value.SetAsInt32(const Value: TInt32);
begin
  if (Value <= High(ShortInt)) and (Value >= Low(ShortInt)) then
    SetInt8(Value)
  else
    inherited;
end;

procedure TDBXInt8Value.SetAsInt64(const Value: Int64);
begin
  if (Value <= High(ShortInt)) and (Value >= Low(ShortInt)) then
    SetInt8(Value)
  else
    inherited;
end;

procedure TDBXInt8Value.SetAsInt8(const Value: ShortInt);
begin
  SetInt8(Value);
end;

procedure TDBXInt8Value.SetAsSingle(const Value: Single);
begin
  if (Value <= High(ShortInt)) and (Value >= Low(ShortInt)) then
    SetInt8(Round(Value))
  else
    inherited;
end;

procedure TDBXInt8Value.SetAsString(const Value: string);
var
  IntValue: Integer;
begin
  IntValue := StrToInt(Value);
  if (IntValue <= High(ShortInt)) and (IntValue >= Low(ShortInt)) then
    SetInt8(IntValue)
  else
    inherited;
end;

procedure TDBXInt8Value.SetAsUInt16(const Value: Word);
begin
  if Value < Word(High(ShortInt)) then
    SetInt8(Value)
  else
    inherited;
end;

procedure TDBXInt8Value.SetInt8(const Value: ShortInt);
begin
  FIsNull := false;
  FInt8 := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXInt8Value.SetRowValue;
begin
  FDbxRow.SetInt8(Self, FInt8);
end;

procedure TDBXInt8Value.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetInt8(Value.GetAsInt8)
end;

{ TDBXUInt8Value }

function TDBXUInt8Value.Compare(Other: TDBXValue): Smallint;
begin
  if AsUInt8 = Other.AsUInt8 then
    Result := 0
  else if AsUInt8 < Other.AsUInt8 then
    Result := -1
  else
    Result := 1
end;

procedure TDBXUInt8Value.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetUInt8(Self, GetUInt8);
end;

function TDBXUInt8Value.GetAsBcd: TBcd;
begin
  Result := IntegerToBcd(GetUInt8);
end;

function TDBXUInt8Value.GetAsBoolean: Boolean;
begin
  Result := GetUInt8 <> 0;
end;

function TDBXUInt8Value.GetAsDouble: Double;
begin
  Result := GetInt8;
end;

function TDBXUInt8Value.GetAsInt16: SmallInt;
begin
  Result := GetUInt8;
end;

function TDBXUInt8Value.GetAsInt32: TInt32;
begin
  Result := GetUInt8;
end;

function TDBXUInt8Value.GetAsInt64: Int64;
begin
  Result := GetUInt8;
end;

function TDBXUInt8Value.GetAsInt8: ShortInt;
begin
  Result := GetUInt8;
end;

function TDBXUInt8Value.GetAsSingle: Single;
begin
  Result := GetInt8;
end;

function TDBXUInt8Value.GetAsString: string;
begin
  Result := IntToStr(GetUInt8);
end;

function TDBXUInt8Value.GetAsUInt16: Word;
begin
  Result := GetUInt8;
end;

function TDBXUInt8Value.GetUInt8: Byte;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetUInt8(Self, FUInt8, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FUInt8;
end;

function TDBXUInt8Value.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetUInt8(Self, FUInt8, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

procedure TDBXUInt8Value.SetAsBcd(const Value: TBcd);
var
  IntValue: Integer;
begin
  IntValue := BcdToInteger(Value);
  if (IntValue >= Low(Byte)) and (IntValue <= High(Byte)) then
    SetUInt8(IntValue)
  else
    inherited;
end;

procedure TDBXUInt8Value.SetAsBoolean(const Value: Boolean);
begin
  SetUInt8(Ord(Value));
end;

procedure TDBXUInt8Value.SetAsDouble(const Value: Double);
begin
  if (Value >= Low(Byte)) and (Value <= High(Byte)) then
    SetUInt8(Round(Value))
  else
    inherited;
end;

procedure TDBXUInt8Value.SetAsInt16(const Value: SmallInt);
begin
  if (Value >= Low(Byte)) and (Value <= High(Byte)) then
    SetUInt8(Value)
  else
    inherited;
end;

procedure TDBXUInt8Value.SetAsInt32(const Value: TInt32);
begin
  if (Value >= Low(Byte)) and (Value <= High(Byte)) then
    SetUInt8(Value)
  else
    inherited;
end;

procedure TDBXUInt8Value.SetAsInt64(const Value: Int64);
begin
  if (Value >= Low(Byte)) and (Value <= High(Byte)) then
    SetUInt8(Value)
  else
    inherited;
end;

procedure TDBXUInt8Value.SetAsInt8(const Value: ShortInt);
begin
  if Value >= ShortInt(Low(Byte)) then
    SetUInt8(Value)
  else
    inherited;
end;

procedure TDBXUInt8Value.SetAsSingle(const Value: Single);
begin
  if (Value >= Low(Byte)) and (Value <= High(Byte)) then
    SetUInt8(Round(Value))
  else
    inherited;
end;

procedure TDBXUInt8Value.SetAsString(const Value: string);
var
  IntValue: Integer;
begin
  IntValue := StrToInt(Value);
  if (IntValue >= Low(Byte)) and (IntValue <= High(Byte)) then
    SetUInt8(IntValue)
  else
    inherited;
end;

procedure TDBXUInt8Value.SetAsUInt16(const Value: Word);
begin
  if Value < High(Byte) then
    SetUInt8(Value)
  else
    inherited;
end;

procedure TDBXUInt8Value.SetRowValue;
begin
  FDbxRow.SetUInt8(Self, FUInt8);
end;

procedure TDBXUInt8Value.SetUInt8(const Value: Byte);
begin
  FIsNull := false;
  FUInt8 := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXUInt8Value.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetUInt8(Value.GetUInt8)
end;

{TDBXJSONValue}

constructor TDBXJSONValue.Create(const ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
  FJsonValue := nil;
end;

destructor TDBXJSONValue.Destroy;
begin
  if FInstanceOwner then
    FJsonValue.Free;
  inherited;
end;

procedure TDBXJSONValue.SetRowValue;
begin
  FGeneration := FDbxRow.Generation;
  FdbxRow.SetJSONValue( self, FJsonValue );
end;

procedure TDBXJSONValue.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetJSONValue(Value.GetJSONValue, False)
end;

function TDBXJSONValue.EstimatedByteSize: Integer;
begin
  if FJsonValue <> nil then
  begin
    Result := FJsonValue.EstimatedByteSize;
    exit;
  end;
  Result := 0;
end;

function TDBXJSONValue.ToBytes(const Data: TArray<Byte>; const Offset: Integer): Integer;
begin
  if FJsonValue <> nil then
  begin
    Result := FJsonValue.ToBytes(Data, Offset);
    exit;
  end;
  Result := 0;
end;

function TDBXJSONValue.GetJSONValue(AInstanceOwner: Boolean): TJSONValue;
begin
  Result := GetJSONValue;
  FInstanceOwner := AInstanceOwner;
end;

function TDBXJSONValue.GetJSONValue: TJSONValue;
begin
  if (FdbxRow <> nil) and (FdbxRow.Generation <> FGeneration) then
  begin
    if FInstanceOwner then
      FreeAndNil(FJsonValue)
    else
      FJsonValue := nil;
    FdbxRow.GetJSONValue(self, FJsonValue, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FJsonValue;
end;

function TDBXJSONValue.GetObjectValue(AInstanceOwner: Boolean): TObject;
begin
  Result := GetJSONValue(AInstanceOwner);
end;

function TDBXJSONValue.GetWideString: string;
var
  Val: TJSONValue;
begin
  Val := GetJSONValue;
  if Val <> nil then
    Result := Val.Value;
end;

function TDBXJSONValue.GetObjectValue: TObject;
begin
  Result := GetJSONValue;
end;

function TDBXJSONValue.CreateJSONValue(const Data: TArray<Byte>; const Off: Integer; const Count: Integer): TJSONValue;
begin
  if FInstanceOwner then
    FJsonValue.Free;
  FJsonValue := TJSONObject.ParseJSONValue(Data, Off, Off + Count);
  if FJsonValue = nil then
    raise TDBXError.Create(0, SJSONByteStream);
  Result := FJsonValue;
end;

procedure TDBXJSONValue.SetJSONValue(const Value: TJSONValue; const AInstanceOwner: Boolean);
begin
  FSetPending := true;

  if (FJsonValue <> Value) and (FJsonValue <> nil) and FInstanceOwner then
  begin
    FJsonValue.Free;
    FJsonValue := nil;
  end;

  if Value = nil then
    self.SetNull
  else
  begin
    self.FIsNull := false;
    FInstanceOwner := AInstanceOwner;
    FJsonValue := Value;
    if FDBXRow <> nil then
    begin
      FGeneration := FDbxRow.Generation;
      FdbxRow.SetJSONValue( self, Value );
    end;
  end;
end;

procedure TDBXJSONValue.SetNull;
begin
  if FInstanceOwner then
    FreeAndNil(FJsonValue)
  else
    FJsonValue := nil;
  inherited SetNull;
end;

procedure TDBXJSONValue.SetObjectValue(const Value: TObject; const AInstanceOwner: Boolean);
begin
  if (Value = nil) or (Value is TJSONValue) then
  begin
    SetJSONValue( TJSONValue( Value ), AInstanceOwner );
  end
  else
    inherited;
end;

function TDBXJSONValue.IsNull: Boolean;
begin
  if (FdbxRow <> nil) and (FdbxRow.Generation <> self.FGeneration) then
    Result := FDbxRow.IsStoredNull(Self)
  else
    Result := FJsonValue = nil;
end;

{TDBXCallbackValue}

constructor TDBXCallbackValue.Create(const ValueType: TDBXValueType);
begin
  inherited Create(ValueType);
  FDbxCallback := TDBXCallbackDelegate.Create;
{$IFNDEF AUTOREFCOUNT}
  FDbxCallback.AddRef;
{$ENDIF !AUTOREFCOUNT}
end;

destructor TDBXCallbackValue.Destroy;
begin
{$IFNDEF AUTOREFCOUNT}
  FDbxCallback.Release;
{$ENDIF !AUTOREFCOUNT}
  FDbxCallback := nil;
end;

procedure TDBXCallbackValue.SetRowValue;
begin
  FDbxRow.SetCallbackValue(self, FDbxCallback);
end;

procedure TDBXCallbackValue.SetValue(const Value: TDBXValue);
begin
  if (Value = nil) or (Value.IsNull) then
  begin
{$IFNDEF AUTOREFCOUNT}
    if FDbxCallback <> nil then
      FDbxCallback.Release;
{$ENDIF !AUTOREFCOUNT}
    FDBXCallback := nil
  end
  else
    SetCallbackValue(Value.GetCallbackValue)
end;

function TDBXCallbackValue.IsNull: Boolean;
begin
  Result := FDbxCallback = nil;
end;

procedure TDBXCallbackValue.SetCallbackValue(const Value: TDBXCallback);
begin
{$IFNDEF AUTOREFCOUNT}
  if Value <> nil then
    Value.AddRef;
  FDbxCallback.Release;
{$ENDIF !AUTOREFCOUNT}
  FDbxCallback := Value;

  FIsNull := false;
  FSetPending := true;
end;

function TDBXCallbackValue.GetCallbackValue: TDBXCallback;
begin
  Result := FDbxCallback;
end;

procedure TDBXCallbackValue.SetOrdinal(const Ordinal: Integer);
begin
  if FDbxCallback <> nil then
    FDbxCallback.Ordinal := Ordinal;
end;

procedure TDBXCallbackValue.SetConnectionHandler(const ConnectionHandler: TObject);
begin
  if FDbxCallback <> nil then
    FDbxCallback.ConnectionHandler := ConnectionHandler;
end;

procedure TDBXCallbackValue.SetObjectValue(const Value: TObject; const AInstanceOwner: Boolean);
begin
  if (Value = nil) or (Value is TDBXCallback) then
  begin
    // AInstanceOwner flag is ignored
    SetCallbackValue( TDBXCallback( Value ) );
  end
  else
    inherited;
end;

function TDBXCallbackValue.CreateCallbackDelegate(ordinal: Integer): TDBXCallback;
begin
  FDbxCallback := TDBXCallbackDelegate.Create;
  FDbxCallback.Ordinal := ordinal;
{$IFNDEF AUTOREFCOUNT}
  FDbxCallback.AddRef;
{$ENDIF !AUTOREFCOUNT}
  Result := FDbxCallback;
end;

{TDBXCommunicatonLayer}

function TDBXCommunicationLayer.GetConnectTimeout: Integer;
begin
  Result := FConnectTimeout;
end;

procedure TDBXCommunicationLayer.SetConnectTimeout(Duration: Integer);
begin
  FConnectTimeout := Duration;
end;

procedure TDBXCommunicationLayer.Terminate;
begin
  FTerminated := true;
end;

{ TDBXScheduler }

procedure TDBXScheduler.AddEvent(Id: NativeInt; Proc: TDBXScheduleEvent; Delta: Integer);
var
  Rec: TDBXSchedulerRec;
  idx: Integer;
begin
  Rec := TDBXSchedulerRec.Create;
  Rec.FEvent := Proc;
  Rec.FTime := Now + Delta * MsToDay;
  Rec.FID := Id;

  idx := 0;
  FSync.Enter;
  try
    // find the position
    while (idx < FEvents.Count) and (FEvents[idx].FTime <= Rec.FTime) do
      Inc(idx);
    // if no events then start the thread
    if FEvents.Count = 0 then
    begin
      // insert the new event record
      FEvents.Insert(idx, Rec);
      StartSchedulerThread
    end
    else if idx > 0 then
      // insert the new event record
      FEvents.Insert(idx, Rec)
    else
    begin
      // re-start the wait
      TMonitor.Enter(FEventSemaphore);
      try
        // insert the new event record
        FEvents.Insert(idx, Rec);
        TMonitor.Pulse(FEventSemaphore);
      finally
        TMonitor.Exit(FEventSemaphore);
      end;
    end;
  finally
    FSync.Leave;
  end;
end;

function TDBXScheduler.CancelEvent(Id: NativeInt): Boolean;
var
  Rec: TDBXSchedulerRec;
begin
  FSync.Enter;
  try
    for Rec in FEvents do
      if Rec.FID = Id then
      begin
        Rec.FEvent := nil;
        Rec.FID := 0;
        exit(true);
      end;
  finally
    FSync.Leave;
  end;
  Result := false;
end;

procedure TDBXScheduler.CloseScheduler;
begin
  FSync.Enter;
  try
    FEvents.Clear;
  finally
    FSync.Leave;
  end;
end;

constructor TDBXScheduler.Create;
begin
  inherited;
  FEventSemaphore := TObject.Create;
  FSync := TCriticalSection.Create;
  FEvents := TObjectList<TDBXSchedulerRec>.Create;
end;

destructor TDBXScheduler.Destroy;
begin
  StopSchedulerThread;
  CloseScheduler;
  FEventSemaphore.Free;
  FSync.Free;
  FEvents.Free;
  FThread.Free;
  inherited;
end;

function TDBXScheduler.EventCount: Integer;
begin
  FSync.Enter;
  try
    Result := FEvents.Count;
  finally
    FSync.Leave;
  end;
end;

function TDBXScheduler.PeekEvent: TDBXScheduleEvent;
begin
  FSync.Enter;
  try
    if (FEvents.Count > 0) then
      result := FEvents[0].FEvent
    else
      result := nil
  finally
    FSync.Leave;
  end;
end;

function TDBXScheduler.PeekTime: TDateTime;
begin
  FSync.Enter;
  try
    if FEvents.Count > 0 then
      result := FEvents[0].FTime
    else
      result := 0
  finally
    FSync.Leave;
  end;
end;

procedure TDBXScheduler.Pop;
begin
  FSync.Enter;
  try
    if FEvents.Count > 0 then
      FEvents.Remove(FEvents.First);
  finally
    FSync.Leave;
  end;
end;

procedure TDBXScheduler.StartSchedulerThread;
begin
  StopSchedulerThread;
  FreeAndNil(FThread);
  FThread := TDBXSchedulerThread.Create(FEventSemaphore);
end;

procedure TDBXScheduler.StopSchedulerThread;
begin
  if FThread <> nil then
  begin
    FThread.Terminate;
    TMonitor.Enter(FEventSemaphore);
    try
      TMonitor.PulseAll(FEventSemaphore);
    finally
      TMonitor.Exit(FEventSemaphore);
    end;
    FThread.WaitFor;
  end;
end;

{ TDBXScheduler.TDBXSchedulerThread }

constructor TDBXScheduler.TDBXSchedulerThread.Create(EventSem: TObject);
begin
  FEventSemaphore := EventSem;
  inherited Create(false);
end;

procedure TDBXScheduler.TDBXSchedulerThread.Execute;
var
  nextEventTime: TDateTime;
  waitTime: Integer;
  status: Boolean;
  proc: TDBXScheduleEvent;
begin
{$IFNDEF POSIX}
  SetCurrentThreadName(DBXSchedulerThreadName);
{$ENDIF}
  while (not Terminated) do
  begin
    if TDBXScheduler.Instance.EventCount = 0 then
      Terminate
    else
    begin
      // get the next event time
      nextEventTime := TDBXScheduler.Instance.PeekTime;
      if nextEventTime > 0 then
      begin
        // calculate the miliseconds
        waitTime := Trunc((nextEventTime - Now) / MsToDay);
        // wait
        if waitTime > 0 then
        begin
          TMonitor.Enter(FEventSemaphore);
          try
            status := TMonitor.Wait(FEventSemaphore, waitTime)
          finally
            TMonitor.Exit(FEventSemaphore);
          end;
        end
        else
          status := False;
        if not Terminated then
          if status = True then
            FLastFailure := nextEventTime
          else if status = False then
          begin
            // if timeout execute the event and pop it
            proc := TDBXScheduler.Instance.PeekEvent();
            try
              try
                if Assigned(proc) then
                  proc;
              except
                FLastFailure := nextEventTime
              end;
            finally
              TDBXScheduler.Instance.Pop
            end
          end
      end
      else
        TDBXScheduler.Instance.Pop
    end
  end;
end;

{$IFNDEF POSIX}
procedure TDBXScheduler.TDBXSchedulerThread.SetCurrentThreadName(const Name: string);
type
  TThreadNameInfo =
    record
      RecType: LongWord;
      Name: PChar;
      ThreadID: LongWord;
      Flags: LongWord;
    end;
var
  info:TThreadNameInfo;
begin
  // This code is extremely strange, but it's the documented way of doing it!
  info.RecType:=$1000;
  info.Name:=PChar(Name);
  info.ThreadID:=$FFFFFFFF;
  info.Flags:=0;
  try
    RaiseException($406D1388, 0,
      SizeOf(info) div SizeOf(LongWord), PUINT_PTR(@info));
  except
  end;
end;
{$ENDIF}

{ TDBXUInt16Value }

function TDBXUInt16Value.Compare(Other: TDBXValue): Smallint;
begin
  if AsUInt16 = Other.AsUInt16 then
    Result := 0
  else if AsUInt16 < Other.AsUInt16 then
    Result := -1
  else
    Result := 1
end;

procedure TDBXUInt16Value.CopyRowValue(Row: TDBXRow);
begin
  if IsNull then
    Row.SetNull(Self)
  else
    Row.SetUInt16(Self, GetUInt16);
end;

function TDBXUInt16Value.GetAsBcd: TBcd;
begin
  Result := IntegerToBcd(GetUInt16);
end;

function TDBXUInt16Value.GetAsBoolean: Boolean;
begin
  Result := GetUInt16 <> 0;
end;

function TDBXUInt16Value.GetAsDouble: Double;
begin
  Result := GetUInt16;
end;

function TDBXUInt16Value.GetAsInt16: SmallInt;
begin
  Result := GetUInt16;
end;

function TDBXUInt16Value.GetAsInt32: TInt32;
begin
  Result := GetUInt16;
end;

function TDBXUInt16Value.GetAsInt64: Int64;
begin
  Result := GetUInt16;
end;

function TDBXUInt16Value.GetAsInt8: ShortInt;
begin
  Result := GetUInt16;
end;

function TDBXUInt16Value.GetAsSingle: Single;
begin
  Result := GetUInt16;
end;

function TDBXUInt16Value.GetAsString: string;
begin
  Result := IntToStr(GetUInt16);
end;

function TDBXUInt16Value.GetAsUInt16: Word;
begin
  Result := GetUInt16;
end;

function TDBXUInt16Value.GetAsUInt8: Byte;
begin
  Result := GetUInt16;
end;

function TDBXUInt16Value.GetUInt16: Word;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetUInt16(Self, FUInt16, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FUInt16;
end;

function TDBXUInt16Value.IsNull: Boolean;
begin
  if (FDbxRow <> nil) and (FGeneration <> FDbxRow.Generation) then
  begin
    FDbxRow.GetUInt16(Self, FUInt16, FIsNull);
    FGeneration := FDbxRow.Generation;
  end;
  Result := FIsNull;
end;

procedure TDBXUInt16Value.SetAsBcd(const Value: TBcd);
var
  IntValue: Integer;
begin
  IntValue := BcdToInteger(Value);
  if (IntValue >= Low(Word)) and (IntValue <= High(Word)) then
    SetUInt16(IntValue)
  else
    inherited;
end;

procedure TDBXUInt16Value.SetAsBoolean(const Value: Boolean);
begin
  SetUInt16(Ord(Value));
end;

procedure TDBXUInt16Value.SetAsDouble(const Value: Double);
begin
  if (Value >= Low(Word)) and (Value <= High(Word)) then
    SetUInt16(Round(Value))
  else
    inherited;
end;

procedure TDBXUInt16Value.SetAsInt16(const Value: SmallInt);
begin
  if Value >= SmallInt(Low(Word)) then
    SetUInt16(Value)
  else
    inherited;
end;

procedure TDBXUInt16Value.SetAsInt32(const Value: TInt32);
begin
  if (Value >= Low(Word)) and (Value < High(Word)) then
    SetUInt16(Value)
  else
    inherited;
end;

procedure TDBXUInt16Value.SetAsInt64(const Value: Int64);
begin
  if (Value >= Low(Word)) and (Value < High(Word)) then
    SetUInt16(Value)
  else
    inherited;
end;

procedure TDBXUInt16Value.SetAsInt8(const Value: ShortInt);
begin
  if Value >= ShortInt(Low(Word)) then
    SetUInt16(Value)
  else
    inherited;
end;

procedure TDBXUInt16Value.SetAsSingle(const Value: Single);
begin
  if (Value >= Low(Word)) and (Value <= High(Word)) then
    SetUInt16(Round(Value))
  else
    inherited;
end;

procedure TDBXUInt16Value.SetAsString(const Value: string);
var
  IntValue: LongInt;
begin
  IntValue := StrToInt(Value);
  if (IntValue >= Low(Word)) and (IntValue <= High(Word)) then
    SetUInt16(IntValue)
  else
    inherited;
end;

procedure TDBXUInt16Value.SetAsUInt16(const Value: Word);
begin
  SetUInt16(Value);
end;

procedure TDBXUInt16Value.SetAsUInt8(const Value: Byte);
begin
  SetUInt16(Value);
end;

procedure TDBXUInt16Value.SetRowValue;
begin
  FDbxRow.SetUInt16(Self, FUInt16);
end;

procedure TDBXUInt16Value.SetUInt16(const Value: Word);
begin
  FIsNull := false;
  FUInt16 := Value;
  FSetPending := true;
  if FDbxRow <> nil then
  begin
    FGeneration := FDbxRow.Generation;
    FDbxRow.ValueSet(Self);
  end;
end;

procedure TDBXUInt16Value.SetValue(const Value: TDBXValue);
begin
  if Value.IsNull then
    SetNull
  else
    SetUInt16(Value.GetAsUInt16);
end;

{ TX509Certificate }

function TX509Certificate.GetType: string;
begin
  Result := 'X.509';
end;

procedure InitializeConnectionFactorySingletonFromIniFile(const DriverFileName, ConnectionFileName: string);
begin
  if TDBXConnectionFactory.ConnectionFactorySingleton = nil then
    TDBXConnectionFactory.ConnectionFactorySingleton := TDBXConnectionFactory.OpenConnectionFactory(DriverFileName, ConnectionFileName);
end;

{ TEventsCollection }

constructor TEventsCollection.Create;
begin
  inherited;
  FEvents := TDictionary<string, TEventPointer>.Create;
end;

destructor TEventsCollection.Destroy;
begin
  FEvents.Free;
  inherited;
end;

function TEventsCollection.GetEvent(const AName: string): TEventPointer;
begin
  if not FEvents.TryGetValue(AName, Result) then
    Result := nil;
end;

procedure TEventsCollection.SetEvent(const AName: string; AValue: TEventPointer);
begin
  FEvents.AddOrSetValue(AName, AValue);
end;

procedure TEventsCollection.SetValues(Collection: TDictionary<string, TEventPointer>);
var
  Key: string;
  Val: TEventPointer;
begin
  //clear any previously held events
  FEvents.Clear;

  //iterate over the values of the collection and store them here
  if Assigned(Collection) then
  begin
    for Key In Collection.Keys do
    begin
      if Collection.TryGetValue(Key, Val) then
        FEvents.Add(Key, Val);
    end;
  end;
end;

initialization
  TDBXScheduler.FInstance := TDBXScheduler.Create;
  if TDBXDriverRegistry.DBXDriverRegistry = nil then
    TDBXDriverRegistry.DBXDriverRegistry := TDBXDriverRegistry.Create;
  TDBXDefaultFormatter.FDBXDefaultFormatterSingletonOwned := false;
finalization
  TDBXDriverRegistry.DBXDriverRegistry.CloseAllDrivers;
                                                                                 
  FreeAndNil(TDBXDriverRegistry.DBXDriverRegistry);
  FreeAndNil(TDBXConnectionFactory.ConnectionFactorySingleton);
  if TDBXDefaultFormatter.FDBXDefaultFormatterSingletonOwned then
    FreeAndNil(TDBXDefaultFormatter.FDBXDefaultFormatterSingleton);
  FreeAndNil(TDBXScheduler.FInstance);
end.


