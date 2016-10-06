unit MultiOperationRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/MultiOperationRequest_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::MultiOperationRequest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега MultiOperationRequest .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typMultiOperationRequest: MultiOperationRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_MultiOperationRequest : MultiOperationRequestTag = nil;

// start class MultiOperationRequestTag

function k2_typMultiOperationRequest: MultiOperationRequestTag;
begin
 if (g_MultiOperationRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_MultiOperationRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_MultiOperationRequest;
 end;//g_MultiOperationRequest = nil
 Result := g_MultiOperationRequest;
end;

end.