unit nevFontPrim;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: nevFontPrim -   }
{ Начат: 20.05.2005 19:49 }
{ $Id: nevFontPrim.pas,v 1.9 2014/03/24 12:02:15 lulin Exp $ }

// $Log: nevFontPrim.pas,v $
// Revision 1.9  2014/03/24 12:02:15  lulin
// {RequestLink:522793127}
//
// Revision 1.8  2014/02/21 12:59:32  lulin
// - упрощаем наследование.
//
// Revision 1.7  2008/02/14 17:09:01  lulin
// - cleanup.
//
// Revision 1.6  2007/12/04 12:47:51  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.5  2007/09/04 15:54:18  lulin
// - убран ненужный параметр.
//
// Revision 1.1.2.4  2007/01/11 14:06:31  lulin
// - интерфейс шрифта переехал в базовый модуль.
//
// Revision 1.1.2.3  2005/05/23 13:26:08  lulin
// - используем интерфейс, а не объект.
//
// Revision 1.1.2.2  2005/05/23 12:23:58  lulin
// - bug fix: были AV при получении шрифта.
//
// Revision 1.1.2.1  2005/05/20 16:30:17  lulin
// - развязал интерфейс и реализацию шрифта выделения.
//

{$Include nevDefine.inc }

interface

uses
  l3Types,
  l3Interfaces,
  l3Base,
  l3CProtoObject,
  l3Variant,

  k2Interfaces,
  k2Tags,
  
  evResultFont,
  
  nevTools
  ;

type
  TnevFontPrim = class(Tl3CProtoObject, InevFontPrim)
    private
    // internal fields
      f_Font : TevResultFont;
    protected
    // interface methods
      // InevFontPrim 
      function  SubFont(const aFont: InevFontPrim): Boolean;
        {* - вычитает шрифт. }
      function  AsFont(CorrectItalic: Boolean): Il3Font;
        {* - преобразует к Il3Font. }
      function  GetParam(ItemIndex: Tk2FontParam): Long;
        {-}
      procedure Set2Font(const aFont: Il3Font; CorrectItalic: Bool);
        {* - присваивает себя Il3Font. }
      function  Empty: Boolean;
        {-}
      procedure MakeFontArray(BlockFont: Bool);
        {-}
      procedure InitFromTag(aTag: Tl3Variant);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(aFont: PevResultFont);
        reintroduce;
        {-}
      class function Make(aFont: PevResultFont = nil): InevFontPrim;
        reintroduce;
        {-}
  end;//TnevFontPrim

implementation

uses
  k2Const
  ;

// start class TnevFontPrim

constructor TnevFontPrim.Create(aFont: PevResultFont);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Font.Init;
 if (aFont <> nil) then
  f_Font.AddFont(aFont^);
end;

class function TnevFontPrim.Make(aFont: PevResultFont = nil): InevFontPrim;
  //reintroduce;
  {-}
var
 l_F : TnevFontPrim;
begin
 l_F := Create(aFont);
 try
  Result := l_F;
 finally
  l3Free(l_F);
 end;//try..finally
end;

procedure TnevFontPrim.Cleanup;
  //override;
  {-}
begin
 f_Font.Clear;
 inherited;
end;

function TnevFontPrim.SubFont(const aFont: InevFontPrim): Boolean;
  {* - вычитает шрифт. }
var
 i : Tk2FontParam;
 V : Long;
begin
 Result := Empty;
 if Result AND ((aFont = nil) OR aFont.Empty) then
  Result := false
 else
 begin
  if (aFont <> nil) then
  begin
   MakeFontArray(false);
   f_Font.ClearParam;
   f_Font.InitParam;
   aFont.MakeFontArray(false);
   for i := Low(TevFontArray) to High(TevFontArray) do
   begin
    V := f_Font.FontArray^[i];
    if (V <> k2_TransparentValue) AND (V = aFont.GetParam(i)) then
     f_Font.SetItem(Ord(i), nil, V)
    else
     f_Font.DeleteItem(Ord(i) - Ord(Low(TevFontArray)), nil);
   end;//for i..
   f_Font.ClearFontArray;
   MakeFontArray(true);
  end;//aFont <> nil
  Result := Empty;
 end;//Result AND aFont.Empty
end;

function TnevFontPrim.AsFont(CorrectItalic: Boolean): Il3Font;
  {* - преобразует к Il3Font. }
begin
 Result := f_Font.AsFont(CorrectItalic);
end;

function TnevFontPrim.GetParam(ItemIndex: Tk2FontParam): Long;
  {-}
begin
 Result := f_Font.GetParam(ItemIndex);
end;

procedure TnevFontPrim.Set2Font(const aFont: Il3Font; CorrectItalic: Bool);
  {* - присваивает себя Il3Font. }
begin
 f_Font.Set2Font(aFont, CorrectItalic);
end;

function TnevFontPrim.Empty: Boolean;
  {-}
begin
 Result := f_Font.Empty;
end;

procedure TnevFontPrim.MakeFontArray(BlockFont: Bool);
  {-}
begin
 f_Font.MakeFontArray(BlockFont);
end;

procedure TnevFontPrim.InitFromTag(aTag: Tl3Variant);
  {-}
begin
 f_Font.Clear;
 f_Font.AddStyledTag(aTag);
end;

end.

