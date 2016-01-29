////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/LibHome.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Library::Category>> MDProcess::MDAFormat
//
// �������� ������� �������� ������. ������ ��������� � 3-� ������:
// - �����������
// - ������������
// - ���������������
// 
// ������ ����� ����������� ����������� ��������, ��� ����� ���������� � ���� "������� ����"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_H__
#define __MDPROCESS_MDAFORMAT_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace MDAFormat {

class LibHomeFactory {
public:
	static Core::Root::LibHome& get ();
};

class LibHomeImpl : virtual public Core::Root_i::StdLibHomeBase {
	SET_OBJECT_COUNTER (LibHomeImpl)


private:
	friend class LibHomeFactory;
	
	REFCOUNT_SINGLETON(LibHomeImpl)
	
	LibHomeImpl ();

	void registrate_all_factories () const;
	
	void finalize ();
};
} // namespace MDAFormat


#endif //__MDPROCESS_MDAFORMAT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
