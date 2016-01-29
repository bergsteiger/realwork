unit ncsGetFilePartReply;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsGetFilePartReply.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsGetFilePartReply
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
 TncsGetFilePartReply = class(TncsReply)
 protected
 // property methods
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property IsSuccess: Boolean
     read pm_GetIsSuccess
     write pm_SetIsSuccess;
 end;//TncsGetFilePartReply
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csGetFilePartReply_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsGetFilePartReply

function TncsGetFilePartReply.pm_GetIsSuccess: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TncsGetFilePartReply.pm_GetIsSuccess

procedure TncsGetFilePartReply.pm_SetIsSuccess(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TncsGetFilePartReply.pm_SetIsSuccess

class function TncsGetFilePartReply.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsGetFilePartReply;
end;//TncsGetFilePartReply.GetTaggedDataType

{$IfEnd} //not Nemesis

end.