////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffDocDataProvider_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DiffDocDataProvider_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffDocDataProvider_i.h"

//#UC START# *4D78EAEB0118_CUSTOM_INCLUDES*
#include "common/components/rtl/Garant/EVD/evddata.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"

#include <fstream>
#include <boost/foreach.hpp>


//#UC END# *4D78EAEB0118_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4D78EAEB0118*

void make_para (const GblPilot::DiffDocPara& server_para, DiffDocPara& para) {
	para.id = server_para.id;
	para.style = MemoryStreamFactory::make (server_para.style, true /*with_copy*/);
	para.data  = MemoryStreamFactory::make (server_para.data,  true /*with_copy*/);
	para.text  = GCI::IO::StringFactory::create (server_para.text.data.in (), server_para.text.enc);
	para.type  = server_para.type;
}

DiffDocPara* make_para (const GblPilot::DiffDocPara& server_para) {
	Core::Aptr<DiffDocPara> para (new DiffDocPara);
	make_para (server_para, *para);
	return para._retn ();
}


void test (DiffDocDataProvider* provider) {
	std::ofstream file ("diff-doc.txt");

	file << "All leaf para count: " << provider->get_all_leaf_para_count () << std::endl;
	
	Core::Aptr<DiffDocPara> left_date;
	provider->get_date_para_left (left_date.out ());
	file << "Left  date:" << left_date->text->get_data () << std::endl;
	
	Core::Aptr<DiffDocPara> right_date;
	provider->get_date_para_right (right_date.out ());
	file << "Right date:" << right_date->text->get_data () << std::endl;

	Core::Aptr<DiffDocPara> name_left  = provider->get_redaction_name_left ();
	file << "Left  name:" << name_left->text->get_data () << std::endl;
	
	Core::Aptr<DiffDocPara> name_right = provider->get_redaction_name_right ();
	file << "Right name:" << name_right->text->get_data () << std::endl;

	Core::Aptr<DiffDocParaList> list = provider->get_header_para_list ();
	BOOST_FOREACH (const DiffDocPara& para, *list) {
		file << "Header para:" << para.text->get_data () << std::endl;
	}
	
	
	for (size_t i = 0, count = provider->get_changed_block_count (); i < count; ++i) {
		Core::Aptr <ChangedBlock> block = provider->get_changed_block (i);
		file << "{{{" << std::endl;
		file << "ID::" << block->id << std::endl;

		const DiffDocParaList& header = block->header;
		BOOST_FOREACH (const DiffDocPara& para, header) {
			file << "Block Header para:" << para.text->get_data () << std::endl;
		}

		const DiffDocParaList& left = block->left_text_para_list;
		BOOST_FOREACH (const DiffDocPara& para, left) {
			file << "Left:" << para.text->get_data () << std::endl;
		}

		const DiffDocParaList& right = block->right_text_para_list;
		BOOST_FOREACH (const DiffDocPara& para, right) {
			file << "Right:" << para.text->get_data () << std::endl;
		}

		file << "}}}" << std::endl;
	}

	file.close ();
}

//#UC END# *4D78EAEB0118*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DiffDocDataProvider_i::DiffDocDataProvider_i (const Document* left, const Document* right)
//#UC START# *4D78D8200190_4D78DFAF0175_4D78EAEB0118_BASE_INIT*
//#UC END# *4D78D8200190_4D78DFAF0175_4D78EAEB0118_BASE_INIT*
{
	//#UC START# *4D78D8200190_4D78DFAF0175_4D78EAEB0118_BODY*
	GblPilot::Document* left_doc  = left->get_server_doc ();
	GblPilot::Document* right_doc = right->get_server_doc ();
	
	GblPilot::LegalDocument_var legal_left_doc  = GblPilot::LegalDocument::_narrow (left_doc);
	GblPilot::LegalDocument_var legal_right_doc = GblPilot::LegalDocument::_narrow (right_doc);
	
	GDS_ASSERT (!CORBA::is_nil (legal_left_doc));
	GDS_ASSERT (!CORBA::is_nil (legal_right_doc));
	try {
		m_data = legal_right_doc->diff_doc_data (legal_left_doc);
	} catch (GblPilot::AllChangesInTables&) {
		throw GblAdapterLib::AllChangesInTables ();
	}	
	
	// test (this);
	//#UC END# *4D78D8200190_4D78DFAF0175_4D78EAEB0118_BODY*
}

DiffDocDataProvider_i::~DiffDocDataProvider_i () {
	//#UC START# *4D78EAEB0118_DESTR_BODY*
	//#UC END# *4D78EAEB0118_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DiffDocDataProvider
unsigned long DiffDocDataProvider_i::get_all_leaf_para_count () const {
	//#UC START# *4D78D86C0070_4D78EAEB0118*
	return m_data->all_leaf_para_count;
	//#UC END# *4D78D86C0070_4D78EAEB0118*
}

// implemented method from DiffDocDataProvider
ChangedBlock* DiffDocDataProvider_i::get_changed_block (unsigned long i) const {
	//#UC START# *4D78DBB90348_4D78EAEB0118*
	GDS_ASSERT (i < this->get_changed_block_count ());
	Core::Aptr<ChangedBlock> block (new ChangedBlock);

	const GblPilot::ChangedBlock& server_block = m_data->changed_block_list [i];
	
	block->id = server_block.id;
	
	// Название структурной единицы с точностью до минимального блока, входящего в оглавление,
	// которым  предваряется измененный фрагмент (блок)
	block->header.resize (server_block.header.length ());
	for (CORBA::ULong i = 0; i < server_block.header.length (); ++i) {
		make_para (server_block.header [i], block->header [i]);
	}

	// Измененный фрагмент левой редакции
	block->left_text_para_list.resize (server_block.left_para_list.length ());
	for (CORBA::ULong i = 0; i < server_block.left_para_list.length (); ++i) {
		make_para (server_block.left_para_list [i], block->left_text_para_list [i]);
	}

	// Измененный фрагмент правой редакции
	block->right_text_para_list.resize (server_block.right_para_list.length ());
	for (CORBA::ULong i = 0; i < server_block.right_para_list.length (); ++i) {
		make_para (server_block.right_para_list [i], block->right_text_para_list [i]);
	}

	return block._retn ();
	//#UC END# *4D78DBB90348_4D78EAEB0118*
}

// implemented method from DiffDocDataProvider
unsigned long DiffDocDataProvider_i::get_changed_block_count () const {
	//#UC START# *4D78DB960024_4D78EAEB0118*
	return m_data->changed_block_list.length ();
	//#UC END# *4D78DB960024_4D78EAEB0118*
}

// implemented method from DiffDocDataProvider
// параграф с датами изменений документа для левого документа
bool DiffDocDataProvider_i::get_date_para_left (DiffDocPara*& para) const {
	//#UC START# *4D78DB34007D_4D78EAEB0118*
	para = make_para (m_data->date_record.left);
	return m_data->date_record.has_changes;
	//#UC END# *4D78DB34007D_4D78EAEB0118*
}

// implemented method from DiffDocDataProvider
// параграф с датами изменений документа для правого документа
bool DiffDocDataProvider_i::get_date_para_right (DiffDocPara*& para) const {
	//#UC START# *4D78DB060332_4D78EAEB0118*
	para = make_para (m_data->date_record.right);
	return m_data->date_record.has_changes;
	//#UC END# *4D78DB060332_4D78EAEB0118*
}

// implemented method from DiffDocDataProvider
// Заголовок документа состоит из:
// 
// Фраза "Обзор изменений документа"
// Длинное имя документа (!Name)
// Фраза "Подготовлено экспертами компании "Гарант"
// Фраза "Далее приведены изменившиеся фрагменты редакций:"
DiffDocParaList* DiffDocDataProvider_i::get_header_para_list () const {
	//#UC START# *4D78D893019F_4D78EAEB0118*
	Core::Aptr<DiffDocParaList> list (new DiffDocParaList ());
	
	const GblPilot::DiffDocParaVector& server_list = m_data->header_para_list;
	
	list->resize (server_list.length ());
	
	for (CORBA::ULong i = 0, length = server_list.length (); i < length; ++i) {
		make_para (server_list[i], list->at (i));
	}
	
	return list._retn ();
	//#UC END# *4D78D893019F_4D78EAEB0118*
}

// implemented method from DiffDocDataProvider
// Каждая таблица имеет заголовок содержащий имена редакций (это имя редакции для левого документа)
DiffDocPara* DiffDocDataProvider_i::get_redaction_name_left () const {
	//#UC START# *4D78DB6C025D_4D78EAEB0118*
	return make_para (m_data->redaction_name_record.left);
	//#UC END# *4D78DB6C025D_4D78EAEB0118*
}

// implemented method from DiffDocDataProvider
// Каждая таблица имеет заголовок содержащий имена редакций (это имя редакции для правого документа)
DiffDocPara* DiffDocDataProvider_i::get_redaction_name_right () const {
	//#UC START# *4D78DB3B00AF_4D78EAEB0118*
	return make_para (m_data->redaction_name_record.right);
	//#UC END# *4D78DB3B00AF_4D78EAEB0118*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

