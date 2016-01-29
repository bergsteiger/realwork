////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/TemplatePainter_OutputWrapper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::TemplatePainter::OutputWrapper
//
// обертка над потоком, в который будет записываться результат
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
// by <<friend>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

//#UC START# *47762FB2013A_CUSTOM_INCLUDES*
#include <strstream>
#include <fstream>
//#UC END# *47762FB2013A_CUSTOM_INCLUDES*

class TemplatePainter;
//#UC START# *47762FB2013A*
TemplatePainter::OutputWrapper& 
TemplatePainter::OutputWrapper::operator << (const char* str) {
	std::string replaced_string = str;	
	if (GCL::contains ('\t', str)) {	
		const AbstractDumperBase* ad = m_owner.m_owner ? m_owner.m_owner : m_owner.m_main_scope;
		const AbstractDumperBase::TemplateBody& tp = ad->get_template_body ();
		GCL::replace_char (
			str, replaced_string, '\t', tp.tab_replacer
		);
		
	} 
		
	//replaced_string = GCL::convert (replaced_string.c_str (), AbstractDumperBase::s_default_encoding, m_owner.get_encoding ());
	*m_output << replaced_string;
	if (m_need_buffer) {
		m_buffer += replaced_string;
	}
	return *this;
}

TemplatePainter::OutputWrapper& 
TemplatePainter::OutputWrapper::operator << (const std::string& str) {
	//Core::GDS::StopWatchEx sw ("OutputWrapper::operator << (const std::string& str)");		
	std::string replaced_string = str;	
	if (GCL::contains ('\t', str.c_str ())) {	
		const AbstractDumperBase* ad = m_owner.m_owner ? m_owner.m_owner : m_owner.m_main_scope;
		const AbstractDumperBase::TemplateBody& tp = ad->get_template_body ();
		GCL::replace_char (
			str.c_str (), replaced_string, '\t', tp.tab_replacer
		);
		
	} 
		
	//replaced_string = GCL::convert (replaced_string.c_str (), AbstractDumperBase::s_default_encoding, m_owner.get_encoding ());	
	*m_output << replaced_string;
	if (m_need_buffer) {
		m_buffer += replaced_string;
	}
	return *this;
}

TemplatePainter::OutputWrapper& 
TemplatePainter::OutputWrapper::operator << (const char& c) {	
	if (c == '\t') {
		const AbstractDumperBase* ad = m_owner.m_owner ? m_owner.m_owner : m_owner.m_main_scope;
		const AbstractDumperBase::TemplateBody& tp = ad->get_template_body ();
		*m_output << tp.tab_replacer;
		if (m_need_buffer) {
			m_buffer += tp.tab_replacer;
		}
	} else {
		//нужно сконвертить символ
		std::string str;
		str += c;
		//std::string converted = GCL::convert (str.c_str (), AbstractDumperBase::s_default_encoding, m_owner.get_encoding ());
		*m_output << str;
		if (m_need_buffer) {
			m_buffer += str;
		}
	}	
	return *this;
}

void TemplatePainter::OutputWrapper::seekp (std::streampos pos) {
	if (pos != m_output->tellp ()) {
		if (size_t (pos) == size_t (-1)) {
			pos = 0;
		}
		m_output->clear ();
		m_output->seekp (pos);
	}
}

std::streampos TemplatePainter::OutputWrapper::tellp () const {
	return m_output->tellp();
}
//#UC END# *47762FB2013A*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор, out - поток, над которым делается обёртка
TemplatePainter::OutputWrapper::OutputWrapper (std::ostream& out, const TemplatePainter* owner)
//#UC START# *47762FDC0329_BASE_INIT*
:	m_output (&out)
	, m_own_output(false) 
	, m_owner (*owner)
	, m_need_buffer (false)
//#UC END# *47762FDC0329_BASE_INIT*
{
	//#UC START# *47762FDC0329_BODY*
	m_buffer.clear ();
	//#UC END# *47762FDC0329_BODY*
}

TemplatePainter::OutputWrapper::OutputWrapper (const TemplatePainter* owner)
//#UC START# *477C865B0347_BASE_INIT*
:	m_output (0)
	, m_own_output(false) 
	, m_owner (*owner)
	, m_need_buffer (false)
//#UC END# *477C865B0347_BASE_INIT*
{
	//#UC START# *477C865B0347_BODY*
	m_buffer.clear ();
	m_own_output = true;
	m_output = new std::strstream;
	//#UC END# *477C865B0347_BODY*
}

TemplatePainter::OutputWrapper::~OutputWrapper () {
	//#UC START# *47762FB2013A_DESTR_BODY*
	if (m_own_output) {
		delete m_output;
	}
	//#UC END# *47762FB2013A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// инициализирует внутренний буфер
void TemplatePainter::OutputWrapper::init_buffer () {
	//#UC START# *477632AB0178*
	m_need_buffer = true;
	m_buffer.clear ();
	//#UC END# *477632AB0178*
}

// очищает внутренний буфер, возвращает в качестве результата значение буфера перед очисткой
const std::string TemplatePainter::OutputWrapper::release_buffer () {
	//#UC START# *477632DA0226*
	std::string res;
	if (m_need_buffer) {
		res = m_buffer;
	}
	m_need_buffer = false;
	m_buffer.clear ();
	return res;
	//#UC END# *477632DA0226*
}

// установить поток
void TemplatePainter::OutputWrapper::set_output (std::ostream& out) {
	//#UC START# *4776328902F6*
	if (m_own_output) {
		delete m_output;			
	}
	m_output = &out;
	//#UC END# *4776328902F6*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

