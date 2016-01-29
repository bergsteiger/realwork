unit evdTxtConst;
{* Константы формата evd. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evdConst -      }
{ Начат: 09.11.1999 15:57 }
{ $Id: evdTxtConst.pas,v 1.2 2007/08/29 14:52:33 lulin Exp $ }

// $Log: evdTxtConst.pas,v $
// Revision 1.2  2007/08/29 14:52:33  lulin
// - не пишем информацию о текстовых скобках.
//
// Revision 1.1  2007/08/29 12:00:33  lulin
// - константы распилены на два файла.
//
// Revision 1.3  2006/01/27 11:00:49  lulin
// - bug fix: при выравнивании куска пямяти не читался EVD, т.к. в конце был мусор (CQ OIT5-19345).
//
// Revision 1.2  2005/07/21 11:41:21  lulin
// - убраны лишние зависимости.
//
// Revision 1.1  2005/06/23 12:55:39  lulin
// - файл с константами переехал в папку EVD.
//
// Revision 1.31  2002/09/18 09:33:26  law
// - new behavior: при записи в evd-binary опускаем тип дочернего тега по умолчанию.
//
// Revision 1.30  2002/09/18 07:08:02  law
// - new units: k2StackGenerator, k2Ver.
// - new behavior: Tk2CustomReader теперь наследуется от Tk2CustomStackGenerator и соответственно наследует его поведение.
//
// Revision 1.29  2001/10/23 08:14:46  law
// - new const: idLink.
//
// Revision 1.28  2001/09/04 16:47:26  law
// - comments: xHelpGen.
//
// Revision 1.27  2001/05/31 07:43:14  law
// - new version: к строке таблицы временно вернул свойство Frame.
//
// Revision 1.26  2001/05/30 12:19:42  law
// - new version: у строки таблицы убрано свойство k2_tiFrame.
//
// Revision 1.25  2001/02/23 13:44:26  law
// - к текстовому параграфу добавлено свойство AllowHyphen.
//
// Revision 1.24  2001/01/25 13:54:53  law
// - к интерфейсу IedParagraphFormatting добавлено свойство FirstIndent.
//
// Revision 1.23  2001/01/24 14:53:43  law
// - сделано более компактное сохранение имен шрифтов
//
// Revision 1.22  2000/12/15 15:10:35  law
// - вставлены директивы Log.
//

{$Include evdDefine.inc }

interface

uses
  l3Chars
  ;

const
  evDirectivePrefix    = cc_PercentSign;
    {* - префикс директивы. }
  evRollbackPrefix     = cc_Tilda;
    {* - префикс отката тега. }
  evTransparentToken   = '@';
    {* - признак прозрачности тега. }

  evdOpenBracket = '{';
    {-}
  evdCloseBracket = '}';
    {-}

implementation

end.

