unit eeExceptions;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeExceptions -  }
{ Начат: 20.10.2003 19:43 }
{ $Id: eeExceptions.pas,v 1.1 2015/01/20 11:54:23 lulin Exp $ }

// $Log: eeExceptions.pas,v $
// Revision 1.1  2015/01/20 11:54:23  lulin
// - правим зависимости.
//
// Revision 1.1  2014/12/09 14:16:03  kostitsin
// {requestlink: 580710238 }
//
// Revision 1.3  2004/07/21 10:32:57  law
// - new behavior: при попытке вставки комментария при выключенных комментариях кидаем исключение EeeUserCommentsHidden.
// - new behavior: запрещаем Drag'n'Drop в редактор при выключенных комментариях.
//
// Revision 1.2  2003/10/30 11:51:44  law
// - bug fix: не всегда проверялась возможность вставки параграфа.
//
// Revision 1.1  2003/10/20 16:02:03  law
// - change: начата поддержка "листьевых" параграфов.
// - new behavior: задел на неудаление параграфом (картинок в частности).
//

{$I evDefine.inc }

interface

uses
  evExcept
  ;

type
  EeeCannotDeletePara = class(EevReadOnly);  
  EeeCannotInsertPara = class(EevReadOnly);
  EeeUserCommentsHidden = class(EevReadOnly);

implementation

end.

