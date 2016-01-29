////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/CEditMask.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::CEditMask
//
// контрол ввода с возможность фильтрации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/CEditMask.h"

//#UC START# *470AFDEC0203_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/CRegExp.h"
//#UC END# *470AFDEC0203_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470AFDEC0203*
CEditMask::CEditMask()
{
 // default input mask: allow any characters //
  m_stInputMask = ".*" ;
  pEditInputCallback = NULL ;

  m_iMaxLength = -1 ;
}

/////////////////////////////////////////////////////////////////////////////
// Behandlungsroutinen fьr Nachrichten CEditMask 

BOOL CEditMask::PreTranslateMessage(MSG* pMsg) 
{
  CString stInputText ;

  if (!pMsg)
    return FALSE ;

  if (pMsg->message == WM_KEYDOWN && pMsg->wParam == VK_RETURN)
  {
	  GetWindowText(stInputText) ;
	  
    // the return has been processed
    if(CallCallback(stInputText) > 0)
      return TRUE;

	  // should be unreachable //  
    //return TRUE ;
  }

  if (pMsg->message == WM_CHAR)
	{
		// check, if input is valid.						//
		// get ald and new input text						//
		CString stInputValue ;

		GetWindowText(stInputText) ;
		stInputValue.Format("%c", (char) pMsg->wParam) ;
// GARANT {
		unsigned char c = (unsigned char) pMsg->wParam ;
// } GARANT

    if (c == 'ь' || c == 'Я' || c == 'д' || c == 'ц' || 
        c == 'Ь' || c == 'Д' || c == 'Ц' || 
        isprint(c))
		{
			//stInputText += stInputValue ;

      int iSelStart = 0 ;
      int iSelEnd = 0 ;

      GetSel(iSelStart, iSelEnd) ;

      if (stInputText.Left(1) == ' ')
      {
        stInputText.TrimLeft() ;

        if (iSelStart > 0)
          iSelStart-- ;

        if (iSelEnd > 0)
          iSelEnd-- ;
      }

      if (iSelStart == iSelEnd)
      {
// GARANT {
        // insert single character //
        stInputText.Insert(iSelStart, (char) c) ;
// } GARANT
      }
      else
      {
        // replace selection //
        CString stTmp ;

        stTmp  = stInputText.Left(iSelStart) ;
        stTmp += stInputValue ;
        stTmp += stInputText.Right(stInputText.GetLength() - iSelEnd) ;

        stInputText = stTmp ;
      }

      if (m_iMaxLength != -1 && stInputText.GetLength() > m_iMaxLength)
      {
        MessageBeep(1) ;
        return TRUE ;
      }

      // check, if input is a valid string  //
      // check against regular expression   //
      if (!ValidateInput(stInputText.GetBuffer(500)))
			{
				MessageBeep(1) ;
				// ignore the last input character ! //
        return TRUE ;								
			}
      else
      {
        SetWindowText(stInputText) ;
        
        // restore cursor position //
        SetSel(iSelStart+1, iSelStart+1) ;

        return TRUE ;								
      }
		}
	}
	
	return CEdit::PreTranslateMessage(pMsg);
}

int CEditMask::ValidateInput(char *pInputText)
{
	ASSERT(pInputText != NULL) ;

	if (pInputText == NULL)
		return 0 ;

	//if (CString(pInputText) == "")
	//	return 0 ;

  CString stTmp = m_stInputMask ;
  stTmp.MakeLower() ;

  if (stTmp == "#date#")
  {
    #ifdef USESONDATE
      CSonDateParse SonDateParse ;
      
      if (SonDateParse.Parse(CString(pInputText)) == 0)
      {
        // error //
        
      }
      else
      {
        
      }
    #endif  
  }
  else
  {
    // match it with the InputMask regular expression	//
	  CRegExp RegExp ;
	  RegExp.RegComp(m_stInputMask) ;
	  
	  int iRet = RegExp.RegFind(pInputText) ;
	  
	  if (iRet == -1)
		  return 0 ;								    // does not match //
	  else
		  return iRet + 1;							// matches ! //
  }

  // should be unreachable //
  return 0 ;
}

int CEditMask::SetInputMask(const CString &stInputMask)
{
	m_stInputMask = stInputMask ;

	return 1 ;
}

int CEditMask::SetCallback(EDITINPUTCALLBACK EditInputMask)
{
	pEditInputCallback = EditInputMask ;
	return 1 ;
}

int CEditMask::CallCallback(CString& stText)
{
	if (pEditInputCallback)
  {
    
    return (pEditInputCallback) (stText) ;
  }

	return 0 ;
}

bool CEditMask::SetMaxLenght(int iMaxLength)
{
  m_iMaxLength = iMaxLength ;

  return true ;
}

//#UC END# *470AFDEC0203*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CEditMask::~CEditMask () {
	//#UC START# *470AFDEC0203_DESTR_BODY*
	//#UC END# *470AFDEC0203_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(CEditMask, CEdit)
	//#UC START# *470AFDEC0203_MESSAGE_MAP*
	//#UC END# *470AFDEC0203_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(CEditMask, CEdit)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

