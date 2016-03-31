unit ncsLoginMessage;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsLoginMessage.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsLoginMessage" MUID: (544E07C6034D)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsLoginMessage = class(TncsMessage)
  protected
   function pm_GetServerHost: AnsiString;
   procedure pm_SetServerHost(const aValue: AnsiString);
   function pm_GetLogin: AnsiString;
   procedure pm_SetLogin(const aValue: AnsiString);
   function pm_GetPassword: AnsiString;
   procedure pm_SetPassword(const aValue: AnsiString);
   function pm_GetServerPort: Integer;
   procedure pm_SetServerPort(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ServerHost: AnsiString
    read pm_GetServerHost
    write pm_SetServerHost;
   property Login: AnsiString
    read pm_GetLogin
    write pm_SetLogin;
   property Password: AnsiString
    read pm_GetPassword
    write pm_SetPassword;
   property ServerPort: Integer
    read pm_GetServerPort
    write pm_SetServerPort;
 end;//TncsLoginMessage
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csLogin_Const
;

function TncsLoginMessage.pm_GetServerHost: AnsiString;
//#UC START# *A8CE837D53E8_544E07C6034Dget_var*
//#UC END# *A8CE837D53E8_544E07C6034Dget_var*
begin
//#UC START# *A8CE837D53E8_544E07C6034Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *A8CE837D53E8_544E07C6034Dget_impl*
end;//TncsLoginMessage.pm_GetServerHost

procedure TncsLoginMessage.pm_SetServerHost(const aValue: AnsiString);
//#UC START# *A8CE837D53E8_544E07C6034Dset_var*
//#UC END# *A8CE837D53E8_544E07C6034Dset_var*
begin
//#UC START# *A8CE837D53E8_544E07C6034Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *A8CE837D53E8_544E07C6034Dset_impl*
end;//TncsLoginMessage.pm_SetServerHost

function TncsLoginMessage.pm_GetLogin: AnsiString;
//#UC START# *F242EF9D067F_544E07C6034Dget_var*
//#UC END# *F242EF9D067F_544E07C6034Dget_var*
begin
//#UC START# *F242EF9D067F_544E07C6034Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *F242EF9D067F_544E07C6034Dget_impl*
end;//TncsLoginMessage.pm_GetLogin

procedure TncsLoginMessage.pm_SetLogin(const aValue: AnsiString);
//#UC START# *F242EF9D067F_544E07C6034Dset_var*
//#UC END# *F242EF9D067F_544E07C6034Dset_var*
begin
//#UC START# *F242EF9D067F_544E07C6034Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *F242EF9D067F_544E07C6034Dset_impl*
end;//TncsLoginMessage.pm_SetLogin

function TncsLoginMessage.pm_GetPassword: AnsiString;
//#UC START# *1E446BBD08F0_544E07C6034Dget_var*
//#UC END# *1E446BBD08F0_544E07C6034Dget_var*
begin
//#UC START# *1E446BBD08F0_544E07C6034Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *1E446BBD08F0_544E07C6034Dget_impl*
end;//TncsLoginMessage.pm_GetPassword

procedure TncsLoginMessage.pm_SetPassword(const aValue: AnsiString);
//#UC START# *1E446BBD08F0_544E07C6034Dset_var*
//#UC END# *1E446BBD08F0_544E07C6034Dset_var*
begin
//#UC START# *1E446BBD08F0_544E07C6034Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *1E446BBD08F0_544E07C6034Dset_impl*
end;//TncsLoginMessage.pm_SetPassword

function TncsLoginMessage.pm_GetServerPort: Integer;
//#UC START# *25BE68E15A6A_544E07C6034Dget_var*
//#UC END# *25BE68E15A6A_544E07C6034Dget_var*
begin
//#UC START# *25BE68E15A6A_544E07C6034Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *25BE68E15A6A_544E07C6034Dget_impl*
end;//TncsLoginMessage.pm_GetServerPort

procedure TncsLoginMessage.pm_SetServerPort(aValue: Integer);
//#UC START# *25BE68E15A6A_544E07C6034Dset_var*
//#UC END# *25BE68E15A6A_544E07C6034Dset_var*
begin
//#UC START# *25BE68E15A6A_544E07C6034Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *25BE68E15A6A_544E07C6034Dset_impl*
end;//TncsLoginMessage.pm_SetServerPort

class function TncsLoginMessage.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_544E07C6034D_var*
//#UC END# *53AC03EE01FD_544E07C6034D_var*
begin
//#UC START# *53AC03EE01FD_544E07C6034D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_544E07C6034D_impl*
end;//TncsLoginMessage.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
