////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/ArgType/ArgType.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::ArgType
//
// пакет для тестирования различных способов передачи интерфейсов в параметры метода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/ArgType/ArgType.h"

namespace BasicTests {
namespace ArgType {


// oneway methods impl
struct InoutParamParams_ {
	TestFacet_cvar self;
	TestFacet_var a;
	InoutParamParams_ (
		const TestFacet* self_
		, TestFacet* a_
	) :
		self(TestFacet::_duplicate(self_))
		, a(TestFacet::_duplicate(a_))
	{
	}
};

void TestFacet::thr_inout_param_ (void* arg) {
	try {
		Core::Aptr<InoutParamParams_> arg_ (reinterpret_cast<InoutParamParams_*>(arg));
		arg_->self->inout_param_ (arg_->a.in ());
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute TestFacet::inout_param oneway function"));
	} catch (...) {
		LOG_UEX (("while execute TestFacet::inout_param oneway function"));
	}
}

struct InrefParamParams_ {
	TestFacet_var self;
	const TestFacet_cvar a;
	InrefParamParams_ (
		TestFacet* self_
		, const TestFacet& a_
	) :
		self(TestFacet::_duplicate(self_))
		, a(TestFacet::_duplicate(&a_))
	{
	}
};

void TestFacet::thr_inref_param_ (void* arg) {
	try {
		Core::Aptr<InrefParamParams_> arg_ (reinterpret_cast<InrefParamParams_*>(arg));
		arg_->self->inref_param_ (*arg_->a.in ());
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute TestFacet::inref_param oneway function"));
	} catch (...) {
		LOG_UEX (("while execute TestFacet::inref_param oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle TestFacet::inout_param (TestFacet* a) const {
	Core::Aptr<InoutParamParams_> arg = new InoutParamParams_ (this, a);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (TestFacet::thr_inout_param_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}

/*oneway*/ Core::ThreadHandle TestFacet::inref_param (const TestFacet& a) {
	Core::Aptr<InrefParamParams_> arg = new InrefParamParams_ (this, a);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (TestFacet::thr_inref_param_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}
} // namespace ArgType
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

