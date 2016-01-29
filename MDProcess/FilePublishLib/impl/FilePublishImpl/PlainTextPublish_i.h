////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/FilePublishLib/impl/FilePublishImpl/PlainTextPublish_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::FilePublishLib::FilePublishImpl::PlainTextPublish_i
// ��������� ���������� ������ �������� ��� ��������� PlainTextPublish
//
// ��������� ���� � ���� � ��������� ���
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXTPUBLISH_I_H__
#define __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXTPUBLISH_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/FilePublishLib/FilePublish/FilePublish.h"

namespace FilePublishLib {
namespace FilePublishImpl {

class PlainTextPublish_i; // self forward Var
typedef ::Core::Var<PlainTextPublish_i> PlainTextPublish_i_var;
typedef ::Core::Var<const PlainTextPublish_i> PlainTextPublish_i_cvar;

class PlainTextPublish_i_factory;

// ��������� ���� � ���� � ��������� ���
class PlainTextPublish_i:
	virtual public FilePublish::PlainTextPublish
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PlainTextPublish_i)
	friend class PlainTextPublish_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PlainTextPublish_i ();

	virtual ~PlainTextPublish_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from FilePublish::PlainTextPublish
	// ��������� ��������� ���� ��� ��������� ��������������� �����
	virtual void post_as_functional_test (const std::string& file_path, const std::string& page_id);
}; // class PlainTextPublish_i

} // namespace FilePublishImpl
} // namespace FilePublishLib


#endif //__MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXTPUBLISH_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
