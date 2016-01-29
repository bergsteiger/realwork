////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Defs/Defs.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Defs
//
// Общие типы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_DEFS_H__
#define __SHARED_CONTEXTSEARCH_DEFS_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <vector>
#include "shared/GCL/data/std_defs.h"

namespace ContextSearch {
namespace Defs {

// Тип
enum TuneDocType {
	dt_CODE // документы c коммандой CODE
	, dt_TYPE // документы c определенным типом
	, dt_INFORM // информеры
	, dt_RCH // rel_change
};

#pragma pack (push, 1)

// Данные позиции из невидимого диапазона приписанного к блоку
struct InvisibleBlockPosition {
	// длина блока
	size_t length;
	// балл релевантности
	unsigned long relevancy;
};

#pragma pack (pop)

// Данные позиций из невидимого диапазона приписанного к блоку
typedef std::map < unsigned long, InvisibleBlockPosition > InvisibleData;

// Длины блоков приписанных к позициям из невидимого текста
typedef std::map < unsigned long, InvisibleData > InvisibleBlocks;

#pragma pack (push, 1)

// Релевантная позиция
struct RelPos {
	// позиция
	unsigned long pos;
	// релевантность
	unsigned char rel;
	//#UC START# *53D6435E011F*
	bool operator < (const RelPos& val) const {
		return pos < val.pos;
	}
	//#UC END# *53D6435E011F*
};

#pragma pack (pop)

// Релевантности позиций из обычного невидимого текста
typedef std::vector < RelPos > PositionsRel;

// Тип для позиции (маска: поле флагов + позиция) слова в документе
typedef unsigned long Position;

// Вектор позиций слов в документе
typedef std::vector < Position > Positions;

// Тип для релевантности документа
typedef unsigned long RelevancyType;

#pragma pack (push, 1)

// Структура для оценки релевантности документа
struct RelevancyInfo {
	// значение релевантности
	RelevancyType relevancy_value;
	// позиция первого слова в найденной релевантной цепочке
	Position position;
	RelevancyInfo () : relevancy_value(0), position(0) {
		//#UC START# *451BC43E0167_DEF_INIT_CTOR*
		//#UC END# *451BC43E0167_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *451BC43E0167*
	inline RelevancyInfo& operator = (const RelevancyInfo& copy) {
		relevancy_value = copy.relevancy_value;
		position = copy.position;
		return *this;
	}
	inline bool operator != (RelevancyType val) const {
		return relevancy_value != val;
	}
	inline bool operator == (RelevancyType val) const {
		return relevancy_value == val;
	}
	//#UC END# *451BC43E0167*
};

#pragma pack (pop)

// Тип для идентификатора документа
typedef unsigned long DocId;

#pragma pack (push, 1)

// Документ  и его релевантность
struct RelevancyDocInfo {
	// идентификатор документа
	DocId doc_id;
	// инфо о релевантности документа
	RelevancyInfo info;
	RelevancyDocInfo () : doc_id(0) {
		//#UC START# *4516957E037A_DEF_INIT_CTOR*
		//#UC END# *4516957E037A_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *4516957E037A*
	inline bool operator < (const RelevancyDocInfo& val) const {
		return doc_id < val.doc_id;
	}

	inline bool operator == (const RelevancyDocInfo& val) const {
		return doc_id == val.doc_id;
	}
	//#UC END# *4516957E037A*
};

#pragma pack (pop)

// Контейнер для найденных (удовлетворяющих запросу) документов
typedef std::vector < RelevancyDocInfo > RelevancyDocuments;

#pragma pack (push, 1)

// Фрагмент (релевантный набор позиций слов в заданном тексте)
struct Fragment {
	// инфо о релевантности фрагмента
	RelevancyInfo info;
	// позиции слов найденной фразы (в порядке исходного запроса)
	Positions data;
	//#UC START# *451683A0032C*
	Fragment (RelevancyType relevancy = 0, Position pos = 0) {
		info.position = pos;
		info.relevancy_value = relevancy;
	}
	inline bool operator < (RelevancyType val) const {
		return info.relevancy_value < val;
	}
	inline bool operator > (const Fragment& val) const {
		return info.relevancy_value > val.info.relevancy_value;
	}
	inline bool operator >= (const Fragment& val) const {
		return info.relevancy_value >= val.info.relevancy_value;
	}
	//#UC END# *451683A0032C*
};

#pragma pack (pop)

// Вектор фрагментов
typedef std::vector < Fragment > Fragments;

#pragma pack (push, 1)

// Параметры влияющие на значение релевантности документа
struct RelevancyParam {
	// учитывается, если в найденной цепочке правильный порядок слов
	RelevancyType X;
	// учитывается, если найденная цепочка принадлежит фрагменту
	RelevancyType Y;
	// учитывается если слова из запроса принадлежат к заголовку из текста
	RelevancyType Z;
	// баллы за невидимый текст
	RelevancyType I;
	RelevancyParam () : X(0), Y(0), Z(0), I(0) {
		//#UC START# *474ECA0D00EA_DEF_INIT_CTOR*
		//#UC END# *474ECA0D00EA_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *474ECA0D00EA*
	RelevancyParam& operator = (const RelevancyParam& copy) {
		X = copy.X;
		Y = copy.Y;
		Z = copy.Z;
		I = copy.I;
		return *this;
	}
	//#UC END# *474ECA0D00EA*
};

#pragma pack (pop)

// Информация о релевантности фрагментов
typedef std::vector < RelevancyInfo > RelDetail;

// Детальная информация о базовых параметрах для всех фрагментов
typedef std::vector < RelevancyParam > ParamDetail;

#pragma pack (push, 1)

// Детальная информация о релевантности
struct Detail {
	// надбавка за CODE
	short code_factor;
	// идентификатор документа
	unsigned long doc_id;
	// поисковый запрос
	std::string req;
	// надбавка за TYPE
	short type_factor;
	// надбавка за информеры
	short inform_factor;
	// rel_change
	short rch_factor;
	// инфо о релевантности
	RelevancyInfo info;
	// список синонимичных запросов для всех фрагментов
	GCL::StrVector reqs;
	// базовые параметры
	RelevancyParam param;
	// инфо о базовых параметрах для всех фрагментов
	ParamDetail params;
	// инфо о релевантности фрагментов
	RelDetail rel_detail;
	Detail () : code_factor(0), doc_id(0), type_factor(0), inform_factor(0), rch_factor(0) {
		//#UC START# *4C18E86F0371_DEF_INIT_CTOR*
		//#UC END# *4C18E86F0371_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *4C18E86F0371*
	inline bool operator < (const Detail& val) const {
		return doc_id < val.doc_id;
	}
	inline bool operator == (const Detail& val) const {
		return doc_id == val.doc_id;
	}
	//#UC END# *4C18E86F0371*
};

#pragma pack (pop)

// Детальная информация о релевантности
typedef std::vector < Detail > DetailInfo;

class IRelevancyInfo;
typedef ::Core::Var<IRelevancyInfo> IRelevancyInfo_var;
typedef ::Core::Var<const IRelevancyInfo> IRelevancyInfo_cvar;
// Интерфейс для сбора детальной информации о релевантности
class IRelevancyInfo
	: virtual public ::Core::IObject
{
public:
	// добавить запрос
	virtual void add (const std::string& req) = 0;

	// добавить документ и его релевантность
	virtual void add (unsigned long doc_id, const RelevancyInfo& info) = 0;

	// добавить базовые параметры в формуле релевантности
	virtual void add (const RelevancyParam& param, unsigned long pos) = 0;

	// добавить значение релевантности для определенного типа
	virtual void add (unsigned long doc_id, TuneDocType type, short value) = 0;

	// очистить кэш
	virtual void clear () = 0;

	// получить информацию о релевантности
	virtual const DetailInfo& get_info () = 0;
};

class IFilter;
typedef ::Core::Var<IFilter> IFilter_var;
typedef ::Core::Var<const IFilter> IFilter_cvar;
// Фильтр
class IFilter
	: virtual public ::Core::IObject
{
public:
	// check
	virtual bool check (DocId val) = 0;

	// check
	virtual bool check () const = 0;

	// создать дубликат
	virtual IFilter* duplicate () = 0;

	// logic op
	virtual char get_op () const = 0;

	// size
	virtual size_t get_size () const = 0;

	// reset
	virtual void reset () = 0;

	// type
	virtual const char* type () const = 0;
};

#pragma pack (push, 1)

// Параметры запроса
struct Request {
	// контекст
	std::string context;
	// поиск в тексте
	bool btext;
	// логическая операция
	char op;
	Request () : btext(true), op('&') {
		//#UC START# *4ECFAF56035C_DEF_INIT_CTOR*
		//#UC END# *4ECFAF56035C_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *4ECFAF56035C*
	Request (const std::string& _context, bool _btext = true) 
		: context (_context)
		, btext (_btext) 
		, op ('&') {
	}
	//#UC END# *4ECFAF56035C*
};

#pragma pack (pop)

// Вектор контекстных запросов
typedef std::vector < Request > Requests;

#pragma pack (push, 1)

// Параметры поисковой сессии
struct SearchInfo {
	// сборщик информации о релевантности
	IRelevancyInfo* info_collector;
	// фильтр
	IFilter* filter;
	//#UC START# *4ECF74B2002B*
	SearchInfo ()
		: info_collector (0) 
		, filter (0) {
	}

	SearchInfo (IRelevancyInfo* _collector, IFilter* _filter)
		: info_collector (_collector) 
		, filter (_filter) {
	}
	//#UC END# *4ECF74B2002B*
};

#pragma pack (pop)

class IResCollector;
typedef ::Core::Var<IResCollector> IResCollector_var;
typedef ::Core::Var<const IResCollector> IResCollector_cvar;
// Коллектор для результата поиска
class IResCollector
	: virtual public ::Core::IObject
{
public:
	// add
	virtual void add (DocId id, const RelevancyInfo& info) = 0;

	// empty
	virtual bool empty () const = 0;

	// finish
	virtual void finish (const std::string& req) = 0;

	// filter
	virtual IFilter* get_filter (char op) = 0;

	// start
	virtual void start (const std::string& req) = 0;
};

// Релевантности позиций из обычного невидимого текста документа
typedef std::map < unsigned long, PositionsRel > InvisibleRel;

// StrStrMap
typedef std::map < std::string, std::string > StrStrMap;

// Логические операции
static const char so_AND = '&'; // AND
static const char so_OR = '|'; // OR
static const char so_NOT = '~'; // NOT

} // namespace Defs
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_DEFS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
