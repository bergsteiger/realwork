#ifndef SHARED_GCL_META_SELECT_H__
#define SHARED_GCL_META_SELECT_H__

namespace GCL {

namespace Templates {

template<bool which , typename T1, typename T2>
struct select {
};
template<typename T1, typename T2>
struct select<true, T1, T2> {
  typedef T1 Type; 
};
template<typename T1, typename T2>
struct select<false, T1, T2> {
  typedef T2 Type; 
};

}

}

#endif //SHARED_GCL_META_SELECT_H__
