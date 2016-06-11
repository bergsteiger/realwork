//===----------------------------- typeinfo.cpp ---------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include <typeinfo>
#include <string.h>

#include "cxxabi.h"
#include "private_typeinfo.h"

namespace std
{

// type_info

type_info::~type_info()
{
}

const char * type_info::name() const
{
    return __type_name;
}

bool type_info::operator==(const type_info &_rhs) const
{
    abi::__shim_type_info const *lhs =
	dynamic_cast<abi::__shim_type_info const *>(this);
    abi::__shim_type_info const *rhs =
	dynamic_cast<abi::__shim_type_info const *>(&_rhs);
    return lhs->equals(*rhs);
}

bool type_info::operator!=(const type_info &rhs) const
{
    return !(*this == rhs);
}

bool type_info::before(const type_info &rhs) const
{
    return strcmp(name(), rhs.name()) < 0;
}

// bad_cast

bad_cast::bad_cast() _NOEXCEPT
{
}

bad_cast::~bad_cast() _NOEXCEPT
{
}

const char*
bad_cast::what() const _NOEXCEPT
{
  return "std::bad_cast";
}

// bad_typeid

bad_typeid::bad_typeid() _NOEXCEPT
{
}

bad_typeid::~bad_typeid() _NOEXCEPT
{
}

const char*
bad_typeid::what() const _NOEXCEPT
{
  return "std::bad_typeid";
}

}  // std
