// selcttreectrl.cpp : implementation file
//

#include "stdafx.h"
#include "recode.h"
#include "TestBreeder32.h"
#include "selcttreectrl.h"
#include "TestBreeder32Dlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSelctTreeCtrl

CSelctTreeCtrl::CSelctTreeCtrl()
{
	pDlg= NULL;
}

CSelctTreeCtrl::~CSelctTreeCtrl()
{
}


BEGIN_MESSAGE_MAP(CSelctTreeCtrl, CTreeCtrl)
	//{{AFX_MSG_MAP(CSelctTreeCtrl)
	ON_NOTIFY_REFLECT(TVN_KEYDOWN, OnKeydown)
	ON_NOTIFY_REFLECT(NM_RCLICK, OnRclick)
	ON_NOTIFY_REFLECT(NM_CLICK, OnClick)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

extern "C" char *GetBasedExtFileName( char *, int);

int isLastFile(LPPF_PARAM pPrm)
{
	int indx;
	if((indx= IsNextTom(pPrm))){
		GetBasedExtFileName(pPrm->FileName, indx);
		if((indx= open(pPrm->FileName, O_RDONLY)) == -1){
			GetBasedExtFileName(pPrm->FileName, 0);
			pPrm->currentDisk= 0;
			return 1;
		}
		close(indx);
	}
	return 0;
}

void preCheckMultiDisk(Base *p_chkBase)
{
	p_chkBase->strFile->m_readed.page
		= p_chkBase->strFile->LastPage;

	if(p_chkBase->strFile->IsPacked()){
		if(!(p_chkBase->strFile->m_mode & 0x1000)){
			p_chkBase->strFile->m_readed.page
				= p_chkBase->strFile->pageOffs
						[p_chkBase->strFile->LastPage-1]
					/
				p_chkBase->strFile->PageSize;
		}else{
				p_chkBase->strFile->m_readed.page= 
	(long)((((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)(5 * (p_chkBase->strFile->LastPage-1) + (char*)p_chkBase->strFile->pageOffs))
			/ (ACE_UINT64)p_chkBase->strFile->PageSize);
		}
	}

	p_chkBase->keyFile->m_readed.page
		= p_chkBase->keyFile->LastPage;

	if(p_chkBase->keyFile->IsPacked()){
		if(!(p_chkBase->keyFile->m_mode & 0x1000)){
			p_chkBase->keyFile->m_readed.page
				= p_chkBase->keyFile->pageOffs
						[p_chkBase->keyFile->LastPage-1]
					/
				p_chkBase->keyFile->PageSize;
		}else{
				p_chkBase->keyFile->m_readed.page= 
	(long)((((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)(5 * (p_chkBase->keyFile->LastPage-1) + (char*)p_chkBase->keyFile->pageOffs))
			/ (ACE_UINT64)p_chkBase->keyFile->PageSize);
		}
	}
	p_chkBase->textFile->m_readed.page
		= p_chkBase->textFile->LastPage;

	if(p_chkBase->textFile->IsPacked())
		p_chkBase->textFile->m_readed.page
			= p_chkBase->textFile->pageOffs
					[p_chkBase->textFile->LastPage-1]
				/
			  p_chkBase->textFile->PageSize;
}

void CSelctTreeCtrl::SelectOrUnselect(HTREEITEM hTreeItem, BOOL bAddSel)
{
	int img, simg;
	GetItemImage(hTreeItem, img, simg);
	if(pDlg != NULL && (img == 2 || img == 3)){
		int baseIndx= (int)GetItemData(hTreeItem) / MAX_HDD_COUNT,
			segmIndx= ((int)GetItemData(hTreeItem)-1) % MAX_HDD_COUNT,
			*pCurrentWeight= pDlg->ppHDDs[baseIndx].currentWeight,
			allWeight= 0, ii= 0, secondExsptn= FALSE, split= 0;

		preCheckMultiDisk(pDlg->ppHDDs[baseIndx].pHDD);

		if(img == 2){
			SetItemImage(hTreeItem, 3, 3);
		}else{
			SetItemImage(hTreeItem, 2, 2);
		}
		pCurrentWeight[segmIndx*2] *= -1;
		while(*pCurrentWeight){
			if(*pCurrentWeight > 0){
				allWeight += pCurrentWeight[1];
				ii++;
			}else
				split++;
			pCurrentWeight += 2;
		}
		HTREEITEM hPrnt= GetParentItem(hTreeItem);
		if(split){
			SetItemImage(hPrnt, 4, 4);
			CString tmpStr;
			tmpStr.Format(pDlg->szFrmtU, pDlg->szUnk);
			pDlg->m_Msg1.SetWindowText(tmpStr);
		}else{
			SetItemImage(hPrnt, 1, 1);
			CString tmpStr;
			if(pDlg->ppHDDs[baseIndx].pHDD->keyFile->IsPacked()
									|| pDlg->ppHDDs[baseIndx].pHDD->strFile->IsPacked()
									|| pDlg->ppHDDs[baseIndx].pHDD->textFile->IsPacked()){
			tmpStr.Format(pDlg->szFrmtN, (pDlg->ppHDDs[baseIndx].pHDD->keyFile->GetFileSizeInKbytes()
									+ pDlg->ppHDDs[baseIndx].pHDD->strFile->GetFileSizeInKbytes()
										+ pDlg->ppHDDs[baseIndx].pHDD->textFile->GetFileSizeInKbytes()) / 1024,
										(pDlg->ppHDDs[baseIndx].pHDD->keyFile->GetFileSizeInKbytes(pDlg->ppHDDs[baseIndx].pHDD->keyFile->IsPacked())
									+ pDlg->ppHDDs[baseIndx].pHDD->strFile->GetFileSizeInKbytes(pDlg->ppHDDs[baseIndx].pHDD->strFile->IsPacked())
										+ pDlg->ppHDDs[baseIndx].pHDD->textFile->GetFileSizeInKbytes(pDlg->ppHDDs[baseIndx].pHDD->textFile->IsPacked())) / 1024);
			}else
			tmpStr.Format(pDlg->szFrmt, (pDlg->ppHDDs[baseIndx].pHDD->keyFile->GetFileSizeInKbytes()
									+ pDlg->ppHDDs[baseIndx].pHDD->strFile->GetFileSizeInKbytes()
										+ pDlg->ppHDDs[baseIndx].pHDD->textFile->GetFileSizeInKbytes()) / 1024);
			pDlg->m_Msg1.SetWindowText(tmpStr);
		}
		if(!ii || 
	(
		(secondExsptn= isLastFile(&pDlg->ppHDDs[baseIndx].pHDD->textFile->m_readed))
			||
		(secondExsptn= isLastFile(&pDlg->ppHDDs[baseIndx].pHDD->strFile->m_readed))
			||
		(secondExsptn= isLastFile(&pDlg->ppHDDs[baseIndx].pHDD->keyFile->m_readed))
	)
			)
		{
			pDlg->m_BttnNext.EnableWindow(FALSE);
			SelectItem(0);
			pDlg->BeepWarning();
			if(secondExsptn){
				*pDlg->pSelctMesgs= pDlg->pSelctMesgs[4];
			}else{
				*pDlg->pSelctMesgs= pDlg->pSelctMesgs[2];
			}
			pDlg->m_ProcessMsg.SetWindowText(*pDlg->pSelctMesgs);
			Sleep(3000);
			pDlg->BeepOk();
			*pDlg->pSelctMesgs= pDlg->pSelctMesgs[1];
			pDlg->ppHDDs[baseIndx].currentWeight[segmIndx*2] *= -1;
			if(img == 2){
				SetItemImage(hTreeItem, 2, 2);
			}else{
				SetItemImage(hTreeItem, 3, 3);
			}
			if(bAddSel)
				SelectItem(hTreeItem);
			pDlg->m_BttnNext.EnableWindow();
		} else {
			for (ii= (int)pDlg->ppHDDs[baseIndx].bwcount; ii--;) {
				BaseWeight& cur = pDlg->ppHDDs [baseIndx].bws [ii];

				if (cur.min <= (unsigned long)allWeight	&& cur.max >= (unsigned long)allWeight) {
					if (get_app ()->get_rc_lang () == rl_Eng) {
						pDlg->SetItemTextAsUnknwn (hPrnt, cur.nameEng);
					} else {
						pDlg->SetItemTextAsUnknwn (hPrnt, cur.name);
					}
					break;
				}
			}

			if (ii == -1) {
				pDlg->SetItemTextAsUnknwn (hPrnt);
			}
		}
	}
}

/////////////////////////////////////////////////////////////////////////////
// CSelctTreeCtrl message handlers

void CSelctTreeCtrl::OnKeydown(NMHDR* pNMHDR, LRESULT* pResult) 
{
	TV_KEYDOWN* pTVKeyDown = (TV_KEYDOWN*)pNMHDR;
	// TODO: Add your control notification handler code here
	if(pTVKeyDown->wVKey == VK_INSERT || pTVKeyDown->wVKey == VK_SPACE)
		SelectOrUnselect(GetSelectedItem(), TRUE);

	*pResult = 0;
}

void CSelctTreeCtrl::OnMyClick(NMHDR* pNMHDR, LRESULT* pResult, int left)
{
	POINT pointScreen, pointLVClient;
	DWORD dwPos = GetMessagePos();

	pointScreen.x = LOWORD (dwPos);
	pointScreen.y = HIWORD (dwPos);

	pointLVClient = pointScreen;

	// Convert the point from screen to client coordinates,
	// relative to the treeview
	ScreenToClient (&pointLVClient);

	UINT uFlags;
	HTREEITEM hTreeSelItem= HitTest(pointLVClient, &uFlags);
	if(hTreeSelItem){
		if(!left)
			SelectItem(hTreeSelItem);
		else if(pointLVClient.x >= 38 && pointLVClient.x <= 50)
			SelectOrUnselect(hTreeSelItem);
	}
}

void CSelctTreeCtrl::OnRclick(NMHDR* pNMHDR, LRESULT* pResult) 
{
	OnMyClick(pNMHDR, pResult);
}

void CSelctTreeCtrl::OnClick(NMHDR* pNMHDR, LRESULT* pResult) 
{
	OnMyClick(pNMHDR, pResult, 1);
	
	*pResult = 0;
}
