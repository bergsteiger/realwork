unit operation_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "operation_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Tag::Class Shared Delphi Sand Box::SandBox::Meta::Meta::operation
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега operation .
{$Include ..\SandBox\sbDefine.inc}

interface

uses
  k2Base {a},
  Meta_Schema
  ;

function k2_typoperation: operationTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_operation : operationTag = nil;

// start class operationTag

function k2_typoperation: operationTag;
begin
 if (g_operation = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TMetaSchema);
  g_operation := TMetaSchema(Tk2TypeTable.GetInstance).t_operation;
 end;//g_operation = nil
 Result := g_operation;
end;

end.