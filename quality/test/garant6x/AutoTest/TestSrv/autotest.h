#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "Garant/GblAdapter/Start/StartUnit.h"
#include "Garant/GblAdapter/CommonDefines.h"
#include "progress_i.h"

#define RESULT_FILE ".\\result.csv"
using namespace GCL;


class AutoTest
{
public:
	class AutoTestError : public std::exception {
	public:
		AutoTestError () 
		{
			m_err = "Error in create AutoTest";
		}
		virtual ~AutoTestError () {}
		
		const char* what() const throw() {
			return m_err.c_str ();
		}

	protected:
		std::string m_err;
	};
public:
	AutoTest(char* login, char* pass):m_common_interfaces(0),
										m_query(0),
										m_authorization(0)
										
	{
		m_file = fopen( RESULT_FILE, "a" );
		try {
			test_LoadAdapter();
			//sprintf(m_user_login, "%s", login);
			//sprintf(m_user_pass, "%s", pass);
			m_user_login.assign(login);
			m_user_pass.assign(pass);
			gbladapter_make_interface(m_authorization.out());
			m_connected = TryConnect();
		} catch (AutoTestError&) {
			LOG_ERR(("Can't init adapter"));
			throw;
		}
	}
	
	~AutoTest()
	{	
		//delete m_common_interfaces;
		//delete m_authorization;
		fclose(m_file);
//		gbladapter_done();
	}
public: //список авто-тестов
	GblAdapter::IDocument* test_Struct(); //тестирование метода получения структуры
	void test_TextDocument(); //тестирование метода получения текста документа
	GblAdapter::IList* test_Search_by_Date();//тестирование поиска по дате
	GblAdapter::IList* test_Search_by_Attr();//тестирование сложного поиска
	GblAdapter::IList* test_Search_by_Frase(char cntxt[] = "Конституция Российской Федерации");//тестирование поиска по контексту
	void test_GetList();//тестирование получения списка документов в результате
						//поиска
	void test_GetListAll();//тестирование получения списка всех документов
	void test_ReadSettings();//тестирование метода чтения настроек
	void test_ReWriteSettings();//тестирование метода перезаписи настроек
	void test_CreateSettings();//тестирование метода записи настроек
	void test_LoadAdapter() throw(AutoTestError);//тестирование загрузки адаптера
	GblAdapter::IList* test_EmptySearch();//тестирование поиска по пустому запросу
	bool TryConnect();//функция, пытающаяся законнектиться на сервер
						//под заданным логином и паролем (m_user_login - m_user_pass)
	GblAdapter::INode* AutoTest::get_node_from_folder();
	void test_GetList_by_search(GblAdapter::IList*);
public:
	void Set_Number(long num)
	{
		m_DocNumber = num;
	}
	void Set_SearchAttr(GblAdapter::IQuery* query)
	{
		m_query = GblAdapter::IQuery::_narrow(query);
	}
	bool is_connected() {
		return m_connected;
	}
	void EndWriteTime()
	{
		fprintf(m_file,"\n");
	}
protected:
	long m_DocNumber;
	GblAdapter::IQuery* m_query;
	GblAdapter::ICommon_var m_common_interfaces;
	GblAdapter::IAuthorization_var m_authorization;
	std::string m_user_login;
	std::string m_user_pass;
	bool m_connected;
	FILE* m_file;
};

