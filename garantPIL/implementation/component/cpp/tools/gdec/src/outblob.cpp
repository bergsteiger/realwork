
#include "ace/ACE.h"

#include "zutil.h"
#include "btiter.h"
#include "main.h"

void out_blob (Base* base, FILE* file, const int blob, char* fname, long& id) {
	const long zip_buf_size = 1024, unzip_buf_size = 2048;

	char* unzip_buf = new char [unzip_buf_size];

	Index* ind_blob = base->FindIndex ("Blob");

	BTIterator btit (ind_blob); {
		for (long i = 0; i < blob; ++i) {
			btit.next ();
		}
	}

	ObjKey* objs = (ObjKey *)btit.Key ();
	id = objs->id;

	Stream* str = ind_blob->Open (objs);

	if (str) {
		ObjInfo	info;
		str->Read (&info, sizeof (info));

		//long objType = info.type>>8;

		switch (info.type) {
		case EOT_XML:
			ACE_OS::sprintf (fname, "%s\\%d.xml", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_PDF:
			ACE_OS::sprintf (fname, "%s\\%d.pdf", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_PIC:
			ACE_OS::sprintf (fname, "%s\\%d.bmp", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_PNG:
			ACE_OS::sprintf (fname, "%s\\%d.png", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_JPG:
			ACE_OS::sprintf (fname, "%s\\%d.jpg", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_GIF:
			ACE_OS::sprintf (fname, "%s\\%d.gif", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_EVD:
			ACE_OS::sprintf (fname, "%s\\%d.evd", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_RTF:
			ACE_OS::sprintf (fname, "%s\\%d.rtf", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_URL:
			ACE_OS::sprintf (fname, "%s\\%d.url", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_MSG:
			ACE_OS::sprintf (fname, "%s\\%d.msg", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_XLS:
			ACE_OS::sprintf (fname, "%s\\%d.xls", blob_dir.c_str (), objs->id - ID_BORDER);
			break;
		case EOT_MP3:
			ACE_OS::sprintf (fname, "%s\\%d.mp3", blob_dir.c_str (), objs->id - ID_BORDER); // GARANT_NONPOD
			break;
		case EOT_SWF:
			ACE_OS::sprintf (fname, "%s\\%d.swf", blob_dir.c_str (), objs->id - ID_BORDER); // GARANT_NONPOD
			break;
		default:
			// Не применимо из-за неизвестных расширений:
			// sprintf(fname, "%s\\%d.%s", blob_dir.c_str (), objs->id - ID_BORDER, &objType);

			ACE_OS::sprintf (fname, "%s\\%d.dat", blob_dir.c_str (), objs->id - ID_BORDER);
			Log.printf (lt_info, "ERROR! Unknown Blob type: '%s\\%d.dat'\n", blob_dir.c_str (), objs->id - ID_BORDER);
		}		

		change_slashes (fname);
		FILE_aptr out = ACE_OS::fopen (fname, "wb");

		if (info.packed) {
			char* zip_buf = new char [zip_buf_size];

			z_stream c_stream;
			bzero ((caddr_t)&c_stream, sizeof (z_stream));

			int err = inflateInit (&c_stream);

			if (err == Z_OK) {
				c_stream.total_out = 0;
				c_stream.avail_out = unzip_buf_size;
				c_stream.next_out  = (unsigned char *)unzip_buf;

				err = 0;

				long rd = 0, finished = 0;

				do {
					if (c_stream.avail_in == 0) {
						while (c_stream.avail_in == 0 && !err && c_stream.avail_out) {
							rd = str->Read (zip_buf, zip_buf_size);
							if (rd == 0) {
								finished = 1;
								break;
							} else {
								c_stream.avail_in = rd;
								c_stream.next_in = (unsigned char *)zip_buf;
							}
							err = inflate (&c_stream, Z_NO_FLUSH);
						}
					} else {
						err = inflate (&c_stream, Z_NO_FLUSH);
					}

					switch (err) {
						case Z_OK:
							break;
						case Z_STREAM_END:
							finished = 1;
							break;
						default:
							finished = 1; // error?
							break;
					}

					if (c_stream.total_out) {
						ACE_OS::fwrite (unzip_buf, c_stream.total_out, 1, out.in ());

						c_stream.total_out = 0;
						c_stream.avail_out = unzip_buf_size ;
						c_stream.next_out = (unsigned char *)unzip_buf;
					}
				} while (!finished);
			}

			err = inflateEnd (&c_stream);

			delete [] zip_buf;

		} else {
			long i = 0, rd = 0;

			while (i < info.size) {
				rd = str->Read (unzip_buf, std::min (unzip_buf_size, info.size - i));
				i += rd;
				ACE_OS::fwrite (unzip_buf, rd, 1, out.in ());
			}
		}

#ifdef	WINENCODE
		Recoding (cd_win, cd_dos, info.name);
#endif

		bool b_flashtopic = (objs->id >= ID_FLASH_LO && objs->id <= ID_FLASH_HI);
		if (!b_flashtopic)
			ACE_OS::fprintf (file, "!OBJTOPIC %d %s\n", objs->id - ID_BORDER, info.name);

		str->Seek (sizeof (ObjInfo) + info.size);

		{
			Core::Aptr <char, CharArrayDestructor> buffer = new char [str->Length ()];
			str->Read (buffer.inout (), str->Length ());

			ind_blob->Close (str);

			str = ind_blob->OpenN (objs, 1);

			if (str) {
				short sbuf [MAX_BASES];

				long stream_len = str->Length ();
				long sz = stream_len / sizeof (short);

				str->Read (sbuf, stream_len);

				if (!b_flashtopic && sz) {
					ACE_OS::fprintf (file, "!BELONGS ");

					for (long i = 0; i < sz; ++i) {
						ACE_OS::fprintf (file, "%s", Belongs [sbuf [i]].SName);

						if (i < sz - 1) {
							ACE_OS::fprintf (file, "\\");
						}
					}

					ACE_OS::fprintf (file, "\n");
				}

				ind_blob->Close (str);
			}

			char* blobname = buffer.ptr () + sizeof (long);

#ifdef	WINENCODE
			Recoding (cd_win, cd_dos, blobname);
#endif
			if (!b_flashtopic)
				ACE_OS::fprintf (file, "!NAME %s\n", blobname);
		}

		// ACE_OS::fprintf (file, "!OBJTYPE %s\n", &objType); Не применимо из-за неизвестных расширений

		if (!b_flashtopic) switch (info.type) {
		case EOT_PIC:
			ACE_OS::fprintf (file, "!OBJTYPE PIC\n");
			break;
		case EOT_EVD:
			ACE_OS::fprintf (file, "!OBJTYPE EVD\n");
			break;
		case EOT_PNG:
			ACE_OS::fprintf (file, "!OBJTYPE PNG\n");
			break;
		case EOT_XML:
			ACE_OS::fprintf (file, "!OBJTYPE XML\n");
			break;
		case EOT_PDF:
			ACE_OS::fprintf (file, "!OBJTYPE PDF\n");
			break;
		case EOT_RTF:
			ACE_OS::fprintf (file, "!OBJTYPE RTF\n");
			break;
		case EOT_URL:
			ACE_OS::fprintf (file, "!OBJTYPE URL\n");
			break;
		case EOT_MSG:
			ACE_OS::fprintf (file, "!OBJTYPE MSG\n");
			break;
		case EOT_XLS:
			ACE_OS::fprintf (file, "!OBJTYPE XLS\n");
			break;
		case EOT_MP3:
			ACE_OS::fprintf (file, "!OBJTYPE MP3\n");
			break;
		case EOT_SWF:
			ACE_OS::fprintf (file, "!OBJTYPE SWF\n");
			break;
		default:
			ACE_OS::fprintf (file, "!OBJTYPE DAT\n");
			break;
		}

		if (!b_flashtopic)
			ACE_OS::fprintf (file, "!OBJPATH %s\n\n", fname);

	}

	delete [] unzip_buf;
}
