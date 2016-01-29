unit ddFormula2PictureFilter;
{ Превращает формулы в картинки }

{ $Id: ddFormula2PictureFilter.pas,v 1.17 2014/07/11 11:01:20 lulin Exp $ }
// $Log: ddFormula2PictureFilter.pas,v $
// Revision 1.17  2014/07/11 11:01:20  lulin
// - вычищаем ответные процедуры при остановке сервера.
//
// Revision 1.15  2014/07/10 17:15:17  lulin
// {RequestLink:543448591}
//
// Revision 1.14  2014/07/03 14:33:18  lulin
// - работаем над инфраструктурой заворачивания тегов в таски.
//
// Revision 1.13  2014/04/08 14:17:10  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.12  2014/04/07 06:53:33  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.11  2014/03/25 14:31:53  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.10  2014/03/04 14:35:30  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.9  2014/02/24 15:14:28  lulin
// {RequestLink:518433323}
//
// Revision 1.8  2014/02/21 18:08:46  lulin
// - избавляемся от обёрток над тегами.
//
// Revision 1.7  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.6  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.5  2013/02/13 09:26:01  fireton
// - альфа-канал для картинок-формул
//
// Revision 1.4  2012/10/10 10:16:05  narry
// Формулы в PNG
//
// Revision 1.3  2012/08/30 13:55:23  narry
// Экспорт для Хаванского
//
// Revision 1.2  2012/08/27 11:28:06  narry
// Заменяет формулы картинками (для экспорта во внешние форматы)
//
// Revision 1.1  2012/08/22 14:01:35  narry
// Заменяет формулы картинками (для экспорта во внешние форматы)
//

interface

uses
  evdLeafParaFilter, k2Interfaces, l3types,

  k2Base
  ;

type
 TddFormula2PictureFilter = class(TevdLeafParaFilter)
 protected
        {* Summary
          Определяет нужно ли фильтровать переданный абзац.  }
  procedure DoWritePara(aLeaf: Tl3Variant); override;
        {-}
  function ParaTypeForFiltering: Tk2Type; override;
 end;

implementation

uses
  TextPara_Const, evTypes, k2Tags, evdTypes,
  l3BitmapContainer,
  l3MetafileContainer,
  ExprDraw,
  ExprMake, evFont, l3Memory, l3BaseStream, l3InternalInterfaces, SysUtils, BitmapPara_Const,
  Formula_Const, l3GraphicContainer, l3Const, Math, l3Math, l3Base, ImageEnIO, ImageEnProc,
  hyieutils, hyiedefs,

  k2SizedMemoryPool,
  Classes,
  k2RawData_Const,
  l3Stream,
  l3ImageUtils
  ;

type
  _B_ = {$IfDef UseMetafile}
        Tl3MetafileContainer
        {$Else  UseMetafile}
        Tl3BitmapContainer
        {$EndIf UseMetafile}
        ;


procedure TddFormula2PictureFilter.DoWritePara(aLeaf: Tl3Variant);
var
 l_Seg    : Tl3Variant;
 l_Layer  : Tl3Variant;
 l_Bitmap : _B_;
 l_Expr   : Tl3expr;
 l_F      : TevFont;
 l_Pool   : Tk2RawData;
 l_Pic    : Tl3Variant;
 I : Integer;
begin
 l_Layer := aLeaf.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slObjects)], nil);
 if l_Layer.IsValid then
 begin
  for i:= 0 to Pred(l_Layer.ChildrenCount) do
  begin
   l_Seg:= l_Layer.Child[i];
   // Проверить, что это формула
   if (l_Seg.ChildrenCount > 0) and l_Seg.Child[0].IsKindOf(k2_typFormula) then
   begin
    try
     l_Expr:= SafeBuildExpr(l_Seg.Child[0].StrA[k2_tiText]);
    except
     on E: EIncorrectExpr do
     begin
      l3System.Msg2Log('Ошибка преобразования формулы "%s": %s', [l_Seg.Child[0].StrA[k2_tiText], E.Message]);
      l_Expr:= nil;
     end; // E: EIncorrectExpr
    end;
    try
     l_Seg.DeleteChild(0);
     if l_Expr <> nil then
     begin
      l_Bitmap:= _B_.Create;
      try
       l_F := TevFont.Create;
       try
        l_F.Name:= l_Expr.Font.Name;
        // Видимо, нужно взять шрифт от абзаца
        //if Abs(aCHP.FontSize) <> propUndefined then
        l_F.Size:= aLeaf.Attr[k2_tiFont].IntA[k2_tiSize];
        if (l_F.Size = 0) then
         l_F.Size:= 12; // Заменить на константу
        l_Bitmap.SetParams(l_Expr As Il3Renderer, l_F);
       finally
        FreeAndNil(l_F);
       end;
       l_Pool := Tk2RawData.Create;
       try
        l3BitmapToAlphaPNG(l_Bitmap.Bitmap, l_Pool As IStream);
        l_Pic:= k2_typBitmapPara.MakeTag.AsObject;
        l_Pic.AttrW[k2_tiData, nil] := l_Pool;
        l_Pic.IntW[k2_tiDPI, nil] := 96;
        l_Pic.IntW[k2_tiWidth, nil] :=  l3MulDiv(l_Bitmap.Width, l3Inch, 96);
        l_Pic.IntW[k2_tiHeight, nil] := l3MulDiv(l_Bitmap.Height, l3Inch, 96);
        l_Seg.AddChild(l_Pic.AsObject);
       finally
        FreeAndNil(l_Pool);
       end;
      finally
       FreeAndNil(l_Bitmap);
      end;
     end; // l_Expr <> nil
    finally
     FreeAndNil(l_Expr);
    end;
   end;
  end; //for i
 end; // l_Segments.IsValid
 inherited DoWritePara(aLeaf);
end;

function TddFormula2PictureFilter.ParaTypeForFiltering: Tk2Type;
begin
 Result := k2_typTextPara;
end;

end.
