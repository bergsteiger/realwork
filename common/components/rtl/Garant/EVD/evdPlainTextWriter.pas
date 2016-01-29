unit evdPlainTextWriter;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evdPlainTextWriter - }
{ Начат: 14.05.2004 19:42 }
{ $Id: evdPlainTextWriter.pas,v 1.9 2013/10/21 15:43:12 lulin Exp $ }

// $Log: evdPlainTextWriter.pas,v $
// Revision 1.9  2013/10/21 15:43:12  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.8  2013/10/21 10:31:00  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.7  2010/11/30 11:47:10  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.6  2009/07/03 16:24:09  lulin
// - шаг к переходу от интерфейсов к объектам.
//
// Revision 1.5  2009/03/04 13:33:09  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.4  2007/08/09 18:05:28  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.3  2007/08/09 11:19:25  lulin
// - cleanup.
//
// Revision 1.2  2005/07/21 11:17:09  lulin
// - bug fix: поправлен Include.
//
// Revision 1.1  2005/07/21 10:40:04  lulin
// - генератор plain-текста переехал в правильную папку.
//
// Revision 1.4.8.1  2005/07/21 10:20:04  lulin
// - теперь TextSource не знает как создавать Reader'ы, а про это знает контейнер документа.
//
// Revision 1.4  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.3  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.2  2004/06/02 14:45:48  law
// - rename method: Tk2BaseStackGenerator.Atom2String -> VariantAsString.
// - сделан фильтр для сбора информации о документах со строками в кодировке _1252.
//
// Revision 1.1  2004/05/14 16:07:56  law
// - new units: evFileGenerator, evPlainTextGenerator.
//

{$Include evdDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Filer,

  k2Types,
  k2FileGenerator
  ;

type
  TevdCustomPlainTextWriter = class(Tk2CustomFileGenerator)
   {* Базовый писатель текста в формате txt. }
    private
    // internal fields
      f_First : Boolean;
    protected
    // internal methods
      procedure FilerChanged(aFiler: Tl3CustomFiler);
        override;
        {-}
      procedure OpenStream;
        override;
        {-}
      procedure OutText(S: Tl3CustomString);
        virtual;
        {-}
    protected
    // protected properties
      property First: Boolean
        read f_First
        write f_First;
        {-}
    public
    // public methods
      procedure AddAtomEx(AtomIndex: Long; const aValue: Tk2Variant);
        override;
        {-}
      procedure OutEOL;
        override;
        {-}
  end;//TevdCustomPlainTextWriter
  {* Записывает в файл только текст тегов, игнорируя всяческое оформление. }

  TevdPlainTextWriter = class(TevdCustomPlainTextWriter)
   {*! Пользовательский класс для записи txt-файлов. }
    published
    {published properties}
      property Filer;
        {-}
  end;//TevdPlainTextWriter
  {* Пользовательский класс для записи txt-файлов. Для использования на форме в design-time. }
  
implementation

uses
  k2Tags,
  k2Interfaces,
  k2Base,

  LeafPara_Const
  ;

// start class TevdCustomPlainTextWriter 

procedure TevdCustomPlainTextWriter.FilerChanged(aFiler: Tl3CustomFiler);
  //override;
  {-}
begin
 inherited;
 First := (aFiler = nil) OR (aFiler.Pos = 0);
end;
  
procedure TevdCustomPlainTextWriter.OpenStream;
  {override;}
  {-}
begin
 First := (f_Filer = nil) OR (f_Filer.Pos = 0);
 inherited;
end;

procedure TevdCustomPlainTextWriter.OutEOL;
  {override;}
  {-}
begin
 if First then First := false else inherited;
end;

procedure TevdCustomPlainTextWriter.OutText(S: Tl3CustomString);
  {virtual;}
  {-}
begin
 OutEOL;
 OutString(S);
end;

procedure TevdCustomPlainTextWriter.AddAtomEx(AtomIndex: Long; const aValue: Tk2Variant);
  {override;}
  {-}
var
 CT  : Tk2TypePrim;
 l_S : Tl3CustomString;
begin
 CT := CurrentType;
 if (CT <> nil) AND
     CT.IsKindOf(k2_typLeafPara) AND
     // - пропускаем текст относящийся не к листьевым параграфам или другим тегам
    (AtomIndex = k2_tiText) then begin
  l_S := VariantAsString(aValue);
  try
   OutText(l_S);
  finally
   l3Free(l_S);
  end;{try..finally}
 end;{AtomIndex = k2_tiText}
end;

end.

