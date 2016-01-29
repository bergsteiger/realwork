#include "shared/Core/fix/mpcxc.h"

#include "SearchB.h"

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	YBase *from_base = new YBase (argv [2], ACE_OS_O_RDONLY);
	from_base->IsOk ();
	StdBigBase *to_base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	ObjKey key;
	gk_bzero (&key, sizeof (key));
	for (int i = 3; i < argc; i++) {
		key.id = atol (argv [i]);
		printf ("%ld\r", key.id);
		Stream *str = from_base->FindIndex ("Blob")->Index::OpenN (&key, 0);
		if (str) {
			long size = str->Length ();
			char *data = new char [size];
			str->Read (data, size);
			from_base->FindIndex ("Blob")->Close (str);

			str = to_base->FindIndex ("Blob")->Index::OpenN (&key, 0, 1);
			if (str) {
				str->Write (data, size);
				str->Trunc ();
				to_base->FindIndex ("Blob")->Close (str);
			}
			delete []data;
		}
		str = from_base->FindIndex ("Blob")->Index::OpenN (&key, 1);
		if (str) {
			long size = str->Length ();
			char *data = new char [size];
			str->Read (data, size);
			from_base->FindIndex ("Blob")->Close (str);

			str = to_base->FindIndex ("Blob")->Index::OpenN (&key, 1, 1);
			if (str) {
				str->Write (data, size);
				str->Trunc ();
				to_base->FindIndex ("Blob")->Close (str);
			}
			delete []data;
		}
	}
	printf ("\n");
	delete to_base;
	delete from_base;
	return 0;
}
