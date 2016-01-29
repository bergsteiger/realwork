unit dependency_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "dependency_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Tag::Class Shared Delphi Sand Box::SandBox::Meta::Meta::dependency
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега dependency .
{$Include ..\SandBox\sbDefine.inc}

interface

uses
  k2Base {a},
  Meta_Schema
  ;

function k2_typdependency: dependencyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_dependency : dependencyTag = nil;

// start class dependencyTag

function k2_typdependency: dependencyTag;
begin
 if (g_dependency = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TMetaSchema);
  g_dependency := TMetaSchema(Tk2TypeTable.GetInstance).t_dependency;
 end;//g_dependency = nil
 Result := g_dependency;
end;

end.