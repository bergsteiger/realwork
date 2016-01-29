unit evPageBreakEliminator;
{* Фильтр, выкидивающий разрывы страниц и разделов. }

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evPageBreakEliminator - }
{ Начат: 28.09.1999 10:18 }
{ $Id: evPageBreakEliminator.pas,v 1.8 2014/04/04 17:53:34 lulin Exp $ }

// $Log: evPageBreakEliminator.pas,v $
// Revision 1.8  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.7  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.6  2009/03/04 13:32:46  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.5  2007/12/04 12:47:03  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.3.8.1  2005/06/23 13:52:45  lulin
// - фильтр листьевых параграфов переехал в папку EVD.
//
// Revision 1.3  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.2  2005/02/01 14:12:03  lulin
// - bug fix: при вставке комментарие теперь отрезаем ID параграфов - т.к. иначе на комментарии ставились закладки, ни и прочая...
//
// Revision 1.1  2004/11/25 16:42:09  lulin
// - new behavior: в комментарии не даем вставлять разрывы страниц и разделов.
//

{$Include evDefine.inc }

interface

uses
  l3Types,

  k2Interfaces,
  k2Base,
  
  evdLeafParaFilter
  ;

type
  TevPageBreakEliminator = class(TevdLeafParaFilter)
   {* Фильтр, выкидивающий разрывы страниц и разделов. }
    protected
    // internal methods
      function  ParaTypeForFiltering: Tk2Type;
        override;
        {-}
      function  NeedWritePara(aLeaf: Tl3Variant): Boolean;
        override;
        {-}
  end;//TevPageBreakEliminator

implementation

uses
  PageBreak_Const
  ;

// start class TevPageBreakEliminator

function TevPageBreakEliminator.ParaTypeForFiltering: Tk2Type;
  //override;
  {-}
begin
 Result := k2_typPageBreak;
end;

function TevPageBreakEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
  //override;
  {-}
begin
 Result := false;
end;

end.

