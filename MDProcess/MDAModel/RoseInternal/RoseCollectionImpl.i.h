////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseCollectionImpl.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseInternal::RoseCollectionImpl
// Файл inline реализации утилитного набора RoseCollectionImpl
//
// реализация розовской коллекции элементов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//#UC START# *4A3F27DE02A2_CUSTOM_INCLUDES*
//#UC END# *4A3F27DE02A2_CUSTOM_INCLUDES*

namespace RoseInternal {

//#UC START# *4A3F27DE02A2*
template <class CollectionType, class ElementType, typename Comparator>
STDMETHODIMP RoseCollectionImpl<CollectionType, ElementType, Comparator>::Invoke(DISPID id, REFIID , LCID , WORD Flags, DISPPARAMS *DispParams, VARIANT* Result, EXCEPINFO* pe, UINT* pu) {
	switch(id) {
        case 202:
            if ( (Flags & DISPATCH_PROPERTYPUT) != 0) {
                // Count: Put Property
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                short par__x;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_I2)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_I2) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_I2(&x);
				} else {
					par__x = V_I2(&DispParams->rgvarg[0]);
				}
                
                return DISP_E_MEMBERNOTFOUND;

            } else if ( (Flags & DISPATCH_PROPERTYGET) != 0) {
                // Count: Get Property
                if (DispParams->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  short GetCount();
                */
                if (Result) {
                    V_I2(Result) = m_impl.size ();
                    V_VT(Result) = VT_I2;
                } else {
                    m_impl.size ();
                }
                return S_OK;

            } 
            break;
        case 203:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // GetAt: Method
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                short par_Index;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_I2)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_I2) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_Index = V_I2(&x);
				} else {
					par_Index = V_I2(&DispParams->rgvarg[0]);
				}
                /*
                  com_ptr<IRoseInheritRelation> GetAt(short par_Index);
                */
                if (Result) {
					if ((size_t)par_Index > m_impl.size ()) {
						return DISP_E_BADINDEX;
					}
					
					size_t i = 1;
					ElementTypePtr obj;
					for (ElementTypeCollection::const_iterator it = m_impl.begin (); it != m_impl.end (); ++it) {
						if (i >= (size_t)par_Index) {
							obj = it->element;
							break;
						}
						++i;
					}
					
                    V_DISPATCH(Result) = obj.Detach ();
                    V_VT(Result) = VT_DISPATCH;
                }
                return S_OK;

            } 
            break;
        case 204:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // Exists: Method
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par_pObject;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_pObject = V_DISPATCH(&x);
				} else {
					par_pObject = V_DISPATCH(&DispParams->rgvarg[0]);
				}
                /*
                  bool Exists(const com_ptr<IRoseInheritRelation>& par_pObject);
                */
				ElementTypePtr obj;
				par_pObject->QueryInterface (&obj);
				ElementTypeCollection::value_type elem (obj);
				bool exist = m_impl.find (elem) != m_impl.end ();
               
				if (Result) {
					V_BOOL(Result) = exist ? VARIANT_TRUE : VARIANT_FALSE;
                    V_VT(Result) = VT_BOOL;
                }
                return S_OK;

            } 
            break;
        case 205:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // FindFirst: Method
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                _bstr_t par_Name;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_BSTR) {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_Name = V_BSTR(&x);
				} else {
					par_Name = V_BSTR(&DispParams->rgvarg[0]);
				}
                /*
                  short FindFirst(const bstr_t& par_Name);
                */
				size_t founded_index = 0;
				size_t i = 1;
				for (ElementTypeCollection::const_iterator it = m_impl.begin (); it != m_impl.end (); ++it) {
					if (it->get_name () == par_Name) {
						founded_index = i;
						break;
					}
					++i;
				}
                if (Result) {
                    V_I2(Result) = i;
                    V_VT(Result) = VT_I2;
                }
                return S_OK;

            } 
            break;
        case 206:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // FindNext: Method
                if (DispParams->cArgs != 2) return DISP_E_BADPARAMCOUNT;

                short par_iCurID;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[1]) != VT_I2)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[1], 0, VT_I2) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_iCurID = V_I2(&x);
				} else {
					par_iCurID = V_I2(&DispParams->rgvarg[1]);
				}
                _bstr_t par_Name;
				VARIANT y;
                if (V_VT(&DispParams->rgvarg[0]) != VT_BSTR)
                {
                    if ( VariantChangeType(&y, &DispParams->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_Name = V_BSTR(&y);
				} else {
					par_Name = V_BSTR(&DispParams->rgvarg[0]);
				}
                /*
                  short FindNext(short par_iCurID, const bstr_t& par_Name);
                */
				size_t i = 1;
				ElementTypeCollection::const_iterator it = m_impl.begin ();
				ElementTypeCollection::const_iterator it_end = m_impl.end ();
				for (; it != it_end && (i < (size_t)par_iCurID); ++it, ++i) {
					if ((++i) >= (size_t)(par_iCurID)) {
						break;
					}
				}

				size_t founded_index = 0;
				for (; it != it_end; ++it) {
					if (it->get_name () == par_Name) {				
						founded_index = i;
						break;
					}
					++i;
				}
                if (Result) {
                    V_I2(Result) = (short)founded_index;
                    V_VT(Result) = VT_I2;
                }
                return S_OK;

            } 
            break;
        case 207:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // IndexOf: Method
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par_theObject;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_theObject = V_DISPATCH(&x);
				} else {
					par_theObject = V_DISPATCH(&DispParams->rgvarg[0]);
				}
                /*
                  short IndexOf(const com_ptr<IRoseInheritRelation>& par_theObject);
                */
				ElementTypePtr obj;
				par_theObject->QueryInterface (&obj);

				short index = 0;
				ElementTypeCollection::value_type elem (obj);
				ElementTypeCollection::iterator it = m_impl.find (elem);
				if (it != m_impl.end ()) {
					index = std::distance (it, m_impl.begin ()) + 1;
				}

                if (Result) {
                    V_I2(Result) = index;
                    V_VT(Result) = VT_I2;
                }
                return S_OK;

            } 
            break;
        case 208:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // Add: Method
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par_theObject;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_theObject = V_DISPATCH(&x);
				} else {
					par_theObject = V_DISPATCH(&DispParams->rgvarg[0]);
				}
				ElementTypePtr obj;
				par_theObject->QueryInterface (&obj);
                /*
                  void Add(const com_ptr<IRoseInheritRelation>& par_theObject);
                */
				ElementTypeCollection::value_type elem (obj);
				m_impl.insert (elem);
                return S_OK;

            } 
            break;
        case 209:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // AddCollection: Method
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par_theCollection;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_theCollection = V_DISPATCH(&x);
				} else {
					par_theCollection = V_DISPATCH(&DispParams->rgvarg[0]);
				}
                /*
                  void AddCollection(const com_ptr<IRoseInheritRelationCollection>& par_theCollection);
                */

                return DISP_E_MEMBERNOTFOUND;

            } 
            break;
        case 210:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // Remove: Method
                 if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par_theObject;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_theObject = V_DISPATCH(&x);
				} else {
					par_theObject = V_DISPATCH(&DispParams->rgvarg[0]);
				}
				ElementTypePtr obj;
				par_theObject->QueryInterface (&obj);
                /*
                  void Remove(const com_ptr<IRoseInheritRelation>& par_theObject);
                */
				ElementTypeCollection::value_type elem (obj);
				m_impl.erase (elem);
                return S_OK;

            } 
            break;
        case 211:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // RemoveAll: Method
                if (DispParams->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  void RemoveAll();
                */
				m_impl.clear ();
                return S_OK;

            } 
            break;
        case 212:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // GetFirst: Method
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                _bstr_t par_Name;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_BSTR)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_Name = V_BSTR(&x);
				} else {
					par_Name = V_BSTR(&DispParams->rgvarg[0]);
				}
                /*
                  com_ptr<IRoseInheritRelation> GetFirst(const bstr_t& par_Name);
                */
				ElementTypePtr founded_obj;
				for (ElementTypeCollection::const_iterator it = m_impl.begin (); it != m_impl.end (); ++it) {
					if (it->get_name () == par_Name) {
						founded_obj = it->element;
						break;
					}
				}
                if (Result) {
                    V_DISPATCH(Result) = founded_obj.Detach ();
                    V_VT(Result) = VT_DISPATCH;
                }
                return S_OK;

            } 
            break;
        case 213:
            if ( (Flags & DISPATCH_METHOD) != 0) {
                // GetWithUniqueID: Method
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                _bstr_t par_UniqueID;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_BSTR)
                {
                   if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_UniqueID = V_BSTR(&x);
				} else {
					par_UniqueID = V_BSTR(&DispParams->rgvarg[0]);
				}
                /*
                  com_ptr<IRoseInheritRelation> GetWithUniqueID(const bstr_t& par_UniqueID);
                */
				
				ElementTypePtr founded_obj;
				for (ElementTypeCollection::const_iterator it = m_impl.begin (); it != m_impl.end (); ++it) {
					if (it->get_uid () == par_UniqueID) {
						founded_obj = it->element;
						break;
					}
				}
                if (Result) {
                    V_DISPATCH(Result) = founded_obj.Detach ();
                    V_VT(Result) = VT_DISPATCH;
                }
                return S_OK;

            } 
            break;
        default:
                return DISP_E_MEMBERNOTFOUND;
        }
	return S_OK;
}
//#UC END# *4A3F27DE02A2*

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

