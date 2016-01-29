unit Inner_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "Inner_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Tag::Class Shared Delphi Sand Box::SandBox::Meta::Meta::Inner
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Inner .
{$Include ..\SandBox\sbDefine.inc}

interface

uses
  k2Base {a},
  Meta_Schema
  ;

function k2_attrStereotype: Integer;

function k2_typInner: InnerTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Inner : InnerTag = nil;

// start class InnerTag

function k2_typInner: InnerTag;
begin
 if (g_Inner = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TMetaSchema);
  g_Inner := TMetaSchema(Tk2TypeTable.GetInstance).t_Inner;
 end;//g_Inner = nil
 Result := g_Inner;
end;
var
 g_k2_attrStereotype: Integer = -1;

function k2_attrStereotype: Integer;
begin
 if (g_k2_attrStereotype = -1) then
  g_k2_attrStereotype :=  Tk2Attributes.Instance.CheckIDByName('Stereotype');
 Result := g_k2_attrStereotype;
end;


end.