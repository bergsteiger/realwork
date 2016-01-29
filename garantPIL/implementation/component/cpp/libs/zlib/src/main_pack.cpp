#include "shared/Core/fix/mpcxc.h"
#include "pack.h"

#include <iostream>
#include <cstdlib>

const unsigned int EXTRAFSIZE = 65536;

#ifdef OPT_PACK
extern "C" int deflateExit ();
#endif

int main(int argc, char* argv[]) {

try {
  int fd = ace_os_open (argv[1], O_RDONLY);
  if (fd == -1) throw std::logic_error ("bad open file");
  long fsize = ace_os_filesize (fd);
  if (fsize < 0) throw std::logic_error ("bad file size");
  char* buf = new char [fsize];
  int res = ace_os_read (fd, buf, fsize);
  ace_os_close (fd);
  
  if (res != int(fsize)) throw std::logic_error ("bad file read");
  char* packed_buf = new char [fsize+EXTRAFSIZE];
  unsigned int packed_fsize = Zip::Pack (buf, fsize, packed_buf, fsize+EXTRAFSIZE);
  if (packed_fsize == 0) throw std::logic_error ("bad pack");

  int fdout = ace_os_open (argv[2], O_CREAT | O_TRUNC | O_WRONLY);
  if (fdout == -1) throw std::logic_error ("bad create file");
  int resout = ace_os_write (fdout, packed_buf, packed_fsize);
  if (resout != int(packed_fsize)) throw std::logic_error ("bad file write");
  ace_os_close (fdout);
  
  delete [] buf;
  delete [] packed_buf;

#ifdef OPT_PACK
  deflateExit ();
#endif

  return 0;
}
catch (std::logic_error& e) {
  std::cerr<<e.what ()<<std::endl;
  return 1;
}  
}
