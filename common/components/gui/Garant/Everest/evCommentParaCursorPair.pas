unit evCommentParaCursorPair;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evCommentParaCursorPair - }
{ Начат: 26.05.2006 15:49 }
{ $Id: evCommentParaCursorPair.pas,v 1.3 2008/04/09 17:57:07 lulin Exp $ }

// $Log: evCommentParaCursorPair.pas,v $
// Revision 1.3  2008/04/09 17:57:07  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.2  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.1  2006/05/26 14:06:10  lulin
// - bug fix: при выделении текста в комментариях текст из буфера не вставлялся - только выделение удалялось (CQ OIT5-21034).
//

{$Include evDefine.inc }

interface

uses
  evDocumentPartCursorPair,

  nevBase,
  nevTools
  ;

type
  TevCommentParaCursorPair = class(TevDocumentPartCursorPair)
    protected
    // internal methods
      procedure DeleteBeforeInsert(const aView : InevView;
                                   const anOp: InevOp);
        override;
        {-}
  end;//TevCommentParaCursorPair

implementation

procedure TevCommentParaCursorPair.DeleteBeforeInsert(const aView : InevView;
                                                      const anOp: InevOp);
  //override;
  {-}
begin
 Delete(aView, anOp, ev_cmKeepOne);
end;

end.

