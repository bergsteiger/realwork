unit csMultiClearAttributes_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csMultiClearAttributes_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csMultiClearAttributes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csMultiClearAttributes .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsMultiClearAttributes_Attributes: csMultiClearAttributes_Attributes_Tag;

function k2_typcsMultiClearAttributes_DocumentIDList: csMultiClearAttributes_DocumentIDList_Tag;

function k2_attrFamilyID: Integer;

function k2_attrAttributes: Integer;

function k2_attrRightsNeeded: Integer;

function k2_attrDocumentIDList: Integer;
function k2_typcsMultiClearAttributes: csMultiClearAttributesTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csMultiClearAttributes : csMultiClearAttributesTag = nil;

// start class csMultiClearAttributesTag

function k2_typcsMultiClearAttributes: csMultiClearAttributesTag;
begin
 if (g_csMultiClearAttributes = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiClearAttributes := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiClearAttributes;
 end;//g_csMultiClearAttributes = nil
 Result := g_csMultiClearAttributes;
end;
var
 g_k2_attrFamilyID: Integer = -1;

function k2_attrFamilyID: Integer;
begin
 if (g_k2_attrFamilyID = -1) then
  g_k2_attrFamilyID :=  Tk2Attributes.Instance.CheckIDByName('FamilyID');
 Result := g_k2_attrFamilyID;
end;

var
 g_k2_attrAttributes: Integer = -1;

function k2_attrAttributes: Integer;
begin
 if (g_k2_attrAttributes = -1) then
  g_k2_attrAttributes :=  Tk2Attributes.Instance.CheckIDByName('Attributes');
 Result := g_k2_attrAttributes;
end;

var
 g_k2_attrRightsNeeded: Integer = -1;

function k2_attrRightsNeeded: Integer;
begin
 if (g_k2_attrRightsNeeded = -1) then
  g_k2_attrRightsNeeded :=  Tk2Attributes.Instance.CheckIDByName('RightsNeeded');
 Result := g_k2_attrRightsNeeded;
end;

var
 g_k2_attrDocumentIDList: Integer = -1;

function k2_attrDocumentIDList: Integer;
begin
 if (g_k2_attrDocumentIDList = -1) then
  g_k2_attrDocumentIDList :=  Tk2Attributes.Instance.CheckIDByName('DocumentIDList');
 Result := g_k2_attrDocumentIDList;
end;


var
 g_csMultiClearAttributes_Attributes : csMultiClearAttributes_Attributes_Tag = nil;

// start class Attributes

function k2_typcsMultiClearAttributes_Attributes: csMultiClearAttributes_Attributes_Tag;
begin
 if (g_csMultiClearAttributes_Attributes = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiClearAttributes_Attributes := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiClearAttributes_Attributes;
 end;//g_csMultiClearAttributes = nil
 Result := g_csMultiClearAttributes_Attributes;
end;

var
 g_csMultiClearAttributes_DocumentIDList : csMultiClearAttributes_DocumentIDList_Tag = nil;

// start class DocumentIDList

function k2_typcsMultiClearAttributes_DocumentIDList: csMultiClearAttributes_DocumentIDList_Tag;
begin
 if (g_csMultiClearAttributes_DocumentIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiClearAttributes_DocumentIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiClearAttributes_DocumentIDList;
 end;//g_csMultiClearAttributes = nil
 Result := g_csMultiClearAttributes_DocumentIDList;
end;


end.