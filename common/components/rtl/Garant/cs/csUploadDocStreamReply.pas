unit csUploadDocStreamReply;

// Модуль: "w:\common\components\rtl\Garant\cs\csUploadDocStreamReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsUploadDocStreamReply" MUID: (57D270880150)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TcsUploadDocStreamReply = class(TncsReply)
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
 end;//TcsUploadDocStreamReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csUploadDocStreamReply_Const
 //#UC START# *57D270880150impl_uses*
 //#UC END# *57D270880150impl_uses*
;

function TcsUploadDocStreamReply.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TcsUploadDocStreamReply.pm_GetIsSuccess

procedure TcsUploadDocStreamReply.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TcsUploadDocStreamReply.pm_SetIsSuccess

function TcsUploadDocStreamReply.pm_GetErrorMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrErrorMessage]);
end;//TcsUploadDocStreamReply.pm_GetErrorMessage

procedure TcsUploadDocStreamReply.pm_SetErrorMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrErrorMessage, nil] := (aValue);
end;//TcsUploadDocStreamReply.pm_SetErrorMessage

class function TcsUploadDocStreamReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsUploadDocStreamReply;
end;//TcsUploadDocStreamReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
