unit ContentsElement_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/ContentsElement_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::ContentsElement
//
// элемент структуры документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ContentsElement - "элемент структуры документа".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idContentsElement = 133;

function k2_typContentsElement_InContents: ContentsElement_InContents_Tag;

function k2_attrInContents: Integer;

function k2_attrName: Integer;

function k2_attrShortName: Integer;
function k2_typContentsElement: ContentsElementTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ContentsElement : ContentsElementTag = nil;

// start class ContentsElementTag

function k2_typContentsElement: ContentsElementTag;
begin
 if (g_ContentsElement = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ContentsElement := TevNativeSchema(Tk2TypeTable.GetInstance).t_ContentsElement;
 end;//g_ContentsElement = nil
 Result := g_ContentsElement;
end;
var
 g_k2_attrInContents: Integer = -1;

function k2_attrInContents: Integer;
begin
 if (g_k2_attrInContents = -1) then
  g_k2_attrInContents :=  Tk2Attributes.Instance.CheckIDByName('InContents');
 Result := g_k2_attrInContents;
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
 g_k2_attrShortName: Integer = -1;

function k2_attrShortName: Integer;
begin
 if (g_k2_attrShortName = -1) then
  g_k2_attrShortName :=  Tk2Attributes.Instance.CheckIDByName('ShortName');
 Result := g_k2_attrShortName;
end;


var
 g_ContentsElement_InContents : ContentsElement_InContents_Tag = nil;

// start class InContents

function k2_typContentsElement_InContents: ContentsElement_InContents_Tag;
begin
 if (g_ContentsElement_InContents = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ContentsElement_InContents := TevNativeSchema(Tk2TypeTable.GetInstance).t_ContentsElement_InContents;
 end;//g_ContentsElement = nil
 Result := g_ContentsElement_InContents;
end;


end.