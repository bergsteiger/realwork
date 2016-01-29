////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumper_GenArtefacts_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumper::GenArtefacts_i
//
// реализация GenArtefacts
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"

class AbstractDumper;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Сбрасываем данные
void AbstractDumper::GenArtefacts_i::reset () {
	//#UC START# *45C9F37801C5*
	ArtefactSetUnic::iterator it = m_data.begin ();
	ArtefactSetUnic::iterator it_end = m_data.end ();
	for (; it != it_end; ++it) {
		if (it->source_info.source.d_() == AbstractDumper::GST_FILE) {			
			::ace_os_unlink (
				AbstractDumper::create_gen_file_name (
					it->source_info.source.file_name()
				).data ()
			);
		}
		
	}

	typedef std::vector<AbstractDumper::GenArtData> GenArtDataList;
	GenArtDataList arts (m_data.begin (), m_data.end ());
	for (GenArtDataList::iterator it = arts.begin (); it != arts.end (); ++it) {
		const_cast<AbstractDumperBase*>(it->dumper)->clear_metadata ();
	}
	
	m_data.clear();
	m_fake_deleted.clear ();
	//#UC END# *45C9F37801C5*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GenArtefacts
// добавляет в список сгенеррованных артефактов новый
void AbstractDumper::GenArtefacts_i::add (const GenArtData& art) {
	//#UC START# *45964A3E027F_45964CC70250*
	/*if (art.status != AbstractDumper::SS_DEL) {
		for (ArtefactSetUnic::const_iterator it = m_data.begin(); it != m_data.end(); it++) {
			if (it->status == AbstractDumper::SS_DEL) {				
				if (it->source_info.source.file_name () == art.source_info.source.file_name ()) {
					m_fake_deleted.insert (*it);
					m_data.erase (*it);
				}			
			}
		}
	}*/	
	m_data.insert (art);
	//#UC END# *45964A3E027F_45964CC70250*
}

// implemented method from GenArtefacts
// изменяет статус сгенерированного элемента
void AbstractDumper::GenArtefacts_i::change_status (const GenArtData& art, SourceStatus stat) {
	//#UC START# *4632D32502CE_45964CC70250*
	ArtefactSetUnic::iterator f = m_data.find (art);
	if (f != m_data.end()) {
		GenArtData new_art = art;
		new_art.status = stat;
		m_data.erase (f);
		m_data.insert (new_art);				
		
		std::string art_abstract_guid; //идентификатор объекта - для файла - путь, для страницы в К - GUID страницы
		if (new_art.source_info.source.d_() == AbstractDumper::GST_WIKI)  {
			if (new_art.source_info.source.wiki_page () != 0	) {
				//CORBA::String_var it_guid = new_art.source_info.source.wiki_page ()->get_guid ();
				//art_abstract_guid = it_guid;
				art_abstract_guid = new_art.source_info.source.wiki_page ()->get_guid ();
			}
		} else if (new_art.source_info.source.d_() == AbstractDumper::GST_FILE) {
			art_abstract_guid = new_art.source_info.source.file_name ();
		}

		for (ArtefactSetUnic::const_iterator it = m_fake_deleted.begin(); it != m_fake_deleted.end(); it++) {
			if (
				it->source_info.source.d_() == AbstractDumper::GST_FILE
			) {
				if (it->source_info.source.file_name () == art_abstract_guid) {				
					m_fake_deleted.erase (*it);
				}
			} else if (
				it->source_info.source.d_() == AbstractDumper::GST_WIKI
			) {
				if (
					it->source_info.source.wiki_page () != 0
				) {
					//CORBA::String_var it_guid = it->source_info.source.wiki_page ()->get_guid ();
					//if (strcmp (art_abstract_guid.data (), it_guid.in ()) == 0) {
					//	m_fake_deleted.erase (*it);
					//}
					if (it->source_info.source.wiki_page ()->get_guid () == art_abstract_guid) {
						m_fake_deleted.erase (*it);
					}
				}
			}
		}
	}
	//#UC END# *4632D32502CE_45964CC70250*
}

// implemented method from GenArtefacts
// корректирует список сгенернированных артефактов, выделяя псевдо-удаленные
void AbstractDumper::GenArtefacts_i::correct_data () {
	//#UC START# *45D443180148_45964CC70250*	
	bool erased = false;
	for (ArtefactSetUnic::iterator it = m_data.begin(); it != m_data.end(); erased = false) {
		if (it->status == AbstractDumper::SS_DEL) {
			
			std::string it_abstract_guid; //идентификатор объекта - для файла - путь, для страницы в К - GUID страницы
			if (it->source_info.source.d_() == AbstractDumper::GST_WIKI)  {
				if (it->source_info.source.wiki_page () != 0	) {
					//CORBA::String_var it_guid = it->source_info.source.wiki_page ()->get_guid ();
					//it_abstract_guid = it_guid;
					it_abstract_guid = it->source_info.source.wiki_page ()->get_guid ();
				}
			} else if (it->source_info.source.d_() == AbstractDumper::GST_FILE) {
				it_abstract_guid = it->source_info.source.file_name ();
			}

			for (ArtefactSetUnic::const_iterator not_del_it = m_data.begin(); not_del_it != m_data.end(); not_del_it++) {
				if (
					not_del_it->status != AbstractDumper::SS_DEL 
					&& it->source_info.source.d_ () == not_del_it->source_info.source.d_ ()					
				) {
					if (
						not_del_it->source_info.source.d_ () == GST_FILE
					) {
						if (it_abstract_guid == not_del_it->source_info.source.file_name ()) {
							m_fake_deleted.insert (*it);							
							TransactionContainer::instance ()->remove_source (it->source_info);
							m_data.erase (it++);
							erased = true;
							break;
						}
					} else if (
						not_del_it->source_info.source.d_ () == GST_WIKI
					) {
						if (
							not_del_it->source_info.source.wiki_page () != 0
						) {
							/*CORBA::String_var not_del_it_guid = not_del_it->source_info.source.wiki_page ()->get_guid ();
							if (strcmp (it_abstract_guid.data (), not_del_it_guid.in ()) == 0) {
								m_fake_deleted.insert (*it);																
								TransactionContainer::instance ()->remove_source (it->source_info);
								m_data.erase (it++);
								erased = true;
								break;
							}*/
							if (it_abstract_guid == not_del_it->source_info.source.wiki_page ()->get_guid ()) {
								m_fake_deleted.insert (*it);																
								TransactionContainer::instance ()->remove_source (it->source_info);
								m_data.erase (it++);
								erased = true;
								break;
							}
						}
					}
				}
			}
		}
		if (erased == false) {
			++it;
		}
	}
	//#UC END# *45D443180148_45964CC70250*
}

// implemented method from GenArtefacts
// возвращает подмножетсво сгенерированных артефактов по их статусу
AbstractDumper::ArtefactSet* AbstractDumper::GenArtefacts_i::get_by_status (SourceStatus stat) const {
	//#UC START# *4596519701C4_45964CC70250*
	Core::Aptr <ArtefactSet> ret = new ArtefactSet;
	for (ArtefactSetUnic::const_iterator it = m_data.begin(); it != m_data.end(); it++) {
		if (it->status == stat) {
			ret->insert (&(*it));
		}
	}
	return ret._retn();
	//#UC END# *4596519701C4_45964CC70250*
}

// implemented method from GenArtefacts
// возвращает псевдо-удаленные артефакты, как правило это те артефакты, у которых изменился дампер
// или генератор, при этом сам артефакт созранил свое местоположение и имя
AbstractDumper::ArtefactSet* AbstractDumper::GenArtefacts_i::get_fake_deleted () const {
	//#UC START# *45D432CD001F_45964CC70250*
	Core::Aptr <ArtefactSet> ret = new ArtefactSet;
	for (ArtefactSetUnic::const_iterator it = m_fake_deleted.begin(); it != m_fake_deleted.end(); it++) {	
			ret->insert (&(*it));		
	}
	return ret._retn();
	//#UC END# *45D432CD001F_45964CC70250*
}

// implemented method from GenArtefacts
// восстанавливает артефакт (новый\изменный\удаленный)
void AbstractDumper::GenArtefacts_i::restore (const GenArtData& art) {
	//#UC START# *45964C930241_45964CC70250*
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx  sw (GDS_CURRENT_FUNCTION);
#endif
	ArtefactSetUnic::iterator f = m_data.find (art);
	if (f != m_data.end()) {
		std::string art_abstract_guid; //идентификатор объекта - для файла - путь, для страницы в К - GUID страницы
		if (f->source_info.source.d_() == AbstractDumper::GST_FILE) {			
			::ace_os_unlink (
				AbstractDumper::create_gen_file_name (
					f->source_info.source.file_name()
				).data ()
			);
			art_abstract_guid = f->source_info.source.file_name ();
		} else if (f->source_info.source.d_() == AbstractDumper::GST_WIKI) {
			if (f->source_info.source.wiki_page () != 0) {
				//CORBA::String_var art_guid = f->source_info.source.wiki_page ()->get_guid ();
				//art_abstract_guid = art_guid;
				art_abstract_guid = f->source_info.source.wiki_page ()->get_guid ();
				f->source_info.source.wiki_page ()->rollback_all_changes ();				
			}
		}
		TransactionContainer::instance ()->remove_source (f->source_info);
		if (f->status != AbstractDumper::SS_NEW) {
			GenArtData new_art = art;
			new_art.status = AbstractDumper::SS_EQ;
			m_data.erase (art);
			m_data.insert (new_art);
		} else {
			m_data.erase (art);
		}
		bool erased = false;
		for (ArtefactSetUnic::iterator it = m_fake_deleted.begin(); it != m_fake_deleted.end(); erased = false) {
			if (
				it->source_info.source.d_() == AbstractDumper::GST_FILE
			) {
				if (it->source_info.source.file_name () == art_abstract_guid) {				
					m_fake_deleted.erase (it++);
					erased = true;
				}
			} else if (
				it->source_info.source.d_() == AbstractDumper::GST_WIKI
			) {
				if (
					it->source_info.source.wiki_page () != 0
				) {
					/*CORBA::String_var it_guid = it->source_info.source.wiki_page ()->get_guid ();
					if (strcmp (art_abstract_guid.data (), it_guid.in ()) == 0) {
						m_fake_deleted.erase (it++);
						erased = true;
					}*/
					if (art_abstract_guid == it->source_info.source.wiki_page ()->get_guid ()) {
						m_fake_deleted.erase (it++);
						erased = true;
					}
				}
			}
			if (erased == false) {
				++it;
			}
		}
	}
	//#UC END# *45964C930241_45964CC70250*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

