unit csDeleteDocsQueryPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csDeleteDocsQueryPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsDeleteDocsQueryPrim
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
 TcsDeleteDocsQueryPrim = class(TddProcessTask)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsDeleteDocsQueryPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  DeleteDocsQuery_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsDeleteDocsQueryPrim

class function TcsDeleteDocsQueryPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typDeleteDocsQuery;
end;//TcsDeleteDocsQueryPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.