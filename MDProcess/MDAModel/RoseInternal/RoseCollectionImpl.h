////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseCollectionImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseInternal::RoseCollectionImpl
//
// реализация розовской коллекции элементов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECOLLECTIONIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECOLLECTIONIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"

//#UC START# *4A3F27DE02A2_USER_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include <comdef.h>
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include <set>
//#UC END# *4A3F27DE02A2_USER_INCLUDES*

namespace RoseInternal {

//#UC START# *4A3F27DE02A2_USER_DEFINITION*
template <class Type> struct UniqueIDExctractor;
template <class Type> struct NameExtractor;

template <class Type>
struct UniqueIDExctractor {
	_COM_SMARTPTR_TYPEDEF(Type, __uuidof(Type));
	
	_bstr_t operator () (const TypePtr& obj) const {
		return get_rose_element_uid(obj).c_str ();
	}
};

template <>
struct UniqueIDExctractor<IRoseProperty> {
	_bstr_t operator () (const IRosePropertyPtr& obj) const {
		return obj->GetName ();
	}
};

template <class Type>
struct NameExtractor {
	_COM_SMARTPTR_TYPEDEF(Type, __uuidof(Type));
	
	_bstr_t operator () (const TypePtr& obj) const {
		return obj->GetName ();
	}
};

template <class ElementType>
class ElementWrapper {
public:
	_COM_SMARTPTR_TYPEDEF(ElementType, __uuidof(ElementType));

	ElementWrapper (const ElementTypePtr& elem) : element (elem) {};
	
	_bstr_t get_uid () const {
		return uid_extractor (element);
	}

	_bstr_t get_name () const {
		return name_extractor (element);
	}
	
	typename UniqueIDExctractor<ElementType> uid_extractor;
	typename NameExtractor<ElementType> name_extractor;

	ElementTypePtr element;	
};

template <class T1, class T2>
bool operator < (
	const typename ElementWrapper<T1>& x
	, const typename ElementWrapper<T2>& y
) {
	return x.get_uid () < y.get_uid ();
}


template <class CollectionType, class ElementType, typename Comparator = std::less<typename ElementWrapper<ElementType> > >
class RoseCollectionImpl:
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>
	, public ATL::CComCoClass<typename RoseCollectionImpl<CollectionType, ElementType> >
	, public ATL::IDispatchImpl<CollectionType, &__uuidof(CollectionType)>
{
	typedef typename RoseCollectionImpl<CollectionType, ElementType> ThisClass;
	SET_OBJECT_COUNTER (ThisClass)

public:	
	typedef typename ElementWrapper<ElementType>::ElementTypePtr ElementTypePtr;

	DECLARE_PROTECT_FINAL_CONSTRUCT()
	
	BEGIN_COM_MAP(ThisClass)
		COM_INTERFACE_ENTRY(CollectionType)
		COM_INTERFACE_ENTRY(IDispatch)
	END_COM_MAP()

	STDMETHODIMP Invoke(DISPID id, REFIID , LCID , WORD Flags, DISPPARAMS *DispParams, VARIANT* Result, EXCEPINFO* pe, UINT* pu);

private:
	typedef std::set < typename ElementWrapper<ElementType>, Comparator> ElementTypeCollection;
	//typedef RoseElementSet ElementTypeCollection;
	ElementTypeCollection m_impl;
};
//#UC END# *4A3F27DE02A2_USER_DEFINITION*

} // namespace RoseInternal

#include "MDProcess/MDAModel/RoseInternal/RoseCollectionImpl.i.h"

#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECOLLECTIONIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
