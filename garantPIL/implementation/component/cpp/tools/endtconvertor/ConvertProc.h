
#if !defined __CONVERT_PROC_H
#define __CONVERT_PROC_H

namespace EndtConvertor {

	unsigned get_space_count (const char* buf, unsigned pos);
	unsigned get_segment_start  (const char* buf, unsigned cur_buff_len, long &pos);

	bool is_true_before (const char* buf);

	inline bool is_pseudo_graph (char ch) {
		return (ch >= -80 && ch <= -33);
	}

} // namespace

#endif // !defined(__CONVERT_PROC_H)
