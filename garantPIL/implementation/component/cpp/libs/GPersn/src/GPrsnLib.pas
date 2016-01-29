unit GPrsnLib;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

const
     SIZE_SYNHRO_PER_DWORD = 2;
type

	PL_FILES_LIST_TAG = record
            pFileName: PCHAR;
            next: Pointer;
	end;

	PL_IMPORT_CIB_DATA_TAG = record
            pLogin: PCHAR;
            Alias: PCHAR;
            next: Pointer;
	end;

        P_PL_FILES_LIST_TAG= ^PL_FILES_LIST_TAG;
        PP_PL_FILES_LIST_TAG= ^P_PL_FILES_LIST_TAG;

      	PP_PChar = ^PChar;

 function    pl_InitCrypto(hWnd:integer): integer; stdcall; external;

 function    pl_DoneCrypto(hWnd:integer): integer; stdcall; external;

 function    pl_UnCryptoOrder(  FileNameOrder:PChar;
                               	LoginReplicator:PChar;
                                PasswordReplicator:PChar;
                                ppMem:PP_PChar) : integer; stdcall; external;

 function    pl_FreeMemWithCryptoOrder(pMem:PChar) : integer; stdcall; external;

 function    pl_CreateInstalledDisk(	FileNameOrder:PChar;
                                        BaseFileName:PChar;
                                        LoginReplicator:PChar;
                                        PasswordReplicator:PChar;
                                        LoginInstalledCIB:PChar) : integer; stdcall; external;

 function    pl_InstallFromHDD(           LoginHDD:PChar;
                                          PassHDD:PChar;
                                          FZ1FileBase:PChar;
                                          LoginCIB:PChar ): integer; stdcall; external;

 function    pl_CopyPX( pSource:PChar;
                        pTarget:PChar): integer; stdcall; external;

 function    pl_GetFileList( BaseFileName:PChar;
                             ppList:PP_PL_FILES_LIST_TAG): integer; stdcall; external;

 function    pl_FreeFileList( pList:P_PL_FILES_LIST_TAG): integer; stdcall; external;

implementation
{$L pl_crypt}

end.