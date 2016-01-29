///////////////////////////////////////////////////////////////////////////////
//
// Классы для анализа файла условий
//
///////////////////////////////////////////////////////////////////////////////
#ifndef PARSER_H
#define PARSER_H

#include <stdio.h>
#include <list>
#include <string>

//#include "Spirit.h"
#include "lex.h"

using	std::list;
using	std::string;

/*
using	Spirit::Rule;
using	Spirit::Scanner;
using	Spirit::Nothing_;


typedef	Scanner<Nothing_>	Scanner_t;
*/

// Класс Action ///////////////////////////////////////////////////////////////

class	ChangeAction {
public:
	enum	CommandType {
		ctNone,
		ctChange,
		ctRemove,
		ctAdd,
		ctPush,
		ctSet
	};

	ChangeAction();
	~ChangeAction();

	void	name(list<string> &);
	list<string>	&name(void);
	void	value(list<string> &);
	list<string>	&value(void);
	void	command(string);
	void	command(long);
	long	command(void);

protected:
private:
	list<string>	m_name;
	list<string>	m_value;
	long	m_command;
};

// Класс Condition ////////////////////////////////////////////////////////////

class	Condition {
public:
	enum	OperatorType {
		otNone,
		otEqual,
		otNotEqual,
		otGreater,
		otBelow
	};

	void name(list<string> &);
	list<string> &name(void);
	void operation(string);
	void operation(long operation);
	long operation(void);
	void value(string);
	string value(void);

	Condition();
	~Condition();

protected:
private:
	list<string>	m_name;
	string	m_value;
	long	m_operation;
};

// Класс Rule /////////////////////////////////////////////////////////////////

class	ChangeRule {
public:
	enum	ChangeRuleType {  // Типы действий
		rtNone,				// Не определен
		rtOnce,				// Единовременно
		rtFinally			// в конце
	};

	ChangeRule();
	ChangeRule(long type);
	~ChangeRule();

	long	type(void);
	void	type(long);
	void	insert_condition(Condition *condition);
	void	insert_action(ChangeAction *action);
	list<Condition>		&condition(void);
	list<ChangeAction>	&action(void);

protected:
private:
	long			m_type;
	list<Condition>	m_condition;
	list<ChangeAction>	m_action;
};

// Класс RuleParser ///////////////////////////////////////////////////////////

class	RuleParser {
public:
	RuleParser(char *buf);
	~RuleParser();

	void	insert_rule(ChangeRule *rule);
	long	is_ok(void);
	ChangeRule	*rule(long index);

	void	out_parser(FILE *out);

	list<ChangeRule>	&rule(void);

protected:
private:
	long	Parse(Parser/*Rule<Scanner_t>*/ &expr, const char *str);

static	void	do_identifier(const char *start, long length);
static	void	do_operator  (const char *start, long length);
static	void	do_value     (const char *start, long length);
static	void	do_action    (const char *start, long length);
static	void	do_condition (const char *start, long length);
static	void	do_ifkey     (const char *start, long length);
static	void	do_oncekey   (const char *start, long length);
static	void	do_finallykey   (const char *start, long length);
static	void	do_thenkey   (const char *start, long length);
static	void	do_endkey    (const char *start, long length);

	long	m_ok;
	list<ChangeRule>	m_rule;
};

#endif // PARSER_H
