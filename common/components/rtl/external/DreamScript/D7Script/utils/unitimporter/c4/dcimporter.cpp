//---------------------------------------------------------------------------
#include <vcl.h>
#include "DCRunner.hpp"
#pragma hdrstop
USERES("DCImporter.res");
USEUNIT("..\DCRunner.pas");
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
  DCRunUnitImporter();
  return 0;
}
//---------------------------------------------------------------------------
