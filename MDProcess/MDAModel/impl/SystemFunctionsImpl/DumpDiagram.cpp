////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/DumpDiagram.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::DumpDiagram
//
// реализация встроенной функции генератора "_dump_diagram".
// _dump_diagram(«параметр») - пытается сдампить параметр как диаграмму - добавляя её в качестве
// атача к текущей странице
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/DumpDiagram.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "boost/lexical_cast.hpp"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DumpDiagram::DumpDiagram ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE8E50142_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE8E50142_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE8E50142_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE8E50142_BODY*
}

DumpDiagram::~DumpDiagram () {
	//#UC START# *4A2CE8E50142_DESTR_BODY*
	//#UC END# *4A2CE8E50142_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string DumpDiagram::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE8E50142*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string::const_iterator it = params[0].begin();
	const AbstractDumperBase* dumper = painter->get_dumper_by_template(it, params[0].end ());		
	if (
		dumper != 0
		&& (
			dumper->get_model_class_str () == "ClassDiagram"
			|| dumper->get_model_class_str () == "ScenarioDiagram"
			|| dumper->get_model_class_str () == "StateDiagram"
		)
	) {

		AbstractDumperBase::DiagramItemCollection items;
													
		std::string diag_uid = dumper->get_model_unique_id_str () + ".jpg";

		std::string new_hash_str;
		Core::Aptr<CxMemFile> picture = const_cast<AbstractDumperBase*>(dumper)->dump_diagram (items, new_hash_str);
		if (
			picture.ptr () != 0 
			&& painter->get_main_scope ()->get_source_type () == AbstractDumperBase::GST_WIKI
		) {	
			//сообщаем о начале транзакции
			AbstractDumper::on_start_wiki_generation ();
			std::string uid = painter->get_main_scope ()->get_model_unique_id_str ();

			GenSupport::PageProxy& page = GenSupport::PageProxyFactory::get (uid.c_str ());
			
			if (page.is_new_page () == true) {
				AbstractDumperBase::GenSourceInfo srs;
				srs.source.wiki_page (&page);
				AbstractDumperBase::TransactionContainer::instance ()->add_source (srs);
			}
			ServerGate::GenerationContents::Diagram diag;				
			
			size_t len = picture->Size ();				
			if (len <= AbstractDumperBase::MAX_PICTURE_SIZE) {
				if (len != 0) {					
					diag.picture.replace (len, len, picture->GetBuffer (false), false);					
				}					
			} else {
				std::string mess ("Diagram is very big (more than");
				mess += boost::lexical_cast<std::string> (AbstractDumperBase::MAX_PICTURE_SIZE);
				mess += "b) and we can't transfer it to Confluence";
				painter->get_main_scope ()->write_warning_log (
					mess
				);
				return std::string ();
			}

			std::string owner_uid (painter->get_owner ()->get_model_unique_id_str ());

			AbstractDumperBase::DiagramItemCollection fixed_items;
			for (
				AbstractDumperBase::DiagramItemCollection::iterator it = items.begin ()
				; it != items.end ()
				; ++it
			) {
				if (!it->uid/*.get ()*/.empty () && it->uid != owner_uid) {
					fixed_items.push_back (*it);
				}
			}
			size_t items_size = fixed_items.size ();
			diag.map.length (items_size);
							
			std::string guid_hash = boost::lexical_cast<std::string> (items_size);
			for (size_t i = 0; i < items_size; ++i) {
				diag.map[i].x1 = fixed_items[i].x1;
				diag.map[i].y1 = fixed_items[i].y1;
									
				diag.map[i].x2 = fixed_items[i].x2;
				diag.map[i].y2 = fixed_items[i].y2;

				diag.map[i].x3 = fixed_items[i].x3;
				diag.map[i].y3 = fixed_items[i].y3;

				diag.map[i].x4 = fixed_items[i].x4;
				diag.map[i].y4 = fixed_items[i].y4;

				diag.map[i].guid = fixed_items[i].uid/*.get ()*/.c_str ();
				guid_hash += fixed_items[i].uid;
			}
			boost::hash<std::string> str_hash;		
			new_hash_str += ", image map guids: " + boost::lexical_cast<std::string> (str_hash (guid_hash));
			CORBA::String_var old_hash = page.get_diagram_hash (diag_uid.c_str ());
			
			if (
				ACE_OS::strcmp (old_hash.in (), new_hash_str.c_str ()) != 0
				|| dumper->is_changed ()
			) {
				//добавляем диаграмму к странице
				diag.hash = new_hash_str.c_str ();
				
				AbstractDumperBase::GenSourceInfo srs;
				srs.source.wiki_page (&page);
				AbstractDumperBase::TransactionContainer::instance ()->add_source (srs);
				try {
					page.add_diagram (diag_uid.c_str (), diag);	
					AbstractDumperBase::get_source_to_dumpers ()[srs].push_back (dumper);
				} catch (ServerGate::GenerationContents::TransactionConflict&) {
					painter->get_main_scope ()->write_warning_log ("TransactionConflict");
				} catch (ServerGate::GenerationContents::ReadOnlyContent&) {
					painter->get_main_scope ()->write_warning_log ("ReadOnlyContent");
				} catch (CORBA::Exception& ex) {
					std::string mess = "Exception in dump_diagram: ";
					mess += ex._info ().c_str ();
					painter->get_main_scope ()->write_error_log (mess, true);
				}
			}
		}
	} else {
		std::string mess (params[0]);
		mess += " is not a diagram, it is: \"";
		mess += dumper ? dumper->get_model_class_str () : "null";
		mess += "\"";
		
		throw Base::FatalError (mess);
	}
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CE8E50142*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

