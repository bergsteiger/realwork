#pragma once

#ifndef _IMPL_COORDINATE_H_
#define _IMPL_COORDINATE_H_ 1

#include <assert.h>
#include <iterator>
#include <type_traits>

#define _CONSTEXPR

namespace std {
	namespace experimental {
		namespace D4087 {
			
			namespace details
			{
				template <typename ConcreteType, typename ValueType, int Rank>
				class coordinate_facade
				{
					static_assert(std::is_fundamental<ValueType>::value, "ValueType must be fundamental!");
					static_assert(Rank > 0, "Rank must be greater than 0!");

				public:
					using reference       = ValueType&;
					using const_reference = const ValueType&;
					using size_type       = size_t;
					using value_type      = ValueType;
					static const int rank = Rank;

					_CONSTEXPR coordinate_facade() _NOEXCEPT
					{
						static_assert(std::is_base_of<coordinate_facade, ConcreteType>::value, "ConcreteType must be derived from coordinate_facade.");
						for (int i = 0; i < rank; ++i)
							elems[i] = {};
					}

					_CONSTEXPR coordinate_facade(value_type e0) _NOEXCEPT
					{
						static_assert(std::is_base_of<coordinate_facade, ConcreteType>::value, "ConcreteType must be derived from coordinate_facade.");
						static_assert(rank == 1, "This constructor can only be used with rank == 1.");
						elems[0] = e0;
					}

					// Preconditions: il.size() == rank
					_CONSTEXPR coordinate_facade(std::initializer_list<value_type> il)
					{
						static_assert(std::is_base_of<coordinate_facade, ConcreteType>::value, "ConcreteType must be derived from coordinate_facade.");
						assert(il.size() == rank);
						for (int i = 0; i < rank; ++i)
						{
							elems[i] = begin(il)[i];
						}
					}

				protected:
					coordinate_facade& operator=(const coordinate_facade& rhs) = default;

					// Preconditions: component_idx < rank
					_CONSTEXPR reference operator[](size_type component_idx)
					{
						return elems[component_idx];
					}

					// Preconditions: component_idx < rank
					_CONSTEXPR const_reference operator[](size_type component_idx) const
					{
						return elems[component_idx];
					}

					_CONSTEXPR bool operator==(const ConcreteType& rhs) const _NOEXCEPT
					{
						for (int i = 0; i < rank; ++i)
						{
							if (elems[i] != rhs.elems[i])
								return false;
						}
						return true;
					}

					_CONSTEXPR bool operator!=(const ConcreteType& rhs) const _NOEXCEPT
					{
						return !(to_concrete() == rhs);
					}

					_CONSTEXPR ConcreteType operator+() const _NOEXCEPT
					{
						return to_concrete();
					}

					_CONSTEXPR ConcreteType operator-() const
					{
						ConcreteType ret = to_concrete();
						for (int i = 0; i < rank; ++i)
							ret.elems[i] = -ret.elems[i];
						return ret;
					}

					_CONSTEXPR ConcreteType operator+(const ConcreteType& rhs) const
					{
						ConcreteType ret = to_concrete();
						ret += rhs;
						return ret;
					}

					_CONSTEXPR ConcreteType operator-(const ConcreteType& rhs) const
					{
						ConcreteType ret = to_concrete();
						ret -= rhs;
						return ret;
					}

					_CONSTEXPR ConcreteType& operator+=(const ConcreteType& rhs)
					{
						for (int i = 0; i < rank; ++i)
							elems[i] += rhs.elems[i];
						return to_concrete();
					}

					_CONSTEXPR ConcreteType& operator-=(const ConcreteType& rhs)
					{
						for (int i = 0; i < rank; ++i)
							elems[i] -= rhs.elems[i];
						return to_concrete();
					}

					_CONSTEXPR ConcreteType& operator++()
					{
						static_assert(rank == 1, "This operator can only be used with rank == 1.");
						++elems[0];
						return to_concrete();
					}

					_CONSTEXPR ConcreteType operator++(int)
					{
						static_assert(rank == 1, "This operator can only be used with rank == 1.");
						ConcreteType ret = to_concrete();
						++(*this);
						return ret;
					}

					_CONSTEXPR ConcreteType& operator--()
					{
						static_assert(rank == 1, "This operator can only be used with rank == 1.");
						--elems[0];
						return to_concrete();
					}

					_CONSTEXPR ConcreteType operator--(int)
					{
						static_assert(rank == 1, "This operator can only be used with rank == 1.");
						ConcreteType ret = to_concrete();
						--(*this);
						return ret;
					}

					_CONSTEXPR ConcreteType operator*(value_type v) const
					{
						ConcreteType ret = to_concrete();
						ret *= v;
						return ret;
					}

					_CONSTEXPR ConcreteType operator/(value_type v) const
					{
						ConcreteType ret = to_concrete();
						ret /= v;
						return ret;
					}

					friend _CONSTEXPR ConcreteType operator*(value_type v, const ConcreteType& rhs)
					{
						return rhs * v;
					}

					_CONSTEXPR ConcreteType& operator*=(value_type v)
					{
						for (int i = 0; i < rank; ++i)
							elems[i] *= v;
						return to_concrete();
					}

					_CONSTEXPR ConcreteType& operator/=(value_type v)
					{
						for (int i = 0; i < rank; ++i)
							elems[i] /= v;
						return to_concrete();
					}

					value_type elems[rank];

				private:
					_CONSTEXPR const ConcreteType& to_concrete() const _NOEXCEPT
					{
						return static_cast<const ConcreteType&>(*this);
					}

					_CONSTEXPR ConcreteType& to_concrete() _NOEXCEPT
					{
						return static_cast<ConcreteType&>(*this);
					}
				};

				template <typename T>
				class arrow_proxy
				{
				public:
					explicit arrow_proxy(T t)
						: val(t)
					{}

					const T operator*() const _NOEXCEPT
					{
						return val;
					}

					const T* operator->() const _NOEXCEPT
					{
						return &val;
					}

				private:
					T val;
				};
			}

			template <int Rank>
			class index : private details::coordinate_facade<index<Rank>, ptrdiff_t, Rank>
			{
				using Base = details::coordinate_facade<index<Rank>, ptrdiff_t, Rank>;
				friend Base;

			public:
				using Base::rank;
				using reference       = typename Base::reference;
				using const_reference = typename Base::const_reference;
				using size_type       = typename Base::size_type;
				using value_type      = typename Base::value_type;

				_CONSTEXPR index() _NOEXCEPT : Base(){}
				template <typename = std::enable_if_t<rank == 1>>
				_CONSTEXPR index(value_type e0) _NOEXCEPT : Base(e0){}
				_CONSTEXPR index(std::initializer_list<value_type> il) : Base(il){}

				using Base::operator[];
				using Base::operator==;
				using Base::operator!=;
				using Base::operator+;
				using Base::operator-;
				using Base::operator+=;
				using Base::operator-=;
				using Base::operator++;
				using Base::operator--;
				using Base::operator*;
				using Base::operator/;
				using Base::operator*=;
				using Base::operator/=;
			};

			template <>
			class index<1>
			{
			public:
				static const int rank = 1;
				using reference = ptrdiff_t&;
				using const_reference = const ptrdiff_t&;
				using size_type = size_t;
				using value_type = ptrdiff_t;

				_CONSTEXPR index() _NOEXCEPT : value(0)
				{
				}

				_CONSTEXPR index(value_type e0) _NOEXCEPT : value(e0)
				{
				}

				// Preconditions: il.size() == rank
				_CONSTEXPR index(std::initializer_list<value_type> il)
				{
					assert(il.size() == rank);
					value = begin(il)[0];
				}

				// Preconditions: component_idx < rank
				_CONSTEXPR reference operator[](size_type component_idx) _NOEXCEPT
				{
					assert(component_idx == 0);
					(component_idx);
					return value;
				}

				// Preconditions: component_idx < rank
				_CONSTEXPR const_reference operator[](size_type component_idx) const _NOEXCEPT
				{
					assert(component_idx == 0);
					(component_idx);
					return value;
				}

				_CONSTEXPR bool operator==(const index& rhs) const _NOEXCEPT
				{
					return value == rhs.value;
				}

				_CONSTEXPR bool operator!=(const index& rhs) const _NOEXCEPT
				{
					return !(*this == rhs);
				}

				_CONSTEXPR index operator+() const _NOEXCEPT
				{
					return *this;
				}

				_CONSTEXPR index operator-() const _NOEXCEPT
				{
					return index(-value);
				}

				_CONSTEXPR index operator+(const index& rhs) const _NOEXCEPT
				{
					return index(value + rhs.value);
				}

				_CONSTEXPR index operator-(const index& rhs) const _NOEXCEPT
				{
					return index(value - rhs.value);
				}

				_CONSTEXPR index& operator+=(const index& rhs) _NOEXCEPT
				{
					value += rhs.value;
					return *this;
				}

				_CONSTEXPR index& operator-=(const index& rhs) _NOEXCEPT
				{
					value -= rhs.value;
					return *this;
				}

				_CONSTEXPR index& operator++() _NOEXCEPT
				{
					++value;
					return *this;
				}

				_CONSTEXPR index operator++(int) _NOEXCEPT
				{
					index ret = *this;
					++(*this);
					return ret;
				}

				_CONSTEXPR index& operator--() _NOEXCEPT
				{
					--value;
					return *this;
				}

				_CONSTEXPR index operator--(int) _NOEXCEPT
				{
					index ret = *this;
					--(*this);
					return ret;
				}

				_CONSTEXPR index operator*(value_type v) const _NOEXCEPT
				{
					return index(value * v);
				}

				_CONSTEXPR index operator/(value_type v) const _NOEXCEPT
				{
					return index(value / v);
				}

				_CONSTEXPR index& operator*=(value_type v) _NOEXCEPT
				{
					value *= v;
					return *this;
				}

				_CONSTEXPR index& operator/=(value_type v) _NOEXCEPT
				{
					value /= v;
					return *this;
				}

				friend _CONSTEXPR index operator*(value_type v, const index& rhs) _NOEXCEPT
				{
					return index(rhs * v);
				}
			private:
				ptrdiff_t value;
			};

			template <int Rank> struct bounds_iterator;

			// Preconditions (for all functions): after operation:
			//  - every component must be greater than or equal to zero
			//  - product of all components must not overflow ptrdiff_t
			template <int Rank>
			class bounds : private details::coordinate_facade<bounds<Rank>, ptrdiff_t, Rank>
			{
				using Base = details::coordinate_facade<bounds<Rank>, ptrdiff_t, Rank>;
				friend Base;

			public:
				using Base::rank;
				using reference       = typename Base::reference;
				using const_reference = typename Base::const_reference;
				using iterator        = bounds_iterator<rank>;
				using const_iterator  = bounds_iterator<rank>;
				using size_type       = typename Base::size_type;
				using value_type      = typename Base::value_type;

				_CONSTEXPR bounds() _NOEXCEPT : Base(){}

				template <typename = std::enable_if_t<rank == 1>>
				_CONSTEXPR bounds(value_type e0)
					: Base(e0)
				{
					assert(e0 >= 0);
				}

				_CONSTEXPR bounds(std::initializer_list<value_type> il)
					: Base(il)
				{
#ifndef NDEBUG
					for (const auto& v : il)
					{
						assert(v >= 0);
					}
#endif
				}

				using Base::operator[];
				using Base::operator==;
				using Base::operator!=;
				using Base::operator*;
				using Base::operator/;
				using Base::operator*=;
				using Base::operator/=;

				_CONSTEXPR bounds operator+(const index<rank>& rhs) const
				{
					auto ret = *this;
					ret += rhs;
					return ret;
				}

				_CONSTEXPR bounds operator-(const index<rank>& rhs) const
				{
					auto ret = *this;
					ret -= rhs;
					return ret;
				}

				friend _CONSTEXPR bounds operator+(const index<rank>& lhs, const bounds& rhs)
				{
					return rhs + lhs;
				}

				_CONSTEXPR bounds& operator+=(const index<rank>& rhs)
				{
					for (int i = 0; i < rank; ++i)
						Base::elems[i] += rhs[i];
					return *this;
				}

				_CONSTEXPR bounds& operator-=(const index<rank>& rhs)
				{
					for (int i = 0; i < rank; ++i)
						Base::elems[i] -= rhs[i];
					return *this;
				}

				_CONSTEXPR size_type size() const _NOEXCEPT
				{
					size_type ret = Base::elems[0];
					for (int i = 1; i < rank; ++i)
						ret *= Base::elems[i];
					return ret;
				}

				_CONSTEXPR bool contains(const index<rank>& idx) const _NOEXCEPT
				{
					for (int i = 0; i < rank; ++i)
					{
						if (idx[i] < 0 || idx[i] >= Base::elems[i])
							return false;
					}
					return true;
				}

				const_iterator begin() const _NOEXCEPT
				{
					return const_iterator{ *this };
				}

				const_iterator end() const _NOEXCEPT
				{
					index<rank> idx_end;
					for (int i = 0; i < rank; ++i)
						idx_end[i] = (*this)[i];
					return const_iterator{ *this, idx_end };
				}
			};

			template <int Rank>
			struct bounds_iterator
				: public iterator<random_access_iterator_tag,
					index<Rank>,
					ptrdiff_t,
					const details::arrow_proxy<index<Rank>>,
					const index<Rank>>
			{
				// Preconditions: bnd.contains(curr) unless bnd.size() == 0
				explicit bounds_iterator(bounds<Rank> bnd, index<Rank> curr = index<Rank>{}) _NOEXCEPT
					: bnd( std::move(bnd) )
					, curr( std::move(curr) )
				{}

				reference operator*() const _NOEXCEPT
				{
					return curr;
				}

				pointer operator->() const _NOEXCEPT
				{
					return details::arrow_proxy<index<Rank>>{ curr };
				}

				bounds_iterator& operator++() _NOEXCEPT
				{
					for (int i = Rank; i-- > 0;)
					{
						if (++curr[i] < bnd[i])
						{
							return *this;
						}
						else
						{
							curr[i] = 0;
						}
					}

					// If we're here we've wrapped over - set to past-the-end.
					for (int i = 0; i < Rank; ++i)
					{
						curr[i] = bnd[i];
					}
					return *this;
				}

				bounds_iterator operator++(int) _NOEXCEPT
				{
					auto ret = *this;
					++(*this);
					return ret;
				}

				bounds_iterator& operator--() _NOEXCEPT
				{
					for (int i = Rank; i-- > 0;)
					{
						if (curr[i]-- > 0)
						{
							return *this;
						}
						else
						{
							curr[i] = bnd[i] - 1;
						}
					}

					// If we're here the preconditions were violated
					// "pre: there exists s such that r == ++s"
					assert(false);
					return *this;
				}

				bounds_iterator operator--(int) _NOEXCEPT
				{
					auto ret = *this;
					--(*this);
					return ret;
				}

				bounds_iterator operator+(difference_type n) const _NOEXCEPT
				{
					bounds_iterator ret{ *this };
					return ret += n;
				}

				bounds_iterator& operator+=(difference_type n) _NOEXCEPT
				{
					auto linear_idx = linearize(curr) + n;

					bounds<Rank> stride;
					stride[Rank - 1] = 1;
					for (int i = Rank - 1; i-- > 0;)
					{
						stride[i] = stride[i + 1] * bnd[i + 1];
					}

					for (int i = 0; i < Rank; ++i)
					{
						curr[i] = linear_idx / stride[i];
						linear_idx = linear_idx % stride[i];
					}

					return *this;
				}

				bounds_iterator operator-(difference_type n) const _NOEXCEPT
				{
					bounds_iterator ret{ *this };
					return ret -= n;
				}

				bounds_iterator& operator-=(difference_type n) _NOEXCEPT
				{
					return *this += -n;
				}

				difference_type operator-(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return linearize(curr) - linearize(rhs.curr);
				}

				reference operator[](difference_type n) const _NOEXCEPT
				{
					return *(*this + n);
				}

				bool operator==(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return curr == rhs.curr;
				}

				bool operator!=(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return !(*this == rhs);
				}

				bool operator<(const bounds_iterator& rhs) const _NOEXCEPT
				{
					for (int i = 0; i < Rank; ++i)
					{
						if (curr[i] < rhs.curr[i])
							return true;
					}
					return false;
				}

				bool operator<=(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return !(rhs < *this);
				}

				bool operator>(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return rhs < *this;
				}

				bool operator>=(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return !(rhs > *this);
				}

				void swap(bounds_iterator& rhs) _NOEXCEPT
				{
					std::swap(bnd, rhs.bnd);
					std::swap(curr, rhs.curr);
				}

			private:
				ptrdiff_t linearize(const index<Rank>& idx) const _NOEXCEPT
				{
					// TODO: Smarter impl.

					// Check if past-the-end
					bool pte = true;
					for (int i = 0; i < Rank; ++i)
					{
						if (idx[i] != bnd[i])
						{
							pte = false;
							break;
						}
					}

					ptrdiff_t multiplier = 1;
					ptrdiff_t res = 0;

					if (pte)
					{
						res = 1;
						for (int i = Rank; i-- > 0;)
						{
							res += (idx[i] - 1) * multiplier;
							multiplier *= bnd[i];
						}
					}
					else
					{
						for (int i = Rank; i-- > 0;)
						{
							res += idx[i] * multiplier;
							multiplier *= bnd[i];
						}
					}

					return res;
				}

				bounds<Rank> bnd;
				index<Rank> curr;
			};

			template <>
			struct bounds_iterator<1>
				: public iterator<random_access_iterator_tag,
				index<1>,
				ptrdiff_t,
				const details::arrow_proxy<index<1>>,
				const index<1>>
			{
				// Preconditions: bnd.contains(curr) unless bnd.size() == 0
				explicit bounds_iterator(bounds<1>, index<1> curr = index<1>{}) _NOEXCEPT
					: curr( std::move(curr) )
				{}

				reference operator*() const _NOEXCEPT
				{
					return curr;
				}

				pointer operator->() const _NOEXCEPT
				{
					return details::arrow_proxy<index<1>>{ curr };
				}

				bounds_iterator& operator++() _NOEXCEPT
				{
					++curr;
					return *this;
				}

				bounds_iterator operator++(int) _NOEXCEPT
				{
					auto ret = *this;
					++(*this);
					return ret;
				}

				bounds_iterator& operator--() _NOEXCEPT
				{
					curr--;
					return *this;
				}

				bounds_iterator operator--(int) _NOEXCEPT
				{
					auto ret = *this;
					--(*this);
					return ret;
				}

				bounds_iterator operator+(difference_type n) const _NOEXCEPT
				{
					bounds_iterator ret{ *this };
					return ret += n;
				}

				bounds_iterator& operator+=(difference_type n) _NOEXCEPT
				{
					curr += n;
					return *this;
				}

				bounds_iterator operator-(difference_type n) const _NOEXCEPT
				{
					bounds_iterator ret{ *this };
					return ret -= n;
				}

				bounds_iterator& operator-=(difference_type n) _NOEXCEPT
				{
					return *this += -n;
				}

				difference_type operator-(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return curr[0] - rhs.curr[0];
				}

				reference operator[](difference_type n) const _NOEXCEPT
				{						
					return curr + n;
				}

				bool operator==(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return curr == rhs.curr;
				}

				bool operator!=(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return !(*this == rhs);
				}

				bool operator<(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return curr[0] < rhs.curr[0];
				}

				bool operator<=(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return !(rhs < *this);
				}

				bool operator>(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return rhs < *this;
				}

				bool operator>=(const bounds_iterator& rhs) const _NOEXCEPT
				{
					return !(rhs > *this);
				}

				void swap(bounds_iterator& rhs) _NOEXCEPT
				{
					std::swap(curr, rhs.curr);
				}

			private:
				index<1> curr;
			};

			template <int Rank>
			bounds_iterator<Rank> operator+(typename bounds_iterator<Rank>::difference_type n, const bounds_iterator<Rank>& rhs) _NOEXCEPT
			{
				return rhs + n;
			}
		}
	}
} // namespace std::experimental::D4087

#endif // _IMPL_COORDINATE_H_
