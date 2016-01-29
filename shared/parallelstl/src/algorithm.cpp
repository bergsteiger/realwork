#pragma once

#include <atomic>
#include <experimental/impl/algorithm_impl.h>

_PSTL_NS1_BEGIN

namespace details {
	namespace
	{
		__declspec(thread) _Contextaware_waitable_chore * _Thread_chore_context;

		// We need to limit the global over-subscription to linear size.
		// Please note that *5 is just an arbitrary choice that fits in
		// a reasonable range. As long as total number don't go exponential
		// a little bit more linear over-subscription won't hurt.
		size_t _Max_global_chore_num = get_hardware_concurrency() * 5;
		atomic<size_t> _Global_chore_num;
	}


	_EXP_IMPL void _Contextaware_waitable_chore::_Set_current_chore(_Contextaware_waitable_chore * _Context)
	{
		_Thread_chore_context = _Context;
	}

	_EXP_IMPL _Contextaware_waitable_chore * _Contextaware_waitable_chore::current_chore()
	{
		return _Thread_chore_context;

	}

	_EXP_IMPL bool _Partition_status_tracker::_IsPartitionNumUnderLimit()
	{
		return _Global_chore_num.load(std::memory_order_relaxed) < _Max_global_chore_num;

	}

	_EXP_IMPL void _Partition_status_tracker::_AddPartitions(size_t _Num)
	{
		_PartitionNum += _Num;
		_Global_chore_num.fetch_add(_Num, std::memory_order_relaxed);
	}

	_EXP_IMPL _Partition_status_tracker::~_Partition_status_tracker()
	{
		if (_PartitionNum)
			_Global_chore_num.fetch_sub(_PartitionNum, std::memory_order_relaxed);
	}
}
_PSTL_NS1_END