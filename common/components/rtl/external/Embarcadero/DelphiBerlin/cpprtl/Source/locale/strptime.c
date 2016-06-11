/*------------------------------------------------------------------------
 * filename - strptime.c
 *
 * function(s)
 *      strptime - converts string to data and time structure
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2002, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */



#include <_io.h>
#include <_printf.h>
#include <time.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <_locale.h>
#include <ctype.h>
#include <math.h>

#define EATWS(s) \
while(*s && isspace(*s)) \
  s++;

#define LEAP_YEAR(x) (!(x%4) && ((x%100) || !(x%400)))

const int __month_days[2][13] = {
  {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365},
  {0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366}
};

const char* internal_strptime( const char *s, const char *fmt, struct tm *t);
void calculate_tm_fields(struct tm *t);

char* _RTLENTRY _EXPFUNC
strptime( const char *s, const char *fmt, struct tm *t )
{
  char *p = NULL;

  if(!s || !fmt || !t)
    return p;

  memset(t,0,sizeof(struct tm));

  /* Set to -1 to detect if wday or yday has been touched */
  t->tm_wday=-1;
  t->tm_yday=-1;

  p = (char *) internal_strptime(s,fmt,t);

  calculate_tm_fields(t);

  /* Don't let yday or wday get returned with invalid value */
  if(t->tm_yday < 0)
    t->tm_yday = 0;
  if(t->tm_wday < 0)
    t->tm_wday = 0;

  return p;
}

/* This just does Zeller's Algorithm */
int zellers_week_day_calc(int m, int d, int y) {

  int cen, cyear, ig;
  float g;

  if(m >= 3){	
    m -= 2;
  }
  else {
    m += 10;
  }
  
  if( (m == 11) || (m == 12) ){
    y--;
  }

  cen = y/100;
  cyear = y%100;
  
  g = floor(2.6 * m - .2);
  
  g += floor(d + cyear);
  g += (float)cyear / 4.0;	
  g = floor(g);
  g += floor(cen / 4);
  g -= floor(2 * cen);
  ig = (int)g;
  ig %= 7;
	
  if(ig < 0){
    ig += 7;
  }
       
  return ig;
}

/* Calculate any fields possible */
void calculate_tm_fields(struct tm *t) 
{

  int y;

  y = t->tm_year + 1900;

  if(t->tm_mday)
    /* If mday is non-zero assume a complete date (ie mm/dd/YYYY) */
    t->tm_yday = __month_days[LEAP_YEAR(y)][t->tm_mon] + t->tm_mday - 1;
  else if(t->tm_yday >= 0) {
    int i;

    /* Set month and month day */
    for(i=0; t->tm_yday > (__month_days[LEAP_YEAR(y)][i+1]-1); i++)
      ;

    t->tm_mon = i;
    t->tm_mday = t->tm_yday - __month_days[LEAP_YEAR(y)][t->tm_mon]+1;
  }

  if(t->tm_wday < 0)
    /* Calculate the day of the week if wday isn't already set */
    t->tm_wday = zellers_week_day_calc(t->tm_mon+1,t->tm_mday,y); 
}

const char* internal_strptime( const char *s, const char *fmt, struct tm *t)
{

  int sweek=0, mweek=0;
  
  do {

    /* Eat all the whitespace at the head of the strings */
    EATWS(s);
    EATWS(fmt);

    /* Found a field desctiptor */
    if(*fmt == '%') {

      /* Buffer used to hold a field of input */
      char buff[255]; 
      /* Delimeter buffer (used in recursive formats */
      char dbuff[2];
      /* Field type */
      char field;
      /* Delimeter value */
      char delim;
      /* ANSI flag */
      int flag;
      int i;
      
      flag=0;
      dbuff[1] = '\0';

      /* Get the field descriptor value*/
      field = *(++fmt);

      if(!field)
	break;

      /* Is ANSI flag set? */
      if(field == '#') {
	flag=1;
	field = *(++fmt);
      }

      /* Ignore E and O modifiers (used only for strftime) */
      if(field == 'E' || field == 'O')
	field = *(++fmt);

      /* If no descriptor value found, exit */
      if(!field)
	break;

      /* If field is just % make sure input matches and continue */
      if(field == '%') {
	if(*s != '%')
	  break;
	continue;
      }

      if(field != 'C') {

	/* The next char, after whitespace, is the delim */
	fmt++;
	EATWS(fmt);
	delim = *fmt;

	/* If the delim is a % check for %% and backup if not %% */
	if(*fmt == '%') {
	  if(*(fmt+1) != '%') {
	    delim = '\0';
	    fmt--;
	  } else
	    fmt++;
	}

	dbuff[0] = delim;

	/* Handle recursive formats here. */
	switch(field) {
	  /* Date and time */
	case 'c': 
	  if(flag) {
	    strcpy(buff,_getLocaleTimeInfo(LOCALE_SLONGDATE));
	    strcat(buff," %X");
	    strcat(buff,dbuff);
	  } else {
	    strcpy(buff,"%x %X"); 
	    strcat(buff,dbuff);
	  }
	  s = internal_strptime(s,buff,t);  
	  continue;

	  /* Locale date */
	case 'x':
	case 'D': strcpy(buff,_getLocaleTimeInfo(LOCALE_SSHORTDATE)); strcat(buff,dbuff); s = internal_strptime(s,buff,t); continue;
	  /* Time */
	case 'r': strcpy(buff,"%I:%M:%S %p"); strcat(buff,dbuff); s = internal_strptime(s,buff,t); continue;
	case 'R': strcpy(buff,"%H:%M"); strcat(buff,dbuff); s = internal_strptime(s,buff,t); continue;
	case 'T': strcpy(buff,"%H:%M:%S"); strcat(buff,dbuff); s = internal_strptime(s,buff,t); continue;
	case 'X': strcpy(buff,_getLocaleTimeInfo(LOCALE_STIMEFORMAT)), strcat(buff,dbuff); s = internal_strptime(s,buff,t); continue;
	}

	/* Copy field from input into buffer. Stop at whitespace or delim. */
	for(i=0; *s && (*s != delim) && !isspace(*s); i++, s++)
	  buff[i] = *s;
	buff[i] = '\0';

	/* If there was a delim, eat whitespace, and check for matching delim in input */
	if(delim) {
	  EATWS(s);
	  if(*s != delim)
	    break;
	}
      } else {
	buff[0] = *s++;
	buff[1] = *s++;
	buff[2] = '\0';
      }

      /* Handle the string -> tm conversion here */
      switch(field) {
	/* Abbreviated day name */
      case 'a': {
	for(i=0; i<7; i++) {
	  if(!strcmpi(buff,_getLocaleTimeInfo(LOCALE_SABBREVDAYNAME1+i))) {
	    t->tm_wday = i+1;
	    /* break out of for loop */
	    break;
	  }
	}
	if(i==7)
	  return NULL;
	break;
      }
      /* Day name */
      case 'A': {
	for(i=0; i<7; i++) {
	  if(!strcmpi(buff,_getLocaleTimeInfo(LOCALE_SDAYNAME1+i))) {
	    t->tm_wday = i+1;
	    /* break out of for loop */
	    break;
	  }
	}
	if(i==7)
	  return NULL;
	break;
      }
      /* Abbreviated month name */
      case 'b':
      case 'h': {
	for(i=0; i<12; i++) {
	  if(!strcmpi(buff,_getLocaleTimeInfo(LOCALE_SABBREVMONTHNAME1+i))) {
	    t->tm_mon = i;
	    /* break out of for loop */
	    break;
	  }
	}
	if(i==12)
	  return NULL;
	break;
      }
      /* Month name */
      case 'B': {
	for(i=0; i<12; i++) {
	  if(!strcmpi(buff,_getLocaleTimeInfo(LOCALE_SMONTHNAME1+i))) {
	    t->tm_mon = i;
	    /* break out of for loop */
	    break;
	  }
	}
	if(i==12)
	  return NULL;
	break;
      }
      /* Century */
      case 'C': t->tm_year = (atoi(buff)-19)*100 + t->tm_year%100; break;
	/* Day of month */
	/* POSIX */
      case 'e':
	/* ANSI */
      case 'd': t->tm_mday = atoi(buff); break;
	/* Hour */
      case 'H': 
      case 'I': t->tm_hour += atoi(buff); t->tm_hour %= 24; break;
	/* Day of year */
      case 'j': t->tm_yday = atoi(buff)-1; break;
	/* Month number */
      case 'm': t->tm_mon = atoi(buff)-1; break;
	/* Minutes */
      case 'M': t->tm_min = atoi(buff)%60; break;
	/* AM or PM */
      case 'p': {
	if(!strcmpi(buff,_getLocaleTimeInfo(LOCALE_S2359))) {
	  t->tm_hour += 12;
	  t->tm_hour %= 24;
	}
	break;
      }
      /* Seconds */
      case 'S': t->tm_sec = atoi(buff)%60; break;
	/* Week of year (week starts Sunday) */
      case 'U': sweek = atoi(buff); break;
	/* Day of week */
      case 'w': t->tm_wday = atoi(buff)%7; break;
	/* Week of year (week starts Monday) */
      case 'W': mweek = atoi(buff); break;
	/* Short year */
      case 'y': t->tm_year = atoi(buff) + (t->tm_year - (t->tm_year%100)); break;
	/* Full year */
      case 'Y': t->tm_year = atoi(buff) - 1900; break;
	/* Need to add timezone stuff here */
      case 'z': break;
      case 'Z': break;
      }

      /* Don't run off the end of the format string */
      if(!*fmt)
	break;

    } else if(*s != *fmt) {
      /* Input and format string do not match so exit */
      break;
    }
  } while(*(++s) && *(++fmt));

  /* If week and weekday have been gived, compute
     day of year. Assume year is valid.
  */
  if(sweek && (t->tm_yday<0) && (t->tm_wday>=0)) {
    int day1;

    day1 = zellers_week_day_calc(1,1,t->tm_year+1900);

    t->tm_yday = (sweek-1)*7-day1+t->tm_wday;

    /* Hmmm...docs say Sun==0, but Sun actually equals 7, Mon==1, etc */
    if(t->tm_wday == 7)
      t->tm_yday -= 7;
    
  }
  if(mweek && (t->tm_yday<0) && (t->tm_wday>=0)) {
    int day1;

    day1 = zellers_week_day_calc(1,1,t->tm_year+1900);

    t->tm_yday = (mweek-1)*7-day1+t->tm_wday;
  }

  return s;
}
