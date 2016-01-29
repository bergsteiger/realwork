//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include <mainunit.hpp>
USERES("instant.res");
USEUNIT("..\MainUnit.pas");
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
          InitInstant();
        }                    
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------

