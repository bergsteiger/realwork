unit NOT_COMPLETED_ncsGetPartialTaskDescription;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_ncsGetPartialTaskDescription.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetPartialTaskDescription" MUID: (54B66DB30346)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsGetTaskDescription
 , k2Base
;

type
 TncsGetPartialTaskDescription = class(TncsGetTaskDescription)
  protected
   function pm_GetFileName: AnsiString;
   procedure pm_SetFileName(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property FileName: AnsiString
    read pm_GetFileName
    write pm_SetFileName;
 end;//TncsGetPartialTaskDescription
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetPartialTaskDescription_Const
;

function TncsGetPartialTaskDescription.pm_GetFileName: AnsiString;
//#UC START# *E22FD6A558D1_54B66DB30346get_var*
//#UC END# *E22FD6A558D1_54B66DB30346get_var*
begin
//#UC START# *E22FD6A558D1_54B66DB30346get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E22FD6A558D1_54B66DB30346get_impl*
end;//TncsGetPartialTaskDescription.pm_GetFileName

procedure TncsGetPartialTaskDescription.pm_SetFileName(const aValue: AnsiString);
//#UC START# *E22FD6A558D1_54B66DB30346set_var*
//#UC END# *E22FD6A558D1_54B66DB30346set_var*
begin
//#UC START# *E22FD6A558D1_54B66DB30346set_impl*
 !!! Needs to be implemented !!!
//#UC END# *E22FD6A558D1_54B66DB30346set_impl*
end;//TncsGetPartialTaskDescription.pm_SetFileName

class function TncsGetPartialTaskDescription.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54B66DB30346_var*
//#UC END# *53AC03EE01FD_54B66DB30346_var*
begin
//#UC START# *53AC03EE01FD_54B66DB30346_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54B66DB30346_impl*
end;//TncsGetPartialTaskDescription.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
