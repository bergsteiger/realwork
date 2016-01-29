MDA GENERATOR TEMPLATE FILE

//////////////////////////////////////////////////////////////////////////////////////////////////
// ������� MDA.
//////////////////////////////////////////////////////////////////////////////////////////////////

Generator definitions:
group "All" {
//#UC START# *46A730E30341gen*
	group "CORBA IDL" {
		generator "idl" {
			Description: GCM IDL file (.idl)
			lid: idl
		}
		
		generator "idl_ami" {
			Description: GCM IDL separete file for AMI (.idl)
			lid: idl
		}
	}
	
	group "C++ ���������� � ����������" {
		generator "h" {
			Description: C++ header files (.h)
			lid: cpp
			ifdef_suffix: H
		}
	
		generator "cpp" {
			Description: C++ implementation files (.cpp)
			lid: cpp
		}
		
		generator "i.h" {
			Description: C++ inline impl. files (.i.h)
			lid: cpp
		}
	
		generator "fctr.h" {
			Description: C++ Interface Factories header files (.h)
			lid: cpp
			ifdef_suffix: FCTR_H
		}
	
		generator "fctr.cpp" {
			Description: C++ Interface Factories implementation files (.cpp)
			lid: cpp
		}
		group "��������� �����" {
			generator "mpc" {
				Description: MPC/MWC Project File (mpc/mwc)
			}
			
			generator "mpc2" {
				Description: Additional MPC (mpc)
			}
			
			generator "s.reg" {
				Description: Initial regestry export (reg)
			}
			
			generator "s.ini" {
				Description: Settings file (ini)
			}
			
			generator "vi.rc" {
				Description: Virsion info (rc)
			}
			
			generator "vi.rch" {
				Description: Virsion info (rchj)
			}
			
			generator "rc" {
				Description: ����� �������� (rc)
			}
		}
	}
	
	group "COM" {
			generator "odl" {
				Description: ODL file (.odl)
				lid: cpp
			}
			
			generator "com.def" {
				Description: COM DLL export definitiopn (def)
			}
			
			generator "com.rgs" {
				Description: COM DLL regestry definitiopn (rgs)
			}
			
	}

	group "Java" {
			group "��������� �����" {
				generator "output.project" {
					Description: ��������� ������ �������
					lid: xml
				}
				generator "output.xml" {
					Description: ��������� ������ � ��������� ��������
					lid: xml
				}
				generator "output.classpath" {
					Description: ��������� ������ � ��������� ����� ������� ��� Eclipse 
					lid: xml
				}
				generator "build.xml" {
					Description: ��������� ������ ��� ������ 
					lid: xml
				}
				generator "Makejar.launch" {
					Description: ��������� ������ ��� ������������ � ������� ������ 
					lid: xml
				}
			}
			
			generator "fctr.java" {
				Description: Java Interface Factories implementation files (.java)
				lid: java
			}
			
			generator "java" {
				Description: Java class implementation (.java)
				lid: java
			}
			
	}

	group "������-DLL �������" {	
		generator "mpc.dll" {
			Description: MPC ��� TIE-������� (.mpc)
		}
		
		generator "dll.h" {
			Description: �++ TIE-������� ��� DLL (_tie.h)
			lid: dll_cpp
			ifdef_suffix: TIE_H
		}
	
		generator "dll.cpp" {
			Description: �++ TIE-������� ��� DLL (_tie.cpp)
			lid: dll_cpp
		}
		
		generator "dll.pas" {
			Description: Delphi ������� ��� DLL (.pas)
			lid: delphi
		}		
	}
	
	group "������ ��� ������" {
		generator "ant.xml" {
			Description: ������ ��� Ant'� (.xml)
		}
		generator "ant.bat" {
			Description: ������� ��� �������(.bat)
		}
	}

//#UC END# *46A730E30341gen*
	group "�������������� ����������" {
		generator "wiki" {
			Description: ��������� ��������� ������ � wiki-�����������
			lid: wiki
		}
		generator "xml" {
			Description: ��������� ��������� ������ � ���� xml-�����
			lid: xml
		}
	}
	group "Delphi ���������� � ����������" {
		generator "pas" {
			Description: Description: Delphi ���������� ��� �������� (.pas)
			lid: delphi
		}
		generator "intf.pas" {
			Description: Description: ������ Delphi ���������� (.pas)
			lid: delphi
		}
		generator "impl.pas" {
			Description: Description: ���������� �� Delphi(.pas)
			lid: delphi
		}
	}
	group "EVD-�����" {
		generator "evd.pas" {
			Description: ��������� �������� ����� ��������� � ��� �� Delphi (_schema.pas)
			lid: evd_pas
		}
	}
	group "MDA" {
		generator "mda" {
			Description: ��������� �������� �����������
			lid: mda
		}
	}
	group "WEB" {
		generator "web" {
			Description: ��������� WEB-����������
			lid: web
		}
	}
	group "���������� ������ VCM." {
		generator "vcm.pas" {
			Description: ��������� ��������� VCM � Delphi.
			lid: delphi
		}
	}

}

Stereotype definitions:

//////////////////////////////////////////////////////////////////////////////////
// default

: default
//#UC START# *46A730E30341def*
+ h
P
	<%CX>

+ com.def
= h

+ com.rgs
= h

+ odl
= h

+ cpp
= h

+ i.h
= h

+ dll.cpp
= h

+ dll.h
= h

+ idl
= h

+ idl_ami
= h

+ pas
= h

+ dll.pas
= h

+ fctr.h
= h

+ fctr.cpp
= h

+ mpc
= h

+ mpc2
= mpc

+ mpc.dll
= mpc

+ vi.rc
= h
		
+ vi.rch
= h

+ rc
= h

+ s.reg
= h

+ s.ini
= s.reg

+ xml	
= h

+ output.project
= h

+ java
= h

+ output.classpath
= h

+ output.xml
= h

+ fctr.java
= h

+ build.xml
= h

+ Makejar.launch
= h

+ ant.xml
= h

+ ant.bat
= ant.xml

+ wiki
= h

+ evd.pas
= h
//#UC END# *46A730E30341def*

//////////////////////////////////////////////////////////////////////////////////
// default Category

: default::Category
= default
> default::Category
> MDAPrj::Category
> Project::Category
> UMLModule::Category
> ServerLibrary::Category
> WEBProject::Category
> VCMProject::Category

//////////////////////////////////////////////////////////////////////////////////
// includes

# MDAGen/Core/Core_lib
# MDAGen/CommonLang/CommonLang_lib
# MDAGen/MDA/MDA_lib
# MDAGen/WEB/WEB_lib
# MDAGen/VCM/VCM_lib	

//#UC START# *46A730E30341inc*

# t1_Project

# t2_Library

# MDAGen/tpiUtils
# MDAGen/mdaUtils

# EVD/EvdUtils
# PAS/pasUtils

# t2_Requirements
# t2_ServerLibrary
# t2_ExeTarget
# t2_AdapterTarget
# t2_ComTarget
# t2_ConfluencePluginTarget
# t2_InstallerTarget

# t3_Unit
# t3_Interface
# t3_ServerInterface
# t3_ComInterface
# t3_Impl
# t3_Views
# t3_LibSupport
# t3_CustomFile
# t3_CustomDirectory

# t4_Servant
# t4_SimpleClass
# t4_CustomFactory
# t4_Constants
# t4_Enum
# t4_Exception
# t4_Struct
# t4_Typedef
# t4_Box
# t4_Deallocator
# t4_containers
# t4_functors
# t4_Interface
# t4_Facet
# t4_ComInterface
# t4_Component
# t4_ComServant
# t4_Valuetype
# t4_UtilityClass
# t4_views_items
# t4_Environment
# t4_InstanceDef
# t4_Union
# t4_UtilityPack
# t4_ServerInterface
# t4_ServerFacet
# t4_LibExecutor
# t4_TypeConvertor
# t4_BitMask
# t4_interceptors
# t4_StateMachine
# t4_Event
# t4_TemplateFunctions

# t0_types
# t0_functions
# t0_config
# t0_constraints
# t0_uml

# GTF/t2_TestSuite
# GTF/t4_TestInterface
# GTF/t4_TestServant

# Confluence/t3_CPluginsPackage
# Confluence/t4_cplugins_items

# MDAGen/EVD/Group_grp
# EVD/EvdModifier
# EVD/EvdStruct
# EVD/EvdTag
# EVD/EvdList
# MDAGen/EVD/Atom_class
# EVD/EvdDataDef
# EVD/EvdFactoryDef
# EVD/EvdFactory
# EVD/EvdTagClass

f _is_unrefensable_int
	[{%SS=Interface|%t_interface(%S)=true}{false}[{<{}{%CS=factory&%CV=PublicAccess|%CS=multy factory&%CV=PublicAccess}{C}>!=0}{false}true]]

f _can_be_unreferensed
	[{%SC!=Class|%SS=Servant|%f_is_unrefensable_int(%S)=true|%SS=Constants|%SS=Predicate|%SS=BinaryFunctor|%SS=UnaryFunctor|%SS=Generator|%SS=BinaryPredicate|%SS=UtilityPack|%SS=Environment}{false}true]

f _unref_with_gen
	[{<{}{%f_can_be_unreferensed(%c)=true}{C}>=0&<{}{%f_unref_with_gen(%G)=false}{C}>=0}{false}true]

f _must_have_doc
	[{%SS=Interface|%SS=Library|%SS=ServerLibrary|%SS=Unit|%SS=Requirements|%t_interface(%S)=true|%t_interface(%P)=true&%SC!=Dependency|%SV=PublicAccess&%SC!=Dependency&%SC!=Parameter&%PS!=Vector&%PS!=Map&%PS!=HashMap&%PS!=Set&%PS!=Queue&%PS!=UnsortedSet&%PS!=UnsortedMap&%SS!=switch}{false}true]

f _child_must_have_doc
	[{%SV=PublicAccess}{false}[{%SS=SimpleClass|%SS=Servant|%SS=Interface|%SS=Library|%SS=ServerLibrary|%SS=Unit|%SS=Requirements|%t_interface(%S)=true}{false}true]]

f _attrs_need_doc
	[{%t_interface(%P)=true|%PS=Enum|%PS=Constants|%PS=Struct|%PS=Union&%SS!=switch}{false}true]

f _dont_need_doc
	[{%PS=Vector|%PS=Map|%PS=HashMap|%PS=Set|%PS=Queue|%PS=UnsortedSet|%PS=UnsortedMap|%SS=CustomFile|%SS=ctor|%SS=Servant|%SS=ComServant|%SS=Actor|%SS=Impl|%SC=Dependency|%SC=Attribute&%f_attrs_need_doc(%S)=false|%SC=Parameter}{false}true]

//#UC END# *46A730E30341inc*

Reports definitions:

//#UC START# *46A730E30341rep*
group "All" {
group "Design" {
	report "Undocumented items" {
		auto: Warning
		query: {%f_dont_need_doc(%S)=false&"%SD"=""&<{}{%PU=%X%MU}{C%P}>!=0}

		Item name: {\<\<%SS\>\>%SN} : 200
		Model path: {<{/}{}{r}%PN>} : 400
	}
	
	report "Template constraints" {
		auto: Error
		query: {"%S%t_constraint()"!=""}
		Item name: {\<\<%SS\>\>%SN} : 200
		Library: {<{}{%PS=AdapterTarget|%PS=Library|%PS=ServerLibrary|%PS=ExeTarget|%PS=ComTarget|%PS=ConfluencePluginTarget}\<\<%PS\>\>%PN>} : 150	
		Errors: {%S%t_constraint()} : 400
	}
}
}
//#UC END# *46A730E30341rep*

