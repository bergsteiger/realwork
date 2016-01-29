#ifndef __LOG_H
#define __LOG_H

#define TF_CURRENT 0
#define TF_ELAPSED 1
#define TF_TOTAL   2

#ifdef __cplusplus
extern "C" {
#endif

extern int create_log(char *, int);
extern void m_log(char *);
extern char* fmtime(char *, short);
extern char* flog(char *format, ...);
void logtime(short nMode, char *format, ...);

#ifdef __cplusplus
}
#endif

#endif

