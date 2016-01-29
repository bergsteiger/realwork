
#include "ace/ACE.h"

#include "garantPIL/implementation/component/cpp/tools/gctools/src/gcini.h"

#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectCounter.h"
#include "shared/Core/mng/PoolMemoryManager.h"

#include "main.h"
#include "garver.h"
#include "decompile.h"

/*
	Usage:
		gdec base gcinit [-x] [-check]

	base	- base name
	gcinit	- ini file
	-x	- decompile only documents which have in 'Here'
	-check - проверять ссылки. В тексте остается ссылка только тогда, когда документ в базе

  TODO!!!:
	Revision date to gcini - PROBLEM!!!
	Belongs to gcini

  Etalon files:
	-	belongs table (need!)
	-	warnings table (need!)
	+	clax file
	+	source file
	+	keyword file
	+	blob files
	+	territory file
	+	document type file
	-	object type file
	+	priority table file (generate in docs)
	+	publitions file
	-	complect info file
	-	cat file

  Now support:

Etalon	Sub	Topic
.	.	+	!BELONGS
.	+	+	!CLASS
.	.	+	!CODE
.	.	+	!DATE
.	.	+	!NAME
.	.	+	!NOACTIVE		// revision date
.	.	+	!PREACTIVE		// revision date
.	+	+	!PREFIX
.	.	+	!PRIORITY		// for all documets
.	.	+	!PUBLISHEDIN
.	.	+	!RCODE
.	.	+	!RDATE
.	.	+	!RELATED
.	.	+	!SOURCE
.	.	+	!TERRITORY
.	.	+	!TOPIC
.	+	+	!TYPE
.	.	+	!VANONCED
.	.	+	!WARNING
.	.	+	!BUSINESS
.	.	+	!CALENDAR
.	.	+	!CHECK			// Ignore by compilerr
.	.	+	!DEFAULT		// Ignore by compiler
.	.	+	!DOC
.	.	+	!GDATE			// Ignore by compilerr
.	.	+	!MOJNOTREG
.	.	+	!NODOC			// only for DOC
.	.	+	!NORM			// for all documents
.	.	+	!PRICELEVEL		// Ignore by compiler
.	.	+	!REVISION		// Ignore by compiler
.	.	+	!REL			// Ignore by compiler
.	.	+	!SFDATE			// Ignore by compiler
.	.	+	!SORTDATE
.	.	+	!STAGE			// Ignore by compiler
.	.	+	!USERINFO
.	.	+	!VABOLISHED
.	.	+	!VCHANGED
.	.	+	!VINCLUDED
.	.	+	!VLCONTROL
.	.	+	!SPLASH
+	.	.	!VERSION		// used in etalon
+	.	.	!KEY			// used in etalon
+	.	.	!DOCPREFIX		// used in etalon
+	.	.	!DOCSPREFIX
+	.	.	!COMMPREFIX
+	.	.	!FORMPREFIX
+	.	.	!PROJPREFIX
+	.	.	!PRAKPREFIX
+	.	.	!INTEPREFIX
+	.	.	!BREFPREFIX
+	.	.	!QUESPREFIX
+	.	.	!EQ			// Don't need to generate (it's in documents)
+	.	.	!PREFIXEX
.	.	+	!OBJTOPIC		// for objects
.	.	+	!OBJTYPE		// for objects
.	.	+	!OBJPATH		// for objects
.	+	.	!BLOCK			// Ignore by compiler
.	+	.	!BLOCKEND		// Ignore by compiler
.	+	.	!SUB
.	+	.	!STYLE

*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Logger Log;

char* buf = new char [BSIZE];

Belong Belongs [MAX_BASES];
Warning Warnings [MAX_WARN];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class GCParameters_ex : public GCParameters {
public:
	GCParameters_ex () {
		ACE_OS::memset (this, 0, sizeof (GCParameters));
	}

	inline bool read (FILE* file) {
		return (readParams (this, file) == 0);
	}

	~GCParameters_ex ()	{
		if (inRTFile) {
			delete inRTFile;
		}
		if (inOFile) {
			delete inOFile;
		}
	}
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	LogScreen Screen;

	Log.Init (&Screen, cd_win, cd_dos);
	Log.printf ("\nGARANT Base decompiler Version %s\n\n", GARANT_VERSION); // print title

	if (argc >= 3) {
		LogFile logInfo ("gdec.log");
		Log.Devices (lt_info).Add (&logInfo);

		bool is_full = true;
		long from_doc = 0;

		for (int i = 3; i < argc; ++i) {
			if (!stricmp (argv [i], "-x")) {
				is_full = false;
			} else if (!stricmp (argv [i], "-check")) {
			} else if (atol (argv [i])) {
				from_doc = atol (argv [i]);
			}
		}

		std::string base_name = argv [1];
		std::string ini_name  = argv [2];

		FILE_aptr ini_file = ACE_OS::fopen (ini_name.c_str (), "r"); // open ini file

		if (ini_file.ptr ()) {
			GCParameters_ex gcparam;

			if (gcparam.read (ini_file.in ())) {
				Core::Aptr <YBase> base = new YBase (base_name.c_str (), O_RDONLY); // open base

				if (base->IsOk ()) {
					int belongs = 0, warnings = 0, publishers = 0;
					// Reading Belongs table
					if (gcparam.belongsMapFile) {
						belongs = LoadBelongs (gcparam.belongsMapFile, Belongs);
					} else {
						Log.printf (lt_info, "Warning. No belongs map file name in ini file\n");
					}

					if (!from_doc) {

						// Reading Warning table
						if (gcparam.warningsFile) {
							warnings = LoadWarnings (gcparam.warningsFile, Warnings);
						} else {
							Log.printf (lt_info, "Warning. No warnings file name in ini file\n");
						}

						// Generate etalon file with publishers
						Log.printf (lt_info, "Creating publishers file\n");
						if (gcparam.pubSourceFile) {
							publishers = CreatePublishers (base.in (), gcparam.pubSourceFile);
						} else {
							Log.printf (lt_info, "Warning. No published file name in ini file\n");
						}

						// Generate Clax
						Log.printf (lt_info, "Creating class file\n");
						if (gcparam.classFile) {
							CreateClass (base.in (), gcparam.classFile);
						} else {
							Log.printf (lt_info, "Warning. No class file name in ini file\n");
						}

						// Generate Norm (Category)
						Log.printf (lt_info, "Creating norm file\n");
						if (gcparam.normFile) {
							CreateNorm (base.in (), gcparam.normFile);
						} else {
							Log.printf (lt_info, "Warning. No norm file name in ini file\n");
						}

						// Generate Source
						Log.printf (lt_info, "Creating source file\n");
						if (gcparam.sourcesFile) {
							CreateSource (base.in (), gcparam.sourcesFile);
						} else {
							Log.printf (lt_info, "Warning. No source file name in ini file\n");
						}

						// Generate Territory
						Log.printf (lt_info, "Creating territory file\n");
						if (gcparam.territoryFile) {
							CreateTerritory (base.in (), gcparam.territoryFile);
						} else {
							Log.printf (lt_info, "Warning. No territory file name in ini file\n");
						}

						// Generate Anno*
						Log.printf (lt_info, "Creating anno files\n");
						if (gcparam.annoUserFile) {
							CreateAnno (base.in (), gcparam.annoUserFile, "AnnoUser" );
						} else {
							Log.printf (lt_info, "Warning. No annouser file name in ini file\n");
						}
						if (gcparam.annoOrganizationFile) {
							CreateAnno (base.in (), gcparam.annoOrganizationFile, "AnnoOrganization" );
						} else {
							Log.printf (lt_info, "Warning. No annoorganization file name in ini file\n");
						}
						if (gcparam.annoTaxFile) {
							CreateAnno (base.in (), gcparam.annoTaxFile, "AnnoTax" );
						} else {
							Log.printf (lt_info, "Warning. No annotax file name in ini file\n");
						}
						if (gcparam.annoInterestFile) {
							CreateAnno (base.in (), gcparam.annoInterestFile, "AnnoInterest" );
						} else {
							Log.printf (lt_info, "Warning. No annointerest file name in ini file\n");
						}
						if (gcparam.annoKindFile) {
							CreateAnno (base.in (), gcparam.annoKindFile, "AnnoKind" );
						} else {
							Log.printf (lt_info, "Warning. No annokind file name in ini file\n");
						}

						// Generate Type
						Log.printf (lt_info, "Creating types file\n");
						if (gcparam.typesFile) {
							CreateType (base.in (), gcparam.typesFile);
						} else {
							Log.printf (lt_info, "Warning. No types file name in ini file\n");
						}

						// Generate KeyWord
						Log.printf (lt_info, "Creating keyword file\n");
						if (gcparam.kwFile) {
							CreateKeyWord (base.in (), gcparam.kwFile);
						} else {
							Log.printf(lt_info, "Warning. No keyword file name in ini file\n");
						}

						// Generate Cat file
						Log.printf (lt_info, "Creating cat file\n");
						if (gcparam.catFile) {
							create_cat_file (base.in (), gcparam.catFile);
						} else {
							Log.printf (lt_info, "Warning. No catfile file name in ini file\n");
						}

						// Erase files
						Log.printf (lt_info, "Creating NSRC files\n\n");

						if (gcparam.catFile) {
							erase_cat_files (gcparam.catFile);
						}

						Log.printf (lt_info, "Total Bases       - %d\n", belongs);
						Log.printf (lt_info, "Total Warnigs     - %d\n", warnings);
						Log.printf (lt_info, "Total Publishers  - %d\n", publishers);
					}

					{
						Decompile dec (base.in (), is_full);

						dec.load_here ();
						if (!from_doc)
							dec.decompile_blobs (blob_dir.c_str ()); // decompiling of blobs to blob dir
						dec.decompile_documents (nsrc_dir.c_str (), from_doc); // decompiling of topics to nsrc dir
					}

					Log.printf (lt_info, "\n\n");
					Log.printf (lt_info, "Creating warnings file\n");

					if (!from_doc && gcparam.warningsFile) {
						char name [256];
						ACE_OS::strcpy (name, gcparam.warningsFile);
						make_file_dir (name);		
						SaveWarnings (name, Warnings);
					}
				} else {
					Log.printf (lt_info, "Error: The base '%s' is not ok!\n", base_name.c_str ());
				}
			} else {
				Log.printf (lt_info, "Read ini file '%s' failed\n", ini_name.c_str ());
			}
		} else {
			Log.printf (lt_info, "Can't open ini file '%s'\n", ini_name.c_str ());
		}
	} else {
		Log.printf ("\tUsage: gdec base gc-ini [-x]\n\n");
		Log.printf ("\t-x     - Decompile only documents which have in 'Here'.\n\n");
		Log.printf ("\t-check - Check refs. Skip docs not presented in base.\n\n");
	}

	Log.printf("\n\n");

	if (buf) {
		delete [] buf;
	}

	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
