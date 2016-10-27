unit csMultiOperationReply;

// Модуль: "w:\common\components\rtl\Garant\cs\csMultiOperationReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMultiOperationReply" MUID: (57EE517102EC)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TcsMultiOperationReply = class(TncsReply)
  protected
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
   function pm_GetErrorMessage: AnsiString;
   procedure pm_SetErrorMessage(const aValue: AnsiString);
   function pm_GetRejectedIDList: RejectedIDListHelper;
   function pm_GetProcessedCount: Integer;
   procedure pm_SetProcessedCount(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
   property ErrorMessage: AnsiString
    read pm_GetErrorMessage
    write pm_SetErrorMessage;
   property RejectedIDList: RejectedIDListHelper
    read pm_GetRejectedIDList;
   property ProcessedCount: Integer
    read pm_GetProcessedCount
    write pm_SetProcessedCount;
 end;//TcsMultiOperationReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csMultiOperationReply_Const
 //#UC START# *57EE517102ECimpl_uses*
 //#UC END# *57EE517102ECimpl_uses*
;

function TcsMultiOperationReply.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TcsMultiOperationReply.pm_GetIsSuccess

procedure TcsMultiOperationReply.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TcsMultiOperationReply.pm_SetIsSuccess

function TcsMultiOperationReply.pm_GetErrorMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrErrorMessage]);
end;//TcsMultiOperationReply.pm_GetErrorMessage

procedure TcsMultiOperationReply.pm_SetErrorMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrErrorMessage, nil] := (aValue);
end;//TcsMultiOperationReply.pm_SetErrorMessage

function TcsMultiOperationReply.pm_GetRejectedIDList: RejectedIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TRejectedIDListHelper.Make(TaggedData.cAtom(k2_attrRejectedIDList));
end;//TcsMultiOperationReply.pm_GetRejectedIDList

function TcsMultiOperationReply.pm_GetProcessedCount: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrProcessedCount]);
end;//TcsMultiOperationReply.pm_GetProcessedCount

procedure TcsMultiOperationReply.pm_SetProcessedCount(aValue: Integer);
begin
 TaggedData.IntW[k2_attrProcessedCount, nil] := (aValue);
end;//TcsMultiOperationReply.pm_SetProcessedCount

class function TcsMultiOperationReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsMultiOperationReply;
end;//TcsMultiOperationReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
