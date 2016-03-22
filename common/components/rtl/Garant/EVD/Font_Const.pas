unit Font_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Font_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::Font
//
// Шрифт
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Font - "Шрифт".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idFont = 36;

function k2_typFont_Index: Font_Index_Tag;

function k2_typFont_Pitch: Font_Pitch_Tag;

function k2_attrIndex: Integer;

function k2_attrBold: Integer;

function k2_attrItalic: Integer;

function k2_attrUnderline: Integer;

function k2_attrStrikeout: Integer;

function k2_attrPitch: Integer;

function k2_attrSize: Integer;

function k2_attrName: Integer;

function k2_attrForeColor: Integer;

function k2_attrBackColor: Integer;
function k2_typFont: FontTag;

//#UC START# *484CEE9A0170const_intf*
//#UC END# *484CEE9A0170const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Font : FontTag = nil;

// start class FontTag

function k2_typFont: FontTag;
begin
 if (g_Font = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Font := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Font;
 end;//g_Font = nil
 Result := g_Font;
end;
var
 g_k2_attrIndex: Integer = -1;

function k2_attrIndex: Integer;
begin
 if (g_k2_attrIndex = -1) then
  g_k2_attrIndex :=  Tk2Attributes.Instance.CheckIDByName('Index');
 Result := g_k2_attrIndex;
end;

var
 g_k2_attrBold: Integer = -1;

function k2_attrBold: Integer;
begin
 if (g_k2_attrBold = -1) then
  g_k2_attrBold :=  Tk2Attributes.Instance.CheckIDByName('Bold');
 Result := g_k2_attrBold;
end;

var
 g_k2_attrItalic: Integer = -1;

function k2_attrItalic: Integer;
begin
 if (g_k2_attrItalic = -1) then
  g_k2_attrItalic :=  Tk2Attributes.Instance.CheckIDByName('Italic');
 Result := g_k2_attrItalic;
end;

var
 g_k2_attrUnderline: Integer = -1;

function k2_attrUnderline: Integer;
begin
 if (g_k2_attrUnderline = -1) then
  g_k2_attrUnderline :=  Tk2Attributes.Instance.CheckIDByName('Underline');
 Result := g_k2_attrUnderline;
end;

var
 g_k2_attrStrikeout: Integer = -1;

function k2_attrStrikeout: Integer;
begin
 if (g_k2_attrStrikeout = -1) then
  g_k2_attrStrikeout :=  Tk2Attributes.Instance.CheckIDByName('Strikeout');
 Result := g_k2_attrStrikeout;
end;

var
 g_k2_attrPitch: Integer = -1;

function k2_attrPitch: Integer;
begin
 if (g_k2_attrPitch = -1) then
  g_k2_attrPitch :=  Tk2Attributes.Instance.CheckIDByName('Pitch');
 Result := g_k2_attrPitch;
end;

var
 g_k2_attrSize: Integer = -1;

function k2_attrSize: Integer;
begin
 if (g_k2_attrSize = -1) then
  g_k2_attrSize :=  Tk2Attributes.Instance.CheckIDByName('Size');
 Result := g_k2_attrSize;
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
 g_k2_attrForeColor: Integer = -1;

function k2_attrForeColor: Integer;
begin
 if (g_k2_attrForeColor = -1) then
  g_k2_attrForeColor :=  Tk2Attributes.Instance.CheckIDByName('ForeColor');
 Result := g_k2_attrForeColor;
end;

var
 g_k2_attrBackColor: Integer = -1;

function k2_attrBackColor: Integer;
begin
 if (g_k2_attrBackColor = -1) then
  g_k2_attrBackColor :=  Tk2Attributes.Instance.CheckIDByName('BackColor');
 Result := g_k2_attrBackColor;
end;


var
 g_Font_Index : Font_Index_Tag = nil;

// start class Index

function k2_typFont_Index: Font_Index_Tag;
begin
 if (g_Font_Index = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Font_Index := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Font_Index;
 end;//g_Font = nil
 Result := g_Font_Index;
end;

var
 g_Font_Pitch : Font_Pitch_Tag = nil;

// start class Pitch

function k2_typFont_Pitch: Font_Pitch_Tag;
begin
 if (g_Font_Pitch = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Font_Pitch := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Font_Pitch;
 end;//g_Font = nil
 Result := g_Font_Pitch;
end;


end.