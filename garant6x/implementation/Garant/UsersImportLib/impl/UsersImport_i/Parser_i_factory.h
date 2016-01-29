////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Parser_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::Parser_i
// �������� ���������� ������ ��������� DataParser ��� �������� Parser_i
//
// ��������� �������� ������ �������:
// <login><�����������><���><�����������>[password]<�����������>[e-
// mail]<�����������>[using_consulting_status]
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_PARSER_I_FCTR_H__
#define __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_PARSER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImportFactories.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"

namespace UsersImport_i {

/// Interface-factory implementation for Parser_i
class Parser_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public UsersImport::DataParserAbstractFactory
{
public:
	Parser_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	UsersImport::DataParser* make (UsersImport::DataWriter* writer);

};

typedef ::Core::Var<Parser_i_factory> Parser_i_factory_var;

} // namespace UsersImport_i


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_PARSER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

