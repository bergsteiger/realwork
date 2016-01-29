////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseDiagramDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseDiagramDumper
//
// Дампер для розовских диаграмм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseDiagramDumper.h"
// by <<uses>> dependencies
#include "xmemfile.h"
#include "ximage.h"
#include "ximawmf.h"
#include "xiofile.h"
#include "MDProcess/MDAModel/RoseDumpers/MDAModelParams.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571DFB400FA_CUSTOM_INCLUDES*
#include <sstream>
#include "shared/GCL/os/FileOp.h"
#include <boost/lexical_cast.hpp>
#include <boost/functional/hash/hash.hpp>
//#UC END# *4571DFB400FA_CUSTOM_INCLUDES*


//#UC START# *4571DFB400FA*
const int DEFAULT_HORZ_RES = 1280;
const int DEFAULT_VERT_RES = 1024;

const int get_horz_res () {
	int res = -1;
	HDC dc = GetDC (0);
	if (dc) {
		res = GetDeviceCaps (dc, HORZRES);
		ReleaseDC (0, dc);
	}
	return res;
}

const int get_vert_res () {
	int res = -1;
	HDC dc = GetDC (0);
	if (dc) {
		res = GetDeviceCaps (dc, VERTRES);
		ReleaseDC (0, dc);
	}
	return res;
}
/*CxImage* resize_emf (const std::string& emf_path, const double scale) {
	//Declartions
	HENHMETAFILE original_hemf;
	ENHMETAHEADER original_emh;
		
	original_hemf = ::GetEnhMetaFile(emf_path.c_str ());
		
	// Get the header from the enhanced metafile.
	ZeroMemory( &original_emh, sizeof(ENHMETAHEADER) );
	original_emh.nSize = sizeof(ENHMETAHEADER);
	if( GetEnhMetaFileHeader( original_hemf, sizeof( ENHMETAHEADER ), &original_emh ) == 0 )
	{
		DeleteEnhMetaFile( original_hemf );
		return 0;
	}	
	long left = (long)((double)original_emh.rclFrame.left*scale);
	long top = (long)((double)original_emh.rclFrame.top*scale);
	long right = (long)((double)original_emh.rclFrame.right*scale);
	long bottom = (long)((double)original_emh.rclFrame.bottom*scale);
	
	
	left = (long)((double)original_emh.rclBounds.left*scale);
	top = (long)((double)original_emh.rclBounds.top*scale);
	right = (long)((double)original_emh.rclBounds.right*scale);
	bottom = (long)((double)original_emh.rclBounds.bottom*scale);
	
	CRect rect (0, 0, right - left, bottom - top);	
	
	HDC dc = ::GetDC (0);
	HDC memDC=::CreateCompatibleDC (dc);
	HBITMAP bitmap = ::CreateCompatibleBitmap (dc, rect.Width (), rect.Height ());
	::SelectObject(memDC, bitmap);

	PlayEnhMetaFile (memDC, original_hemf, &rect);
	DeleteEnhMetaFile( original_hemf );
	
	Core::Aptr<CxImage> image = new CxImage ();
	image->CreateFromHBITMAP (bitmap);
	
	DeleteObject (bitmap);
	DeleteDC (memDC);
	::ReleaseDC(0, dc);
	return image.forget ();
}*/

const std::string resize_emf (const std::string& emf_path, const double scale) {
	//Declartions
	HENHMETAFILE original_hemf;
	ENHMETAHEADER original_emh;
		
	//Get the Handle from the enhanced metafile
	original_hemf = ::GetEnhMetaFile(emf_path.c_str ());
		
	// Get the header from the enhanced metafile.
	ZeroMemory( &original_emh, sizeof(ENHMETAHEADER) );
	original_emh.nSize = sizeof(ENHMETAHEADER);
	if( GetEnhMetaFileHeader( original_hemf, sizeof( ENHMETAHEADER ), &original_emh ) == 0 )
	{
		DeleteEnhMetaFile( original_hemf );
		return emf_path;
	}	
	long left = (long)((double)original_emh.rclFrame.left*scale);
	long top = (long)((double)original_emh.rclFrame.top*scale);
	long right = (long)((double)original_emh.rclFrame.right*scale);
	long bottom = (long)((double)original_emh.rclFrame.bottom*scale);
	
	std::string new_emf_path = emf_path;
	std::string::size_type pos = new_emf_path.find_first_of (".");
	if (pos != std::string::npos) {
		new_emf_path = new_emf_path.substr (0, pos) + "_z.emf";
	}

	CRect rect (left, top, right, bottom);
	HDC emf_dc = CreateEnhMetaFile (NULL, new_emf_path.c_str (), NULL, NULL);

	SelectObject (emf_dc, GetStockObject (WHITE_PEN));

	left = (long)((double)original_emh.rclBounds.left*scale);
	top = (long)((double)original_emh.rclBounds.top*scale);
	right = (long)((double)original_emh.rclBounds.right*scale);
	bottom = (long)((double)original_emh.rclBounds.bottom*scale);
	rect.SetRect (left, top, right, bottom);

	Rectangle (emf_dc, left, top, right, bottom);
	
	PlayEnhMetaFile (emf_dc, original_hemf, &rect);
//	PlayEnhMetaFile (emf_dc, original_hemf, &rect);

	DeleteEnhMetaFile( original_hemf );
	
	HENHMETAFILE new_hemf = CloseEnhMetaFile (emf_dc);
	ZeroMemory( &original_emh, sizeof(ENHMETAHEADER) );
	original_emh.nSize = sizeof(ENHMETAHEADER);
	GetEnhMetaFileHeader( new_hemf, sizeof( ENHMETAHEADER ), &original_emh );
	DeleteEnhMetaFile( new_hemf );

	return new_emf_path;
}

bool RoseDiagramDumper::operator == (const AbstractDumperBase& c) const {
	bool ret = false;
	const RoseDiagramDumper* rdd = dynamic_cast<const RoseDiagramDumper*>(&c);
	if (rdd) ret = (get_rose_element_uid(this->m_diag) == get_rose_element_uid(rdd->m_diag));
	return ret;
}

///////////////////////////////////////////////////////////////////////
// abstracte base - method implementation
///////////////////////////////////////////////////////////////////////

void RoseDiagramDumper::dump (std::ostream* output) const {	
	
}
//#UC END# *4571DFB400FA*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// метод дампит всю информацию, связанную с view (элементом на диграмме) в
// поток stream
void RoseDiagramDumper::dump_item_view (IRoseItemViewPtr view, std::ostream& stream) {
	//#UC START# *466A480201C5*
	if (view) {		
		stream << "View name: " << (const char*)view->Name << std::endl;
		
		//short stereotypedisplay = view->StereotypeDisplay;
		//stream << "StereotypeDisplay:" << stereotypedisplay << std::endl;
		stream << "Color in RGB: " 
			<< view->FillColor->Red 
			<< ", " 
			<< view->FillColor->Green 
			<< ", " 
			<< view->FillColor->Blue
			<< ", transparent = " << view->FillColor->Transparent
			<< std::endl;
		if (view->IsClass ("NoteView")) {
			IRoseNoteViewPtr note = view;
			stream << "Note view text: " << (const char*) note->Text << std::endl;
		}		

		IRoseItemViewCollectionPtr sub_views = view->SubViews;
		short sub_views_count = sub_views->Count;
		for (short j = 1; j <= sub_views_count; ++j) {
			IRoseItemViewPtr sub_view = sub_views->GetAt (j);
			dump_item_view (sub_view, stream);
		}		
	}
	//#UC END# *466A480201C5*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// ctor
RoseDiagramDumper::RoseDiagramDumper (IRoseDiagramPtr diag)
//#UC START# *465E53F5005D_BASE_INIT*
	: m_diag (diag)	
//#UC END# *465E53F5005D_BASE_INIT*
{
	//#UC START# *465E53F5005D_BODY*
	try {
		m_model_class_str = (char*)m_diag->IdentifyClass ();
		m_model_stereotype_id = RoseHelper::get_gen_stereotype(m_diag);
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseAbstractOperationDumper ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseAbstractOperationDumper ctor");
	}
	//#UC END# *465E53F5005D_BODY*
}

RoseDiagramDumper::~RoseDiagramDumper () {
	//#UC START# *4571DFB400FA_DESTR_BODY*
	//#UC END# *4571DFB400FA_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// сохраняет диграмму в виде картинке, с зум-фактором = 100 и выполняет при необходимости ресайз,
// чтобы картинка уместилась по ширине в 1200 пикселей
CxImage* RoseDiagramDumper::create_image () const {
	//#UC START# *46639EA600BB*
	IRoseItemViewCollectionPtr views = m_diag->ItemViews;
	short views_count = views->Count;
	
	if (views_count == 0) {
		return 0;
	}
	std::string wmf_temp_file = "~";
	wmf_temp_file += this->get_model_unique_id_str ();
	std::string wmf_temp_file_zoomed = wmf_temp_file + "_z";
	wmf_temp_file += ".emf";
	wmf_temp_file_zoomed += ".emf";
		
	short zoom = m_diag->ZoomFactor;
	
	//если WMF уже есть удаляем его
	if (ACE_OS::access(wmf_temp_file.c_str (), F_OK) != -1) {
		ACE_OS::unlink (wmf_temp_file.c_str ());
	}
	m_diag->RenderEnhanced (wmf_temp_file.c_str ());
	m_diag->RenderEnhanced (wmf_temp_file.c_str ());
	
	if (ACE_OS::access(wmf_temp_file.c_str (), F_OK) == -1) {
		LOG_E(("Rose haven't rendered the diagram to file: ", wmf_temp_file.c_str ()));
		return 0;
	}

	long original_w;
	long original_h;
	{
		CxImage temp_image;
		temp_image.Load (wmf_temp_file.c_str (), CXIMAGE_FORMAT_WMF);
		original_w = temp_image.GetWidth ();
		original_h = temp_image.GetHeight ();	
	}
	
	long wmf_w = original_w;
	long wmf_h = original_h;	
		
	double scale_factor = 1.0;
	static const unsigned long c_maximum_width = 1200;

	if (zoom != 100 && wmf_w < c_maximum_width) {
		scale_factor = (double)(100.0/zoom);
		wmf_w = (long)ceil ((double)(original_w*scale_factor));
	}
		
	if (wmf_w > c_maximum_width) {		
		scale_factor *= ((double)c_maximum_width/wmf_w);
	}
		
	original_w = static_cast<long> (original_w*scale_factor);
	original_h = static_cast<long> (original_h*scale_factor);
		
	Core::Aptr<CxImageWMF> result_image = new CxImageWMF ();
	{
		CxIOFile file;	
		if (file.Open (wmf_temp_file.c_str (), "rb")) {
			if (!result_image->Decode (&file, original_w, original_h)) {
				LOG_E (("Can't decode WMF image[h:%d, w:%d]: %s", wmf_temp_file.c_str (), original_h, original_w));
			}
			file.Close ();
		} else {
			if (ACE_OS::access(wmf_temp_file.c_str (), F_OK) == -1) {
				LOG_E (("Can't open image from file: %s", wmf_temp_file.c_str ()));
			} else {
				LOG_E (("Can't open image from file: %s, file doesn't exist", wmf_temp_file.c_str ()));
			}
		}

	}
	
	CFile::Remove (wmf_temp_file.c_str ());
	return result_image.forget ();
	//#UC END# *46639EA600BB*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает имя
const std::string RoseDiagramDumper::get_name_str () const {
	//#UC START# *466554D9006D_4571DFB400FA*
	std::string ret = (char*)m_diag->Name;
	return ret;
	//#UC END# *466554D9006D_4571DFB400FA*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// метод дампит диаграмму, возвращает диаграму в виде куска памяти.
// items - коллекция элементов даграммы, для формирования навигационной мапы
// diagram_hash - хэш диаграммы, высчитывается на основе всех view - элементов на диграмме
CxMemFile* RoseDiagramDumper::dump_diagram (
	AbstractDumperBase::DiagramItemCollection& items
	, std::string& diagram_hash
) const {
	//#UC START# *4642AC6B0138_4571DFB400FA*
	static const int DEFAULT_HORZ_RES = 1280;
	static const int DEFAULT_HORZ_RES_HD = 1920;

	static const int DEFAULT_VERT_RES = 1024;
	static const int DEFAULT_VERT_RES_HD = 1200;
	
	int horz_res = GetSystemMetrics (SM_CXSCREEN);
	int vert_res = GetSystemMetrics (SM_CYSCREEN);
	
	/*
	if (
		(horz_res != DEFAULT_HORZ_RES && horz_res != DEFAULT_HORZ_RES_HD) 
		|| (vert_res != DEFAULT_VERT_RES && vert_res != DEFAULT_VERT_RES_HD)
	) {
		std::string mess ("Can't dump diagram, because your primary display resolution doesn't equal ");
		mess += boost::lexical_cast<std::string> (DEFAULT_HORZ_RES);
		mess += "x";
		mess += boost::lexical_cast<std::string> (DEFAULT_VERT_RES);
		mess += "(or " + boost::lexical_cast<std::string> (DEFAULT_HORZ_RES_HD);
		mess += "x";
		mess += boost::lexical_cast<std::string> (DEFAULT_VERT_RES_HD);
		mess += "). On different display resolution, Rose dump different element's coords";

		GenSupport::ErrorManagerFactory::get ().fatal_error (this, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);
	}
	*/

	IRoseItemViewCollectionPtr views = m_diag->ItemViews;
	short views_count = views->Count;
	
	Core::Aptr<CxImage> image = this->create_image ();
	Core::Aptr<CxMemFile> file;

	
	if (
		image.is_nil () == false
		&& image->IsValid ()
	) {
		image->SetJpegQuality(100);
		file = new CxMemFile ();
		file->Open ();
		if (!image->Encode (file.ptr (), CXIMAGE_FORMAT_JPG)) {			
			GenSupport::LogManagerFactory::get ().log_warning ("Can't convert wmf to jpg");
			LOG_W (("Can't convert wmf to jpg"));
			return 0;
		}		

		image->Save ("debug.jpg", CXIMAGE_FORMAT_JPG);
		image->Load ("debug.jpg", CXIMAGE_FORMAT_JPG);
		long image_min_x = INT_MAX;
		long image_min_y = INT_MAX;
		long image_max_x = INT_MIN;
		long image_max_y = INT_MIN;
		
		RGBQUAD bk_color = image->GetPixelColor (0, 0, false);
		int i_bk_color = RGB2GRAY(bk_color.rgbRed, bk_color.rgbGreen, bk_color.rgbBlue);
		long img_w = (long)image->GetWidth ();
		long img_h = (long)image->GetHeight ();
		//определяем границы квадрата, в который вписывается диграмма			
		for (long x = 0; x < img_w; ++x) {
			for (long y = 0; y < img_h; ++y) {
				long fliped_y = img_h - y - 1;
				RGBQUAD pixel_color = image->GetPixelColor (x, fliped_y, false);
				int i_pixel_color = RGB2GRAY(pixel_color.rgbRed, pixel_color.rgbGreen, pixel_color.rgbBlue);
				if (
					abs (i_pixel_color - i_bk_color) > 5
					/*pixel_color.rgbBlue != bk_color.rgbBlue
					&& pixel_color.rgbGreen != bk_color.rgbGreen
					&& pixel_color.rgbRed != bk_color.rgbRed*/
				) {
					
					image_min_x = std::min (image_min_x, x);
					image_min_y = std::min (image_min_y, y);

					image_max_x = std::max (image_max_x, x);
					image_max_y = std::max (image_max_y, y);
				}
			}			
		}

		long min_x = INT_MAX;
		long min_y = INT_MAX;
		long max_x = INT_MIN;
		long max_y = INT_MIN;
		
		/*std::string diagram_contents = m_diag->GetPropertyValue(TOOL_NAME, "DiagramContents");		
		m_diagram_content.load (diagram_contents);*/

		std::ostringstream hash;
		for (short i = 1; i <= views_count; ++i) {
			IRoseItemViewPtr view = views->GetAt (i);
			
			dump_item_view (view, hash);

			int x = view->XPosition;
			int y = view->YPosition;
			int width = view->GetWidth ();
			int height = view->GetHeight ();
							
			AbstractDumperBase::DiagramItem diag_item;
			
			long t_min_x = x - (int)width/2;
			long t_max_x = x + (int)width/2;
			long t_min_y = y - (int)height/2;
			long t_max_y = y + (int)height/2;

			diag_item.x1 = x - (int)width/2;
			diag_item.y1 = y - (int)height/2;
			
			diag_item.x2 = x - (int)width/2;
			diag_item.y2 = y + (int)height/2;

			diag_item.x3 = x + (int)width/2;
			diag_item.y3 = y + (int)height/2;

			diag_item.x4 = x + (int)width/2;
			diag_item.y4 = y - (int)height/2;
						
			if (view->HasItem ()) {				
				if (m_model_class_str  == "ScenarioDiagram") {
					IRoseObjectInstancePtr oi = view->GetItem ();
					if (oi) {
						IRoseClassPtr cls = oi->GetClass();
						if (cls != 0) {
							const RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (cls);
							if (rad) {
								diag_item.uid = rad->get_link_guid ();								
								items.push_back (diag_item);
							}
						}
					}
				} else {
					IRoseItemPtr item = view->GetItem ();					
					if (item->IsClass(_T(CATEGORY_TYPE)) || item->IsClass(_T(CLASS_TYPE))) {
						//корректируем верхнюю границу прямоугольника	
						//метод тыка - у пакетов есть ещё маленький 
						//квдритик сверху - его размер Роза не отдает:((
						if (item->IsClass(_T(CATEGORY_TYPE))) {
							diag_item.y1 = y - (int)height*5/6;			
							diag_item.y4 = y - (int)height*5/6;
						}
						const RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (item);
						if (rad) {
							diag_item.uid = rad->get_link_guid ();							
							items.push_back (diag_item);
						}						
					}
				}
			}
			IRoseLineVertexCollectionPtr lines = view->LineVertices;
			short lines_count = lines->Count;
			if (lines_count != 0) {
				//это стелка на диаграмме - определяем координаты её изломов
				diag_item.x1 = 0;
				diag_item.x2 = 0;
				
				diag_item.y1 = 0;
				diag_item.y4 = 0;
				
				diag_item.x3 = 0;
				diag_item.x4 = 0;
				
				diag_item.y2 = 0;
				diag_item.y3 = 0;
				for (short n = 1; n <= lines_count; ++n) {
					IRoseLineVertexPtr line = lines->GetAt (n);
					
					long vertex_x = line->GetXPosition ();
					long vertex_y = line->GetYPosition ();

					min_x = std::min (min_x, vertex_x);
					min_y = std::min (min_y, vertex_y);

					max_x = std::max (max_x, vertex_x);
					max_y = std::max (max_y, vertex_y);
				}
			} else {
				IRoseItemViewCollectionPtr sub_views = view->SubViews;
				short sub_views_count = sub_views->Count;
				for (short j = 1; j <= sub_views_count; ++j) {
					IRoseItemViewPtr sub_view = sub_views->GetAt (j);
					if (sub_view->IsClass ("NoteView")) {
						std::string text = ((IRoseNoteViewPtr)sub_view)->Text;
						
						if (text != "") {
							long sub_x = sub_view->XPosition;
							long sub_y = sub_view->YPosition;
							long sub_width = sub_view->GetWidth ();
							long sub_height = sub_view->GetHeight ();

							min_x = std::min (min_x, sub_x - (int)sub_width/2);
							min_y = std::min (min_y, sub_y - (int)sub_height/2);

							max_x = std::max (max_x, sub_x + (int)sub_width/2);
							max_y = std::max (max_y, sub_y + (int)sub_height/2);
						}
					}
				}
				min_x = std::min (min_x, diag_item.x1);
				min_y = std::min (min_y, diag_item.y1);

				max_x = std::max (max_x, diag_item.x3);
				max_y = std::max (max_y, diag_item.y2);				
			}			
		}
		if (m_model_class_str  == "ScenarioDiagram") {
			//корректируем max_y - у сиквенс диаграмм есть внизу хвостик
			//размером примерно 90 попугаев, который никак не учитывается
			//метод тыка :((
			max_y += 90;
		}

		boost::hash<std::string> str_hash;		
		diagram_hash = boost::lexical_cast<std::string> (str_hash (hash.str ()));
		//diagram_hash += "\n";
		//diagram_hash += hash.str ();
		//LOG_D (("Diag: %s, hash: %s", this->get_name_str ().c_str (), diagram_hash.c_str ()));
		//x_offset и y_offset начало координа
		//в системе "картинка"
		const long x_offset = image_min_x;
		const long y_offset = image_min_y;

		const double kx = abs ((double)(max_x - min_x)/(image_max_x - image_min_x));
		const double ky = abs ((double)(max_y - min_y)/(image_max_y - image_min_y));
		//LOG_D (("kx = %.2f, ky = %.2f", kx, ky));
		for (
			AbstractDumperBase::DiagramItemCollection::iterator it = items.begin ()
			; it != items.end ()
			; ++it
		) {				
			it->x1 = (long)((it->x1 - min_x)/kx + x_offset);
			it->y1 = (long)((it->y1 - min_y)/ky + y_offset);

			it->x2 = (long)((it->x2 - min_x)/kx + x_offset);
			it->y2 = (long)((it->y2 - min_y)/ky + y_offset);

			it->x3 = (long)((it->x3 - min_x)/kx + x_offset);
			it->y3 = (long)((it->y3 - min_y)/ky + y_offset);
			
			it->x4 = (long)((it->x4 - min_x)/kx + x_offset);
			it->y4 = (long)((it->y4 - min_y)/ky + y_offset);
#ifdef _DEBUG
			/*if (m_diag->GetUniqueID () == _bstr_t ("4614DE7A03B9")) {
				LOG_D ((
					"Coords (%s): %d, %d, %d, %d, %d, %d, %d, %d"
					, it->uid.c_str ()
					, it->x1
					, it->y1
					, it->x2
					, it->y2
					, it->x3
					, it->y3
					, it->x4
					, it->y4
				));
			}*/
#endif
		}
		size_t len = file->Size ();
		if (len > AbstractDumperBase::MAX_PICTURE_SIZE) {
			long quality = 100*AbstractDumperBase::MAX_PICTURE_SIZE/len;
			image->SetJpegQuality(static_cast<unsigned char> (quality));

			file->Close ();
			file->Open ();
			image->Encode (file.ptr (), CXIMAGE_FORMAT_JPG);
			
			std::string mess ("Diagram's (");
			mess += boost::lexical_cast<std::string> (DEFAULT_HORZ_RES);
			mess += static_cast<const char*> (m_diag->GetQualifiedName ());
			mess += ") image size more than ";
			mess += boost::lexical_cast<std::string> (AbstractDumperBase::MAX_PICTURE_SIZE);
			mess += " Byte - we compress it with ";
			mess += boost::lexical_cast<std::string> (quality);
			mess += " percent quality";
			
			GenSupport::LogManagerFactory::get ().log_warning (mess.c_str ());	
			//LOG_W (("Diagram image size more than %d Byte - we compress it with %d%% quality", AbstractDumperBase::MAX_PICTURE_SIZE, quality));
		}
	} else {
		IRoseElementPtr diag_parent = RoseHelper::get_context (m_diag);
		std::string mess (
			diag_parent !=0 
				? RoseHelper::get_full_name (diag_parent) + "::" + this->get_name_str ()
				: this->get_name_str ()
		);
		mess += ": Empty diagram render";
		GenSupport::LogManagerFactory::get ().log_warning (mess.c_str ());
	}	
	return file.forget ();
	//#UC END# *4642AC6B0138_4571DFB400FA*
}

// overloaded method from AbstractDumperBase
// возвращает класс
const std::string RoseDiagramDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571DFB400FA*
	return m_model_class_str;
	//#UC END# *465EA35D005D_4571DFB400FA*
}

// overloaded method from AbstractDumperBase
// стереотип на модели (VCMModule, CORBAInterface::operation, ...)
const AbstractDumperBase::StereotypeID& RoseDiagramDumper::get_model_stereotype_str () const {
	//#UC START# *4666AB4D0109_4571DFB400FA*
	return m_model_stereotype_id;
	//#UC END# *4666AB4D0109_4571DFB400FA*
}

// overloaded method from AbstractDumperBase
// возвращает GUID элемента
const std::string& RoseDiagramDumper::get_model_unique_id_str () const {
	//#UC START# *465E51860213_4571DFB400FA*
	if (m_model_unique_id.empty ()) {
		m_model_unique_id = get_rose_element_uid(m_diag);
	}
	return m_model_unique_id;
	//#UC END# *465E51860213_4571DFB400FA*
}

// overloaded method from AbstractDumperBase
// возвращает true, если элемент был изменён (используется дл определения того, что диаграмма была
// изменена)
bool RoseDiagramDumper::is_changed () const {
	//#UC START# *4745846E0191_4571DFB400FA*
	std::string self_guid = this->get_model_unique_id_str ();
	bool res = RoseHelper::get_changed_diags ().find (self_guid) != RoseHelper::get_changed_diags ().end ();
	if (res == false) {
		//нужн опроверить флаг изменённости в свойствах элемента
		std::string prop_value = m_diag->GetPropertyValue (TOOL_NAME, RoseHelper::DIAG_CHANGE_FLAG_PROPERTY);
		if (prop_value == "true") {
			RoseHelper::get_changed_diags ().insert (self_guid);
			res = true;
		}
	}
	return res;

	//#UC END# *4745846E0191_4571DFB400FA*
}

// overloaded method from AbstractDumperBase
// сбрасывает информацию об изменённости
void RoseDiagramDumper::reset_changed () const {
	//#UC START# *474584AB02B6_4571DFB400FA*
	//всегда сбрасываем флаг изменённости в модели
	RoseHelper::write_property_with_lock (
		m_diag
		, RoseHelper::DIAG_CHANGE_FLAG_PROPERTY
		, ""
		, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
		, false
		, "Flag of changing"
	);

	RoseHelper::get_changed_diags ().erase (get_model_unique_id_str ());
	//#UC END# *474584AB02B6_4571DFB400FA*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

