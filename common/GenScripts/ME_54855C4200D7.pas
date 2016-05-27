unit ncsSendTaskReply;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsSendTaskReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsSendTaskReply" MUID: (54855C4200D7)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsSendTaskReply = class(TncsReply)
  protected
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
 end;//TncsSendTaskReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csSendTaskReply_Const
;

function TncsSendTaskReply.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TncsSendTaskReply.pm_GetIsSuccess

procedure TncsSendTaskReply.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TncsSendTaskReply.pm_SetIsSuccess

class function TncsSendTaskReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsSendTaskReply;
end;//TncsSendTaskReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
