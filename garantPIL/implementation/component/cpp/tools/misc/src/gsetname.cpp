#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstring>
#include <cstdlib>
//#include <unistd.h>
#include <cctype>

#include "shared/Core/os/IniFile.h"

#include "stdbase.h"
#include "index.h"
#include "gardefs.h"
#include "garver.h"
#include <cstring>
#include "basemask.h"
#include "recode.h"

#include <getopt.h>
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

#define RM_HELP  128
#define RM_READ  1
#define RM_WRITE 2
#define RM_ENG	 64
#define RM_RUS	 32

static void usage(char *);
static int parse_cmdline(int argc, char **argv);

int get_baseinfo(const char *base_name, const char *out_file, int isEng);
int set_baseinfo(const char *base_name, const char *name_file, int isEng);

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

bool	b_flash = false;

int main_logic ( int argc, char *argv[] )
{
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GSETNAME;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GSETNAME Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	int mode = 0;

	if (argc < 4) {
		usage(argv[0]);
		return 0;
	}
	
	if(!(mode = parse_cmdline(argc, argv))) {
		fprintf(stderr, "Nothing to do: '-r' or '-w' required.\n");
		fprintf(stderr, "Use '-h' option to get help.\n");
		return -1;
	};
	if ((mode & ~RM_ENG) == RM_HELP) {
		// usage();
		return 0;
	}
	if ((mode & ~RM_ENG) == RM_READ) {
		get_baseinfo(argv[optind], argv[optind+1], mode & RM_ENG);
	}
	else if((mode & ~RM_ENG) == RM_WRITE)
		set_baseinfo(argv[optind], argv[optind+1], mode & RM_ENG);
	return 0;
}

static char *mkfname(const char *name, const char *ext);

int get_baseinfo(const char *base_name, const char *out_file, int isEng)
{
	BaseInfo *bi;
	int bicount, hcount, i, j;
	YBase *base;
	Index *aux;
	char *keyname, *strname;
	Core::IniFile *of;
	u_int16_t *heres;
	Stream *str;

	keyname = mkfname(base_name, "key");
	strname = mkfname(base_name, "str");
	//base = new YBase(keyname, strname, 0, ACE_OS_O_RDONLY, 20, 20, 0);
	base = new YBase(base_name,ACE_OS_O_RDONLY);
	if (!base || !base->IsOk()) {
		free(keyname);
		free(strname);
		return -3;
	}
	// Create output file...
	of = new Core::IniFile((char *)out_file);
	aux = base->FindIndex("Aux");
	str = aux->Open("Here");
	heres = (u_int16_t *)malloc(str->Length());
	hcount = str->Length() >> 1;
	of->WriteProfileInt("Base", "Count", hcount);
	str->Read(heres, str->Length());
	aux->Close(str);
	str = aux->Open("Base");
	bi = (BaseInfo *)malloc(str->Length());
	bicount = str->Length()/sizeof(BaseInfo);
	str->Read(bi, bicount*sizeof(BaseInfo));
	aux->Close(str);
	if(bi->BaseId == 0) {
		if (isEng)
			of->WriteProfileString("Base", "Name", bi->NameEng);
		else
			of->WriteProfileString("Base", "Name", bi->Name);
		j = 1;
	}
	else {
		of->WriteProfileString("Base", "Name", "");
		j = 0;
	}
	for (i=0; i<hcount; i++) {
		for (; j<bicount && heres[i] != bi[j].BaseId; j++)
			;
		char segname[20];
		sprintf(segname, "Segment%d", i+1);
		if (isEng)
			of->WriteProfileString("Contents", segname, bi[j].NameEng);
		else
			of->WriteProfileString("Contents", segname, bi[j].Name);
	}
    free(strname);
    free(keyname);
	free(heres);
	free(bi);
	delete base;
	delete of;
	return 0;
}

static int unpackPFile ( PagedFile *of, PagedFile *nf )
{
    nf -> LastPage     = of -> LastPage;
    nf -> FreePage     = of -> FreePage;
    nf -> lastFreePage = of -> lastFreePage;
    nf -> AttrOffs     = of -> AttrOffs;

    memcpy (nf -> SystemPageBuf, of -> SystemPageBuf, of -> PageSize);

	if(((PagedFileHeader*)nf->SystemPageBuf)->TomPerPages)
		nf->m_max_paged_file_per_bytes = ((PagedFileHeader*)nf->SystemPageBuf)->TomPerPages * nf->PageSize;
	else
		nf->m_max_paged_file_per_bytes = MAX_BYTE_FILE_SIZE;

	nf->m_mode ^= ACE_OS_O_CREAT;

	if(nf -> GetAttr ( ID_PACKED, 0, 0 ))
		nf -> DelAttr ( ID_PACKED );
	else
		nf -> DelAttr ( ID_PACKED_NEW );

    if ( of -> LastPage == 0 )
		return 1;

    u_int32_t nPackPages = of -> LastPage;
    u_int16_t pageSize   = of -> PageSize;

    int pc = -1;
	char *pbuf= (char*)malloc(of -> PageSize);
	if(pbuf == 0)
		return 1;

    for ( u_int32_t i = 1; i <= nPackPages; i++ ) {
		if(!of -> GetPage(i, pbuf))
			return 1;

		if(!nf -> PutPage ( i, pbuf ))
			return 1;
    }
    free ( pbuf );

    return 0;
}

int compare9 (const void *arg1, const void *arg2)
{
   return (memcmp (arg1, arg2, 9));
}

int compare4 (const void *arg1, const void *arg2)
{
   return (memcmp (arg1, arg2, 4));
}

#include "packfile.h"

int set_baseinfo(const char *base_name, const char *name_file, int isEng)
{
	{
		YBase* abase = new YBase (base_name, ACE_OS_O_RDONLY);
		abase->IsOk ();
		char in9tr [MPCXC_MAX_PATH], *fndE; //GARFB
		if(abase->IsOk()){
			Index *Indx= abase->FindIndexOther("Aux.str");
			if(!Indx){
				delete abase;
				return -1;
			}
			strcpy(in9tr, Indx->streams->file->FileName);
			fndE= strrchr (in9tr, '.')+1;
		}else{
			delete abase;
			return -1;
		}
		bool packed = abase->IsPacked ();
		long bases_length = 0;
		{
		Stream *str = abase->FindIndex("Aux")->Open ("Base");
		if (str) {
			bases_length = str->Length ();
			abase->FindIndex("Aux")->Close (str);
		}
		}
		delete abase;
		if (packed) {
			long tmon = 0, tmwr = 0, vip = 0;
			std::vector<long> percents;
			char code [48];
			gk_bzero (code, sizeof (code));
#ifdef	__FreeBSD__
			printf ("gsetname on packed bases works only in Win32\n");
#else
			char cache_temp_dir [MAX_PATH];
			DWORD dwBufSize = MAX_PATH, dwRetVal = GetTempPath (dwBufSize, cache_temp_dir);

			char temp_name [MAX_PATH], *fndR= (char*)strrchr (base_name, '\\');

			if (fndR) {
				if (!GetTempFileName (cache_temp_dir, fndR+1, 0, temp_name))
					return 0;
			} else {
				if (!GetTempFileName (cache_temp_dir, base_name, 0, temp_name))
					return 0;
			}
			_unlink (temp_name);
			strcpy (strrchr (temp_name, '.')+1, fndE);

			printf ("step1: unpack %s in %s\n", in9tr, temp_name);

			PagedFile		*in		= new PagedFile		( in9tr,	ACE_OS_O_RDONLY	);
			CompressedFile	*out	= new CompressedFile( temp_name );

			long offset = 0, to_read = in->PageSize;

			out->Create (in->PageSize);
			unpackPFile (in, out);
			delete in;

			bool b_found = false;
			printf ("step2: find signature\n");
			FILE* file2modify = mpcxc_fopen (temp_name, "rb");
			char* buffer = new char [to_read + 16], *key = "1990-2001";
			while (fread (buffer, 1, to_read, file2modify)) {
				unsigned int to_search = to_read;
				char* q = (char*) _lsearch (key, buffer, &to_search, 1, compare9);
				if (to_search != to_read + 1) {
					offset += 2;
					b_found = true;
					break;
				}
				offset += to_read;
			}
			fclose (file2modify);
			
			if (b_found) {
				printf ("step3: read new name from %s\n", name_file);
				char *new_name = (char*) malloc (2048), *s;
				FILE* inf = mpcxc_fopen (name_file, "r");
				bzero (new_name, 2048);
				fgets (new_name, 2048, inf);
				s = strchr (new_name, '\n');
				if (s) *s = '\0';
				new_name [	BASE_NAME_SIZE-1] = '\0';
				Recoding(cd_dos,cd_win,new_name);

				printf ("step4: writing new name %s\n", new_name);
				file2modify = mpcxc_fopen (temp_name, "r+b");
				fseek (file2modify, offset + (isEng & RM_ENG ? BASE_NAME_SIZE : 0), ACE_OS_SEEK_SET);
				fwrite (new_name, strlen (new_name) + 1, 1, file2modify);
				BaseInfo baseinfo;
				long username_offset = (long) ((char*)&baseinfo.UserName - (char*)&baseinfo.BaseId) - sizeof (baseinfo.BaseId);
				fseek (file2modify, offset + username_offset, ACE_OS_SEEK_SET);
				short username = 1;
				fwrite (&username, sizeof (short), 1, file2modify);
				fflush (file2modify);

				if (!isEng) while (!feof (inf)) {
					bzero(new_name, BASE_NAME_SIZE);
					fgets(new_name, BASE_NAME_SIZE, inf);
					new_name[BASE_NAME_SIZE-1] = '\0';
					if (!new_name [0])
						continue;

					short id = 0;
					if (strstr (new_name, "period=")) {
						tmon = atol (strchr (new_name, '=') + 1);
						if (strchr (new_name, '|'))
							strcpy (code, strchr (new_name, '|') + 1);
						continue;
					} else if (strstr (new_name, "tmwr=")) {
						tmwr = atol (strchr (new_name, '=') + 1);
						if (strstr (new_name, "vip="))
							vip = atol (strstr (new_name, "vip=") + 4);
						if (strstr (new_name, "complect=")) {
							std::vector<std::string> parts;
							std::string str = strstr (new_name, "complect=") + 9;
							boost::split (parts, str, boost::is_any_of (","));
							for (std::vector<std::string>::const_iterator it = parts.begin (); it != parts.end (); it++) {
								if (it->size ())
									percents.push_back (atol (it->c_str ()));
							}
						}
						continue;
					} else if (strstr (new_name, "vip=")) {
						vip = atol (strstr (new_name, "vip=") + 4);
						if (strstr (new_name, "complect=")) {
							std::vector<std::string> parts;
							std::string str = strstr (new_name, "complect=") + 9;
							boost::split (parts, str, boost::is_any_of (","));
							for (std::vector<std::string>::const_iterator it = parts.begin (); it != parts.end (); it++) {
								if (it->size ())
									percents.push_back (atol (it->c_str ()));
							}
						}
						continue;
					} else {
						id = (short) (atol (new_name) & 0xFFFF);
					}
					fseek (file2modify, offset - 2 /*short BaseId*/, ACE_OS_SEEK_SET);

					for (int i = 0, blen= bases_length / (long)(sizeof (BaseInfo) & 0x7fffffff); i < blen; i++) {
						short base_id;
						fread (&base_id, sizeof (base_id), 1, file2modify);
						if (base_id == id) {
							char name [BASE_NAME_SIZE];
							fread (name, BASE_NAME_SIZE, 1, file2modify);
							fseek (file2modify, -BASE_NAME_SIZE, ACE_OS_SEEK_CUR);
							if (strstr (name, STR_TRIAL_VERSION))
								break;
							strcpy (name + std::min <long> (strlen (name), BASE_NAME_SIZE - strlen (STR_TRIAL_VERSION) - 5), STR_TRIAL_VERSION);
							fwrite (name, BASE_NAME_SIZE, 1, file2modify);
						} else {
							fseek (file2modify, sizeof (BaseInfo) - sizeof (base_id), ACE_OS_SEEK_CUR);
						}
					}
				}

				fclose (inf);

				fclose (file2modify);

				if (b_flash) {
					printf ("step5: repack %s\n", temp_name);
					out->PackOldFile (out);

					printf ("step6: flash: copy %s to %s\n", temp_name, in9tr);
					char *exts[] = {"9tr", "9t0", "9t1", "9t2"};
					delete out;
					for (int i = 0; i < sizeof (exts) / sizeof (char*); i++) {
						strcpy (strrchr (temp_name, '.') + 1, exts [i]);
						strcpy (strrchr (in9tr, '.') + 1, exts [i]);
						FILE* chk_file = fopen (in9tr, "rb");
						if (chk_file) {
							fclose (chk_file);
						} else {
							break;
						}
						FILE* in_file = fopen (temp_name, "rb");
						if (in_file) {
							_unlink (in9tr);
							FILE* out_file = fopen (in9tr, "wb");
							if (out_file) {
								unsigned const int to_read = 256 * 1024;
								char* buffer [to_read];
								while (!feof (in_file)) {
									long buffer_size = to_read;
									buffer_size = fread (buffer, 1, buffer_size, in_file);
									fwrite (buffer, 1, buffer_size, out_file);
								}
								fclose (in_file);
								unlink (temp_name);
								fclose (out_file);
							} else {
								return 1;
							}
						}
					}
					strcpy (strrchr (temp_name, '.') + 1, "0ey");
				} else {
					printf ("step5: repack %s in %s\n", temp_name, in9tr);
					_unlink (in9tr);
					PagedFile *out1 = new PagedFile (in9tr, ACE_OS_O_RDWR);
					out1->Create (out->PageSize);
					out->PackOldFile (out1);
					out->Remove();
					delete out;
					delete out1;
				}
			}

			if (tmon || tmwr || code [0] || vip || percents.size ()) {
				//записать в data.0ey еще и Aux.TmOn/TmWr
				strcpy (strrchr (in9tr, '.'), ".0ey");

				printf ("step7: unpack %s in %s\n", in9tr, temp_name);
				_unlink (temp_name);

				PagedFile		*in		= new PagedFile		( in9tr,	ACE_OS_O_RDONLY	);
				CompressedFile	*out	= new CompressedFile( temp_name );
				int pagesize = in->PageSize;

				out->Create (in->PageSize);
				unpackPFile (in, out);
				delete in;

				if (tmon) {
					long offset = 0, to_read = pagesize;
					b_found = false;
					FILE* file2modify = mpcxc_fopen (temp_name, "rb");
					char* buffer = new char [to_read + 16], *key = "TmOn";
					while (fread (buffer, 1, to_read, file2modify)) {
						unsigned int to_search = to_read;
						char* q = (char*) _lsearch (key, buffer, &to_search, 1, compare4);
						if (to_search != to_read + 1) {
							offset += q - buffer;
							b_found = true;
							break;
						}
						offset += to_read;
					}
					fclose (file2modify);
					if (b_found) {
						file2modify = mpcxc_fopen (temp_name, "r+b");
						fseek (file2modify, offset + 13, ACE_OS_SEEK_SET);
						fwrite (&tmon, sizeof (tmon), 1, file2modify);
						fflush (file2modify);
						fclose (file2modify);
					}
				}
				if (tmwr) {
					long offset = 0, to_read = pagesize;
					b_found = false;
					FILE* file2modify = mpcxc_fopen (temp_name, "rb");
					char* buffer = new char [to_read + 16], *key = "TMWR";
					while (fread (buffer, 1, to_read, file2modify)) {
						unsigned int to_search = to_read;
						char* q = (char*) _lsearch (key, buffer, &to_search, 1, compare4);
						if (to_search != to_read + 1) {
							offset += q - buffer;
							b_found = true;
							break;
						}
						offset += to_read;
					}
					fclose (file2modify);

					if (b_found) {
						file2modify = mpcxc_fopen (temp_name, "r+b");
						fseek (file2modify, offset + 13, ACE_OS_SEEK_SET);
						fwrite (&tmwr, sizeof (tmwr), 1, file2modify);
						fflush (file2modify);
						fclose (file2modify);
					}
				}
				if (vip) {
					long offset = 0, to_read = pagesize;
					b_found = false;
					FILE* file2modify = mpcxc_fopen (temp_name, "rb");
					char* buffer = new char [to_read + 16], *key = AUX_VIP;
					while (fread (buffer, 1, to_read, file2modify)) {
						unsigned int to_search = to_read;
						char* q = (char*) _lsearch (key, buffer, &to_search, 1, compare4);
						if (to_search != to_read + 1) {
							offset += q - buffer;
							b_found = true;
							break;
						}
						offset += to_read;
					}
					fclose (file2modify);

					if (b_found) {
						file2modify = mpcxc_fopen (temp_name, "r+b");
						fseek (file2modify, offset + 13, ACE_OS_SEEK_SET);
						fwrite (&vip, sizeof (vip), 1, file2modify);
						fflush (file2modify);
						fclose (file2modify);
					}
				}
				if (percents.size ()) {
					long i = 0;
					std::vector<long>::const_iterator it;
					for (i = 0, it = percents.begin (); it != percents.end (); it++, i++) {
						char key [5];
						sprintf (key, "%%%%%%%X", i);

						std::set<long> offsets;

						long offset = 0, to_read = pagesize;
						FILE* file2modify = mpcxc_fopen (temp_name, "rb");
						char* buffer = new char [to_read + 16];
						while (fread (buffer, 1, to_read, file2modify)) {
							unsigned int to_search = to_read;
							char* q = (char*) _lsearch (key, buffer, &to_search, 1, compare4);
							if (to_search != to_read + 1) {
								long new_offset = offset + q - buffer;
								if (offsets.find (new_offset) == offsets.end ())
									offsets.insert (new_offset);
							}
							offset += to_read;
						}
						fclose (file2modify);

						if (offsets.size ()) {
							file2modify = mpcxc_fopen (temp_name, "r+b");
							for (std::set<long>::const_iterator oit = offsets.begin (); oit != offsets.end (); oit++) {
								offset = *oit;
								fseek (file2modify, offset + 13, ACE_OS_SEEK_SET);
								long perc = *it;
								fwrite (&perc, sizeof (perc), 1, file2modify);
								fflush (file2modify);
							}
							fclose (file2modify);
						}
					}
				}
				if (code) {
					for (int i = 0; i < 48 / 4; i++) {
						char key [5];
						sprintf (key, "PRO%X", i);

						std::set<long> offsets;

						long offset = 0, to_read = pagesize;
						FILE* file2modify = mpcxc_fopen (temp_name, "rb");
						char* buffer = new char [to_read + 16];
						while (fread (buffer, 1, to_read, file2modify)) {
							unsigned int to_search = to_read;
							char* q = (char*) _lsearch (key, buffer, &to_search, 1, compare4);
							if (to_search != to_read + 1) {
								long new_offset = offset + q - buffer;
								if (offsets.find (new_offset) == offsets.end ())
									offsets.insert (new_offset);
							}
							offset += to_read;
						}
						fclose (file2modify);

						if (offsets.size ()) {
							file2modify = mpcxc_fopen (temp_name, "r+b");
							for (std::set<long>::const_iterator it = offsets.begin (); it != offsets.end (); it++) {
								offset = *it;
								fseek (file2modify, offset + 13, ACE_OS_SEEK_SET);
								fwrite (code + i * 4, 4, 1, file2modify);
								fflush (file2modify);
							}
							fclose (file2modify);
						}
					}
				}
				if (b_flash) {
					printf ("step8: repack %s\n", temp_name);
					out->PackOldFile (out);

					printf ("step9: flash: copy %s to %s\n", temp_name, in9tr);
					FILE* in_file = fopen (temp_name, "rb");
					out->Remove();
					delete out;
					if (in_file) {
						_unlink (in9tr);
						FILE* out_file = fopen (in9tr, "wb");
						if (out_file) {
							unsigned const int to_read = 256 * 1024;
							char* buffer [to_read];
							while (!feof (in_file)) {
								long buffer_size = to_read;
								buffer_size = fread (buffer, 1, buffer_size, in_file);
								fwrite (buffer, 1, buffer_size, out_file);
							}
							fclose (in_file);
							unlink (temp_name);
							fclose (out_file);
						} else {
							return 1;
						}
					}
				} else {
					printf ("step8: repack %s in %s\n", temp_name, in9tr);
					_unlink (in9tr);
					PagedFile *out1 = new PagedFile (in9tr, ACE_OS_O_RDWR);
					out1->Create (out->PageSize);
					out->PackOldFile (out1);
					out->Remove();
					delete out;
					delete out1;
				}
			}
#endif
			return 0;
		}
	}

	int res;
	Base *base;
	struct BaseInfo superBase;
	FILE *inf;
	Index *aux;
	char *keyname, *strname, *new_name, *s;
	Stream *str;

	keyname = mkfname(base_name, "key");
	strname = mkfname(base_name, "str");

	base = new StdBigBase(base_name, ACE_OS_O_RDWR );

	if (!base || !base->IsOkWithoutText()) {
		free(keyname);
		free(strname);
		fprintf(stderr, "Can't open base %s for writing.\n", base_name);
		return -3;
	}
	aux = base->FindIndex("Aux");
	str = aux->Open("Base");
	str->Read(&superBase, sizeof(superBase));
	if (superBase.BaseId) {
		res = -3;
		fprintf(stderr, "SuperBase info not found in base %s.\n", base_name);
		aux->Close(str);
	} else {
		new_name = (char *)malloc(2048);
		inf = mpcxc_fopen(name_file, "r");
		bzero(new_name, BASE_NAME_SIZE);
		fgets(new_name, 2048, inf);
		new_name[BASE_NAME_SIZE-1] = '\0';
#ifdef	WINENCODE
		Recoding(cd_dos,cd_win,new_name);
#endif
		s = strchr(new_name, '\n');
		if (s) *s = '\0';
		if (isEng & RM_ENG) {
			if (strlen(new_name) > BASE_NAME_SIZE-1)
				fprintf(stderr, "Warning: English name too long and was truncated.\n");
			strncpy(superBase.NameEng, new_name, BASE_NAME_SIZE-1);
			superBase.NameEng[BASE_NAME_SIZE-1] = '\0';
		}
		if (!isEng || (isEng & RM_RUS)) {
			if (strlen(new_name) > BASE_NAME_SIZE-1)
				fprintf(stderr, "Warning: Russian name too long and was truncated.\n");
			strncpy(superBase.Name, new_name, BASE_NAME_SIZE-1);
			superBase.Name[BASE_NAME_SIZE-1] = '\0';
		}
		superBase.UserName = 1;
		str->Seek(0);
		str->Write(&superBase, sizeof(superBase));
		res = 0;

		if (!isEng) while (!feof (inf)) {
			bzero(new_name, BASE_NAME_SIZE);
			fgets(new_name, BASE_NAME_SIZE, inf);
			new_name[BASE_NAME_SIZE-1] = '\0';
			if (!new_name [0])
				continue;
			int id = atol (new_name);
			str->Seek (0);
			while (str->Tell () < str->Length ()) {
				if (str->Read (&superBase, sizeof(superBase)) != sizeof (superBase))
					break;
				if (superBase.BaseId == id) {
					if (strstr (superBase.Name, STR_TRIAL_VERSION))
						break;
					strcpy (superBase.Name + std::min <long> (strlen (superBase.Name), BASE_NAME_SIZE - strlen (STR_TRIAL_VERSION) - 5), STR_TRIAL_VERSION);
					str->SeekCur (0-sizeof (superBase));
					str->Write (&superBase, sizeof(superBase));
				}
			}
		}
		fclose(inf);
		free(new_name);
	}
	aux->Close(str);
	delete base;
	return res;
}

static char *mkfname(const char *name, const char *ext)
{
	char *fullname, *fext;

	fext = (char *)malloc(12);
	*fext = '.';
	strcpy(fext+1, ext);
	fullname = (char *)malloc(strlen(name)+5);
	strcpy(fullname, name);
	strcat(fullname, fext);
	free(fext);
	return fullname;
/*
	len = strlen(name);
	if(!strcmp(fullname+len-4
*/
}

static void usage(char *progname)
{
	printf("GARANT Legacy systems v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
	printf("Usage:\n\t%s [-h] {-r | -w} [-e] basename textname\n", progname);
	printf("\n\tWhere -r used to get base name and segment set in\n");
	printf("\tini-file format written to textname;\n\tand -w user to write");
	printf("name from text file.\n");
	printf("\tUse gsetname -h for help\n");
}

static int parse_cmdline(int argc, char **argv)
{
	int c;
	int mode = 0;
	
	while ((c=getopt(argc, argv, "fhrwe")) != -1) {
		switch(c) {
			case 'f':
				b_flash = true;
				break;
			case 'r':
				if(!mode) mode = RM_READ;
				else if (mode != RM_HELP) {
					printf("Invalid options combination.\n");
					printf("Do not use -r and -w options together.\n");
				}
				break;
			case 'w':
				if(!mode) mode = RM_WRITE;
				else if (mode != RM_HELP) {
					printf("Invalid options combination.\n");
					printf("Do not use -r and -w options together.\n");
				}
				break;
			case 'h':
				mode = RM_HELP;
				break;
			case 'e':
				mode |= RM_ENG;
				break;
			default:
				printf("Unrecognized option. use -h for help.\n");
				return 0;
		}
	}
	return mode;
}