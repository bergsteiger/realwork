unit ControlPara_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/ControlPara_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::ControlPara
//
// Параграф представляющий собой контрол ввода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ControlPara - "Параграф представляющий собой контрол ввода".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idControlPara = 119;

function k2_typControlPara_Type: ControlPara_Type_Tag;

function k2_attrName: Integer;

function k2_attrShortName: Integer;

function k2_attrAlternateText: Integer;

function k2_attrMaxTextLength: Integer;

function k2_attrType: Integer;

function k2_attrValid: Integer;

function k2_attrStateIndex: Integer;

function k2_attrStateCount: Integer;

function k2_attrImageIndex: Integer;

function k2_attrChecked: Integer;

function k2_attrEnabled: Integer;

function k2_attrUpper: Integer;

function k2_attrFlat: Integer;

function k2_attrScript: Integer;

function k2_attrObject: Integer;

function k2_attrModelControl: Integer;

function k2_attrNodeVisibleIndex: Integer;
function k2_typControlPara: ControlParaTag;

//#UC START# *4857923F0186const_intf*
//#UC END# *4857923F0186const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ControlPara : ControlParaTag = nil;

// start class ControlParaTag

function k2_typControlPara: ControlParaTag;
begin
 if (g_ControlPara = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ControlPara := TevNativeSchema(Tk2TypeTable.GetInstance).t_ControlPara;
 end;//g_ControlPara = nil
 Result := g_ControlPara;
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
 g_k2_attrAlternateText: Integer = -1;

function k2_attrAlternateText: Integer;
begin
 if (g_k2_attrAlternateText = -1) then
  g_k2_attrAlternateText :=  Tk2Attributes.Instance.CheckIDByName('AlternateText');
 Result := g_k2_attrAlternateText;
end;

var
 g_k2_attrMaxTextLength: Integer = -1;

function k2_attrMaxTextLength: Integer;
begin
 if (g_k2_attrMaxTextLength = -1) then
  g_k2_attrMaxTextLength :=  Tk2Attributes.Instance.CheckIDByName('MaxTextLength');
 Result := g_k2_attrMaxTextLength;
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
 g_k2_attrValid: Integer = -1;

function k2_attrValid: Integer;
begin
 if (g_k2_attrValid = -1) then
  g_k2_attrValid :=  Tk2Attributes.Instance.CheckIDByName('Valid');
 Result := g_k2_attrValid;
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
 g_k2_attrStateCount: Integer = -1;

function k2_attrStateCount: Integer;
begin
 if (g_k2_attrStateCount = -1) then
  g_k2_attrStateCount :=  Tk2Attributes.Instance.CheckIDByName('StateCount');
 Result := g_k2_attrStateCount;
end;

var
 g_k2_attrImageIndex: Integer = -1;

function k2_attrImageIndex: Integer;
begin
 if (g_k2_attrImageIndex = -1) then
  g_k2_attrImageIndex :=  Tk2Attributes.Instance.CheckIDByName('ImageIndex');
 Result := g_k2_attrImageIndex;
end;

var
 g_k2_attrChecked: Integer = -1;

function k2_attrChecked: Integer;
begin
 if (g_k2_attrChecked = -1) then
  g_k2_attrChecked :=  Tk2Attributes.Instance.CheckIDByName('Checked');
 Result := g_k2_attrChecked;
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
 g_k2_attrScript: Integer = -1;

function k2_attrScript: Integer;
begin
 if (g_k2_attrScript = -1) then
  g_k2_attrScript :=  Tk2Attributes.Instance.CheckIDByName('Script');
 Result := g_k2_attrScript;
end;

var
 g_k2_attrObject: Integer = -1;

function k2_attrObject: Integer;
begin
 if (g_k2_attrObject = -1) then
  g_k2_attrObject :=  Tk2Attributes.Instance.CheckIDByName('Object');
 Result := g_k2_attrObject;
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
 g_k2_attrNodeVisibleIndex: Integer = -1;

function k2_attrNodeVisibleIndex: Integer;
begin
 if (g_k2_attrNodeVisibleIndex = -1) then
  g_k2_attrNodeVisibleIndex :=  Tk2Attributes.Instance.CheckIDByName('NodeVisibleIndex');
 Result := g_k2_attrNodeVisibleIndex;
end;


var
 g_ControlPara_Type : ControlPara_Type_Tag = nil;

// start class Type

function k2_typControlPara_Type: ControlPara_Type_Tag;
begin
 if (g_ControlPara_Type = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ControlPara_Type := TevNativeSchema(Tk2TypeTable.GetInstance).t_ControlPara_Type;
 end;//g_ControlPara = nil
 Result := g_ControlPara_Type;
end;


end.