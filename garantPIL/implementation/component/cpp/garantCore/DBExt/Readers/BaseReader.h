////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/BaseReader.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::BaseReader
//
// Базовый класс
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_READERS_BASEREADER_H__
#define __GARANTCORE_DBEXT_READERS_BASEREADER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"

namespace DBExt {

// Базовый класс
class BaseReader;
typedef Core::Var<BaseReader> BaseReader_var;
typedef Core::Var<const BaseReader> BaseReader_cvar;

class BaseReader :
	virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (BaseReader)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BaseReader (DBCore::Store* stream, DBCore::IIndex* index);

public:
	~BaseReader ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// дина порции данных
	size_t get_length () const;

	// длина стрима
	size_t get_stream_length () const;

	// текущая позиция в стриме
	size_t get_tell () const;

	// чтение данных
	char* read (size_t data_size, int pos);

	// чтение данных
	char* read_more ();

private:
	// чтение данных
	size_t read (char* buffer, size_t count);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// буффер для данных
	char* m_buffer;

	// длина буффера
	size_t m_buffer_size;

	DBCore::IIndex* m_index;

	// длина порции данных
	size_t m_length;

	// указатель на открытый стрим
	DBCore::Store* m_stream;
}; // class BaseReader

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_READERS_BASEREADER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

