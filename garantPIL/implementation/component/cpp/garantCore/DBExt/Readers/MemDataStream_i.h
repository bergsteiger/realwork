////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/MemDataStream_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::MemDataStream_i
//
// MemDataStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_READERS_MEMDATASTREAM_I_H__
#define __GARANTCORE_DBEXT_READERS_MEMDATASTREAM_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"
#include "garantCore/DBExt/Def/Def.h"

namespace DBExt {

// MemDataStream
class MemDataStream_i;
typedef Core::Var<MemDataStream_i> MemDataStream_i_var;
typedef Core::Var<const MemDataStream_i> MemDataStream_i_cvar;

class MemDataStream_i :
	virtual public DBCore::IDataStream
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MemDataStream_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	MemDataStream_i (const char* data, int length, Def::Type type, bool has_form);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	const char* m_data;

	bool m_has_block;

	bool m_has_form;

	size_t m_length;

	Def::Type m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DBCore::IDataStream
	// получить данные
	void get (DBCore::ULongVector& data, const DBCore::Ref_& ref, const DBCore::ExtrPair& extr);

	// implemented method from DBCore::IDataStream
	// найдена блочная позиция
	bool has_block () const;
}; // class MemDataStream_i

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_READERS_MEMDATASTREAM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

