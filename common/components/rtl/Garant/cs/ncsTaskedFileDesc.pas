unit ncsTaskedFileDesc;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsTaskedFileDesc.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsTaskedFileDesc" MUID: (546EF14803A6)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsFileDesc
 , k2Base
;

type
 TncsTaskedFileDesc = class(TncsFileDesc)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetCopiedSize: Int64;
   procedure pm_SetCopiedSize(aValue: Int64);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property CopiedSize: Int64
    read pm_GetCopiedSize
    write pm_SetCopiedSize;
 end;//TncsTaskedFileDesc
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , TaskedFileDesc_Const
;

function TncsTaskedFileDesc.pm_GetTaskID: AnsiString;
//#UC START# *4002BB80A765_546EF14803A6get_var*
//#UC END# *4002BB80A765_546EF14803A6get_var*
begin
//#UC START# *4002BB80A765_546EF14803A6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4002BB80A765_546EF14803A6get_impl*
end;//TncsTaskedFileDesc.pm_GetTaskID

procedure TncsTaskedFileDesc.pm_SetTaskID(const aValue: AnsiString);
//#UC START# *4002BB80A765_546EF14803A6set_var*
//#UC END# *4002BB80A765_546EF14803A6set_var*
begin
//#UC START# *4002BB80A765_546EF14803A6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4002BB80A765_546EF14803A6set_impl*
end;//TncsTaskedFileDesc.pm_SetTaskID

function TncsTaskedFileDesc.pm_GetCopiedSize: Int64;
//#UC START# *3B46B181312E_546EF14803A6get_var*
//#UC END# *3B46B181312E_546EF14803A6get_var*
begin
//#UC START# *3B46B181312E_546EF14803A6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3B46B181312E_546EF14803A6get_impl*
end;//TncsTaskedFileDesc.pm_GetCopiedSize

procedure TncsTaskedFileDesc.pm_SetCopiedSize(aValue: Int64);
//#UC START# *3B46B181312E_546EF14803A6set_var*
//#UC END# *3B46B181312E_546EF14803A6set_var*
begin
//#UC START# *3B46B181312E_546EF14803A6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *3B46B181312E_546EF14803A6set_impl*
end;//TncsTaskedFileDesc.pm_SetCopiedSize

class function TncsTaskedFileDesc.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_546EF14803A6_var*
//#UC END# *53AC03EE01FD_546EF14803A6_var*
begin
//#UC START# *53AC03EE01FD_546EF14803A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_546EF14803A6_impl*
end;//TncsTaskedFileDesc.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
