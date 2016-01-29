////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/MDACommands/DblClickActionImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::MDACommands::DblClickActionImpl
// ��������� ���������� ������ �������� ��� ��������� DblClickAction
//
// �������� �� ����-����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDACOMMANDS_DBLCLICKACTIONIMPL_H__
#define __MDPROCESS_MDAADDINLIB_MDACOMMANDS_DBLCLICKACTIONIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/data/UnsortedTypeConverter.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"

namespace MDACommands {

class DblClickActionImpl; // self forward Var
typedef ::Core::Var<DblClickActionImpl> DblClickActionImpl_var;
typedef ::Core::Var<const DblClickActionImpl> DblClickActionImpl_cvar;

class DblClickActionImpl_factory;

// �������� �� ����-����
class DblClickActionImpl:
	virtual public Commands::DblClickAction
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DblClickActionImpl)
	friend class DblClickActionImpl_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ������������ ��������
	enum ActionID {
		OPEN_PROPERTIES // ������ ��������� ��������
		, OPEN_DIAGRAM // ������ ���������\��������� ��������� ���������
		, ALWAYS_ASK // ���������� ������� �������� ��� �������\������� ��������� ���������
		, OPEN_DIAGRAM_IF_EXISTS_ELSE_PROPERTIES // ���� �������� ���� - ��������� ��, ���� ��� - ��������
		, OPEN_DIAGRAM_IF_EXISTS_ELSE_ASK // ���� �������� ���� - ��������� ��, ���� ��� - ���������� "������� - ��������"/"������� ���������"
	};


	class ActionIDConvertor : 
		public Core::UnsortedTypeConverter<ActionID, std::string> {
		protected:
			void fill_array () {
				//#UC START# *46FA64BE01E4_FILL_ARRAY_IMPLEMENTATION*
				this->add (OPEN_PROPERTIES, "OPEN_PROPERTIES");
				this->add (OPEN_DIAGRAM, "OPEN_DIAGRAM");
				this->add (ALWAYS_ASK, "ALWAYS_ASK");
				this->add (OPEN_DIAGRAM_IF_EXISTS_ELSE_PROPERTIES, "OPEN_DIAGRAM_IF_EXISTS_ELSE_PROPERTIES");
				this->add (OPEN_DIAGRAM_IF_EXISTS_ELSE_ASK, "OPEN_DIAGRAM_IF_EXISTS_ELSE_ASK");
				//#UC END# *46FA64BE01E4_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class ActionIDConvertor

	typedef ACE_Singleton<ActionIDConvertor, ACE_SYNCH_NULL_MUTEX> ActionIDConvertorSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DblClickActionImpl ();

	virtual ~DblClickActionImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ��������������� ����� ��� ������ ������ ������ ����������� ��������
	virtual void ask (IRoseElementPtr elem);

	// ��������������� �����, �������� ������������ ��������� ��������, ���� ��������� ��� ��������
	// ��� - ������ �
	virtual void open_create_diag (IRoseElementPtr elem);

	// ��������������� ����� ��� ��������� ���������
	// ���������� rue, ���� ��������� ��� �������� ������� � �������������, ����� - false
	virtual bool open_diag (IRoseElementPtr elem);


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Commands::DblClickAction
	// ��������� ��������
	virtual void action (IRoseElementPtr elem);
}; // class DblClickActionImpl

} // namespace MDACommands


#endif //__MDPROCESS_MDAADDINLIB_MDACOMMANDS_DBLCLICKACTIONIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
