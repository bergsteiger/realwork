unit Block_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Block_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Block
//
// Элемент структуры документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Block - "Элемент структуры документа".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idBlock = 50;

function k2_typBlock_LayerID: Block_LayerID_Tag;

function k2_typBlock_ViewKind: Block_ViewKind_Tag;

function k2_attrExternalHandle: Integer;

function k2_attrType: Integer;

function k2_attrCollapsed: Integer;

function k2_attrContentsLevel: Integer;

function k2_attrContentsLevel5: Integer;

function k2_attrLayerID: Integer;

function k2_attrStyle: Integer;

function k2_attrCompareContentsLevel: Integer;

function k2_attrFont: Integer;

function k2_attrViewKind: Integer;
function k2_typBlock: BlockTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Block : BlockTag = nil;

// start class BlockTag

function k2_typBlock: BlockTag;
begin
 if (g_Block = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Block := TevNativeSchema(Tk2TypeTable.GetInstance).t_Block;
 end;//g_Block = nil
 Result := g_Block;
end;
var
 g_k2_attrExternalHandle: Integer = -1;

function k2_attrExternalHandle: Integer;
begin
 if (g_k2_attrExternalHandle = -1) then
  g_k2_attrExternalHandle :=  Tk2Attributes.Instance.CheckIDByName('ExternalHandle');
 Result := g_k2_attrExternalHandle;
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
 g_k2_attrCollapsed: Integer = -1;

function k2_attrCollapsed: Integer;
begin
 if (g_k2_attrCollapsed = -1) then
  g_k2_attrCollapsed :=  Tk2Attributes.Instance.CheckIDByName('Collapsed');
 Result := g_k2_attrCollapsed;
end;

var
 g_k2_attrContentsLevel: Integer = -1;

function k2_attrContentsLevel: Integer;
begin
 if (g_k2_attrContentsLevel = -1) then
  g_k2_attrContentsLevel :=  Tk2Attributes.Instance.CheckIDByName('ContentsLevel');
 Result := g_k2_attrContentsLevel;
end;

var
 g_k2_attrContentsLevel5: Integer = -1;

function k2_attrContentsLevel5: Integer;
begin
 if (g_k2_attrContentsLevel5 = -1) then
  g_k2_attrContentsLevel5 :=  Tk2Attributes.Instance.CheckIDByName('ContentsLevel5');
 Result := g_k2_attrContentsLevel5;
end;

var
 g_k2_attrLayerID: Integer = -1;

function k2_attrLayerID: Integer;
begin
 if (g_k2_attrLayerID = -1) then
  g_k2_attrLayerID :=  Tk2Attributes.Instance.CheckIDByName('LayerID');
 Result := g_k2_attrLayerID;
end;

var
 g_k2_attrStyle: Integer = -1;

function k2_attrStyle: Integer;
begin
 if (g_k2_attrStyle = -1) then
  g_k2_attrStyle :=  Tk2Attributes.Instance.CheckIDByName('Style');
 Result := g_k2_attrStyle;
end;

var
 g_k2_attrCompareContentsLevel: Integer = -1;

function k2_attrCompareContentsLevel: Integer;
begin
 if (g_k2_attrCompareContentsLevel = -1) then
  g_k2_attrCompareContentsLevel :=  Tk2Attributes.Instance.CheckIDByName('CompareContentsLevel');
 Result := g_k2_attrCompareContentsLevel;
end;

var
 g_k2_attrFont: Integer = -1;

function k2_attrFont: Integer;
begin
 if (g_k2_attrFont = -1) then
  g_k2_attrFont :=  Tk2Attributes.Instance.CheckIDByName('Font');
 Result := g_k2_attrFont;
end;

var
 g_k2_attrViewKind: Integer = -1;

function k2_attrViewKind: Integer;
begin
 if (g_k2_attrViewKind = -1) then
  g_k2_attrViewKind :=  Tk2Attributes.Instance.CheckIDByName('ViewKind');
 Result := g_k2_attrViewKind;
end;


var
 g_Block_LayerID : Block_LayerID_Tag = nil;

// start class LayerID

function k2_typBlock_LayerID: Block_LayerID_Tag;
begin
 if (g_Block_LayerID = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Block_LayerID := TevNativeSchema(Tk2TypeTable.GetInstance).t_Block_LayerID;
 end;//g_Block = nil
 Result := g_Block_LayerID;
end;

var
 g_Block_ViewKind : Block_ViewKind_Tag = nil;

// start class ViewKind

function k2_typBlock_ViewKind: Block_ViewKind_Tag;
begin
 if (g_Block_ViewKind = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Block_ViewKind := TevNativeSchema(Tk2TypeTable.GetInstance).t_Block_ViewKind;
 end;//g_Block = nil
 Result := g_Block_ViewKind;
end;


end.