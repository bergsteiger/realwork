unit csAutoSpellTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csAutoSpellTaskPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsAutoSpellTaskPrim
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
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsAutoSpellTaskPrim = class(TddProcessTask)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsAutoSpellTaskPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  AutoSpellTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsAutoSpellTaskPrim

class function TcsAutoSpellTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAutoSpellTask;
end;//TcsAutoSpellTaskPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.