////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Utility/DataLoader.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::DBExt::Utility::DataLoader
//
// Загрузка данных из индексов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/DBExt/Utility/DataLoader.h"

namespace DBExt {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// загрузка списка строк
void DataLoader::load (DBCore::IIndex* index, const void* key, GCL::StrVector& out) {
	//#UC START# *4EB2706801ED*
	size_t size = 0;

	DBCore::IBuffer_var buf = index->read (key, 0, size);

	if (size) {
		std::string item;

		const char* ptr = buf->get ();

		for (size_t i = 0; i < size; i += item.size () + 1) {
			item = ptr + i;
			out.push_back (item);
		}
	}
	//#UC END# *4EB2706801ED*
}

// загрузка списка документов
void DataLoader::load (DBCore::IIndex* index, const void* key, DBCore::DocVector& out) {
	//#UC START# *4EB7CA19011B*
	if (index) {
		DBCore::Store* str = index->open_stream (key, 0);

		if (str) {
			DataLoader::read (str, out);
			index->close_stream (str);
		}
	}
	//#UC END# *4EB7CA19011B*
}

// загрузка списка документов
void DataLoader::load_ (DBCore::IIndex* index, const void* key, int sn, DBCore::DocVector& out) {
	//#UC START# *4EB7C9A40016*
	if (index) {
		DBCore::Store* str = index->key_open (key, sn);

		if (str) {
			DataLoader::read (str, out);
			index->close_stream (str);
		}
	}
	//#UC END# *4EB7C9A40016*
}

// загрузка списка документов
void DataLoader::load_refs (DBCore::IIndex* index, const void* key, DBCore::DocVector& out) {
	//#UC START# *4EB7C97100A1*
	if (index) {
		DBCore::Store* str = index->open_stream (key, 0);

		if (str) {
			DataLoader::load_refs (str, out);
			index->close_stream (str);
		}

	}
	//#UC END# *4EB7C97100A1*
}

// загрузка списка документов
void DataLoader::load_refs (DBCore::Store* store, DBCore::DocVector& out) {
	//#UC START# *4EB7CA680325*
	struct FakeRef {
		long id;
		long sub;
	};

	size_t type_size = sizeof (FakeRef);

	size_t size = (size_t) store->Length (), count = size / type_size;

	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > buf = new char [size];
	store->Read (buf.inout (), size);

	out.resize (count);

	DBCore::DocVector::iterator it = out.begin (), it_end = out.end ();

	for (char* ptr = buf.ptr (); it != it_end; ++it, ptr += type_size) {
		*it = ((FakeRef*) ptr)->id;
	}
	//#UC END# *4EB7CA680325*
}

// загрузка списка документов
void DataLoader::load_refs_ (DBCore::IIndex* index, const void* key, DBCore::DocVector& out) {
	//#UC START# *4EB7C9220106*
	if (index) {
		DBCore::Store* str = index->key_open (key, 0);

		if (str) {
			DataLoader::load_refs (str, out);
			index->close_stream (str);
		}
	}
	//#UC END# *4EB7C9220106*
}

// загрузка списка документов
void DataLoader::read (DBCore::Store* store, DBCore::DocVector& out) {
	//#UC START# *4EB270E60391*
	size_t count = (size_t) store->Length () / sizeof (long);

	Core::Aptr <long, Core::ArrayDeleteDestructor <long> > buf =  new long [count + 1];
	store->Read (buf.inout (), store->Length ());

	out.insert (out.begin (), buf.ptr (), buf.ptr () + count);
	//#UC END# *4EB270E60391*
}

} // namespace DBExt

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

