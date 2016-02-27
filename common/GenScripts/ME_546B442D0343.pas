unit ncsGetTaskDescriptionReply;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetTaskDescriptionReply.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , ncsFileDescHelper
 , k2Base
;

type
 TncsGetTaskDescriptionReply = class(TncsReply)
  protected
   function pm_GetLocalFolder: AnsiString;
   procedure pm_SetLocalFolder(const aValue: AnsiString);
   function pm_GetRemoteFolder: AnsiString;
   procedure pm_SetRemoteFolder(const aValue: AnsiString);
   function pm_GetFileDesc: FileDescHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property LocalFolder: AnsiString
    read pm_GetLocalFolder
    write pm_SetLocalFolder;
   property RemoteFolder: AnsiString
    read pm_GetRemoteFolder
    write pm_SetRemoteFolder;
   property FileDesc: FileDescHelper
    read pm_GetFileDesc;
 end;//TncsGetTaskDescriptionReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetTaskDescriptionReply_Const
;

function TncsGetTaskDescriptionReply.pm_GetLocalFolder: AnsiString;
//#UC START# *3294A79E3E3C_546B442D0343get_var*
//#UC END# *3294A79E3E3C_546B442D0343get_var*
begin
//#UC START# *3294A79E3E3C_546B442D0343get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3294A79E3E3C_546B442D0343get_impl*
end;//TncsGetTaskDescriptionReply.pm_GetLocalFolder

procedure TncsGetTaskDescriptionReply.pm_SetLocalFolder(const aValue: AnsiString);
//#UC START# *3294A79E3E3C_546B442D0343set_var*
//#UC END# *3294A79E3E3C_546B442D0343set_var*
begin
//#UC START# *3294A79E3E3C_546B442D0343set_impl*
 !!! Needs to be implemented !!!
//#UC END# *3294A79E3E3C_546B442D0343set_impl*
end;//TncsGetTaskDescriptionReply.pm_SetLocalFolder

function TncsGetTaskDescriptionReply.pm_GetRemoteFolder: AnsiString;
//#UC START# *87AC3958D4EC_546B442D0343get_var*
//#UC END# *87AC3958D4EC_546B442D0343get_var*
begin
//#UC START# *87AC3958D4EC_546B442D0343get_impl*
 !!! Needs to be implemented !!!
//#UC END# *87AC3958D4EC_546B442D0343get_impl*
end;//TncsGetTaskDescriptionReply.pm_GetRemoteFolder

procedure TncsGetTaskDescriptionReply.pm_SetRemoteFolder(const aValue: AnsiString);
//#UC START# *87AC3958D4EC_546B442D0343set_var*
//#UC END# *87AC3958D4EC_546B442D0343set_var*
begin
//#UC START# *87AC3958D4EC_546B442D0343set_impl*
 !!! Needs to be implemented !!!
//#UC END# *87AC3958D4EC_546B442D0343set_impl*
end;//TncsGetTaskDescriptionReply.pm_SetRemoteFolder

function TncsGetTaskDescriptionReply.pm_GetFileDesc: FileDescHelper;
//#UC START# *121B881CBEF7_546B442D0343get_var*
//#UC END# *121B881CBEF7_546B442D0343get_var*
begin
//#UC START# *121B881CBEF7_546B442D0343get_impl*
 !!! Needs to be implemented !!!
//#UC END# *121B881CBEF7_546B442D0343get_impl*
end;//TncsGetTaskDescriptionReply.pm_GetFileDesc

class function TncsGetTaskDescriptionReply.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_546B442D0343_var*
//#UC END# *53AC03EE01FD_546B442D0343_var*
begin
//#UC START# *53AC03EE01FD_546B442D0343_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_546B442D0343_impl*
end;//TncsGetTaskDescriptionReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
