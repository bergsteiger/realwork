unit csMultiClearAttributesReply;

// Модуль: "w:\common\components\rtl\Garant\cs\csMultiClearAttributesReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMultiClearAttributesReply" MUID: (57EBA06202BE)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , evdTasksHelpers
 , k2Base
;

type
 TcsMultiClearAttributesReply = class(TncsReply)
  protected
   function pm_GetRejectedIDList: RejectedIDListHelper;
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
   function pm_GetErrorMessage: AnsiString;
   procedure pm_SetErrorMessage(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property RejectedIDList: RejectedIDListHelper
    read pm_GetRejectedIDList;
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
   property ErrorMessage: AnsiString
    read pm_GetErrorMessage
    write pm_SetErrorMessage;
 end;//TcsMultiClearAttributesReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csMultiClearAttributesReply_Const
 //#UC START# *57EBA06202BEimpl_uses*
 //#UC END# *57EBA06202BEimpl_uses*
;

function TcsMultiClearAttributesReply.pm_GetRejectedIDList: RejectedIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TRejectedIDListHelper.Make(TaggedData.cAtom(k2_attrRejectedIDList));
end;//TcsMultiClearAttributesReply.pm_GetRejectedIDList

function TcsMultiClearAttributesReply.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TcsMultiClearAttributesReply.pm_GetIsSuccess

procedure TcsMultiClearAttributesReply.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TcsMultiClearAttributesReply.pm_SetIsSuccess

function TcsMultiClearAttributesReply.pm_GetErrorMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrErrorMessage]);
end;//TcsMultiClearAttributesReply.pm_GetErrorMessage

procedure TcsMultiClearAttributesReply.pm_SetErrorMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrErrorMessage, nil] := (aValue);
end;//TcsMultiClearAttributesReply.pm_SetErrorMessage

class function TcsMultiClearAttributesReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsMultiClearAttributesReply;
end;//TcsMultiClearAttributesReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
