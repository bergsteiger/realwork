unit ControlsBlock_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/ControlsBlock_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::ControlsBlock
//
// Блок контролов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ControlsBlock - "Блок контролов".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idControlsBlock = 121;

function k2_attrModelControl: Integer;

function k2_attrEnabled: Integer;

function k2_attrUpper: Integer;

function k2_attrFlat: Integer;

function k2_attrChecked: Integer;

function k2_typControlsBlock: ControlsBlockTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ControlsBlock : ControlsBlockTag = nil;

// start class ControlsBlockTag

function k2_typControlsBlock: ControlsBlockTag;
begin
 if (g_ControlsBlock = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ControlsBlock := TevNativeSchema(Tk2TypeTable.GetInstance).t_ControlsBlock;
 end;//g_ControlsBlock = nil
 Result := g_ControlsBlock;
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
 g_k2_attrEnabled: Integer = -1;

function k2_attrEnabled: Integer;
begin
 if (g_k2_attrEnabled = -1) then
  g_k2_attrEnabled :=  Tk2Attributes.Instance.CheckIDByName('Enabled');
 Result := g_k2_attrEnabled;
end;

var
 g_k2_attrUpper: Integer = -1;

function k2_attrUpper: Integer;
begin
 if (g_k2_attrUpper = -1) then
  g_k2_attrUpper :=  Tk2Attributes.Instance.CheckIDByName('Upper');
 Result := g_k2_attrUpper;
end;

var
 g_k2_attrFlat: Integer = -1;

function k2_attrFlat: Integer;
begin
 if (g_k2_attrFlat = -1) then
  g_k2_attrFlat :=  Tk2Attributes.Instance.CheckIDByName('Flat');
 Result := g_k2_attrFlat;
end;

var
 g_k2_attrChecked: Integer = -1;

function k2_attrChecked: Integer;
begin
 if (g_k2_attrChecked = -1) then
  g_k2_attrChecked :=  Tk2Attributes.Instance.CheckIDByName('Checked');
 Result := g_k2_attrChecked;
end;


end.