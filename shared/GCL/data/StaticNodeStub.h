////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/StaticNodeStub.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::StaticNodeStub
//
// реализация ноды-заглушки, которая может быть вставлена в дерево StaticNode и эмулировать
// заданное кол-во элементов одного уровня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_STATICNODESTUB_H__
#define __SHARED_GCL_DATA_STATICNODESTUB_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/StaticNodeStubBase.h"

//#UC START# *450136CE01F4_CUSTOM_INCLUDES*
#include "shared/Core/mng/PoolObjectManager.h"
#include "shared/GCL/data/StaticNodeMng.h"

namespace GCL {
struct NullStubPostProcess {
	void operator () (GCL::StaticNode*, GCL::StaticNode*) {}
};
}
//#UC END# *450136CE01F4_CUSTOM_INCLUDES*

namespace GCL {

// реализация ноды-заглушки, которая может быть вставлена в дерево StaticNode и эмулировать
// заданное кол-во элементов одного уровня
template <class _StubImpl>
class StaticNodeStub :
	virtual public StaticNodeStubBase
{
	SET_OBJECT_COUNTER (StaticNodeStub)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~StaticNodeStub ();


//#UC START# *450136CE01F4*
	template <typename StubPostProcess>
	static void make_as_back_child (GCL::StaticNode* parent, unsigned long count, StaticNodeMng* mng, StubPostProcess post_process) {
		GDS_ASSERT (count); 

		_StubImpl* st1 = NodeStubPool::instance()->new_obj();//new _StubImpl ();
		_StubImpl* st2 = 0;

		if (count>1) {
			st2 = NodeStubPool::instance()->new_obj();//new _StubImpl ();
			count--;
		}

		SharedData_box d = new SharedData(count, st1, st2, mng);
		st1->init (d, 0, 0);
		parent->insert_back_child(st1);
		
		if (st2) {
			d = new SharedData(-static_cast<long>(count), st2, st1, mng);
			st2->init(d, 0, 0);
			parent->insert_back_child(st2);
		}
		
		post_process (st1, st2); // may be we need to add similar 'processer' to other 'make_as_x_child'
	}

	static void make_as_front_child (GCL::StaticNode* parent, unsigned long count, StaticNodeMng* mng) {
		GDS_ASSERT (count); 

		_StubImpl* st1 = NodeStubPool::instance()->new_obj();//new _StubImpl ();
		_StubImpl* st2 = 0;

		if (count>1) {
			st2 = NodeStubPool::instance()->new_obj();//new _StubImpl ();
			count--;
		}

		SharedData_box d = new SharedData(count, st1, st2, mng);
		st1->init (d, 0, 0);
		parent->insert_front_child(st1);
		
		if (st2) {
			d = new SharedData(-static_cast<long>(count), st2, st1, mng);
			st2->init(d, 0, 0);
			st1->insert_next(st2);
		}
	}


	static void make_as_next_sibling (GCL::StaticNode* left_sibling, unsigned long count, StaticNodeMng* mng) {
		GDS_ASSERT (count); 

		StaticNodeStub* sns = dynamic_cast<StaticNodeStub*> (left_sibling);
		if (sns) {
			sns->resize_stub (count);
		} else {
			_StubImpl* st1 = NodeStubPool::instance()->new_obj();//new _StubImpl ();
			_StubImpl* st2 = 0;

			if (count>1) {
				st2 = NodeStubPool::instance()->new_obj();//new _StubImpl ();
				count--;
			}

			SharedData_box d = new SharedData(count, st1, st2, mng);
			st1->init (d, 0, 0);
			left_sibling->insert_next(st1);
			
			if (st2) {
				d = new SharedData(-static_cast<long>(count), st2, st1, mng);
				st2->init(d, 0, 0);
				st1->insert_next(st2);
			}
		}
	}

	static void make_as_prev_sibling (GCL::StaticNode* sibling, unsigned long count, StaticNodeMng* mng) {
		GDS_ASSERT (count); 

		StaticNodeStub* sns = dynamic_cast<StaticNodeStub*> (sibling);
		if (sns) {
			GDS_ASSERT (false); // need to check this code
			sns->resize_stub (count);
		} else {
			_StubImpl* st1 = NodeStubPool::instance()->new_obj();//new _StubImpl ();
			_StubImpl* st2 = 0;

			if (count>1) {
				st2 = NodeStubPool::instance()->new_obj();//new _StubImpl ();
				count--;
			}

			SharedData_box d = new SharedData(count, st1, st2, mng);
			st1->init (d, 0, 0);
					
			if (st2) {
				d = new SharedData(-static_cast<long>(count), st2, st1, mng);
				st2->init(d, 0, 0);
				sibling->insert_prev(st2);
				st2->insert_prev(st1);
			} else {
				sibling->insert_prev(st1);
			}
		}
	}

public:	
	bool has_pair () const {
		return m_data->negative_pair != 0;
	}

	long stub_count () const {
		return m_data->stub_count;
	}

	long stub_ind () const {
		return m_ind;
	}

	typedef Core::Var<StaticNodeStub> StaticNodeStub_var;

	StaticNodeStubBase* const get_at (long ind) const {
		GDS_ASSERT (m_data->stub_count > 0 ? ind < m_data->stub_count && ind >= 0 : ind > m_data->stub_count && ind <= 0);
		GDS_ASSERT (ind != m_ind);
		
		return this->make(ind);		
	}

	virtual StaticNode* transform_to_real_node () {
		
		//LOG_D (("TRANSFORM_TO_REAL_NODE (%d,%d)", this->stub_count(), this->stub_ind()));
		//m_data->owner->m_parent->print_tree ();
		
		StaticNode* ret_val = m_real_node;

		if (!m_real_node) {
			bool am_i_positive = m_data->stub_count > 0;
			long offset = am_i_positive ? m_ind + 1 : m_ind - 1;
			const GCL::StaticNode* point;
			
			if (am_i_positive) {
				point = m_data->owner->m_prev;
				if (!point) {
					offset--;
				}
			} else {
				if (m_data->negative_pair) {
					point = m_data->negative_pair->m_prev;
					offset = m_ind - m_data->stub_count + 1;
				} else {
					point = m_data->owner->m_prev;
					offset = m_ind - m_data->stub_count;
				}				
			}


			// при входе в make_real_node point должен указывать на реальную ноду
			// (т.е. должен приводится к NodeBase: dynamic_cast<Nodebase*> (point) != 0
			// для этого необходим рекурсивный проход по предыдушим нодам с коррекцией offset
			// последняя версия этого цикла писалась для [$278832098]
			
			while (point && dynamic_cast<const StaticNodeStub*> (point)) {
				
				GDS_ASSERT (am_i_positive); // хрен знает чего случиться, если мы сюда попадем с am_i_positive == false
				                            // может быть надо крутить такой же цикл но с уменьшением offset'а
				                            // а и может двигаться надо не вверх а вниз ? ...
				
				// тут мы на нижей паре заглушки или на одинарной заглушке
				if (!StaticNode::shift_prev (point)) {
					break;                                          // достигли parent'а, т.е. вся ветка сверху - одни заглушки
				}
			
				const StaticNodeStub* stub = dynamic_cast<const StaticNodeStub*> (point);
				
				if (!stub) {
					++offset;                                       // до сдвига мы были на одинарной заглушке,
					break;                                          // сейчас на реальной ноде => выходим
				}

				// тут мы на верхней паре заглушки или на предыдущей одинарной заглушке
				if (stub->stub_count () == 1)  {                    
					offset += stub->stub_count ();                  // одинарная заглушка
				} else {                                            
					offset += stub->stub_count () + 1;              // верхняя пара заглушки
					StaticNode::shift_prev (point);
				}
			}
			
			ret_val = m_real_node = m_data->mng->make_real_node (m_data->owner->m_parent, point, offset, this);
			GDS_ASSERT (m_real_node);

			this->correct_tree (0, 0);			
		}
		
		//LOG_D (("TREE SNAP after transform_to_real_node ()"));
		//m_real_node->print_tree ();

		return ret_val;
	}
	
	virtual StaticNode* remove_me_and_siblings (unsigned long& count) {
		GDS_ASSERT (count);
		GDS_ASSERT (m_ind >= 0); // обработка виртуальных отрицательных нод не реализована.
		// Вернее сейчас удаление виртуальной отрицательной ноды 
		// возможно, только если она последняя. Это может быть, если
		// в дереве 61 нода (по умолчанию загружается 30 нод сверху и 30 снизу)
		// См. ошибку 22750. Чтобы удалить эту ноду вставили проверку на
		// this->stub_count () == -1 для случая с единственной нодой заглушкой
		
		// single stub node 
		if ((this->stub_count () == 1 || this->stub_count () == -1)  && !this->has_pair ()) {
			StaticNode_var ret = StaticNode::_duplicate (m_next.ptr ());
			this->remove_from_tree ();
			count--;
			return ret._retn();
		} 

		// we have to do with stub pair further
		GDS_ASSERT (this->has_pair ()); 
		
		// попали на нижнюю (отрицательную) заглушку
		if (m_ind == 0 &&  this->stub_count () < 0) {
			count--;
			StaticNode_var ret = StaticNode::_duplicate (m_next.ptr ());
			long new_stub_count = this->stub_count () + 1; // увеличиваем отрицательное значение (по модулю - уменьшаем)

			if (new_stub_count == 0) { // удаляем нижнюю заглушку
				m_data->negative_pair->m_data->negative_pair = 0;
				this->remove_from_tree ();
			} else {
				m_data->stub_count = new_stub_count;
				m_data->negative_pair->m_data->stub_count = -new_stub_count;
			}
			
			return ret._retn();
		}
		
		
		
		// remove pair at all
		if (m_ind == 0 && static_cast<long> (count) > this->stub_count ()) { 
			count -= this->stub_count () + 1;
			StaticNode_var ret = StaticNode::_duplicate (m_data->negative_pair->m_next.ptr ());
			GDS_ASSERT (m_data->owner == this);
			m_data->negative_pair->remove_from_tree ();
			this->remove_from_tree ();
			return ret._retn();
		}
		
		// modify stub pair
		long stub_count = this->stub_count ();
		long count_to_delete = count;
		
		// новый stub_count = индекс + положительная разница между величиной хвоста и кол-вом удаляемых
		long new_stub_count = m_ind + (((stub_count - m_ind) - count_to_delete) > 0 ? (stub_count - m_ind) - count_to_delete : 0);
		// модифицированный count = положительной разнице между кол-вом удаляемых и величиной хвоста
		long new_count_to_delete = (count_to_delete - (stub_count - m_ind)) > 0 ? count_to_delete - (stub_count - m_ind) : 0;
		
		StaticNode_var ret = StaticNode::_duplicate (m_data->negative_pair->m_next.ptr ());

		// если удаляем от верхней заглушки кол-во эл-тов равное stub_count => остается единственная (нижняя) заглушка
		if (m_ind == 0 && static_cast<long> (count) == this->stub_count ()) {
			new_stub_count += 1; // требуется коррекция stub_count, высчитанного по формуле выше (сказывается неявное участие второй заглушки)
			m_data->negative_pair->remove_from_tree ();
			m_data->negative_pair = 0;
			GDS_ASSERT (new_stub_count == 1);
			GDS_ASSERT (new_count_to_delete == 0);
		}
		
		// если удаляем с первого эл-та по нижнюю заглушку включительно => остается единственная (верхняя) заглушка
		if (m_ind == 1 && static_cast<long> (count) >= this->stub_count ()) {
			new_count_to_delete -= 1; // требуется коррекция new_count_to_delete, высчитанного по формуле выше (неявное участие второй заглушки)
			m_data->negative_pair->remove_from_tree ();
			m_data->negative_pair = 0;
			GDS_ASSERT (new_stub_count == 1);
		}
		
		// основная коррекция данных
		m_data->stub_count = new_stub_count;
		count = new_count_to_delete;
		
		if (m_data->negative_pair) {
			m_data->negative_pair->m_data->stub_count = -new_stub_count;
		}
		
		// если последний удаляемый внутри интервала, возвращаем указаталь на эл-т внутри интевала
		if (static_cast<long> (count) < this->stub_count () - m_ind) { 
			if (m_ind) {
				ret = m_data->owner->get_at (m_ind);
			} else {
				ret = GCL::StaticNode::_duplicate(this);
			}
		}
		
		GDS_ASSERT (this->stub_count () > 0);
	
		return ret._retn();
	}

	void correct_tree (StaticNodeStubBase* prev_sibbling_stub, StaticNodeStubBase* next_sibbling_stub) {
		bool am_i_positive = m_data->stub_count > 0;			
		long offset = am_i_positive ? m_ind + 1 : m_ind - 1;

		long remain_count = m_data->stub_count - offset;
		
		if (remain_count) {			
			StaticNodeStub* l;
			if (am_i_positive ? next_sibbling_stub : prev_sibbling_stub) {
				l = dynamic_cast<StaticNodeStub*>(am_i_positive ? next_sibbling_stub : prev_sibbling_stub);
				GDS_ASSERT (l);
				StaticNode::_duplicate (l);
			} else {
				l = NodeStubPool::instance()->new_obj();
			}

			{
				SharedData_box data (new SharedData(remain_count, l, m_data->negative_pair, m_data->mng));
				l->init (data, 0, this);
				if (m_data->negative_pair) {
					m_data->negative_pair->reset_pair(data.in());
				}
			}				
			
			if (am_i_positive) {
				m_data->owner->insert_next (l);
			} else {
				m_data->owner->insert_prev (l);
			}
		} else {
			if (m_data->negative_pair) {
				m_data->negative_pair->reset_pair(0);
			}
		}

		if (am_i_positive) {
			m_data->owner->insert_next (m_real_node);
		} else {
			m_data->owner->insert_prev (m_real_node);
		}

		if (m_ind) { // i am slave
			m_data->stub_count = am_i_positive ? m_ind - 1 : m_ind + 1;
			
			if (m_data->stub_count) {
				StaticNodeStub* l;
				if (am_i_positive ? prev_sibbling_stub : next_sibbling_stub) {
					l = dynamic_cast<StaticNodeStub*>(am_i_positive ? prev_sibbling_stub : next_sibbling_stub);
					GDS_ASSERT (l);
				} else {
					l = NodeStubPool::instance()->new_obj();
				}

				{
					SharedData_box data (new SharedData(-m_data->stub_count, l, m_data->owner, m_data->mng));
					l->init (data, 0, this);
					m_data->owner->reset_pair(data.in());
				}

				if (am_i_positive) {
					m_data->owner->insert_next (l);
				} else {
					m_data->owner->insert_prev (l);
				}
			} else {
				m_data->stub_count = am_i_positive ? 1 : -1;
				m_data->owner->reset_pair (0);
			}
		}

		const_cast<StaticNodeStub*>(this)->remove_from_tree();		
	}

	virtual GCL::StaticNode* next () {
		return const_cast<GCL::StaticNode*>(((const StaticNodeStub*const)this)->next());
	}
	virtual const GCL::StaticNode* next () const {
		if (m_real_node) {
			return m_real_node->next();			
		}  

		if (m_data->stub_count > 0) {
			if (m_data->owner == this) {
				if (m_data->stub_count > 1) {
					return this->make(1);
				} else {
					return m_next._sretn();
				}
			} else {
				if (m_ind < m_data->stub_count - 1) {
					return this->make (m_ind + 1);
				} else {
					return m_data->owner->m_next._sretn();
				}
			}
		} else {
			if (m_data->owner == this) {
				return m_next._sretn();
			} else {
				return this->make (m_ind + 1);
			}
		}
	}

	virtual GCL::StaticNode* prev () {
		return const_cast<GCL::StaticNode*>(((const StaticNodeStub*const)this)->prev());
	}
	virtual const GCL::StaticNode* prev () const {
		if (m_real_node) {
			return m_real_node->prev();
		}

		if (m_data->stub_count > 0) {
			if (m_data->owner == this) {
				return Core::IObject::_duplicate(m_prev);
			} else {
				return this->make (m_ind - 1);
			}
		} else {
			if (m_data->owner == this) {
				if (m_data->stub_count < -1) {
					return this->make (m_ind - 1);
				} else {
					return Core::IObject::_duplicate(m_prev);
				}
			} else {
				if (m_ind > m_data->stub_count + 1) {
					return this->make (m_ind - 1);
				} else {
					return Core::IObject::_duplicate(m_data->owner->m_prev);
				}
			}
		}
	}

	virtual bool is_equal (const StaticNode* e) const {		
		return (e == this) || (m_real_node && m_real_node == e);
	}

	bool is_last () {
		if (m_real_node) {
			return m_real_node->is_last();
		}
		
		if (m_data->stub_count > 0) {
			if (m_data->owner == this) {
				if (m_data->stub_count > 1) {
					return false;
				} else {
					return m_next.ptr() == 0;
				}
			} else {
				if (m_ind < m_data->stub_count - 1) {
					return false;
				} else {
					return m_data->owner->m_next.ptr() == 0;
				}
			}
		} else {
			if (m_data->owner == this) {
				return m_next.ptr() == 0;
			} else {
				return false;
			}
		}
	}

	// Первый элемент.
	bool is_first () {
		if (m_real_node) {
			return m_real_node->is_first();
		}
		
		if (m_data->stub_count > 0) {
			if (m_data->owner == this) {
				return m_prev == 0;
			} else {
				return false;
			}
		} else {
			if (m_data->owner == this) {
				if (m_data->stub_count < -1) {
					return false;
				} else {
					return m_prev == 0;
				}
			} else {
				if (m_ind > m_data->stub_count + 1) {
					return false;
				} else {
					return m_data->owner->m_prev == 0;
				}
			}
		}
	}

protected:
	typedef typename Core::PoolObjectManager<_StubImpl>::PoolObjectManagerSingleton NodeStubPool;
	typedef Core::PoolObjectManager<_StubImpl> Pool;
	friend Pool;

private:
	struct SharedData {
		long stub_count; // кол-во виртуальных ноду внутри заглушки
		StaticNodeStub* owner; // "основная" заглушка
		StaticNodeStub* negative_pair; // ссылка на парную "отрицательную" заглушку
		StaticNodeMng* mng; // ссылка на менеджера нод

		SharedData (
			long sc
			, StaticNodeStub* owner
			, StaticNodeStub* np
			, StaticNodeMng* m
		) 
			: stub_count(sc)
			, owner(owner)
			, negative_pair(np)
			, mng(m) 
		{
			GDS_ASSERT (stub_count && owner);			
		}
	};

	//typedef Core::Box<SharedData> SharedData_box;

protected:	
	typedef Core::Box<SharedData> SharedData_box; // GARANT_PRIVATE

	StaticNodeStub () {
		m_data = 0;
		m_ind = 0;
		m_real_node = 0;
		m_parent = 0;
	}

	void resize_stub (long delta) {
		if (m_data->stub_count > 0) {
			GDS_ASSERT (m_data->stub_count + delta > 1);

			if (m_data->negative_pair) {
				m_data->stub_count += +delta;
				m_data->negative_pair->m_data->stub_count += -delta;
			} else {
				m_data->stub_count += +delta-1;

				_StubImpl* stub = NodeStubPool::instance ()->new_obj ();
				SharedData_box shared_data = new SharedData (-delta, stub, m_data->owner, m_data->mng);

				stub->init (shared_data, 0, 0);
				m_data->negative_pair = stub;

				this->insert_next (stub);
			}
		} else {
			GDS_ASSERT (-m_data->stub_count + delta > 1);

			if (m_data->negative_pair) {
				m_data->stub_count += -delta;
				m_data->negative_pair->m_data->stub_count += +delta;
			} else {
				m_data->stub_count += -delta+1;

				_StubImpl* stub = NodeStubPool::instance ()->new_obj ();
				SharedData_box shared_data = new SharedData (+delta, stub, m_data->owner, m_data->mng);

				stub->init (shared_data, 0, 0);
				m_data->negative_pair = stub;

				this->insert_prev (stub);
			}
		}
	}


	virtual long get_nodes_count_for_me () {
		return this->stub_count ();
	}

	virtual void init (const SharedData_box& data, long ind, const GCL::StaticNode* master) {
		m_data = data;
		m_ind = ind;
		m_parent = m_data->owner->m_parent;
		m_real_node = 0;
		m_next = 0;
		m_prev = 0;
		m_first_child = 0;
		m_last_child = 0;
		// m_id__ = ++s_id; // debug helper
	}
	
	inline StaticNodeStubBase* make (long ind) const {
		if (ind) {
			register StaticNodeStub* ret = NodeStubPool::instance()->new_obj();
			ret->init(m_data, ind, this);
			return ret;
		} else {
			return Core::IObject::_duplicate(m_data->owner); // !!
		}
	}

	void reset_pair (const SharedData* sd) {
		if (sd) {
			m_data->negative_pair = sd->owner;
			m_data->stub_count = - sd->stub_count;
		} else {
			m_data->negative_pair = 0;
			m_data->stub_count = m_data->stub_count > 0 ? 1 : -1;
		}
	}

#ifdef _DEBUG
	virtual void draw_node (unsigned level, unsigned index) const {
		char buf [1024];
		
		unsigned i=0;
		for(; i < level; i++) {
			sprintf (buf+i, "\t");
		}
		sprintf (buf+i, "%d: Stub[%d] - (%d, %d)", index, (GCL::StaticNode*)this, m_data->stub_count, m_ind);
		LOG_D ((buf));	
	}

public:	
	//void _dump (FILE* to_dump) const {
	//	fprintf (to_dump, "StaticNodeStub [%d] id:[%d]", this, m_id__);
	//}
#endif

protected:
	virtual void delete_obj () {
		NodeStubPool::instance()->release_obj(dynamic_cast<_StubImpl*>(this));
	}

protected:
	mutable SharedData_box m_data;
	mutable long m_ind;
//#UC END# *450136CE01F4*
}; // class StaticNodeStub

} // namespace GCL

#include "shared/GCL/data/StaticNodeStub.i.h"

#endif //__SHARED_GCL_DATA_STATICNODESTUB_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

