////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/DB/DBCore/DBCore.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::DB::DBCore
//
// Базовые сущности ядра
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_DB_DBCORE_H__
#define __SHARED_DB_DBCORE_H__

#include "shared/Core/sys/std_inc.h"
#include <deque>
#include <vector>

namespace DBCore {

class Store;
// Store
class Store
{
public:
	// length
	virtual int Length () const = 0;

	// read
	virtual int Read (void* buf, int count) = 0;

	// seek
	virtual int Seek (int pos) = 0;

	// tell
	virtual int Tell () const = 0;

	// trunk
	virtual int Trunc () = 0;

	// write
	virtual int Write (const void* buf, int count) = 0;
};

class Storable;
// Storable
class Storable
{
public:
	// reload contents of existing object from Store
	virtual int Get (Store* in) = 0;

	// save object to Store
	virtual int Put (Store* in) = 0;

	// tag for restoring object
	virtual short Tag () const = 0;
};

class IBTreeIterator;
typedef ::Core::Var<IBTreeIterator> IBTreeIterator_var;
typedef ::Core::Var<const IBTreeIterator> IBTreeIterator_cvar;
// BTreeIterator
class IBTreeIterator
	: virtual public ::Core::IObject
{
public:
	// sets to first item >= key
	virtual int Set (const void* key) = 0;

	// returns current item
	virtual const void* Key () const = 0;

	// whether iterator reached end of tree in either direction
	virtual int End () const = 0;

	// next
	virtual void next () = 0;

	// prev
	virtual void prev () = 0;
};

class IProgress;
typedef ::Core::Var<IProgress> IProgress_var;
typedef ::Core::Var<const IProgress> IProgress_cvar;
// Прогресс-индикатор
class IProgress
	: virtual public ::Core::IObject
{
public:
	// проверка, остановлен ли процесс пользователем
	virtual bool canceled_by_user () = 0;

	// инициализация
	virtual void init (size_t div, size_t pos) = 0;

	// пауза
	virtual void pause (bool pause) = 0;

	// set
	virtual void plus () = 0;

	// позиционирование
	virtual void set (size_t value) = 0;

	// установить максимальное значение
	virtual void set_border (size_t value) = 0;
};

class IBuffer;
typedef ::Core::Var<IBuffer> IBuffer_var;
typedef ::Core::Var<const IBuffer> IBuffer_cvar;
// Буффер
class IBuffer
	: virtual public ::Core::IObject
{
public:
	// данные
	virtual const char* get () const = 0;
};

class IIndex;
typedef ::Core::Var<IIndex> IIndex_var;
typedef ::Core::Var<const IIndex> IIndex_cvar;
// Индекс
class IIndex
	: virtual public ::Core::IObject
{
public:
	// открыть стрим
	virtual Store* open_stream (const void* key, unsigned short stream_no) = 0;

	// закрыть стрим
	virtual void close_stream (Store* store) = 0;

	// проверка на валидность
	virtual bool is_valid () const = 0;

	// чтение данных
	virtual IBuffer* read (const void* key, unsigned short stream_no, size_t& len) = 0;

	// проверка ключа на валидность
	virtual bool is_valid_key (const void* key) = 0;

	// открыть стрим
	virtual Store* key_open (const void* key, int stream_no) = 0;

	// итератор по btree
	virtual IBTreeIterator* make_iterator () = 0;

	// количество ключей
	virtual size_t key_count () const = 0;
};

class IBase;
typedef ::Core::Var<IBase> IBase_var;
typedef ::Core::Var<const IBase> IBase_cvar;
// Абстрактная база
class IBase
	: virtual public ::Core::IObject
{
public:
	// фабрика
	virtual IIndex* make (const char* name) = 0;
};

// Тип для идентификатора документа
typedef unsigned long DocId;

// Вектор идентификационных номеров документов
typedef std::vector < DocId > DocVector;

#pragma pack (push, 1)

// Ссылка на позиции документа
struct Ref_ {
	// идентификатор документа
	unsigned long doc_id;
	// позиция в стриме с данными
	unsigned long pos;
	// длина порции данных
	size_t length;
};

#pragma pack (pop)

// Дек идентификационных номеров документов
typedef std::deque < DocId > DocDeque;

#pragma pack (push, 1)

// Данные для алгоритма модификации значений релевантности в списке найденных документов
struct DocListRelevancy {
	// значение релевантности
	int relevancy;
	// список документов, для которых нужно модифицировать значение релевантности
	DocDeque docs;
	//#UC START# *4DD3BB00024E*
	inline bool operator > (const DocListRelevancy& val) const {
		return relevancy > val.relevancy;
	}
	//#UC END# *4DD3BB00024E*
};

#pragma pack (pop)

#pragma pack (push, 1)

// Пара крайних значений
struct ExtrPair {
	// минимум
	long min;
	// максимум
	long max;
	ExtrPair () : min(0), max(0) {
		//#UC START# *505744D1004E_DEF_INIT_CTOR*
		//#UC END# *505744D1004E_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// Тип данных для алгоритма модификации значений релевантности
typedef std::vector < DocListRelevancy > RelevancyTuneData;

class IRefStream;
typedef ::Core::Var<IRefStream> IRefStream_var;
typedef ::Core::Var<const IRefStream> IRefStream_cvar;
// Стрим
class IRefStream
	: virtual public ::Core::IObject
{
public:
	// длина
	virtual unsigned long get_length () const = 0;

	// прочитать следующую порцию данных
	virtual bool get_next (Ref_& ref, long border) = 0;

	// текущая позиция
	virtual unsigned long get_tell () const = 0;

	// поиск заданного документа
	virtual bool search (Ref_& ref) = 0;
};

// Вектор безнаковых целых
typedef std::vector < unsigned long > ULongVector;

class IDataStream;
typedef ::Core::Var<IDataStream> IDataStream_var;
typedef ::Core::Var<const IDataStream> IDataStream_cvar;
// Стрим позиций
class IDataStream
	: virtual public ::Core::IObject
{
public:
	// получить данные
	virtual void get (ULongVector& data, const Ref_& ref, const ExtrPair& extr) = 0;

	// найдена блочная позиция
	virtual bool has_block () const = 0;
};

#pragma pack (push, 1)

// Стримы
struct StreamsPair {
	// стрим
	IRefStream_var ref_stream;
	// стрим
	IDataStream_var data_stream;
};

#pragma pack (pop)

class IStreamsFactory;
typedef ::Core::Var<IStreamsFactory> IStreamsFactory_var;
typedef ::Core::Var<const IStreamsFactory> IStreamsFactory_cvar;
// Фабрика стримов
class IStreamsFactory
	: virtual public ::Core::IObject
{
public:
	// проверка на валидность
	virtual bool is_valid () const = 0;

	// фабрика
	virtual StreamsPair* make (const std::string& key, unsigned long flags) = 0;
};

#pragma pack (push, 1)

// Стримы
struct Streams {
	// флаг наличия формы
	bool has_form;
	// первый стрим
	Store* first;
	// второй стрим
	Store* second;
	//#UC START# *4EBA9B800366*
	Streams () : first (0), second (0), has_form (false) {
	}
	//#UC END# *4EBA9B800366*
};

#pragma pack (pop)

// Тип загрузки
enum LoadType {
	lt_All // всё
	, lt_Refs // ссылки
	, lt_Data // данные
};

class IBasePool;
typedef ::Core::Var<IBasePool> IBasePool_var;
typedef ::Core::Var<const IBasePool> IBasePool_cvar;
// Пул баз
class IBasePool
	: virtual public ::Core::IObject
{
public:
	// создать
	virtual IBase* get (size_t i) = 0;

	// размер
	virtual size_t size () const = 0;
};

#pragma pack (push, 1)

// Настроки кэша
struct MemCacheSettings {
	// для списка лексем
	bool for_list;
	// макимальный размер
	size_t max_size;
	// тип
	LoadType type;
	// пул баз
	IBasePool_var pool;
	MemCacheSettings () : for_list(false), max_size(0), type(lt_All) {
		//#UC START# *52D526D70243_DEF_INIT_CTOR*
		//#UC END# *52D526D70243_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// Позиции контекста
typedef std::vector < ULongVector > ContextPositions;

class IPosContainer;
typedef ::Core::Var<IPosContainer> IPosContainer_var;
typedef ::Core::Var<const IPosContainer> IPosContainer_cvar;
// Контейнер позиций
class IPosContainer
	: virtual public ::Core::IObject
{
public:
	// добавить
	virtual bool add (unsigned long val) = 0;

	// добавить
	virtual bool add (unsigned long pos, unsigned long flags) = 0;

	// данные
	virtual const ContextPositions& get () const = 0;

	// имеет блочную позицию
	virtual bool has_block () const = 0;

	// ссылка на текущий элемент
	virtual const ULongVector& ref () const = 0;

	// очистить
	virtual void reset () = 0;

	// настроится на элемент
	virtual void set (size_t pos) = 0;

	// указываем на вектор с минимальным набором вхождений
	virtual void set_min (const ULongVector& in) = 0;
};

// Вектор байт
typedef std::vector < unsigned char > Bytes;

// Шаблоны связей между частями речи
typedef std::vector < Bytes > PSDTemplates;

#pragma pack (push, 1)

// RelPair
struct RelPair {
	// идентификатор
	DocId id;
	// релевантность
	short rel;
	//#UC START# *53834B850211*
	bool operator < (const RelPair& val) const {
		return id < val.id;
	}

	bool operator >= (long val) const {
		return id >= (DBCore::DocId) val;
	}

	bool operator == (const RelPair& val) const {
		return id == val.id;
	}
	//#UC END# *53834B850211*
};

#pragma pack (pop)

// RelTuneData
typedef std::vector < RelPair > RelTuneData;

// Константы
static const size_t MAX_WORDS_OF_REQUEST = 15; // максимальное количество слов в контекстном запросе

} // namespace DBCore


#endif //__SHARED_DB_DBCORE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
