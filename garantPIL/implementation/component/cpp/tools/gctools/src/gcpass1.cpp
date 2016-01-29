/*
* $Id: gcpass1.cpp,v 2.223 2015/06/09 09:48:17 young Exp $
*/
#include "gardefs.h"
#include "garcomp.h"
#include "fstring.h"
#include "long.long.VHMap.h"
#include "long.long.SplayMap.h"
#include "CaseString.defs.h"
#include "u_int32_t.VHSet.h"
#include "fstringer.h"
#include "sttop.h"
#include "sources.h"
#include "nsrccmd.h"
#include "base.h"
#include "rev.h"

extern	bool	bIgnoreFatal;
extern	void	localrev_adddays ( revision& theRev, const int days );

#ifdef OLD_MAP
	extern	longSplaySet	hereBelongs;
#else
	extern	GSubMap hereBelongs;
	//extern	longSplaySet	hereBelongs;
#endif

std::deque<std::string> errors;

std::map<long, const char*> topicNSR;
const char* topicNSR_unknown = "'unknown nsr'";
const char* get_topicNSR (long doc) {
	std::map<long,const char*>::const_iterator map_it = topicNSR.find (doc);
	if (map_it == topicNSR.end ())
		return topicNSR_unknown;
	else
		return map_it->second;
}

#ifdef __WIN32__
#define atoll _atoi64
#endif

#ifdef	GARANT_TOOLS
long long atoll( const char* str )
{
	return strtoll( str, 0, 10 );
}
#endif

#ifdef VERSION56
struct DateInterval {
	struct date from;
	struct date to;
	enum {Active, Noactive, Preactive} act;
};
typedef std::map<topic_t, DateInterval> Intervals;

bool fatalErrors = false;
std::map<long,long> rev_editions_map;

int is_next(date prev, date next) {
	if (prev.da_year+1==next.da_year && prev.da_mon==12 && next.da_mon==1 && 
		prev.da_day==31 && next.da_day==1) return 1;
	if (prev.da_year!=next.da_year) return 0;
	if (prev.da_mon==next.da_mon && prev.da_day+1==next.da_day) return 1;
	if (prev.da_mon+1!=next.da_mon) return 0;
	if (next.da_day!=1) return 0;
	if ((prev.da_mon==1 || prev.da_mon==3 || prev.da_mon==5 || 
		prev.da_mon==7 || prev.da_mon==8 || prev.da_mon==10) && prev.da_day==31) return 1;
	if (prev.da_day==30) return 1;
	if (prev.da_mon!=2) return 0;
	if (prev.da_day==29) return 1;
	if (!(prev.da_year%4)) return 0;
	if (prev.da_day==28) return 1;
	return 0;
}

static void check(const Intervals& activity, ThreadCompileInfo& tcinfo)
{
	for (std::deque<long>::const_iterator it = tcinfo.editions->begin (); it != tcinfo.editions->end (); it++) {
		topic_t ttt= *it;
		// ищем топик, который на него ссылается
		VerLink::const_iterator j;
		for (j=tcinfo.m_next->begin(); j!=tcinfo.m_next->end(); j++) {
			if (j->first==ttt) {
				break;
			}
		}
		if (j==tcinfo.m_next->end()) { // не нашли топика, ссылающегося на этот, который с !EDITION
			// ищем топик, на который он ссылается
			for (j=tcinfo.m_next->begin(); j!=tcinfo.m_next->end(); j++) {
				if (j->second==ttt) {
					break; // ссылается, коварный
				}
			}
			if (j==tcinfo.m_next->end()) {
				gclog.noHdr();
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "!EDITION стоит, но никто сюда не ссылается (топик %d, %s).\n", ttt-REAL_DOC_OFFS, get_topicNSR (ttt));
				if (bIgnoreFatal)
					tcinfo.bad_docs->insert (ttt);
			} else {
				if (tcinfo.map_doc_subs->find (j->first) == tcinfo.map_doc_subs->end ()) {
					//из него, конечно, есть ссылка, но того документа нет
					gclog.noHdr();
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "!EDITION стоит, но никто сюда не ссылается (топик %d, %s).\n", ttt-REAL_DOC_OFFS, get_topicNSR (ttt));
					if (bIgnoreFatal)
						tcinfo.bad_docs->insert (ttt);
				}
			}
		}
	}

	VerLink::const_iterator j;
	for (j=tcinfo.m_next->begin(); j!=tcinfo.m_next->end(); j++) {
		long tmpLong= j->first;
		if (tcinfo.map_doc_subs->find (tmpLong) == tcinfo.map_doc_subs->end ()) {
			fatalErrors = true;
			gclog.noHdr();
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "!VERLINK на отсутствующий топик %d (%s) из %d (%s).\n", tmpLong-REAL_DOC_OFFS, get_topicNSR (tmpLong), j->second-REAL_DOC_OFFS, get_topicNSR (j->second));
			if (bIgnoreFatal) {
				tcinfo.bad_docs->insert (tmpLong);
				tcinfo.bad_docs->insert (j->second);
			}
		}
	}

	for (j=tcinfo.m_next->begin(); j!=tcinfo.m_next->end(); j++) {
		long tmpLong=j->first;
		if (tcinfo.notADocs->contains(tmpLong) && !std::binary_search (tcinfo.editions->begin (), tcinfo.editions->end (), tmpLong)) {
			gclog.noHdr();
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "!VERLINK не может ссылаться на !NODOC (%d,%s на %d,%s).\n", j->second-REAL_DOC_OFFS, get_topicNSR (j->second), tmpLong-REAL_DOC_OFFS, get_topicNSR (tmpLong));
			if (bIgnoreFatal)
				tcinfo.bad_docs->insert (j->second);
		}
	}
	
#ifdef	VERSION56
	longSplaySet *editionsWithError = new longSplaySet;
	longSplaySet *checkedEditions = new longSplaySet;
	for (j=tcinfo.m_next->begin(); j!=tcinfo.m_next->end(); j++) {
		bool foundDoc = false;
		long old=j->first, neo=j->second;

		if ( checkedEditions->contains( old ) || checkedEditions->contains( neo ) || editionsWithError->contains( old ) || editionsWithError->contains( neo ))
			continue;

		checkedEditions->add (old);
		checkedEditions->add (neo);

		long doc_id = 0;
		if ((tcinfo.map_doc_subs->find (old) != tcinfo.map_doc_subs->end ()) && !std::binary_search (tcinfo.editions->begin (), tcinfo.editions->end (), old) && !tcinfo.notADocs->contains (old)) {
			foundDoc = true;
			doc_id = old;
		} else if ((tcinfo.map_doc_subs->find (neo) != tcinfo.map_doc_subs->end ()) && !std::binary_search (tcinfo.editions->begin (), tcinfo.editions->end (), neo) && !tcinfo.notADocs->contains (neo)) {
			foundDoc = true;
			doc_id = neo;
		}

		for (VerLink::const_iterator i=tcinfo.m_next->begin(); i!=tcinfo.m_next->end(); i++ ) {
			long t=i->first;
			long tt=i->second;
			checkedEditions->add(t);
			if ((tcinfo.map_doc_subs->find (t) != tcinfo.map_doc_subs->end ()) && !std::binary_search (tcinfo.editions->begin (), tcinfo.editions->end (), t) && !tcinfo.notADocs->contains (t)) {
				foundDoc = true;
				doc_id = t;
			} else if ((tcinfo.map_doc_subs->find (tt) != tcinfo.map_doc_subs->end ()) && !std::binary_search (tcinfo.editions->begin (), tcinfo.editions->end (), tt) && !tcinfo.notADocs->contains (tt)) {
				foundDoc = true;
				doc_id = tt;
			} else if ( editionsWithError->contains(t)) {
				foundDoc = true;
			}
		}

		if ( !foundDoc ) {
			editionsWithError->add(j->first);
			gclog.noHdr();
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "!EDITION стоит, в цепочке нет !DOC. Редакция %d (%s).\n", j->first - ID_BORDER, get_topicNSR (j->first));
		}
	}
	delete editionsWithError;
	delete checkedEditions;
#endif

	// Проверка ссылок друг на друга (циклических).
	// сперва надо собрать редакции одного документа в порядке возрастания редакции
	// затем собрать для него только левые топики в порядке возрастания редакции
	// затем посмотреть если справа из будущего ссылка налево назад
	// если есть, то это циклическая ссылка
	// если нет, то собрать редакции для следующего документа
	for (j=tcinfo.m_next->begin(); j!=tcinfo.m_next->end(); j++) {
		topic_t old=j->first;
		topic_t neo=j->second;

		VerLink::const_iterator i=j;
		VerLink bones;
		bones[old]=neo;
		while (i!=tcinfo.m_next->end() && ++i!=tcinfo.m_next->end()) {
			if (i->first==neo || i->second==old) {
				bones[i->first]=i->second;
				neo=i->second;
				old=i->first;
			}
		}

		typedef std::set<topic_t> Line;
		Line line;
		i=bones.begin();
		topic_t left=i->first;
		topic_t right=i->second;
		line.insert(left);
		line.insert(right);
		while ((i=bones.find(right))!=bones.end()) { // сперва идём влево по времени
			if (line.find(i->second)!=line.end()) {
				fatalErrors = true;
				gclog.noHdr();
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "!VERLINK циклическая ссылка: топики %d (%s) и %d (%s).\n", right-REAL_DOC_OFFS, get_topicNSR (right), i->second-REAL_DOC_OFFS, get_topicNSR (j->second));
				break;
			}
			line.insert(i->second);
			right=i->second;
		}
		i=bones.begin();
		for (++i; i!=bones.end(); i++) { // теперь вправо по времени
			if (i->second==left) {
				if (line.find(i->first)!=line.end()) {
					fatalErrors = true;
					gclog.noHdr();
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "!VERLINK циклическая ссылка: топики %d(%s) и %d (%s).\n", left-REAL_DOC_OFFS, get_topicNSR (left), i->first-REAL_DOC_OFFS, get_topicNSR (i->first));
					break;
				}
				line.insert(i->first);
				left=i->first;
			}
		}
	}

	std::set<long> processed_ids;
	if (!fatalErrors) for (std::map<long,long>::const_iterator map_it = tcinfo.editions_map->begin (); map_it != tcinfo.editions_map->end (); map_it++) {
		bool absent_topic = false;
		long id = map_it->first;
		std::set<long> docs;
		if (processed_ids.find (id) == processed_ids.end ()) {
			std::map<long,long>::const_iterator it = map_it;
			processed_ids.insert (id);
			if (!tcinfo.notADocs->contains (id) && !std::binary_search (tcinfo.editions->begin (), tcinfo.editions->end (), id))
				docs.insert (id);
			absent_topic |= (tcinfo.map_doc_subs->find (id) == tcinfo.map_doc_subs->end ());

			std::set<long> processed_verlinks;
			while (it != tcinfo.editions_map->end ()) {
				long verlink = it->second;
				if (processed_verlinks.find (verlink) != processed_verlinks.end ())
					break;
				processed_verlinks.insert (verlink);
				absent_topic |= (tcinfo.map_doc_subs->find (verlink) == tcinfo.map_doc_subs->end ());
				processed_ids.insert (verlink);
				if (!tcinfo.notADocs->contains (verlink) && !std::binary_search (tcinfo.editions->begin (), tcinfo.editions->end (), verlink))
					docs.insert (verlink);
				it = tcinfo.editions_map->find (verlink);
			}
			processed_verlinks.clear ();

			it = rev_editions_map.find (id);
			while (it != rev_editions_map.end ()) {
				long verlink = it->second;
				if (processed_verlinks.find (verlink) != processed_verlinks.end ())
					break;
				processed_verlinks.insert (verlink);
				absent_topic |= (tcinfo.map_doc_subs->find (verlink) == tcinfo.map_doc_subs->end ());
				processed_ids.insert (verlink);
				if (!tcinfo.notADocs->contains (verlink) && !std::binary_search (tcinfo.editions->begin (), tcinfo.editions->end (), verlink))
					docs.insert (verlink);
				it = rev_editions_map.find (verlink);
			}

			if (docs.size () > 1 && !absent_topic) {
				fatalErrors = true;
				gclog.noHdr();
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "В цепочке больше одного !DOC. Редакция %d (%s).\n", id - ID_BORDER, get_topicNSR (id));
				if (bIgnoreFatal)
					tcinfo.bad_docs->insert (id);
			} else 
			if (docs.size () == 0) {
				gclog.noHdr();
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "!EDITION стоит, в цепочке нет !DOC. Редакция %d (%s).\n", id - ID_BORDER, get_topicNSR (id));
				if (bIgnoreFatal)
					tcinfo.bad_docs->insert (id);
			}
		}
	}

	// теперь будем проверять диапазоны действия редакций
	// бежим по верлинкам, они содержат пары: кто ссылается, на кого ссылается
	for (VerLink::const_iterator i=tcinfo.m_next->begin(); i!=tcinfo.m_next->end(); i++) {
		topic_t old=i->first;
		topic_t neo=i->second;
		Intervals::const_iterator p=activity.find(old); // интервал действия того, на кого ссылаются
		Intervals::const_iterator n=activity.find(neo); // интервал действия того, кто ссылается

		if (p!=activity.end() && n!=activity.end()) {
			if (p->second.act==DateInterval::Preactive) {
				if (n->second.act==DateInterval::Noactive) {
					gclog.noHdr();
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "NOACTIVE %d(%s) имеет предыдущую редакцию PREACTIVE %d(%s).\n", n->first-REAL_DOC_OFFS, get_topicNSR (n->first), p->first-REAL_DOC_OFFS, get_topicNSR (p->first));
				} else if (n->second.act==DateInterval::Active) {
					gclog.noHdr();
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ACTIVE %d(%s) имеет предыдущую редакцию PREACTIVE %d(%s).\n", n->first-REAL_DOC_OFFS, get_topicNSR (n->first), p->first-REAL_DOC_OFFS, get_topicNSR (p->first));
				}
			} else if (p->second.act==DateInterval::Noactive) {
				if (p->second.to.da_year) {
					if (n->second.act==DateInterval::Noactive && !n->second.to.da_year) {
						gclog.noHdr();
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "NOACTIVE %d(%s) без даты имеет предыдущую редакцию NOACTIVE %d(%s) с датой.\n", n->first-REAL_DOC_OFFS, get_topicNSR (n->first), p->first-REAL_DOC_OFFS, get_topicNSR (p->first));
					} else if (n->second.act==DateInterval::Noactive && !is_lt(p->second.to, n->second.to)) {
						gclog.noHdr();
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "NOACTIVE %d(%s) прекращает действие раньше, чем предыдущая редакция NOACTIVE %d(%s).\n", n->first-REAL_DOC_OFFS, get_topicNSR (n->first), p->first-REAL_DOC_OFFS, get_topicNSR (p->first));
					} else if (n->second.act==DateInterval::Active && n->second.from.da_year) {
						if (!is_lt(date_plusdays(p->second.to,-1), n->second.from)) {
							gclog.noHdr();
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ACTIVE %d(%s) начинает действие раньше, чем кончается предыдущая редакция NOACTIVE %d(%s).\n", n->first-REAL_DOC_OFFS, get_topicNSR (n->first), p->first-REAL_DOC_OFFS, get_topicNSR (p->first));
						} else if (is_lt(p->second.to, n->second.from)) {
							date d1 = p->second.to;
							date d2 = n->second.from;
							if ( d1.da_year && d2.da_year ) {
								gclog.noHdr();
								gclog.printfC (errors, AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "Нарушена последовательность действия документов %d(%s) и редакции %d(%s). Есть интервал, когда нет действующей редакции.\n", n->first-REAL_DOC_OFFS, get_topicNSR (n->first), p->first-REAL_DOC_OFFS, get_topicNSR (p->first));
							} else {
								gclog.noHdr();
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Нарушена последовательность действия документов %d(%s) и редакции %d(%s). Есть пересекающийся интервал.\n", n->first-REAL_DOC_OFFS, get_topicNSR (n->first), p->first-REAL_DOC_OFFS, get_topicNSR (p->first));
							}
							/*
							gclog.noHdr();
							gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,
								"Нарушена последовательность действия документов %d и редакции %d.\n",
								n->first-REAL_DOC_OFFS, p->first-REAL_DOC_OFFS);
							*/
						}
					}
				}
			} else if (n->second.act==DateInterval::Preactive) {
			} else if (!is_next(p->second.to, n->second.from)) {
				if ( p->second.act==DateInterval::Active && n->second.act==DateInterval::Noactive ) {
					//ситуация - active, следующий за ним - noactive.
					//надо соответственно найти следующий топик с active, и сравнить с ним
					topic_t newneo = neo;
					for (VerLink::const_iterator j=tcinfo.m_next->begin(); j!=tcinfo.m_next->end(); ) {
						topic_t t=j->first;
						if ( t == newneo ) {
							//нашли топик, который следующий в цепочке
							Intervals::const_iterator tt=activity.find(newneo);
							if ( tt->second.act==DateInterval::Noactive ) {
								//и этот недействующий. Ищем следующий
								newneo = j->second;
								j=tcinfo.m_next->begin();
							}
							else
								break;
						}
						else
							j++;
					}
					//сравнить old и newneo
					Intervals::const_iterator newn=activity.find(newneo);
					date d1 = p->second.to;
					date d2 = newn->second.from;
					date dd1 = p->second.from;
					date dd2 = newn->second.to;
					short a1 = p->second.act;
					short a2 = newn->second.act;
					if ( !is_next( d1, d2 ) && d2.da_year ) {
						gclog.noHdr();
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Нарушена последовательность действия документов %d(%s) и редакции %d(%s).\n", old-REAL_DOC_OFFS, get_topicNSR (old), newneo-REAL_DOC_OFFS, get_topicNSR (newneo));
					} else
					if ( a1 == DateInterval::Active && a2 == DateInterval::Noactive && !d1.da_year && !d2.da_year && is_lt( dd1, dd2 )) {						
						gclog.noHdr();
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Нарушена последовательность действия документов %d(%s) и редакции %d(%s). Есть пересекающийся интервал.\n", old-REAL_DOC_OFFS, get_topicNSR (old), newneo-REAL_DOC_OFFS, get_topicNSR (newneo));
					}
				} else {
					gclog.noHdr();
					date d1 = p->second.to;
					date d2 = n->second.from;
					if ( is_lt( d1, d2 ) && d1.da_year ) {
						gclog.noHdr();
						gclog.printfC (errors, AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "Нарушена последовательность действия документов %d(%s) и редакции %d(%s). Есть интервал, когда нет действующей редакции.\n", n->first-REAL_DOC_OFFS, get_topicNSR (n->first), p->first-REAL_DOC_OFFS, get_topicNSR (p->first));
					} else {
						gclog.noHdr();
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Нарушена последовательность действия документов %d(%s) и редакции %d(%s)). Есть пересекающийся интервал.\n", n->first-REAL_DOC_OFFS, get_topicNSR (n->first), p->first-REAL_DOC_OFFS, get_topicNSR (p->first));

						if (d2.da_year) {
							long topic = p->first;
							revision correctd2;
							gk_bzero(&correctd2,sizeof(revision));
							correctd2.RevisionDate = d2;
							localrev_adddays (correctd2, -1);
							tcinfo.incorrect_dates_to->insert(std::map<long, date>::value_type (topic, d1));
							tcinfo.incorrect_dates_toto->insert(std::map<long, date>::value_type (topic, correctd2.RevisionDate));
						}
					}
				}
			}
		}
	}

#ifdef	FLUSH56
	if( fatalErrors ) {
		gclog.noHdr();
		if ( bIgnoreFatal ) {
			gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "Финальная компиляция должна быть прекращена из-за фатальных ошибок с редакциями.\n");
		} else {
			if (tcinfo.iniSbrf) {
				gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "Компиляция прекращена из-за нарушения диапазона топиков, выделенных СБРФ; или фатальных ошибок с редакциями.\n");
				exit(1);
			} else {
				gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "Компиляция прекращена из-за фатальных ошибок с редакциями.\n");
				exit(1);
			}
		}
	}
#endif
}
#endif

void gcpass1( ThreadCompileInfo &tcinfo )
{
	int  objRootLength = tcinfo.objRoot ? strlen (tcinfo.objRoot) : 0;
	char *objRoot = (char*) malloc (objRootLength+2048);
	if (tcinfo.objRoot)
		strcpy (objRoot, tcinfo.objRoot);
	else
		objRoot [0] = '\0';

	long ctn = -1;
	int bNoActive = 0;
	int bAnonced = 0;
	int bIncluded = 0;
	int bNoDoc = 0;
	int bHasTitle = 0;
	int bPreActive = 0;
	bool b_flashtopic = false;
	bool b_objpath = false;
#ifdef VERSION56
	long lastfinishctn = -1;
	Intervals activity;
	DateInterval interval={0};
#endif
	bool b_was_doc = false;

	std::set<long> subs_in_doc;
	std::stack<long> blocks_in_doc;
	std::map<long,long> map_block_paras;

	const char *buf;
	int l ;

	int wasDup = 0;
	int wasBelongs = 0;
	int wasRelated = 0;
	int wasVerlink = 0;
	int wasActive = 0;
	int wasXActive = 0;
	int wasTerm = 0;

	tcinfo.topicBelongs->clear();
	tcinfo.notADocs->clear();
	tcinfo.invalidDocs->clear();
#ifdef VERSION56
	tcinfo.m_next->clear();
#endif

	longSplaySet *defSet = new longSplaySet();
	longlongSplaySetSplayMap * relations = new longlongSplaySetSplayMap(*defSet);

	int empty_para = -1;
	bool b_check_empty_paras = true;

	std::set<long> relatedS, editions, docs_with_class;

#ifdef VERSION56
#define FINISH_ACTIVITY \
	if ( ctn!=lastfinishctn ) { \
		activity[ctn]=interval; \
		{DateInterval i={0};interval=i;}; \
		wasVerlink = 0; \
		wasActive = 0; \
		wasXActive = 0; \
		lastfinishctn = ctn; \
	}
#else
#	define FINISH_ACTIVITY
#endif

#ifdef	VERSION56
#define FINISH_TOPIC	if( ctn != -1 ) \
	{ \
	if (!tcinfo.blobs->contains(ctn)) tcinfo.topics_tocompile->push_back (ctn); \
	if( !bHasTitle ) \
	{ \
	if( !bNoDoc ) \
	{ \
	gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "фПРЙЛ ВЕЪ ЪБЗПМПЧЛБ ЙМЙ ЙНЕОЙ ОЕ РПНЕЮЕО ЛБЛ NODOC.\n"); \
	} \
	} \
	} \
	FINISH_ACTIVITY \
	long *data = new long [subs_in_doc.size () + 1], *ptr = data; \
	*ptr++ = subs_in_doc.size (); \
	for (std::set<long>::const_iterator it = subs_in_doc.begin (); it != subs_in_doc.end (); it++, ptr++) \
    	*ptr = *it; \
	if (ctn != -1 && !tcinfo.blobs->contains(ctn)) tcinfo.map_doc_subs->insert (std::map<long,long*>::value_type (ctn, data)); \
	subs_in_doc.clear (); \
	while (!blocks_in_doc.empty ()) blocks_in_doc.pop (); \
	map_block_paras.clear (); \
	if (ctn != -1 && !wasBelongs) { \
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"У топика %d нет команды !BELONGS. Топик игнорируется\n",ctn-REAL_DOC_OFFS); \
		if (tcinfo.fatal_ifnotinbelongs) \
			fatalErrors = 1; \
	} \
	wasBelongs = 0; \
	b_was_doc = false; \
	wasRelated = 0; \
	empty_para = -1; \
	if (b_flashtopic && !b_objpath) tcinfo.bad_docs->insert (ctn); \
	b_flashtopic = b_objpath = false;\
	if ( bAnonced ) tcinfo.anonces->add(ctn); \
	wasTerm = 0; \
	if (ctn != -1) {\
		std::map<long,short*>::const_iterator map_it = tcinfo.topicBelongs->find (ctn); \
		if (map_it != tcinfo.topicBelongs->end ()) { \
			short *ptr = map_it->second, count = *ptr++; \
			bool found = false; \
			for (short segs = 0; segs < count; segs++, ptr++) \
				if (tcinfo.hereBelongs->contains (*ptr)) found = true; \
			if (!found) { \
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"Топик %d не принадлежит базам указанным в BelongsList\n",ctn-REAL_DOC_OFFS); \
				if (tcinfo.fatal_ifnotinbelongs) \
					fatalErrors = 1; \
				tcinfo.topicBelongs->erase (ctn); \
			} \
		} \
	} \
	ctn = -1;
#else
#define FINISH_TOPIC	if( ctn != -1 ) \
	{ \
	if( !bHasTitle ) \
	{ \
	if( !bNoDoc ) \
	{ \
	gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "фПРЙЛ ВЕЪ ЪБЗПМПЧЛБ ЙМЙ ЙНЕОЙ ОЕ РПНЕЮЕО ЛБЛ NODOC.\n"); \
	} \
	} \
	} \
	FINISH_ACTIVITY \
	wasBelongs = 0; \
	wasRelated = 0; \
    wasTerm = 0; \
	if (ctn != -1 && tcinfo.topicBelongs->contains(ctn)) \
	{ \
		if (!(tcinfo.hereBelongs & (*tcinfo.topicBelongs)[ctn])) \
	{ \
			gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"Топик %d не принадлежит базам указанным в BelongsList\n",ctn-REAL_DOC_OFFS); \
			tcinfo.topicBelongs->del(ctn); \
	} \
	}
#endif

	for(Pix i= tcinfo.Sources->first(), belong; i; tcinfo.Sources->next(i) ) {
		FileStringer fst( tcinfo.Sources->key(i).chars() );
		if( ! fst.OK() ) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оЕ НПЗХ ПФЛТЩФШ ЖБКМ '%s'\n", tcinfo.Sources->key(i).chars());
			continue;
		}
		const char* nsrc_filename = tcinfo.Sources->key(i).chars();
		gclog.setFileName(nsrc_filename);
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "рТПУНПФТ ЖБКМБ '%s'\n", tcinfo.Sources->key(i).chars());
		int cl = 0;
        while( (buf=fst.gets(l)) != 0 ) {
			gclog.setLN (++cl);
			if (!l || buf[0] != '!' ) {
				if (!l) {
					if (b_check_empty_paras)
						empty_para = cl;
				} else if (buf [0] != ';' && !map_block_paras.empty ())
					for (std::map<long,long>::iterator map_it = map_block_paras.begin (); map_it != map_block_paras.end (); map_it++)
						map_it->second++;
				continue;
			}
			if( IS_CMD(TOPIC,buf,l) || IS_CMD(ANNOTOPIC,buf,l) || IS_CMD (MEDTOPIC,buf,l) || IS_CMD (FIRMTOPIC,buf,l) || IS_CMD (MDICTTOPIC,buf,l) || IS_CMD (FLASHTOPIC,buf,l)) {
				FINISH_TOPIC;
				const char* s;
				b_flashtopic = false;
				long len;
				if ( IS_CMD(TOPIC,buf,l )) {
					b_check_empty_paras = true;
					len = CMD_CALL3(TOPIC,getChars,buf,l,s);
				} else if (IS_CMD (ANNOTOPIC,buf,l)) {
					b_check_empty_paras = false;
					len = CMD_CALL3(ANNOTOPIC,getChars,buf,l,s);
				} else if (IS_CMD (MEDTOPIC,buf,l)) {
					b_check_empty_paras = false;
					len = CMD_CALL3 (MEDTOPIC, getChars, buf, l, s);
				} else if (IS_CMD (MDICTTOPIC,buf,l)) {
					b_check_empty_paras = false;
					len = CMD_CALL3 (MDICTTOPIC, getChars, buf, l, s);
				} else if (IS_CMD (FLASHTOPIC,buf,l)) {
					b_check_empty_paras = false;
					b_flashtopic = true;
					len = CMD_CALL3 (FLASHTOPIC, getChars, buf, l, s);
				} else {
					len = CMD_CALL3 (FIRMTOPIC, getChars, buf, l, s);
					b_check_empty_paras = false;
				}

				if (len <= 0) {
					gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Error in command !TOPIC. ID was not defined\n");
				}

				unsigned long ll = l;
				try {
					while( ll && (*s == ' ' || *s=='\t' ) ) {
						s++; ll--;
					}
				}
				catch (...) {
				}

				int64_t ctn64 = 0;

				try {
					while(*s >= '0' && *s <='9') {
						if (!ll) break;
						ctn64*=10;
						ctn64+=*s-'0';
						s++; ll--;
					}
				}
				catch (...) {
				}

				if ( tcinfo.TopicRanges ) {
					short	aFound = 0;
					for ( short aRange = 0; aRange < tcinfo.TopicRanges && !aFound; aRange++ )
						if ( ctn64 >= tcinfo.LoTopicRanges[ aRange ] && ctn64 <= tcinfo.HiTopicRanges[ aRange ] )
							aFound = 1;
					if ( !aFound )
						gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "Недопустимый номер топика %d. Нарушен допустимый диапазон топиков\n", ctn64 );
				}

				ctn64 += ID_BORDER;

				if (tcinfo.iniSbrf && (ctn64 < SBRF_LOW_ID || ctn64 > SBRF_HI_ID)) {
					gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "Топик %ld - не входит в диапазон документов СберБанка\n", (long)ctn64-100000);
					fatalErrors = true;
				}

				if ((ctn64 >= BIG_INFO_DOC) && (ctn64 < BIG_INFO_DOC+BIG_INFO_COUNT)) {
					gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "Топик %ld пересекается с glными топиками\n", (long)ctn64-100000);
					fatalErrors = true;
				}

				if (!b_flashtopic) {
					if ((ctn64 >= ID_FLASH_LO) && (ctn64 < ID_FLASH_HI)) {
						gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "Топик %ld не может входить в диапазон FLASHTOPICов\n", (long)ctn64-100000);
						fatalErrors = true;
					}
				}
				
				if (IS_CMD (ANNOTOPIC,buf,l)) {
					ctn64+=ID_ANNOPLUS;
					ctn=(long)ctn64;

					short* data = new short [2];
					data [0] = 1; data [1] = (short) (hereBelongs (hereBelongs.first ()) & 0xFFFF);
					tcinfo.topicBelongs->insert (std::map<long,short*>::value_type (ctn, data));
					wasBelongs = 1;
					tcinfo.notADocs->add (ctn);
				} else
				if (IS_CMD (MEDTOPIC, buf, l) || IS_CMD (FIRMTOPIC, buf, l) || IS_CMD (MDICTTOPIC, buf, l)) {
					ctn=(long)ctn64;
					short* data = new short [2];
					data [0] = 1; data [1] = INPHARM_SEGMENT;
					tcinfo.topicBelongs->insert (std::map<long,short*>::value_type (ctn, data));
					wasBelongs = 1;
					tcinfo.notADocs->add (ctn);
				} else
				if (IS_CMD (FLASHTOPIC, buf, l)) {
					ctn = (long)ctn64;
					if (ctn < ID_FLASH_LO || ctn > ID_FLASH_HI) {
						fatalErrors = true;
						gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "Недопустимый номер flashtopicа %d. Нарушен допустимый диапазон\n", ctn);
						tcinfo.bad_docs->insert (ctn);
					}
				}

				try {
					while(*s == ' ' || *s=='\t') {
						if (!ll) break;
						s++; ll--;
					}
				}
				catch (...) {
				}

				if (ctn64 < 100001 || ctn64 > MAX_DOC_NUMBER) {
					gclog.printfC (errors, AdvLogger::LOG_FATAL,AdvLogger::CD_WIN,"Недопустимый номер топика\n");
					exit(1);
				}

				ctn=(long)ctn64;
				gclog.setTopic(ctn-ID_BORDER);

				subs_in_doc.insert (0);
				topicNSR.insert (std::map<long,const char*>::value_type (ctn, tcinfo.Sources->key(i).chars()));
				
				bNoActive = 0; bHasTitle = 0; bNoDoc = 0; bPreActive=0; bAnonced=0; bIncluded=0;
				if( tcinfo.blobs->contains( ctn ) || (tcinfo.map_doc_subs->find (ctn) != tcinfo.map_doc_subs->end ())) {
					gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "рПЧФПТСАЭЙКУС ОПНЕТ ФПРЙЛБ %ld.\n", ctn-100000);
					wasDup = 1;
				}
				if( ll ) bHasTitle = 1;
			}
			else if( IS_CMD(OBJPATH,buf,l) ) {
				b_objpath = true;
				const char *ptr;
				int len;
				if ((len=CMD_CALL3 (OBJPATH, getChars, buf, l, ptr)) >0 ) {
					if (objRootLength && objRoot [objRootLength-1] != '/') {
						objRoot[objRootLength] = '/';
						objRootLength++;
					}
					char* toput = objRoot + objRootLength;
					if (ptr[0] == '\\' || ptr[0] == '/') {
						memcpy(objRoot + objRootLength, ptr+1, len-1 );
						objRoot[objRootLength+len-1] =0;
					} else {
						memcpy(objRoot + objRootLength, ptr, len );
						objRoot[objRootLength+len] =0;
					}
					int fd = ace_os_open(objRoot, ACE_OS_O_RDONLY | ACE_OS_O_BINARY );
					if( fd != -1 ) {
						ace_os_close(fd);
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Файл объекта %s не найден\n", objRoot);
						b_objpath = false;
					}
				}
			} else if( IS_CMD(BELONGS,buf,l) ) {
				if (wasBelongs) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_WIN,  "Повторяющаяся команда !BELONGS. Команда игнорируется.\n");
					continue;
				}
				const char * grpst;
				int blen = CMD_CALL3(BELONGS,getChars,buf,l,grpst);
				if (blen) {
					const char *bstr = grpst, *bptr = strchr (grpst,'\\');					
					std::set<short> doc_belongs;
					long count = 0;
					do {
						FString ft(bstr,(bptr && bptr-grpst<blen)?bptr-bstr:blen-(bstr-grpst));
						if ((belong=tcinfo.belongsMap->seek (ft))) {
							short segment_id = (short) (tcinfo.belongsMap->contents (belong) & 0xFFFF);
							if (tcinfo.ignoreBelongs->find (segment_id) == tcinfo.ignoreBelongs->end ())
								doc_belongs.insert (segment_id);
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT,"ЌҐЁ§ўҐбв­®Ґ §­ зҐ­ЁҐ BELONGS '%s'\n", ft.chars());
						}
						ft.bDoFree=1;
						if (bptr) {
							bstr = bptr+1;
							bptr = strchr(bstr,'\\');
						}
						else
							break;
					} while (bstr-grpst < blen);
					if (doc_belongs.size ()) {
						short *data = new short [doc_belongs.size () + 1], *ptr = data;
						*ptr++ = doc_belongs.size ();
						for (std::set<short>::const_iterator seg_it = doc_belongs.begin (); seg_it != doc_belongs.end (); seg_it++, ptr++)
							*ptr = *seg_it;
						tcinfo.topicBelongs->insert (std::map<long,short*>::value_type (ctn, data));
					}
				} else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_WIN, "Ошибка формата команды BELONGS\n");
				}
				wasBelongs = 1;
			}
#ifdef VERSION56
			else if (IS_CMD(VERLINK,buf,l)) {
				int val; 
				if( CMD_CALL3(VERLINK,getInt,buf,l,val) == 0 ) {
					val += REAL_DOC_OFFS;
					if (wasVerlink) {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Может быть только одна команда VERLINK на топик\n");
					} else {
						if (tcinfo.m_next->find(val)!=tcinfo.m_next->end()) { // у предка уже есть потомок
							fatalErrors = true;
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "У топика %ld уже есть следующая редакция (%ld).\n", val-REAL_DOC_OFFS, (*tcinfo.m_next)[val]-REAL_DOC_OFFS);
						} else {
							(*tcinfo.m_next)[val]=ctn;
							tcinfo.editions_map->insert (std::map<long,long>::value_type (ctn,val));
							rev_editions_map.insert (std::map<long,long>::value_type (val,ctn));
						}
					}
				} else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"Не указан номер топика в команде VERLINK\n");
				}
			}
			else if( IS_CMD(ACTIVE,buf,l) ) {
				if (wasXActive) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Команды ACTIVE, PREACTIVE, NOACTIVE несовместимы.\n");
				} else {
					DocActivityEx a={0};					
					getActivity(buf+ACTIVE_DOFFS, l-ACTIVE_DOFFS, a);
					if (a.text) {
						delete a.text;
						a.text=0;
					}
					interval.act=DateInterval::Active;
					if (!wasActive) {
						interval.from=a.from;
						interval.to=a.to;
						++wasActive;
					} else {
						if ( (!a.from.da_year && interval.from.da_year ) || ( !interval.to.da_year && a.from.da_year ) ) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Взаимоисключающие команды ACTIVE (не указана дата).\n");
						} else {
							if (is_lt(a.from, interval.from)) {
								interval.from=a.from;
							}
							if (!a.to.da_year || is_lt(interval.to, a.to)) {
								interval.to=a.to;
							}
						}
					}
				}
			}
			else if( IS_CMD(PREACTIVE,buf,l) ) {
				if (wasActive || wasXActive) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Команды ACTIVE, PREACTIVE, NOACTIVE несовместимы.\n");
				} else {
					interval.act=DateInterval::Preactive;
					++wasXActive;
				}
			}
			else if( IS_CMD(NOACTIVE,buf,l) ) {
				if (wasActive || wasXActive) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Команды ACTIVE, PREACTIVE, NOACTIVE несовместимы.\n");
				} else {
					DocActivityEx a={0};
					getActivity(buf+NOACTIVE_DOFFS, l-NOACTIVE_DOFFS, a);
					if (a.text) {
						delete a.text;
						a.text=0;
					}
					interval.to=a.from;
					interval.act=DateInterval::Noactive;
					++wasXActive;
				}
			}
#endif
			else if( IS_CMD(RELATED,buf,l) ) {
				int t;
				long tmpLong;
				if( CMD_CALL3(RELATED,getInt,buf,l,t) == 0 ) {
					t += REAL_DOC_OFFS;
					if( wasRelated ) {
						gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_WIN,  "Повторяющаяся команда !RELATED. Команда игнорируется.\n");
					} else {
						if (t != ctn) {
							(*relations)[t].add(ctn);
							tmpLong= t;
							relatedS.insert (tmpLong);
							wasRelated = 1;
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_WIN, "Топик %ld не может быть RELATED самому себе.\n", ctn);
						}
					}
				} else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"Ошибка формата команды RELATED.\n");
				}
			} else if( IS_CMD(REL,buf,l) ) {
				b_check_empty_paras = false;
			} else if( IS_CMD(BLOCKEND,buf,l) ) {
				if( ctn != -1 ) {
					const char* ptr;
					unsigned long len;
					long subn = 0;
					if( (len=CMD_CALL3(BLOCKEND,getChars,buf,l,ptr)) >0 )
						subn = atoi( ptr );
					else 
					if (!blocks_in_doc.empty ()) {
						subn = blocks_in_doc.top ();
						blocks_in_doc.pop ();
					}
					std::map<long,long>::iterator map_it = map_block_paras.find (subn);
					if (map_it != map_block_paras.end ()) {
						if (!map_it->second) {
							u_int64_t empty_block = (((u_int64_t) ctn) << 32) + subn;
							tcinfo.set_empty_blocks->insert (empty_block);
						}
						map_block_paras.erase (map_it);
					}
				}
			} else if( IS_CMD(BLOCK,buf,l) ) {
				empty_para = -1;
				const char* ptr;
				unsigned long len;
				if( (len=CMD_CALL3(BLOCK,getChars,buf,l,ptr)) >0 ) {
					if( ctn != -1 ) {
						long subn = atoi( ptr );
						if ((atoll(ptr) != (int64_t)subn) || ((subn < 0) || (subn > MAX_SUB_NUMBER))) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оЕРТБЧЙМШОЩК ОПНЕТ Ч ЛПННБОДЕ !BLOCK\n");
						} else if (subn) {
							if (subs_in_doc.find (subn) == subs_in_doc.end ()) {
								map_block_paras.insert (std::map<long,long>::value_type (subn, 0));
								subs_in_doc.insert (subn);
								blocks_in_doc.push (subn);
							} else {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "рПЧФПТСАЭЙКУС ОПНЕТ !BLOCK/SUB/TERM (%ld)\n", subn);
							}
						}
						if((wasTerm != 0) && subs_in_doc.find (subn-100) == subs_in_doc.end ()) {
							gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "оЕФ УППФЧЕФУФЧХАЭЕЗП ОПНЕТБ !TERM ДМС !BLOCK (%ld)\n", subn);
						}
					}
				}
			}
			else if (IS_CMD (STYLE, buf, l)) {
				if (empty_para != -1 && (!strcmp (buf, "!STYLE J 1 72 1") || !strcmp (buf, "!STYLE V 1 72 1"))) {
					int next_l;
					const char *next_buf = fst.get_nexts (next_l);
					if (next_buf && !strstr (next_buf, "‘¬. Ја дЁзҐбЄЁ© ®ЎкҐЄв"))
						tcinfo.map_file_leadingparas->insert (std::map<std::string, std::set<long> >::value_type (nsrc_filename, std::set<long>())).first->second.insert (empty_para);
				}
				empty_para = -1;
			}
			else if( IS_CMD(SUB,buf,l) ) {
				const char* ptr;
				unsigned long len;
				if( (len=CMD_CALL3(SUB,getChars,buf,l,ptr)) >0 ) {
					if( ctn != -1 ) {
						long subn = atoi( ptr );
						if ((atoll(ptr) != (int64_t)subn) || ((subn < 0) || (subn > MAX_SUB_NUMBER))) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оЕРТБЧЙМШОЩК ОПНЕТ Ч ЛПННБОДЕ !SUB\n");
						} else if (subn) {
							if (subs_in_doc.find (subn) == subs_in_doc.end ())
								subs_in_doc.insert (subn);
							else
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "рПЧФПТСАЭЙКУС ОПНЕТ !BLOCK/SUB/TERM (%ld)\n", subn);
						}
					}
				}
			}
			else if( IS_CMD(TERM,buf,l) ) {
				const char* ptr;
				unsigned long len;
				if( (len=CMD_CALL3(TERM,getChars,buf,l,ptr)) >0 ) {
					if( ctn != -1 ) {
						long subn = atoi( ptr );
						if ((atoll(ptr) != (int64_t)subn) || ((subn <= 0) || (subn > MAX_SUB_NUMBER))) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оЕРТБЧЙМШОЩК ОПНЕТ Ч ЛПННБОДЕ !TERM\n");
						} else {
							if (subs_in_doc.find (subn) == subs_in_doc.end ()) {
								subs_in_doc.insert (subn);
							} else {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "рПЧФПТСАЭЙКУС ОПНЕТ !BLOCK/SUB/TERM (%ld)\n", subn);
							}
							wasTerm=1;
						}
					}
				}
			} else if( IS_CMD(NODOC,buf,l) ) {
				b_check_empty_paras = false;
				if( ctn != -1 ) {
					bNoActive = 1;
					bNoDoc = 1;
					tcinfo.notADocs->add(ctn);
				}
			} else if( IS_CMD(EDITION,buf,l) ) {
				if( ctn != -1 ) {
					bNoActive = 1;
					bNoDoc = 1;
#ifdef	VERSION56
					editions.insert (ctn);
#endif
				}
			} else if( IS_CMD(REFDOC,buf,l) ) {
				if( ctn != -1 ) {
					bNoActive = 1;
					bNoDoc = 1;
					tcinfo.notADocs->add(ctn);
				}
			} else if( IS_CMD(NOACTIVE,buf,l) ) {
				if( ctn != -1 && !bNoActive ) {
					date d;
					if( CMD_CALL3(NOACTIVE,getDate,buf,l,d) ) {
						if( dateCmp( d, todayDate ) <=0 )
							bNoActive = 1;
					} else {
						bNoActive = 1;
					}
				}
			} else if( IS_CMD(PREACTIVE,buf,l) ) {
				if( ctn != -1 && !bNoActive ) {
					date d;
					if( CMD_CALL3(PREACTIVE,getDate,buf,l,d) ) {
						if( dateCmp( d, todayDate ) > 0 )
							bPreActive = 1;
					} else {
						bPreActive = 1;
					}
				}
			} else if (IS_CMD (DOC,buf,l)) {
				if( ctn != -1 ) {
					b_was_doc = true;
					std::map<long,short*>::const_iterator map_it = tcinfo.topicBelongs->find (ctn);
					if (map_it != tcinfo.topicBelongs->end ()) {
						short *data = map_it->second, tofind = DICTIONARY_SEGMENT;
						if (bsearch (&tofind, data+1, *data, sizeof (short), shortcmp)) {
							bNoActive = 1;
							bNoDoc = 1;
							tcinfo.notADocs->add(ctn);
						}
					}
				}
			}
#ifdef	VERSION56
			else if( IS_CMD(VLCONTROL,buf,l) ) {
				if ( ctn != -1 )
					tcinfo.vlcontrols->add(ctn);
			} else if( IS_CMD(VANONCED,buf,l) ) {
				if( ctn != -1 && !bIncluded ) {
					bAnonced = 1;
				}
			} else if( IS_CMD(VINCLUDED,buf,l) ) {
				if( ctn != -1 ) {
					bIncluded = 1;
					if ( bAnonced )
						bAnonced = 0;
				}
			}
#endif
			else if( IS_CMD(VABOLISHED,buf,l) ) {
				if( ctn != -1 ) {
					bNoActive = 1;
				}
			}
			else if( IS_CMD(NAME,buf,l) ) {
				bHasTitle = 1;
			}
			else if (IS_CMD (CLASS, buf, l)) {
				if (!b_was_doc)
					docs_with_class.insert (ctn);
			}
			else if ( IS_CMD(OBJTOPIC,buf,l) ) {
				FINISH_TOPIC;
				wasRelated = 0;
				wasBelongs = 0;
				if (ctn != -1 ) {
					std::map<long,short*>::iterator map_it = tcinfo.topicBelongs->find (ctn);
					if (map_it != tcinfo.topicBelongs->end ()) {
						bool found = false;
						short *ptr = map_it->second, count = *ptr++;
						for (short seg_it = 0; seg_it < count; seg_it++, ptr++)
							if (tcinfo.hereBelongs->contains (*ptr))
								found = true;
						if (!found) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"Топик %d не принадлежит базам указанным в BelongsList\n",ctn-REAL_DOC_OFFS);
							tcinfo.topicBelongs->erase (ctn);
						}
					}
				}
				ctn = -1; 
				const char* s;
				
				long len = CMD_CALL3(OBJTOPIC,getChars,buf,l,s);
				if (len <= 0)
					gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Error in command !OBJTOPIC. ID was not defined\n");
				
				unsigned long ll = l;
				while( ll && (*s == ' ' || *s=='\t' ) )
					s++; ll--;
				
				long bn = 0;
				while( ll && (*s >= '0' && *s <='9' ) ) {
					bn *=10;
					bn += *s - '0';
					s++; ll--;
				}
				bn += ID_BORDER;
				if (!tcinfo.blobs->contains( bn ) && (tcinfo.map_doc_subs->find (bn) == tcinfo.map_doc_subs->end ())) {
					tcinfo.blobs->add(bn);
				} else {
					gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "рПЧФПТСАЭЙКУС ОПНЕТ ПВЯЕЛФБ %d.\n", bn-100000);
					wasDup = 1;
				}
				ctn = bn;

				if (tcinfo.iniSbrf && (ctn < SBRF_LOW_ID || ctn > SBRF_HI_ID)) {
					if ((ctn >= ID_EVD_KZ && ctn <= ID_EVD_QUERY) || (ctn == ID_CONSULTING_XML) || (ctn == ID_EVD_INPHARM)) {
					} else {
						gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "Объектный топик %ld - не входит в диапазон документов СберБанка\n", ctn-100000);
						fatalErrors = true;
					}
				}
			}
		}
		FINISH_TOPIC;
	}
	std::sort (tcinfo.topics_tocompile->begin (), tcinfo.topics_tocompile->end ());
	if (relatedS.size ()) {
		for (std::set<long>::const_iterator it = relatedS.begin (); it != relatedS.end (); it++)
			tcinfo.relatedS->push_back (*it);
		relatedS.clear ();
	}
	if (editions.size ()) {
		for (std::set<long>::const_iterator it = editions.begin (); it != editions.end (); it++)
			tcinfo.editions->push_back (*it);
		editions.clear ();
	}
	if (docs_with_class.size ()) {
		for (std::set<long>::const_iterator it = docs_with_class.begin (); it != docs_with_class.end (); it++)
			tcinfo.docs_with_class->push_back (*it);
		docs_with_class.clear ();
	}

	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "рТПУНПФТЕОП %ld ФПРЙЛПЧ.\n",tcinfo.map_doc_subs->size ());
	if( wasDup ) {
		gclog.noHdr();
		gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_KOI,  "лПНРЙМСГЙС РТЕЛТБЭЕОБ ЙЪ-ЪБ РПЧФПТСАЭЙИУС ФПРЙЛПЧ.\n");
		exit(1);
	}

	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_WIN, "Проверка RELATED топиков...\n");

	Pix ii;

	u_int32_tSplaySet* ranonces = new u_int32_tSplaySet();
	u_int32_tSplaySet* rvlcontrols = new u_int32_tSplaySet();

	for (ii = relations->first(); ii; relations->next(ii)) {
		long related = relations->key(ii);
		for (Pix pix5 = relations->contents(ii).first(); pix5; relations->contents(ii).next(pix5)) {
			long rel = relations->contents(ii)(pix5);
#ifdef	VERSION56
			if (tcinfo.anonces->contains(rel))
				ranonces->add(related);
			if (tcinfo.vlcontrols->contains(rel))
				rvlcontrols->add(related);
#endif
		}

		if (!tcinfo.notADocs->contains(relations->key(ii))) {
			char error [64], addS[]= " должна содержать команду !NODOC\n";
			sprintf (error, "Справка %ld для документа(ов)", relations->key(ii) - REAL_DOC_OFFS);
			std::string error_str (error);
			gclog.noHdr();
			gclog.printfC (AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Справка %ld для документа(ов) ",relations->key(ii) - REAL_DOC_OFFS);
			for (Pix pix5 = relations->contents(ii).first(); pix5; relations->contents(ii).next(pix5)) {
				sprintf (error, " %ld", relations->contents(ii)(pix5) - REAL_DOC_OFFS);
				error_str += error;
				gclog.printfCP (AdvLogger::CD_WIN, " %ld", relations->contents(ii)(pix5) - REAL_DOC_OFFS);
			}
			gclog.printfCP(AdvLogger::CD_WIN, " должна содержать команду !NODOC\n");
			error_str += addS;
			errors.push_back (error_str);
			tcinfo.notADocs->add(relations->key(ii));
		}
		tcinfo.topicBelongs->erase (relations->key(ii));
		longSplaySet reltopic = relations->contents(ii);
		for (Pix iii = reltopic.first(); iii; reltopic.next(iii)) {
			std::map<long,short*>::const_iterator map_it = tcinfo.topicBelongs->find (reltopic(iii));
			if (map_it != tcinfo.topicBelongs->end ()) {
				long id = relations->key(ii);
				std::map<long,short*>::iterator map_it_id = tcinfo.topicBelongs->find (id);
				std::set<short> belongs;
				if (map_it_id != tcinfo.topicBelongs->end ()) {
					short *data = map_it_id->second, *ptr = data, count = *ptr++;
					for (int seg = 0; seg < count; seg++, ptr++)
						belongs.insert (*ptr);
					delete [] data;
				}
				short *ptr = map_it->second, count = *ptr++;
				for (short segs = 0; segs < count; segs++, ptr++)
					belongs.insert (*ptr);

				tcinfo.topicBelongs->erase (id);
				short *data = new short [belongs.size () + 1];
				ptr = data;
				*ptr++ = belongs.size ();
				for (std::set<short>::const_iterator seg_it = belongs.begin (); seg_it != belongs.end (); seg_it++, ptr++)
					*ptr = *seg_it;
				tcinfo.topicBelongs->insert (std::map<long,short*>::value_type (id, data));
			}
		}
	}

#ifdef	VERSION56
	tcinfo.anonces->clear();
	tcinfo.vlcontrols->clear();

	Pix pix5;
	long tmpLong;
	for (pix5 = ranonces->first(); pix5; ranonces->next(pix5)){
		tmpLong= (*ranonces)(pix5);
		tcinfo.anonces->add(tmpLong);
	}
	for (pix5 = rvlcontrols->first(); pix5; rvlcontrols->next(pix5)){
		tmpLong= (*rvlcontrols)(pix5);
		tcinfo.vlcontrols->add(tmpLong);
	}
#endif

	/*
	std::vector<long> tmp;
	for (std::set<long>::const_iterator it = tcinfo.topic_topics->begin (); it != tcinfo.topic_topics->end (); it++) {
		long docid = *it;
		if (!tcinfo.topicBelongs->contains (docid))
			tmp.push_back (*it);
	}
	for (std::vector<long>::const_iterator itit = tmp.begin (); itit != tmp.end (); itit++)
		tcinfo.topic_topics->erase (tcinfo.topic_topics->find (*itit));
	*/

	check(activity, tcinfo);

#ifdef	VERSION63
	if ( !tcinfo.blobs->contains( ID_EVD_KZ ) || !tcinfo.blobs->contains( ID_EVD_KZPPR ) || !tcinfo.blobs->contains( ID_EVD_KZPRIME )) {
		gclog.noHdr();
		gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "База должна содержать объектные топики %ld %ld %ld\n", ID_EVD_KZ - ID_BORDER, ID_EVD_KZPPR - ID_BORDER, ID_EVD_KZPRIME - ID_BORDER );
		exit( 1 );
	}
#endif

	delete relations;
	topicNSR.clear();
}

