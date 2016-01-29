#include <string>

// Конвертирует из mbs в wcs. Результат должен чистить вызывающий. Если не сконвертили то возвращаем null
wchar_t* qc_mbs_to_wcs(
	const char* in_buf, 
	const size_t size // сколько символов конвертить, не больше чем размер in_buf
);


const std::wstring qc_mbs_to_wcs(
	const std::string& in
);


// Конвертирует из mbs в wcs. Результат должен чистить вызывающий. Если не сконвертили то возвращаем null
char* qc_wcs_to_mbs(
	const wchar_t* in_buf, 
	const size_t size // сколько символов конвертить, не больше чем размер in_buf
);

const std::string qc_wcs_to_mbs(
	const std::wstring& in
);
