unit daUtils;

// Модуль: "w:\common\components\rtl\Garant\DA\daUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "daUtils" MUID: (5437B276039C)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , daTypes
;

function GetHomePathCode(aUserID: TdaUserID): TdaPathStr;
procedure CheckDbVersion(DocBaseVersion: Integer;
 AdminBaseVersion: Integer);
function UserIDBelongsToRegion(aUserID: TdaUserID;
 aRegion: TdaRegionID): Boolean;
function UserIsService(aUserID: TdaUserID): Boolean;
function IsUserRequireReports(aUserID: TdaUserID): Boolean;
function IsWrongUser(anUserID: TdaUserID): Boolean;

implementation

uses
 l3ImplUses
 , SysUtils
 , daInterfaces
 , daDataProvider
 //#UC START# *5437B276039Cimpl_uses*
 //#UC END# *5437B276039Cimpl_uses*
;

function GetHomePathCode(aUserID: TdaUserID): TdaPathStr;
//#UC START# *551E861C0377_5437B276039C_var*
//#UC END# *551E861C0377_5437B276039C_var*
begin
//#UC START# *551E861C0377_5437B276039C_impl*
 Result := 'Usr#'+IntToHex(aUserID, 4);
//#UC END# *551E861C0377_5437B276039C_impl*
end;//GetHomePathCode

procedure CheckDbVersion(DocBaseVersion: Integer;
 AdminBaseVersion: Integer);
//#UC START# *552279710064_5437B276039C_var*
//#UC END# *552279710064_5437B276039C_var*
begin
//#UC START# *552279710064_5437B276039C_impl*
 if DocBaseVersion = c_BadVersion then
  raise Exception.Create('Невозможно определить номер версии БД (док.)');

 if AdminBaseVersion = c_BadVersion then
  raise Exception.Create('Невозможно определить номер версии БД (админ.)');

 if (DocBaseVersion <> c_DocBaseVersion) then
  raise Exception.CreateFmt('Обнаружено несоответствие версий программы и БД!'+
                            #10'Версия базы семейства документов %d, требуемая версия %d', [DocBaseVersion, c_DocBaseVersion]);
 if (AdminBaseVersion <> c_AdminBaseVersion) then
  raise Exception.CreateFmt('Обнаружено несоответствие версий программы и БД!'+
                            #10'Версия административной базы %d, требуемая версия %d', [AdminBaseVersion, c_AdminBaseVersion]);
//#UC END# *552279710064_5437B276039C_impl*
end;//CheckDbVersion

function UserIDBelongsToRegion(aUserID: TdaUserID;
 aRegion: TdaRegionID): Boolean;
//#UC START# *552287F70191_5437B276039C_var*
//#UC END# *552287F70191_5437B276039C_var*
begin
//#UC START# *552287F70191_5437B276039C_impl*
 Result := (aUserID shr 24) = aRegion;
//#UC END# *552287F70191_5437B276039C_impl*
end;//UserIDBelongsToRegion

function UserIsService(aUserID: TdaUserID): Boolean;
//#UC START# *55228D9D03B2_5437B276039C_var*
//#UC END# *55228D9D03B2_5437B276039C_var*
begin
//#UC START# *55228D9D03B2_5437B276039C_impl*
 Result := (aUserID = usServerService) or ((aUserID > usAdminReserved) and (aUserID <= usFirstWorkUser))
//#UC END# *55228D9D03B2_5437B276039C_impl*
end;//UserIsService

function IsUserRequireReports(aUserID: TdaUserID): Boolean;
//#UC START# *55228DAB0064_5437B276039C_var*
//#UC END# *55228DAB0064_5437B276039C_var*
begin
//#UC START# *55228DAB0064_5437B276039C_impl*
 Result := (aUserID <> GlobalDataProvider.UserID) and not UserIsService(aUserID);
//#UC END# *55228DAB0064_5437B276039C_impl*
end;//IsUserRequireReports

function IsWrongUser(anUserID: TdaUserID): Boolean;
//#UC START# *5784E79A015A_5437B276039C_var*
//#UC END# *5784E79A015A_5437B276039C_var*
begin
//#UC START# *5784E79A015A_5437B276039C_impl*
 Result := (anUserID = 0) or
   (anUserID = usWrongClient) or
   (anUserID = usDuplicateClient) or
   (anUserID = usDeadClient)
//#UC END# *5784E79A015A_5437B276039C_impl*
end;//IsWrongUser

end.
