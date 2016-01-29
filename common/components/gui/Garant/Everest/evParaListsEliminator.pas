unit evParaListsEliminator;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evParaListsEliminator - }
{ Начат: 21.10.2004 23:08 }
{ $Id: evParaListsEliminator.pas,v 1.1 2004/10/21 19:14:05 lulin Exp $ }

// $Log: evParaListsEliminator.pas,v $
// Revision 1.1  2004/10/21 19:14:05  lulin
// - new behavior: не даем вставлять структурные элементы (таблицы, блоки и т.п.) - пока пользовательские комментарии это у нас PlainText - потом можно будет переделать (CQ OIT5-10512).
//

{$I evDefine.inc }

interface

uses
  k2TagFilter
  ;

type
  TevParaListsEliminator = class(Tk2TagFilter)
    protected
    // internal methods
      function  NeedTranslateChildToNext: Boolean;
        override;
        {-}
  end;//TevParaListsEliminator

implementation

uses
  k2Tags
  ;

// start class TevParaListsEliminator

function TevParaListsEliminator.NeedTranslateChildToNext: Boolean;
  //override;
  {-}
begin
 with CurrentType do
  Result := not InheritsFrom(k2_idParaList) OR InheritsFrom(k2_idDocument);
end;

end.

