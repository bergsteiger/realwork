#include "shared/Core/fix/mpcxc.h"
#include "osdep.h"

#include <cstdio>
#include <cstdlib>
#include <fcntl.h>
//#include <unistd.h>
#include <cstring>
#include <cerrno>
#include <sys/ctime>
#include <ctime>
#include <getopt.h>

#ifdef __MSVC__
#include <winsock.h>
#endif


int main(int argc, char **argv)
{
	int c;
	char *ofile = 0;
	char *ifile = 0;

	int bufsz =0;
	int nbufs =0;

	while ((c = getopt(argc, argv, "i:o:b:n:")) != EOF){
		switch(c){
			case 'n':
				nbufs = atoi(optarg);
				break;
			case 'b':
				bufsz = atoi(optarg);
				break;
			case 'i':
				ifile = optarg;
				break;
			case 'o':
				ofile = optarg;
				break;
			default:
				ifile = 0;
		}
	}
	if( !ifile || !ofile || !nbufs || !bufsz) {
		printf("FIFO buffer balancer \n");
		printf(" %s: -i <input file> -o <output file> -b <blocksize> -n <number of blocks>\n", argv[0]);
		return 1;
	}

	int ifd = ace_os_open( ifile, ACE_OS_O_RDONLY );
	int ofd = ace_os_open( ofile, ACE_OS_O_WRONLY );

	fd_set read_set, write_set;
	FD_ZERO(&read_set);
	FD_ZERO(&write_set);
	char *thebuf=(char*)calloc(bufsz,nbufs);
	int maxfd = (ofd>ifd)?ofd+1:ifd+1;
	int in_buf = 0;
	int out_buf = 0;
	int count = 0;
	int last_in_bytes = 0;
	int eoi =0;
	int eow =0;
	int in_cbytes, out_cbytes;
	in_cbytes = out_cbytes =0;
	for( ;; ){
		struct timeval tv;
		int may_read_more = (count <nbufs ) && !eoi;
		int may_write_more = (count > 0 ) && !eow;
		if( ifd != -1 ) FD_SET(ifd, &read_set);
		if( ofd != -1 ) FD_SET(ofd, &write_set);
		tv.tv_sec = tv.tv_usec =0;
		int i = select( maxfd, 
						(may_read_more)?&read_set:0, 
						(may_write_more)?&write_set:0, 
						0,  // no error fds
						0   // no timeout
						);
		if( i == -1 ){
			fprintf(stderr,"select: %s\n", strerror(errno) );
		}else{
			if( i ){
				if( ofd != -1 && FD_ISSET(ofd, &write_set) && may_write_more ){
					if( !eoi || count > 1 ){
						int bt = ace_os_write(ofd,thebuf+bufsz*out_buf,bufsz);
						out_cbytes += bt;
						if( bt != bufsz ){
							fprintf(stderr,
								"balancer: "
								"unexpected %d of %d bytes written.\n",
								bt, bufsz );
							ace_os_close(ofd);
							printf("balancer: total out bytes %d\n", 
								out_cbytes );
							return 2;
						}
						out_buf++;
						if( out_buf == nbufs ) out_buf = 0;
						count --;
					}else{
						// last bytes
						int bt = ace_os_write(ofd,thebuf+bufsz*out_buf,last_in_bytes);
						out_cbytes += bt;
						printf("balancer: total out bytes %d\n", out_cbytes );
						ace_os_close(ofd);
						if( bt != last_in_bytes ){
							fprintf(stderr,
								"balancer: "
								"unexpected %d of %d bytes written.\n",
								bt, bufsz );
							return 2;
						}else{
							return 0;
						}
					}
				}
				if( ifd != -1 && FD_ISSET(ifd, &read_set) && may_read_more ){
					int bt = ace_os_read(ifd,thebuf+bufsz*in_buf,bufsz);
					in_cbytes += bt;
					if( bt == bufsz){
						in_buf++;
						if( in_buf == nbufs ) in_buf = 0;
						count ++;
					}else{
						// no more
						last_in_bytes = bt;
						count ++;
						printf("balancer: total in bytes %d\n", in_cbytes );
						// warning: no modification of queue pointer!
						ace_os_close(ifd);
						ifd = -1;
						eoi = 1;
					}
				}
			}
		}
	}
	return 0;
}












