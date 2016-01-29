// AnimateDlgIcon.h : interface of the CAnimateDlgIcon class
// written by Rajesh Parikh
// email : rparikh@usa.net
// Not protected by any copyright, use it freely
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_ANIMATEDLGICON_H__47E058AD_6F69_11D2_B59C_86DD54033006__INCLUDED_)
#define      AFX_ANIMATEDLGICON_H__47E058AD_6F69_11D2_B59C_86DD54033006__INCLUDED_

class CAnimateDlgIcon
{
protected :
	CImageList  m_imgList;
	int m_iImageCounter;
	int m_iMaxNoOfImages;
	HICON hIcon;
	HICON hPrevIcon ;
		
public:
	CAnimateDlgIcon();
	~CAnimateDlgIcon();
	BOOL SetImageList(int IDOfImgListResource,int numberOfImages,COLORREF transparentColor);
	BOOL ShowNextImage();
	HICON GetNextImage();
};

#endif //#define AFX_ANIMATEDLGICON_H__47E058AD_6F69_11D2_B59C_86DD54033006__INCLUDED_