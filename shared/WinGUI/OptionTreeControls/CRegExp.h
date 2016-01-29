////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/CRegExp.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::OptionTreeControls::CRegExp
//
// regexp
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_CREGEXP_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_CREGEXP_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *470B17AB001F_CUSTOM_INCLUDES*
#ifdef STRINGEX
	#include <StringEx.h>
	int RegSearchReplace(CStringEx& string, LPCTSTR sSearchExp, LPCTSTR sReplaceExp);
#endif

#define NSUBEXP  10
//#UC END# *470B17AB001F_CUSTOM_INCLUDES*

namespace WinGUI {

// regexp
class CRegExp {
	SET_OBJECT_COUNTER (CRegExp)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~CRegExp ();


//#UC START# *470B17AB001F*
public:
	CRegExp();

	CRegExp *RegComp( const TCHAR *re );
	int RegFind(const TCHAR *str);
	TCHAR* GetReplaceString( const TCHAR* sReplaceExp );
	int GetFindLen()
	{
		if( startp[0] == NULL || endp[0] == NULL )
			return 0;

		return endp[0] - startp[0];
	}

	int GetVar(/*CString stSearchString,*/ int iVarNr, CString &RetString) ;

	int GetVarCount() ;

private:
	TCHAR *regnext(TCHAR *node);
	void reginsert(TCHAR op, TCHAR *opnd);

	int regtry(TCHAR *string);
	int regmatch(TCHAR *prog);
	size_t regrepeat(TCHAR *node);
	TCHAR *reg(int paren, int *flagp);
	TCHAR *regbranch(int *flagp);
	void regtail(TCHAR *p, TCHAR *val);
	void regoptail(TCHAR *p, TCHAR *val);
	TCHAR *regpiece(int *flagp);
	TCHAR *regatom(int *flagp);

	// Inline functions
private:
	TCHAR OP(TCHAR *p) {return *p;};
	TCHAR *OPERAND( TCHAR *p) {return (TCHAR*)((short *)(p+1)+1); };

	// regc - emit (if appropriate) a byte of code
	void regc(TCHAR b)
	{
		if (bEmitCode)
			*regcode++ = b;
		else
			regsize++;
	};

	// regnode - emit a node
	TCHAR *	regnode(TCHAR op)
	{
		if (!bEmitCode) {
			regsize += 3;
			return regcode;
		}

		*regcode++ = op;
		*regcode++ = _T('\0');		/* Null next pointer. */
		*regcode++ = _T('\0');

		return regcode-3;
	};


private:
	BOOL bEmitCode;
	BOOL bCompiled;
	TCHAR *sFoundText;

	TCHAR *startp[NSUBEXP];
	TCHAR *endp[NSUBEXP];
	TCHAR regstart;		// Internal use only. 
	TCHAR reganch;		// Internal use only. 
	TCHAR *regmust;		// Internal use only. 
	int regmlen;		// Internal use only. 
	TCHAR *program;		// Unwarranted chumminess with compiler. 

	TCHAR *regparse;	// Input-scan pointer. 
	int regnpar;		// () count. 
	TCHAR *regcode;		// Code-emit pointer; ®dummy = don't. 
	TCHAR regdummy[3];	// NOTHING, 0 next ptr 
	long regsize;		// Code size. 

	TCHAR *reginput;	// String-input pointer. 
	TCHAR *regbol;		// Beginning of input, for ^ check. 

	char*	m_pVars[10] ;
	int		m_VarLen[10] ;
	
	int		m_iVarCount ;
//#UC END# *470B17AB001F*
}; // class CRegExp

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_CREGEXP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

