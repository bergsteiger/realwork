///////////////////////////////////////////////////////////////////////////////
//
// Класс контекста программы Garant change
//
///////////////////////////////////////////////////////////////////////////////

#ifndef CONTEXT_H
#define CONTEXT_H

#include    "parser.h"
#include    "stdbase.h"
#include    "gardefs.h"

// Класс Context //////////////////////////////////////////////////////////////
//
// Назначение:
//  хронение данных для передачи их другим модулям, а также выполнение
//  некторых операций
//

const   long    s_bufsize = 8000000;
const   long    s_maxstr  = 1024;
const   long    s_maxseg  = 400;

const   char    s_DocId[]     = "DocId";
const   char    s_InfoForce[] = "InfoForce";
const   char    s_Here[]      = "Here";
const   char    s_Belongs[]   = "Belongs";
const   char    s_ExcludeBelongs[]   = "ExcludeBelongs";
const   char    s_Belongss[]  = "Belongss";
const	char	s_LastDate[]  = "LastDate";
const	char	s_Date[]      = "Date";
const   char    s_Id[]        = "Id";
const   char    s_Type[]      = "Type";
const   char    s_FastType[]      = "FastType";
const	char	s_PublishedIn[] = "PublishedIn";
const   char    s_ServiceInfo[] = "ServiceInfo";
const   char    s_Source[]    = "Source";
const   char    s_FastSource[]    = "FastSource";
const   char    s_Class[]     = "Class";
const   char    s_AnnoTax[]     = "AnnoTax";
const   char    s_AnnoInterest[]= "AnnoInterest";
const   char    s_PreAnnoTax[]     = "PreAnnoTax";
const   char    s_PreAnnoInterest[]= "PreAnnoInterest";
const   char    s_FastClass[] = "FastClass";
const   char    s_Name[]      = "Name";
const   char    s_Prefix[]    = "Prefix";
const   char    s_Norm[]      = "Norm";
const   char    s_Keyword[]   = "Keyword";
const   char    s_Handmask[]  = "Handmask";
const   char    s_Territory[] = "Territory";
const   char    s_DocKind[]   = "DocKind";
const   char    s_Kind[]      = "Kind";
const   char    s_Blob[]      = "Blob";
const   char    s_FastBlob[]      = "FastBlob";
const   char    s_NoDoc[]     = "NoDoc";
const   char    s_RealNoDoc[] = "RealNoDoc";
const	char	s_Editions[]  = "Editions";
const   char    s_Doc[]       = "Doc";
const   char    s_Related[]   = "Related";
const   char    s_Anno[]      = "Anno";
const	char	s_Status[]    = "Status";
const	char	s_Status_ex[]    = "Status_ex";
const	char	s_Status_exex[]    = "Status_exex";
const	char	s_AAKRefs[]    = "AAKRefs";
const	char	s_Active[]    = "Active";
const	char	s_Warning[]   = "Warning";
const	char	s_ShortName[] = "ShortName";
const	char	s_Samedocs[]  = "Samedocs";
const   char    s_Add[]       = "add";
const   char    s_Change[]    = "change";
const   char    s_Set[]       = "set";
const   char    s_Remove[]    = "remove";
const   char    s_If[]        = "if";
const   char    s_Then[]      = "then";
const   char    s_Once[]      = "once";
const   char    s_Finally[]      = "finally";
const   char    s_End[]       = "end";
const   char    s_BelongsForIds[] = "BelongsForIds";
const   char    s_BelongsForIdsN[] = "BelongsForIdsN";
const   char    s_BelongsForIdsRelateds[] = "BelongsForIdsRelateds";
const   char    s_BelongsForIdsEditions[] = "BelongsForIdsEditions";
const   char    s_BelongsForBlobs[] = "BelongsForBlobs";
const   char    s_BelongsForIdsBlobs[] = "BelongsForIdsBlobs";
const	char	s_AccountTopic[]  = "AccountTopic";
const	char	s_UserInfoTopic[] = "UserInfoTopic";
const	char	s_AltMenuTopic[]  = "AltMenuTopic";
const	char	s_BusinessTopic[] = "BusinessTopic";
const	char	s_SplashTopic[] = "SplashTopic";
const	char	s_BannerTopic[] = "BannerTopic";
const	char	s_Status128ForIds[] = "Status128ForIds";
const	char	s_RelatedForIds[] = "RelatedForIds";
const	char	s_Keywords [] = "Keywords";
const	char	s_Casecode[] = "Casecode";
const	char	s_PublishedIns [] = "PublishedIns";
const	char	s_Correspondents [] = "Correspondents";
const	char	s_Respondents [] = "Respondents";
const   char    s_Attrs[] = "Attrs";
const   char    s_Aux[] = "Aux";
const	char	s_Index[] = "Index";
const	char	s_result[] = "result";
const	char	s_blobresult[] = "blobresult";
const	char	s_push[] = "push";
const	char	s_PrevEdition[] = "PrevEdition";
const	char	s_NextEdition[] = "NextEdition";
const	char	s_AnnoTax2AnnoInterest[] = "AnnoTax2AnnoInterest";
const	char	s_ProfDocs[] = "ProfDocs";

class   Context {

public:

    Context();
    Context(char *pBaseFileName, char *pRulesFileName = 0, char *pLogFileName = 0);
    ~Context();

    Base *base(void) const;
    void base(YBase *base);
    long parse_command_line(long argc, char **argv);
    long parse_rules(void);
    void do_changes(void);
    long check_condition(Condition &theCondition, long docId);
	void do_action(ChangeAction &theAction, long docId, std::string indent);
    long find_string(long docId, const char *str, long tag);
    long fast_find_string(long docId, const char *str, long tag);
    long find_notnot_string(long docId, const char *str, long tag);
    long fast_find_notnot_string(long docId, const char *str, long tag);
    void set_gl(long flag);
    void rule(RuleParser *pNewRule);
    RuleParser *rule(void);
    int fprintf(FILE *str, const char *format, ...);
    int fflush(FILE *);
	void init ();

    // Работа с BaseInfo
    void add_baseinfo(long id, const char *rusName, const char *engName, long weight);
    void remove_baseinfo(long id);
    void sort_baseinfo(BaseInfo *pBaseInfo, long count);
    void recalc_bases(void);

    // Работа с Here
    void add_here(long id);
    void remove_here(long id);
    void sort_here(short *pHere, long count);

    // Работа с ключами индексов
    void add_keyindex(void *key, Index *index);
    void remove_keyindex(void *key, Index *index);

    bool add_string(long docId, const char *str, long tag, long key_size = 0);
    void remove_string(long docId, const char *str, long tag);

    // Работа с belongs
    bool add_belongs(long docId, long segment);
    void remove_belongs(long docId, long segment);

    // Работа с индексами
    long add_str_index(long tag, const char *pKeyStr, long docId);
    long del_str_index(long tag, const char *pKeyStr, long docId, long delLevel);
    long add_str_index(long tag, const char *pKeyStr, Ref ref);
    long del_str_index(long tag, const char *pKeyStr, Ref ref);
    long add_stream_doc(Index *pInd, const void *pKey, long docId);
    long del_stream_doc(Index *pInd, const void *pKey, long docId, long keepKey = false);
    long add_stream_ref(Index *pInd, const void *pKey, Ref ref);
    long del_stream_ref(Index *pInd, const void *pKey, Ref ref, long keepKey = false);
    Index *select_index(long tag);

    // Работа с документом
    list<long> get_docs(long docId, long refType, bool slow = false);

	void	change_doc_revision( long docId );

protected:
	void initObj();
	
public:
    void	set_baseinfo_revision (revision r);

private:
    revision baseinfo_revision;
    DocCollection* allTopic;
    YBase *m_pBase;
    long m_needGl;
	bool b_norecalc;
	bool b_readonly;
    long m_baseChanged;
    string m_baseFileName;
    string m_rulesFileName;
    string m_logFileName;
    long m_needLog;
    FILE *m_pLogFile;
    RuleParser *m_pRulesParser;
    list<short> m_calcBases;
    revision rrevision;
    bool changedocrevision;

	std::map<long, std::set<long> > map_doc_editions;
	std::map<long,long> map_edition_doc;
	std::map<long, DocInfo> map_doc_docinfo;
	std::set<long> blob_keys;

	std::set<long> finally_docs;
	bool b_finally;


	std::map<long, DocInfo>::iterator get_doc_info (long);

	std::map<long, short*> map_doc_belongs;
	std::map<long, short> map_doc_belongscount;
	short get_belongs (long id, void *buf);
	void put_belongs (long id, void* buf, short count);

	void	blob_add_belongs (long, short);
	void	blob_del_belongs (long, short);

	std::map<long,void*> map_tag_data;
	std::map<long,long> map_tag_datasize;
};

#endif // CONTEXT_H
