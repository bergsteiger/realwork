#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "Garant/GblAdapter/Start/StartUnit.h"
#include "Garant/GblAdapter/CommonDefines.h"
#include "Garant/GblAdapter/Document/DataReadingStream_i.h"
#include "Garant/GblAdapter/Search/QueryTagNode_i.h"
#include "Garant/GblAdapter/Search/Query_i.h"


#define GetRandom( min, max ) ((rand() % (int)(((max) + 1) - (min))) + (min))

void CreateQueryOperation(GblAdapter::IQuery* aQuery,
                               GblAdapter::INode* aTagNode,
                               GblAdapter::INode*& aOP,
                               GblAdapter::QueryLogicOperation aLO,
							   bool aNegative = false);
void SaveAttribute(GblAdapter::IQuery* aQuery,
                        GblAdapter::INode* aTagNode,
                        char* aTagName,
                        GblAdapter::INodeBase* aDictNode,
						GblAdapter::INode* aOP);

void CreateQueryTagNode(GblAdapter::IQuery* aQuery,
                             GblAdapter::INode*& aTagNode,
                             char* aTagName);
void SaveDate(GblAdapter::IQuery* aQuery,
                   GblAdapter::INode* aTagNode,
                   char* aTagName,
				   GblAdapter::Date dStart,
				   GblAdapter::Date dFinish);

class FileParam
{
	public:
		FileParam(LPCSTR lpFileName):vect(0)
		{
			if (lpFileName !="")
			{
				strcpy(m_fileName,lpFileName);
				this->m_File = _open(lpFileName,NULL,_O_TEXT | _O_RDONLY);
			}
			
		};
		FileParam():vect(0)
		{
			this->m_File = NULL;
		};
		~FileParam()
		{
			if (_close(this->m_File)) 
			{ 
				throw; 
			} 
			//m_File = NULL;
		};
		bool open_file (LPCSTR lpFileName)
		{
			if (this->m_File != NULL)
			{
				this->m_File = _open(lpFileName,NULL,_O_TEXT | _O_RDONLY);
				strcpy(m_fileName,lpFileName);
				if (this->m_File == NULL)
					return false;
				return true;
			}
			return true;
		};
	
		void FillVector()
		{
			char buffer[100000];
			unsigned long readbytes = _read(m_File,&buffer,100000);
			buffer[readbytes] = '\0';
			char* ch =strtok(buffer,"\n");
			std::string str;
			str.assign(ch);
			vect.push_back(str);
			
			while ((ch = strtok(NULL,"\n")) != NULL)
			{
				
				str.assign(ch);
				vect.push_back(str);
			}
			unsigned long size = this->vect.size();
			//ch = this->vect[0];
			return;
		};
		string get_rnd_data()
		{	if (this->vect.size() == 0)
				this->FillVector();
			srand( (unsigned)time( NULL ) );
			long l_rnd = GetRandom(0,this->vect.size()-1);
			std::string ch = this->vect[l_rnd];
			return this->vect[l_rnd];
		}
	protected:
		std::vector<std::string> vect;
		HFILE m_File;
		char m_fileName[255];
		
};

class ThreadParam
{
public:
	ThreadParam(int s1=1,int s2=1)
	{
		sprintf(user_login, "%d",s1);
		sprintf(user_pass, "%d",s2);
	};
	char user_login[100];
	char user_pass[100];
	FileParam* textF;
	FileParam* docF;
	int flag;


	
};

