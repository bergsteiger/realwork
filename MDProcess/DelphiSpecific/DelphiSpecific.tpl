MDA GENERATOR TEMPLATE FILE

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/DelphiSpecific/DelphiSpecific.tpl"
// ��������� ����-��������
// Generated from UML model, root element: <<MDATemplates::Category>> MDProcess$ForDelphi::DelphiSpecific
//
// ������ ��������, �������� ����������� ����������� ��� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Generator definitions:
group "All" {

	group "C++ ���������� � ����������" {
		generator "cpp" {
			Description: ��������� ������ ���������� C++ (.cpp)
			lid: cpp
		}
		generator "h" {
			Description: ��������� ������������ ������ C++ (.h)
			lid: cpp
			ifdef_suffix: H
		}
		generator "i.h" {
			Description: ��������� inline ������ ���������� C++ (.i.h)
			lid: cpp
		}
		group "��������� ����� C++" {
			generator "mpc" {
				Description: mpc/mwc ����� �������� (mpc/mwc)
			}
			generator "mpc2" {
				Description: �������������� ����� �������� (mpc)
			}
			generator "rc" {
				Description: ����� �������� (rc)
			}
			generator "s.ini" {
				Description: ���� �������� (.ini)
			}
			generator "s.reg" {
				Description: ��������� ������� (.reg)
			}
			generator "vi.rc" {
				Description: ���������� � ������ (.rc)
			}
			generator "vi.rch" {
				Description: ���������� � ������ (.rch)
			}
		}
		group "C++ �������" {
			generator "fctr.cpp" {
				Description: ��������� ������ ���������� ��� ������ ����������� (.cpp)
				lid: cpp
			}
			generator "fctr.h" {
				Description: ��������� ������������ ������ ��� ������ ����������� (.h)
				lid: cpp
				ifdef_suffix: FCTR_H
			}
		}
	}

	group "COM" {
		generator "com.def" {
			Description: ��������� ����� �������� ����������� ��� COM DLL (.def)
		}
		generator "com.rgs" {
			Description: ��������� ����� ���������� ��� ����������� COM DLL (.rgs)
		}
		generator "odl" {
			Description: ��������� ODL-����� ������������ COM-���������� (.odl)
			lid: cpp
		}
	}

	group "CORBA IDL" {
		generator "idl" {
			Description: ��������� idl ������������ (.idl)
			lid: idl
		}
		generator "idl_ami" {
			Description: ��������� idl ������������ ��� AMI (.idl)
			lid: idl
		}
	}

	group "Delphi ���������� � ����������" {
		generator "impl.pas" {
			Description: ���������� �� Delphi(.pas)
			lid: delphi
		}
		generator "intf.pas" {
			Description: ������ Delphi ���������� (.pas)
			lid: delphi
		}
		generator "intf2.pas" {
			Description: ������ ������������ ������ ����������. �������� ���������� ������� ������.
			lid: delphi
		}
		generator "intf3.pas" {
			Description: 3-� ������ ����������. �������� ���� ��� ��������.
			lid: delphi
		}
		generator "pas.script" {
			Description: 
			lid: script
		}
		generator "pas.script.runner" {
			Description: 
			lid: script
		}
	}

	group "Java" {
		generator "fctr.java" {
			Description: ��������� ���������� ������ ����������� �� java (.java)
			lid: java
		}
		generator "java" {
			Description: ��������� �������, ����������� �� java (.java)
			lid: java
		}
		group "��������� ����� Java" {
			generator "Makejar.launch" {
				Description: ��������� ������ ��� ������������ � ������� ������
				lid: xml
			}
			generator "build.xml" {
				Description: ��������� ������ ��� ������ � Ecllipse
				lid: xml
			}
			generator "output.classpath" {
				Description: ��������� ����� � ��������� ����� ������ ��������� (CLASSPATH ��� java)
				lid: xml
			}
			generator "output.project" {
				Description: ��������� ������ ������� ��� Ecllipse
				lid: xml
			}
			generator "output.xml" {
				Description: ��������� ������ � ��������� �������� ��� Confluence
				lid: xml
			}
		}
	}

	group "��������� ��� Web" {
		group "��������� Velocity" {
			generator "vm" {
				Description: ��������� VM
			}
		}
		group "��������� JavaScript" {
			generator "js" {
				Description: ��������� JavaScript
			}
		}
	}

	group "������-DLL �������" {
		generator "dll.cpp" {
			Description: �++ TIE-������� ��� DLL (_tie.cpp)
			lid: dll_cpp
		}
		generator "dll.h" {
			Description: �++ TIE-������� ��� DLL (_tie.h)
			lid: dll_cpp
			ifdef_suffix: TIE_H
		}
		generator "pas" {
			Description: Delphi ���������� ��� �������� (.pas)
			lid: delphi
		}
	}

	group "������-DLL ������� ��������� �����" {
		generator "mpc.dll" {
			Description: MPC ��� TIE-������� (.mpc)
		}
	}

	group "������ ��� ������" {
		generator "ant.bat" {
			Description: ������� ��� ������� (.bat)
		}
		generator "ant.xml" {
			Description: ������ ��� Ant'� (.xml)
		}
	}

	group "����-MDA" {
		generator "mda" {
			Description: ��������� ����-��������
		}
		generator "mda.inc" {
			Description: ��������� ������ ��������� ����-�������� (mda.inc)
		}
		generator "tpi.script" {
			Description: 
			lid: script
		}
	}

	group "ModelBuilding" {
		generator "spell" {
			Description: ��������� ���������� ����������� ��������� ������ - ����������� �� ��������� ���������� ����������
		}
	}

	group "������������" {
		generator "wiki" {
			Description: ��������� ������ � MDKnow
		}
	}


Stereotype definitions:

//////////////////////////////////////////////////////////////////////////////////
// default

: default

//////////////////////////////////////////////////////////////////////////////////
// default Category (Using for generation LogicalView)

: default::Category
> UMLModule::Category
> Project::Category
> Domain::Category


+ fctr.cpp
P
	<%CX>

+ fctr.h
P
	<%CX>

+ cpp
P
	<%CX>

+ h
P
	<%CX>

+ i.h
P
	<%CX>

+ com.def
P
	<%CX>

+ com.rgs
P
	<%CX>

+ odl
P
	<%CX>

+ idl
P
	<%CX>

+ idl_ami
P
	<%CX>

+ impl.pas
P
	<%CX>

+ intf.pas
P
	<%CX>

+ intf2.pas
P
	<%CX>

+ intf3.pas
P
	<%CX>

+ pas.script
P
	<%CX>

+ pas.script.runner
P
	<%CX>

+ fctr.java
P
	<%CX>

+ java
P
	<%CX>

+ js
P
	<%CX>

+ vm
P
	<%CX>

+ dll.cpp
P
	<%CX>

+ dll.h
P
	<%CX>

+ pas
P
	<%CX>

+ mpc.dll
P
	<%CX>

+ mpc
P
	<%CX>

+ mpc2
P
	<%CX>

+ rc
P
	<%CX>

+ s.ini
P
	<%CX>

+ s.reg
P
	<%CX>

+ vi.rc
P
	<%CX>

+ vi.rch
P
	<%CX>

+ Makejar.launch
P
	<%CX>

+ build.xml
P
	<%CX>

+ output.classpath
P
	<%CX>

+ output.project
P
	<%CX>

+ output.xml
P
	<%CX>

+ ant.bat
P
	<%CX>

+ ant.xml
P
	<%CX>

+ mda
P
	<%CX>

+ mda.inc
P
	<%CX>

+ tpi.script
P
	<%CX>

+ spell
P
	<%CX>

+ wiki
P
	<%CX>


# ./DelphiSpecific.inc.tpi

f _all_generators
	[%f_clear_list(ALL_GENERATORS_ID)
	%f_add_to_list(ALL_GENERATORS_ID,"Makejar.launch")
	%f_add_to_list(ALL_GENERATORS_ID,"ant.bat")
	%f_add_to_list(ALL_GENERATORS_ID,"ant.xml")
	%f_add_to_list(ALL_GENERATORS_ID,"build.xml")
	%f_add_to_list(ALL_GENERATORS_ID,"com.def")
	%f_add_to_list(ALL_GENERATORS_ID,"com.rgs")
	%f_add_to_list(ALL_GENERATORS_ID,"cpp")
	%f_add_to_list(ALL_GENERATORS_ID,"dll.cpp")
	%f_add_to_list(ALL_GENERATORS_ID,"dll.h")
	%f_add_to_list(ALL_GENERATORS_ID,"fctr.cpp")
	%f_add_to_list(ALL_GENERATORS_ID,"fctr.h")
	%f_add_to_list(ALL_GENERATORS_ID,"fctr.java")
	%f_add_to_list(ALL_GENERATORS_ID,"h")
	%f_add_to_list(ALL_GENERATORS_ID,"i.h")
	%f_add_to_list(ALL_GENERATORS_ID,"idl")
	%f_add_to_list(ALL_GENERATORS_ID,"idl_ami")
	%f_add_to_list(ALL_GENERATORS_ID,"impl.pas")
	%f_add_to_list(ALL_GENERATORS_ID,"intf.pas")
	%f_add_to_list(ALL_GENERATORS_ID,"intf2.pas")
	%f_add_to_list(ALL_GENERATORS_ID,"intf3.pas")
	%f_add_to_list(ALL_GENERATORS_ID,"java")
	%f_add_to_list(ALL_GENERATORS_ID,"js")
	%f_add_to_list(ALL_GENERATORS_ID,"mda")
	%f_add_to_list(ALL_GENERATORS_ID,"mda.inc")
	%f_add_to_list(ALL_GENERATORS_ID,"mpc")
	%f_add_to_list(ALL_GENERATORS_ID,"mpc.dll")
	%f_add_to_list(ALL_GENERATORS_ID,"mpc2")
	%f_add_to_list(ALL_GENERATORS_ID,"odl")
	%f_add_to_list(ALL_GENERATORS_ID,"output.classpath")
	%f_add_to_list(ALL_GENERATORS_ID,"output.project")
	%f_add_to_list(ALL_GENERATORS_ID,"output.xml")
	%f_add_to_list(ALL_GENERATORS_ID,"pas")
	%f_add_to_list(ALL_GENERATORS_ID,"pas.script")
	%f_add_to_list(ALL_GENERATORS_ID,"pas.script.runner")
	%f_add_to_list(ALL_GENERATORS_ID,"rc")
	%f_add_to_list(ALL_GENERATORS_ID,"s.ini")
	%f_add_to_list(ALL_GENERATORS_ID,"s.reg")
	%f_add_to_list(ALL_GENERATORS_ID,"spell")
	%f_add_to_list(ALL_GENERATORS_ID,"tpi.script")
	%f_add_to_list(ALL_GENERATORS_ID,"vi.rc")
	%f_add_to_list(ALL_GENERATORS_ID,"vi.rch")
	%f_add_to_list(ALL_GENERATORS_ID,"vm")
	%f_add_to_list(ALL_GENERATORS_ID,"wiki")]

Reports definitions:
group "All" {

# ./../CoreTemplates/Integrated/Root/Design.tpi
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
