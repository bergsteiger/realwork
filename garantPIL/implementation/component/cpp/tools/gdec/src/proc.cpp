#include "shared/Core/fix/mpcxc.h"
#include "ace/ACE.h"

#include "shared/GCL/str/str_conv.h"
#include "garantPIL/implementation/component/cpp/libs/endt/Common.h"

#include "btiter.h"
#include "main.h"

void	change_slashes (char* name) {
	mpcxc_strtolower (name, strlen(name));
#ifdef	__FreeBSD__
	if (name) for (int i = 0; i < strlen (name); i++)
		if (name [i] == '\\')
			name [i] = '/';
#endif
}

Month Months [] = {
	{31, "Январь"},
	{28, "Февраль"},
	{31, "Март"},
	{30, "Апрель"},
	{31, "Май"},
	{30, "Июнь"},
	{31, "Июль"},
	{31, "Август"},
	{30, "Сентябрь"},
	{31, "Октябрь"},
	{30, "Ноябрь"},
	{31, "Декабрь"},
};

std::set<long>	relateds;

int tst_atoi(const char *pS, unsigned nxt)
{
	if(::strlen(pS) > nxt)
		return ::atoi(pS+nxt);
	return 0;
}

const int make_file_dir (char* name) {
    int retv = 0;

    if (name) {
		int i = ACE_OS::strlen (name) - 1;

		while (i > 0) {
			if (name [i] == '/' || name [i] == '\\') {
				char ch = name [i];
				name [i] = 0;

				if (ACE_OS::strlen (name)) {
					retv = (ace_os_mkdir (name) == 0) ? 1 : 0;
				}
				name [i] = ch;
				break;
			}
			--i;
		}
	}
	return retv;
}

const int erase_cat_files (const char* name) {
    FILE* out = 0;
    int retv = 0;

	FILE_aptr cat = mpcxc_fopen (name, "r");

	if (cat.ptr ()) {
		while (!feof (cat.ptr ())) {
			if (ACE_OS::fgets (buf, BSIZE, cat.ptr ())) {
				size_t len = ACE_OS::strlen (buf);
				if (len >= 1) {
					buf [len - 1] = 0;

					make_file_dir (buf); // get directory and create it

					if (out = mpcxc_fopen (buf, "w")) {
						ACE_OS::fclose (out);
						++retv;
					} else {
						Log.printf (lt_info, "Can't open NSRC file '%s' fo writing\n", buf);
					}
				}
			}
		}
	} else {
		Log.printf (lt_info, "Can't open file '%s' fo reading\n", name);
	}

	return retv;
}

void create_cat_file (Base* base, char* name) {
	make_file_dir (name);

	typedef std::map <std::string, std::string> FileNames_map;
	{
		FILE_aptr cat = mpcxc_fopen (name, "w+");

		if (cat.ptr ()) {
			FileNames_map file_names;
			DocCollection_aptr docs = base->AllTopics ();
			long count = 0, doc_id = 0, doc_count = docs->DocCount ();

			char fname [255], nfname [255];

			EndtTools::ProcessIndicator indicator ("create cat file");
			indicator.init (doc_count);

			IndexDataLoader <char> loader;

			for (long i = 0; i < doc_count; ++i) {
				doc_id = docs->GetItem (i);

				if (doc_id>=BIG_INFO_DOC && doc_id<BIG_INFO_DOC+BIG_INFO_COUNT)
					continue;

				DocInfo docinfo;
				base->FindDocInfo( doc_id, docinfo );
				relateds.insert( docinfo.Related );

				indicator.update (i, doc_id);

				Core::Aptr <char, DataDestructor> data (loader.load (base, doc_id, IDD_SOURCEFILE, count));

				if (data.ptr () && count) {
					ACE_OS::strncpy (fname, data.in (), count);
					char* truncate_name = TruncateNSRCFile (fname); // truncate the ":line"

					ACE_OS::sprintf (nfname, "%s/%s", nsrc_dir.c_str (), truncate_name);

					if (!ACE_OS::strcmp (fname, "meta-file")) {
						ACE_OS::sprintf (nfname, "%s/%d.nsr", nsrc_dir.c_str (), doc_id - 100000);
					}
					change_slashes (nfname);

					file_names [nfname] = nfname;

				} else if (doc_id > 100000) {
					ACE_OS::sprintf (nfname, "%s/%d.nsr", nsrc_dir.c_str (), doc_id - 100000);

					file_names [nfname] = nfname;
				}
			}

			file_names [blob_name] = blob_name;

			FileNames_map::const_iterator it = file_names.begin (), it_end = file_names.end ();
			for (; it != it_end; ++it) {
				ACE_OS::fprintf (cat.ptr (), "%s\n", it->first.c_str ());
			}
		} else {
			Log.printf (lt_info, "Can't open file '%s' for writing\n", name);
		}
	}
}

char    *TruncateNSRCFile(char *str) {
    char    *retv;
    int    slen, i;

    retv = str;

    if ( strstr( str, "(topic:" ))
        *strstr( str, "(topic:" ) = '\0';
    
    mpcxc_strtolower (str, strlen(str)); //strupr(str);

    slen = strlen(str);

    for( i = slen - 1; i >= 0; i -- ) {
        if( str[i] == ':' ) {
            str[i] = 0;
            break;
        }
    }

    slen = strlen(str);

    for( i = slen - 1; i >=0 ; i -- ) {
        if( str[i] == '/' || str[i] == '\\' ) {
            retv = &str[i + 1];
            break;
        }
    }

    return retv;
}

int    LoadBelongs(char *name, Belong *b) {
    FILE    *in;
    int    retv;

    retv = 0;

    if( name ) {
        if( in = mpcxc_fopen(name, "r") ) {
            int    i, j;
            //
            // Make zerro belongs
            //
            for( i = 0; i < MAX_BASES; i ++)
                b[i].id = 0;

            //
            // Read the bases shor names
            //
            while( !feof(in) ) {
                fscanf(in, "%d", &retv);
                b[retv].id = retv;
                fscanf(in, "%s", &b[retv].SName);

                fscanf(in, "%d", &b[retv].Weight);

                //
                // Skiping the string
                //
                fgets(buf, BSIZE, in);

                i = 0;

                while( buf[i] != '|' )
                    i ++;

                j = 0;
                i ++;
                while( buf[i] != '|' ) {
                    b[retv].RName[j] = buf[i];
                    i ++;
                    j ++;
                }
                b[retv].RName[j] = 0;
                i ++;

                while( buf[i] != '|' )
                    i ++;

                j = 0;
                i ++;
                while( buf[i] != '|' ) {
                    b[retv].EName[j] = buf[i];
                    i ++;
                    j ++;
                }
                b[retv].EName[j] = 0;

            }
            fclose(in);
        }
    }

    //
    // Return last number of belongs
    //
    return retv;
}

int    LoadWarnings(char *name, Warning *w) {
    FILE    *in;
    int    retv, i;

    retv = 0;

    if( name ) {
        if( in = mpcxc_fopen(name, "r") ) {

            //
            // Make zerro warnings
            //
            for( i = 0; i < MAX_WARN; i ++)
                w[i].id = 0;

            //
            // Read the warning names
            //
            while( !feof(in) ) {
                fscanf(in, "%d", &retv);
				if ( !retv || retv > MAX_WARN )
					break;
                w[retv].id = retv;
                fgets(buf, BSIZE, in);
                strcpy(w[retv].Name, TruncString(buf));
				retv = 0;
            }
            fclose(in);
        }
    }

    //
    // Return last number of warning
    //
    return retv;
}

bool SaveWarnings(char* fileName, Warning* w) {

    FILE* fout=mpcxc_fopen(fileName, "wt");
    if (!fout) {
        return false;
    }

    for(int i=0; i<MAX_WARN; i++) {
        if (w[i].id) {
            fprintf(fout, "%d %s\n", w[i].id, w[i].Name);
        }
    }
    fclose(fout);

    return true;
}

int    CreateNorm(Base *base, char *name) {
    int        retv;
    FILE        *out;

    retv = 0;

    make_file_dir (name);

    if( out = mpcxc_fopen(name, "w") ) {
        const	void    *key;
        Index	*ind = base->FindIndex("Category");

		BTIterator    btit(ind);
        int        i;

        for( i = 0; i < ind->KeyCount; i ++) {
            key = btit.Key();
			char* norm = strdup( (const char*) key );
#ifdef	WINENCODE
			Recoding( cd_win,cd_dos,norm );
#endif
            fprintf(out, "!NORM %s\n", norm );
			free( norm );
            btit.next();
            retv ++;
        }

        fclose(out);
    } else
        Log.printf(lt_info, "Can't open norm file '%s' for writing\n", name);

    return retv;
}

int    CreateSource(Base *base, char *name) {
    int    retv;
    FILE    *out;

    retv = 0;

    make_file_dir (name);

    if( out = mpcxc_fopen(name, "w") ) {
        HIndex            *hind = (HIndex*) base->FindIndex( "Adopted" );

        HIndex::HIndexKey    *hkey;
        BTIterator        btit(hind);
        int            i;

        for( i = 0; i < hind->KeyCount; i ++) {
            hkey = (HIndex::HIndexKey *)btit.Key();
            if( hkey->chCount == 0 ) {
                hind->FullName(hkey, buf);
#ifdef	WINENCODE
				Recoding( cd_win,cd_dos,buf );
#endif
                fprintf(out, "%s\n", buf);
            }
            btit.next();
            retv ++;
        }

        fclose(out);
    } else
        Log.printf(lt_info, "Can't open source file '%s' for writing\n", name);

    return retv;
}
////////////////////////////////////////////////////////////////////////////////
int    CreateKeyWord(Base *base, char *name) {

    make_file_dir (name);

    FILE* out = mpcxc_fopen(name, "w");
    if( !out )
        return -1;

    HIndex *ind = (HIndex*)base->FindIndex( "KeyWord" );

    int ret = 0;
    for(BTIterator btit(ind); !btit.End(); ++btit, ++ret) {
        const HIndex::HIndexKey* rootKey = 
            reinterpret_cast<const HIndex::HIndexKey*>(btit.Key());
        if( rootKey->level == 0 ) {
			char* text = strdup( ind->Text(rootKey));
#ifdef	WINENCODE
			Recoding(cd_win,cd_dos,text);
#endif
            fprintf(out, "\n!KEY %s\n", text );
			free( text );

            for(BTIterator btit1(ind); !btit1.End(); ++btit1) {
                const HIndex::HIndexKey* key = 
                    reinterpret_cast<const HIndex::HIndexKey*>(btit1.Key());

                if( key->parent == rootKey->id ) {
					char* text = strdup( ind->Text(key) );
#ifdef	WINENCODE
					Recoding(cd_win,cd_dos,text);
#endif
                    fprintf(out, "\t%s", text );
					free(text);
                    Stream* s = ind->Index::OpenN(key, 0);
                    if( s )    {
                        fprintf(out, ":");
                        for( int ib = s->Length() / sizeof(Ref); ib > 0; ib--) {
                            Ref ref;
                            s->Read(&ref, sizeof(ref));
                            if( ref.Sub > 0 )
                                fprintf(out, "%d.%d ", ref.DocId - 100000, ref.Sub);
                            else
                                fprintf(out, "%d ", ref.DocId - 100000);
                        }
                        fprintf(out, "\n");
                        ind->Close(s);
                    } else
                        fprintf(out, "\n");
                }
            }
        }
    }

    fclose(out);

    return ret;
}
////////////////////////////////////////////////////////////////////////////////
int    CreateTerritory(Base *base, char *name) {
    int    retv;
    FILE    *out;

    retv = 0;

    make_file_dir (name);

    if( out = mpcxc_fopen(name, "w") ) {
        HIndex    *hind = (HIndex*)base->FindIndex( "Territory" );

        HIndex::HIndexKey    *hkey;
        BTIterator        btit(hind);
        int            i;

        for( i = 0; i < hind->KeyCount; i ++) {
            hkey = (HIndex::HIndexKey *)btit.Key();
            if( hkey->chCount == 0 ) {
                hind->FullName(hkey, buf);
#ifdef	WINENCODE
				Recoding(cd_win,cd_dos,buf);
#endif
                fprintf(out, "%s\n", buf);
            }
            btit.next();
            retv ++;
        }
        fclose(out);
    }

    return retv;
}

int    CreateType(Base *base, char *name) {
    int    retv;
    FILE    *out;

    retv = 0;

    make_file_dir (name);

    if( out = mpcxc_fopen(name, "w") ) {
        HIndex    *hind = (HIndex*)base->FindIndex( "Type" );

        HIndex::HIndexKey    *hkey;
        BTIterator        btit(hind);
        int            i;

        for( i = 0; i < hind->KeyCount; i ++) {
            hkey = (HIndex::HIndexKey *)btit.Key();
            if( hkey->chCount == 0 ) {
                hind->FullName(hkey, buf);
#ifdef	WINENCODE
				Recoding(cd_win,cd_dos,buf);
#endif
                fprintf(out, "%s\n", buf);
            }
            btit.next();
            retv ++;
        }
        fclose(out);
    }

    return retv;
}

int    CreateAnno(Base *base, char *name, char* indexname ) {
    int    retv;
    FILE    *out;

    retv = 0;

    make_file_dir (name);

    if( out = mpcxc_fopen(name, "w") ) {
        HIndex    *hind = (HIndex*)base->FindIndex( indexname );

        HIndex::HIndexKey    *hkey;
        BTIterator        btit(hind);
        int            i;

        for( i = 0; i < hind->KeyCount; i ++) {
            hkey = (HIndex::HIndexKey *)btit.Key();
            if( hkey->chCount == 0 ) {
                hind->FullName(hkey, buf);
#ifdef	WINENCODE
				Recoding(cd_win,cd_dos,buf);
#endif
                fprintf(out, "%s\n", buf);
            }
            btit.next();
            retv ++;
        }
        fclose(out);
    }

    return retv;
}

int    CreateClass(Base *base, char *name) {

    int    retv;
    FILE    *out;

    retv = 0;

    make_file_dir (name);

    if( (out = mpcxc_fopen(name, "w")) == 0 ) {
        Log.printf(lt_info, "Can't open class file '%s' for writing\n", name);
        return retv;
    }

    // !VERSION 
    {
        char        Rootc[] = "Clas";
        ContextIndex    *cind = (ContextIndex*) base->FindIndex("Aux");
        int        size;
        Stream        *str;

        str = cind -> Open ( Rootc );
        if ( str ) {
            if ( size = str -> Length ( ) ) {
                str -> Read ( buf, size );
                fprintf(out, "!VERSION %d\n", *((int *)buf));
            }
            cind->Close(str);
        }
    }

    // COMMPREFIX
    // DOCSPREFIX ... 
    {
        char *Rootc [] = { PR_ALL, PR_DOCS, PR_COMMENTS, PR_FORMS, PR_PROJECTS, PR_PRACTICE, PR_INTERS /*, PR_QUES, PR_BREF*/};
        char *RootName [] = { "!ALLPREFIX", "!DOCSPREFIX", "!COMMPREFIX", "!FORMPREFIX", "!PROJPREFIX",
                    "!PRAKPREFIX", "!INTEPREFIX"/*, "!QUESPREFIX", "!BREFPREFIX" */};
        Stream        *str;
        int        size, len, i;
        char        *ptr;

        ContextIndex    *cind = (ContextIndex*) base->FindIndex("Aux");
        for ( i = 0; i < sizeof ( Rootc ) / sizeof ( Rootc [0] ); i++ ) {
            if ( str = cind -> Open ( Rootc [i] ) ) {
                if ( size = str -> Length ( ) ) {
                    size = str -> Read ( buf, size );
                    ptr = buf;
                    while( size > 0 ) {
                        len = strlen(ptr) + 1; // skip '\0'
#ifdef	WINENCODE
						Recoding( cd_win,cd_dos,ptr);
#endif
                        fprintf(out, "%s %s\n", RootName[i], ptr);
                        ptr += len;
                        size -= len;
                    }
                }
                cind -> Close ( str );
            }
        }
    }

    fprintf(out, "\n");

    // !PREFIX 
    {
        HIndex::HIndexKey    *hkey;
        HIndex            *hind = (HIndex*)base->FindIndex( "DocKind" );
        int            i;

        BTIterator btit(hind);

        for( i = 0; i < hind->KeyCount; i ++) {
            hkey = (HIndex::HIndexKey *)btit.Key();
            if( hkey->chCount == 0 ) {
                hind->FullName(hkey, buf);
#ifdef	WINENCODE
				Recoding(cd_win,cd_dos,buf);
#endif
                fprintf(out, "!PREFIX %s\n", buf);
            }
            btit.next();
        }
    }

    fprintf(out, "\n");

    // !CLASS 
    {
        HIndex::HIndexKey    *hkey;
        HIndex            *hind = (HIndex*)base->FindIndex( "Class" );
        int            i;

        BTIterator btit(hind);

        for( i = 0; i < hind->KeyCount; i ++) {
            hkey = (HIndex::HIndexKey *)btit.Key();
            if( hkey->chCount == 0 ) {
                hind->FullName(hkey, buf);
#ifdef	WINENCODE
				Recoding(cd_win,cd_dos,buf);
#endif
                fprintf(out, "!CLASS %s\n", buf);
            }
            btit.next();
        }
    }

    fprintf(out, "\n");

    // !PREFIXEX 
    {
        HIndex::HIndexKey    *hkey;
        HIndex            *hind = (HIndex*)base->FindIndex( "DocKind" );
        int            size, i, j, flg, plen, prexlen;
        char            *ptr, pname[1024];
        Stream            *str;


        BTIterator btit(hind);

        for( i = 0; i < hind->KeyCount; i ++) {
            hkey = (HIndex::HIndexKey *)btit.Key();

            if( str = hind->Index::OpenN(hkey, 1) ) {
                if( size = str->Length() ) {
                    size = str->Read(buf, size);
                    ptr = buf;
					plen = ACE_OS::strlen (hind->FullName (hkey, pname));
#ifdef	WINENCODE
					Recoding (cd_win, cd_dos, pname);
#endif

                    if( size > 0 )
                        fprintf(out, "\n");

                    while( size > 0 ) {
#ifdef	WINENCODE
						Recoding (cd_win, cd_dos, ptr);
#endif
                        fprintf(out, "!PREFIXEX ");
                        for( j = 4; j < plen; j ++) {
                            if( pname[j] == '\\' ) {
                                j += 4;
                                fprintf(out, "\\");
                                continue;
                            }
                            fprintf(out, "%c", pname[j]);
                        }
                        prexlen = strlen(ptr);
                        for( j = 1, flg = 0; j < prexlen; j ++) {
                            if( !(isdigit(ptr[j]) || ptr[j] == '=') && (flg == 1) )
                                flg = 2;
                            if( ptr[j] == ':' && !flg )
                                flg = 1;
                            if( (isdigit(ptr[j]) || ptr[j] == '=') && (flg == 2) )
                                continue;
                            fprintf(out, "%c", ptr[j]);
                        }
                        size -= (prexlen + 1);
                        ptr += (prexlen + 1);
						ACE_OS::fprintf (out, "\\;\n");
                    }
                }
                hind->Close(str);
            }
            btit.next();
        }
    }

    fclose(out);

    retv = 1;

    return retv;
}

int    CreatePublishers(Base *base, char *name) {
    int    retv;
    FILE    *out;

    retv = 0;

    make_file_dir (name);

    if( out = mpcxc_fopen(name, "w") ) {
        HIndex    *hind = (HIndex*)base->FindIndex( "PublishedIn" );

        HIndex::HIndexKey *hkey;
        BTIterator btit(hind);
        int i;
        char *ptr;

        for( i = 0; i < hind->KeyCount; i ++) {
            hkey = (HIndex::HIndexKey *)btit.Key();

			if( hkey->chCount == 0 ) {
                hind->FullName(hkey, buf);
            #ifdef	WINENCODE
                Recoding(cd_win,cd_dos,buf);
            #endif
                ptr = TranslatePublisher(buf, 0);
                fprintf(out, "%s\n", ptr);
				delete ptr;
                retv ++;
            }
            btit.next();
        }
        fclose(out);
    } else
        Log.printf(lt_info, "Can't open publishers file '%s' for writing\n", name);

    return retv;
}

//     NNN=Source[\NNN=Source][...]\NNN=Year[\NNN=BMonth[-EMonth]]\NNN=Name
char    *TranslatePublisher(char *ptr, int forDoc) {
    char    *str = new char[10000], *saved_ptr = ptr;
    int    i, ptrlen, num;
    char    *year;
    date    begin_data, end_data;

    ptrlen = strlen(ptr);
    *str = 0;

    for( i = 0; i < ptrlen; i ++)
        if( ptr[i] == '\\' )
            ptr[i] = 0;

    strcpy(str, ptr);
    ptr += (strlen(ptr) + 1);

    while( !(isdigit(ptr[5]) && isdigit(ptr[6]) && isdigit(ptr[7])) ) {
        if( forDoc )
            sprintf(str, "%s\\%s", str, ptr + 4);
        else
            sprintf(str, "%s\\%s", str, ptr);
        ptr += (strlen(ptr) + 1);
    }

    // Finding Year
    year = ptr + 4;
    ptr += (strlen(ptr) + 1);

    if( year[5] == '-' ) {
        end_data.da_year = tst_atoi(year, 5);
    } else {
        begin_data.da_year = atoi(year);
        end_data.da_year = begin_data.da_year;
    }

    // Finding Month
    begin_data.da_mon = FindMonth(ptr + 4);

    if( begin_data.da_mon ) {
        if( *(ptr + 4 + strlen(Months[begin_data.da_mon - 1].Name)) == '-' )
            end_data.da_mon = FindMonth(ptr + 4 + strlen(Months[begin_data.da_mon - 1].Name) + 1);
        else
            end_data.da_mon = begin_data.da_mon;

        ptr += (strlen(ptr) + 1);
    } else {
        begin_data.da_mon = 1;
        end_data.da_mon   = 12;
    }

    // Finding day
    if( isdigit(ptr[5]) && isdigit(ptr[strlen(ptr) - 1]) ) {
        begin_data.da_day = 1;
        end_data.da_day   = Months[end_data.da_mon - 1].days + ((end_data.da_year % 4) ? 0 : 1) * (end_data.da_mon == 2);
		char* real_str = ptr + strlen (ptr) + 1;
		if (strrchr (real_str, 'N')) {
			char *s_num = strrchr (real_str, 'N') + 2;
			sprintf(str, "%s|%02d/%02d/%04d-%02d/%02d/%04d|%s|%s|", str, begin_data.da_day, begin_data.da_mon, begin_data.da_year, end_data.da_day, end_data.da_mon, end_data.da_year, ptr+4, s_num);
			return str;
		} else {
			sprintf(str, "%s|%02d/%02d/%04d-%02d/%02d/%04d|%s|", str, begin_data.da_day, begin_data.da_mon, begin_data.da_year, end_data.da_day, end_data.da_mon, end_data.da_year, ptr+4);
			return str;
		}
		/*

        // Found day
        ptr += 5;
        begin_data.da_day = tst_atoi(ptr,5);
        while( !isdigit(*ptr) )
            ptr ++;

        if( *ptr == '-' )
            end_data.da_day = tst_atoi(ptr, 1);
        else
            end_data.da_day = begin_data.da_day;
        ptr += (strlen(ptr) + 1);
		*/

    } else {
        begin_data.da_day = 1;
        end_data.da_day   = Months[end_data.da_mon - 1].days + ((end_data.da_year % 4) ? 0 : 1) * (end_data.da_mon == 2);
    }

    // Find number
	char* Npos = strrchr (ptr, 'N');
	if (Npos && *++Npos == ' ') {
		sprintf(str, "%s|%02d/%02d/%04d-%02d/%02d/%04d|%s|", str, begin_data.da_day, begin_data.da_mon, begin_data.da_year,
										end_data.da_day,   end_data.da_mon,   end_data.da_year, ++Npos);
	} else {
		num = atoi(ptr);
		if (num)
			sprintf(str, "%s|%02d/%02d/%04d-%02d/%02d/%04d|%d|", str, begin_data.da_day, begin_data.da_mon, begin_data.da_year, end_data.da_day, end_data.da_mon, end_data.da_year, num);
		else
			sprintf(str, "%s|%02d/%02d/%04d-%02d/%02d/%04d|", str, begin_data.da_day, begin_data.da_mon, begin_data.da_year, end_data.da_day,end_data.da_mon, end_data.da_year);
	}

    return str;
}

int    FindMonth(char *str) {
    int    i;

    for( i = 0; i < 12; i ++) {
        if( strncmp(str, Months[i].Name, strlen(Months[i].Name)) == 0 )
            return i + 1;
    }
    return 0;
}

char    *TruncString(char *str) {
    while ( *str == ' ' )
        str ++;

    while ( str[strlen(str) - 1] == ' ' || str[strlen(str) - 1] == '\n' )
        str[strlen(str) - 1] = 0;

    return str;
}
