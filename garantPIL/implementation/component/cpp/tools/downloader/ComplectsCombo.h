//
// ComplectsCombo.h : header file
//
#if !defined(AFX_COMPLECTSCOMBO_H__1FF3DE17_4080_4ADC_9413_3FF6C1E4548E__INCLUDED_)
#define AFX_COMPLECTSCOMBO_H__1FF3DE17_4080_4ADC_9413_3FF6C1E4548E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CComplectsCombo window

class CComplectsCombo : public CComboBox {
// Construction
public:
	CComplectsCombo ();
	virtual ~CComplectsCombo ();

// Attributes
private:
	bool m_initialized;
	
// Operations
public:
	inline void set_init_flag (bool val) { 
		m_initialized = val; 
	}

// Overrides
protected:
	//{{AFX_VIRTUAL(CComplectsCombo)
	virtual void PreSubclassWindow ();
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CComplectsCombo)
	afx_msg int OnCreate (LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnLButtonDown (UINT nFlags, CPoint point);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
#endif // !defined(AFX_COMPLECTSCOMBO_H__1FF3DE17_4080_4ADC_9413_3FF6C1E4548E__INCLUDED_)
