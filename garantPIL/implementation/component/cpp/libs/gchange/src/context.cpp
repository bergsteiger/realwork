///////////////////////////////////////////////////////////////////////////////
//
// Класс контекста программы Garant change
//
///////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"

#include "context.h"

#include <cstdlib>
#include <cstdarg>
#include <string>
#include <list>

#include "basemask.h"
#include "rev.h"
#include "date.defs.h"
#include "recode.h"
#include "SearchB.h"

#include "garantPIL/implementation/component/cpp/libs/endt/BlockDecompile.h"
#include "common/components/rtl/Garant/EVD/eeReader.h"
#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"

#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

#include "shared\GCL\alg\set_operations.h"

#include "boost/lexical_cast.hpp"

std::map<short, std::deque<long> > map_segment_adddocs;
std::map<short, std::set<long> > map_statusex_docs;

// Класс Context //////////////////////////////////////////////////////////////

char	buf[ s_bufsize];

std::set<long> exclude_belongs;
std::set<long> set_result;

void Context::initObj()
{
	m_pBase = 0;
	m_needGl = false;
	m_baseChanged = false;
	m_needLog = false;
	b_norecalc = false;
	b_readonly = false;

	m_logFileName = "";
	m_rulesFileName = "";
	m_baseFileName = "";
	allTopic = 0;

	b_finally = false;
}

Context::Context()
{
	initObj();
	memset (&baseinfo_revision, 0, sizeof (revision));
}

///////////////////////////////////////////////////////////////////////////////

Context::Context(char *pBaseFileName, char *pRulesFileName, char *pLogFileName)
{
	initObj();
    if (pBaseFileName != 0)
        m_baseFileName = string(pBaseFileName);
    if (pRulesFileName != 0)
        m_rulesFileName = string(pRulesFileName);
    if (pLogFileName != 0)
        m_logFileName = string(pLogFileName);
    if( pLogFileName != 0 )
        m_needLog = true;
}

///////////////////////////////////////////////////////////////////////////////

Context::~Context()
{
    if( m_pBase ) {
        m_pBase->close_saw_bases ();
        delete m_pBase;
    }

    if( m_pRulesParser )
        m_pRulesParser = 0;
}

///////////////////////////////////////////////////////////////////////////////

void    Context::base(YBase *base)
{
    if( m_pBase ) {
        m_pBase->close_saw_bases ();
        delete m_pBase;
    }

    m_pBase = base;
}

///////////////////////////////////////////////////////////////////////////////

Base *Context::base(void) const
{
    return m_pBase;
}

///////////////////////////////////////////////////////////////////////////////

int Context::fprintf(
        FILE *str,
        const char *format,
        ...
        )
{
        va_list arglist;
        int retv;

        va_start(arglist, format);

        retv = 0;

        if( str && m_needLog )
            retv = ::vfprintf(str, format, arglist);

        va_end(arglist);

        return retv;
}

int Context::fflush(FILE *file)
{
    //if( m_needLog )
    //    return ::fflush(file);

    return 0;
}

int StrRev ( char * pStr, revision& theRev )
{	
	unsigned short day, month, year, hour, min, find;
	find = sscanf ( pStr, "%hd/%hd/%hd:%hd:%hd", &day, &month, &year, &hour, &min );

	if ( find != 3 && find != 5 ) return 0;
	if ( day > 31 || month > 12 ) return 0;
	if ( year < 100 ) year += 2000;
	theRev.RevisionDate.da_day = (unsigned char)day;
	theRev.RevisionDate.da_mon = (unsigned char)month;
	theRev.RevisionDate.da_year = year;
	if ( find == 5 ) {
		if ( hour > 23 || min > 59 ) return 0;
		theRev.RevisionTime.ti_min = (unsigned char)min;
		theRev.RevisionTime.ti_hour = (unsigned char)hour;
	}		

	return 1;
}

long    Context::parse_command_line(long argc, char **argv)
{
    long    retv = false;

    if( (argc < 3) || (argc > 7) ) {
        printf( "Usage:\n\tgchange <basefile> <rulesfile> [-g] [logfile]\n" );
        printf( "where:\n"\
                "\t<basefile> - Garant Base file name without extension.\n"\
                "\t<rulefile> - Garant Rule file name.\n"\
                "\t[-g]       - Don't touch flags for other GDK's tools.\n"\
                "\t[logfile]  - Log file name. Default 'gchange.log'.\n\n"\
                );
    } else {
        m_baseFileName = std::string(argv[1]);
        m_rulesFileName = std::string(argv[2]);

        m_needGl = true;

		changedocrevision = false;
		m_logFileName = m_rulesFileName;
		if (m_logFileName.rfind ('.') != -1)
			m_logFileName.erase (m_logFileName.rfind ('.'));
		if (m_logFileName.rfind ('\\') != -1)
			m_logFileName.erase (0, m_logFileName.rfind ('\\')+1);
		else if (m_logFileName.rfind ('/') != -1)
			m_logFileName.erase (0, m_logFileName.rfind ('/')+1);
		m_logFileName = "gchange_" + m_logFileName;
		m_logFileName += ".log";

        // Если указан логфайл или опция -g
		for ( int i = 3; i < argc; i++ ) {
			if (!strcmp (argv [i], "-norecalc")) {
				b_norecalc = true;
			} else if (!strcmp(argv[i], "-readonly")) {
				b_readonly = true;
				b_norecalc = true;
				m_needGl = false;
			} else if (!strcmp(argv[i], "-g")) {
				m_needGl = false;
			} else if( strstr(argv[i], "-r:")) {
				if ( StrRev ( &argv [i][3], rrevision ))
					changedocrevision = true;
			} else {
				m_logFileName = std::string(argv[i]);
			}
		}

        m_pLogFile = fopen(m_logFileName.c_str(), "w+");

        if( m_pLogFile ) {
            retv = true;
            m_needLog = true;
        } else {
            printf("Error: Can't open logfile for writing!\n");
        }
    }

    return retv;
}

///////////////////////////////////////////////////////////////////////////////

long    Context::parse_rules(void)
{
    long    retv = false;
    FILE    *rulesFile;

    if( !m_rulesFileName.empty() ) {

        rulesFile = fopen(m_rulesFileName.c_str(), "rb");
        if( rulesFile ) {
            long    rulesFileSize;
            char    *buf;

            fseek(rulesFile, 0, SEEK_END); // Добавляем место для нуля в конце
            rulesFileSize = ftell(rulesFile) + 1;

            buf = new char[rulesFileSize];

            rewind(rulesFile);
            fread(buf, rulesFileSize, 1, rulesFile);
            buf[rulesFileSize - 1] = 0;
#ifdef	WINENCODE
			Recoding( cd_dos,cd_win,buf );
#endif

            m_pRulesParser = new RuleParser(buf);

            delete buf;

            if( m_pRulesParser->is_ok() ) {
                retv = true;

                fprintf(m_pLogFile, "-- Start parsed block --\n");
                m_pRulesParser->out_parser(m_pLogFile);
                fprintf(m_pLogFile, "--  End parsed block  --\n");
            }
        } else {
            printf("Can't open rulesfile ""%s""!\n", m_rulesFileName.c_str());
        }
    } else {
        printf("The rulesfile is null!\n");
    }

    return retv;
}

///////////////////////////////////////////////////////////////////////////////

void	Context::init ()
{
	allTopic = new DocCollection ();

    printf ("load Edis\n");
	Stream *str = m_pBase->FindIndex ("Aux")->Open ("Edis");
	if (str) {
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		m_pBase->FindIndex ("Aux")->Close (str);
		size >>= 3;
		for (int i = 0; i < size; i++) {
			long edition = *ptr;
			ptr++;
			long doc = *ptr;
			ptr++;

			std::map<long, std::set<long> >::iterator it = map_doc_editions.find (doc);
			if (it == map_doc_editions.end ()) {
				std::set<long> editions;
				editions.insert (edition);
				editions.insert (doc);
				map_doc_editions.insert (std::map<long, std::set<long> >::value_type (doc, editions));
			} else {
				it->second.insert (edition);
			}
			map_edition_doc.insert (std::map<long,long>::value_type (edition, doc));
		}
		gk_free (data);
	}

	{
		std::vector<long> doc_ids;
		for (std::vector<Base*>::const_iterator base_it = m_pBase->bases_ptrs.begin (); base_it != m_pBase->bases_ptrs.end (); base_it++) {
			AttrIndex *attrs = (AttrIndex*) (*base_it)->FindIndex ("Attrs");
			static const AttrKey key = {ID_BORDER, IDD_INFO};
			printf ("load DocInfo\n");
			for (BTIterator it (attrs, &key ); !it.End (); ++it) {
				AttrKey * ptr = (AttrKey *) it.Key ();
				if (ptr -> AttrTag != IDD_INFO)
					break;
				doc_ids.push_back (ptr->DocId);
			}
		}
		std::sort (doc_ids.begin (), doc_ids.end ());
		doc_ids.erase (std::unique (doc_ids.begin (), doc_ids.end ()), doc_ids.end ());
		for (std::vector<long>::const_iterator it = doc_ids.begin (); it != doc_ids.end (); it++) {
			long id = *it;
			allTopic->Collection::Add (&id);
		}
	}

    printf ("load Blob\n");
	for (std::vector<Base*>::const_iterator base_it = m_pBase->bases_ptrs.begin (); base_it != m_pBase->bases_ptrs.end (); base_it++) {
		for (BTIterator it ((*base_it)->FindIndex ("Blob")); !it.End (); ++it) {
			long id = *(long*) it.Key ();
			blob_keys.insert (id);
		}
	}

    printf ("done\n");
}

void    Context::do_changes(void)
{
	std::list<ChangeRule>::iterator      i;
	std::list<Condition>::iterator       j;
	std::list<ChangeAction>::iterator    k;

	long docId, flgCondition, l, proc= 0;

	if(m_pBase == 0) {
		if (b_readonly) {
			m_pBase = new SearchBase (m_baseFileName.c_str());
			m_pBase->YBase::IsOk ();
			m_pBase->open_saw_bases (ACE_OS_O_RDONLY);
		} else {
			m_pBase = new StdBigBase(m_baseFileName.c_str(), ACE_OS_O_RDWR);
			m_pBase->open_saw_bases (ACE_OS_O_RDWR);
		}
	}

	if (m_pBase->IsOk() && (b_readonly || !(m_pBase->keyFile->IsPacked() || m_pBase->strFile->IsPacked()))) {
		m_pBase->check_version ();

        //if ( !allTopic ) allTopic = m_pBase->AllTopics(ID_BORDER);

		init ();

        printf("Total topics: %d\n", allTopic->ItemCount);

        printf("Doing once...\n");

        for(i = m_pRulesParser->rule().begin(); i != m_pRulesParser->rule().end(); i++) {
            if( (*i).type() == ChangeRule::rtOnce ) {
                for(k = (*i).action().begin(); k != (*i).action().end(); k++) {
                    do_action(*k, 0, "");
                }
            }
        }

        printf("Changing documents...\n");
		long step = allTopic->ItemCount / 100, cur_step = 0;
		fflush(stdout);    
        for (l = 0; l < allTopic->ItemCount; l++) {
			docId = allTopic->GetItem (l);

			if (++cur_step > step) {
				printf ("%ld%%\r", ++proc);
				cur_step = 0;
			}

            for (i = m_pRulesParser->rule ().begin (); i != m_pRulesParser->rule ().end (); i++) {
                if ((*i).type () != ChangeRule::rtOnce) {
					if ((*i).type () == ChangeRule::rtFinally) {
						if (!b_finally)
							break;
					}
                    flgCondition = true;
                    for (j = (*i).condition ().begin (); j != (*i).condition().end (); j++) {
                        if (!check_condition (*j, docId)) {
                            flgCondition = false;
                            break;
                        }
                    }

                    if (flgCondition) 
						for (k = (*i).action ().begin (); k != (*i).action ().end (); k++)
                            do_action (*k, docId, "");
                }
            }

			if (map_doc_docinfo.size () > 1000000) {
				fprintf (m_pLogFile, "! warning, clear docinfo map !\n");
				map_doc_docinfo.clear ();
			}
			if (map_doc_belongs.size () > 1000000) {
				fprintf (m_pLogFile, "! warning, clear belongs map !\n");

				for (std::map<long,short*>::iterator map_it = map_doc_belongs.begin (); map_it != map_doc_belongs.end (); map_it++)
					delete [] map_it->second;
				map_doc_belongs.clear ();
				map_doc_belongscount.clear ();
			}
			if (map_tag_data.size ()) {
				for (std::map<long,void*>::iterator map_it = map_tag_data.begin (); map_it != map_tag_data.end (); map_it++)
					gk_free (map_it->second);
				map_tag_data.clear ();
				map_tag_datasize.clear ();
			}
        }

        printf("\nFinally changing documents...\n");
		fflush(stdout);
		proc = cur_step = 0;

        printf("Doing finally once...\n");
		fprintf (m_pLogFile, "finally once, for %ld docs\n", finally_docs.size ());
		fflush (m_pLogFile);

		for (std::set<long>::const_iterator set_it = finally_docs.begin (); set_it != finally_docs.end (); ++set_it) {
			docId = *set_it;
			for(i = m_pRulesParser->rule().begin(); i != m_pRulesParser->rule().end(); i++) {
				if( (*i).type() == ChangeRule::rtFinally) {
					for(k = (*i).action().begin(); k != (*i).action().end(); k++) {
						do_action(*k, docId, "");
					}
				}
			}
        }

		fprintf (m_pLogFile, "finally if, for %ld docs\n", finally_docs.size ());
		fflush (m_pLogFile);

		b_finally = true;
		step = finally_docs.size () / 100;
		{
			for (std::set<long>::const_iterator set_it = finally_docs.begin (); set_it != finally_docs.end (); ++set_it) {
				docId = *set_it;

				if (++cur_step > step) {
					printf ("%ld%%\r", ++proc);
					cur_step = 0;
				}

				bool b_can = false;
				for (i = m_pRulesParser->rule().begin(); i != m_pRulesParser->rule().end(); i++) {
					if ((*i).type () != ChangeRule::rtOnce) {
						if ((*i).type () == ChangeRule::rtFinally) {
							b_can = true;
						}
						if (!b_can)
							continue;

						if ((*i).type () == ChangeRule::rtNone) {
							flgCondition = true;

							for (j = (*i).condition ().begin (); j != (*i).condition().end (); j++) {
								if (!check_condition (*j, docId)) {
									flgCondition = false;
									break;
								}
							}

							if (flgCondition) 
								for (k = (*i).action ().begin (); k != (*i).action ().end (); k++)
									do_action (*k, docId, "");
						}
					}
				}
				if (map_doc_docinfo.size () > 1000000) {
					fprintf (m_pLogFile, "! warning, clear docinfo map !\n");
					map_doc_docinfo.clear ();
				}
				if (map_doc_belongs.size () > 1000000) {
					fprintf (m_pLogFile, "! warning, clear belongs map !\n");

					for (std::map<long,short*>::iterator map_it = map_doc_belongs.begin (); map_it != map_doc_belongs.end (); map_it++)
						delete [] map_it->second;
					map_doc_belongs.clear ();
					map_doc_belongscount.clear ();
				}
				if (map_tag_data.size ()) {
					for (std::map<long,void*>::iterator map_it = map_tag_data.begin (); map_it != map_tag_data.end (); map_it++)
						gk_free (map_it->second);
					map_tag_data.clear ();
					map_tag_datasize.clear ();
				}
			}
        }
		if (!b_readonly) {
			for (std::map<short, std::deque<long> >::const_iterator map_it = map_segment_adddocs.begin (); map_it != map_segment_adddocs.end (); map_it++) {
				short segment = map_it->first;
				Stream* str = m_pBase->FindIndex ("Segment")->Open (&segment, 1);
				if (str) {
					DocCollection docs;
					docs.Get (str);

					for (std::deque<long>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
						long id = *it;
						if (id > 0) {
							docs.Insert (&id);
						} else {
							id = -id;
							docs.Delete (&id);
						}
					}
					str->Seek (0);
					docs.Put (str);
					str->Trunc ();
					m_pBase->FindIndex ("Segment")->Close (str);
				}
			}
			for (std::map<short, std::set<long> >::const_iterator map_it = map_statusex_docs.begin (); map_it != map_statusex_docs.end (); map_it++) {
				short status = map_it->first;
				RefCollection to_add;
				for (std::set<long>::const_iterator doc_it = map_it->second.begin (); doc_it != map_it->second.end (); doc_it++) {
					Ref ref = {*doc_it, 0};
					to_add.Add (ref);
				}
				Stream *str = m_pBase->FindIndex ("Status_ex")->Open (&status, 1);
				if (str) {
					RefCollection refs;
					refs.Get (str);
					refs.Merge (to_add);
					str->Seek (0);
					refs.Put (str);
					str->Trunc ();
					m_pBase->FindIndex ("Status_ex")->Close (str);
				}

			}
		}

		set_gl (m_baseChanged);
		if (!b_norecalc) recalc_bases ();

#ifdef	DELDOCS
	{
	int b_gchg = 0;
	for ( long i = 0; i < allTopic->ItemCount; i++ ) {
		long docId = (*allTopic)[ i ];
		printf( "%ld\r", docId );
		if ( ( docId >= BIG_INFO_DOC && docId < BIG_INFO_DOC + BIG_INFO_COUNT ) || ( docId == 100100 ))
			continue;
		DocInfo docInfo;
		m_pBase->FindDocInfo( docId, docInfo );
		if ( docInfo.Status & ( DS_DOC | DS_EDITION )) {
			b_gchg = 1;
			m_pBase->DelText( docId );
			docInfo.ParaCount = 0;
			m_pBase->ReplaceAttr( docId, IDD_INFO, &docInfo, sizeof( docInfo ));
		}
	}
	if (b_gchg) {
		Stream* str = m_pBase->FindIndex ("Aux")->Open ("gchg", 1);
		if (str) {
			str->Write (&b_gchg, sizeof (b_gchg)); 
			m_pBase->FindIndex ("Aux")->Close (str);
		}
	}
	}
#endif
    } else {
        printf("Can't open base %s for reading and writing.\n",
                m_baseFileName.c_str());
    }
}

///////////////////////////////////////////////////////////////////////////////

void    Context::add_here(long id)
{
    Stream  *pStream;

    // Открываем стрим
    pStream = m_pBase->FindIndex("Aux")->Open( "Here" );

    if( pStream ) {
        long    segmentCount, i, flagFound;
        short   *pSegment;

        segmentCount = pStream->Length() / sizeof(short);
        pSegment = new short[segmentCount + 1];

        // Читаем список сегментов
        pStream->Read( pSegment, segmentCount * sizeof(short) );

        flagFound = false;
        // Ишем вставляемый сегмент
        for( i = 0; i < segmentCount; i++ ) {
            if( pSegment[i] == id ) {
                flagFound = true;
                break;
            }
        }

        // Если не нашли то добавляем
        if( !flagFound ) {
            m_baseChanged = true;
            m_calcBases.push_back(id);

            pStream->Seek(0);
            pSegment[segmentCount] = id;
            sort_here(pSegment, segmentCount + 1);
            pStream->Write(pSegment, (segmentCount + 1) * sizeof(short));
        } else {
            fprintf(m_pLogFile, "\tSegment already exists\n");
        }

        m_pBase->FindIndex("Aux")->Close(pStream);
        delete pSegment;
    }
}

///////////////////////////////////////////////////////////////////////////////

void Context::remove_here(long id)
{
    Stream  *pStream;

    // Открываем стрим
    pStream = m_pBase->FindIndex("Aux")->Open("Here");

    if( pStream ) {
        long    segmentCount, i, flagFound;
        short   *pSegment;

        segmentCount = pStream->Length() / sizeof(short);
        pSegment = new short[segmentCount + 1];

        // Читаем список сегментов
        pStream->Read( pSegment, segmentCount * sizeof(short) );

        flagFound = false;
        // Ишем удаляемый сегмент
        for( i = 0; i < segmentCount; i++) {
            if( pSegment[i] == id ) {
                flagFound = true;
                break;
            }
        }

        // Если не нашли то удаляем
        if( flagFound ) {
            m_baseChanged = true;

            // Продолжаем цикл для сдвига списка
            for(; i < (segmentCount - 1); i++) {
                pSegment[i] = pSegment[i + 1];
            }
            pStream->Seek(0);
            pStream->Write(pSegment, (segmentCount - 1) * sizeof(short));
            // Обрезаем стрим текущей пощицией
            pStream->Trunc();
        } else {
            fprintf(m_pLogFile, "\tnothing to remove\n");
        }

        m_pBase->FindIndex("Aux")->Close(pStream);
        delete pSegment;
    }
}

///////////////////////////////////////////////////////////////////////////////

void Context::rule(RuleParser *pNewRule)
{
    m_pRulesParser = pNewRule;
}

///////////////////////////////////////////////////////////////////////////////

RuleParser *Context::rule(void)
{
    return m_pRulesParser;
}

///////////////////////////////////////////////////////////////////////////////

void Context::add_baseinfo(long id,
    const char *rusName,
    const char *engName,
    long weight)
{
    Stream      *pStream;

    // Открываем стрим
    pStream = m_pBase->FindIndex("Aux")->Open( "Base" );
    long splash_topic = 0, banner_topic = 0;

    if( pStream ) {
        BaseInfo    baseInfo;
        long        flagFound;

        flagFound = false;
        // Ищем добавляемый сегмент
        while( pStream->Read(&baseInfo, sizeof(BaseInfo)) == sizeof(BaseInfo) ) {
            if ( baseInfo.BaseId == id ) {
		splash_topic = baseInfo.SplashTopic;
		banner_topic = baseInfo.BannerTopic;
                flagFound = true;
                break;
            }
        }

	::memset(&baseInfo, 0, sizeof(BaseInfo));
	baseInfo.SplashTopic = splash_topic;
	baseInfo.BannerTopic = banner_topic;
	baseInfo.BaseId = id;
	::strcpy(baseInfo.Name, rusName);
	::strcpy(baseInfo.NameEng, engName);
	baseInfo.LastUpdate = baseinfo_revision;
	baseInfo.Weight = weight;

        // Если не нашли то добавляем
        if( !flagFound ) {
            m_baseChanged = true;
            m_calcBases.push_back(id);

            pStream->Seek(pStream->Length());
            pStream->Write(&baseInfo, sizeof(BaseInfo));

            BaseInfo    *pBaseInfo;
            long        baseInfoCount;

            baseInfoCount = pStream->Length() / sizeof(BaseInfo);
            pBaseInfo = new BaseInfo[baseInfoCount];
            pStream->Seek(0);
            pStream->Read(pBaseInfo, baseInfoCount * sizeof(BaseInfo));
            sort_baseinfo(pBaseInfo, baseInfoCount);
            pStream->Seek(0);
            pStream->Write(pBaseInfo, baseInfoCount * sizeof(BaseInfo));
        } else {
	    m_pBase->ReplaceBaseInfo( id, &baseInfo );
            //fprintf(m_pLogFile, "\tBaseInfo %d already exists\n", id);
        }

        m_pBase->FindIndex("Aux")->Close(pStream);
    }
}

///////////////////////////////////////////////////////////////////////////////

void    Context::remove_baseinfo(long id)
{
    Stream      *pStream;

    // Открываем стрим
    pStream = m_pBase->FindIndex("Aux")->Open("Base");

    if( pStream ) {
        BaseInfo    *pBaseInfo;
        long        flagFound, countBaseInfo, i;

        countBaseInfo = pStream->Length() / sizeof(BaseInfo);
        pBaseInfo = new BaseInfo[countBaseInfo];

        pStream->Read( pBaseInfo, countBaseInfo * sizeof(BaseInfo));

        flagFound = false;
        // Ищем удаляемый сегмент
        for( i = 0; i < countBaseInfo; i++) {
            if( pBaseInfo[i].BaseId == id ) {
                flagFound = true;
                break;
            }
        }

        // Если нашли то удаляем
        if( flagFound ) {
            m_baseChanged = true;

            for(; i < (countBaseInfo - 1); i++) {
                pBaseInfo[i] = pBaseInfo[i + 1];
            }
            pStream->Seek(0);
            pStream->Write(pBaseInfo, (countBaseInfo - 1) * sizeof(BaseInfo));
            pStream->Trunc();
        } else {
            fprintf(m_pLogFile, "\tNothing to remove\n");
        }

        m_pBase->FindIndex("Aux")->Close(pStream);
        delete pBaseInfo;
    }
}

///////////////////////////////////////////////////////////////////////////////

void    Context::add_keyindex(void *key, Index *index)
{
    Stream  *pStream;

    // Вызываем открытие стрима с флажком автоматического создания
    pStream = index->Open(key, 1);

    // Проверяем есть ли этот ключ в индексе
    if( pStream ) {
        index->Close(pStream);
    }
}

///////////////////////////////////////////////////////////////////////////////

void    Context::remove_keyindex(void *key, Index *index)
{
    Stream  *pStream;

    pStream = index->Open(key);

    // Проверяем есть ли этот ключ в индексе
    if( pStream ) {
        // Если есть то удаляем
        index->Delete(key);
        index->Close(pStream);
    }
}

///////////////////////////////////////////////////////////////////////////////

bool	Context::add_belongs (long docId, long segment)
{
    long    i, flagFound;
    short	segmentBuf [s_maxseg], segmentCount = get_belongs (docId, segmentBuf);

    // Ищем belongs в документе
    flagFound = false;
	bool in_exclude = false;
    for( i = 0; i < segmentCount && !in_exclude; i++ ) {
        if( segmentBuf[i] == segment ) {
            flagFound = true;
        }
		if (exclude_belongs.find (segmentBuf[i]) != exclude_belongs.end ())
			in_exclude = true;
    }

	if (in_exclude) {
		fprintf(m_pLogFile, "\tЕсть Belongs из списка exclude\n", segment);
		return false;
	} else if( !flagFound ) {
        m_baseChanged = true;
        m_calcBases.push_back (segment);
        segmentBuf [segmentCount] = segment;
        sort_here (segmentBuf, segmentCount + 1);
		put_belongs (docId, segmentBuf, segmentCount + 1);
		change_doc_revision (docId);
		return true;
    } else {
        fprintf(m_pLogFile, "\tBelongs %d already exists\n", segment);
		return false;
    }
}

///////////////////////////////////////////////////////////////////////////////

void    Context::remove_belongs(long docId, long segment)
{
    long    i, flagFound;
    short   segmentBuf[s_maxseg], segmentCount = get_belongs (docId, segmentBuf);

    // Ищем belongs в документе
    flagFound = false;
    for( i = 0; i < segmentCount; i++ ) {
        if( segmentBuf[i] == segment ) {
            flagFound = true;
            break;
        }
    }

    // Если нашли то удаляем
    if( flagFound ) {
        m_baseChanged = true;
        m_calcBases.push_back(segment);

        for(; i < (segmentCount - 1); i++ ) {
            segmentBuf[i] = segmentBuf[i + 1];
        }
		put_belongs (docId, segmentBuf, segmentCount - 1);
		change_doc_revision( docId );
    } else {
        fprintf(m_pLogFile, "\tNothing to remove\n");
    }
}

///////////////////////////////////////////////////////////////////////////////

long Context::add_str_index(long iTag, const char *pKeyStr, long lDocId)
{
	if (b_readonly)
		return 0;

	if (iTag == IDD_BASES) {
		short segment = *(short*) pKeyStr;
		std::map<short, std::deque<long> >::iterator map_it = map_segment_adddocs.find (segment);
		if (map_it == map_segment_adddocs.end ()) {
			std::deque<long> docs;
			docs.push_back (lDocId);
			map_segment_adddocs.insert (std::map<short, std::deque<long> >::value_type (segment, docs));
		} else {
			map_it->second.push_back (lDocId);
		}

		return 1;
	}

    Index *pInd = select_index (iTag);

    if( !pInd ) return false;

    if( iTag == IDD_SOURCE ||
        iTag == IDD_KEY ||
        iTag == IDD_SERVICEINFO ||
        iTag == IDD_DIV ||
        iTag == IDD_PUBLISHEDIN ||
        iTag == IDD_TYPE ||
        iTag == IDD_TERRITORY ||
        iTag == IDD_KIND ||
        iTag == IDD_DOCKIND ||
		iTag == IDD_ANNOINTEREST
	) {
        Ref     aRef = {lDocId, 0};
        char    *pPureKey = 0;
        char    *pPrevLevel = 0;

        if ( iTag == IDD_KEY ||
             iTag == IDD_SERVICEINFO ||
             iTag == IDD_DIV ||
             iTag == IDD_DOCKIND ||
             iTag == IDD_KIND ||
             iTag == IDD_PUBLISHEDIN ||
             iTag == IDD_TYPE )
        {
            // for key with sub
            ::sscanf( pKeyStr, "%ld:", &aRef.Sub );
            pPureKey = ::strdup( ::strchr( pKeyStr, ':' ) + 1 );
        } else {
            pPureKey = ::strdup( pKeyStr );
        }

        do {
            long    iRes;
            if( iTag == IDD_KEY ||
                iTag == IDD_DIV ||
                iTag == IDD_SERVICEINFO ||
                iTag == IDD_DOCKIND ||
                iTag == IDD_KIND ||
                iTag == IDD_PUBLISHEDIN ||
                iTag == IDD_TYPE )
            {
                iRes = add_stream_ref( pInd, pPureKey, aRef );
            } else {
                iRes = add_stream_doc( pInd, pPureKey, lDocId );
            }

            // Moving from end of Source's branch to begin
            pPrevLevel = ::strrchr( pPureKey, '\\' );
            if( pPrevLevel ) {
                *pPrevLevel = '\x0';
            }
        } while( pPrevLevel );
        ::free( pPureKey );
    } else {
        add_stream_doc( pInd, pKeyStr, lDocId );
    }

    return 1;
}

long Context::add_str_index(long iTag, const char *pKeyStr, Ref ref)
{
	if (b_readonly)
		return 0;

	Index *pInd = select_index (iTag);

    if( !pInd ) return false;

    if( iTag == IDD_SOURCE ||
        iTag == IDD_KEY ||
        iTag == IDD_SERVICEINFO ||
        iTag == IDD_DIV ||
        iTag == IDD_PUBLISHEDIN ||
        iTag == IDD_TYPE ||
        iTag == IDD_TERRITORY ||
        iTag == IDD_KIND ||
        iTag == IDD_DOCKIND )
    {
        char    *pPureKey = 0;
        char    *pPrevLevel = 0;

        if ( iTag == IDD_KEY ||
             iTag == IDD_SERVICEINFO ||
             iTag == IDD_DIV ||
             iTag == IDD_DOCKIND ||
             iTag == IDD_KIND ||
             iTag == IDD_PUBLISHEDIN ||
             iTag == IDD_TYPE )
        {
            // for key with sub
			if (strchr (pKeyStr, ':')) {
				::sscanf( pKeyStr, "%ld:", &ref.Sub );
				pPureKey = ::strdup( ::strchr( pKeyStr, ':' ) + 1 );
			} else {
				pPureKey = ::strdup( pKeyStr );
			}
        } else {
            pPureKey = ::strdup( pKeyStr );
        }

        do {
            long    iRes;
            if( iTag == IDD_KEY ||
                iTag == IDD_DIV ||
                iTag == IDD_SERVICEINFO ||
                iTag == IDD_DOCKIND ||
                iTag == IDD_KIND ||
                iTag == IDD_PUBLISHEDIN ||
                iTag == IDD_TYPE )
            {
                iRes = add_stream_ref( pInd, pPureKey, ref );
            } else {
                iRes = add_stream_doc( pInd, pPureKey, ref.DocId);
            }

            // Moving from end of Source's branch to begin
            pPrevLevel = ::strrchr( pPureKey, '\\' );
            if( pPrevLevel ) {
                *pPrevLevel = '\x0';
            }
        } while( pPrevLevel );
        ::free( pPureKey );
    } else {
		add_stream_doc( pInd, pKeyStr, ref.DocId );
    }

    return 1;
}

///////////////////////////////////////////////////////////////////////////////

long Context::del_str_index(long iTag,
        const char * pKeyStr,
        long lDocId,
        long iDelLevel)
{
	if (b_readonly)
		return 0;

	if (iTag == IDD_BASES) {
		short segment = *(short*) pKeyStr;
		std::map<short, std::deque<long> >::iterator map_it = map_segment_adddocs.find (segment);
		if (map_it == map_segment_adddocs.end ()) {
			std::deque<long> docs;
			docs.push_back (-lDocId);
			map_segment_adddocs.insert (std::map<short, std::deque<long> >::value_type (segment, docs));
		} else {
			map_it->second.push_back (-lDocId);
		}

		return 1;
	}

    Index *pInd = select_index( iTag );
    if( !pInd ) {
        return 0;
    }
    
    if( iTag == IDD_SOURCE ||
        iTag == IDD_KEY ||
        iTag == IDD_SERVICEINFO ||
        iTag == IDD_DIV ||
        iTag == IDD_PUBLISHEDIN ||
        iTag == IDD_TYPE ||
        iTag == IDD_TERRITORY ||
        iTag == IDD_KIND ||
        iTag == IDD_DOCKIND ||
		iTag == IDD_ANNOINTEREST )
    {
        Ref     aRef = {lDocId, 0};
        char    *pPureKey = 0;
        char    *pPrevLevel = 0;

        if( iTag == IDD_KEY ||
            iTag == IDD_DIV ||
            iTag == IDD_SERVICEINFO ||
            iTag == IDD_DOCKIND ||
            iTag == IDD_KIND ||
            iTag == IDD_PUBLISHEDIN ||
            iTag == IDD_TYPE )
        {
            // for key with sub
            ::sscanf( pKeyStr, "%ld:", &aRef.Sub );
            pPureKey = ::strdup( ::strchr( pKeyStr , ':' ) + 1 );
        } else {
            pPureKey = ::strdup( pKeyStr );
        }

        long    iDelKey = -1;
        long    iPrevDelKey = -1;

        do {
            if( iTag==IDD_KEY ||
                iTag==IDD_DIV ||
                iTag==IDD_SERVICEINFO ||
                iTag==IDD_DOCKIND ||
                iTag==IDD_KIND ||
                iTag==IDD_PUBLISHEDIN ||
                iTag==IDD_TYPE )
            {
                // prevent key deleting for pair index
                iDelKey = del_stream_ref( pInd,
                        pPureKey, aRef, iTag == IDD_DIV);
            } else {
                // prevent key deleting for pair index
                iDelKey = del_stream_doc( pInd,
                        pPureKey, lDocId, iTag == IDD_SOURCE);
            }

            if ( !iDelKey || (iDelKey < iPrevDelKey)) {
                break;
            }

            iPrevDelKey = iDelKey;

            // Moving from the end of the hindex branche to begin
            pPrevLevel = ::strrchr( pPureKey, '\\' );
            if ( pPrevLevel ) {
                *pPrevLevel = '\x0';
            }
            iDelLevel--;
        } while( pPrevLevel && iDelLevel );

        ::free( pPureKey );
    } else {
        del_stream_doc( pInd, pKeyStr, lDocId );
    }

    return 1;
}

long Context::del_str_index(long iTag,
        const char * pKeyStr,
        Ref ref)
{
	if (b_readonly)
		return 0;

	Index *pInd = select_index( iTag );
    if( !pInd )
        return 0;
    
    if( iTag == IDD_SOURCE ||
        iTag == IDD_KEY ||
        iTag == IDD_SERVICEINFO ||
        iTag == IDD_DIV ||
        iTag == IDD_PUBLISHEDIN ||
        iTag == IDD_TYPE ||
        iTag == IDD_TERRITORY ||
        iTag == IDD_KIND ||
        iTag == IDD_DOCKIND )
    {
        char    *pPureKey = 0;
        char    *pPrevLevel = 0;

        if( iTag == IDD_KEY ||
            iTag == IDD_DIV ||
            iTag == IDD_SERVICEINFO ||
            iTag == IDD_DOCKIND ||
            iTag == IDD_KIND ||
            iTag == IDD_PUBLISHEDIN ||
            iTag == IDD_TYPE )
        {
            // for key with sub
			if (strchr (pKeyStr, ':')) {
				::sscanf( pKeyStr, "%ld:", &ref.Sub );
				pPureKey = ::strdup( ::strchr( pKeyStr , ':' ) + 1 );
			} else {
				pPureKey = ::strdup(pKeyStr);
			}
        } else {
            pPureKey = ::strdup( pKeyStr );
        }

        long    iDelKey = -1;
        long    iPrevDelKey = -1;

        do {
            if( iTag==IDD_KEY ||
                iTag==IDD_DIV ||
                iTag==IDD_SERVICEINFO ||
                iTag==IDD_DOCKIND ||
                iTag==IDD_KIND ||
                iTag==IDD_PUBLISHEDIN ||
                iTag==IDD_TYPE )
            {
                // prevent key deleting for pair index
                iDelKey = del_stream_ref( pInd, pPureKey, ref, iTag == IDD_DIV);
            } else {
                // prevent key deleting for pair index
				iDelKey = del_stream_doc( pInd, pPureKey, ref.DocId, iTag == IDD_SOURCE);
            }

            if ( !iDelKey || (iDelKey < iPrevDelKey)) {
                break;
            }

            iPrevDelKey = iDelKey;

            // Moving from the end of the hindex branche to begin
            pPrevLevel = ::strrchr( pPureKey, '\\' );
            if ( pPrevLevel ) {
                *pPrevLevel = '\x0';
            }
        } while (pPrevLevel);

        ::free( pPureKey );
    } else {
		del_stream_doc( pInd, pKeyStr, ref.DocId);
    }

    return 1;
}
///////////////////////////////////////////////////////////////////////////////

Index *Context::select_index(long iTag)
{
    switch (iTag) {
    case IDD_SERVICEINFO :
        return m_pBase->FindIndex("ServiceInfo");
    case IDD_KEY :
        return m_pBase->FindIndex("KeyWord");
    case IDD_DIV :
        return m_pBase->FindIndex("Class");
    case IDD_DATE :
        return m_pBase->FindIndex("Date");
    case IDD_ID :
        return m_pBase->FindIndex("Number");
    case IDD_SOURCE :
        return m_pBase->FindIndex("Adopted");
    case IDD_TYPE :
        return m_pBase->FindIndex("Type");
    case IDD_RCODE :
        return m_pBase->FindIndex("RCode");
    case IDD_RDATE :
        return m_pBase->FindIndex("RDate");
    case IDD_VINCLUDED :
        return m_pBase->FindIndex("VIncluded");
    case IDD_VCHANGED :
        return m_pBase->FindIndex("VChanged");
    case IDD_VABOLISHED :
        return m_pBase->FindIndex("VAbolished");
    case IDD_SORTDATE :
        return m_pBase->FindIndex("SortDate");
    case IDD_VLCONTROL :
        return m_pBase->FindIndex("VLControl");
    case IDD_VANONCED :
        return m_pBase->FindIndex("VAnonced");
    case IDD_CATEGORY :
        return m_pBase->FindIndex("Category");
    case IDD_PUBLISHEDIN :
        return m_pBase->FindIndex("PublishedIn");
    case IDD_BASES :
        return m_pBase->FindIndex("Segment");
    case IDD_DOCKIND :
        return m_pBase->FindIndex("DocKind");
    case IDD_KIND :
        return m_pBase->FindIndex("Kind");
    case IDD_TERRITORY :
        return m_pBase->FindIndex("Territory");
    case IDD_ANNOTAX:
        return m_pBase->FindIndex("AnnoTax");
    case IDD_ANNOINTEREST:
        return m_pBase->FindIndex("AnnoInterest");

    case IDD_WARNING :
    case IDD_INFO :
    case IDD_SUBS :
    case IDD_BLOB :
    case IDD_SOURCEFILE :
        return 0;

    default :
        fprintf(m_pLogFile, "Unknown attr %ld\n", iTag);
        //fflush(m_pLogFile);
        break;
    }

    return 0;
}

///////////////////////////////////////////////////////////////////////////////

long Context::add_stream_doc(Index *pInd, const void *vpKey, long lDocId)
{
	if (b_readonly)
		return 0;

	int iCreated = 0;
    if ( pInd && vpKey ) {
        
        Stream *pStr = pInd->Open( vpKey, 1, &iCreated );
        if ( pStr ) {

            DocCollection aDocs;
            aDocs.Get(pStr);

            aDocs.Add(lDocId);
            pStr->Seek(0);
            aDocs.Put(pStr);
            pInd->Close(pStr);
        }
    }
    return iCreated;
}

///////////////////////////////////////////////////////////////////////////////

long Context::del_stream_doc(Index* pInd,
        const void* vpKey,
        long lDocId,
        long keepKey)
{
	if (b_readonly)
		return 0;

	if ( pInd && vpKey ) {

        Stream *pStr = pInd->Open(vpKey);
        if( pStr ) {

            DocCollection aDocs;
            aDocs.Get(pStr);
            aDocs.Del(lDocId);
            
            pStr->Seek(0);
            aDocs.Put(pStr);
            pStr->Trunc();
            pInd->Close(pStr);

            if( (aDocs.ItemCount == 0) && !keepKey ) {
                pInd->Delete(vpKey);
            }
            
        }
    }

    return 0;
}

///////////////////////////////////////////////////////////////////////////////

long Context::add_stream_ref(Index* pInd, const void* vpKey, Ref aRef)
{
	if (b_readonly)
		return 0;

	int iCreated = 0;
    Stream *pStr = pInd->Open(vpKey, 1, &iCreated);

    if( pStr ) {
        RefCollection aRefs;
        aRefs.Get(pStr);
        aRefs.Add(aRef);
        pStr->Seek(0);
        aRefs.Put(pStr);
        pInd->Close(pStr);
    }

    return iCreated;
}

///////////////////////////////////////////////////////////////////////////////

long Context::del_stream_ref(Index* pInd,
        const void* vpKey,
        Ref aRef,
        long keepKey)
{
	if (b_readonly)
		return 0;

	Stream *pStr = pInd->Open(vpKey);

    if ( pStr ) {

        RefCollection aRefs;
        aRefs.Get(pStr);
        aRefs.Del(aRef);
        pStr->Seek(0);
        aRefs.Put(pStr);
        pStr->Trunc();
        pInd->Close(pStr);

        if( (aRefs.ItemCount == 0) && !keepKey ) {
                pInd->Delete(vpKey);
        }
    }

    return 1;
}

///////////////////////////////////////////////////////////////////////////////

void    Context::do_action(ChangeAction &action, long docId, std::string indent)
{
    std::list<std::string>::iterator s;

    fprintf(m_pLogFile, "%sAction for Doc %10d(%d):", indent.c_str (), docId, docId - 100000);
    for( s = action.name().begin() ; s != action.name().end(); s++ ) {
        fprintf(m_pLogFile, "%s.", (*s).c_str());
    }
	//fflush (m_pLogFile);

    switch( action.command() ) {
    case ChangeAction::ctAdd:
        fprintf(m_pLogFile, s_Add);
        break;
    case ChangeAction::ctRemove:
        fprintf(m_pLogFile, s_Remove);
        break;
    case ChangeAction::ctChange:
        fprintf(m_pLogFile, s_Change);
        break;
    case ChangeAction::ctSet:
        fprintf(m_pLogFile, s_Set);
        break;
    default:
        fprintf(m_pLogFile, "none");
        break;
    }
    fprintf(m_pLogFile, "( ");
    std::list<std::string>::iterator l;
    for( l = action.value().begin(); l != action.value().end(); l++ ) {
        fprintf(m_pLogFile, "'%s' ", (*l).c_str());
    }
    fprintf(m_pLogFile, ")\n");
    //fflush(m_pLogFile);
    
	if (*action.name().begin() == s_push) {
		std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
		if (map_it != map_doc_docinfo.end ())
			finally_docs.insert (docId);
		return; 
	}

	if (*action.name ().begin () == s_PrevEdition) {
		std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
		if (map_it != map_doc_docinfo.end () && map_it->second.prevEdition && action.command() == ChangeAction::ctSet) {
			fprintf(m_pLogFile, "--  Start action for PrevEdition  --\n");
			map_it->second.prevEdition = atol (action.value ().begin ()->c_str ());
			m_pBase->ReplaceAttr (docId, IDD_INFO, &map_it->second, sizeof (DocInfo));
			change_doc_revision (docId);
			fprintf(m_pLogFile, "--  End action for PrevEdition  --\n");
		}
        return;
	}
	if (*action.name ().begin () == s_NextEdition) {
		std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
		if (map_it != map_doc_docinfo.end () && map_it->second.nextEdition && action.command() == ChangeAction::ctSet) {
			fprintf(m_pLogFile, "--  Start action for NextEdition  --\n");
			map_it->second.nextEdition = atol (action.value ().begin ()->c_str ());
			m_pBase->ReplaceAttr (docId, IDD_INFO, &map_it->second, sizeof (DocInfo));
			change_doc_revision (docId);
			fprintf(m_pLogFile, "--  End action for NextEdition  --\n");
		}
		return ;
	}

	if (*action.name ().begin () == s_Casecode) {
		switch( action.command() ) {
		case ChangeAction::ctRemove:
			((AttrIndex*)m_pBase->FindIndex ("Attrs"))->Del (docId, IDD_CASECODE);
		}
		return;
	}

	//респонденты
	if (*action.name().begin() == s_Respondents) {
		std::list<long> docs = get_docs (docId, REFTYPE_REFLIST);
		for(std::list<long>::const_iterator i = docs.begin(); i != docs.end(); i++) {
			ChangeAction theAction = action;
			list<string> theName;
			theName = theAction.name ();
			theName.erase (theName.begin ());
			theAction.name(theName);
			do_action(theAction, *i, indent + "   ");
		}
		return ;
	}

	//корреспонденты
	if (*action.name().begin() == s_Correspondents) {
		Stream* str = m_pBase->FindIndex ("NewCorr")->Open (&docId);
		if (str) {
	        fprintf(m_pLogFile, "-- Start actions for Correspondents --\n");

			long size = str->Length (), i;
			CorrRef *corrs = new CorrRef [size / sizeof (CorrRef)];
			str->Read (corrs, size);
			m_pBase->FindIndex ("NewCorr")->Close (str);

			DocCollection procTopics;
			for (i = 0; i < size / sizeof (CorrRef); i++)
				procTopics.Insert (&corrs [i].DocId);
			delete corrs;

			for (i = 0; i < procTopics.ItemCount; i++ ) {
				ChangeAction theAction = action;
				list<string> theName;
				theName = theAction.name();
				theName.erase(theName.begin());
				theAction.name(theName);
				do_action(theAction, procTopics[i], indent + "   ");
			}

			fprintf(m_pLogFile, "--  End actions for Correspondents  --\n");
		}
		return;
	}

    // редакции
	if( *action.name().begin() == s_Samedocs) {
        fprintf(m_pLogFile, "-- Start actions for SameDocs --\n");

		long count = ::atoi((*action.value().begin()).c_str()), length;
		char *data = (char*) m_pBase->LoadAttr (docId, IDD_SAMEDOCS, length), *ptr = data;
		if (!length)
			return ;

		length /= sizeof (DocRele);
		std::vector<long> sames;
		for (int i = 0; i < length && i < count; i++, ptr += sizeof (DocRele)) {
			sames.push_back (((DocRele*)ptr)->DocId);
		}
		gk_free (data);

		for (std::vector<long>::const_iterator same_it = sames.begin (); same_it != sames.end (); same_it++) {
			ChangeAction theAction = action;
			list<string> theName;
			theName = theAction.name ();
			theName.erase (theName.begin ());
			theAction.name(theName);
			do_action(theAction, *same_it, indent + "   ");
		}

		return ;
	}

	if( *action.name().begin() == s_Editions ) {
        fprintf(m_pLogFile, "-- Start actions for Editions --\n");

		long edi_doc = docId;
		std::map<long,long>::const_iterator edi_it = map_edition_doc.find (docId);
		if (edi_it != map_edition_doc.end ())
			edi_doc = edi_it->second;
		std::map<long, std::set<long> >::const_iterator map_it = map_doc_editions.find (edi_doc);
		if (map_it != map_doc_editions.end ()) {
			for (std::set<long>::const_iterator editions_it = map_it->second.begin (); editions_it != map_it->second.end (); editions_it++) {
				if (*editions_it == docId)
					continue;
				ChangeAction theAction = action;
				list<string> theName;
				theName = theAction.name ();
				theName.erase (theName.begin ());
				theAction.name(theName);
				do_action(theAction, *editions_it, indent + "   ");
			}
		}
		fprintf(m_pLogFile, "--  End actions for Editions  --\n");
		return;
	}
	if( *action.name().begin() == s_AAKRefs ) {
		fprintf(m_pLogFile, "-- Start actions for AAKRefs --\n");

		DocCollection respondents;
		long length;
		char *data = (char*) m_pBase->LoadAttr (docId, IDD_EVD, length), *ptr = data;

		if (length) {
			long structs_count, i, j;
			DocStruct *structs = (DocStruct*) m_pBase->LoadAttr (docId, IDD_DOCSTRUCT, structs_count), *structs_ptr;
			structs_count /= sizeof (DocStruct);

			long refs_count;
			RespRef *idd_refs = (RespRef*) m_pBase->LoadAttr (docId, IDD_REFS, refs_count), *refs_ptr;
			refs_count /= sizeof (RespRef);

			long para_count;
			long *idd_paraids = (long*) m_pBase->LoadAttrEx (docId, IDD2_PARAIDS, para_count), *ids_ptr;
			para_count /= sizeof (long);

			while (ptr - data < length) {
				long block_id = *(long*)ptr;
				ptr += sizeof (long);
				long size = (long) ptr [0];
				if (block_id < 0) {
					std::string info;
					evd::IeeGenerator_var generator = EndtTools::BlockDecompileFactory::make (info);
					evd::EvdReader_var evd_reader = new evd::EvdReader (ptr+1, size, generator.in ());
					evd_reader->convert_binary_object ();
					if (info == "RIGHT") {
						for (i = 0, structs_ptr = structs; i < structs_count; i++, structs_ptr++) {
							short evd_type = (short) ((structs_ptr->m_para_list_type >> 24) & 0xFF);
							if (evd_type == SUBDESCEX_BLOCK) {
								long block = structs_ptr->m_para_list_id;
								if (block == -block_id) {
									long from_para = structs_ptr->m_start_para, to_para = structs_ptr->m_end_para;
									std::set<long> para_ids;
									for (j = from_para, ids_ptr = idd_paraids + from_para; j <= to_para; j++, ids_ptr++)
										para_ids.insert (*ids_ptr);
									for (j = 0, refs_ptr = idd_refs; j < refs_count; j++, refs_ptr++)
										if (para_ids.find (refs_ptr->ParaId) != para_ids.end ())
											respondents.Insert (&refs_ptr->DocId);
								}
							}
						}
					}
				}
				ptr += size + 1;
			}
			gk_free (data);
			gk_free (structs);
			gk_free (idd_refs);
			gk_free (idd_paraids);
		}

		std::set<long> final_ids;

		for (int i = 0; i < respondents.ItemCount; i++) {
			bool b_isgarant = false, b_isconsulting = false, b_ok = false;
			long resp_id = respondents [i], size;
			char *sources = (char*) m_pBase->LoadAttr (resp_id, IDD_SOURCE, size), *ptr = sources;
			if (size) {
				while (ptr - sources < size) {
					b_isgarant |= !strcmp (ptr + 4, "Компания \"Гарант\"");
					b_isconsulting |= !strcmp (ptr + 4, "Служба Правового консалтинга ГАРАНТ");
					ptr += strlen (ptr) + 1;
				}
				gk_free (sources);
			}
			if (b_isconsulting)
				b_ok = true;
			else if (b_isgarant) {
				char *kinds = (char*) m_pBase->LoadAttr (resp_id, IDD_KIND, size), *ptr = kinds;
				bool b_isforms = false;
				if (size) {
					while (ptr - kinds < size) {
						b_isforms |= !strcmp (strchr (ptr, '=') + 1, "Формы документов");
						ptr += strlen (ptr) + 1;
					}
					gk_free (kinds);
				}
				if (b_isforms)
					b_ok = true;
			}
			if (b_ok)
				final_ids.insert (resp_id);
		}
		for (std::set<long>::const_iterator it = final_ids.begin (); it != final_ids.end (); ++it) {
			long id = *it;
			ChangeAction theAction = action;
			std::list<std::string>::const_iterator name_it = action.name().begin ();
			name_it++;
			if (*name_it == s_Belongs) {
				short segmentBuf [s_maxseg], segmentCount = get_belongs (docId, segmentBuf);
				for (long i = 0; i < segmentCount; i++) {
					ChangeAction theAction = action;
					theAction.name().erase (theAction.name().begin ());
					char seg_str [32];
					sprintf (seg_str, "%ld", segmentBuf [i]);
					theAction.value ().clear ();
					theAction.value().push_back (seg_str);
					do_action (theAction, id, indent + "   ");
					theAction.name().push_front (s_Related);
					do_action (theAction, id, indent + "   ");
					theAction.name().pop_front ();
					theAction.name().push_front (s_Blob);
					do_action (theAction, id, indent + "   ");
				}
			}
		}

		fprintf(m_pLogFile, "--  End actions for AAKRefs  --\n");
		return;
	}

    //недокументы
	if( *action.name().begin() == s_NoDoc ) {
        std::list<long> docs;
        std::list<long>::iterator i;
        long flagFound;

        flagFound = false;

        fprintf(m_pLogFile, "-- Start actions for NoDoc --\n");

        docs = get_docs (docId, REFTYPE_REFLIST);
        for( i = docs.begin(); i != docs.end(); i++ ) {
			std::map<long,DocInfo>::const_iterator map_it = get_doc_info ((*i));
			if (map_it != map_doc_docinfo.end ()) {
				if (map_it->second.Status & DS_NODOC ) {
                    ChangeAction theAction = action;
                    list<string> theName;
                    theName = theAction.name();
                    theName.erase(theName.begin());
                    theAction.name(theName);
                    do_action(theAction, (*i), indent + "   ");
                    flagFound = true;
                }
            }
        }

        if( !flagFound ) {
            fprintf(m_pLogFile, "\tNoDoc not found\n");
        }

        fprintf(m_pLogFile, "--  End actions for NoDoc  --\n");
        return;
    }

	if( *action.name().begin() == s_RealNoDoc ) {
        std::list<long> docs;
        std::list<long>::iterator i;
        long flagFound;

        flagFound = false;

        fprintf(m_pLogFile, "-- Start actions for RealNoDoc --\n");

        docs = get_docs(docId, REFTYPE_REFLIST);
        for( i = docs.begin(); i != docs.end(); i++ ) {
			long idocid = (*i);
			std::map<long,DocInfo>::const_iterator map_it = get_doc_info (idocid);
			if (map_it != map_doc_docinfo.end ()) {
				if( (map_it->second.Status & DS_NODOC ) && !(map_it->second.Status & DS_EDITION)) {
                    ChangeAction theAction = action;
                    list<string> theName;
                    theName = theAction.name();
                    theName.erase(theName.begin());
                    theAction.name(theName);
                    do_action(theAction, idocid, indent + "   ");
                    flagFound = true;
                }
            }
        }

        if( !flagFound ) {
            fprintf(m_pLogFile, "\tRealNoDoc not found\n");
        }

        fprintf(m_pLogFile, "--  End actions for RealNoDoc  --\n");
        return;
    }

    if ( *action.name().begin() == s_Warning ) {
        if( action.command() == ChangeAction::ctSet ) {
			const char* aWarning = (*action.value().begin()).c_str();
	        m_pBase->ReplaceAttr(docId,IDD_WARNING,(void*)aWarning,strlen(aWarning)+1);
			change_doc_revision( docId );
		}

		return ;
	}

    if ( *action.name().begin() == s_ShortName ) {
		/*
        if( action.command() == ChangeAction::ctAdd ) {
			std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
			if (map_it != map_doc_docinfo.end ()) {
				const char* aPlus = (*action.value().begin()).c_str();
				short aPlusLen = strlen( aPlus );
				if ( strlen (map_it->second.Title ) + aPlusLen > DOC_SHORT_NAME_SIZE) {
					map_it->second.Title [DOC_SHORT_NAME_SIZE - 4 - aPlusLen] = 0;
					strcat (map_it->second.Title, "..." );
				}
				strcat (map_it->second.Title, aPlus );
                m_pBase->ReplaceAttr (docId, IDD_INFO, &map_it->second, sizeof (DocInfo));
				change_doc_revision (docId );
			}
		}
		*/
		return ;
	}

    if( *action.name().begin() == s_Doc ) {
        std::list<long> docs;
        std::list<long>::iterator i;
        long flagFound;

        flagFound = false;

        fprintf(m_pLogFile, "-- Start actions for Doc --\n");

        docs = get_docs(docId, REFTYPE_REFLIST);
        for( i = docs.begin(); i != docs.end(); i++ ) {
			if ( (*i) == docId )
				continue;

			if (set_result.find (*i) != set_result.end ())
				continue;

			std::map<long,DocInfo>::const_iterator map_it = get_doc_info ((*i));
			if (map_it != map_doc_docinfo.end ()) {
				if (map_it->second.Status & DS_DOC ) {
                    ChangeAction theAction = action;
                    list<string> theName;
                    theName = theAction.name();
                    theName.erase(theName.begin());
                    theAction.name(theName);
                    do_action(theAction, (*i), indent + "   ");
                    flagFound = true;
                }
            }
        }

        if( !flagFound ) {
            fprintf(m_pLogFile, "\tDoc not found\n");
        }

        fprintf(m_pLogFile, "--  End actions for Doc  --\n");
        return;
    }
    
    // Сссылки на блобы
    if( *action.name().begin() == s_Blob ) {
		if (action.command() == ChangeAction::ctRemove) {
			for(std::list<std::string>::iterator i = action.value().begin(); i != action.value().end(); i++ ) {
				if (b_readonly)
					continue;
				ObjKey objkey;
				objkey.id = ::atoi( (*i).c_str() );
				m_pBase->FindIndex ("Blob")->Delete (&objkey);
			}
		} else
        if( *(++action.name().begin()) == s_Belongs ) {
            long flagFound;
            short segment;
            Index *indBlob = m_pBase->FindIndex ("Blob");
            Stream *pStream;

            flagFound = false;
            segment = ::atoi((*action.value().begin()).c_str());
            
            fprintf(m_pLogFile, "-- Start actions for Blob --\n");
            
            // Берем список графических объектов
            std::list<long> blobs = get_docs (docId, REFTYPE_BLOB, true);
            std::list<long>::iterator i;

            switch( action.command() ) {
			case ChangeAction::ctAdd:            
                for( i = blobs.begin(); i != blobs.end(); i++ ) {
					fprintf(m_pLogFile, "%sAction for Blob %10d(%d):Belongs.add( '%s' )\n", indent.c_str (), (*i), (*i) - 100000, (*action.value().begin()).c_str());
            
					if (b_readonly)
						continue;
					pStream = indBlob->OpenN(&(*i), 1);
					if(pStream) {
						long    segCount, j, segFound;
						short   *pSeg;

						segCount = pStream->Length() / sizeof(short);
						pSeg = new short[segCount + 1];
						segFound = false;
						pStream->Read(pSeg, segCount * sizeof(short));

						bool in_exclude = false;

						for (j = 0; j < segCount && !in_exclude; j++) {
							if (pSeg[j] == segment)
								segFound = true;
							if (exclude_belongs.find (pSeg [j]) != exclude_belongs.end ())
								in_exclude = true;
						}

						if (in_exclude) {
							fprintf (m_pLogFile, "\tBlob содержит exclude_segment\n");
						} else
						if (!segFound) {
							pSeg [segCount] = segment;
							sort_here (pSeg, segCount + 1);
							pStream->Seek (0);
							pStream->Write (pSeg, sizeof(short) * (segCount + 1));
						} else {
							fprintf (m_pLogFile, "\tBlob Already exists\n");
						}
            
						indBlob->Close(pStream);
						delete [] pSeg;
					}
            
					flagFound = true;
				}
            
                break;

            case ChangeAction::ctRemove:
                for( i = blobs.begin(); i != blobs.end(); i++ ) {            
                    fprintf(m_pLogFile, "Action for Blob %10d(%d):Belongs.remove( '%s' )\n", (*i), (*i) - 100000, (*action.value().begin()).c_str());

					if (b_readonly)
						continue;

                    pStream = indBlob->OpenN(&(*i), 1);            
                    if(pStream) {
                        long    segCount, j, segFound;
                        short   *pSeg;

                        segCount = pStream->Length() / sizeof(short);
                        pSeg = new short[segCount];
                        segFound = false;
                        pStream->Read(pSeg, segCount * sizeof(short));

                        for( j = 0; j < segCount; j++ )
							if( pSeg[j] == segment ) {
                                segFound = true;
								break;
							}

                        if (segFound) {
                            for( ; j < segCount - 1; j++ )
                                pSeg[j] = pSeg[j + 1];

                            pStream->Seek(0);
                            pStream->Write(pSeg, (segCount - 1) * sizeof(short));
                            pStream->Trunc();
                        } else {
                            fprintf(m_pLogFile, "\tNothing to remove\n");
                        }
            
                        indBlob->Close(pStream);
						delete [] pSeg;
                    }
            
                    flagFound = true;
                }
                break;

            default:
                break;
            }

            if( !flagFound )
                fprintf(m_pLogFile, "\tBlob not found\n");
            
            fprintf(m_pLogFile, "--  End actions for Blob  --\n");
        } else {
            fprintf(m_pLogFile, "Error: in Blob you able to Belongs.remove() or Belongs.add()\n");
        }

        return;
    }
    
    // Сссылки на блобы, медленные
    if( *action.name().begin() == s_FastBlob ) {
        if( *(++action.name().begin()) == s_Belongs ) {
            long flagFound;
            short segment;
            Index *indBlob = m_pBase->FindIndex ("Blob");
            Stream *pStream;

            flagFound = false;
            segment = ::atoi((*action.value().begin()).c_str());
            
            fprintf(m_pLogFile, "-- Start actions for FastBlob --\n");
            
            // Берем список графических объектов
            std::list<long> blobs = get_docs (docId, REFTYPE_BLOB);
            std::list<long>::iterator i;

            switch( action.command() ) {

            case ChangeAction::ctAdd:            
                for( i = blobs.begin(); i != blobs.end(); i++ ) {
                    fprintf(m_pLogFile, "Action for Blob %10d(%d):Belongs.add( '%s' )\n", (*i), (*i) - 100000, (*action.value().begin()).c_str());

                    pStream = indBlob->OpenN(&(*i), 1);
                    if(pStream) {
                        long    segCount, j, segFound;
                        short   *pSeg;

                        segCount = pStream->Length() / sizeof(short);
                        pSeg = new short[segCount + 1];
                        segFound = false;
                        pStream->Read(pSeg, segCount * sizeof(short));

						bool in_exclude = false;

						for (j = 0; j < segCount && !in_exclude; j++) {
                            if (pSeg[j] == segment)
                                segFound = true;
							if (exclude_belongs.find (pSeg [j]) != exclude_belongs.end ())
								in_exclude = true;
						}

						if (in_exclude) {
							fprintf (m_pLogFile, "\tBlob содержит exclude_segment\n");
						} else
                        if (!segFound) {
                            pSeg [segCount] = segment;
                            sort_here (pSeg, segCount + 1);
                            pStream->Seek (0);
                            pStream->Write (pSeg, sizeof(short) * (segCount + 1));
                        } else {
                            fprintf (m_pLogFile, "\tBlob Already exists\n");
                        }
            
                        indBlob->Close(pStream);
						delete [] pSeg;
                    }
            
                    flagFound = true;
                }
            
                break;

            case ChangeAction::ctRemove:
                for( i = blobs.begin(); i != blobs.end(); i++ ) {            
                    fprintf(m_pLogFile, "Action for Blob %10d(%d):Belongs.remove( '%s' )\n", (*i), (*i) - 100000, (*action.value().begin()).c_str());

                    pStream = indBlob->OpenN(&(*i), 1);            
                    if(pStream) {
                        long    segCount, j, segFound;
                        short   *pSeg;

                        segCount = pStream->Length() / sizeof(short);
                        pSeg = new short[segCount];
                        segFound = false;
                        pStream->Read(pSeg, segCount * sizeof(short));

                        for( j = 0; j < segCount; j++ )
							if( pSeg[j] == segment ) {
                                segFound = true;
								break;
							}

                        if( segFound ) {
                            for( ; j < segCount - 1; j++ )
                                pSeg[j] = pSeg[j + 1];

                            pStream->Seek(0);
                            pStream->Write(pSeg, (segCount - 1) * sizeof(short));
                            pStream->Trunc();
                        } else {
                            fprintf(m_pLogFile, "\tNothing to remove\n");
                        }
            
                        indBlob->Close(pStream);
						delete [] pSeg;
                    }
            
                    flagFound = true;
                }
                break;

            default:
                break;
            }

            if( !flagFound ) {
                fprintf(m_pLogFile, "\tBlob not found\n");
            }
            
            fprintf(m_pLogFile, "--  End actions for FastBlob  --\n");
        } else {
            fprintf(m_pLogFile, "Error: in FastBlob you able to Belongs.remove() or Belongs.add()\n");
        }

        return;
    }
    
    // Сссылка на справку
    if( *action.name().begin() == s_Related ) {
        DocInfo docInfo;

        fprintf(m_pLogFile, "-- Start actions for Related --\n");

		std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
		if (map_it != map_doc_docinfo.end ()) {
            ChangeAction theAction = action;
            list<string> theName;
            theName = theAction.name();
            theName.erase(theName.begin());
            theAction.name(theName);
			if (theAction.command() == ChangeAction::ctSet) {
				map_it->second.Related = atol (theAction.value().begin()->c_str ());
				m_pBase->ReplaceAttr (docId, IDD_INFO, &map_it->second, sizeof( docInfo ));
			} else {
				long related = map_it->second.Related;
				map_it = get_doc_info (related);
				if (map_it != map_doc_docinfo.end ())
					do_action (theAction, related, indent + "   ");
			}
        }

        fprintf(m_pLogFile, "--  End actions for Related  --\n");
        return;
    }
    
    // Сссылка на аннотацию
    if( *action.name().begin() == s_Anno ) {
        fprintf(m_pLogFile, "-- Start actions for Anno --\n");

		std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
		if (map_it != map_doc_docinfo.end ()) {
			long annoid = GetDocMonitoring( (DocInfo*) &map_it->second);
			map_it = get_doc_info (annoid);
			if (map_it != map_doc_docinfo.end ()) {
				ChangeAction theAction = action;
				list<string> theName;
				theName = theAction.name();
				theName.erase(theName.begin());
				theAction.name(theName);
				do_action(theAction, annoid, indent + "   ");
			}
        }

        fprintf(m_pLogFile, "--  End actions for Anno --\n");
        return;
    }

    // Устанавливаем метку gl, grev, gsetrev
    m_baseChanged = true;

	// Юридическая сила документа
    if( *action.name().begin() == s_InfoForce ) {
        if( action.command() == ChangeAction::ctChange ) {
			std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
			if (map_it != map_doc_docinfo.end ()) {
				map_it->second.Force = ::atoi(( *action.value().begin() ).c_str());
				m_pBase->ReplaceAttr (docId, IDD_INFO, &map_it->second, sizeof(DocInfo));
				change_doc_revision (docId);
            }
        } else {
            fprintf(m_pLogFile,"Error: for InfoForce you able use only change() command\n");
            //fflush(m_pLogFile);
        }
        return;
    }

	if( *action.name().begin() == s_Status_ex ) {
		if( action.command() == ChangeAction::ctAdd ) {
			std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
			if (map_it != map_doc_docinfo.end ()) {
				unsigned short status = (unsigned short)(atoi(( *action.value().begin() ).c_str()) & 0xFFFF);
				if ((map_it->second.Status_ex & status) == 0) {
					map_it->second.Status_ex |= status;
					m_pBase->ReplaceAttr (docId, IDD_INFO, &map_it->second, sizeof(DocInfo));
					Ref ref = {docId, 0};
					if (map_statusex_docs.find (status) == map_statusex_docs.end ()) {
						std::set<long> toinsert;
						toinsert.insert (docId);
						map_statusex_docs.insert (std::map<short, std::set<long> >::value_type (status, toinsert));
					} else {
						map_statusex_docs.find (status)->second.insert (docId);
					}
					//add_stream_ref (m_pBase->FindIndex ("Status_ex"), &status, ref);
					change_doc_revision (docId);
				}
			}
		}
		return ;
	}

    if( *action.name().begin() == s_Status ) {
        if( action.command() == ChangeAction::ctAdd ) {
			std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
			if (map_it != map_doc_docinfo.end ()) {
				map_it->second.Status |= atoi(( *action.value().begin() ).c_str());
				m_pBase->ReplaceAttr(docId, IDD_INFO, &map_it->second, sizeof(DocInfo));
				change_doc_revision( docId );

				if (atoi(( *action.value().begin() ).c_str()) == DS_WARNING) {
					short status = DS_WARNING;
					add_stream_doc (m_pBase->FindIndex ("Status"), &status, docId);
				}
            }
        } else
        if( action.command() == ChangeAction::ctRemove ) {
			std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
			if (map_it != map_doc_docinfo.end ()) {
				int old_status = map_it->second.Status, remove_status = atoi(( *action.value().begin() ).c_str());
				map_it->second.Status &= ~remove_status;
				m_pBase->ReplaceAttr(docId, IDD_INFO, &map_it->second, sizeof(DocInfo));
				change_doc_revision( docId );
				if ((remove_status & DS_WARNING) && (old_status & DS_WARNING)) {
					short status = DS_WARNING;
					del_stream_doc (m_pBase->FindIndex ("Status"), &status, docId);
				}
            }
		} else {
            fprintf(m_pLogFile, "Error: for Status you can use only add() or remove() commands\n");
            //fflush(m_pLogFile);
        }
		return;
    }


	if ( *action.name().begin() == s_RelatedForIds ) {
		if ( action.command() == ChangeAction::ctSet ) {
			long related = ::atol ((*action.value().begin()).c_str());
			std::list<std::string>::iterator i = action.value().begin();
			for( i++; i != action.value().end(); i++ ) {
				long id = ::atoi( (*i).c_str() );
				std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
				if (map_it != map_doc_docinfo.end ()) {
					map_it->second.Related = related;
					m_pBase->ReplaceAttr (id, IDD_INFO, &map_it->second, sizeof (DocInfo));
				}
			}
		}
		return;
	}

	if ( *action.name().begin() == s_BelongsForBlobs ) {
		Index *indBlob = m_pBase->FindIndex("Blob");
		if ( action.command() == ChangeAction::ctAdd ) {
			long segment = ::atoi((*action.value().begin()).c_str());
			std::list<std::string>::iterator i = action.value().begin();

			for( i++; i != action.value().end(); i++ ) {
				long blobId = ::atoi( (*i).c_str() );
                fprintf(m_pLogFile, "Action for Blob %d\n", blobId);

				if (b_readonly)
					continue;

                Stream* pStream = indBlob->OpenN( &blobId, 1);        
                if( pStream ) {
					long    segCount, j, segFound;
                    short   *pSeg;

                    segCount = pStream->Length() / sizeof(short);
                    pSeg = new short[segCount + 1];
                    segFound = false;
                    pStream->Read(pSeg, segCount * sizeof(short));

					bool in_exclude = false;
					for( j = 0; j < segCount && !in_exclude; j++ ) {
                        if( pSeg[j] == segment )
                            segFound = true;
						if (exclude_belongs.find (pSeg [j]) != exclude_belongs.end ())
							in_exclude = true;
					}

					if (!in_exclude && !segFound) {
                        pSeg[segCount] = segment;
                        sort_here(pSeg, segCount + 1);
                        pStream->Seek(0);
                        pStream->Write(pSeg, sizeof(short) * (segCount + 1));
                    }

                    indBlob->Close(pStream);
					delete [] pSeg;
                }
            }
		} else if ( action.command() == ChangeAction::ctRemove ) {
			long segment = ::atoi((*action.value().begin()).c_str());
			std::list<std::string>::iterator i = action.value().begin();

			for( i++; i != action.value().end(); i++ ) {
				long blobId = ::atoi( (*i).c_str() );
                fprintf(m_pLogFile, "Action for Blob %d\n", blobId);

				if (b_readonly)
					continue;

                Stream* pStream = indBlob->OpenN( &blobId, 1);        
                if( pStream ) {
                    long    segCount, j, segFound;
                    short   *pSeg;

                    segCount = pStream->Length() / sizeof(short);
                    pSeg = new short[segCount + 1];
                    segFound = false;
                    pStream->Read(pSeg, segCount * sizeof(short));

                    for (j = 0; j < segCount; j++)
						if( pSeg[j] == segment ) {
                            segFound = true;
							break;
						}

                    if (segFound) {
                        for (; j < segCount - 1; j++)
                            pSeg [j] = pSeg [j+1];

                        pStream->Seek(0);
                        pStream->Write(pSeg, (segCount - 1) * sizeof(short));
                        pStream->Trunc();
                    }

                    indBlob->Close(pStream);
					delete [] pSeg;
                }
            }
		}
		return ;
	}

	/*
	if ( *action.name().begin() == s_AccountTopic ) {
		switch( action.command() ) {
		case ChangeAction::ctSet:
			long    segment = ::atoi((*action.value().begin()).c_str());
			long	docid   = ::atoi((*(++action.value().begin())).c_str());
			BaseInfo baseinfo;
			m_pBase->FindBaseInfo(segment,baseinfo);
			baseinfo.AccountTopic = docid;
			m_pBase->ReplaceBaseInfo(segment,&baseinfo);
			break;
		}
		return;
	}
	if ( *action.name().begin() == s_UserInfoTopic ) {
		switch( action.command() ) {
		case ChangeAction::ctSet:
			long    segment = ::atoi((*action.value().begin()).c_str());
			long	docid   = ::atoi((*(++action.value().begin())).c_str());
			BaseInfo baseinfo;
			m_pBase->FindBaseInfo(segment,baseinfo);
			baseinfo.UserInfoTopic = docid;
			m_pBase->ReplaceBaseInfo(segment,&baseinfo);
			break;
		}
		return;
	}
	if ( *action.name().begin() == s_AltMenuTopic ) {
		switch( action.command() ) {
		case ChangeAction::ctSet:
			long    segment = ::atoi((*action.value().begin()).c_str());
			long	docid   = ::atoi((*(++action.value().begin())).c_str());
			BaseInfo baseinfo;
			m_pBase->FindBaseInfo(segment,baseinfo);
			baseinfo.AltMenuTopic = docid;
			m_pBase->ReplaceBaseInfo(segment,&baseinfo);
			break;
		}
		return;
	}
	if ( *action.name().begin() == s_BusinessTopic ) {
		switch( action.command() ) {
		case ChangeAction::ctSet:
			long    segment = ::atoi((*action.value().begin()).c_str());
			long	docid   = ::atoi((*(++action.value().begin())).c_str());
			BaseInfo baseinfo;
			m_pBase->FindBaseInfo(segment,baseinfo);
			baseinfo.BusinessTopic = docid;
			m_pBase->ReplaceBaseInfo(segment,&baseinfo);
			break;
		}
		return;
	}
	*/
	if ( *action.name().begin() == s_SplashTopic ) {
		switch( action.command() ) {
		case ChangeAction::ctSet:
			long    segment = ::atoi((*action.value().begin()).c_str());
			long	docid   = ::atoi((*(++action.value().begin())).c_str());
			BaseInfo baseinfo;
			m_pBase->FindBaseInfo(segment,baseinfo);
			baseinfo.SplashTopic = docid;
			m_pBase->ReplaceBaseInfo(segment,&baseinfo);
			break;
		}
		return;
	}
	if ( *action.name().begin() == s_BannerTopic ) {
		switch( action.command() ) {
		case ChangeAction::ctSet:
			long    segment = ::atoi((*action.value().begin()).c_str());
			long	docid   = ::atoi((*(++action.value().begin())).c_str());
			BaseInfo baseinfo;
			m_pBase->FindBaseInfo(segment,baseinfo);
			baseinfo.BannerTopic = docid;
			m_pBase->ReplaceBaseInfo(segment,&baseinfo);
			break;
		}
		return;
	}
	if ( *action.name().begin() == s_Attrs) {
		if (action.command() == ChangeAction::ctRemove) {
			int tag = ::atoi((*action.value().begin()).c_str());
			AttrKey attr_key = {ID_BORDER, tag};
			std::deque<long> doc_ids;
			for (BTIterator it (m_pBase->FindIndex ("Attrs"), &attr_key); !it.End (); ++it) {
				AttrKey *key = (AttrKey*) it.Key ();
				if (key->AttrTag != tag)
					break;
				doc_ids.push_back (key->DocId);
			}
			for (std::deque<long>::const_iterator deq_it = doc_ids.begin (); deq_it != doc_ids.end (); deq_it++)
				m_pBase->DelAttr (*deq_it, tag);
		}
		return ;
	}
	if ( *action.name().begin() == s_Aux) {
		if (action.command() == ChangeAction::ctRemove) {
			m_pBase->FindIndex("Aux")->Delete ((*action.value().begin()).c_str());
		}
		return ;
	}
	if ( *action.name().begin() == s_Index) {
		if (action.command() == ChangeAction::ctRemove) {
			m_pBase->FindIndex((*action.value().begin()).c_str())->KeyCount = 0;
		}
		return ;
	}

	if ( *action.name().begin() == s_ExcludeBelongs) {
		if (action.command() == ChangeAction::ctAdd) {
			exclude_belongs.insert (::atoi((*action.value().begin()).c_str()));
		}
		return ;
	}

	if ( *action.name().begin() == s_BelongsForIdsBlobs ) {
		fprintf(m_pLogFile, "-- Start actions for BelongsForIdsBlobs --\n");

		std::list<long> blobs;
		Index* indBlob = m_pBase->FindIndex ("Blob");
		switch( action.command() ) {
		case ChangeAction::ctAdd:
			{
                long    segment;
                segment = ::atoi((*action.value().begin()).c_str());

				std::list<std::string>::iterator i = action.value().begin();
				for( i++; i != action.value().end(); i++ ) {
					long docId = ::atoi( (*i).c_str() );
					std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
					if (map_it == map_doc_docinfo.end ())
						continue;
					blobs = get_docs (docId, REFTYPE_BLOB, true);
					for( std::list<long>::const_iterator j = blobs.begin(); j != blobs.end(); j++ ) {
	                    fprintf(m_pLogFile, "Action for Blob %d\n", (*j));
						if (!b_readonly) {
							Stream *pStream = indBlob->OpenN(&(*j), 1);
							if(pStream) {
								long    segCount, k, segFound;
								short   *pSeg;

								segCount = pStream->Length() / sizeof(short);
								pSeg = new short[segCount + 1];
								segFound = false;
								pStream->Read(pSeg, segCount * sizeof(short));

								bool in_exclude = false;
								for( k = 0; k < segCount && !in_exclude; k++ ) {
									if( pSeg[k] == segment )
										segFound = true;
									if (exclude_belongs.find (pSeg [k]) != exclude_belongs.end ())
										in_exclude = true;
								}

								if (!in_exclude && !segFound) {
									pSeg[segCount] = segment;
									sort_here(pSeg, segCount + 1);
									pStream->Seek(0);
									pStream->Write(pSeg, sizeof(short) * (segCount + 1));
								}
	            
								indBlob->Close(pStream);
								delete [] pSeg;
							}
						}
					}
				}
			}
			break;
		case ChangeAction::ctRemove:
			{
                long    segment;
                segment = ::atoi((*action.value().begin()).c_str());

				std::list<std::string>::iterator i = action.value().begin();
				for( i++; i != action.value().end(); i++ ) {
					long docId = ::atoi( (*i).c_str() );
					blobs = get_docs(docId, REFTYPE_BLOB, true);
					for( std::list<long>::const_iterator j = blobs.begin(); j != blobs.end(); j++ ) {
	                    fprintf(m_pLogFile, "Action for Blob %d\n", (*j));
						if (!b_readonly) {
							Stream* pStream = indBlob->OpenN(&(*i), 1);
							if (pStream) {
								long    segCount, k, segFound;
								short   *pSeg;

								segCount = pStream->Length() / sizeof(short);
								pSeg = new short[segCount];
								segFound = false;
								pStream->Read(pSeg, segCount * sizeof(short));

								for( k = 0; k < segCount; k++ )
									if( pSeg[k] == segment )
										segFound = true;

								if( segFound )
									for( ; k < segCount - 1; k++ )
										pSeg[k] = pSeg[k + 1];

								pStream->Seek(0);
								pStream->Write(pSeg, (segCount - 1) * sizeof(short));
								pStream->Trunc();
								delete [] pSeg;
							}
							indBlob->Close(pStream);
						}
                    }
				}
			}
			break;
		}
		fprintf(m_pLogFile, "-- End actions for BelongsForIdsBlobs --\n");
		return;
	}

	if ( *action.name().begin() == s_BelongsForIdsRelateds ) {
		fprintf(m_pLogFile, "-- Start actions for BelongsForIdsRelateds --\n");
		switch( action.command() ) {
		case ChangeAction::ctAdd:
			{
                long    segment;
                segment = ::atoi((*action.value().begin()).c_str());

				std::list<std::string>::iterator i = action.value().begin();
				for( i++; i != action.value().end(); i++ ) {
					long docId = ::atoi( (*i).c_str() );
					std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
					if (map_it != map_doc_docinfo.end ()) {
						long related = map_it->second.Related;
						if (related) {
		                    fprintf(m_pLogFile, "Action for Related %d\n", related);
							map_it = get_doc_info (related);
							if (map_it != map_doc_docinfo.end ())
								add_belongs (related, segment);
						}
					}
				}

			}
			break;
        case ChangeAction::ctRemove:
            {
                long    segment;
                segment = ::atoi((*action.value().begin()).c_str());

				std::list<std::string>::iterator i = action.value().begin();
				for( i++; i != action.value().end(); i++ ) {
					long docId = ::atoi( (*i).c_str() );
					std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
					if (map_it != map_doc_docinfo.end ()) {
						long related = map_it->second.Related;
						if (related) {
		                    fprintf(m_pLogFile, "Action for Related %d\n", related);
							std::map<long,DocInfo>::const_iterator map_it = get_doc_info (related);
							if (map_it != map_doc_docinfo.end ())
								remove_belongs (related, segment );
						}
					}
				}
            }
            break;
		}
		fprintf(m_pLogFile, "-- End actions for BelongsForIdsRelateds --\n");
		return;
	}

	if ( *action.name().begin() == s_BelongsForIdsEditions ) {
		fprintf(m_pLogFile, "-- Start actions for BelongsForIdsEditions --\n");
		long    segment = ::atoi((*action.value().begin()).c_str());
		std::list<std::string>::iterator i = action.value().begin();
		std::set<long> editions;
		for( i++; i != action.value().end(); i++ ) {
			long docId = ::atoi( (*i).c_str() );
			std::map<long, std::set<long> >::const_iterator map_it = map_doc_editions.find (docId);
			if (map_it != map_doc_editions.end ())
				editions.insert (map_it->second.begin (), map_it->second.end ());
		}

		switch( action.command() ) {
		case ChangeAction::ctAdd:
			for (std::set<long>::const_iterator it = editions.begin (); it != editions.end (); it++) {
				fprintf(m_pLogFile, "Action for Edition %d\n", *it);
				add_belongs(*it, segment );
			}
			break;
        case ChangeAction::ctRemove:
			for (std::set<long>::const_iterator it = editions.begin (); it != editions.end (); it++) {
				fprintf(m_pLogFile, "Action for Edition %d\n", *it);
				remove_belongs(*it, segment );
			}
            break;
		}
		fprintf(m_pLogFile, "-- End actions for BelongsForIdsEditions --\n");
		return;
	}

	if ( *action.name().begin() == s_BelongsForIdsN ) {
		fprintf(m_pLogFile, "-- Start actions for BelongsForIdsN --\n");
		long total = ::atoi((*action.value().begin()).c_str()), count = 0;
		std::set<long> segments, docs, docs_docs;
		std::list<std::string>::iterator i = action.value().begin();
		for (i++; count < total; i++, count++) {
			long segment = ::atoi( (*i).c_str() );
			segments.insert (segment);
		}
		for (; i != action.value().end(); i++) {
			long docId = ::atoi( (*i).c_str());
			std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
			if (map_it != map_doc_docinfo.end ()) {
				docs.insert (docId);
				if (map_it->second.Status & DS_DOC)
					docs_docs.insert (docId);
			}
		}

		switch( action.command() ) {
		case ChangeAction::ctAdd:
			{
				std::set<long>::const_iterator it = docs.begin (), seg_it, found_it;

				for (; it != docs.end (); it++) {
					long docId = *it;
					fprintf(m_pLogFile, "Action for Id %d\n", docId);

					short   segmentBuf [s_maxseg], segmentCount = get_belongs (docId, segmentBuf);
					std::set<long> ids;
					for (int i = 0; i < segmentCount; i++)
						ids.insert (segmentBuf [i]);
					for (seg_it = segments.begin (); seg_it != segments.end (); seg_it++)
						ids.insert (*seg_it);
					if (ids.size () != segmentCount) {
						for (segmentCount = 0, seg_it = ids.begin (); seg_it != ids.end (); seg_it++)
							segmentBuf [segmentCount++] = *seg_it;
						put_belongs (docId, segmentBuf, segmentCount);
					}
				}
			}
			break;
        case ChangeAction::ctRemove:
            {
				std::set<long>::const_iterator it = docs.begin (), seg_it;

				for (; it != docs.end (); it++) {
					long docId = *it;
					fprintf(m_pLogFile, "Action for Id %d\n", docId);

					short   segmentBuf [s_maxseg], segmentCount = get_belongs (docId, segmentBuf);
					std::set<long> ids;
					for (int i = 0; i < segmentCount; i++)
						ids.insert (segmentBuf [i]);
					for (seg_it = segments.begin (); seg_it != segments.end (); seg_it++) {
						std::set<long>::iterator found_it = ids.find (*seg_it);
						if (found_it != ids.end ())
							ids.erase (found_it);
					}
					if (ids.size () != segmentCount) {
						for (segmentCount = 0, seg_it = ids.begin (); seg_it != ids.end (); seg_it++)
							segmentBuf [segmentCount++] = *seg_it;
						put_belongs (docId, segmentBuf, segmentCount);
					}
				}
            }
            break;
		}
		fprintf(m_pLogFile, "-- End actions for BelongsForIdsN --\n");
		return;
	}

	if ( *action.name().begin() == s_Keywords) {
		if (action.command () == ChangeAction::ctRemove) {
			Index* index = m_pBase->FindIndex ("KeyWord");
			long length = index->KeyLength, count = index->KeyCount;
			if ( count ) {
				char *keys = (char*) malloc (count * length), *apos = keys;
				BTIterator *it;
				for (it = new BTIterator (index); !it->End (); ++*it, apos += length ) {
					memcpy (apos, it->Key (), length);
				}
				delete it;
				apos = keys;
				for (long i = 0; i < count; i++, apos += length)
					index->Index::Delete (apos);
				free (keys);
			}

			for (long i = 0; i < allTopic->ItemCount; i++) {
				long doc_id = (*allTopic)[i];
				m_pBase->DelAttr (doc_id, IDD_KEY);
			}
			
		}
		return ;
	}
	
	if ( *action.name().begin() == s_PublishedIns) {
		if (action.command () == ChangeAction::ctRemove) {
			Index* index = m_pBase->FindIndex ("PublishedIn");
			long length = index->KeyLength, count = index->KeyCount;
			if ( count ) {
				char *keys = (char*) malloc (count * length), *apos = keys;
				BTIterator *it;
				for (it = new BTIterator (index); !it->End (); ++*it, apos += length ) {
					memcpy (apos, it->Key (), length);
				}
				delete it;
				apos = keys;
				for (long i = 0; i < count; i++, apos += length)
					index->Index::Delete (apos);
				free (keys);
			}

			for (long i = 0; i < allTopic->ItemCount; i++) {
				long doc_id = (*allTopic)[i];
				m_pBase->DelAttr (doc_id, IDD_PUBLISHEDIN);
			}
			
		}
		return ;
	}
	
	if ( *action.name().begin() == s_BelongsForIds ) {
		fprintf(m_pLogFile, "-- Start actions for BelongsForIds --\n");
		switch( action.command() ) {
		case ChangeAction::ctAdd:
			{
                long    segment;
                segment = ::atoi((*action.value().begin()).c_str());

				std::list<std::string>::iterator i = action.value().begin();
				for( i++; i != action.value().end(); i++ ) {
					long docId = ::atoi( (*i).c_str() );
					std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
					if (map_it != map_doc_docinfo.end ()) {
						fprintf(m_pLogFile, "Action for Id %d\n", docId);
						if (add_belongs (docId, segment)) {
							if (b_readonly)
								continue;
							if (map_it->second.Status & DS_DOC)
								add_str_index (IDD_BASES,(const char *)&segment, docId);
							if (map_it->second.Status_ex & DS_FLASH) {
								Index *indBlob = m_pBase->FindIndex("Blob");
								Stream *pStream;
								pStream = indBlob->OpenN (&docId, 1);
								if (pStream) {
									long    segCount, j, segFound;
									short   *pSeg;

									segCount = pStream->Length() / sizeof(short);
									pSeg = new short[segCount + 1];
									segFound = false;
									pStream->Read(pSeg, segCount * sizeof(short));

									for( j = 0; j < segCount; j++ )
										if( pSeg[j] == segment )
											segFound = true;

									if( !segFound ) {
										pSeg[segCount] = segment;
										sort_here(pSeg, segCount + 1);
										pStream->Seek(0);
										pStream->Write(pSeg, sizeof(short) * (segCount + 1));
									}
									indBlob->Close(pStream);
									delete [] pSeg;
								}
							}
						}
					}
				}

			}
			break;
        case ChangeAction::ctRemove:
            {
                long    segment;
                segment = ::atoi((*action.value().begin()).c_str());

				std::list<std::string>::iterator i = action.value().begin();
				for( i++; i != action.value().end(); i++ ) {
					long docId = ::atoi( (*i).c_str() );
					std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
					if (map_it != map_doc_docinfo.end ()) {
						fprintf(m_pLogFile, "Action for Id %d\n", docId);
						if (b_readonly)
							continue;
						remove_belongs (docId, segment);
						if (map_it->second.Status & DS_DOC)
							del_str_index (IDD_BASES, (const char *)&segment, docId, 0);
					}
				}
            }
            break;
		}
		fprintf(m_pLogFile, "-- End actions for BelongsForIds --\n");
		return;
	}
    
	if ( *action.name().begin() == s_Status128ForIds) {
		switch( action.command() ) {
		case ChangeAction::ctAdd:
			{
				short status = DS_WARNING;
				DocCollection add;
				for( std::list<std::string>::iterator i = action.value().begin(); i != action.value().end(); i++ ) {
					long docId = ::atoi( (*i).c_str() );
					std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
					if (map_it != map_doc_docinfo.end ()) {
						add.Add (docId);
						map_it->second.Status |= status;
						m_pBase->ReplaceAttr (docId, IDD_INFO, &map_it->second, sizeof(DocInfo));
						change_doc_revision( docId );
					}
				}

				Stream* str = m_pBase->FindIndex ("Status")->Open (&status,1);
				if (str) {
					DocCollection docs;
					docs.Get (str);
					docs.Merge (add);
					str->Seek (0);
					docs.Put (str);
					m_pBase->FindIndex ("Status")->Close (str);
				}
			}
			break;
		}
		return;
	}
    
	if( *action.name().begin() == s_Here ) {
        if (!b_readonly) switch( action.command() ) {
        // Добавить belongs
        case ChangeAction::ctAdd:
            {
                long    segment;

                segment = ::atoi((*action.value().begin()).c_str());

                // Добавляем в Here
                add_here(segment);

                // Добавляем в BaseInfo
                if( action.value().size() > 3 ) {
                    add_baseinfo(segment,
                            (*(++action.value().begin())).c_str(),
                            (*(++(++action.value().begin()))).c_str(),
                            ::atoi((*(++(++(++action.value().begin())))).c_str()));
                } else {
                    fprintf(m_pLogFile, "Error: invalid parameters in Belongs.add()\n");
                    //fflush(m_pLogFile);
                }

                // Добавляем в Index
                add_keyindex(&segment, m_pBase->FindIndex("Segment"));
            }
            break;

        case ChangeAction::ctRemove:
            {
                long    segment;

                segment = ::atoi((*action.value().begin()).c_str());

                // Удаляем из Here
                remove_here(segment);

                // Удаляем из BaseInfo
                remove_baseinfo(segment);

                // Удаляем из Index
                remove_keyindex(&segment, m_pBase->FindIndex("Segment"));
            }
            break;

        default:
            fprintf(m_pLogFile, "Error: for Here you able use only add() or remove() commands\n");
            break;
        }
        return;
    }

    // IDD_BASES, Сегменты, к которым принадлежит документ
	if( *action.name().begin() == s_result ) {
		set_result.insert (docId);
		return;
	}
	if( *action.name().begin() == s_Belongs ) {
        switch( action.command() ) {
        // Добавляем belongs
        case ChangeAction::ctAdd:
            {
                long    segment = ::atoi((*action.value().begin()).c_str());
				std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
				if (map_it != map_doc_docinfo.end () && add_belongs (docId, segment)) {
					if (map_it->second.Status & DS_DOC )
						add_str_index (IDD_BASES, (const char *)&segment, docId);

					if (!b_readonly && (map_it->second.Status_ex & DS_FLASH)) {
						Index *indBlob = m_pBase->FindIndex("Blob");
						Stream *pStream;
						pStream = indBlob->OpenN (&docId, 1);
						if (pStream) {
							long    segCount, j, segFound;
							short   *pSeg;

							segCount = pStream->Length() / sizeof(short);
							pSeg = new short[segCount + 1];
							segFound = false;
							pStream->Read(pSeg, segCount * sizeof(short));

							for( j = 0; j < segCount; j++ )
								if( pSeg[j] == segment )
									segFound = true;

							if( !segFound ) {
								pSeg[segCount] = segment;
								sort_here (pSeg, segCount + 1);
								pStream->Seek(0);
								pStream->Write (pSeg, sizeof(short) * (segCount + 1));
							}

							delete [] pSeg;
							indBlob->Close (pStream);
						}
					}
				}
            }
            break;

        // Удаляем belongs
        case ChangeAction::ctRemove:
            {
                long    segment = ::atoi((*action.value().begin()).c_str());
                remove_belongs(docId, segment);
				std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
				if (map_it != map_doc_docinfo.end () && map_it->second.Status & DS_DOC )
					del_str_index (IDD_BASES, (const char *)&segment, docId, 0);
            }
            break;

        default:
            fprintf(m_pLogFile,
                    "Error: for Belongs you "\
                    "able use only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

    // IDD_ID, Номер документа
    if( *action.name().begin() == s_Id ) {
        switch( action.command() ) {
        // Добавляем номер документа
        case ChangeAction::ctAdd:
            {
                add_string(docId, (*action.value().begin()).c_str(), IDD_ID);
                add_str_index(IDD_ID, (*action.value().begin()).c_str(), docId);
            }
            break;
        // Удаляем номер документа
        case ChangeAction::ctRemove:
            {
                remove_string(docId,
                        (*action.value().begin()).c_str(),
                        IDD_ID);
                del_str_index(IDD_ID,
                        (*action.value().begin()).c_str(),
                        docId, 0);
            }
            break;
        default:
            fprintf(m_pLogFile,
                    "Error: for Id you able use "\
                    "only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

    // IDD_PUBLISHEDIN, Источник опубликования
    if( *action.name().begin() == s_PublishedIn ) {
        switch( action.command() ) {
        // Добавляем
        case ChangeAction::ctAdd:
            {
                add_string(docId, (*action.value().begin()).c_str(), IDD_PUBLISHEDIN);
                add_str_index(IDD_PUBLISHEDIN,
                        (*action.value().begin()).c_str(),
                        docId);
            }
            break;
        // Удаляем
        case ChangeAction::ctRemove:
            {
                remove_string(docId,
                        (*action.value().begin()).c_str(),
                        IDD_PUBLISHEDIN);
                del_str_index(IDD_PUBLISHEDIN,
                        (*action.value().begin()).c_str(),
                        docId, 0);
            }
            break;
        default:
            fprintf(m_pLogFile,
                    "Error: for PublishedIn you able "\
                    "use only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

    // IDD_TYPE, Тип документа
    if( *action.name().begin() == s_Type ) {
        switch( action.command() ) {
        // Добавляем тип документа
        case ChangeAction::ctAdd:
            {
                add_string(docId, (*action.value().begin()).c_str(), IDD_TYPE);
                add_str_index(IDD_TYPE,
                        (*action.value().begin()).c_str(),
                        docId);
            }
            break;
        // Удаляем тип документа
        case ChangeAction::ctRemove:
            {
                remove_string(docId,
                        (*action.value().begin()).c_str(),
                        IDD_TYPE);
                del_str_index(IDD_TYPE,
                        (*action.value().begin()).c_str(),
                        docId, 0);
            }
            break;
        default:
            fprintf(m_pLogFile,
                    "Error: for Type you able "\
                    "use only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

    // IDD_SOURCE, Орган, издавший документ
    if( *action.name().begin() == s_Source ) {
        switch( action.command() ) {
        // Орган, издавший документ
        case ChangeAction::ctAdd:
            {
                add_string(docId, (*action.value().begin()).c_str(), IDD_SOURCE);
                add_str_index(IDD_SOURCE, (*action.value().begin()).c_str(), docId);
            }
            break;
        // Орган, издавший документ
        case ChangeAction::ctRemove:
            {
                remove_string(docId, (*action.value().begin()).c_str(), IDD_SOURCE);
                del_str_index(IDD_SOURCE, (*action.value().begin()).c_str(), docId, 0);
            }
            break;
		case ChangeAction::ctChange:
			{
				Index* adopted = m_pBase->FindIndex ("Adopted");
				for (std::list<std::string>::const_iterator l = action.value().begin(); l != action.value().end(); l++) {
					std::string at_l = *l;
					GCL::StrVector from_to;
					boost::split (from_to, at_l, boost::is_any_of ("|"));
					if (from_to.size () != 2)
						continue;

					std::string from = from_to.at (0);
					std::string to = from_to.at (1);
					BTKEY key = adopted->FullKey (from.c_str ());
					if (key) {
						Stream* str0 = adopted->Index::OpenN (key, 0);
						DocCollection docs;
						if (str0) {
							docs.Get (str0);
							adopted->Close (str0);
						}
						adopted->DelKey (key);
						HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) key;
						if (strrchr (to.c_str (), '\\')) {
							strcpy (hkey->text, strrchr (to.c_str (), '\\') + 1);
						} else {
							strcpy (hkey->text, to.c_str ());
						}
						str0 = adopted->Index::OpenN (key, 0, 1);
						if (str0) {
							docs.Put (str0);
							adopted->Close (str0);
						}
						for (int doc = 0; doc < docs.ItemCount; doc++) {
							long docid = docs [doc], size0 = 0;
							char *data = (char*) m_pBase->LoadAttr (docid, IDD_SOURCE, size0), *ptr = data;
							std::vector<std::string> new_strings;
							while (ptr - data < size0) {
								if (strstr (ptr, from.c_str ()) == ptr) {
									std::string new_str = to;
									new_str += ptr + from.size ();
									new_strings.push_back (new_str);
								} else {
									new_strings.push_back (ptr);
								}
								ptr += strlen (ptr) + 1;
							}
							gk_free (data);
							std::vector<std::string>::const_iterator str_it;
							for (str_it = new_strings.begin (), size0 = 0; str_it != new_strings.end (); str_it++)
								size0 += str_it->size () + 1;
							for (str_it = new_strings.begin (), data = new char [size0], ptr = data; str_it != new_strings.end (); str_it++, ptr += strlen (ptr) + 1)
								strcpy (ptr, str_it->c_str ());
							m_pBase->ReplaceAttr (docid, IDD_SOURCE, data, size0);
							delete []data;					
						}
					}
				}
			}
			break;
        default:
            fprintf(m_pLogFile,
                    "Error: for Source you able "\
                    "use only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

	if( *action.name().begin() == s_ProfDocs && action.command() == ChangeAction::ctAdd) {
		std::map<long,date> map_doc_olddates;
		std::set<long> old_docs, old_blobs, new_blobs;
		AttrKey key = {ID_BORDER, IDD_PROFDATE};
		for (BTIterator it(m_pBase->FindIndex ("Attrs"), &key); !it.End (); ++it) {
			AttrKey *akey = (AttrKey*) it.Key ();
			if (akey->AttrTag != IDD_PROFDATE)
				break;
			long id = akey->DocId, size = 0;
			old_docs.insert (id);

			date* dates = (date*) m_pBase->LoadAttr (id, IDD_PROFDATE, size);
			map_doc_olddates.insert (std::map<long,date>::value_type (id, *dates));
			gk_free (dates);
		}

		std::list<std::string>::const_iterator l = action.value().begin();
		long days = atol (l->c_str ());
		l++;
		long belongs = atol (l->c_str ());
		l++;
		std::set<long> resps;
		for (; l != action.value().end(); l++) {
			long doc = atol (l->c_str ());
			std::list<long> docs = get_docs (doc, REFTYPE_REFLIST);
			for (std::list<long>::const_iterator i = docs.begin (); i != docs.end (); i++) {
				long resp = *i;
				std::map<long,DocInfo>::const_iterator map_it = get_doc_info (resp);
				if (map_it != map_doc_docinfo.end ()) {
					if (map_it->second.Status & DS_REFDOC)
						continue;
					if (map_it->second.Status & (DS_DOC|DS_EDITION|DS_NODOC))
						resps.insert (resp);
				}
			}
		}
		std::set<long> more_resps;
		std::set<long>::const_iterator resp_it;
		for (resp_it = resps.begin (); resp_it != resps.end (); resp_it++) {
			long resp = *resp_it;
			if (map_edition_doc.find (resp) != map_edition_doc.end ()) {
				long doc = map_edition_doc.find (resp)->second;
				std::set<long> editions = map_doc_editions.find (doc)->second;
				more_resps.insert (editions.begin (), editions.end ());
			} else if (map_doc_editions.find (resp) != map_doc_editions.end ()) {
				std::set<long> editions = map_doc_editions.find (resp)->second;
				more_resps.insert (editions.begin (), editions.end ());
			}
		}
		resps.insert (more_resps.begin (), more_resps.end ());
		std::vector<long> check_old_docs; //старые документы, которые надо проверить: не прошло ли разрешенное для их показа время
		std::set_difference (old_docs.begin (), old_docs.end (), resps.begin (), resps.end (), std::back_inserter (check_old_docs));

		for (resp_it = resps.begin (); resp_it != resps.end (); resp_it++) {
			long id = *resp_it;
			add_belongs (id, belongs);
			std::map<long,DocInfo>::const_iterator map_it = get_doc_info (id);
			if (map_it != map_doc_docinfo.end () && (map_it->second.Status & DS_DOC))
				add_str_index (IDD_BASES, (const char*)&belongs, id);

			m_pBase->ReplaceAttr (id, IDD_PROFDATE, &rrevision.RevisionDate, sizeof (date));
			change_doc_revision (id);

			std::list<long> blobs = get_docs  (id, REFTYPE_BLOB, true);
			for (std::list<long>::iterator blobs_it = blobs.begin (); blobs_it != blobs.end (); blobs_it++) {
				long blob_id = *blobs_it;
				new_blobs.insert (blob_id);
			}
		}

		for (std::vector<long>::const_iterator check_it = check_old_docs.begin (); check_it != check_old_docs.end (); check_it++) {
			long id = *check_it, size = 0;
			date* old_date = (date*) m_pBase->LoadAttr (id, IDD_PROFDATE, size);
			if (size) {
				revision docr;
				gk_bzero (&docr, sizeof (docr));
				docr.RevisionDate = *old_date;
				long diff = rev_daysdiff (rrevision, docr);
				if (diff > days) {
					remove_belongs (id, belongs);
					std::map<long,DocInfo>::const_iterator map_it = get_doc_info (id);
					if (map_it != map_doc_docinfo.end () && (map_it->second.Status & DS_DOC))
						del_str_index (IDD_BASES, (const char*)&belongs, id, 0);
					m_pBase->DelAttr (id, IDD_PROFDATE);
					change_doc_revision (id);
				} else {
					add_belongs (id, belongs);
					std::map<long,DocInfo>::const_iterator map_it = get_doc_info (id);
					if (map_it != map_doc_docinfo.end () && (map_it->second.Status & DS_DOC))
						add_str_index (IDD_BASES, (const char*)&belongs, id);
					change_doc_revision (id);

					std::list<long> blobs = get_docs  (id, REFTYPE_BLOB, true);
					for (std::list<long>::iterator blobs_it = blobs.begin (); blobs_it != blobs.end (); blobs_it++) {
						long blob_id = *blobs_it;
						new_blobs.insert (blob_id);
					}
				}
				gk_free (old_date);
			}
		}

		std::set<long>::const_iterator blob_it;
		for (blob_it = new_blobs.begin (); blob_it != new_blobs.end (); blob_it++) {
			long id = *blob_it;
			blob_add_belongs (id, (short) (belongs & 0x7FFF));
		}

		return ;
	}
	
	if( *action.name().begin() == s_AnnoTax2AnnoInterest ) {
		if (action.command() == ChangeAction::ctChange) {
			Index *annotax = m_pBase->FindIndex ("AnnoTax"), *annointerest = m_pBase->FindIndex ("AnnoInterest");

			for (std::list<std::string>::const_iterator l = action.value().begin(); l != action.value().end(); l++) {
				std::string at_l = *l;
				GCL::StrVector from_to;
				boost::split (from_to, at_l, boost::is_any_of ("|"));
				if (from_to.size () != 2)
					continue;

				std::string from = from_to.at (0);
				std::string to = from_to.at (1);
				BTKEY taxkey = annotax->FullKey (from.c_str ());
				if (taxkey) {
					Stream* str = annotax->Index::OpenN (taxkey, 0);
					DocCollection docs;
					if (str) {
						docs.Get (str);
						annotax->Close (str);
					}
					str = annointerest->Open (to.c_str (), 1);
					if (str) {
						DocCollection wasdocs;
						wasdocs.Get (str);
						docs.Merge (wasdocs);
						str->Seek (0);
						docs.Put (str);
						annointerest->Close (str);
					}
				}
			}
		}
		return;
	}

	if( *action.name().begin() == s_AnnoInterest ) {
		switch( action.command() ) {
		case ChangeAction::ctAdd:
			{
				add_string(docId, (*action.value().begin()).c_str(), IDD_ANNOINTEREST);
				add_str_index(IDD_ANNOINTEREST, (*action.value().begin()).c_str(), docId);
			}
			break;
        case ChangeAction::ctChange:
			{
				Index* annointerest = m_pBase->FindIndex ("AnnoInterest");
				for (std::list<std::string>::const_iterator l = action.value().begin(); l != action.value().end(); l++) {
					std::string at_l = *l;
					GCL::StrVector from_to;
					boost::split (from_to, at_l, boost::is_any_of ("|"));
					if (from_to.size () != 2)
						continue;

					std::string from = from_to.at (0);
					std::string to = from_to.at (1);
					BTKEY key = annointerest->FullKey (from.c_str ());
					if (key) {
						Stream* str0 = annointerest->Index::OpenN (key, 0);
						DocCollection docs;
						if (str0) {
							docs.Get (str0);
							annointerest->Close (str0);
						}
						annointerest->DelKey (key);
						HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) key;
						if (strrchr (to.c_str (), '\\')) {
							strcpy (hkey->text, strrchr (to.c_str (), '\\') + 1);
						} else {
							strcpy (hkey->text, to.c_str ());
						}
						str0 = annointerest->Index::OpenN (hkey, 0, 1);
						if (str0) {
							docs.Put (str0);
							annointerest->Close (str0);
						}
					}
				}
			}
			break;
		}
        return;
	}

    if( *action.name().begin() == s_PreAnnoInterest ) {
        switch( action.command() ) {
        // Класс
        case ChangeAction::ctAdd:
            {
                add_string(docId, (*action.value().begin()).c_str(), IDD_PREANNOINTEREST);
            }
            break;
		case ChangeAction::ctChange:
			if (docId==0) {
				std::map<std::string,std::string> map_replaces;
				for (std::list<std::string>::iterator i = action.value().begin(); i != action.value().end(); i++) {
					char *str = strdup (i->c_str ()), *deli = strchr (str, '|');
					if (!deli)
						continue;
					*deli = 0; deli++;
					map_replaces.insert (std::map<std::string,std::string>::value_type (str, deli));
					free (str);
				}
				for (int i = 0; i < allTopic->ItemCount; i++) {
					long id = (*allTopic) [i], size = 0;
					if (id < ID_ANNOPLUS)
						continue;
					char *preannointerest = (char*) m_pBase->LoadAttr (id, IDD_PREANNOINTEREST, size), *ptr = preannointerest;
					if (!size)
						continue;
					std::deque<std::string> oldstrs;
					while (ptr - preannointerest < size) {
						oldstrs.push_back (ptr);
						ptr += strlen (ptr) + 1;
					}
					gk_free (preannointerest);

					std::deque<std::string> newstrs;
					std::deque<std::string>::const_iterator str_it;
					for (str_it = oldstrs.begin (); str_it != oldstrs.end (); str_it++) {
						std::map<std::string,std::string>::const_iterator chg_it = map_replaces.find (*str_it);
						if (chg_it != map_replaces.end ()) {
							newstrs.push_back (chg_it->second.c_str ());
						} else {
							newstrs.push_back (*str_it);
						}
					}

					long newsize = 0;
					for (str_it = newstrs.begin (); str_it != newstrs.end (); str_it++)
						newsize += str_it->size () + 1;
					char *newdata = new char [newsize];
					for (ptr = newdata, str_it = newstrs.begin (); str_it != newstrs.end (); str_it++, ptr += strlen (ptr) + 1)
						strcpy (ptr, str_it->c_str ());
					m_pBase->ReplaceAttr (id, IDD_PREANNOINTEREST, newdata, newsize);
					delete []newdata;
				}				
			}
			break;
		}

        return;
	}

    // IDD_DIV, Класс
    if( *action.name().begin() == s_Class ) {
        switch( action.command() ) {
        // Класс
        case ChangeAction::ctAdd:
            {
                add_string(docId, (*action.value().begin()).c_str(), IDD_DIV);
                add_str_index(IDD_DIV, (*action.value().begin()).c_str(), docId);
            }
            break;
        // Класс
        case ChangeAction::ctRemove:
            {
                remove_string(docId, (*action.value().begin()).c_str(), IDD_DIV);
                del_str_index(IDD_DIV, (*action.value().begin()).c_str(), docId, 0);
            }
            break;
        default:
            fprintf(m_pLogFile, "Error: for Class you able use only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

    if( *action.name().begin() == s_Handmask) {
        switch( action.command() ) {
	        case ChangeAction::ctAdd:
                add_string(docId, (*action.value().begin()).c_str(), IDD_HANDHANDMASK);
	            break;
		    case ChangeAction::ctRemove:
                remove_string(docId, (*action.value().begin()).c_str(), IDD_HANDHANDMASK);
	            break;
		}
		return;
	}

    // IDD_KEY, Ключевые слова
    if( *action.name().begin() == s_Keyword ) {
        switch( action.command() ) {

        case ChangeAction::ctAdd:
            {
                add_string(docId,
                        (*action.value().begin()).c_str(), IDD_KEY);
                add_str_index(IDD_KEY,
                        (*action.value().begin()).c_str(), docId);
            }
            break;

        case ChangeAction::ctRemove:
            {
                remove_string(docId,
                        (*action.value().begin()).c_str(), IDD_KEY);
                del_str_index(IDD_KEY,
                        (*action.value().begin()).c_str(), docId, 0);
            }
            break;
        default:
            fprintf(m_pLogFile,
                    "Error: for Keyword you able "\
                    "use only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

    // IDD_SERVICEINFO
    if( *action.name().begin() == s_ServiceInfo) {
        switch( action.command() ) {

        case ChangeAction::ctAdd:
            {
                if (add_string(docId, (*action.value().begin()).c_str(), IDD_SERVICEINFO, CLASS_KEY_SIZE))
					add_str_index(IDD_SERVICEINFO, (*action.value().begin()).c_str(), docId);
            }
            break;

        case ChangeAction::ctRemove:
            {
                remove_string(docId, (*action.value().begin()).c_str(), IDD_SERVICEINFO);
                del_str_index(IDD_SERVICEINFO, (*action.value().begin()).c_str(), docId, 0);
            }
            break;

		case ChangeAction::ctChange:
			if (docId==0) {
				std::map<std::string,std::string> map_replaces;
				for (std::list<std::string>::iterator i = action.value().begin(); i != action.value().end(); i++) {
					char *str = strdup (i->c_str ()), *deli = strchr (str, '|');
					if (!deli)
						continue;
					*deli = 0; deli++;
					map_replaces.insert (std::map<std::string,std::string>::value_type (str, deli));
					free (str);
				}
				for (int i = 0; i < allTopic->ItemCount; i++) {
					long id = (*allTopic) [i], size = 0;
					char *serviceinfo = (char*) m_pBase->LoadAttr (id, IDD_SERVICEINFO, size), *ptr = serviceinfo;
					if (!size)
						continue;
					std::deque<std::string> oldstrs;
					while (ptr - serviceinfo < size) {
						oldstrs.push_back (ptr);
						ptr += strlen (ptr) + 1;
					}
					gk_free (serviceinfo);
					std::deque<std::string> newstrs;
					std::deque<std::string>::const_iterator str_it;
					bool gchg = false;
					for (str_it = oldstrs.begin (); str_it != oldstrs.end (); str_it++) {
						char* old = strdup (str_it->c_str ()), *deli = strchr (old, ':');
						*deli = 0; deli++;
						long sub = atol (old);
						bool chg = false;
						for (std::map<std::string,std::string>::const_iterator map_it = map_replaces.begin (); map_it != map_replaces.end (); map_it++) {
							const char* replace_from = map_it->first.c_str ();
							if (strstr (deli, replace_from) == deli) {
								char newstr [2048];
								strcat (strcat (strcpy (newstr, old), ":"), map_it->second.c_str ());
								if (strcmp (deli, replace_from))
									strcat (newstr, deli + strlen (replace_from));
								newstrs.push_back (newstr);
								Ref ref = {id, sub};
								del_str_index (IDD_SERVICEINFO, deli, ref);
								add_str_index (IDD_SERVICEINFO, strchr (newstr, ':') + 1, ref);
								chg = gchg = true;
								break;
							}
						}
						if (!chg)
 							newstrs.push_back (*str_it);
						gk_free (old);
					}
					if (gchg) {
						long newsize = 0;
						for (str_it = newstrs.begin (); str_it != newstrs.end (); str_it++)
							newsize += str_it->size () + 1;
						char *newdata = new char [newsize];
						for (ptr = newdata, str_it = newstrs.begin (); str_it != newstrs.end (); str_it++, ptr += strlen (ptr) + 1)
							strcpy (ptr, str_it->c_str ());
						m_pBase->ReplaceAttr (id, IDD_SERVICEINFO, newdata, newsize);
						delete []newdata;
					}
				}				
			}
			break;

        default:
            fprintf(m_pLogFile, "Error: for ServiceInfo you able use only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

    // IDD_TERRITORY, Территория
    if( *action.name().begin() == s_Territory ) {
        switch( action.command() ) {

        case ChangeAction::ctAdd:
            {
                add_string(docId,
                        (*action.value().begin()).c_str(), IDD_TERRITORY);
                add_str_index(IDD_TERRITORY,
                        (*action.value().begin()).c_str(), docId);
            }
            break;

        case ChangeAction::ctRemove:
            {
                remove_string(docId,
                        (*action.value().begin()).c_str(), IDD_TERRITORY);
                del_str_index(IDD_TERRITORY,
                        (*action.value().begin()).c_str(), docId, 0);
            }
            break;
        default:
            fprintf(m_pLogFile,
                    "Error: for Territory you able "\
                    "use only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

    // IDD_DOCKIND, Префикс
    if( *action.name().begin() == s_DocKind ) {
        switch( action.command() ) {

        case ChangeAction::ctAdd:
            {
                add_string(docId,
                        (*action.value().begin()).c_str(), IDD_DOCKIND);
                add_str_index(IDD_DOCKIND,
                        (*action.value().begin()).c_str(), docId);
            }
            break;

        case ChangeAction::ctRemove:
            {
                remove_string(docId,
                        (*action.value().begin()).c_str(), IDD_DOCKIND);
                del_str_index(IDD_DOCKIND,
                        (*action.value().begin()).c_str(), docId, 0);
            }
            break;
        default:
            fprintf(m_pLogFile,
                    "Error: for DocKind you able "\
                    "use only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

    if( *action.name().begin() == s_Kind ) {
        switch( action.command() ) {

        case ChangeAction::ctAdd:
            {
                add_string(docId,
                        (*action.value().begin()).c_str(), IDD_KIND);
                add_str_index(IDD_KIND,
                        (*action.value().begin()).c_str(), docId);
            }
            break;

        case ChangeAction::ctRemove:
            {
                remove_string(docId,
                        (*action.value().begin()).c_str(), IDD_KIND);
                del_str_index(IDD_KIND,
                        (*action.value().begin()).c_str(), docId, 0);
            }
            break;

		case ChangeAction::ctChange:
			{
				Index* kind = m_pBase->FindIndex ("Kind");
				for (std::list<std::string>::const_iterator l = action.value().begin(); l != action.value().end(); l++) {
					std::string at_l = *l;
					GCL::StrVector from_to;
					boost::split (from_to, at_l, boost::is_any_of ("|"));
					if (from_to.size () != 2)
						continue;

					std::string from = from_to.at (0);
					std::string to = from_to.at (1);
					BTKEY key = kind->FullKey (from.c_str ());
					if (key) {
						Stream* str0 = kind->Index::OpenN (key, 0);
						char *data1 = 0;
						RefCollection refs;
						if (str0) {
							refs.Get (str0);
							kind->Close (str0);
						}
						kind->DelKey (key);
						HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) key;
						if (strrchr (to.c_str (), '\\')) {
							strcpy (hkey->text, strrchr (to.c_str (), '\\') + 1);
						} else {
							strcpy (hkey->text, to.c_str ());
						}
						str0 = kind->Index::OpenN (key, 0, 1);
						if (str0) {
							refs.Put (str0);
							kind->Close (str0);
						}
						DocCollection docs;
						docs.Merge (refs);
						for (int doc = 0; doc < docs.ItemCount; doc++) {
							long docid = docs [doc], size0 = 0;
							char *data = (char*) m_pBase->LoadAttr (docid, IDD_KIND, size0), *ptr = data;
							std::vector<std::string> new_strings;
							while (ptr - data < size0) {
								char* semipos = strchr (ptr, ':') + 1;
								if (strstr (semipos, from.c_str ()) == semipos) {
									char* sub = new char [semipos - ptr + 1];
									strncpy (sub, ptr, semipos - ptr);
									sub [semipos - ptr] = 0;

									std::string new_str (sub);
									delete [] sub;
									new_str += to;
									new_str += ptr + from.size () + (semipos - ptr);
									new_strings.push_back (new_str);
								} else {
									new_strings.push_back (ptr);
								}
								ptr += strlen (ptr) + 1;
							}
							gk_free (data);
							std::vector<std::string>::const_iterator str_it;
							for (str_it = new_strings.begin (), size0 = 0; str_it != new_strings.end (); str_it++)
								size0 += str_it->size () + 1;
							for (str_it = new_strings.begin (), data = new char [size0], ptr = data; str_it != new_strings.end (); str_it++, ptr += strlen (ptr) + 1)
								strcpy (ptr, str_it->c_str ());
							m_pBase->ReplaceAttr (docid, IDD_KIND, data, size0);
							delete []data;
						}
					}
				}
			}
			break;

		default:
            fprintf(m_pLogFile, "Error: for Kind you able use only add() or remove() commands\n");
            //fflush(m_pLogFile);
            break;
        }
        return;
    }

    fprintf(m_pLogFile,
            "Unsupported command - '%s'\n",
            (*action.name().begin()).c_str());
    //fflush(m_pLogFile);
}

///////////////////////////////////////////////////////////////////////////////

long    Context::check_condition(Condition &condition, long docId)
{
	long    retv = false;

	// Внутренний номер документа
	if( *condition.name().begin() == s_DocId ) {
		retv = (docId == ::atoi(condition.value().c_str()));
	} else
    // IDD_BASES, Сегменты, к которым принадлежит документ
    if( *condition.name().begin() == s_Belongs ) {
        short   segBuf [s_maxseg], segCount = get_belongs (docId, segBuf);
        long    seg, i;
        seg = ::atoi(condition.value().c_str());
        for (i = 0; i < segCount; i++) {
            if (segBuf[i] == seg ) {
                retv = true;
                break;
            }
        }
	} else
	if( *condition.name().begin() == s_Belongss ) {
		long    i;
		short   segBuf[s_maxseg], segCount = get_belongs (docId, segBuf);

		std::set<long> segs;
		char* in = strdup (condition.value().c_str());
		char*	token = strtok (in, ";");
		while (token) {
			segs.insert (atol (token));
			token = strtok (0, ";");
		}
		free (in);

		for(i = 0; i < segCount; i++) {
			if( segs.find (segBuf[i]) != segs.end () ) {
				retv = true;
				break;
			}
		}
	} else
	if( *condition.name().begin() == s_Respondents) {
		std::list<long> docs = get_docs (docId, REFTYPE_REFLIST);
		long doc_id = ::atoi(condition.value().c_str());
		for(std::list<long>::const_iterator i = docs.begin(); i != docs.end() && !retv; i++ )
			retv = ((*i) == doc_id);
	} else
	if (*condition.name().begin() == s_Date ) {
		long size = 0;
		date* dates = (date*) m_pBase->LoadAttr( docId, IDD_DATE, size );
		size /= sizeof( date );

		if ( size ) {
			date aDate;
			const char* sDate=strdup(condition.value().c_str());
			aDate.da_day = atol( sDate );
			aDate.da_mon = atol( strchr( sDate, '/' )+1);
			aDate.da_year= atol( strrchr( sDate, '/' )+1);
			free((void*)sDate);

			long result = 0;
			for ( int i = 0; i < size; i++ ) {
				retv = dateCMP( dates[i], aDate );
				if ( condition.operation() == Condition::otEqual && retv == 0 )
					result = 0;
				else
				if ( condition.operation() == Condition::otGreater && retv == 1 )
					result = 1;
				else
				if ( condition.operation() == Condition::otBelow && retv == -1 )
					result = 1;
			}
			gk_free( dates );
			return result;
		}
		return false;
	}
	else
	if (*condition.name().begin() == s_LastDate ) {
		std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
		if (map_it != map_doc_docinfo.end ()) {
			if (!map_it->second.LastDate.da_year )
				return 0;

			date aDate;
			const char* sDate=condition.value().c_str();
			aDate.da_day = atol( sDate );
			aDate.da_mon = atol( strchr( sDate, '/' )+1);
			aDate.da_year= atol( strrchr( sDate, '/' )+1);
			retv = dateCMP (map_it->second.LastDate, aDate );
			if ( condition.operation() == Condition::otEqual && retv == 0 )
				return 1;
			else
			if ( condition.operation() == Condition::otNotEqual && retv != 0 )
				return 1;
			else
			if ( condition.operation() == Condition::otGreater && retv == 1 )
				return 1;
			else
			if ( condition.operation() == Condition::otBelow && retv == -1 )
				return 1;
		}
		return 0;
	}
	else
    // Статус документа
    if ( *condition.name().begin() == s_Status ) {
		std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
		if (map_it != map_doc_docinfo.end ())
			retv = ((map_it->second.Status & ::atoi(condition.value().c_str())) != 0 );
    }
	else
    if ( *condition.name().begin() == s_Status_exex ) {
		std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
		if (map_it != map_doc_docinfo.end ())
			retv = (GetDocStatusExEx ((DocInfo*) &map_it->second) & ::atoi(condition.value().c_str())) != 0;
    }
	else
	if ( *condition.name().begin() == s_Active ) {
		long aSize = 0;
		void* aActive = m_pBase->LoadAttr( docId, IDD_ACTIVE, aSize );
		if ( ( aSize == 0 ) && ( ::atoi(condition.value().c_str()) == 0 ))
			retv = 1;
		else
			retv = 0;
	}

	else
	if( *condition.name().begin() == s_Name ) {
		if ( condition.operation() == Condition::otNotEqual) {
			retv = !find_string(docId, condition.value().c_str(), 0);
		}
		return retv;
	}
	else
	// Предупреждение
    if ( *condition.name().begin() == s_Warning ) {
		char aWarning[ 1024 ];
		int aSize = m_pBase->FindDocAttr(docId, IDD_WARNING, aWarning, 1024);
		if ( aSize ) retv = !strcmp( aWarning, condition.value().c_str() );
	}
	else
    // Юридическая сила документа
    if( *condition.name().begin() == s_InfoForce ) {
		std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
		if (map_it != map_doc_docinfo.end ())
			retv = (map_it->second.Force ==  ::atoi(condition.value().c_str()));
    }
	else
    // IDD_ID, Номер документа
    if( *condition.name().begin() == s_Id ) {
        retv = find_string(docId, condition.value().c_str(), IDD_ID);
    }
	else
    // IDD_PUBLISHEDIN, Источник опубликование
    if( *condition.name().begin() == s_PublishedIn ) {
        retv = find_string(docId, condition.value().c_str(), IDD_PUBLISHEDIN);
    }
	else
    // IDD_TYPE, Тип документа
    if( *condition.name().begin() == s_Type ) {
		if ( condition.operation() == Condition::otGreater || condition.operation() == Condition::otBelow ) {
			retv = find_notnot_string (docId, condition.value().c_str(), IDD_TYPE);
			return retv;
		} else {
	        retv = find_string (docId, condition.value().c_str(), IDD_TYPE);
		}
    }
    // IDD_TYPE, Тип документа
    if( *condition.name().begin() == s_FastType ) {
		if ( condition.operation() == Condition::otGreater || condition.operation() == Condition::otBelow ) {
			retv = fast_find_notnot_string (docId, condition.value().c_str(), IDD_TYPE);
			return retv;
		} else {
	        retv = fast_find_string (docId, condition.value().c_str(), IDD_TYPE);
		}
    }
	else
    // IDD_SOURCE, Орган, издавший документ
    if( *condition.name().begin() == s_Source ) {
        retv = find_string(docId, condition.value().c_str(), IDD_SOURCE);
    }
	else
    // IDD_SOURCE, Орган, издавший документ
    if( *condition.name().begin() == s_FastSource ) {
        retv = fast_find_string(docId, condition.value().c_str(), IDD_SOURCE);
    }
    // IDD_DIV, Раздел классификатора
    if( *condition.name().begin() == s_Class ) {
		if ( condition.operation() == Condition::otGreater || condition.operation() == Condition::otBelow ) {
			retv = find_notnot_string(docId, condition.value().c_str(), IDD_DIV);
			return retv;
		} else {
			retv = find_string(docId, condition.value().c_str(), IDD_DIV);
		}			
    }
	else
	// IDD_PREANNOTAX
    if( *condition.name().begin() == s_PreAnnoTax ) {
		if ( condition.operation() == Condition::otGreater || condition.operation() == Condition::otBelow ) {
			retv = find_notnot_string(docId, condition.value().c_str(), IDD_PREANNOTAX);
			return retv;
		} else {
			retv = find_string(docId, condition.value().c_str(), IDD_PREANNOTAX);
		}			
	}
	// IDD_PREANNOINTEREST
    if( *condition.name().begin() == s_PreAnnoInterest) {
		if ( condition.operation() == Condition::otGreater || condition.operation() == Condition::otBelow ) {
			retv = find_notnot_string(docId, condition.value().c_str(), IDD_PREANNOINTEREST);
			return retv;
		} else {
			retv = find_string(docId, condition.value().c_str(), IDD_PREANNOINTEREST);
		}			
	}

    // IDD_ANNOTAX
    if( *condition.name().begin() == s_AnnoTax ) {
		if ( condition.operation() == Condition::otGreater || condition.operation() == Condition::otBelow ) {
			retv = find_notnot_string(docId, condition.value().c_str(), IDD_ANNOTAX);
			return retv;
		} else {
			retv = find_string(docId, condition.value().c_str(), IDD_ANNOTAX);
		}			
    }
	else
    // IDD_DIV, Раздел классификатора
    if( *condition.name().begin() == s_FastClass ) {
		if ( condition.operation() == Condition::otGreater || condition.operation() == Condition::otBelow ) {
			retv = fast_find_notnot_string(docId, condition.value().c_str(), IDD_DIV);
			return retv;
		} else {
			retv = fast_find_string(docId, condition.value().c_str(), IDD_DIV);
		}			
    }
	else
    // IDD_CATEGORY, Норма
    if( *condition.name().begin() == s_Norm ) {
		retv = find_string(docId, condition.value().c_str(), IDD_CATEGORY);
    }
	else
    // IDD_SERVICEINFO
    if( *condition.name().begin() == s_ServiceInfo ) {
        retv = find_string(docId, condition.value().c_str(), IDD_SERVICEINFO);
    }
	else
    // IDD_KEY, Ключевые слова
    if( *condition.name().begin() == s_Keyword ) {
        retv = find_string(docId, condition.value().c_str(), IDD_KEY);
    }
	else
    // IDD_TERRITORY, Территория
    if( *condition.name().begin() == s_Territory ) {
        retv = find_string(docId, condition.value().c_str(), IDD_TERRITORY);
    }
	else
    // IDD_DOCKIND, Префикс
    if( *condition.name().begin() == s_DocKind ) {
        retv = find_string(docId, condition.value().c_str(), IDD_DOCKIND);
    }
	else
    // IDD_KIND, ВидИнформации
    if( *condition.name().begin() == s_Kind ) {
        retv = find_string(docId, condition.value().c_str(), IDD_KIND);
    }

	if ( condition.operation() == Condition::otEqual )
		return retv;
	else
		return !retv;
}

///////////////////////////////////////////////////////////////////////////////

long    Context::fast_find_string (long docId, const char *str, long tag)
{
	long    retv, bufLen, strLength, bufLenCopy;
	char    *pBuf;

	retv = false;

	if (!tag)
		bufLen = m_pBase->FindDocName (docId, buf);
	else {
		std::map<long,void*>::const_iterator map_it = map_tag_data.find (tag);
		if (map_it == map_tag_data.end ()) {
			bufLen = m_pBase->FindDocAttr (docId, tag, buf, s_bufsize);
			if (bufLen) {
				void* data = malloc (bufLen);
				memcpy (data, buf, bufLen);
				map_tag_data.insert (std::map<long,void*>::value_type (tag, data));
				map_tag_datasize.insert (std::map<long,long>::value_type (tag, bufLen));
			}
		} else {
			bufLen = map_tag_datasize.find (tag)->second;
			memcpy (buf, map_tag_data.find (tag)->second, bufLen);
		}
	}

	bufLenCopy = bufLen;
	if( bufLen ) {
		int len = strlen (str) + 1;
		char*	in = (char*) malloc (len);
		memcpy (in, str, len);
		char*	token = strtok (in, ";");

		while (token && !retv) {
	        pBuf = buf;
			while( bufLen ) {
				if( ::strstr(pBuf, token) ) {
					retv = true;
					break;
				}
				//заменяем " на '
				strLength = ::strlen(pBuf) + 1;
				bool changed = false;
				for (int i = 0; i < strLength - 1; i++)
					if (pBuf[i] == '"') {
						changed = true;
						pBuf[i] = '\'';
					}
				if( changed && ::strstr(pBuf, token) ) {
					retv = true;
					break;
				}
				bufLen -= strLength;
				pBuf += strLength;
			}
			token = strtok (0, ";");
			bufLen = bufLenCopy;
		}
		gk_free (in);
	}

	return retv;
}

long    Context::find_string (long docId, const char *str, long tag)
{
	long    retv, bufLen, strLength, bufLenCopy;
	char    *pBuf;

	retv = false;

	if (!tag)
		bufLen = m_pBase->FindDocName (docId, buf);
	else
		bufLen = m_pBase->FindDocAttr(docId, tag, buf, s_bufsize);
	bufLenCopy = bufLen;
	if( bufLen ) {
		int len = strlen (str) + 1;
		char*	in = (char*) malloc (len);
		memcpy (in, str, len);
		char*	token = strtok (in, ";");

		while (token && !retv) {
	        pBuf = buf;
			while( bufLen ) {
				if( ::strstr(pBuf, token) ) {
					retv = true;
					break;
				}
				//заменяем " на '
				strLength = ::strlen(pBuf) + 1;
				bool changed = false;
				for (int i = 0; i < strLength - 1; i++)
					if (pBuf[i] == '"') {
						changed = true;
						pBuf[i] = '\'';
					}
				if( changed && ::strstr(pBuf, token) ) {
					retv = true;
					break;
				}
				bufLen -= strLength;
				pBuf += strLength;
			}
			token = strtok (0, ";");
			bufLen = bufLenCopy;
		}
		gk_free (in);
	}

	return retv;
}

long    Context::fast_find_notnot_string(long docId, const char *str, long tag)
{
	// в str - строки, разделенные ;
	// правило следующее - если в атрибуте есть строка, не равная ни одной из переданных, то true
    long    retv, bufLen, strLength;
    char    *pBuf;

    retv = false;
	std::map<long,void*>::const_iterator map_it = map_tag_data.find (tag);
	if (map_it == map_tag_data.end ()) {
		bufLen = m_pBase->FindDocAttr (docId, tag, buf, s_bufsize);
		if (bufLen) {
			void* data = malloc (bufLen);
			memcpy (data, buf, bufLen);
			map_tag_data.insert (std::map<long,void*>::value_type (tag, data));
			map_tag_datasize.insert (std::map<long,long>::value_type (tag, bufLen));
		}
	} else {
		bufLen = map_tag_datasize.find (tag)->second;
		memcpy (buf, map_tag_data.find (tag)->second, bufLen);
	}
    if( bufLen ) {
        pBuf = buf;
        while( bufLen ) {
			char* newstr = strdup( str );
			int eqs = 0;
			char*	aDelimiters = ";";
			char*	aToken = strtok( newstr, aDelimiters );
			while( ( aToken != 0 ) && !eqs ) {
				if ( ::strstr( aToken, pBuf ))
					eqs++;
				aToken = strtok( 0, aDelimiters );
			}
			free( newstr );
			if ( !eqs ) {
				retv = true;
				break;
			}
            strLength = ::strlen(pBuf) + 1;
            bufLen -= strLength;
            pBuf += strLength;
        }
    }

    return retv;
}

long    Context::find_notnot_string(long docId, const char *str, long tag)
{
	// в str - строки, разделенные ;
	// правило следующее - если в атрибуте есть строка, не равная ни одной из переданных, то true
    long    retv, bufLen, strLength;
    char    *pBuf;

    retv = false;
    bufLen = m_pBase->FindDocAttr(docId, tag, buf, s_bufsize);
    if( bufLen ) {
        pBuf = buf;
        while( bufLen ) {
			char* newstr = strdup( str );
			int eqs = 0;
			char*	aDelimiters = ";";
			char*	aToken = strtok( newstr, aDelimiters );
			while( ( aToken != 0 ) && !eqs ) {
				if ( ::strstr( aToken, pBuf ))
					eqs++;
				aToken = strtok( 0, aDelimiters );
			}
			free( newstr );
			if ( !eqs ) {
				retv = true;
				break;
			}
            strLength = ::strlen(pBuf) + 1;
            bufLen -= strLength;
            pBuf += strLength;
        }
    }

    return retv;
}

///////////////////////////////////////////////////////////////////////////////

bool    Context::add_string(long docId, const char *str, long tag, long key_size)
{
    long    bufLength;
	bool	valid = true;
	if (key_size) {
		char *ptr = (char*) strchr (str, ':')+1, *slash_pos = strchr (ptr, '\\');
		while (slash_pos && valid) {
			if (slash_pos-ptr >= key_size)
				valid = false;
			ptr = slash_pos + 1;
			slash_pos = strchr (ptr, '\\');
		}
		if (::strlen (ptr) >= key_size)
			valid = false;
	}
	if (!valid) {
		fprintf(m_pLogFile, "\tERROR: invalid key length\n");
		//fflush (m_pLogFile);
		return false;
	}

    bufLength = m_pBase->FindDocAttr(docId, tag, buf, s_bufsize);

    if( bufLength ) {
        char    *pBuf;
        char    **strings;
        long    i, strCount, flagFound;

        strCount = 0;
        for(i = 0; i < bufLength; i++) {
            if( buf[i] == 0 )
                strCount++;
        }

        strings = new char *[strCount];

        flagFound = false;
        pBuf = buf;
        for( i = 0; i < strCount; i++ ) {
            strings[i] = ::strdup(pBuf);
            pBuf += (::strlen(strings[i]) + 1);
            if( ::strcmp(strings[i], str) == 0 ) {
                flagFound = true;
            }
        }

        if( !flagFound ) {
            pBuf = buf + bufLength;
			::memcpy(pBuf, str, ::strlen(str) + 1);
			bufLength += ::strlen (pBuf)+1;
            m_pBase->ReplaceAttr(docId, tag, &buf, bufLength);
			change_doc_revision( docId );
            fprintf(m_pLogFile, "\tok\n");
        } else {
            fprintf(m_pLogFile, "\talready exist\n");
        }

        delete []strings;
    } else {
        m_pBase->PutAttr(docId, tag, str, ::strlen(str) + 1);
		change_doc_revision( docId );
		fprintf(m_pLogFile, "\tcreate stream\n");
    }
	return true;
}

///////////////////////////////////////////////////////////////////////////////

void    Context::remove_string(long docId, const char *str, long tag)
{
    long    bufLength;

    bufLength = m_pBase->FindDocAttr(docId, tag, buf, s_bufsize);

    if( bufLength ) {
        char    *pBuf;
        char    **strings;
        long    strLength, i, strCount, flagFound, iRemove;

        strCount = 0;
        for( i = 0; i < bufLength; i++ ) {
            if( buf[i] == 0 ) {
                strCount++;
            }
        }

        strings = new char *[strCount];

        flagFound = false;
        pBuf = buf;
        for( i = 0; i < strCount; i++ ) {
            strings[i] = ::strdup(pBuf);
            pBuf += (::strlen(strings[i]) + 1);
            if( ::strcmp(strings[i], str) == 0 ) {
                flagFound = true;
                iRemove = i;
            }
        }

        // Если нашли то удаляем
        if( flagFound ) {
            pBuf = buf;
            for( i = 0; i < strCount; i++ ) {
                if( iRemove != i ) {
                    strLength = ::strlen(strings[i]);
                    ::memcpy(pBuf, strings[i], strLength + 1);
                    pBuf += (strLength + 1);
                } else {
                    bufLength -= (::strlen(strings[i]) + 1);
                }
            }
            if( bufLength ) {
                m_pBase->ReplaceAttr(docId, tag, &buf, bufLength);
                fprintf(m_pLogFile, "\tok\n");
            } else {
                ((AttrIndex*)m_pBase->FindIndex("Attrs"))->Del(docId, tag);
                fprintf(m_pLogFile, "\tstream empty\n");
            }
			change_doc_revision( docId );
        } else {
            fprintf(m_pLogFile, "\tnothing to remove\n");
        }

        delete []strings;
    }

}

///////////////////////////////////////////////////////////////////////////////

void    Context::sort_baseinfo(BaseInfo *pBaseInfo, long count)
{
    long    i, flgSorted;

    flgSorted = false;

    while( !flgSorted ) {
        flgSorted = true;
        for( i = 0; i < count - 1; i++ ) {
            if( pBaseInfo[i].BaseId > pBaseInfo[i + 1].BaseId ) {
                BaseInfo    baseInfo;
                baseInfo = pBaseInfo[i];
                pBaseInfo[i] = pBaseInfo[i + 1];
                pBaseInfo[i + 1] = baseInfo;
                flgSorted = false;
            }
        }
    }
}

///////////////////////////////////////////////////////////////////////////////

void    Context::sort_here(short *pHere, long count)
{
    long    i, flgSorted;

    flgSorted = false;

    while( !flgSorted ) {
        flgSorted = true;
        for( i = 0; i < count - 1; i++ ) {
            if( pHere[i] > pHere[i + 1] ) {
                short   here;
                here = pHere[i];
                pHere[i] = pHere[i + 1];
                pHere[i + 1] = here;
                flgSorted = false;
            }
        }
    }
}

///////////////////////////////////////////////////////////////////////////////

void    Context::set_gl(long flag)
{
    if( flag && m_needGl ) {
        m_pBase->SetReady (TID_GCHANGE);
    }
}

///////////////////////////////////////////////////////////////////////////////

void    Context::recalc_bases (void)
{
    std::list<short>::iterator i;
    long jj, j, l, docId, k, seg, proc = -1;
    short hereCount, *pHere;
    Stream *pStream;

    m_calcBases.sort();
    m_calcBases.unique();

    printf("\n");

    pStream = m_pBase->FindIndex("Aux")->Open("Here");
    hereCount = pStream->Length() / sizeof(short);
    pHere = new short[hereCount];
    pStream->Read( pHere, hereCount * sizeof(short) );
    m_pBase->FindIndex("Aux")->Close(pStream);

	//if ( !allTopic ) allTopic = m_pBase->AllTopics(ID_BORDER);
		
    if ( m_calcBases.size() ) {
	    printf("Recalc baseinfos...\n");

		BaseInfo	*baseInfos = new BaseInfo[ MAX_BASES ];
		DocCollection* docs = new DocCollection[ m_calcBases.size() ];
		
		for( k = 0; k < hereCount; k++ )
			m_pBase->FindBaseInfo(pHere[k], baseInfos[pHere[k]]);

		for ( i = m_calcBases.begin(); i != m_calcBases.end(); i++ ) {
			seg = *i;
	       	m_pBase->FindBaseInfo(seg, baseInfos[seg]);
			baseInfos[seg].GreenComments  = 0;
			baseInfos[seg].HyperRefs      = 0;
			baseInfos[seg].RecCount       = 0;
			baseInfos[seg].RecSize        = 0;
			baseInfos[seg].DocCount       = 0;
			baseInfos[seg].DocSize        = 0;
			baseInfos[seg].CommonDocCount = 0;
			baseInfos[seg].CommonDocSize  = 0;
			baseInfos[seg].FormsCount     = 0;
			/*
			baseInfos[seg].FormsSize      = 0;
			baseInfos[seg].CommentsCount  = 0;
			baseInfos[seg].CommentsSize   = 0;
			baseInfos[seg].ProjectCount   = 0;
			baseInfos[seg].ProjectSize    = 0;
			baseInfos[seg].PractikCount   = 0;
			baseInfos[seg].PractikSize    = 0;
			baseInfos[seg].InterCount     = 0;
			baseInfos[seg].InterSize      = 0;
			baseInfos[seg].QuestionCount  = 0;
			baseInfos[seg].QuestionSize   = 0;
			baseInfos[seg].BReferCount    = 0;
			baseInfos[seg].BReferSize     = 0;
			*/
		}

		for( j = 0; j < allTopic->ItemCount; j++ ) {
			if(((j + 1) * 100) / allTopic->ItemCount > proc)
				printf("%d%%\r", (proc= ((j + 1) * 100) / allTopic->ItemCount));

			docId = allTopic->GetItem(j);

			std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
			if (map_it == map_doc_docinfo.end ())
				continue;

		    short segBuf [s_maxseg], segCount = get_belongs (docId, segBuf);
			long flagFound;       
			for ( jj= 0, i = m_calcBases.begin(); i != m_calcBases.end(); i++, jj++ ) {
				seg = *i;
				flagFound = false;

				for( l = 0; l < segCount; l++) {
					if( segBuf[l] == seg ) {
						flagFound = true;
						break;
					}
				}

				// Документ docId принадлежит обрабатываемому сегменту
				if( flagFound ) {
					docs[jj].Collection::Add( &docId );

					baseInfos[seg].RecSize       += map_it->second.Size;
					baseInfos[seg].GreenComments += map_it->second.GreenComments;
					baseInfos[seg].HyperRefs     += map_it->second.HyperRefs;
        
					if ((map_it->second.Status & DS_DOC) || (map_it->second.Status_ex & DS_FLASH) || (map_it->second.Status_ex & DS_MEDTOPIC)) {
						baseInfos[seg].CommonDocCount++;
						baseInfos[seg].CommonDocSize += map_it->second.Size;
					}

					// Количество топиков
					baseInfos[seg].RecCount++;
				}
			}

			if (map_doc_docinfo.size () > 1000000) {
				fprintf (m_pLogFile, "! warning, clear docinfo map !\n");
				map_doc_docinfo.clear ();
			}
			if (map_doc_belongs.size () > 1000000) {
				fprintf (m_pLogFile, "! warning, clear belongs map !\n");

				for (std::map<long,short*>::iterator map_it = map_doc_belongs.begin (); map_it != map_doc_belongs.end (); map_it++)
					delete [] map_it->second;
				map_doc_belongs.clear ();
				map_doc_belongscount.clear ();
			}
		}

		// заполнить UserInfoTopic и т.д.
		// у каждого из baseInfos из Here берем *Topic, и если он есть в списке топиков добавляемого сегмента
		for ( jj = 0, i = m_calcBases.begin(); i != m_calcBases.end(); i++, jj++ ) {
			seg = *i;
			/*
			for( k = 0; k < hereCount; k++ )
				if ( docs[jj].IndexOf( &baseInfos[pHere[k]].AccountTopic ) != -1 ) {
					baseInfos[ seg ].AccountTopic = baseInfos[pHere[k]].AccountTopic;
					break;
				}

			for( k = 0; k < hereCount; k++ )
				if ( docs[jj].IndexOf( &baseInfos[pHere[k]].UserInfoTopic ) != -1 ) {
					baseInfos[ seg ].UserInfoTopic = baseInfos[pHere[k]].UserInfoTopic;
					break;
				}

			for( k = 0; k < hereCount; k++ )
				if ( docs[jj].IndexOf( &baseInfos[pHere[k]].BusinessTopic ) != -1 ) {
					baseInfos[ seg ].BusinessTopic = baseInfos[pHere[k]].BusinessTopic;
					break;
				}
			*/

			for( k = 0; k < hereCount; k++ )
				if ( docs[jj].IndexOf( &baseInfos[pHere[k]].SplashTopic ) != -1 ) {
					baseInfos[ seg ].SplashTopic = baseInfos[pHere[k]].SplashTopic;
					break;
				}
			for( k = 0; k < hereCount; k++ )
				if ( docs[jj].IndexOf( &baseInfos[pHere[k]].BannerTopic ) != -1 ) {
					baseInfos[ seg ].BannerTopic = baseInfos[pHere[k]].BannerTopic;
					break;
				}
		}

		for ( i = m_calcBases.begin(); i != m_calcBases.end(); i++ ) {
			seg = *i;
		    fprintf(m_pLogFile, "BaseInfo[%d]: CommonDocCount: %ld, RecCount: %ld\n", seg, baseInfos[seg].CommonDocCount, baseInfos[seg].RecCount );
			m_pBase->ReplaceBaseInfo(seg, &baseInfos[seg]);
		}

		delete baseInfos;
	}

    delete pHere;
}

///////////////////////////////////////////////////////////////////////////////

list<long> get_docs_docs, get_docs_blobs;
long last_get_docs_id = 0;
long last_get_blobs_id = 0;

list<long> Context::get_docs(long docId, long refType, bool b_slow)
{
    list<long> docList;
    Document *doc;
    long i, j, len, nref, curRefType, iref;
    char *para, *paraText;
    Ref *ref;

	if (refType == REFTYPE_BLOB) {
		if (docId == last_get_blobs_id)
			return get_docs_blobs;
	} else {
		if (docId == last_get_docs_id)
			return get_docs_docs;
	}

	if (refType == REFTYPE_BLOB) {
		last_get_blobs_id = docId;
		if (b_slow) {
			doc = m_pBase->GetDoc (docId);

			EndtTools::EndtParser obj (m_pBase);
			EndtTools::LongVector *refs = obj.get_resp_documents (doc, true);
			if ( refs->size()) {
				EndtTools::LongVector::const_iterator it = refs->begin();
				for ( ; it != refs->end(); it++ ) {
					long docid = *it;
					if (blob_keys.find (docid) != blob_keys.end ()) {
						std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docid);
						if (map_it != map_doc_docinfo.end ()) {
							if (!(map_it->second.Status_ex & DS_FLASH))
								docList.push_back (docid );
						} else docList.push_back (docid );
					}
				}
			}
			delete refs;

			long blobs_size;
			char *blobs = (char*) m_pBase->LoadAttr (docId, IDD_BLOBS, blobs_size), *ptr = blobs;
			if (blobs_size) {
				u_int32_t ss = 0;
				std::set<long> processed_paras;
				BlobInfo* bi;
				long plus = sizeof (bi->Para) + sizeof (bi->type);
				while (ss < blobs_size) {
					bi = (BlobInfo*) ptr;
					char* text = ptr + plus;
					long lpara = bi->Para;
					if (processed_paras.find (lpara) == processed_paras.end ()) {
						processed_paras.insert (lpara);
						char* para = doc->GetPara (lpara);
						if (doc->EVDFlags (para) & ENDT_HAS_BMP) {
							para = ParaText (para) + ENDT_FLAGS_LEN + ENDT_CP_LEN;
							docList.push_back (*(long*)para);
						}
					}
					u_int32_t textlen = strlen (text) + 1;
					ss += textlen + plus;
					ptr = text + textlen;
				}
				gk_free (blobs);
			}
			delete doc;
		} else {
			std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
			if ((map_it != map_doc_docinfo.end ()) && (map_it->second.Status & DS_EVD)) {
				long size, *data = (long*) m_pBase->LoadAttr (docId, IDD_BLOB, size), *ptr = data;
				if (size) {
					for (int i = 0; i < size / sizeof (long); i++, ptr++)
						docList.push_back (*ptr);
					gk_free (data);
				}
			}
		}
		get_docs_blobs = docList;
	} else {
		last_get_docs_id = docId;
		std::map<long,DocInfo>::const_iterator map_it = get_doc_info (docId);
		if (map_it != map_doc_docinfo.end ()) {
			if (map_it->second.Status & DS_EVD) {
				if (map_it->second.Status & DS_NODOC) {
					doc = m_pBase->GetDoc (docId);
					EndtTools::EndtParser obj (m_pBase);
					EndtTools::LongVector *refs = obj.get_resp_documents (doc, true);
					if ( refs->size()) {
						EndtTools::LongVector::const_iterator it = refs->begin();
						for ( ; it != refs->end(); it++ ) {
							long _id = *it;
							if (get_doc_info (_id) != map_doc_docinfo.end ())
								docList.push_back (_id);
						}
					}
					delete refs;
					delete doc;
				} else {
					long lRefs;
					RespRef* iddrefs = (RespRef*) m_pBase->LoadAttr( docId, IDD_REFS, lRefs );
					lRefs = lRefs / sizeof( RespRef );
					for ( i = 0; i < lRefs; i++ )
						docList.push_back( iddrefs[i].DocId );
					gk_free (iddrefs);
				}
			} else {
				doc = m_pBase->GetDoc (docId);
				for (j = 0; j < doc->Stat.ParaCount; j++) {
					para = doc->GetPara (j);
					paraText = ParaText (para);
					len = TextSize (para);

					for (i = 0; i < len; ) {
						if (paraText[i] == AT_XREF) {
							i++;
							while ( i < len && paraText[i] != AT_XREF )
								i++;
							if ( i < len ) {
								curRefType = paraText[i + 1];
								nref = *((short *)(paraText + i + 2));
								nref = (nref > 0) ? nref : 1;
								i += 4;
								for ( iref = 0; iref < nref; iref++, i += sizeof( Ref )) {
									ref = (Ref *)(paraText + i);
									if (curRefType == refType)
										docList.push_back (ref->DocId);
								}
							}
						} else {
							i++;
						}
					}
				}
				delete doc;
			}
		}
		get_docs_docs = docList;
	}

    return docList;
}

void	Context::change_doc_revision( long docId )
{
	if ( changedocrevision ) {
		std::map<long,DocInfo>::iterator map_it = get_doc_info (docId);
		if (map_it == map_doc_docinfo.end ())
			return;
		map_it->second.Revision = rrevision;
		if (!b_readonly) m_pBase->ReplaceAttr (docId, IDD_INFO, &map_it->second, sizeof(DocInfo));
	}
}

void	Context::set_baseinfo_revision (revision r)
{
	baseinfo_revision = r;
}

std::map<long, DocInfo>::iterator Context::get_doc_info (long docid)
{
	if (allTopic->IndexOf (&docid) == -1)
		return map_doc_docinfo.end ();
	else {
		std::map<long,DocInfo>::iterator map_it = map_doc_docinfo.find (docid);
		if (map_it == map_doc_docinfo.end ()) {
			DocInfo docinfo;
			m_pBase->FindDocInfo (docid, docinfo);
			map_doc_docinfo.insert (std::map<long,DocInfo>::value_type (docid, docinfo));
			map_it = map_doc_docinfo.find (docid);
		}
		return map_it;
	}
}

short	Context::get_belongs (long id, void* buf)
{
	short result;
	std::map<long,short*>::const_iterator map_it = map_doc_belongs.find (id);
	if (map_it == map_doc_belongs.end ()) {
		result = m_pBase->FindDocAttr (id, IDD_BASES, buf, s_bufsize);
		result /= sizeof (short);
		short* segs = new short [result];
		memcpy (segs, buf, result * sizeof (short));
		map_doc_belongs.insert (std::map<long,short*>::value_type (id, segs));
		map_doc_belongscount.insert (std::map<long,short>::value_type (id, result));
	} else {
		result = map_doc_belongscount.find (id)->second;
		memcpy (buf, map_it->second, result * sizeof (short));
	}
	return result;
}

void	Context::put_belongs (long id, void* buf, short count)
{
	std::map<long,short*>::iterator map_it = map_doc_belongs.find (id);
	if (map_it != map_doc_belongs.end ()) {
		delete [] map_it->second;
		map_it->second = new short [count];
		memcpy (map_it->second, buf, count * sizeof (short));
		if (!b_readonly) m_pBase->ReplaceAttr (id, IDD_BASES, buf, count * sizeof (short));
		map_doc_belongscount [id] = count;
	} else {
		fprintf (m_pLogFile, "! error in put_belongs for %ld !\n", id);
	}
}

///////////////////////////////////////////////////////////////////////////////

void	Context::blob_add_belongs (long id, short segment)
{
	if (b_readonly)
		return ;
	
	Index *indBlob = m_pBase->FindIndex ("Blob");
	Stream *pStream = indBlob->OpenN (&id, 1);
	if (pStream) {
		long    segCount, j, segFound;
		short   *pSeg;

		segCount = pStream->Length() / sizeof(short);
		pSeg = new short[segCount + 1];
		segFound = false;
		pStream->Read(pSeg, segCount * sizeof(short));

		bool in_exclude = false;

		for (j = 0; j < segCount && !in_exclude; j++) {
			if (pSeg[j] == segment)
				segFound = true;
			if (exclude_belongs.find (pSeg [j]) != exclude_belongs.end ())
				in_exclude = true;
		}

		if (in_exclude) {
			fprintf (m_pLogFile, "\tBlob содержит exclude_segment\n");
		} else if (!segFound) {
			pSeg [segCount] = segment;
			sort_here (pSeg, segCount + 1);
			pStream->Seek (0);
			pStream->Write (pSeg, sizeof(short) * (segCount + 1));
		} else {
			fprintf (m_pLogFile, "\tBlob Already exists\n");
		}
            
		indBlob->Close(pStream);
		delete [] pSeg;
	}
}

void	Context::blob_del_belongs (long id, short segment)
{
	if (b_readonly)
		return;

	if (b_readonly)
		return ;
	
	Index *indBlob = m_pBase->FindIndex ("Blob");
	Stream *pStream = indBlob->OpenN (&id, 1);            
	if(pStream) {
		long    segCount, j, segFound;
		short   *pSeg;

        segCount = pStream->Length() / sizeof(short);
        pSeg = new short[segCount];
        segFound = false;
        pStream->Read(pSeg, segCount * sizeof(short));

        for( j = 0; j < segCount; j++ )
			if( pSeg[j] == segment ) {
                segFound = true;
				break;
			}

        if (segFound) {
            for( ; j < segCount - 1; j++ )
                pSeg[j] = pSeg[j + 1];

			pStream->Seek(0);
			pStream->Write(pSeg, (segCount - 1) * sizeof(short));
			pStream->Trunc();
	    } else {
		    fprintf(m_pLogFile, "\tNothing to remove\n");
		}
            
		indBlob->Close(pStream);
		delete [] pSeg;
	}
}
