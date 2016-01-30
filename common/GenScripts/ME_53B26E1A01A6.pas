unit csUserDefinedExportTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csUserDefinedExportTaskPrim.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , UserDefinedExportTask_Const
 , k2Base
;

type
 TcsUserDefinedExportTaskPrim = class(TddProcessTask)
  protected
   function pm_GetQueryFile: AnsiString;
   procedure pm_SetQueryFile(const aValue: AnsiString);
   function pm_GetTimeToRun: TDateTime;
   procedure pm_SetTimeToRun(aValue: TDateTime);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property QueryFile: AnsiString
    read pm_GetQueryFile
    write pm_SetQueryFile;
   property TimeToRun: TDateTime
    read pm_GetTimeToRun
    write pm_SetTimeToRun;
 end;//TcsUserDefinedExportTaskPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

function TcsUserDefinedExportTaskPrim.pm_GetQueryFile: AnsiString;
//#UC START# *3FED742390E4_53B26E1A01A6get_var*
//#UC END# *3FED742390E4_53B26E1A01A6get_var*
begin
//#UC START# *3FED742390E4_53B26E1A01A6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3FED742390E4_53B26E1A01A6get_impl*
end;//TcsUserDefinedExportTaskPrim.pm_GetQueryFile

procedure TcsUserDefinedExportTaskPrim.pm_SetQueryFile(const aValue: AnsiString);
//#UC START# *3FED742390E4_53B26E1A01A6set_var*
//#UC END# *3FED742390E4_53B26E1A01A6set_var*
begin
//#UC START# *3FED742390E4_53B26E1A01A6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *3FED742390E4_53B26E1A01A6set_impl*
end;//TcsUserDefinedExportTaskPrim.pm_SetQueryFile

function TcsUserDefinedExportTaskPrim.pm_GetTimeToRun: TDateTime;
//#UC START# *4DDC348B9CCC_53B26E1A01A6get_var*
//#UC END# *4DDC348B9CCC_53B26E1A01A6get_var*
begin
//#UC START# *4DDC348B9CCC_53B26E1A01A6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDC348B9CCC_53B26E1A01A6get_impl*
end;//TcsUserDefinedExportTaskPrim.pm_GetTimeToRun

procedure TcsUserDefinedExportTaskPrim.pm_SetTimeToRun(aValue: TDateTime);
//#UC START# *4DDC348B9CCC_53B26E1A01A6set_var*
//#UC END# *4DDC348B9CCC_53B26E1A01A6set_var*
begin
//#UC START# *4DDC348B9CCC_53B26E1A01A6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDC348B9CCC_53B26E1A01A6set_impl*
end;//TcsUserDefinedExportTaskPrim.pm_SetTimeToRun

class function TcsUserDefinedExportTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B26E1A01A6_var*
//#UC END# *53AC03EE01FD_53B26E1A01A6_var*
begin
//#UC START# *53AC03EE01FD_53B26E1A01A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B26E1A01A6_impl*
end;//TcsUserDefinedExportTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
