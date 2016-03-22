/*
 *
 * cvs id was here
 * Generic Garant defines & structures
 *
 */

#ifndef	__GARANT_DEFINES__
#define	__GARANT_DEFINES__

#include "garantPIL/implementation/component/cpp/include/osdep.h"

#ifdef VERSION61
	#ifndef MULTI_INDEX_STREAM_FILE
		#define MULTI_INDEX_STREAM_FILE
	#endif
	#if !defined(INSTLL_CIB) && !defined(BRDR32) && !defined(MAKE_HDD)
		#define INSTLL_CIB
	#endif
	#ifndef STORE_FORM_N
		#define STORE_FORM_N
	#endif
	#ifndef KERNEL_NOT_USE_CONTEXT
		#define KERNEL_NOT_USE_CONTEXT
	#endif
  #ifndef KERNEL_NOT_USE_CONTEXT
	#ifndef QUICK_NEW_DOC
		#define QUICK_NEW_DOC
	#endif
	#ifndef ONLY_NORM_INDEX
		#define ONLY_NORM_INDEX
	#endif
	#ifndef MIN_MEM_CONTEXT
		#define MIN_MEM_CONTEXT
	#endif
  #endif
	#ifndef VERSION56
		#define VERSION56
	#endif
	#ifndef BLOCKSINHERIT
		#define BLOCKSINHERIT
	#endif
	#ifndef OPT_PACK_MPCXC
		#define OPT_PACK_MPCXC
	#endif
	#ifndef NEMESIS
		#define NEMESIS
	#endif
	#define IDD2_PARAIDS	0x25
	#define	IDD2_NAME	0x01
#else
	#define	IDD_NAME	0x01	/* ASCIIZ string with documents full name */
	#define IDD_PARAIDS	0x25
	#define IDD2_PARAIDS	0x25
#endif

static const unsigned long GKDB_POS_HEADER = 2;
static const unsigned long GKDB_POS_INVISIBLE_BLOCK = 3;
static const unsigned long GKDB_POS_INVISIBLE = 1;
static const unsigned long GKDB_POS_FLAGS = 3;

#define ID_BORDER       100000l  /* Topic with ID > ID_BORDER is not GL topic */
#define	ID_ANNOPLUS     1000000000l
#define	ID_TRANSPLUS	500000000l
#define ID_WWWDOC       100104l

#define	BIG_INFO_DOC	5734000 + ID_BORDER
#define	BIG_INFO_COUNT	2000
#define	BIG_INFO_STEP	50000
#define	BIG_INFO_DELIMITER	'і'

#define MAX_DOC_NAME	800	// maximum doc's name
#define HISTORY_DEPTH	 12	// info about 4 last weeks, last week in days
#define HISTORY_INTERVAL 7	// weekly history
#define MAX_MULTI       ( ( MAX_PARA_LEN - 100 ) / sizeof ( Ref ) )
//
// predefined topics numbers
//
#define MAINMENU 1	// predefined topic for documents
#define ALTMENU	 2	// predefined topic for chronology
#define NEWMENU	 3	// predefined topic for new documents
#define COMMENU	 4	// predefined topic for comments
#define FORMENU	 5	// predefined topic for forms
#define CALMENU	 6	// predefined topic for calendar
#define BUSMENU 7	// predefined topic for biznes-spravka 
#define USERMENU 8	// predefined topic for user info
#define PROJMENU 9	// predefined topic for law projects
#define PRAKMENU 10	// predefined topic for "sudebnaja praktika"
#define INTMENU  11	// predefined topic for international documents
#define BREFMENU 12	// predefined topic for buisness references
#define QUESMENU 13	// predefined topic for q&a
#define PUBLISHEDMENU	14	// predefined topic for published in
#define FASTDICIDX	15	// predefined topic for fast dictionary index
#define ALLMENU	16	// predefined topic for q&a

#define	ID_CONSULTING_XML 53 + ID_BORDER
#define	ID_FLASH_LO	5421001 + ID_BORDER
#define	ID_FLASH_HI	5471000 + ID_BORDER

#define	ID_DIC_LO	3700000 + ID_BORDER
#define	ID_DIC_HI	3799999 + ID_BORDER

#define	DOC_TIP_OF_THE_DAY_LOW	5362601 + ID_BORDER
#define	DOC_TIP_OF_THE_DAY_HI	5362700 + ID_BORDER
#define DOC_TIP_OF_THE_DAY	5362700 + ID_BORDER

#define	SBRF_LOW_ID	12205001 + ID_BORDER
#define	SBRF_HI_ID	12405000 + ID_BORDER

#define	AUX_CLASS6_CODEX	"c6co"
#define	AUX_CLASS6_CALENDAR	"c6ca"
#define	AUX_CLASS6_MSFORMS	"c6ms"
#define	AUX_CLASS6_OTHER_BUS	"c6ob"
#define	AUX_CLASS6_MONITORING	"c6mo"
#define	AUX_CLASS6_HOTINFO	"c6hi"
#define	AUX_CLASS6_NEWDOCS	"c6nd"
#define	AUX_CLASS6_NAVIGATOR	"c6na"
#define	AUX_CLASS6_SERVICEINFO	"c6si"
#define	AUX_CLASS6_BUSINESS_REFERENCES "c6ab"

#define	AUX_CLASS6_TAXFINANCE	 "c6nf"
#define	AUX_CLASS6_JURISPRUDENCE "c6ju"
#define	AUX_CLASS6_HR		 "c6hr"
#define	AUX_CLASS6_BUDGETORGS	 "c6bo"
#define	AUX_CLASS6_LAWFORALL     "c6la"
#define	AUX_CLASS6_GOSZAKUPKI    "c6gz"

#define	AUX_CLASS6_INPHARM_INPHARM	"c6ii"
#define	AUX_CLASS6_INPHARM_SEARCH	"c6is"
#define	AUX_CLASS6_INPHARM_CHAPTERS	"c6ic"
#define	AUX_CLASS6_INPHARM_LEKS		"c6il"
#define	AUX_CLASS6_INPHARM_FIRMS	"c6if"
#define	AUX_CLASS6_INPHARM_DIC		"c6id"

#define	AUX_OM_CHANGESINLEGISLATION	"omIZ"

#define	AUX_O_POSITIONS			"PosO"
#define	AUX_INFO			"Info"
#define	AUX_DSS_FLAGS			"DSSF"
#define	AUX_DSS_FLAGS_LENGTH		"DSSL"
#define	AUX_GC				"-GC-"
#define	AUX_HANDMASK_LENS		"HLen"
#define	AUX_FASTSNIPPETS_DOCS		"Snip"
#define	AUX_SHORTLISTSIZE		"ShLS"
#define	AUX_SIMPLE_SYNS			"SSyn"
#define	AUX_INVISIBLE_LENS		"InvL"
#define	AUX_INVISIBLE_RELES		"InvR"
#define	AUX_NUMBERS			"Nmbs"
#define	AUX_NUMBERS_RCODE		"NmbR"
#define AUX_INFORMERS			"Infm"
#define AUX_INFORMERS_EX		"InfM"	//Информеры для 7.9 с переменной релевантностью
#define	AUX_HOTINFOTOPIC		"HInT"
#define	AUX_INVISIBLE_BLOCKSLENS	"InvB"

#define	AUX_MISTAKES_MORPHO		"MMor"
#define	AUX_MORPHO_SYNS			"MSyn"

#define	AUX_TIME_ONLINECHECKING		"TmOn"	//количество дней, в течении которых осуществляется онлайн-проверка актуальности документов

#define	AUX_SEARCH_CACHE_OFFSETS "SeaO" //стрим для смещений результатов в стриме SeaR
#define	AUX_SEARCH_CACHE_RESULTS "SeaR" //стрим для результатов предварительно посчитанных поисков

#define	AUX_BIGRAMS	"Bigr"

#define	AUX_PARTS	"Prts"

#define	AUX_NAME_SEARCH	"NmSr"	//http://mdp.garant.ru/pages/viewpage.action?pageId=588041161 
				//Нужно создать словарик слов, словосочетаний и шаблонов, по которому будет порождаться дополнительный поисковый запрос вида ПОИСК ПО НАЗВАНИЯМ: слова из словари И ПОИСК ПО ТЕКСТУ: остальные слова запроса.

/*
структура стрима SeaO:
длина запроса | строка запроса\0 | смещение результатов запроса в стриме SeaR

структура стрима SeaR:
количество_сегментов | [сегмент|количество_документов]...[сегмент|количество_документов] [списки RefwRele]...[списки RefwRele]

где:
- количество_сегментов - по поискам найдено какое-то количество документов.
  Они принадлежат какому-то множеству сегментов. Вот количество_сегментов - размер этого множества
*/

#define	class6Navigator  "001=Правовой навигатор"
#define	class6Info       "002=Справочная информация"
#define	class6Inpharm    "003=ИнФарм"
#define	class6NewDocs    "999=Новые поступления"
#define	class6NavigatorE "001=Legal Guide"
#define	class6InfoE      "002=Reference"
#define	class6NewDocsE   "999=New Documents"

#define	class6InpharmSearch  "001=Поиск лекарственных средств"
#define	class6InpharmChapter "002=Разделы справочника"
#define	class6InpharmLekS    "003=Государственный реестр лекарственных средств"
#define	class6InpharmFirms   "004=Справочник фармацевтических фирм"
#define	class6InpharmDic     "005=Словарь медицинских терминов"

#define	class6InpharmCLeks   "001=Лекарственные препараты"
#define	class6InpharmCLekR   "002=Лекарственные растения и сырье"
#define	class6InpharmCImmuno "003=Иммунобиологические препараты"
#define	class6InpharmCGomeo  "004=Гомеопатические препараты"
#define	class6InpharmCSubs   "005=Поливитаминные препараты"

// end of GL.H

#define	INHERITED_BLOCK       0x40000000
#define MINUS_INHERITED_BLOCK 0x3fffffff

#define	DICTIONARY_SEGMENT     33
#define	DICTIONARY_SEGMENT_SML 34
#define	DEMO_SEGMENT           39
#define	INPHARM_SEGMENT        94
#define	ANNO_SEGMENT          211
#define	CONSULTING_SEGMENT    218
#define CLASSIC_SEGMENT       198 //сегмент для Классики (образы документов)

#define	GD_KEYPAGESIZE	2048	/* key file page size */
#define	GD_STRPAGESIZE	4096	/* StreamFile page size */
#define	GD_TEXTPAGESIZE	512	/* textFile page size */

#define ID_PACKED		"*PACKED*"  // 
#define ID_PACKED_NEW	"~PACKED~"  // 
#define ID_PACKED_NDT	"PACKTXT"  // 
#define ID_BLOCK_SIZE	"~BS~"  // 

#define	AUX_PREFIXES		"????"	//пустышка для утилиты addsyns
#define	AUX_SYN_TYPE		"SynT"
#define	AUX_SYN_MORPHO		"SynM"
#define	AUX_SYN_MORPHO_PATTERN		"SynP"
#define	AUX_SYNS		"Syns"
#define	AUX_HARD		"Hard" //безусловно устойчивые словосочетания
#define	AUX_SYN_DATES		"SynD"
#define	AUX_SYN_EXAMPLE		"Exam"
#define	AUX_SYN_CODEXES		"SynC"
#define	AUX_SYN_TYPES		"TSyn"
#define	AUX_SYN_ADOPTED		"ASyn"
#define	AUX_RELE_PLUS		"Rel+"
#define	AUX_BELONGS			"Belo"
#define AUX_BELONGS_DECISIONSARCHIVE	"BlDA"
#define	AUX_IGNORE_BELONGS	"IgnB"
#define	AUX_IGNORE_K3_BELONGS	"IgK3"
#define	AUX_SERV			"Serv"
#define	AUX_TIPS			"Tips"
#define	AUX_MDICS			"MDic"
#define	AUX_MEDICINE_GLOSSARY		"MGlo"
#define	AUX_IGNORE_GL_BELONGS	"GL-a"
#define	AUX_EXCLUDE_WORDS	"Excl"
#define	AUX_EXCLUDE_WORDS_3	"Exc3"
#define	AUX_EXCLUDE_WORDS_8	"Exc8"
#define	AUX_BASENAMES		"BNam"
#define	AUX_RELE_PLUS8		"Rel8"
#define	AUX_RELE_PLUS4		"Rel4"
#define	AUX_RELE_Y		"RelY"
#define	AUX_PartsSpeechAnalyzer	"PSA"
#define	AUX_TOP_LEMMS		"TLem"

#define	AUX_BELONGS_ENCYCLOPEDIA	"BelE"

#define	AUX_CLASS6_KEYS		"key6"
#define	AUX_COUNTRY_FIRMS	"ICFI"
#define	AUX_EXCLUDE_RF		"ExRF"
#define	AUX_TYPING_ERRORS	"TypE"	//список популярных опечаток и их коррекции, например: обьект-объект
#define	AUX_CONTEXT_VARIANTS	"CVar"	//список подсказок ("выпадающий" список a-la google.com) по контексту, введенному пользователем
#define	AUX_CONTEXT_EVARIANTS	"EVar"  //список подсказок (совмещенный для БП и поисков в документе)
#define	AUX_CONTEXT_MVARIANTS	"MVar"  //список подсказок (совмещенный для БП и поисков в документе), содержит и "невидимое" поле. Подробнее http://mdp.garant.ru/pages/viewpage.action?pageId=259164780
#define	AUX_MORPHO_HASHES	"HASH"	//список хэшей для "нормальных" слов, которые в Супере
#define	AUX_RELEF_LAWS		"Laws"	//список номеров документов, которые добавляются к нормативным актам (для слагаемого f в формуле релевантности)
#define	AUX_ERRORS_GOODWORDS	"EWOk"	//список слов, которые подозрительны с точки зрения исправления опечатки, но признаны экспертами "корректными"
#define	AUX_NOT_NORMALIZE	"NotN"	//http://mdp.garant.ru/pages/viewpage.action?pageId=519480682
#define	AUX_NORMALIZER_EXCLUDE	"NExc"	//http://mdp.garant.ru/pages/viewpage.action?pageId=519480682
#define	AUX_PHRASAL_NORMALIZER	"PhrN"	//http://mdp.garant.ru/pages/viewpage.action?pageId=450268918&focusedCommentId=552017652#comment-552017652

#define	AUX_ANNO_UIDS		"AIds"	//список ключ|уникальный_номер для АнкетыПрайма
#define	AUX_KIND_UIDS		"KIds"	//список ключ|уникальный_номер для ВидовПравовойИнформации (Kind)
#define	AUX_DEMO		"Demo"
#define	AUX_MEDTOPICS_SUBNAMES	"ISNC"  //кэш сабнеймов для MEDTOPICов
#define	AUX_RELE_IZM		"Izms"	//список документов, которым понижаем релевантность
#define	AUX_KIND_BITS		"KBit"	//список уникальныйномерkind'а|егобитоваямаска
#define	AUX_KIND_ANALYSEMASK	"AMsk"	//битовая маска для АнализаСписка (какие из видов оставить)
#define	AUX_VIP			"Vip "  //база для vip-клиентов
#define	AUX_PERC		"Perc"  //градусники

#define	AUX_KIND_BASESEARCH	"KBaS"  //список текстовоепредставлениеKindа|егоuid. Используется для закладок видов в БазовомПоиске
#define AUX_KIND_CORRESPONDENTS "KCor"  //список uidов видов, которые надо выводить для типизированных корреспондентов к фрагменту

#define	AUX_RELEVANCY_CHANGES			"RelC"	//правила Украинского для снижения/повышения релевантности спискам документов
#define	AUX_RELEVANCY_CALCULATED_CHANGES	"CRel"	//посчитанные по RelC данные. Пары релевантность:список документов

#define	AUX_CODEPAGE		"CdPg"	//кодировка базы
#define	AUX_VERSION		"BVer"	//версия базы
#define	GKDB_BASE_VERSION	711000

//--== новая псевдоморфология от юристов ==--
#define	AUX_STOP_LEMMS    "SLem" //словарь для блока префиксов. 
//(eсли после отброски префикса оставшаяся часть входит в список стоп-лемм, то такой префикс отбрасывать нельзя)
#define AUX_ENDINGS       "Ends" //псевдоокончания (какое окончание на что менять; иванОВА -> иванОВ)
#define	AUX_SUPPORT_WORDS "SupW" //словарь опорных слов
#define	AUX_MPREFIXES     "MPrf" //словарь префиксов

//индексы для создания фильтрованных FAdo/FPre/FCla (Обзор изменений законодательства)
//эти индексы создаются addsynsом, т.е. юристами (и используются только glем/gdlt)
#define	AUX_fAdo "fAdo"	//для Adopted, т.е. Орган
#define	AUX_fCla "fCla"	//для Class, т.е. Раздел-Тема
#define	AUX_fPre "fPre"  //для Prefix, т.е. ВидПравовойИнформации
#define	AUX_fPub "fPub"  //для PublishedIn, т.е. ИсточникОпубликования
#define	AUX_fILF "fILF"  //для LekForm, т.е. ЛекарственныхСредств
#define	AUX_fKnd "fKnd"	 //для Kind в КЗ
#define	AUX_fCor "fCor"	 //для фильтрации видов у корреспондентов 

#define	AUX_fPJU "fPJU"  //фильтрованный PublishedIn для юристов
#define	AUX_fPHR "fPHR"  //фильтрованный PublishedIn для кадровиков
#define	AUX_fPBO "fPBO"  //фильтрованный PublishedIn для бюджетников
#define	AUX_fPPH "fPPH"  //фильтрованный PublishedIn для Инфарма

//эти индексы создаются glем на основе AUX_fAdo и прочих (см.выше) и используются сервером
//в них записаны пары id ключа индекса : сколько уровней показывать
#define	AUX_FILTERED_ADOPTED   "FAdo"
#define	AUX_FILTERED_CLASS     "FCla"
#define	AUX_FILTERED_PREFIX    "FPre"
#define	AUX_FILTERED_PUBLISHED "FPub"
#define	AUX_FILTERED_LEKFORM   "FILF"
#define	AUX_FILTERED_KIND      "FKnd"
#define	AUX_FILTERED_CORR      "FCor"

#define	AUX_FILTERED_PUBLISHED_JU "FPJU"
#define	AUX_FILTERED_PUBLISHED_HR "FPHR"
#define	AUX_FILTERED_PUBLISHED_BO "FPBO"
#define	AUX_FILTERED_PUBLISHED_PH "FPPH"

#define	AUX_KIND_GCTX	"kctx"	//индекс с теми kindами, которые будучи поставлены на блоке, должны быть "виндексированы" в текст
#define	AUX_KIND_BLOCK	"ksub"	//список kindов; имена блоков, на которых они стоят, будут "виндекированы" в текст

#define	AUX_ANNO_LEAFS	"ALfs"	//сколько параграфов у аннотаций, http://mdp.garant.ru/pages/viewpage.action?pageId=254354147
#define	AUX_IMPORTANT_ANNOS	"ImpA" //важные аннотации, http://mdp.garant.ru/pages/viewpage.action?pageId=518756614

#define	AUX_IMPORTANT_ANNOS_1	"Imp1" //важные аннотации, http://mdp.garant.ru/pages/viewpage.action?pageId=565860583
#define	AUX_IMPORTANT_ANNOS_2	"Imp2"

#define	AUX_INDEXES_SYNS	"ISyn"	//индекс для "виртуальных" (синонимичных) индексов, http://mdp.garant.ru/pages/viewpage.action?pageId=465700744
#define	AUX_INDEXES_CHANGES	"IChg"	//индекс для переименования ключей
#define	AUX_SEGMENT_INDEXES	"SegI"	//индекс для пар типа "Kind - !Knd" - для Kind надо смотреть в Aux.!Knd для определения списка сегментов для каждого ключа из Kind

#define	BASE_SID	"SID"

/* Attribute tags : */
#define IDD_NONE	0x0	
#define	IDD_DATE	0x02	/* struct date */
#define	IDD_ID		0x03	/* ASCIIZ string with document number */
#define IDD_TERRITORY	0x04 
#define	IDD_SOURCE	0x05	/* ASCIIZ string with adopting body */
#define	IDD_DIV		0x06	/* ASCIIZ string with division */
#define	IDD_KEY		0x07	/* ASCIIZ string with keyword */
#define	IDD_TYPE	0x08	/* ASCIIZ string with document type */
#define IDD_INFO	0x09	/* struct DocInfo */
#define IDD_DOCKIND	0x0A
#define	IDD_SUBS	0x0B	/* array of SubDesc's */
#define	IDD_RUNS	0x0D	/* block of PageRun's with text */
#define	IDD_BLOCKS	0x0E	/* array of BlockRec's */
#define	IDD_BASES	0x0F	/* arrary of int - ## of bases this doc belongs to */
#define	IDD_RCODE	0x10	/* ASCIIZ string with reg # in Ministry of Justice */
#define	IDD_VINCLUDED	0x11	/* date of base when doc was 1st time included */
#define	IDD_VCHANGED	0x12	/* date of base when document was changed */
#define	IDD_VABOLISHED	0x13	/* date of base when document was abolished */
#define	IDD_RDATE	0x14
#define	IDD_SORTDATE	0x15
#define	IDD_WARNING	0x16
#define	IDD_VANONCED	0x17
#define	IDD_VLCONTROL	0x18
#define	IDD_SOURCEFILE	0x19
#define	IDD_PREANNODATE	0x1A
#define	IDD_ANNODATE	0x1B
#define IDD_CATEGORY	0x20
#define IDD_PUBLISHEDIN	0x21
#define	IDD_COMPARECONTENTS	0x22
#define IDD_ACTIVE	0x23 /* array of DocActivity's */ 
#define IDD_PAGEBREAKS	0x24 /* array of PageBreak's */ 
#define IDD_CHDATE	0x26
#define	IDD_CONTENTS	0x27
#define	IDD_NOTSURE	0x28
#define	IDD_REFS	0x29
#define	IDD_BLOBS	0x2A
#define	IDD_DIVISION	0x2B
#define	IDD_PREANNOUSER		0x2C
#define	IDD_PREANNOORGANIZATION	0x2D
#define	IDD_PREANNOTAX		0x2E
#define	IDD_PREANNOINTEREST	0x2F
#define	IDD_PREANNOKIND		0x30
#define	IDD_ANNOUSER		0x31
#define	IDD_ANNOORGANIZATION	0x32
#define	IDD_ANNOTAX		0x33
#define	IDD_ANNOINTEREST	0x34
#define	IDD_ANNOKIND		0x35
#define	IDD_CHANGE		0x36
#define IDD_REFS_BLOCKS		0x37
#define	IDD_HANDMASK		0x38 //в 7.6 - обычный невидимый текст
#define	IDD_TFIDF		0x39
#define	IDD_SAMEDOCS		0x3A
#define	IDD_SERVICEINFO		0x3B
#define	IDD_HANDHANDMASK	0x3C //в 7.6 - блочный невидимый текст
#define	IDD_CLASS6		0x3D
#define	IDD_INPHARMFIRM		0x3E
#define	IDD_INPHARMCOUNTRY	0x3F
#define	IDD_REGDATE		0x40
#define	IDD_ANNULDATE		0x41
#define	IDD_TRADENAME		0x42
#define	IDD_INTNAME		0x43
#define	IDD_PHARMGROUP		0x44
#define	IDD_PHARMEFFECT		0x45
#define	IDD_CHAPTER		0x46
#define	IDD_ATC			0x47
#define	IDD_REGSTATUS		0x48
#define	IDD_LEKFORM		0x49
#define	IDD_MKB			0x4A
#define	IDD_CASECODE		0x4B
#define	IDD_LIFE		0x4C
#define	IDD_UNRECIPE		0x4D
#define	IDD_ALLOWED		0x4E
#define	IDD_NOTLIFE		0x4F
#define	IDD_NOTALLOWED		0x50
#define	IDD_RECIPE		0x51
#define	IDD_SUBS_EX		0x52
#define	IDD_EVD			0x53
#define	IDD_FASTCORRS		0x54
#define	IDD_FASTTCORRS		0x55
#define IDD_ACTIVEEX		0x56
#define	IDD_PARAHEIGHTS		0x57
#define	IDD_PARAGCTXLENS	0x58
#define	IDD_CALIN		0x59
#define	IDD_CALAB		0x5A
#define	IDD_CALCH		0x5B
#define	IDD_DOCSTRUCT		0x5C
#define	IDD_INVISIBLELENS	0x5D
#define	IDD_INVISIBLERELES	0x5E
#define	IDD_KIND		0x5F	//Новый ВидПравовойИнформации
#define IDD_BLOB        	0x60
#define IDD_CHDATE_EX		0x61
#define	IDD_ADDCODE		0x62
#define IDD_CHDATE_EXEX		0x63
#define	IDD_MARKEDTEXT		0x64
#define	IDD_SAMES		0x65	//http://mdp.garant.ru/pages/viewpage.action?pageId=565000133
#define	IDD_TAG			0x66
#define	IDD_PROFDATE		0x67	//http://mdp.garant.ru/pages/viewpage.action?pageId=609603293
#define	IDD_INVISIBLEBLOCKSLENS	0x68	//http://mdp.garant.ru/pages/viewpage.action?pageId=616564547

/* Basic sizes: */
#define	BLOCK_SIZE	16U*1024U	/* sizeof single block of document */
#define	ADD_BLOCK_SIZE	65000	/* sizeof single block of document */
#define	NAME_SIZE	75	/* длина имени блоба и копирайта */
#define	BASE_NAME_SIZE	181	/* длина имени сегмента (блока базы) */
#define	DOC_SHORT_NAME_SIZE	64 /* длина короткого имени документа */
#define	SUB_NAME_SIZE	800	/* max. size of SUB name */
#define	DOC_NAME_SIZE	800	/* max. size of document's name */
#define	MAX_PARA_LEN	16384U
#define	CTX_WORD_SIZE	8
#define CATEGORY_KEY_SIZE 20

#define	TYPE_KEY_SIZE	100
#define ADOPTED_KEY_SIZE 200
#define	PRIME_KW_SIZE	100 
#define	SEC_KW_SIZE	100
#define CLASS_KEY_SIZE   100
#define CODE_KEY_SIZE 60
#define PUBLISHEDIN_KEY_SIZE 120
#define	KIND_KEY_SIZE	100
#define TAG_KEY_SIZE 200

#define INPHARM_TRADENAME_SIZE 	200
#define INPHARM_INTNAME_SIZE 	200
#define	INPHARM_FIRM_SIZE	220
#define	INPHARM_COUNTRY_SIZE	200
#define INPHARM_PHARMGROUP_SIZE 200
#define INPHARM_CHAPTER_SIZE 	200
#define INPHARM_ATC_SIZE	200
#define INPHARM_PHARMEFFECT_SIZE 200
#define INPHARM_REGSTATUS_SIZE	200
#define INPHARM_LEKFORM_SIZE	200
#define INPHARM_MKB_SIZE 	220

#ifdef	VERSION56
#define MAX_BASES	65536
#else
#define MAX_BASES	256
#endif // VERSION56

				/* text attributes */
#define	AT_SEL1		'\x01'
#define	AT_SEL2		'\x02'
#define	AT_SEL3		'\x03'
#define	AT_XREF		'\x04'	/* cross-reference */
#define	AT_PRINT	'\x05'	/* don't print attribute */
#define	AT_SEL6		'\x06'
#define	AT_FUT		'\x07'
#define	AT_FORMULA	'\x13'
#define	AT_EMBEDDEDPIC	'\x14'
#define	AT_MARKEDTEXT	15

/* paragraph styles */
#define	PS_PREFORMATTED	'\x0A'
#define	PS_CENTERED	'\x0B'
#define	PS_JUSTIFIED	'\x0C'
#define	PS_RIGHT	'\x0D'
#define PS_SIDEBYSIDE	'\x0E'
#define	PS_SKIPPARA	'\x0F'
#define	PS_EVD		'\x10'
#define	PS_LEFT		'\x11'
#define	PS_VERSION	'\x12'
#define PS_STYLENUM	'\x13'
#define	PS_STYLED	'\x14'
#define	PS_DUMMYBIT	0x80	/* if this bit is set then para is dummy */

/* packing methods */
#define	PM_STORED	0
#define	PM_ZIP		1
#define	PM_NOT_STORE_INFO 2
#define	PM_NOT_STORE_PARAINFO 4

#define	DSS_LEGAL       0x0000
#define	DSS_DIC         0x0001
#define	DSS_TIP         0x0002
#define	DSS_MEDFIRM     0x0004
#define	DSS_MEDDICT     0x0008
#define	DSS_MEDTOPIC    0x0010
#define	DSS_FLASH       0x0020
#define	DSS_AAKTOPIC    0x0040
#define	DSS_AAKCONTENTS 0x0080
#define	DSS_LIKEABLE    0x0100
#define	DSS_REF		0x0200
#define	DSS_BOOK	0x0400

/* document status ( bit fields ) */
#define	DS_ACTIVE	0x01
#define	DS_ABOLISHED	0x02
#define DS_PREACTIVE 	0x04
#define	DS_MOJREG  	0x08
#define DS_MOJNOTREG 	0x10
#define	DS_NODOC	0x20
#define	DS_DOC		0x40
#define	DS_WARNING	0x80		//у документа такой warning, что ему надо уменьшить релевантность
#define	DS_WWW		0x100
#define	DS_REFDOC	0x200
#define	DS_ANNO		0x400
#define DS_EDITION  	0x800
#define	DS_EVD		0x1000
#define	DS_BOOK		0x2000
#define	DS_NOTTM	0x4000
#define DS_MOJOTHER	0x8000

#define	DS_MEDTOPIC	0x0001
#define	DS_FIRMTOPIC	0x0002
#define	DS_NARCOTIC	0x0004
#define	DS_LIFE		0x0008
#define	DS_UNRECIPE	0x0010
#define	DS_MDICTTOPIC	0x0020
#define	DS_IZM		0x0040
#define	DS_ALLOWED	0x0080
#define	DS_RECIPE	0x0100
#define	DS_NOTNARCOTIC	0x0200
#define	DS_NOTLIFE	0x0400
#define	DS_NOTALLOWED	0x0800
#define	DS_FLASH	0x1000
#define	DS_NOCOMPARE	0x2000		//у документа нельзя сравнивать редакции
#define	DS_DATE		0x4000
#define	DS_SIGNIFICANT	0x8000

#define DS_AAKCONTENT	0x0001
#define	DS_AAKTEXT	0x0002

/* для контроля */
#define	CS_NOT_REGISTERED	1L
#define	CS_REGISTERED		2L
#define	CS_ABOLISHED		4L
#define	CS_CHANGED		8L
#define	CS_ACTIVE		16L
#define	CS_DELETED		32L

/* types of references */
#define REFTYPE_UNKNOWN 0
#define REFTYPE_REFLIST 1
#define REFTYPE_CLASS	2
#define REFTYPE_BLOB    3

/* BLOB types */
enum BLOB_types {
	EOT_XML = 0x4C4D5800l,
	EOT_PIC = 0x43495000l,
	EOT_JPG = 0x47504a00l,
	EOT_BMP = 0x504D4200l,
	EOT_PNG = 0x474e5000l,
	EOT_GIF = 0x46494700l,
	EOT_RTF = 0x46545200l,
	EOT_URL = 0x4C525500l,
	EOT_MSG = 0x47534D00l,
	EOT_XLS = 0x534C5800l,
	EOT_MP3 = 0x33504D00l,
	EOT_EVD = 0x44564500l,
	EOT_SWF = 0x46575300l,
	EOT_PDF = 0x46445000l,
	EOT_TIF = 0x46495400l,
	EOT_PPT = 0x54505000l,
	EOT_CDR = 0x52444300l,
	EOT_DOC = 0x434F4400l,
	EOT_DOCX= 0x58434f44l,
	EOT_XLSX= 0x58534C58l,
	EOT_XSD = 0x44535800l,
};

/* lengths of fragments endt */
#define ENDT_HEADER_LEN   5
#define ENDT_FLAGS_LEN    4
#define ENDT_CP_LEN       2
#define ENDT_LEN          4
#define ENDT_ID_LEN       4

/* flags of endt */
#define ENDT_SBS                0x00000010
#define ENDT_COMMENTS           0x00000020
#define ENDT_HEADER             0x00000040
#define ENDT_HAS_BMP            0x00000080
#define ENDT_ARTICLE_HEADER     0x00000100
#define ENDT_VERSION_COMMENTS   0x00000200
#define	ENDT_DOC_DATES          0x00000400
#define	ENDT_PREFORMATTED       0x00000800

#define	CP_ANSI		0x0
#define	CP_OEM		0x1
#define	CP_UNICODE	-1
#define	CP_TATAR	-5

#define DEFAULT_TOPIC_PRIORITY 0x1000
				/* basic text funcs */

#define	ID_EVD_KZ			106 + ID_BORDER
#define	ID_EVD_KZPPR		107 + ID_BORDER
#define	ID_EVD_KZPRIME		108 + ID_BORDER
#define	ID_EVD_KZCONS		109 + ID_BORDER
#define	ID_EVD_KZCONS2		110 + ID_BORDER
#define	ID_EVD_PREANSWER	111 + ID_BORDER
#define	ID_EVD_ANSWER		112 + ID_BORDER
#define	ID_EVD_QUERY		113 + ID_BORDER
#define	ID_EVD_CONTRACT		114 + ID_BORDER
#define	ID_BLOB_FOR_SCRIPTS	115 + ID_BORDER
#define	ID_EVD_INPHARM		50 + ID_BORDER
#define	ID_JSON_K3		116 + ID_BORDER

#define	AUX_FILTER_JSONS	"FJsn"
#define	AUX_LIST_KINDS		"LKnd"
#define	AUX_LIST_KINDS_SORTED	"SKnd"
#define	ID_DEFAULT_FILTER	57870400 + ID_BORDER
//и свободно до 57870499

#define	AUX_LARGE_DOCS		"LrgD"
#define	AUX_PACKED_NEWCORR	"PNeC"

#define	ID_BANNERDOC	54 + ID_BORDER
#define	AUX_BANNERS	"Bans"
#define	AUX_SPLASH	"Spla"
//свободно до 67

#define	AUX_INTERNET_BASE	"WWWB"

#define	AUX_CORR_WEIGHT			"CorW"
#define	AUX_CORR_PAIR_WEIGHT		"Cr2W"
#define	AUX_CORR_PAIR_DOC_WEIGHT	"Cr2D"
#define	AUX_CORR_PAIR_SUB_WEIGHT	"CrSW"

#define	AUX_BASES_LIST	"LIST"
#define	AUX_DOC_BASE	"DOCB"
#define	AUX_BLOB_BASE	"BLBB"

#define	AUX_MAIN_PAGES	"MPgs"	//Индекс профессиональных главных страниц, http://mdp.garant.ru/pages/viewpage.action?pageId=605133695

#define	DDI_SHOW	0
#define	DDI_FOR_WARNING	1
#define	DDI_FOR_DUMMY	2

#define	PR_ALL		"All"
#define	PR_DOCS		"Docs"
#define	PR_COMMENTS	"Comm"
#define	PR_FORMS	"Form"
#define	PR_PROJECTS	"Proj"
#define	PR_PRACTICE	"Prak"
#define	PR_INTERS	"Inte"
#define	PR_BREF		"Bref"	//пользовательский префикс
#define PR_ACCOUNTING_TRANSACTION		"AcTr"	//бухгалтерская проводка

//формально неиспользуемый, но от него пока не отказались
#define	PR_QUES		"Ques"

#define	STR_TRIAL_VERSION ". Пробная версия"

#define	PROTECTED_DOCID	3885635 + ID_BORDER

#pragma pack(1)

#include "garantPIL/implementation/component/cpp/libs/gkdb/src/garctx.h"

#define R_TOUPPER(ch) if(rv_uc(ch)==rv_uc('с')) lv_uc(ch)=rv_uc('…'); else if(rv_uc(ch)==rv_uc('р')) lv_uc(ch)=rv_uc('…'); else if(rv_uc(ch)>=rv_uc('a')&&rv_uc(ch)<=rv_uc('z'))lv_uc(ch)+=rv_uc('A')-rv_uc('a'); else if(rv_uc(ch)>=rv_uc(' ')&&rv_uc(ch)<=rv_uc('Ї'))lv_uc(ch)+=rv_uc('Ђ')-rv_uc(' '); else if(rv_uc(ch)>=rv_uc('а')&&rv_uc(ch)<=rv_uc('п'))lv_uc(ch)+=rv_uc('ђ')-rv_uc('а')

#define QUICK_R_TOUPPER(ch) if(rv_uc(ch)==rv_uc('с')) lv_uc(ch)=rv_uc('…'); else if(rv_uc(ch)==rv_uc('ч')) lv_uc(ch)=rv_uc('ц'); else if(rv_uc(ch)==rv_uc('р')) lv_uc(ch)=rv_uc('…'); else if(rv_uc(ch)>=rv_uc(' ')&&rv_uc(ch)<=rv_uc('Ї'))lv_uc(ch)+=rv_uc('Ђ')-rv_uc(' '); else if(rv_uc(ch)>=rv_uc('а')&&rv_uc(ch)<=rv_uc('п'))lv_uc(ch)+=rv_uc('ђ')-rv_uc('а'); else if(rv_uc(ch)>=rv_uc('a')&&rv_uc(ch)<=rv_uc('z'))lv_uc(ch)+=rv_uc('A')-rv_uc('a')

//#define QUICK_R_WIN_TOUPPER_DOS(ch) {if(rv_uc(ch)==rv_uc('ё')) lv_uc(ch)=rv_uc('…'); else if(rv_uc(ch)==rv_uc('Ё')) lv_uc(ch)=rv_uc('…'); else if(rv_uc(ch)>=rv_uc('а')&&rv_uc(ch)<=rv_uc('п'))lv_uc(ch)+=rv_uc('Ђ')-rv_uc('а'); else if(rv_uc(ch)>=rv_uc('р')&&rv_uc(ch)<=rv_uc('я'))lv_uc(ch)+=rv_uc('ђ')-rv_uc('р'); else if(rv_uc(ch)>=rv_uc('А')&&rv_uc(ch)<=rv_uc('Я'))lv_uc(ch)+=rv_uc('Ђ')-rv_uc('А'); else if(rv_uc(ch)>=rv_uc('a')&&rv_uc(ch)<=rv_uc('z'))lv_uc(ch)+=rv_uc('A')-rv_uc('a');}

#define	QUICK_R_WIN_TOUPPER_WIN(ch) { if(rv_uc(ch)>=rv_uc('а')&&rv_uc(ch)<=rv_uc('я'))lv_uc(ch)+=rv_uc('А')-rv_uc('а'); else if(rv_uc(ch)==rv_uc('Ё')) lv_uc(ch)=rv_uc('Е'); else if(rv_uc(ch)==rv_uc('ё'))lv_uc(ch)=rv_uc('Е'); else if(rv_uc(ch)==rv_uc('ў'))lv_uc(ch)=rv_uc('Ў'); if(rv_uc(ch)>=rv_uc('a')&&rv_uc(ch)<=rv_uc('z'))lv_uc(ch)+=rv_uc('A')-rv_uc('a');}

#define QUICK_R_DOS_TOUPPER_WIN(ch) {if(rv_uc(ch)==rv_uc('с')) lv_uc(ch)=rv_uc('Е'); else if(rv_uc(ch)==rv_uc('р')) lv_uc(ch)=rv_uc('Е'); else if(rv_uc(ch)==rv_uc('ч')) lv_uc(ch)=rv_uc('Ў'); \
else if(rv_uc(ch)>=rv_uc(' ')&&rv_uc(ch)<=rv_uc('Ї'))lv_uc(ch)+=rv_uc('А')-rv_uc(' '); else if(rv_uc(ch)>=rv_uc('а')&&rv_uc(ch)<=rv_uc('п'))lv_uc(ch)+=rv_uc('Р')-rv_uc('а'); else if(rv_uc(ch)>=rv_uc('a')&&rv_uc(ch)<=rv_uc('z'))lv_uc(ch)+=rv_uc('A')-rv_uc('a');\
else if(rv_uc(ch)>=rv_uc('Ђ')&&rv_uc(ch)<=rv_uc('џ'))lv_uc(ch)+=rv_uc('А')-rv_uc('Ђ');}

//АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ
//ЂЃ‚ѓ„…†‡€‰Љ‹ЊЌЋЏ ђ‘’“”•–—?™њ›љќћџ
//абвгдежзийклмноп рстуфхцчшщьыъэюя
// ЎўЈ¤Ґ¦§Ё©Є«¬­®Ї абвгдежзиймлкноп

#define CORE_DUMP_ON_CHECK(a,b) if(!(a)){ fputs(b,stderr);*(long*)0=0; }

struct HIndexKeyData {
	signed char level;
	u_int32_t parent;
	u_int32_t id;
	u_int32_t achCount;
	u_int32_t chCount;
	char text [1];
}__PACKED__;

struct lemma_tfidf {
	char lemma [32];
	double tfidf;
}__PACKED__;

struct Ref { /* generic reference to a place within doc */
	long DocId;
	long Sub  ;
}__PACKED__;

struct RefwRele {
	long DocId;
	long Word;
	short Rele;
}__PACKED__;

struct RefwWeight {
	long DocId;
	long Sub;
	long Weight;
}__PACKED__;

struct RefwReleEx {
	long DocId;
	long Word;
	short Rele;
	long Block;
}__PACKED__;

struct DocRele {
	long DocId;
	short Rele;
}__PACKED__;

struct SameRele {
	long Sub;
	struct Ref ref;	
	short Rele;
}__PACKED__;

#define OBJKEY_RESERVED_SIZE 4

struct ObjKey {
	long id;
	char reserved[OBJKEY_RESERVED_SIZE];
#ifdef	__cplusplus
	bool operator == (const ObjKey& y) const {
		return (id == y.id);
	}
	bool operator < (const ObjKey& y) const {
		return (id < y.id);
	}
#endif
}__PACKED__;

#define BO_BLBEQU  0
#define BO_OBJCHG  1
#define BO_TALCHG  2
#define BO_INFCHG  4
#define BO_BELCHG  8
#define BO_BLBNEW  (16|BO_OBJCHG|BO_INFCHG|BO_BELCHG|BO_TALCHG)
#define BO_ORDER_MASK  (16|BO_OBJCHG|BO_INFCHG|BO_BELCHG|BO_TALCHG|BO_BLBEQU)

#define BO_TYPPIC  32   //
#define BO_TYPRTF  64   //  it's ugly ofcorse, but... life is life
#define BO_TYPOTH  128  //
#define BO_TYPE_MASK (BO_TYPPIC|BO_TYPRTF|BO_TYPOTH)

#define GROW_BY 32

struct	CorrRef {
	long	Sub;
	long	DocId;
	long	Para;
	long	RealPara;
	long	Block;
}__PACKED__;

struct	KindCorrRef {
	u_int64_t mask;
	short	seg;
}__PACKED__;

struct	KindCorr78Ref {
	unsigned long	mask;
	short	seg;
	short	reserved;
}__PACKED__;

struct	RespRef {
	long	ParaId;
	short	Offset;
	long	DocId;
	long	Sub;
}__PACKED__;

struct RespRef2 {
	long ParaId;
	short Offset;
	long DocId;
	long Sub;
	long para;
	long block;
}__PACKED__;

#define OBJINFO_RESERVED_SIZE 16

struct ObjInfo {
	long size;
	long crc32;
	unsigned long type;
	char packed;
	char name[NAME_SIZE];
	char reserved[OBJINFO_RESERVED_SIZE];
}__PACKED__;

#ifdef _USE_CORBA_CONVERTS
struct StrRevision;
#endif

struct revision {
	struct date	RevisionDate;
	struct time	RevisionTime;
#ifdef _USE_CORBA_CONVERTS
	operator StrRevision () const;
	revision& operator = (const StrRevision& c);
#endif
}__PACKED__;

struct RevInfo {
	char Name [BASE_NAME_SIZE];
	struct revision LastUpdate;
}__PACKED__;

#define BASEINFO_RESERVED_SIZE 17
struct	BaseInfo		/* generic info about base (str="Aux",key="Base" ) */
{
	short	BaseId;
	char	Name [BASE_NAME_SIZE];
	char	NameEng [BASE_NAME_SIZE];
	char	AuthorName [NAME_SIZE]; /* Copyright notice */
 
	long	RecCount;		/* total records (topics) */
	long	RecSize;
	long	DocCount;		/* total # of DOCUMENTS in the base */
	long	DocSize;
	long	CommonDocCount; 	/* Number of common docs (DS_DOC) in base */
	long	CommonDocSize;  	/* Size of common docs */
	long	FormsCount;		/* количество объектных топиков */
	long	GreenComments;
	long	HyperRefs;
	struct revision LastUpdate;	/* date of last update */
	unsigned short Weight; 		/* base "weight" for sales decisions... */
	unsigned short UserName;	/* Flag indicates that Name field must not be changed. */
	long	SplashTopic; 
	long	BannerTopic;
	char	reserved [BASEINFO_RESERVED_SIZE];	/* RESERVED !!! This fild MUST BE LAST in structure. */
	                                /* Total structure size MUST BE CONSTANT. */
	                                /* sizeof (BaseInfo) == 512 */
	                                /* If You add any fields in structure don't forget to */
	                                /* edit reserved size !!! */
}__PACKED__;

#define HASP_NAME_SIZE 8
#define BASEWEIGHT_RESERVED_SIZE  512-BASE_NAME_SIZE*2-HASP_NAME_SIZE-sizeof(long)*2
struct BaseWeight {
	unsigned long min;
	unsigned long max;
	char name[BASE_NAME_SIZE];
	char nameEng[BASE_NAME_SIZE];
	char haspName[HASP_NAME_SIZE];
	char reserved[BASEWEIGHT_RESERVED_SIZE];
}__PACKED__;

struct	DocInfo			/* generic info about document */
{	
	char	Title [DOC_SHORT_NAME_SIZE];	/* doc ( window ) title */
	unsigned long	long_respondents;
	unsigned long	hi_long_respondents;
	unsigned char	Status_exex_part1;
	short   Status_ex;
	long	Size;			/* total document text size in bytes */
	long	ParaCount;		/* total paragraphs in a document */
	struct revision Revision;	/* last date of modification */
	struct date	FirstDate;	/* date used for sorting */
	struct date	LastDate;
	short	Force;			/* juridical force, used for sorting */
	unsigned short	HyperRefs;
	short	GreenComments;
	short	Status;			/* one of DS_* constants */
	unsigned short	 reserved_short;// это будет одна половина ссылки на мониторинг
	long	Related;		/* belongs to the same base, 0 if none */
	long	prevEdition, nextEdition; 
	long	lastParaID;
	unsigned short	reserved_short2; //это будет вторая половина ссылки на мониторинг
	unsigned char	Status_exex_part2;
}__PACKED__;

struct	PageRun
{
    long	StartPage;	/* 1st page of run */
    short	Count;		/* # of pages in this run */
}__PACKED__;

struct	BlockRec		/* description of a block */
{
	short	Pos1;		/* from page Pos1 in doc's page list */
	short	Pos2;		/* to page Pos1 in doc's page list */
	long	FirstPara;	/* # of 1st paragraph of a block */
}__PACKED__;

struct	IddChangeStruct {
	long	id;
	char	reason;
}__PACKED__;

#define	SUBDESCEX_END 0x8000

struct	SubDescEx {
	long	Sub;	//номер саба или uid таблицы
	long	Para;	//на каком параграфе блок или начинается/заканчивается
	unsigned short	Flags;	//флаги, что это такое - блок, таблица, строка, ячейка
	long	Id;	//порядковый номер элемента с начала
}__PACKED__;

struct	DocStruct {
	unsigned int m_id;
	unsigned int m_para_list_id;
	unsigned int m_para_list_type;
	unsigned int m_start_para;
	unsigned int m_end_para;
	unsigned int m_first_child;
	unsigned int m_last_child;	
}__PACKED__;

struct	AttrKey			/* key for AttrIndex */
{
	long	DocId;
	short	AttrTag;
}__PACKED__;

struct	BlockHeader {
	char	Method;		/* method of packing */
	unsigned short	SrcSize;	/* unpacked size */
	unsigned short	ArcSize;	/* packed size */
	short	InPrePage;	/* bytes in prefered page */
	//unsigned short	Crc;		/* block checksum, not actual, include in ZIP */
}__PACKED__;

#ifdef VERSION56
struct DocActivity {
	struct	date from;
	struct	date to;
	char*	text;	
}__PACKED__;

struct DocActivitySmall {
	struct	date from;
	long	block;
}__PACKED__;

struct	PageBreak {
	long Para;    /* на каком параграфе */
	short Count;  /* и после какого слова разрыв страницы */
}__PACKED__;

struct  ShortCommonAttribute {
    long m_id;			// id документа
    short m_force;		// юр сила
    long m_published;		// сюда дата из DocInfo.FirstDate
    long m_changed;		// сюда дата из DocInfo.LastDate
    short m_status;		// статус документа
}__PACKED__;

struct  DSSAttribute {
    long m_id;			// id документа
    short m_flags;		// флаги
}__PACKED__;

struct  CommonAttribute76 {
    long m_id;			// id документа
    short m_force;		// юр сила
    long m_published;		// сюда дата из DocInfo.FirstDate
    long m_changed;		// сюда дата из DocInfo.LastDate
    short m_status;		// статус документа
    char mask;			// маска видов правовой информации документа
    long m_number;      	// позиция документа в Aux.sort (это список документов, отсортированный по !CODE, т.е. номеру документа)
}__PACKED__;

struct  CommonAttribute {
    long m_id;			// id документа
    short m_force;		// юр сила
    long m_published;		// сюда дата из DocInfo.FirstDate
    long m_changed;		// сюда дата из DocInfo.LastDate
    short m_status;		// статус документа
    u_int64_t mask;		// маска видов правовой информации документа
    long m_number;      	// позиция документа в Aux.sort (это список документов, отсортированный по !CODE, т.е. номеру документа)
}__PACKED__;

struct	InpharmAttribute {
	long m_id;
	short m_status_ex;
	char* name;
}__PACKED__;

struct	BlobInfo {
	long	Para;
	long	type;
	char	Name[1];
}__PACKED__;

struct	EVDParaInfo {
	unsigned long para;
	unsigned long flags;	
}__PACKED__;

#endif

/* size of the sizes of the stream */
#define STRSZSZ sizeof(IndexRecordData::RecordDataHeader)

#pragma pack()

struct	ContextPattern	/* description of a context pattern as a list of words */
{
	char    buf [1024];
	int	WordCount;
	char  * Word [256];
};

struct	ContextPos		/* generic position of context within DocWindow */
{
	long	Para;
	int	Start;
	int	End;
};

struct IndexReq {   // index request - elementary search request
	char Name [20]; // name of index to be searched
	short SearchOp; // operation to be performed
	short ItemCount;
	short ItemSize; // if == 0 then items a ASCIIZ strings must be followed by data : ItemCount of fixed sized items or ASCIIZ strings
};

void cdecl OkBox (const char *t, const char *fmt, ...);
int cdecl YesNOBox  (char *, char *, ...);

extern char *gbase_FilesExt[];

#define GB_NDT_EXT gbase_FilesExt[0]
#define GB_STR_EXT gbase_FilesExt[1]
#define GB_KEY_EXT gbase_FilesExt[2]

#if defined(_WINDOWS) || defined(_WINDOWS_) || defined(_AFXDLL)
// see windows headers
#include <wingdi.h>
#define BI_RGB 0L
#define WIDTHBYTES(bits)	(((bits) + 31) / 32 * 4)
#define IS_WIN30_DIB(lpbi)	((*(unsigned long*)(lpbi)) == sizeof(BITMAPINFOHEADER))
#else
	typedef struct {
			unsigned char    rgbBlue;
			unsigned char    rgbGreen;
			unsigned char    rgbRed;
			unsigned char    rgbReserved;
	} RGBQUAD;
	#pragma pack(1)
	typedef struct {
			unsigned char    rgbtBlue;
			unsigned char    rgbtGreen;
			unsigned char    rgbtRed;
	} RGBTRIPLE;
	#pragma pack()
	#pragma pack(2)
	typedef struct {
			unsigned short    bfType;
			unsigned long   bfSize;
			unsigned short    bfReserved1;
			unsigned short    bfReserved2;
			unsigned long   bfOffBits;
	} BITMAPFILEHEADER, *PBITMAPFILEHEADER;
	#pragma pack()
	typedef struct {
			unsigned long   bcSize;
			unsigned short    bcWidth;
			unsigned short    bcHeight;
			unsigned short    bcPlanes;
			unsigned short    bcBitCount;
	} BITMAPCOREHEADER, *PBITMAPCOREHEADER;
	typedef struct {
			unsigned long      biSize;
			long       biWidth;
			long       biHeight;
			unsigned short       biPlanes;
			unsigned short       biBitCount;
			unsigned long      biCompression;
			unsigned long      biSizeImage;
			long       biXPelsPerMeter;
			long       biYPelsPerMeter;
			unsigned long      biClrUsed;
			unsigned long      biClrImportant;
	} BITMAPINFOHEADER, *PBITMAPINFOHEADER;

	#define BI_RGB 0L
	#define WIDTHBYTES(bits)	(((bits) + 31) / 32 * 4)
	#define IS_WIN30_DIB(lpbi)	((*(unsigned long*)(lpbi)) == sizeof(BITMAPINFOHEADER))

	extern unsigned short DIBNumColors(char *);

	extern unsigned short PaletteSize(char *);
#endif
	extern unsigned long BitmapSize( unsigned long, unsigned long, unsigned short);
//#endif

#endif

