unit daArchiUser;

// Модуль: "w:\common\components\rtl\Garant\DA\daArchiUser.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaArchiUser" MUID: (52FBA57600AB)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , Classes
;

type
 TdaCalcPriorityCallBack = function(aUserId: TdaUserID;
  out aImportPriority: TdaPriority;
  out aExportPriority: TdaPriority): Boolean of object;

 TdaArchiUser = class(Tl3ProtoObject, IdaArchiUser)
  private
   f_CalcPriorityCallBack: TdaCalcPriorityCallBack;
   f_ID: TdaUserID;
   f_ExportPriority: TdaPriority;
   f_ImportPriority: TdaPriority;
   f_Active: Boolean;
   f_HasAdminRights: Boolean;
   f_IP: AnsiString;
   f_LoginDate: TDateTime;
   f_LoginName: AnsiString;
   f_Password: AnsiString;
   f_UserName: AnsiString;
  protected
   function pm_GetExportPriority: TdaPriority; virtual;
   function pm_GetImportPriority: TdaPriority; virtual;
   procedure Save(aStream: TStream);
   procedure Load(aStream: TStream);
   function Get_ID: TdaUserID;
   procedure Set_ID(aValue: TdaUserID);
   function Get_Active: Boolean;
   procedure Set_Active(aValue: Boolean);
   function Get_HasAdminRights: Boolean;
   procedure Set_HasAdminRights(aValue: Boolean);
   function Get_ExportPriority: TdaPriority;
   procedure Set_ExportPriority(aValue: TdaPriority);
   function Get_ImportPriority: TdaPriority;
   procedure Set_ImportPriority(aValue: TdaPriority);
   function Get_IP: AnsiString;
   procedure Set_IP(const aValue: AnsiString);
   function Get_LoginDate: TDateTime;
   procedure Set_LoginDate(aValue: TDateTime);
   function Get_LoginName: AnsiString;
   procedure Set_LoginName(const aValue: AnsiString);
   function Get_Password: AnsiString;
   procedure Set_Password(const aValue: AnsiString);
   function Get_UserName: AnsiString;
   procedure Set_UserName(const aValue: AnsiString);
   procedure ClearFields; override;
  public
   constructor Create(aCalcPriorityCallback: TdaCalcPriorityCallBack); reintroduce;
   class function Make(aCalcPriorityCallback: TdaCalcPriorityCallBack): IdaArchiUser; reintroduce;
  public
   property ID: TdaUserID
    read f_ID
    write f_ID;
   property ExportPriority: TdaPriority
    read pm_GetExportPriority
    write f_ExportPriority;
   property ImportPriority: TdaPriority
    read pm_GetImportPriority
    write f_ImportPriority;
   property Active: Boolean
    read f_Active
    write f_Active;
   property HasAdminRights: Boolean
    read f_HasAdminRights
    write f_HasAdminRights;
   property IP: AnsiString
    read f_IP
    write f_IP;
   property LoginDate: TDateTime
    read f_LoginDate
    write f_LoginDate;
   property LoginName: AnsiString
    read f_LoginName
    write f_LoginName;
   property Password: AnsiString
    read f_Password
    write f_Password;
   property UserName: AnsiString
    read f_UserName
    write f_UserName;
 end;//TdaArchiUser

implementation

uses
 l3ImplUses
 , ddStreamUtils
;

const
 cPriorityNeedCalc: TdaPriority = daTypes.TdaPriority(-3);

function TdaArchiUser.pm_GetExportPriority: TdaPriority;
//#UC START# *572B22B0011C_52FBA57600ABget_var*
//#UC END# *572B22B0011C_52FBA57600ABget_var*
begin
//#UC START# *572B22B0011C_52FBA57600ABget_impl*
 Result := Get_ExportPriority;
//#UC END# *572B22B0011C_52FBA57600ABget_impl*
end;//TdaArchiUser.pm_GetExportPriority

function TdaArchiUser.pm_GetImportPriority: TdaPriority;
//#UC START# *572B22BF003A_52FBA57600ABget_var*
//#UC END# *572B22BF003A_52FBA57600ABget_var*
begin
//#UC START# *572B22BF003A_52FBA57600ABget_impl*
 Result := Get_ImportPriority;
//#UC END# *572B22BF003A_52FBA57600ABget_impl*
end;//TdaArchiUser.pm_GetImportPriority

constructor TdaArchiUser.Create(aCalcPriorityCallback: TdaCalcPriorityCallBack);
//#UC START# *572B1324003C_52FBA57600AB_var*
//#UC END# *572B1324003C_52FBA57600AB_var*
begin
//#UC START# *572B1324003C_52FBA57600AB_impl*
 inherited Create;
 f_CalcPriorityCallBack := aCalcPriorityCallback;
 f_ExportPriority := cPriorityNeedCalc;
 f_ImportPriority := cPriorityNeedCalc;
//#UC END# *572B1324003C_52FBA57600AB_impl*
end;//TdaArchiUser.Create

class function TdaArchiUser.Make(aCalcPriorityCallback: TdaCalcPriorityCallBack): IdaArchiUser;
var
 l_Inst : TdaArchiUser;
begin
 l_Inst := Create(aCalcPriorityCallback);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaArchiUser.Make

procedure TdaArchiUser.Save(aStream: TStream);
//#UC START# *5729DCF300FC_52FBA57600AB_var*
//#UC END# *5729DCF300FC_52FBA57600AB_var*
begin
//#UC START# *5729DCF300FC_52FBA57600AB_impl*
 with aStream do
 begin
  Write(f_ID, SizeOf(f_ID));
  Write(f_ImportPriority, SizeOf(f_ImportPriority));
  WriteString(aStream, f_IP);
  Write(f_LoginDate, SizeOf(f_LoginDate));
  WriteString(aStream, f_LoginName);
  WriteString(aStream, f_Password);
  WriteString(aStream, f_UserName);
 end; // aStream
//#UC END# *5729DCF300FC_52FBA57600AB_impl*
end;//TdaArchiUser.Save

procedure TdaArchiUser.Load(aStream: TStream);
//#UC START# *572B08330098_52FBA57600AB_var*
//#UC END# *572B08330098_52FBA57600AB_var*
begin
//#UC START# *572B08330098_52FBA57600AB_impl*
 with aStream do
 begin
  Read(f_ID, SizeOf(f_ID));
  Read(f_ImportPriority, SizeOf(f_ImportPriority));
  ReadString(aStream, f_IP);
  Read(f_LoginDate, SizeOf(f_LoginDate));
  ReadString(aStream, f_LoginName);
  ReadString(aStream, f_Password);
  ReadString(aStream, f_UserName);
 end; // aStream
//#UC END# *572B08330098_52FBA57600AB_impl*
end;//TdaArchiUser.Load

function TdaArchiUser.Get_ID: TdaUserID;
//#UC START# *572B1204035B_52FBA57600ABget_var*
//#UC END# *572B1204035B_52FBA57600ABget_var*
begin
//#UC START# *572B1204035B_52FBA57600ABget_impl*
 Result := f_ID;
//#UC END# *572B1204035B_52FBA57600ABget_impl*
end;//TdaArchiUser.Get_ID

procedure TdaArchiUser.Set_ID(aValue: TdaUserID);
//#UC START# *572B1204035B_52FBA57600ABset_var*
//#UC END# *572B1204035B_52FBA57600ABset_var*
begin
//#UC START# *572B1204035B_52FBA57600ABset_impl*
 f_ID := aValue;
//#UC END# *572B1204035B_52FBA57600ABset_impl*
end;//TdaArchiUser.Set_ID

function TdaArchiUser.Get_Active: Boolean;
//#UC START# *572B121B01DF_52FBA57600ABget_var*
//#UC END# *572B121B01DF_52FBA57600ABget_var*
begin
//#UC START# *572B121B01DF_52FBA57600ABget_impl*
 Result := f_Active;
//#UC END# *572B121B01DF_52FBA57600ABget_impl*
end;//TdaArchiUser.Get_Active

procedure TdaArchiUser.Set_Active(aValue: Boolean);
//#UC START# *572B121B01DF_52FBA57600ABset_var*
//#UC END# *572B121B01DF_52FBA57600ABset_var*
begin
//#UC START# *572B121B01DF_52FBA57600ABset_impl*
 f_Active := aValue;
//#UC END# *572B121B01DF_52FBA57600ABset_impl*
end;//TdaArchiUser.Set_Active

function TdaArchiUser.Get_HasAdminRights: Boolean;
//#UC START# *572B123002B7_52FBA57600ABget_var*
//#UC END# *572B123002B7_52FBA57600ABget_var*
begin
//#UC START# *572B123002B7_52FBA57600ABget_impl*
 Result := f_HasAdminRights;
//#UC END# *572B123002B7_52FBA57600ABget_impl*
end;//TdaArchiUser.Get_HasAdminRights

procedure TdaArchiUser.Set_HasAdminRights(aValue: Boolean);
//#UC START# *572B123002B7_52FBA57600ABset_var*
//#UC END# *572B123002B7_52FBA57600ABset_var*
begin
//#UC START# *572B123002B7_52FBA57600ABset_impl*
 f_HasAdminRights := aValue;
//#UC END# *572B123002B7_52FBA57600ABset_impl*
end;//TdaArchiUser.Set_HasAdminRights

function TdaArchiUser.Get_ExportPriority: TdaPriority;
//#UC START# *572B12420088_52FBA57600ABget_var*
//#UC END# *572B12420088_52FBA57600ABget_var*
begin
//#UC START# *572B12420088_52FBA57600ABget_impl*
 if f_ExportPriority = cPriorityNeedCalc then
 begin
  Assert(Assigned(f_CalcPriorityCallBack));
  f_CalcPriorityCallBack(f_ID, f_ExportPriority, f_ImportPriority);
 end;

 Result := f_ExportPriority;
//#UC END# *572B12420088_52FBA57600ABget_impl*
end;//TdaArchiUser.Get_ExportPriority

procedure TdaArchiUser.Set_ExportPriority(aValue: TdaPriority);
//#UC START# *572B12420088_52FBA57600ABset_var*
//#UC END# *572B12420088_52FBA57600ABset_var*
begin
//#UC START# *572B12420088_52FBA57600ABset_impl*
 f_ExportPriority := aValue;
//#UC END# *572B12420088_52FBA57600ABset_impl*
end;//TdaArchiUser.Set_ExportPriority

function TdaArchiUser.Get_ImportPriority: TdaPriority;
//#UC START# *572B125E006C_52FBA57600ABget_var*
//#UC END# *572B125E006C_52FBA57600ABget_var*
begin
//#UC START# *572B125E006C_52FBA57600ABget_impl*
 if f_ImportPriority = cPriorityNeedCalc then
 begin
  Assert(Assigned(f_CalcPriorityCallBack));
  f_CalcPriorityCallBack(f_ID, f_ExportPriority, f_ImportPriority);
 end;

 Result := f_ImportPriority;
//#UC END# *572B125E006C_52FBA57600ABget_impl*
end;//TdaArchiUser.Get_ImportPriority

procedure TdaArchiUser.Set_ImportPriority(aValue: TdaPriority);
//#UC START# *572B125E006C_52FBA57600ABset_var*
//#UC END# *572B125E006C_52FBA57600ABset_var*
begin
//#UC START# *572B125E006C_52FBA57600ABset_impl*
 f_ImportPriority := aValue;
//#UC END# *572B125E006C_52FBA57600ABset_impl*
end;//TdaArchiUser.Set_ImportPriority

function TdaArchiUser.Get_IP: AnsiString;
//#UC START# *572B126D0341_52FBA57600ABget_var*
//#UC END# *572B126D0341_52FBA57600ABget_var*
begin
//#UC START# *572B126D0341_52FBA57600ABget_impl*
 Result := f_IP;
//#UC END# *572B126D0341_52FBA57600ABget_impl*
end;//TdaArchiUser.Get_IP

procedure TdaArchiUser.Set_IP(const aValue: AnsiString);
//#UC START# *572B126D0341_52FBA57600ABset_var*
//#UC END# *572B126D0341_52FBA57600ABset_var*
begin
//#UC START# *572B126D0341_52FBA57600ABset_impl*
 f_IP := aValue;
//#UC END# *572B126D0341_52FBA57600ABset_impl*
end;//TdaArchiUser.Set_IP

function TdaArchiUser.Get_LoginDate: TDateTime;
//#UC START# *572B127D0098_52FBA57600ABget_var*
//#UC END# *572B127D0098_52FBA57600ABget_var*
begin
//#UC START# *572B127D0098_52FBA57600ABget_impl*
 Result := f_LoginDate;
//#UC END# *572B127D0098_52FBA57600ABget_impl*
end;//TdaArchiUser.Get_LoginDate

procedure TdaArchiUser.Set_LoginDate(aValue: TDateTime);
//#UC START# *572B127D0098_52FBA57600ABset_var*
//#UC END# *572B127D0098_52FBA57600ABset_var*
begin
//#UC START# *572B127D0098_52FBA57600ABset_impl*
 f_LoginDate := aValue;
//#UC END# *572B127D0098_52FBA57600ABset_impl*
end;//TdaArchiUser.Set_LoginDate

function TdaArchiUser.Get_LoginName: AnsiString;
//#UC START# *572B128D015A_52FBA57600ABget_var*
//#UC END# *572B128D015A_52FBA57600ABget_var*
begin
//#UC START# *572B128D015A_52FBA57600ABget_impl*
 Result := f_LoginName;
//#UC END# *572B128D015A_52FBA57600ABget_impl*
end;//TdaArchiUser.Get_LoginName

procedure TdaArchiUser.Set_LoginName(const aValue: AnsiString);
//#UC START# *572B128D015A_52FBA57600ABset_var*
//#UC END# *572B128D015A_52FBA57600ABset_var*
begin
//#UC START# *572B128D015A_52FBA57600ABset_impl*
 f_LoginName := aValue;
//#UC END# *572B128D015A_52FBA57600ABset_impl*
end;//TdaArchiUser.Set_LoginName

function TdaArchiUser.Get_Password: AnsiString;
//#UC START# *572B129D021B_52FBA57600ABget_var*
//#UC END# *572B129D021B_52FBA57600ABget_var*
begin
//#UC START# *572B129D021B_52FBA57600ABget_impl*
 Result := f_Password;
//#UC END# *572B129D021B_52FBA57600ABget_impl*
end;//TdaArchiUser.Get_Password

procedure TdaArchiUser.Set_Password(const aValue: AnsiString);
//#UC START# *572B129D021B_52FBA57600ABset_var*
//#UC END# *572B129D021B_52FBA57600ABset_var*
begin
//#UC START# *572B129D021B_52FBA57600ABset_impl*
 f_Password := aValue;
//#UC END# *572B129D021B_52FBA57600ABset_impl*
end;//TdaArchiUser.Set_Password

function TdaArchiUser.Get_UserName: AnsiString;
//#UC START# *572B12AE028C_52FBA57600ABget_var*
//#UC END# *572B12AE028C_52FBA57600ABget_var*
begin
//#UC START# *572B12AE028C_52FBA57600ABget_impl*
 Result := f_UserName;
//#UC END# *572B12AE028C_52FBA57600ABget_impl*
end;//TdaArchiUser.Get_UserName

procedure TdaArchiUser.Set_UserName(const aValue: AnsiString);
//#UC START# *572B12AE028C_52FBA57600ABset_var*
//#UC END# *572B12AE028C_52FBA57600ABset_var*
begin
//#UC START# *572B12AE028C_52FBA57600ABset_impl*
 f_UserName := aValue;
//#UC END# *572B12AE028C_52FBA57600ABset_impl*
end;//TdaArchiUser.Set_UserName

procedure TdaArchiUser.ClearFields;
begin
 IP := '';
 LoginName := '';
 Password := '';
 UserName := '';
 inherited;
end;//TdaArchiUser.ClearFields

end.
