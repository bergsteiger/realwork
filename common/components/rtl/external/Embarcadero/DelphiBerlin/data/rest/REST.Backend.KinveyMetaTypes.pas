{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.KinveyMetaTypes;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  REST.Backend.MetaTypes,
  REST.Backend.KinveyApi;

type

  TMetaFactory = class(TInterfacedObject, IBackendMetaFactory, IBackendMetaClassFactory,
    IBackendMetaClassObjectFactory, IBackendMetaUserFactory, IBackendMetaDataTypeFactory,
    IBackendMetaFileFactory)
  protected
    { IBackendMetaClassFactory }
    function CreateMetaClass(const AClassName: string): TBackendMetaClass;
    { IBackendMetaClassObjectFactory }
    function CreateMetaClassObject(const AClassName, AObjectID: string): TBackendEntityValue;
    { IBackendMetaUserFactory }
    function CreateMetaUserObject(const AObjectID: string): TBackendEntityValue;
    { IBackendMetaDataTypeFactory }
    function CreateMetaDataType(const ADataType, ABackendClassName: string): TBackendMetaClass;
    { IBackendMetaFileFactory }
    function CreateMetaFileObject(const AFileID: string): TBackendEntityValue;
  end;

  // Describe a backend class
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

  // Defined backend class with ClassName property
  TMetaClassName = class(TMetaClass, IBackendMetaClass, IBackendClassName)
  end;

  // Defined backend class with ClassName and datatype property
  TMetaDataType = class(TMetaClass, IBackendMetaClass, IBackendClassName, IBackendDataType)
  end;

  // Describe an object
  TMetaObject = class(TInterfacedObject, IBackendMetaObject)
  private
    FObjectID: TKinveyAPI.TObjectID;
  protected
    function GetObjectID: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
    function GetClassName: string;
  public
    constructor Create(const AObjectID: TKinveyAPI.TObjectID);
    property ObjectID: TKinveyAPI.TObjectID read FObjectID;
  end;

  // Describe a user object
  TMetaUser = class(TInterfacedObject, IBackendMetaObject)
  private
    FUser: TKinveyAPI.TUser;
  protected
    function GetObjectID: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
    function GetUserName: string;
  public
    constructor Create(const AUser: TKinveyAPI.TUser);
    property User: TKinveyAPI.TUser read FUser;
  end;

  // Describe an logged in user
  TMetaLogin = class(TMetaUser)
  private
    FLogin: TKinveyAPI.TLogin;
  protected
    function GetAuthTOken: string;
  public
    constructor Create(const ALogin: TKinveyAPI.TLogin);
    property Login: TKinveyAPI.TLogin read FLogin;
  end;

  // Describe an uploaded file
  TMetaFile = class(TInterfacedObject, IBackendMetaObject)
  private
    FFile: TKinveyAPI.TFile;
  protected
    function GetDownloadURL: string;
    function GetFileName: string;
    function GetExpiresAt: TDateTime;
    function GetFileID: string;
  public
    constructor Create(const AFile: TKinveyAPI.TFile);
    property FileValue: TKinveyAPI.TFile read FFile;
  end;

  TMetaUploadedFile = class(TMetaFile, IBackendMetaObject,
     IBackendFileID, IBackendDownloadURL, IBackendFileName, IBackendExpiresAt)
  end;

  TMetaFileObject = class(TMetaFile, IBackendMetaObject,
     IBackendFileID, IBackendDownloadURL, IBackendFileName, IBackendExpiresAt)
  end;

  // Define MetaObject with ObjectID and CreatedAt properties
  TMetaCreatedObject = class(TMetaObject, IBackendMetaObject,
     IBackendObjectID, IBackendClassName, IBackendCreatedAt)
  end;

  // Define MetaObject with ObjectID and BackendClassName properties
  TMetaClassObject = class(TMetaObject, IBackendMetaObject, IBackendClassName,
     IBackendObjectID)
  end;

  // Define MetaObject with UpdatedAt properties
  TMetaUpdatedObjectAt = class(TMetaObject, IBackendMetaObject, IBackendUpdatedAt)
  end;

  TMetaFoundObject = class(TMetaObject, IBackendMetaObject, IBackendClassName,
     IBackendObjectID, IBackendCreatedAt, IBackendUpdatedAt)
  end;

  // Define MetaObject with ObjectID and BackendClassName properties
  TMetaUserObject = class(TMetaObject, IBackendObjectID)
  end;

  // Define MetaObject with UpdatedAt properties
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

  // Define MetaObject with UpdatedAt properties
  TMetaUpdatedUserAt = class(TMetaObject, IBackendMetaObject, IBackendUpdatedAt)
  private
    FUpdatedAt: TKinveyAPI.TUpdatedAt;
  protected
    function GetUpdatedAt: TDateTime;
  public
    constructor Create(const AUpdatedAt: TKinveyAPI.TUpdatedAt);
    property UpdatedAt: TKinveyAPI.TUpdatedAt read FUpdatedAt;
  end;

  TKinveyMetaFactory = class
  private
  public
    class function CreateMetaClass(const AClassName: string): TBackendMetaClass; static;
    // Classes/Objects
    class function CreateMetaClassObject(const AClassName, AObjectID: string): TBackendEntityValue; overload;static;
    class function CreateMetaClassObject(const AObjectID: TKinveyAPI.TObjectID): TBackendEntityValue; overload;static;
    class function CreateMetaCreatedObject(const AObjectID: TKinveyAPI.TObjectID): TBackendEntityValue; static;
    class function CreateMetaFoundObject(const AObjectID: TKinveyAPI.TObjectID): TBackendEntityValue; static;
    class function CreateMetaUpdatedObject(const AObjectID: TKinveyAPI.TObjectID): TBackendEntityValue; overload; static;
    // Query
    class function CreateMetaDataType(const ADataType,
      AClassName: string): TBackendMetaClass; static;
    // Users
    class function CreateMetaUserObject(const AObjectID: string): TBackendEntityValue; overload;static;
    class function CreateMetaUserObject(const AUser: TKinveyAPI.TUser): TBackendEntityValue; overload;static;
     class function CreateMetaFoundUser(const AUser: TKinveyAPI.TUser): TBackendEntityValue; static;
    class function CreateMetaUpdatedUser(const AUpdatedAt: TKinveyAPI.TUpdatedAt): TBackendEntityValue; overload; static;
    class function CreateMetaSignupUser(const ALogin: TKinveyAPI.TLogin): TBackendEntityValue; overload; static;
    class function CreateMetaLoginUser(const ALogin: TKinveyAPI.TLogin): TBackendEntityValue; overload; static;
    // Files
    class function CreateMetaUploadedFile(const AFile: TKinveyAPI.TFile): TBackendEntityValue;
    class function CreateMetaFileObject(const AFileID: string): TBackendEntityValue;
  end;

implementation

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

{ TMetaObject }

constructor TMetaObject.Create(const AObjectID: TKinveyAPI.TObjectID);
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
  Result := FObjectID.BackendCollectionName;
end;

{ TMetaUser }

constructor TMetaUser.Create(const AUser: TKinveyAPI.TUser);
begin
  inherited Create;
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

{ TMetaFactory }

function TMetaFactory.CreateMetaClass(
  const AClassName: string): TBackendMetaClass;
begin
  Result := TKinveyMetaFactory.CreateMetaClass(AClassName);
end;

function TMetaFactory.CreateMetaClassObject(
  const AClassName: string; const AObjectID: string): TBackendEntityValue;
begin
  Result := TKinveyMetaFactory.CreateMetaClassObject(AClassName, AObjectID);
end;

function TMetaFactory.CreateMetaDataType(const ADataType,
  ABackendClassName: string): TBackendMetaClass;
begin
  Result := TKinveyMetaFactory.CreateMetaDataType(ADataType, ABackendClassName);
end;

function TMetaFactory.CreateMetaFileObject(
  const AFileID: string): TBackendEntityValue;
begin
  Result := TKinveyMetaFactory.CreateMetaFileObject(AFileID);
end;

function TMetaFactory.CreateMetaUserObject(
  const AObjectID: string): TBackendEntityValue;
begin
  Result := TKinveyMetaFactory.CreateMetaUserObject(AObjectID);
end;

{ TKinveyMetaFactory }

class function TKinveyMetaFactory.CreateMetaClass(
  const AClassName: string): TBackendMetaClass;
var
  LIntf: IBackendMetaClass;
begin
  LIntf := TMetaClassName.Create(AClassName);
  Assert(Supports(LIntf, IBackendClassName));
  Result := TBackendMetaClass.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaClassObject(
  const AClassName: string; const AObjectID: string): TBackendEntityValue;
var
  LObjectID: TKinveyAPI.TObjectID;
begin
  LObjectID := TKinveyAPI.TObjectID.Create(AClassName, AObjectID);
  Result := CreateMetaClassObject(LObjectID);
end;

class function TKinveyMetaFactory.CreateMetaClassObject(
  const AObjectID: TKinveyAPI.TObjectID): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaClassObject.Create(AObjectID);
  Assert(Supports(LIntf, IBackendClassName));
  Assert(Supports(LIntf, IBackendObjectID));
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaCreatedObject(
  const AObjectID: TKinveyAPI.TObjectID): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaCreatedObject.Create(AObjectID);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaFileObject(
  const AFileID: string): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
  LFile: TKinveyAPI.TFile;
begin
  LFile := TKinveyAPI.TFile.Create(AFileID);
  LIntf := TMetaFileObject.Create(LFile);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaFoundObject(
  const AObjectID: TKinveyAPI.TObjectID): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundObject.Create(AObjectID);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaFoundUser(
  const AUser: TKinveyAPI.TUser): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundUser.Create(AUser);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaLoginUser(
  const ALogin: TKinveyAPI.TLogin): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaLoginUser.Create(ALogin);         
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaDataType(const ADataType,
  AClassName: string): TBackendMetaClass;
var
  LIntf: IBackendMetaClass;
begin
  LIntf := TMetaDataType.Create(ADataType, AClassName);
  Result := TBackendMetaClass.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaSignupUser(
  const ALogin: TKinveyAPI.TLogin): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaSignupUser.Create(ALogin);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaUpdatedObject(
  const AObjectID: TKinveyAPI.TObjectID): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUpdatedObjectAt.Create(AObjectID);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaUpdatedUser(
  const AUpdatedAt: TKinveyAPI.TUpdatedAt): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUpdatedUserAt.Create(AUpdatedAt);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaUserObject(
  const AUser: TKinveyAPI.TUser): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundUser.Create(AUser);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TKinveyMetaFactory.CreateMetaUserObject(
  const AObjectID: string): TBackendEntityValue;
var
  LObjectID: TKinveyAPI.TUser;
begin
  LObjectID := TKinveyAPI.TUser.Create(AObjectID);
  Result := CreateMetaUserObject(LObjectID);
end;

class function TKinveyMetaFactory.CreateMetaUploadedFile(
  const AFile: TKinveyAPI.TFile): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUploadedFile.Create(AFile);
  Result := TBackendEntityValue.Create(LIntf);
end;

{ TMetaUpdatedUserAt }

constructor TMetaUpdatedUserAt.Create(const AUpdatedAt: TKinveyAPI.TUpdatedAt);
begin
  FUpdatedAt := AUpdatedAt;
end;

function TMetaUpdatedUserAt.GetUpdatedAt: TDateTime;
begin
  Result := FUpdatedAt.UpdatedAt;
end;

{ TMetaLogin }

constructor TMetaLogin.Create(const ALogin: TKinveyAPI.TLogin);
begin
  FLogin := ALogin;
  inherited Create(FLogin.User);
end;

function TMetaLogin.GetAuthTOken: string;
begin
  Result := FLogin.AuthToken;
end;

{ TMetaFile }

constructor TMetaFile.Create(const AFile: TKinveyAPI.TFile);
begin
  FFile := AFile;
end;

function TMetaFile.GetExpiresAt: TDateTime;
begin
  Result := FFile.ExpiresAt;
end;

function TMetaFile.GetFileID: string;
begin
  Result := FFile.ID;
end;

function TMetaFile.GetFileName: string;
begin
  Result := FFile.FileName;
end;

function TMetaFile.GetDownloadURL: string;
begin
  Result := FFile.DownloadURL;
end;

end.

