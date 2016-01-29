////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Controls/CImageListEx.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Controls::CImageListEx
//
// ����������� ImageList, ��������� ����������� ������ ����������� �� ��������� ������-��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/Controls/CImageListEx.h"
// by <<uses>> dependencies
#include "ximage.h"

namespace WinGUI {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// �����������
CImageListEx::CImageListEx ()
//#UC START# *469C8A0F03D8_BASE_INIT*
: m_cx (-1), m_cy (-1)
//#UC END# *469C8A0F03D8_BASE_INIT*
{
	//#UC START# *469C8A0F03D8_BODY*
	//#UC END# *469C8A0F03D8_BODY*
}

CImageListEx::~CImageListEx () {
	//#UC START# *46960B1401F4_DESTR_BODY*
	//#UC END# *46960B1401F4_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ��������� ����������� � ������.
// path - ���� � ����� � ������������
// � ������ ��������� ���������� ���������� ������ ����������� � ������, ����� ��������� -1
int CImageListEx::add (const std::string& path) {
	//#UC START# *46960C7C0138*
	
	ImagePathToIndex::const_iterator it = m_image_path_to_index.find (path);
	if (it != m_image_path_to_index.end ()) {
		return it->second;
	} else if (ACE_OS::access(path.c_str (), F_OK) != -1) { //file exists		
		CxImage image;
		if (
			image.Load (path.c_str ())
			&& image.IsValid ()
		) {
			int idx = -1;
			/*RGBQUAD rgbquad_mask = image.GetPixelColor (0, 0, false);
			COLORREF rgb_mask = RGB (
				rgbquad_mask.rgbRed, rgbquad_mask.rgbGreen, rgbquad_mask.rgbBlue
			);*/
			HBITMAP bitmap = image.MakeBitmap ();
			if (bitmap != NULL) {
				idx = this->add_image (bitmap, 1);
				if (idx != -1) {
					m_image_path_to_index.insert (ImagePathToIndex::value_type (path, idx));
				}				
				DeleteObject (bitmap);
			}
			return idx;
		}
	}
	return -1;
	//#UC END# *46960C7C0138*
}

// ��������� � ������ ��������
// ���������� ������ ������ ����������� �������� � ������
int CImageListEx::add_image (HBITMAP image, int count) {
	//#UC START# *469C8E2301C5*
	class _local {
	public:
		static void fill_dc (HDC dc, const COLORREF& row_color) {
			HBRUSH backBrush= (HBRUSH)(row_color);				
			// Save old brush
			HBRUSH pOldBrush = (HBRUSH)::SelectObject(dc, backBrush);
			
			RECT rect;
			::GetClipBox(dc, &rect);     // Erase the area needed
			
			//paint the given rectangle using the brush that is currently selected 
			//into the specified device context
			::PatBlt(dc, rect.left, rect.top, abs(rect.left - rect.right),abs(rect.top-rect.bottom ),PATCOPY);

			//Select back the old brush
			::SelectObject(dc,pOldBrush);
			DeleteObject (backBrush);
		}
		static HBITMAP add_rows (CBitmap* src, const long row_count,  const COLORREF& row_color) {	
			HBITMAP ret = NULL;
			if (src) {
				HDC dc = ::GetDC(NULL);
				BITMAP bmp = {0};
				src->GetBitmap (&bmp);
				const long width = bmp.bmWidth; 
				const long height = bmp.bmHeight + row_count;

				HDC src_dc = CreateCompatibleDC (dc);
				HGDIOBJ old_obj = SelectObject (src_dc, (HBITMAP)*src);

				HDC dst_dc = CreateCompatibleDC(dc);
				HGDIOBJ objReserve;
				ret = CreateCompatibleBitmap(src_dc, width, height);
				objReserve = SelectObject(dst_dc, ret);
				fill_dc (dst_dc, row_color);
				BitBlt (dst_dc, 0, 0, bmp.bmWidth, bmp.bmHeight, src_dc, 0, 0, SRCCOPY);
				
				SelectObject (dst_dc, objReserve);
				SelectObject (src_dc, old_obj);

				DeleteDC (dst_dc);
				DeleteDC (src_dc);
				ReleaseDC (NULL, dc);
			}
			return ret;
		}
	};
	int idx = -1;
	CBitmap* bmp = CBitmap::FromHandle (image);
	if (bmp) {					
		BITMAP bmBitmap;
		bmp->GetBitmap (&bmBitmap);
		RGBTRIPLE* rgb = (RGBTRIPLE*)(bmBitmap.bmBits);
		COLORREF rgb_mask = RGB(rgb[0].rgbtRed, rgb[0].rgbtGreen, rgb[0].rgbtBlue);
		HBITMAP new_bitmap = NULL;
		if (m_cy > 0 && bmBitmap.bmHeight < m_cy) {
			new_bitmap = _local::add_rows (bmp, m_cy - bmBitmap.bmHeight, rgb_mask);
			if (new_bitmap != NULL) {				
				if (count > 1) {
					//�������� �� ������� �������� �� ���������
					CxImage full_img;
					if (full_img.CreateFromHBITMAP (new_bitmap)) {
						for (int i = 0; i < count; ++i) {
							long cx = m_cx != -1 ? m_cx : 16;
							long cy = m_cy != -1 ? m_cy : 16;
							CxImage one_image (m_cx, m_cy, full_img.GetBpp ());
							long left = i*cx;
							long right = left + cx;
							full_img.Crop (left, 0, right, cy, &one_image);
							HBITMAP bitmap = one_image.MakeBitmap ();
							if (bitmap != NULL) {
								CBitmap* bmp = CBitmap::FromHandle (bitmap);
								idx = this->Add (bmp, rgb_mask);			
								bmp->Detach ();
								DeleteObject (bitmap);
							}
						}
					}
				} else {
					CBitmap* new_bmp = CBitmap::FromHandle (new_bitmap);
					idx = this->Add (new_bmp, rgb_mask);
					new_bmp->Detach();
				}				
				DeleteObject (new_bitmap);
			}
		} else {
			idx = this->Add (bmp, rgb_mask);
		}
		
		bmp->Detach();				
	}
	return idx;
	//#UC END# *469C8E2301C5*
}

// ������ Create �� MSDN:
// cx - ������ ������� �����������
// cy - ������ ������� �����������
// flags - �����, �������� ���
// initial - ������� ����������� ���� ������ �������
// grow - �� ������� ������ ������ ��� ���������� �����������
void CImageListEx::create (int cx, int cy, unsigned int flags, int initial, int grow) {
	//#UC START# *469C88D80109*
	m_cx = cx;
	m_cy = cy;
	this->Create (cx, cy, flags, initial, grow);
	//#UC END# *469C88D80109*
}

// ������� ImageList, ������� ����
void CImageListEx::delete_list () {
	//#UC START# *4696256F031C*
	m_cx = -1;
	m_cy = -1;
	m_image_path_to_index.clear ();
	this->DeleteImageList();
	//#UC END# *4696256F031C*
}

// ���������� ������ �����������, ���������������� ���� (path)
int CImageListEx::get_image_index (const std::string& path) {
	//#UC START# *46960D0B034B*
	ImagePathToIndex::const_iterator it = m_image_path_to_index.find (path);
	if (it != m_image_path_to_index.end ()) {
		return it->second;
	} else {
		return this->add (path);
	}
	return -1;
	//#UC END# *46960D0B034B*
}

// ������� ����������� �� ������
void CImageListEx::remove_images () {
	//#UC START# *46976C1800DA*
	for (int i = 0; i < this->GetImageCount (); ++i) {
		this->Remove (i);
	}
	m_image_path_to_index.clear ();
	//#UC END# *46976C1800DA*
}

} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

