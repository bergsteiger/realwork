unit dd_lcSourceUtils;
{ Вспомогательные утилиты  для работы с Исходящим органом }

{ $Id: dd_lcSourceUtils.pas,v 1.17 2015/05/29 11:10:30 fireton Exp $ }
// $Log: dd_lcSourceUtils.pas,v $
// Revision 1.17  2015/05/29 11:10:30  fireton
// - длинные строки должны стоять в начале списка, иначе неправильно
//   опознаются источники
//
// Revision 1.16  2014/12/26 12:58:13  fireton
// - новые арбитражные суды
//
// Revision 1.15  2014/08/21 12:32:26  fireton
// - добавляем Верховный Суд России
//
// Revision 1.14  2014/08/04 11:16:16  fireton
// - распознаём новые названия ФАСов
//
// Revision 1.13  2013/07/19 06:40:04  fireton
// - правильный код Волго-Вятского ФАС
//
// Revision 1.12  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.11  2012/05/11 13:04:33  narry
// Не форматируются документы Югры (363566409)
//
// Revision 1.10  2012/04/12 10:28:10  narry
// Добавление новых судов
//
// Revision 1.9  2012/02/28 07:02:31  narry
// Объединить два диапазона в один (342330845)
//
// Revision 1.8  2012/02/27 10:35:52  narry
// Группа доступа и группа документов для первой инстанции арбитражных судов (341838087)
//
// Revision 1.7  2011/10/21 13:12:39  narry
// Накопившиеся изменения
//
// Revision 1.6  2011/06/17 07:04:34  narry
// Формирование Названия (265388524)
//
// Revision 1.5  2011/06/09 11:56:23  narry
// Проверка документов ФАС при импорте на повторы (268340187)
//
// Revision 1.4  2011/04/11 10:25:01  narry
// Названия для ФАС (259885290)
//
// Revision 1.3  2011/04/01 12:15:54  narry
// 259885188 Справка для ФАС
//
// Revision 1.2  2011/04/01 11:33:27  narry
// 259885596 Группы документов для ФАС
//
// Revision 1.1  2011/04/01 09:07:00  narry
// К259884509.Диапазоны номеров
//


interface

uses dt_Const;

type
 Tdd_lcDossierType = (lc_dtAAC, lc_dtVAC, lc_dtFAC, lc_dtFirst);

 Tdd_lcSource = record
  Name: AnsiString;
  Alias: AnsiString;
  Dossier: Tdd_lcDossierType;
  Base: AnsiString;
 end;

function Source2DossierType(const aSource: AnsiString): Tdd_lcDossierType;

function FindSource(const aSource: AnsiString): Integer;

function Source2Alias(const aSource: AnsiString): AnsiString;

function Alias2Source(const Alias: AnsiString): AnsiString;

function Source2Base(const aSource: AnsiString): AnsiString;

function IsFASAlias(const aAlias: AnsiString): Boolean;

const
 // ВАЖНО! Поскольку поиск соответствия ведётся по окончанию названия источника, необходимо, чтобы строки с большей
 // длиной стояли в списке раньше. Чтобы "Первый арбитражный апелляционный суд" не находился вместо "Двадцать первый
 // арбитражный апелляционный суд"
 lcSources : Array[0..128] of Tdd_lcSource = (
 (Name:'Двадцать первый арбитражный апелляционный суд'; Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLCEO'),
 (Name:'Первый арбитражный апелляционный суд';          Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLVV'),
 (Name:'Второй арбитражный апелляционный суд';          Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLVV'),
 (Name:'Третий арбитражный апелляционный суд';          Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLVSO'),
 (Name:'Четвертый арбитражный апелляционный суд';       Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLVSO'),
 (Name:'Пятый арбитражный апелляционный суд';           Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLDVO'),
 (Name:'Шестой арбитражный апелляционный суд';          Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLDVO'),
 (Name:'Седьмой арбитражный апелляционный суд';         Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLZPS'),
 (Name:'Восьмой арбитражный апелляционный суд';         Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLZPS'),
 (Name:'Девятый арбитражный апелляционный суд';         Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLMO'),
 (Name:'Десятый арбитражный апелляционный суд';         Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLMO'),
 (Name:'Одиннадцатый арбитражный апелляционный суд';    Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLPVL'),
 (Name:'Двенадцатый арбитражный апелляционный суд';     Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLPVL'),
 (Name:'Тринадцатый арбитражный апелляционный суд';     Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLSZO'),
 (Name:'Четырнадцатый арбитражный апелляционный суд';   Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLSZO'),
 (Name:'Пятнадцатый арбитражный апелляционный суд';     Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLSKO'),
 (Name:'Шестнадцатый арбитражный апелляционный суд';    Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLSKO'),
 (Name:'Семнадцатый арбитражный апелляционный суд';     Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLURO'),
 (Name:'Восемнадцатый арбитражный апелляционный суд';   Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLURO'),
 (Name:'Девятнадцатый арбитражный апелляционный суд';   Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLCEO'),
 (Name:'Двадцатый арбитражный апелляционный суд';       Alias:ftnDocIDLawCase; Dossier:lc_dtAAC; base:'APELLCEO'),

 (Name:'(ВАС РФ)';                                    Alias:ftnDocIDVAS;     Dossier:lc_dtVAC; base:'ARB'),
 (Name:'Верховный Суд России';                        Alias:ftnDocIDVAS;     Dossier:lc_dtVAC; base:'ARB'),
 
 (Name:'(ФАС Волго-Вятского округа)';                 Alias:ftnDocIDFAS6;    Dossier:lc_dtFAC; base:'FASVV'),
 (Name:'(ФАС Восточно-Сибирского округа)';            Alias:ftnDocIDFAS2;    Dossier:lc_dtFAC; base:'FASVSO'),
 (Name:'(ФАС Дальневосточного округа)';               Alias:ftnDocIDFAS1;    Dossier:lc_dtFAC; base:'FASDVO'),
 (Name:'(ФАС Западно-Сибирского округа)';             Alias:ftnDocIDFAS3;    Dossier:lc_dtFAC; base:'FASZPS'),
 (Name:'(ФАС Московского округа)';                    Alias:ftnDocIDFAS10;   Dossier:lc_dtFAC; base:'FASMO'),
 (Name:'(ФАС Поволжского округа)';                    Alias:ftnDocIDFAS5;    Dossier:lc_dtFAC; base:'FASPVL'),
 (Name:'(ФАС Северо-Западного округа)';               Alias:ftnDocIDFAS9;    Dossier:lc_dtFAC; base:'FASSZO'),
 (Name:'(ФАС Северо-Кавказского округа)';             Alias:ftnDocIDFAS8;    Dossier:lc_dtFAC; base:'FASSKO'),
 (Name:'(ФАС Уральского округа)';                     Alias:ftnDocIDFAS4;    Dossier:lc_dtFAC; base:'FASURO'),
 (Name:'(ФАС Центрального округа)';                   Alias:ftnDocIDFAS7;    Dossier:lc_dtFAC; base:'FASCEO'),

 (Name:'(АС Волго-Вятского округа)';                  Alias:ftnDocIDFAS6;    Dossier:lc_dtFAC; base:'FASVV'),
 (Name:'(АС Восточно-Сибирского округа)';             Alias:ftnDocIDFAS2;    Dossier:lc_dtFAC; base:'FASVSO'),
 (Name:'(АС Дальневосточного округа)';                Alias:ftnDocIDFAS1;    Dossier:lc_dtFAC; base:'FASDVO'),
 (Name:'(АС Западно-Сибирского округа)';              Alias:ftnDocIDFAS3;    Dossier:lc_dtFAC; base:'FASZPS'),
 (Name:'(АС Московского округа)';                     Alias:ftnDocIDFAS10;   Dossier:lc_dtFAC; base:'FASMO'),
 (Name:'(АС Поволжского округа)';                     Alias:ftnDocIDFAS5;    Dossier:lc_dtFAC; base:'FASPVL'),
 (Name:'(АС Северо-Западного округа)';                Alias:ftnDocIDFAS9;    Dossier:lc_dtFAC; base:'FASSZO'),
 (Name:'(АС Северо-Кавказского округа)';              Alias:ftnDocIDFAS8;    Dossier:lc_dtFAC; base:'FASSKO'),
 (Name:'(АС Уральского округа)';                      Alias:ftnDocIDFAS4;    Dossier:lc_dtFAC; base:'FASURO'),
 (Name:'(АС Центрального округа)';                    Alias:ftnDocIDFAS7;    Dossier:lc_dtFAC; base:'FASCEO'),

 (Name:'Арбитражный суд Алтайского края';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Амурской области';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Архангельской области';                       Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Астраханской области';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Белгородской области';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Брянской области';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Владимирской области';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Волгоградской области';                       Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Вологодской области';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Воронежской области';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд г.Москвы';                                    Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Еврейской автономной области';                Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Ивановской области';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Иркутской области';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Забайкальского края';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Кабардино-Балкарской Республики';             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Калининградской области';                     Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Калужской области';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Камчатского края';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Карачаево-Черкесской Республики';             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Кемеровской области';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Кировской области';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Костромской области';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Краснодарского края';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Красноярского края';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Курганской области';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Курской области';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Липецкой области';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Магаданской области';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Московской области';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Мурманской области';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Нижегородской области';                       Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Новгородской области';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Новосибирской области';                       Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Омской области';                              Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Оренбургской области';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Орловской области';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Пензенской области';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Пермского края';                              Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Приморского края';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Псковской области';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Адыгея';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Алтай';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Башкортостан';                     Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Бурятия';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Дагестан';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Ингушетия';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Калмыкия';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Карелия';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Коми';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Марий Эл';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Мордовия';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Саха (Якутия)';                    Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Северная Осетия - Алания';         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Татарстан';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Тыва';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Хакасия';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Ростовской области';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Рязанской области';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Самарской области';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд г.Санкт-Петербурга и Ленинградской области';  Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Саратовской области';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Сахалинской области';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Свердловской области';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Смоленской области';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Ставропольского края';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Тамбовской области';                          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Тверской области';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Томской области';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Тульской области';                            Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Тюменской области';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Удмуртской Республики';                       Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Ульяновской области';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Хабаровского края';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Ханты-Мансийского автономного округа - Югры'; Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Челябинской области';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Чеченской Республики';                        Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Читинской области';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Чувашской Республики - Чувашии';              Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Чукотского автономного округа';               Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Ямало-Ненецкого автономного округа';          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Ярославской области';                         Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'ПСП Арбитражного суда Пермского края в г.Кудымкаре';          Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд г.Севастополя';                               Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Арбитражный суд Республики Крым';                             Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1'),
 (Name:'Хозяйственный суд Республики Крым';                           Alias:ftnDocID1st;    Dossier:lc_dtFirst; base:'ARBSUD1')
 );

const
 lc_defAlias   = ftnDocIDLawCase;
 lc_defDossier = lc_dtAAC;
 lc_defBase    = 'ARB';

implementation

uses StrUtils, SysUtils, l3Base;

function Source2DossierType(const aSource: AnsiString): Tdd_lcDossierType;
var
 index: Integer;
begin
 index:= FindSource(aSource);
 if index <> -1 then
  Result:= lcSources[index].Dossier
 else
  Result := lc_defDossier;
end;

function FindSource(const aSource: AnsiString): Integer;
var
 i: Integer;
 l_Source: AnsiString;
begin
 Result := -1;
 l_Source:= Trim(aSource);
 for i:= 0 to Length(lcSources)-1 do
  if AnsiEndsText(lcSources[i].Name, l_Source) then
  begin
   Result:= i;
   Break;
  end; // AnsiEndsText(lcSources[i].Name, aSource)
 if Result = -1 then
  l3System.Msg2Log('Неизвестный Исх. орган "%s"', [l_Source]);
end;

function Source2Alias(const aSource: AnsiString): AnsiString;
var
 index: Integer;
begin
 index:= FindSource(aSource);
 if index <> -1 then
  Result:= lcSources[index].Alias
 else
  Result := lc_defAlias;
end;

function Alias2Source(const Alias: AnsiString): AnsiString;
var
 i: Integer;
begin
 Result := '';
 for i:= 0 to Length(lcSources)-1 do
  if AnsiSameText(lcSources[i].Alias, Alias) then
  begin
   Result:= lcSources[i].Name;
   break
  end;
end;

function Source2Base(const aSource: AnsiString): AnsiString;
var
 index: Integer;
begin
 index:= FindSource(aSource);
 if index <> -1 then
  Result:= lcSources[index].Base
 else
  Result := lc_defBase;
end;

function IsFASAlias(const aAlias: AnsiString): Boolean;
begin
 Result := (aAlias = ftnDocIDFAS6) or
           (aAlias = ftnDocIDFAS2) or
           (aAlias = ftnDocIDFAS1) or
           (aAlias = ftnDocIDFAS3) or
           (aAlias = ftnDocIDFAS10) or
           (aAlias = ftnDocIDFAS5) or
           (aAlias = ftnDocIDFAS9) or
           (aAlias = ftnDocIDFAS8) or
           (aAlias = ftnDocIDFAS4) or
           (aAlias = ftnDocIDFAS7);
end;

end.
