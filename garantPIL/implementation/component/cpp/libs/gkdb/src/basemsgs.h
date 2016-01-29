#if defined(_MSC_VER)
	#define BSMES_OK				"┴рчр т яюЁ фъх"

	#define BSMES_FILESNULL			"╬фшэ шч Їрщыют срч√ эх ёючфрыё "

	#define BSMES_FILESLOCKED		"┴рчр юЄъЁ√Єр фЁєующ юсюыюўъющ"

	#define BSMES_CANNOTOPENFILES	"╬фшэ шч Їрщыют срч√ эх юЄъЁ√ыё "

	#define BSMES_INVALIDSIGN		"┬хЁёш  фрээ√ї эх ёютярфрхЄ"

	#define BSMES_NOTOK				"╬фшэ шч Їрщыют срч√ эх т яюЁ фъх"

	#define BSMES_DOCINDERROR		"╬°шсър т шэфхъёх фюъєьхэЄют"

	#define BSMES_STREAMERROR		"╬°шсър т STR-Їрщых"

#elif defined(unix) && !defined(__GO32__) && !defined(__CYGWIN32__)

	#define BSMES_OK				"Base OK"

	#define BSMES_FILESNULL			"One of the files is 0"

	#define BSMES_FILESLOCKED		"Base's file locked"

	#define BSMES_CANNOTOPENFILES	"One of the files was not opened"

	#define BSMES_INVALIDSIGN		"Data version is invalid"

	#define BSMES_NOTOK				"One of the files is not Ok"

	#define BSMES_DOCINDERROR		"Error in docIndex"

	#define BSMES_STREAMERROR		"Error in stream file"

#else // I hope it's meen DOS

	#define BSMES_OK				"База в порядке"
	#define BSMES_FILESNULL			"Один из файлов базы не создался"
	#define BSMES_FILESLOCKED		"База открыта другой оболочкой"
	#define BSMES_CANNOTOPENFILES	"Один из файлов базы не открылся"
	#define BSMES_INVALIDSIGN		"Версия данных не совпадает"
	#define BSMES_NOTOK				"Один из файлов базы не в порядке"
	#define BSMES_DOCINDERROR		"Ошибка в индексе документов"
	#define BSMES_STREAMERROR		"Ошибка в STR-файле"
#endif // OS/compiler type

