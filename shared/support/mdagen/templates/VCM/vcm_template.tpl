MDA GENERATOR TEMPLATE FILE
// template for DLL-adapters generation

Generator definitions:
group "All" {
	group "VCM-framework" {
		generator "vcm" {
			Description: VCM генератор (.pas)
			lid: delphi
		}
		
	}

	group "Дополнительная информация" {
		generator "inf" {
			Description: Full Model's Elements Catalog (.txt)
		}
	
		generator "unusable.txt" {
			Description: Find all unusable items
		}
		
		generator "doc" {
			Description: Быстрая документация (описание с модели)
		}
	}
}

Stereotype definitions:

: default
+ inf
	#[\<\<%SS\>\> ]%SN (%SM)
	<{}{}{Sn}%CX>

+ doc
	[{"%SC"="Category"|"%SC"="Class"}#***** \<\<%SM\>\> %SN *****
	# описание: %SD][{"%SC"!="Category"&"%SC"!="Class"}#%SC: %SN[ - %SD]]
	<{}{}{Sn}%CX>
+ vcm
	<%CX>
	
: Project::Category
+ vcm
P
C /%SN
	<%CX>

: VCM Entity::Class
$ C 200,200,255
a s
+ vcm
	<%CX>
	
: VCM Entity::Class::Operation
a t
m t
+ vcm
	<%CX>

: VCM Form::Class
$ C 200,200,200
$ S
$ s
+ vcm
	<%CX>

: VCM Controller::Class
$ C 200,255,200
$ S
$ s
+ vcm
	<%CX>

: VCM Menu::Class
$ C 230,230,230
$ S
$ s
d 1
+ vcm
	<%CX>

# w:/common/model/templates/t_fixed
# w:/common/model/templates/integrated/t_type
# w:/common/model/templates/integrated/t_simple_type
