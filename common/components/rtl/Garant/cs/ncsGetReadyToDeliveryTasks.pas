unit ncsGetReadyToDeliveryTasks;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetReadyToDeliveryTasks.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetReadyToDeliveryTasks" MUID: (54645DEC03E4)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsGetReadyToDeliveryTasks = class(TncsMessage)
  protected
   function pm_GetUserID: Cardinal;
   procedure pm_SetUserID(aValue: Cardinal);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property UserID: Cardinal
    read pm_GetUserID
    write pm_SetUserID;
 end;//TncsGetReadyToDeliveryTasks
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetReadyToDeliveryTasks_Const
 //#UC START# *54645DEC03E4impl_uses*
 //#UC END# *54645DEC03E4impl_uses*
;

function TncsGetReadyToDeliveryTasks.pm_GetUserID: Cardinal;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Cardinal(TaggedData.IntA[k2_attrUserID]);
end;//TncsGetReadyToDeliveryTasks.pm_GetUserID

procedure TncsGetReadyToDeliveryTasks.pm_SetUserID(aValue: Cardinal);
begin
 TaggedData.IntW[k2_attrUserID, nil] := Integer(aValue);
end;//TncsGetReadyToDeliveryTasks.pm_SetUserID

class function TncsGetReadyToDeliveryTasks.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsGetReadyToDeliveryTasks;
end;//TncsGetReadyToDeliveryTasks.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
