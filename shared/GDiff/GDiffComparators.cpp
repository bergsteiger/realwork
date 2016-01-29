#pragma  warning (push)
	#pragma  warning (disable: 4244) // 'argument' : conversion from 'type1' to 'type2', possible loss of data
	#pragma  warning (disable: 4267) // 'var' : conversion from 'size_t' to 'type', possible loss of data
	#pragma  warning (disable: 4311) // 'variable' : pointer truncation from 'type' to 'type'
	#pragma  warning (disable: 4312) // 'operation' : conversion from 'type1' to 'type2' of greater size

	#include "ace/ACE.h"
	#include "ace/OS.h"
#pragma  warning (pop)

#include "GDiffComparators.h"

namespace GDiff {
namespace Private {

void BaseComparator::compare_i (
	void* a_this
	, PutCompareInfo a_put_compare_info
	, const Data& a_ldata
	, const Data& a_rdata
) const {
	class StaticHelper {
	public:
		static void create_diff (
			void* a_this
			, PutCompareInfo a_put_compare_info
			, Diff& a_ldiff
			, Diff& a_rdiff
		) {
			class CallbackWrapper {
			public:
				static void put_compare_info (
					void* a_this
					, size_t a_lposition
					, size_t a_ldeleted
					, size_t a_rposition
					, size_t a_rinserted
				) {
					// do nothing
				}
			}; // class CallbackWrapper

			if (a_put_compare_info == 0) {
				a_put_compare_info = &CallbackWrapper::put_compare_info;
			}

			size_t l_lindex (0);
			size_t l_rindex (0);

			const size_t l_lsize (a_ldiff.size ());
			const size_t l_rsize (a_rdiff.size ());

			while ((l_lindex < l_lsize) || (l_rindex < l_rsize)) {
				if (
					(
						l_lindex < l_lsize
					) && (
						!a_ldiff.modified () [l_lindex]
					) && (
						l_rindex < l_rsize
					) && (
						!a_rdiff.modified () [l_rindex]
					)
				) {
					++l_lindex;
					++l_rindex;
				} else {
					size_t l_lposition (l_lindex);
					size_t l_rposition (l_rindex);

					while (
						(
							l_lindex < l_lsize
						) && (
							(
								l_rindex >= l_rsize
							) || (
								a_ldiff.modified () [l_lindex]
							)
						)
					) {
						++l_lindex;
					}

					while (
						(
							l_rindex < l_rsize
						) && (
							(
								l_lindex >= l_lsize
							) || (
								a_rdiff.modified () [l_rindex]
							)
						)
					) {
						++l_rindex;
					}

					if ((l_lposition < l_lindex) || (l_rposition < l_rindex)) {
						a_put_compare_info (
							a_this
							, l_lposition
							, l_lindex- l_lposition
							, l_rposition
							, l_rindex- l_rposition
						);
					}
				}
			}
		}
	public:
		static void lcs (
			Diff& a_ldiff
			, size_t a_ldiff_lo
			, size_t a_ldiff_hi
			, Diff& a_rdiff
			, size_t a_rdiff_lo
			, size_t a_rdiff_hi
			, Vector& a_dvector
			, Vector& a_uvector
		) {
			class StaticHelper {
			public:
				static void sms (
					Info& a_result
					, Diff& a_ldiff
					, size_t a_ldiff_lo
					, size_t a_ldiff_hi
					, Diff& a_rdiff
					, size_t a_rdiff_lo
					, size_t a_rdiff_hi
					, Vector& a_dvector
					, Vector& a_uvector
				) {
					class TypeTransformer {
					public:
						inline static ssize_t src2dst (
							size_t a_size
						) {
							return (
								(
									assert (
										(ssize_t)a_size >= 0
									)
									, static_cast <ssize_t> (a_size)
								)
							);
						}

						inline static size_t dst2src (
							ssize_t a_size
						) {
							return (
								(
									assert (
										(ssize_t)a_size >= 0
									)
									, static_cast <size_t> (a_size)
								)
							);
						}
					};

					const ssize_t l_ldiff_lo (TypeTransformer::src2dst (a_ldiff_lo));
					const ssize_t l_ldiff_hi (TypeTransformer::src2dst (a_ldiff_hi));

					const ssize_t l_lsize (TypeTransformer::src2dst (a_ldiff.size ()));

					const ssize_t l_rdiff_lo (TypeTransformer::src2dst (a_rdiff_lo));
					const ssize_t l_rdiff_hi (TypeTransformer::src2dst (a_rdiff_hi));

					const ssize_t l_rsize (TypeTransformer::src2dst (a_rdiff.size ()));

					ssize_t l_max (l_lsize+ l_rsize+ 1);

					ssize_t l_dk (l_ldiff_lo- l_rdiff_lo);
					ssize_t l_uk (l_ldiff_hi- l_rdiff_hi);

					bool l_is_odd_delta ((((l_ldiff_hi- l_ldiff_lo)- (l_rdiff_hi- l_rdiff_lo)) & 1) != 0);

					ssize_t l_doffset (l_max- l_dk);
					ssize_t l_uoffset (l_max- l_uk);

					a_dvector [l_doffset+ l_dk+ 1] = l_ldiff_lo;
					a_uvector [l_uoffset+ l_uk- 1] = l_ldiff_hi;

					const ssize_t l_max_d ((l_ldiff_hi- l_ldiff_lo+ l_rdiff_hi- l_rdiff_lo)/ 2+ 1);

					for (ssize_t d = 0; d <= l_max_d; ++d) {
						for (ssize_t k = l_dk- d; k <= l_dk+ d; k += 2) {
							ssize_t l_x;

							if (k == l_dk- d) {
								l_x = a_dvector [l_doffset+ k+ 1];
							} else {
								l_x = a_dvector [l_doffset+ k- 1]+ 1;

								if ((k < l_dk+ d) && (a_dvector [l_doffset+ k+ 1] >= l_x)) {
									l_x = a_dvector [l_doffset+ k+ 1];
								}
							}

							ssize_t l_y (l_x- k);

							while (
								(
									l_x < l_ldiff_hi
								) && (
									l_y < l_rdiff_hi
								) && (
									a_ldiff [l_x] == a_rdiff [l_y]
								)
							) {
								++l_x;
								++l_y;
							}

							a_dvector [l_doffset+ k] = l_x;

							if (l_is_odd_delta && (l_uk- d < k) && (k < l_uk+ d)) {
								if ((a_uvector [l_uoffset+ k]) <= (a_dvector [l_doffset+ k])) {
									a_result.set (
										TypeTransformer::dst2src (a_dvector [l_doffset+ k])
										, TypeTransformer::dst2src (a_dvector [l_doffset+ k]- k)
									);

									return;
								}
							}
						}
						
						for (ssize_t k = l_uk- d; k <= l_uk+ d; k += 2) {
							ssize_t l_x;

							if (k == l_uk+ d) {
								l_x = a_uvector [l_uoffset+ k- 1];
							} else {
								l_x = a_uvector [l_uoffset+ k+ 1]- 1;

								if ((k > l_uk- d) && (a_uvector [l_uoffset+ k- 1] < l_x)) {
									l_x = a_uvector [l_uoffset+ k- 1];
								}
							}

							ssize_t l_y (l_x- k);

							while (
								(
									l_x > l_ldiff_lo
								) && (
									l_y > l_rdiff_lo
								) && (
									a_ldiff [l_x- 1] == a_rdiff [l_y- 1]
								)
							) {
								--l_x;
								--l_y;
							}

							a_uvector [l_uoffset+ k] = l_x;

							if (!l_is_odd_delta && (l_dk- d <= k) && (k <= l_dk+ d)) {
								if ((a_uvector [l_uoffset+ k]) <= (a_dvector [l_doffset+ k])) {
									a_result.set (
										TypeTransformer::dst2src (a_dvector [l_doffset+ k])
										, TypeTransformer::dst2src (a_dvector [l_doffset+ k]- k)
									);

									return;
								}
							}
						}
					}

					assert ("The algorithm should never come here" == 0);
				}
			}; // class StaticHelper

			while (
				(
					a_ldiff_lo < a_ldiff_hi
				) && (
					a_rdiff_lo < a_rdiff_hi
				) && (
					a_ldiff [a_ldiff_lo] == a_rdiff [a_rdiff_lo]
				)
			) {
				++a_ldiff_lo;
				++a_rdiff_lo;
			}

			while (
				(
					a_ldiff_lo < a_ldiff_hi
				) && (
					a_rdiff_lo < a_rdiff_hi
				) && (
					a_ldiff [a_ldiff_hi- 1] == a_rdiff [a_rdiff_hi- 1]
				)
			) {
				--a_ldiff_hi;
				--a_rdiff_hi;
			}

			if (a_ldiff_lo == a_ldiff_hi) {
				while (a_rdiff_lo < a_rdiff_hi) {
					a_rdiff.modified () [a_rdiff_lo++] = true;
				}
			} else if (a_rdiff_lo == a_rdiff_hi) {
				while (a_ldiff_lo < a_ldiff_hi) {
					a_ldiff.modified () [a_ldiff_lo++] = true;
				}
			} else {
				Info l_info; {
					StaticHelper::sms (
						l_info
						, a_ldiff
						, a_ldiff_lo
						, a_ldiff_hi
						, a_rdiff
						, a_rdiff_lo
						, a_rdiff_hi
						, a_dvector
						, a_uvector
					);
				}

				lcs (
					a_ldiff
					, a_ldiff_lo
					, l_info.x ()
					, a_rdiff
					, a_rdiff_lo
					, l_info.y ()
					, a_dvector
					, a_uvector
				);

				lcs (
					a_ldiff
					, l_info.x ()
					, a_ldiff_hi
					, a_rdiff
					, l_info.y ()
					, a_rdiff_hi
					, a_dvector
					, a_uvector
				);
			}
		}
	}; // class StaticHelper

	Diff l_ldiff (a_ldata);
	Diff l_rdiff (a_rdata);

	const size_t l_lsize (l_ldiff.size ());
	const size_t l_rsize (l_rdiff.size ());

	const size_t l_vsize (2* (l_lsize+ l_rsize+ 1)+ 2);

	Vector l_dvector (l_vsize);
	Vector l_uvector (l_vsize);

	StaticHelper::lcs (
		l_ldiff
		, 0
		, l_lsize
		, l_rdiff
		, 0
		, l_rsize
		, l_dvector
		, l_uvector
	);

	this->fixup (l_ldiff);
	this->fixup (l_rdiff);

	StaticHelper::create_diff (a_this, a_put_compare_info, l_ldiff, l_rdiff);
}

void BaseComparator::fixup (
	Diff& a_diff
) const {
	const size_t l_size (a_diff.size ());

	size_t l_bposition (0);

	while (l_bposition < l_size) {
		while (
			(
				l_bposition < l_size
			) && (
				!a_diff.modified () [l_bposition]
			)
		) {
		  ++l_bposition;
		}

		size_t l_eposition (l_bposition);

		while (
			(
				l_eposition < l_size
			) && (
				a_diff.modified () [l_eposition]
			)
		) {
			++l_eposition;
		}

		if (
			(
				l_eposition < l_size
			) && (
				(l_eposition- l_bposition) > 1
			) && (
				a_diff [l_bposition] == a_diff [l_eposition]
			)
		) {
			a_diff.modified () [l_bposition] = false;
			a_diff.modified () [l_eposition] = true;
		} else {
			l_bposition = l_eposition;
		}
	}
}


void ParaComparator::compare_i (
	void* a_this
	, PutCompareInfo a_put_compare_info
	, GetNextPara a_get_next_lpara
	, GetNextPara a_get_next_rpara
) const {
	class StaticHelper {
	public:
		static void create_data (
			void* a_this
			, HashTable& a_hash_table
			, GetNextPara a_get_next_para
			, Data& a_data
		) {
			unsigned int l_last_used_code (static_cast <unsigned int> (a_hash_table.current_size ()));

			size_t l_item (0);
			size_t l_size;

			for (
				const char* l_para
				; ((l_para = a_get_next_para (a_this, (l_size = c_unknown_text_size, l_size))) != 0)
				; ++l_item
			) {
				HashTable_Key l_key (l_para, (l_size == c_unknown_text_size) ? (ACE_OS::strlen (l_para)) : (l_size));
				HashTable_Value l_value (l_last_used_code);

				if (a_hash_table.trybind (l_key, l_value) == 0) {
					++l_last_used_code;
				}

				a_data.push_back (l_value);
			}
		}
	}; // class StaticHelper

	Data l_ldata;
	Data l_rdata;
	{
		HashTable l_hash_table;

		StaticHelper::create_data (a_this, l_hash_table, a_get_next_lpara, l_ldata);
		StaticHelper::create_data (a_this, l_hash_table, a_get_next_rpara, l_rdata);
	}

	BaseComparator::compare_i (a_this, a_put_compare_info, l_ldata, l_rdata);
}

} // namespace Private
} // namespace GDiff
