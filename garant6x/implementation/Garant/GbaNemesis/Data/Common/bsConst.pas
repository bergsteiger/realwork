unit bsConst;

{------------------------------------------------------------------------------}
{ Библиотека : Бизнес слой проекта "Немезис";                                  }
{ Автор      : Морозов М.А;                                                    }
{ Начат      : 28.09.2005 22.24;                                               }
{ Модуль     : bsConst                                                         }
{ Описание   : Общие общие константы бизнес слоя.                              }
{------------------------------------------------------------------------------}

// $Id: bsConst.pas,v 1.5 2012/10/03 10:37:50 kostitsin Exp $
// $Log: bsConst.pas,v $
// Revision 1.5  2012/10/03 10:37:50  kostitsin
// [$398276179]
//
// Revision 1.4  2012/09/11 14:31:17  kostitsin
// [$388859236] - иконка ЭР в списках
//
// Revision 1.3  2012/08/28 09:34:17  lulin
// - прибираемся за коллегами.
//
// Revision 1.2  2011/02/08 14:24:38  lulin
// {RequestLink:252522068}.
//
// Revision 1.1  2009/09/14 11:28:52  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.23  2009/07/31 17:29:53  lulin
// - убираем мусор.
//
// Revision 1.22  2008/03/24 08:43:18  oman
// - new: Заготовки для типизации узлов списка мед. препаратов
//
// Revision 1.21  2008/03/21 08:42:16  oman
// - new: Заголовка для типизации узлов списка лекарственных препаратов
//
// Revision 1.20  2008/03/19 19:51:39  lulin
// - bug fix: не собирался F1.
//
// Revision 1.19  2008/01/10 07:23:00  oman
// Переход на новый адаптер
//
// Revision 1.17.4.3  2007/11/28 15:56:45  mmorozov
// - MERGE WITH HEAD;
//
// Revision 1.17.4.2  2007/11/26 09:03:55  oman
// Перепиливаем на новый адаптер
//
// Revision 1.17.4.1  2007/11/21 10:26:15  oman
// Перепиливаем на новый адаптер
//
// Revision 1.18  2007/11/28 15:49:40  mmorozov
// - bugfix: неправильно определяли типы элементов (папка | не папка) (CQ: OIT5-27615);
//
// Revision 1.17  2007/06/27 05:46:19  mmorozov
// - new: добавил другие бизнес справки в перечислимый тип папок дерева навигатора (CQ: OIT5-25413);
//
// Revision 1.16  2007/04/10 12:38:25  mmorozov
// - new: использование новых идентификаторов элементов навигатора (CQ: OIT5-24602);
//
// Revision 1.15  2007/03/05 11:31:14  oman
// - fix: Группу выделяем по флагу (cq23879)
//
// Revision 1.14  2006/07/05 07:51:19  mmorozov
// - new: профайлеры прецедентов;
//
// Revision 1.13  2006/06/23 11:31:29  mmorozov
// - new: замеры времени открытия документа;
//
// Revision 1.12  2006/05/02 13:56:38  mmorozov
// - работы связанные с редактированием фильтров;
//
// Revision 1.11  2006/04/17 07:18:42  oman
// - change: Избавляем бизнес-объекты (слой модели) от обязательств
//  контроллера (хинты, imageindex)
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.10  2006/04/04 14:03:33  oman
// - new beh: Перевод на механизм мап "строка для отображения в UI"-<нечто>.
//
// Revision 1.9  2006/03/15 14:12:58  oman
// - new beh: Перекладываем все текстовые константы в два места (StdStr и DebugStr)
//
// Revision 1.8  2005/11/24 16:50:39  mmorozov
// new: реализация списка литературы для толкового словаря (cq: 00012546);
//
// Revision 1.7  2005/11/23 13:24:07  demon
// - fix: изменены формулировки предупреждений о ненайденных СКР
//
// Revision 1.6  2005/10/19 14:36:43  mmorozov
// cleanup: вычищены не используемые адаптером типы/интерфейсы;
//
// Revision 1.5  2005/10/19 09:49:48  mmorozov
// - add comments;
//
// Revision 1.4  2005/10/19 09:28:10  mmorozov
// change: переименована сортировка по релевантности;
// change: константы переехали из dsList в bsConst;
//
// Revision 1.3  2005/10/12 09:27:38  demon
// - new behavior: переименованы корреспонденты/респонденты в сообщениях
//
// Revision 1.2  2005/09/29 10:12:31  mmorozov
// new: открытие документа в новом/текущем окне;
//
// Revision 1.1  2005/09/28 18:33:08  mmorozov
// - правки связанные с сортировкой списка;
//

interface

uses
  BaseTypesUnit,
  DynamicDocListUnit,
  
  bsTypes
  ;

const
///// Типы ссылок //////////////////////////////////////////////////////////////
  bs_hidConsultationMark = 101;
    // - ссылка на оценку консультации
///// Толковый словарь /////////////////////////////////////////////////////////
  c_LiteratureListForDictionary = 3984056;
    {* - документ со списком литературы для толкового словаря. }
///// Константы для работы со списком //////////////////////////////////////////
  cMin_CR_List_Count    = 5;
    {* - количество документов, при котором происходит анализ наличия документов
         в отсутствующих блоках. }

  cDocumentSet: set of TbsListNodeType = [
  {* Типы относящиеся к документу. }
    lntDocActive,
    lntDocPreactive,
    lntDocAbolished,
    lntRedaction,
    lntBlock,
    lntDrugAnnuled,
    lntDrugNarcotic,
    lntDrugNoAnnuledNoNarcoric,
    lntFormAnnuled,
    lntFormRussianImportant,
    lntFormNoRussianImportant,
    lntFormRussianNoImportant,
    lntFormNoRussianNoImportant,
    lntAAC
  ];

  cbsListNodeTypeMap: array [TListNodeType] of TbsListNodeType = (
  {* Типы списка }
    lntBlock,                   // LNT_SUB //
    lntBlock,                   // LNT_PARA //
    lntExternalObject,          // LNT_EXTERNAL_OBJECT //
    lntExternalLink,            // LNT_EXTERNAL_LINK //
    lntDocAbolished,            // LNT_DOCUMENT_ABOLISHED //
    lntDocActive,               // LNT_DOCUMENT_ACTIVE //
    lntDocPreActive,            // LNT_DOCUMENT_PREACTIVE //
    lntDocActive,               // LNT_DOCUMENT_UNKNOWN //
    lntRedaction,               // LNT_EDITION_ABOLISHED //
    lntRedaction,               // LNT_EDITION_ACTIVE //
    lntRedaction,               // LNT_EDITION_PREACTIVE //
    lntRedaction,               // LNT_EDITION_UNKNOWN //
    lntRedactions,              // LNT_EDITIONS_GROUP //
    lntBlock,                   // LNT_BLOCK //
    lntDrugAnnuled,             // LNT_DRUG_ANNULED // препарат аннулирован
    lntDrugNarcotic,            // LNT_DRUG_NARCOTIC // наркотический препарат
    lntDrugNoAnnuledNoNarcoric, // LNT_DRUG_NONANNULED_NONNARCOTIC // разрешённый ненаркотический препарат
    lntFormAnnuled,             // LNT_FORM_ANNULED // аннулированная форма препарата
    lntFormRussianImportant,    // LNT_FORM_RUSSIAN_IMPORTANT // жизненноважный российский препарат
    lntFormNoRussianImportant,  // LNT_FORM_NONRUSSIAN_IMPORTANT // жизненноважный иностранный препарат
    lntFormRussianNoImportant,  // LNT_FORM_RUSSIAN_NONIMPORTANT // российский препарат
    lntFormNoRussianNoImportant,// LNT_FORM_NONRUSSIAN_NONIMPORTANT // иностранный препарат
    lntMedicFirm,
    lntAAC                      // LNT_AAK // Энциклопедия решений
  );

////////////////////////////////////////////////////////////////////////////////

implementation

end.