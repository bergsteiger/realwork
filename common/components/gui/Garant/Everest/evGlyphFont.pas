unit evGlyphFont;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evGlyphFont -   }
{ Начат: 20.09.2007 20:27 }
{ $Id: evGlyphFont.pas,v 1.5 2014/03/24 12:02:14 lulin Exp $ }

// $Log: evGlyphFont.pas,v $
// Revision 1.5  2014/03/24 12:02:14  lulin
// {RequestLink:522793127}
//
// Revision 1.4  2012/03/14 14:16:16  lulin
// {RequestLink:344139764}
//
// Revision 1.3  2008/02/26 13:37:32  lulin
// - написал комментарий.
//
// Revision 1.2  2008/02/26 13:33:30  lulin
// - <CQ>: 28349.
//
// Revision 1.1  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.7  2007/10/09 15:50:02  lulin
// - подготавливаемся к учету формулами оформления.
//
// Revision 1.6  2007/09/25 08:29:49  lulin
// - bug fix: формула не переносилась на другую, строку, если влезала нецеликом.
//
// Revision 1.5  2007/09/25 08:19:32  lulin
// - выравниваем текст по-вертикали относительно формул.
//
// Revision 1.4  2007/09/20 18:10:35  lulin
// - форматируем параграф с учетом того, что он может содержать сегменты с объектами.
//
// Revision 1.3  2007/09/20 17:16:40  lulin
// - для сегмента с параграфом возвращаем специальный атомарный шрифт.
//
// Revision 1.2  2007/09/20 16:40:49  lulin
// - добавлен конструктор и фабричный метод.
//
// Revision 1.1  2007/09/20 16:30:31  lulin
// - добавляем реализацию "атомарного" шрифта.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Base,
  l3Variant,

  k2Types,
  k2Interfaces,

  evCustomFont
  ;

type
  TevGlyphFont = class(TevCustomFont, Il3FontMetrics)
    private
    // internal fields
       f_Width    : Integer;
       f_Height   : Integer;
       f_FontName : Tl3String;
       f_Font     : Il3Font;
       f_BaseLined : Boolean;
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
      function IsAtomic: Boolean;
        override;
        {-}
      function FM: Il3FontMetrics;
        override;
        {-}
      function  Pos2Index(W: Integer; const S: Tl3WString): Integer;
        {-}
      function  TextExtent(const S : Tl3WString): Tl3_Point;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(aBaseLined      : Boolean;
                         aWidth, aHeight : Integer;
                         const aFont     : Il3Font);
        reintroduce;
        {-}
      class function Make(aBaseLined      : Boolean;
                          aWidth, aHeight : Integer;
                          const aFont     : Il3Font): Il3Font;
        reintroduce;
        {-}
  end;//TevGlyphFont

implementation

uses
  Graphics,

  l3String,

  k2Tags
  ;

// start class TevGlyphFont

constructor TevGlyphFont.Create(aBaseLined      : Boolean;
                                aWidth, aHeight : Integer;
                                const aFont     : Il3Font);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Width := aWidth;
 f_Height := aHeight;
 f_Font := aFont;
 f_BaseLined := aBaseLined;
end;

class function TevGlyphFont.Make(aBaseLined      : Boolean;
                                 aWidth, aHeight : Integer;
                                 const aFont     : Il3Font): Il3Font;
  //reintroduce;
  {-}
var
 l_F : TevGlyphFont;
begin
 Assert(aFont <> nil);
 l_F := Create(aBaseLined, aWidth, aHeight, aFont);
 try
  Result := l_F;
 finally
  l3Free(l_F);
 end;//try..finally
end;

procedure TevGlyphFont.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_FontName);
 f_Font := nil;
 inherited;
end;

function TevGlyphFont.pm_GetHandle: Tl3Handle;
  {override;}
  {-}
begin
 Result := 0;
 Assert(false);
end;

procedure TevGlyphFont.pm_SetHandle(Value: Tl3Handle);
  {override;}
  {-}
begin
 Assert(false);
end;

procedure TevGlyphFont.SetLongParam(Index: Integer; Value: Long);
  //override;
  {-}
begin
 Assert(false);
end;

function TevGlyphFont.IsAtomic: Boolean;
  //override;
  {-}
begin
 Result := true;
end;

function TevGlyphFont.FM: Il3FontMetrics;
  //override;
  {-}
begin
 Result := Self;
end;

function TevGlyphFont.Pos2Index(W: Integer; const S: Tl3WString): Integer;
  {-}
begin
 if (W < f_Width) then
  Result := 0
 else
  Result := S.SLen;
end;

function TevGlyphFont.TextExtent(const S : Tl3WString): Tl3_Point;
  {-}
begin
 if (S.SLen <= 0) then
 // <CQ>: 28349.
 // Если сегмент не влез, то не учитываем его размеры при подсчёте размеров строки
 begin
  Result.X := 0;
  Result.Y := 0;
 end//S.SLen <= 0
 else
 begin
  Result.X := f_Width;
  Result.Y := f_Height;
 end;//S.SLen <= 0
end;

procedure TevGlyphFont.GetParam(Index: Long; TK: Tk2TypeKind; var Dest);
  //override;
begin
 Case TK of
  k2_tkInteger:
  begin
   Case Index of
    k2_tiHandle:
    begin
     Long(Dest) := 0;
     Assert(false);
    end;//k2_tiHandle
    k2_tiBold:
     Long(Dest) := Ord(f_Font.Bold);//Ord(false);
    k2_tiItalic:
     Long(Dest) := Ord(f_Font.Italic);//Ord(false);
    k2_tiUnderline:
     Long(Dest) := Ord(f_Font.Underline);//Ord(false);
    k2_tiStrikeout:
     Long(Dest) := Ord(f_Font.Strikeout);//Ord(false);
    k2_tiForeColor:
     Long(Dest) := f_Font.ForeColor;//clDefault;
    k2_tiBackColor:
     Long(Dest) := f_Font.BackColor;//clDefault;
    k2_tiSize:
     Long(Dest) := f_Font.Size;//0;
    k2_tiPitch:
     Long(Dest) := Ord(fpDefault);
    k2_tiIndex:
     if f_BaseLined then
      Long(Dest) := Ord(l3_fiBaseLined)
     else
      Long(Dest) := Ord(l3_fiObject);
    else
     inherited GetParam(Index, TK, Dest);
   end;//Case Index
  end;//k2_tkInteger
  k2_tkBool:
  begin
   Case Index of
    k2_tiBold:
     Bool(Dest) := f_Font.Bold;//false;
    k2_tiItalic:
     Bool(Dest) := f_Font.Italic;//false;
    k2_tiUnderline:
     Bool(Dest) := f_Font.Underline;//false;
    k2_tiStrikeout:
     Bool(Dest) := f_Font.Strikeout;//false;
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
      f_FontName := Tl3String.Make(l3PCharLen(String(l3GlyphFontName)));
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

procedure TevGlyphFont.SetParam(Index: Long; Source: Tl3Variant);
  //override;
  {-}
begin
 Assert(false);
end;

end.

