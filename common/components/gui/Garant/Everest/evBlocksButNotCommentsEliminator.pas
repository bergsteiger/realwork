unit evBlocksButNotCommentsEliminator;
{* Фильтр, выкидивающий блоки, но не комментарии. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evBlocksButNotCommentsEliminator - }
{ Начат: 17.11.2004 16:39 }
{ $Id: evBlocksButNotCommentsEliminator.pas,v 1.4 2013/10/21 15:42:57 lulin Exp $ }

// $Log: evBlocksButNotCommentsEliminator.pas,v $
// Revision 1.4  2013/10/21 15:42:57  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.3  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.2  2009/03/04 13:32:45  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.1  2004/11/18 08:12:28  lulin
// - забыл добавить.
//

{$I evDefine.inc }

interface

uses
  k2TagFilter
  ;

type
  TevBlocksButNotCommentsEliminator = class(Tk2TagFilter)
    protected
    // internal methods
      function  NeedTranslateChildToNext: Boolean;
        override;
        {-}
  end;//TevBlocksButNotCommentsEliminator

implementation

uses
  Block_Const,
  Document_Const,
  CommentPara_Const
  ;

// start class TevBlocksButNotCommentsEliminator

function TevBlocksButNotCommentsEliminator.NeedTranslateChildToNext: Boolean;
  //override;
  {-}
begin
 with CurrentType do
  Result := not IsKindOf(k2_typBlock) OR IsKindOf(k2_typDocument) OR
            IsKindOf(k2_typCommentPara);
end;

end.

