////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeContractData_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeContractData_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeContractData_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

//#UC START# *4D38222201AA_CUSTOM_INCLUDES*
//#UC END# *4D38222201AA_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4D38222201AA*
void server_strings_to_adapter (GCI::IO::String_var& adapter, const TAO_Unbounded_String_Sequence& server) {
	std::string adapter_string;
	for (size_t i = 0; i < server.length (); ++i) {
		adapter_string += server[i].in ();
		if (i < (server.length () - 1)) {
			adapter_string += "\n";
		}
	}
	adapter = GCI::IO::StringFactory::make (adapter_string.c_str ());
}
//#UC END# *4D38222201AA*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PrimeContractData_i::PrimeContractData_i (Query* query)
//#UC START# *4D381A3202D6_4D381CAD0282_4D38222201AA_BASE_INIT*
//#UC END# *4D381A3202D6_4D381CAD0282_4D38222201AA_BASE_INIT*
{
	//#UC START# *4D381A3202D6_4D381CAD0282_4D38222201AA_BODY*
	GblPilotQueryDef::Query_var pilot_query (query->build_query ());
	GblPrime::ContractFormData_var data (
		ApplicationHelper::instance ()->get_cached_contract_form ()->get_contract_form_data (pilot_query.in ())
	);

	m_email = GCI::IO::StringFactory::make (data->email.in ());
	m_client_name = GCI::IO::StringFactory::make (data->client_name.in ());
	m_themes_name  = GCI::IO::StringFactory::make (data->themes_name.in ());;
	server_strings_to_adapter (m_info_kind, data->anno_kind);
	server_strings_to_adapter (m_profession, data->anno_user);
	server_strings_to_adapter (m_organisation_type, data->anno_org);
	server_strings_to_adapter (m_area, data->anno_interest);
	server_strings_to_adapter (m_taxes, data->anno_tax);
	//#UC END# *4D381A3202D6_4D381CAD0282_4D38222201AA_BODY*
}

PrimeContractData_i::~PrimeContractData_i () {
	//#UC START# *4D38222201AA_DESTR_BODY*
	//#UC END# *4D38222201AA_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const GCI::IO::String& PrimeContractData_i::get_area () const {
	//#UC START# *4D38308B026F_GET_ACCESSOR*
	return *m_area;
	//#UC END# *4D38308B026F_GET_ACCESSOR*
}

const GCI::IO::String& PrimeContractData_i::get_client_name () const {
	//#UC START# *4D3830BE0091_GET_ACCESSOR*
	return *m_client_name;
	//#UC END# *4D3830BE0091_GET_ACCESSOR*
}

const GCI::IO::String& PrimeContractData_i::get_email () const {
	//#UC START# *4D3830AA0359_GET_ACCESSOR*
	return *m_email;
	//#UC END# *4D3830AA0359_GET_ACCESSOR*
}

const GCI::IO::String& PrimeContractData_i::get_info_kind () const {
	//#UC START# *4D3830B50285_GET_ACCESSOR*
	return *m_info_kind;
	//#UC END# *4D3830B50285_GET_ACCESSOR*
}

const GCI::IO::String& PrimeContractData_i::get_organisation_type () const {
	//#UC START# *4D3830C50334_GET_ACCESSOR*
	return *m_organisation_type;
	//#UC END# *4D3830C50334_GET_ACCESSOR*
}

const GCI::IO::String& PrimeContractData_i::get_profession () const {
	//#UC START# *4D3830D8012D_GET_ACCESSOR*
	return *m_profession;
	//#UC END# *4D3830D8012D_GET_ACCESSOR*
}

const GCI::IO::String& PrimeContractData_i::get_taxes () const {
	//#UC START# *4D3830E30366_GET_ACCESSOR*
	return *m_taxes;
	//#UC END# *4D3830E30366_GET_ACCESSOR*
}

const GCI::IO::String& PrimeContractData_i::get_themes_name () const {
	//#UC START# *4D3830ED01CB_GET_ACCESSOR*
	return *m_themes_name;
	//#UC END# *4D3830ED01CB_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from PrimeContractData
GCI::IO::String& PrimeContractData_i::get_area () {
	return const_cast<GCI::IO::String&>(((const PrimeContractData_i*)this)->get_area ());
}

// implemented method from PrimeContractData
GCI::IO::String& PrimeContractData_i::get_client_name () {
	return const_cast<GCI::IO::String&>(((const PrimeContractData_i*)this)->get_client_name ());
}

// implemented method from PrimeContractData
GCI::IO::String& PrimeContractData_i::get_email () {
	return const_cast<GCI::IO::String&>(((const PrimeContractData_i*)this)->get_email ());
}

// implemented method from PrimeContractData
// получить шаблон для печатной формы Прайма
GCI::IO::Stream* PrimeContractData_i::get_contract_evd_form () const /*throw (CanNotFindData)*/ {
	//#UC START# *4D38192E0375_4D38222201AA*
	if (m_evd_template.is_nil ()) {
		try {
			GCD::SeqOctet_var evd_template (
				ApplicationHelper::instance ()->
					get_cached_contract_form ()->get_evd_template ()
			);
			m_evd_template = MemoryStreamFactory::make (evd_template.in (), true);
		} catch (GCD::CanNotFindData&) {
			throw CanNotFindData ();
		}
	}

	return Core::IObject::_duplicate (m_evd_template.in ());
	//#UC END# *4D38192E0375_4D38222201AA*
}

// implemented method from PrimeContractData
GCI::IO::String& PrimeContractData_i::get_info_kind () {
	return const_cast<GCI::IO::String&>(((const PrimeContractData_i*)this)->get_info_kind ());
}

// implemented method from PrimeContractData
GCI::IO::String& PrimeContractData_i::get_organisation_type () {
	return const_cast<GCI::IO::String&>(((const PrimeContractData_i*)this)->get_organisation_type ());
}

// implemented method from PrimeContractData
GCI::IO::String& PrimeContractData_i::get_profession () {
	return const_cast<GCI::IO::String&>(((const PrimeContractData_i*)this)->get_profession ());
}

// implemented method from PrimeContractData
GCI::IO::String& PrimeContractData_i::get_taxes () {
	return const_cast<GCI::IO::String&>(((const PrimeContractData_i*)this)->get_taxes ());
}

// implemented method from PrimeContractData
GCI::IO::String& PrimeContractData_i::get_themes_name () {
	return const_cast<GCI::IO::String&>(((const PrimeContractData_i*)this)->get_themes_name ());
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

