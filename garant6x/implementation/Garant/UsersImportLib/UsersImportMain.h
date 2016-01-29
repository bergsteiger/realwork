////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/UsersImportLib/UsersImportMain.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> garant6x::UsersImportLib::LibSupport::UsersImportMain
//
// ������ �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_LIBSUPPORT_USERSIMPORTMAIN_H__
#define __GARANT6X_USERSIMPORTLIB_LIBSUPPORT_USERSIMPORTMAIN_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"

//#UC START# *481D6E04016B_CUSTOM_INCLUDES*
//#UC END# *481D6E04016B_CUSTOM_INCLUDES*

// ������ �������� ������

class UsersImportMain : virtual public Core::Root_i::ExecutorBase {
	SET_OBJECT_COUNTER (UsersImportMain)		

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
private:
	REFCOUNT_SINGLETON(UsersImportMain)

public:
	static UsersImportMain& get () {
		return Singleton::instance();
	}		


private:
	static void handle_control (int sig);
	
	void execute_ ();	
	
	void finalize ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:

	// ������� ����������
	virtual void fini () const;

	// ������� ���� � ����������
	virtual void get_path_to_application (std::string& path) const;

	// �������� ������ ���� � ����� � �������
	virtual void get_path_to_datafile (std::string& path) const;

	// ������������� ���������� (GCMManager-�),���������� ��������� ������ ��� ������ ������
	virtual UsersImport::DataWriter* init () const;

	// ��������� ���������� ParamManager
	virtual void init_environment () const;

	// �������� ������������� �������
	virtual void usage () const;


//#UC START# *481D6E04016B*
//#UC END# *481D6E04016B*
}; // class UsersImportMain



#endif //__GARANT6X_USERSIMPORTLIB_LIBSUPPORT_USERSIMPORTMAIN_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
