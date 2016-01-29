MDA GENERATOR TEMPLATE FILE

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/DDT/DDT.tpl"
// ��������� ����-��������
// Generated from UML model, root element: <<MDATemplates::Category>> MDProcess::DDT
//
// ������� ��� �������� ������������� ������� ������
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
		generator "dfm" {
			Description: ��������� ������ ���� (.dfm)
		}
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
		generator "sd" {
			Description: ������� TC (.sd)
			lid: TC
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

	group "��������� ��������" {
		generator "config" {
			Description: ��������� �������� � ini-���� (.ini)
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

	group "�������� ��������" {
		generator "test_scenario.txt" {
			Description: ���� �� ��������� ������������
		}
	}

	group "����-MDA" {
		generator "mda" {
			Description: ��������� ����-��������
		}
		generator "mda.inc" {
			Description: ��������� ������ ��������� ����-�������� (mda.inc)
		}
		group "��������� �����" {
			generator "ue_prj" {
				Description: ��������� ������� ��� UE
			}
		}
	}

	group "ModelBuilding" {
		generator "spell" {
			Description: ��������� ���������� ����������� ��������� ������ - ����������� �� ��������� ���������� ����������
		}
	}

	group "������������" {
		generator "link_to_requests_hack" {
			Description: ��� ��� [$281531116]
		}
		generator "wiki" {
			Description: ��������� ������ � MDKnow
		}
		group "ModelSerialize" {
			generator "forth_structure" {
				Description: ��������� ��������� ������ � �������� �� ����� FORTH
				lid: forth
			}
			generator "structure" {
				Description: ��������� ��������� ������ � ����� ������ ��������
			}
		}
	}

	group "����������" {
		generator "g.cpp" {
			Description: ��������� ���������� ��� ANTLR (������� ���� c++)
		}
		generator "g.java" {
			Description: ��������� ���������� ��� ANTLR (������� ���� java)
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

+ dfm
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

+ sd
P
	<%CX>

+ fctr.java
P
	<%CX>

+ java
P
	<%CX>

+ config
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

+ test_scenario.txt
P
	<%CX>

+ mda
P
	<%CX>

+ mda.inc
P
	<%CX>

+ ue_prj
P
	<%CX>

+ spell
P
	<%CX>

+ forth_structure
P
	<%CX>

+ structure
P
	<%CX>

+ link_to_requests_hack
P
	<%CX>

+ wiki
P
	<%CX>

+ g.cpp
P
	<%CX>

+ g.java
P
	<%CX>


# ./DDT.inc.tpi

f _all_generators
	[%f_clear_list(ALL_GENERATORS_ID)
	%f_add_to_list(ALL_GENERATORS_ID,"Makejar.launch")
	%f_add_to_list(ALL_GENERATORS_ID,"ant.bat")
	%f_add_to_list(ALL_GENERATORS_ID,"ant.xml")
	%f_add_to_list(ALL_GENERATORS_ID,"build.xml")
	%f_add_to_list(ALL_GENERATORS_ID,"com.def")
	%f_add_to_list(ALL_GENERATORS_ID,"com.rgs")
	%f_add_to_list(ALL_GENERATORS_ID,"config")
	%f_add_to_list(ALL_GENERATORS_ID,"cpp")
	%f_add_to_list(ALL_GENERATORS_ID,"dfm")
	%f_add_to_list(ALL_GENERATORS_ID,"dll.cpp")
	%f_add_to_list(ALL_GENERATORS_ID,"dll.h")
	%f_add_to_list(ALL_GENERATORS_ID,"fctr.cpp")
	%f_add_to_list(ALL_GENERATORS_ID,"fctr.h")
	%f_add_to_list(ALL_GENERATORS_ID,"fctr.java")
	%f_add_to_list(ALL_GENERATORS_ID,"forth_structure")
	%f_add_to_list(ALL_GENERATORS_ID,"g.cpp")
	%f_add_to_list(ALL_GENERATORS_ID,"g.java")
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
	%f_add_to_list(ALL_GENERATORS_ID,"link_to_requests_hack")
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
	%f_add_to_list(ALL_GENERATORS_ID,"rc")
	%f_add_to_list(ALL_GENERATORS_ID,"s.ini")
	%f_add_to_list(ALL_GENERATORS_ID,"s.reg")
	%f_add_to_list(ALL_GENERATORS_ID,"sd")
	%f_add_to_list(ALL_GENERATORS_ID,"spell")
	%f_add_to_list(ALL_GENERATORS_ID,"structure")
	%f_add_to_list(ALL_GENERATORS_ID,"test_scenario.txt")
	%f_add_to_list(ALL_GENERATORS_ID,"ue_prj")
	%f_add_to_list(ALL_GENERATORS_ID,"vi.rc")
	%f_add_to_list(ALL_GENERATORS_ID,"vi.rch")
	%f_add_to_list(ALL_GENERATORS_ID,"vm")
	%f_add_to_list(ALL_GENERATORS_ID,"wiki")]

Reports definitions:
group "All" {

# ./../CoreTemplates/Integrated/Root/Design.tpi
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
