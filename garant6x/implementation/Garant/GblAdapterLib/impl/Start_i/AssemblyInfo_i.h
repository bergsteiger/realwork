////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/AssemblyInfo_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::AssemblyInfo_i
// Заголовок реализации класса серванта для интерфеса AssemblyInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_START_I_ASSEMBLYINFO_I_H__
#define __GARANT6X_GBLADAPTERLIB_START_I_ASSEMBLYINFO_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/data/UnsortedTypeConverter.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"

//#UC START# *46091A1F033C_CUSTOM_INCLUDES*
//#UC END# *46091A1F033C_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class AssemblyInfo_i; // self forward Var
typedef ::Core::Var<AssemblyInfo_i> AssemblyInfo_i_var;
typedef ::Core::Var<const AssemblyInfo_i> AssemblyInfo_i_cvar;

class AssemblyInfo_i_factory;

class AssemblyInfo_i:
	virtual public AssemblyInfo
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AssemblyInfo_i)
	friend class AssemblyInfo_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:

	class ServerCapacityConverter : 
		public Core::UnsortedTypeConverter<GCD::Capacity, Capacity> {
		protected:
			void fill_array () {
				//#UC START# *4AFC2355023D_FILL_ARRAY_IMPLEMENTATION*
				this->add (GCD::C_32, C_32);
				this->add (GCD::C_64, C_64);
				//#UC END# *4AFC2355023D_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class ServerCapacityConverter

	typedef ACE_Singleton<ServerCapacityConverter, ACE_SYNCH_NULL_MUTEX> ServerCapacityConverterSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AssemblyInfo_i ();

	virtual ~AssemblyInfo_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from AssemblyInfo
	virtual bool get_first_start () const;

	virtual void set_first_start (bool first_start);

	// implemented method from AssemblyInfo
	virtual bool get_is_commerce () const;

	// implemented method from AssemblyInfo
	virtual bool get_is_debug () const;

	// implemented method from AssemblyInfo
	virtual bool get_is_desktop () const;

	// implemented method from AssemblyInfo
	// Разрядность сервера
	virtual const Capacity get_server_capacity () const;

//#UC START# *46091A1F033C*
//#UC END# *46091A1F033C*
}; // class AssemblyInfo_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_START_I_ASSEMBLYINFO_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
