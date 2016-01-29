////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Parser_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::Parser_i
//
// ��������� �������� ������ �������:
// <login><�����������><���><�����������>[password]<�����������>[e-
// mail]<�����������>[using_consulting_status]
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Parser_i_factory.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Parser_i.h"

namespace UsersImport_i {

Parser_i_factory::Parser_i_factory () {
}

void Parser_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	UsersImport::DataParserFactoryManager::register_factory (this, priority);
}

const char* Parser_i_factory::key () const {
	return "Parser_i";
}

UsersImport::DataParser* Parser_i_factory::make (UsersImport::DataWriter* writer) {
	Parser_i_var ret = new Parser_i (writer);
	return ret._retn ();
}

} // namespace UsersImport_i

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

