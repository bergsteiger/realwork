#include "autotest.h"
#include "FragmentList_i.h"

#define READ_BUFFER 500000L
#define COUNT_SETTINGS 3500
char sett_str[] = "Setting N%d";
char findContext[] = "Конституция Российской Федерации";
const char topic[] = "Административные правонарушения, административная ответственность\\Виды административных правонарушений";
const char type[] = "Указ";
const char organ_source[] = "Президент России и СССР";
const char meaning[] = "Общие";
const char type_info[] = "Документы";
const char territory[] = "Субъекты Российской Федерации";


GblAdapter::INodeBase* findNode(GblAdapter::INodeBase* aNode, char find[])
{
	
	return NULL;
}


void CreateQueryOperation(GblAdapter::IQuery* aQuery,
                               GblAdapter::INode* aTagNode,
                               GblAdapter::INode*& aOP,
                               GblAdapter::QueryLogicOperation aLO,
							   bool aNegative = false)
{
	GblAdapter::IQueryOperationNode_var l_QueryOp;
	aQuery->create_operation_node(l_QueryOp.out());
	try {
		l_QueryOp->set_operation(aLO);
		l_QueryOp->set_negative(aNegative);
		aTagNode->add_child_node((GblAdapter::IBaseEntity*)l_QueryOp.in(), aOP);
	} catch (...)
	{
	}
}

void SaveAttribute(GblAdapter::IQuery* aQuery,
                        GblAdapter::INode* aTagNode,
                        char* aTagName,
                        GblAdapter::INodeBase* aDictNode,
						GblAdapter::INode* aOP)
{
  GblAdapter::INode_var l_Node;
  GblAdapter::IQueryAttributeNode_var l_AttrNode;
  GblAdapter::IQueryDictionaryNodeNew_var l_QueryNodeNew;

 //l_Op := FindQueryOperation(aQuery, aTagNode, aLO, True);
  
  try {
  
   aQuery->create_attribute_node(GblAdapter::QNT_DICTIONARY_NEW, l_AttrNode.out());
	try {
		  l_AttrNode->set_tag(aTagName);
		  ((GblAdapter::IQueryDictionaryNodeNew*) l_AttrNode.in())->set_dict_node(aDictNode);
		  aOP->add_child_node((GblAdapter::IBaseEntity*)l_AttrNode.in(), l_Node.out());
	} catch (...) 
		{
		}
	} catch (...)
		{
		}

  
}
void CreateQueryTagNode(GblAdapter::IQuery* aQuery,
                             GblAdapter::INode*& aTagNode,
                             char* aTagName)
{
	GblAdapter::INode_var l_Root;
	GblAdapter::IQueryTagNode_var l_QueryTagNode;
	if (aTagNode == NULL)
	{
		aQuery->create_tag_node(l_QueryTagNode.out());
		l_QueryTagNode->set_tag(aTagName);
		aQuery->get_root(l_Root.out());
		try {
			    l_Root->add_child_node((GblAdapter::IBaseEntity*)l_QueryTagNode.in(), aTagNode);
		} catch (...)
		{
		}
	}
}

void SaveDate(GblAdapter::IQuery* aQuery,
                   GblAdapter::INode* aTagNode,
                   char* aTagName,
				   GblAdapter::Date dStart,
				   GblAdapter::Date dFinish)
{
  GblAdapter::INode_var l_Node;
  GblAdapter::IQueryDateNode_var l_QueryDateNode;
  GblAdapter::IQueryAttributeNode_var l_AttrNode;

  aQuery->create_attribute_node(GblAdapter::QNT_DATE, l_AttrNode.out());
  try {
		l_AttrNode->set_tag(aTagName);
	    l_QueryDateNode.out() = GblAdapter::IQueryDateNode::_narrow(l_AttrNode.in());
		try {     
				if (dStart.day != 0)
					l_QueryDateNode->set_start(dStart);
				if (dFinish.day !=0)
					l_QueryDateNode->set_finish(dFinish);
		} catch (...)
		{
		}
	    aTagNode->add_child_node((GblAdapter::IBaseEntity*) l_QueryDateNode.in(), l_Node.out());
  } catch (...)
  {
  }
}


GblAdapter::INode* FindQueryOperation(GblAdapter::IQuery* aQuery,
                            GblAdapter::INode* aTagNode,
							GblAdapter::QueryLogicOperation aLO,
                            bool aWithCreate)
{
	GblAdapter::INode_var l_Node;
	int l_Index = 0;
	GblAdapter::IBaseEntity_var l_BaseEntity;
	GblAdapter::IQueryOperationNode_var l_QueryOp;
	GblAdapter::INode_var Result;
 /* Определим есть ли такая операция в IQueryTagNode, если есть то присвоим
   ее "var aOp: INode" */
 while ((l_Index <= aTagNode->get_child_count()) && (Result.in() == NULL)) 
 {
  aTagNode->get_child(l_Index, l_Node.out());
  try {
	l_Node->open(l_BaseEntity.out());
	l_QueryOp.out() = GblAdapter::IQueryOperationNode::_narrow(l_BaseEntity.in());
	switch (aLO)
	{
	case GblAdapter::QLO_AND:
        if ((l_QueryOp->get_operation() == GblAdapter::QLO_AND) && (!l_QueryOp->get_negative()))
		{
			Result.out() = GblAdapter::INode::_narrow(l_Node.in());
		}
       case GblAdapter::QLO_AND_NOT:
        if ((l_QueryOp->get_operation() == GblAdapter::QLO_AND) && (!l_QueryOp->get_negative()))
		{
          Result.out() = GblAdapter::INode::_narrow(l_Node.in());
		}
       case GblAdapter::QLO_OR:
		if (l_QueryOp->get_operation() == GblAdapter::QLO_OR)
		{
          Result.out() = GblAdapter::INode::_narrow(l_Node.in());
		}
	}
  } catch(...)
  {
  }
   l_Index++;
 }

 // Создаем операцию 
 if ((Result.in() == NULL) && aWithCreate)
 {
  CreateQueryOperation(aQuery, aTagNode, Result.out(), aLO);
 }
 return GblAdapter::INode::_narrow(Result.in());
}

GblAdapter::INode* find_node(GblAdapter::INode* aNode, const char* findCaption)
{
	GblAdapter::INode_var resultNode;
	GblAdapter::INode_var childNode;
	GblAdapter::IString_var nodeCaption;
	if (aNode == NULL)
	{
		LOG_ERR(("Error while trying search node: root node is NULL"));
		return NULL;
	}
	aNode->get_caption(nodeCaption.out());
	if (strcmp(nodeCaption->get_buffer(), findCaption) == 0)
		return GblAdapter::INode::_narrow(aNode);
	int child_count = aNode->get_child_count();
	if (child_count == 0)
	{
		aNode->get_next_node(resultNode.out());
		if (resultNode.in() != NULL)
			if ((resultNode.out() = find_node(childNode.in(), findCaption))!= NULL)
				return GblAdapter::INode::_narrow(resultNode.in());
		while (resultNode.in() != NULL )
		{
			if ((resultNode.out() = find_node(childNode.in(), findCaption))!= NULL)
				return GblAdapter::INode::_narrow(resultNode.in());
		}
		return NULL;
	} else {
		for (int i=0;i<child_count;i++)
		{
			aNode->get_child(i,childNode.out());
			if ((resultNode.out() = find_node(childNode.in(), findCaption))!= NULL)
				return GblAdapter::INode::_narrow(resultNode.in());
		}
		return NULL;
	}

}
GblAdapter::INode* AutoTest::get_node_from_folder()
{
	GblAdapter::IFolders_var folders;
	GblAdapter::INode_var l_Node;
	GblAdapter::INode_var resultNode;
	GblAdapter::IBaseEntity_var entity;
	GblAdapter::IString_var str;
	m_common_interfaces->get_folders(folders.out());
	folders->get_root(l_Node.out());
	resultNode.out() = find_node(l_Node.in(),"Эталонный запрос");
	if (resultNode.in() != NULL)
	{
		return  GblAdapter::INode::_narrow(resultNode.in());
		//return GblAdapter::IQuery::_narrow(dynamic_cast<const GblAdapter::IQuery*>(resultNode.in()));
	}
	return NULL;
}

GblAdapter::IDocument* AutoTest::test_Struct()
{
	GblAdapter::IDocument_var i_document;
	GblAdapter::IFragmentList_var fragments;
	GblAdapter::IStream_var stream;
	GblAdapter::IStream_var text_stream;
//	try {
		m_common_interfaces->get_document_on_number(m_DocNumber, i_document.out());
/*	} catch (...) {
		LOG_ERR(("Can't get IDocument, maybe can't find doc with number %d", m_DocNumber));
		return 0;
	}
*/
	try {
		fragments.out() = FragmentList_i::make_interface(1);
		((GblAdapter::Fragment*)fragments->get_data_ptr(0))->count = 1000;
		((GblAdapter::Fragment*)fragments->get_data_ptr(0))->from.point = 0;
		((GblAdapter::Fragment*)fragments->get_data_ptr(0))->from.type = GblAdapter::PT_PARA;
		
		{
			MyStopWatch sw("Test_Struct: ");
			i_document->get_text_structure(*(GblAdapter::Fragment*)fragments->get_data_ptr(0),stream.out());
			sw.stop();
			float pr = (float)sw.sec+(float)sw.msec/1000+(float)sw.usec/1000000;
			fprintf(m_file, "%f;", pr);
		}
		LOG_D(("End get_struct"));
	}  catch (GblAdapter::Exception& ex) {
		LOG_CEX (((CORBA::Exception&) ex,"Error, while trying get information from server"));
	}
	return GblAdapter::IDocument::_narrow(i_document.in());
}

bool AutoTest::TryConnect ()
{
	while (1) {
		try {
			m_authorization->login(m_user_login.c_str(),m_user_pass.c_str(), m_common_interfaces.out());
			LOG_D(("login()::User login, login=%s, pass=%s",m_user_login.data(),m_user_pass.data()));
			break;
		} catch (GblAdapter::WrongAuthentication) {
			try {
					m_authorization->autoregistration("Kirill",m_user_login.c_str(),m_user_pass.c_str(),"pugin@garant.ru",m_common_interfaces.out());
					LOG_D(("autoregistration()::UserRegistred, login=%s, pass=%s",m_user_login.data(),m_user_pass.data()));
					break;
			}	catch (GblAdapter::LoginDuplicate){
					LOG_D(("User %s already in user's base",m_user_login.data()));
					return false;
			}	catch (GblAdapter::WrongAuthentication) {
					LOG_UEX(("Can't create new user"));
					return false;
			}
		}	catch (GblAdapter::AlreadyLogged) {
			LOG_D(("User %s already logged in",m_user_login.data()));
			return false;
		}
	}
	return true;
}

void AutoTest::test_LoadAdapter() throw (AutoTestError)
{
	if (m_DocNumber == 0)
	{
		LOG_D(("Document number is 0"));
		return;
	}
	{
		MyStopWatch sw("Test_Load_Adapter: ");
		try {
			gbladapter_init();
		} catch ( GblAdapter::NoServer& ) {
			throw AutoTestError();
		} catch (GblAdapter::IPAddressNotFound& ) {
			throw AutoTestError();
		} catch (GblAdapter::NoMoreConnections& ) {
			throw AutoTestError();
		} catch (GblAdapter::Exception&) {
			throw AutoTestError();
		} catch (...) {
			throw AutoTestError();
		}
		sw.stop();
		float pr= (float)sw.sec+(float)sw.msec/1000+(float)sw.usec/1000000;
		fprintf(m_file, "%f;", pr);
		
	}
	LOG_D(("End load adapter"));
}

void AutoTest::test_TextDocument()
{
	GblAdapter::IFragmentList_var fragments;
	GblAdapter::IStream_var stream;
	GblAdapter::IDocument_var i_document;
	GblAdapter::IStream_var text_stream;

	i_document.out() = test_Struct();
	if (i_document.in() == 0)
	{
		LOG_ERR(("Error IDocument is NULL!!!"));
		return;
	}

	char buffer[READ_BUFFER];
	unsigned long size = READ_BUFFER;
	unsigned long result = 1;

	try {
			{
				MyStopWatch sw("Test_Text_Document: ");
				i_document->get_text_fragment(fragments,text_stream.out());
				do {
					text_stream->read(buffer,size,&result);
					if (result<=size)
					{
						break;
					}
				} while (result);
				sw.stop();
				float pr= (float)sw.sec+(float)sw.msec/1000+(float)sw.usec/1000000;
				fprintf(m_file, "%f;", pr);
			}
		LOG_D(("End reading text"));
	}  catch (GblAdapter::Exception& ex) {
		LOG_CEX (((CORBA::Exception&) ex,"Error, while trying get information from server"));
	}
	
}

void AutoTest::test_CreateSettings()
{
	GblAdapter::ISettings_var settings;
	GblAdapter::IString_var i_string;
	m_common_interfaces->get_settings(settings.out());
	char strSettings[1000];
	char Settings_value[1000];
	{
		MyStopWatch sw("Test_Create_Settings (%d): ", COUNT_SETTINGS);
		for (long k=0;k<COUNT_SETTINGS;k++)
		{
				sprintf(strSettings,sett_str,k);
				sprintf(Settings_value,"%d",k);
				try {
						settings->set_string(strSettings,Settings_value);
				} catch (GblAdapter::InvalidValueType &e) {
								LOG_ERR (("set_string()::InvalidValueType %s: %s = %s",e.id (),strSettings,Settings_value));
				} catch (GblAdapter::ConstantModify &e) {
								LOG_ERR (("set_string()::ConstantModify %s: %s = %s", e.id (), strSettings,Settings_value));
				} catch (GblAdapter::Exception& ex) {
							LOG_CEX (((CORBA::Exception&) ex,"Can't write settings"));
				} catch (GblSettings::PropertyValueNotDefined&) {
							LOG_ERR (("set_string()::PropertyValueNotDefined: %s = %s",strSettings,Settings_value));
				} catch (...) {
							LOG_ERR (("set_string()::UNKNOWN_EX: %s = %s",strSettings,Settings_value));
				}
		}
		sw.stop();
		float pr= (float)sw.sec+(float)sw.msec/1000+(float)sw.usec/1000000;
		fprintf(m_file, "%f;", pr);
	}
	LOG_D(("End write settings"));
}

void AutoTest::test_ReWriteSettings()
{
	LOG_D(("Start ReWriting 3500 settings"));
	test_CreateSettings();
	LOG_D(("End ReWriting settings"));
}

void AutoTest::test_GetList_by_search(GblAdapter::IList* search_list)
{
	GblAdapter::IList_var List;
	GblAdapter::INode_var list_Node;
	GblAdapter::INodeBase_var list_NodeBase;
	GblAdapter::INode_var outNode;
	List.out() = search_list;
	if (List.in() == NULL)
	{
		LOG_ERR(("Query return empty list!!!"));
		fprintf(m_file, "%f;", 0);
		return;
	}
	long count = 0;
	{
		MyStopWatch sw("Test_List_after_Search: ");
		List->get_root(list_Node.out());
		if ((count = list_Node->get_child_count())>0) {
			
			list_Node->get_child(0,outNode.out());
		}	else {
			LOG_ERR(("List hasn't child"));
		}
		sw.stop();
		float pr= (float)sw.sec+(float)sw.msec/1000+(float)sw.usec/1000000;
		fprintf(m_file, "%f;", pr);
	}
	LOG_D(("END load list, %d", count));

}
void AutoTest::test_GetList()
{
	GblAdapter::IList_var List;
	GblAdapter::INode_var list_Node;
	GblAdapter::INodeBase_var list_NodeBase;
	GblAdapter::INode_var outNode;
	List.out() = test_Search_by_Date();
	if (List.in() == NULL)
	{
		LOG_ERR(("Query return empty list!!!"));
		return;
	}
	long count = 0;
	{
		MyStopWatch sw("Test_GetList: ");
		List->get_root(list_Node.out());
		if ((count = list_Node->get_child_count())>0) {
			
			list_Node->get_child(0,outNode.out());
		}	else {
			LOG_ERR(("List hasn't child"));
		}
		sw.stop();
		float pr= (float)sw.sec+(float)sw.msec/1000+(float)sw.usec/1000000;
		fprintf(m_file, "%f;", pr);
	}
	LOG_D(("END load list, %d", count));

}

GblAdapter::IList* AutoTest::test_Search_by_Attr()
{
	GblAdapter::IQuery_var query;
	GblAdapter::IList_var List;
	GblAdapter::INode_var node_in_folder;
	GblAdapter::IBaseEntity_var entity;

	node_in_folder.out()= get_node_from_folder();
	if (node_in_folder.in() == NULL)
		return NULL;
	unsigned long type = node_in_folder->get_object_type();
	if (type == GblAdapter::FIT_QUERY)
	{
		node_in_folder->open(entity.out());	
		if (entity.in() == NULL)
			return NULL;
	}
	query.out() = GblAdapter::IQuery::_narrow(entity.in());
	if (query.in() == NULL)
		return NULL;
	GblAdapter::ICancelLongProcess_var cancel;
	MyStopWatch* sw = new MyStopWatch("Test_Search_by_Attr: ");
	GblAdapter::Progress_i progress(query.in(), NULL, sw);
	progress.execute(List.out());
	float pr= (float)sw->sec+(float)sw->msec/1000+(float)sw->usec/1000000;
	fprintf(m_file, "%f;", pr);
	delete sw;
	return GblAdapter::IList::_narrow(List.in());
}


GblAdapter::IList* AutoTest::test_Search_by_Date()
{
	
	GblAdapter::INode_var aTagNode;
	GblAdapter::IQuery_var query;
	//GCL::Var<GblAdapter::Query_i> query;
	GblAdapter::INode_var l_Root;
	GblAdapter::IQueryTagNode_var l_QueryTagNode;
	GblAdapter::INode_var l_Node;
	GblAdapter::IQueryDateNode_var l_QueryDateNode;
	GblAdapter::IQueryAttributeNode_var l_AttrNode;
	GblAdapter::INodeBase_var typeOpt;
	GblAdapter::Date findDateStart;
	findDateStart.day = 5;
	findDateStart.month= 10;
	findDateStart.year= 1995;
	
	GblAdapter::ISearch_var srch;
	GblAdapter::IList_var List;




	try {
			m_common_interfaces->get_search(srch.out());
			srch->create_query(query.out());
			CreateQueryTagNode(query.in(),aTagNode.out(),"dt_PublishingDate");
			SaveDate(query.in(),aTagNode.in(),"dt_PublishingDate",findDateStart,findDateStart);
			
			
			MyStopWatch* sw = new MyStopWatch("Test_Search_by_Date");
			GblAdapter::Progress_i progress(query.in(), NULL, sw);
			progress.execute(List.out());
			float pr= (float)sw->sec+(float)sw->msec/1000+(float)sw->usec/1000000;
			fprintf(m_file, "%f;", pr);
			delete sw;
	
	} catch (GblAdapter::CanNotFindData &ex) {
		LOG_D(("Cannot execute query %s",ex.id()));
		
	} catch (GblAdapter::Exception& ex) {
		LOG_CEX (((CORBA::Exception&) ex,"Error, while trying get information from server"));
	}

	return GblAdapter::IList::_narrow(List.in());
}

void AutoTest::test_GetListAll()
{
	GblAdapter::IList_var List;
	GblAdapter::INode_var list_Node;
	GblAdapter::INodeBase_var list_NodeBase;
	GblAdapter::INode_var outNode;
	List.out() = test_EmptySearch();
	if (List.in() == NULL)
	{
		LOG_ERR(("Query return empty list!!!"));
		return;
	}
	long count = 0;
	{
		MyStopWatch sw("Test_GetListAll: ");
		List->get_root(list_Node.out());
		if ((count = list_Node->get_child_count())>0) {
			
			list_Node->get_child(0,outNode.out());
		}	else {
			LOG_ERR(("List hasn't child"));
		}
		sw.stop();
		float pr = (float)sw.sec+ (float)sw.msec/1000+(float)sw.usec/1000000;
		fprintf(m_file, "%f;", pr);
	}
	LOG_D(("END load list with All elements, %d", count));

}

GblAdapter::IList* AutoTest::test_EmptySearch()
{
	GblAdapter::ISearch_var search;
	GblAdapter::IQuery_var query;
	GblAdapter::IList_var List;
	m_common_interfaces->get_search(search.out());
	search->create_query(query.out());
	MyStopWatch* sw = new MyStopWatch("Test_EMptySearch: ");
	GblAdapter::Progress_i progress(query.in(), NULL, sw);
	progress.execute(List.out());
	float pr= (float)sw->sec+(float)sw->msec/1000+(float)sw->usec/1000000;
	fprintf(m_file, "%f;", pr);
	delete sw;
	return GblAdapter::IList::_narrow(List.in());

}

void AutoTest::test_ReadSettings()
{
	GblAdapter::ISettings_var settings;
	GblAdapter::IString_var i_string;
	m_common_interfaces->get_settings(settings.out());
	char strSettings[1000];
	char Settings_value[1000];
	Sleep(1000);
	{
		MyStopWatch sw("Test_ReadSettings (%d): ", COUNT_SETTINGS);
		for (long k=0;k<COUNT_SETTINGS;k++)
		{
				sprintf(strSettings, sett_str, k);
				sprintf(Settings_value, "%d", k);
				try {
						settings->set_string(strSettings,Settings_value);
						try {
							settings->get_string(strSettings,i_string.out());
							
						} catch (GblAdapter::InvalidValueType &e) {
								LOG_ERR (("get_string()::InvalidValueType %s:, %s = %s", e.id(), strSettings));
						} catch (GblAdapter::Exception& ex) {
							LOG_CEX (((CORBA::Exception&) ex,"Can't read settings"));
						} catch (...) {
								LOG_D (("get_string()::UNKNOWN_EX: %s = %s, ",strSettings,Settings_value));
						}
				} catch (GblAdapter::InvalidValueType &e) {
								LOG_ERR (("set_string()::InvalidValueType %s: %s = %s",e.id (),strSettings,Settings_value));
				} catch (GblAdapter::ConstantModify &e) {
								LOG_ERR (("set_string()::ConstantModify %s: %s = %s", e.id (), strSettings,Settings_value));
				} catch (GblAdapter::Exception& ex) {
							LOG_CEX (((CORBA::Exception&) ex,"Can't write settings"));
				} catch (GblSettings::PropertyValueNotDefined&) {
							LOG_ERR (("set_string()::PropertyValueNotDefined: %s = %s",strSettings,Settings_value));
				} catch (...) {
							LOG_ERR (("set_string()::UNKNOWN_EX: %s = %s",strSettings,Settings_value));
				}
				
		}
		sw.stop();
		float pr= (float)sw.sec+(float)sw.msec/1000+(float)sw.usec/1000000;
		fprintf(m_file, "%f;", pr);
	}
}

GblAdapter::IList* AutoTest::test_Search_by_Frase(char cntxt[])
{
	
	
	GblAdapter::INodeBase_var node;
	GblAdapter::IString_var str;
	GblAdapter::IQuery_var query;
	GblAdapter::IQueryAttributeNode_var attrNode;
	GblAdapter::IQueryStringNode_var stringNode;
	GblAdapter::INode_var tagNode;
	GblAdapter::INode_var aTagNode;
	GblAdapter::INode_var rootNode;
	GblAdapter::INode_var aNode;
	GblAdapter::IString_var iString;
	GblAdapter::INodeBase_var rootTextOpt;
	GblAdapter::INodeBase_var txtOptVal;
	GblAdapter::INode_var aOP;
	GblAdapter::INode_var tag_opNode;
	GblAdapter::INode_var textTagNode;
	GblAdapter::ISearch_var srch;
	GblAdapter::IList_var List;
	long count_attr=0;
	
	
	try {
		m_common_interfaces->get_search(srch.out());
		srch->create_query(query.out());
		query->set_name("My query");
		query->create_attribute_node(GblAdapter::QNT_STRING,(GblAdapter::IQueryAttributeNode*&)attrNode.out());
		//attrNode->query_interface(GblAdapter::IID_IQueryStringNode, (GCL::IObject *&)stringNode.out());
		//Создаём  ноду тэгов
		query->get_root(rootNode.out());
		CreateQueryTagNode(query.in(), tagNode.out(), "dt_Text");
		CreateQueryTagNode(query.in(), textTagNode.out(), "dt_Text");
		
		srch->get_attribute_tree_new("dt_TextOpt",rootTextOpt.out());
		rootTextOpt->get_first_child(txtOptVal.out());

		CreateQueryOperation(query.in(),tagNode.in(),aOP.out(),GblAdapter::QLO_OR);
		SaveAttribute(query.in(),tagNode.in(),"dt_TextOpt",txtOptVal.in(),aOP.in());
		
		//Получаем рутовую ноду Query
		
		//Устанавливаем тэг на ноду атрибутов
		stringNode.out() = (GblAdapter::IQueryStringNode*)attrNode.in();
		stringNode->set_tag("dt_Text");

		stringNode->set_string(cntxt);
		//Устанавливаем тэг на ноду тэгов
		//Связываем рутовую ноду с тэг-нодой
		
		//Связываем тэг ноду с нодой атрибутов
		textTagNode->add_child_node((GblAdapter::IBaseEntity*)stringNode.in(),aNode.out());

		MyStopWatch* sw = new MyStopWatch("Test_Serach_by_Fraze (%s): ", cntxt);
		GblAdapter::Progress_i progress(query.in(), NULL, sw);
		progress.execute(List.out());
		float pr= (float)sw->sec+(float)sw->msec/1000+(float)sw->usec/1000000;
		fprintf(m_file, "%f;", pr);
		delete sw;

	
	} catch (GblAdapter::CanNotFindData &ex) {
		LOG_D(("Can't execute query, ", ex.id()));
		
	} catch (GblAdapter::Exception& ex) {
		LOG_CEX (((CORBA::Exception&) ex,"Error, while trying get information from server"));
	} catch (...) {
		LOG_ERR(("Somthing wrong in test_Search_by_Frase()"));
	}
	
	return GblAdapter::IList::_narrow(List.in());
}

