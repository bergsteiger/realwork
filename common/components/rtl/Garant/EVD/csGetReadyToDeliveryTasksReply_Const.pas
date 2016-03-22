unit csGetReadyToDeliveryTasksReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csGetReadyToDeliveryTasksReply_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csGetReadyToDeliveryTasksReply
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csGetReadyToDeliveryTasksReply .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsGetReadyToDeliveryTasksReply_TasksIDList: csGetReadyToDeliveryTasksReply_TasksIDList_Tag;

function k2_attrTasksIDList: Integer;
function k2_typcsGetReadyToDeliveryTasksReply: csGetReadyToDeliveryTasksReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csGetReadyToDeliveryTasksReply : csGetReadyToDeliveryTasksReplyTag = nil;

// start class csGetReadyToDeliveryTasksReplyTag

function k2_typcsGetReadyToDeliveryTasksReply: csGetReadyToDeliveryTasksReplyTag;
begin
 if (g_csGetReadyToDeliveryTasksReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csGetReadyToDeliveryTasksReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csGetReadyToDeliveryTasksReply;
 end;//g_csGetReadyToDeliveryTasksReply = nil
 Result := g_csGetReadyToDeliveryTasksReply;
end;
var
 g_k2_attrTasksIDList: Integer = -1;

function k2_attrTasksIDList: Integer;
begin
 if (g_k2_attrTasksIDList = -1) then
  g_k2_attrTasksIDList :=  Tk2Attributes.Instance.CheckIDByName('TasksIDList');
 Result := g_k2_attrTasksIDList;
end;


var
 g_csGetReadyToDeliveryTasksReply_TasksIDList : csGetReadyToDeliveryTasksReply_TasksIDList_Tag = nil;

// start class TasksIDList

function k2_typcsGetReadyToDeliveryTasksReply_TasksIDList: csGetReadyToDeliveryTasksReply_TasksIDList_Tag;
begin
 if (g_csGetReadyToDeliveryTasksReply_TasksIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csGetReadyToDeliveryTasksReply_TasksIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csGetReadyToDeliveryTasksReply_TasksIDList;
 end;//g_csGetReadyToDeliveryTasksReply = nil
 Result := g_csGetReadyToDeliveryTasksReply_TasksIDList;
end;


end.