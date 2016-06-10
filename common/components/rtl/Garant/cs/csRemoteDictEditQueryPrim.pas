unit csRemoteDictEditQueryPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csRemoteDictEditQueryPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsRemoteDictEditQueryPrim
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
 TcsRemoteDictEditQueryPrim = class(TddProcessTask)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsRemoteDictEditQueryPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  RemoteDictEditQuery_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsRemoteDictEditQueryPrim

class function TcsRemoteDictEditQueryPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typRemoteDictEditQuery;
end;//TcsRemoteDictEditQueryPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.