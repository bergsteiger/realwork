unit csMultiChangeHyperLinksReply;

// Модуль: "w:\common\components\rtl\Garant\cs\csMultiChangeHyperLinksReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMultiChangeHyperLinksReply" MUID: (5800BD8000B6)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TcsMultiChangeHyperLinksReply = class(TncsReply)
  protected
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
   function pm_GetErrorMessage: AnsiString;
   procedure pm_SetErrorMessage(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
   property ErrorMessage: AnsiString
    read pm_GetErrorMessage
    write pm_SetErrorMessage;
 end;//TcsMultiChangeHyperLinksReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csMultiChangeHyperLinksReply_Const
 //#UC START# *5800BD8000B6impl_uses*
 //#UC END# *5800BD8000B6impl_uses*
;

function TcsMultiChangeHyperLinksReply.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TcsMultiChangeHyperLinksReply.pm_GetIsSuccess

procedure TcsMultiChangeHyperLinksReply.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TcsMultiChangeHyperLinksReply.pm_SetIsSuccess

function TcsMultiChangeHyperLinksReply.pm_GetErrorMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrErrorMessage]);
end;//TcsMultiChangeHyperLinksReply.pm_GetErrorMessage

procedure TcsMultiChangeHyperLinksReply.pm_SetErrorMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrErrorMessage, nil] := (aValue);
end;//TcsMultiChangeHyperLinksReply.pm_SetErrorMessage

class function TcsMultiChangeHyperLinksReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsMultiChangeHyperLinksReply;
end;//TcsMultiChangeHyperLinksReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
