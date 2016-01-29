#include "unittest.h"

namespace UnitTest {

	IniFile::IniFile ()
	{
	}
	IniFile::IniFile (const char *file_name) : m_file_name (file_name) {

	}

	std::string IniFile::read_string (const char *section_name, const char *key_name) {
		char buf [256];
		::GetPrivateProfileString (section_name, key_name, "", buf, sizeof (buf), m_file_name.c_str ());
		return std::string (buf);
	}

	int IniFile::read_int (const char *section_name, const char *key_name) {
		return (::GetPrivateProfileInt (section_name, key_name, -1, m_file_name.c_str ()));
	}

	void IniFile::write_string( const char *section_name, const char *key_name, const char* value) {
		::WritePrivateProfileString (section_name, key_name, value, m_file_name.c_str ());
		::WritePrivateProfileString (NULL, NULL, NULL, m_file_name.c_str ());
	}

	void InitAdapter::execute() {
		try {
			MyStopWatch sw("Init adapter: ");
			gbladapter_init();
		} catch(...) {
			LOG_ERR(("Cannot init adapter."));
		}
	}

	void LoginTest::execute(const char* login, const char* password) {
		if (login == NULL)
		{
			LOG_ERR(("Error login is NULL"));
			return;
		}
		GblAdapter::ICommon_var common;
		GblAdapter::IAuthorization_var authorization;
		gbladapter_make_interface(authorization.out());
		if (authorization.in() == NULL)
		{
			LOG_ERR(("Can't get IAuthorization"));
			return;
		}
		try {
			MyStopWatch sw("Login by user: %s: ", login);
			authorization->login(login, password, common.out());
			if (common.in() == NULL)
			{
				LOG_ERR(("Can't get ICommon"));
				return;
			}
		} catch(...) {
			LOG_D(("Can't login user"));
		}
		
	}

	void LoginTest::execute(const char* login, const char* password, GblAdapter::ICommon*& common, GblAdapter::IAuthorization*& authorization) {
		if (login == NULL)
		{
			LOG_ERR(("Error login is NULL"));
			return;
		}
		gbladapter_make_interface(authorization);
		if (authorization == NULL)
		{
			LOG_ERR(("Can't get IAuthorization"));
			return;
		}
		try {
			MyStopWatch sw("Login by user: %s: ", login);
			authorization->login(login, password, common);
			if (common == NULL)
			{
				LOG_ERR(("Can't get ICommon"));
				return;
			}
		} catch(...) {
			LOG_D(("Can't login user"));
		}
		
	}

	void LoadDocument::execute(GblAdapter::IDocument* document) {
		if (document == 0)
		{
			LOG_ERR(("Error IDocument is NULL!!!"));
			return;
		}
		GblAdapter::IStream_var text_stream;
		GblAdapter::IFragmentList_var fragments;
		char buffer[READ_BUFFER];
		unsigned long size = READ_BUFFER;
		unsigned long result = 1;

		try {
				MyStopWatch sw("Load Document: ");
				document->get_text_fragment(fragments,text_stream.out());
				do {
					text_stream->read(buffer,size,&result);
					if (result<=size)
					{
						break;
					}
				} while (result);
		}  catch (...) {
			LOG_ERR (("Error in load_document"));
		}
	}

	void LoadStruct::execute(GblAdapter::IDocument* document) {
		
		GblAdapter::IFragmentList_var fragments;
		GblAdapter::IStream_var stream;
		try {
			fragments.out() = FragmentList_i::make_interface(1);
			((GblAdapter::Fragment*)fragments->get_data_ptr(0))->count = 1000;
			((GblAdapter::Fragment*)fragments->get_data_ptr(0))->from.point = 0;
			((GblAdapter::Fragment*)fragments->get_data_ptr(0))->from.type = GblAdapter::PT_PARA;
			{
				MyStopWatch sw("LoadStruct: ");
				document->get_text_structure(*(GblAdapter::Fragment*)fragments->get_data_ptr(0),stream.out());
			}
		}  catch (...) {
			LOG_ERR(("Error in LoadStruct"));
		}
	}

	void StartSearch::execute(GblAdapter::IQuery* query) {
		if (query == 0)
		{
			LOG_ERR(("Error IQuery is NULL!!!"));
			return;
		}
		GblAdapter::ICancelLongProcess_var cancel;
		GblAdapter::IList_var List;
		MyStopWatch* sw = new MyStopWatch("StartSearch: ");
		GblAdapter::Progress_i progress(query, NULL, sw);
		progress.execute(List.out());
	}

	void StartSearch::execute(GblAdapter::IQuery* query, GblAdapter::IList*& List) {
		if (query == 0)
		{
			LOG_ERR(("Error IQuery is NULL!!!"));
			return;
		}
		GblAdapter::ICancelLongProcess_var cancel;
		MyStopWatch* sw = new MyStopWatch("StartSearch: ");
		GblAdapter::Progress_i progress(query, NULL, sw);
		progress.execute(List);
	}

	void LoadList::execute(GblAdapter::IList* List) {
		GblAdapter::INode_var list_Node;
		GblAdapter::INode_var outNode;
		if (List == NULL)
		{
			LOG_ERR(("Error, IList is NULL"));
			return;
		}
		long count = 0;
		{
			MyStopWatch sw("LoadList: ");
			List->get_root(list_Node.out());
			if ((count = list_Node->get_child_count())>0) {
				
				list_Node->get_child(0,outNode.out());
			}	else {
				LOG_ERR(("List hasn't child"));
			}
			
		}
	}

	void LoadDocumentFromList::execute(GblAdapter::IList* List, GblAdapter::IDocument*& document) {
		
		document = NULL;
		GblAdapter::INode_var list_Node;
		GblAdapter::INode_var outNode;
		GblAdapter::IBaseEntity_var entity;

		if (List == NULL)
		{
			LOG_ERR(("Error, IList is NULL"));
			return;
		}
		long count = 0;
		List->get_root(list_Node.out());
		if ((count = list_Node->get_child_count())>0) {
				list_Node->get_child(curr_child++,outNode.out());
		} else {
			LOG_ERR(("List hasn't child"));
		}
		if (outNode.in() == NULL)
		{
			LOG_ERR(("Error, when get_child() inLoadDocumentFromList" ));
			return;
		}
		unsigned long type = outNode->get_object_type();
		{
			MyStopWatch sw("LoadDocumentFromList: ");
			outNode->open(entity.out());	
			if (entity.in() == NULL)
			{
				LOG_ERR(("Error, when try open(), in LoadDocumentFromList"));
				return;
			}
			document = GblAdapter::IDocument::_narrow(entity.in());
		}
	};

} //end namespace UnitTest