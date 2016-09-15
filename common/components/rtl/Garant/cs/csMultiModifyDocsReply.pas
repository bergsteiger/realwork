unit csMultiModifyDocsReply;

// Модуль: "w:\common\components\rtl\Garant\cs\csMultiModifyDocsReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMultiModifyDocsReply" MUID: (57DA7796002F)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , l3Variant
 , k2Base
;

type
 TcsMultiModifyDocsReply = class(TncsReply)
  protected
   function pm_GetRejectedIDList: Tl3Tag;
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
   function pm_GetErrorMessage: AnsiString;
   procedure pm_SetErrorMessage(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property RejectedIDList: Tl3Tag
    read pm_GetRejectedIDList;
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
   property ErrorMessage: AnsiString
    read pm_GetErrorMessage
    write pm_SetErrorMessage;
 end;//TcsMultiModifyDocsReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csMultiModifyDocsReply_Const
 //#UC START# *57DA7796002Fimpl_uses*
 //#UC END# *57DA7796002Fimpl_uses*
;

function TcsMultiModifyDocsReply.pm_GetRejectedIDList: Tl3Tag;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TaggedData.cAtom(k2_attrRejectedIDList);
end;//TcsMultiModifyDocsReply.pm_GetRejectedIDList

function TcsMultiModifyDocsReply.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TcsMultiModifyDocsReply.pm_GetIsSuccess

procedure TcsMultiModifyDocsReply.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TcsMultiModifyDocsReply.pm_SetIsSuccess

function TcsMultiModifyDocsReply.pm_GetErrorMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrErrorMessage]);
end;//TcsMultiModifyDocsReply.pm_GetErrorMessage

procedure TcsMultiModifyDocsReply.pm_SetErrorMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrErrorMessage, nil] := (aValue);
end;//TcsMultiModifyDocsReply.pm_SetErrorMessage

class function TcsMultiModifyDocsReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsMultiModifyDocsReply;
end;//TcsMultiModifyDocsReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
