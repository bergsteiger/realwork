#include "shared/Core/fix/mpcxc.h"
#include "pack.h"

#include "ace/OS.h"
#include <iostream>
#include <strstream>

ACE_THR_FUNC_RETURN reentrant_foo (void* p) {
  while(true) {
    char* phrase = new char [65565];
    std::ostrstream s (phrase, 65565);
    for(int x=0; x<10; x++) {
      s << "hello, world"<<ACE_OS::thr_self()<<ACE_OS::rand()<<std::endl;
    }  
//    char* phrase = "hello, world hello, world hello, world hello, world hello, world hello, world\n";
    char* packed_phrase = new char [65565];
    unsigned int packed_size = Zip::Pack(phrase, strlen(phrase)+1, packed_phrase, 65565);
//std::cerr<<"packed_size = "<<packed_size<<std::endl;  
    char* unpacked_phrase = new char [65565];
    int success = Zip::UnZip(packed_phrase, packed_size, unpacked_phrase, 65565);
//std::cerr<<"success = "<<success<<", unpacked_phrase = "<<unpacked_phrase<<std::endl;
    if (success == 0) {
      std::cerr<<"error: success = 0"<<std::endl;
    }
    if ((success != 0) && strcmp (phrase, unpacked_phrase) != 0) {
      std::cerr<<"error: phrase != unpacked_phrase"<<std::endl;
    }
    delete [] phrase;
    delete [] packed_phrase;
    delete [] unpacked_phrase;
  }
}

int run_reentrant_foo () {
        char p[1];
	const size_t GARLINK_STAKCSIZE = 1*1024*1024;
	char* garlink_stack_ptr = new char [GARLINK_STAKCSIZE];
	ACE_thread_t working_thread_id = 0;
	ACE_hthread_t working_thread_handle = 0;
	int res = ACE_OS::thr_create (
		reentrant_foo
		, p
		, THR_NEW_LWP | THR_JOINABLE
		, &working_thread_id
		, &working_thread_handle
		, ACE_DEFAULT_THREAD_PRIORITY
		, garlink_stack_ptr
		, GARLINK_STAKCSIZE
	);
	if (res < 0) {
		std::cerr<<"can't spawn thread for reentrant_foo"<<std::endl;
		abort();
	}
}


int main() {
  std::cout<< "hello, world"<<ACE_OS::thr_self()<<ACE_OS::rand()<<std::endl;
  for(int i=0; i<100; i++) {
    run_reentrant_foo ();    
  }
  ACE_OS::sleep (100);
  return 0;
}
