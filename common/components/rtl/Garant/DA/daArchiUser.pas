unit daArchiUser;

// Модуль: "w:\common\components\rtl\Garant\DA\daArchiUser.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaArchiUser" MUID: (57234C2903E3)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daTypes
 , Classes
;

type
 TdaArchiUser = class(Tl3ProtoObject)
  private
   f_ID: TdaUserID;
   f_Active: Boolean;
   f_HasAdminRights: Boolean;
   f_ExportPriority: TdaPriority;
   f_ImportPriority: TdaPriority;
   f_IP: AnsiString;
   f_LoginDate: TDateTime;
   f_LoginName: AnsiString;
   f_Password: AnsiString;
   f_UserName: AnsiString;
  protected
   procedure ClearFields; override;
  public
   procedure Load(aStream: TStream);
   procedure Save(aStream: TStream);
  public
   property ID: TdaUserID
    read f_ID
    write f_ID;
   property Active: Boolean
    read f_Active
    write f_Active;
   property HasAdminRights: Boolean
    read f_HasAdminRights
    write f_HasAdminRights;
   property ExportPriority: TdaPriority
    read f_ExportPriority
    write f_ExportPriority;
   property ImportPriority: TdaPriority
    read f_ImportPriority
    write f_ImportPriority;
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
;

procedure TdaArchiUser.Load(aStream: TStream);
//#UC START# *57234C5B02CA_57234C2903E3_var*
//#UC END# *57234C5B02CA_57234C2903E3_var*
begin
//#UC START# *57234C5B02CA_57234C2903E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *57234C5B02CA_57234C2903E3_impl*
end;//TdaArchiUser.Load

procedure TdaArchiUser.Save(aStream: TStream);
//#UC START# *57234C6E01C3_57234C2903E3_var*
//#UC END# *57234C6E01C3_57234C2903E3_var*
begin
//#UC START# *57234C6E01C3_57234C2903E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *57234C6E01C3_57234C2903E3_impl*
end;//TdaArchiUser.Save

procedure TdaArchiUser.ClearFields;
begin
 IP := '';
 LoginName := '';
 Password := '';
 UserName := '';
 inherited;
end;//TdaArchiUser.ClearFields

end.
