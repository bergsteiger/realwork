////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentState_i
// Заголовок реализации класса серванта для интерфеса DocumentState
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTSTATE_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTSTATE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"

//#UC START# *460A59CD0328_CUSTOM_INCLUDES*
//#UC END# *460A59CD0328_CUSTOM_INCLUDES*

// forward decls for defined friends
namespace GblAdapterLib {
	class DocumentDelegate;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class Document_i;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class Document_i;
class DocumentState_i; // self forward Var
typedef ::Core::Var<DocumentState_i> DocumentState_i_var;
typedef ::Core::Var<const DocumentState_i> DocumentState_i_cvar;

class DocumentState_i_factory;

class DocumentState_i:
	virtual public DocumentState
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DocumentState_i)
	friend class DocumentState_i_factory; // self factory
	friend class DocumentDelegate; // defined friend
	friend class Document_i; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	struct State {
		RedactionID redaction;
		GblPilotDef::DictLanguage language;
		bool has_extruct;
		ListEntryInfo_var appropriate_entry_in_list;
		Core::Box<RedactionInfoList> prev_redaction_info_list;
		Core::Box<RedactionInfoList> cur_and_next_redaction_info_list;

		State (const State& copy);

		State& operator = (const State& copy);

		State ();
		//#UC START# *461A555F0213*
		//#UC END# *461A555F0213*
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DocumentState_i (Document* source_doc);

	DocumentState_i ();

	virtual ~DocumentState_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual GblPilotDef::DictLanguage language () const;

	virtual void set_appropriate_list_info (const ListEntryInfo* lei);

private:
	virtual bool is_list_data_equivalent (const ListEntryInfo* lei1, const ListEntryInfo* lei2) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable State m_new_state;

	Document_i* m_source_doc;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocumentState
	// [$178325284]
	virtual bool can_compare_with_any_other_redaction () const;

	// implemented method from DocumentState
	virtual DocumentState* clone () const;

	// implemented method from DocumentState
	// [$178324034]
	virtual const RedactionInfoList& get_cur_and_next_redactions_list () const;

	// implemented method from DocumentState
	virtual DiffData* diff_with_redaction_by_id (RedactionID id) const;

	// implemented method from DocumentState
	virtual RedactionInfo* get_current_redaction () const;

	// implemented method from DocumentState
	// возвращает true, если эта редакция актуальная, т. е. имеет тип:
	// - RT_ACTUAL
	// - RT_ACTUAL_ABOLISHED
	// - RT_ACTUAL_PREACTIVE
	virtual bool is_actual () const;

	// implemented method from DocumentState
	virtual bool is_same_redactions (const DocumentState* other) const;

	// implemented method from DocumentState
	virtual Languages get_language () const;

	virtual void set_language (Languages language);

	// implemented method from DocumentState
	virtual const RedactionInfoList& get_prev_redactions_list () const;

	// implemented method from DocumentState
	virtual RedactionID redaction () const;

	// implemented method from DocumentState
	// Операция устанавливает в качестве текущей редакцию, актуальную редакцию для данного документа.
	// Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой,
	// что и до вызова метода.
	virtual void set_actual_redaction () const /*throw (RedactionNotFound)*/;

	// implemented method from DocumentState
	// Операция устанавливает в качестве текущей следующую редакцию объекта.
	// Если следующей редакции нет, то возвращается RedactionNotFound.
	virtual void set_next_redaction () const /*throw (RedactionNotFound)*/;

	// implemented method from DocumentState
	// GetБлижайшаяДействующаяРедакцияВниз. [$178325284]
	virtual void set_prev_active_redaction () const /*throw (RedactionNotFound)*/;

	// implemented method from DocumentState
	// Операция устанавливает в качестве текущей предыдущую редакцию объекта.
	// Если предыдущей редакции нет, то возвращается RedactionNotFound.
	virtual void set_prev_redaction () const /*throw (RedactionNotFound)*/;

	// implemented method from DocumentState
	virtual void set_redaction_on_date (const Date& date) const /*throw (RedactionNotFound)*/;

	// implemented method from DocumentState
	// Операция устанавливает в качестве текущей редакцию с заданным идентификатором.
	// Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой,
	// что и до вызова метода.
	// Если задан неверный идентификатор редакции, то возвращается InvalidRedactionId.
	virtual void set_redaction_on_id (RedactionID id) const /*throw (RedactionNotFound)*/;

//#UC START# *460A59CD0328*
public:
	DocumentState_i& operator = (const DocumentState_i& copy);
	DocumentState_i (const DocumentState_i& copy);
	bool operator == (const DocumentState_i& other) const;

private:	
	static bool is_actual_redaction (RedactionType type);
//#UC END# *460A59CD0328*
}; // class DocumentState_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTSTATE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
