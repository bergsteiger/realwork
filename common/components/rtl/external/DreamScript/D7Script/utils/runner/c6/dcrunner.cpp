//---------------------------------------------------------------------------
#include <vcl.h>
#include "rununit.hpp"
#pragma hdrstop
USERES("Dcrunner.res");
USEUNIT("..\rununit.pas");
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
         Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------
