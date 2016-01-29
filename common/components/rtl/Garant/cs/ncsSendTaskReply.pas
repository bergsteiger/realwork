unit ncsSendTaskReply;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsSendTaskReply.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::TaskSend::TncsSendTaskReply
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
 TncsSendTaskReply = class(TncsReply)
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
 end;//TncsSendTaskReply
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csSendTaskReply_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsSendTaskReply

function TncsSendTaskReply.pm_GetIsSuccess: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TncsSendTaskReply.pm_GetIsSuccess

procedure TncsSendTaskReply.pm_SetIsSuccess(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TncsSendTaskReply.pm_SetIsSuccess

class function TncsSendTaskReply.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsSendTaskReply;
end;//TncsSendTaskReply.GetTaggedDataType

{$IfEnd} //not Nemesis

end.