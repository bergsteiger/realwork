#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "helpers/logs.h"
#include <map>
#include <conio.h>
#include <stdexcept>
#include <time.h>
#include <TLHELP32.H>
#include <process.h>
#include <string.h>
#include "TestSrv.h"
#include "FragmentList_i.h"

#include "autotest.h"
//#include "Garant/GblAdapter/Document/FragmentList_i.h"

#define MAX_THREAD 1
#define MAX_READ_BUFFER 500000L
#define DELAY_OP 6000L

char sett_str[] = "Setting N%d";


HANDLE  hRunMutex;
HANDLE  hThreadMutex;
int     ThreadNr; 
int     ThreadNumber = 0; 

using namespace GCL;
using namespace GblAdapter;



void Run(GblAdapter::ISettings* settings)
{
	char strSettings[1000];
	char Settings_value[1000];
	std::map<char*,char*> StrMap;
	for (long k=0;k<1;k++)
	{
	
		

		srand( (unsigned)time( NULL ) );
		LOG_D (("Start write settings"));
		for (int i=0;i<GetRandom(10,100);i++)
			{
				if (WaitForSingleObject( hRunMutex, 10L ) != WAIT_TIMEOUT) 
				{
					ReleaseMutex( hThreadMutex );
					return;
				}
				sprintf(strSettings,sett_str,GetRandom(0,100000));
				sprintf(Settings_value,"%d",rand());
				try {
										
						settings->set_string(strSettings,Settings_value);
						LOG_D (("Write: %s, = %s",strSettings,Settings_value));
						
					} catch (GblAdapter::InvalidValueType &e) {
					//	e.id ();
						LOG_ERR (("set_string()::InvalidValueType %s: %s = %s",e.id (),strSettings,Settings_value));
						
				} catch (GblAdapter::ConstantModify &e) {
						LOG_ERR (("set_string()::ConstantModify %s: %s = %s", e.id (), strSettings,Settings_value));
				} catch (GblAdapter::Exception& ex) {
					LOG_CEX (((CORBA::Exception&) ex,"Can't write settings"));
				} catch (...) {
					LOG_ERR (("set_string()::UNKNOWN_EX: %s = %s",strSettings,Settings_value));
				}
				
			//	StrMap.insert ( PCHAR_Pair ( strSettings, Settings_value) );
			}
		LOG_D (("End write settings"));
		LOG_D (("Start read settings"));
		for (i=0;i<GetRandom(10,100);i++)
		{
			if (WaitForSingleObject( hRunMutex, 10L ) != WAIT_TIMEOUT) 
			{
				ReleaseMutex( hThreadMutex );
				return;
			}
			int res=-20;
			try {
					sprintf(strSettings,sett_str,GetRandom(0,100000));
					GblAdapter::IString_var i_string;
					res = settings->get_string(strSettings,i_string.out());
					LOG_D (("get_string(): res = %d , %s = %s",res,strSettings,((GblAdapter::IString*)i_string)->get_buffer()));
			} catch (GblAdapter::InvalidValueType &e) {
					LOG_ERR (("get_string()::InvalidValueType %s:res = %d, %s = %s", e.id(), res,strSettings));
			} catch (GblAdapter::Exception& ex) {
				LOG_CEX (((CORBA::Exception&) ex,"Cant attach to facet"));
			} catch (...) {
					LOG_D (("get_string()::UNKNOWN_EX: %s = %s, res = %d",strSettings,Settings_value,res));
			}
		}
		LOG_D (("End read settings"));
	
		
	}
	
	
}
void GetDoc(GblAdapter::IDocument* doc_mng,long doc_num)
{
	GblAdapter::ICommon_var common_interfaces;
	GblAdapter::IString_var i_string;
	GblAdapter::IDocument* i_document = (GblAdapter::IDocument*)doc_mng;
	GblAdapter::IAuthorization_var authorization;
	GblAdapter::IFragmentList_var fragments;
	GblAdapter::IStream_var stream;
	//GblAdapter::Fragment frag;
	GblAdapter::IStream_var text_stream;
	
	char buffer[MAX_READ_BUFFER];
	unsigned long size = MAX_READ_BUFFER;
	unsigned long result = 1;

	try {
		fragments.out() = FragmentList_i::make_interface(1);
		((GblAdapter::Fragment*)fragments->get_data_ptr(0))->count = 1000;
		((GblAdapter::Fragment*)fragments->get_data_ptr(0))->from.point = 0;
		((GblAdapter::Fragment*)fragments->get_data_ptr(0))->from.type = GblAdapter::PT_PARA;
		
		
		i_document->get_name(i_string.out());
		i_document->get_text_structure(*(GblAdapter::Fragment*)fragments->get_data_ptr(0),stream.out());
		//stream = NULL;
		Sleep(1000);
		i_document->get_text_fragment(fragments,text_stream.out());
			
		do {
			text_stream->read(buffer,size,&result);
			if (result)
			{
				LOG_D(("Name of doc: %s",((GblAdapter::IString*)i_string)->get_buffer()));
				LOG_D(("Reading %d byte from stream",result));
			}
		} while (result);
		LOG_D(("End reading text"));
	} catch (GblAdapter::CanNotFindData &ex) {
		LOG_D(("Can't find document with number: %d; %s",doc_num, ex.id()));
		
		
	}  catch (GblAdapter::Exception& ex) {
		LOG_CEX (((CORBA::Exception&) ex,"Error? while trying get information from server"));
	}
	
}





//поиск по дате
void SearchDate(GblAdapter::ISearch* Search_mng,GblAdapter::Date findDateStart/*,GblAdapter::Date findDateFinish*/)
{
	GblAdapter::ISearch* srch = (GblAdapter::ISearch*)Search_mng;
	GblAdapter::INode_var aTagNode;
	GblAdapter::IQuery_var query;
	//GCL::Var<GblAdapter::Query_i> query;
	GblAdapter::INode_var l_Root;
	GblAdapter::IQueryTagNode_var l_QueryTagNode;
	GblAdapter::INode_var l_Node;
	GblAdapter::IQueryDateNode_var l_QueryDateNode;
	GblAdapter::IQueryAttributeNode_var l_AttrNode;
	GblAdapter::INodeBase_var typeOpt;
	GblAdapter::Date findDateFinish;
	findDateFinish.day = findDateStart.day;
	findDateFinish.month= findDateStart.month;
	findDateFinish.year= findDateStart.year+1;

	try {
			//получили Query
			srch->create_query(/*(GblAdapter::IQuery *&)*/query.out());
			
			CreateQueryTagNode(query.in(),aTagNode.out(),"dt_PublishingDate");
			SaveDate(query.in(),aTagNode.in(),"dt_PublishingDate",findDateStart,findDateFinish);
			
			GblAdapter::ICancelLongProcess_var cancel;
			
			LOG_D(("Try find doc's by date: %d/%d/%d - %d/%d/%d",
												findDateStart.day,
												findDateStart.month,
												findDateStart.year,
												findDateFinish.day,
												findDateFinish.month,
												findDateFinish.year));
			IList_var tList;
			StopWatch* sw = new StopWatch("Search time: ");
			Var<Progress_i> progress;
			progress.out() = new Progress_i(query.in(), NULL, sw);
			progress->execute(tList.out());
	
	} catch (GblAdapter::CanNotFindData &ex) {
		LOG_D(("Cannot execute query %s",ex.id()));
		
	} catch (GblAdapter::Exception& ex) {
		LOG_CEX (((CORBA::Exception&) ex,"Error, while trying get information from server"));
	}

	
}
//поиск по контексту (по всему тексту)
void Search(GblAdapter::ISearch* Search_mng,const char* findContext)
{
	GblAdapter::ISearch* srch = (GblAdapter::ISearch*)Search_mng;
	
	GCL::Var<GblAdapter::IAttributeTagList> attr;
	GblAdapter::QueryFormInfo formInfo;
	GblAdapter::GroupInfo groupInfo;
	GblAdapter::AttributeInfo attrInfo;
	GblAdapter::INodeBase_var node;
	GblAdapter::IString_var str;
	GCL::Var<GblAdapter::Query_i> query;
	GblAdapter::IQueryAttributeNode_var attrNode;
	GblAdapter::IQueryStringNode_var stringNode;
	GCL::Var<GblAdapter::QueryTagNode_i> tagNode;
	GblAdapter::INode_var aTagNode;
	GblAdapter::INode_var rootNode;
	GblAdapter::INode_var aNode;
	GblAdapter::IString_var iString;
	GblAdapter::INodeBase_var rootTextOpt;
	GblAdapter::INodeBase_var txtOptVal;
	GblAdapter::INode_var aOP;
	GblAdapter::INode_var tag_opNode;
	GCL::Var<GblAdapter::QueryTagNode_i> textTagNode;
	long count_attr=0;
	
	//get_available_tags
	try {
//		common_interfaces->get_search(srch.out());
		srch->get_available_tags(attr.out());
		count_attr = attr->get_count();
		srch->get_query_form(GblAdapter::NM_ATTRIBUTE_SEARCH,formInfo);
		for (int i=0;i<formInfo.groups->get_count();i++)
		{
			groupInfo = *(formInfo.groups->get_data_ptr(i));
			for (int j=0;j<groupInfo.attributes->get_count ();j++)
			{
				attrInfo = *(groupInfo.attributes->get_data_ptr(j));
				LOG_D((attrInfo.tag));
				//logOP = *(attrInfo.available_ops->get_data_ptr(j));
			}
		}
		
		//Создаём  Query
		srch->create_query((GblAdapter::IQuery *&)query.out());
		query->set_name("My query");
		//query->set_type(GblAdapter::QT_ATTRIBUTE);
		//Создаём  ноду атрибутов
		query->create_attribute_node(GblAdapter::QNT_STRING,(GblAdapter::IQueryAttributeNode*&)attrNode.out());
		
		//attrNode->query_interface(GblAdapter::IID_IQueryStringNode, (GCL::IObject *&)stringNode.out());
		//Создаём  ноду тэгов
		

		

		///
		
		
		query->get_root(rootNode.out());

		query->create_tag_node((GblAdapter::IQueryTagNode *&)tagNode.out());
		query->create_tag_node((GblAdapter::IQueryTagNode *&)textTagNode.out());

		srch->get_attribute_tree_new("dt_TextOpt",rootTextOpt.out());
		rootTextOpt->get_first_child(txtOptVal.out());

		CreateQueryOperation(query.in(),tagNode.in(),aOP.out(),GblAdapter::QLO_OR);
		SaveAttribute(query.in(),tagNode.in(),"dt_TextOpt",txtOptVal.in(),aOP.in());
		
		rootNode->add_child_node((GblAdapter::IBaseEntity*)tagNode.in(),aTagNode.out());
		///

		

		
		//Получаем рутовую ноду Query
		
		//Устанавливаем тэг на ноду атрибутов
		stringNode.out() = (GblAdapter::IQueryStringNode*)attrNode.in();
		stringNode->set_tag("dt_Text");

		stringNode->set_string(findContext);
		LOG_D(("Search context = %s",findContext));
		//Устанавливаем тэг на ноду тэгов
		textTagNode->set_tag("dt_Text");
		//Связываем рутовую ноду с тэг-нодой
		rootNode->add_child_node((GblAdapter::IBaseEntity*)textTagNode.in(),aTagNode.out());
		//Связываем тэг ноду с нодой атрибутов
		textTagNode->add_child_node((GblAdapter::IBaseEntity*)stringNode.in(),aNode.out());
		//GblAdapter::IQueryexecuteProgressIndicator progress;
		GblAdapter::ICancelLongProcess_var cancel;
		int cnt = rootNode->get_all_child_count();
		//rootNode->get_child(0,aNode.out());
		//aNode->get_caption(iString.out());
		
		query->execute((GblAdapter::IList*)NULL,(GblAdapter::IQueryexecuteProgressIndicator*)NULL,(GblAdapter::ICancelLongProcess*&)cancel.out());
		//unsigned long cnt_find= query->get_count();
		//LOG_D(("Find %d %s",cnt,"documents"));
		


	
	} catch (GblAdapter::CanNotFindData &ex) {
		LOG_D(("Can't execute query, ", ex.id()));
		
	} catch (GblAdapter::Exception& ex) {
		LOG_CEX (((CORBA::Exception&) ex,"Error, while trying get information from server"));
	}

	
}

void SearchType(GblAdapter::ISearch* Search_mng,const char* findType)
{
	GblAdapter::ISearch* srch = (GblAdapter::ISearch*)Search_mng;
	
	
	
	GblAdapter::IQuery_var query;
	GblAdapter::INode_var aTagNode;

	GblAdapter::INodeBase_var typeOpt;
	GblAdapter::INodeBase_var typeOptVal;
	GblAdapter::INode_var aOP;
	GblAdapter::IQueryDictionaryNodeNew_var dictNode;
	GblAdapter::IString_var str;

	try {

		//Создаём  Query
		srch->create_query((GblAdapter::IQuery *&)query.out());
		query->set_name("My query");
	

		srch->get_attribute_tree_new("dt_Type",typeOpt.out());
		typeOpt->get_first_child(typeOptVal.out());
		/*typeOptVal->get_caption(str.out());	
		if (str->get_buffer() != findType)
		{

		}*/
		CreateQueryTagNode(query.in(), aTagNode.out(), "dt_Type");
		CreateQueryOperation(query.in(),aTagNode.in(),aOP.out(),GblAdapter::QLO_OR);
		SaveAttribute(query.in(),aTagNode.in(),"dt_Type",typeOptVal.in(),aOP.in());
		dictNode.out() = (GblAdapter::IQueryDictionaryNodeNew* )typeOptVal.in();
		
	
		LOG_D(("Search context = %s",findType));
		
		GblAdapter::ICancelLongProcess_var cancel;
	
		query->execute((GblAdapter::IList*)NULL,(GblAdapter::IQueryexecuteProgressIndicator*)NULL,(GblAdapter::ICancelLongProcess*&)cancel.out());
	
	
	} catch (GblAdapter::CanNotFindData &ex) {
		LOG_D(("Can't execute query", ex.id()));
		
	} catch (GblAdapter::Exception& ex) {
		LOG_CEX (((CORBA::Exception&) ex,"Error, while trying get information from server"));
	}

	
}
void ThreadFunc(void* Param)
{
	ThreadNumber++;
	LOG_D(("Start new thread"));
	char str[10000];
	sprintf(str,"Thread №: %d",ThreadNumber);
	LOG_D((str));
	ThreadParam* par = (ThreadParam*)Param;
	do{
		WaitForSingleObject( hThreadMutex, INFINITE );
		srand( (unsigned)time( NULL ) );
	
		{
			if (WaitForSingleObject( hRunMutex, 10L ) != WAIT_TIMEOUT) 
			{
				ReleaseMutex( hThreadMutex );
				return;
			}
			GblAdapter::IAuthorization_var authorization;
			GblAdapter::ICommon_var common_interfaces;
			GCL::Var<GblAdapter::ISettings> settings;
			GblAdapter::IString_var i_string;
			gbladapter_make_interface(authorization.out ());
			while (1)
			{
				try {
						authorization->login(par->user_login,par->user_pass, common_interfaces.out ());
						LOG_D(("login()::User login, login=%s, pass=%s",par->user_login,par->user_pass));
						break;
					} 
					catch (...) {
						try {
								authorization->autoregistration("Kirill",par->user_login,par->user_pass,"pugin@garant.ru",common_interfaces.out());
								LOG_D(("autoregistration()::UserRegistred, login=%s, pass=%s",par->user_login,par->user_pass));
								break;
							}
							catch (...){
								LOG_D(("Thread is sleep"));
								Sleep(610000);
								LOG_D(("Thread is waking"));
							}
					}
			}
			try {
					common_interfaces->get_settings(settings.out());
			} catch (GblAdapter::Exception& ex) {
				LOG_CEX (((CORBA::Exception&) ex,"Error, while trying get information from server"));
			}
			
			srand( (unsigned)time( NULL ) );
			while (GetRandom(0,20)!=5)
			{
				
				Run(settings.in());
			}
			authorization->logout();
			
			LOG_D(("logout()::User logout, login=%s, pass=%s",par->user_login,par->user_pass));
		}
		if (WaitForSingleObject( hRunMutex, 10L ) != WAIT_TIMEOUT) 
			{
				ReleaseMutex( hThreadMutex );
				return;
			}
	} while( WaitForSingleObject( hRunMutex, 50L ) == WAIT_TIMEOUT );
	ReleaseMutex( hThreadMutex );
	return;
}

GblAdapter::Date& Str2Date(const char* str/*,GblAdapter::Date& date_out*/)
{
	static GblAdapter::Date date;
	char ch[100];
	strcpy(ch,str);
	if (ch != "")
	{
	/*date_out.day = */date.day = atoi(strtok(ch,"/"));
	/*date_out.month = */date.month = atoi(strtok(NULL,"/"));
	/*date_out.year = */date.year= atoi(strtok(strtok(NULL,":"),"/"));
	} else {
		LOG_ERR(("String is empty!!!"));
	}
	return date;
}

bool TryConnect (GblAdapter::IAuthorization* authorization, ThreadParam* par, GblAdapter::ICommon*& common_interfaces)
{
	while (1) {
		try {
			authorization->login(par->user_login,par->user_pass, common_interfaces);
			LOG_D(("login()::User login, login=%s, pass=%s",par->user_login,par->user_pass));
			break;
		} catch (GblAdapter::WrongAuthentication) {
			try {
					authorization->autoregistration("Kirill",par->user_login,par->user_pass,"pugin@garant.ru",common_interfaces);
					LOG_D(("autoregistration()::UserRegistred, login=%s, pass=%s",par->user_login,par->user_pass));
					break;
			}	catch (GblAdapter::LoginDuplicate){
					LOG_D(("User %s already in user's base",par->user_login));
					return false;
			}	catch (GblAdapter::WrongAuthentication) {
					LOG_UEX(("WrongAuthentication"));
					return false;
			}	catch (...) {
					LOG_ERR(("Can't create new user"));
					return false;
			}
		}	catch (GblAdapter::AlreadyLogged) {
			LOG_D(("User %s already logged in",par->user_login));
			return false;
		}	catch (...) {
			LOG_ERR(("Can't login..."));
			return false;
		}
	}
	return true;
}
void funThrdTime(void* Param)
{
	ThreadParam* par = (ThreadParam*)Param;
	FileParam* rndText = (FileParam*) par->textF;
	FileParam* rndDoc = (FileParam*) par->docF;

		GblAdapter::ICommon_var common_interfaces;
		GblAdapter::IString_var i_string;
		GblAdapter::IDocument_var i_document;
		GblAdapter::IAuthorization_var authorization;
		GblAdapter::ISearch_var search;
		gbladapter_make_interface(authorization.out ());
		GblAdapter::ISettings_var settings;

	
		if (!TryConnect(authorization.in(), par, common_interfaces.out()))
		{
			
			return;
		}
		srand( (unsigned)time( NULL ) );
		long doc_num = 0;
		switch (/*GetRandom(0,1)*/par->flag)
		{
			case 0:
				
				common_interfaces->get_search(search.out());
				
				SearchDate(search.in(), Str2Date(rndText->get_rnd_data().c_str())/*, Str2Date("0/0/0:")*/);
				
			
				break;
			case 1:
				
				doc_num=atol((rndDoc->get_rnd_data()).c_str());
				try {
					common_interfaces->get_document_on_number(doc_num, i_document.out());
					GetDoc(i_document.in(),doc_num);
				} catch (GblAdapter::Exception& ex) {
					LOG_CEX (((CORBA::Exception&) ex,"Error, while trying get information from server"));
				}
			
				break;
			case 2:
				try{
					common_interfaces->get_settings(settings.out());
					Run(settings.in());
				}
				catch(...)
				{
				}
				break;
	
		}
		authorization->logout();

}
void funThrd(void* Param)
{
	ThreadParam* par = (ThreadParam*)Param;
	FileParam* rndText = (FileParam*) par->textF;
	FileParam* rndDoc = (FileParam*) par->docF;
		

	do{
		WaitForSingleObject( hThreadMutex, INFINITE );
		
		GblAdapter::ICommon_var common_interfaces;
		GblAdapter::IString_var i_string;
		GblAdapter::IDocument_var i_document;
		GblAdapter::IAuthorization_var authorization;
		GblAdapter::ISearch_var search;
		gbladapter_make_interface(authorization.out ());
		GblAdapter::ISettings_var settings;

		if (WaitForSingleObject( hRunMutex, 10L ) != WAIT_TIMEOUT) 
			{
				ReleaseMutex( hThreadMutex );
				return;
			}
		if (!TryConnect(authorization.in(), par, common_interfaces.out()))
		{
			ReleaseMutex( hThreadMutex );
			return;
		}
		srand( (unsigned)time( NULL ) );
		long doc_num = 0;
		while (GetRandom(0,20)!=5)
		{
		//	char dateStr[100];
		//	strcpy(dateStr,rndText->get_rnd_data().c_str());
			switch (/*GetRandom(0,1)*/par->flag)
			{
			case 0:
				
				common_interfaces->get_search(search.out());
				
				SearchDate(search.in(), Str2Date(rndText->get_rnd_data().c_str())/*, Str2Date("0/0/0:")*/);
				
				if (WaitForSingleObject( hRunMutex, 10L ) == WAIT_TIMEOUT) 
				{
					ReleaseMutex( hThreadMutex );
					return;
				}
				break;
			case 1:
				
				doc_num=atol((rndDoc->get_rnd_data()).c_str());
				try {
					common_interfaces->get_document_on_number(doc_num, i_document.out());
					GetDoc(i_document.in(),doc_num);
				} catch (GblAdapter::Exception& ex) {
					LOG_CEX (((CORBA::Exception&) ex,"Error, while trying get information from server"));
				}
				if (WaitForSingleObject( hRunMutex, 10L ) != WAIT_TIMEOUT) 
				{
					authorization->logout();
					ReleaseMutex( hThreadMutex );
					return;
				}
				break;
			case 2:
				try{
					common_interfaces->get_settings(settings.out());
					Run(settings.in());
				}
				catch(...)
				{
				}
				break;
			}
		/*	LOG_D(("Wait %d second",DELAY_OP/1000));
			if (WaitForSingleObject( hRunMutex, DELAY_OP ) != WAIT_TIMEOUT) 
				{
		*/			authorization->logout();
					ReleaseMutex( hThreadMutex );
					return;
			/*	}
			LOG_D(("Process continue work"));*/
		}
	//	delete date;
		authorization->logout();
	} while( WaitForSingleObject( hRunMutex, 50L ) == WAIT_TIMEOUT );
	ReleaseMutex( hThreadMutex );
}
void ShutDown( void )                  /* Shut down threads */
{
    while ( ThreadNr > 0 )
    {
            /* Tell thread to die and record its death. */
            ReleaseMutex( hRunMutex );
            ThreadNr--;   
    }
    /* Clean up display when done */
    WaitForSingleObject( hThreadMutex, INFINITE );
}
/*
int GetProcessList () 
{ 
    HANDLE         hProcessSnap = NULL; 
    BOOL           bRet      = FALSE; 
    PROCESSENTRY32 pe32      = {0}; 
	bRet = 0;
   
    hProcessSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); 

    if (hProcessSnap == INVALID_HANDLE_VALUE) 
        return (FALSE); 
 
    pe32.dwSize = sizeof(PROCESSENTRY32); 
 
   
    if (Process32First(hProcessSnap, &pe32)) 
    { 
        DWORD         dwPriorityClass; 
        BOOL          bGotModule = FALSE; 
        MODULEENTRY32 me32       = {0}; 
        do 
        { 
             if (_strcmpi(pe32.szExeFile, "testsrv.exe")==0)
			 {
				 bRet++;
			 }
             
        } 
        while (Process32Next(hProcessSnap, &pe32)); 
     
    } 
    else 
        bRet;    
    CloseHandle (hProcessSnap); 
    return (bRet); 
} 
*/

int main(int argc, char* argv[])
{	
	AutoTest* test;
	if (argc<2)
	{
		try {
			test= new AutoTest("Etalon", "Etalon");
		} catch (...) {
			return -1;
		}
		if (!test->is_connected())
			return 0;
		test->Set_Number(10164072);
		test->test_TextDocument(); //мерим время загрузки текста и структуры
									//и одновременно время загрузки адаптера
		Sleep(1000);
		test->test_GetList_by_search(test->test_Search_by_Date());
		Sleep(1000);
		test->test_GetList_by_search(test->test_Search_by_Frase());
		Sleep(1000);
		test->test_GetList_by_search(test->test_EmptySearch());
		Sleep(1000);
		test->test_GetList_by_search(test->test_Search_by_Attr());
		Sleep(1000);
		test->test_CreateSettings();
		Sleep(1000);
		test->test_ReadSettings();
		Sleep(1000);
		test->test_ReWriteSettings();
		delete test;
		gbladapter_done();

		printf("Press any key...");
		_getch();
	} else {
		int n_test = atoi(argv[1]);
		switch (n_test)
		{
			case -1:	//тесты не требующие определённого пользователя
				{
					try {
					test= new AutoTest("Etalon", "Etalon");
					} catch (...) {
						return -1;
					}
					test->Set_Number(10164072);
					test->test_TextDocument(); //мерим время загрузки текста и структуры
												//и одновременно время загрузки адаптера
					Sleep(1000);
					test->test_GetList_by_search(test->test_Search_by_Date());
					Sleep(1000);
					test->test_GetList_by_search(test->test_Search_by_Frase());
					Sleep(1000);
					test->test_GetList_by_search(test->test_EmptySearch());
					Sleep(1000);
					delete test;
					gbladapter_done();

					printf("Press any key...");
					_getch();
					break;
				}
			case -2:	//тесты не требующие определённого пользователя
				{
					try {
					test= new AutoTest("Etalon", "Etalon");
					} catch (...) {
						return -1;
					}
					test->test_GetList_by_search(test->test_Search_by_Attr());
					Sleep(1000);
					test->test_CreateSettings();
					Sleep(1000);
					test->test_ReadSettings();
					Sleep(1000);
					test->test_ReWriteSettings();
					delete test;
					gbladapter_done();

					printf("Press any key...");
					_getch();
					break;
				}
			case 1:	//тест загрузки структуры ГК
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->Set_Number(10164072);
				test->test_Struct();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 2:	//тест загрузки текста ГК
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->Set_Number(10164072);
				test->test_TextDocument();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 3:	//тест простого поиска
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_Search_by_Date();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 4:	//тест сложного поиска
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_Search_by_Attr();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 5:	//тест фразального поиска
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_Search_by_Frase();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 6:	//тест получения иерархического списка
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_GetList_by_search(test->test_Search_by_Attr());
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 7:	//тест получения списка всех документов
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_GetList_by_search(test->test_EmptySearch());
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 8:	//тест создания новых настроек
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_CreateSettings();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 9:	//тест перезаписи новых настроек
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 10:	//тест чтения новых настроек
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_ReadSettings();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 11:	//тест загрузки адаптера
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_LoadAdapter();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}

		}
	}
	return 0;
}