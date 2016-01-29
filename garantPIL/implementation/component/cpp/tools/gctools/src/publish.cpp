#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <vector>
#include <cstring>
#include "CaseString.defs.h"
#include "gclog.h"
#include "gardefs.h"
#include "fstringer.h"
#include "publish.h"

extern	std::deque<std::string> errors;

static char *months [] =
{
	"","Январь","Февраль","Март",
		"Апрель","Май","Июнь","Июль",
		"Август","Сентябрь","Октябрь",
		"Ноябрь","Декабрь"
};

static char *monthsp [] =
{
	"","января","февраля","марта",
		"апреля","мая","июня","июля",
		"августа","сентября","октября",
		"ноября","декабря"
};

int checkPubDates(date& d1, date& d2)
{
	if (d1.da_year < 900 || d1.da_year > 3500)
		return 0;
	if (d1.da_mon < 0 || d1.da_mon > 12)
		return 0;
	if (d1.da_day < 0 || d1.da_day > 31)
		return 0;

	if (d2.da_year != 0)
	{
		if (d2.da_year < 900 || d2.da_year > 3500)
			return 0;
		if (d2.da_mon < 1 || d2.da_mon > 12)
			return 0;
		if (d2.da_day < 1 || d2.da_day > 31)
			return 0;

		return (d1.da_day && d1.da_mon && d1.da_year);
	}

	return 1;
}

unsigned char getPublishDate(const char * sd, date& d1, date& d2)
{
	const char * p = sd, * q = strchr(sd,'-');
	
	if (q)
	{
		if (strlen(p) == 21)
		{
			d1.da_day = (unsigned char)atoi(p);
			d1.da_mon = (unsigned char)atoi(p+3);
			d1.da_year = (short)atoi(p+6);
			d2.da_day = (unsigned char)atoi(q+1);
			d2.da_mon = (unsigned char)atoi(q+4);
			d2.da_year = (short)atoi(q+7);
		}
		else
			return 0;
	}
	else
	{
		if (strlen(p) == 10)
		{
			d1.da_day = (unsigned char)atoi(p);
			d1.da_mon = (unsigned char)atoi(p+3);
			d1.da_year = (short)atoi(p+6);
		}
		else if (strlen(p) == 7)
		{
			d1.da_mon = (unsigned char)atoi(p);
			d1.da_year = (short)atoi(p+3);
		}
		else if (strlen(p) == 4)
		{
			d1.da_year = atoi(p);
		}
		else
			return 0;
	}
	return 1;
}

std::map<std::string,std::string> map_prefix_name;

char* new2old(const char* p_new,unsigned int max_key_length)
{
	date d1,d2;
	bzero((char*)&d1,sizeof(date));
	bzero((char*)&d2,sizeof(date));

	char *p, *q;

	p = (char*)p_new;
	q = strchr(p,'|');
	
	FString source_nodes(p,q-p);
	source_nodes.bDoFree = 1;

	p = q+1; q = strchr(p,'|'); 
	if (!q) {
		gclog.printfC(AdvLogger::LOG_ERROR,AdvLogger::CD_WIN,"═хтхЁэ√щ ЇюЁьрЄ ъюьрэф√ PUBLISHEDIN: ");
		gclog.printfCP(AdvLogger::CD_ALT,"%s\n",p_new);
		return 0;
	}

	FString sdate(p,q-p);
	sdate.bDoFree = 1;

	if (!getPublishDate(sdate.chars(),d1,d2)) {
		gclog.printfC(AdvLogger::LOG_ERROR,AdvLogger::CD_WIN,"═хфюяєёЄшь√х чэрўхэш  фрЄ√ т ъюьрэфх PUBLISHEDIN: ");
		gclog.printfCP(AdvLogger::CD_ALT,"%s\n",p_new);
		return 0;
	}

	if (!checkPubDates(d1,d2)) {
		gclog.printfC(AdvLogger::LOG_ERROR,AdvLogger::CD_WIN,"═хфюяєёЄшь√х чэрўхэш  фрЄ√ т ъюьрэфх PUBLISHEDIN: ");
		gclog.printfCP(AdvLogger::CD_ALT,"%s\n",p_new);
		return 0;
	}

	char year_node[15];
	char month_node[25];
	char day_node[15];

	*year_node = *month_node = *day_node = 0;

	if (d1.da_year == d2.da_year || d2.da_year == 0) {
		sprintf(year_node,"%.3ld=%.4ld\0",2850-d1.da_year,d1.da_year);
		if (d1.da_mon) {
			if (d1.da_mon == d2.da_mon || d2.da_mon == 0 ||  (d1.da_day != 1 && d2.da_day < 28)) {
				sprintf(month_node,"%.3ld=%s\0",d1.da_mon,months[(int)d1.da_mon]);
				if (d1.da_day) {
					if (!(d1.da_day == 1 && d2.da_day > 27)) {
						if (d2.da_day != 0 && d1.da_day != d2.da_day)
							sprintf(day_node,"%.3ld=%ld-%ld\0",d1.da_day, d1.da_day, d2.da_day);
					}
				}
			}
			else if (!(d1.da_mon == 1 && d2.da_mon == 12)) {
				sprintf(month_node,"%.3ld=%s-%s\0",d1.da_mon, months[(int)d1.da_mon], months[(int)d2.da_mon]);
			}
		}
	} else {
		sprintf(year_node,"%.3ld=%.4ld-%.4ld\0",2850-d1.da_year,d1.da_year,d2.da_year);
	}

	p = q+1; q = strchr(p,'|');
	char *num_node = 0, *res;
	if (!q) {
		//gclog.printfC(AdvLogger::LOG_WARNING,AdvLogger::CD_WIN,"═х юяЁхфхыхэ эюьхЁ т√яєёър т ъюьрэфх PUBLISHEDIN: ");
		//gclog.printfCP(AdvLogger::CD_ALT,"%s\n",p_new);
		res = new char[source_nodes.length() + strlen(year_node) + strlen(month_node) + strlen(day_node) + 200];
		num_node = (char*)malloc(source_nodes.length() + 200);
		const char * q1 = strrchr(source_nodes.chars(),'\\');
		if (!q1) q1 = source_nodes.chars(); else q1++;
		int l = 0;

		if (strlen(p)) {
			if (strchr (p, '/'))
				l = sprintf(num_node,"%.3d=%s, %s год, N %s\0",((atoi(p)+atoi(strchr (p, '/')+1))%1000),q1+4,year_node+4,p);
			else
				l = sprintf(num_node,"%.3d=%s, %s год, N %s\0",(atoi(p)%1000),q1+4,year_node+4,p);
		}
		else {
			if (!d2.da_year && *year_node && *month_node && d1.da_day) {
				l = sprintf (num_node, "%ld=%s, %ld %s %ld г.", d1.da_day, q1+4, d1.da_day, monthsp[(int)d1.da_mon], d1.da_year);
			} else {
				l = sprintf(num_node,"000=%s, %s год\0",q1+4,year_node+4);
			}
		}

		if (strlen(num_node) >= max_key_length) {
			gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Получен слишком длинный раздел: '%s'\n",num_node);
			free(num_node);
			return 0;
		}

		if (*year_node && *month_node && *day_node)
			sprintf(res,"%s\\%s\\%s\\%s\\%s\0",source_nodes.chars(),year_node,month_node,day_node,num_node);
		else if (*year_node && *month_node && !*day_node)
			sprintf(res,"%s\\%s\\%s\\%s\0",source_nodes.chars(),year_node,month_node,num_node);
		else if (*year_node && !*month_node && !*day_node)
			sprintf(res,"%s\\%s\\%s\0",source_nodes.chars(),year_node,num_node);

		free (num_node);
	} else {
		*q=0;
		num_node = (char*)malloc(source_nodes.length() + 200);
		const char * q1 = strrchr(source_nodes.chars(),'\\');
		if (!q1) q1 = source_nodes.chars(); else q1++;
		int l = 0;
		if (strlen(p)) {
			if (strchr (p, '/'))
				l = sprintf(num_node,"%.3d=%s, %s год, N %s\0",((atoi(p)+atoi(strchr (p, '/')+1))%1000),q1+4,year_node+4,p);
			else
				l = sprintf(num_node,"%.3d=%s, %s год, N %s\0",(atoi(p)%1000),q1+4,year_node+4,p);
		}
		else
			l = sprintf(num_node,"%.3d=%s, %s год\0",(atoi(p)%1000),q1+4,year_node+4);

		*q='|';	p = q+1; 

		if (*p != '\0'/* && *p != 13*/) {
			sprintf(num_node + l," (%s)\0",p);
		}

		if (strlen(num_node) >= max_key_length) {
			gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Получен слишком длинный раздел: '%s'\n",num_node);
			free(num_node);
			return 0;
		}

		res = new char[source_nodes.length() + strlen(year_node) + strlen(month_node) + strlen(day_node) + strlen(num_node)+10];

		if (*year_node && *month_node && *day_node)
			sprintf(res,"%s\\%s\\%s\\%s\\%s\0",source_nodes.chars(),year_node,month_node,day_node,num_node);
		else if (*year_node && *month_node && !*day_node)
			sprintf(res,"%s\\%s\\%s\\%s\0",source_nodes.chars(),year_node,month_node,num_node);
		else if (*year_node && !*month_node && !*day_node)
			sprintf(res,"%s\\%s\\%s\0",source_nodes.chars(),year_node,num_node);

		free(num_node);
	}

	char* ptr = res, prefix [4], small_name [4096];
	std::string sprefix, name;
	prefix [3] = 0;
	long levels = 0;
	while (ptr) {
		strncpy (prefix, ptr, 3);
		char* saved_prefix = ptr;
		if (sprefix.size ())
			sprefix += "\\";
		sprefix += prefix;

		if (name.size ())
			name += "\\";
		char *old_ptr = ptr + 4;
		ptr = strchr (ptr, '\\');
		gk_bzero (small_name, sizeof (small_name));
		if (ptr) {
			strncpy (small_name, old_ptr, ptr - old_ptr);
			ptr++;
		} else {
			strcpy (small_name, old_ptr);
		}
		name += small_name;

		std::map<std::string,std::string>::const_iterator map_it = map_prefix_name.find (sprefix);
		if (map_it == map_prefix_name.end ()) {
			map_prefix_name.insert (std::map<std::string,std::string>::value_type (sprefix, name));
		} else {
			if (strcmp (map_it->second.c_str (), name.c_str ())) {
				long lprefix = atol (prefix);
				while (lprefix < 999) {
					lprefix++;
					sprintf (prefix, "%03d", lprefix);
					sprefix.erase (sprefix.size () - 3, 3);
					sprefix += prefix;
					map_it = map_prefix_name.find (sprefix);
					if (map_it == map_prefix_name.end ()) {
						map_prefix_name.insert (std::map<std::string,std::string>::value_type (sprefix, name));
						break;
					} else {
						if (!strcmp (map_it->second.c_str (), name.c_str ()))
							break;
					}
				}
				strncpy (saved_prefix, prefix, 3);
			}
		}
		levels++;
	}

	return res;
}

int loadPublishMap(GFStringFStringMap *m, GFStringFStringMap *mconv, const char *fn, int maxKeyLength)
{
	FILE * pub_file = mpcxc_fopen( fn, "r" );
	
	FileStringer fst( fn );
	if( ! fst.OK() )
	{
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"я█╔┬╦┴ ╧╘╦╥┘╘╔╤ ╞┴╩╠┴ %s\n", fn);
		return 1;
	}
	const char *buf;
	int l;

	gclog.setFileName( fn );

	char fullName[16384];
	char stripName[16384];

	gclog.setLN(1);

	for (int cln = 1; (buf=fst.gets(l)) != 0; cln++) {
		if ( l == 0 || buf[0] == ';')
			continue;
		gclog.setLN(cln);

		memcpy(fullName, buf, l);
		fullName[l] = 0;

		char * source_part_end = strchr(fullName,'|');
		if (!source_part_end) {
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "№╘┴╠╧╬╬┘╩ ╞┴╩╠ ╔╙╘╧▐╬╔╦╧╫ ╨╒┬╠╔╦┴├╔╩ ╫ ╙╘┴╥╧═ ╞╧╥═┴╘┼.\n");
			exit(1);
		}
		char * p = fullName;
		char * q = strchr(fullName,'\\');
		int pos = 0;
		while (q && q < source_part_end) {
			strncpy(stripName+pos,p+4,q-p-4); pos += q-p-4;
			stripName[pos] = '\\'; pos++;
			p = q+1; q = strchr(p,'\\');
		}
		if (q && q < source_part_end) continue;
		strncpy(stripName+pos,p+4,source_part_end-p-4); pos += source_part_end-p-4;
		strcpy(stripName+pos,source_part_end);
		char * old = new2old(fullName,maxKeyLength);
		
		if (!old) continue;
		
		FString sp(stripName);
		FString op(old);

		delete[] old;

		if( m->contains(sp) ) {
			gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Ё╧╫╘╧╥┼╬╔┼ ");
			gclog.printfCP(AdvLogger::CD_ALT, "'%s'\n", sp.chars() );
			op.bDoFree = 1;
			continue;
		}
		
		FString fp(fullName);

		(*m)[sp] = fp;
		(*mconv)[sp] = op;
	}
	
	fclose (pub_file);
	map_prefix_name.clear ();

	return 0;
}
