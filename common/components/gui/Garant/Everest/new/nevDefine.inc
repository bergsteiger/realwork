{$IfNDef nevDefine}
 {$Define nevDefine}
{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: nevDefine.inc - файл переменных условной компиляции библиотеки }
{ Начат: 31.03.2005 13:10 }
{ $Id: nevDefine.inc,v 1.7 2012/06/05 13:10:55 voba Exp $ }

// $Log: nevDefine.inc,v $
// Revision 1.7  2012/06/05 13:10:55  voba
// no message
//
// Revision 1.6  2010/12/21 09:29:16  lulin
// {RequestLink:248189760}.
//
// Revision 1.5  2009/06/19 12:54:57  lulin
// - переносим TnevAnchor на модель.
//
// Revision 1.4  2008/02/21 19:32:44  lulin
// - убрана вредная директива.
//
// Revision 1.3  2007/12/04 12:47:51  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.2.6.6  2007/09/05 11:57:49  lulin
// - сделана возможность определять проектные директивы в специально отведенном файле.
//
// Revision 1.2.6.5  2006/07/21 05:50:09  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.2.6.4  2006/06/26 14:06:42  mmorozov
// - new: вывод в лог ближайшего координате параграфа;
//
// Revision 1.2.6.3  2006/01/11 14:12:31  mmorozov
// - bugfix: для отицательно смещенных параграфов не правильно вычислялись размеры (cq: 00017579);
//
// Revision 1.2.6.2  2005/06/29 07:49:02  lulin
// - cleanup.
//
// Revision 1.2.6.1  2005/05/18 12:42:59  lulin
// - отвел новую ветку.
//
// Revision 1.1.2.1  2005/04/12 10:18:46  lulin
// - новые файлы переехали в новый каталог.
//
// Revision 1.2.2.2  2005/04/08 15:47:23  lulin
// - под Define _ItsLAW вставлено кеширование индекса параграфа.
//
// Revision 1.2.2.1  2005/04/08 15:23:12  lulin
// - вставлена более правильная директива - чтобы проще было искать по контексту.
//
// Revision 1.2  2005/04/07 17:17:27  lulin
// - new method: InevParaList._IndexOfPara.
//
// Revision 1.1  2005/03/31 09:12:30  lulin
// - добавлено в CVS.
//

{$Include evDefine.inc}

{.$IfDef Archi}
 {.$I ArchiDefine.inc}
{.$EndIf Archi}

{$IfDef UseProjectDefine}
 {$I ProjectDefine.inc}
{$EndIf UseProjectDefine}

{$EndIf nevDefine}
