#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "shared/Core/os/IniFile.h"
#include "gardefs.h"
#include "garutils.h"
#include "garver.h"
#include "stdbase.h"
#include "basemask.h"

#include "SearchB.h"
#include "protect.h"

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
	VER_PARAM verParam;
		int	i;

	verParam.exeId= TID_BASEINFO;		// defines BASEMASK.H
	verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
	verParam.stdOut= stdout;
	verParam.pDate= __DATE__;
	verParam.pTime= __TIME__;

	if((i=_imp_GVersion(&argc, argv, &verParam))){
		if(i == VC_ADD_OK){
		}else{
		}
#ifdef _DEBUG
		printf("\n *** BASEINFO Debug Version. For test, only... ***\n\n");
#else
		exit(0);
#endif
	}
	}

	if (argc == 2 ) {
		// fast info
		printf ( "Fast GarBase Info (ver:%s)\n", GARANT_VERSION );
		
		YBase* base = new YBase (argv[1], ACE_OS_O_RDONLY, 0);
		if ( !base || !base->IsOk()) {
			printf("Problems opening base '%s'\n", argv[1]);
			exit(-1);
		}

		Stream *str1 = base->FindIndex("Aux")->Open("Here");
		if (!str1 || !str1->Length()) {
			printf("Error reading key Here for base\n" );
			exit(-1);
		}
		
		long count = str1->Length() / sizeof(short);
		short *here = new short[count];
		str1->Read(here, str1->Length());
		base->FindIndex("Aux")->Close(str1);
		str1= 0;
		
		BaseInfo bi, rbi;
		short notGl = 0;
		
		if (base->FindBaseInfo(0, bi) != sizeof(BaseInfo)) notGl = 1;
		if (base->FindBaseInfo(here[0], rbi) != sizeof(BaseInfo)) {
			printf("Cannot find BaseInfo for %d seg\n", here[0] );
			exit (EXIT_FAILURE);
		}
				
		printf ( "Name (rus)     : %s\n", notGl ? "unknown" : bi.Name);
		printf ( "Name (eng)     : %s\n", notGl ? "unknown" : bi.NameEng);
		printf ( "Here           :" );
		long l;
		for ( l=0; l<count; l++ ) printf ( " %d", here[l] );
		printf ( "\nRevision (null): " );
		notGl ? printf ( "unknown" ) : printRev ( &bi.LastUpdate );
		printf ( "\nRevision (real): " );
		printRev ( &rbi.LastUpdate );
		
		revision rrev = rbi.LastUpdate;
		for ( l=0; l<count; l++ ) {			
			if (base->FindBaseInfo(here[l], rbi) != sizeof(BaseInfo)) {
				printf("Cannot find BaseInfo for %d seg\n", here[0] );
				exit (EXIT_FAILURE);
			}
			if ( CompRevs (&rrev,&rbi.LastUpdate) ) {
				printf ("\n\texcept %d seg: ", here[l]);
				printRev ( &rbi.LastUpdate );
			}
		}
		
		printf ( "\nWeight         : %d\n", notGl ? -1 : bi.Weight);
		printf ( "KEY pack       : %s\n", base->keyFile->IsPacked() ? "yes" : "no" );
		printf ( "STR pack       : %s\n", base->strFile->IsPacked() ? "yes" : "no" );

		printf ("VIP            : %s\n", base->is_vip_base () ? "yes" : "no");

		printf ("Perc           : ");
		std::vector<std::pair <std::string, long> > gauges;
		base->get_percents (gauges);
		for (std::vector<std::pair <std::string, long> >::const_iterator it = gauges.begin (); it != gauges.end (); it++) {
			if (it != gauges.begin ())
				printf (",");
			printf ("%s:%ld", it->first.c_str (), it->second);
		}
		printf ("\n");

		if (base->GetPersInfo ())
			printf ("Pswd           : %s\n", base->GetPersInfo ());

		if (base->GetClientInfo ())
			printf ("KI             : %ld\n", base->GetClientInfo ());

		{
			u_int16_t sid;
			if (base->textFile->GetAttr (BASE_SID, &sid, sizeof (sid)))
				printf ("SID            : %ld\n", (long) sid);
		}

		DocCollection* allDocs = base->AllDocs();
		if ( !allDocs->ItemCount ) {
			delete allDocs;
			allDocs = base->AllTopics(ID_BORDER);
		}
		
		int version = 5;
		if ( allDocs->ItemCount ) {
			int item = 0;
			long docId = (*allDocs)[item];

			while ( item < allDocs->ItemCount && ( docId == 100100 || ( docId >= BIG_INFO_DOC && docId < BIG_INFO_DOC + BIG_INFO_COUNT )))
				docId = (*allDocs)[++item];
			
			DocInfo docInfo;
			base->FindDocInfo( docId, docInfo );
			if ( docInfo.Status & DS_EVD ) {
				version = 6;
				long size;
				void* aParaIDs = base->LoadAttr( docId, IDD2_PARAIDS, size );
				if ( !aParaIDs ) {
					aParaIDs = base->LoadAttrEx( docId, IDD2_PARAIDS, size );
					if ( aParaIDs ) {
						version = 61;
						IndexInfo info;
						if( base->keyFile->GetAttr( "AnnoDate", &info, sizeof (info))) {
							version = 62;
							if ( base->keyFile->GetAttr( "NewCorr", &info, sizeof( info ))) {
								if ( info.immdatasize == 20 ) {
									version = 63;

									long blobid = ID_EVD_ANSWER;
									Stream* blob = base -> FindIndex ("Blob") -> Open (&blobid);
									if (blob) {
										base -> FindIndex ("Blob") -> Close (blob);
										version = 64;

										if ( base->keyFile->GetAttr( "KindCorr", &info, sizeof( info ))) {
											version = 70;

											if (base->keyFile->GetAttr ("PhFirm", &info, sizeof (info))) {
												version = 72;

												if (base->keyFile->GetAttr ("Active", &info, sizeof (info))) {
													version = 74;
													if (base->FindIndex ("Attrs")->file->GetAttr ("CalIn.str", &info, sizeof (info))) {
														version = 77;
														Stream* str = base->FindIndex ("Aux")->Open (AUX_VERSION);
														if (str) {
															long v;
															str->Read (&v, sizeof (long));
															base->FindIndex ("Aux")->Close (str);
															if (v == 708000)
																version = 78;
															else
															if (v == 709000)
																version = 79;
															else
															if (v == 710000)
																version = 710;
															else
															if (v == 711000)
																version = 711;
														}
													} else {
														Stream* str = base->FindIndex ("Aux")->Open (AUX_VERSION);
														if (str) {
															long v;
															str->Read (&v, sizeof (long));
															base->FindIndex ("Aux")->Close (str);
															if (v == 705000)
																version = 75;
															else
															if (v == 706000)
																version = 76;
														}
													}
												} else {
													if (!base->keyFile->GetAttr ("SubName", &info, sizeof (info))) {
														version = 73;
													}
												}
											}
										}
									}
								}
							}
						}
					}
					else
						version = 0;
				}
			}
		}

		if (version == -1)
			printf ( "Version        : bad morpho\n");
		else
			printf ( "Version        : %d\n", version );
		
		delete base;		
		return 0;
	}
	
	if (argc < 3) {
		printf ( "Garant Base Info (ver:%s)\n", GARANT_VERSION );
		printf("Usage: %s <ini-file> <base1> <base2> .. \n", argv[0]);
		printf("   or: %s <base>  - for Fast Base Info\n", argv[0]);
		exit(-1);
	}
	
	YBase **bases = new YBase*[argc-1];
	int i;
	for (i = 0; i < argc-2; i++) {
		bases[i] = new YBase(argv[i+2], ACE_OS_O_RDONLY);
		if (!bases[i]->IsOkWithoutText()) {
			printf("Problems opening base '%s'\n", argv[i+2]);
		}
	}	
	int needBaseWeight = 1;

	int baseCount = argc-2;
	
	char ***segName = new char**[baseCount];
	char ***segNameEng = new char**[baseCount];
	int *segCount = new int[baseCount];
	char **complectName = new char*[baseCount];
	char **complectNameEng = new char*[baseCount];
	revision **segRev = new revision*[baseCount];
	short **segId = new short*[baseCount];
	unsigned short **segWidth = new unsigned short*[baseCount];
	int *packedKey = new int[baseCount];
	int *packedStr = new int[baseCount];
	int *superWeight = new int[baseCount];

	for (i = 0; i < baseCount; i++) {
		packedKey[i] = bases[i]->keyFile->IsPacked();
		packedStr[i] = bases[i]->strFile->IsPacked();
		Index *aux = bases[i]->FindIndex("Aux");
		Stream *str = aux->Open("Here");
		if (!str || !str->Length()) {
			printf("Error reading key Here for base %d\n", i);
			exit(-1);
		}
		
		segCount[i] = str->Length() / 2;
		complectName[i] = new char[100];
		char *buffer = new char[str->Length()];

		str->Read(buffer, segCount[i] * 2);
		segName[i] = new char*[segCount[i]];
		segNameEng[i] = new char*[segCount[i]];
		segId[i] = new short[segCount[i]];
		segWidth[i] = new unsigned short[segCount[i]];
		segRev[i] = new revision[segCount[i]];
		//!superWeight[i] = 0;

		{
		BaseInfo bi;
		if (bases[i]->FindBaseInfo(0, bi) == sizeof(BaseInfo))
			superWeight[i] = bi.Weight;
		}

		for (int j = 0; j < segCount[i]; j++) {
			BaseInfo bi;

			segId[i][j] = ((short *)buffer)[j];
			if (bases[i]->FindBaseInfo(segId[i][j], bi) != sizeof(BaseInfo)) {
				printf("Cannot find BaseInfo for seg %d in base %d\n", j, i);
				exit (EXIT_FAILURE);
			}
			segName[i][j] = new char[NAME_SIZE];
			segNameEng[i][j] = new char[NAME_SIZE];
			strcpy(segName[i][j], bi.Name);
			strcpy(segNameEng[i][j], bi.NameEng);
			memcpy(&segRev[i][j], &bi.LastUpdate, sizeof(revision));
			segWidth[i][j] = bi.Weight;
			//!superWeight[i] += bi.Weight;
		}
		BaseInfo bi;
		if (bases[i]->FindBaseInfo(0, bi) != sizeof(BaseInfo)) {
			printf("Cannot find zerro BaseInfo in base %d\n", i);
			exit (EXIT_FAILURE);
		}
		complectName[i] = new char[NAME_SIZE];
		complectNameEng[i] = new char[NAME_SIZE];
		strcpy(complectName[i], bi.Name);
		strcpy(complectNameEng[i], bi.NameEng);
		delete buffer;
		aux->Close(str);
	}
	BaseWeight *bws = 0;
	unsigned int bwcount = 0;

	if ( needBaseWeight ) {
		Index *aux = bases[0]->FindIndex("Aux");
		Stream *compStr = aux->Open("Comp");

		bws = (BaseWeight *)malloc(compStr->Length());
		compStr->Read(bws, compStr->Length());
		bwcount = compStr->Length()/sizeof(BaseWeight);
		aux->Close(compStr);
	}

	Core::IniFile *inifile = new Core::IniFile(argv[1]);

	if ( needBaseWeight ) {
		inifile->WriteProfileInt("Complects", "Count", bwcount);
		for (unsigned int i = 0; i < bwcount; i++) {
			char section[1024];
			sprintf(section, "Complect%d", i);
			inifile->WriteProfileString(section, "Name", bws[i].name);
			inifile->WriteProfileString(section, "NameEng", bws[i].nameEng);
			inifile->WriteProfileString(section, "HaspName", bws[i].haspName);
			inifile->WriteProfileInt(section, "MinWeight", (short)bws[i].min);
			inifile->WriteProfileInt(section, "MaxWeight", (short)bws[i].max);
		}
	}

	inifile->WriteProfileInt("Bases", "Count", baseCount); 
	for (i = 0; i < baseCount; i++) {
		char section[1024];
		int error;

#define CHECK(s) \
	if ((error = s)) { \
		printf("Error %d. Program aborted in line %d.\n", error, __LINE__); \
		exit(1); \
	};

		sprintf(section, "Base%d", i);
		CHECK(inifile->WriteProfileInt(section, "Count", segCount[i]));
		CHECK(inifile->WriteProfileString(section, "Filename", argv[i+2]));
		CHECK(inifile->WriteProfileString(section, "Name", complectName[i]));
		CHECK(inifile->WriteProfileString(section, "NameEng", 
				complectNameEng[i]));
		CHECK(inifile->WriteProfileInt(section, "PackedStr", packedStr[i]));
		CHECK(inifile->WriteProfileInt(section, "PackedKey", packedKey[i]));
		CHECK(inifile->WriteProfileInt(section, "Weight", superWeight[i]));
		for (int j = 0; j < segCount[i]; j++) {
			char tag[1024];
			char revis[1024];

			sprintf(revis, "%d:%d:%d:%d %d/%d/%d",
				segRev[i][j].RevisionTime.ti_hour, 
				segRev[i][j].RevisionTime.ti_min, 
				segRev[i][j].RevisionTime.ti_sec, 
				segRev[i][j].RevisionTime.ti_hund,
				segRev[i][j].RevisionDate.da_day,
				segRev[i][j].RevisionDate.da_mon,
				segRev[i][j].RevisionDate.da_year);
			sprintf(tag, "Revision%d", j);
			CHECK(inifile->WriteProfileString(section, tag, revis));
			sprintf(tag, "Name%d", j);
			CHECK(inifile->WriteProfileString(section, tag, segName[i][j]));
			sprintf(tag, "NameEng%d", j);
			CHECK(inifile->WriteProfileString(section, tag, segNameEng[i][j]));
			sprintf(tag, "ID%d", j);
			CHECK(inifile->WriteProfileInt(section, tag, segId[i][j]));
			sprintf(tag, "Weight%d", j);
			CHECK(inifile->WriteProfileInt(section, tag, segWidth[i][j]));
		}
	}
	if (bws) free(bws);
	delete inifile;

	for(i = 0; i < baseCount; i++) {
		for(int j = 0; j < segCount[i]; j++) {
			delete segName[i][j];
			delete segNameEng[i][j];
		}
		delete segName[i];
		delete segNameEng[i];
		delete complectName[i];
		delete complectNameEng[i];
		delete segRev[i];
		delete segId[i];
		delete segWidth[i];

		delete bases[i];
	}
	delete segWidth;
	delete segId;
	delete segRev;
	delete complectName;
	delete complectNameEng;
	delete segCount;
	delete packedKey;
	delete packedStr;
	delete superWeight;
	delete bases;
	
	return 0;
}
