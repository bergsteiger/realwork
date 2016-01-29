////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/FileReader_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::FileReader_i
// ��������� ���������� ������ �������� ��� ��������� DataReader
//
// ���������� ������ ������ �� ��������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_FILEREADER_I_H__
#define __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_FILEREADER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"

namespace UsersImport_i {

class FileReader_i; // self forward Var
typedef ::Core::Var<FileReader_i> FileReader_i_var;
typedef ::Core::Var<const FileReader_i> FileReader_i_cvar;

class FileReader_i_factory;

// ���������� ������ ������ �� ��������� �����
class FileReader_i:
	virtual public UsersImport::DataReader
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (FileReader_i)
	friend class FileReader_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FileReader_i (const std::string& source, UsersImport::DataParser* parser);

	FileReader_i (const std::string& source);

	virtual ~FileReader_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ��������� ������ �� ��������� ���� � �������� �� � ���������
	virtual void read (const char* source, UsersImport::DataParser* parser);

}; // class FileReader_i

} // namespace UsersImport_i


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_FILEREADER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
