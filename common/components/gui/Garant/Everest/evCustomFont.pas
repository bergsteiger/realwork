unit evCustomFont;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evCustomFont - }
{ Начат: 19.05.2005 19:38 }
{ $Id: evCustomFont.pas,v 1.16 2014/02/13 15:15:55 lulin Exp $ }

// $Log: evCustomFont.pas,v $
// Revision 1.16  2014/02/13 15:15:55  lulin
// - рефакторим безликие списки.
//
// Revision 1.15  2012/03/06 07:45:21  dinishev
// Bug fix: лишний код из-за правок.
//
// Revision 1.14  2012/03/05 11:58:19  dinishev
// Bug fix: перестарался.
//
// Revision 1.13  2012/03/05 08:52:37  dinishev
// Даем возможность тестам падать. :-)
//
// Revision 1.12  2009/07/02 17:42:26  lulin
// - распиливаем канву на несколько групп методов.
//
// Revision 1.11  2009/03/05 13:09:35  lulin
// - <K>: 137470629. Используем ссылки на типы.
//
// Revision 1.10  2009/03/04 18:14:14  lulin
// - <K>: 137470629. Удалён ненужный интерфейс.
//
// Revision 1.9  2009/03/04 13:32:45  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.8  2008/04/02 14:22:01  lulin
// - cleanup.
//
// Revision 1.7  2007/12/24 22:38:43  lulin
// - удален ненужный модуль.
//
// Revision 1.6  2007/12/04 12:47:00  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.13  2007/09/20 18:10:38  lulin
// - форматируем параграф с учетом того, что он может содержать сегменты с объектами.
//
// Revision 1.1.2.12  2007/09/20 16:17:27  lulin
// - cleanup.
//
// Revision 1.1.2.11  2007/04/13 11:36:17  lulin
// - используем родную канву для подсчетов.
//
// Revision 1.1.2.10  2007/01/12 11:00:48  lulin
// - cleanup.
//
// Revision 1.1.2.9  2007/01/12 10:32:01  lulin
// - с интерфейса шрифта удалены ненужные методы.
//
// Revision 1.1.2.8  2007/01/11 14:36:19  lulin
// - шрифт и информация о шрифте теперь связаны отношением наследования.
//
// Revision 1.1.2.7  2007/01/11 14:06:28  lulin
// - интерфейс шрифта переехал в базовый модуль.
//
// Revision 1.1.2.6  2006/12/11 12:25:06  lulin
// - cleanup.
//
// Revision 1.1.2.5  2005/10/11 10:34:19  lulin
// - bug fix: не собиралась библиотека.
// - панель _Preview переехала в библиотеку VT.
//
// Revision 1.1.2.4  2005/10/07 11:21:14  lulin
// - спрятано устаревшее свойство шрифта.
//
// Revision 1.1.2.3  2005/06/01 16:22:24  lulin
// - remove unit: evIntf.
//
// Revision 1.1.2.2  2005/05/20 12:10:52  lulin
// - new unit: l3FontTools.
//
// Revision 1.1.2.1  2005/05/19 15:49:25  lulin
// - класс _TevCustomFont выделен в отдельный модуль.
//

{$Include evDefine.inc }

interface

uses
  Windows,
  
  Classes,

  Graphics,

  l3Types,
  l3Interfaces,

  k2Interfaces,
  k2Tags,
  k2Unknown,
  k2Base
  ;

type
  TevCustomFont = class(Ik2Unknown, Il3FontInfo, Il3Font)
   {* Базовый абстрактный класс для реализации интерфейсов Il3FontInfo и Il3Font. }
    protected
    // property methods
      function  pm_GetStyle: TFontStyles;
        {-}
      procedure pm_SetStyle(Value: TFontStyles);
        {-}
      function  pm_GetPitch: TFontPitch;
        {-}
      procedure pm_SetPitch(Value: TFontPitch);
        {-}
      function  pm_GetName: String;
        reintroduce;
      procedure pm_SetName(const Value: String);
        reintroduce;
        {-}
      function  pm_GetColor: Tl3Color;
      procedure pm_SetColor(Value: Tl3Color);
        {-}
      function Get_Size: Integer;
        {-}
      function Get_Name: TFontName;
        {-}
      function Get_Bold: Boolean;
        {-}
      function Get_Italic: Boolean;
        {-}
      function Get_Underline: Boolean;
        {-}
      function Get_Strikeout: Boolean;
        {-}
      function Get_ForeColor: Tl3Color;
        {-}
      function Get_BackColor: Tl3Color;
        {-}
      function Get_Pitch: TFontPitch;
        {-}
      // Il3Font
      procedure Set_ForeColor(Value: Tl3Color);
        {-}
      procedure Set_BackColor(Value: Tl3Color);
        {-}
      procedure Set_Name(const Value: TFontName);
        {-}
      procedure Set_Pitch(Value: TFontPitch);
        {-}
      procedure Set_Size(Value: Long);
        {-}
      function  Get_Style: TFontStyles;
      procedure Set_Style(Value: TFontStyles);
        {-}
      function  Get_Index: Tl3FontIndex;
      procedure Set_Index(Value: Tl3FontIndex);
        {-}
      procedure Set_Bold(Value: Boolean);
        {-}
      procedure Set_Italic(Value: Boolean);
        {-}
      procedure Set_Underline(Value: Boolean);
        {-}
      procedure Set_Strikeout(Value: Boolean);
        {-}
      function  AssignFont(aFont: TFont): Bool;
        virtual;
        {-}
      function IsAtomic: Boolean;
        virtual;
        {-}
    protected
    // internal methods
      function  GetTagType: Tk2Type;
        override;
        {-}
      function  NameStored: Bool;
        {-}
    public
    // public methods
      constructor Create{(anOwner: TObject = nil)};
        //override;
        {-}
      procedure AssignToFont(F: TFont);
        {-}
      procedure Assign(P: TPersistent);
        override;
        {-}
      procedure AssignTo(P: TPersistent);
        override;
        {-}
      procedure Lock;
        {-}
      procedure Unlock;
        {-}
      procedure Assign2Font(const aFont: Il3Font);
        virtual;
        {-}
      function HF: hFont;
        virtual;
        {-}
      function FM: Il3FontMetrics;
        virtual;
        {-}
    public
    // public properties
      property Bold: Bool
        index k2_tiBold
        read GetBoolParam
        write SetBoolParam
        default false;
        {* - жирный. }
      property Italic: Bool
        index k2_tiItalic
        read GetBoolParam
        write SetBoolParam
        default false;
        {* - курсив. }
      property Underline: Bool
        index k2_tiUnderline
        read GetBoolParam
        write SetBoolParam
        default false;
        {* - подчеркнутый. }
      property StrikeOut: Bool
        index k2_tiStrikeOut
        read GetBoolParam
        write SetBoolParam
        default false;
        {* - перечеркнутый. }
      property ForeColor: Long
        index k2_tiForeColor
        read GetLongParam
        write SetLongParam
        default clWindowText;
        {* - цвет текста см. Color. }
      property BackColor: Long
        index k2_tiBackColor
        read GetLongParam
        write SetLongParam
        default clWindow;
        {* - цвет фона. }
      property Size: Long
        index k2_tiSize
        read GetLongParam
        write SetLongParam
        default 10;
        {* - кегль. }
      property Name: String
        read pm_GetName
        write pm_SetName
        stored NameStored;
        {* - гарнитура. }
      property Style: TFontStyles
        read pm_GetStyle
        write pm_SetStyle
        default [];
        {* - стиль. }
      property Pitch: TFontPitch
        read pm_GetPitch
        write pm_SetPitch
        default fpDefault;
        {* - кернинг. }
      property Color: Tl3Color
        read pm_GetColor
        write pm_SetColor
        default clWindowText;
        {* - цвет текста. }
      property Index: Tl3FontIndex
        read Get_Index
        write Set_Index;
        {* - индекс. }
  end;//TevCustomFont

implementation

uses
  l3FontTools,
  
  k2Facade,

  Font_Const
  ;

// start class TevCustomFont 

constructor TevCustomFont.Create{(anOwner: TObject = nil)};
  //override;
  {-}
begin
 inherited;
// Size := 10;
end;

function TevCustomFont.pm_GetPitch: TFontPitch;
  {-}
begin
 Result := TFontPitch(GetLongParam(k2_tiPitch));
end;

procedure TevCustomFont.pm_SetPitch(Value: TFontPitch);
  {-}
begin
 SetLongParam(k2_tiPitch, Ord(Value));
end;

function TevCustomFont.pm_GetName: String;
  {-}
begin
 Result := GetStringParam(k2_tiName);
end;

procedure TevCustomFont.pm_SetName(const Value: String);
  {-}
begin
 SetStringParam(k2_tiName, Value);
end;

function TevCustomFont.pm_GetColor: Tl3Color;
  {-}
begin
 Result := ForeColor;
end;

procedure TevCustomFont.pm_SetColor(Value: Tl3Color);
  {-}
begin
 ForeColor := Value;
end;

function TevCustomFont.pm_GetStyle: TFontStyles;
  {-}
begin
 Result := [];
 if Get_Bold then Include(Result, fsBold);
 if Get_Italic then Include(Result, fsItalic);
 if Get_Underline then Include(Result, fsUnderline);
 if Get_Strikeout then Include(Result, fsStrikeout);
end;

procedure TevCustomFont.pm_SetStyle(Value: TFontStyles);
  {-}
begin
 Bold := (fsBold in Value);
 Italic := (fsItalic in Value);      
 Underline := (fsUnderline in Value);
 Strikeout := (fsStrikeout in Value);
end;

function TevCustomFont.Get_Size: Integer;
  {-}
begin
 try
  Result := Size;
 except
  Result := 0;
 end;{try..except}
end;

function TevCustomFont.Get_Name: TFontName;
  {-}
begin
 try
  Result := Name;
 except
  Result := '';
 end;{try..except}
end;

function TevCustomFont.Get_Bold: Boolean;
  {-}
begin
 try
  Result := Bold;
 except
  Result := false;
 end;{try..except}
end;

function TevCustomFont.Get_Italic: Boolean;
  {-}
begin
 try
  Result := Italic;
 except
  Result := false;
 end;{try..except}
end;

function TevCustomFont.Get_Underline: Boolean;
  {-}
begin
 try
  Result := Underline;
 except
{$IFDEF nsTest}
  on Ek2ParamNotDefined do
   Result := false;
{$ELSE}
  Result := false;
{$ENDIF nsTest}
 end;{try..except}
end;

function TevCustomFont.Get_Strikeout: Boolean;
  {-}
begin
 try
  Result := Strikeout;
 except
  Result := false;
 end;{try..except}
end;

function TevCustomFont.Get_ForeColor: Tl3Color;
  {-}
begin
 try
  Result := ForeColor;
 except
  Result := -1;
 end;{try..except}
end;

function TevCustomFont.Get_BackColor: Tl3Color;
  {-}
begin
 try
  Result := BackColor;
 except
  Result := -1;
 end;{try..except}
end;

function TevCustomFont.Get_Pitch: TFontPitch;
  {-}
begin
 try
  Result := Pitch;
 except
  Result := fpDefault;
 end;{try..except}
end;

procedure TevCustomFont.Set_ForeColor(Value: Tl3Color);
  {-}
begin
 ForeColor := Value;
end;

procedure TevCustomFont.Set_BackColor(Value: Tl3Color);
  {-}
begin
 BackColor := Value; 
end;

procedure TevCustomFont.Set_Name(const Value: TFontName);
  {-}
begin
 Name := Value;
end;

procedure TevCustomFont.Set_Pitch(Value: TFontPitch);
  {-}
begin
 Pitch := Value;
end;

procedure TevCustomFont.Set_Size(Value: Long);
  {-}
begin
 Size := Value;
end;

function TevCustomFont.Get_Style: TFontStyles;
  {-}
begin
 Result := Style;
end;

procedure TevCustomFont.Set_Style(Value: TFontStyles);
  {-}
begin
 Style := Value;
end;

function TevCustomFont.Get_Index: Tl3FontIndex;
  {-}
begin
 try
  Result := Tl3FontIndex(GetLongParam(k2_tiIndex));
 except
  Result := l3_fiNone;
 end;{try..except}
end;

procedure TevCustomFont.Set_Index(Value: Tl3FontIndex);
  {-}
begin
 SetLongParam(k2_tiIndex, Ord(Value));
end;

procedure TevCustomFont.Set_Bold(Value: Boolean);
  {-}
begin
 Bold := Value;
end;

procedure TevCustomFont.Set_Italic(Value: Boolean);
  {-}
begin
 Italic := Value;
end;

procedure TevCustomFont.Set_Underline(Value: Boolean);
  {-}
begin
 Underline := Value;
end;

procedure TevCustomFont.Set_Strikeout(Value: Boolean);
  {-}
begin
 Strikeout := Value;
end;

function TevCustomFont.AssignFont(aFont: TFont): Bool;
  {-}
begin
 Result := true;
 Name := aFont.Name;
 Size := aFont.Size;
 Style := aFont.Style;
 Pitch := aFont.Pitch;
 ForeColor := aFont.Color;
end;

function TevCustomFont.IsAtomic: Boolean;
  //virtual;
  {-}
begin
 Result := false;
end;

procedure TevCustomFont.AssignToFont(F: TFont);
  {-}
begin
 l3IFont2Font(Self, F);
end;

procedure TevCustomFont.Lock;
  {-}
begin
end;

procedure TevCustomFont.Unlock;
  {-}
begin
end;

procedure TevCustomFont.Assign2Font(const aFont: Il3Font);
  {virtual;}
  {-}
begin
 aFont.Lock;
 try
  aFont.Name := Get_Name;
  aFont.Size := Get_Size;
  aFont.Style := Style;
  aFont.Pitch := Get_Pitch;
  aFont.ForeColor := Get_ForeColor;
  aFont.BackColor := Get_BackColor;
  aFont.Index := Index;
 finally
  aFont.Unlock;
 end;{try..finally}
end;

function TevCustomFont.HF: hFont;
  //virtual;
  {-}
begin
 Result := 0;
 Assert(false);
end;

function TevCustomFont.FM: Il3FontMetrics;
  //virtual;
  {-}
begin
 Result := nil;
end;

function TevCustomFont.GetTagType: Tk2Type;
  //override;
  {-}
begin
 Result := k2_typFont;
end;

function TevCustomFont.NameStored: Bool;
  {-}
begin
 Result := (Name <> 'System');
end;

procedure TevCustomFont.Assign(P: TPersistent);
  {override;}
  {-}
var
 _OF : TevCustomFont absolute P;
begin
 if (P Is TFont) then
  AssignFont(TFont(P))
 else
 if (P Is TevCustomFont) then
 begin
  Name := _OF.Name;
  Size := _OF.Size;
  Style := _OF.Style;
  Pitch := _OF.Pitch;
  ForeColor := _OF.ForeColor;
  BackColor := _OF.BackColor;
 end//P Is TevCustomFont
 else
  inherited Assign(P);
end;

procedure TevCustomFont.AssignTo(P: TPersistent);
  {override;}
  {-}
begin
 if (P Is TevCustomFont) then
  P.Assign(Self)
 else
 if (P Is TFont) then
  AssignToFont(TFont(P))
 else
  inherited AssignTo(P);
end;

end.

