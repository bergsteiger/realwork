#include "ace/ACE.h"

#include "shared/Core/sys/Logs.h"
#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"
#include "main.h"

#include <stack>

/////////////////////////////////////////////////////////////////////////////////////

enum BInfoParam { ip_None, ip_Splash, ip_Account, ip_Business, ip_UserInfo };

void out_date (const Document* doc, FILE* file, const int tag, const char* text);
void out_data (const Document* doc, FILE* file, const BInfoParam param);
void out_data (const Document* doc, FILE* file, const unsigned flag, const char* text);
void out_data (const Document* doc, FILE* file, const int sub, const int tag, const char* text, bool b_sortprefix = true);
void out_annodata (const Document* doc, FILE* file, const int tag, const char* text);
void out_contents (const Document* doc, FILE* file, const int sub, const int tag, const char* text);

void out_text (Document* doc, FILE* file, EndtTools::EndtParser* parser);
void out_topic (const Document* doc, FILE* file);
void out_code (const Document* doc, FILE* file, const int tag, const char* text);

std::map<long,long> map_tag_size;
std::map<long,char*> map_tag_data;
std::map<long, std::map<long, std::vector<char*> > > map_tag_sub_strings;

/////////////////////////////////////////////////////////////////////////////////////

void out_doc (Document* doc, EndtTools::EndtParser* parser) { // Printing doc to it's source file
	Base *base = doc->base;

	char* nsrfile, nfile [255];

	//
	// Get source file name
	// in format "file.ext:line"
	//

	if (doc->DocId > ID_BORDER) {
		long size = base->FindDocAttr (doc->DocId, IDD_SOURCEFILE, buf, BSIZE);

		if (size && buf [0] && stricmp (buf, "meta-file")) {
			buf [size] = 0; // Make zero-end

			nsrfile = TruncateNSRCFile (buf); // Truncate the ":line"

			if (ACE_OS::strcmp (buf, "meta-file")) {
				ACE_OS::sprintf (nfile, "%s/%s", nsrc_dir.c_str (), nsrfile);
			} else {
				ACE_OS::sprintf (nfile, "%s/%d.nsr", nsrc_dir.c_str (), doc->DocId - 100000);
			}

			make_file_dir (nfile); // Get directory and create it

		} else {
			ACE_OS::sprintf (nfile, "%s/%d.nsr", nsrc_dir.c_str (), doc->DocId - 100000);
		}

		//
		// Open file for writing to end of file
		//

		change_slashes (nfile);
		EndtTools::NsrcFileWriter* file_writer = new EndtTools::NsrcFileWriter(nfile);

		if (file_writer->is_valid ()) {
			::out_topic (doc, file_writer->get_handle ());     // !TOPIC

			if (doc->DocId < ID_ANNOPLUS+ID_BORDER)
				OutBelongs (doc, file_writer->get_handle ());      // !BELONGS
			OutName (doc, file_writer->get_handle ());         // !NAME

			::out_date (doc, file_writer->get_handle (), IDD_VANONCED,   "!VANONCED");

			OutDate (doc, file_writer->get_handle ());         // !DATE

#ifdef VERSION56
			OutActivite (doc, file_writer->get_handle ());     // !ACTIVE
			OutEdition (doc, file_writer->get_handle ());      // !EDITION
			OutChdate (doc, file_writer->get_handle ());       // !CHDATE
			OutVerlink (doc, file_writer->get_handle ());      // !VERLINK
#endif
			::out_contents (doc, file_writer->get_handle (), 0, IDD_CONTENTS,"!CONTENTS ");
			OutNotSure(doc, file_writer->get_handle ());

			OutWarning(doc, file_writer->get_handle ());       // !WARNING
			OutPreactive (doc, file_writer->get_handle ());    // !PREACTIVE
			OutNoActive (doc, file_writer->get_handle ());     // !NOACTIVE
			OutRelated (doc, file_writer->get_handle ());      // !RELATED

			::out_code (doc, file_writer->get_handle (), IDD_ID,         "!CODE");
			::out_code (doc, file_writer->get_handle (), IDD_RCODE,      "!RCODE");
			::out_date (doc, file_writer->get_handle (), IDD_RDATE,      "!RDATE");

			OutPriority (doc, file_writer->get_handle ());     // !PRIORITY
			OutPublishedin (doc, file_writer->get_handle ());  // !PUBLISHEDIN

			//::out_data (doc, file_writer->get_handle (), 0, IDD_DOCKIND, "!PREFIX ");
			::out_data (doc, file_writer->get_handle (), 0, IDD_KIND, "!KIND ");
			::out_data (doc, file_writer->get_handle (), 0, IDD_DIV    , "!CLASS ");

			OutTerritory (doc, file_writer->get_handle ());    // !TERRITORY
			OutSource (doc, file_writer->get_handle ());       // !SOURCE

			if (doc->DocId > ID_ANNOPLUS+ID_BORDER) {
				::out_annodata (doc, file_writer->get_handle (), IDD_ANNOUSER, "!ANNOUSER ");
				::out_annodata (doc, file_writer->get_handle (), IDD_ANNOORGANIZATION, "!ANNOORGANIZATION ");
				::out_annodata (doc, file_writer->get_handle (), IDD_ANNOTAX, "!ANNOTAX ");
				::out_annodata (doc, file_writer->get_handle (), IDD_ANNOINTEREST, "!ANNOINTEREST ");
				::out_annodata (doc, file_writer->get_handle (), IDD_ANNOKIND, "!ANNOKIND ");
			}

			::out_data (doc, file_writer->get_handle (), 0, IDD_SERVICEINFO , "!SERVICEINFO ");
			::out_data (doc, file_writer->get_handle (), 0, IDD_TYPE   , "!TYPE ");
			::out_data (doc, file_writer->get_handle (), ip_Business);
			::out_data (doc, file_writer->get_handle (), ip_Account);
			if (!(doc->Stat.Status_ex & DS_FLASH)) ::out_data (doc, file_writer->get_handle (), DS_DOC, "!DOC");
			::out_data (doc, file_writer->get_handle (), DS_BOOK,        "!BOOK");
			::out_data (doc, file_writer->get_handle (), DS_NOTTM,       "!NOTTM");

			OutNoDoc (doc, file_writer->get_handle ());        // !NODOC

			::out_data (doc, file_writer->get_handle (), ip_Splash);  // !SPLASH
            ::out_data (doc, file_writer->get_handle (), DS_MOJNOTREG,   "!MOJNOTREG");

			OutNorm (doc, file_writer->get_handle ());         // !NORM

			//OutRevision (doc, file_writer->get_handle ());     // !REVISION

			::out_date (doc, file_writer->get_handle (), IDD_SORTDATE,   "!SORTDATE");
			::out_data (doc, file_writer->get_handle (), ip_UserInfo);
			::out_date (doc, file_writer->get_handle (), IDD_VABOLISHED, "!VABOLISHED");
			::out_date (doc, file_writer->get_handle (), IDD_VINCLUDED,  "!VINCLUDED");
			::out_date (doc, file_writer->get_handle (), IDD_VLCONTROL,  "!VLCONTROL");

			OutVChanged (doc, file_writer->get_handle ());     // !VCHANGED

			GDS_ASSERT (parser);

			::out_text (doc, file_writer->get_handle (), parser); // out text documnet with !SUB
			//ACE_OS::fprintf (file_writer->get_handle (), "\n");
			delete file_writer;

			map_tag_size.clear ();
			for (std::map<long,char*>::iterator map_it = map_tag_data.begin (); map_it != map_tag_data.end (); map_it++)
				gk_free (map_it->second);
			map_tag_data.clear ();
			map_tag_sub_strings.clear ();

			/*{
			int file = ace_os_open(nfile,ACE_OS_O_RDONLY);
			long size = ace_os_filesize(file);
			if (!size) {
				printf( "error writing %s\n",nfile);
			}
			ace_os_close(file);
			}*/
		} else {
			Log.printf (lt_info, "Can't open source file '%s' for writting\n", buf);
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////

int	OutBelongs(Document *doc, FILE *file)
{
	short	*sbuf = (short *)buf;
	int	r, i;

	//
	// Load belongs and devide by sizeof(short)
	//
	r = i = doc->base->FindDocAttr(doc->DocId, IDD_BASES, buf, BSIZE) / 2;

	//
	// Printing belongs
	//
	if( i ) {
		fprintf(file, "!BELONGS ");
		for(; i > 0; i --) {
			BaseInfo	binfo;

			//
			// Get base info
			//
			doc->base->FindBaseInfo(*sbuf, binfo);
#ifdef	WINENCODE
			Recoding(cd_win,cd_dos,binfo.Name);
#endif

			//
			// If have no this belongs in BelongFile
			//
			if(false/*Belongs[*sbuf].id == 0*/) {
				Log.printf(lt_info, "WARNING! Топик %d принадлежит сегменту, не определенному в BelongFile:\n", doc->DocId);

				Log.printf(lt_info, "\tНовый сегмент:\n\t\t%d\tA%03d\t%d\t|", *sbuf, *sbuf, binfo.Weight);
				Log.printf(lt_info, cd_dos, "%s", binfo.Name);
				Log.printf(lt_info, "||%s|\n", binfo.NameEng);
				
				Belongs[*sbuf].id = *sbuf;
				Belongs[*sbuf].Weight = binfo.Weight;
				sprintf(Belongs[*sbuf].SName, "A%03d", *sbuf);
				strcpy(Belongs[*sbuf].RName, binfo.Name);
				strcpy(Belongs[*sbuf].EName, binfo.NameEng);
			} else {
				if(false/*(strncmp(Belongs[*sbuf].RName, binfo.Name, strlen(Belongs[*sbuf].RName)) != 0) || (strncmp(Belongs[*sbuf].EName, binfo.NameEng, strlen(Belongs[*sbuf].EName)) != 0)*/) {
					Log.printf(lt_info, "WARNING! Топик %d принадлежит сегменту имя котрого не совпадает с определенным в BelongFile:\n", doc->DocId);

					Log.printf(lt_info, "\tСегмент в базе:\n\t\t%d\tXXX\t%d\t|", *sbuf, binfo.Weight);
					Log.printf(lt_info, cd_dos, "%s", binfo.Name);
					Log.printf(lt_info, "||%s|\n", binfo.NameEng);

					Log.printf(lt_info, "\tСегмент в BelongFile:\n\t\t%d\t%s\t%d\t|", *sbuf, Belongs[*sbuf].SName, Belongs[*sbuf].Weight);
					Log.printf(lt_info, cd_dos, "%s", Belongs[*sbuf].RName);
					Log.printf(lt_info, "||%s|\n", Belongs[*sbuf].EName);

					Log.printf(lt_info, "\tНовый сегмент:\n\t\t%d\tA%03d\t%d\t|", *sbuf, *sbuf, binfo.Weight);
					Log.printf(lt_info, cd_dos, "%s", binfo.Name);
					Log.printf(lt_info, "||%s|\n", binfo.NameEng);

					Belongs[*sbuf].id = *sbuf;
					Belongs[*sbuf].Weight = binfo.Weight;
					sprintf(Belongs[*sbuf].SName, "A%03d", *sbuf);
					strcpy(Belongs[*sbuf].RName, binfo.Name);
					strcpy(Belongs[*sbuf].EName, binfo.NameEng);
				} else if (!strlen (Belongs[*sbuf].SName)) {
					Belongs[*sbuf].id = *sbuf;
					Belongs[*sbuf].Weight = binfo.Weight;
					sprintf(Belongs[*sbuf].SName, "A%03d", *sbuf);
					strcpy(Belongs[*sbuf].RName, binfo.Name);
					strcpy(Belongs[*sbuf].EName, binfo.NameEng);
				}
			}

			fprintf(file, "%s", Belongs[*sbuf].SName);
			sbuf ++;
			if( i > 1 )
				fprintf(file, "\\");
		}
		fprintf(file, "\n");
	}

	return	r;
}

int	OutName(Document *doc, FILE *file)
{
	if( doc->base->FindDocName(doc->DocId, buf) ) {
#ifdef	WINENCODE
		Recoding(cd_win,cd_dos,buf);
#endif
		fprintf(file, "!NAME %s\n", buf);
		return 1;
	}
	return 0;
}

#ifdef VERSION56
int	OutEdition(Document *doc, FILE *file) 
{
	if (doc->Stat.Status & DS_EDITION) {
		fprintf(file, "!EDITION\n");
		return 1;
	}
	return 0;
}

int	OutActivite(Document *doc, FILE *file) 
{
	char buff[4096]="";
	int len;
	if( len = doc->base->FindDocAttr(doc->DocId, IDD_ACTIVE, buff, sizeof(buff)) ) {
		int i=0;
		DocActivity d;
		while(i<len) {
			memcpy(&d, &buff[i], 2*sizeof(date));
			i+=2*sizeof(date);
			d.text=&buff[i];
			if (*d.text=='\0') {
				if ( d.to.da_year && d.from.da_year ) {
					fprintf(file, "!ACTIVE %d/%d/%d-%d/%d/%d\n", d.from.da_day, d.from.da_mon, d.from.da_year, d.to.da_day, d.to.da_mon, d.to.da_year);
				} else {
					if ( d.to.da_year ) {
						d.to = date_plusdays( d.to, 1 );
						fprintf(file, "!NOACTIVE %d/%d/%d\n", d.to.da_day, d.to.da_mon, d.to.da_year);
					} else {
						if (doc->Stat.Status & DS_ACTIVE)
							fprintf(file, "!ACTIVE %d/%d/%d\n", d.from.da_day, d.from.da_mon, d.from.da_year);
						else
						if (doc->Stat.Status & DS_PREACTIVE)
							if (d.from.da_year)
								fprintf(file, "!ACTIVE %d/%d/%d\n", d.from.da_day, d.from.da_mon, d.from.da_year);
							else
								fprintf(file, "!PREACTIVE\n");
						else
							fprintf(file, "!ACTIVE %d/%d/%d\n", d.from.da_day, d.from.da_mon, d.from.da_year); //будущая редакция?
					}
				}
			} else {
#ifdef	WINENCODE
				Recoding(cd_win,cd_dos,d.text);
#endif
				if ( d.to.da_year && d.from.da_year ) {
					fprintf(file, "!ACTIVE %d/%d/%d-%d/%d/%d \"%s\"\n", d.from.da_day, d.from.da_mon, d.from.da_year, d.to.da_day, d.to.da_mon, d.to.da_year, d.text);
				} else {
					if (d.to.da_year ) {
						d.to = date_plusdays( d.to, 1 );
						fprintf(file, "!NOACTIVE %d/%d/%d \"%s\"\n", d.to.da_day, d.to.da_mon, d.to.da_year, d.text);
					} else {
						if (doc->Stat.Status & DS_ACTIVE)
							fprintf(file, "!ACTIVE %d/%d/%d \"%s\"\n", d.from.da_day, d.from.da_mon, d.from.da_year, d.text);
						else
						if (doc->Stat.Status & DS_PREACTIVE)
							fprintf(file, "!ACTIVE %d/%d/%d \"%s\"\n", d.from.da_day, d.from.da_mon, d.from.da_year, d.text);
						else
							fprintf(file, "!ACTIVE %d/%d/%d \"%s\"\n", d.from.da_day, d.from.da_mon, d.from.da_year, d.text); //будущая редакция?
					}
				}
			}
			i+=strlen(d.text)+2;
			if (buff[i]=='\0') {
				break;
			} else {
				--i;
			}
		}
		return 1;
	} else {
		if ((doc->Stat.Status & DS_EDITION) && (doc->Stat.Status & DS_ABOLISHED)) {
			fprintf(file, "!NOACTIVE\n");
		}
	}
	return 0;
}

int	OutNotSure(Document *doc, FILE *file)
{
	char buff[4096]="";
	int len;
	if( len = doc->base->FindDocAttr(doc->DocId, IDD_NOTSURE, buff, sizeof(buff)) ) {
		const char* d = (const char*) buff;
		u_int32_t ss = 0;
		while ( ss < (u_int32_t) len ) {
			DocNotSure* ns = (DocNotSure*)d;
			char* aText = (char*) d + sizeof(ns->from) + sizeof(ns->to);
#ifdef	WINENCODE
			Recoding(cd_win,cd_dos,aText);
#endif
			if (ns->from.da_year && ns->to.da_year && strlen( aText )) {
				fprintf ( file, "!NOTSURE %02d/%02d/%04d-%02d/%02d/%04d \"%s\"\n",
					(int) ns->from.da_day,
					(int) ns->from.da_mon,
					(int) ns->from.da_year,
					(int) ns->to.da_day,
					(int) ns->to.da_mon,
					(int) ns->to.da_year,
					aText );
			} else {
				if (ns->from.da_year && ns->to.da_year) {
					fprintf ( file, "!NOTSURE %02d/%02d/%04d-%02d/%02d/%04d\n",
						(int) ns->from.da_day,
						(int) ns->from.da_mon,
						(int) ns->from.da_year,
						(int) ns->to.da_day,
						(int) ns->to.da_mon,
						(int) ns->to.da_year );
				} else {
					if (ns->from.da_year && strlen(aText)){
						fprintf ( file, "!NOTSURE %02d/%02d/%04d \"%s\"\n",
							(int) ns->from.da_day,
							(int) ns->from.da_mon,
							(int) ns->from.da_year,
							aText );
					} else {
						if (ns->from.da_year) {
							fprintf ( file, "!NOTSURE %02d/%02d/%04d\n",
								(int) ns->from.da_day,
								(int) ns->from.da_mon,
								(int) ns->from.da_year );
						} else {
							fprintf ( file, "!NOTSURE\n" );
						}
					}
				}
			}
			u_int32_t aLen = strlen(aText) + 1;
			ss += aLen + sizeof(ns->from) + sizeof(ns->to);
			d = aText + aLen;
		}
	}

	return 0;
}

int	OutChdate(Document *doc, FILE *file) 
{
	char buff[4096]="";
	int len;
	if( len = doc->base->FindDocAttr(doc->DocId, IDD_CHDATE, buff, sizeof(buff)) ) {
		int i=0;
		DocChDate d;
		while(i<len) {
			memcpy(&d, &buff[i], sizeof(DocChDate));
			i+=sizeof(DocChDate);
			fprintf(file, "!CHDATE %d/%d/%d\n", d.anonce.da_day, d.anonce.da_mon, d.anonce.da_year );
		}
		return 1;
	}
	return 0;
}

int	OutVerlink(Document *doc, FILE *file)
{
	if (doc->Stat.prevEdition) {
		fprintf(file, "!VERLINK %d\n", doc->Stat.prevEdition-ID_BORDER);
		return 1;
	}
	return 0;
}

#endif // VERSION56

int	OutDate(Document* doc, FILE* file) {
	int	i = doc->base->FindDocAttr (doc->DocId, IDD_DATE, buf, BSIZE) / sizeof (date);

	if (i) {
		date* d = (date*) buf;

		while (i > 0) {
			ACE_OS::fprintf (file, "!DATE %02d/%02d/%04d\n", d->da_day, d->da_mon, d->da_year);
			++d;
			--i;
		}

		return 1;
	}

	return 0;
}

int	OutWarning (Document* doc, FILE* file) {
	int	retv = 0, i;

	if (doc->base->FindDocAttr (doc->DocId, IDD_WARNING, buf, BSIZE)) {
#ifdef	WINENCODE
		Recoding (cd_win, cd_dos, buf);
#endif
		for (i = 0; i < MAX_WARN; ++i)	{
			if (Warnings [i].id && (ACE_OS::strcmp (buf, Warnings [i].Name) == 0)) {
				ACE_OS::fprintf (file, "!WARNING %d\n", i);
				retv = 1;
				break;
			}
		}

		//
		// If not found then message
		//
		if (!retv) {
			for (i = MAX_WARN - 1; i >= 0; --i) {
				if (Warnings [i].id || (i == 0)) {
					++i;
					Warnings [i].id = i;
					ACE_OS::fprintf (file, "!WARNING %d\n", i);
					ACE_OS::strcpy (Warnings [i].Name, buf);
					retv = 1;
					//warnModified=true;
					break;
				}
			}

			Log.printf (lt_info, "WARNING! Топик %d содержит WARNING не определенный в WarningsFile:\n", doc->DocId);
			Log.printf (lt_info, "\tНовый WARNING:\n\t\t%d\t", i);
			Log.printf (lt_info, cd_dos, "%s", Warnings [i].Name);
			Log.printf (lt_info, "\n");
		}
	}
	
	return retv;
}

int	OutPreactive(Document *doc, FILE *file)
{
#ifndef	VERSION56
	if( (doc->Stat.Status & DS_PREACTIVE) && (doc->Stat.Status & DS_DOC) )
	{
		fprintf(file, "!PREACTIVE\n");
		return 1;
	}
#endif
	return 0;
}

int	OutNoActive(Document *doc, FILE *file)
{
#ifdef	VERSION56
	char buff[4096]="";
	int len = doc->base->FindDocAttr(doc->DocId, IDD_ACTIVE, buff, sizeof(buff));
	if( !len  ) {
		if( !(doc->Stat.Status & DS_ACTIVE) && (doc->Stat.Status & DS_DOC) ) {
			fprintf(file, "!NOACTIVE\n");
			return 1;
		}
		if( (doc->Stat.Status & DS_PREACTIVE) && (doc->Stat.Status & DS_DOC) ) {
			fprintf(file, "!PREACTIVE\n");
			return 1;
		}
	}
#else
	if( !(doc->Stat.Status & DS_ACTIVE) && (doc->Stat.Status & DS_DOC) ) {
		fprintf(file, "!NOACTIVE\n");
		return 1;
	}
#endif
	return 0;
}

int	OutRelated (Document* doc, FILE* file) {
	if (doc->Stat.Related > 100000) {
		ACE_OS::fprintf (file, "!RELATED %d\n", doc->Stat.Related - 100000);
	} else if (doc->Stat.Related) {
		ACE_OS::fprintf (file, "!RELATED %d\n", doc->Stat.Related);
	}
	return doc->Stat.Related;
}

int	OutPriority (Document* doc, FILE* file) {
	int	p = doc->Stat.Force;

	if (p && (doc->Stat.Status & DS_DOC)) {
		/*
		if (doc->Stat.Status & DS_ABOLISHED) {
			p -= 4096;
		} else if (doc->Stat.Status & DS_PREACTIVE) {
			p -= 2048;
		}
		if (doc->Stat.Status & DS_MOJREG) {
			p += 1;
		}
		*/

		ACE_OS::fprintf (file, "!PRIORITY %d\n", p);
	}
	return doc->Stat.Force;
}

int	OutPublishedin(Document *doc, FILE *file)
{
	int	i, len;
	char	*ptr, *tptr;

	if( i = doc->base->FindDocAttr(doc->DocId, IDD_PUBLISHEDIN, buf, BSIZE) )
	{
		ptr = buf;
		while( i > 0 )
		{
			len = strlen(ptr) + 1;
#ifdef	WINENCODE
			Recoding(cd_win,cd_dos,ptr);
#endif
			tptr = TranslatePublisher(ptr, 1);
			if( tptr ) {
				// Skip 4 chars "100="
				fprintf(file, "!PUBLISHEDIN %s\n", tptr + 4);
				delete tptr;
			}
			i -= len;
			ptr += len;
		}
		return 1;
	}
	return 0;
}

int	OutTerritory(Document *doc, FILE *file)
{
	int	i, len, j;
	char	*ptr;
	
	if( i = doc->base->FindDocAttr(doc->DocId, IDD_TERRITORY, buf, BSIZE) ) {
		ptr = buf;
		while( i > 0 ) {
			len = strlen(ptr);
			fprintf(file, "!TERRITORY ");
#ifdef	WINENCODE
			Recoding(cd_win,cd_dos,ptr+4);
#endif
			for( j = 4; j < len; j ++) {
				if( ptr[j] == '\\' )
				{
					fprintf(file, "%c", ptr[j]);
					j += 4;
				} else
					fprintf(file, "%c", ptr[j]);
			}
			fprintf(file, "\n");
			i -= (len + 1);
			ptr += (len + 1);
		}
		return 1;
	}
	return 0;
}

int	OutSource(Document *doc, FILE *file)
{
	int	i, len;
	char	*ptr, *tptr;;
	
	
	if( i = doc->base->FindDocAttr(doc->DocId, IDD_SOURCE, buf, BSIZE) ){
		ptr = buf;
		while (i > 0) {
			ptr += 4; //пропустили первый сорт.префикс
			i -= 4;
#ifdef	WINENCODE
			Recoding(cd_win,cd_dos,ptr);
#endif

			len = strlen(ptr) + 1;
			tptr = ptr;
			fprintf(file, "!SOURCE ");
			while( *ptr != 0 ) {
				fprintf(file, "%c", *ptr);
				if (*ptr == '\\')
					ptr += 4;
				ptr ++;
			}
			fprintf(file, "\n");
			ptr = tptr;
			i -= len;
			ptr += len;
		}
		return 1;
	}
	return 0;
}

int	OutNoDoc(Document* doc, FILE *file) {
	if (doc->Stat.Status & DS_REFDOC) {
		ACE_OS::fprintf(file, "!REFDOC\n");
		return 1;
	} else if ((doc->Stat.Status & DS_NODOC) && !(doc->Stat.Status & DS_EDITION)) {
		ACE_OS::fprintf (file, "!NODOC\n");
		return 1;
	}
	return 0;
}

int	OutNorm (Document* doc, FILE* file) {
	if (doc->base->FindDocAttr(doc->DocId, IDD_CATEGORY, buf, BSIZE)) {
#ifdef	WINENCODE
		Recoding (cd_win, cd_dos, buf);
#endif
		ACE_OS::fprintf (file, "!NORM %s\n", buf);
		return 1;
	}
	return 0;
}

void OutRevision (Document* doc, FILE* file) {
	/*
	ACE_OS::fprintf (
		file
		, "!REVISION %02d/%02d/%04d\n"
		, doc->Stat.Revision.RevisionDate.da_day
		, doc->Stat.Revision.RevisionDate.da_mon
		, doc->Stat.Revision.RevisionDate.da_year
	);
	*/
}

int	OutVChanged(Document *doc, FILE *file)
{
	int	i;
	date	*pdate;
	char	*ptr;

	if( i = (doc->base->FindDocAttr(doc->DocId, IDD_VCHANGED, buf, BSIZE) / sizeof(date)) )
	{
		ptr = buf;
		while( i > 0 )
		{
			pdate = (date *)ptr;
			fprintf(file, "!VCHANGED %02d/%02d/%04d\n", pdate->da_day, pdate->da_mon, pdate->da_year);
			i --;
			ptr += sizeof(date);
		}
		return 1;
	}
	return 0;
}

/////////////////////////////////////////////////////////////////////////////////////

extern	std::set<long>	relateds;

void out_topic (const Document* doc, FILE* file) {
	char* name = ACE_OS::strdup (doc->Stat.Title);

	if (name) {

#ifdef	WINENCODE
		Recoding (cd_win, cd_dos, name);
#endif

		if (doc->DocId > ID_BORDER) {
			if (doc->DocId > ID_ANNOPLUS+ID_BORDER)
				ACE_OS::fprintf (file, "!ANNOTOPIC %d %s\n", doc->DocId - ID_BORDER - ID_ANNOPLUS, name);
			else if (doc->Stat.Status_ex & DS_FLASH) {
				ACE_OS::fprintf (file, "!FLASHTOPIC %d %s\n", doc->DocId - ID_BORDER, name);

				ObjKey objkey;
				objkey.id = doc->DocId;
				Stream* str = doc->base->FindIndex ("Blob")->Open (&objkey);
				if (str) {
					ObjInfo	info;
					str->Read (&info, sizeof (info));
					doc->base->FindIndex ("Blob")->Close (str);

					char fname [255];
					ACE_OS::sprintf (fname, "%s\\%d.swf", blob_dir.c_str (), objkey.id - ID_BORDER);
					change_slashes (fname);
					ACE_OS::fprintf (file, "!OBJPATH %s\n", fname);
				}
			} else
				ACE_OS::fprintf (file, "!TOPIC %d %s\n", doc->DocId - ID_BORDER, name);
		} else {
			ACE_OS::fprintf (file, "!TOPIC %d %s\n", doc->DocId, doc->Stat.Title);
		}
		if ( relateds.find( doc->DocId ) != relateds.end())
			ACE_OS::fprintf (file, "!REL\n");

		ACE_OS::free (name);
	}
}

void out_code (const Document* doc, FILE* file, const int tag, const char* text) {
	long count;

	Base* base = dynamic_cast <Base*> (doc->base);

	Core::Aptr <char, DataDestructor> data (
		IndexDataLoader <char> (false).load (base, doc->DocId, tag, count)
	);
	
	if (data.ptr () && count > 0) {
		char* ptr = data.ptr ();

		while (count > 0) {

#ifdef	WINENCODE
			Recoding (cd_win, cd_dos, ptr);
#endif
			ACE_OS::fprintf (file, "%s %s\n", text, ptr);
			size_t len = ACE_OS::strlen (ptr) + 1;
			count -= len;
			ptr += len;
		}
	}
}

void out_data (const Document* doc, FILE* file, const unsigned flag, const char* text) {
	if (doc->Stat.Status & flag) {
		ACE_OS::fprintf (file, "%s\n", text);
	}
}

void out_data (const Document* doc, FILE* file, const BInfoParam param) {
	long count;

	Base* base = dynamic_cast <Base*> (doc->base);

	Core::Aptr <short, DataDestructor> data (
		IndexDataLoader <short> ().load (base, doc->DocId, IDD_BASES, count)
	);

	if (data.ptr () && count > 0) {
		long value = 0;
		BaseInfo base_info;

		std::string str; 

		switch (param) {
			case ip_Splash:
				str = "!SPLASH";
				break;
			default:
				//assert (0);
				break;
		}

		for (long i = count - 1; i >= 0; --i) {
			if (base->FindBaseInfo (data.ptr () [i], base_info)) {
				switch (param) {
					case ip_Splash:
						value = base_info.SplashTopic;
						break;
					default:
						//assert (0);
						break;
				}

				if (value == doc->DocId) {
					ACE_OS::fprintf (file, "%s\n", str.c_str ());
					break;
				}
			}
		}
	}
}

void out_date (const Document* doc, FILE* file, const int tag, const char* text) {
	long count;

	Base* base = dynamic_cast <Base*> (doc->base);

	Core::Aptr <date, DataDestructor> data (
		IndexDataLoader <date> (false).load (base, doc->DocId, tag, count)
	);

	if (data.ptr () && count > 0) {
		ACE_OS::fprintf (file, "%s %02d/%02d/%04d\n", text, data->da_day, data->da_mon, data->da_year);
	}
}

void out_data (const Document* doc, FILE* file, const int sub, const int tag, const char* text, bool b_sortprefix) {
	if (map_tag_size.find (tag) == map_tag_size.end ()) {
		Base* base = dynamic_cast <Base*> (doc->base);

		long count;
		char *data = (char*) base->LoadAttr (doc->DocId, tag, count), *ptr = data;
		map_tag_size.insert (std::map<long,long>::value_type (tag, count));
		map_tag_data.insert (std::map<long,char*>::value_type (tag, data));
		std::map<long, std::vector<char*> > map_sub_strings;
		while (count > 0) {
			long sub = strchr (ptr, ':') ? atol (ptr) : 0;
			std::map<long, std::vector<char*> >::iterator map_it = map_sub_strings.find (sub);
			if (map_it == map_sub_strings.end ()) {
				std::vector<char*> avector;
				avector.push_back (ptr);
				map_sub_strings.insert (std::map<long,std::vector<char*> >::value_type (sub, avector));
			} else {
				map_it->second.push_back (ptr);
			}
			long len = strlen (ptr) + 1;
			ptr += len;
			count -= len;
		}
		map_tag_sub_strings.insert (std::map<long, std::map<long,std::vector<char*> > >::value_type (tag, map_sub_strings));
	}
	std::map<long, std::map<long,std::vector<char*> > >::const_iterator map_map_it = map_tag_sub_strings.find (tag);
	if (map_map_it == map_tag_sub_strings.end ())
		return ;
	std::map<long,std::vector<char*> >::const_iterator map_it = map_map_it->second.find (sub);
	if (map_it != map_map_it->second.end ()) {
		char buffer [20];
		ACE_OS::sprintf (buffer, "%d", sub);
		int sslen = ACE_OS::strlen (buffer);
		for (std::vector<char*>::const_iterator char_it = map_it->second.begin (); char_it != map_it->second.end (); char_it++) {
			char* ptr = strdup (*char_it);
			int len = ACE_OS::strlen (ptr);

			if (ACE_OS::strncmp (ptr, buffer, sslen) == 0 && ptr [sslen] == ':') {
				ACE_OS::fprintf (file, text);

#ifdef	WINENCODE
				Recoding (cd_win, cd_dos, ptr + sslen);
#endif
				for (int i = sslen + (b_sortprefix ? 5 : 1); i < len; ++i) {
					ACE_OS::fprintf (file, "%c", ptr [i]);
					if (ptr [i] == '\\')
						i += b_sortprefix ? 4 : 0;
				}

				ACE_OS::fprintf (file, "\n");
			}
			gk_free (ptr);
		}
	}
	/*
	long count;

	Base* base = dynamic_cast <Base*> (doc->base);

	Core::Aptr <char, DataDestructor> data (
		IndexDataLoader <char> (false).load (base, doc->DocId, tag, count)
	);
	
	if (data.ptr () && count > 0) {
		char buffer [20];

		size_t sslen, len, i;

		ACE_OS::sprintf (buffer, "%d", sub);
		sslen = ACE_OS::strlen (buffer);

		char* ptr = data.ptr ();

		while (count > 0) {
			len = ACE_OS::strlen (ptr);

			if (ACE_OS::strncmp (ptr, buffer, sslen) == 0 && ptr [sslen] == ':') {
				ACE_OS::fprintf (file, text);

#ifdef	WINENCODE
				Recoding (cd_win, cd_dos, ptr + sslen + 5);
#endif
				for (i = sslen + 5; i < len; ++i) {
					ACE_OS::fprintf (file, "%c", ptr [i]);
					if (ptr [i] == '\\') {
						i += 4;
					} 
				}

				ACE_OS::fprintf (file, "\n");
			}

			count -= (len + 1);
			ptr += (len + 1);
		}
	}
	*/
}

void out_contents (const Document* doc, FILE* file, const int sub, const int tag, const char* text) {
	long count;
	Core::Aptr <char, DataDestructor> data (IndexDataLoader <char> (false).load (dynamic_cast <Base*> (doc->base), doc->DocId, tag, count));
	if (data.ptr () && count > 0) {
		char* d = (char*) data.ptr ();
		for ( ; count; count -= sizeof( ContentsStruct ), d += sizeof (ContentsStruct)) {
			if ( ((ContentsStruct*)d)->Sub == sub ) {
				ACE_OS::fprintf (file, "!CONTENTS %d %d\n", ((ContentsStruct*)d)->Size, ((ContentsStruct*)d)->Extended );
				break;
			}
		}
	}
}

void out_annodata (const Document* doc, FILE* file, const int tag, const char* text) {
	int sub = 0;
	long count;

	Base* base = dynamic_cast <Base*> (doc->base);

	Core::Aptr <char, DataDestructor> data (
		IndexDataLoader <char> (false).load (base, doc->DocId-ID_ANNOPLUS, tag, count)
	);
	
	if (data.ptr () && count > 0) {
		char* ptr = data.ptr ();
		while (count > 0) {
			size_t len = ACE_OS::strlen (ptr), i;

#ifdef	WINENCODE
			Recoding (cd_win, cd_dos, ptr);
#endif
			ACE_OS::fprintf (file, text);

			for (i = 4; i < len; ++i) {
				ACE_OS::fprintf (file, "%c", ptr [i]);
				if (ptr [i] == '\\') {
					i += 4;
				} 
			}

			ACE_OS::fprintf (file, "\n");

			count -= (len + 1);
			ptr += (len + 1);
		}
	}
}

struct	SubDesc2
{
	long	block;
	long	from, to;
};

long	in_table = 0;
std::stack<long> table_types;

void out_block (Document* doc, FILE* file, SubDesc2* ptr) {
	const size_t max_sub_name_len = DOC_NAME_SIZE + SUB_NAME_SIZE;

	long len = 0, block = ptr->block;	

	char sub_name [max_sub_name_len];

	len = doc->base->FindSubName (doc->DocId, block, sub_name);

	if (len < 0) {
		Log.printf (lt_info, "ERROR! Invalid sub's name lenght: doc %ld\n", doc->DocId);
		return;
	} else {
		sub_name [len] = '\0';

		if (len > SUB_NAME_SIZE) {
			Log.printf (lt_info, "WARNING! Name of sub %ld is very long: len %ld: doc %ld\n", block, len, doc->DocId);
		}
	}

#ifdef	WINENCODE
	Recoding (cd_win, cd_dos, sub_name);
#endif

	ACE_OS::fprintf (file, "!BLOCK %d %s\n", block, sub_name);

	//::out_data (doc, file, block, IDD_DOCKIND, "!PREFIX ");
	::out_data (doc, file, block, IDD_KIND, "!KIND ");
	::out_data (doc, file, block, IDD_DIV    , "!CLASS ");
	::out_data (doc, file, block, IDD_TYPE   , "!TYPE ");
	::out_data (doc, file, block, IDD_SERVICEINFO, "!SERVICEINFO ");
	::out_contents (doc, file, block, IDD_CONTENTS,"!CONTENTS ");

	if (ptr->from == ptr->to) {
		//пустой блок?
		ACE_OS::fprintf (file, "!BLOCKEND %d\n", block);
	}
}

bool	out_blockend (Document* doc, FILE* file, SubDesc2* ptr) {
	if (ptr->from != ptr->to) {
		ACE_OS::fprintf (file, "!BLOCKEND %d\n", ptr->block);
		return true;
	} else {
		return false;
	}
}

void out_sub (Document* doc, FILE* file, const int sub) {
	char sub_name [SUB_NAME_SIZE];
	doc->base->FindSubName (doc->DocId, sub, sub_name);
#ifdef	WINENCODE
	Recoding (cd_win, cd_dos, sub_name);
#endif
	ACE_OS::fprintf (file, "!SUB %d %s\n", sub, sub_name);

	//::out_data (doc, file, sub, IDD_DOCKIND, "!PREFIX ");
	::out_data (doc, file, sub, IDD_KIND, "!KIND ");
	::out_data (doc, file, sub, IDD_DIV    , "!CLASS ");
	::out_data (doc, file, sub, IDD_TYPE   , "!TYPE ");
	::out_data (doc, file, sub, IDD_SERVICEINFO, "!SERVICEINFO ");
	::out_contents (doc, file, sub, IDD_CONTENTS,"!CONTENTS ");
}

int sortSubDesc2( const void *a, const void *b )
{
	SubDesc2* s1 = (SubDesc2*) a;
	SubDesc2* s2 = (SubDesc2*) b;
	int s;
	s = s1->from - s2->from;
	if ( s != 0 ) return s;
	s = ( s2->to - s2->from ) - ( s1->to - s1->from );
	if ( s != 0 ) return s;
	s = s2->to - s1->to;
	if ( s != 0 ) return s;
	return s2->block - s1->block;
}

std::map<long,std::vector <DocStruct*> > map_para_docstructs;

SubDesc2* Construct (DocStruct* subs, long structs_count, long& blockscount, std::set<long>& set_blocks)
{
	map_para_docstructs.clear ();

	SubDesc2*	blocks = 0;
	blockscount = 0;
	DocStruct* structs_ptr = subs;

	for (int i = 0; i < structs_count; i++, structs_ptr++) {
		short evd_type = (short) ((structs_ptr->m_para_list_type >> 24) & 0xFF);
		if (evd_type == SUBDESCEX_BLOCK) {
			long block = structs_ptr->m_para_list_id;

			blocks = (SubDesc2*) realloc (blocks, (blockscount+1) * sizeof (SubDesc2));
			blocks [blockscount].block = block;
			blocks [blockscount].from = structs_ptr->m_start_para;
			blocks [blockscount].to = structs_ptr->m_end_para + 1;
			blockscount++;

			set_blocks.insert (block);
		}

		int j = structs_ptr->m_start_para;
		if (map_para_docstructs.find (j) == map_para_docstructs.end ()) {
			std::vector<DocStruct*> ds_vector;
			ds_vector.push_back (structs_ptr);
			map_para_docstructs.insert (std::map<long, std::vector<DocStruct*> >::value_type (j, ds_vector));
		} else {
			map_para_docstructs.find (j)->second.push_back (structs_ptr);
		}

		if (structs_ptr->m_start_para != structs_ptr->m_end_para) {
			j = structs_ptr->m_end_para;
			if (map_para_docstructs.find (j) == map_para_docstructs.end ()) {
				std::vector<DocStruct*> ds_vector;
				ds_vector.push_back (structs_ptr);
				map_para_docstructs.insert (std::map<long, std::vector<DocStruct*> >::value_type (j, ds_vector));
			} else {
				map_para_docstructs.find (j)->second.push_back (structs_ptr);
			}
		}
	}

	qsort( blocks, blockscount, sizeof( SubDesc2 ), sortSubDesc2 );

	return blocks;
}

int	para_compare_subdesc (const void* p1, const void* p2)
{
	int s = ((SubDesc*)p1)->Para - ((SubDesc*)p2)->Para;
	if (!s) s = ((SubDesc*)p1)->Sub - ((SubDesc*)p2)->Sub;
	return s;
}

extern	std::map<long,std::string> map_blob_name;

void out_text (Document* doc, FILE* file, EndtTools::EndtParser* parser) {
	while (table_types.size ())
		table_types.pop ();
	in_table = 0;

	long i = -1, j, ds_count = 0, subs_count, blocks_count, ids_count = 0, para_count = doc->Stat.ParaCount;

	long idd_divivision_size;
	char* idd_division = (char*)doc->base->LoadAttr (doc->DocId, IDD_DIVISION, idd_divivision_size), *div_ptr = idd_division;
	std::map<long,std::string> map_para_division;
	if (idd_divivision_size) {
		while (div_ptr - idd_division < idd_divivision_size) {
			DivisionInfo* d = (DivisionInfo*) div_ptr;
			const char* text = div_ptr + sizeof(d->Para) + sizeof(d->Symbol);
			if (d->Symbol) {
				char str [32];
				sprintf (str, "!DIVISION %c %s\n", d->Symbol, text);
				map_para_division.insert (std::map<long,std::string>::value_type (d->Para, str)); 
			} else {
				map_para_division.insert (std::map<long,std::string>::value_type (d->Para, "!DIVISION\n")); 
			}
			div_ptr += strlen (text) + 1 + sizeof(d->Para) + sizeof(d->Symbol);
		}
		gk_free (idd_division);
	}

	INDEX_DATA (DocStruct) ds = IndexLoader (doc->base).load <DocStruct> (doc->DocId, IDD_DOCSTRUCT, ds_count);
	INDEX_DATA (long) para_ids = IndexLoader (doc->base).load <long> (doc->DocId, IDD2_PARAIDS, ids_count);
	INDEX_DATA (SubDesc) subs = IndexLoader (doc->base).load <SubDesc> (doc->DocId, IDD_SUBS, subs_count);

	EndtTools::TableInfo info;
	parser->decompile_table (doc->DocId, info);

	SubDesc2* block;
	std::set<long> set_blocks;
	block = Construct (ds.in (), ds_count, blocks_count, set_blocks);
	std::set <long> blocks, blockends;

	qsort (subs.ptr (), subs_count, sizeof (SubDesc), para_compare_subdesc);
	long last_subs_pos = 0;
	SubDesc* last_subs_ptr = subs.ptr ();
	std::set<long> paras_with_blocks, paras_with_subs;
	for (j = 0; j < blocks_count; ++j) {
		paras_with_blocks.insert (block [j].from);
		paras_with_blocks.insert (block [j].to);
	}
	for (j = 0; j < subs_count; j++, last_subs_ptr++) {
		long sub = last_subs_ptr->Sub;
		if (set_blocks.find (sub) == set_blocks.end ())
			paras_with_subs.insert (last_subs_ptr->Para);
	}
	last_subs_ptr = subs.ptr ();

	try {
		for (i = 0; i <= para_count; ++i) {
			if (paras_with_blocks.find (i) != paras_with_blocks.end ()) {
				for (j = blocks_count - 1; j >= 0; --j) {
					long lblock = block [j].block;
					if (block [j].to == i && !in_table && (blockends.find (lblock) == blockends.end ()) && (blocks.find (lblock) != blocks.end ())) {
						if (out_blockend (doc, file, &block [j]))
							blockends.insert (lblock);
					}
				}

				for (j = 0; j < blocks_count; ++j) {
					long lblock = block [j].block;
					if (block [j].from == i && !in_table && (blocks.find (lblock) == blocks.end ())) {
						out_block (doc, file, &block [j]);
						blocks.insert (lblock);
					}
				}
			}

			if (ds_count && map_para_docstructs.find (i) != map_para_docstructs.end ()) {
				std::vector<DocStruct*> ds_vector = map_para_docstructs.find (i)->second;
				for (std::vector<DocStruct*>::const_iterator ds_vector_it = ds_vector.begin (); ds_vector_it != ds_vector.end (); ds_vector_it++) {
					DocStruct *at_it = *ds_vector_it;
					if (at_it->m_start_para != i)
						continue;
					short evd_type = (short) ((at_it->m_para_list_type >> 24) & 0xFF);
					if (evd_type == SUBDESCEX_TABLE || evd_type == SUBDESCEX_SBS) {
						in_table++;
						table_types.push (evd_type);
						ACE_OS::fprintf (file, "!TABLE %ld\n", evd_type == SUBDESCEX_TABLE ? 0 : 1);
						long table_id = at_it->m_para_list_id;
						if (info.find (table_id) != info.end ()) {
							std::string table_str = info.find (table_id)->second;
							long indent, zoom;
							sscanf (table_str.c_str (), "TABLE %ld %ld", &indent, &zoom);
							if (indent) ACE_OS::fprintf (file, "!LEFTINDENT %ld\n", indent);
							if (zoom) ACE_OS::fprintf (file, "!ZOOM %ld\n", zoom);
						}
					} else if (evd_type == SUBDESCEX_STRING || evd_type == SUBDESCEX_SBSSTRING) {
						ACE_OS::fprintf (file, "!ROW\n");
					} else if (evd_type == SUBDESCEX_CELL || evd_type == SUBDESCEX_SBSCELL) {
						long table_type = table_types.top ();
						long cell_id = at_it->m_para_list_id;
						std::string cell_str = info.find (cell_id)->second;
						char cell_frames [5]; cell_frames [4] = 0;
						strncpy (cell_frames, strrchr (cell_str.c_str (), ' ') + 1, 4);
						if (!strcmp (cell_frames, "2222")) {
							if (evd_type == SUBDESCEX_CELL)
								strcpy (cell_frames, "1111");
							else
								strcpy (cell_frames, "0000");
						} else {
							for (int ii = 0; ii < 4; ii++)
								if (cell_frames [ii] == '2')
									cell_frames [ii] = '0';
						}
						long width, merge, align;
						sscanf (cell_str.c_str (), "CELL %ld %ld %ld", &width, &merge, &align);
						ACE_OS::fprintf (file, "!CELL %ld %s %ld %ld\n", width, cell_frames, merge, align);
					}
					if (!in_table) {
						if (evd_type == SUBDESCEX_BLOCKEND) {
							for (long jj = blocks_count - 1; jj >= 0; --jj) {
								long lblock = block [jj].block;
								if (block [jj].to == i && (blocks.find (lblock) != blocks.end ()) && (blockends.find (lblock) == blockends.end ())) {
									if (out_blockend (doc, file, &block [jj]))
										blockends.insert (lblock);
								}
							}
						}

						if (evd_type == SUBDESCEX_BLOCK) {
							for (long jj = 0; jj < blocks_count; ++jj) {
								long lblock = block [jj].block;
								if (block [jj].from == i && (blocks.find (lblock) == blocks.end ())) {
									out_block (doc, file, &block [jj]);
									blocks.insert (lblock);
								}
							}
						}
					}
				}
			}

			if (paras_with_subs.find (i) != paras_with_subs.end ()) {
				for (j = last_subs_pos; j < subs_count && last_subs_ptr->Para <= i; j++, last_subs_pos++, last_subs_ptr++) {
					long sub = last_subs_ptr->Sub;
					if (set_blocks.find (sub) == set_blocks.end () && last_subs_ptr->Para == i)
						out_sub (doc, file, sub);
				}
			}

			if (paras_with_blocks.find (i) != paras_with_blocks.end ()) {
				for (j = blocks_count - 1; j >= 0; --j) {
					long lblock = block [j].block;
					if (block [j].to == i && (blocks.find (lblock) != blocks.end ()) && (blockends.find (lblock) == blockends.end ())) {
						if (out_blockend (doc, file, &block [j]))
							blockends.insert (lblock);
					}
				}

				for (j = 0; j < blocks_count; ++j) {
					long lblock = block [j].block;
					if (block [j].from == i && (blocks.find (lblock) == blocks.end ())) {
						out_block (doc, file, &block [j]);
						blocks.insert (lblock);
					}
				}
			}

			if (i < para_count) {
				if (map_para_division.find (i) != map_para_division.end ()) {
					ACE_OS::fprintf (file, map_para_division.find (i)->second.c_str (), &map_blob_name);
				} else {
					Core::Aptr <EndtTools::NsrcData> data = parser->get_nsrc_data (doc, i, &map_blob_name);

					if (para_ids.ptr () && para_ids.ptr () [i] == 0) {
						ACE_OS::fprintf (file, "\n");
					} else if (data.ptr () && data->is_valid ()) {
						char *text = strdup (data->get_text ()), *ptr = text;
						for (;*ptr;ptr++)
							if (*ptr == 10)
								*ptr = 29;
						ACE_OS::fprintf (file, "%s\n%s\n", data->get_style (), text);
						free (text);
					}
				}
			}

			if (ds_count && map_para_docstructs.find (i) != map_para_docstructs.end ()) {
				std::vector<DocStruct*> ds_vector = map_para_docstructs.find (i)->second;
				for (std::vector<DocStruct*>::reverse_iterator ds_vector_it = ds_vector.rbegin (); ds_vector_it != ds_vector.rend (); ds_vector_it++) {
					DocStruct *at_it = *ds_vector_it;
					if (at_it->m_end_para != i)
						continue;
					short evd_type = (short) ((at_it->m_para_list_type >> 24) & 0xFF);
					if (evd_type == SUBDESCEX_CELL || evd_type == SUBDESCEX_SBSCELL) {
						ACE_OS::fprintf (file, "!CELLEND\n");
					} else if (evd_type == SUBDESCEX_STRING || evd_type == SUBDESCEX_SBSSTRING) {
						ACE_OS::fprintf (file, "!ROWEND\n");
					} else if (evd_type == SUBDESCEX_TABLE || evd_type == SUBDESCEX_SBS) {
						ACE_OS::fprintf (file, "!TABLEEND\n");
						in_table--;
						table_types.pop ();
					}
				}
			}
		}
	} catch (...) {
#ifdef _DEBUG
		LOG_UEX (("%s: para %ld, doc %ld", GDS_CURRENT_FUNCTION, i, doc->DocId));
#endif

		Log.printf (
			lt_info
			, "\nERROR! %s: unknown exeption handled: para %ld, doc %ld\n"
			, GDS_CURRENT_FUNCTION
			, i
			, doc->DocId
		);
	}

	free (block);
}
