////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/JournalBookmark_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::JournalBookmark_i
// �������� ���������� ������ ��������� JournalBookmark ��� �������� JournalBookmark_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_JOURNALBOOKMARK_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_JOURNALBOOKMARK_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for JournalBookmark_i
class JournalBookmark_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public JournalBookmarkAbstractFactory
{
public:
	JournalBookmark_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	JournalBookmark* make (ObjectId doc_id, ParaId para_id);

	JournalBookmark* make (GblUserJournal::JournalBookmark* journal_bookmark);

};

typedef ::Core::Var<JournalBookmark_i_factory> JournalBookmark_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_JOURNALBOOKMARK_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

