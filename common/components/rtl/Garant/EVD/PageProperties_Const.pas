unit PageProperties_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/PageProperties_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::PageProperties
//
// Свойства страницы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега PageProperties - "Свойства страницы".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idPageProperties = 106;

function k2_typPageProperties_Orientation: PageProperties_Orientation_Tag;

function k2_attrOrientation: Integer;

function k2_attrWidth: Integer;

function k2_attrHeight: Integer;

function k2_attrLeftIndent: Integer;

function k2_attrRightIndent: Integer;

function k2_attrSpaceBefore: Integer;

function k2_attrSpaceAfter: Integer;
function k2_typPageProperties: PagePropertiesTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_PageProperties : PagePropertiesTag = nil;

// start class PagePropertiesTag

function k2_typPageProperties: PagePropertiesTag;
begin
 if (g_PageProperties = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_PageProperties := TevdNativeSchema(Tk2TypeTable.GetInstance).t_PageProperties;
 end;//g_PageProperties = nil
 Result := g_PageProperties;
end;
var
 g_k2_attrOrientation: Integer = -1;

function k2_attrOrientation: Integer;
begin
 if (g_k2_attrOrientation = -1) then
  g_k2_attrOrientation :=  Tk2Attributes.Instance.CheckIDByName('Orientation');
 Result := g_k2_attrOrientation;
end;

var
 g_k2_attrWidth: Integer = -1;

function k2_attrWidth: Integer;
begin
 if (g_k2_attrWidth = -1) then
  g_k2_attrWidth :=  Tk2Attributes.Instance.CheckIDByName('Width');
 Result := g_k2_attrWidth;
end;

var
 g_k2_attrHeight: Integer = -1;

function k2_attrHeight: Integer;
begin
 if (g_k2_attrHeight = -1) then
  g_k2_attrHeight :=  Tk2Attributes.Instance.CheckIDByName('Height');
 Result := g_k2_attrHeight;
end;

var
 g_k2_attrLeftIndent: Integer = -1;

function k2_attrLeftIndent: Integer;
begin
 if (g_k2_attrLeftIndent = -1) then
  g_k2_attrLeftIndent :=  Tk2Attributes.Instance.CheckIDByName('LeftIndent');
 Result := g_k2_attrLeftIndent;
end;

var
 g_k2_attrRightIndent: Integer = -1;

function k2_attrRightIndent: Integer;
begin
 if (g_k2_attrRightIndent = -1) then
  g_k2_attrRightIndent :=  Tk2Attributes.Instance.CheckIDByName('RightIndent');
 Result := g_k2_attrRightIndent;
end;

var
 g_k2_attrSpaceBefore: Integer = -1;

function k2_attrSpaceBefore: Integer;
begin
 if (g_k2_attrSpaceBefore = -1) then
  g_k2_attrSpaceBefore :=  Tk2Attributes.Instance.CheckIDByName('SpaceBefore');
 Result := g_k2_attrSpaceBefore;
end;

var
 g_k2_attrSpaceAfter: Integer = -1;

function k2_attrSpaceAfter: Integer;
begin
 if (g_k2_attrSpaceAfter = -1) then
  g_k2_attrSpaceAfter :=  Tk2Attributes.Instance.CheckIDByName('SpaceAfter');
 Result := g_k2_attrSpaceAfter;
end;


var
 g_PageProperties_Orientation : PageProperties_Orientation_Tag = nil;

// start class Orientation

function k2_typPageProperties_Orientation: PageProperties_Orientation_Tag;
begin
 if (g_PageProperties_Orientation = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_PageProperties_Orientation := TevdNativeSchema(Tk2TypeTable.GetInstance).t_PageProperties_Orientation;
 end;//g_PageProperties = nil
 Result := g_PageProperties_Orientation;
end;


end.