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
public: //������ ����-������
	GblAdapter::IDocument* test_Struct(); //������������ ������ ��������� ���������
	void test_TextDocument(); //������������ ������ ��������� ������ ���������
	GblAdapter::IList* test_Search_by_Date();//������������ ������ �� ����
	GblAdapter::IList* test_Search_by_Attr();//������������ �������� ������
	GblAdapter::IList* test_Search_by_Frase(char cntxt[] = "����������� ���������� ���������");//������������ ������ �� ���������
	void test_GetList();//������������ ��������� ������ ���������� � ����������
						//������
	void test_GetListAll();//������������ ��������� ������ ���� ����������
	void test_ReadSettings();//������������ ������ ������ ��������
	void test_ReWriteSettings();//������������ ������ ���������� ��������
	void test_CreateSettings();//������������ ������ ������ ��������
	void test_LoadAdapter() throw(AutoTestError);//������������ �������� ��������
	GblAdapter::IList* test_EmptySearch();//������������ ������ �� ������� �������
	bool TryConnect();//�������, ���������� �������������� �� ������
						//��� �������� ������� � ������� (m_user_login - m_user_pass)
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

