unit Division_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Division_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Division
//
// Раздел документа (не используется)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Division - "Раздел документа (не используется)".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idDivision = 102;

function k2_typDivision_Headers: Division_Headers_Tag;

function k2_typDivision_Footers: Division_Footers_Tag;

function k2_attrHeaders: Integer;

function k2_attrFooters: Integer;
function k2_typDivision: DivisionTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Division : DivisionTag = nil;

// start class DivisionTag

function k2_typDivision: DivisionTag;
begin
 if (g_Division = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Division := TevNativeSchema(Tk2TypeTable.GetInstance).t_Division;
 end;//g_Division = nil
 Result := g_Division;
end;
var
 g_k2_attrHeaders: Integer = -1;

function k2_attrHeaders: Integer;
begin
 if (g_k2_attrHeaders = -1) then
  g_k2_attrHeaders :=  Tk2Attributes.Instance.CheckIDByName('Headers');
 Result := g_k2_attrHeaders;
end;

var
 g_k2_attrFooters: Integer = -1;

function k2_attrFooters: Integer;
begin
 if (g_k2_attrFooters = -1) then
  g_k2_attrFooters :=  Tk2Attributes.Instance.CheckIDByName('Footers');
 Result := g_k2_attrFooters;
end;


var
 g_Division_Headers : Division_Headers_Tag = nil;

// start class Headers

function k2_typDivision_Headers: Division_Headers_Tag;
begin
 if (g_Division_Headers = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Division_Headers := TevNativeSchema(Tk2TypeTable.GetInstance).t_Division_Headers;
 end;//g_Division = nil
 Result := g_Division_Headers;
end;

var
 g_Division_Footers : Division_Footers_Tag = nil;

// start class Footers

function k2_typDivision_Footers: Division_Footers_Tag;
begin
 if (g_Division_Footers = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Division_Footers := TevNativeSchema(Tk2TypeTable.GetInstance).t_Division_Footers;
 end;//g_Division = nil
 Result := g_Division_Footers;
end;


end.