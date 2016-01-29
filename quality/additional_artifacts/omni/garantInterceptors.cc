/* garantInterceptors.cc */

#include <omniORB4/CORBA.h>
#include <omniORB4/omniInterceptors.h>
#include <initialiser.h>
#include <stdio.h>
#include <string.h>
#include <pthread.h>

OMNI_USING_NAMESPACE(omni)

pthread_key_t session_key = 0;
const CORBA::ULong svc_id = 20012001;


static CORBA::Boolean
send_session_id(omni::omniInterceptors::clientSendRequest_T::info_T& info) {
 try {
   unsigned int session_id = (unsigned int) pthread_getspecific(session_key);
    int id_len = sizeof(unsigned int);
    int len = info.service_contexts.length();
    info.service_contexts.length(len+1);
    info.service_contexts[len].context_id = svc_id;
    info.service_contexts[len].context_data.length(id_len);
    unsigned char data[id_len];
    data[0] = session_id & 0xFF;
    data[1] = (session_id >> 8) &0xFF;
    data[2] = (session_id >> 16) & 0xFF;
    data[3] = (session_id >> 24) &0xFF;
    for(int i = 0; i < id_len; i++) {
      info.service_contexts[len].context_data[i] = data[i];
    }
  }
  catch (...) {
    fprintf(stderr, "some exception in send_session_id\n");
    return 0;
  }
  return 1;
}

static CORBA::Boolean
receive_session_id(omni::omniInterceptors::clientReceiveReply_T::info_T& info) {
  try {
    if(strcmp(info.opname, "login") == 0) {
      int i;
      for(i = 0; i < (signed)info.service_contexts.length(); i++) {
	if(info.service_contexts[i].context_id == svc_id) {
	  int len = info.service_contexts[i].context_data.length();
	  if(len == sizeof(unsigned int)) {
	    unsigned char data[sizeof(unsigned int)];
	    for(int j = 0; j < (signed)info.service_contexts[i].context_data.length(); j++) {
	      data[j] = info.service_contexts[i].context_data[j];
	    }
	    unsigned int session_id = ((data[3]<<24)&0xFF000000) | ((data[2]<<16)&0x00FF0000) |
	      ((data[1]<<8)&0x0000FF00) | ((data[0])&0xFF);
	    pthread_setspecific(session_key, (void*) session_id);
	  }
	}
	break;
      }
      if(i >= (signed)info.service_contexts.length()) {
	fprintf(stderr, "reply from login, but session id not found in service context\n");
	return 0;
      }
    }
  }
  catch(...) {
    fprintf(stderr, "some exception in receive_session_id\n");
    return 0;
  }
  return 1;
}

OMNI_NAMESPACE_BEGIN(omni)

  class garant_Client_initializer : public omniInitialiser {
  public:
    void attach() {
      omniInterceptors *interceptors = omniORB::getInterceptors();
      interceptors->clientReceiveReply.add(receive_session_id);
      interceptors->clientSendRequest.add(send_session_id);
      pthread_key_create(&session_key, 0);
    }
    void detach() {
      pthread_key_delete(session_key);
    }
  };

static garant_Client_initializer initializer;
omniInitialiser& garant_Client_initialiser_ = initializer;

OMNI_NAMESPACE_END(omni)
