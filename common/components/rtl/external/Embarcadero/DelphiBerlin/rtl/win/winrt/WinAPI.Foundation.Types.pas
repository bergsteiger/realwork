{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Foundation.Types;

{$HPPEMIT NOUSINGNAMESPACE}

interface

{$MINENUMSIZE 4}

uses
  Winapi.Winrt,
  System.Types;

{$SCOPEDENUMS ON}

type
  // Windows.Foundation Enums
  // Windows.Foundation.Metadata.GCPressureAmount
  Metadata_GCPressureAmount = (
    Low = 0,
    Medium = 1,
    High = 2
  );
  PMetadata_GCPressureAmount = ^Metadata_GCPressureAmount;

  // Windows.Foundation.PropertyType
  PropertyType = (
    Empty = 0,
    UInt8 = 1,
    Int16 = 2,
    UInt16 = 3,
    Int32 = 4,
    UInt32 = 5,
    Int64 = 6,
    UInt64 = 7,
    Single = 8,
    Double = 9,
    Char16 = 10,
    Boolean = 11,
    &String = 12,
    Inspectable = 13,
    DateTime = 14,
    TimeSpan = 15,
    Guid = 16,
    Point = 17,
    Size = 18,
    Rect = 19,
    OtherType = 20,
    UInt8Array = 1025,
    Int16Array = 1026,
    UInt16Array = 1027,
    Int32Array = 1028,
    UInt32Array = 1029,
    Int64Array = 1030,
    UInt64Array = 1031,
    SingleArray = 1032,
    DoubleArray = 1033,
    Char16Array = 1034,
    BooleanArray = 1035,
    StringArray = 1036,
    InspectableArray = 1037,
    DateTimeArray = 1038,
    TimeSpanArray = 1039,
    GuidArray = 1040,
    PointArray = 1041,
    SizeArray = 1042,
    RectArray = 1043,
    OtherTypeArray = 1044
  );
  PPropertyType = ^PropertyType;

  // Windows.Foundation.Metadata.Platform
  Metadata_Platform = (
    Windows = 0,
    WindowsPhone = 1
  );
  PMetadata_Platform = ^Metadata_Platform;

  // Windows.Foundation.Metadata.AttributeTargets
  Metadata_AttributeTargets = (
    All = -1,
    Delegate = 1,
    Enum = 2,
    Event = 4,
    Field = 8,
    &Interface = 16,
    Method = 64,
    Parameter = 128,
    &Property = 256,
    RuntimeClass = 512,
    Struct = 1024,
    InterfaceImpl = 2048,
    ApiContract = 8192
  );
  PMetadata_AttributeTargets = ^Metadata_AttributeTargets;

  // Windows.Foundation.Metadata.CompositionType
  Metadata_CompositionType = (
    Protected = 1,
    Public = 2
  );
  PMetadata_CompositionType = ^Metadata_CompositionType;

  // Windows.Foundation.Metadata.ThreadingModel
  Metadata_ThreadingModel = (
    STA = 1,
    MTA = 2,
    Both = 3,
    InvalidThreading = 0
  );
  PMetadata_ThreadingModel = ^Metadata_ThreadingModel;

  // Windows.Foundation.Metadata.MarshalingType
  Metadata_MarshalingType = (
    None = 1,
    Agile = 2,
    Standard = 3,
    InvalidMarshaling = 0
  );
  PMetadata_MarshalingType = ^Metadata_MarshalingType;

  // Windows.Foundation.Metadata.DeprecationType
  Metadata_DeprecationType = (
    Deprecate = 0,
    Remove = 1
  );
  PMetadata_DeprecationType = ^Metadata_DeprecationType;

  // Windows.Foundation.AsyncStatus
  AsyncStatus = (
    Canceled = 2,
    Completed = 1,
    Error = 3,
    Started = 0
  );
  PAsyncStatus = ^AsyncStatus;

  // Windows.Foundation.Diagnostics.CausalityTraceLevel
  Diagnostics_CausalityTraceLevel = (
    Required = 0,
    Important = 1,
    Verbose = 2
  );
  PDiagnostics_CausalityTraceLevel = ^Diagnostics_CausalityTraceLevel;

  // Windows.Foundation.Diagnostics.CausalitySource
  Diagnostics_CausalitySource = (
    Application = 0,
    &Library = 1,
    System = 2
  );
  PDiagnostics_CausalitySource = ^Diagnostics_CausalitySource;

  // Windows.Foundation.Diagnostics.CausalityRelation
  Diagnostics_CausalityRelation = (
    AssignDelegate = 0,
    Join = 1,
    Choice = 2,
    Cancel = 3,
    Error = 4
  );
  PDiagnostics_CausalityRelation = ^Diagnostics_CausalityRelation;

  // Windows.Foundation.Diagnostics.CausalitySynchronousWork
  Diagnostics_CausalitySynchronousWork = (
    CompletionNotification = 0,
    ProgressNotification = 1,
    Execution = 2
  );
  PDiagnostics_CausalitySynchronousWork = ^Diagnostics_CausalitySynchronousWork;

  // Windows.Foundation.Diagnostics.ErrorOptions
  Diagnostics_ErrorOptions = (
    None = 0,
    SuppressExceptions = 1,
    ForceExceptions = 2,
    UseSetErrorInfo = 4,
    SuppressSetErrorInfo = 8
  );
  PDiagnostics_ErrorOptions = ^Diagnostics_ErrorOptions;

  // Windows.Foundation.Diagnostics.LoggingLevel
  Diagnostics_LoggingLevel = (
    Verbose = 0,
    Information = 1,
    Warning = 2,
    Error = 3,
    Critical = 4
  );
  PDiagnostics_LoggingLevel = ^Diagnostics_LoggingLevel;

  // Windows.Foundation.Diagnostics.LoggingOpcode
  Diagnostics_LoggingOpcode = (
    Info = 0,
    Start = 1,
    Stop = 2,
    Reply = 6,
    Resume = 7,
    Suspend = 8,
    Send = 9
  );
  PDiagnostics_LoggingOpcode = ^Diagnostics_LoggingOpcode;

  // Windows.Foundation.Diagnostics.LoggingFieldFormat
  Diagnostics_LoggingFieldFormat = (
    Default = 0,
    Hidden = 1,
    &String = 2,
    Boolean = 3,
    Hexadecimal = 4,
    ProcessId = 5,
    ThreadId = 6,
    Port = 7,
    Ipv4Address = 8,
    Ipv6Address = 9,
    SocketAddress = 10,
    Xml = 11,
    Json = 12,
    Win32Error = 13,
    NTStatus = 14,
    HResult = 15,
    FileTime = 16,
    Signed = 17,
    Unsigned = 18
  );
  PDiagnostics_LoggingFieldFormat = ^Diagnostics_LoggingFieldFormat;


  // Windows.Foundation Records
  // Windows.Foundation.DateTime
  DateTime = record
    UniversalTime: Int64;
  end;
  PDateTime = ^DateTime;

  // Windows.Foundation.TimeSpan
  TimeSpan = record
    Duration: Int64;
  end;
  PTimeSpan = ^TimeSpan;

  // Windows.Foundation.EventRegistrationToken
  EventRegistrationToken = record
    Value: Int64;
  end;
  PEventRegistrationToken = ^EventRegistrationToken;

  // Windows.Foundation.FoundationContract
  FoundationContract = record
  end;
  PFoundationContract = ^FoundationContract;

  // Windows.Foundation.Numerics.Vector2
  Numerics_Vector2 = record
    X: Single;
    Y: Single;
  end;
  PNumerics_Vector2 = ^Numerics_Vector2;

  // Windows.Foundation.Numerics.Vector3
  Numerics_Vector3 = record
    X: Single;
    Y: Single;
    Z: Single;
  end;
  PNumerics_Vector3 = ^Numerics_Vector3;

  // Windows.Foundation.Numerics.Vector4
  Numerics_Vector4 = record
    X: Single;
    Y: Single;
    Z: Single;
    W: Single;
  end;
  PNumerics_Vector4 = ^Numerics_Vector4;

  // Windows.Foundation.Numerics.Matrix3x2
  Numerics_Matrix3x2 = record
    M11: Single;
    M12: Single;
    M21: Single;
    M22: Single;
    M31: Single;
    M32: Single;
  end;
  PNumerics_Matrix3x2 = ^Numerics_Matrix3x2;

  // Windows.Foundation.Numerics.Matrix4x4
  Numerics_Matrix4x4 = record
    M11: Single;
    M12: Single;
    M13: Single;
    M14: Single;
    M21: Single;
    M22: Single;
    M23: Single;
    M24: Single;
    M31: Single;
    M32: Single;
    M33: Single;
    M34: Single;
    M41: Single;
    M42: Single;
    M43: Single;
    M44: Single;
  end;
  PNumerics_Matrix4x4 = ^Numerics_Matrix4x4;

  // Windows.Foundation.Numerics.Plane
  Numerics_Plane = record
    Normal: Numerics_Vector3;
    D: Single;
  end;
  PNumerics_Plane = ^Numerics_Plane;

  // Windows.Foundation.Numerics.Quaternion
  Numerics_Quaternion = record
    X: Single;
    Y: Single;
    Z: Single;
    W: Single;
  end;
  PNumerics_Quaternion = ^Numerics_Quaternion;

  // Windows.Foundation.UniversalApiContract
  UniversalApiContract = record
  end;
  PUniversalApiContract = ^UniversalApiContract;


implementation

end.
