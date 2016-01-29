#pragma once

#ifndef _IMPL_ARRAY_VIEW_H_
#define _IMPL_ARRAY_VIEW_H_ 1

#include <stdexcept>
#include <type_traits>
#include <utility>
#include "coordinate.h"

namespace std {
	namespace experimental {
		namespace D4087 {

			template <typename ValueType, int Rank> class array_view;
			template <typename ValueType, int Rank> class strided_array_view;

			namespace details
			{
				// Note: This should be replaced with std::index_sequence if available.
				template <size_t... I> struct index_seq {};

				template <typename T>  struct append_1;
				template <size_t... I> struct append_1<index_seq<I...>> { using type = index_seq<I..., sizeof...(I)>; };
				template <typename T>  using  append_1_t = typename append_1<T>::type;

				template <size_t N> struct make_seq;
				template <size_t N> using  make_seq_t = typename make_seq<N>::type;

				template <size_t N> struct make_seq    { using type = append_1_t<make_seq_t<N - 1>>; };
				template <>         struct make_seq<0> { using type = index_seq<>; };

				template <typename T, size_t... I>
				_CONSTEXPR bounds<sizeof...(I)> make_bounds_inner(index_seq<I...>) _NOEXCEPT
				{
					return{ static_cast<ptrdiff_t>(std::extent<T, I>::value)... };
				}

				// Make bounds from an array type extents.
				template <typename T>
				_CONSTEXPR auto make_bounds() _NOEXCEPT -> decltype(make_bounds_inner<T>(make_seq_t<std::rank<T>::value>{}))
				{
					return make_bounds_inner<T>(make_seq_t<std::rank<T>::value>{});
				}

				// Make a stride vector from bounds, assuming continugous memory.
				template <int Rank>
				_CONSTEXPR index<Rank> make_stride(const bounds<Rank>& bnd) _NOEXCEPT
				{
					index<Rank> stride;
					stride[Rank - 1] = 1;
					for (int i = Rank - 1; i-- > 0;)
					{
						stride[i] = stride[i + 1] * bnd[i + 1];
					}
					return stride;
				}

				template <typename T>
				_CONSTEXPR T* to_pointer(T& t) _NOEXCEPT
				{
					return &t;
				}

				template <typename T, int N>
				_CONSTEXPR std::remove_all_extents_t<T>* to_pointer(T(&t)[N]) _NOEXCEPT
				{
					return to_pointer(t[0]);
				}

				template <typename T, typename ValueType>

				struct is_viewable : std::integral_constant<bool,
					std::is_convertible<decltype(std::declval<T>().size()), ptrdiff_t>::value
					&& std::is_convertible<decltype(std::declval<T>().data()), ValueType*>::value
					&& std::is_same<std::remove_cv_t<std::remove_pointer_t<decltype(std::declval<T>().data())>>,
						std::remove_cv_t<ValueType>>::value>
				{};

				template <typename T>
				struct is_array_view_oracle : false_type
				{};
				template <typename T, int N>
				struct is_array_view_oracle<array_view<T, N>> : true_type
				{};

				template <typename T>
				struct is_array_view : is_array_view_oracle<std::decay_t<T>>
				{};

				template <template <typename, int> class ViewType, typename ValueType, int Rank>
				struct slice_return_type { using type = ViewType<ValueType, Rank - 1>; };

				template <template <typename, int> class ViewType, typename ValueType>
				struct slice_return_type<ViewType, ValueType, 1> { using type = void; };

				template <template <typename, int> class ViewType, typename ValueType, int Rank>
				using slice_return_type_t = typename slice_return_type<ViewType, ValueType, Rank>::type;

				template <typename ValueType, int Rank>
				class any_array_view_base
				{
				public:
					static const int rank = Rank;
					using index_type  = index<rank>;
					using bounds_type = bounds<rank>;
					using size_type   = size_t;
					using value_type  = ValueType;
					using pointer     = ValueType*;
					using reference   = ValueType&;

					_CONSTEXPR bounds_type bounds() const _NOEXCEPT
					{
						return bnd;
					}

					_CONSTEXPR size_type size() const _NOEXCEPT
					{
						return bnd.size();
					}

					_CONSTEXPR index_type stride() const _NOEXCEPT
					{
						return srd;
					}

					// Preconditions: (*this).bounds().contains(idx)
					_CONSTEXPR reference operator[](const index_type& idx) const
					{
						assert(bnd.contains(idx));
						auto ptr = data_ptr;
						for (int i = 0; i < rank; i++)
						{
							ptr += idx[i] * srd[i];
						}
						return *ptr;
					}

					// Preconditions: for any index idx, if section_bounds.contains(idx),
					// bounds().contains(origin + idx) must be true
					_CONSTEXPR strided_array_view<value_type, rank> section(const index_type& origin, const bounds_type& section_bnd) const
					{
						assert(bnd.contains(origin));
						assert(check_section_correct(origin, section_bnd));
						return{ section_bnd, srd, &operator[](origin) };
					}

					// Preconditions: for any index idx, if section_bounds.contains(idx),
					// bounds().contains(origin + idx) must be true
					_CONSTEXPR strided_array_view<value_type, rank> section(const index_type& origin) const
					{
						assert(bnd.contains(origin));
						bounds_type section_bnd = bnd - origin;
						return section(origin, section_bnd);
					}

				protected:
					_CONSTEXPR any_array_view_base(bounds_type bnd, index_type stride, pointer data) _NOEXCEPT
						: data_ptr( std::move(data) )
						, bnd( std::move(bnd) )
						, srd( std::move(stride) )
					{
					}

					_CONSTEXPR bool check_section_correct(const index_type& origin, const bounds_type& section_bnd) const _NOEXCEPT
					{
						for (int i = 0; i < rank; ++i)
						{
							if (origin[i] > bnd[i] - section_bnd[i])
							{
								return false;
							}
						}
						return true;
					}

					pointer data_ptr;
					bounds_type bnd;
					index_type srd;
					// Note: for non-strided array view, stride can be computed on-the-fly
					// thus saving couple of bytes. It should be measured whether it's
					// beneficial.
				};

			} // namespace details

			template <typename ValueType, int Rank = 1>
			class array_view : public details::any_array_view_base<ValueType, Rank>
			{
				using Base = details::any_array_view_base<ValueType, Rank>;
				template <typename AnyValueType, int AnyRank> friend class array_view;
				template <typename AnyValueType, int AnyRank> friend class strided_array_view;

			public:
				using Base::rank;
				using index_type  = typename Base::index_type;
				using bounds_type = typename Base::bounds_type;
				using size_type   = typename Base::size_type;
				using value_type  = typename Base::value_type;
				using pointer     = typename Base::pointer;
				using reference   = typename Base::reference;

				_CONSTEXPR array_view() _NOEXCEPT
					: Base{ {}, {}, nullptr }
				{
				}

				template <typename Viewable,
					typename = std::enable_if_t<rank == 1
						&& details::is_viewable<Viewable, value_type>::value
						&& !details::is_array_view<Viewable>::value>>
				_CONSTEXPR array_view(Viewable&& cont)
					: Base{ static_cast<typename bounds_type::value_type>(cont.size()), 1, cont.data() }
				{
				}

				template <typename ViewValueType, int ViewRank,
					typename = std::enable_if_t<rank == 1
						&& std::is_convertible<std::add_pointer_t<ViewValueType>, pointer>::value
						&& std::is_same<std::remove_cv_t<ViewValueType>, std::remove_cv_t<value_type>>::value>>
				_CONSTEXPR array_view(const array_view<ViewValueType, ViewRank>& rhs) _NOEXCEPT
					: Base{ static_cast<typename bounds_type::value_type>(rhs.size()), 1, rhs.data() }
				{
				}

				// Preconditions: product of the ArrayType extents must be <= ptrdiff_t max.
				template <typename ArrayType,
					typename = std::enable_if_t<std::is_convertible<std::add_pointer_t<std::remove_all_extents_t<ArrayType>>, pointer>::value
						&& std::is_same<std::remove_cv_t<std::remove_all_extents_t<ArrayType>>, std::remove_cv_t<value_type>>::value
						&& std::rank<ArrayType>::value == rank>>
				_CONSTEXPR array_view(ArrayType& data) _NOEXCEPT
					: Base{ details::make_bounds<ArrayType>(), details::make_stride(details::make_bounds<ArrayType>()),
					        details::to_pointer(data) }
				{
				}

				template <typename ViewValueType,
					typename = std::enable_if_t<std::is_convertible<std::add_pointer_t<ViewValueType>, pointer>::value
						&& std::is_same<std::remove_cv_t<ViewValueType>, std::remove_cv_t<value_type>>::value>>
				_CONSTEXPR array_view(const array_view<ViewValueType, rank>& rhs) _NOEXCEPT
					: Base{ rhs.bnd, rhs.srd, rhs.data_ptr }
				{
				}

				// Preconditions: bounds.size() <= cont.size()
				template <typename Viewable,
					typename = std::enable_if_t<details::is_viewable<Viewable, value_type>::value>>
				_CONSTEXPR array_view(bounds_type bounds, Viewable&& cont)
					: Base{ bounds, details::make_stride(bounds), cont.data() }
				{
					assert(Base::bnd.size() <= cont.size());
				}

				_CONSTEXPR array_view(bounds_type bounds, pointer data)
					: Base{ bounds, details::make_stride(bounds), data }
				{
				}

				template <typename ViewValueType,
					typename = std::enable_if_t<std::is_convertible<std::add_pointer_t<ViewValueType>, pointer>::value
						&& std::is_same<std::remove_cv_t<ViewValueType>, std::remove_cv_t<value_type>>::value>>
				_CONSTEXPR array_view& operator=(const array_view<ViewValueType, rank>& rhs) _NOEXCEPT
				{
					Base::bnd = rhs.bnd;
					Base::srd = rhs.srd;
					Base::data_ptr = rhs.data_ptr;
					return *this;
				}

				using Base::operator[];

				// Returns a slice of the view.
				// Preconditions: slice < (*this).bounds()[0]
				template <int _dummy_rank = rank>
				_CONSTEXPR typename details::slice_return_type<std::experimental::D4087::array_view, value_type, Rank>::type
					operator[](typename std::enable_if<_dummy_rank != 1, typename index_type::value_type>::type slice) const
				{
					static_assert(_dummy_rank == rank, "_dummy_rank must have the default value!");
					assert(slice < Base::bnd[0]);

					index_type idx;
					idx[0] = slice;

					std::experimental::D4087::bounds<rank - 1> bound;
					for (int i = 1; i < rank; ++i)
					{
						bound[i - 1] = Base::bnd[i];
					}

					return{ bound, &operator[](idx) };
				}

				_CONSTEXPR pointer data() const _NOEXCEPT
				{
					return Base::data_ptr;
				}
			};

			template <typename ValueType, int Rank = 1>
			class strided_array_view : public details::any_array_view_base<ValueType, Rank>
			{
				using Base = details::any_array_view_base<ValueType, Rank>;
				friend strided_array_view<const ValueType, Rank>;

			public:
				using Base::rank;
				using index_type  = typename Base::index_type;
				using bounds_type = typename Base::bounds_type;
				using size_type   = typename Base::size_type;
				using value_type  = typename Base::value_type;
				using pointer     = typename Base::pointer;
				using reference   = typename Base::reference;

				_CONSTEXPR strided_array_view() _NOEXCEPT
					: Base{ {}, {}, nullptr }
				{
				}

				template <typename ViewValueType,
					typename = std::enable_if_t<std::is_convertible<std::add_pointer_t<ViewValueType>, pointer>::value
						&& std::is_same<std::remove_cv_t<ViewValueType>, std::remove_cv_t<value_type>>::value>>
				_CONSTEXPR strided_array_view(const array_view<ViewValueType, rank>& rhs) _NOEXCEPT
					: Base{ rhs.bnd, rhs.srd, rhs.data_ptr }
				{
				}

				template <typename ViewValueType,
					typename = std::enable_if_t<std::is_convertible<std::add_pointer_t<ViewValueType>, pointer>::value
						&& std::is_same<std::remove_cv_t<ViewValueType>, std::remove_cv_t<value_type>>::value>>
				_CONSTEXPR strided_array_view(const strided_array_view<ViewValueType, rank>& rhs) _NOEXCEPT
					: Base{ rhs.bnd, rhs.srd, rhs.data_ptr }
				{
				}

				// Preconditions:
				//   - for any index idx, if bounds().contains(idx),
				//     for i = [0,rank), idx[i] * stride[i] must be representable as ptrdiff_t
				//   - for any index idx, if bounds().contains(idx),
				//     (*this)[idx] must refer to a valid memory location
				_CONSTEXPR strided_array_view(bounds_type bounds, index_type stride, pointer data) _NOEXCEPT
					: Base{ std::move(bounds), std::move(stride), data }
				{
				}

				template <typename ViewValueType,
					typename = std::enable_if_t<std::is_convertible<std::add_pointer_t<ViewValueType>, pointer>::value
						&& std::is_same<std::remove_cv_t<ViewValueType>, std::remove_cv_t<value_type>>::value>>
				_CONSTEXPR strided_array_view& operator=(const strided_array_view<ViewValueType, rank>& rhs) _NOEXCEPT
				{
					Base::bnd = rhs.bnd;
					Base::srd = rhs.srd;
					Base::data_ptr = rhs.data_ptr;
					return *this;
				}

				using Base::operator[];

				// Returns a slice of the view.
				// Preconditions: slice < (*this).bounds()[0]
				template <int _dummy_rank = rank>
				_CONSTEXPR details::slice_return_type_t<std::experimental::D4087::strided_array_view, value_type, Rank>
					operator[](typename std::enable_if<_dummy_rank != 1, typename index_type::value_type>::type slice) const _NOEXCEPT
				{
					static_assert(_dummy_rank == rank, "_dummy_rank must have the default value!");
					assert(slice < Base::bnd[0]);

					index_type idx;
					idx[0] = slice;

					std::experimental::D4087::bounds<rank - 1> bound;
					std::experimental::D4087::index<rank - 1> stride;
					for (int i = 1; i < rank; ++i)
					{
						bound[i - 1] = Base::bnd[i];
						stride[i - 1] = Base::srd[i];
					}

					return{ bound, stride, &operator[](idx) };
				}
			};
		}
	}
} // namespace std::experimental::D4087

#endif // _IMPL_ARRAY_VIEW_H_
