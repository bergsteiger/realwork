unit k2InternalInterfaces;
{* Внутренние интерфейсы библиотеки К-2. }

{ Библиотека "K-2"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2InternalInterfaces - }
{ Начат: 27.09.1999 12:58 }
{ $Id: k2InternalInterfaces.pas,v 1.41 2014/04/29 13:38:56 lulin Exp $ }

// $Log: k2InternalInterfaces.pas,v $
// Revision 1.41  2014/04/29 13:38:56  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.40  2014/03/18 09:59:12  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.39  2007/08/10 14:44:46  lulin
// - cleanup.
//
// Revision 1.38  2005/11/15 08:02:45  lulin
// - чтение/запись документа практически польностью перенесены с TextSource на контейнер документа.
//
// Revision 1.37  2005/07/14 18:04:38  lulin
// - bug fix: в отсутствии "настоящего" TextSource не дочитывался документ при построении Preview.
//
// Revision 1.36  2005/04/28 15:04:09  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.35.4.1  2005/04/23 16:07:35  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.35  2005/03/28 12:42:35  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.34  2005/03/28 11:32:28  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.33  2005/03/09 19:06:09  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.32  2005/03/09 17:29:09  lulin
// - от Tk2AtomR переходим к Ik2TagWrap.
//
// Revision 1.31  2005/03/09 13:47:16  lulin
// - bug fix: проеб со счетчиком ссылок на объекты внутри документа, в результате которого в частности "разъезжался" текст (CQ OIT5-12595).
//
// Revision 1.30  2004/11/09 13:37:59  lulin
// - переходим от классов к интерфейсам.
//
// Revision 1.29  2004/11/04 17:43:46  lulin
// - new interface: _Ik2TypeTable.
//
// Revision 1.28  2004/09/27 11:32:54  lulin
// - new method: Im3DB.SingleDocument.
//
// Revision 1.27  2004/06/29 14:58:13  law
// - new interface: Ik2TagBox.
//
// Revision 1.26  2004/06/29 14:26:52  law
// - избавляемся от метода Tk2AtomR._Set.
//
// Revision 1.25  2004/06/03 17:15:47  law
// - new interface: _Ik2Base.
//
// Revision 1.24  2002/03/26 16:31:57  law
// - cleanup.
//
// Revision 1.23  2001/06/06 08:28:51  law
// - comments: xHelpGen.
//
// Revision 1.22  2001/02/28 13:15:03  law
// - расширен интерфейс Ik2PropertyBag.
//
// Revision 1.21  2001/02/20 10:23:52  law
// - some tuning
//
// Revision 1.20  2000/12/15 15:18:58  law
// - вставлены директивы Log.
//

{$Include k2Define.inc }

interface

uses
  l3Filer,

  k2Interfaces
  ;

type
  Ik2FilerSource = Il3FilerSource;

  Ik2FilerSource2 = interface(Ik2FilerSource)
    ['{A093526B-2DAF-4FB6-9BF6-71E8F457D414}']
  end;//Ik2FilerSource2

implementation

end.

