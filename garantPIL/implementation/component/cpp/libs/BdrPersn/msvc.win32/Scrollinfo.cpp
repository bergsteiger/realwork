// Scrollinfo.cpp : implementation file
//

#include "stdafx.h"
#include "TestBreeder32.h"
#include "Scrollinfo.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CScrollinfo

CScrollinfo::CScrollinfo()
{
}

CScrollinfo::~CScrollinfo()
{
}


BEGIN_MESSAGE_MAP(CScrollinfo, CListBox)
	//{{AFX_MSG_MAP(CScrollinfo)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

int CScrollinfo::LocalAddString(LPCTSTR lpszItem)
{
	CString added(lpszItem);
	int FndTmp;
	if((FndTmp= added.Find('\n')) > -1){
		added= added.Left(FndTmp);
	}
	return AddString((LPCTSTR)added);
}

void CScrollinfo::SetText(LPCTSTR pText)
{
	CString Tmp(pText), Str0= Tmp, qqq;
	int Find= 0, Lines= 1, cx= 0, len= 0, width, FndTmp= -1, skipedChars;
	CSize sz;
	CDC* pDC = GetDC();
	CRect rect;
	GetClientRect(&rect);
	width= rect.Width();
	Find= 0;
	while(Str0[Find] == ' ')
		Find++;
	if(Find)
		Str0= Str0.Mid(Find);
	while((Find= Str0.Find(' ')) > -1 || (FndTmp= Str0.Find('\n')) > -1){
		if(Find == -1){
			Find= FndTmp;
		}
		qqq= Str0.Left(Find);
		sz = pDC->GetTextExtent(qqq);
		skipedChars= 0;
		if(FndTmp == -1 && (FndTmp= qqq.Find('\n')) == -1 && width > sz.cx+cx){
			cx += sz.cx;
			len += Find;
			sz = pDC->GetTextExtent(" ");
			do{
				cx += sz.cx;
				len++;
				Find++;
			}while(Str0[Find] == ' ');
			Str0= Str0.Mid(Find);
		}else if(FndTmp != -1){
			qqq= Str0.Left(FndTmp);
			sz = pDC->GetTextExtent(qqq);
			if(width > sz.cx+cx){
				Find= FndTmp;
				len += Find;
				do{
					len++;
					Find++;
				}while(((LPCTSTR)Str0)[Find] && Str0[Find] == ' ' && ++skipedChars);
			}else
				FndTmp= Find -1;
		}else
			FndTmp= Find -1;
		if(FndTmp+1+skipedChars == Find){
			FndTmp= -1;
			Lines++;
			if (len==0)
				len = Find;
			qqq= Tmp.Left(len);
			if(((LPCTSTR)qqq)[len-1] == '\x0a')
				((char*)(LPCTSTR)qqq)[len-1]= ' ';
			LocalAddString(qqq);
			while(((LPCTSTR)Tmp)[len] && Tmp[len] == ' '){
				len++;
			}
			Tmp= Tmp.Mid(len);
			len= Tmp.GetLength();
			Str0= Tmp;
			len= cx= 0;
		}
	}
	if(Tmp != "")
		LocalAddString(Tmp);
	else
		Lines--;
	InitStorage(Lines, 1);
}
/////////////////////////////////////////////////////////////////////////////
// CScrollinfo message handlers

