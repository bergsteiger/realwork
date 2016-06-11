{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.MetaTypes;

interface

uses System.Generics.Collections, System.Classes, System.JSON;

type


  IBackendMetaFactory = interface;
  IBackendMetaObject = interface;
  IBackendMetaClass = interface;

  TBackendEntityValue = record
  class var
    FEmpty: TBackendEntityValue;
  private
    FData: IBackendMetaObject;
    FFiller: Integer;                                                                               
    function GetBackendClassName: string;
    function GetCreateddAt: TDateTime;
    function GetObjectID: string;
    function GetUpdatedAt: TDateTime;
    function GetAuthToken: string;
    function GetUserName: string;
    function GetGroupName: string;
    function GetDownloadURL: string;
    function GetExpiresAt: TDateTime;
    function GetFileName: string;
    function GetFileID: string;
    function GetIsEmpty: Boolean;
  public
    constructor Create(const Intf: IBackendMetaObject);
    function TryGetBackendClassName(out AValue: string): Boolean;
    function TryGetObjectID(out AValue: string): Boolean;
    function TryGetUpdatedAt(out AValue: TDateTime): Boolean;
    function TryGetCreatedAt(out AValue: TDateTime): Boolean;
    function TryGetExpiresAt(out AValue: TDateTime): Boolean;
    function TryGetUserName(out AValue: string): Boolean;
    function TryGetGroupName(out AValue: string): Boolean;
    function TryGetFileName(out AValue: string): Boolean;
    function TryGetDownloadURL(out AValue: string): Boolean;
    function TryGetAuthToken(out AValue: string): Boolean;
    function TryGetFileID(out AValue: string): Boolean;
    property BackendClassName: string read GetBackendClassName;
    property ObjectID: string read GetObjectID;
    property UpdatedAt: TDateTime read GetUpdatedAt;
    property CreatedAt: TDateTime read GetCreateddAt;
    property UserName: string read GetUserName;
    property GroupName: string read GetGroupName;
    property AuthToken: string read GetAuthToken;
    property DownloadURL: string read GetDownloadURL;
    property ExpiresAt: TDateTime read GetExpiresAt;
    property FileName: string read GetFileName;
    property FileID: string read GetFileID;
    property Data: IBackendMetaObject read FData;
    property IsEmpty: Boolean read GetIsEmpty;
    class property Empty: TBackendEntityValue read FEmpty;
  end;

  TBackendMetaObject = TBackendEntityValue; // Temporary

  TBackendClassValue = record
  private
    FData: IBackendMetaClass;
    function GetBackendClassName: string;
    function GetDataType: string;
  public
    constructor Create(const Intf: IBackendMetaClass);
    function TryGetBackendClassName(out AValue: string): Boolean;
    function TryGetDataType(out AValue: string): Boolean;
    property BackendClassName: string read GetBackendClassName;
    property BackendDataType: string read GetDataType;
  end;

  TBackendMetaClass = TBackendClassValue; // Temporary

  IBackendMetaObject = interface
    ['{95F29709-C995-4E69-A16E-3E9FA6D81ED6}']
  end;

  IBackendClassName = interface(IBackendMetaObject)
    ['{A73AB14F-12C8-4121-AFB1-2E0C55F37BB6}']
    function GetClassName: string;
  end;

  IBackendDataType = interface(IBackendMetaObject)
    ['{8E75565A-3A1B-44E0-B150-B74927F50F97}']
    function GetDataType: string;
  end;

  IBackendObjectID = interface(IBackendMetaObject)
    ['{CD893599-279D-4000-B7E2-F94B944D6C63}']
    function GetObjectID: string;
  end;

  IBackendUpdatedAt = interface(IBackendMetaObject)
    ['{16630E95-EE80-4328-8323-6F7FF67C0141}']
    function GetUpdatedAt: TDateTime;
  end;

  IBackendCreatedAt = interface(IBackendMetaObject)
    ['{C3204A92-434F-4008-B356-E41896BC22CA}']
    function GetCreatedAt: TDateTime;
  end;

  IBackendAuthToken = interface(IBackendMetaObject)
    ['{3C4FF6D8-11CA-48D8-8967-B3F1FC06C3EA}']
    function GetAuthToken: string;
  end;

  IBackendUserName = interface(IBackendMetaObject)
    ['{B7022538-2C7D-4F93-A1C8-A7A96545E4BF}']
    function GetUserName: string;
  end;

  IBackendGroupName = interface(IBackendMetaObject)
    ['{BEA0754A-0D59-4D62-96A4-3175A3E8E1EB}']
    function GetGroupName: string;
  end;

  ///<summary> MetaObject Interface. Use this type to read the property Module Name.</summary>
  IBackendModuleName = interface(IBackendMetaObject)
    ['{BEA0754A-0D59-4D62-96A4-3175A3E8E1EB}']
    ///<summary> Gets module name property.</summary>
    function GetModuleName: string;
  end;
   ///<summary> MetaObject Interface. Use this type to read the property Resource Name.</summary>
  IBackendModuleResourceName = interface(IBackendMetaObject)
    ['{BEA0754A-0D59-4D62-96A4-3175A3E8E1EB}']
    ///<summary> Gets resource name property.</summary>
    function GetResourceName: string;
  end;

  IBackendDownloadURL = interface(IBackendMetaObject)
    ['{0403AF5D-AF5D-4463-97DD-2903DE03EBFD}']
    function GetDownloadURL: string;
  end;

  IBackendFileName = interface(IBackendMetaObject)
    ['{59E96B63-92B9-4A1D-991E-1487FF26B0A3}']
    function GetFileName: string;
  end;

  IBackendFileID = interface(IBackendMetaObject)
    ['{B58DA141-82E8-4BD6-920D-9C9E680BEC03}']
    function GetFileID: string;
  end;


  IBackendExpiresAt = interface(IBackendMetaObject)
    ['{CAD0E4F8-AB04-4EB5-B13C-CD9B0188036C}']
    function GetExpiresAt: TDateTime;
  end;

  IBackendMetaClass = interface
    ['{F80536B3-4F7F-4C52-9F53-A81CF608299C}']
  end;

  IBackendMetaDataType = interface
    ['{64064A4C-09AC-4FDC-8A12-31C40AC9E2FC}']
  end;

  IBackendMetaFactory = interface
    ['{B58EC9B1-060C-4B44-82E9-82F576AB3793}']
  end;

  IBackendMetaClassFactory = interface(IBackendMetaFactory)
    ['{B27A40E6-5084-4093-BED3-A329DCC65E92}']
    function CreateMetaClass(const AClassName: string): TBackendMetaClass; overload;
  end;

  IBackendMetaClassObjectFactory = interface(IBackendMetaFactory)
    ['{80E7B794-6088-4A85-A5A2-49ADA2112629}']
    function CreateMetaClassObject(const AClassName, AObjectID: string): TBackendEntityValue; overload;
  end;

  IBackendMetaUserFactory = interface(IBackendMetaFactory)
    ['{5C1A367B-F06E-492F-BD64-D68CA268671F}']
    function CreateMetaUserObject(const AObjectID: string): TBackendEntityValue; overload;
  end;

  IBackendMetaGroupFactory = interface(IBackendMetaFactory)
    ['{3CB88315-4399-4307-A5E5-CF60C919FF2D}']
    function CreateMetaGroupObject(const AGroupName: string): TBackendEntityValue; overload;
  end;

  IBackendMetaFileFactory = interface(IBackendMetaFactory)
    ['{96C22B76-C711-4D7C-90C8-AEA565F622D5}']
    function CreateMetaFileObject(const AObjectID: string): TBackendEntityValue; overload;
  end;

  IBackendMetaDataTypeFactory = interface(IBackendMetaFactory)
    ['{7FDED929-4F6D-4C41-8AF9-8AE20BFB2EF9}']
    function CreateMetaDataType(const ADataType, ABackendClassName: string): TBackendMetaClass; overload;
  end;


implementation

uses System.SysUtils, REST.Backend.Consts, REST.Backend.Exception;

{ TBackendEntityValue }

constructor TBackendEntityValue.Create(const Intf: IBackendMetaObject);
begin
  FData := Intf;
  FFiller := 0;
end;

function TBackendEntityValue.GetAuthToken: string;
begin
  if not TryGetAuthToken(Result) then
    raise EBackendServiceError.Create(sAuthTokenRequired);
end;

function TBackendEntityValue.GetBackendClassName: string;
begin
  if not TryGetBackendClassName(Result) then
    raise EBackendServiceError.Create(sBackendClassNameRequired);

end;

function TBackendEntityValue.GetCreateddAt: TDateTime;
begin
  if not TryGetCreatedAt(Result) then
    raise EBackendServiceError.Create(sCreateAtRequired);
end;

function TBackendEntityValue.GetDownloadURL: string;
begin
  if not TryGetDownloadURL(Result) then
    raise EBackendServiceError.Create(sDownloadUrlRequired);
end;

function TBackendEntityValue.GetExpiresAt: TDateTime;
begin
  if not TryGetExpiresAt(Result) then
    raise EBackendServiceError.Create(sExpiresAtRequired);
end;

function TBackendEntityValue.GetFileName: string;
begin
  if not TryGetFileName(Result) then
    raise EBackendServiceError.Create(sFileNameRequired);
end;

function TBackendEntityValue.GetFileID: string;
begin
  if not TryGetFileID(Result) then
    raise EBackendServiceError.Create(sFileIDRequired);
end;

function TBackendEntityValue.GetObjectID: string;
begin
  if not TryGetObjectID(Result) then
    raise EBackendServiceError.Create(sObjectIDRequired);
end;

function TBackendEntityValue.GetUpdatedAt: TDateTime;
begin
  if not TryGetUpdatedAt(Result) then
    raise EBackendServiceError.Create(sUpdatedAtRequired);
end;

function TBackendEntityValue.GetUserName: string;
begin
  if not TryGetUserName(Result) then
    raise EBackendServiceError.Create(sUserNameRequired);
end;

function TBackendEntityValue.GetGroupName: string;
begin
  if not TryGetGroupName(Result) then
    raise EBackendServiceError.Create(sGroupNameRequired);
end;

function TBackendEntityValue.GetIsEmpty: Boolean;
begin
  Result := FData = nil;
end;

function TBackendEntityValue.TryGetAuthToken(out AValue: string): Boolean;
var
  LIntf: IBackendAuthToken;
begin
  Result := Supports(FData, IBackendAuthToken, LIntf);
  if Result then
    AValue := LIntf.GetAuthToken;
end;

function TBackendEntityValue.TryGetBackendClassName(out AValue: string): Boolean;
var
  LIntf: IBackendClassName;
begin
  Result := Supports(FData, IBackendClassName, LIntf);
  if Result then
    AValue := LIntf.GetClassName;
end;

function TBackendEntityValue.TryGetCreatedAt(out AValue: TDateTime): Boolean;
var
  LIntf: IBackendCreatedAt;
begin
  Result := Supports(FData, IBackendCreatedAt, LIntf);
  if Result then
    AValue := LIntf.GetCreatedAt;
end;

function TBackendEntityValue.TryGetDownloadURL(out AValue: string): Boolean;
var
  LIntf: IBackendDownloadURL;
begin
  Result := Supports(FData, IBackendDownloadURL, LIntf);
  if Result then
    AValue := LIntf.GetDownloadURL;
end;

function TBackendEntityValue.TryGetExpiresAt(out AValue: TDateTime): Boolean;
var
  LIntf: IBackendExpiresAt;
begin
  Result := Supports(FData, IBackendExpiresAt, LIntf);
  if Result then
    AValue := LIntf.GetExpiresAt;
end;

function TBackendEntityValue.TryGetFileName(out AValue: string): Boolean;
var
  LIntf: IBackendFileName;
begin
  Result := Supports(FData, IBackendFileName, LIntf);
  if Result then
    AValue := LIntf.GetFileName;
end;

function TBackendEntityValue.TryGetFileID(out AValue: string): Boolean;
var
  LIntf: IBackendFileID;
begin
  Result := Supports(FData, IBackendFileID, LIntf);
  if Result then
    AValue := LIntf.GetFileID;
end;

function TBackendEntityValue.TryGetObjectID(out AValue: string): Boolean;
var
  LIntf: IBackendObjectID;
begin
  Result := Supports(FData, IBackendObjectID, LIntf);
  if Result then
    AValue := LIntf.GetObjectID;
end;

function TBackendEntityValue.TryGetUpdatedAt(out AValue: TDateTime): Boolean;
var
  LIntf: IBackendUpdatedAt;
begin
  Result := Supports(FData, IBackendUpdatedAt, LIntf);
  if Result then
    AValue := LIntf.GetUpdatedAt;
end;

function TBackendEntityValue.TryGetUserName(out AValue: string): Boolean;
var
  LIntf: IBackendUserName;
begin
  Result := Supports(FData, IBackendUserName, LIntf);
  if Result then
    AValue := LIntf.GetUserName;
end;

function TBackendEntityValue.TryGetGroupName(out AValue: string): Boolean;
var
  LIntf: IBackendGroupName;
begin
  Result := Supports(FData, IBackendGroupName, LIntf);
  if Result then
    AValue := LIntf.GetGroupName;
end;

{ TBackendClassValue }

constructor TBackendClassValue.Create(const Intf: IBackendMetaClass);
begin
  Assert(Supports(Intf, IBackendClassName));
  FData := Intf;
end;

function TBackendClassValue.GetBackendClassName: string;
begin
  if not TryGetBackendClassName(Result) then
    raise EBackendServiceError.Create(sBackendClassNameRequired);
end;

function TBackendClassValue.GetDataType: string;
begin
  if not TryGetDataType(Result) then
    raise EBackendServiceError.Create(sDataTypeNameRequired);
end;

function TBackendClassValue.TryGetBackendClassName(out AValue: string): Boolean;
var
  LIntf: IBackendClassName;
begin
  Result := Supports(FData, IBackendClassName, LIntf);
  if Result then
    AValue := LIntf.GetClassName
  else
    Assert(False); // Expect this to work
end;

function TBackendClassValue.TryGetDataType(out AValue: string): Boolean;
var
  LIntf: IBackendDataType;
begin
  Result := Supports(FData, IBackendDataType, LIntf);
  if Result then
    AValue := LIntf.GetDataType
  else
    Assert(False); // Expect this to work
end;

end.
