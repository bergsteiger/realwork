{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit REST.Backend.EMSMetaTypes;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  REST.Backend.MetaTypes,
  REST.Backend.EMSApi;

type

  TMetaFactory = class(TInterfacedObject, IBackendMetaFactory,
    IBackendMetaUserFactory, IBackendMetaGroupFactory, IBackendMetaDataTypeFactory)
  protected
    { IBackendMetaUserFactory }
    function CreateMetaUserObject(const AObjectID: string): TBackendEntityValue;
     { IBackendMetaDataTypeFactory }
    function CreateMetaDataType(const ADataType, ABackendClassName: string): TBackendMetaClass;
    { IBackendMetaUserGroupFactory }
    function CreateMetaGroupObject(const AGroupID: string): TBackendEntityValue;
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
  TMetaDataType = class(TMetaClass, IBackendMetaClass, IBackendClassName,
    IBackendDataType)
  end;

  // Describe a user object
  TMetaUser = class(TInterfacedObject, IBackendMetaObject)
  private
    FUser: TEMSClientAPI.TUser;
  protected
    function GetObjectID: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
    function GetUserName: string;
  public
    constructor Create(const AUser: TEMSClientAPI.TUser);
    property User: TEMSClientAPI.TUser read FUser;
  end;

  // Describe a group object
  TMetaGroup = class(TInterfacedObject, IBackendMetaObject)
  private
    FGroup: TEMSClientAPI.TGroup;
  protected
    function GetGroupName: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
  public
    constructor Create(const AGroup: TEMSClientAPI.TGroup);
    property Group: TEMSClientAPI.TGroup read FGroup;
  end;

  // Describe an installation object
  TMetaInstallation = class(TInterfacedObject, IBackendMetaObject)
  private
    FInstallation: TEMSClientAPI.TInstallation;
  protected
    function GetObjectID: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
  public
    constructor Create(const AInstallation: TEMSClientAPI.TInstallation);
    property Installation: TEMSClientAPI.TInstallation read FInstallation;
  end;

  // Describe an logged in user
  TMetaLogin = class(TMetaUser)
  private
    FLogin: TEMSClientAPI.TLogin;
  protected
    function GetAuthTOken: string;
  public
    constructor Create(const ALogin: TEMSClientAPI.TLogin);
    property Login: TEMSClientAPI.TLogin read FLogin;
  end;

  // Describe a module object
  TMetaModule = class(TInterfacedObject, IBackendMetaObject)
  private
    FModule: TEMSClientAPI.TModule;
  protected
    function GetObjectID: string;
    function GetModuleName: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
  public
    constructor Create(const AModule: TEMSClientAPI.TModule);
    property Module: TEMSClientAPI.TModule read FModule;
  end;

  // Describe a module Resource object
  TMetaModuleResource = class(TInterfacedObject, IBackendMetaObject)
  private
    FModuleResource: TEMSClientAPI.TModuleResource;
  protected
    function GetObjectID: string;
    function GetModuleName: string;
    function GetResourceName: string;
    function GetCreatedAt: TDateTime;
    function GetUpdatedAt: TDateTime;
  public
    constructor Create(const AModuleResource: TEMSClientAPI.TModuleResource);
    property ModuleResource: TEMSClientAPI.TModuleResource read FModuleResource;
  end;

  // Define MetaObject with UpdatedAt properties
  TMetaUpdatedUser = class(TMetaUser, IBackendMetaObject, IBackendUpdatedAt,
    IBackendUserName)
  end;

  TMetaFoundUser = class(TMetaUser, IBackendMetaObject, IBackendObjectID,
    IBackendCreatedAt, IBackendUpdatedAt, IBackendUserName)
  end;

  TMetaFoundGroup = class(TMetaGroup, IBackendMetaObject,
    IBackendCreatedAt, IBackendUpdatedAt, IBackendGroupName)
  end;

  TMetaFoundInstallation = class(TMetaInstallation, IBackendMetaObject,
    IBackendCreatedAt, IBackendUpdatedAt, IBackendObjectID)
  end;

  TMetaInstallationID = class(TMetaInstallation, IBackendMetaObject,
    IBackendObjectID)
  end;

  TMetaLoginUser = class(TMetaLogin, IBackendMetaObject, IBackendObjectID,
    IBackendCreatedAt, IBackendUpdatedAt, IBackendUserName, IBackendAuthToken)
  end;

  TMetaSignupUser = class(TMetaLogin, IBackendMetaObject, IBackendObjectID,
    IBackendCreatedAt, IBackendUserName, IBackendAuthToken)
  end;

  TMetaFoundModule = class(TMetaModule, IBackendMetaObject,
    IBackendCreatedAt, IBackendUpdatedAt, IBackendObjectID, IBackendModuleName)
  end;

  TMetaFoundModuleResource  = class(TMetaModuleResource, IBackendMetaObject,
    IBackendCreatedAt, IBackendUpdatedAt, IBackendObjectID, IBackendModuleName,
    IBackendModuleResourceName)
  end;

  // Define MetaObject with UpdatedAt properties
  TMetaUpdatedAt = class(TInterfacedObject, IBackendMetaObject, IBackendUpdatedAt)
  private
    FUpdatedAt: TEMSClientAPI.TUpdatedAt;
  protected
    function GetUpdatedAt: TDateTime;
  public
    constructor Create(const AUpdatedAt: TEMSClientAPI.TUpdatedAt);
    property UpdatedAt: TEMSClientAPI.TUpdatedAt read FUpdatedAt;
  end;

  TMetaUpdatedUserAt = TMetaUpdatedAt;

  TMetaUpdatedGroupAt = TMetaUpdatedAt;

  TEMSMetaFactory = class
  private
  public
    class function CreateMetaClass(const AClassName: string)
      : TBackendMetaClass; static;
    // Query
    class function CreateMetaDataType(const ADataType, AClassName: string)
      : TBackendMetaClass; static;
    // Users
    class function CreateMetaUserObject(const AObjectID: string)
      : TBackendEntityValue; overload; static;
    class function CreateMetaGroupObject(const AGroupName: string)
      : TBackendEntityValue; overload; static;
    class function CreateMetaUserObject(const AUser: TEMSClientAPI.TUser)
      : TBackendEntityValue; overload; static;
    class function CreateMetaGroupObject(const AGroup: TEMSClientAPI.TGroup)
      : TBackendEntityValue; overload; static;
    class function CreateMetaFoundUser(const AUser: TEMSClientAPI.TUser)
      : TBackendEntityValue; static;
    class function CreateMetaFoundGroup(const AGroup: TEMSClientAPI.TGroup)
      : TBackendEntityValue; static;
    class function CreateMetaFoundInstallation(const AInstallation: TEMSClientAPI.TInstallation)
      : TBackendEntityValue; static;
    class function CreateMetaUpdatedUser(const AUpdatedAt
      : TEMSClientAPI.TUpdatedAt): TBackendEntityValue; overload; static;
    class function CreateMetaUpdatedGroup(const AUpdatedAt
      : TEMSClientAPI.TUpdatedAt): TBackendEntityValue; overload; static;
    class function CreateMetaSignupUser(const ALogin: TEMSClientAPI.TLogin)
      : TBackendEntityValue; overload; static;
    class function CreateMetaLoginUser(const ALogin: TEMSClientAPI.TLogin)
      : TBackendEntityValue; overload; static;
    class function CreateMetaFoundModule(const AModule: TEMSClientAPI.TModule)
      : TBackendEntityValue; static;
    class function CreateMetaFoundModuleResource(const AModuleResource: TEMSClientAPI.TModuleResource)
      : TBackendEntityValue; static;
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

{ TMetaUser }

constructor TMetaUser.Create(const AUser: TEMSClientAPI.TUser);
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
  Result := FUser.UserID;
end;

function TMetaUser.GetUpdatedAt: TDateTime;
begin
  Result := FUser.UpdatedAt;
end;

function TMetaUser.GetUserName: string;
begin
  Result := FUser.UserName;
end;

{ TMetaGroup }

constructor TMetaGroup.Create(const AGroup: TEMSClientAPI.TGroup);
begin
  inherited Create;
  FGroup := AGroup;
end;

function TMetaGroup.GetCreatedAt: TDateTime;
begin
  Result := FGroup.CreatedAt;
end;

function TMetaGroup.GetUpdatedAt: TDateTime;
begin
  Result := FGroup.UpdatedAt;
end;

function TMetaGroup.GetGroupName: string;
begin
  Result := FGroup.GroupName;
end;


{ TMetaUserGroup }

constructor TMetaInstallation.Create(const AInstallation: TEMSClientAPI.TInstallation);
begin
  inherited Create;
  FInstallation := AInstallation;
end;

function TMetaInstallation.GetCreatedAt: TDateTime;
begin
  Result := FInstallation.CreatedAt;
end;

function TMetaInstallation.GetUpdatedAt: TDateTime;
begin
  Result := FInstallation.UpdatedAt;
end;

function TMetaInstallation.GetObjectID: string;
begin
  Result := FInstallation.InstallationID;
end;

{ TMetaFactory }

 function TMetaFactory.CreateMetaDataType(const ADataType,
   ABackendClassName: string): TBackendMetaClass;
 begin
   Result := TEMSMetaFactory.CreateMetaDataType(ADataType, ABackendClassName);
 end;

function TMetaFactory.CreateMetaGroupObject(
  const AGroupID: string): TBackendEntityValue;
begin
  Result := TEMSMetaFactory.CreateMetaGroupObject(AGroupID);
end;

function TMetaFactory.CreateMetaUserObject(const AObjectID: string)
  : TBackendEntityValue;
begin
  Result := TEMSMetaFactory.CreateMetaUserObject(AObjectID);
end;

{ TEMSMetaFactory }

class function TEMSMetaFactory.CreateMetaClass(const AClassName: string)
  : TBackendMetaClass;
var
  LIntf: IBackendMetaClass;
begin
  LIntf := TMetaClassName.Create(AClassName);
  Assert(Supports(LIntf, IBackendClassName));
  Result := TBackendMetaClass.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaFoundUser
  (const AUser: TEMSClientAPI.TUser): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundUser.Create(AUser);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaFoundGroup
  (const AGroup: TEMSClientAPI.TGroup): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundGroup.Create(AGroup);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaFoundInstallation
  (const AInstallation: TEMSClientAPI.TInstallation): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundInstallation.Create(AInstallation);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaFoundModule(
  const AModule: TEMSClientAPI.TModule): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundModule.Create(AModule);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaFoundModuleResource(
  const AModuleResource: TEMSClientAPI.TModuleResource): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundModuleResource.Create(AModuleResource);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaLoginUser(const ALogin
  : TEMSClientAPI.TLogin): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaLoginUser.Create(ALogin);         
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaDataType(const ADataType,
  AClassName: string): TBackendMetaClass;
var
  LIntf: IBackendMetaClass;
begin
  LIntf := TMetaDataType.Create(ADataType, AClassName);
  Result := TBackendMetaClass.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaSignupUser(const ALogin
  : TEMSClientAPI.TLogin): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaSignupUser.Create(ALogin);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaUpdatedUser(const AUpdatedAt
  : TEMSClientAPI.TUpdatedAt): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUpdatedAt.Create(AUpdatedAt);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaUpdatedGroup(const AUpdatedAt
  : TEMSClientAPI.TUpdatedAt): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaUpdatedGroupAt.Create(AUpdatedAt);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaUserObject
  (const AUser: TEMSClientAPI.TUser): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundUser.Create(AUser);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaGroupObject
  (const AGroup: TEMSClientAPI.TGroup): TBackendEntityValue;
var
  LIntf: IBackendMetaObject;
begin
  LIntf := TMetaFoundGroup.Create(AGroup);
  Result := TBackendEntityValue.Create(LIntf);
end;

class function TEMSMetaFactory.CreateMetaUserObject(const AObjectID: string)
  : TBackendEntityValue;
var
  LUser: TEMSClientAPI.TUser;
begin
  LUser := TEMSClientAPI.TUser.Create('', AObjectID);
  Result := CreateMetaUserObject(LUser);
end;

class function TEMSMetaFactory.CreateMetaGroupObject(const AGroupName: string)
  : TBackendEntityValue;
var
  LGroup: TEMSClientAPI.TGroup;
begin
  LGroup := TEMSClientAPI.TGroup.Create(AGroupName);
  Result := CreateMetaGroupObject(LGroup);
end;

{ TMetaUpdatedUserAt }

constructor TMetaUpdatedAt.Create(const AUpdatedAt
  : TEMSClientAPI.TUpdatedAt);
begin
  FUpdatedAt := AUpdatedAt;
end;

function TMetaUpdatedAt.GetUpdatedAt: TDateTime;
begin
  Result := FUpdatedAt.UpdatedAt;
end;

{ TMetaLogin }

constructor TMetaLogin.Create(const ALogin: TEMSClientAPI.TLogin);
begin
  FLogin := ALogin;
  inherited Create(FLogin.User);
end;

function TMetaLogin.GetAuthTOken: string;
begin
  Result := FLogin.AuthToken;
end;

{ TMetaModule }

constructor TMetaModule.Create(const AModule: TEMSClientAPI.TModule);
begin
  inherited Create;
  FModule := AModule;
end;

function TMetaModule.GetCreatedAt: TDateTime;
begin
  Result := FModule.CreatedAt;
end;

function TMetaModule.GetModuleName: string;
begin
  Result := FModule.ModuleName;
end;

function TMetaModule.GetObjectID: string;
begin
  Result := FModule.ModuleID;
end;

function TMetaModule.GetUpdatedAt: TDateTime;
begin
  Result := FModule.UpdatedAt
end;

{ TMetaModuleResource }

constructor TMetaModuleResource.Create(
  const AModuleResource: TEMSClientAPI.TModuleResource);
begin
  inherited Create;
  FModuleResource := AModuleResource;
end;

function TMetaModuleResource.GetCreatedAt: TDateTime;
begin
  Result := FModuleResource.CreatedAt;
end;

function TMetaModuleResource.GetModuleName: string;
begin
  Result := FModuleResource.ModuleName;
end;

function TMetaModuleResource.GetObjectID: string;
begin
  Result := FModuleResource.ModuleID;
end;

function TMetaModuleResource.GetResourceName: string;
begin
  Result := FModuleResource.ResourceName;
end;

function TMetaModuleResource.GetUpdatedAt: TDateTime;
begin
  Result := FModuleResource.UpdatedAt;
end;

end.
