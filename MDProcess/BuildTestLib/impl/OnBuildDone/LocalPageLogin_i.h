////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/LocalPageLogin_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::LocalPageLogin_i
// Заголовок реализации класса серванта для интерфеса LocalPageLogin
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_LOCALPAGELOGIN_I_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_LOCALPAGELOGIN_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Contents/Contents.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"

namespace BuildTestLib {
namespace OnBuildDone {

class LocalPageLogin_i; // self forward Var
typedef ::Core::Var<LocalPageLogin_i> LocalPageLogin_i_var;
typedef ::Core::Var<const LocalPageLogin_i> LocalPageLogin_i_cvar;

class LocalPageLogin_i_factory;

class LocalPageLogin_i:
	virtual public LocalPageLogin
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (LocalPageLogin_i)
	friend class LocalPageLogin_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	LocalPageLogin_i (const std::string& login, const std::string& passwd, ServerGate::Contents::PageId page_id);

	virtual ~LocalPageLogin_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ServerGate::Contents::PageId m_id;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from LocalPageLogin
	// ссылка на страницу
	virtual ServerGate::Contents::KPage* get_p () const;
}; // class LocalPageLogin_i

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_LOCALPAGELOGIN_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
