MDA GENERATOR TEMPLATE FILE

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/DelphiSpecific/DelphiSpecific.tpl"
// Генерация мета-шаблонов
// Generated from UML model, root element: <<MDATemplates::Category>> MDProcess$ForDelphi::DelphiSpecific
//
// Модель шаблонов, описания стереотипов специфичных для дельфи
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Generator definitions:
group "All" {

	group "C++ интерфейсы и реализация" {
		generator "cpp" {
			Description: генератор файлов реализации C++ (.cpp)
			lid: cpp
		}
		generator "h" {
			Description: генератор заголовочных файлов C++ (.h)
			lid: cpp
			ifdef_suffix: H
		}
		generator "i.h" {
			Description: генератор inline файлов реализации C++ (.i.h)
			lid: cpp
		}
		group "Проектные файлы C++" {
			generator "mpc" {
				Description: mpc/mwc файлы проектов (mpc/mwc)
			}
			generator "mpc2" {
				Description: дополнительные файлы проектов (mpc)
			}
			generator "rc" {
				Description: Файлы ресурсов (rc)
			}
			generator "s.ini" {
				Description: файл настроек (.ini)
			}
			generator "s.reg" {
				Description: настройки реестра (.reg)
			}
			generator "vi.rc" {
				Description: информация о версии (.rc)
			}
			generator "vi.rch" {
				Description: информация о версии (.rch)
			}
		}
		group "C++ Фабрики" {
			generator "fctr.cpp" {
				Description: генератор файлов реализации для фабрик интерфейсов (.cpp)
				lid: cpp
			}
			generator "fctr.h" {
				Description: генератор заголовочных файлов для фабрик интерфейсов (.h)
				lid: cpp
				ifdef_suffix: FCTR_H
			}
		}
	}

	group "COM" {
		generator "com.def" {
			Description: генерация файла экспорта определений для COM DLL (.def)
		}
		generator "com.rgs" {
			Description: генерация файла опрделений для регистрации COM DLL (.rgs)
		}
		generator "odl" {
			Description: генератор ODL-файла спецификации COM-интерфейса (.odl)
			lid: cpp
		}
	}

	group "CORBA IDL" {
		generator "idl" {
			Description: генератор idl спецификаций (.idl)
			lid: idl
		}
		generator "idl_ami" {
			Description: генератор idl спецификаций для AMI (.idl)
			lid: idl
		}
	}

	group "Delphi интерфейсы и реализация" {
		generator "impl.pas" {
			Description: Реализация на Delphi(.pas)
			lid: delphi
		}
		generator "intf.pas" {
			Description: Родные Delphi интерфейсы (.pas)
			lid: delphi
		}
		generator "intf2.pas" {
			Description: Вторая интерфейсная секция стереотипа. Например реализация свойств класса.
			lid: delphi
		}
		generator "intf3.pas" {
			Description: 3-я секция интерфейса. Например поле для свойства.
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
			Description: генератор реализации фабрик интерфейсов на java (.java)
			lid: java
		}
		generator "java" {
			Description: генератор классов, интерфейсов на java (.java)
			lid: java
		}
		group "Проектные файлы Java" {
			generator "Makejar.launch" {
				Description: Генерация файлов для конфигурации и запуска сборки
				lid: xml
			}
			generator "build.xml" {
				Description: генерация файлов для сборки в Ecllipse
				lid: xml
			}
			generator "output.classpath" {
				Description: генерация файла с описанием путей поиска библиотек (CLASSPATH для java)
				lid: xml
			}
			generator "output.project" {
				Description: генерация файлов проекта для Ecllipse
				lid: xml
			}
			generator "output.xml" {
				Description: генератор файлов с описанием плагинов для Confluence
				lid: xml
			}
		}
	}

	group "Генерация для Web" {
		group "Генерация Velocity" {
			generator "vm" {
				Description: генератор VM
			}
		}
		group "Генерация JavaScript" {
			generator "js" {
				Description: генератор JavaScript
			}
		}
	}

	group "Дельфи-DLL Адаптер" {
		generator "dll.cpp" {
			Description: С++ TIE-обвязка для DLL (_tie.cpp)
			lid: dll_cpp
		}
		generator "dll.h" {
			Description: С++ TIE-обвязка для DLL (_tie.h)
			lid: dll_cpp
			ifdef_suffix: TIE_H
		}
		generator "pas" {
			Description: Delphi интерфейсы для адаптера (.pas)
			lid: delphi
		}
	}

	group "Дельфи-DLL Адаптер проектные файлы" {
		generator "mpc.dll" {
			Description: MPC для TIE-обвязки (.mpc)
		}
	}

	group "Скрипт для сборки" {
		generator "ant.bat" {
			Description: Пускачь для скрипта (.bat)
		}
		generator "ant.xml" {
			Description: Скрипт для Ant'а (.xml)
		}
	}

	group "Мета-MDA" {
		generator "mda" {
			Description: Генерация мета-шаблонов
		}
		generator "mda.inc" {
			Description: Генерация списка включения мета-шаблонов (mda.inc)
		}
		generator "tpi.script" {
			Description: 
			lid: script
		}
	}

	group "ModelBuilding" {
		generator "spell" {
			Description: генератор построения виртуальных элементов модели - запускается до генерации конкретных артефактов
		}
	}

	group "Документация" {
		generator "wiki" {
			Description: Генерация модели в MDKnow
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
