////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/DiagramColorizer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::DiagramColorizer
//
// расскрасщик диаграмм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/DiagramColorizer.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструтор.
// \diag - диаграмма, которую нужно расскрасить
DiagramColorizer::DiagramColorizer (IRoseDiagramPtr diag)
//#UC START# *46C595FF003E_BASE_INIT*
: m_diag (diag), m_diag_parent (RoseHelper::get_context (diag))
//#UC END# *46C595FF003E_BASE_INIT*
{
	//#UC START# *46C595FF003E_BODY*
	this->init_notes ();
	//#UC END# *46C595FF003E_BODY*
}

DiagramColorizer::~DiagramColorizer () {
	//#UC START# *46C5941A01C5_DESTR_BODY*
	//#UC END# *46C5941A01C5_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// раскашиваем один элемент на диаграмме
// \elem - элемент, который нужно расскрасить
void DiagramColorizer::colorize (IRoseElementPtr elem) {
	//#UC START# *46C596BD02FD*
	GDS_ASSERT(elem);
	IRoseItemPtr item = RoseHelper::get_nearest_container (elem);
	if (item) {
		//ищем все вью элемента на диаграмме - их может быть несколько
		IRoseItemViewCollectionPtr views = m_diag->ItemViews;
		short views_count = views->Count;
		std::string item_guid (get_rose_element_uid(item));
		for (int i = 1; i <= views_count; i++) {
			IRoseItemViewPtr view = views->GetAt(i);
			if (
				view 
				&& view->Item
				&& get_rose_element_uid(view->Item) == item_guid
			) {
				this->colorize_i (view);
			}
		}
	}
	//#UC END# *46C596BD02FD*
}

// расскрашиваем всю диаграмму
void DiagramColorizer::colorize () {
	//#UC START# *46C596FA02BF*
	IRoseItemViewCollectionPtr views = m_diag->ItemViews;
	short views_count = views->Count;
	for (int i = 1; i <= views_count; i++) {
		IRoseItemViewPtr view = views->GetAt(i);
		if (view && view->Item) {
			this->colorize_i (view);
		}
	}
	//#UC END# *46C596FA02BF*
}

// раскраска вью конкретного элемента на диаграмме
void DiagramColorizer::colorize_i (IRoseItemViewPtr view) {
	//#UC START# *4705D33F02AF*
	GDS_ASSERT(view);
	IRoseItemPtr ri = view->Item;
	if (ri) {
		IRoseItemViewPtr riv = view;
		if (riv) {
			std::string main_guid (get_rose_element_uid(RoseHelper::get_main_model_element ()));
			std::string ri_uid (get_rose_element_uid(ri));
			
			if (riv->Font->Size != 10) {
				riv->Font->Size = 10;
			}
			
			if (riv->Font->Underline != false) {
				riv->Font->Underline = false;
			}
			
			if (ri != NULL) {
				IRoseElementPtr it_cat = RoseHelper::get_context (ri);

				if (ri->IsClass(CATEGORY_TYPE) || ri->IsClass(CLASS_TYPE)) {
					std::string note;
					std::string vt = RoseHelper::get_visibility_type(ri);
					if (vt == "PublicAccess") {						
					} else if (vt == "ProtectedAccess") {
						note = "protected";
					} else if (vt == "PrivateAccess") {
						note = "private";
					} else {
						note = "implement";
					}

					IRoseNoteViewPtr nv;

					NoteMap::iterator f = m_note_map.find (ri_uid);
					if (f != m_note_map.end()) {
						nv = f->second;
						try {
							m_diag->RemoveNoteView (nv);								
						} catch (...) {									
							LOG_E (("Error while exec RemoveNoteView - this is Rose bug, NoteView was deleted anyway"));
						}
						nv = 0;
						m_note_map.erase (ri_uid);
					}
					
					if (note != "") {
						nv = m_diag->AddNoteView (note.data (), 1);
						nv->Font->Size = 8;
						SET_COLOR_RGB (nv->Font, 255, 0, 0);
						RoseHelper::override_property (nv, TOOL_NAME, "LinkedItemGuid", ri_uid.c_str ());
						m_note_map[ri_uid] = nv;
					}
					
					if (nv != 0) {
						if (nv->Text != _bstr_t(note.data())) {
							nv->Text = note.data();
						}

						short x = riv->GetXPosition();
						x -= riv->Width / 2;
						x += 5;

						short y = riv->GetYPosition();
						y += riv->Height / 2;
						y -= nv->Height;
						if (ri->IsClass(CLASS_TYPE)) {
							y += 5;
						}

						if (abs (nv->XPosition - (x + nv->Width/2)) > 2) {
							nv->PutXPosition (x);
						}
						if (abs (nv->YPosition - (y + nv->Height/2)) > 2) {
							nv->PutYPosition (y);
						}
					}
				}
				
				if (
					ri->IsClass(CATEGORY_TYPE) 
					|| ri->IsClass(CLASS_TYPE) 
					|| ri->IsClass ("Association")
				) {
					this->colorize_overwritten_prop (riv);
					NoteMap::iterator f = m_up_note_map.find (ri_uid);
					if (f != m_up_note_map.end()) {
						IRoseNoteViewPtr nv = f->second;						
						if (nv != 0) {
							try {
								m_diag->RemoveNoteView (nv);
							} catch (...) {									
								LOG_E (("Error while exec RemoveNoteView - this is Rose bug, NoteView was deleted anyway"));
							}
							m_up_note_map.erase (ri_uid);
						}
					}
				}

				bool unexist_item;
				if (RoseAbstractDumper::s_gen_tree.ptr()) {
					// look is this item exist to project (has at least one generator)
					IRoseItemPtr cat;
					if (ri->IsClass(CATEGORY_TYPE)) {
						cat = ri;
					} else {
						cat = RoseHelper::get_parent_category(ri);
					}
					std::string merged_sels = cat->GetPropertyValue(TOOL_NAME, PROP_APPLGEN);
					
					if (merged_sels == "none") {
						unexist_item = true;
					} else {
						Core::Var<AbstractDumperBase::GenTreeItem> gen_tree = AbstractDumperBase::GenTreeItem::clone_tree (
							RoseAbstractDumper::s_gen_tree.in()
							, RoseAbstractDumper::s_gen_tree.in()
							, RoseHelper::ParentSelectFilter (cat)
						);

						unexist_item = !gen_tree->has_children();
					}
				} else {
					// template has no one generator defined
					unexist_item = false;
				}
				
				if (ri->IsClass(CLASS_TYPE) || ri->IsClass(CATEGORY_TYPE)) {
					AbstractDumperBase::Template& t = AbstractDumperBase::get_template (AbstractDumperBase::StereotypeID (RoseHelper::get_gen_stereotype(ri)));
					
					if (get_rose_element_uid(it_cat) != get_rose_element_uid(m_diag_parent)) {
						if (ri->IsClass(CLASS_TYPE)) {
							IRoseClassViewPtr rciv = ((IRoseClassViewPtr)riv);
							
							if (t.clrz_iconic_view == AbstractDumperBase::IVT_ST) {
								if (rciv->GetStereotypeDisplay() != 1) {
									rciv->PutStereotypeDisplay(1);
								}
							} else if (t.clrz_iconic_view == AbstractDumperBase::IVT_ICON) {
								if (rciv->GetStereotypeDisplay() != 3) {
									rciv->PutStereotypeDisplay(3);
								}
							} else if (t.clrz_iconic_view == AbstractDumperBase::IVT_DECOR) {
								if (rciv->GetStereotypeDisplay() != 2) {
									rciv->PutStereotypeDisplay(2);
								}
							} else if (t.clrz_iconic_view == AbstractDumperBase::IVT_NONE) {
								if (rciv->GetStereotypeDisplay() != 0) {
									rciv->PutStereotypeDisplay(0);
								}
							}
							if (!rciv->SuppressAttributes) {
								rciv->SuppressAttributes = true;
							}
							if (!rciv->SuppressOperations) {
								rciv->SuppressOperations = true;
							}							
						}
						IRoseElementPtr context = RoseHelper::get_context (ri);
						_bstr_t name = context ? context->Name : "";
						if (!strcmp("Primitives", name)) {
							if (ri->IsClass(CLASS_TYPE)) {
								IRoseClassViewPtr rciv = ((IRoseClassViewPtr)riv);
								if (rciv->Visibility != false) {
									rciv->Visibility = false;
								}
							}
							if (riv->GetStereotypeDisplay() != 0) {
								riv->PutStereotypeDisplay(0);
							}
							SET_COLOR_RGB(riv->LineColor, 225, 225, 225);
							SET_COLOR_RGB(riv->FillColor, 225, 225, 225);
							SET_COLOR_RGB(riv->Font, 200, 10, 10);
							if (!riv->Font->Bold) {
								riv->Font->Bold = true;
							}
						} else if (RoseHelper::get_is_native_with_parent(ri)) {
							SET_COLOR_RGB(riv->LineColor, 225, 225, 225);
							SET_COLOR_RGB(riv->FillColor, 225, 225, 225);
							SET_COLOR_RGB(riv->Font, 200, 10, 10);
							if (riv->Font->Bold) {
								riv->Font->Bold = false;
							}
						} else {
							if (riv->Font->Bold != false) {
								riv->Font->Bold = false;
							}

							SET_COLOR_RGB(riv->FillColor, 255, 255, 255);

							if (t.clrz_forien_line_color.size() >= 3) {
								SET_COLOR(riv->LineColor, t.clrz_forien_line_color);
							} else {
								SET_COLOR_RGB(riv->LineColor, 0, 0, 0);
							}

							if (t.clrz_forien_font_color.size() >= 3) {
								SET_COLOR(riv->Font, t.clrz_forien_font_color);
							} else {
								SET_COLOR_RGB(riv->Font, 0, 0, 0);
							}
							//riv->Height = riv->GetMinHeight ();
							//riv->Width = riv->GetMinWidth ();
							if (ri->IsClass(CLASS_TYPE)) {
								((IRoseClassViewPtr)riv)->AutomaticResize = true;
							}
							riv->Invalidate();
						}						
					} else {
						if (riv->Font->Bold != false) {
							riv->Font->Bold = false;
						}
						if (t.clrz_fill_color.size() >= 3) {
							SET_COLOR(riv->FillColor, t.clrz_fill_color);
						} else {
							SET_COLOR_RGB(riv->FillColor, 255, 255, 204);
						}

						if (t.clrz_line_color.size() >= 3) {
							SET_COLOR(riv->LineColor, t.clrz_line_color);
						} else {
							SET_COLOR_RGB(riv->LineColor, 0, 0, 0);
						}					

						if (t.clrz_font_color.size() >= 3) {
							SET_COLOR(riv->Font, t.clrz_font_color);
						} else {
							SET_COLOR_RGB(riv->Font, 0, 0, 0);
						}

						if (ri->IsClass(CLASS_TYPE)) {
							IRoseClassViewPtr rciv = ((IRoseClassViewPtr)riv);

							if (t.clrz_iconic_view == AbstractDumperBase::IVT_ST) {
								if (rciv->GetStereotypeDisplay() != 1) {
									rciv->PutStereotypeDisplay(1);
								}
							} else if (t.clrz_iconic_view == AbstractDumperBase::IVT_ICON) {
								if (rciv->GetStereotypeDisplay() != 3) {
									rciv->PutStereotypeDisplay(3);
								}
							} else if (t.clrz_iconic_view == AbstractDumperBase::IVT_DECOR) {
								if (rciv->GetStereotypeDisplay() != 2) {
									rciv->PutStereotypeDisplay(2);
								}
							} else if (t.clrz_iconic_view == AbstractDumperBase::IVT_NONE) {
								if (rciv->GetStereotypeDisplay() != 0) {
									rciv->PutStereotypeDisplay(0);
								}
							}
							
							Core::Aptr<GCL::StrSet> enabled_stereotypes = RoseHelper::get_enabled_stereotypes (ri);
							VARIANT_BOOL suppress_attrs = enabled_stereotypes->find (ATTRIBUTE_TYPE) == enabled_stereotypes->end () ? VARIANT_TRUE : VARIANT_FALSE;
							if (rciv->GetSuppressAttributes() != suppress_attrs) {
								rciv->PutSuppressAttributes(suppress_attrs);						
							}

							VARIANT_BOOL suppress_ops = enabled_stereotypes->find (OPERATION_TYPE) == enabled_stereotypes->end () ? VARIANT_TRUE : VARIANT_FALSE;
							if (rciv->GetSuppressOperations() != suppress_ops) {
								rciv->PutSuppressOperations(suppress_ops);						
							}

							if (rciv->GetShowOperationSignature() != VARIANT_TRUE) {
								rciv->PutShowOperationSignature(VARIANT_TRUE);
							}

							IRoseClassDiagramCollectionPtr class_diags = RoseHelper::get_class_diagrams (ri);
							if (class_diags->Count > 0) {
								//у класса есть своя диаграмма классов -
								//делаем цвет линий красным
								SET_COLOR_RGB(riv->LineColor, 255, 80, 120);
							}
						}

						/*IRoseItemViewCollectionPtr sub_views = riv->SubViews;
						short sub_views_count = sub_views->Count;
						for (short i = 0; i <= sub_views_count; ++i) {
							IRoseNoteViewPtr note = sub_views->GetAt (i);
							if (note) {
								std::string text = note->Text;
								std::string searched_text ("(from ");
								searched_text += it_cat->Name;
								searched_text += " )";
								if (text.find ("from") != std::string::npos) {								
									LOG_D (("Raplace text: %s", text.c_str ()));
									note->Text = "!!!";
									note->Invalidate ();
								}
							}
						}*/	
					}				
				} else if (!unexist_item) {
					SET_COLOR_RGB(riv->LineColor, 160, 60, 60);
					SET_COLOR_RGB(riv->FillColor, 255, 200, 200);
					SET_COLOR_RGB(riv->Font, 0, 0, 0);
				}

				if (ri_uid == main_guid) {
					if (!riv->Font->Underline) {
						riv->Font->Underline = true;
					}
				}
				
				if (unexist_item) {
					SET_COLOR_RGB(riv->LineColor, 235, 235, 235);
					SET_COLOR_RGB(riv->FillColor, 245, 245, 245);
					SET_COLOR_RGB(riv->Font, 200, 200, 200);
				}			
			}

			IRoseClassViewPtr rciv = ((IRoseClassViewPtr)riv);
			if (rciv != 0) {
				rciv->AutomaticResize = true;
			} else {
				//if ((IRoseCategoryPtr)riv->Item == 0) {
				//	riv->Height = riv->GetMinHeight();
				//	riv->Width = riv->GetMinWidth();
				//}
			}
			//riv->Invalidate ();
		}//if (view)
	} //if (item)
	//#UC END# *4705D33F02AF*
}

// алгоритм расскраски вью элемента, если у него есть переопределённые свойства
void DiagramColorizer::colorize_overwritten_prop (IRoseItemViewPtr view) {
	//#UC START# *470610EA01A5*
	std::string up_note;
	IRoseItemPtr ri = view->Item;	

	if (ri->IsClass ("Association")) {
		IRoseRolePtr role = ((IRoseAssociationPtr)ri)->Role1;
		if (!role->Navigable) {
			role = ((IRoseAssociationPtr)ri)->Role2;
		}
		ri = role;
		up_note = RoseHelper::get_overwriten_prop (role);
	} else {
		up_note = RoseHelper::get_overwriten_prop (ri);
	}
	
	std::string ri_name = ri->Name;
	IRoseItemViewCollectionPtr sub_views = view->SubViews;
	short sub_views_count = sub_views->Count;
	for (short i = 0; i <= sub_views_count; ++i) {
		IRoseNoteViewPtr note = sub_views->GetAt (i);
		if (note) {			
			std::string text = note->Text;
			if (up_note.empty () == false) {
				if (text == ri_name) {				
					note->Text = RoseHelper::create_label_name (ri_name).c_str ();
				}
			} else {
				std::string name = RoseHelper::extract_name_from_label (text);				
				if (name != text) {
					note->Text = name.c_str ();
				}
			}
		}
	}
	//#UC END# *470610EA01A5*
}

// инициализирует мапы Нот
void DiagramColorizer::init_notes () {
	//#UC START# *46C5967702FD*
	// find all linked notes
	IRoseNoteViewCollectionPtr note_views = m_diag->GetNoteViews ();
	short note_views_count = note_views->Count;
	for (int i = 1; i <= note_views_count; i++) {
		IRoseNoteViewPtr rnv = note_views->GetAt(i);
		if (rnv != 0 && rnv->Item == 0) {
			std::string linked_guid ((const char*)rnv->GetPropertyValue(TOOL_NAME, "LinkedItemGuid"));
			if (linked_guid != "") {
				if (rnv->GetNoteViewType() == 1) {
					m_note_map[linked_guid] = rnv;
				} else {
					m_up_note_map[linked_guid] = rnv;
				}
			}
		}
	}
	//#UC END# *46C5967702FD*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

