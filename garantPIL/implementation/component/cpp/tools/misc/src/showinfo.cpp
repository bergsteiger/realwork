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
#include "pack.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

struct acl_t {
	unsigned short m_aid;
	unsigned char m_right;
};

struct acl_list_t {
	unsigned m_count;
	acl_t* m_acl;

	acl_list_t () : m_count (0), m_acl (0) {
	}

	~acl_list_t () {
		delete[] m_acl;
	}
};

enum LicenceType
{
	lt_ConnectionLimit,
	lt_DemoMode,
	lt_InternalUse
};

const unsigned long SI_LEGACY_STORAGE = 1;
const unsigned long SI_PROFILE_STORAGE = 2;

const unsigned long CI_TOPIC = (SI_LEGACY_STORAGE << 16) | 1;
const unsigned long CI_BLOB = (SI_LEGACY_STORAGE << 16) | 2;
const unsigned long CI_GROUP = (SI_PROFILE_STORAGE << 16) | 0;
const unsigned long CI_USER = (SI_PROFILE_STORAGE << 16) | 1;

const unsigned long AI_GET_FULL_ATTRIBUTES = 102;
const unsigned long AI_GET_PARAGRAPH_TEXT = 101;
const unsigned long AI_GET_OBJECT_STREAM = 201;
const unsigned long AI_ADMINISTRATOR = 500;
const unsigned long AI_CHANGE_IDLE_TIMEOUT = 302;

const char* ATTR_NAME_MAX_USERS			= "MU"; //"MaxUsers";
const char* ATTR_NAME_PERM_USERS		= "PU"; //"PermUsers";
const char* ATTR_NAME_MAX_PROFILES		= "MP"; //"MaxProfiles";
const char* ATTR_NAME_BASE_ACL_COUNT	= "BRC";//"BaseRightsCount";
const char* ATTR_NAME_BASE_ACL_ARRAY	= "BRA";//"BaseRightsArray";
const char* ATTR_NAME_TOPIC_ACL_COUNT	= "TC";//"TopicCount";
const char* ATTR_NAME_TOPIC_ACL_ARRAY	= "TA";//"TopicArray";
const char* ATTR_NAME_BLOB_ACL_COUNT	= "OC";//"ObjectCount";
const char* ATTR_NAME_BLOB_ACL_ARRAY	= "OA";//"ObjectArray";
const char* ATTR_NAME_GROUP_ACL_COUNT	= "GC";//"GroupCount";
const char* ATTR_NAME_GROUP_ACL_ARRAY	= "GA";//"GroupArray";
const char* ATTR_NAME_USER_ACL_COUNT	= "UC";//"UserCount";
const char* ATTR_NAME_USER_ACL_ARRAY	= "UA";//"UserArray";
const char* ATTR_NAME_CRC				= "CIV"; //"CRC MU+PU+MP";
const char* ATTR_NAME_GUEST_ENABLED		= "GE"; //"Guest Enabled";
const char* ATTR_NAME_VERSION			= "VER"; //"Version";
const unsigned SEED_FOR_ADLER32			= 0x31304947;//(unsigned)"GI01";

unsigned long VERSION = 1;

void load_acl(PagedFile* pNDT, const char* countName, const char* arrayName, char* pCount, acl_t** ppAcl) {
	!pNDT->GetAttr(countName, pCount, sizeof(char));
	*ppAcl = new acl_t[*pCount];
	!pNDT->GetAttr(arrayName, *ppAcl, sizeof(acl_t)*(*pCount));
}

LicenceType	load_licence_type (PagedFile *pNDT) {
	char size = 0;
	acl_t* acl = 0;
	const char* countName = 0;
	const char* arrayName = 0;

	LicenceType type;

	unsigned class_id = CI_TOPIC;
	countName = ATTR_NAME_TOPIC_ACL_COUNT;
	arrayName = ATTR_NAME_TOPIC_ACL_ARRAY;

	load_acl (pNDT, countName, arrayName, &size, &acl);

	bool all_set = true, all_reset = true;
	for(long i = 0; i < size; i++) {
		all_set &= (acl[i].m_right != 0);
		all_reset &= (acl[i].m_right == 0);
	}
	if(all_set) {
		type = lt_InternalUse;
	}
	else if(all_reset) {
		type = lt_DemoMode;
	}
	else {
		type = lt_ConnectionLimit;
	}

	return type;
}

int main_logic ( int argc, char *argv[] )
{	
	{
		YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);

		int max_num, max_perm, max_profiles;
		base->textFile->GetAttr (ATTR_NAME_MAX_USERS, &max_num, sizeof(int));
		base->textFile->GetAttr(ATTR_NAME_PERM_USERS, &max_perm, sizeof(int));
		base->textFile->GetAttr(ATTR_NAME_MAX_PROFILES, &max_profiles, sizeof(int));

		printf ("MaxUsers: %ld\nPermUsers: %ld\nMaxProfiles: %ld\n", max_num, max_perm, max_profiles);

		switch (load_licence_type (base->textFile)) {
			case lt_ConnectionLimit:
				printf ("Licence: lt_ConnectionLimit\n");
				break;
			case lt_DemoMode:
				printf ("Licence: lt_DemoMode\n");
				break;
			case lt_InternalUse:
				printf ("Licence: lt_InternalUse\n");
				break;
		}

		int guest_enabled;
		base->textFile->GetAttr(ATTR_NAME_GUEST_ENABLED, &guest_enabled, sizeof(int));
		printf ("guest: %s\n", guest_enabled ? "true" : "false");

		delete base;
		exit (EXIT_SUCCESS);
	}
}
