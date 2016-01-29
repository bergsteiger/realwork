////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/OnDemandFile.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::data::OnDemandFile
//
// обвязка над std::ofstream, создающая выходной файл, только при первом к нему обращении
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_ONDEMANDFILE_H__
#define __SHARED_GCL_DATA_ONDEMANDFILE_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *450135840290_USER_INCLUDES*
#include <fstream>
#include <string>
//#UC END# *450135840290_USER_INCLUDES*

namespace GCL {

//#UC START# *450135840290_USER_DEFINITION*
class OnDemandFile : public std::ofstream {
	int m_mode;
	std::string m_file_name;
	bool m_is_file_open;	

public:
	class FileOpenError : public std::exception {
	};

	OnDemandFile (std::string file_name, int mode) 
		: m_file_name (file_name)
		, m_mode (mode)
		, m_is_file_open (false)
	{
	};

	void check_open () {
		if (!m_is_file_open) {
			open (m_file_name.data(), m_mode);
			if (!is_open()) throw FileOpenError();
			else m_is_file_open = true;
		}
	}
};

}; //GCL

// INSERTERS
inline GCL::OnDemandFile& __cdecl operator<< (GCL::OnDemandFile& _O, std::string _S) {
	_O.check_open ();
	std::ofstream* stdf = &_O;
	(*stdf) << _S.data();
	return (_O); 
};

template<class _E> 
inline GCL::OnDemandFile& __cdecl operator<< (GCL::OnDemandFile& _O, _E _C) {
	_O.check_open ();
	std::ofstream* stdf = &_O;
	(*stdf) << _C;
	return (_O); 
};

namespace GCL {
//#UC END# *450135840290_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_DATA_ONDEMANDFILE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
