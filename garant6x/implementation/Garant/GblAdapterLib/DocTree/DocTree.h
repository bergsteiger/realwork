////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTree.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DocTree
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// EVD-��� ����
typedef unsigned long TagHandle;

class DocNodeFilter;
typedef ::Core::Var<DocNodeFilter> DocNodeFilter_var;
typedef ::Core::Var<const DocNodeFilter> DocNodeFilter_cvar;
// ������ ��� ������ ���� ���������
class DocNodeFilter
	: virtual public FilterForTree
{
public:
	virtual TagHandle get_id () const = 0;

	virtual void set_id (TagHandle id) = 0;

	virtual bool get_inheritable () const = 0;

	virtual void set_inheritable (bool inheritable) = 0;

	virtual NodeType get_type () const = 0;

	virtual void set_type (NodeType type) = 0;
};

/// factory interface for DocNodeFilter
class DocNodeFilterFactory {
public:
	static DocNodeFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ContentsNode;
typedef ::Core::Var<ContentsNode> ContentsNode_var;
typedef ::Core::Var<const ContentsNode> ContentsNode_cvar;
class ContentsNode
	: virtual public NodeBase
{
};

/// factory interface for ContentsNode
class ContentsNodeFactory {
public:
	static ContentsNode* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DocNodeFilter> {
	typedef GblAdapterLib::DocNodeFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ContentsNode> {
	typedef GblAdapterLib::ContentsNodeFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
