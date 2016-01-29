/**
 * <copyright>
 * </copyright>
 *
 * $Id: ClassImpl.java,v 1.1 2009/02/25 06:20:01 pugin Exp $
 */
package euml.impl;

import euml.Attribute;
import euml.Dependecy;
import euml.EumlPackage;
import euml.Generalization;
import euml.Operation;
import euml.Realization;

import java.util.Collection;

import org.eclipse.emf.common.notify.NotificationChain;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.InternalEObject;

import org.eclipse.emf.ecore.util.EObjectContainmentEList;
import org.eclipse.emf.ecore.util.InternalEList;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Class</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link euml.impl.ClassImpl#getDependencies <em>Dependencies</em>}</li>
 *   <li>{@link euml.impl.ClassImpl#getAttributes <em>Attributes</em>}</li>
 *   <li>{@link euml.impl.ClassImpl#getOperations <em>Operations</em>}</li>
 *   <li>{@link euml.impl.ClassImpl#getRealizations <em>Realizations</em>}</li>
 *   <li>{@link euml.impl.ClassImpl#getGeneralizations <em>Generalizations</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class ClassImpl extends NamedElementImpl implements euml.Class {
	/**
	 * The cached value of the '{@link #getDependencies() <em>Dependencies</em>}' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getDependencies()
	 * @generated
	 * @ordered
	 */
	protected EList<Dependecy> dependencies;

	/**
	 * The cached value of the '{@link #getAttributes() <em>Attributes</em>}' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getAttributes()
	 * @generated
	 * @ordered
	 */
	protected EList<Attribute> attributes;

	/**
	 * The cached value of the '{@link #getOperations() <em>Operations</em>}' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getOperations()
	 * @generated
	 * @ordered
	 */
	protected EList<Operation> operations;

	/**
	 * The cached value of the '{@link #getRealizations() <em>Realizations</em>}' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getRealizations()
	 * @generated
	 * @ordered
	 */
	protected EList<Realization> realizations;

	/**
	 * The cached value of the '{@link #getGeneralizations() <em>Generalizations</em>}' containment reference list.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getGeneralizations()
	 * @generated
	 * @ordered
	 */
	protected EList<Generalization> generalizations;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	protected ClassImpl() {
		super();
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	protected EClass eStaticClass() {
		return EumlPackage.Literals.CLASS;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EList<Dependecy> getDependencies() {
		if (dependencies == null) {
			dependencies = new EObjectContainmentEList<Dependecy>(Dependecy.class, this, EumlPackage.CLASS__DEPENDENCIES);
		}
		return dependencies;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EList<Attribute> getAttributes() {
		if (attributes == null) {
			attributes = new EObjectContainmentEList<Attribute>(Attribute.class, this, EumlPackage.CLASS__ATTRIBUTES);
		}
		return attributes;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EList<Operation> getOperations() {
		if (operations == null) {
			operations = new EObjectContainmentEList<Operation>(Operation.class, this, EumlPackage.CLASS__OPERATIONS);
		}
		return operations;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EList<Realization> getRealizations() {
		if (realizations == null) {
			realizations = new EObjectContainmentEList<Realization>(Realization.class, this, EumlPackage.CLASS__REALIZATIONS);
		}
		return realizations;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EList<Generalization> getGeneralizations() {
		if (generalizations == null) {
			generalizations = new EObjectContainmentEList<Generalization>(Generalization.class, this, EumlPackage.CLASS__GENERALIZATIONS);
		}
		return generalizations;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public NotificationChain eInverseRemove(InternalEObject otherEnd, int featureID, NotificationChain msgs) {
		switch (featureID) {
			case EumlPackage.CLASS__DEPENDENCIES:
				return ((InternalEList<?>)getDependencies()).basicRemove(otherEnd, msgs);
			case EumlPackage.CLASS__ATTRIBUTES:
				return ((InternalEList<?>)getAttributes()).basicRemove(otherEnd, msgs);
			case EumlPackage.CLASS__OPERATIONS:
				return ((InternalEList<?>)getOperations()).basicRemove(otherEnd, msgs);
			case EumlPackage.CLASS__REALIZATIONS:
				return ((InternalEList<?>)getRealizations()).basicRemove(otherEnd, msgs);
			case EumlPackage.CLASS__GENERALIZATIONS:
				return ((InternalEList<?>)getGeneralizations()).basicRemove(otherEnd, msgs);
		}
		return super.eInverseRemove(otherEnd, featureID, msgs);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public Object eGet(int featureID, boolean resolve, boolean coreType) {
		switch (featureID) {
			case EumlPackage.CLASS__DEPENDENCIES:
				return getDependencies();
			case EumlPackage.CLASS__ATTRIBUTES:
				return getAttributes();
			case EumlPackage.CLASS__OPERATIONS:
				return getOperations();
			case EumlPackage.CLASS__REALIZATIONS:
				return getRealizations();
			case EumlPackage.CLASS__GENERALIZATIONS:
				return getGeneralizations();
		}
		return super.eGet(featureID, resolve, coreType);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void eSet(int featureID, Object newValue) {
		switch (featureID) {
			case EumlPackage.CLASS__DEPENDENCIES:
				getDependencies().clear();
				getDependencies().addAll((Collection<? extends Dependecy>)newValue);
				return;
			case EumlPackage.CLASS__ATTRIBUTES:
				getAttributes().clear();
				getAttributes().addAll((Collection<? extends Attribute>)newValue);
				return;
			case EumlPackage.CLASS__OPERATIONS:
				getOperations().clear();
				getOperations().addAll((Collection<? extends Operation>)newValue);
				return;
			case EumlPackage.CLASS__REALIZATIONS:
				getRealizations().clear();
				getRealizations().addAll((Collection<? extends Realization>)newValue);
				return;
			case EumlPackage.CLASS__GENERALIZATIONS:
				getGeneralizations().clear();
				getGeneralizations().addAll((Collection<? extends Generalization>)newValue);
				return;
		}
		super.eSet(featureID, newValue);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eUnset(int featureID) {
		switch (featureID) {
			case EumlPackage.CLASS__DEPENDENCIES:
				getDependencies().clear();
				return;
			case EumlPackage.CLASS__ATTRIBUTES:
				getAttributes().clear();
				return;
			case EumlPackage.CLASS__OPERATIONS:
				getOperations().clear();
				return;
			case EumlPackage.CLASS__REALIZATIONS:
				getRealizations().clear();
				return;
			case EumlPackage.CLASS__GENERALIZATIONS:
				getGeneralizations().clear();
				return;
		}
		super.eUnset(featureID);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public boolean eIsSet(int featureID) {
		switch (featureID) {
			case EumlPackage.CLASS__DEPENDENCIES:
				return dependencies != null && !dependencies.isEmpty();
			case EumlPackage.CLASS__ATTRIBUTES:
				return attributes != null && !attributes.isEmpty();
			case EumlPackage.CLASS__OPERATIONS:
				return operations != null && !operations.isEmpty();
			case EumlPackage.CLASS__REALIZATIONS:
				return realizations != null && !realizations.isEmpty();
			case EumlPackage.CLASS__GENERALIZATIONS:
				return generalizations != null && !generalizations.isEmpty();
		}
		return super.eIsSet(featureID);
	}

} //ClassImpl
