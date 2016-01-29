////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeContractData_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeContractData_i
// Заголовок реализации класса серванта для интерфеса PrimeContractData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMECONTRACTDATA_I_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMECONTRACTDATA_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/Prime.h"

//#UC START# *4D38222201AA_CUSTOM_INCLUDES*
//#UC END# *4D38222201AA_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class PrimeContractData_i; // self forward Var
typedef ::Core::Var<PrimeContractData_i> PrimeContractData_i_var;
typedef ::Core::Var<const PrimeContractData_i> PrimeContractData_i_cvar;

class PrimeContractData_i_factory;

class PrimeContractData_i:
	virtual public PrimeContractData
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PrimeContractData_i)
	friend class PrimeContractData_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PrimeContractData_i (Query* query);

	virtual ~PrimeContractData_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCI::IO::String_var m_area;

	GCI::IO::String_var m_client_name;

	GCI::IO::String_var m_email;

	mutable MemoryStream_var m_evd_template;

	GCI::IO::String_var m_info_kind;

	GCI::IO::String_var m_organisation_type;

	GCI::IO::String_var m_profession;

	GCI::IO::String_var m_taxes;

	GCI::IO::String_var m_themes_name;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	const GCI::IO::String& get_area () const;

	virtual const GCI::IO::String& get_client_name () const;

	virtual const GCI::IO::String& get_email () const;

	virtual const GCI::IO::String& get_info_kind () const;

	virtual const GCI::IO::String& get_organisation_type () const;

	virtual const GCI::IO::String& get_profession () const;

	virtual const GCI::IO::String& get_taxes () const;

	virtual const GCI::IO::String& get_themes_name () const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from PrimeContractData
	virtual GCI::IO::String& get_area ();

	// implemented method from PrimeContractData
	virtual GCI::IO::String& get_client_name ();

	// implemented method from PrimeContractData
	virtual GCI::IO::String& get_email ();

	// implemented method from PrimeContractData
	// получить шаблон для печатной формы Прайма
	virtual GCI::IO::Stream* get_contract_evd_form () const /*throw (CanNotFindData)*/;

	// implemented method from PrimeContractData
	virtual GCI::IO::String& get_info_kind ();

	// implemented method from PrimeContractData
	virtual GCI::IO::String& get_organisation_type ();

	// implemented method from PrimeContractData
	virtual GCI::IO::String& get_profession ();

	// implemented method from PrimeContractData
	virtual GCI::IO::String& get_taxes ();

	// implemented method from PrimeContractData
	virtual GCI::IO::String& get_themes_name ();

//#UC START# *4D38222201AA*
//#UC END# *4D38222201AA*
}; // class PrimeContractData_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMECONTRACTDATA_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
