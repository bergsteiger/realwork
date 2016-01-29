#ifndef _ADVLOG_H_
#define _ADVLOG_H_

#include <cstdio> // GARANT_GCC
#include "gardefs.h"  // ????????????
#include "gar_defs.hpp"
#include <cstring>
#include <deque>

#define ADVLOG_BUFFER_SIZE 4096
/*
//#define DEBUG   AdvLogger::LOG_DEBUG_MPCXC // GARANT_GCC macro conflict under Linux
#define INFO    AdvLogger::LOG_INFO_MPCXC
#define WARNING AdvLogger::LOG_WARNING_MPCXC
#if !defined(_AFXDLL) && !defined(_WINDOWS_)
	#define ERROR   AdvLogger::LOG_ERROR
#endif
#define FATAL   AdvLogger::LOG_FATAL

#define CDKOI	AdvLogger::CD_KOI
#define CDALT	AdvLogger::CD_ALT
#define CDWIN	AdvLogger::CD_WIN
#define CDMAC	AdvLogger::CD_MAC
*/
class AdvLogger {
	public:
		// logging priority
		enum LogPriority {
			LOG_DEBUG_MPCXC 	= 0,
			LOG_INFO_MPCXC	= 1,
			LOG_WARNING_MPCXC	= 2,
			LOG_ERROR	= 3,
			LOG_FATAL	= 4
		};

		enum Coding {
			CD_NONE	= 0,
			CD_ALT	= 1,
			CD_KOI	= 2,
			CD_WIN	= 3,
			CD_MAC	= 4
		};

		static Coding MpcxcCurEncoding () {
			code_t cd = mpcxc_cd_cursys ();
			switch (cd) {
				case cd_dos: return CD_ALT; break;
				case cd_win: return CD_WIN; break;
				case cd_koi: return CD_KOI; break;
				case cd_mac: return CD_MAC; break;
				default: return CD_ALT;
			}
		}

#define CD_DEF MpcxcCurEncoding () // GARANT_TO_IMPROVE_CODING

		int 		lineno;			// current line nomber
		long		topicno;		// current topic
		char		*flName;		// current file

		int		bHideInfoMessages;
		
		AdvLogger(LogPriority pr = LOG_INFO_MPCXC);
		AdvLogger(Coding cd, LogPriority pr = LOG_INFO_MPCXC);	// to cerr
		AdvLogger(const char *fname, Coding cd = CD_DEF, 
					LogPriority pr = LOG_INFO_MPCXC);			// to file fname
		//AdvLogger(FILE* of, Coding cd = CD_DEF, LogPriority pr = LOG_INFO_MPCXC);	
								// to stream
		AdvLogger(FILE *fout, Coding cd = CD_DEF, LogPriority pr = LOG_INFO_MPCXC);	
								// use opened file
		~AdvLogger();

		void setDestCoding(Coding cd);
		void setLogName(const char *fname, int useBoth = 1);
		void setLogName(std::deque<std::string> &errors, const char *fname, const char *alt_name, int useBoth = 1);
		void setLogFile(FILE* f);

		void setLN(int n)
		{
			lineno = n;
		}

		void setTopic(long n)
		{
			topicno = n;
		}

		void setFileName(const char *str);
	
		void noHdr()
		{
			topicno = 0;
			bNoHdr = 1;
		}
		void globalNoHdr()
		{
			bGlobalNoHdr = 1;
		}
		void noPrior()
		{
			bNoPrior = 1;
		}
		void flush();

		int printf(LogPriority pr, const char *fmt, ...);	
		int printf(std::deque<std::string> &errors, LogPriority pr, const char *fmt, ...);	
				// use original symbols
		int printfC(LogPriority pr, Coding cd, const char *fmt, ...);
				// recode due to cd
		int printfC(std::deque<std::string> &errors, LogPriority pr, Coding cd, const char *fmt, ...);
		int printfCP(Coding cd, const char *str, ...);
				// just write to log with decoding
		int printfCPW(const char *str, ...);
				// just write to log with decoding fom AdvLogger::CD_WIN
		int printRev ( LogPriority pr, revision * pRev, int iShort = 0);
				// print revision with out priority

		int print (const char *str);
	private:
		int dest;		// 0 if to stream 
						// 1 if to opened file
						// 2 if to internal opened file
		FILE 		*ofile;			// destination file
		FILE		*outfile;		// 'screen' streaming file
		LogPriority priority; 	//log priority: oputput olny if pr is greater
		Coding		dest_coding;  	// destination coding
		unsigned char *tables[6];	// decode tables
		char 		bNoHdr;			// do not use header (..,..)
		char		bGlobalNoHdr;	// global noHdr
		int			use_both;		// use both file and stream
		char		bNoPrior;		// no print priority
		
		char* RusRecode(char *str, Coding src_coding);
};

extern int mpcxc_printfwin(const char* fmt, ...);
extern int mpcxc_printfwin(std::vector<std::string> *strings, const char* fmt, ...);
extern int mpcxc_printwin(const char* str);

#endif // _ADVLOG_H_
