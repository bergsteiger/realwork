////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/rtl/Garant/EVD/Types/Types.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi Low Level::EVD::Types
//
// Базовые типы, используемые форматом EVD.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_DELPHI_LOW_LEVEL_EVD_TYPES_H__
#define __SHARED_DELPHI_LOW_LEVEL_EVD_TYPES_H__

#include "shared/Core/sys/std_inc.h"

namespace EVD {

// Выравнивание объекта по горизонтали.
enum IndentType {
	it_Left // по левому краю.
	, it_Right // по правому краю.
	, it_Center // по центру.
	, it_Width // по ширине.
	, it_Preformatted // "преформатированный".
	, it_None
};

// Ориентация страницы.
enum PageOrientation {
	po_Portrait // книжная.
	, po_Landscape // альбомная.
};

// признак объединения ячеек.
enum MergeStatus {
	ms_None
	, ms_Head
	, ms_Continue
};

// Выравнивание объекта по вертикали.
enum VerticalAligment {
	val_Top
	, val_Center
	, val_Bottom
};

// Тип контрола.
enum ControlType {
	ct_Label // метка с курсором в виде рамки
	, ct_Edit // обычный редактор
	, ct_Combo // выпадающий список
	, ct_Button // кнопка
	, ct_Spinedit // редактор с возможностью редактирования чисел
	, ct_CheckEdit // редактор с CheckBox
	, ct_EllipsesEdit // редактор с кнопкой
	, ct_RadioEdit // редактор с RadioButton
	, ct_CalEdit // редактор с выпадающим календарём
	, ct_CollapsedPanel // сворачивающая панель
	, ct_StateButton // кнопка с изменением состояния
	, ct_EmailEdit // редактор для ввода E-mail адреса (с проверкой)
	, ct_MemoEdit // многострочное поле ввода (не используется)
	, ct_PictureLabel // текст примечания с картинкой
	, ct_TextParaLabel // метка с обычным курсором
	, ct_PhoneEdit
	, ct_Unknown // неизвестный тип контрола
};

// Тип реквизита.
enum ReqKind {
	rk_Simple // обычный реквизит, допускающий редактировани (попадающий в модель) (ev_rkSimple).
	, rk_Context // контекстный атрибут, допускающий редактирование (попадающий в модель)(ev_rkContext).
	, rk_Description // информационный атрибут (НЕ попадает в модель (ev_rkDescription).
};

enum SubPlace {
	sp_NoWhere
	, sp_OnlyInContents
	, sp_InContentsAndOnSubPanel
	, sp_OnlyOnSubPanel
};

static const unsigned long CI_TOPIC = 65537; // для всех ссылок на документы
static const unsigned long CI_BLOB = 65538; // для ссылок на двоичные объекты
static const unsigned long CI_MULT = 65539; // для мультиссылок на документы/двоичные объекты
static const unsigned long CI_REF = 65540; // для ссылок на внешние интернет-ресурсы
static const unsigned long CI_FolderLink = 65544;
static const unsigned long CI_ExternalOperation = 65545;
static const unsigned long CI_PHARM_MULTI = 65547; // для мультиссылок на документы инфарма
static const unsigned long CI_PIC = 65541; // для ссылок на внешние картинки
static const unsigned long CI_SCRIPT = 65552;
static const unsigned long CI_EDITION = 65543;
static const unsigned long CI_SHELL_INTERNAL = 65554; // Ссылки с раскрывающихся блоков и т.п. Не должны передаваться на адаптер. {Requestlink:607263536}

static const long NullAddressType = 0;
static const long defAddressType = CI_TOPIC;

enum LinkViewKind {
	lvk_Unknown // Неизвестно
	, lvk_InternalValid // Внутри системы. Правильная
	, lvk_InternalInvalid // Внутри системы. На отсутствующую информацию
	, lvk_External // Наружу
	, lvk_InternalAbolished // Внутри системы. На утративший силу документ
	, lvk_InternalPreactive // Внутри системы. На не вступивший в силу документ
	, lvk_ExternalENO // Внешнее приложение
	, lvk_InternalEdition // Редакция документа
	, lvk_Script
	, lvk_ShellInternal
};

// Слои меток.
enum SubHandle {
	None
	, Sub
	, Marker
	, Bookmark
	, Mark
};

// Слои меток.
static const unsigned long sbt_None = None; // несуществующий слой меток.
static const unsigned long sbt_Sub = Sub; // слой Sub'ов.
static const unsigned long sbt_Marker = Marker; // слой закладок.
static const unsigned long sbt_Bookmark = Bookmark; // слой именованных закладок (зарезервированно).
static const unsigned long sbt_Mark = Mark; // слой вспомогательных значков (зарезервированно).
static const unsigned long sbt_Para = 10; // параграф (псевдослой).
static const unsigned long sbt_DocumentPlace = 11; // место в документе (псевдослой) см. [TevDocumentPlace].
static const unsigned long sbt_BySearcher = 14; // условие по Searcher'у (псевдослой).

// Место в документе.
enum DocumentPlace {
	dp_None // Нигде.
	, dp_End // В конце.
};

static const long c_UserCommentFlags = 2; // Флаги пользовательских комментариев
static const long c_CommentsFlag = 1; // Флаги комментариев юристов
static const long c_VersionCommentsFlag = 4; // Флаги версионных комментариев

// Тип колонтитула
enum HFType {
	hft_Ordinal
	, hft_Left
	, hft_Right
	, hft_First
};

enum SegmentHandle {
	Superposition
	, View
	, Hyperlinks
	, FoundWords
	, Found
	, Objects
	, Mistakes
	, Diff
};

static const unsigned long POSITION_TYPE_PARA_ID = 2147483648;

enum BlockViewKind {
	bvk_None
	, bvk_Left
	, bvk_Right
};

// Слои сегментов оформления
static const unsigned long sl_Superposition = Superposition; // слой суперпозиции сегментов.
static const unsigned long sl_View = View; // слой оформления.
static const unsigned long sl_Hyperlinks = Hyperlinks; // слой гиперссылок.
static const unsigned long sl_FoundWords = FoundWords; // слой слов найденных по контексту.
static const unsigned long sl_Found = Found; // слой найденных слов (зарезервированно).
static const unsigned long sl_Objects = Objects; // слой объектов, вставленных в параграф.
static const unsigned long sl_Mistakes = Mistakes; // слой сегментов для покраски опечаток.
static const unsigned long sl_Diff = Diff; // Разница двух сравниваемых документов

} // namespace EVD


#endif //__SHARED_DELPHI_LOW_LEVEL_EVD_TYPES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
