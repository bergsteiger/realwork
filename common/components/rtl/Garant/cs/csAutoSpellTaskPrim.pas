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
 //#UC START# *53B682E2009Fimpl_uses*
 //#UC END# *53B682E2009Fimpl_uses*
;

class function TcsAutoSpellTaskPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAutoSpellTask;
end;//TcsAutoSpellTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
