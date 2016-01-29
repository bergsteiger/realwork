////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/SplashScreen_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::SplashScreen_i
// Заголовок реализации класса серванта для интерфеса SplashScreen
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_SPLASHSCREEN_I_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_SPLASHSCREEN_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalObject_i.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"

//#UC START# *45EE7F5603BF_CUSTOM_INCLUDES*
//#UC END# *45EE7F5603BF_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class SplashScreen_i; // self forward Var
typedef ::Core::Var<SplashScreen_i> SplashScreen_i_var;
typedef ::Core::Var<const SplashScreen_i> SplashScreen_i_cvar;

class SplashScreen_i_factory;

class SplashScreen_i:
	virtual public SplashScreen
	, virtual public ExternalObject_i
{
	SET_OBJECT_COUNTER (SplashScreen_i)
	friend class SplashScreen_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SplashScreen_i (bool is_start, short x, short y, bool flash_available);

	virtual ~SplashScreen_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GblPilotDef::SplashImageInfo_var m_splash_image_info;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from SplashScreen
	virtual const GCI::IO::String* get_owner () const;

	// implemented method from SplashScreen
	virtual const GCI::IO::String* get_owner_caption () const;

	// implemented method from SplashScreen
	virtual short get_show_time () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from ExternalObject
	// Указатель на буфер с данными.
	virtual const void* get_data_pointer () const;
	virtual void* get_data_pointer ();

	// overloaded method from ExternalObject
	// Общий размер возвращаемых данных.
	virtual unsigned long get_data_size () const;

	// overloaded method from ExternalObject
	virtual ExternalObjectType get_data_type () const;

	// overloaded method from ExternalObject
	// Имя внешнего объекта.
	virtual const GCI::IO::String* get_name () const;


//#UC START# *45EE7F5603BF*
//#UC END# *45EE7F5603BF*
}; // class SplashScreen_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_SPLASHSCREEN_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
