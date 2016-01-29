////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/GDS/TimePeriod.h"
//
// класс секундомера для профайлинга времени выполнения участков кода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef __SHARED_CORE_GDS_TIMEPERIOD_H__
#define __SHARED_CORE_GDS_TIMEPERIOD_H__

#include <chrono>

namespace Core { namespace GDS {

class TimePeriod {
public:
	TimePeriod () : m_start_point (std::chrono::steady_clock::now ()) {
	}

	std::chrono::steady_clock::duration delta () const {
		return std::chrono::steady_clock::now () - m_start_point;
	}

	std::pair<long long, long long> delta_in_secs_and_millis () const {
		auto delta = std::chrono::steady_clock::now () - m_start_point;
		return std::make_pair (
			std::chrono::duration_cast<std::chrono::seconds> (delta).count ()
			, std::chrono::duration_cast<std::chrono::milliseconds> (delta).count () % 1000
		);
	}

private:
	const std::chrono::steady_clock::time_point m_start_point;
};

} }

#endif