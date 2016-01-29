#ifndef _nsrccmd_h_
#define _nsrccmd_h_

#define ARCHICHECK_DOFFS 11
#define ARCHICHECK_COP >=
#define ARCHICHECK_CHECK(s) (strncmp(s+1,"ARCHICHECK",10)==0)

#define ADDCODE_DOFFS 8
#define ADDCODE_COP >=
#define ADDCODE_CHECK(s) (strncmp(s+1,"ADDCODE",7)==0)

#define CASECODE_DOFFS 9
#define CASECODE_COP >=
#define CASECODE_CHECK(s) (strncmp(s+1,"CASECODE",8)==0)

#define CASEDOCPARTICIPANT_DOFFS 19
#define CASEDOCPARTICIPANT_COP >=
#define CASEDOCPARTICIPANT_CHECK(s) (strncmp(s+1,"CASEDOCPARTICIPANT",18)==0)

#define BANNER_DOFFS 7
#define BANNER_COP >=
#define BANNER_CHECK(s) (strncmp(s+1,"BANNER",6)==0)

#define KIND_DOFFS 5
#define KIND_COP >=
#define KIND_CHECK(s) (strncmp(s+1,"KIND",4)==0)

#define TABLE_DOFFS 6
#define TABLE_COP >=
#define TABLE_CHECK(s) (strncmp(s+1,"TABLE",5)==0)

#define STYLEA_DOFFS 7
#define STYLEA_COP >=
#define STYLEA_CHECK(s) (strncmp(s+1,"STYLEA",6)==0)

#define NEXTVERLINK_DOFFS 12
#define NEXTVERLINK_COP >=
#define NEXTVERLINK_CHECK(s) (strncmp(s+1,"NEXTVERLINK",11)==0)

#define TABLEEND_DOFFS 9
#define TABLEEND_COP >=
#define TABLEEND_CHECK(s) (strncmp(s+1,"TABLEEND",8)==0)

#define ROW_DOFFS 4
#define ROW_COP >=
#define ROW_CHECK(s) (strncmp(s+1,"ROW",3)==0)

#define ROWEND_DOFFS 7
#define ROWEND_COP >=
#define ROWEND_CHECK(s) (strncmp(s+1,"ROWEND",6)==0)

#define CHANGE_DOFFS 7
#define CHANGE_COP >=
#define CHANGE_CHECK(s) (strncmp(s+1,"CHANGE",6)==0)

#define ZOOM_DOFFS 5
#define ZOOM_COP >=
#define ZOOM_CHECK(s) (strncmp(s+1,"ZOOM",4)==0)

#define LEFTINDENT_DOFFS 11
#define LEFTINDENT_COP >=
#define LEFTINDENT_CHECK(s) (strncmp(s+1,"LEFTINDENT",10)==0)

#define CELL_DOFFS 5
#define CELL_COP >=
#define CELL_CHECK(s) (strncmp(s+1,"CELL",4)==0)

#define CELLEND_DOFFS 8
#define CELLEND_COP >=
#define CELLEND_CHECK(s) (strncmp(s+1,"CELLEND",7)==0)

#define ALLOWED_DOFFS 8
#define ALLOWED_COP >=
#define ALLOWED_CHECK(s) (strncmp(s+1,"ALLOWED",7)==0)

#define NOTALLOWED_DOFFS 11
#define NOTALLOWED_COP >=
#define NOTALLOWED_CHECK(s) (strncmp(s+1,"NOTALLOWED",10)==0)

#define LIFE_DOFFS 5
#define LIFE_COP >=
#define LIFE_CHECK(s) (strncmp(s+1,"LIFE",4)==0)

#define NOTLIFE_DOFFS 8
#define NOTLIFE_COP >=
#define NOTLIFE_CHECK(s) (strncmp(s+1,"NOTLIFE",7)==0)

#define UNRECIPE_DOFFS 9
#define UNRECIPE_COP >=
#define UNRECIPE_CHECK(s) (strncmp(s+1,"UNRECIPE",8)==0)

#define RECIPE_DOFFS 7
#define RECIPE_COP >=
#define RECIPE_CHECK(s) (strncmp(s+1,"RECIPE",6)==0)

#define ADDMENU_DOFFS 7  
#define ADDMENU_COP >=
#define ADDMENU_CHECK(s) ( *(int*)(s)==1145323809 && *(int*)((s)+4)==1431192909)
	   // !ADD MENU

#define ALTMENU_DOFFS 7  
#define ALTMENU_COP >=
#define ALTMENU_CHECK(s) ( *(int*)(s)==1414283553 && *(int*)((s)+4)==1431192909)
	   // !ALT MENU

#define ANONCE_DOFFS 6  
#define ANONCE_COP >=
#define ANONCE_CHECK(s) ((s)[2]=='N'&&*(int*)((s)+3)==1162038863)
	   // N ONCE

#define ARTICLE_DOFFS 7  
#define ARTICLE_COP >=
#define ARTICLE_CHECK(s) ( *(int*)(s)==1414676769  && *(int*)((s)+4)==1162625865 )
	   // !ART ICLE


#define BELONGS_DOFFS 8  
#define BELONGS_COP >=
#define BELONGS_CHECK(s) (*(int*)(s)==1279607329 && *(int*)((s)+4)==1397182031 )
	   // !BEL ONGS

#define BLOCK_DOFFS 6
#define BLOCK_COP >
#define BLOCK_CHECK(s) ((*(int*)(s+2)==1262702412)&&((s[6]==' ')||(s[6]=='\t')))


#define BLOCKEND_DOFFS 9
#define BLOCKEND_COP >=
#define BLOCKEND_CHECK(s) (*(int*)(s+1)==1129270338 && *(int*)((s)+5)==1145980235 )
	   // BLOC KEND


#define BLOCKDATA_DOFFS 10
#define BLOCKDATA_COP >=
#define BLOCKDATA_CHECK(s) (strncmp(s+1,"BLOCKDATA",9)==0)
        // BLOCKDATA

#define DOCTYPE_DOFFS 8
#define DOCTYPE_COP >=
#define DOCTYPE_CHECK(s) (strncmp(s+1,"DOCTYPE",7)==0)
        // DOCTYPE


#define BUSINESS_DOFFS 8  
#define BUSINESS_COP >=
#define BUSINESS_CHECK(s) (*(int*)(s+1)==1230198082 && *(int*)((s)+5)==1397966158 )
	   // BUSI NESS

#define CALENDAR_DOFFS 8  
#define CALENDAR_COP >=
#define CALENDAR_CHECK(s) (*(int*)(s+1)==1162625347 && *(int*)((s)+5)==1380009038 )
	   // CALE NDAR


#define CATEGORY_DOFFS 8  
#define CATEGORY_COP >=
#define CATEGORY_CHECK(s) (*(int*)(s+1)==1163149635 && *(int*)((s)+5)==1498566471 )
	   // CATE GORY

#define CHECK_DOFFS 6
#define CHECK_COP >=
#define CHECK_CHECK(s) (*(int*)((s)+2)==1262699848)
        // HECK

#define CLASS_DOFFS 6
#define CLASS_COP >=
#define CLASS_CHECK(s) (*(int*)((s)+3)==542331713)
        // LASS

#define CLASS_4X_DOFFS 9
#define CLASS_4X_COP >=
#define CLASS_4X_CHECK(s) (*(int*)((s)+3)==1599296321)
        // ASS_


#define CODE_DOFFS 5
#define CODE_COP >=
#define CODE_CHECK(s) (*(int*)((s+1))==1162104643)
        // CODE

#define DATE_DOFFS 5  
#define DATE_COP >=
#define DATE_CHECK(s) (*(int*)((s)+2)==541414465||*(int*)((s)+2)==155538497 )
	   // ATE<space> or ATE<tab>

#define DIVISION_DOFFS 8
#define DIVISION_COP >=
#define DIVISION_CHECK(s) ((*(int*)(s+1)==1230391620) && (*(int*)(s+5))==1313818963)
        // DIVI SION

#define DOC_DOFFS 4
#define DOC_COP >=
#define DOC_CHECK(s) (*(int*)((s)) == 1129268257 )
	   // !DOC

#define FULL_DOFFS 5
#define FULL_COP >=
#define FULL_CHECK(s) (*(int*)((s+1)) ==1280070982)
	   // FULL

#define GDDATE_DOFFS 6  
#define GDDATE_COP >=
#define GDDATE_CHECK(s) ( s[2]=='D' && *(int*)((s)+3)==1163149636)
	   // F DATE

#define KEY_DOFFS 5
#define KEY_COP >=
#define KEY_CHECK(s) ((*(int*)(s+1)==542721355) || (*(int*)(s+1))==156845387)
        // O +AME<space> or AME<tab>

#define LIST_DOFFS 4
#define LIST_COP >=
#define LIST_CHECK(s) (*(int*)(s+1)==1414744396)
        // LIST

#define MAIN_DOFFS 4
#define MAIN_COP >=
#define MAIN_CHECK(s) (*(int*)(s+1)==1313423693)
        // MAIN

#define MAXLINES_DOFFS 8
#define MAXLINES_COP >=
#define MAXLINES_CHECK(s) ((*(int*)(s+1)==1280852301) && (*(int*)(s+5))==1397050953)
        // MAXL INES

#define MOJNOTREG_DOFFS 9
#define MOJNOTREG_COP >=
#define MOJNOTREG_CHECK(s) ((*(int*)(s+2)==1330530895)&&(*(int*)(s+6))==1195725396)
        // OJNO TREG


#define NAME_DOFFS 5
#define NAME_COP >=
#define NAME_CHECK(s) ((*(int*)(s+2)==541412673) || (*(int*)(s+2))==155536705)
        // O +AME<space> or AME<tab>

#define NEWLIST_DOFFS 7
#define NEWLIST_COP >=
#define NEWLIST_CHECK(s) ((*(int*)(s)==1464159777) && (*(int*)(s+4))==1414744396)
        // !NEW LIST

#define NOACTIVE_DOFFS 9
#define NOACTIVE_COP >=
#define NOACTIVE_CHECK(s) (*(int*)((s)+1) ==1128353614 && *(int*)((s)+5) ==1163282772)
	   // NOAC TIVE

#define NORM_DOFFS 5  
#define NORM_COP >=
#define NORM_CHECK(s) (*(int*)((s)+1) ==1297239886 )
	   // NORM

#define NODOC_DOFFS 5
#define NODOC_COP >=
#define NODOC_CHECK(s) (*(int*)(s+2)==1129268303)
        // ODOC

#define REFDOC_DOFFS 6
#define REFDOC_COP >=
#define REFDOC_CHECK(s) (strncmp(s+1,"REFDOC",6)==0)
        // REFDOC

#define IZM_DOFFS 3
#define IZM_COP >=
#define IZM_CHECK(s) (strncmp(s+1,"IZM",4)==0)
        // IZM

#define BOOK_DOFFS 4
#define	BOOK_COP >=
#define BOOK_CHECK(s) (strncmp(s+1,"BOOK",4)==0)
        // REFDOC


#define ALARM_DOFFS 6
#define ALARM_COP >=
#define ALARM_CHECK(s) (strncmp(s+1,"ALARM",5)==0)
        // ALARM

#define CHDATE_DOFFS 7
#define CHDATE_COP >=
#define CHDATE_CHECK(s) (strncmp(s+1,"CHDATE",6)==0)
        // CHDATE

#define NOTSURE_DOFFS 8
#define NOTSURE_COP >=
#define NOTSURE_CHECK(s) (strncmp(s+1,"NOTSURE",7)==0)
        // NOTSURE

#define ANNOTOPIC_DOFFS 10
#define ANNOTOPIC_COP >=
#define ANNOTOPIC_CHECK(s) (strncmp(s+1,"ANNOTOPIC",9)==0)
        // ANNOTOPIC

#define ANNONAME_DOFFS 9
#define ANNONAME_COP >=
#define ANNONAME_CHECK(s) (strncmp(s+1,"ANNONAME",8)==0)
        // ANNONAME

#define ANNOSIGNIFICANT_DOFFS 16
#define ANNOSIGNIFICANT_COP >=
#define ANNOSIGNIFICANT_CHECK(s) (strncmp(s+1,"ANNOSIGNIFICANT",15)==0)
        // ANNOSIGNIFICANT

#define ANNOUSER_DOFFS 9
#define ANNOUSER_COP >=
#define ANNOUSER_CHECK(s) (strncmp(s+1,"ANNOUSER",8)==0)
        // ANNOUSER

#define SERVICEINFO_DOFFS 12
#define SERVICEINFO_COP >=
#define SERVICEINFO_CHECK(s) (strncmp(s+1,"SERVICEINFO",11)==0)
        // SERVICEINFO

#define ANNOORGANIZATION_DOFFS 17
#define ANNOORGANIZATION_COP >=
#define ANNOORGANIZATION_CHECK(s) (strncmp(s+1,"ANNOORGANIZATION",16)==0)
        // ANNOORGANIZATION

#define ANNOTAX_DOFFS 8
#define ANNOTAX_COP >=
#define ANNOTAX_CHECK(s) (strncmp(s+1,"ANNOTAX",7)==0)
        // ANNOTAX

#define ANNOKIND_DOFFS 9
#define ANNOKIND_COP >=
#define ANNOKIND_CHECK(s) (strncmp(s+1,"ANNOKIND",8)==0)
        // ANNOKIND

#define ANNOINTEREST_DOFFS 14
#define ANNOINTEREST_COP >=
#define ANNOINTEREST_CHECK(s) (strncmp(s+1,"ANNOINTEREST",12)==0)
        // ANNOINTEREST

#define ANNODATE_DOFFS 9
#define ANNODATE_COP >=
#define ANNODATE_CHECK(s) (strncmp(s+1,"ANNODATE",8)==0)
        // ANNODATE

#define NARCOTIC_DOFFS 9
#define NARCOTIC_COP >=
#define NARCOTIC_CHECK(s) (strncmp(s+1,"NARCOTIC",8)==0)

#define NOTNARCOTIC_DOFFS 12
#define NOTNARCOTIC_COP >=
#define NOTNARCOTIC_CHECK(s) (strncmp(s+1,"NOTNARCOTIC",11)==0)

#define ADWORD_DOFFS 7
#define ADWORD_COP >=
#define ADWORD_CHECK(s) (strncmp(s+1,"ADWORD",6)==0)
        // ADWORD

#define NOTTM_DOFFS 6
#define NOTTM_COP >=
#define NOTTM_CHECK(s) (strncmp(s+1,"NOTTM",5)==0)
        // NOTTM

#define CONTENTS_DOFFS 9
#define CONTENTS_COP >=
#define CONTENTS_CHECK(s) (strncmp(s+1,"CONTENTS",8)==0)
        // CONTENTS

#define COMPARECONTENTS_DOFFS 16
#define COMPARECONTENTS_COP >=
#define COMPARECONTENTS_CHECK(s) (strncmp(s+1,"COMPARECONTENTS",15)==0)
        // COMPARECONTENTS

#define OBJPATH_DOFFS 8
#define OBJPATH_COP >=
#define OBJPATH_CHECK(s) (strncmp(s+1,"OBJPATH",7)==0)
        // OBJPATH

#define MEDTOPIC_DOFFS 9
#define MEDTOPIC_COP >=
#define MEDTOPIC_CHECK(s) (strncmp(s+1,"MEDTOPIC",8)==0)

#define FLASHTOPIC_DOFFS 11
#define FLASHTOPIC_COP >=
#define FLASHTOPIC_CHECK(s) (strncmp(s+1,"FLASHTOPIC",10)==0)

#define MDICTTOPIC_DOFFS 11
#define MDICTTOPIC_COP >=
#define MDICTTOPIC_CHECK(s) (strncmp(s+1,"MDICTTOPIC",10)==0)

#define MREL_DOFFS 5
#define MREL_COP >=
#define MREL_CHECK(s) (strncmp(s+1,"MREL",4)==0)

#define FIRMTOPIC_DOFFS 10
#define FIRMTOPIC_COP >=
#define FIRMTOPIC_CHECK(s) (strncmp(s+1,"FIRMTOPIC",9)==0)

#define FIRM_DOFFS 5
#define FIRM_COP >=
#define FIRM_CHECK(s) (strncmp(s+1,"FIRM",4)==0)

#define PHARMGROUP_DOFFS 11
#define PHARMGROUP_COP >=
#define PHARMGROUP_CHECK(s) (strncmp(s+1,"PHARMGROUP",10)==0)

#define PHARMEFFECT_DOFFS 12
#define PHARMEFFECT_COP >=
#define PHARMEFFECT_CHECK(s) (strncmp(s+1,"PHARMEFFECT",11)==0)

#define MKB_DOFFS 4
#define MKB_COP >=
#define MKB_CHECK(s) (strncmp(s+1,"MKB",3)==0)

#define CHAPTER_DOFFS 8
#define CHAPTER_COP >=
#define CHAPTER_CHECK(s) (strncmp(s+1,"CHAPTER",7)==0)

#define ATC_DOFFS 4
#define ATC_COP >=
#define ATC_CHECK(s) (strncmp(s+1,"ATC",3)==0)

#define REGSTATUS_DOFFS 10
#define REGSTATUS_COP >=
#define REGSTATUS_CHECK(s) (strncmp(s+1,"REGSTATUS",9)==0)

#define LEKFORM_DOFFS 8
#define LEKFORM_COP >=
#define LEKFORM_CHECK(s) (strncmp(s+1,"LEKFORM",7)==0)

#define TRADENAME_DOFFS 10
#define TRADENAME_COP >=
#define TRADENAME_CHECK(s) (strncmp(s+1,"TRADENAME",9)==0)

#define INTNAME_DOFFS 8
#define INTNAME_COP >=
#define INTNAME_CHECK(s) (strncmp(s+1,"INTNAME",7)==0)

#define REGDATE_DOFFS 8
#define REGDATE_COP >=
#define REGDATE_CHECK(s) (strncmp(s+1,"REGDATE",7)==0)

#define ANNULDATE_DOFFS 10
#define ANNULDATE_COP >=
#define ANNULDATE_CHECK(s) (strncmp(s+1,"ANNULDATE",9)==0)

#define COUNTRY_DOFFS 8
#define COUNTRY_COP >=
#define COUNTRY_CHECK(s) (strncmp(s+1,"COUNTRY",7)==0)

#define OBJTOPIC_DOFFS 9
#define OBJTOPIC_COP >=
#define OBJTOPIC_CHECK(s) (strncmp(s+1,"OBJTOPIC",8)==0)
// BLOB

#define A_OBJTOPIC_DOFFS 9
#define A_OBJTOPIC_COP >=
#define A_OBJTOPIC_CHECK(s) (*s=='!' && (strncmp(s+1,"OBJTOPIC",8)==0))
// BLOB

#define OBJTYPE_DOFFS 8
#define OBJTYPE_COP >
#define OBJTYPE_CHECK(s) (*(short*)((s)+2)==19010&&*(int*)((s)+4)==1162893652)
	   // BJ + TYPE


#define PRA_DOFFS 4
#define PRA_COP >=
#define PRA_CHECK(s) (*(int*)(s)==1095913505)
        // !PRA

#define PREFIX_DOFFS 7  
#define PREFIX_COP >
#define PREFIX_CHECK(s) ((s)[2]=='R' && *(int*)((s)+3) == 1481197125)
	   // R + EFIX

#define PREACTIVE_DOFFS 10  
#define PREACTIVE_COP >=
#define PREACTIVE_CHECK(s) (*(int*)((s)+2) ==1128351058 && \
            *(int*)((s)+6) == 1163282772)
	   // REAC TIVE

#define PRICELEVEL_DOFFS 11
#define PRICELEVEL_COP >=
#define PRICELEVEL_CHECK(s) (strncmp(s+1,"PRICELEVEL",10)==0)

#define PRIORITY_DOFFS 9  
#define PRIORITY_COP >=
#define PRIORITY_CHECK(s) (*(int*)((s)+1) ==1330205264 && *(int*)((s)+5) == 1498696018)
	   // PRIO RITY

#define PUBLISHEDIN_DOFFS 12  
#define PUBLISHEDIN_COP >=
#define PUBLISHEDIN_CHECK(s) \
		(*(int*)((s)+2)==1229734485 && \
		 *(int*)((s)+6)==1145391187 && \
		 *(short*)((s)+10)==20041)
	   // UBLI SHED IN


#define RCODE_DOFFS 6
#define RCODE_COP >=
#define RCODE_CHECK(s) (*(int*)((s+2)) == 1162104643)
        // CODE

#define RDATE_DOFFS 6
#define RDATE_COP >=
#define RDATE_CHECK(s) (*(int*)((s+2)) == 1163149636)
        // DATE

#define REL_DOFFS 4 
#define REL_COP >=
#define REL_CHECK(s) (*(int*)((s)) == 1279611425)
        // EL 

#define RELATED_DOFFS 9  
#define RELATED_COP >=
#define RELATED_CHECK(s) (*(int*)((s)+2) == 1413565509 && *(short*)((s)+6)==17477)
	   // ELAT

#define REVISION_DOFFS 9 
#define REVISION_COP >=
#define REVISION_CHECK(s) (*(int*)(s+1)==1230390610 && *(int*)((s)+5) == 1313818963)
	   // REVI SION


#define SFDATE_DOFFS 6  
#define SFDATE_COP >=
#define SFDATE_CHECK(s) ( s[2]=='F' && *(int*)((s)+3)==1163149636)
	   // F DATE


#define SORTDATE_DOFFS 9  
#define SORTDATE_COP >
#define SORTDATE_CHECK(s) (*(int*)((s)+1) ==1414680403 && *(int*)((s)+5)==1163149636)
	   // SORT DATE


#define SOURCE_DOFFS 7  
#define SOURCE_COP >
#define SOURCE_CHECK(s) ((s)[2]=='O' && *(int*)((s)+3) == 1162039893)
	   // O + URCE

#define SPLASH_DOFFS 7
#define SPLASH_COP ==
#define SPLASH_CHECK(s) (*(short*)((s)+1)==20563&&*(int*)((s)+3)==1213415756)


#define STAGE_DOFFS 6
#define STAGE_COP >
#define STAGE_CHECK(s) (*(int*)((s)+2)==1162297684)


#define STYLE_DOFFS 6
#define STYLE_COP >
#define STYLE_CHECK(s) (*(int*)((s)+2)==1162631508)
        // TYLE

#define SUB_DOFFS 4  
#define SUB_COP >
#define SUB_CHECK(s) (*(int*)((s)+1) == 541218131 || *(int*)((s)+1) == 155342163)
	   // SUB<space> or SUB<tab>

#define SUFFIX_DOFFS 7
#define SUFFIX_COP >
#define SUFFIX_CHECK(s) ((s)[2]=='U'&& *(int*)((s)+3)==1481197126)
        // U+FFIX

#define TERM_DOFFS 6
#define TERM_COP >=
#define TERM_CHECK(s) ((*(int*)(s+1)==1297237332)&&((s[5]==' ')||(s[5]=='\t')))
        // TERM

#define TERRITORY_DOFFS 10
#define TERRITORY_COP >
#define TERRITORY_CHECK(s) ( *(int*)((s)+2)==1230131781 \
                              && *(int*)((s)+6)==1498566484)
        // ERRI  TORY

#define TOPIC_DOFFS 6
#define TOPIC_COP >=
#define TOPIC_CHECK(s) (*(int*)((s)+2)==1128878159)
        // OPIC

#define A_TOPIC_DOFFS 6
#define A_TOPIC_COP >=
#define A_TOPIC_CHECK(s) (*(short*)s==21537&&*(int*)((s)+2)==1128878159)
        //!T OPIC


#define TYPE_DOFFS 5  
#define TYPE_COP >=
#define TYPE_CHECK(s) (*(int*)((s)+1) ==1162893652 )
	   // TYPE

#define VABOLISHED_DOFFS 11
#define VABOLISHED_COP >=
#define VABOLISHED_CHECK(s) ((s)[2]=='A'&&*(int*)((s)+3)==1229737794&&*(int*)((s)+7)==1145391187)
	   // A BOLI SHED

#define VANONCED_DOFFS 9
#define VANONCED_COP >=
#define VANONCED_CHECK(s) (*(int*)((s)+1) ==1330528598 && *(int*)((s)+5)==1145389902)
	   // VANO NCED

#define VCHANGED_DOFFS 9
#define VCHANGED_COP >=
#define VCHANGED_CHECK(s) (*(int*)((s)+1) == 1095254870 && *(int*)((s)+5)==1145390926)
	   // VCHA NGED


#define VINCLUDED_DOFFS 11
#define VINCLUDED_COP >=
#define VINCLUDED_CHECK(s) (*(int*)((s)+2) ==1279479369 && *(int*)((s)+6)==1145390165)
	   // INCL UDED

#define VLCONTROL_DOFFS 10
#define VLCONTROL_COP >
#define VLCONTROL_CHECK(s) (*(int*)((s)+2) == 1313817420 && *(int*)((s)+6)==1280266836)
	   // LCON TROL

#define USERINFO_DOFFS 8
#define USERINFO_COP >=
#define USERINFO_CHECK(s) (*(int*)((s)+1) == 1380275029 && *(int*)((s)+5)==1330007625)
	   // USER INFO


#define WARNING_DOFFS 8  
#define WARNING_COP >=
#define WARNING_CHECK(s) (*(int*)(s)==1380013857 && *(int*)((s)+4) == 1196312910)
	   // WARN ING

#define EDITION_DOFFS 8  
#define EDITION_COP >=
#define EDITION_CHECK(s) (*(int*)(s)==1229210913 && *(int*)((s)+4)==1313818964 )
	   // !EDI TION

#define VERLINK_DOFFS 8
#define VERLINK_COP >=
#define VERLINK_CHECK(s) (*(int*)(s)==1380275745 && *(int*)((s)+4)==1263421772 )
	   // !VER LINK

#define ACTIVE_DOFFS 7  
#define ACTIVE_COP >=
#define ACTIVE_CHECK(s) ((s)[1]=='A' && (s)[2]=='C' && *(int*)((s)+3)==1163282772 )
	   // !AC TIVE

#define IS_CMD(cmd,s,l) (((l)cmd ## _COP cmd ## _DOFFS) && cmd ## _CHECK(s) )
#define CMD_CALL(cmd,proc,s,l) proc(((s)+ cmd ## _DOFFS), (l - cmd ## _DOFFS))
#define CMD_CALL3(cmd,proc,s,l,d) proc(((s)+ cmd ## _DOFFS), (l - cmd ## _DOFFS),(d))
#define CMD_CALL4(cmd,proc,s,l,d,b) proc(((s)+ cmd ## _DOFFS), (l - cmd ## _DOFFS),(d),(b))

static inline int getInt(const char *s, int l, int &result)
{
	const char * p = s;
	while ( p-s < l && (*p == ' ' || *p=='\t' ) ) p++;
	
	if( !(p-s < l) ) return 1;
	
	result = atoi(p);
	
	while ( *p >= '0' && *p <= '9' ) p++;
	while ( p-s < l && (*p == ' ' || *p=='\t' ) ) p++;
	
	if ( p - s < l )
	{
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,
			"Данные после команды.\n");
	}
	return 0;
}

static inline int getChars(const char *s, int l, const char *&result)
  /*
   return length on success, 0 on error
   */
{
	int off =0;

     while( l && (*s == ' ' || *s=='\t' ) ){
	  s++; l--;
	}
	if( !l ) return 0;				

	off = l-1;
	while( off && (s[off] == ' ' || s[off]=='\t') )  off --;
	if( off+1 ){
	  result = s;
	  return off+1;
	}else{
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Invariant failure in getChars()" );
		return 0;
	}

}

static inline unsigned char isValidDate(date& d)
{
	if ((d.da_day <= 0) || (d.da_mon <= 0) || (d.da_year < 1) || (d.da_year > 3000)) return 0;
	if (d.da_mon == 2)
	{
		if (((d.da_year % 4 == 0) && ((d.da_year % 100 != 0) || (d.da_year % 400 == 0))))
		{
			if (d.da_day <= 29) return 1;
		}
		else
		{
			if (d.da_day <= 28) return 1;
		}
	} else if ((d.da_mon == 1) || (d.da_mon == 3) || (d.da_mon == 5) || (d.da_mon == 7) || (d.da_mon == 8) || (d.da_mon == 10) || (d.da_mon == 12))
	{
		if (d.da_day <= 31) return 1;
	} else if ((d.da_mon == 4) || (d.da_mon == 6) || (d.da_mon == 9) || (d.da_mon == 11))
	{
		if (d.da_day <= 30) return 1;
	}
	return 0;
}

static inline int getDate(const char *s, int l, date &d )
{
	const char *p = s;
	const char *dd;
	const char *mm;
	const char *yyyy;

	if (!l) return 0;
	while (*p == ' ' || *p == '\t') p++;
	if (*p >= '0' && *p <= '9') dd = p;
	else return 0;
	while (*p >= '0' && *p <= '9') p++; p++;
	if (*(p-1) == '/' && *p >= '0' && *p <= '9') mm = p;
	else return 0;
	while (*p >= '0' && *p <= '9') p++; p++;
	if (*(p-1) == '/' && *p >= '0' && *p <= '9') yyyy = p;
	else return 0;
	d.da_day = atoi( dd );
	d.da_mon = atoi( mm );
	d.da_year = atoi( yyyy );
	if (!isValidDate(d)) return 0;
	while (*p >= '0' && *p <= '9') p++;
	while ((*p == ' ' || *p <= '\t') && p-s < l) p++;
	if ( p - s < l )
	{
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"Данные после команды: ");
		FString fs(s,l); fs.bDoFree = 1;
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",fs.chars());
	}
	return 1;
}



#endif
