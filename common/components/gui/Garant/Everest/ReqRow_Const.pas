unit ReqRow_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/ReqRow_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::ReqRow
//
// Строка контролов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ReqRow - "Строка контролов".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idReqRow = 130;

function k2_typReqRow_ReqKind: ReqRow_ReqKind_Tag;

function k2_attrReqID: Integer;

function k2_attrEnabled: Integer;

function k2_attrRequired: Integer;

function k2_attrFilterType: Integer;

function k2_attrReqKind: Integer;

function k2_attrMulty: Integer;

function k2_attrNumList: Integer;

function k2_attrModelControl: Integer;

function k2_attrDefaultText: Integer;

function k2_attrDefaultNode: Integer;

function k2_attrModified: Integer;

function k2_attrOperations: Integer;

function k2_attrStateIndex: Integer;
function k2_typReqRow: ReqRowTag;

//#UC START# *4857EA97011Dconst_intf*
//#UC END# *4857EA97011Dconst_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ReqRow : ReqRowTag = nil;

// start class ReqRowTag

function k2_typReqRow: ReqRowTag;
begin
 if (g_ReqRow = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ReqRow := TevNativeSchema(Tk2TypeTable.GetInstance).t_ReqRow;
 end;//g_ReqRow = nil
 Result := g_ReqRow;
end;
var
 g_k2_attrReqID: Integer = -1;

function k2_attrReqID: Integer;
begin
 if (g_k2_attrReqID = -1) then
  g_k2_attrReqID :=  Tk2Attributes.Instance.CheckIDByName('ReqID');
 Result := g_k2_attrReqID;
end;

var
 g_k2_attrEnabled: Integer = -1;

function k2_attrEnabled: Integer;
begin
 if (g_k2_attrEnabled = -1) then
  g_k2_attrEnabled :=  Tk2Attributes.Instance.CheckIDByName('Enabled');
 Result := g_k2_attrEnabled;
end;

var
 g_k2_attrRequired: Integer = -1;

function k2_attrRequired: Integer;
begin
 if (g_k2_attrRequired = -1) then
  g_k2_attrRequired :=  Tk2Attributes.Instance.CheckIDByName('Required');
 Result := g_k2_attrRequired;
end;

var
 g_k2_attrFilterType: Integer = -1;

function k2_attrFilterType: Integer;
begin
 if (g_k2_attrFilterType = -1) then
  g_k2_attrFilterType :=  Tk2Attributes.Instance.CheckIDByName('FilterType');
 Result := g_k2_attrFilterType;
end;

var
 g_k2_attrReqKind: Integer = -1;

function k2_attrReqKind: Integer;
begin
 if (g_k2_attrReqKind = -1) then
  g_k2_attrReqKind :=  Tk2Attributes.Instance.CheckIDByName('ReqKind');
 Result := g_k2_attrReqKind;
end;

var
 g_k2_attrMulty: Integer = -1;

function k2_attrMulty: Integer;
begin
 if (g_k2_attrMulty = -1) then
  g_k2_attrMulty :=  Tk2Attributes.Instance.CheckIDByName('Multy');
 Result := g_k2_attrMulty;
end;

var
 g_k2_attrNumList: Integer = -1;

function k2_attrNumList: Integer;
begin
 if (g_k2_attrNumList = -1) then
  g_k2_attrNumList :=  Tk2Attributes.Instance.CheckIDByName('NumList');
 Result := g_k2_attrNumList;
end;

var
 g_k2_attrModelControl: Integer = -1;

function k2_attrModelControl: Integer;
begin
 if (g_k2_attrModelControl = -1) then
  g_k2_attrModelControl :=  Tk2Attributes.Instance.CheckIDByName('ModelControl');
 Result := g_k2_attrModelControl;
end;

var
 g_k2_attrDefaultText: Integer = -1;

function k2_attrDefaultText: Integer;
begin
 if (g_k2_attrDefaultText = -1) then
  g_k2_attrDefaultText :=  Tk2Attributes.Instance.CheckIDByName('DefaultText');
 Result := g_k2_attrDefaultText;
end;

var
 g_k2_attrDefaultNode: Integer = -1;

function k2_attrDefaultNode: Integer;
begin
 if (g_k2_attrDefaultNode = -1) then
  g_k2_attrDefaultNode :=  Tk2Attributes.Instance.CheckIDByName('DefaultNode');
 Result := g_k2_attrDefaultNode;
end;

var
 g_k2_attrModified: Integer = -1;

function k2_attrModified: Integer;
begin
 if (g_k2_attrModified = -1) then
  g_k2_attrModified :=  Tk2Attributes.Instance.CheckIDByName('Modified');
 Result := g_k2_attrModified;
end;

var
 g_k2_attrOperations: Integer = -1;

function k2_attrOperations: Integer;
begin
 if (g_k2_attrOperations = -1) then
  g_k2_attrOperations :=  Tk2Attributes.Instance.CheckIDByName('Operations');
 Result := g_k2_attrOperations;
end;

var
 g_k2_attrStateIndex: Integer = -1;

function k2_attrStateIndex: Integer;
begin
 if (g_k2_attrStateIndex = -1) then
  g_k2_attrStateIndex :=  Tk2Attributes.Instance.CheckIDByName('StateIndex');
 Result := g_k2_attrStateIndex;
end;


var
 g_ReqRow_ReqKind : ReqRow_ReqKind_Tag = nil;

// start class ReqKind

function k2_typReqRow_ReqKind: ReqRow_ReqKind_Tag;
begin
 if (g_ReqRow_ReqKind = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ReqRow_ReqKind := TevNativeSchema(Tk2TypeTable.GetInstance).t_ReqRow_ReqKind;
 end;//g_ReqRow = nil
 Result := g_ReqRow_ReqKind;
end;


end.