////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/sys/TaoBeginEnd.h"
//
// операции begin и end для TAO_Sequence
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SYS_BEGIN_END_FOR_TAO_H__
#define __SHARED_CORESRV_SYS_BEGIN_END_FOR_TAO_H__

#include "shared/GCL/alg/iterable.h"

namespace CoreSrv {

template<class Seq>
auto make_iterable_from_tao_sequance (Seq& sequence) -> GCL::Iterable<decltype (sequence.get_buffer ())> {
	return GCL::make_iterable (sequence.get_buffer (), sequence.get_buffer () + sequence.length ());
}

}

#endif //__SHARED_CORESRV_SYS_BEGIN_END_FOR_TAO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
