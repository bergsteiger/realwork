////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "Watcher.h"

#ifndef __WATCHER_H__
#define __WATCHER_H__

#include "shared/Core/sys/std_inc.h"

namespace SearchProfiler {

	struct WatchTime {
		unsigned sec;
		unsigned msec;
		unsigned usec;

		inline double get_sec_value () {
			return (static_cast <double> (sec + msec / 1000.));
		}

		inline double get_min_value () {
			return (this->get_sec_value () / 60.);
		}

		inline double get_hour_value () {
			return (this->get_min_value () / 60.);
		}
	};

	//////////////////////////////////////////////////////////////////////////////////////////////

	class IWatcher 
		: virtual public Core::IObject {
	public:
		virtual void start () = 0;
		virtual void finish () = 0;
		virtual const WatchTime& get_data () const = 0;
	};

	typedef Core::Var <IWatcher> IWatcher_var;

	//////////////////////////////////////////////////////////////////////////////////////////////

	struct WatcherFactory {
		static IWatcher* make ();
	};

} // namespace SearchProfiler

#endif //__WATCHER_H__
