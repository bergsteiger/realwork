unit csLineRequestPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csLineRequestPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsLineRequestPrim
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
  csRequestTask,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsLineRequestPrim = class(TddRequestTask)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsLineRequestPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  LineRequest_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsLineRequestPrim

class function TcsLineRequestPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typLineRequest;
end;//TcsLineRequestPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.