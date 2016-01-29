#include <string>

// ������������ �� mbs � wcs. ��������� ������ ������� ����������. ���� �� ����������� �� ���������� null
wchar_t* qc_mbs_to_wcs(
	const char* in_buf, 
	const size_t size // ������� �������� ����������, �� ������ ��� ������ in_buf
);


const std::wstring qc_mbs_to_wcs(
	const std::string& in
);


// ������������ �� mbs � wcs. ��������� ������ ������� ����������. ���� �� ����������� �� ���������� null
char* qc_wcs_to_mbs(
	const wchar_t* in_buf, 
	const size_t size // ������� �������� ����������, �� ������ ��� ������ in_buf
);

const std::string qc_wcs_to_mbs(
	const std::wstring& in
);
