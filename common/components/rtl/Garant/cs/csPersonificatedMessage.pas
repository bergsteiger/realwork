unit csPersonificatedMessage;

// Модуль: "w:\common\components\rtl\Garant\cs\csPersonificatedMessage.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsPersonificatedMessage" MUID: (57F25AF103B0)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TcsPersonificatedMessage = class(TncsMessage)
  protected
   function pm_GetUserID: Cardinal;
   procedure pm_SetUserID(aValue: Cardinal);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property UserID: Cardinal
    read pm_GetUserID
    write pm_SetUserID;
 end;//TcsPersonificatedMessage
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csPersonificatedMessage_Const
 //#UC START# *57F25AF103B0impl_uses*
 //#UC END# *57F25AF103B0impl_uses*
;

function TcsPersonificatedMessage.pm_GetUserID: Cardinal;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Cardinal(TaggedData.IntA[k2_attrUserID]);
end;//TcsPersonificatedMessage.pm_GetUserID

procedure TcsPersonificatedMessage.pm_SetUserID(aValue: Cardinal);
begin
 TaggedData.IntW[k2_attrUserID, nil] := Integer(aValue);
end;//TcsPersonificatedMessage.pm_SetUserID

class function TcsPersonificatedMessage.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsPersonificatedMessage;
end;//TcsPersonificatedMessage.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
