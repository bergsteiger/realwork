#ifndef __GETOPT_H__
#define __GETOPT_H__

#ifdef __cplusplus
extern "C" {
#endif

extern int optind;
extern int opterr;
extern int optopt;
extern char *optarg;
extern int optreset;

int getopt(int argc, char *argv[], char *optstring);

#ifdef __cplusplus
}
#endif

#endif  /* __GETOPT_H__ */
