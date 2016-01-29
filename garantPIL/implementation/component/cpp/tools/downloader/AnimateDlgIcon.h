//
// AnimateDlgIcon.h : interface of the CAnimateDlgIcon class
//
 
#if !defined (AFX_ANIMATEDLGICON_H__47E058AD_6F69_11D2_B59C_86DD54033006__INCLUDED_)
#define AFX_ANIMATEDLGICON_H__47E058AD_6F69_11D2_B59C_86DD54033006__INCLUDED_

class CAnimateDlgIcon {
public:
	CAnimateDlgIcon ();
	~CAnimateDlgIcon ();

	BOOL SetImageList (int IDOfImgListResource, int numberOfImages, COLORREF transparentColor);

	BOOL ShowNextImage ();
	HICON GetNextImage ();

private:
	CImageList m_imgList;

	HICON hIcon;
	HICON hPrevIcon;

	int m_iImageCounter;
	int m_iMaxNoOfImages;
};

#endif //#define AFX_ANIMATEDLGICON_H__47E058AD_6F69_11D2_B59C_86DD54033006__INCLUDED_