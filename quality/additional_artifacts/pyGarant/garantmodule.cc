/* garantmodule.cc */

#include <Python.h>
#include <stdio.h>
#include <pthread.h>

extern "C" {
  static PyObject* garant_getSessionId(PyObject* self, PyObject* args);
  static PyObject* garant_setSessionId(PyObject* self, PyObject* args);
  void initgarant();
static PyMethodDef GarantMethods[] = {
  {"getSessionId", garant_getSessionId, METH_VARARGS},
  {"setSessionId", garant_setSessionId, METH_VARARGS},
  {NULL, NULL}
};
}

extern pthread_key_t session_key;

static PyObject*
garant_getSessionId(PyObject* self, PyObject* args)
{
  unsigned int session_id = 0;
  try {
    session_id = (unsigned int)pthread_getspecific(session_key);
  }
  catch(...) {
    fprintf(stderr, "exception in getSessionId\n");
  }
  return Py_BuildValue("i", session_id);
}

static PyObject*
garant_setSessionId(PyObject* self, PyObject* args)
{
  unsigned int session_id;
  if(!PyArg_ParseTuple(args, "i", &session_id)) {
    return NULL;
  }
  try {
    pthread_setspecific(session_key, (void*)session_id);
  }
  catch(...) {
    fprintf(stderr, "exception in setSessionId\n");
  }
  Py_INCREF(Py_None);
  return Py_None;
}


void initgarant()
{
  Py_InitModule("garant", GarantMethods);
}
