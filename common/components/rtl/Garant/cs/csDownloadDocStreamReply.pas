unit csDownloadDocStreamReply;

// Модуль: "w:\common\components\rtl\Garant\cs\csDownloadDocStreamReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsDownloadDocStreamReply" MUID: (57BFF6EA005F)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2SizedMemoryPool
 , k2Base
;

type
 TcsDownloadDocStreamReply = class(TncsReply)
  protected
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
   function pm_GetData: Tk2RawData;
   procedure pm_SetData(aValue: Tk2RawData);
   function pm_GetErrorMessage: AnsiString;
   procedure pm_SetErrorMessage(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
   property Data: Tk2RawData
    read pm_GetData
    write pm_SetData;
   property ErrorMessage: AnsiString
    read pm_GetErrorMessage
    write pm_SetErrorMessage;
 end;//TcsDownloadDocStreamReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csDownloadDocStreamReply_Const
 //#UC START# *57BFF6EA005Fimpl_uses*
 //#UC END# *57BFF6EA005Fimpl_uses*
;

function TcsDownloadDocStreamReply.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TcsDownloadDocStreamReply.pm_GetIsSuccess

procedure TcsDownloadDocStreamReply.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TcsDownloadDocStreamReply.pm_SetIsSuccess

function TcsDownloadDocStreamReply.pm_GetData: Tk2RawData;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Tk2RawData(TaggedData.cAtom(k2_attrData));
end;//TcsDownloadDocStreamReply.pm_GetData

procedure TcsDownloadDocStreamReply.pm_SetData(aValue: Tk2RawData);
begin
 TaggedData.AttrW[k2_attrData, nil] := (aValue);
end;//TcsDownloadDocStreamReply.pm_SetData

function TcsDownloadDocStreamReply.pm_GetErrorMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrErrorMessage]);
end;//TcsDownloadDocStreamReply.pm_GetErrorMessage

procedure TcsDownloadDocStreamReply.pm_SetErrorMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrErrorMessage, nil] := (aValue);
end;//TcsDownloadDocStreamReply.pm_SetErrorMessage

class function TcsDownloadDocStreamReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsDownloadDocStreamReply;
end;//TcsDownloadDocStreamReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
