unit csSpellCorrectTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csSpellCorrectTaskPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsSpellCorrectTaskPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csProcessTask,
  csTasksHelpers,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsSpellCorrectTaskPrim = class(TddProcessTask)
 protected
 // property methods
   function pm_GetReplacementFile: ReplacementFileHelper;
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property ReplacementFile: ReplacementFileHelper
     read pm_GetReplacementFile;
 end;//TcsSpellCorrectTaskPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  SpellCorrectTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsSpellCorrectTaskPrim

function TcsSpellCorrectTaskPrim.pm_GetReplacementFile: ReplacementFileHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TReplacementFileHelper.Make(TaggedData.cAtom(k2_attrReplacementFile));
end;//TcsSpellCorrectTaskPrim.pm_GetReplacementFile

class function TcsSpellCorrectTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typSpellCorrectTask;
end;//TcsSpellCorrectTaskPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.