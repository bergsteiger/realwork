MDA GENERATOR TEMPLATE FILE

//////////////////////////////////////////////////////////////////////////////////////////////////
// common template for all types of targets
//////////////////////////////////////////////////////////////////////////////////////////////////

Generator definitions:

Stereotype definitions:

: default::Category

: UML::Class
$ C 170,225,245
a ra
< *::Class, *::Category

: UML::Class::Operation
: UML::Class::Attribute
: UML::Class::sequence::Attribute
: UML::Class::реализует::ClassDependency


: CRM::Class
$ C 215,215,255
a ra
< *::Class, *::Category

: CRM::Class::Operation
: CRM::Class::Attribute
: CRM::Class::sequence::Attribute

: Wiki::Class
$ C 255,215,215
a ra
< *::Class, *::Category

: Wiki::Class::Operation
: Wiki::Class::Attribute
: Wiki::Class::sequence::Attribute


: System::Class
< *::Class, *::Category
$ C 215,255,215
: System::Class::Operation
: System::Class::Attribute
: System::Class::sequence::Attribute
: System::Class::интеграция::ClassDependency