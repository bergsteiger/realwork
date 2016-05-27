unit csSpellCorrectTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csSpellCorrectTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsSpellCorrectTaskPrim" MUID: (53B2545A003D)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
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
 , SpellCorrectTask_Const
;

function TcsSpellCorrectTaskPrim.pm_GetReplacementFile: ReplacementFileHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TReplacementFileHelper.Make(TaggedData.cAtom(k2_attrReplacementFile));
end;//TcsSpellCorrectTaskPrim.pm_GetReplacementFile

class function TcsSpellCorrectTaskPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typSpellCorrectTask;
end;//TcsSpellCorrectTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
