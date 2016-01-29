unit Element_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "Element_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Tag::Class Shared Delphi Sand Box::SandBox::Meta::Meta::Element
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Element .
{$Include ..\SandBox\sbDefine.inc}

interface

uses
  k2Base {a},
  Meta_Schema
  ;

function k2_typElement_Visisbility: Element_Visisbility_Tag;

function k2_typElement_Abstract: Element_Abstract_Tag;

function k2_attrName: Integer;

function k2_attrVisisbility: Integer;

function k2_attrAbstract: Integer;
function k2_typElement: ElementTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Element : ElementTag = nil;

// start class ElementTag

function k2_typElement: ElementTag;
begin
 if (g_Element = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TMetaSchema);
  g_Element := TMetaSchema(Tk2TypeTable.GetInstance).t_Element;
 end;//g_Element = nil
 Result := g_Element;
end;
var
 g_k2_attrName: Integer = -1;

function k2_attrName: Integer;
begin
 if (g_k2_attrName = -1) then
  g_k2_attrName :=  Tk2Attributes.Instance.CheckIDByName('Name');
 Result := g_k2_attrName;
end;

var
 g_k2_attrVisisbility: Integer = -1;

function k2_attrVisisbility: Integer;
begin
 if (g_k2_attrVisisbility = -1) then
  g_k2_attrVisisbility :=  Tk2Attributes.Instance.CheckIDByName('Visisbility');
 Result := g_k2_attrVisisbility;
end;

var
 g_k2_attrAbstract: Integer = -1;

function k2_attrAbstract: Integer;
begin
 if (g_k2_attrAbstract = -1) then
  g_k2_attrAbstract :=  Tk2Attributes.Instance.CheckIDByName('Abstract');
 Result := g_k2_attrAbstract;
end;


var
 g_Element_Visisbility : Element_Visisbility_Tag = nil;

// start class Visisbility

function k2_typElement_Visisbility: Element_Visisbility_Tag;
begin
 if (g_Element_Visisbility = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TMetaSchema);
  g_Element_Visisbility := TMetaSchema(Tk2TypeTable.GetInstance).t_Element_Visisbility;
 end;//g_Element = nil
 Result := g_Element_Visisbility;
end;

var
 g_Element_Abstract : Element_Abstract_Tag = nil;

// start class Abstract

function k2_typElement_Abstract: Element_Abstract_Tag;
begin
 if (g_Element_Abstract = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TMetaSchema);
  g_Element_Abstract := TMetaSchema(Tk2TypeTable.GetInstance).t_Element_Abstract;
 end;//g_Element = nil
 Result := g_Element_Abstract;
end;


end.