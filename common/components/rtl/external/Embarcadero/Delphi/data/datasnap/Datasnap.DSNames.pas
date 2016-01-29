{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Datasnap.DSNames;

interface

uses
  Data.DBXCommon;

type
  
  /// <summary> 
  ///  String representation of server methods that can be called in the built-in
  ///  <c>DSAdmin</c> server class.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSAdminMethods = class
  public
    const CreateServerClasses = 'DSAdmin.CreateServerClasses';
    const CreateServerMethods = 'DSAdmin.CreateServerMethods';
    const FindClasses = 'DSAdmin.FindClasses';
    const FindMethods = 'DSAdmin.FindMethods';
    const FindPackages = 'DSAdmin.FindPackages';
    const GetPlatformName = 'DSAdmin.GetPlatformName';
    const GetServerClasses = 'DSAdmin.GetServerClasses';
    const GetServerMethods = 'DSAdmin.GetServerMethods';
    const GetServerMethodParameters = 'DSAdmin.GetServerMethodParameters';
    const DropServerClasses = 'DSAdmin.DropServerClasses';
    const DropServerMethods = 'DSAdmin.DropServerMethods';
    const GetDatabaseConnectionProperties = 'DSAdmin.GetDatabaseConnectionProperties';
  end;

  
  /// <summary>
  ///  Currently not used.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSCacheColumns = class
  public
    const CacheName = 'CacheName';
    const MaxReaders = 'MaxReaders';
    const MaxReaderBytes = 'MaxReaderBytes';
    const MaxLifeTime = 'MaxLifeTime';
    const CacheData = 'CacheData';
    const HitCount = 'HitCount';
    const MissCount = 'MissCount';
    const ExpirationCount = 'ExpirationCount';
  end;

  
  /// <summary> 
  ///  Columns used by TDSClassEntity collection.
  /// </summary>
  TDSClassColumns = class
  public
    
    /// <summary> Name of the deployment unit that contains the code for
    ///  methods executed remotely.
    /// </summary>
    /// <remarks>  On the win32/64 platform this
    ///  there is only one since all classes are accessed through the
    ///  <c>TPersistent</c> registry.  On the .net
    ///  platform this will be the name of an assembly.  On the Java
    ///  platform this will be the name of a jar file.
    /// </remarks>
    const PackageName = 'PackageName';
    
    /// <summary> Name of a class that public methods can be called from remote clients.
    /// </summary>
    const ServerClassName = 'ClassName';
    
    /// <summary> Role name used for security purposes to restrict access
    ///  to remote clients.
    /// </summary>
    const RoleName = 'RoleName';
    
    /// <summary> Life cycle management for instances of class that remote
    ///  clients execute methods against.
    /// </summary>
    const LifeCycle = 'LifeCycle';
  end;

  
  /// <summary> 
  ///  Columns used by TDSConnectionEntity collection.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSConnectionColumns = class
  public
    
    /// <summary> Connection name
    /// </summary>
    const ConnectionName = 'ConnectionName';
    
    /// <summary> Semicolon separated list of connection properties.
    /// </summary>
    const ConnectionProperties = 'ConnectionProperties';
    
    /// <summary> Driver name
    /// </summary>
    const DriverName = 'DriverName';
    
    /// <summary> Semicolon separated list of driver properties.
    /// </summary>
    const DriverProperties = 'DriverProperties';
  end;

  
  /// <summary> 
  ///  Property values used by TDSCustomServerClass lifecycle property.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSLifeCycle = class
  public
    
    /// <summary> One component instance is used per server. 
    /// </summary>
    /// <remarks> 
    /// </remarks>
    const Server = 'Server';
    
    /// <summary> One component instance is used per DataSnapSession.
    /// </summary>
    const Session = 'Session';
    
    /// <summary> One component instance is used per invocation of a method.
    /// </summary>
    const Invocation = 'Invocation';
  end;

  
  /// <summary> 
  ///  Method names used by TDSMetadata server class.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSMetadataMethods = class(TObject)
  public
    const GetDatabase = 'DSMetadata.' + TDBXMetaDataCommands.GetDatabase;
    const GetProcedures = 'DSMetadata.' + TDBXMetaDataCommands.GetProcedures;
    const GetProcedureParameters = 'DSMetadata.' + TDBXMetaDataCommands.GetProcedureParameters;
  end;

  
  /// <summary> 
  ///  Columns used by the TDSMethodEntity collection.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSMethodColumns = class
  public
    
    /// <summary> Name of the server method used by client.
    /// </summary>
    const MethodAlias = 'MethodAlias';
    
    /// <summary> Name of a class that public methods can be called from remote clients.
    /// </summary>
    const ServerClassName = 'ServerClassName';
    
    /// <summary> Name of method to be called.
    /// </summary>
    const ServerMethodName = 'MethodName';
    
    /// <summary> Role name used for security purposes to restrict access
    ///  to remote clients.
    /// </summary>
    const RoleName = 'RoleName';
  end;

  TDSMethodParametersColumns = class
  public
    
    /// <summary> Name of the server method used by client.
    /// </summary>
    const MethodAlias = 'MethodAlias';
    
    /// <summary> Name of a class that public methods can be called from remote clients.
    /// </summary>
    const ServerClassName = 'ServerClassName';
    
    /// <summary> Name of method to be called.
    /// </summary>
    const ServerMethodName = 'MethodName';
    
    /// <summary> Name of the parameter.
    /// </summary>
    const ParameterName = 'Name';
    
    /// <summary> Data type name of the parameter.
    /// </summary>
    const ParameterTypeName = 'ParameterTypeName';
    
    /// <summary> Parameter's type unit name, introduced due to user objects
    /// </summary>
    const ParameterTypeUnit = 'ParameterTypeUnit';
    
    /// <summary> One of the constants in <c>DBXParameterDirections</c> class.
    /// </summary>
    const ParameterDirection = 'ParameterDirection';
    
    /// <summary> <c>DBXDataTypes</c> type that used for this parameter type.
    /// </summary>
    const DbxDataType = 'DBXType';
    
    /// <summary> One of the constants in <c>DBXParameterDirections</c> class.
    /// </summary>
    /// <remarks> This will be the same as <c>PARAMETER_DIRECTION</c> except for paramters of type
    ///  <c>DBX*Value</c>.  <c>DBX*Value</c> type parameters always have a <c>DBX_PARAMETER_DIRECTION</c>
    ///  of <c>DBXParameterDirection.IN_OUT_PARAMETER</c>
    /// </remarks>
    const DbxParameterDirection = 'DBXParameterDirection';
  end;

  
  /// <summary> 
  ///  Columns used by the TDSPackageEntity collection.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSPackageColumns = class
  public
    
    /// <summary> Name of the deployment unit that contains the code for
    ///  methods executed remotely.
    /// </summary>
    /// <remarks>  On the win32/64 platform this
    ///  there is only one since all classes are accessed through the
    ///  <c>TPersistent</c> registry.  On the .net
    ///  platform this will be the name of an assembly.  On the Java
    ///  platform this will be the name of a jar file.
    /// </remarks>
    const PackageName = 'PackageName';
  end;

implementation

end.


