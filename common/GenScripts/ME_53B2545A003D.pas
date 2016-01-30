unit csSpellCorrectTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csSpellCorrectTaskPrim.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , SpellCorrectTask_Const
 , csTasksHelpers
 , k2Base
;

type
 TcsSpellCorrectTaskPrim = class(TddProcessTask)
  protected
   function pm_GetReplacementFile: ReplacementFileHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ReplacementFile: ReplacementFileHelper
    read pm_GetReplacementFile;
 end;//TcsSpellCorrectTaskPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

function TcsSpellCorrectTaskPrim.pm_GetReplacementFile: ReplacementFileHelper;
//#UC START# *4D53CCA1F803_53B2545A003Dget_var*
//#UC END# *4D53CCA1F803_53B2545A003Dget_var*
begin
//#UC START# *4D53CCA1F803_53B2545A003Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D53CCA1F803_53B2545A003Dget_impl*
end;//TcsSpellCorrectTaskPrim.pm_GetReplacementFile

class function TcsSpellCorrectTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B2545A003D_var*
//#UC END# *53AC03EE01FD_53B2545A003D_var*
begin
//#UC START# *53AC03EE01FD_53B2545A003D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B2545A003D_impl*
end;//TcsSpellCorrectTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
