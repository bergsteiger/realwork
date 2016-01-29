////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/MissingInfo_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::MissingInfo_i
// Заголовок реализации класса серванта для интерфеса MissingInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_MISSINGINFO_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_MISSINGINFO_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"

namespace GblAdapterLib {

class MissingInfo_i; // self forward Var
typedef ::Core::Var<MissingInfo_i> MissingInfo_i_var;
typedef ::Core::Var<const MissingInfo_i> MissingInfo_i_cvar;

class MissingInfo_i_factory;

class MissingInfo_i:
	virtual public MissingInfo
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MissingInfo_i)
	friend class MissingInfo_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MissingInfo_i (const GCD::PID& pid);

	virtual ~MissingInfo_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCI::IO::String_var m_blocks_info;

	bool m_is_one_block;

	GCI::IO::String_var m_obj_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MissingInfo
	// Имена блоков (баз), в которых содержится отсутствующий объект.
	virtual const GCI::IO::String& get_blocks_info () const;
	virtual GCI::IO::String& get_blocks_info ();

	// implemented method from MissingInfo
	// Отсутствующий объект содержится только в одном блоке (базе) - необходимо для правильного
	// постоения сообщения о том, в каком(их) блоке(ах) содержится отсутствующий объект.  Если в
	// blocks_info содержится только один блок, то возвращается true, в противном случае false.
	virtual bool is_one_block () const;

	// implemented method from MissingInfo
	// Имя отсутствующего объекта.
	virtual const GCI::IO::String& get_obj_name () const;
	virtual GCI::IO::String& get_obj_name ();
}; // class MissingInfo_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_MISSINGINFO_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
