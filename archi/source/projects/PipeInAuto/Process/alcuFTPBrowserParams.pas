unit alcuFTPBrowserParams;

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\alcuFTPBrowserParams.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuFTPBrowserParams" MUID: (54041EBF03C6)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , k2Base
 , Classes
;

type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TalcuFTPBrowserParams = class(_evdTagHolder_)
  protected
   function pm_GetServerName: AnsiString;
   procedure pm_SetServerName(const aValue: AnsiString);
   function pm_GetPort: Integer;
   procedure pm_SetPort(aValue: Integer);
   function pm_GetLogin: AnsiString;
   procedure pm_SetLogin(const aValue: AnsiString);
   function pm_GetPassword: AnsiString;
   procedure pm_SetPassword(const aValue: AnsiString);
   function pm_GetPassiveMode: Boolean;
   procedure pm_SetPassiveMode(aValue: Boolean);
   function pm_GetRemoteFolder: AnsiString;
   procedure pm_SetRemoteFolder(const aValue: AnsiString);
   function pm_GetLogTitle: AnsiString;
   procedure pm_SetLogTitle(const aValue: AnsiString);
   procedure InitFields; override;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ServerName: AnsiString
    read pm_GetServerName
    write pm_SetServerName;
   property Port: Integer
    read pm_GetPort
    write pm_SetPort;
   property Login: AnsiString
    read pm_GetLogin
    write pm_SetLogin;
   property Password: AnsiString
    read pm_GetPassword
    write pm_SetPassword;
   property PassiveMode: Boolean
    read pm_GetPassiveMode
    write pm_SetPassiveMode;
   property RemoteFolder: AnsiString
    read pm_GetRemoteFolder
    write pm_SetRemoteFolder;
   property LogTitle: AnsiString
    read pm_GetLogTitle
    write pm_SetLogTitle;
 end;//TalcuFTPBrowserParams

implementation

uses
 l3ImplUses
 , IdAssignedNumbers
 , FTPBrowser_Const
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TalcuFTPBrowserParams.pm_GetServerName: AnsiString;
//#UC START# *202E75514D0E_54041EBF03C6get_var*
//#UC END# *202E75514D0E_54041EBF03C6get_var*
begin
//#UC START# *202E75514D0E_54041EBF03C6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *202E75514D0E_54041EBF03C6get_impl*
end;//TalcuFTPBrowserParams.pm_GetServerName

procedure TalcuFTPBrowserParams.pm_SetServerName(const aValue: AnsiString);
//#UC START# *202E75514D0E_54041EBF03C6set_var*
//#UC END# *202E75514D0E_54041EBF03C6set_var*
begin
//#UC START# *202E75514D0E_54041EBF03C6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *202E75514D0E_54041EBF03C6set_impl*
end;//TalcuFTPBrowserParams.pm_SetServerName

function TalcuFTPBrowserParams.pm_GetPort: Integer;
//#UC START# *073FDA93F8D8_54041EBF03C6get_var*
//#UC END# *073FDA93F8D8_54041EBF03C6get_var*
begin
//#UC START# *073FDA93F8D8_54041EBF03C6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *073FDA93F8D8_54041EBF03C6get_impl*
end;//TalcuFTPBrowserParams.pm_GetPort

procedure TalcuFTPBrowserParams.pm_SetPort(aValue: Integer);
//#UC START# *073FDA93F8D8_54041EBF03C6set_var*
//#UC END# *073FDA93F8D8_54041EBF03C6set_var*
begin
//#UC START# *073FDA93F8D8_54041EBF03C6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *073FDA93F8D8_54041EBF03C6set_impl*
end;//TalcuFTPBrowserParams.pm_SetPort

function TalcuFTPBrowserParams.pm_GetLogin: AnsiString;
//#UC START# *20C2D44F4133_54041EBF03C6get_var*
//#UC END# *20C2D44F4133_54041EBF03C6get_var*
begin
//#UC START# *20C2D44F4133_54041EBF03C6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *20C2D44F4133_54041EBF03C6get_impl*
end;//TalcuFTPBrowserParams.pm_GetLogin

procedure TalcuFTPBrowserParams.pm_SetLogin(const aValue: AnsiString);
//#UC START# *20C2D44F4133_54041EBF03C6set_var*
//#UC END# *20C2D44F4133_54041EBF03C6set_var*
begin
//#UC START# *20C2D44F4133_54041EBF03C6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *20C2D44F4133_54041EBF03C6set_impl*
end;//TalcuFTPBrowserParams.pm_SetLogin

function TalcuFTPBrowserParams.pm_GetPassword: AnsiString;
//#UC START# *C2C175FB652C_54041EBF03C6get_var*
//#UC END# *C2C175FB652C_54041EBF03C6get_var*
begin
//#UC START# *C2C175FB652C_54041EBF03C6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *C2C175FB652C_54041EBF03C6get_impl*
end;//TalcuFTPBrowserParams.pm_GetPassword

procedure TalcuFTPBrowserParams.pm_SetPassword(const aValue: AnsiString);
//#UC START# *C2C175FB652C_54041EBF03C6set_var*
//#UC END# *C2C175FB652C_54041EBF03C6set_var*
begin
//#UC START# *C2C175FB652C_54041EBF03C6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *C2C175FB652C_54041EBF03C6set_impl*
end;//TalcuFTPBrowserParams.pm_SetPassword

function TalcuFTPBrowserParams.pm_GetPassiveMode: Boolean;
//#UC START# *7DA33908BCEC_54041EBF03C6get_var*
//#UC END# *7DA33908BCEC_54041EBF03C6get_var*
begin
//#UC START# *7DA33908BCEC_54041EBF03C6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7DA33908BCEC_54041EBF03C6get_impl*
end;//TalcuFTPBrowserParams.pm_GetPassiveMode

procedure TalcuFTPBrowserParams.pm_SetPassiveMode(aValue: Boolean);
//#UC START# *7DA33908BCEC_54041EBF03C6set_var*
//#UC END# *7DA33908BCEC_54041EBF03C6set_var*
begin
//#UC START# *7DA33908BCEC_54041EBF03C6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *7DA33908BCEC_54041EBF03C6set_impl*
end;//TalcuFTPBrowserParams.pm_SetPassiveMode

function TalcuFTPBrowserParams.pm_GetRemoteFolder: AnsiString;
//#UC START# *78091B6DF190_54041EBF03C6get_var*
//#UC END# *78091B6DF190_54041EBF03C6get_var*
begin
//#UC START# *78091B6DF190_54041EBF03C6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *78091B6DF190_54041EBF03C6get_impl*
end;//TalcuFTPBrowserParams.pm_GetRemoteFolder

procedure TalcuFTPBrowserParams.pm_SetRemoteFolder(const aValue: AnsiString);
//#UC START# *78091B6DF190_54041EBF03C6set_var*
//#UC END# *78091B6DF190_54041EBF03C6set_var*
begin
//#UC START# *78091B6DF190_54041EBF03C6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *78091B6DF190_54041EBF03C6set_impl*
end;//TalcuFTPBrowserParams.pm_SetRemoteFolder

function TalcuFTPBrowserParams.pm_GetLogTitle: AnsiString;
//#UC START# *D5E5C41ACD4D_54041EBF03C6get_var*
//#UC END# *D5E5C41ACD4D_54041EBF03C6get_var*
begin
//#UC START# *D5E5C41ACD4D_54041EBF03C6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D5E5C41ACD4D_54041EBF03C6get_impl*
end;//TalcuFTPBrowserParams.pm_GetLogTitle

procedure TalcuFTPBrowserParams.pm_SetLogTitle(const aValue: AnsiString);
//#UC START# *D5E5C41ACD4D_54041EBF03C6set_var*
//#UC END# *D5E5C41ACD4D_54041EBF03C6set_var*
begin
//#UC START# *D5E5C41ACD4D_54041EBF03C6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *D5E5C41ACD4D_54041EBF03C6set_impl*
end;//TalcuFTPBrowserParams.pm_SetLogTitle

class function TalcuFTPBrowserParams.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54041EBF03C6_var*
//#UC END# *53AC03EE01FD_54041EBF03C6_var*
begin
//#UC START# *53AC03EE01FD_54041EBF03C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54041EBF03C6_impl*
end;//TalcuFTPBrowserParams.GetTaggedDataType

procedure TalcuFTPBrowserParams.InitFields;
//#UC START# *47A042E100E2_54041EBF03C6_var*
//#UC END# *47A042E100E2_54041EBF03C6_var*
begin
//#UC START# *47A042E100E2_54041EBF03C6_impl*
 inherited;
 Port := IDPORT_FTP;
//#UC END# *47A042E100E2_54041EBF03C6_impl*
end;//TalcuFTPBrowserParams.InitFields

end.
