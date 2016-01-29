#include "stdafx.h"
#include "AnimateDlgIcon.h"

CAnimateDlgIcon::CAnimateDlgIcon()
{
	m_iImageCounter = -1;
	m_iMaxNoOfImages = -99;
	m_imgList.m_hImageList = NULL;
}

CAnimateDlgIcon::~CAnimateDlgIcon()
{
	DestroyIcon( hPrevIcon );
}

BOOL CAnimateDlgIcon::SetImageList( int IDOfImgListResource, int numberOfImages, COLORREF transparentColor )
{
	if ( numberOfImages <= 0 )
		return FALSE;
	m_iMaxNoOfImages = numberOfImages;
	m_imgList.Detach(); // GARANT_MSVC7: debug assertion failed
	VERIFY( m_imgList.Create( IDOfImgListResource, 16, 1, transparentColor ));
	return TRUE;
}

BOOL CAnimateDlgIcon::ShowNextImage()
{
	if( m_imgList.m_hImageList == NULL )
		return FALSE;

	m_iImageCounter++;
	if( m_iImageCounter >= m_iMaxNoOfImages )
		m_iImageCounter =0;

	hIcon = m_imgList.ExtractIcon( m_iImageCounter );
	HICON hPrevIcon = (HICON) AfxGetMainWnd()->SetIcon( hIcon,FALSE );
	DestroyIcon( hPrevIcon );
	return TRUE;
}

HICON CAnimateDlgIcon::GetNextImage() {
	if (m_imgList.m_hImageList == NULL) { 
		return NULL;
	}
	
	m_iImageCounter++;
	
	if (m_iImageCounter >= m_iMaxNoOfImages) {
		m_iImageCounter = 0;
	}
	
	hIcon = m_imgList.ExtractIcon (m_iImageCounter);
	return hIcon;
}
