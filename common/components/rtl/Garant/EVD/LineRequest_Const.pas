unit LineRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/LineRequest_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::LineRequest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега LineRequest .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typLineRequest: LineRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_LineRequest : LineRequestTag = nil;

// start class LineRequestTag

function k2_typLineRequest: LineRequestTag;
begin
 if (g_LineRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_LineRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_LineRequest;
 end;//g_LineRequest = nil
 Result := g_LineRequest;
end;

end.