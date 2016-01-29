////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/StorageStreamOperators.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::NemesisChatImplementation::ChatImplementation::StorageStreamOperators
//
// операторы записи/считывания данных в индексы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_STORAGESTREAMOPERATORS_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_STORAGESTREAMOPERATORS_H__

#include "shared/CoreSrv/sys/std_inc.h"

//#UC START# *4A388C6D0102_USER_INCLUDES*
#include "garantServer/src/Global/Core/GCDC.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/StreamOperatorsPrimitives.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.h"

namespace NdtClone {

	void operator << (Stream& stream, const ChatLibrary::ChatService::MessageType& value) {
		stream << static_cast<int> (value);
	}

	void operator >> (Stream& stream, ChatLibrary::ChatService::MessageType& value) {
		int type;
		stream >> type;
		switch (type) {
			case ChatLibrary::ChatService::MT_UNKNOWN:
				value = ChatLibrary::ChatService::MT_UNKNOWN; break;
			case ChatLibrary::ChatService::MT_TEXT:
				value = ChatLibrary::ChatService::MT_TEXT; break;
			case ChatLibrary::ChatService::MT_EVD:
				value = ChatLibrary::ChatService::MT_EVD; break;
			default: GDS_ASSERT (
						 !"operator >> (Stream& stream, ChatLibrary::ChatService::MessageType& value): Unknown value!"
					 );
		};
	}

	void operator << (Stream& stream, const ChatLibrary::ChatService::MessageText& value) {
		std::string s (reinterpret_cast<const char*> (value.get_buffer ()), value.length ());
		stream << s;
	}

	void operator >> (Stream& stream, ChatLibrary::ChatService::MessageText& value) {
		std::string s;
		stream >> s;
		size_t size = s.size ();

		CORBA::Octet* octet_buffer = GCD::XMLText::allocbuf (size);
		ACE_OS::memcpy (octet_buffer, s.data (), size);
		value.replace (size, size, octet_buffer, 1);
	}

	void operator << (Stream& stream, const ChatLibrary::ChatService::Message& value) {
		stream << value.data.type;
		stream << value.data.text;

		stream << value.meta_data.date;
		stream << value.meta_data.id;
		stream << value.meta_data.receiver;
		stream << value.meta_data.sender;
	}	

	void operator >> (Stream& stream, ChatLibrary::ChatService::Message& value) {
		stream >> value.data.type;
		stream >> value.data.text;

		stream >> value.meta_data.date;
		stream >> value.meta_data.id;
		stream >> value.meta_data.receiver;
		stream >> value.meta_data.sender;
	}	
}
//#UC END# *4A388C6D0102_USER_INCLUDES*

namespace NemesisChatImplementation {
namespace ChatImplementation {

//#UC START# *4A388C6D0102_USER_DEFINITION*
//#UC END# *4A388C6D0102_USER_DEFINITION*

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_STORAGESTREAMOPERATORS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
