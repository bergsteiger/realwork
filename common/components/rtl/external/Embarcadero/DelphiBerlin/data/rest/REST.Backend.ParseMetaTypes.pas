{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.ParseMetaTypes;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  REST.Backend.Providers,
  REST.Backend.MetaTypes,
  REST.Backend.ParseProvider,
  REST.Backend.ParseApi;

type

  /// <summary>Describe a backend object</summary>
  TMetaObject = class(TInterfacedObject, IBackendMetaObject)
  private
    FObjectID: TParseAPI.TObjectID;
  protected
    function GetObjectID: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
    function GetClassName: string;
  public
    constructor Create(const AObjectID: TParseAPI.TObjectID);
    property ObjectID: TParseAPI.TObjectID read FObjectID;
  end;

  /// <summary>Define MetaObject with ObjectID and CreatedAt properties</summary>
  TMetaCreatedObject = class(TMetaObject, IBackendMetaObject,
     IBackendObjectID, IBackendClassName, IBackendCreatedAt)
  end;

  /// <summary>Define MetaObject with ObjectID and BackendClassName properties</summary>
  TMetaClassObject = class(TMetaObject, IBackendMetaObject, IBackendClassName,
     IBackendObjectID, IBackendCreatedAt, IBackendUpdatedAt)
  end;

  /// <summary>Define MetaObject with UpdatedAt properties</summary>
  TMetaUpdatedObject = class(TInterfacedObject, IBackendMetaObject)
  private
    FUpdatedAt: TParseAPI.TUpdatedAt;
  protected
    function GetObjectID: string;
    function GetUpdatedAt: TDateTime;
    function GetClassName: string;
  public
    constructor Create(const AUpdatedAt: TParseAPI.TUpdatedAt);
    property ObjectID: TParseAPI.TUpdatedAt read FUpdatedAt;
  end;

  /// <summary>Describe a user object</summary>
  TMetaUser = class(TInterfacedObject, IBackendMetaObject)
  private
    FUser: TParseAPI.TUser;
  protected
    function GetObjectID: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
    function GetUserName: string;
  public
    constructor Create(const AUser: TParseAPI.TUser);
    property User: TParseAPI.TUser read FUser;
  end;

  /// <summary>Describe an uploaded file</summary>
  TMetaFile = class(TInterfacedObject, IBackendMetaObject)
  private
    FFile: TParseAPI.TFile;
  protected
    function GetDownloadURL: string;
    function GetFileName: string;
    function GetFileID: string;
  public
    constructor Create(const AFile: TParseAPI.TFile); overload;
    constructor Create(const AFileID: string); overload;
    property FileValue: TParseAPI.TFile read FFile;
  end;

  /// <summary>Define MetaObject with ObjectID</summary>
  TMetaObjectID = class(TMetaObject, IBackendMetaObject,
     IBackendObjectID)
  end;

  /// <summary>Define MetaObject with ObjectID and BackendClassName properties</summary>
  TMetaUserObject = class(TMetaUser, IBackendMetaObject,
     IBackendObjectID)
  end;

  /// <summary>Describe a logged in user</summary>
  TMetaLogin = class(TMetaUser)
  private
    FLogin: TParseAPI.TLogin;
  protected
    function GetAuthTOken: string;
  public
    constructor Create(const ALogin: TParseAPI.TLogin);
    property Login: TParseAPI.TLogin read FLogin;
  end;

  TMetaFoundObject = class(TMetaObject, IBackendMetaObject, IBackendClassName,
     IBackendObjectID, IBackendCreatedAt, IBackendUpdatedAt)
  end;

  TMetaUploadedFile = class(TMetaFile, IBackendMetaObject, IBackendFileID, IBackendFileName,
     IBackendDownloadURL)
  end;

  TMetaFileObject = class(TMetaFile, IBackendMetaObject, IBackendFileID)
  end;

  /// <summary> Define MetaObject with UpdatedAt properties</summary>
  TMetaUpdatedUser = class(TMetaUser, IBackendMetaObject, IBackendUpdatedAt, IBackendUserName)
  end;

  TMetaFoundUser = class(TMetaUser, IBackendMetaObject,
     IBackendObjectID, IBackendCreatedAt, IBackendUpdatedAt, IBackendUserName)
  end;

  TMetaLoginUser = class(TMetaLogin, IBackendMetaObject,
     IBackendObjectID, IBackendCreatedAt, IBackendUpdatedAt, IBackendUserName, IBackendAuthToken)
  end;

  TMetaSignupUser = class(TMetaLogin, IBackendMetaObject,
     IBackendObjectID, IBackendCreatedAt, IBackendUserName, IBackendAuthToken)
  end;

  /// <summary>Describe a backend storage class</summary>
  TMetaClass = class(TInterfacedObject, IBackendMetaObject)
  private
    FClassName: string;
    FDataType: string;
  protected
    function GetClassName: string;
    function GetDataType: string;
  public
    constructor Create(const AClassName: string); overload;
    constructor Create(const ADataType, AClassName: string); overload;
  end;

  /// <summary>Define backend class with ClassName property</summary>
  TMetaClassName = class(TMetaClass, IBackendMetaClass, IBackendClassName)
  end;

  /// <summary>Defined backend class with ClassName and DataType property</summary>
  TMetaDataType = class(TMetaClass, IBackendMetaClass, IBackendClassName, IBackendDataType)
  end;

  TMetaFactory = class(TInterfacedObject, IBackendMetaFactory, IBackendMetaClassFactory,
    IBackendMetaClassObjectFactory, IBackendMetaDataTypeFactory, IBackendMetaFileFactory)
  protected
    { IBackendMetaClassFactory }
    function CreateMetaClass(const AClassName: string): TBackendMetaClass;
    { IBackendMetaClassObjectFactory }
    function CreateMetaClassObject(const AClassName, AObjectID: string): TBackendEntityValue;
    { IBackendMetaDataTypeFactory }
    function CreateMetaDataType(const ADataType, ABackendClassName: string): TBackendMetaClass;
    { IBackendMetaFileFactory }
    function CreateMetaFileObject(const AFileID: string): TBackendEntityValue;
  end;

  TParseMetaFactory = class
  public
    // Class
    class function CreateMetaClass(const AClassName: string): TBackendMetaClass; static;
    class function CreateMetaDataType(const ADataType, AClassName: string): TBackendMetaClass; overload; static;
    // Object
     class function CreateMetaClassObject(const AClassName, AObjectID: string): TBackendEntityValue; overload;static;
    class function CreateMetaClassObject(const AObjectID: TParseAPI.TObjectID): TBackendEntityValue; overload;static;
    class function CreateMetaCreatedObject(
      const AObjectID: TParseAPI.TObjectID): TBackendEntityValue; static;
    class function CreateMetaFoundObject(const AObjectID: TParseAPI.TObjectID): TBackendEntityValue; static;
    class function CreateMetaUpdatedObject(const AUpdatedAt: TParseAPI.TUpdatedAt): TBackendEntityValue; static;
   // User
    class function CreateMetaUpdatedUser(const AUpdatedAt: TParseAPI.TUpdatedAt): TBackendEntityValue; overload; static;
    class function CreateMetaSignupUser(const ALogin: TParseAPI.TLogin): TBackendEntityValue; overload; static;
    class function CreateMetaLoginUser(const ALogin: TParseAPI.TLogin): TBackendEntityValue; overload; static;
    class function CreateMetaFoundUser(const AUser: TParseAPI.TUser): TBackendEntityValue; static;
    // Files
    class function CreateMetaUploadedFile(const AFile: TParseAPI.TFile): TBackendEntityValue; static;
    class function CreateMetaFileObject(const AFileID: string): TBackendEntityValue;
  end;

implementation

{ TMetaCreatedObject }

constructor TMetaObject.Create(const AObjectID: TParseAPI.TObjectID);
begin
  inherited Create;
  FObjectID := AObjectID;
end;

function TMetaObject.GetCreatedAt: TDateTime;
begin
  Result := FObjectID.CreatedAt;
end;

function TMetaObject.GetObjectID: string;
begin
  Result := FObjectID.ObjectID;
end;

function TMetaObject.GetUpdatedAt: TDateTime;
begin
  Result := FObjectID.UpdatedAt;
end;

function TMetaObject.GetClassName: string;
begin
  Result := FObjectID.BackendClassName;
end;

{ TMetaClass }

constructor TMetaClass.Create(const AClassName: string);
begin
  inherited Create;
  FClassName := AClassName;
end;

constructor TMetaClass.Create(const ADataType, AClassName: string);
begin
  Create(AClassName);
  FDataType := ADataType;
end;

function TMetaClass.GetClassName: string;
begin
  Result := FClassName;
end;

function TMetaClass.GetDataType: string;
begin
  Result := FDataType;
end;

{ TMetaFactory }

function TMetaFactory.CreateMetaClass(
  const AClassName: string): TBackendMetaClass;
begin
  Result := TParseMetaFactory.CreateMetaClass(AClassName);
end;

function TMetaFactory.CreateMetaClassObject(
  const AClassName: string; const AObjectID: string): TBackendEntityValue;
begin
  Result := TParseMetaFactory.CreateMetaClassObject(AClassName, AObjectID);
end;

function TMetaFactory.CreateMetaDataType(const ADataType,
  ABackendClassName: string): TBackendMetaClass;
begin
  Result := TParseMetaFactory.CreateMetaDataType(ADataType, ABackendClassName);
end;

function TMetaFactory.CreateMetaFileObject(
  const AFileID: string): TBackendEntityValue;
begin
  Result := TParseMetaFactory.CreateMetaFileObject(AFileID);
end;

{ TParseMetaFactory }

class function TParseMetaFactory.CreateMetaClass(
  const AClassName: string): TBackendMetaClass;
var
  LIntf: IBackendMetaClass;
begin
  LIntf := TMetaClassName.Create(AClassName);
  Assert(Supports(LIntf, IBackendClassName));
  Result := TBackendMetaClass.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaClassObject(
  const AClassName: string; const AObjectID: string): TBackendEntityValue;
var
  LObjectID: TParseAPI.TObjectID;
begin
  LObjectID := TParseAPI.TObjectID.Create(AClassName, AObjectID);
  Result := CreateMetaClassObject(LObjectID);
end;

class function TParseMetaFactory.CreateMetaClassObject(
  const AObjectID: TParseAPI.TObjectID): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaClassObject.Create(AObjectID);
  Assert(Supports(LIntf, IBackendClassName));
  Assert(Supports(LIntf, IBackendObjectID));
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaCreatedObject(
  const AObjectID: TParseAPI.TObjectID): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaCreatedObject.Create(AObjectID);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaDataType(const ADataType,
  AClassName: string): TBackendMetaClass;
var
  LIntf: IBackendMetaClass;
begin
  LIntf := TMetaDataType.Create(ADataType, AClassName);
  Result := TBackendMetaClass.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaFileObject(
  const AFileID: string): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFileObject.Create(AFileID);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaFoundObject(
  const AObjectID: TParseAPI.TObjectID): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundObject.Create(AObjectID);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaFoundUser(
  const AUser: TParseAPI.TUser): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundUser.Create(AUser);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaLoginUser(
  const ALogin: TParseAPI.TLogin): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaLoginUser.Create(ALogin);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaSignupUser(
  const ALogin: TParseAPI.TLogin): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaSignupUser.Create(ALogin);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaUpdatedObject(
  const AUpdatedAt: TParseAPI.TUpdatedAt): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUpdatedObject.Create(AUpdatedAt);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaUpdatedUser(
  const AUpdatedAt: TParseAPI.TUpdatedAt): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUpdatedObject.Create(AUpdatedAt);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TParseMetaFactory.CreateMetaUploadedFile(
  const AFile: TParseAPI.TFile): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUploadedFile.Create(AFile);
  Result := TBackendEntityValue.Create(LIntf);
end;

{ TMetaUpdateObject }

constructor TMetaUpdatedObject.Create(const AUpdatedAt: TParseAPI.TUpdatedAt);
begin
  FUpdatedAt := AUpdatedAt;
end;

function TMetaUpdatedObject.GetClassName: string;
begin
  Result := FUpdatedAt.BackendClassName;
end;

function TMetaUpdatedObject.GetObjectID: string;
begin
  Result := FUpdatedAt.ObjectID;
end;

function TMetaUpdatedObject.GetUpdatedAt: TDateTime;
begin
  Result := FUpdatedAt.UpdatedAt;
end;

{ TMetaUser }

constructor TMetaUser.Create(const AUser: TParseAPI.TUser);
begin
  FUser := AUser;
end;

function TMetaUser.GetCreatedAt: TDateTime;
begin
  Result := FUser.CreatedAt;
end;

function TMetaUser.GetObjectID: string;
begin
  Result := FUser.ObjectID;
end;

function TMetaUser.GetUpdatedAt: TDateTime;
begin
  Result := FUser.UpdatedAt;
end;

function TMetaUser.GetUserName: string;
begin
  Result := FUser.UserName;
end;

{ TMetaLogin }

constructor TMetaLogin.Create(const ALogin: TParseAPI.TLogin);
begin
  inherited Create(ALogin.User);
  FLogin := ALogin;
end;

function TMetaLogin.GetAuthTOken: string;
begin
  Result := FLogin.SessionToken;
end;

{ TMetaFile }

constructor TMetaFile.Create(const AFile: TParseAPI.TFile);
begin
  FFile := AFile;
end;

function TMetaFile.GetFileID: string;
begin
  Result := FFile.Name;
end;

function TMetaFile.GetFileName: string;
begin
  Result := FFile.FileName;
end;

constructor TMetaFile.Create(const AFileID: string);
begin
  FFile := TParseAPI.TFile.Create(AFileID);
end;

function TMetaFile.GetDownloadURL: string;
begin
  Result := FFile.DownloadURL;
end;

end.
