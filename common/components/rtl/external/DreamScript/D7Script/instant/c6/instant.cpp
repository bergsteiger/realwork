//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include <mainunit.hpp>
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
          InitInstant();
        }                    
        catch (Exception &exception)
        {
                 Forms::Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------
