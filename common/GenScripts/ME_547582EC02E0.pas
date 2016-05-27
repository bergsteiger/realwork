unit ncsDeliveryResult;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsDeliveryResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsDeliveryResult" MUID: (547582EC02E0)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , evdNcsTypes
 , k2Base
;

type
 TncsDeliveryResult = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetResultKind: TncsResultKind;
   procedure pm_SetResultKind(aValue: TncsResultKind);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property ResultKind: TncsResultKind
    read pm_GetResultKind
    write pm_SetResultKind;
 end;//TncsDeliveryResult
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csDeliveryResult_Const
;

function TncsDeliveryResult.pm_GetTaskID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsDeliveryResult.pm_GetTaskID

procedure TncsDeliveryResult.pm_SetTaskID(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsDeliveryResult.pm_SetTaskID

function TncsDeliveryResult.pm_GetResultKind: TncsResultKind;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TncsResultKind(TaggedData.IntA[k2_attrResultKind]);
end;//TncsDeliveryResult.pm_GetResultKind

procedure TncsDeliveryResult.pm_SetResultKind(aValue: TncsResultKind);
begin
 TaggedData.IntW[k2_attrResultKind, nil] := Ord(aValue);
end;//TncsDeliveryResult.pm_SetResultKind

class function TncsDeliveryResult.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsDeliveryResult;
end;//TncsDeliveryResult.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
