unit ncsGetReadyToDeliveryTasks;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsGetReadyToDeliveryTasks.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsGetReadyToDeliveryTasks
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  ncsMessage,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsGetReadyToDeliveryTasks = class(TncsMessage)
 protected
 // property methods
   function pm_GetUserID: Cardinal;
   procedure pm_SetUserID(aValue: Cardinal);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property UserID: Cardinal
     read pm_GetUserID
     write pm_SetUserID;
 end;//TncsGetReadyToDeliveryTasks
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csGetReadyToDeliveryTasks_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsGetReadyToDeliveryTasks

function TncsGetReadyToDeliveryTasks.pm_GetUserID: Cardinal;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Cardinal(TaggedData.IntA[k2_attrUserID]);
end;//TncsGetReadyToDeliveryTasks.pm_GetUserID

procedure TncsGetReadyToDeliveryTasks.pm_SetUserID(aValue: Cardinal);
 {-}
begin
 TaggedData.IntW[k2_attrUserID, nil] := Integer(aValue);
end;//TncsGetReadyToDeliveryTasks.pm_SetUserID

class function TncsGetReadyToDeliveryTasks.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsGetReadyToDeliveryTasks;
end;//TncsGetReadyToDeliveryTasks.GetTaggedDataType

{$IfEnd} //not Nemesis

end.