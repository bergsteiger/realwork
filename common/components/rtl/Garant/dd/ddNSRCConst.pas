unit ddNSRCConst;

{ $Id: ddNSRCConst.pas,v 1.43 2015/09/29 13:58:04 voba Exp $ }

// $Log: ddNSRCConst.pas,v $
// Revision 1.43  2015/09/29 13:58:04  voba
// -k:608012012
//
// Revision 1.42  2015/08/27 11:01:49  lulin
// {RequestLink:605842696}
// - вычищаем.
//
// Revision 1.41  2013/07/11 13:40:17  voba
// - K:463114395
//
// Revision 1.40  2013/01/28 12:48:40  narry
// Поправить экспорт_импорт что бы выливался !KIND вместо !PREFIX (425040214)
//
// Revision 1.39  2012/06/07 10:39:31  narry
// Новые пользовательские типы документов "Общая структура ААК" и "ААК - содержание" (365831611)
//
// Revision 1.38  2012/06/06 14:18:35  narry
// "Правые" и "левые" блоки для ААК (365831635)
//
// Revision 1.37  2012/01/31 06:37:10  narry
// Экспорт(импорт) !COMPARECONTENTS (332563861)
//
// Revision 1.36  2012/01/26 07:56:26  fireton
// - команда !*HANG (K 330696104)
//
// Revision 1.35  2011/12/21 14:45:08  fireton
// - новая команда !*INTERNET (К 321986367)
//
// Revision 1.34  2010/05/07 07:03:59  narry
// - поддержка команды !LEFTINDENT
//
// Revision 1.33  2010/04/30 14:11:29  narry
// - починка ошибок преобразования плюс->классик
//
// Revision 1.32  2010/04/06 12:23:27  narry
// - чистка кода
// - поддержка команды !ZOOM и нового параметра команды !STYLE
//
// Revision 1.31  2010/02/15 10:28:12  narry
// - поддержка команды !NOCOMPARE
//
// Revision 1.30  2009/09/11 11:18:18  narry
// - промежуточное обновление
//
// Revision 1.29  2009/03/31 09:02:55  fireton
// - импорт/экспорт атрибута "Комментарий к документу" [$121164344]
//
// Revision 1.28  2009/02/20 13:27:54  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//
// Revision 1.27  2009/01/13 16:19:14  narry
// - татары
//
// Revision 1.26  2008/10/21 12:47:54  narry
// - поддержка NSRC+
//
// Revision 1.25  2008/09/23 12:17:48  fireton
// - импорт/экспорт номера судебного дела
//
// Revision 1.24  2008/09/22 13:25:29  narry
// - Поддержка команды !STYLEA
//
// Revision 1.23  2008/09/17 14:47:45  fireton
// - новая версия базы (130)
// - срочность документа
//
// Revision 1.22  2008/06/10 10:55:19  fireton
// - поддержка Flash-документов
//
// Revision 1.21  2008/05/07 06:07:44  voba
// - Refact. Убрал "magic number"
//
// Revision 1.20  2008/03/21 17:30:41  narry
// - поддержка PNG для ObjTopic
//
// Revision 1.19  2008/02/20 12:06:14  narry
// - поддержка команды !ARCHICHECK
//
// Revision 1.18  2007/06/25 12:19:28  narry
// - поддержка команды !SERVICEINFO
//
// Revision 1.17  2006/12/01 11:21:17  voba
// - add kwdLog         = 'LOG';
//
// Revision 1.16  2006/10/03 11:48:12  narry
// - поддержка команды IZM
//
// Revision 1.15  2005/12/01 13:04:13  narry
// - обновление: новый аннокласс
//
// Revision 1.14  2005/09/16 12:42:01  narry
// - обновление: поддержка команды BOOK
//
// Revision 1.13  2005/03/28 14:36:20  narry
// - update: изменение формулировок
//
// Revision 1.12  2005/02/16 17:11:14  narry
// - update: поддержка Аннотаций
//
// Revision 1.11  2004/07/23 14:59:53  narry
// - new: поддержка команды !NOTTM
//
// Revision 1.10  2004/04/29 13:20:03  narry
// - new: поддержка команды !TERM
//
// Revision 1.9  2004/03/09 11:34:12  narry
// - new: поддержка команды !NOTSURE
//
// Revision 1.8  2004/03/05 15:04:46  narry
// - update: поддержка команды !CONTENTS
//
// Revision 1.7  2003/08/22 09:05:22  narry
// - new: поддержка команды !CHDATE
//
// Revision 1.6  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.5  2003/03/14 09:55:35  narry
// - new: команды версионности. Компиляется, но не работает.
//
// Revision 1.4  2003/01/16 14:51:22  narry
// - new behavior: поддержка версионности блоков
//
// Revision 1.3  2002/04/02 13:46:19  narry
// - new behavior: поддержка команды !REFDOC
//
// Revision 1.2  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.1  2001/05/07 10:45:15  narry
// First upload - изменено имя модуля
//
// Revision 1.9  2001/04/27 09:16:21  narry
// Add - команда !DIVISION
//
// Revision 1.8  2001/01/19 13:36:29  narry
// no message
//
// Revision 1.7  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

uses
  evNSRCConst
  ;

const
  { Константы PriceLevel }
  prclvlNormal = 0;
  prclvlFree   = 1;
  prclvl_nNormal = 'NORMAL';
  prclvl_nFree   = 'FREE';

const
  cDefParaWidth = 73;

(*const
  { Константы ObjType }
  objtPIC = 1;
  objtRTF = 2;*)
(*
const
  charWhiteSmile = #1; // Цветовое выделение
  charBlackSmile = #2; // Продолжение ссылки
  charHearts     = #3; // Комментарий
  charDiamonds   = #4; // Ссылка
  charClubs      = #5; // Невидимый
  charSpades     = #6; // Утративший силу
*)
const
  kwdTopic       = 'TOPIC';
  kwdStyle       = 'STYLE';
  kwdSub         = 'SUB';
  kwdName        = 'NAME';
  kwdSource      = 'SOURCE';
  kwdType        = 'TYPE';
  kwdKeywords    = 'KEYWORDS';
  kwdBelongs     = 'BELONGS';
  kwdWarning     = 'WARNING';
  kwdClass       = 'CLASS';
  kwdSuffix      = 'SUFFIX';
  kwdDoc         = 'DOC';
  kwdNoDoc       = 'NODOC';
  kwdCalendar    = 'CALENDAR';
  kwdBusiness    = 'BUSINESS';
  kwdUserInfo    = 'USERINFO';
  kwdDate        = 'DATE';
  kwdRDate       = 'RDATE';
  kwdGDDate      = 'GDDATE';
  kwdSFDate      = 'SFDATE';
  kwdSFCode      = 'SFCODE';
  kwdGDCode      = 'GDCODE';
  kwdRCode       = 'RCODE';
  kwdCode        = 'CODE';
  kwdAddCode     = 'ADDCODE';
  kwdVIncluded   = 'VINCLUDED';
  kwdVChanged    = 'VCHANGED';
  kwdVAbolished  = 'VABOLISHED';
  kwdVLControl   = 'VLCONTROL';
  kwdRelated     = 'RELATED';
  kwdBlock       = 'BLOCK';
  kwdBlockEnd    = 'BLOCKEND';
  kwdPriority    = 'PRIORITY';
  kwdSortDate    = 'SORTDATE';
  kwdNoActive    = 'NOACTIVE';
  kwdRel         = 'REL';
  kwdStage       = 'STAGE';
  kwdCheck       = 'CHECK';
  kwdPublishedIn = 'PUBLISHEDIN';
  kwdPrefix      = 'PREFIX';
  kwdTerritory   = 'TERRITORY';
  kwdNorm        = 'NORM';
  kwdPreactive   = 'PREACTIVE';
  kwdMOJNotReg   = 'MOJNOTREG';
  kwdObjPath     = 'OBJPATH';
  kwdObjTopic    = 'OBJTOPIC';
  kwdFlashTopic  = 'FLASHTOPIC';
  kwdObjType     = 'OBJTYPE';
  kwdPriceLevel  = 'PRICELEVEL';
  kwdTable       = 'TABLE';
  kwdSubKW       = 'SUBKW';
  kwdRevision    = 'REVISION';
  kwdVAnonced    = 'VANONCED';
  kwdClass_4x    = 'CLASS_4X';
  kwdDivision    = 'DIVISION';
  kwdMain        = 'MAIN';
  kwdRefDoc      = 'REFDOC';

  {Добавления для версионности}
  kwdEdition     = 'EDITION';
  kwdActive      = 'ACTIVE';
  kwdAlarm       = 'ALARM';
  kwdVerLink     = 'VERLINK';
  kwdChDate      = 'CHDATE';
  kwdCasecode    = 'CASECODE';

  kwdContents    = 'CONTENTS';
  kwdNotSure     = 'NOTSURE';
  kwdTerm        = 'TERM';
  kwdNotTM       = 'NOTTM';
  kwdInternet    = 'INTERNET';
  kwdHang        = 'HANG';

  { Аннотации }
  kwdAnnoTopic        = 'ANNOTOPIC';
  kwdAnnoName         = 'ANNONAME';
  kwdAnnoDate         = 'ANNODATE';
  kwdAnnoUser         = 'ANNOUSER';
  kwdAnnoOrganization = 'ANNOORGANIZATION';
  kwdAnnoTax          = 'ANNOTAX';
  kwdAnnoInterest     = 'ANNOINTEREST';
  kwdAnnoKind         = 'ANNOKIND';
  kwdAnnoImportant    = 'ANNOIMPORTANT';
  kwdAnnoSignificant  = 'ANNOSIGNIFICANT';

  kwdBook        = 'BOOK';
  kwdIzm         = 'IZM';
  kwdLog         = 'LOG';

  kwdServiceInfo = 'SERVICEINFO';

  kwdArchiCheck  = 'ARCHICHECK';

  kwdSTYLEA      = 'STYLEA';
  kwdUrgency     = 'URGENCY';
  kwdNameComment = 'NAMECOMMENT';
  {NSRC+}
  kwdTableEnd    = 'TABLEEND';
  kwdRow         = 'ROW';
  kwdRowEnd      = 'ROWEND';
  kwdCell        = 'CELL';
  kwdCellEnd     = 'CELLEND';
  {Татары}
  kwdLanguage    = 'LANGUAGE';
  {Связи между документами}
  kwdChange      = 'CHANGE';

  kwdCaseDoc     = 'CASEDOC';

  kwdNOCOMPARE   = 'NOCOMPARE';

  kwdZoom        = 'ZOOM';
  kwdLeftIndent  = 'LEFTINDENT';

  kwdCompareContents = 'COMPARECONTENTS';

  kwdBlockData    = 'BLOCKDATA';

  kwdDocType      = 'DOCTYPE';

  kwdKind         = 'KIND';

(*const
  num_kwdUnknown     = 0;
  num_kwdTopic       = 1;
  num_kwdStyle       = 2;
  num_kwdSub         = 3;
  num_kwdName        = 4;
  num_kwdSource      = 5;
  num_kwdType        = 6;
  num_kwdKeywords    = 7;
  num_kwdBelongs     = 8;
  num_kwdWarning     = 9;
  num_kwdClass       = 10;
  num_kwdSuffix      = 11;
  num_kwdDoc         = 12;
  num_kwdNoDoc       = 13;
  num_kwdCalendar    = 14;
  num_kwdBusiness    = 15;
  num_kwdUserInfo    = 16;
  num_kwdDate        = 17;
  num_kwdRDate       = 18;
  num_kwdGDDate      = 19;
  num_kwdSFDate      = 20;
  num_kwdSFCode      = 21;
  num_kwdGDCode      = 22;
  num_kwdRCode       = 23;
  num_kwdCode        = 24;
  num_kwdVIncluded   = 25;
  num_kwdVChanged    = 26;
  num_kwdVAbolished  = 27;
  num_kwdVLControl   = 28;
  num_kwdRelated     = 29;
  num_kwdBlock       = 30;
  num_kwdBlockEnd    = 31;
  num_kwdPriority    = 32;
  num_kwdSortDate    = 33;
  num_kwdNoActive    = 34;
  num_kwdRel         = 35;
  num_kwdStage       = 36;
  num_kwdCheck       = 37;
  num_kwdPublishedIn = 38;
  num_kwdPrefix      = 39;
  num_kwdTerritory   = 40;
  num_kwdNorm        = 41;
  num_kwdPreactive   = 42;
  num_kwdMOJNotReg   = 43;
  num_kwdObjPath     = 44;
  num_kwdObjTopic    = 45;
  num_kwdObjType     = 46;
  num_kwdPriceLevel  = 47;
  num_kwdTable       = 48;
  num_kwdSubKW       = 49;
  num_kwdRevision    = 50;
  num_kwdVAnonced    = 51;
  num_kwdDivision    = 52;
  num_kwdMain        = 53;
  num_kwdRefDoc      = 54;
  num_kwdEdition     = 55;
  num_kwdActive      = 56;
  num_kwdAlarm       = 57;
  num_kwdVerLink     = 58;
  num_kwdChDate      = 59;
  num_kwdContents    = 60;
  num_kwdNotSure     = 61;
  num_kwdTerm        = 62;
  num_kwdNotTM       = 63;
  num_kwdAnnoTopic   = 64;
  num_kwdANNONAME    = 65;
  num_kwdANNODATE    = 66;
  num_kwdAnnoUser    = 67;
  num_kwdAnnoOrganization = 68;
  num_kwdAnnoTax          = 69;
  num_kwdAnnoInterest     = 70;
  num_kwdAnnoKind         = 71;
  num_kwdBook             = 72;
  num_kwdAnnoImportant    = 73;
  num_kwdIzm              = 74;
  num_kwdLog              = 75;
  num_kwdServiceInfo      = 76;
  num_kwdArchiCheck       = 77;
  num_kwdStyleA           = 78;
  num_kwdUrgency          = 79;
  num_kwdTableEnd         = 80;
  num_kwdRow              = 81;
  num_kwdRowEnd           = 82;
  num_kwdCell             = 83;
  num_kwdCellEnd          = 84;
  num_kwdLanguage         = 85;
  num_kwdChange           = 86;
  num_kwdCaseDoc          = 87;
  num_kwdNoCompare        = 88;
  num_kwdZoom             = 89;
  num_kwdLeftIndent       = 90;
  num_kwdCompareContents  = 91;
  num_kwdBlockData        = 92;
  num_kwdDocType          = 93;
  num_kwdKind             = 94;*)

const
  class_AnnoUser  = 'Ваша профессия\';
  class_AnnoOrganization = 'Специфика Вашей организации\';
  class_AnnoTax = 'Особенности налогообложения\';
  class_AnnoInterest = 'Сфера интересов\';
  class_AnnoKind = 'Вид информации\';
  class_AnnoImportant = 'Важность\';
  class_AnnoSignificant = 'Самые значимые документы\';

(*const
 // 0 - картинка, 1 - внешний документ, 2 - просто данные
 otGraphic = 0;
 otExtDoc = 1;
 otBinary = 2;

type
 TObjType = otGraphic..otBinary;

const
 ObjTypeArr : array[TObjType] of String =
  ('.BMP;.PNG',
   '.RTF;.DOC;.PDF',
   '');*)

implementation

end.
