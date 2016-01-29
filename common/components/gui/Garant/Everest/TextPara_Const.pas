unit TextPara_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/TextPara_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::TextPara
//
// Текстовый параграф
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TextPara - "Текстовый параграф".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idTextPara = 22;

function k2_typTextPara_Segments: TextPara_Segments_Tag;

function k2_typTextPara_TabStops: TextPara_TabStops_Tag;

function k2_attrAllowHyphen: Integer;

function k2_attrFirstIndent: Integer;

function k2_attrFirstLineIndent: Integer;

function k2_attrBullet: Integer;

function k2_attrPrintFontSize: Integer;

function k2_attrCollapsed: Integer;

function k2_attrText: Integer;

function k2_attrFont: Integer;

function k2_attrSegments: Integer;

function k2_attrTabStops: Integer;
function k2_typTextPara: TextParaTag;

//#UC START# *485683750360const_intf*
//#UC END# *485683750360const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TextPara : TextParaTag = nil;

// start class TextParaTag

function k2_typTextPara: TextParaTag;
begin
 if (g_TextPara = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TextPara := TevNativeSchema(Tk2TypeTable.GetInstance).t_TextPara;
 end;//g_TextPara = nil
 Result := g_TextPara;
end;
var
 g_k2_attrAllowHyphen: Integer = -1;

function k2_attrAllowHyphen: Integer;
begin
 if (g_k2_attrAllowHyphen = -1) then
  g_k2_attrAllowHyphen :=  Tk2Attributes.Instance.CheckIDByName('AllowHyphen');
 Result := g_k2_attrAllowHyphen;
end;

var
 g_k2_attrFirstIndent: Integer = -1;

function k2_attrFirstIndent: Integer;
begin
 if (g_k2_attrFirstIndent = -1) then
  g_k2_attrFirstIndent :=  Tk2Attributes.Instance.CheckIDByName('FirstIndent');
 Result := g_k2_attrFirstIndent;
end;

var
 g_k2_attrFirstLineIndent: Integer = -1;

function k2_attrFirstLineIndent: Integer;
begin
 if (g_k2_attrFirstLineIndent = -1) then
  g_k2_attrFirstLineIndent :=  Tk2Attributes.Instance.CheckIDByName('FirstLineIndent');
 Result := g_k2_attrFirstLineIndent;
end;

var
 g_k2_attrBullet: Integer = -1;

function k2_attrBullet: Integer;
begin
 if (g_k2_attrBullet = -1) then
  g_k2_attrBullet :=  Tk2Attributes.Instance.CheckIDByName('Bullet');
 Result := g_k2_attrBullet;
end;

var
 g_k2_attrPrintFontSize: Integer = -1;

function k2_attrPrintFontSize: Integer;
begin
 if (g_k2_attrPrintFontSize = -1) then
  g_k2_attrPrintFontSize :=  Tk2Attributes.Instance.CheckIDByName('PrintFontSize');
 Result := g_k2_attrPrintFontSize;
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
 g_k2_attrText: Integer = -1;

function k2_attrText: Integer;
begin
 if (g_k2_attrText = -1) then
  g_k2_attrText :=  Tk2Attributes.Instance.CheckIDByName('Text');
 Result := g_k2_attrText;
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
 g_k2_attrSegments: Integer = -1;

function k2_attrSegments: Integer;
begin
 if (g_k2_attrSegments = -1) then
  g_k2_attrSegments :=  Tk2Attributes.Instance.CheckIDByName('Segments');
 Result := g_k2_attrSegments;
end;

var
 g_k2_attrTabStops: Integer = -1;

function k2_attrTabStops: Integer;
begin
 if (g_k2_attrTabStops = -1) then
  g_k2_attrTabStops :=  Tk2Attributes.Instance.CheckIDByName('TabStops');
 Result := g_k2_attrTabStops;
end;


var
 g_TextPara_Segments : TextPara_Segments_Tag = nil;

// start class Segments

function k2_typTextPara_Segments: TextPara_Segments_Tag;
begin
 if (g_TextPara_Segments = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TextPara_Segments := TevNativeSchema(Tk2TypeTable.GetInstance).t_TextPara_Segments;
 end;//g_TextPara = nil
 Result := g_TextPara_Segments;
end;

var
 g_TextPara_TabStops : TextPara_TabStops_Tag = nil;

// start class TabStops

function k2_typTextPara_TabStops: TextPara_TabStops_Tag;
begin
 if (g_TextPara_TabStops = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TextPara_TabStops := TevNativeSchema(Tk2TypeTable.GetInstance).t_TextPara_TabStops;
 end;//g_TextPara = nil
 Result := g_TextPara_TabStops;
end;


end.