////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/PositionsReader.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::PositionsReader
//
// Ридер позиций документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_READERS_POSITIONSREADER_H__
#define __GARANTCORE_DBEXT_READERS_POSITIONSREADER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"
#include "garantCore/DBExt/Readers/BaseReader.h"
#include "garantCore/DBExt/Def/Def.h"

namespace DBExt {

// Ридер позиций документа
class PositionsReader;
typedef Core::Var<PositionsReader> PositionsReader_var;
typedef Core::Var<const PositionsReader> PositionsReader_cvar;

class PositionsReader :
	virtual public DBCore::IDataStream
	, virtual public BaseReader
{
	SET_OBJECT_COUNTER (PositionsReader)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	PositionsReader (DBCore::Store* stream, unsigned char form, Def::Type type, bool has_form, DBCore::IIndex* index);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	unsigned char m_form;

	bool m_has_block;

	bool m_has_form;

	// длина стрима
	size_t m_stream_length;

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
}; // class PositionsReader

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_READERS_POSITIONSREADER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

