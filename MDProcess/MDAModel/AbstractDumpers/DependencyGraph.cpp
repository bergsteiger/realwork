////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/DependencyGraph.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::DependencyGraph
//
// Граф зависимости - представляет собой набор элементов дерева генерации, связанных между собой
// связями зависимости.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/DependencyGraph.h"
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"

//#UC START# *476FA2AD0179_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"

#include <boost/graph/graph_utility.hpp>
#include <boost/graph/properties.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/graph/dijkstra_shortest_paths.hpp>
#include <sstream>
#include <boost/graph/visitors.hpp>
#include <boost/graph/depth_first_search.hpp>
#include <boost/graph/breadth_first_search.hpp>
#include <boost/graph/johnson_all_pairs_shortest.hpp>
//#UC END# *476FA2AD0179_CUSTOM_INCLUDES*


//#UC START# *476FA2AD0179*
void DependencyGraph::print_path (const ObjectTreeResolver* from, const ObjectTreeResolver* to) {
	Core::Aptr<Path> path = this->get_path (from, to);
	if (path.is_nil () == false && path->empty () == false) {
		std::ostringstream stream;
		for (
			DependencyGraph::Path::iterator it = path->begin ()
			; it != path->end ()
			; ++it
		) {
			stream << "{" << (*it)->get_full_name () << "}";
			if (std::distance (it, path->end ()) > 1) {
				stream << "->";
			}
		}
		std::string res = stream.str ();
		LOG_D (("Path from (%s) to (%s):", from->get_full_name ().data (), to->get_full_name ().data ()));
		LOG_D (("%s", res.c_str ()));
	} else {
		LOG_D (("Empty path from (%s) to (%s):", from->get_full_name ().data (), to->get_full_name ().data ()));
	}
}

const DependencyGraph::VertexDescriptor DependencyGraph::UNDEFINDED_VERTEX = std::numeric_limits <DependencyGraph::VertexDescriptor>::max ();

DependencyGraph::VertexDescriptor DependencyGraph::add_vertex (const ObjectTreeResolver* otr) {
	VertexDescriptor vertex = get_vertex (otr);
	if (vertex == UNDEFINDED_VERTEX)  {
		vertex = boost::add_vertex (m_graph);
		m_otr2vertex[otr] = vertex;
		if (vertex >= m_vertex2otr.size ()) {
			m_vertex2otr.resize (vertex + 1, 0);
		}
		m_vertex2otr[vertex] = otr;
	}

	return vertex;
}

DependencyGraph::VertexDescriptor DependencyGraph::get_vertex (const ObjectTreeResolver* otr) const {
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	OTR2Vertex::const_iterator it = m_otr2vertex.find (otr);
	return it != m_otr2vertex.end () ? it->second : UNDEFINDED_VERTEX;
}

const ObjectTreeResolver* DependencyGraph::get_otr (const VertexDescriptor& vertex) const {
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	return vertex < m_vertex2otr.size () ? m_vertex2otr[vertex] : 0;
}
//#UC END# *476FA2AD0179*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// блок констант
const DependencyGraph::Distance DependencyGraph::UNDEFINED_DISTANCE = std::numeric_limits <DependencyGraph::Distance>::max (); // константа, определяющая неопределённое расстояние - используется для определения расстояний между недостижимыми вершинами графа

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DependencyGraph::~DependencyGraph () {
	//#UC START# *476FA2AD0179_DESTR_BODY*
	//#UC END# *476FA2AD0179_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавляет ребро в граф между элементами, вес ребра всегда равен 1
void DependencyGraph::add_edge (const ObjectTreeResolver* from, const ObjectTreeResolver* to) {
	//#UC START# *476FA79903D0*

	VertexDescriptor s = add_vertex (from);
	VertexDescriptor t = add_vertex (to);	

	EdgeDescriptor e;
	bool inserted = false;
	boost::tie (e, inserted) = boost::add_edge(s, t, m_graph);
	if (inserted) {
		boost::property_map<Graph, boost::edge_weight_t>::type
		  local_edge_map = boost::get(boost::edge_weight, m_graph);
	    
		boost::put(local_edge_map, e, 1);
	}
	//#UC END# *476FA79903D0*
}

// //рассчитывает расстояния от всех вершин графа до достижимых вершин
void DependencyGraph::calculate_distances () {
	//#UC START# *492657E2000F*
	//Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	typedef boost::graph_traits<Graph>::vertices_size_type vertices_size_type;
	vertices_size_type vertices_count = num_vertices(m_graph);
	
	std::vector<VertexDescriptor> p (vertices_count);
	std::vector<Distance> distances (vertices_count, UNDEFINED_DISTANCE);
	
	boost::graph_traits<Graph>::vertex_iterator vi, vend;
	for(boost::tie(vi,vend) = boost::vertices(m_graph); vi != vend; ++vi) {
		std::fill (p.begin (), p.end (), 0);
		std::fill (distances.begin (), distances.end (), UNDEFINED_DISTANCE);

		VertexDescriptor vertex = *vi;
		p[vertex] = vertex;
		const ObjectTreeResolver* from = get_otr (vertex);
		GDS_ASSERT(from);

		boost::dijkstra_shortest_paths(m_graph, vertex, boost::predecessor_map(&p[0]).distance_map(&distances[0]));
		
		/*
		boost::graph_traits<Graph>::vertex_iterator vvi, vvend;
		PathTableRow& row = m_search_paths[from];

		for (boost::tie(vvi,vvend) = boost::vertices(m_graph); vvi != vvend; ++vvi) {
			VertexDescriptor vv = *vvi;
			if (vv != p[vv]) {			
				const ObjectTreeResolver* to = get_otr (vv);
				Path& path = row[to];
				while (vv != vertex && vv != p[vv] && vv < p.size ()) {
					vv = p[vv];
					if (vv != vertex) {
						const ObjectTreeResolver* otr = get_otr (vv);
						path.insert (path.begin (), otr);
					}
				}
				path.insert (path.begin (), from);
				path.push_back (to);
			}
		}*/

		for (VertexDescriptor it = 0; it < distances.size (); ++it) {
			Distance d = distances[it];
			if (d != UNDEFINED_DISTANCE) {
				const ObjectTreeResolver* to = get_otr (it);
				m_otr_distances[std::make_pair(from, to)] = d;
			}
		}
	}
	//#UC END# *492657E2000F*
}

// возвращает true, если элемент находится в графе
bool DependencyGraph::exists (const ObjectTreeResolver* obj) const {
	//#UC START# *47CE519F009B*
	return get_vertex (obj) != UNDEFINDED_VERTEX;	
	//#UC END# *47CE519F009B*
}

// находит кратчайший путь от вершины from к вершине to в графе
DependencyGraph::Path* DependencyGraph::find_shortest_path (
	const ObjectTreeResolver* from
	, const ObjectTreeResolver* to
) {
	//#UC START# *4926582B006F*
	//Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	typedef boost::graph_traits<Graph>::vertices_size_type vertices_size_type;
	vertices_size_type vertices_count = boost::num_vertices(m_graph);
	
	std::vector<VertexDescriptor> p (vertices_count);
	std::vector<Distance> distances (vertices_count, UNDEFINED_DISTANCE);

	Core::Aptr<DependencyGraph::Path> ret = new DependencyGraph::Path ();

	// The source vertex
	VertexDescriptor vertex = get_vertex (from);
	if (vertex != UNDEFINDED_VERTEX) {
		p[vertex] = vertex;

		boost::dijkstra_shortest_paths(m_graph, vertex, boost::predecessor_map(&p[0]).distance_map(&distances[0]));


		PathTableRow& row = m_search_paths[from];
		row.clear ();
		boost::graph_traits<Graph>::vertex_iterator vvi, vvend;

		for (boost::tie(vvi,vvend) = boost::vertices(m_graph); vvi != vvend; ++vvi) {
			VertexDescriptor vv = *vvi;
			if (vv != p[vv]) {			
				const ObjectTreeResolver* dest = get_otr (vv);
				Path& path = row[dest];
				path.clear ();
				while (vv != vertex && vv != p[vv] && vv < p.size ()) {
					vv = p[vv];
					if (vv != vertex) {
						const ObjectTreeResolver* otr = get_otr (vv);
						path.insert (path.begin (), otr);
					}
				}
				path.insert (path.begin (), from);
				path.push_back (dest);
				
				if (dest == to) {
					ret->assign (path.begin (), path.end ());
				}
			}
		}
	}

	return ret.forget ();
	//#UC END# *4926582B006F*
}

// возвращает кратчайшее расстояние между элементами в графе
DependencyGraph::Distance DependencyGraph::get_distance (
	const ObjectTreeResolver* from
	, const ObjectTreeResolver* to
) {
	//#UC START# *476FA7620102*
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatchEx sw ("DependencyGraph::get_distance");	
#endif
	if (m_otr_distances.empty ()) {
		calculate_distances ();
	}

	OTR2Distance::iterator it = m_otr_distances.find (std::make_pair (from, to));
	return (it != m_otr_distances.end ()) ? it->second : UNDEFINED_DISTANCE;
	//#UC END# *476FA7620102*
}

// возвращает список вершин, которые были пройдены при вычислении кратчайшего пути от from к to
DependencyGraph::Path* DependencyGraph::get_path (const ObjectTreeResolver* from, const ObjectTreeResolver* to) {
	//#UC START# *476FA6D6024F*
	class local {
	public:
		static void fill_path (
			const ObjectTreeResolver* to
			, const DependencyGraph::PathTableRow& full_path
			, DependencyGraph::Path& to_path
		) {
			PathTableRow::const_iterator to_it = full_path.find (to);
			if (to_it != full_path.end ()) {
				to_path.assign (to_it->second.begin (), to_it->second.end ());
			}
		}
	};
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);

	/*if (m_otr_distances.empty ()) {
		calculate_distances ();
	}*/

	Core::Aptr<DependencyGraph::Path> ret = new DependencyGraph::Path ();
	PathTable::iterator it = m_search_paths.find (from);
	if (it != m_search_paths.end ()) {		
		local::fill_path (to, it->second, *ret);
	} else {
		ret = find_shortest_path (from, to);
	}
	return ret.forget ();
	//#UC END# *476FA6D6024F*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

