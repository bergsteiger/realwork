////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/ExternalObjectTypeConvertor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::ExternalObjectTypeConvertor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_EXTERNALOBJECTTYPECONVERTOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_EXTERNALOBJECTTYPECONVERTOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
#include "shared/Core/data/UnsortedTypeConverter.h"
// by <<uses>> dependencies
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/gardefs.h"

namespace GblAdapterLib {

class ExternalObjectTypeConvertor : 
	public Core::UnsortedTypeConverter<long, ExternalObjectType> {
	protected:
		void fill_array () {
			//#UC START# *47A9AFEA0041_FILL_ARRAY_IMPLEMENTATION*
			this->add (::EOT_PIC, EOT_PIC);
			this->add (::EOT_JPG, EOT_JPG);
			this->add (::EOT_PNG, EOT_PNG);
			this->add (::EOT_GIF, EOT_GIF);
			this->add (::EOT_RTF, EOT_RTF);
			this->add (::EOT_XLS, EOT_XLS);
			this->add (::EOT_MP3, EOT_MP3);
			this->add (::EOT_EVD, EOT_EVD);
			this->add (::EOT_PDF, EOT_PDF); 
			this->add (::EOT_TIF, EOT_TIF);
			this->add (::EOT_PPT, EOT_PPT);
			this->add (::EOT_CDR, EOT_CDR);
			this->add (::EOT_DOC, EOT_DOC);
			this->add (::EOT_DOCX, EOT_DOCX);
			this->add (::EOT_XLSX, EOT_XLSX);
			this->add (::EOT_XML, EOT_XML);
			this->add (::EOT_XSD, EOT_XSD);
			//#UC END# *47A9AFEA0041_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class ExternalObjectTypeConvertor

typedef ACE_Singleton<ExternalObjectTypeConvertor, ACE_SYNCH_NULL_MUTEX> ExternalObjectTypeConvertorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_EXTERNALOBJECTTYPECONVERTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

