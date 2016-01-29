unit Class_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "Class_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Tag::Class Shared Delphi Sand Box::SandBox::Meta::Meta::Class
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Class .
{$Include ..\SandBox\sbDefine.inc}

interface

uses
  k2Base {a},
  Meta_Schema
  ;

function k2_typClass_Extends: Class_Extends_Tag;

function k2_typClass_Children: Class_Children_Tag;

function k2_attrExtends: Integer;

function k2_attrImplements: Integer;
function k2_typClass: ClassTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Class : ClassTag = nil;

// start class ClassTag

function k2_typClass: ClassTag;
begin
 if (g_Class = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TMetaSchema);
  g_Class := TMetaSchema(Tk2TypeTable.GetInstance).t_Class;
 end;//g_Class = nil
 Result := g_Class;
end;
var
 g_k2_attrExtends: Integer = -1;

function k2_attrExtends: Integer;
begin
 if (g_k2_attrExtends = -1) then
  g_k2_attrExtends :=  Tk2Attributes.Instance.CheckIDByName('Extends');
 Result := g_k2_attrExtends;
end;

var
 g_k2_attrImplements: Integer = -1;

function k2_attrImplements: Integer;
begin
 if (g_k2_attrImplements = -1) then
  g_k2_attrImplements :=  Tk2Attributes.Instance.CheckIDByName('Implements');
 Result := g_k2_attrImplements;
end;


var
 g_Class_Extends : Class_Extends_Tag = nil;

// start class Extends

function k2_typClass_Extends: Class_Extends_Tag;
begin
 if (g_Class_Extends = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TMetaSchema);
  g_Class_Extends := TMetaSchema(Tk2TypeTable.GetInstance).t_Class_Extends;
 end;//g_Class = nil
 Result := g_Class_Extends;
end;

var
 g_Class_Children : Class_Children_Tag = nil;

// unit methods

function k2_typClass_Children: Class_Children_Tag;
begin
 if (g_Class_Children = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TMetaSchema);
  g_Class_Children := TMetaSchema(Tk2TypeTable.GetInstance).t_Class_Children;
 end;//g_Class = nil
 Result := g_Class_Children;
end;


end.