unit csAutoSpellTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csAutoSpellTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsAutoSpellTaskPrim" MUID: (53B682E2009F)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsAutoSpellTaskPrim = class(TddProcessTask)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsAutoSpellTaskPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , AutoSpellTask_Const
;

class function TcsAutoSpellTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B682E2009F_var*
//#UC END# *53AC03EE01FD_53B682E2009F_var*
begin
//#UC START# *53AC03EE01FD_53B682E2009F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B682E2009F_impl*
end;//TcsAutoSpellTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
