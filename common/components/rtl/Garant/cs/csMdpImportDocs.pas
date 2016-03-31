unit csMdpImportDocs;

// Модуль: "w:\common\components\rtl\Garant\cs\csMdpImportDocs.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMdpImportDocs" MUID: (55EEC220007F)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsMdpImportDocs = class(TddProcessTask)
  protected
   function pm_GetMail: AnsiString;
   procedure pm_SetMail(const aValue: AnsiString);
   function pm_GetErrorMail: AnsiString;
   procedure pm_SetErrorMail(const aValue: AnsiString);
   function pm_GetMaxCount: Integer;
   procedure pm_SetMaxCount(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Mail: AnsiString
    read pm_GetMail
    write pm_SetMail;
   property ErrorMail: AnsiString
    read pm_GetErrorMail
    write pm_SetErrorMail;
   property MaxCount: Integer
    read pm_GetMaxCount
    write pm_SetMaxCount;
 end;//TcsMdpImportDocs
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , mdpImportDocs_Const
;

function TcsMdpImportDocs.pm_GetMail: AnsiString;
//#UC START# *ACB4DD73A6F0_55EEC220007Fget_var*
//#UC END# *ACB4DD73A6F0_55EEC220007Fget_var*
begin
//#UC START# *ACB4DD73A6F0_55EEC220007Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *ACB4DD73A6F0_55EEC220007Fget_impl*
end;//TcsMdpImportDocs.pm_GetMail

procedure TcsMdpImportDocs.pm_SetMail(const aValue: AnsiString);
//#UC START# *ACB4DD73A6F0_55EEC220007Fset_var*
//#UC END# *ACB4DD73A6F0_55EEC220007Fset_var*
begin
//#UC START# *ACB4DD73A6F0_55EEC220007Fset_impl*
 !!! Needs to be implemented !!!
//#UC END# *ACB4DD73A6F0_55EEC220007Fset_impl*
end;//TcsMdpImportDocs.pm_SetMail

function TcsMdpImportDocs.pm_GetErrorMail: AnsiString;
//#UC START# *2A71761FFD30_55EEC220007Fget_var*
//#UC END# *2A71761FFD30_55EEC220007Fget_var*
begin
//#UC START# *2A71761FFD30_55EEC220007Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *2A71761FFD30_55EEC220007Fget_impl*
end;//TcsMdpImportDocs.pm_GetErrorMail

procedure TcsMdpImportDocs.pm_SetErrorMail(const aValue: AnsiString);
//#UC START# *2A71761FFD30_55EEC220007Fset_var*
//#UC END# *2A71761FFD30_55EEC220007Fset_var*
begin
//#UC START# *2A71761FFD30_55EEC220007Fset_impl*
 !!! Needs to be implemented !!!
//#UC END# *2A71761FFD30_55EEC220007Fset_impl*
end;//TcsMdpImportDocs.pm_SetErrorMail

function TcsMdpImportDocs.pm_GetMaxCount: Integer;
//#UC START# *7F1C1465BBBC_55EEC220007Fget_var*
//#UC END# *7F1C1465BBBC_55EEC220007Fget_var*
begin
//#UC START# *7F1C1465BBBC_55EEC220007Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *7F1C1465BBBC_55EEC220007Fget_impl*
end;//TcsMdpImportDocs.pm_GetMaxCount

procedure TcsMdpImportDocs.pm_SetMaxCount(aValue: Integer);
//#UC START# *7F1C1465BBBC_55EEC220007Fset_var*
//#UC END# *7F1C1465BBBC_55EEC220007Fset_var*
begin
//#UC START# *7F1C1465BBBC_55EEC220007Fset_impl*
 !!! Needs to be implemented !!!
//#UC END# *7F1C1465BBBC_55EEC220007Fset_impl*
end;//TcsMdpImportDocs.pm_SetMaxCount

class function TcsMdpImportDocs.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_55EEC220007F_var*
//#UC END# *53AC03EE01FD_55EEC220007F_var*
begin
//#UC START# *53AC03EE01FD_55EEC220007F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_55EEC220007F_impl*
end;//TcsMdpImportDocs.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
