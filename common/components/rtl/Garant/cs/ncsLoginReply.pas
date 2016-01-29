unit ncsLoginReply;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsLoginReply.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsLoginReply
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
  ncsMessage,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsLoginReply = class(TncsReply)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 end;//TncsLoginReply
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csLoginReply_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsLoginReply

class function TncsLoginReply.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsLoginReply;
end;//TncsLoginReply.GetTaggedDataType

{$IfEnd} //not Nemesis

end.