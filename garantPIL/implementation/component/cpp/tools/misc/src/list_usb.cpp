#include <windows.h>
#include <setupapi.h>
#include <atlstr.h>

#pragma comment(lib, "setupapi")

char get_disk (DWORD num)
{
	char res = 0;
	TCHAR drives [26 * 4];
	LPTSTR drive = drives;
	DWORD size = GetLogicalDriveStrings (sizeof(drives), drives);
	if (size) {
		while (*drive) {
			STORAGE_DEVICE_NUMBER sdn = {0};
			DWORD dwSize = 0;
			CString driveStr;
			driveStr.Format(TEXT("\\\\.\\%c:"), drive[0]);
			HANDLE hDrive = CreateFile(driveStr, GENERIC_READ, FILE_SHARE_READ|FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, 0);

			if (INVALID_HANDLE_VALUE != hDrive && DeviceIoControl (hDrive, IOCTL_STORAGE_GET_DEVICE_NUMBER, NULL, 0, &sdn, sizeof(sdn), &dwSize, NULL ) && dwSize)  {
				if (sdn.DeviceNumber == num) {
					CString letterStr;
					letterStr.Format(TEXT("%c"), drive[0]);
					res = letterStr.GetBuffer () [0];
				}
			}

			CloseHandle(hDrive);
			drive += _tcslen(drive) + 1;
		}
	}

	return res;
}

int _tmain(int argc, _TCHAR* argv[])
{
	HDEVINFO dev_info = NULL;
	SP_DEVINFO_DATA DeviceInfoData = {sizeof(DeviceInfoData)};
	const int bufSize = 4096;
	LPSTR prop_buffer = (LPSTR)LocalAlloc (LPTR, bufSize);
	DWORD required_size, req_bufsize, prop_datatype;
	BOOL bRes;

	dev_info = SetupDiGetClassDevs (&GUID_DEVINTERFACE_DISK, NULL, NULL, DIGCF_PRESENT|DIGCF_DEVICEINTERFACE);

	for( DWORD i = 0; SetupDiEnumDeviceInfo( dev_info, i, &DeviceInfoData ); i++ ) {
		bRes = SetupDiGetDeviceRegistryProperty (dev_info, &DeviceInfoData, SPDRP_ENUMERATOR_NAME, &prop_datatype, (LPBYTE)prop_buffer, bufSize, &req_bufsize);
		if (0 == _tcscmp((LPTSTR)prop_buffer, TEXT("USBSTOR"))) {
			ZeroMemory(prop_buffer, bufSize);
			bRes = SetupDiGetDeviceRegistryProperty(dev_info, &DeviceInfoData, SPDRP_FRIENDLYNAME, &prop_datatype, (LPBYTE)prop_buffer, bufSize, &req_bufsize);

			SP_DEVICE_INTERFACE_DATA did = {sizeof(did)};
			PSP_DEVICE_INTERFACE_DETAIL_DATA pdd = NULL;
			DWORD idx = 0;
			while(1) {
				DWORD err;

				bRes = SetupDiEnumDeviceInterfaces(dev_info, &DeviceInfoData, &GUID_DEVINTERFACE_DISK, idx++, &did);
				if (!bRes) {
					err = GetLastError ();
					if (ERROR_NO_MORE_DEVICES == err || ERROR_NO_MORE_ITEMS == err)
						break;
				}

				bRes = SetupDiGetDeviceInterfaceDetail(dev_info, &did, NULL, 0, &required_size, NULL);
				if (!bRes) {
					err = GetLastError ();
					if (ERROR_INSUFFICIENT_BUFFER == err) {
						pdd = (PSP_DEVICE_INTERFACE_DETAIL_DATA)LocalAlloc(LPTR, required_size);
						pdd->cbSize = sizeof(SP_DEVICE_INTERFACE_DETAIL_DATA);
					} else {
						break;
					}
				}

				bRes = SetupDiGetDeviceInterfaceDetail(dev_info, &did, pdd, required_size, NULL, NULL);
				if(bRes) {
					STORAGE_DEVICE_NUMBER sdn = {0};
					DWORD dwSize = 0;
					HANDLE hDrive = CreateFile (pdd->DevicePath, GENERIC_READ, FILE_SHARE_READ|FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, 0);

					if (INVALID_HANDLE_VALUE != hDrive && DeviceIoControl (hDrive, IOCTL_STORAGE_GET_DEVICE_NUMBER, NULL, 0, &sdn, sizeof(sdn), &dwSize, NULL ) && dwSize) {
					#ifdef	_DEBUG
						int NameLenUnicode = lstrlenW (pdd->DevicePath);
						int NameLen = WideCharToMultiByte (CP_ACP, 0, pdd->DevicePath, NameLenUnicode, NULL, 0, NULL, NULL);
						char *buff = new char [ NameLen ];
						WideCharToMultiByte (CP_ACP, 0, pdd->DevicePath, NameLenUnicode, buff, NameLen, NULL, NULL);
					#else
						char *buff = strdup (pdd->DevicePath);
						int NameLen = strlen (buff);
					#endif
						
						char* usbstor = strstr (buff, "\\usbstor");
						if (!usbstor) usbstor = strstr (buff, "\\USBSTOR");
						if (usbstor) {
							char* unique_id_trash = strchr (usbstor + 10, '#');
							if (unique_id_trash) {
								unique_id_trash++;
								char* unique_id = (char*) malloc (NameLen);
								if (strchr (unique_id_trash, '&')) {
									int len = strchr (unique_id_trash, '&') - unique_id_trash;
									strncpy (unique_id, unique_id_trash, len);
									unique_id [len] = 0;
								} else {
									strcpy (unique_id, unique_id_trash);
								}
								printf ("%c: %s\n", get_disk (sdn.DeviceNumber), unique_id);
								free (unique_id);
							}
						}
					#ifdef	_DEBUG
						delete [] buff;
					#else
						free (buff);
					#endif

					}
					CloseHandle (hDrive);
				}
				LocalFree (pdd);
				pdd = NULL;
			}
		}
	}

	SetupDiDestroyDeviceInfoList (dev_info);
	return 0;
}
