////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::BuildTestLib::OnBuildDone
//
// имлементация того что надо сделать по событию окончания сборки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <fstream>
#include "MDProcess/ServerGate/Comm/Comm.h"
#include "MDProcess/ServerGate/Contents/Contents.h"
#include "MDProcess/BuildTestLib/TestResults/TestResults.h"
#include "MDProcess/BuildTestLib/TestPublish/TestPublish.h"


namespace BuildTestLib {
namespace OnBuildDone {

class LocalPageLogin;
typedef ::Core::Var<LocalPageLogin> LocalPageLogin_var;
typedef ::Core::Var<const LocalPageLogin> LocalPageLogin_cvar;
// хелпер - логин в К со страницей-атрибутом и авто-выходом
class LocalPageLogin
	: virtual public ::Core::IObject
{
public:
	// ссылка на страницу
	virtual ServerGate::Contents::KPage* get_p () const = 0;
};

/// factory interface for LocalPageLogin
class LocalPageLoginFactory {
public:
	// делает авто-логин/логоут
	static LocalPageLogin* make (
		const std::string& login
		, const std::string& passwd
		, ServerGate::Contents::PageId page_id
	) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// форма представления результатов теста в К
struct TestKForm {
	// wiki текст, добавляемый на страницу К
	std::string wiki_text;
	// page labels, добавляемый на страницу К
	std::string page_labels;
};

} //namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

