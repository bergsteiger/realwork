unit evFont;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evFont -        }
{ Начат: 19.05.2005 17:32 }
{ $Id: evFont.pas,v 1.109 2014/05/29 09:29:24 lulin Exp $ }

// $Log: evFont.pas,v $
// Revision 1.109  2014/05/29 09:29:24  lulin
// - чистим код.
//
// Revision 1.108  2014/03/24 12:02:14  lulin
// {RequestLink:522793127}
//
// Revision 1.107  2014/03/03 15:08:33  lulin
// - рефакторинг менеджера шрифтов.
//
// Revision 1.106  2014/02/13 15:15:55  lulin
// - рефакторим безликие списки.
//
// Revision 1.105  2009/07/02 17:42:26  lulin
// - распиливаем канву на несколько групп методов.
//
// Revision 1.104  2007/12/04 12:47:01  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.86.2.17  2007/09/20 17:16:42  lulin
// - для сегмента с параграфом возвращаем специальный атомарный шрифт.
//
// Revision 1.86.2.16  2007/09/20 16:17:28  lulin
// - cleanup.
//
// Revision 1.86.2.15  2007/07/10 17:41:13  lulin
// - удалено устаревшее свойство.
//
// Revision 1.86.2.14  2007/01/12 11:00:48  lulin
// - cleanup.
//
// Revision 1.86.2.13  2007/01/11 14:36:19  lulin
// - шрифт и информация о шрифте теперь связаны отношением наследования.
//
// Revision 1.86.2.12  2007/01/11 14:06:28  lulin
// - интерфейс шрифта переехал в базовый модуль.
//
// Revision 1.86.2.11  2007/01/11 13:19:27  lulin
// - изспользуем "родной" шрифт.
//
// Revision 1.86.2.10  2006/12/04 15:39:37  lulin
// - модуль переименован в соответствии с его функциями.
//
// Revision 1.86.2.9  2006/01/18 08:54:30  lulin
// - изыскания на тему прямой установки целочисленных атрибутов, без преобразования их к тегам.
//
// Revision 1.86.2.8  2005/10/07 11:21:14  lulin
// - спрятано устаревшее свойство шрифта.
//
// Revision 1.86.2.7  2005/09/14 11:29:25  lulin
// - bug fix: иногда строчки параграфа с курсором рисовались с неправильным цветом текста.
//
// Revision 1.86.2.6  2005/05/19 15:49:26  lulin
// - класс _TevCustomFont выделен в отдельный модуль.
//
// Revision 1.86.2.5  2005/05/19 13:49:44  lulin
// - класс _TevFont вынесен в отдельный модуль.
//

{$Include evDefine.inc }

interface

uses
  Graphics,

  l3Types,
  l3Interfaces,
  l3Base,
  l3Variant,

  k2Types,
  k2Interfaces,
  
  evCustomFont
  ;

type
  TevFont = class(TevCustomFont)
   {* Класс реализующий интерфейсы Il3FontInfo и Il3Font на основе TFont. }
    private
      f_Font      : TFont;
      f_BackColor : TColor;
      f_Index     : Tl3FontIndex;
      f_FontName  : Tl3String;
    protected
    // property methods
      function  pm_GetHandle: Tl3Handle;
        override;
      procedure pm_SetHandle(Value: Tl3Handle);
        override;
        {-}
      procedure GetParam(Index: Long; TK: Tk2TypeKind; var Dest);
        override;
      procedure SetParam(Index: Long; Source: Tl3Variant);
        override;
        {-}
      procedure SetLongParam(Index: Integer; Value: Long);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      function  AssignFont(aFont: TFont): Bool;
        override;
        {-}
    public
    // public methods
      constructor Create{(anOwner: TObject = nil)};
        //override;
        {-}
      class function IsCacheable: Bool;
        override;
        {-}
      procedure Assign2Font(const aFont: Il3Font);
        override;
        {-}
    public
    // public properties
      property BackColor
        default clDefault;
        {* - цвет фона. }
    published
    // published properties
      property Name;
        {* - гарнитура. }
      property Size;
        {* - кегль. }
      property Style;
        {* - стиль. }
      property Pitch;
        {* - кернинг. }
      property Color;
        {* -цвет текста. }
  end;//TevFont

implementation

uses
  l3Chars,
  l3FontManager,
  l3String,

  afwFont,

  k2Tags
  ;

// start class TevFont 

constructor TevFont.Create{(anOwner: TObject = nil)};
  {override;}
  {-}
begin
 inherited;
 if (f_Font = nil) then
  f_Font := TafwFont.Create
 else
 begin
  f_Font.Color := clWindowText;
  f_Font.Style := [];
  f_Font.Pitch := fpDefault;
  f_Font.CharSet := CS_Effective;
  f_Font.Height := 0;
 end;//f_Font = nil  
 f_Font.Size := 10;
 f_Font.Name := 'System';
 f_BackColor := clDefault;
 f_Index := l3_fiNone;
end;

procedure TevFont.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_FontName);
 l3Free(f_Font);
 inherited;
end;

class function TevFont.IsCacheable: Bool;
  {override;}
  {-}
begin
 Result := true;
end;

procedure TevFont.Assign2Font(const aFont: Il3Font);
  {override;}
  {-}
begin
 aFont.Lock;
 try
  if aFont.AssignFont(f_Font) then
  begin
   if (aFont.ForeColor <> ForeColor) then
    aFont.ForeColor := ForeColor;
   aFont.BackColor := BackColor;
   aFont.Index     := Index;
  end//aFont.AssignFont(f_Font)
  else
   inherited;
 finally
  aFont.Unlock;
 end;{try..finally}
end;

function TevFont.AssignFont(aFont: TFont): Bool;
  {override;}
  {-}
begin
 Result := true;
 f_Font.Assign(aFont);
end;
  
function TevFont.pm_GetHandle: Tl3Handle;
  {override;}
  {-}
begin
 Result := f_Font.Handle;
end;

procedure TevFont.pm_SetHandle(Value: Tl3Handle);
  {override;}
  {-}
begin
 f_Font.Handle := Value;
end;

procedure TevFont.GetParam(Index: Long; TK: Tk2TypeKind; var Dest);
  {override;}
  {-}
begin
 Case TK of
  k2_tkInteger:
  begin
   Case Index of
    k2_tiHandle:
     Long(Dest) := Handle;
    k2_tiBold:
     Long(Dest) := Ord(fsBold in f_Font.Style);
    k2_tiItalic:
     Long(Dest) := Ord(fsItalic in f_Font.Style);
    k2_tiUnderline:
     Long(Dest) := Ord(fsUnderline in f_Font.Style);
    k2_tiStrikeout:
     Long(Dest) := Ord(fsStrikeout in f_Font.Style);
    k2_tiForeColor:
     Long(Dest) := f_Font.Color;
    k2_tiBackColor:
     Long(Dest) := f_BackColor;
    k2_tiSize:
     Long(Dest) := f_Font.Size;
    k2_tiPitch:
     Long(Dest) := Ord(f_Font.Pitch);
    k2_tiIndex:
     Long(Dest) := Ord(f_Index);
    else
     inherited GetParam(Index, TK, Dest);
   end;//Case Index
  end;//k2_tkInteger
  k2_tkBool:
  begin
   Case Index of
    k2_tiBold:
     Bool(Dest) := fsBold in f_Font.Style;
    k2_tiItalic:
     Bool(Dest) := fsItalic in f_Font.Style;
    k2_tiUnderline:
     Bool(Dest) := fsUnderline in f_Font.Style;
    k2_tiStrikeout:
     Bool(Dest) := fsStrikeout in f_Font.Style;
    else
     inherited GetParam(Index, TK, Dest);
   end;//Case Index
  end;//k2_tkBool
  k2_tkObject:
  begin
   Case Index of
    k2_tiName:
    begin
     if (f_FontName = nil) then
      f_FontName := Tl3String.Make(l3PCharLen(f_Font.Name))
     else
      f_FontName.AsString := f_Font.Name;
     TObject(Dest) := f_FontName;
    end;//k2_tiName
    else
     inherited GetParam(Index, TK, Dest);
   end;//Case Index
  end;//k2_tkBool
  else
   inherited GetParam(Index, TK, Dest);
 end;//Case TK
end;

procedure TevFont.SetParam(Index: Long; Source: Tl3Variant);
  {override;}
  {-}
begin
 Case Index of
  k2_tiHandle:
   Handle := Source.AsLong;
  k2_tiBold:
   if Source.AsBool then
    f_Font.Style := f_Font.Style + [fsBold]
   else
    f_Font.Style := f_Font.Style - [fsBold];
  k2_tiItalic:
   if Source.AsBool then
    f_Font.Style := f_Font.Style + [fsItalic]
   else
    f_Font.Style := f_Font.Style - [fsItalic];
  k2_tiUnderline:
   if Source.AsBool then
    f_Font.Style := f_Font.Style + [fsUnderline]
   else
    f_Font.Style := f_Font.Style - [fsUnderline];
  k2_tiStrikeout:
   if Source.AsBool then
    f_Font.Style := f_Font.Style + [fsStrikeout]
   else
    f_Font.Style := f_Font.Style - [fsStrikeout];
  k2_tiForeColor:
   f_Font.Color := Source.AsLong;
  k2_tiBackColor:
   f_BackColor := Source.AsLong;
  k2_tiSize:
   f_Font.Size := Source.AsLong;
  k2_tiPitch:
   f_Font.Pitch := TFontPitch(Source.AsLong);
  k2_tiIndex:
   f_Index := Tl3FontIndex(Source.AsLong);
  k2_tiName:
   f_Font.Name := (Source.AsObject As Tl3PrimString).AsString;
  else
   inherited SetParam(Index, Source);
 end;//Case Index
end;

procedure TevFont.SetLongParam(Index: Integer; Value: Long);
  //override;
  {-}
begin
 Case Index of
  k2_tiHandle:
   Handle := Value;
  k2_tiBold:
   if (Value <> 0) then
    f_Font.Style := f_Font.Style + [fsBold]
   else
    f_Font.Style := f_Font.Style - [fsBold];
  k2_tiItalic:
   if (Value <> 0) then
    f_Font.Style := f_Font.Style + [fsItalic]
   else
    f_Font.Style := f_Font.Style - [fsItalic];
  k2_tiUnderline:
   if (Value <> 0) then
    f_Font.Style := f_Font.Style + [fsUnderline]
   else
    f_Font.Style := f_Font.Style - [fsUnderline];
  k2_tiStrikeout:
   if (Value <> 0) then
    f_Font.Style := f_Font.Style + [fsStrikeout]
   else
    f_Font.Style := f_Font.Style - [fsStrikeout];
  k2_tiForeColor:
   f_Font.Color := Value;
  k2_tiBackColor:
   f_BackColor := Value;
  k2_tiSize:
   f_Font.Size := Value;
  k2_tiPitch:
   f_Font.Pitch := TFontPitch(Value);
  k2_tiIndex:
   f_Index := Tl3FontIndex(Value);
  k2_tiName:
   inherited;
  else
   inherited;
 end;//Case Index
end;

end.

