unit ncsGetReadyToDeliveryTasksReply;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsGetReadyToDeliveryTasksReply.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsGetReadyToDeliveryTasksReply
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
  evdTasksHelpers,
  ncsMessage,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsGetReadyToDeliveryTasksReply = class(TncsReply)
 protected
 // property methods
   function pm_GetTasksIDList: TasksIDListHelper;
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property TasksIDList: TasksIDListHelper
     read pm_GetTasksIDList;
 end;//TncsGetReadyToDeliveryTasksReply
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csGetReadyToDeliveryTasksReply_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsGetReadyToDeliveryTasksReply

function TncsGetReadyToDeliveryTasksReply.pm_GetTasksIDList: TasksIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TTasksIDListHelper.Make(TaggedData.cAtom(k2_attrTasksIDList));
end;//TncsGetReadyToDeliveryTasksReply.pm_GetTasksIDList

class function TncsGetReadyToDeliveryTasksReply.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsGetReadyToDeliveryTasksReply;
end;//TncsGetReadyToDeliveryTasksReply.GetTaggedDataType

{$IfEnd} //not Nemesis

end.