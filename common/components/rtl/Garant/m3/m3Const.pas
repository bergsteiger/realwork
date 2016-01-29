unit m3Const;

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3Const -       }
{ Начат: 24.01.2002 18:05 }
{ $Id: m3Const.pas,v 1.4 2014/12/08 12:42:59 lulin Exp $ }

// $Log: m3Const.pas,v $
// Revision 1.4  2014/12/08 12:42:59  lulin
// - рисуем на модели.
//
// Revision 1.3  2014/08/19 14:25:53  lulin
// - чистим код.
//
// Revision 1.2  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.1  2004/09/02 08:09:47  law
// - cleanup.
//
// Revision 1.2  2004/08/31 15:11:14  law
// - bug fix: заточка для выливки в NSRC псевдографики странным образом сказалась на работоспособности хранилища (не опознавались индексные файлы).
// - bug fix: неправильно удалялись документы из индекса.
//
// Revision 1.1  2002/01/24 16:30:24  law
// - new behavior: сделан доступ по индексу к элементам хранилища.
//

{$I m3Define.inc}

interface

const
 m3IndexPrefix = #31;
 m3IndexPrefixFormatStr = m3IndexPrefix + '%.10d';
 m3UnicodeIndexPrefix = #$25BC;

const
  CAnyGUIDLength = Length(AnsiString('{00000000-0000-0000-0000-000000000000}'));

  Cm3BasClaDefHeaderSize = 128-(8+CAnyGUIDLength);

implementation

end.

