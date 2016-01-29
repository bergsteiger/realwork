#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "Garant/GblAdapter/Start/StartUnit.h"
#include "Garant/GblAdapter/CommonDefines.h"
#include "progress_i.h"
#include "FragmentList_i.h"

namespace UnitTest {

#define READ_BUFFER 500000L
class IniFile {
	public:
		IniFile();
		IniFile (const char *file_name);
		std::string read_string (const char *section_name, const char *key_name);
		void write_string(const char *section_name, const char *key_name, const char* value );
		int read_int (const char *section_name, const char *key_name);
		void set_file_name(const char *file_name)
		{
			m_file_name = file_name;
		}
	private:
		std::string m_file_name;
};

class BaseTest
{
public:
	BaseTest() : ini_file()
	{
	}
	BaseTest(const char* file_name):ini_file(file_name)
	{

	}
	void SetIniFile(const char* file_name)
	{
		ini_file.set_file_name(file_name);
	}
	virtual ~BaseTest();
	virtual void execute();
protected:
	IniFile ini_file;
};

class InitAdapter: public BaseTest {
public:
	virtual void execute();

};

class LoginTest: public BaseTest {
public:
	virtual void execute(const char* login, const char* password);
	virtual void LoginTest::execute(const char* login, const char* password, GblAdapter::ICommon*& common, GblAdapter::IAuthorization*& authorization);

};

class LoadDocument: public BaseTest {
public:
	virtual void execute(GblAdapter::IDocument* document);

};

class LoadStruct: public BaseTest {
public:
	virtual void execute(GblAdapter::IDocument*);

};

class StartSearch: public BaseTest {
public:
	virtual void execute(GblAdapter::IQuery*);
	virtual void execute(GblAdapter::IQuery*, GblAdapter::IList*& List);

};

class LoadList: public BaseTest {
public:
	virtual void execute(GblAdapter::IList* List);
};

class LoadDocumentFromList: public BaseTest {
public:
	LoadDocumentFromList() : curr_child(0)
	{
	}
	virtual void execute(GblAdapter::IList* List, GblAdapter::IDocument*& document);

protected:
	long curr_child;

};

} //end namespace UnitTest