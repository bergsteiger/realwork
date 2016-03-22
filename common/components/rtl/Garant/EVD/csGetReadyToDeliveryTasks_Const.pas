unit csGetReadyToDeliveryTasks_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csGetReadyToDeliveryTasks_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csGetReadyToDeliveryTasks
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csGetReadyToDeliveryTasks .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrUserID: Integer;

function k2_typcsGetReadyToDeliveryTasks: csGetReadyToDeliveryTasksTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csGetReadyToDeliveryTasks : csGetReadyToDeliveryTasksTag = nil;

// start class csGetReadyToDeliveryTasksTag

function k2_typcsGetReadyToDeliveryTasks: csGetReadyToDeliveryTasksTag;
begin
 if (g_csGetReadyToDeliveryTasks = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csGetReadyToDeliveryTasks := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csGetReadyToDeliveryTasks;
 end;//g_csGetReadyToDeliveryTasks = nil
 Result := g_csGetReadyToDeliveryTasks;
end;
var
 g_k2_attrUserID: Integer = -1;

function k2_attrUserID: Integer;
begin
 if (g_k2_attrUserID = -1) then
  g_k2_attrUserID :=  Tk2Attributes.Instance.CheckIDByName('UserID');
 Result := g_k2_attrUserID;
end;


end.