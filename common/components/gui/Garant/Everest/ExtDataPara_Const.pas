unit ExtDataPara_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/ExtDataPara_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::ExtDataPara
//
// Параграф с данными во внешнем формате
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ExtDataPara - "Параграф с данными во внешнем формате".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idExtDataPara = 132;

function k2_attrExternalPath: Integer;

function k2_attrType: Integer;

function k2_attrInternalHandle: Integer;

function k2_attrData: Integer;

function k2_typExtDataPara: ExtDataParaTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ExtDataPara : ExtDataParaTag = nil;

// start class ExtDataParaTag

function k2_typExtDataPara: ExtDataParaTag;
begin
 if (g_ExtDataPara = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ExtDataPara := TevNativeSchema(Tk2TypeTable.GetInstance).t_ExtDataPara;
 end;//g_ExtDataPara = nil
 Result := g_ExtDataPara;
end;
var
 g_k2_attrExternalPath: Integer = -1;

function k2_attrExternalPath: Integer;
begin
 if (g_k2_attrExternalPath = -1) then
  g_k2_attrExternalPath :=  Tk2Attributes.Instance.CheckIDByName('ExternalPath');
 Result := g_k2_attrExternalPath;
end;

var
 g_k2_attrType: Integer = -1;

function k2_attrType: Integer;
begin
 if (g_k2_attrType = -1) then
  g_k2_attrType :=  Tk2Attributes.Instance.CheckIDByName('Type');
 Result := g_k2_attrType;
end;

var
 g_k2_attrInternalHandle: Integer = -1;

function k2_attrInternalHandle: Integer;
begin
 if (g_k2_attrInternalHandle = -1) then
  g_k2_attrInternalHandle :=  Tk2Attributes.Instance.CheckIDByName('InternalHandle');
 Result := g_k2_attrInternalHandle;
end;

var
 g_k2_attrData: Integer = -1;

function k2_attrData: Integer;
begin
 if (g_k2_attrData = -1) then
  g_k2_attrData :=  Tk2Attributes.Instance.CheckIDByName('Data');
 Result := g_k2_attrData;
end;


end.