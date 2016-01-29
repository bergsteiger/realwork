////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/FileReader_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::FileReader_i
//
// ���������� ������ ������ �� ��������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/FileReader_i_factory.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/FileReader_i.h"

namespace UsersImport_i {

FileReader_i_factory::FileReader_i_factory () {
}

void FileReader_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	UsersImport::DataReaderFactoryManager::register_factory (this, priority);
}

const char* FileReader_i_factory::key () const {
	return "FileReader_i";
}

UsersImport::DataReader* FileReader_i_factory::make (const std::string& source, UsersImport::DataParser* parser) {
	FileReader_i_var ret = new FileReader_i (source, parser);
	return ret._retn ();
}

UsersImport::DataReader* FileReader_i_factory::make (const std::string& source) {
	FileReader_i_var ret = new FileReader_i (source);
	return ret._retn ();
}

} // namespace UsersImport_i

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

