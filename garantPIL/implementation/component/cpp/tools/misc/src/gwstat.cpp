#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"
#include "SearchB.h"

YBase *m_base;

class Named {
public:
    Named() : m_Name(0) {}
    ~Named() { if (m_Name) delete[] m_Name; }
	char* c_str () { return m_Name; };

    char* name() const { return m_Name; }
	void name (const char* name) {
		if (m_Name) {
			delete[] m_Name;
			m_Name=0;
		}
		if (!name)
			return;
		m_Name = new char [strlen (name) + 1];
		strcpy (m_Name, name);
	};
	void name (const char* name, int l) {
		if (m_Name) {
			delete[] m_Name;
			m_Name=0;
		}
		m_Name = new char [l + 1];
		strncpy (m_Name, name, l);
		m_Name [l] = 0;
	}

private:
	char* m_Name;
};

class Complect : public Named {
public:
	std::set<long> m_Segments;

    Complect() : topic_count (0), anno_count (0), doc_count (0), edition_count (0), ref_count (0), comment_count (0) {}
    ~Complect() {}

	long topic_count, anno_count;
	long doc_count, edition_count, ref_count, comment_count;
	std::set<std::string> keys0, keys;
};

struct Product : public Named {
	std::vector<Complect*> m_Complects;

public:
    ~Product();
};

/////////////////////////////////////////////////////////////////////////////
struct SegmentInfo : public Named {
	short	m_Id;
};

std::vector<SegmentInfo*>	m_Segments;

void	add_complect (Product* curGroup, char* str) {
	bool flgDigits = false;

    char *find = strrchr (str, ':');
    if (!find)
        return;

    Complect* curComplect = new Complect;
    curComplect->name (str, find - str);

    while (*find != 0) {
        if (isdigit ((unsigned char) *find)) {
            if (!flgDigits) {
                long seg = atol (find);
                if (seg) {
                    curComplect->m_Segments.insert (seg);
                } else {
					for (std::vector<SegmentInfo*>::const_iterator it = m_Segments.begin (); it != m_Segments.end (); it++) {
						SegmentInfo* si = *it;
						curComplect->m_Segments.insert (si->m_Id);
					}
                    break;
                }
                flgDigits = true;
            }
        } else {
            flgDigits = false;
        }
        find++;
    }

    if (curComplect)
        curGroup->m_Complects.push_back (curComplect);
}

void	GetProductStatistic (std::vector<Product*> *products) {
	short dic_seg = 33;
    DocCollection* all_topics = m_base->AllTopics (ID_BORDER);

	for (int i = 0; i < all_topics->ItemCount; i++) {
        long docId = (*all_topics) [i];

		DocInfo docinfo;
		m_base->FindDocInfo (docId, docinfo);
		long annoid = docId < ID_ANNOPLUS ? GetDocMonitoring (&docinfo) : 0;

	    short segment [300];
        long countSegment = m_base->FindDocAttr (docId, IDD_BASES, segment, sizeof (segment)) / sizeof (short);

        if (countSegment) {
			for (std::vector<Product*>::iterator it = products->begin (); it != products->end (); it++) {
				Product *at_it = *it;
				for (std::vector<Complect*>::iterator it2 = at_it->m_Complects.begin (); it2 != at_it->m_Complects.end (); it2++) {
					Complect *at_it2 = *it2;
                    bool flgFound = false;
					for (std::set<long>::const_iterator it3 = at_it2->m_Segments.begin (); it3 != at_it2->m_Segments.end (); it3++) {
                        for (int s = 0; s < countSegment && !flgFound; s++)
                            flgFound |= segment[s] == *it3;
                    }
                    if (flgFound) {
						at_it2->topic_count++;
						if (annoid) at_it2->anno_count++;
						if (docinfo.Status & DS_DOC) at_it2->doc_count++;
						if ((docinfo.Status & DS_NODOC) && bsearch (&dic_seg, segment, countSegment, sizeof (short), shortcmp)) at_it2->doc_count++;
						if (docinfo.Status & DS_EDITION) at_it2->edition_count++;
						at_it2->ref_count += docinfo.HyperRefs;
						at_it2->comment_count += docinfo.GreenComments;

						long keys_size = 0, keys_count = 0;
						char *data = (char*) m_base->LoadAttr (docId, IDD_KEY, keys_size), *ptr = data;
						if (keys_size) {
							std::set<std::string> keys, keys0;
							while (ptr - data < keys_size) {
								char* str = strchr (ptr, ':') + 1;
								keys.insert (str);
								ptr += strlen (ptr) + 1;
								keys_count++;
								*strchr (str, '\\') = 0;
								keys0.insert (str);
							}							
							at_it2->keys.insert (keys.begin (), keys.end ());
							at_it2->keys0.insert (keys0.begin (), keys0.end ());
							gk_free (data);
						}
                    }
                }
            }
        }
	}
	printf ("\n");
}

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if (argc < 4)
		return -1;

	m_base = new YBase (argv [1], ACE_OS_O_RDONLY);
	m_base->IsOk ();
	Stream* str = m_base->FindIndex ("Aux")->Open ("Here");
	BaseInfo bi0;
	if (str) {
		long size = str->Length ();
		short *segs = new short [size / 2];
		str->Read (segs, size);
		m_base->FindIndex ("Aux")->Close (str);

		size >>= 1;
		for (int i = 0; i < size; i++) {
			BaseInfo baseinfo;
			m_base->FindBaseInfo (segs [i], baseinfo);
			SegmentInfo *si = new SegmentInfo ();
			si->name (baseinfo.Name);
			si->m_Id = segs [i];
			m_Segments.push_back (si);
		}
		m_base->FindBaseInfo (segs [0], bi0);
	}

	FILE* file = mpcxc_fopen (argv [2], "rb");
	if (!file)
		return -1;

	Product *curGroup = 0;
	std::vector<Product*> m_Products;

	while (!feof (file)) {
		char str [4096];
		if (!fgets (str, sizeof (str), file)) {
			if (curGroup && curGroup->m_Complects.size ())
                m_Products.push_back (curGroup);
			break;
		}

		int length = strlen (str);
		while (length && (str [length-1] == 10 || str [length-1] == 13))
			str [--length] = 0;

		if (str [0] == ':' || str [0] == 0) {
			if (curGroup && curGroup->m_Complects.size ())
                m_Products.push_back (curGroup);
            curGroup = new Product;
            curGroup->name (str + 1);
		} else {
			if (!curGroup)
				curGroup = new Product;
			add_complect (curGroup, str);
		}
	}
	fclose (file);

    GetProductStatistic (&m_Products);

    file = fopen (argv [3], "wc");
	if (!file)
		exit (EXIT_FAILURE);

	fprintf(file, "<html>\n"\
		"\t<body>\n"\
		"\t\t<table cellpadding=""1"" cellspacing=""1"" border=""1"" align=""center"">\n"\
		"<tr><td align=center colspan=6><b>Данные от %02d.%02d.%ld</b></td></tr>"
		"\t\t\t<tr>\n"\
		"\t\t\t\t<td align=""center"" rowspan=""2""><p><b>Информационный блок/комплект</b></p></td>\n"\
		"\t\t\t\t<td align=""center"" colspan=""5""><p><b>Количество</b></p></td>\n"\
		"\t\t\t</tr>\n"\
		"\t\t\t<tr>\n"\
		"\t\t\t\t<td align=""center"" ><p><b>Документов</b></p></td>\n"\
		"\t\t\t\t<td align=""center"" ><p><b>Редакций</b></p></td>\n"\
		"\t\t\t\t<td align=""center"" ><p><b>Аннотаций</b></p></td>\n"\
		"\t\t\t\t<td align=""center"" ><p><b>Гипертекстовых ссылок</b></p></td>\n"\
		"\t\t\t\t<td align=""center"" ><p><b>Комментариев в тексте</b></p></td>\n"\
		"\t\t\t\t<td align=""center"" ><p><b>Ситуаций 1-го уровня</b></p></td>\n"\
		"\t\t\t\t<td align=""center"" ><p><b>Ситуаций 2-го уровня</b></p></td>\n"\
		"\t\t\t</tr>\n", bi0.LastUpdate.RevisionDate.da_day, bi0.LastUpdate.RevisionDate.da_mon, bi0.LastUpdate.RevisionDate.da_year);

	for (std::vector<Product*>::const_iterator it = m_Products.begin (); it != m_Products.end (); it++) {
		Product* at_it = *it;
		if (at_it->c_str ())
			fprintf(file, "\t\t\t\t<td align=""center"" colspan=""6""><p><b>%s</b></p></td>\n", at_it->c_str ());

		for (std::vector<Complect*>::const_iterator it2 = at_it->m_Complects.begin (); it2 != at_it->m_Complects.end (); it2++) {
			Complect* at_it2 = *it2;
			fprintf (file, "\t\t\t<tr>\n"\
				"\t\t\t\t<td align=""left""><p>%s</p></td>\n"\
				"\t\t\t\t<td align=""left""><p>%d</p></td>\n"\
				"\t\t\t\t<td align=""left""><p>%d</p></td>\n"\
				"\t\t\t\t<td align=""left""><p>%d</p></td>\n"\
				"\t\t\t\t<td align=""left""><p>%d</p></td>\n"\
				"\t\t\t\t<td align=""left""><p>%d</p></td>\n"\
				"\t\t\t\t<td align=""left""><p>%d</p></td>\n"\
				"\t\t\t\t<td align=""left""><p>%d</p></td>\n"\
				"\t\t\t</tr>\n",
				at_it2->c_str (),
				at_it2->doc_count,
				at_it2->edition_count,
				at_it2->anno_count,
				at_it2->ref_count,
				at_it2->comment_count,
				at_it2->keys0.size (),
				at_it2->keys.size ());
		}
	}
	fprintf (file, "\t\t</table>\n\t</body>\n</html>\n");
	fclose(file);

	return 0;
}
