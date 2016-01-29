///////////////////////////////////////////////////////////////////////////////
//
// Класс для анализа файла условий
//
///////////////////////////////////////////////////////////////////////////////

#include "stdbase.h"
#include <ctype.h>
#include "parser.h"
#include "lex.h"
#include "context.h"
#include <string>
//#include <iostream>

typedef	void	(*call_t)(const char *start, long length);

static	ChangeRule	*pCurRule = 0;
static	RuleParser	*pCurParser = 0;
static	std::list<std::string> CurIdentifier;
static	std::string		 CurOperator;
static	std::list<std::string> CurValue;

///////////////////////////////////////////////////////////////////////////////

void	RuleParser::out_parser(FILE *out)
{
	std::list<ChangeRule>::iterator		i;
	std::list<Condition>::iterator		j;
	std::list<ChangeAction>::iterator	k;
	std::list<std::string>::iterator			l;
	std::list<std::string>::iterator			s;

    if( out ) {
        for(i = m_rule.begin(); i != m_rule.end(); i ++) {
			fprintf(out, "%s:", s_If);
			if( (*i).type() == ChangeRule::rtOnce ) {
				fprintf(out, "%s\n", s_Once);
			} else
			if( (*i).type() == ChangeRule::rtFinally ) {
				fprintf(out, "%s\n", s_Finally);
			} else {
				fprintf(out, "always\n");
			}
			// Вывод условий
            for(j = (*i).condition().begin(); j != (*i).condition().end(); j ++) {
                // Вывод имени условия
				s = (*j).name().begin();
                fprintf(out, "\t%s", (*s).c_str());
                s ++;
                for(; s != (*j).name().end(); s ++) {
                    fprintf(out, ".%s", (*s).c_str());
                }
                // Вывод условия
				switch( (*j).operation() ) {
				case Condition::otEqual:
					fprintf(out, "==");
					break;
        
				case Condition::otNotEqual:
					fprintf(out, "!=");
					break;
				case Condition::otGreater:
					fprintf(out,">");
					break;
				case Condition::otBelow:
					fprintf(out,"<");
					break;
				}
                // Вывод значения условия
				fprintf(out, "'%s'\n", (*j).value().c_str());
			}
			fprintf(out, "%s\n", s_Then);
			for(k = (*i).action().begin(); k != (*i).action().end(); k ++) {
                // Вывод имени действия
				s = (*k).name().begin();
                fprintf(out, "\t%s", (*s).c_str());
                s ++;
                for(; s != (*k).name().end(); s ++) {
                    fprintf(out, ".%s", (*s).c_str());
                }
        
				switch( (*k).command() ) {
				case ChangeAction::ctChange:
					fprintf(out, ".%s", s_Change);
					break;
        
				case ChangeAction::ctSet:
					fprintf(out, ".%s", s_Set);
					break;
        
				case ChangeAction::ctRemove:
					fprintf(out, ".%s", s_Remove);
					break;
        
				case ChangeAction::ctAdd:
					fprintf(out, ".%s", s_Add);
					break;
				}
      
				fprintf(out, "( ");
				for( l = (*k).value().begin(); l != (*k).value().end(); l ++ ) {
					fprintf(out, "'%s' ", (*l).c_str());
				}
				fprintf(out, ")\n");
			}
			fprintf(out, "%s\n", s_End);
		}
		fflush(out);
    }
}

///////////////////////////////////////////////////////////////////////////////
//
// Функция вызывается кодна найдена переменная
//
void	RuleParser::do_identifier(const char *start, long length)
{
	//cout << "- Identifier:" << string(start, end) << "\n";
    CurIdentifier.push_back(string(start, start + length));
}

///////////////////////////////////////////////////////////////////////////////
//
// Функция вызывается кодна найдено значение (строка или число)
//
void	RuleParser::do_value(const char *start, long length)
{
	//cout << "- Value:" << string(start, end) << "\n";
	CurValue.push_back(std::string(start, start + length));
}

///////////////////////////////////////////////////////////////////////////////
//
// Функция вызывается кодна найдена операция
//
void	RuleParser::do_operator(const char *start, long length)
{
	//cout << "- Operator:" << string(start, end) << "\n";
	CurOperator = string(start, start + length);
}

///////////////////////////////////////////////////////////////////////////////
//
// Функция вызывается кодна найдено действие
//
void	RuleParser::do_action(const char *start, long length)
{
	//cout << "- Action" << "\n";
	// Если это действие относиться к правилу
	if( pCurRule ) {
		ChangeAction	*pAction;
		pAction = new ChangeAction();
		pAction->name(CurIdentifier);
		pAction->command(CurOperator);
		pAction->value(CurValue);
		pCurRule->insert_action(pAction);
		delete pAction;
	// Если это действие не относиться к правилу
	} else {
		ChangeRule		*pRule;
		ChangeAction	*pAction;
		pRule = new ChangeRule();
		pAction = new ChangeAction();
		pAction->name(CurIdentifier);
		pAction->command(CurOperator);
		pAction->value(CurValue);
		pRule->insert_action(pAction);
		pCurParser->insert_rule(pRule);
		delete pAction;
		delete pRule;
	}
    CurIdentifier.clear();
    CurOperator.erase();
	CurValue.clear();
}

///////////////////////////////////////////////////////////////////////////////
//
// Функция вызывается кодна найдено условие
//
void	RuleParser::do_condition(const char *start, long length)
{
	//cout << "- Condition" << "\n";
	if( pCurRule ) {
		Condition	*pCondition;
		pCondition = new Condition();
		pCondition->name(CurIdentifier);
		pCondition->operation(CurOperator);
		pCondition->value(*CurValue.begin());
		pCurRule->insert_condition(pCondition);
		delete pCondition;
	}
    CurIdentifier.clear();
    CurOperator.erase();
	CurValue.clear();
}

///////////////////////////////////////////////////////////////////////////////
//
// Функция вызывается кодна найдено "if"
//
void	RuleParser::do_ifkey(const char *start, long length)
{
	//cout << "- ifkey:" << string(start, end) << "\n";
	if( pCurRule ) {
		delete pCurRule;
	}

	pCurRule = new ChangeRule(); // Здесь будут накапливаться условия и действия
}

///////////////////////////////////////////////////////////////////////////////
//
// Функция вызывается кодна найдено "then"
//
void	RuleParser::do_thenkey(const char *start, long length)
{
	//cout << "- thenkey:" << string(start, end) << "\n";
}

///////////////////////////////////////////////////////////////////////////////
//
// Функция вызывается кодна найдено "end"
//
void	RuleParser::do_endkey(const char *start, long length)
{
	//cout << "- endkey:" << string(start, end) << "\n";
	if( pCurRule ) {
		pCurParser->insert_rule(pCurRule);
		delete pCurRule;
		pCurRule = 0;
	}
}

///////////////////////////////////////////////////////////////////////////////
//
// Функция вызывается когда найдено "once"
//
void	RuleParser::do_oncekey(const char *start, long length)
{
	if( pCurRule ) {
		delete pCurRule;
	}

	pCurRule = new ChangeRule(); // Здесь будут накапливаться условия и действия
	pCurRule->type(ChangeRule::rtOnce);
}

void	RuleParser::do_finallykey(const char *start, long length)
{
	if( pCurRule ) {
		delete pCurRule;
	}

	pCurRule = new ChangeRule(); // Здесь будут накапливаться условия и действия
	pCurRule->type(ChangeRule::rtFinally);
}

///////////////////////////////////////////////////////////////////////////////

long	RuleParser::Parse(Parser/*Rule<Scanner_t>*/ &expr, const char *str)
{
	long	retv;
	Match	match;

	//Scanner_t	scan(str, nothing);
	//retv = expr.Parse(scan);

	retv = true;

	match = expr.Parse(str);

	if( !match || (match.length() < ::strlen(str)) )
	{
		printf("Syntax error in rules file!\n");
		retv = false;
	}

	return retv;
}

// Класс RuleParser ///////////////////////////////////////////////////////////

RuleParser::RuleParser(char *str)
{
	Char	x0D(0x0d);
	Char	x0A(0x0a);
	Char	x20(0x20);
	Char	x09(0x09);
	Char	dot('.');
	Char	lbracket('(');
	Char	rbracket(')');
	Char	plus('+');
	Char	minus('+');
	Char	cuot('"');
	Char	scol(';');
	Char	mcomma(',');
	Char	underscore('_');
	String	add(s_Add);
	String	remove(s_Remove);
	String	change(s_Change);
	String	set(s_Set);
	String	if_(s_If);
	String	then_(s_Then);
	String	end_(s_End);
	String	once_(s_Once);
	String	finally_(s_Finally);
	String	eq_("==");
	String	neq_("!=");
	String	gr_(">");
	String	bel_("<");
	Alpha	alpha;
	Alnum	alnum;
	Digit	digit;
	Anychar	anychar;
	Parser	ualpha		= alpha | underscore;
	Parser	ualnum		= alnum | underscore;
	Parser	skip		= x09 | x20;
	Parser	lskip		= x09 | x20 | x0D | x0A;
	Parser	command		= (add | remove | set | change)[(call_t)&do_operator];
	Parser	identifier	= ( (+ualpha >> *ualnum ) - (if_ | then_ | once_ | finally_ | end_ | command))[(call_t)&do_identifier];
	Parser	operation	= (eq_ | neq_ | gr_ | bel_ )[(call_t)&do_operator];
	Parser	key_if		= (if_)[(call_t)&do_ifkey] >> +lskip;
	Parser	key_then	= (then_)[(call_t)&do_thenkey] >> +lskip;
	Parser	key_once	= (once_)[(call_t)&do_oncekey] >> +lskip;
	Parser	key_finally	= (finally_)[(call_t)&do_finallykey] >> +lskip;
	Parser	key_end		= (end_)[(call_t)&do_endkey] >> +lskip;
	Parser	integer		= (!(plus | minus) >> +digit)[(call_t)&do_value];
	Parser	astr		= (cuot >> (*(anychar - cuot))[(call_t)&do_value] >> cuot);
	Parser	condition	= (*lskip >> identifier >> *(dot >> identifier) >> *skip >> operation >> *skip >> (astr | integer) >> *skip >> scol >> *lskip)[(call_t)&do_condition];
	Parser	valargs		= +(astr | integer) >> *skip >> *(mcomma >> *skip >> (astr | integer) >> *skip);
	Parser	action		= (*lskip >> identifier >> *(dot >> identifier) >> dot >> command >> lbracket >> *skip >> valargs >> *skip >> rbracket >> *skip >> scol >> *lskip)[(call_t)&do_action];
	Parser	ruleblock	= (key_if >> *condition >> key_then >> *action >> key_end);
	Parser	onceblock	= (key_once >> *action >> key_end);
	Parser	finallyblock	= (key_finally >> *action >> key_end);
	Parser	expr		= *(ruleblock | onceblock | finallyblock | action | lskip);

	::pCurParser = this;
	m_ok = Parse(expr, str);
}

///////////////////////////////////////////////////////////////////////////////

RuleParser::~RuleParser()
{
}

///////////////////////////////////////////////////////////////////////////////

long	RuleParser::is_ok(void)
{
	return m_ok;
}

///////////////////////////////////////////////////////////////////////////////

void	RuleParser::insert_rule(ChangeRule *rule)
{
	if( rule ) {
		m_rule.insert(m_rule.end(), *rule);
	}
}

///////////////////////////////////////////////////////////////////////////////

list<ChangeRule>	&RuleParser::rule(void)
{
	return m_rule;
}

// Класс Rule /////////////////////////////////////////////////////////////////

ChangeRule::ChangeRule()
{
	m_type = rtNone;
}

///////////////////////////////////////////////////////////////////////////////

ChangeRule::ChangeRule(long type)
{
	m_type = type;
}

///////////////////////////////////////////////////////////////////////////////

ChangeRule::~ChangeRule()
{
}

///////////////////////////////////////////////////////////////////////////////

long	ChangeRule::type(void)
{
	return m_type;
}

///////////////////////////////////////////////////////////////////////////////

void	ChangeRule::type(long type)
{
	m_type = type;
}

///////////////////////////////////////////////////////////////////////////////

void	ChangeRule::insert_condition(Condition *condition)
{
	if( condition ) {
		m_condition.insert(m_condition.end(), *condition);
	}
}

///////////////////////////////////////////////////////////////////////////////

void	ChangeRule::insert_action(ChangeAction *action)
{
	if( action ) {
		m_action.insert(m_action.end(), *action);
	}
}

///////////////////////////////////////////////////////////////////////////////

list<Condition>		&ChangeRule::condition(void)
{
	return m_condition;
}

///////////////////////////////////////////////////////////////////////////////

list<ChangeAction>	&ChangeRule::action(void)
{
	return m_action;
}

// Класс Condition ////////////////////////////////////////////////////////////

Condition::Condition()
{
	m_operation = otNone;
}

///////////////////////////////////////////////////////////////////////////////

Condition::~Condition()
{
}

///////////////////////////////////////////////////////////////////////////////

void Condition::name(list<string> &newName)
{
	m_name = newName;
}

///////////////////////////////////////////////////////////////////////////////

list<string> &Condition::name(void)
{
	return m_name;
}

///////////////////////////////////////////////////////////////////////////////

void	Condition::operation(string newOperation)
{
	if( ::strcmp(newOperation.c_str(), "==") == 0 ) {
		m_operation = otEqual;
	}
	else
	if( ::strcmp(newOperation.c_str(), "!=") == 0 ) {
		m_operation = otNotEqual;
	}
	else
	if( ::strcmp(newOperation.c_str(), ">") == 0 ) {
		m_operation = otGreater;
	}
	else
	if( ::strcmp(newOperation.c_str(), "<") == 0 ) {
		m_operation = otBelow;
	}
}

///////////////////////////////////////////////////////////////////////////////

void	Condition::operation(long newOperation)
{
	m_operation = newOperation;
}

///////////////////////////////////////////////////////////////////////////////

long	Condition::operation(void)
{
	return m_operation;
}

///////////////////////////////////////////////////////////////////////////////

void	Condition::value(string newValue)
{
	m_value = newValue;
}

///////////////////////////////////////////////////////////////////////////////

string	Condition::value(void)
{
	return m_value;
}

// Класс Action ///////////////////////////////////////////////////////////////

ChangeAction::ChangeAction()
{
	m_command = ctNone;
}

///////////////////////////////////////////////////////////////////////////////

ChangeAction::~ChangeAction()
{
}

///////////////////////////////////////////////////////////////////////////////

void ChangeAction::name(list<string> &newName)
{
	m_name = newName;
}

///////////////////////////////////////////////////////////////////////////////

list<string> &ChangeAction::name(void)
{
	return m_name;
}

///////////////////////////////////////////////////////////////////////////////

void	ChangeAction::value(list<string> &newValue)
{
	m_value = newValue;
}

///////////////////////////////////////////////////////////////////////////////

list<string>	&ChangeAction::value(void)
{
	return m_value;
}

///////////////////////////////////////////////////////////////////////////////

void	ChangeAction::command(string newCommand)
{
	if( ::strcmp(newCommand.c_str(), s_Change) == 0 ) {
		m_command = ctChange;
	}
	else
	if( ::strcmp(newCommand.c_str(), s_Set) == 0 ) {
		m_command = ctSet;
	}
	else
	if( ::strcmp(newCommand.c_str(), s_Remove) == 0 ) {
		m_command = ctRemove;
	}
	else
	if( ::strcmp(newCommand.c_str(), s_Add) == 0 ) {
		m_command = ctAdd;
	}
}

///////////////////////////////////////////////////////////////////////////////

void	ChangeAction::command(long newCommand)
{
	m_command = newCommand;
}

///////////////////////////////////////////////////////////////////////////////

long	ChangeAction::command(void)
{
	return m_command;
}

///////////////////////////////////////////////////////////////////////////////
